import {beforeEach, describe, expect, test} from "@jest/globals";
import {Context} from "@azure/functions";
import {buildContext} from "../src/helper/Helper";
import {SkoolRequest} from "../src/model/SkoolRequest";
import {getSkoolResponse} from "../src/service/SkoolService";


describe("Skool service tests", () => {
    let context: Context;

    beforeEach(async () => {
        context = buildContext();
    });

    test("given request when service getSkoolResponse shoud return string response.", async () => {
        // GIVEN
        const request: SkoolRequest = { polygramme: "HEFR", description: "DevOps trainer at Octo.", version: "4" };

        // WHEN
        const response: string = await getSkoolResponse(request);

        // THEN
        expect(response).toEqual("Greetings HEFR, you are using version: 4\n" + "DevOps trainer at Octo.");
    })
})