Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32933 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755092AbcBGWWQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 7 Feb 2016 17:22:16 -0500
From: Cristina Moraru <cristina.moraru09@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	cristina.opriceana@gmail.com, marek@goldelico.com,
	sdliyong@gmail.com, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, tolga.ceylan@gmail.com,
	k.kozlowski@samsung.com, javier@osg.samsung.com, arnd@arndb.de,
	geert@linux-m68k.org, irina.tirdea@intel.com,
	daniel.baluta@intel.com, octavia.purdila@intel.com
Cc: Cristina Moraru <cristina.moraru09@gmail.com>
Subject: [PATCH 3/5] iio: hmc5843: Add ABI documentation file for hmc5843
Date: Mon,  8 Feb 2016 00:21:49 +0200
Message-Id: <1454883711-15489-4-git-send-email-cristina.moraru09@gmail.com>
In-Reply-To: <1454883711-15489-1-git-send-email-cristina.moraru09@gmail.com>
References: <1454883711-15489-1-git-send-email-cristina.moraru09@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add ABI file documenting hmc5843 non-standard attributes
meas_conf and meas_conf_available for bias current
configuration.

Signed-off-by: Cristina Moraru <cristina.moraru09@gmail.com>
---
 .../ABI/testing/sysfs-bus-iio-magnetometer-hmc5843        | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-magnetometer-hmc5843

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-magnetometer-hmc5843 b/Documentation/ABI/testing/sysfs-bus-iio-magnetometer-hmc5843
new file mode 100644
index 0000000..7c3fc4c
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-magnetometer-hmc5843
@@ -0,0 +1,15 @@
+What:           /sys/bus/iio/devices/iio:deviceX/meas_conf
+What:           /sys/bus/iio/devices/iio:deviceX/meas_conf_available
+KernelVersion:  4.3.0
+Contact:        linux-iio@vger.kernel.org
+Description:
+                Current configuration and available configurations
+		for the bias current.
+		0 - Normal measurement configurations (default)
+		1 - Positive bias configuration
+		2 - Negative bias configuration
+		3 - Only available on HMC5983. Disables magnetic
+		sensor and enables temperature sensor.
+		Note: The effect of this configuration may vary
+		according to the device. For exact documentation
+		check the device's datasheet.
-- 
1.9.1

