Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.134]:52661 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751550AbdHKDgu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Aug 2017 23:36:50 -0400
From: Andy Yan <andy.yan@rock-chips.com>
To: heiko@sntech.de
Cc: robh+dt@kernel.org, linux-pwm@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        wsa@the-dreams.de, linux-arm-kernel@lists.infradead.org,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v3 00/13] Support more devices on rockchip rv1108
Date: Fri, 11 Aug 2017 11:36:18 +0800
Message-Id: <1502422578-30611-1-git-send-email-andy.yan@rock-chips.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This series try to support i2c/spi/pwm/saradc/pmic/watchdog
on rockchip rv1108 soc.

As the clk tree part has been taken from Elaine's series, so
this part will be not included in my series from this version.

This version has no more changes, except the pwm  dt-bindings
followed by Rob's suggestion, and the Acked-by from Rob of other
dt-bindings.

Changes in v3:
- remove the clk tree part
- make the compatible string be: "rockchip,rv1108-pwm", "rockchip,rk3288-pwm"
  for rv1108 pwm

Changes in v2:
- add compatible string "rockchip,rv1108-pwm"
- add compatible string "rockchip,rv1108-saradc"

Andy Yan (13):
  dt-bindings: i2c: rk3x: add support for rv1108
  i2c: rk3x: add support for rv1108
  ARM: dts: rockchip: add i2c dt node for rv1108
  spi: rockchip: add compatible string for rv1108 spi
  ARM: dts: rockchip: add spi dt node for rv1108
  dt-bindings: pwm: add description for rv1108 pwm
  ARM: dts: rockchip: add pwm dt node for rv1108
  ARM: dts: rockchip: add watchdog dt node for rv1108
  dt-bindings: adc: add description for rv1108 saradc
  ARM: dts: rockchip: add saradc support for rv1108
  ARM: dts: rockchip: add pwm backlight for rv1108 evb
  ARM: dts: rockchip: add pmic rk805 dt node for rv1108 evb
  ARM: dts: rockchip: add accelerometer bma250e dt node for rv1108 evb

 Documentation/devicetree/bindings/i2c/i2c-rk3x.txt |   1 +
 .../bindings/iio/adc/rockchip-saradc.txt           |   1 +
 .../devicetree/bindings/pwm/pwm-rockchip.txt       |   3 +-
 .../devicetree/bindings/spi/spi-rockchip.txt       |   1 +
 arch/arm/boot/dts/rv1108-evb.dts                   | 158 +++++++++++++
 arch/arm/boot/dts/rv1108.dtsi                      | 249 +++++++++++++++++++++
 drivers/i2c/busses/i2c-rk3x.c                      |   9 +
 drivers/spi/spi-rockchip.c                         |   1 +
 8 files changed, 422 insertions(+), 1 deletion(-)

-- 
2.7.4


