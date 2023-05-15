import { AzureFunction, Context, HttpRequest } from "@azure/functions"
import {SkoolRequest, toSkoolRequest} from "./src/model/SkoolRequest";
import {getSkoolResponse} from "./src/service/SkoolService";

const httpTrigger: AzureFunction = async function (context: Context, req: HttpRequest): Promise<string> {
    context.log('HTTP trigger function processed a request.');
    const skoolRequest: SkoolRequest = toSkoolRequest(req.body)
    const response = await getSkoolResponse(skoolRequest);
    context.log(response);
    return response;
};

export default httpTrigger;