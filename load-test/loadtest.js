import http from "k6/http";
import { htmlReport } from "https://raw.githubusercontent.com/benc-uk/k6-reporter/main/dist/bundle.js";
import { textSummary } from "https://jslib.k6.io/k6-summary/0.0.1/index.js";
import { sleep, check } from "k6";

export let options = {
    stages: [
        { duration: '40s', target: 1000 }, // simulate ramp-up of traffic from 1 to 1000 virtual users over 40 seconds.
        { duration: '30s', target: 1000 }, // stay at 1000 virtual users for 30 seconds
        { duration: '20s', target: 1500 }, // ramp-up of traffic from 1000 to 1500 virtual users over 20 seconds.
        { duration: '20s', target: 2000 }, // ramp-up of traffic from 1500 to 2000 virtual users over 20 seconds.
        { duration: '1m', target: 0 }      // ramp-down to 0 users over 1 minutes
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