/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
 * Licensed under the Apache License,Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import CommonConstants from '../common/constants/CommonConstants';
import RefreshDefaultHeader from '../view/RefreshDefaultHeader';
import RefreshAnimHeader from '../view/RefreshAnimHeader';
import { RefreshConstants, RefreshState, RefreshHeaderStyle } from '../common/constants/RefreshConstants';

@Component
export default struct RefreshComponent {
    private headerStyle: RefreshHeaderStyle = RefreshHeaderStyle.DEFAULT;
    private displayHeight: number = 0;
    private listController: Scroller = new Scroller();
    private onRefresh?: () => void;
    @State headerOffset: number = 0;
    @Consume(RefreshConstants.REFRESH_STATE_TAG) state: number;
    @BuilderParam itemLayout?: () => void;

    aboutToAppear() {
        if (this.state === RefreshState.REFRESHING) {
            this.headerOffset = 0
        }
        this.displayHeight = RefreshConstants.REFRESH_HEADER_HEIGHT + Number(this.displayHeight);
    }

    build() {
        List({ scroller: this.listController }) {
            ListItem() {
                Column() {
                    if (this.headerStyle === RefreshHeaderStyle.DEFAULT) {
                        RefreshDefaultHeader()
                            .height(RefreshConstants.REFRESH_HEADER_HEIGHT)
                    } else if (this.headerStyle === RefreshHeaderStyle.CLOUD) {
                        RefreshAnimHeader()
                            .height(RefreshConstants.REFRESH_HEADER_HEIGHT)
                    }
                    if (this.itemLayout !== undefined) {
                        this.itemLayout()
                    }
                }
                .width(CommonConstants.FULL_LENGTH)
                .height(Number(this.displayHeight) + RefreshConstants.REFRESH_LAYOUT_EXTRA_HEIGHT)
            }
        }
        .edgeEffect(EdgeEffect.Spring)
        .width(CommonConstants.FULL_LENGTH)
        .height(this.displayHeight)
        .listDirection(Axis.Vertical)
        .offset({ y: this.headerOffset })

    }
}