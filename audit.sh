#!/bin/bash

# This script is used to audit the system for security settings
# Lets get the following things and store the output to a file
# All files should be stored in the folder audit

# store the folder name in a variable
folder="laravel-security-audit"

# Delete the folder and recreate it
rm -rf $folder
mkdir $folder

# Lets check the php version
php_v=$(php -v)
# Lets check the composer version
composer_v=$(composer --version)
# Lets check the npm version
npm_v=$(npm -v)
# Lets check the node version
node_v=$(node -v)
# Lets store the version data in a file, this will be a json file
JSON_STRING="{
    \"php\": \"${php_v}\",
    \"composer\": \"${composer_v}\",
    \"npm\": \"${npm_v}\",
    \"node\": \"${node_v}\"
}"
echo $JSON_STRING > $folder/versions.json

# Composer audit
composer audit > $folder/composer_audit.txt
# Now for an npm audit
npm audit > $folder/npm_audit.txt

# Lets do a route audit
php artisan route:list --json > $folder/routes.json

# Lets check if pest is installed
pest_v=$(vendor/bin/pest --version)
# lets check if herd is installed
herd_v=$(herd --version)
# if herd and pest are installed, we need to use "herd debug vendor/bin/pest" to get the type coverage
# else if pest, we can use the pest command to get the type coverage
#if [ -n "$herd_v" ] && [ -n "$pest_v" ]; then
#    herd debug vendor/bin/pest --type-coverage --min=100 --type-coverage-json=$folder/type_coverage.json
#elif [ -n "$pest_v" ]; then
#    vendor/bin/pest --type-coverage --min=100 --type-coverage-json=$folder/type_coverage.json
#fi

# Lets create a php file to compile everything into one neat html file to review
# Lets do in one big doc for now
cat > $folder/audit.php <<EOF
<?php
\$versions = json_decode(file_get_contents('audit/versions.json'), true);
\$composer_audit = file_get_contents('audit/composer_audit.txt');
\$npm_audit = file_get_contents('audit/npm_audit.txt');
\$routes = json_decode(file_get_contents('audit/routes.json'), true);

echo "<h1>System Audit</h1>";
echo "<h2>PHP Version</h2>";
echo "<pre>";
print_r(\$versions['php']);
echo "</pre>";

echo "<h2>Composer Version</h2>";
echo "<pre>";
print_r(\$versions['composer']);
echo "</pre>";

echo "<h2>NPM Version</h2>";
echo "<pre>";
print_r(\$versions['npm']);
echo "</pre>";

echo "<h2>Node Version</h2>";
echo "<pre>";
print_r(\$versions['node']);
echo "</pre>";

echo "<h2>Composer Audit</h2>";
echo "<pre>";
print_r(\$composer_audit);
echo "</pre>";

echo "<h2>NPM Audit</h2>";
echo "<pre>";
print_r(\$npm_audit);
echo "</pre>";

echo "<h2>Routes</h2>";
echo "<pre>";
print_r(\$routes);
echo "</pre>";

EOF

# Lets convert the php file to html
php $folder/audit.php > audit.html

# now lets delete the audit folder
rm -rf $folder