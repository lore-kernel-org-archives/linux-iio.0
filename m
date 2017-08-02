Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.134]:34611 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751066AbdHBIZd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Aug 2017 04:25:33 -0400
From: Andy Yan <andy.yan@rock-chips.com>
To: heiko@sntech.de
Cc: linus.walleij@linaro.org, linux-pwm@vger.kernel.org,
        robh+dt@kernel.org, david.wu@rock-chips.com,
        shawn.lin@rock-chips.com, linux-i2c@vger.kernel.org,
        zhangqing@rock-chips.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, mturquette@baylibre.com,
        sboyd@codeaurora.org, wsa@the-dreams.de,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-spi@vger.kernel.org,
        Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v2 00/23] Support more devices on rockchip rv1108
Date: Wed,  2 Aug 2017 16:25:03 +0800
Message-Id: <1501662303-11687-1-git-send-email-andy.yan@rock-chips.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


This series try to support i2c/spi/pwm/saradc/pmic/watchdog and
the full clk tree on rockchip rv1108 soc.

Changes in v2:
- split the rename and intentation fix part from id patch
- split the new added clks and rename.
- add compatible string "rockchip,rv1108-pwm"
- add compatible string "rockchip,rv1108-saradc"

Andy Yan (14):
  pinctrl: rockchip: add schmitt input mode support for rv1108
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

Elaine Zhang (9):
  clk: rockchip: add more clk ids for rv1108
  clk: rockchip: rename the clk id for HCLK_I2S1_2CH
  clk: rockchip: fix up the indentation stuff for RV1108 SoC
  clk: rockchip: support more rates for cpuclk
  clk: rockchip: fix up the pll clks error for rv1108 SoC
  clk: rockchip: support more clks for rv1108
  clk: rockchip: fix up some clks describe error for rv1108 SoC
  clk: rockchip: rename some of clks for rv1108 SoC
  clk: rockchip: add some critical clocks for rv1108 SoC

 Documentation/devicetree/bindings/i2c/i2c-rk3x.txt |   1 +
 .../bindings/iio/adc/rockchip-saradc.txt           |   1 +
 .../devicetree/bindings/pwm/pwm-rockchip.txt       |   2 +-
 .../devicetree/bindings/spi/spi-rockchip.txt       |   1 +
 arch/arm/boot/dts/rv1108-evb.dts                   | 158 +++++++
 arch/arm/boot/dts/rv1108.dtsi                      | 249 ++++++++++
 drivers/clk/rockchip/clk-rv1108.c                  | 514 ++++++++++++++++-----
 drivers/i2c/busses/i2c-rk3x.c                      |   9 +
 drivers/pinctrl/pinctrl-rockchip.c                 |  31 ++
 drivers/spi/spi-rockchip.c                         |   1 +
 include/dt-bindings/clock/rv1108-cru.h             | 123 ++++-
 11 files changed, 964 insertions(+), 126 deletions(-)

-- 
2.7.4


