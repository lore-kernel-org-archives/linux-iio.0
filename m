Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 02/12] iio: ad7291: Fix typos, change kconfig description and file header
Date: Wed, 31 Aug 2011 12:57:30 +0200
Message-ID: <1314788260-5791-2-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1314788260-5791-1-git-send-email-michael.hennerich@analog.com>
References: <1314788260-5791-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Make clear the AD7291 is primarily an ADC, and not a temp sensor.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/adc/Kconfig  |    4 ++--
 drivers/staging/iio/adc/ad7291.c |   14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index 25566c6..7867ab1 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -18,11 +18,11 @@ config AD7152
 	  (ad7152, ad7153) Provides direct access via sysfs.
 
 config AD7291
-	tristate "Analog Devices AD7291 temperature sensor driver"
+	tristate "Analog Devices AD7291 ADC driver"
 	depends on I2C
 	help
 	  Say yes here to build support for Analog Devices AD7291
-	  temperature sensors.
+	  8 Channel ADC with temperature sensor.
 
 config AD7298
 	tristate "Analog Devices AD7298 ADC driver"
diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index 32944f3..d47df4a 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -1,7 +1,7 @@
 /*
- * AD7291 digital temperature sensor driver supporting AD7291
+ * AD7291 8-Channel, I2C, 12-Bit SAR ADC with Temperature Sensor
  *
- * Copyright 2010 Analog Devices Inc.
+ * Copyright 2010-2011 Analog Devices Inc.
  *
  * Licensed under the GPL-2 or later.
  */
@@ -48,8 +48,8 @@
  */
 #define AD7291_AUTOCYCLE		0x1
 #define AD7291_RESET			0x2
-#define AD7291_ALART_CLEAR		0x4
-#define AD7291_ALART_POLARITY		0x8
+#define AD7291_ALERT_CLEAR		0x4
+#define AD7291_ALERT_POLARITY		0x8
 #define AD7291_EXT_REF			0x10
 #define AD7291_NOISE_DELAY		0x20
 #define AD7291_T_SENSE_MASK		0x40
@@ -134,10 +134,10 @@ static irqreturn_t ad7291_event_handler(int irq, void *private)
 	if (!(t_status || v_status))
 		return IRQ_HANDLED;
 
-	command = chip->command | AD7291_ALART_CLEAR;
+	command = chip->command | AD7291_ALERT_CLEAR;
 	ad7291_i2c_write(chip, AD7291_COMMAND, command);
 
-	command = chip->command & ~AD7291_ALART_CLEAR;
+	command = chip->command & ~AD7291_ALERT_CLEAR;
 	ad7291_i2c_write(chip, AD7291_COMMAND, command);
 
 	/* For now treat t_sense and t_sense_average the same */
@@ -558,7 +558,7 @@ static int __devinit ad7291_probe(struct i2c_client *client,
 			goto error_free_dev;
 
 		/* set irq polarity low level */
-		chip->command |= AD7291_ALART_POLARITY;
+		chip->command |= AD7291_ALERT_POLARITY;
 	}
 
 	ret = ad7291_i2c_write(chip, AD7291_COMMAND, chip->command);
-- 
1.7.0.4
