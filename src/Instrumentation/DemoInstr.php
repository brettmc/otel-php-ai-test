<?php

namespace App\Instrumentation;

use App\Demo;
use OpenTelemetry\API\Common\Instrumentation\CachedInstrumentation;
use OpenTelemetry\API\Trace\Span;
use OpenTelemetry\Context\Context;
use function OpenTelemetry\Instrumentation\hook;

class DemoInstr
{
    public static function init(): void
    {
        $instrumentation = new CachedInstrumentation('demo');
        hook(
            Demo::class,
            'run',
            static function (Demo $demo, array $params, string $class, string $function, ?string $filename, ?int $lineno) use ($instrumentation) {
                $span = $instrumentation->tracer()->spanBuilder(sprintf('%s:%s', $class, $function))->startSpan();
                Context::storage()->attach($span->storeInContext(Context::getCurrent()));
            },
            static function (Demo $demo, array $params, ?string $return, ?Throwable $exception) {
                $scope = Context::storage()->scope();
                $scope?->detach();
                $span = Span::fromContext($scope->context());
                $span->end();
            }
        );
    }
}