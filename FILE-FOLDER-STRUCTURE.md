src/
├── modules/
│   ├── users/
│   │   ├── users.controller.ts
│   │   ├── users.service.ts
│   │   ├── users.repository.ts
│   │   ├── user.entity.ts
│   │   ├── dtos/
│   │   │   ├── create-user.dto.ts
│   │   │   └── user-response.dto.ts
│   │   ├── users.routes.ts
│   │   ├── users.validator.ts
│   │   ├── users.module.ts          # Module registration
│   │   └── __tests__/
│   │       ├── users.service.spec.ts
│   │       └── users.controller.spec.ts
│   │
│   ├── auth/
│   │   ├── auth.controller.ts
│   │   ├── auth.service.ts
│   │   ├── auth.repository.ts
│   │   ├── strategies/
│   │   │   ├── jwt.strategy.ts
│   │   │   └── google.strategy.ts
│   │   ├── guards/
│   │   │   ├── auth.guard.ts
│   │   │   └── roles.guard.ts
│   │   ├── decorators/
│   │   │   └── current-user.decorator.ts
│   │   ├── dtos/
│   │   ├── auth.routes.ts
│   │   ├── auth.module.ts
│   │   └── __tests__/
│   │
│   ├── resumes/
│   │   ├── resumes.controller.ts
│   │   ├── resumes.service.ts
│   │   ├── resumes.repository.ts
│   │   ├── resume.entity.ts
│   │   ├── services/
│   │   │   ├── pdf-generator.service.ts
│   │   │   └── template-parser.service.ts
│   │   ├── dtos/
│   │   ├── resumes.routes.ts
│   │   ├── resumes.module.ts
│   │   └── __tests__/
│   │
│   ├── cover-letters/
│   │   ├── cover-letters.controller.ts
│   │   ├── cover-letters.service.ts
│   │   ├── cover-letters.repository.ts
│   │   ├── cover-letter.entity.ts
│   │   ├── services/
│   │   │   └── ai-content-generator.service.ts
│   │   ├── dtos/
│   │   ├── cover-letters.routes.ts
│   │   ├── cover-letters.module.ts
│   │   └── __tests__/
│   │
│   ├── interview-questions/
│   │   ├── interview-questions.controller.ts
│   │   ├── interview-questions.service.ts
│   │   ├── interview-questions.repository.ts
│   │   ├── question.entity.ts
│   │   ├── category.entity.ts
│   │   ├── services/
│   │   │   └── question-generator.service.ts
│   │   ├── dtos/
│   │   ├── interview-questions.routes.ts
│   │   ├── interview-questions.module.ts
│   │   └── __tests__/
│   │
│   ├── job-applications/
│   │   ├── job-applications.controller.ts
│   │   ├── job-applications.service.ts
│   │   ├── job-applications.repository.ts
│   │   ├── application.entity.ts
│   │   ├── job-posting.entity.ts
│   │   ├── services/
│   │   │   ├── auto-apply.service.ts
│   │   │   ├── job-matcher.service.ts
│   │   │   └── scraper.service.ts
│   │   ├── scrapers/
│   │   │   ├── linkedin.scraper.ts
│   │   │   └── indeed.scraper.ts
│   │   ├── dtos/
│   │   ├── job-applications.routes.ts
│   │   ├── job-applications.module.ts
│   │   └── __tests__/
│   │
│   ├── blog/
│   │   ├── blog.controller.ts
│   │   ├── blog.service.ts
│   │   ├── blog.repository.ts
│   │   ├── post.entity.ts
│   │   ├── category.entity.ts
│   │   ├── comment.entity.ts
│   │   ├── dtos/
│   │   ├── blog.routes.ts
│   │   ├── blog.module.ts
│   │   └── __tests__/
│   │
│   ├── notifications/
│   │   ├── notifications.controller.ts
│   │   ├── notifications.service.ts
│   │   ├── notifications.repository.ts
│   │   ├── notification.entity.ts
│   │   ├── services/
│   │   │   ├── email.service.ts
│   │   │   ├── sms.service.ts
│   │   │   └── push.service.ts
│   │   ├── templates/
│   │   │   ├── email/
│   │   │   └── sms/
│   │   ├── dtos/
│   │   ├── notifications.routes.ts
│   │   ├── notifications.module.ts
│   │   └── __tests__/
│   │
│   └── ai/
│       ├── ai.controller.ts
│       ├── ai.service.ts
│       ├── ai.repository.ts
│       ├── ai-request.entity.ts
│       ├── providers/
│       │   ├── openai.provider.ts
│       │   ├── anthropic.provider.ts
│       │   └── ai-provider.interface.ts
│       ├── services/
│       │   ├── prompt-builder.service.ts
│       │   └── response-cache.service.ts
│       ├── dtos/
│       ├── ai.routes.ts
│       ├── ai.module.ts
│       └── __tests__/
│
├── shared/                              # Shared utilities (keep minimal)
│   ├── database/
│   │   ├── base.repository.ts
│   │   └── database.service.ts
│   ├── middleware/
│   │   ├── error-handler.middleware.ts
│   │   ├── logger.middleware.ts
│   │   ├── rate-limiter.middleware.ts
│   │   └── validation.middleware.ts
│   ├── utils/
│   │   ├── logger.ts
│   │   ├── crypto.utils.ts
│   │   ├── date.utils.ts
│   │   └── validation.utils.ts
│   ├── exceptions/
│   │   ├── base.exception.ts
│   │   ├── not-found.exception.ts
│   │   ├── validation.exception.ts
│   │   └── unauthorized.exception.ts
│   ├── decorators/
│   │   └── api-response.decorator.ts
│   └── types/
│       ├── pagination.types.ts
│       └── response.types.ts
│
├── config/
│   ├── database.config.ts
│   ├── redis.config.ts
│   ├── aws.config.ts
│   ├── email.config.ts
│   ├── ai.config.ts
│   ├── env.config.ts
│   └── index.ts
│
├── infrastructure/
│   ├── database/
│   │   ├── prisma/
│   │   │   ├── schema.prisma
│   │   │   └── migrations/
│   │   └── mongodb/
│   │       └── connection.ts
│   ├── cache/
│   │   └── redis.service.ts
│   ├── storage/
│   │   ├── s3.service.ts
│   │   └── local-storage.service.ts
│   ├── queue/
│   │   └── bull.service.ts
│   └── monitoring/
│       ├── logger.service.ts
│       └── metrics.service.ts
│
├── app.ts                               # Express app setup
├── server.ts                            # Server initialization
└── main.ts                              # Entry point

tests/
├── integration/
│   ├── users/
│   ├── auth/
│   └── setup.ts
├── e2e/
│   └── scenarios/
└── helpers/

scripts/
├── migrate.ts
├── seed.ts
└── build.ts

.env.example
.env.development
.env.test
.env.production
.gitignore
.eslintrc.js
.prettierrc
tsconfig.json
jest.config.js
docker-compose.yml
Dockerfile
package.json
README.md