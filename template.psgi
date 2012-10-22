use strict;
use warnings;

use Template;

my $app = Template->apply_default_middlewares(Template->psgi_app);
$app;

