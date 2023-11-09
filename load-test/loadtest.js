import http from "k6/http";
import { htmlReport } from "https://raw.githubusercontent.com/benc-uk/k6-reporter/main/dist/bundle.js";
import { textSummary } from "https://jslib.k6.io/k6-summary/0.0.1/index.js";
import { sleep, check } from "k6";

export let options = {
    stages: [
        { duration: '40s', target: 1000 }, // run 0 - 1000 VUs for 3 minute
        { duration: '30s', target: 1000 }, // stay 1000 VUs for 2 minute
        { duration: '20s', target: 1500 }, // run 1000 - 1500 VUs for 3 minute
        { duration: '20s', target: 2000 }, // run 1500 - 2000 VUs for 5 minute
        { duration: '1m', target: 0 }     // decrease VUs until 0 for 2 minute
    ]
};

export default function () {
    const URI = ''

    const payload = JSON.stringify({
        email: '',
        name: ''
    })
    
    const header = {
        'Content-Type': 'application/json',
        'Cookie': '',
    }

    const res = http.patch(URI, payload, { headers: header })

    // status code should 200 OK
    check(res, {
        'status was 200': (r) => r.status == 200
    })

    sleep(1)
}

// report result to html
export function handleSummary(data) {
    return {
        "result.html": htmlReport(data),
        stdout: textSummary(data, { indent: " ", enableColors: true }),
    };
}