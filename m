Return-Path: <SRS0=Ck17=NI=googlemail.com=martin.blumenstingl@kernel.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	robh+dt@kernel.org,
	pmeerw@pmeerw.net,
	lars@metafoo.de,
	knaack.h@gmx.de,
	jic23@kernel.org
Cc: khilman@baylibre.com,
	carlo@caione.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/7] meson-saradc: add chip temperature support
Date: Sun, 28 Oct 2018 13:26:22 +0100
Message-Id: <20181028122629.10144-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

The meson-saradc allows switching the input of channel #6 between an
actual ADC pad and the SoC's internal temperature sensor.

On the 64-bit SoCs the SCPI firmware reads the chip temperature using
the SAR ADC. Thus the 64-bit SoCs simply expose the temperature through
the "arm,scpi-sensors" interface (and so Linux doesn't have to program
the SAR ADC for temperature readings).

The 32-bit SoCs however don't have any SCPI firmware. Thus we need to
configure the SAR ADC in Linux to get the chip temperature. To make it
work we need two changes to the existing dt-bindings:
- we have to get the TSC (temperature sensor calibration coefficient)
  from the eFuse (where it has been programmed to the correct value in
  the manufacturing process). the SAR ADC needs the TSC value, otherwise
  it returns only garbage readings
- we need to get a phandle to the new HHI syscon region because on
  Meson8b and Meson8m2 the TSC is five bits wide (on Meson8 it's only
  four bits wide) but only four bits are stored inside the SAR ADC's
  memory region. The upper most bit (not all five bits, only one out of
  five) is stored at a seemingly random register HHI_DPLL_TOP_0) in the
  HHI register area.

Dependencies: The SAR ADC changes are completely independent from
anything else. However, the arch/arm/boot/dts changes from this series
depend on my other series "Meson8/Meson8b: introduce a HHI syscon node"
from [0]. I decided to send them all together to give a better overview
how the end result looks like - I can split the dts changes into a
separate series when requested (in any case I would like Kevin to take
them through his linux-amlogic tree).


[0] https://patchwork.kernel.org/cover/10658527/


Martin Blumenstingl (7):
  dt-bindings: iio: adc: meson-saradc: add temperature sensor support
  iio: adc: meson-saradc: add support for the chip's temperature sensor
  ARM: dts: meson8: add the temperature calibration data for the SAR ADC
  ARM: dts: meson8b: add the temperature calibration data for the SAR
    ADC
  ARM: dts: meson8b: ec100: add iio-hwmon for the chip temperature
  ARM: dts: meson8b: odroidc1: add iio-hwmon for the chip temperature
  ARM: dts: meson8m2: mxiii-plus: add iio-hwmon for the chip temperature

 .../bindings/iio/adc/amlogic,meson-saradc.txt |  10 +
 arch/arm/boot/dts/meson8.dtsi                 |   8 +
 arch/arm/boot/dts/meson8b-ec100.dts           |   5 +
 arch/arm/boot/dts/meson8b-odroidc1.dts        |   5 +
 arch/arm/boot/dts/meson8b.dtsi                |   8 +
 arch/arm/boot/dts/meson8m2-mxiii-plus.dts     |   5 +
 drivers/iio/adc/meson_saradc.c                | 274 ++++++++++++++++--
 7 files changed, 289 insertions(+), 26 deletions(-)

-- 
2.19.1
