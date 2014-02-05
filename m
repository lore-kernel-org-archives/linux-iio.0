Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:39989 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbaBETBt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Feb 2014 14:01:49 -0500
Received: by mail-oa0-f52.google.com with SMTP id i4so1017152oah.11
        for <linux-iio@vger.kernel.org>; Wed, 05 Feb 2014 11:01:48 -0800 (PST)
From: Matt Porter <mporter@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <robh+dt@kernel.org>,
	=?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
	Tony Lindgren <tony@atomide.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Thierry Reding <thierry.reding@gmail.com>
Cc: Linux IIO List <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Devicetree List <devicetree@vger.kernel.org>,
	Linux PWM List <linux-pwm@vger.kernel.org>,
	Linux OMAP List <linux-omap@vger.kernel.org>,
	Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 0/6] IIO pulse capture support for TI ECAP
Date: Wed,  5 Feb 2014 14:01:35 -0500
Message-Id: <1391626901-31684-1-git-send-email-mporter@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes since v2:
	- Remove various unneeded field initialization
	- Call iio_triggered_buffer_cleanup() on remove

Changes since v1:
	- Rebased to 3.14-rc1
	- Renamed in_pulse_polarity to pulse_polarity
	- Added ABI entries for pulse devices and TI ECAP

This series adds support for PWM capture devices within IIO and
adds a TI ECAP IIO driver.

PWM capture devices are supported using a new IIO "pulse" channel type.

The IIO ECAP driver implements interrupt driven triggered buffer capture
only as raw sample reads are not applicable to this hardware.
Initially, the driver supports a single pulse width measurement with
configurable polarity. The ECAP hardware can support measurement of a
complete period and duty cycle but this is not yet implemented.

Matt Porter (6):
  iio: add support for pulse width capture devices
  iio: pulse: add TI ECAP driver
  iio: enable selection and build of pulse drivers
  iio: Add ABI docs for pulse capture devices
  pwm: enable TI PWMSS if the IIO tiecap driver is selected
  ARM: dts: AM33XX: Add ecap interrupt properties

 Documentation/ABI/testing/sysfs-bus-iio            |  18 +
 .../ABI/testing/sysfs-bus-iio-pulse-tiecap         |   9 +
 arch/arm/boot/dts/am33xx.dtsi                      |   6 +
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/industrialio-core.c                    |   1 +
 drivers/iio/pulse/Kconfig                          |  20 +
 drivers/iio/pulse/Makefile                         |   6 +
 drivers/iio/pulse/tiecap.c                         | 491 +++++++++++++++++++++
 drivers/pwm/Kconfig                                |   2 +-
 include/linux/iio/types.h                          |   1 +
 11 files changed, 555 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-pulse-tiecap
 create mode 100644 drivers/iio/pulse/Kconfig
 create mode 100644 drivers/iio/pulse/Makefile
 create mode 100644 drivers/iio/pulse/tiecap.c

-- 
1.8.4

