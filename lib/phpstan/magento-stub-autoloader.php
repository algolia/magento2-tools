<?php

/**
 * Dynamic stub autoloader for Tier 1 (standalone) PHPStan analysis.
 *
 * Generates empty class/interface stubs on-the-fly for Magento and legacy Zend
 * classes so PHPStan can analyse extension code without a full Magento installation.
 *
 * This avoids PHPStan "extends unknown class" internal errors (which are non-ignorable)
 * without requiring maintained stub files. The generated stubs are intentionally empty —
 * Tier 1 analysis catches logic and type errors within the extension itself, not
 * framework integration issues.
 *
 * Loaded via PHPStan's bootstrapFiles configuration.
 */

spl_autoload_register(function (string $class): void {
    // Only stub Magento ecosystem and test framework classes
    if (
        strpos($class, 'Magento\\') !== 0
        && strpos($class, 'Zend_') !== 0
        && strpos($class, 'PHPUnit\\') !== 0
    ) {
        return;
    }

    $namespace = '';
    $className = $class;

    // Handle namespaced classes (Magento\*)
    $lastBackslash = strrpos($class, '\\');
    if ($lastBackslash !== false) {
        $namespace = substr($class, 0, $lastBackslash);
        $className = substr($class, $lastBackslash + 1);
    }

    // Determine if this should be an interface, abstract class, or concrete class
    $isInterface = (
        substr($className, -9) === 'Interface'
        || substr($className, -16) === 'InterfaceFactory'
    );

    $keyword = $isInterface ? 'interface' : 'class';

    $code = "<?php\n";
    if ($namespace !== '') {
        $code .= "namespace {$namespace};\n";
    }
    $code .= "{$keyword} {$className} {}\n";

    eval(substr($code, strlen("<?php\n")));
});
