package main

import (
	"crypto/sha256"
	"github.com/ethereum/go-ethereum/common"
	"log"
	"math/rand"
	"os"
)

var ToCollide = common.Hex2Bytes("1626ba7e19bb34e293bba96bf0caeea54cdd3d2dad7fdf44cbea855173fa84534fcfb528000000000000000000000000000000000000000000000000000000000000004000000000000000000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000000")
var TARGET = common.Hex2Bytes("1626ba7e")

func main() {
	var count = 0
	for {
		rand.Read(ToCollide[100:108])
		// log.Printf("%x", ToCollide)
		hash := sha256.Sum256(ToCollide)
		// log.Printf("%x", hash)
		if hash[0] == TARGET[0] && hash[1] == TARGET[1] && hash[2] == TARGET[2] && hash[3] == TARGET[3] {
			log.Printf("Found collision: %x, rand: %02x", hash, ToCollide[100:108])
			os.Exit(0)
		}
		count++
		if count%1000000 == 0 {
			log.Printf("%d", count/1000000)
		}
	}
}

// Found collision: 1626ba7e95fed565f4010ab111eb8825524035addedf763b65bd3d1c8ec4e5cd, rand: 74bddd646a036561
