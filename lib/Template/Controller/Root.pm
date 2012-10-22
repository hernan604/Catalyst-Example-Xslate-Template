package Template::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=head1 NAME

Template::Controller::Root - Root Controller for Template

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    # Hello World
    $c->response->body( $c->welcome_message );
}

=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

sub tpl_paths :Private {
    my ( $self , $c ) = @_;
    $c->stash->{ aditional_template_paths } = [
        '/Users/nixus/catalyst/Xslate/Template/root/src/padrao',
        '/Users/nixus/catalyst/Xslate/Template/root/src/loja1',
        '/Users/nixus/catalyst/Xslate/Template/root/src/loja2',
        '/Users/nixus/catalyst/Xslate/Template/root/',
    ];
#   return [ qw/loja1 loja2/ ];
}

sub render_tpl :Private {
    my ( $self , $c ) = @_;
    $c->forward( qw/tpl_paths/ );
    $c->stash(
        loja_atual => 'loja2',
        arr => [ qw/ãããã ééé ção/ ],
        template => 'src/template_a.tt',
        current_view => 'Xslate',
    );
}

sub render_tpl2 :Private {
    my ( $self , $c ) = @_;
    $c->forward( qw/tpl_paths/ );
    $c->stash(
        loja_atual => $c->stash->{ loja_escolhida },
        arr => [ qw/ãããã ééé ção/ ],
        template => 'src/template_a.tt',
        current_view => 'Xslate',
    );
}

sub teste :Path('/teste') {
    my ( $self , $c ) = @_;
    $c->forward( qw/render_tpl/ );
}

sub teste2 :Path('/layout') :Args(1) {
    my ( $self , $c, $loja_escolhida ) = @_;
    $c->stash->{ loja_escolhida } = $loja_escolhida;
    $c->forward( qw/render_tpl2/ );
}


=head2 end

Attempt to render a view, if needed.

=cut

#sub end : ActionClass('RenderView') {}
sub end : Private {
    my ( $self, $c ) = @_;
    $c->forward('Template::View::Xslate');
}

=head1 AUTHOR

Nixus Nixus

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
