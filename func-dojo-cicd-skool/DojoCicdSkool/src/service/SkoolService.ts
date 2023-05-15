import {Context} from "@azure/functions";
import {SkoolRequest} from "../model/SkoolRequest";


export const getSkoolResponse = async function(request: SkoolRequest): Promise<string> {
    return "Greetings ".concat(request.polygramme).concat(", you are using version: ").concat(request.version).concat("\n").concat(request.description);
}