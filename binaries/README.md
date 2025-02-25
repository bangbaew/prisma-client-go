# Prisma binaries

There are two types of binaries needed by the Go client, one being the Prisma Engine binaries and the other being the Prisma CLI binaries.

Prisma Engine binaries are fully managed, maintained and automatically updated by the Prisma team, as they are also needed for our NodeJS client.

Prisma CLI binaries are not officially managed and were just by the maintainers of the Go client. This is why there is a some documentation here and a script on how to build, upload and bump the Prisma CLI binaries.

## How to build Prisma CLI binaries

### Prerequisites

Install [zeit/pkg](https://github.com/zeit/pkg):

```shell script
npm i -g pkg
```

Install the [AWS CLI](https://aws.amazon.com/cli/) and authenticate.

### Build the binary and upload to S3

```shell script
sh publish.sh <version>
# e.g.
sh publish.sh 3.0.0
```

You can check the available versions on the [Prisma releases page](https://github.com/prisma/prisma/releases).

**NOTE**:

#### Prisma employees

Any Prisma employee can authenticate with the Prisma Go client account. If you are a community member and would like to
bump the binaries, please ask us to do so in the #prisma-client-go channel in our public Slack.

#### Community members

If you want to set up Prisma CLI binaries yourself, authenticate with your own AWS account and adapt the bucket name in `publish.sh`.
When using the client, you will need to override the URL with env vars whenever you run the Go client, specifically
`PRISMA_CLI_URL` and `PRISMA_ENGINE_URL`. You can see the shape of these values in [binaries/binaries.go#L24-L28](https://github.com/bangbaew/prisma-client-go/blob/50db21001ea041a08d1893e67df8e338a4d8a9a1/binaries/binaries.go#L24-L28).

This will also print the query engine version which you will need in the next step.

### Bump the binaries in the Go client

Go to `binaries/binaries.go` and adapt the [`PrismaVersion`](https://github.com/bangbaew/prisma-client-go/blob/50db21001ea041a08d1893e67df8e338a4d8a9a1/binaries/binaries.go#L18) and [`EngineVersion`](https://github.com/bangbaew/prisma-client-go/blob/50db21001ea041a08d1893e67df8e338a4d8a9a1/binaries/binaries.go#L22) to the new version values.
Push to a new branch, create a PR, and merge if tests are green (e.g. [#709](https://github.com/bangbaew/prisma-client-go/pull/709)).

When internal breaking changes happen, adaptions may be needed.
