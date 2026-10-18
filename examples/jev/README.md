# Jev support-ticket routing example

Learn the difference between a model assessment and a deterministic decision:

1. Send a customer ticket and three allowed departments to Jev.
2. Receive a probability distribution.
3. Route automatically only when the winning department has probability **at least 0.90**.
4. Otherwise return `human_review`. Invalid answers and refusals also require review.

This CLI only displays a decision. It does not contact a support team or change any tickets.

## Requirements

- Node.js **22 or later** (`node --version`).
- No npm packages or installation step.
- For live requests: a **Vercel AI Gateway API key**, model access, available credits,
  and HTTPS access to `ai-gateway.vercel.sh`. A direct TypeSafe or OpenAI key is not interchangeable.

## Get the code

After this branch is pushed:

```bash
git clone --branch codex/jev-routing-example https://github.com/majidraza1228/agentic-dev-template.git
cd agentic-dev-template/examples/jev
```

If you already have the repository, switch to `codex/jev-routing-example` and run
`cd examples/jev` from its root. All commands below assume this directory.

## 1. Try the offline demo first

```bash
node router.mjs --demo
```

No key or network is used. These are **synthetic, fixed probability fixtures**, not
recorded Jev results and not a replacement classifier. Expected routes, in order:

| Example | Route |
| --- | --- |
| Duplicate charge / refund | `billing` |
| API HTTP 500 error | `technical` |
| Forgotten password | `account` |
| Ambiguous export / credits problem | `human_review` |

The output explicitly identifies its source as `synthetic_fixtures_not_live_jev`.
Running without arguments also runs this demo.

## 2. Inspect the request without calling Jev

```bash
node router.mjs --show-request
node router.mjs --show-request --ticket "My password reset email never arrived."
```

This prints the JSON request: `state` contains your ticket; `questions.department`
defines the `choice` question and the three permitted labels.

## 3. Set your key later

Create a key in [Vercel AI Gateway](https://vercel.com/ai-gateway).
The environment variable name used by this example is **JEV_API_KEY**.
No key is included in this repository. The program does not load `.env` files.

Bash (Linux/macOS): enter the key at a hidden prompt, rather than saving it in history:

```bash
read -r -s -p 'Vercel AI Gateway key: ' JEV_API_KEY
export JEV_API_KEY
printf '\n'
```

PowerShell 7:

```powershell
$env:JEV_API_KEY = Read-Host 'Vercel AI Gateway key' -MaskInput
```

The value stays in your current shell session and its child processes.

## 4. Make one live request

```bash
node router.mjs --live
```

Or supply your own ticket:

```bash
node router.mjs --live --ticket "Every request to your API returns HTTP 500."
node router.mjs --live --ticket "Please refund my duplicate subscription charge."
node router.mjs --live --ticket "I cannot sign in after changing my password."
```

Each command makes **one potentially billable API request**, with a 30-second timeout
and no automatic retries. The ticket is sent to the gateway/model provider.
Output includes `source: live_jev`, the answer, policy version, and local routing decision.
Actual live probabilities and routes can differ from the demo.

The documented gateway response is an envelope containing `answers.department`.
The example requires a valid probability for every department, values in [0, 1],
a total within 0.000001 of 1, and a choice matching the largest probability.
An absent distribution, refusal, or unexpected answer shape returns `human_review`.
Transport, HTTP, and JSON decoding failures exit with status 1; they never silently
switch to synthetic results. Error response bodies and credentials are not printed.

## 5. Run tests

```bash
node --test tests/router.test.mjs
node --check router.mjs
node --check tests/router.test.mjs
```

Tests use mocked HTTP responses, never your key or paid API calls. They cover all
four demo routes, the exact 0.90 boundary, invalid answers, request headers,
missing credentials, and HTTP/network/JSON errors. No separate linter or type checker
is configured for this dependency-free JavaScript example.

## Understand the deterministic rule

For example, `{billing: 0.97, technical: 0.02, account: 0.01}` routes to `billing`.
`{billing: 0.55, technical: 0.40, account: 0.05}` requires `human_review`.

**Identical answers produce identical routing decisions.** This does not guarantee
that fresh Jev calls return identical probabilities. This example has no cache.
To replay an identical decision later, persist the original validated answer and
policy version. Do not confuse replay with a new model assessment.

## Customize it

- Edit `buildRequest()` in `router.mjs` to change question wording and criteria.
- Keep `LABELS` and question criteria aligned when changing departments.
- Edit `POLICY.threshold` to change the routing boundary, and increment `POLICY.version`.
- Start with labeled real examples to choose a threshold; 0.90 is an illustrative default,
  not a measured accuracy guarantee.
- Edit `fixtures.json` to demonstrate additional probability distributions; the demo
  never infers probabilities from ticket text.

## Troubleshooting

| Symptom | Next step |
| --- | --- |
| Missing `JEV_API_KEY` | Export it in the same terminal where you run Node. |
| HTTP 401 / 403 | Verify a Vercel gateway key and access to the model. |
| HTTP 429 | Check gateway credits, quota, and rate limits; retry manually later. |
| Network failure / timeout | Check HTTPS access to `ai-gateway.vercel.sh`. |
| HTTP 400 / 404 or persistent unexpected shape | Check current provider API documentation; this example uses the evaluation endpoint described by Treg. |
| `human_review` | Inspect the answer: it may be uncertain, refused, missing probabilities, or malformed. |

## Files and API references

- `router.mjs`: request, live HTTP adapter, deterministic policy, CLI.
- `fixtures.json`: four clearly labeled synthetic examples.
- `tests/router.test.mjs`: offline tests.

Integration reference: [Treg's Jev guide](https://treg.to/jev).
It documents `POST https://ai-gateway.vercel.sh/v4/ai/evaluation-model`, model
`typesafe-ai/jev`, and the evaluation/protocol headers used here. The gateway's
current SDK also uses newer decision terminology; check provider documentation
before adapting to a different endpoint.

## Validation status

Offline tests and CLI checks can be run without credentials. Live paid execution
has not been verified in this workspace because no gateway key was supplied.
