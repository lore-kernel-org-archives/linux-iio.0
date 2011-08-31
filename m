Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 12/12] iio: ad7192: add temp_scale attribute, change module description
Date: Wed, 31 Aug 2011 12:57:40 +0200
Message-ID: <1314788260-5791-12-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1314788260-5791-1-git-send-email-michael.hennerich@analog.com>
References: <1314788260-5791-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Use KBUILD_MODNAME
Fix indention style

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/adc/ad7291.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index 0811c5e..636e635 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -101,7 +101,7 @@ struct ad7291_chip_info {
 	u16			int_vref_mv;
 	u16			command;
 	u16			c_mask;	/* Active voltage channels for events */
-	struct mutex 		state_lock;
+	struct mutex		state_lock;
 };
 
 static int ad7291_i2c_read(struct ad7291_chip_info *chip, u8 reg, u16 *data)
@@ -513,6 +513,13 @@ static int ad7291_read_raw(struct iio_dev *indio_dev,
 		*val =  scale_uv / 1000;
 		*val2 = (scale_uv % 1000) * 1000;
 		return IIO_VAL_INT_PLUS_MICRO;
+	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
+		/*
+		* One LSB of the ADC corresponds to 0.25 deg C.
+		* The temperature reading is in 12-bit twos complement format
+		*/
+		*val = 250;
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -539,7 +546,8 @@ static const struct iio_chan_spec ad7291_channels[] = {
 	AD7291_VOLTAGE_CHAN(7),
 	{
 		.type = IIO_TEMP,
-		.info_mask = (1 << IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE),
+		.info_mask = (1 << IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE) |
+				(1 << IIO_CHAN_INFO_SCALE_SEPARATE),
 		.indexed = 1,
 		.channel = 0,
 		.event_mask =
@@ -683,7 +691,7 @@ MODULE_DEVICE_TABLE(i2c, ad7291_id);
 
 static struct i2c_driver ad7291_driver = {
 	.driver = {
-		.name = "ad7291",
+		.name = KBUILD_MODNAME,
 	},
 	.probe = ad7291_probe,
 	.remove = __devexit_p(ad7291_remove),
@@ -701,8 +709,7 @@ static __exit void ad7291_exit(void)
 }
 
 MODULE_AUTHOR("Sonic Zhang <sonic.zhang@analog.com>");
-MODULE_DESCRIPTION("Analog Devices AD7291 digital"
-			" temperature sensor driver");
+MODULE_DESCRIPTION("Analog Devices AD7291 ADC driver");
 MODULE_LICENSE("GPL v2");
 
 module_init(ad7291_init);
-- 
1.7.0.4
