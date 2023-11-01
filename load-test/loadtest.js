import http from "k6/http";
import { sleep, check } from "k6";

export let options = {
    stages: [
        { duration: '3m', target: 1000 }, // run 0 - 1000 VUs for 3 minute
        { duration: '2m', target: 1000 }, // stay 100 VUs for 2 minute
        { duration: '3m', target: 1500 }, // run 1000 - 1500 VUs for 3 minute
        { duration: '5m', target: 2000 }, // run 1500 - 2000 VUs for 5 minute
        { duration: '2m', target: 0 }     // decrease VUs until 0 for 2 minute
    ]
};

export default function () {
    const URI = 'http:///api/users'

    const payload = JSON.stringify({
        email: 'testing@gmail.com',
        name: 'GenerateByLoadTest2'
    })
    
    const header = {
        'Content-Type': 'application/json',
        'Cookie': '',
        'Connection': 'keep-alive'
    }

    const res = http.patch(URI, payload, { headers: header })

    // status code should 200 OK
    check(res, {
        'status was 200': (r) => r.status == 200
    })

    sleep(1)
}