Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.130]:48345 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751306AbdCXK7h (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Mar 2017 06:59:37 -0400
From: <cl@rock-chips.com>
To: heiko@sntech.de
Cc: robh+dt@kernel.org, mark.rutland@arm.com, zhengxing@rock-chips.com,
        andy.yan@rock-chips.com, jay.xu@rock-chips.com,
        matthias.bgg@gmail.com, paweljarosz3691@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsa@the-dreams.de, linux-i2c@vger.kernel.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        wxt@rock-chips.com, david.wu@rock-chips.com,
        linux-iio@vger.kernel.org, shawn.lin@rock-chips.com,
        akpm@linux-foundation.org, dianders@chromium.org,
        yamada.masahiro@socionext.com, catalin.marinas@arm.com,
        will.deacon@arm.com, afaerber@suse.de, shawnguo@kernel.org,
        khilman@baylibre.com, arnd@arndb.de, fabio.estevam@nxp.com,
        zhangqing@rock-chips.com, kever.yang@rock-chips.com,
        tony.xie@rock-chips.com, huangtao@rock-chips.com,
        yhx@rock-chips.com, rocky.hao@rock-chips.com,
        Liang Chen <cl@rock-chips.com>
Subject: [PATCH v3 0/6] initialize dtsi file and dts file for RK3328 SoCs
Date: Fri, 24 Mar 2017 19:01:21 +0800
Message-Id: <1490353287-25122-1-git-send-email-cl@rock-chips.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Liang Chen <cl@rock-chips.com>

Changes in v3:
    Adjust some descriptions in dtsi.

Changes in v2:
    Remove RK_FUNC_* in dtsi as it dose not help understand things better.
    Adjust the order of description in dt-bindings.

v1:
These patchs depend on pinctrl patchs as below:

https://patchwork.kernel.org/patch/9566427/
https://patchwork.kernel.org/patch/9566425/
https://patchwork.kernel.org/patch/9566431/

Liang Chen (6):
  dt-bindings: iio: rockchip-saradc: add support for rk3328
  dt-bindings: i2c: rk3x: add support for rk3328
  dt-bindings: soc: rockchip: grf: add support for rk3328
  arm64: dts: rockchip: add core dtsi file for RK3328 SoCs
  arm64: dts: rockchip: add dts file for RK3328
  dt-bindings: document rockchip rk3328-evb board

 Documentation/devicetree/bindings/arm/rockchip.txt |    4 +
 Documentation/devicetree/bindings/i2c/i2c-rk3x.txt |    1 +
 .../bindings/iio/adc/rockchip-saradc.txt           |    1 +
 .../devicetree/bindings/soc/rockchip/grf.txt       |    1 +
 arch/arm64/boot/dts/rockchip/Makefile              |    1 +
 arch/arm64/boot/dts/rockchip/rk3328-evb.dts        |   57 +
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           | 1286 ++++++++++++++++++++
 7 files changed, 1351 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-evb.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3328.dtsi

-- 
1.9.1


