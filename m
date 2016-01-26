Return-Path: <cristina.moraru09@gmail.com>
From: Cristina Moraru <cristina.moraru09@gmail.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	ludovic.tancerel@maplehightech.com,
	mranostay@gmail.com,
	geert@linux-m68k.org,
	k.kozlowski@samsung.com,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	octavian.purdila@intel.com,
	daniel.baluta@intel.com
Cc: Cristina Moraru <cristina.moraru09@gmail.com>
Subject: [PATCH 2/2] iio: si7005: add support for Hoperf th02
Date: Tue, 26 Jan 2016 22:21:07 +0200
Message-Id: <1453839667-3626-1-git-send-email-cristina.moraru09@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch adds support for Hoperf th02 humidity and
temperature sensor as it uses same register definitions
as si7005

th02 Datasheet: http://www.anglia-live.com/netalogue/pdfs/hrf/datasheets/TH02_V1.1.pdf

Signed-off-by: Cristina Moraru <cristina.moraru09@gmail.com>
---
 drivers/iio/humidity/Kconfig  | 3 ++-
 drivers/iio/humidity/si7005.c | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
index c1f3a21..866dda1 100644
--- a/drivers/iio/humidity/Kconfig
+++ b/drivers/iio/humidity/Kconfig
@@ -43,7 +43,8 @@ config SI7005
 	  humidity and temperature sensor.
 
 	  To compile this driver as a module, choose M here: the module
-	  will be called si7005.
+	  will be called si7005. This driver also
+	  supports Hoperf TH02 Humidity and Temperature Sensor.
 
 config SI7020
 	tristate "Si7013/20/21 Relative Humidity and Temperature Sensors"
diff --git a/drivers/iio/humidity/si7005.c b/drivers/iio/humidity/si7005.c
index 91972cc..98a022f 100644
--- a/drivers/iio/humidity/si7005.c
+++ b/drivers/iio/humidity/si7005.c
@@ -170,6 +170,7 @@ static int si7005_probe(struct i2c_client *client,
 
 static const struct i2c_device_id si7005_id[] = {
 	{ "si7005", 0 },
+	{ "th02", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, si7005_id);
-- 
1.9.1
