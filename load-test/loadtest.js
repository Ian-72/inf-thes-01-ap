import http from "k6/http";
import { sleep, check } from "k6";

export let options = {
    vus: 100,
    duration: "5s",
};

export default function () {
    const res = http.get("http://localhost:1470");
    check(res, {
        "status was 200": (r) => r.status == 200,
        "transaction time OK": (r) => r.timings.duration < 500,
    });
    sleep(1);
}