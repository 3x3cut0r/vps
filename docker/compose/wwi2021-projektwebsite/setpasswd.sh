#!/usr/bin/env bash

set -e

echo 'root:$6$6dPxbChotawu8Va6$/CoeYMdxgciuZ/Bp.dR8BJUmqXvX8cw8VY1nsJQ/yXdqBHpFWIge9wPo6mKP6xHqic5asbpgUBVOUs6aetBHT/' | chpasswd --encrypted

# Or if you don't pre-hash the password remove the line above and uncomment the line below.
# echo "user1:user1password" | chpasswd
