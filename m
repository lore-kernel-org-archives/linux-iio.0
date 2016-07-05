Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:41617 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754930AbcGELzr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 5 Jul 2016 07:55:47 -0400
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, knaack.h@gmx.de,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH 4/9] staging: iio: isl29018: Cleanup of comments
Date: Tue,  5 Jul 2016 13:55:39 +0200
Message-Id: <1467719744-19450-5-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1467719744-19450-1-git-send-email-pmeerw@pmeerw.net>
References: <1467719744-19450-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
---
 drivers/staging/iio/light/isl29018.c |   19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index 9b3ca0e..cafa2a7 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -133,7 +133,7 @@ static int isl29018_set_integration_time(struct isl29018_chip *chip,
 	if (ret < 0)
 		return ret;
 
-	/* keep the same range when integration time changes */
+	/* Keep the same range when integration time changes */
 	int_time = chip->int_time;
 	for (i = 0; i < ARRAY_SIZE(isl29018_scales[int_time]); ++i) {
 		if (chip->scale.scale == isl29018_scales[int_time][i].scale &&
@@ -313,7 +313,6 @@ static ssize_t show_int_time_available(struct device *dev,
 	return len;
 }
 
-/* proximity scheme */
 static ssize_t show_prox_infrared_suppression(struct device *dev,
 					      struct device_attribute *attr,
 					      char *buf)
@@ -322,7 +321,7 @@ static ssize_t show_prox_infrared_suppression(struct device *dev,
 	struct isl29018_chip *chip = iio_priv(indio_dev);
 
 	/*
-	 * return the "proximity scheme" i.e. if the chip does on chip
+	 * Return the "proximity scheme" i.e. if the chip does on chip
 	 * infrared suppression (1 means perform on chip suppression)
 	 */
 	return sprintf(buf, "%d\n", chip->prox_scheme);
@@ -342,7 +341,7 @@ static ssize_t store_prox_infrared_suppression(struct device *dev,
 		return -EINVAL;
 
 	/*
-	 * get the  "proximity scheme" i.e. if the chip does on chip
+	 * Get the "proximity scheme" i.e. if the chip does on chip
 	 * infrared suppression (1 means perform on chip suppression)
 	 */
 	mutex_lock(&chip->lock);
@@ -352,7 +351,6 @@ static ssize_t store_prox_infrared_suppression(struct device *dev,
 	return count;
 }
 
-/* Channel IO */
 static int isl29018_write_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
 			      int val,
@@ -539,7 +537,7 @@ static int isl29035_detect(struct isl29018_chip *chip)
 	if (id != ISL29035_DEVICE_ID)
 		return -ENODEV;
 
-	/* clear out brownout bit */
+	/* Clear brownout bit */
 	return regmap_update_bits(chip->regmap, ISL29035_REG_DEVICE_ID,
 				  ISL29035_BOUT_MASK, 0);
 }
@@ -572,7 +570,7 @@ static int isl29018_chip_init(struct isl29018_chip *chip)
 	 * conversions, clear the test registers, and then rewrite all
 	 * registers to the desired values.
 	 * ...
-	 * FOR ISL29011, ISL29018, ISL29021, ISL29023
+	 * For ISL29011, ISL29018, ISL29021, ISL29023
 	 * 1. Write 0x00 to register 0x08 (TEST)
 	 * 2. Write 0x00 to register 0x00 (CMD1)
 	 * 3. Rewrite all registers to the desired values
@@ -601,7 +599,7 @@ static int isl29018_chip_init(struct isl29018_chip *chip)
 
 	usleep_range(1000, 2000);	/* per data sheet, page 10 */
 
-	/* set defaults */
+	/* Set defaults */
 	status = isl29018_set_scale(chip, chip->scale.scale,
 				    chip->scale.uscale);
 	if (status < 0) {
@@ -647,10 +645,6 @@ static bool is_volatile_reg(struct device *dev, unsigned int reg)
 	}
 }
 
-/*
- * isl29018_regmap_config: regmap configuration.
- * Use RBTREE mechanism for caching.
- */
 static const struct regmap_config isl29018_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -660,7 +654,6 @@ static const struct regmap_config isl29018_regmap_config = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-/* isl29035_regmap_config: regmap configuration for ISL29035 */
 static const struct regmap_config isl29035_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
-- 
1.7.10.4

