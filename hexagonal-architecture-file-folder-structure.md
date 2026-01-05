```bash
enterprise-backend-hexagonal/
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
│   │   │   ├── 0001-hexagonal-architecture.md
│   │   │   ├── 0002-cqrs-pattern.md
│   │   │   ├── 0003-port-adapter-strategy.md
│   │   │   └── 0004-authentication-flow.md
│   │   ├── diagrams/
│   │   │   ├── hexagon-architecture.puml
│   │   │   ├── port-adapter-diagram.puml
│   │   │   └── context-map.puml
│   │   └── ports-and-adapters.md
│   ├── api/
│   │   ├── openapi.yaml
│   │   └── postman-collection.json
│   └── development/
│       ├── hexagon-guide.md
│       ├── port-creation-guide.md
│       └── adapter-implementation-guide.md
│
├── src/
│   │
│   ├── core/                             # APPLICATION CORE (THE HEXAGON)
│   │   │
│   │   ├── domain/                       # DOMAIN LAYER - Business Logic
│   │   │   │
│   │   │   ├── auth/                     # Auth Bounded Context
│   │   │   │   ├── aggregates/
│   │   │   │   │   ├── user-authentication.aggregate.ts
│   │   │   │   │   └── oauth-connection.aggregate.ts
│   │   │   │   ├── entities/
│   │   │   │   │   ├── session.entity.ts
│   │   │   │   │   ├── refresh-token.entity.ts
│   │   │   │   │   └── password-reset-token.entity.ts
│   │   │   │   ├── value-objects/
│   │   │   │   │   ├── email.vo.ts
│   │   │   │   │   ├── password.vo.ts
│   │   │   │   │   ├── hashed-password.vo.ts
│   │   │   │   │   ├── access-token.vo.ts
│   │   │   │   │   ├── oauth-provider.vo.ts
│   │   │   │   │   └── verification-token.vo.ts
│   │   │   │   ├── events/
│   │   │   │   │   ├── user-registered.event.ts
│   │   │   │   │   ├── user-logged-in.event.ts
│   │   │   │   │   ├── user-logged-out.event.ts
│   │   │   │   │   ├── password-changed.event.ts
│   │   │   │   │   ├── password-reset-requested.event.ts
│   │   │   │   │   ├── email-verified.event.ts
│   │   │   │   │   └── oauth-connected.event.ts
│   │   │   │   ├── specifications/
│   │   │   │   │   ├── password-strength.spec.ts
│   │   │   │   │   ├── email-format.spec.ts
│   │   │   │   │   └── session-validity.spec.ts
│   │   │   │   ├── policies/
│   │   │   │   │   ├── password-policy.ts
│   │   │   │   │   ├── session-policy.ts
│   │   │   │   │   └── rate-limit-policy.ts
│   │   │   │   └── exceptions/
│   │   │   │       ├── invalid-credentials.exception.ts
│   │   │   │       ├── email-already-exists.exception.ts
│   │   │   │       ├── token-expired.exception.ts
│   │   │   │       └── account-locked.exception.ts
│   │   │   │
│   │   │   ├── user/                     # User Bounded Context
│   │   │   │   ├── aggregates/
│   │   │   │   │   └── user.aggregate.ts
│   │   │   │   ├── entities/
│   │   │   │   │   ├── user.entity.ts
│   │   │   │   │   ├── user-profile.entity.ts
│   │   │   │   │   └── user-preferences.entity.ts
│   │   │   │   ├── value-objects/
│   │   │   │   │   ├── user-id.vo.ts
│   │   │   │   │   ├── username.vo.ts
│   │   │   │   │   ├── full-name.vo.ts
│   │   │   │   │   ├── avatar-url.vo.ts
│   │   │   │   │   └── user-role.vo.ts
│   │   │   │   ├── events/
│   │   │   │   │   ├── user-created.event.ts
│   │   │   │   │   ├── user-updated.event.ts
│   │   │   │   │   ├── user-deleted.event.ts
│   │   │   │   │   ├── profile-completed.event.ts
│   │   │   │   │   └── preferences-updated.event.ts
│   │   │   │   ├── specifications/
│   │   │   │   │   ├── unique-username.spec.ts
│   │   │   │   │   └── unique-email.spec.ts
│   │   │   │   ├── policies/
│   │   │   │   │   └── user-deactivation-policy.ts
│   │   │   │   └── exceptions/
│   │   │   │       ├── user-not-found.exception.ts
│   │   │   │       └── duplicate-username.exception.ts
│   │   │   │
│   │   │   └── shared/                   # Shared Domain Concepts
│   │   │       ├── base-aggregate-root.ts
│   │   │       ├── base-entity.ts
│   │   │       ├── base-value-object.ts
│   │   │       ├── domain-event.interface.ts
│   │   │       ├── specification.interface.ts
│   │   │       └── unique-id.vo.ts
│   │   │
│   │   └── application/                  # APPLICATION LAYER - Use Cases
│   │       │
│   │       ├── auth/                     # Auth Application Services
│   │       │   ├── commands/
│   │       │   │   ├── register-user/
│   │       │   │   │   ├── register-user.command.ts
│   │       │   │   │   ├── register-user.handler.ts
│   │       │   │   │   └── register-user.validator.ts
│   │       │   │   ├── login-user/
│   │       │   │   │   ├── login-user.command.ts
│   │       │   │   │   ├── login-user.handler.ts
│   │       │   │   │   └── login-user.validator.ts
│   │       │   │   ├── logout-user/
│   │       │   │   │   ├── logout-user.command.ts
│   │       │   │   │   └── logout-user.handler.ts
│   │       │   │   ├── refresh-token/
│   │       │   │   │   ├── refresh-token.command.ts
│   │       │   │   │   └── refresh-token.handler.ts
│   │       │   │   ├── change-password/
│   │       │   │   │   ├── change-password.command.ts
│   │       │   │   │   └── change-password.handler.ts
│   │       │   │   ├── forgot-password/
│   │       │   │   │   ├── forgot-password.command.ts
│   │       │   │   │   └── forgot-password.handler.ts
│   │       │   │   ├── reset-password/
│   │       │   │   │   ├── reset-password.command.ts
│   │       │   │   │   └── reset-password.handler.ts
│   │       │   │   ├── verify-email/
│   │       │   │   │   ├── verify-email.command.ts
│   │       │   │   │   └── verify-email.handler.ts
│   │       │   │   ├── oauth-login/
│   │       │   │   │   ├── oauth-login.command.ts
│   │       │   │   │   └── oauth-login.handler.ts
│   │       │   │   ├── connect-oauth/
│   │       │   │   │   ├── connect-oauth.command.ts
│   │       │   │   │   └── connect-oauth.handler.ts
│   │       │   │   └── disconnect-oauth/
│   │       │   │       ├── disconnect-oauth.command.ts
│   │       │   │       └── disconnect-oauth.handler.ts
│   │       │   ├── queries/
│   │       │   │   ├── get-session/
│   │       │   │   │   ├── get-session.query.ts
│   │       │   │   │   └── get-session.handler.ts
│   │       │   │   ├── verify-token/
│   │       │   │   │   ├── verify-token.query.ts
│   │       │   │   │   └── verify-token.handler.ts
│   │       │   │   └── list-user-sessions/
│   │       │   │       ├── list-user-sessions.query.ts
│   │       │   │       └── list-user-sessions.handler.ts
│   │       │   ├── event-handlers/
│   │       │   │   ├── send-welcome-email.handler.ts
│   │       │   │   ├── send-verification-email.handler.ts
│   │       │   │   ├── send-password-reset-email.handler.ts
│   │       │   │   └── log-security-event.handler.ts
│   │       │   └── dto/
│   │       │       ├── auth-response.dto.ts
│   │       │       ├── session.dto.ts
│   │       │       └── token-pair.dto.ts
│   │       │
│   │       ├── user/                     # User Application Services
│   │       │   ├── commands/
│   │       │   │   ├── create-user/
│   │       │   │   │   ├── create-user.command.ts
│   │       │   │   │   └── create-user.handler.ts
│   │       │   │   ├── update-user/
│   │       │   │   │   ├── update-user.command.ts
│   │       │   │   │   └── update-user.handler.ts
│   │       │   │   ├── delete-user/
│   │       │   │   │   ├── delete-user.command.ts
│   │       │   │   │   └── delete-user.handler.ts
│   │       │   │   ├── update-profile/
│   │       │   │   │   ├── update-profile.command.ts
│   │       │   │   │   └── update-profile.handler.ts
│   │       │   │   └── update-preferences/
│   │       │   │       ├── update-preferences.command.ts
│   │       │   │       └── update-preferences.handler.ts
│   │       │   ├── queries/
│   │       │   │   ├── get-user-by-id/
│   │       │   │   │   ├── get-user-by-id.query.ts
│   │       │   │   │   └── get-user-by-id.handler.ts
│   │       │   │   ├── get-user-by-email/
│   │       │   │   │   ├── get-user-by-email.query.ts
│   │       │   │   │   └── get-user-by-email.handler.ts
│   │       │   │   ├── list-users/
│   │       │   │   │   ├── list-users.query.ts
│   │       │   │   │   └── list-users.handler.ts
│   │       │   │   └── get-user-profile/
│   │       │   │       ├── get-user-profile.query.ts
│   │       │   │       └── get-user-profile.handler.ts
│   │       │   ├── event-handlers/
│   │       │   │   ├── index-user-in-search.handler.ts
│   │       │   │   └── invalidate-user-cache.handler.ts
│   │       │   └── dto/
│   │       │       ├── user-response.dto.ts
│   │       │       ├── user-list-response.dto.ts
│   │       │       └── user-profile.dto.ts
│   │       │
│   │       └── shared/                   # Shared Application Concepts
│   │           ├── command.interface.ts
│   │           ├── command-handler.interface.ts
│   │           ├── query.interface.ts
│   │           ├── query-handler.interface.ts
│   │           ├── event-handler.interface.ts
│   │           ├── command-bus.interface.ts
│   │           ├── query-bus.interface.ts
│   │           ├── event-bus.interface.ts
│   │           ├── result.ts
│   │           ├── either.ts
│   │           └── pagination.dto.ts
│   │
│   ├── ports/                            # PORTS (Interfaces to/from Core)
│   │   │
│   │   ├── primary/                      # PRIMARY PORTS (Driving - Inbound)
│   │   │   ├── auth.port.ts
│   │   │   ├── user.port.ts
│   │   │   ├── command-bus.port.ts
│   │   │   └── query-bus.port.ts
│   │   │
│   │   └── secondary/                    # SECONDARY PORTS (Driven - Outbound)
│   │       ├── persistence/
│   │       │   ├── user-repository.port.ts
│   │       │   ├── session-repository.port.ts
│   │       │   ├── refresh-token-repository.port.ts
│   │       │   ├── oauth-connection-repository.port.ts
│   │       │   ├── user-profile-repository.port.ts
│   │       │   └── unit-of-work.port.ts
│   │       ├── cache/
│   │       │   ├── cache.port.ts
│   │       │   └── session-cache.port.ts
│   │       ├── messaging/
│   │       │   ├── event-publisher.port.ts
│   │       │   ├── queue.port.ts
│   │       │   └── message-broker.port.ts
│   │       ├── security/
│   │       │   ├── password-hasher.port.ts
│   │       │   ├── token-generator.port.ts
│   │       │   ├── token-verifier.port.ts
│   │       │   └── encryption.port.ts
│   │       ├── notification/
│   │       │   ├── email-sender.port.ts
│   │       │   └── sms-sender.port.ts
│   │       ├── oauth/
│   │       │   ├── oauth-provider.port.ts
│   │       │   └── oauth-client.port.ts
│   │       ├── logging/
│   │       │   ├── logger.port.ts
│   │       │   └── audit-logger.port.ts
│   │       ├── monitoring/
│   │       │   ├── metrics.port.ts
│   │       │   └── health-check.port.ts
│   │       └── storage/
│   │           └── file-storage.port.ts
│   │
│   ├── adapters/                         # ADAPTERS (Implementations)
│   │   │
│   │   ├── primary/                      # PRIMARY ADAPTERS (Driving - Inbound)
│   │   │   │
│   │   │   ├── rest/                     # REST API Adapter
│   │   │   │   ├── controllers/
│   │   │   │   │   ├── auth.controller.ts
│   │   │   │   │   ├── oauth.controller.ts
│   │   │   │   │   ├── user.controller.ts
│   │   │   │   │   └── profile.controller.ts
│   │   │   │   ├── middlewares/
│   │   │   │   │   ├── authentication.middleware.ts
│   │   │   │   │   ├── authorization.middleware.ts
│   │   │   │   │   ├── rate-limiter.middleware.ts
│   │   │   │   │   ├── request-validator.middleware.ts
│   │   │   │   │   ├── error-handler.middleware.ts
│   │   │   │   │   ├── helmet-security.middleware.ts
│   │   │   │   │   ├── cors.middleware.ts
│   │   │   │   │   ├── csrf-protection.middleware.ts
│   │   │   │   │   ├── compression.middleware.ts
│   │   │   │   │   └── request-logger.middleware.ts
│   │   │   │   ├── routes/
│   │   │   │   │   ├── auth.routes.ts
│   │   │   │   │   ├── oauth.routes.ts
│   │   │   │   │   ├── user.routes.ts
│   │   │   │   │   ├── profile.routes.ts
│   │   │   │   │   ├── health.routes.ts
│   │   │   │   │   └── index.ts
│   │   │   │   ├── validators/
│   │   │   │   │   ├── auth.validator.ts
│   │   │   │   │   ├── user.validator.ts
│   │   │   │   │   └── common.validator.ts
│   │   │   │   ├── serializers/
│   │   │   │   │   ├── auth-response.serializer.ts
│   │   │   │   │   ├── user-response.serializer.ts
│   │   │   │   │   └── error-response.serializer.ts
│   │   │   │   ├── mappers/
│   │   │   │   │   ├── http-to-command.mapper.ts
│   │   │   │   │   └── http-to-query.mapper.ts
│   │   │   │   ├── app.ts
│   │   │   │   ├── server.ts
│   │   │   │   └── swagger.config.ts
│   │   │   │
│   │   │   ├── graphql/                  # GraphQL Adapter (Optional)
│   │   │   │   ├── resolvers/
│   │   │   │   │   ├── auth.resolver.ts
│   │   │   │   │   └── user.resolver.ts
│   │   │   │   ├── schemas/
│   │   │   │   │   ├── auth.schema.ts
│   │   │   │   │   └── user.schema.ts
│   │   │   │   └── server.ts
│   │   │   │
│   │   │   ├── cli/                      # CLI Adapter
│   │   │   │   ├── commands/
│   │   │   │   │   ├── create-user.command.ts
│   │   │   │   │   └── migrate.command.ts
│   │   │   │   └── index.ts
│   │   │   │
│   │   │   └── messaging/                # Message Consumer Adapter
│   │   │       ├── consumers/
│   │   │       │   └── auth-events.consumer.ts
│   │   │       └── index.ts
│   │   │
│   │   └── secondary/                    # SECONDARY ADAPTERS (Driven - Outbound)
│   │       │
│   │       ├── persistence/              # Database Adapters
│   │       │   ├── drizzle/
│   │       │   │   ├── config/
│   │       │   │   │   └── drizzle.config.ts
│   │       │   │   ├── schemas/
│   │       │   │   │   ├── users.schema.ts
│   │       │   │   │   ├── user-profiles.schema.ts
│   │       │   │   │   ├── user-preferences.schema.ts
│   │       │   │   │   ├── sessions.schema.ts
│   │       │   │   │   ├── refresh-tokens.schema.ts
│   │       │   │   │   ├── oauth-connections.schema.ts
│   │       │   │   │   └── index.ts
│   │       │   │   ├── repositories/
│   │       │   │   │   ├── user.repository.ts
│   │       │   │   │   ├── session.repository.ts
│   │       │   │   │   ├── refresh-token.repository.ts
│   │       │   │   │   ├── oauth-connection.repository.ts
│   │       │   │   │   └── user-profile.repository.ts
│   │       │   │   ├── mappers/
│   │       │   │   │   ├── user.mapper.ts
│   │       │   │   │   ├── session.mapper.ts
│   │       │   │   │   └── oauth-connection.mapper.ts
│   │       │   │   ├── migrations/
│   │       │   │   │   ├── 0001_create_users_table.sql
│   │       │   │   │   ├── 0002_create_sessions_table.sql
│   │       │   │   │   ├── 0003_create_oauth_connections_table.sql
│   │       │   │   │   └── meta/
│   │       │   │   ├── seeds/
│   │       │   │   │   └── initial-data.seed.ts
│   │       │   │   ├── connection.ts
│   │       │   │   └── unit-of-work.ts
│   │       │   │
│   │       │   └── typeorm/              # Alternative ORM (if needed)
│   │       │       └── README.md
│   │       │
│   │       ├── cache/                    # Cache Adapters
│   │       │   ├── redis/
│   │       │   │   ├── redis-cache.adapter.ts
│   │       │   │   ├── redis-session-cache.adapter.ts
│   │       │   │   ├── redis-client.ts
│   │       │   │   └── redis.config.ts
│   │       │   └── in-memory/
│   │       │       └── in-memory-cache.adapter.ts
│   │       │
│   │       ├── messaging/                # Message Queue Adapters
│   │       │   ├── bull/
│   │       │   │   ├── bull-queue.adapter.ts
│   │       │   │   ├── bull-event-publisher.adapter.ts
│   │       │   │   └── bull.config.ts
│   │       │   └── rabbitmq/
│   │       │       └── rabbitmq.adapter.ts
│   │       │
│   │       ├── security/                 # Security Adapters
│   │       │   ├── bcrypt/
│   │       │   │   └── bcrypt-hasher.adapter.ts
│   │       │   ├── jwt/
│   │       │   │   ├── jwt-token-generator.adapter.ts
│   │       │   │   ├── jwt-token-verifier.adapter.ts
│   │       │   │   └── jwt.config.ts
│   │       │   └── crypto/
│   │       │       └── node-crypto-encryption.adapter.ts
│   │       │
│   │       ├── notification/             # Notification Adapters
│   │       │   ├── email/
│   │       │   │   ├── nodemailer/
│   │       │   │   │   ├── nodemailer-email.adapter.ts
│   │       │   │   │   └── nodemailer.config.ts
│   │       │   │   ├── sendgrid/
│   │       │   │   │   └── sendgrid-email.adapter.ts
│   │       │   │   └── templates/
│   │       │   │       ├── welcome.template.ts
│   │       │   │       ├── verify-email.template.ts
│   │       │   │       ├── password-reset.template.ts
│   │       │   │       └── template-engine.ts
│   │       │   └── sms/
│   │       │       └── twilio-sms.adapter.ts
│   │       │
│   │       ├── oauth/                    # OAuth Adapters
│   │       │   ├── google/
│   │       │   │   ├── google-oauth.adapter.ts
│   │       │   │   └── google-oauth.config.ts
│   │       │   ├── facebook/
│   │       │   │   └── facebook-oauth.adapter.ts
│   │       │   └── oauth-provider.factory.ts
│   │       │
│   │       ├── logging/                  # Logging Adapters
│   │       │   ├── winston/
│   │       │   │   ├── winston-logger.adapter.ts
│   │       │   │   ├── winston.config.ts
│   │       │   │   └── transports/
│   │       │   │       ├── console.transport.ts
│   │       │   │       ├── file.transport.ts
│   │       │   │       └── elasticsearch.transport.ts
│   │       │   ├── morgan/
│   │       │   │   └── morgan-http-logger.adapter.ts
│   │       │   └── pino/
│   │       │       └── pino-logger.adapter.ts
│   │       │
│   │       ├── monitoring/               # Monitoring Adapters
│   │       │   ├── prometheus/
│   │       │   │   ├── prometheus-metrics.adapter.ts
│   │       │   │   └── prometheus.config.ts
│   │       │   ├── datadog/
│   │       │   │   └── datadog-metrics.adapter.ts
│   │       │   └── health-check/
│   │       │       └── health-check.adapter.ts
│   │       │
│   │       └── storage/                  # File Storage Adapters
│   │           ├── s3/
│   │           │   └── s3-storage.adapter.ts
│   │           └── local/
│   │               └── local-storage.adapter.ts
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
│   │   ├── queue.config.ts
│   │   ├── monitoring.config.ts
│   │   ├── environment.ts
│   │   └── index.ts
│   │
│   ├── shared/                           # SHARED INFRASTRUCTURE
│   │   ├── utils/
│   │   │   ├── date.utils.ts
│   │   │   ├── string.utils.ts
│   │   │   ├── crypto.utils.ts
│   │   │   ├── validation.utils.ts
│   │   │   └── async.utils.ts
│   │   ├── constants/
│   │   │   ├── http-status.constants.ts
│   │   │   ├── error-codes.constants.ts
│   │   │   ├── event-types.constants.ts
│   │   │   └── app.constants.ts
│   │   ├── types/
│   │   │   ├── global.types.ts
│   │   │   ├── pagination.types.ts
│   │   │   ├── sorting.types.ts
│   │   │   └── filtering.types.ts
│   │   └── errors/
│   │       ├── base.error.ts
│   │       ├── domain.error.ts
│   │       ├── application.error.ts
│   │       └── infrastructure.error.ts
│   │
│   ├── container/                        # DEPENDENCY INJECTION
│   │   ├── container.ts
│   │   ├── registry.ts
│   │   ├── auth.module.ts
│   │   ├── user.module.ts
│   │   ├── infrastructure.module.ts
│   │   └── index.ts
│   │
│   └── index.ts                          # Application Entry Point
│
├── scripts/
│   ├── db/
│   │   ├── migrate.ts
│   │   ├── rollback.ts
│   │   ├── seed.ts
│   │   ├── reset.ts
│   │   └── backup.ts
│   ├── dev/
│   │   ├── generate-keys.ts
│   │   ├── create-admin.ts
│   │   └── populate-test-data.ts
│   └── deployment/
│       ├── health-check.ts
│       ├── pre-deploy.ts
│       └── post-deploy.ts
│
├── tests/
│   ├── unit/
│   │   ├── core/
│   │   │   ├── domain/
│   │   │   │   ├── auth/
│   │   │   │   └── user/
│   │   │   └── application/
│   │   │       ├── auth/
│   │   │       └── user/
│   │   └── adapters/
│   │       ├── primary/
│   │       └── secondary/
│   ├── integration/
│   │   ├── ports/
│   │   ├── adapters/
│   │   └── end-to-end/
│   ├── e2e/
│   │   ├── auth/
│   │   │   ├── registration.e2e.spec.ts
│   │   │   ├── login.e2e.spec.ts
│   │   │   ├── oauth.e2e.spec.ts
│   │   │   └── password-reset.e2e.spec.ts
│   │   └── user/
│   │       ├── user-management.e2e.spec.ts
│   │       └── profile-management.e2e.spec.ts
│   ├── performance/
│   │   ├── load-tests/
│   │   │   ├── auth-load.spec.ts
│   │   │   └── user-load.spec.ts
│   │   └── stress-tests/
│   ├── security/
│   │   ├── sql-injection.spec.ts
│   │   ├── xss.spec.ts
│   │   ├── csrf.spec.ts
│   │   └── authentication.spec.ts
│   ├── architecture/
│   │   ├── hexagon-compliance.spec.ts
│   │   ├── dependency-rules.spec.ts
│   │   └── port-adapter-isolation.spec.ts
│   ├── helpers/
│   │   ├── test-container.helper.ts
│   │   ├── test-database.helper.ts
│   │   ├── test-server.helper.ts
│   │   └── factories/
│   │       ├── user.factory.ts
│   │       ├── session.factory.ts
│   │       └── command.factory.ts
│   ├── mocks/
│   │   ├── ports/
│   │   │   ├── mock-user-repository.ts
│   │   │   ├── mock-email-sender.ts
│   │   │   └── mock-oauth-provider.ts
│   │   └── adapters/
│   └── setup.ts
│
├── benchmarks/
│   ├── auth-operations.bench.ts
│   └── user-queries.bench.ts
│
├── .vscode/
│   ├── settings.json
│   ├── extensions.json
│   ├── launch.json
│   └── tasks.json
│
├── .husky/
│   ├── pre-commit
│   ├── pre-push
│   ├── commit-msg
│   └── post-merge
│
├── migrations/
│   └── meta/
│
├── logs/
│   ├── app/
│   ├── error/
│   ├── access/
│   ├── security/
│   └── audit/
│
├── .env.example
├── .env.development
├── .env.test
├── .env.staging
├── .env.production
├── .gitignore
├── .prettierrc
├── .prettierignore
├── .eslintrc.json
├── .eslintignore
├── .commitlintrc.json
├── .nvmrc
├── .editorconfig
├── tsconfig.json
├── tsconfig.build.json
├── tsconfig.test.json
├── jest.config.ts
├── vitest.config.ts
├── drizzle.config.ts
├── package.json
├── pnpm-workspace.yaml
├── pnpm-lock.yaml
├── README.md
├── CHANGELOG.md
├── CONTRIBUTING.md
├── CODE_OF_CONDUCT.md
├── LICENSE
├── SECURITY.md
└── ARCHITECTURE.md