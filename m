Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34014 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbeKDIXQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Nov 2018 03:23:16 -0500
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, robh+dt@kernel.org, pmeerw@pmeerw.net,
        lars@metafoo.de, knaack.h@gmx.de, jic23@kernel.org
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 0/2] meson-saradc: add chip temperature support
Date: Sun,  4 Nov 2018 00:10:22 +0100
Message-Id: <20181103231024.659-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

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
  This also requires changes to the clock controller where we don't have
  a solution where everyone's happy with the dt-bindings (see the
  discussion in [0]) - so this will be added in a future series.


changes since v1 at [1]:
- (many thanks to Peter Meerwald-Stadler and Jonathan Cameron for taking
  the time to review my patches)
- use "MESON_SAR_ADC_" as naming schema for two new #defines
- remove .indexed = 0 (because it's already the default) from
  MESON_SAR_ADC_TEMP_CHAN
- simplify setting MESON_SAR_ADC_DELTA_10_TEMP_SEL in
  meson_sar_adc_enable_channel
- remove IIO_CHAN_INFO_ENABLE (abuse) from MESON_SAR_ADC_TEMP_CHAN
- register the channel set depending on whether the temperature sensor
  can be used or not (instead of exposing the info whether it can be
  used through the "ENABLE" element)
- shorten check for MESON_SAR_ADC_EFUSE_BYTE3_IS_CALIBRATED
- dropped Meson8b and Meson8m2 support for now (see the HHI register
  discussion mentioned above). I still plan to add support for these
  SoCs, but I don't want to add any code to the SAR ADC driver before
  we have a decision on the dt-bindings of the clock driver (where we
  need to write one bit from the SAR ADC driver for the temperature
  sensor calibration coefficient).
- dropped the .dts changes for now since the useful part was adding
  iio-hwmon on Meson8b and Meson8m2 boards. now that support for these
  two SoCs is postponed we can wait with the .dts changes as well.


[0] https://patchwork.kernel.org/cover/10658527/
[1] https://patchwork.kernel.org/cover/10658551/


Martin Blumenstingl (2):
  dt-bindings: iio: adc: meson-saradc: add temperature sensor support
  iio: adc: meson-saradc: add support for the chip's temperature sensor

 .../bindings/iio/adc/amlogic,meson-saradc.txt |   6 +
 drivers/iio/adc/meson_saradc.c                | 229 ++++++++++++++++--
 2 files changed, 209 insertions(+), 26 deletions(-)

-- 
2.19.1
