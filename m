Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:47345 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751343Ab3KSPzI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 19 Nov 2013 10:55:08 -0500
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Shawn Guo <shawn.guo@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Denis Ciocca <denis.ciocca@st.com>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Brian Lilly <brian@crystalfontz.com>,
	Brent-Crosby <brent@crystalfontz.com>, Jim Wall <jimwall@q.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [RFC PATCH 0/3] DT support for ST micro accelerometers and gyroscopes
Date: Tue, 19 Nov 2013 16:50:30 +0100
Message-Id: <1384876234-1211-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi everyone,

This is an attempt at adding the DT probing to the st_sensors
accelerometers and gyroscopes.

It's somewhat hackish, because the core actively checks for the value
of the device at probe time, and DT probing generates a quite
different name.

I first tried to turn the function st_sensors_check_device_support the
other way around, with the "leaf" providing the sensor structure, and
the function checking that it's consistent with the WAI stored in the
sensor. However, it turned to be a quite intrusive change, so I'm
sending the easiest one, to try to get some feedback :)

Thanks!
Maxime

Maxime Ripard (3):
  iio: accel: Add device tree probing for STMicro accelerometers
  iio: accel: Add device tree probing for STMicro gyroscopes
  ARM: cfa10057: Add the accelerometer and gyroscope to the device tree

 .../devicetree/bindings/iio/accel/st_accel_i2c.txt | 22 +++++++++++++++
 .../devicetree/bindings/iio/gyro/st_gyro_i2c.txt   | 20 +++++++++++++
 arch/arm/boot/dts/imx28-cfa10057.dts               | 13 +++++++++
 drivers/iio/accel/st_accel_i2c.c                   | 33 ++++++++++++++++++++++
 drivers/iio/gyro/st_gyro_i2c.c                     | 31 ++++++++++++++++++++
 5 files changed, 119 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/st_accel_i2c.txt
 create mode 100644 Documentation/devicetree/bindings/iio/gyro/st_gyro_i2c.txt

-- 
1.8.4.2

