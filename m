Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:46376 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932184AbdA0JB4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Jan 2017 04:01:56 -0500
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        sre@kernel.org, linux@armlinux.org.uk,
        maxime.ripard@free-electrons.com, lee.jones@linaro.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        thomas.petazzoni@free-electrons.com, icenowy@aosc.xyz,
        bonbons@linux-vserver.org
Subject: [PATCH v2 00/25] add support for AXP20X and AXP22X power supply drivers
Date: Fri, 27 Jan 2017 09:54:33 +0100
Message-Id: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The X-Powers AXP20X and AXP22X PMICs have multiple ADCs. They expose
information and data of the various power supplies they support such as
ACIN, battery and VBUS. For example, they expose the current battery
voltage, charge or discharge, as well as ACIN and VBUS current voltages
and currents, internal PMIC temperature and ADC on 2 different GPIOs
when in the right mode (for the AXP209 only).

The ACIN power supply driver is added by this patch. The AXP20X and
AXP22X can both read the status and the "usability" of the power supply
but only the AXP209 will be able to tell the current current and voltage
of the power supply by reading ADC channels. It is simply not supported
by the AXP22X PMICs.

The battery power supply driver is also added by this patch. The AXP20X
and AXP22X share most of their behaviour but have slight variations. The
allowed target voltages for battery charging are not the same, the
AXP22X PMIC are able to tell if the battery percentage computed by the
PMIC is trustworthy and they have different formulas for computing max
current for battery power supply. The driver is able to give the current
voltage and current of the battery (be it charging or discharging), the
maximal and minimal voltage and maximal current allowed for the battery,
whether the battery is present and usable and its capacity. It will get
the battery current current and voltage by reading the ADC channels. The
PMIC allows maximal voltages (4.36V for AXP20X and 4.22V and 4.24V for
AXP22X) that should not be used with Lithium-based batteries and since
this PMIC is supposed to be used with Lithium-based batteries, they have
been disabled. The values returned by the ADC driver are multipled by
1000 to scale from the mV returned by the ADC to the uV expected by the
power supply framework.

This series of patch adds DT bindings for ACIN power supply, ADC and
battery power supply drivers for AXP20X and AXP22X PMICs and their
documentation. It also enables the supported power supplies for the
Nextthing Co. CHIP and Sinlinx SinA33 boards.

The different drivers are also added to the MFD cells of the AXP20X and
AXP22X cells and the writeable and volatile regs updated to work with
the newly added drivers.

VBUS driver has intentionally not been modified to use the ADC channels
because a DT binding already exists for this driver. Migrating the
driver would mean to add an iio_map to map the ADC channels to the VBUS
driver (so we can use iio_channel_get and iio_read_channel_processed
functions). This slightly complexifies the VBUS driver only for
"cosmetic" changes. Feel free to give your two cents on the matter.

This series of patch is based on a previous upstreaming attempt done by
Bruno Prémont few months ago. It differs in three points: the ADC
driver does not tell the battery temperature (TS_IN) as I do not have a
board to test it with, it does not tell the instantaneous battery power
as it returns crazy values for me and finally no support for OCV curves
for the battery.

You can test these patches from this repo and branch:
https://github.com/QSchulz/linux/tree/axp2xx_adc_batt_ac_v2

v2:
 - Some registers' name have been changed to better reflect their
 purpose,
 - Make VBUS power supply driver use IIO channels when AXP ADC driver is
 enabled, but fall back on previous behavior when disabled. This is made
 to avoid the ADC driver overwritting registers for VBUS power supply
 ADC when removed,
 - Removed useless adding of data registers to volatile registers,
 - Reordered IIO channels, now grouped by same part of the PMIC (e.g.
 voltage and current of the battery have the same index in different
 IIO types),
 - Added structures for specific data instead of matching on IDs,
 - Switched from DT IIO channels mapping to iio_map structures IIO
 channels mapping,

Quentin

Quentin Schulz (25):
  dt-bindings: iio: adc: add AXP20X/AXP22X ADC DT binding
  mfd: axp20x: correct name of temperature data ADC registers
  power: supply: axp20x_usb_power: use IIO channels when available
  iio: adc: add support for X-Powers AXP20X and AXP22X PMICs ADCs
  mfd: axp20x: add ADC cells for AXP20X and AXP22X PMICs
  ARM: dtsi: axp209: add AXP209 ADC subnode
  ARM: dtsi: axp22x: add AXP22X ADC subnode
  dt-bindings: power: supply: add AXP20X/AXP22X AC power supply
  iio: adc: axp20x_adc: map acin_i and acin_v
  power: supply: add AC power supply driver for AXP20X and AXP22X PMICs
  mfd: axp20x: add AC power supply cells for AXP22X PMICs
  ARM: dtsi: axp209: add AC power supply subnode
  ARM: dtsi: axp22x: add AC power supply subnode
  ARM: dts: sun8i: sina33: enable ACIN power supply subnode
  ARM: sun5i: chip: enable ACIN power supply subnode
  dt-bindings: power: supply: add AXP20X/AXP22X battery DT binding
  mfd: axp20x: add CHRG_CTRL1/2/3 to writeable regs for AXP20X/AXP22X
  mfd: axp20x: add V_OFF to writeable regs for AXP20X and AXP22X
  iio: adc: axp20x_adc: map battery IIO channels
  power: supply: add battery driver for AXP20X and AXP22X PMICs
  mfd: axp20x: add MFD cells for AXP20X and AXP22X battery driver
  ARM: dtsi: axp209: add battery power supply subnode
  ARM: dtsi: axp22x: add battery power supply subnode
  ARM: dts: sun8i: sina33: enable battery power supply subnode
  ARM: sun5i: chip: enable battery power supply subnode

 .../devicetree/bindings/iio/adc/axp20x_adc.txt     |  22 +
 .../bindings/power/supply/axp20x_ac_power.txt      |  22 +
 .../bindings/power/supply/axp20x_battery.txt       |  25 +
 arch/arm/boot/dts/axp209.dtsi                      |  14 +
 arch/arm/boot/dts/axp22x.dtsi                      |  14 +
 arch/arm/boot/dts/sun5i-r8-chip.dts                |   8 +
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts     |   8 +
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/axp20x_adc.c                       | 609 +++++++++++++++++++++
 drivers/mfd/axp20x.c                               |  36 +-
 drivers/power/supply/Kconfig                       |  24 +
 drivers/power/supply/Makefile                      |   2 +
 drivers/power/supply/axp20x_ac_power.c             | 250 +++++++++
 drivers/power/supply/axp20x_battery.c              | 477 ++++++++++++++++
 drivers/power/supply/axp20x_usb_power.c            |  70 ++-
 include/linux/mfd/axp20x.h                         |   4 +-
 17 files changed, 1587 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
 create mode 100644 drivers/iio/adc/axp20x_adc.c
 create mode 100644 drivers/power/supply/axp20x_ac_power.c
 create mode 100644 drivers/power/supply/axp20x_battery.c

-- 
2.9.3

