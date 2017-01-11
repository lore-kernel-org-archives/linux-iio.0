Return-Path: <SRS0=Fktg=YZ=googlemail.com=martin.blumenstingl@kernel.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	khilman@baylibre.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org
Cc: carlo@caione.org,
	catalin.marinas@arm.com,
	will.deacon@arm.com,
	mturquette@baylibre.com,
	sboyd@codeaurora.org,
	narmstrong@baylibre.com,
	linux-arm-kernel@lists.infradead.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/4] Amlogic Meson SAR ADC support
Date: Wed, 11 Jan 2017 18:43:30 +0100
Message-Id: <20170111174334.24343-1-martin.blumenstingl@googlemail.com>
List-ID: <linux-iio@vger.kernel.org>

This series add support for the SAR ADC on Amlogic Meson GXBB, GXL and
GXM SoCs.
The hardware on GXBB provides 10-bit ADC results, while GXL and GXM are
providing 12-bit results. Support for older SoCs (Meson8b and Meson8)
can be added with little effort, most of which is testing I guess (I
don't have any pre-GXBB hardware so I can't say).

A new set of clocks had to be added to the GXBB clock controller (used
by the GXBB/GXL/GXM SoCs) which are required to get the ADC working.

The ADC itself can sample multiple channels at the same time and allows
capturing multiple samples (which can be used for filtering/averaging).
The ADC results are stored inside a FIFO register. More details on what
the driver supports (or doesn't) can be found in the description of
patch #3.

The code is based on the public S805 (Meson8b) and S905 (GXBB)
datasheets, as well as by reading (various versions of) the vendor
driver and by inspecting the registers on the vendor kernels of my
testing-hardware.

Typical use-cases for the ADC on the Meson GX SoCs are:
- adc-keys ("ADC attached resistor ladder buttons")
- SoC temperature measurement (not supported by this driver yet as
  the system firmware does this already and provides the values via the
  SCPI protocol)
- "version-strapping" (different resistor values are used to indicate
  the board-revision)
- and of course typical ADC measurements


Martin Blumenstingl (4):
  Documentation: dt-bindings: add the Amlogic Meson SAR ADC
    documentation
  clk: gxbb: add the SAR ADC clocks and expose them
  iio: adc: add a driver for the SAR ADC found in Amlogic Meson SoCs
  ARM64: dts: meson: meson-gx: add the SAR ADC

 .../bindings/iio/adc/amlogic,meson-saradc.txt      |  31 +
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi          |   8 +
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |  10 +
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         |  10 +
 drivers/clk/meson/gxbb.c                           |  48 ++
 drivers/clk/meson/gxbb.h                           |   9 +-
 drivers/iio/adc/Kconfig                            |  12 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/meson_saradc.c                     | 860 +++++++++++++++++++++
 include/dt-bindings/clock/gxbb-clkc.h              |   4 +
 10 files changed, 990 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
 create mode 100644 drivers/iio/adc/meson_saradc.c

-- 
2.11.0
