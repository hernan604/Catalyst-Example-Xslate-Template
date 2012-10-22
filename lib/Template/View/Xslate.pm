package Template::View::Xslate;
use Moose;
extends 'Catalyst::View::Xslate';

#   has '+module' => (
#       default => sub { [ 'Text::Xslate::Bridge::TT2Like' ] }
#       );

has '+template_extension' => (
    default => '.tt',
    );

has '+cache_dir' => (
    default => '/Users/nixus/catalyst/Xslate/Template/cache',
    );

has '+cache' => (
    default => '1',
    );

has '+content_charset' => (
    default => 'UTF-8',
    );

before process => sub {
    my ($self, $c) = @_;
    #$self->path($c->stash->{'aditional_template_paths'})
};

#has '+path' => (
#    default => '/Users/nixus/catalyst/Xslate/Template/root/src',
#    );

#   has '+syntax' => (
#       default => 'TTerse',
#       );


#=========
# Adiciona um template da loja sempre que ele existir
#=========
sub include_tpl {
    my ( $self, $c, @args ) = @_;
    my $template = $args[0];
    if (
        -e Template->path_to(
        "root/src/".$c->stash->{loja_atual}."/$template"
    ) ) {
        #Tenta encontrar um tpl específico por loja
        return "src/".$c->stash->{loja_atual}."/$template"
    } elsif (
        -e Template->path_to(
        "root/src/padrao/$template"
    ) ) {
        #Tenta encontrar um tpl padrão
        return "src/padrao/$template"
    }
    return "";
}

__PACKAGE__->config(expose_methods => [qw(include_tpl)]);

1;



