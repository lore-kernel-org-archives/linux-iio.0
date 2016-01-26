Return-Path: <cristina.moraru09@gmail.com>
From: Cristina Moraru <cristina.moraru09@gmail.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	ludovic.tancerel@maplehightech.com,
	mranostay@gmail.com,
	geert@linux-m68k.org,
	andrew.smirnov@gmail.com,
	nicola@corna.info,
	chris.lesiak@licor.com,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	octavian.purdila@intel.com,
	daniel.baluta@intel.com
Cc: Cristina Moraru <cristina.moraru09@gmail.com>
Subject: [PATCH 1/2] iio: si7020: add support for Hoperf th06
Date: Tue, 26 Jan 2016 22:17:49 +0200
Message-Id: <1453839469-3537-1-git-send-email-cristina.moraru09@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch adds support for Hoperf th06 humidity and
temperature sensor as it uses same register definitions
as si7020

th06 Datasheet: http://www.hoperf.com/upload/sensor/TH06.pdf

Signed-off-by: Cristina Moraru <cristina.moraru09@gmail.com>
---
Previously sent: http://marc.info/?l=linux-iio&m=145255305514311&w=2

 drivers/iio/humidity/Kconfig  | 3 ++-
 drivers/iio/humidity/si7020.c | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
index 6a23698..c1f3a21 100644
--- a/drivers/iio/humidity/Kconfig
+++ b/drivers/iio/humidity/Kconfig
@@ -50,7 +50,8 @@ config SI7020
 	depends on I2C
 	help
 	  Say yes here to build support for the Silicon Labs Si7013/20/21
-	  Relative Humidity and Temperature Sensors.
+	  Relative Humidity and Temperature Sensors. This driver also
+	  supports Hoperf TH06 Humidity and Temperature Sensor.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called si7020.
diff --git a/drivers/iio/humidity/si7020.c b/drivers/iio/humidity/si7020.c
index 71991b5..5ab4e06 100644
--- a/drivers/iio/humidity/si7020.c
+++ b/drivers/iio/humidity/si7020.c
@@ -149,6 +149,7 @@ static int si7020_probe(struct i2c_client *client,
 
 static const struct i2c_device_id si7020_id[] = {
 	{ "si7020", 0 },
+	{ "th06", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, si7020_id);
-- 
1.9.1
