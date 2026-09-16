<?php
// Serve index.html as the default page
// This bypasses .htaccess/mod_rewrite issues
$indexFile = 'index.html';

if (file_exists($indexFile)) {
    readfile($indexFile);
} else {
    // Fallback - redirect to /en/ if index.html doesn't exist
    header('Location: /en/');
    exit;
}
?>
