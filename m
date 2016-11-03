Return-Path: <masneyb@onstation.org>
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org,
	gregkh@linuxfoundation.org,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	knaack.h@gmx.de,
	linux-kernel@vger.kernel.org,
	Jon.Brenner@ams.com
Subject: [PATCH 2/9] staging: iio: tsl2583: removed unused code from device probing
Date: Thu,  3 Nov 2016 08:56:13 -0400
Message-Id: <1478177780-28699-3-git-send-email-masneyb@onstation.org>
In-Reply-To: <1478177780-28699-1-git-send-email-masneyb@onstation.org>
References: <1478177780-28699-1-git-send-email-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

taos_probe() queries the all of the sensor's registers and loads all of
the values into a buffer stored on the stack. Only the chip ID register
was actually used. Change the probe function to just query the chip ID
register on the device.

Verified that the driver still functions correctly using a TSL2581
hooked up to a Raspberry Pi 2.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2583.c | 37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index a3a9095..388440b 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -31,8 +31,6 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
-#define TSL258X_MAX_DEVICE_REGS		32
-
 /* Triton register offsets */
 #define	TSL258X_REG_MAX		8
 
@@ -66,6 +64,9 @@
 /* Lux calculation constants */
 #define	TSL258X_LUX_CALC_OVER_FLOW		65535
 
+#define TSL2583_CHIP_ID			0x90
+#define TSL2583_CHIP_ID_MASK		0xf0
+
 enum {
 	TSL258X_CHIP_UNKNOWN = 0,
 	TSL258X_CHIP_WORKING = 1,
@@ -607,12 +608,6 @@ static const struct attribute_group tsl2583_attribute_group = {
 	.attrs = sysfs_attrs_ctrl,
 };
 
-/* Use the default register values to identify the Taos device */
-static int taos_tsl258x_device(unsigned char *bufp)
-{
-	return ((bufp[TSL258X_CHIPID] & 0xf0) == 0x90);
-}
-
 static const struct iio_chan_spec tsl2583_channels[] = {
 	{
 		.type = IIO_LIGHT,
@@ -777,8 +772,7 @@ static const struct iio_info tsl2583_info = {
 static int taos_probe(struct i2c_client *clientp,
 		      const struct i2c_device_id *idp)
 {
-	int i, ret;
-	unsigned char buf[TSL258X_MAX_DEVICE_REGS];
+	int ret;
 	struct tsl2583_chip *chip;
 	struct iio_dev *indio_dev;
 
@@ -799,22 +793,17 @@ static int taos_probe(struct i2c_client *clientp,
 	chip->taos_chip_status = TSL258X_CHIP_UNKNOWN;
 	memcpy(chip->taos_config, taos_config, sizeof(chip->taos_config));
 
-	for (i = 0; i < TSL258X_MAX_DEVICE_REGS; i++) {
-		ret = i2c_smbus_read_byte_data(clientp,
-					       (TSL258X_CMD_REG |
-						(TSL258X_CNTRL + i)));
-		if (ret < 0) {
-			dev_err(&clientp->dev,
-				"i2c_smbus_read_byte from reg failed in taos_probe(), err = %d\n",
-				ret);
-			return ret;
-		}
-		buf[i] = ret;
+	ret = i2c_smbus_read_byte_data(clientp,
+				       TSL258X_CMD_REG | TSL258X_CHIPID);
+	if (ret < 0) {
+		dev_err(&clientp->dev,
+			"%s failed to read the chip ID register\n", __func__);
+		return ret;
 	}
 
-	if (!taos_tsl258x_device(buf)) {
-		dev_info(&clientp->dev,
-			 "i2c device found but does not match expected id in taos_probe()\n");
+	if ((ret & TSL2583_CHIP_ID_MASK) != TSL2583_CHIP_ID) {
+		dev_info(&clientp->dev, "%s received an unknown chip ID %x\n",
+			 __func__, ret);
 		return -EINVAL;
 	}
 
-- 
2.5.5
