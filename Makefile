vendor: composer.lock
	composer install
	touch $@

.PHONY: all static-analysis unit-tests acceptance-tests code-style security-tests coverage

static-analysis: vendor
	bin/console lint:container
	bin/console lint:yaml --parse-tags config/
	php -d memory_limit=512M vendor/bin/phpstan

acceptance-tests: vendor
# 	bin/console doctrine:migrations:migrate --no-interaction
	vendor/bin/behat -v --suite=acceptance