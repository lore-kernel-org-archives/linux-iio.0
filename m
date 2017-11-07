Return-Path: <SRS0=j25b=CF=amlogic.com=Yixun.Lan@kernel.org>
From: Yixun Lan <yixun.lan@amlogic.com>
To: Neil Armstrong <narmstrong@baylibre.com>, Jerome Brunet
	<jbrunet@baylibre.com>, <devicetree@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>, Carlo Caione
	<carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, Yixun Lan
	<yixun.lan@amlogic.com>, Xingyu Chen <xingyu.chen@amlogic.com>,
	<linux-amlogic@lists.infradead.org>, <linux-iio@vger.kernel.org>,
	<linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/4] fix the clock setting for SAR ADC
Date: Tue, 7 Nov 2017 22:09:42 +0800
Message-ID: <20171107140942.29243-1-yixun.lan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

patch [1/4]:
  Fix wrong SARADC/SANA clock gate bit in Meson-GXBB/GXL,
the published datasheets[4] also has wrong description about this.
  This patch should be explicitly merged *before* other patches.

patch [2-4/4]:
  Drop the "sana" clock from SAR ADC module,

  From the hardware perspective, the SAR ADC module doesn't
require "sana" clock to wrok. This should apply to all SoC,
including meson6,8, GXBB, GXL..

Note: the whole patchset series has been tested at GXL-P212 board,
we haven't got any meson6,8 board to test, so I would appreciate
if someone (Martin?) could help to confirm it works there.

Changes since v3 at [3] :
  - fix the missing iio maintainers for patch[2/4]
  - add warning about the dependency, the patch[1/4] should go first
  - update comments

Changes since v2 at [2] :
  - explicitly point out 'sana' clock is not required for saradc, and drop them
  - update comments, as the published datasheet is wrong
 
Changes since v1 at [1] :
  - correct SAR ADC/SANA clock gate bit

[1] http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005221.html

[2] http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005242.html

[3] http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005252.html
    http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005257.html
    http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005253.html
    http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005254.html
    http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005255.html


[4] GXBB v1.1.4, page 57
      http://dn.odroid.com/S905/DataSheet/S905_Public_Datasheet_V1.1.4.pdf
    GXL v0.3_20170314
      http://www.mediafire.com/file/5bpt054va5ut7v9/S905X_Datasheet_V0.3_20170314publicversion-Wesion.pdf


Xingyu Chen (3):
  iio: adc: meson-saradc: remove irrelevant clock "sana"
  dt-bindings: iio: adc: update the doc for SAR ADC
  ARM64: dts: meson: drop "sana" clock from SAR ADC

Yixun Lan (1):
  clk: meson: gxbb: fix wrong clock for SARADC/SANA

 .../bindings/iio/adc/amlogic,meson-saradc.txt        |  1 -
 arch/arm/boot/dts/meson8.dtsi                        |  5 ++---
 arch/arm/boot/dts/meson8b.dtsi                       |  5 ++---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi          |  3 +--
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi           |  3 +--
 drivers/clk/meson/gxbb.c                             |  4 ++--
 drivers/iio/adc/meson_saradc.c                       | 20 --------------------
 7 files changed, 8 insertions(+), 33 deletions(-)

-- 
2.14.1
