#!/bin/bash

for team in $(gawk -F, '{print $2}' data.txt | uniq )
do
    gawk -v team=$team 'BEGIN{FS=",";toal=0}
    {
        if($2==team)
        {
            total+=$3+$4+$5
        }
    }
    END{
        avg=total/6;
        print "Total for",team,"is",total,",the average is",avg
    }' data.txt
done
