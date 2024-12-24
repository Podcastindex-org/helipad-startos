import { types as T, healthUtil } from "../deps.ts";

export const health: T.ExpectedExports.health = {
  async "web-ui"(effects, duration) {
    return healthUtil.checkWebUrl("http://helipad.embassy:2112")(effects, duration).catch(healthUtil.catchError(effects))
  },
};
