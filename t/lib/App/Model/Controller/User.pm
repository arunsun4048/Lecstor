package App::Model::Controller::User;
use Moose;

extends 'Lecstor::Model::Controller::User';

# ABSTRACT: add our little touches to the user set with no schema changes.

# if we don't override the schema result we'll get Lecstor::Models back from
# searches so we really shouldn't override the model class here.
#sub _build_model_class{ 'App::Model::User' }


# for efficiency we should probably override create altogether but let's
# keep it simple for this test..
around 'create' => sub{
    my ($orig, $self, $params) = @_;
    my $model = $self->$orig($params);
    $model->_record->update({ active => 0 });
    return $model;
};


__PACKAGE__->meta->make_immutable;

1;
