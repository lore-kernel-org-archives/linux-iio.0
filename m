Return-Path: <SRS0=okHQ=3C=googlemail.com=martin.blumenstingl@kernel.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	linux-iio@vger.kernel.org
Cc: carlo@caione.org,
	khilman@baylibre.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/2] Meson8b support for the meson_saradc driver
Date: Sat, 25 Mar 2017 17:29:36 +0100
Message-Id: <20170325162938.28659-1-martin.blumenstingl@googlemail.com>
List-ID: <linux-iio@vger.kernel.org>

The SAR ADC register layout seems to be mostly the same on older SoCs.
Thus basically all functionality is already supported by the existing
driver.

There are two small differences though:
- the adc_clk and adc_div clock are not provided by the clock-controller
  on Meson8b. instead the SAR ADC provides an internal "adc_clk" (this
  behavior is already supported by the driver and requires no changes)
- the newer SoCs are using some register bits only the kernel or the
  BL30 (bootloader) are using the SAR ADC. This is the main change of
  this series: guarding all BL30 specific code with a corresponding
  "if"-block.

This also adds a new DT binding for the SAR ADC in Meson8b because the
driver has to specify (for this older version) that there's no BL30
integration available (and these register bits should not be touched).


Martin Blumenstingl (2):
  Documentation: dt-bindings: add a Meson8b compatible to the SAR ADC
  iio: adc: meson-saradc: add Meson8b SoC compatibility

 .../bindings/iio/adc/amlogic,meson-saradc.txt      |  1 +
 drivers/iio/adc/meson_saradc.c                     | 70 ++++++++++++++--------
 2 files changed, 47 insertions(+), 24 deletions(-)

-- 
2.12.1
