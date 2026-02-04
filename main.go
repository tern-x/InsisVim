package main

import (
	"io"
	"net/http"
	"strings"
)

func main() {
	url := "https://nwadmin.mtgame.top/api/game/UserMetricRpc/Cumulate"

	method := "POST"

	payload := strings.NewReader(`{
    "Id": 1,
    "Metrics": {
        "ttt": 123,
        "Value": 1233
    }
}`)

	client := &http.Client{}
	req, err := http.NewRequest(method, url, payload)

	if err != nil {
		fmt.Println(err)
		return
	}
	req.Header.Add("Content-Type", "application/json")
	req.Header.Add("Authorization", "••••••")

	res, err := client.Do(req)
	if err != nil {
		fmt.Println(err)
		return
	}
	defer res.Body.Close()

	body, err := io.ReadAll(res.Body)
	if err != nil {
		fmt.Println(err)
		return
	}

	fmt.Println(string(body))
}
