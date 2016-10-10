Return-Path: <masneyb@onstation.org>
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org
Subject: [PATCH v2 2/8] staging: iio: isl29018: fix poorly named function
Date: Mon, 10 Oct 2016 03:19:56 -0400
Message-Id: <1476084002-29683-3-git-send-email-masneyb@onstation.org>
In-Reply-To: <1476084002-29683-1-git-send-email-masneyb@onstation.org>
References: <1476084002-29683-1-git-send-email-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

isl29035_detect() did not do chip detection. Move functionality directly
into isl29018_chip_init() to avoid naming confusion.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/isl29018.c | 44 ++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index 26bbbb8..130f222 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -529,30 +529,6 @@ static const struct attribute_group isl29023_group = {
 	.attrs = isl29023_attributes,
 };
 
-static int isl29035_detect(struct isl29018_chip *chip)
-{
-	int status;
-	unsigned int id;
-	struct device *dev = regmap_get_device(chip->regmap);
-
-	status = regmap_read(chip->regmap, ISL29035_REG_DEVICE_ID, &id);
-	if (status < 0) {
-		dev_err(dev,
-			"Error reading ID register with error %d\n",
-			status);
-		return status;
-	}
-
-	id = (id & ISL29035_DEVICE_ID_MASK) >> ISL29035_DEVICE_ID_SHIFT;
-
-	if (id != ISL29035_DEVICE_ID)
-		return -ENODEV;
-
-	/* Clear brownout bit */
-	return regmap_update_bits(chip->regmap, ISL29035_REG_DEVICE_ID,
-				  ISL29035_BOUT_MASK, 0);
-}
-
 enum {
 	isl29018,
 	isl29023,
@@ -565,7 +541,25 @@ static int isl29018_chip_init(struct isl29018_chip *chip)
 	struct device *dev = regmap_get_device(chip->regmap);
 
 	if (chip->type == isl29035) {
-		status = isl29035_detect(chip);
+		unsigned int id;
+
+		status = regmap_read(chip->regmap, ISL29035_REG_DEVICE_ID, &id);
+		if (status < 0) {
+			dev_err(dev,
+				"Error reading ID register with error %d\n",
+				status);
+			return status;
+		}
+
+		id = (id & ISL29035_DEVICE_ID_MASK) >> ISL29035_DEVICE_ID_SHIFT;
+
+		if (id != ISL29035_DEVICE_ID)
+			return -ENODEV;
+
+		/* Clear brownout bit */
+		status = regmap_update_bits(chip->regmap,
+					    ISL29035_REG_DEVICE_ID,
+					    ISL29035_BOUT_MASK, 0);
 		if (status < 0)
 			return status;
 	}
-- 
2.5.5
