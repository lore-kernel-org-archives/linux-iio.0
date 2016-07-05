Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:41631 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754964AbcGELzt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 5 Jul 2016 07:55:49 -0400
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, knaack.h@gmx.de,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH 5/9] staging: iio: isl29018: Prefix remaining functions
Date: Tue,  5 Jul 2016 13:55:40 +0200
Message-Id: <1467719744-19450-6-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1467719744-19450-1-git-send-email-pmeerw@pmeerw.net>
References: <1467719744-19450-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
---
 drivers/staging/iio/light/isl29018.c |   34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index cafa2a7..80b6a9e 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -280,7 +280,7 @@ static int isl29018_read_proximity_ir(struct isl29018_chip *chip, int scheme,
 	return 0;
 }
 
-static ssize_t show_scale_available(struct device *dev,
+static ssize_t isl29018_show_scale_available(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -297,7 +297,7 @@ static ssize_t show_scale_available(struct device *dev,
 	return len;
 }
 
-static ssize_t show_int_time_available(struct device *dev,
+static ssize_t isl29018_show_int_time_available(struct device *dev,
 				       struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -313,7 +313,7 @@ static ssize_t show_int_time_available(struct device *dev,
 	return len;
 }
 
-static ssize_t show_prox_infrared_suppression(struct device *dev,
+static ssize_t isl29018_show_prox_infrared_suppression(struct device *dev,
 					      struct device_attribute *attr,
 					      char *buf)
 {
@@ -327,7 +327,7 @@ static ssize_t show_prox_infrared_suppression(struct device *dev,
 	return sprintf(buf, "%d\n", chip->prox_scheme);
 }
 
-static ssize_t store_prox_infrared_suppression(struct device *dev,
+static ssize_t isl29018_store_prox_infrared_suppression(struct device *dev,
 					       struct device_attribute *attr,
 					       const char *buf, size_t count)
 {
@@ -487,13 +487,13 @@ static const struct iio_chan_spec isl29023_channels[] = {
 };
 
 static IIO_DEVICE_ATTR(in_illuminance_integration_time_available, S_IRUGO,
-		       show_int_time_available, NULL, 0);
+		       isl29018_show_int_time_available, NULL, 0);
 static IIO_DEVICE_ATTR(in_illuminance_scale_available, S_IRUGO,
-		      show_scale_available, NULL, 0);
+		      isl29018_show_scale_available, NULL, 0);
 static IIO_DEVICE_ATTR(proximity_on_chip_ambient_infrared_suppression,
 					S_IRUGO | S_IWUSR,
-					show_prox_infrared_suppression,
-					store_prox_infrared_suppression, 0);
+					isl29018_show_prox_infrared_suppression,
+					isl29018_store_prox_infrared_suppression, 0);
 
 #define ISL29018_DEV_ATTR(name) (&iio_dev_attr_##name.dev_attr.attr)
 
@@ -631,7 +631,7 @@ static const struct iio_info isl29023_info = {
 	.write_raw = isl29018_write_raw,
 };
 
-static bool is_volatile_reg(struct device *dev, unsigned int reg)
+static bool isl29018_is_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case ISL29018_REG_ADD_DATA_LSB:
@@ -648,7 +648,7 @@ static bool is_volatile_reg(struct device *dev, unsigned int reg)
 static const struct regmap_config isl29018_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
-	.volatile_reg = is_volatile_reg,
+	.volatile_reg = isl29018_is_volatile_reg,
 	.max_register = ISL29018_REG_TEST,
 	.num_reg_defaults_raw = ISL29018_REG_TEST + 1,
 	.cache_type = REGCACHE_RBTREE,
@@ -657,20 +657,20 @@ static const struct regmap_config isl29018_regmap_config = {
 static const struct regmap_config isl29035_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
-	.volatile_reg = is_volatile_reg,
+	.volatile_reg = isl29018_is_volatile_reg,
 	.max_register = ISL29035_REG_DEVICE_ID,
 	.num_reg_defaults_raw = ISL29035_REG_DEVICE_ID + 1,
 	.cache_type = REGCACHE_RBTREE,
 };
 
-struct chip_info {
+struct isl29018_chip_info {
 	const struct iio_chan_spec *channels;
 	int num_channels;
 	const struct iio_info *indio_info;
 	const struct regmap_config *regmap_cfg;
 };
 
-static const struct chip_info chip_info_tbl[] = {
+static const struct isl29018_chip_info isl29018_chip_info_tbl[] = {
 	[isl29018] = {
 		.channels = isl29018_channels,
 		.num_channels = ARRAY_SIZE(isl29018_channels),
@@ -739,7 +739,7 @@ static int isl29018_probe(struct i2c_client *client,
 	chip->suspended = false;
 
 	chip->regmap = devm_regmap_init_i2c(client,
-				chip_info_tbl[dev_id].regmap_cfg);
+				isl29018_chip_info_tbl[dev_id].regmap_cfg);
 	if (IS_ERR(chip->regmap)) {
 		err = PTR_ERR(chip->regmap);
 		dev_err(&client->dev, "regmap initialization fails: %d\n", err);
@@ -750,9 +750,9 @@ static int isl29018_probe(struct i2c_client *client,
 	if (err)
 		return err;
 
-	indio_dev->info = chip_info_tbl[dev_id].indio_info;
-	indio_dev->channels = chip_info_tbl[dev_id].channels;
-	indio_dev->num_channels = chip_info_tbl[dev_id].num_channels;
+	indio_dev->info = isl29018_chip_info_tbl[dev_id].indio_info;
+	indio_dev->channels = isl29018_chip_info_tbl[dev_id].channels;
+	indio_dev->num_channels = isl29018_chip_info_tbl[dev_id].num_channels;
 	indio_dev->name = name;
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-- 
1.7.10.4

