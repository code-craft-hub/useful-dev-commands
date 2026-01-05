```bash
enterprise-backend-clean-architecture/
│
├── .github/
│   ├── workflows/
│   │   ├── ci.yml
│   │   ├── cd.yml
│   │   ├── security-scan.yml
│   │   └── dependency-check.yml
│   └── CODEOWNERS
│
├── docs/
│   ├── architecture/
│   │   ├── adr/                          # Architecture Decision Records
│   │   │   ├── 0001-modular-monolith.md
│   │   │   ├── 0002-clean-architecture.md
│   │   │   └── 0003-authentication-strategy.md
│   │   ├── diagrams/
│   │   │   ├── c4-context.puml
│   │   │   ├── c4-container.puml
│   │   │   └── sequence-diagrams.puml
│   │   └── system-design.md
│   ├── api/
│   │   ├── openapi.yaml
│   │   └── postman-collection.json
│   └── development/
│       ├── setup.md
│       ├── coding-standards.md
│       └── security-guidelines.md
│
├── src/
│   │
│   ├── modules/                          # BOUNDED CONTEXTS
│   │   │
│   │   ├── auth/                         # Authentication Module
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   ├── session.entity.ts
│   │   │   │   │   ├── refresh-token.entity.ts
│   │   │   │   │   └── oauth-connection.entity.ts
│   │   │   │   ├── value-objects/
│   │   │   │   │   ├── email.vo.ts
│   │   │   │   │   ├── password.vo.ts
│   │   │   │   │   ├── token.vo.ts
│   │   │   │   │   └── oauth-provider.vo.ts
│   │   │   │   ├── repositories/
│   │   │   │   │   ├── session.repository.interface.ts
│   │   │   │   │   ├── refresh-token.repository.interface.ts
│   │   │   │   │   └── oauth-connection.repository.interface.ts
│   │   │   │   ├── services/
│   │   │   │   │   ├── password-hasher.service.interface.ts
│   │   │   │   │   ├── token-generator.service.interface.ts
│   │   │   │   │   └── authentication.domain-service.ts
│   │   │   │   ├── events/
│   │   │   │   │   ├── user-registered.event.ts
│   │   │   │   │   ├── user-logged-in.event.ts
│   │   │   │   │   ├── password-changed.event.ts
│   │   │   │   │   └── oauth-connected.event.ts
│   │   │   │   ├── errors/
│   │   │   │   │   ├── invalid-credentials.error.ts
│   │   │   │   │   ├── token-expired.error.ts
│   │   │   │   │   └── oauth-error.ts
│   │   │   │   └── index.ts
│   │   │   │
│   │   │   ├── application/
│   │   │   │   ├── use-cases/
│   │   │   │   │   ├── register-user/
│   │   │   │   │   │   ├── register-user.use-case.ts
│   │   │   │   │   │   ├── register-user.dto.ts
│   │   │   │   │   │   └── register-user.validator.ts
│   │   │   │   │   ├── login-user/
│   │   │   │   │   │   ├── login-user.use-case.ts
│   │   │   │   │   │   ├── login-user.dto.ts
│   │   │   │   │   │   └── login-user.validator.ts
│   │   │   │   │   ├── refresh-token/
│   │   │   │   │   │   ├── refresh-token.use-case.ts
│   │   │   │   │   │   └── refresh-token.dto.ts
│   │   │   │   │   ├── logout-user/
│   │   │   │   │   │   └── logout-user.use-case.ts
│   │   │   │   │   ├── google-oauth-login/
│   │   │   │   │   │   ├── google-oauth-login.use-case.ts
│   │   │   │   │   │   └── google-oauth-login.dto.ts
│   │   │   │   │   ├── connect-google-oauth/
│   │   │   │   │   │   └── connect-google-oauth.use-case.ts
│   │   │   │   │   ├── disconnect-google-oauth/
│   │   │   │   │   │   └── disconnect-google-oauth.use-case.ts
│   │   │   │   │   ├── change-password/
│   │   │   │   │   │   ├── change-password.use-case.ts
│   │   │   │   │   │   └── change-password.dto.ts
│   │   │   │   │   ├── forgot-password/
│   │   │   │   │   │   ├── forgot-password.use-case.ts
│   │   │   │   │   │   └── forgot-password.dto.ts
│   │   │   │   │   ├── reset-password/
│   │   │   │   │   │   ├── reset-password.use-case.ts
│   │   │   │   │   │   └── reset-password.dto.ts
│   │   │   │   │   ├── verify-email/
│   │   │   │   │   │   └── verify-email.use-case.ts
│   │   │   │   │   └── resend-verification/
│   │   │   │   │       └── resend-verification.use-case.ts
│   │   │   │   ├── event-handlers/
│   │   │   │   │   ├── user-registered.handler.ts
│   │   │   │   │   ├── user-logged-in.handler.ts
│   │   │   │   │   └── password-changed.handler.ts
│   │   │   │   ├── mappers/
│   │   │   │   │   ├── session.mapper.ts
│   │   │   │   │   └── oauth-connection.mapper.ts
│   │   │   │   └── index.ts
│   │   │   │
│   │   │   ├── infrastructure/
│   │   │   │   ├── persistence/
│   │   │   │   │   ├── drizzle/
│   │   │   │   │   │   ├── schemas/
│   │   │   │   │   │   │   ├── sessions.schema.ts
│   │   │   │   │   │   │   ├── refresh-tokens.schema.ts
│   │   │   │   │   │   │   └── oauth-connections.schema.ts
│   │   │   │   │   │   ├── repositories/
│   │   │   │   │   │   │   ├── session.repository.ts
│   │   │   │   │   │   │   ├── refresh-token.repository.ts
│   │   │   │   │   │   │   └── oauth-connection.repository.ts
│   │   │   │   │   │   └── migrations/
│   │   │   │   │   │       └── 0001_create_auth_tables.sql
│   │   │   │   │   └── cache/
│   │   │   │   │       └── session-cache.repository.ts
│   │   │   │   ├── security/
│   │   │   │   │   ├── bcrypt-hasher.service.ts
│   │   │   │   │   ├── jwt-token.service.ts
│   │   │   │   │   └── crypto-token.service.ts
│   │   │   │   ├── oauth/
│   │   │   │   │   ├── google-oauth.service.ts
│   │   │   │   │   └── oauth-provider.factory.ts
│   │   │   │   └── email/
│   │   │   │       ├── email.service.ts
│   │   │   │       └── templates/
│   │   │   │           ├── welcome.template.ts
│   │   │   │           ├── verify-email.template.ts
│   │   │   │           └── reset-password.template.ts
│   │   │   │
│   │   │   ├── presentation/
│   │   │   │   ├── http/
│   │   │   │   │   ├── controllers/
│   │   │   │   │   │   ├── auth.controller.ts
│   │   │   │   │   │   └── oauth.controller.ts
│   │   │   │   │   ├── middlewares/
│   │   │   │   │   │   ├── authenticate.middleware.ts
│   │   │   │   │   │   ├── rate-limit.middleware.ts
│   │   │   │   │   │   └── csrf-protection.middleware.ts
│   │   │   │   │   ├── validators/
│   │   │   │   │   │   ├── registration.validator.ts
│   │   │   │   │   │   ├── login.validator.ts
│   │   │   │   │   │   └── password.validator.ts
│   │   │   │   │   ├── serializers/
│   │   │   │   │   │   ├── auth-response.serializer.ts
│   │   │   │   │   │   └── session.serializer.ts
│   │   │   │   │   └── routes/
│   │   │   │   │       ├── auth.routes.ts
│   │   │   │   │       └── oauth.routes.ts
│   │   │   │   └── index.ts
│   │   │   │
│   │   │   ├── tests/
│   │   │   │   ├── unit/
│   │   │   │   │   ├── domain/
│   │   │   │   │   ├── application/
│   │   │   │   │   └── infrastructure/
│   │   │   │   ├── integration/
│   │   │   │   │   └── api/
│   │   │   │   └── fixtures/
│   │   │   │
│   │   │   └── module.config.ts
│   │   │
│   │   └── user/                         # User Management Module
│   │       ├── domain/
│   │       │   ├── entities/
│   │       │   │   ├── user.entity.ts
│   │       │   │   ├── user-profile.entity.ts
│   │       │   │   └── user-preferences.entity.ts
│   │       │   ├── value-objects/
│   │       │   │   ├── user-id.vo.ts
│   │       │   │   ├── username.vo.ts
│   │       │   │   ├── full-name.vo.ts
│   │       │   │   └── avatar-url.vo.ts
│   │       │   ├── repositories/
│   │       │   │   ├── user.repository.interface.ts
│   │       │   │   └── user-profile.repository.interface.ts
│   │       │   ├── services/
│   │       │   │   └── user.domain-service.ts
│   │       │   ├── events/
│   │       │   │   ├── user-created.event.ts
│   │       │   │   ├── user-updated.event.ts
│   │       │   │   ├── user-deleted.event.ts
│   │       │   │   └── profile-completed.event.ts
│   │       │   ├── errors/
│   │       │   │   ├── user-not-found.error.ts
│   │       │   │   └── duplicate-username.error.ts
│   │       │   └── index.ts
│   │       │
│   │       ├── application/
│   │       │   ├── use-cases/
│   │       │   │   ├── create-user/
│   │       │   │   │   ├── create-user.use-case.ts
│   │       │   │   │   └── create-user.dto.ts
│   │       │   │   ├── get-user/
│   │       │   │   │   └── get-user.use-case.ts
│   │       │   │   ├── update-user/
│   │       │   │   │   ├── update-user.use-case.ts
│   │       │   │   │   └── update-user.dto.ts
│   │       │   │   ├── delete-user/
│   │       │   │   │   └── delete-user.use-case.ts
│   │       │   │   ├── update-profile/
│   │       │   │   │   ├── update-profile.use-case.ts
│   │       │   │   │   └── update-profile.dto.ts
│   │       │   │   ├── update-preferences/
│   │       │   │   │   └── update-preferences.use-case.ts
│   │       │   │   └── list-users/
│   │       │   │       ├── list-users.use-case.ts
│   │       │   │       └── list-users.query.ts
│   │       │   ├── event-handlers/
│   │       │   │   ├── user-created.handler.ts
│   │       │   │   └── user-deleted.handler.ts
│   │       │   ├── mappers/
│   │       │   │   ├── user.mapper.ts
│   │       │   │   └── user-profile.mapper.ts
│   │       │   └── index.ts
│   │       │
│   │       ├── infrastructure/
│   │       │   ├── persistence/
│   │       │   │   ├── drizzle/
│   │       │   │   │   ├── schemas/
│   │       │   │   │   │   ├── users.schema.ts
│   │       │   │   │   │   ├── user-profiles.schema.ts
│   │       │   │   │   │   └── user-preferences.schema.ts
│   │       │   │   │   ├── repositories/
│   │       │   │   │   │   ├── user.repository.ts
│   │       │   │   │   │   └── user-profile.repository.ts
│   │       │   │   │   └── migrations/
│   │       │   │   │       └── 0001_create_user_tables.sql
│   │       │   │   └── cache/
│   │       │   │       └── user-cache.repository.ts
│   │       │   └── services/
│   │       │       └── avatar-upload.service.ts
│   │       │
│   │       ├── presentation/
│   │       │   ├── http/
│   │       │   │   ├── controllers/
│   │       │   │   │   ├── user.controller.ts
│   │       │   │   │   └── profile.controller.ts
│   │       │   │   ├── middlewares/
│   │       │   │   │   └── authorize-user.middleware.ts
│   │       │   │   ├── validators/
│   │       │   │   │   ├── user-update.validator.ts
│   │       │   │   │   └── profile.validator.ts
│   │       │   │   ├── serializers/
│   │       │   │   │   ├── user.serializer.ts
│   │       │   │   │   └── user-list.serializer.ts
│   │       │   │   └── routes/
│   │       │   │       ├── user.routes.ts
│   │       │   │       └── profile.routes.ts
│   │       │   └── index.ts
│   │       │
│   │       ├── tests/
│   │       │   ├── unit/
│   │       │   ├── integration/
│   │       │   └── fixtures/
│   │       │
│   │       └── module.config.ts
│   │
│   ├── shared/                           # SHARED KERNEL
│   │   ├── domain/
│   │   │   ├── base-entity.ts
│   │   │   ├── base-value-object.ts
│   │   │   ├── domain-event.interface.ts
│   │   │   ├── aggregate-root.ts
│   │   │   └── unique-id.vo.ts
│   │   ├── application/
│   │   │   ├── result.ts
│   │   │   ├── either.ts
│   │   │   ├── use-case.interface.ts
│   │   │   ├── query.interface.ts
│   │   │   └── event-bus.interface.ts
│   │   ├── infrastructure/
│   │   │   ├── event-bus/
│   │   │   │   └── in-memory-event-bus.ts
│   │   │   ├── logger/
│   │   │   │   ├── logger.interface.ts
│   │   │   │   ├── winston-logger.service.ts
│   │   │   │   └── morgan-http-logger.ts
│   │   │   ├── cache/
│   │   │   │   ├── cache.interface.ts
│   │   │   │   └── redis-cache.service.ts
│   │   │   ├── database/
│   │   │   │   ├── drizzle-connection.ts
│   │   │   │   └── transaction-manager.ts
│   │   │   └── monitoring/
│   │   │       ├── metrics.service.ts
│   │   │       └── health-check.service.ts
│   │   ├── presentation/
│   │   │   ├── http/
│   │   │   │   ├── base-controller.ts
│   │   │   │   ├── http-response.builder.ts
│   │   │   │   └── error-handler.middleware.ts
│   │   │   └── validators/
│   │   │       └── base-validator.ts
│   │   ├── types/
│   │   │   ├── pagination.types.ts
│   │   │   ├── sorting.types.ts
│   │   │   └── filtering.types.ts
│   │   ├── utils/
│   │   │   ├── date.utils.ts
│   │   │   ├── string.utils.ts
│   │   │   ├── crypto.utils.ts
│   │   │   └── validation.utils.ts
│   │   ├── errors/
│   │   │   ├── base.error.ts
│   │   │   ├── domain.error.ts
│   │   │   ├── application.error.ts
│   │   │   ├── infrastructure.error.ts
│   │   │   └── http-errors/
│   │   │       ├── bad-request.error.ts
│   │   │       ├── unauthorized.error.ts
│   │   │       ├── forbidden.error.ts
│   │   │       ├── not-found.error.ts
│   │   │       ├── conflict.error.ts
│   │   │       ├── unprocessable-entity.error.ts
│   │   │       └── internal-server.error.ts
│   │   └── constants/
│   │       ├── http-status.constants.ts
│   │       ├── error-codes.constants.ts
│   │       └── app.constants.ts
│   │
│   ├── config/                           # CONFIGURATION
│   │   ├── app.config.ts
│   │   ├── database.config.ts
│   │   ├── redis.config.ts
│   │   ├── jwt.config.ts
│   │   ├── oauth.config.ts
│   │   ├── email.config.ts
│   │   ├── security.config.ts
│   │   ├── rate-limit.config.ts
│   │   ├── cors.config.ts
│   │   ├── logger.config.ts
│   │   └── index.ts
│   │
│   ├── api/                              # API COMPOSITION LAYER
│   │   ├── app.ts
│   │   ├── server.ts
│   │   ├── routes.ts
│   │   ├── middlewares/
│   │   │   ├── helmet-security.middleware.ts
│   │   │   ├── cors.middleware.ts
│   │   │   ├── compression.middleware.ts
│   │   │   ├── request-id.middleware.ts
│   │   │   ├── timeout.middleware.ts
│   │   │   └── index.ts
│   │   └── swagger/
│   │       ├── swagger.config.ts
│   │       └── swagger-schemas.ts
│   │
│   └── index.ts
│
├── scripts/
│   ├── db/
│   │   ├── migrate.ts
│   │   ├── seed.ts
│   │   ├── reset.ts
│   │   └── backup.ts
│   ├── dev/
│   │   ├── generate-keys.ts
│   │   └── create-admin.ts
│   └── deployment/
│       ├── health-check.ts
│       └── pre-deploy.ts
│
├── tests/
│   ├── e2e/
│   │   ├── auth/
│   │   │   ├── registration.e2e.spec.ts
│   │   │   ├── login.e2e.spec.ts
│   │   │   └── oauth.e2e.spec.ts
│   │   └── user/
│   │       └── user-management.e2e.spec.ts
│   ├── performance/
│   │   └── load-tests/
│   ├── security/
│   │   ├── sql-injection.spec.ts
│   │   ├── xss.spec.ts
│   │   └── csrf.spec.ts
│   ├── helpers/
│   │   ├── test-database.helper.ts
│   │   ├── test-server.helper.ts
│   │   └── factories/
│   │       ├── user.factory.ts
│   │       └── session.factory.ts
│   └── setup.ts
│
├── .vscode/
│   ├── settings.json
│   ├── extensions.json
│   └── launch.json
│
├── .husky/
│   ├── pre-commit
│   ├── pre-push
│   └── commit-msg
│
├── migrations/                           # Global migrations directory
│   └── meta/
│
├── logs/                                 # Application logs
│   ├── app/
│   ├── error/
│   ├── access/
│   └── security/
│
├── .env.example
├── .env.development
├── .env.test
├── .env.production
├── .gitignore
├── .prettierrc
├── .eslintrc.json
├── .commitlintrc.json
├── tsconfig.json
├── tsconfig.build.json
├── jest.config.ts
├── vitest.config.ts
├── drizzle.config.ts
├── package.json
├── pnpm-workspace.yaml
├── pnpm-lock.yaml
├── README.md
├── CHANGELOG.md
├── CONTRIBUTING.md
├── LICENSE
└── SECURITY.md