Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36234 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711AbcBNWim (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 14 Feb 2016 17:38:42 -0500
From: Cristina Moraru <cristina.moraru09@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	cristina.opriceana@gmail.com, marek@goldelico.com,
	sdliyong@gmail.com, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, geert@linux-m68k.org, arnd@arndb.de,
	irina.tirdea@intel.com, k.kozlowski@samsung.com,
	broonie@kernel.org, afd@ti.com, javier@osg.samsung.com,
	daniel.baluta@intel.com, octavian.purdila@intel.com
Cc: Cristina Moraru <cristina.moraru09@gmail.com>
Subject: [PATCH v2 2/3] iio: hmc5843: Add ABI documentation file for hmc5843
Date: Mon, 15 Feb 2016 00:37:38 +0200
Message-Id: <1455489459-20422-3-git-send-email-cristina.moraru09@gmail.com>
In-Reply-To: <1455489459-20422-1-git-send-email-cristina.moraru09@gmail.com>
References: <1455489459-20422-1-git-send-email-cristina.moraru09@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add ABI file documenting hmc5843 non-standard attributes
meas_conf and meas_conf_available for bias current
configuration.

Signed-off-by: Cristina Moraru <cristina.moraru09@gmail.com>
Cc: Daniel Baluta <daniel.baluta@intel.com>
---
Changes since v1:
        Changed API from integer values to string values
 .../ABI/testing/sysfs-bus-iio-magnetometer-hmc5843        | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-magnetometer-hmc5843

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-magnetometer-hmc5843 b/Documentation/ABI/testing/sysfs-bus-iio-magnetometer-hmc5843
new file mode 100644
index 0000000..6275e9f
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-magnetometer-hmc5843
@@ -0,0 +1,15 @@
+What:           /sys/bus/iio/devices/iio:deviceX/meas_conf
+What:           /sys/bus/iio/devices/iio:deviceX/meas_conf_available
+KernelVersion:  4.5
+Contact:        linux-iio@vger.kernel.org
+Description:
+                Current configuration and available configurations
+		for the bias current.
+		normal		- Normal measurement configurations (default)
+		positivebias	- Positive bias configuration
+		negativebias	- Negative bias configuration
+		disabled	- Only available on HMC5983. Disables magnetic
+				  sensor and enables temperature sensor.
+		Note: The effect of this configuration may vary
+		according to the device. For exact documentation
+		check the device's datasheet.
-- 
1.9.1

