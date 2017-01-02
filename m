Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:42730 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933418AbdABQiA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Jan 2017 11:38:00 -0500
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, sre@kernel.org, linux@armlinux.org.uk,
        maxime.ripard@free-electrons.com, lee.jones@linaro.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        thomas.petazzoni@free-electrons.com, icenowy@aosc.xyz,
        bonbons@linux-vserver.org
Subject: [PATCH 00/22] add support for AXP20X and AXP22X power supply drivers
Date: Mon,  2 Jan 2017 17:37:00 +0100
Message-Id: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
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

[RFC]
I want to take this series of patch as an opportunity to ask what we should
do with the OCV curves.

A battery voltage does not decrease linearly but decreases slowly near
maximum and minimal voltage and quickly most of the time.
By taking raw values without an OCV curve, the battery percentage (or
often wrongly named "capacity") is computed by approximating by a linear
function. This results in battery percentage not lasting the same
depending if the battery is full, almost empty or within those two
states. For example, a decrease of 40 points could take as much time as
a decrease of 5 points when in low battery. Without an OCV curve, the
battery percentage returned by the battery driver (as it is done today)
is absolute non-sense.
When an OCV curve is provided, the percentage is approximated by this
OCV curve and battery percentage are very more likely to last the same
time and thus, being trustworthy.

While I understand the kernel has absolutely nothing to do with OCV
computation, the AXP20X/AXP22X PMICs raise a question due to their
ability to compute the approximated battery percentage if we give them
the OCV curve of the battery in some of their registers. No computing
has to be done in the kernel, we just have to give them the OCV curve of
the battery and the PMIC will return the approximated percentage.

The question is how to do it? IMHO, two different approaches are possible:

 - give the OCV curve points in the Device Tree,
   This allows the OCV curve to be fixed for boards with a non-removable
   battery. However, it also avoids changing batteries without
   recompiling the DT, which is definitely not end-user friendly.
   The DT is here for hardware definition and battery is hardware
   definition I guess, so it makes sense in a way, but it does not work
   for removable batteries.

 - give the OCV curve points via the POWER_SUPPLY_PROP_VOLTAGE_OCV sysfs
 entry in the Power Supply framework,
   This allows the OCV curve to be changed when a user switches the
   batteries, but it also means that the OCV curve will always have to
   be submitted by a small boot script which means it is
   rootfs-dependent. Not really cool for a hardware component which in
   embedded systems is more than likely not to change (IMHO).

Maybe, the best would be the two approaches at the same time: the
OCV curve of the default battery in the DT and the possibility to modify
the OCV curve via the POWER_SUPPLY_PROP_VOLTAGE_OCV sysfs entry?

Thanks,
Quentin

Quentin Schulz (22):
  dt-bindings: iio: adc: add AXP20X/AXP22X ADC DT binding
  mfd: axp20x: add ADC data regs to volatile regs for AXP22X
  iio: adc: add support for X-Powers AXP20X and AXP22X PMICs ADCs
  mfd: axp20x: add ADC cells for AXP20X and AXP22X PMICs
  ARM: dtsi: axp209: add AXP209 ADC subnode
  ARM: dtsi: axp22x: add AXP22X ADC subnode
  dt-bindings: power: supply: add AXP20X/AXP22X AC power supply
  power: supply: add AC power supply driver for AXP20X and AXP22X PMICs
  mfd: axp20x: add AC power supply cells for AXP22X PMICs
  ARM: dtsi: axp209: add AC power supply subnode
  ARM: dtsi: axp22x: add AC power supply subnode
  ARM: dts: sun8i: sina33: enable ACIN power supply subnode
  ARM: sun5i: chip: enable ACIN power supply subnode
  dt-bindings: power: supply: add AXP20X/AXP22X battery DT binding
  mfd: axp20x: add CHRG_CTRL1 to writeable regs for AXP20X/AXP22X
  mfd: axp20x: add V_OFF to writeable regs for AXP20X and AXP22X
  power: supply: add battery driver for AXP20X and AXP22X PMICs
  mfd: axp20x: add MFD cells for AXP20X and AXP22X battery driver
  ARM: dtsi: axp209: add battery power supply subnode
  ARM: dtsi: axp22x: add battery power supply subnode
  ARM: dts: sun8i: sina33: enable battery power supply subnode
  ARM: sun5i: chip: enable battery power supply subnode

 .../devicetree/bindings/iio/adc/axp20x_adc.txt     |  24 +
 .../bindings/power/supply/axp20x_ac_power.txt      |  27 ++
 .../bindings/power/supply/axp20x_battery.txt       |  24 +
 arch/arm/boot/dts/axp209.dtsi                      |  19 +
 arch/arm/boot/dts/axp22x.dtsi                      |  17 +
 arch/arm/boot/dts/sun5i-r8-chip.dts                |   8 +
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts     |   8 +
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/axp20x_adc.c                       | 490 +++++++++++++++++++++
 drivers/mfd/axp20x.c                               |  35 +-
 drivers/power/supply/Kconfig                       |  24 +
 drivers/power/supply/Makefile                      |   2 +
 drivers/power/supply/axp20x_ac_power.c             | 251 +++++++++++
 drivers/power/supply/axp20x_battery.c              | 458 +++++++++++++++++++
 include/linux/mfd/axp20x.h                         |   4 +
 16 files changed, 1400 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
 create mode 100644 drivers/iio/adc/axp20x_adc.c
 create mode 100644 drivers/power/supply/axp20x_ac_power.c
 create mode 100644 drivers/power/supply/axp20x_battery.c

-- 
2.9.3

