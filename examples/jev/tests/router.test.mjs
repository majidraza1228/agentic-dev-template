import test from 'node:test';
import assert from 'node:assert/strict';
import { readFile } from 'node:fs/promises';
import { buildRequest, callJev, ENDPOINT, MODEL, route } from '../router.mjs';

const fixtures = JSON.parse(await readFile(new URL('../fixtures.json', import.meta.url), 'utf8'));
for (const fixture of fixtures) {
  test(`routes fixture to ${fixture.expected}`, () => {
    assert.equal(route(fixture.answer).route, fixture.expected);
    assert.deepEqual(route(fixture.answer), route(fixture.answer));
  });
}

test('threshold is inclusive', () => {
  assert.equal(route({ type: 'choice', choice: 'billing', probabilities: {
    billing: 0.90, technical: 0.06, account: 0.04
  } }).route, 'billing');
});

test('invalid distributions, refusal, and inconsistent answers require review', () => {
  for (const answer of [null, {}, { type: 'refusal' },
    { ...fixtures[0].answer, choice: 'technical' },
    ...[{}, { billing: 1 }, { billing: 1, technical: 0, account: 0, other: 0 },
      { billing: NaN, technical: 0, account: 0 },
      { billing: '0.97', technical: 0.02, account: 0.01 },
      { billing: 1.1, technical: -0.1, account: 0 },
      { billing: 0.5, technical: 0.1, account: 0.1 }]
      .map(probabilities => ({ type: 'choice', choice: 'billing', probabilities }))
  ]) assert.equal(route(answer).route, 'human_review');
});

test('builds typed questions and rejects empty tickets', () => {
  assert.equal(buildRequest('hello').state.ticket, 'hello');
  assert.equal(buildRequest('hello').questions.department.type, 'choice');
  assert.throws(() => buildRequest(' '), /nonempty/);
});

test('missing key fails before any network call', async () => {
  await assert.rejects(callJev({}, '', () => assert.fail('must not fetch')), /JEV_API_KEY/);
});

test('live adapter sends documented headers and extracts JSON envelope', async () => {
  const envelope = { answers: { department: fixtures[0].answer } };
  const result = await callJev(buildRequest('refund'), 'test-placeholder', async (url, init) => {
    assert.equal(url, ENDPOINT);
    assert.equal(init.method, 'POST');
    assert.equal(init.headers.Authorization, 'Bearer test-placeholder');
    assert.equal(init.headers['ai-model-id'], MODEL);
    assert.equal(init.headers['ai-evaluation-model-specification-version'], '4');
    assert.equal(JSON.parse(init.body).state.ticket, 'refund');
    return new Response(JSON.stringify(envelope));
  });
  assert.equal(route(result.answers.department).route, 'billing');
});

test('HTTP and transport errors stay explicit and do not expose bodies or keys', async () => {
  for (const status of [401, 403, 429, 500]) {
    await assert.rejects(callJev({}, 'test-placeholder', async () =>
      new Response('private-error-body', { status })), new RegExp(`HTTP ${status}`));
  }
  await assert.rejects(callJev({}, 'test-placeholder', async () => {
    throw new Error('private-error-body');
  }), /failed or timed out/);
  await assert.rejects(callJev({}, 'test-placeholder', async () =>
    new Response('not json')), /non-JSON/);
});
