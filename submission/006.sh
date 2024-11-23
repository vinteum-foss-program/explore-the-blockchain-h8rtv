#!/usr/bin/env bash

# Which tx in block 257,343 spends the coinbase output of block 256,128?

coinbasetxid=$(bitcoin-cli getblock $(bitcoin-cli getblockhash 256128) | jq -r ".tx[0]")

# we can filter out the first tx as it's the coinbase tx
transactions=$(bitcoin-cli getblock $(bitcoin-cli getblockhash 257343) | jq -r ".tx[1:].[]")

function find_txid
{
    for txid in $transactions
    do
        rawtx=$(bitcoin-cli getrawtransaction $txid)
        txidsin=$(bitcoin-cli decoderawtransaction $rawtx | jq -r ".vin.[] | .txid")

        for txidin in $txidsin
        do
            if [ "$txidin" = "$coinbasetxid" ]; then
                echo $txid
                return 0
            fi
        done
    done

    return 1
}

find_txid
