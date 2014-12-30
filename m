Return-Path: <roberta.dobrescu@gmail.com>
From: Roberta Dobrescu <roberta.dobrescu@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: octavian.purdila@intel.com,
	daniel.baluta@intel.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>
Subject: [PATCH 3/3] iio: accel: Annotate Kconfig entries with module name information
Date: Tue, 30 Dec 2014 20:57:55 +0200
Message-Id: <1419965875-4298-4-git-send-email-roberta.dobrescu@gmail.com>
In-Reply-To: <1419965875-4298-1-git-send-email-roberta.dobrescu@gmail.com>
References: <1419965875-4298-1-git-send-email-roberta.dobrescu@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch fixes the following checkpatch.pl warning:
WARNING: please write a paragraph that describes the config symbol fully

Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
---
 drivers/iio/accel/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 9b9be87..402a3a5 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -43,6 +43,9 @@ config HID_SENSOR_ACCEL_3D
 	  Say yes here to build support for the HID SENSOR
 	  accelerometers 3D.
 
+	  To compile this driver as a module, choose M here: the
+	  module will be called hid-sensor-accel-3d.
+
 config IIO_ST_ACCEL_3AXIS
 	tristate "STMicroelectronics accelerometers 3-Axis Driver"
 	depends on (I2C || SPI_MASTER) && SYSFS
@@ -80,6 +83,9 @@ config KXSD9
 	  Say yes here to build support for the Kionix KXSD9 accelerometer.
 	  Currently this only supports the device via an SPI interface.
 
+	  To compile this driver as a module, choose M here: the module
+	  will be called kxsd9.
+
 config MMA8452
 	tristate "Freescale MMA8452Q Accelerometer Driver"
 	depends on I2C
-- 
1.9.1
