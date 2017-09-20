Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hermes.aosc.io ([199.195.250.187]:41583 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751783AbdITPSd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 20 Sep 2017 11:18:33 -0400
From: Icenowy Zheng <icenowy@aosc.io>
To: Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [RFC PATCH 0/7] AXP803 AC/Battery support
Date: Wed, 20 Sep 2017 23:18:07 +0800
Message-Id: <20170920151814.22461-1-icenowy@aosc.io>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The AXP803 PMIC, used by most Allwinner A64 boards, features 3 power inputs:
AC, USB and Battery.

This patchset adds support for the AC and Battery supplies, which is useful
for the boards from Pine64 (Pine64, SoPine w/ baseboard model A, Pinebook).

The USB supply is not yet supported in this patchset because it's not
present on Pine series boards.

In order to enable battery monitoring the ADC for battery is also enabled
for AXs.

In order to enable battery monitoring the ADC for battery is also enabled
for AXP803.

Icenowy Zheng (7):
  dt-bindings: add compatibles for AXP803 Battery/USB power supplies
  iio: adc: axp20x-adc: allow to skip ADC rate setup now
  iio: adc: axp20x-adc: add support for AXP803
  power: supply: axp20x-battery: support AXP803
  mfd: axp20x: add cells for AXP803 ADC/AC Power/Battery
  arm64: allwinner: a64: add power supply nodes in AXP803 DTSI
  arm64: allwinner: a64: enable AC and Battery for Pine64

 .../bindings/power/supply/axp20x_battery.txt       |   1 +
 .../bindings/power/supply/axp20x_usb_power.txt     |   1 +
 arch/arm64/boot/dts/allwinner/axp803.dtsi          |  15 +++
 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |   8 ++
 drivers/iio/adc/axp20x_adc.c                       | 114 ++++++++++++++++++++-
 drivers/mfd/axp20x.c                               |  11 ++
 drivers/power/supply/axp20x_battery.c              |  88 ++++++++++++++--
 7 files changed, 226 insertions(+), 12 deletions(-)

-- 
2.13.5

