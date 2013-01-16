Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-069.synserver.de ([212.40.185.69]:1037 "EHLO
	smtp-out-069.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753077Ab3APMsd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Jan 2013 07:48:33 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 14/15] iio:adis16400: Expose some debug information in debugfs
Date: Wed, 16 Jan 2013 13:48:50 +0100
Message-Id: <1358340531-31350-14-git-send-email-lars@metafoo.de>
In-Reply-To: <1358340531-31350-1-git-send-email-lars@metafoo.de>
References: <1358340531-31350-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Expose some information useful for debugging a device in debugfs. This includes
for now the flash count, the product id and the serial number and raw register
access.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/imu/adis16400.h      |   4 ++
 drivers/iio/imu/adis16400_core.c | 113 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 113 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/adis16400.h b/drivers/iio/imu/adis16400.h
index a3b9e56..6270185 100644
--- a/drivers/iio/imu/adis16400.h
+++ b/drivers/iio/imu/adis16400.h
@@ -74,7 +74,10 @@
 #define ADIS16400_ALM_CTRL  0x48 /* Alarm control */
 #define ADIS16400_AUX_DAC   0x4A /* Auxiliary DAC data */
 
+#define ADIS16334_LOT_ID1   0x52 /* Lot identification code 1 */
+#define ADIS16334_LOT_ID2   0x54 /* Lot identification code 2 */
 #define ADIS16400_PRODUCT_ID 0x56 /* Product identifier */
+#define ADIS16334_SERIAL_NUMBER 0x58 /* Serial number, lot specific */
 
 #define ADIS16400_ERROR_ACTIVE			(1<<14)
 #define ADIS16400_NEW_DATA			(1<<14)
@@ -132,6 +135,7 @@
 #define ADIS16400_HAS_PROD_ID		BIT(0)
 #define ADIS16400_NO_BURST		BIT(1)
 #define ADIS16400_HAS_SLOW_MODE		BIT(2)
+#define ADIS16400_HAS_SERIAL_NUMBER	BIT(3)
 
 struct adis16400_state;
 
diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400_core.c
index 58699ac..e8f84c9 100644
--- a/drivers/iio/imu/adis16400_core.c
+++ b/drivers/iio/imu/adis16400_core.c
@@ -25,6 +25,7 @@
 #include <linux/sysfs.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/debugfs.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -32,6 +33,104 @@
 
 #include "adis16400.h"
 
+#ifdef CONFIG_DEBUG_FS
+
+static ssize_t adis16400_show_serial_number(struct file *file,
+		char __user *userbuf, size_t count, loff_t *ppos)
+{
+	struct adis16400_state *st = file->private_data;
+	u16 lot1, lot2, serial_number;
+	char buf[16];
+	size_t len;
+	int ret;
+
+	ret = adis_read_reg_16(&st->adis, ADIS16334_LOT_ID1, &lot1);
+	if (ret < 0)
+		return ret;
+
+	ret = adis_read_reg_16(&st->adis, ADIS16334_LOT_ID2, &lot2);
+	if (ret < 0)
+		return ret;
+
+	ret = adis_read_reg_16(&st->adis, ADIS16334_SERIAL_NUMBER,
+			&serial_number);
+	if (ret < 0)
+		return ret;
+
+	len = snprintf(buf, sizeof(buf), "%.4x-%.4x-%.4x\n", lot1, lot2,
+			serial_number);
+
+	return simple_read_from_buffer(userbuf, count, ppos, buf, len);
+}
+
+static const struct file_operations adis16400_serial_number_fops = {
+	.open = simple_open,
+	.read = adis16400_show_serial_number,
+	.llseek = default_llseek,
+	.owner = THIS_MODULE,
+};
+
+static int adis16400_show_product_id(void *arg, u64 *val)
+{
+	struct adis16400_state *st = arg;
+	uint16_t prod_id;
+	int ret;
+
+	ret = adis_read_reg_16(&st->adis, ADIS16400_PRODUCT_ID, &prod_id);
+	if (ret < 0)
+		return ret;
+
+	*val = prod_id;
+
+	return 0;
+}
+DEFINE_SIMPLE_ATTRIBUTE(adis16400_product_id_fops,
+	adis16400_show_product_id, NULL, "%lld\n");
+
+static int adis16400_show_flash_count(void *arg, u64 *val)
+{
+	struct adis16400_state *st = arg;
+	uint16_t flash_count;
+	int ret;
+
+	ret = adis_read_reg_16(&st->adis, ADIS16400_FLASH_CNT, &flash_count);
+	if (ret < 0)
+		return ret;
+
+	*val = flash_count;
+
+	return 0;
+}
+DEFINE_SIMPLE_ATTRIBUTE(adis16400_flash_count_fops,
+	adis16400_show_flash_count, NULL, "%lld\n");
+
+static int adis16400_debugfs_init(struct iio_dev *indio_dev)
+{
+	struct adis16400_state *st = iio_priv(indio_dev);
+
+	if (st->variant->flags & ADIS16400_HAS_SERIAL_NUMBER)
+		debugfs_create_file("serial_number", 0400,
+			indio_dev->debugfs_dentry, st,
+			&adis16400_serial_number_fops);
+	if (st->variant->flags & ADIS16400_HAS_PROD_ID)
+		debugfs_create_file("product_id", 0400,
+			indio_dev->debugfs_dentry, st,
+			&adis16400_product_id_fops);
+	debugfs_create_file("flash_count", 0400, indio_dev->debugfs_dentry,
+		st, &adis16400_flash_count_fops);
+
+	return 0;
+}
+
+#else
+
+static int adis16400_debugfs_init(struct iio_dev *indio_dev)
+{
+	return 0;
+}
+
+#endif
+
 enum adis16400_chip_variant {
 	ADIS16300,
 	ADIS16334,
@@ -600,7 +699,8 @@ static struct adis16400_chip_info adis16400_chips[] = {
 	[ADIS16334] = {
 		.channels = adis16334_channels,
 		.num_channels = ARRAY_SIZE(adis16334_channels),
-		.flags = ADIS16400_HAS_PROD_ID,
+		.flags = ADIS16400_HAS_PROD_ID | ADIS16400_NO_BURST |
+				ADIS16400_HAS_SERIAL_NUMBER,
 		.gyro_scale_micro = IIO_DEGREE_TO_RAD(50000), /* 0.05 deg/s */
 		.accel_scale_micro = IIO_G_TO_M_S_2(1000), /* 1 mg */
 		.temp_scale_nano = 67850000, /* 0.06785 C */
@@ -622,7 +722,8 @@ static struct adis16400_chip_info adis16400_chips[] = {
 	[ADIS16360] = {
 		.channels = adis16350_channels,
 		.num_channels = ARRAY_SIZE(adis16350_channels),
-		.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SLOW_MODE,
+		.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SLOW_MODE |
+				ADIS16400_HAS_SERIAL_NUMBER,
 		.gyro_scale_micro = IIO_DEGREE_TO_RAD(50000), /* 0.05 deg/s */
 		.accel_scale_micro = IIO_G_TO_M_S_2(3333), /* 3.333 mg */
 		.temp_scale_nano = 136000000, /* 0.136 C */
@@ -633,7 +734,8 @@ static struct adis16400_chip_info adis16400_chips[] = {
 	[ADIS16362] = {
 		.channels = adis16350_channels,
 		.num_channels = ARRAY_SIZE(adis16350_channels),
-		.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SLOW_MODE,
+		.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SLOW_MODE |
+				ADIS16400_HAS_SERIAL_NUMBER,
 		.gyro_scale_micro = IIO_DEGREE_TO_RAD(50000), /* 0.05 deg/s */
 		.accel_scale_micro = IIO_G_TO_M_S_2(333), /* 0.333 mg */
 		.temp_scale_nano = 136000000, /* 0.136 C */
@@ -644,7 +746,8 @@ static struct adis16400_chip_info adis16400_chips[] = {
 	[ADIS16364] = {
 		.channels = adis16350_channels,
 		.num_channels = ARRAY_SIZE(adis16350_channels),
-		.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SLOW_MODE,
+		.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SLOW_MODE |
+				ADIS16400_HAS_SERIAL_NUMBER,
 		.gyro_scale_micro = IIO_DEGREE_TO_RAD(50000), /* 0.05 deg/s */
 		.accel_scale_micro = IIO_G_TO_M_S_2(1000), /* 1 mg */
 		.temp_scale_nano = 136000000, /* 0.136 C */
@@ -671,6 +774,7 @@ static const struct iio_info adis16400_info = {
 	.write_raw = &adis16400_write_raw,
 	.attrs = &adis16400_attribute_group,
 	.update_scan_mode = adis16400_update_scan_mode,
+	.debugfs_reg_access = adis_debugfs_reg_access,
 };
 
 static const unsigned long adis16400_burst_scan_mask[] = {
@@ -768,6 +872,7 @@ static int adis16400_probe(struct spi_device *spi)
 	if (ret)
 		goto error_cleanup_buffer;
 
+	adis16400_debugfs_init(indio_dev);
 	return 0;
 
 error_cleanup_buffer:
-- 
1.8.0

