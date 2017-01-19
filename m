Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33250 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753207AbdASO6w (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Jan 2017 09:58:52 -0500
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        khilman@baylibre.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org
Cc: carlo@caione.org, catalin.marinas@arm.com, will.deacon@arm.com,
        mturquette@baylibre.com, sboyd@codeaurora.org,
        narmstrong@baylibre.com, linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 0/4] Amlogic Meson SAR ADC support
Date: Thu, 19 Jan 2017 15:58:18 +0100
Message-Id: <20170119145822.26239-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20170115224221.15510-1-martin.blumenstingl@googlemail.com>
References: <20170115224221.15510-1-martin.blumenstingl@googlemail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

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

Thanks to Heiner Kallweit, Jonathan Cameron, Lars-Peter Clausen and
Peter Meerwald-Stadler for reviewing this series and providing valuable
input!

Changes since v2 (all changes are for patch #3, except where noted):
- fixed another typo in the interrupt (patch #4, thanks again Heiner
  Kallweit)
- change namespace of all register #defines to MESON_SAR_ADC (I
  intentionally decided to keep SAR_ADC in it because that's the way
  registers are named in the datasheet, thus making it easy to match the
  registers without having to look up the offset all the time)
- added additional parenthesis around MACRO parameters  for extra safety
- removed unused definition for SAR_ADC_REG3_ADC_CLK_DIV_MASK (as we
  already have SAR_ADC_REG3_ADC_CLK_DIV_SHIFT and
  SAR_ADC_REG3_ADC_CLK_DIV_WIDTH which are used instead)
- change value of "indexed" from "true" to "1"
- remove type parameter from MESON_SAR_ADC_CHAN macro as all channels are
  currently IIO_VOLTAGE channels
- fixed another multi-line comment style violation
- added timeout to meson_saradc_lock() (unlikely to be triggered, but
  better safe then sorry - which would mean that we'd be keeping one core
  busy infinitely)
- fixed meson_saradc_remove() call order (first unregister the iio_dev,
  then disable the hardware instead of the other way around)
- use "consistent prefixing", which means that all #defines now use
  MESON_SAR_ADC_ as prefix, while all enums, static global variables,
  structs and functions use meson_sar_adc_ as prefix
- rebased .dts and clk patches to apply to khilman's latest v4.11/dt64
  (a minor  conflict had to be resolved in the clk patch due to
  "clk: meson-gxbb: Export HDMI clocks")
- added Tested-by: Neil Armstrong <narmstrong@baylibre.com> to all
  patches (thanks for testing!)

Changes since v1 (all changes are for patch #3, except where noted):
- fix IRQ number in meson-gx.dtsi (thanks to Heiner Kallweit for
  providing the correct value), affects patch #4
- move the most used members of meson_saradc_priv to the beginning
- remove unused struct member "completion" from meson_saradc_priv
- use devm_kasprintf() instead of snprintf() + devm_kstrdup()
- initialize indio_dev->dev.parent earlier in meson_saradc_probe()
- moved meson_saradc_clear_fifo() logic to a separate function
- add comment why a do ... while loop is required in
  meson_saradc_wait_busy_clear()
- remove SAR_ADC_NUM_CHANNELS and SAR_ADC_VALUE_MASK macros (each of them
  was only used once and it's an unneeded level of abstraction)
- fixed multiline comment syntax violations
- dropped unneeded log messages during initialization
- set iio_dev name to "meson-gxbb-saradc" or "meson-gxl-saradc"
- use "indio_dev->dev.parent" in all kernel log calls (dev_warn/err/etc)
  to make it show the OF node name (instead of the iio device name)
- introduce struct meson_saradc_data to hold platform-specific
  information (such as resolution in bits and the iio_dev name)


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
 drivers/iio/adc/meson_saradc.c                     | 916 +++++++++++++++++++++
 include/dt-bindings/clock/gxbb-clkc.h              |   4 +
 10 files changed, 1046 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
 create mode 100644 drivers/iio/adc/meson_saradc.c

-- 
2.11.0

