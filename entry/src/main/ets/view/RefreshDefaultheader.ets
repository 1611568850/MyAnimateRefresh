import CommonConstants from '../common/constants/CommonConstants';
import { RefreshConstants, RefreshState } from '../common/constants/RefreshConstants';
import DimensionUtil from '../common/utils/DimensionUtil';

@Component
export default struct RefreshDefaultHeader {
    @State refreshTitle: Resource = $r('app.string.refresh_default_header_hint');
    @Consume(RefreshConstants.REFRESH_STATE_TAG) state: number;

    build() {
        if (this.state !== RefreshState.IDLE) {
            Text(this.refreshTitle)
                .height(CommonConstants.FULL_LENGTH)
                .width(CommonConstants.FULL_LENGTH)
                .textAlign(TextAlign.Center)
                .fontSize(DimensionUtil.getFp($r('app.float.default_header_font_size')))
        }
    }
}