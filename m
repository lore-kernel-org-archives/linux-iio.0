Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35552 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750773AbdEFNt6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 May 2017 09:49:58 -0400
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org
Cc: carlo@caione.org, khilman@baylibre.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, thomas.langer@intel.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v4 0/3] Meson8 / Meson8b support for the meson_saradc driver
Date: Sat,  6 May 2017 15:49:26 +0200
Message-Id: <20170506134929.31190-1-martin.blumenstingl@googlemail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

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

This also adds a new DT binding for the SAR ADC in Meson8 and Meson8b
because the driver has to specify (for this older version) that there's
no BL30 integration available (and these register bits should not be
touched).

Changes since v3 at [2]:
- the patch that should make the meson_sar_adc_data instances static and
  const only made them static (but not const). thanks to Thomas Langer
  for spotting this. note: this affects patch #1 and #3 (as in #3 there
  are more meson_sar_adc_data instances introduced which were copied from
  the ones in patch #1).

Changes since v2 at [1]:
- re-ordered patches so patch #1 now adds the "static" modifier to the
  existing meson_sar_adc_data instances (was patch #3, now patch #1)
- dropped the "Documentation: " prefix from the devicetree
  documentation patch (patch #2)
- added Rob's ACK to the devicetree Documentation patch (patch #2)
- fixed a copy-and-paste error in the actual driver change (both,
  in the commit message where I claimed that a of_device_id was only
  added for Meson8b as well as in the driver code itself where the Meson8
  meson_sar_adc_data.name was "meson-meson8b-saradc")

Changes since v1 at [0]:
- switched to bool data-type for has_bl30_integration
- also added a "compatible" for Meson8 SoCs (the ADC driver from
  Amlogic's GPL kernel sources handles Meson8 and Meson8b identical)
- added patch #3 to constify some structs (there were supposed to be
  const from the very beginning)


[0] http://lists.infradead.org/pipermail/linux-amlogic/2017-March/003081.html
[1] http://lists.infradead.org/pipermail/linux-amlogic/2017-April/003394.html
[2] http://lists.infradead.org/pipermail/linux-amlogic/2017-May/003439.html

Martin Blumenstingl (3):
  iio: adc: meson-saradc: mark all meson_sar_adc_data static and const
  dt-bindings: iio: adc: add Meson8 and Meson8b support
  iio: adc: meson-saradc: add Meson8b SoC compatibility

 .../bindings/iio/adc/amlogic,meson-saradc.txt      |  2 +
 drivers/iio/adc/meson_saradc.c                     | 86 +++++++++++++++-------
 2 files changed, 61 insertions(+), 27 deletions(-)

-- 
2.12.2

