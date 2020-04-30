## AWS SQS Playgound

A personal playground for AWS SQS fun.

### Installation
Ensure you have ``pyenv`` and ``tfenv`` installed and have added relevant aws credentials for terraform into your ``~/.aws/credentials`` file.
You will also require ``poetry`` to handle python dependencies. The ``make install`` command below checks that you have everything you need.

* ``make install``
* ``make run_terraform``

### Testing the new queue
* ``poetry run python ./scripts/send_msg.py``
* ``poetry run python ./scripts/receive_msg.py``

Note that the receive message script runs constantly checking for new messages every 10 seconds.
I suggest that you have two terminals running, one with the ``receive_msg.py`` process running and another to allow you to run ``send_msg.py`` to
get new messages into the queue.

### Cleaning up

When you are done playing, simply run the two commands below to clean up after youself and avoid any AWS charges.

* ``make clean_up``
* ``make delete_venv``

## Versioning

This project uses [git](https://git-scm.com/) for versioning. For the available versions,
see the [tags on this repository](https://github.com/robcharlwood/aws-sqs-playground/tags).

## Authors

* Rob Charlwood - Bitniftee Limited

## Changes

Please see the [CHANGELOG.md](https://github.com/robcharlwood/aws-sqs-playground/blob/master/CHANGELOG.md) file additions, changes, deletions and fixes between each version

## License

This project is licensed under the MIT License - see the [LICENSE.md](https://github.com/robcharlwood/aws-sqs-playground/blob/master/LICENSE) file for details
