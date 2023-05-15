import {beforeEach, describe, expect, test} from "@jest/globals";
import {Context} from "@azure/functions";
import {buildContext} from "../src/helper/Helper";
import {SkoolRequest, toSkoolRequest} from "../src/model/SkoolRequest";


describe("Skool request tests", () => {
    let context: Context;

    beforeEach(async () => {
        context = buildContext();
    });

    test("given payload should return SkoolRequest", async () => {
        // GIVEN
        const body = { polygramme: "HEFR", description: "DevOps trainer at Octo.", version: "4" };

        // WHEN
        const skoolRequest: SkoolRequest = toSkoolRequest(body);

        // THEN
        expect(skoolRequest.polygramme).toEqual("HEFR");
        expect(skoolRequest.description).toEqual("DevOps trainer at Octo.");
        expect(skoolRequest.version).toEqual("4");
    })
})