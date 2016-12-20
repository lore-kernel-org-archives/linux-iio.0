Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:34631 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934730AbcLTK2Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Dec 2016 05:28:24 -0500
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, wens@csie.org,
        lee.jones@linaro.org, linux@armlinux.org.uk,
        stefan.mavrodiev@gmail.com
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@free-electrons.com
Subject: [PATCH 0/7] add CPU thermal throttling to Allwinner A33 SoC
Date: Tue, 20 Dec 2016 11:27:02 +0100
Message-Id: <20161220102709.9504-1-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The Allwinner SoCs all have an ADC that can also act as a touchscreen
controller and a thermal sensor. The first four channels can be used
either for the ADC or the touchscreen and the fifth channel is used for
the thermal sensor. We currently have a driver for the two latter
functions in drivers/input/touchscreen/sun4i-ts.c but we don't have
access to the ADC feature at all. It is meant to replace the current
driver by using MFD and subdrivers.

The Allwinner A33 only has a thermal sensor present in the GPADC. In
addition, there is not an existing DT binding for the GPADC. Thus, we do
not need the sun4i-gpadc MFD driver which was made to keep DT compatibility
and probe subdrivers without the need to add DT subnodes.

This series of patch adds the CPU thermal sensor for the A33 and CPU thermal
throttling. It also adds DT binding documentation for the IIO and MFD GPADC
drivers. Finally, it adds the cpu-supply property to the CPU node needed by
the Sinlinx SinA33 and Olinuxino A33 to adapt their CPU regulator voltage
depending on the currently used OPP. The other A33 boards all have their
cpu-supply property set.

This patch *HAS NOT* been tested on the Olinuxino A33.
 @Stefan (or anyone owning an Olinuxino A33), could you test this patch
 series on your board, test CPUfreq and tell us if it works in a stable
 manner? Thanks!

This series of patch is based on this[1] and this[2][3] series of patch.

[1] https://lkml.org/lkml/2016/12/13/298 : "[PATCH v9] add support for Allwinner
SoCs ADC"
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-December/473962.html
: "[PATCH] Allwinner A33 CPU frequency scaling support" without PATCH 4/6
[3] https://lkml.org/lkml/2016/12/19/72 : "[PATCH v2] ARM: dts: sun8i: add
opp-v2 table for A33"

Quentin Schulz (7):
  Documentation: DT: bindings: iio: adc: add documentation for Allwinner
    SoCs' GPADC driver
  Documentation: DT: bindings: mfd: add documentation for Allwinner
    SoCs' GPADC MFD driver
  iio: adc: sun4i-gpadc-iio: add support for A33 thermal sensor
  ARM: dts: sun8i-a33-sinlinx-sina33: add cpu-supply
  ARM: dts: sun8i-a33-olinuxino: add cpu-supply
  ARM: dtsi: sun8i-a33: add A33 thermal sensor
  ARM: dtsi: sun8i-a33: add CPU thermal throttling

 .../bindings/iio/adc/sun4i-gpadc-iio.txt           |  57 ++++++
 .../devicetree/bindings/mfd/sun4i-gpadc.txt        |  47 +++++
 arch/arm/boot/dts/sun8i-a33-olinuxino.dts          |   4 +
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts     |   4 +
 arch/arm/boot/dts/sun8i-a33.dtsi                   |  59 ++++++
 drivers/iio/adc/Kconfig                            |  21 ++-
 drivers/iio/adc/sun4i-gpadc-iio.c                  | 204 ++++++++++++++++-----
 include/linux/mfd/sun4i-gpadc.h                    |   4 +
 8 files changed, 343 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/sun4i-gpadc-iio.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt

-- 
2.9.3

