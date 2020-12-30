#!/bin/bash

for i in "$@"
do
   webserver=$(echo $i | awk '{print $1}')
   echo $webserver

   echo Finding the node\'s public id...

   public_id=$(sudo kubectl exec -n dragonchain $webserver -- python3 -c "from dragonchain.lib.keys import get_public_id; print(get_public_id())")
   echo "Public id: $public_id"

   echo Checking the node\'s matchmaking status...

   curl https://matchmaking.api.dragonchain.com/registration/verify/$public_id
   
   echo
   echo
done

