Return-Path: <Johannes.Tenschert@informatik.stud.uni-erlangen.de>
From: Johannes Tenschert <Johannes.Tenschert@informatik.stud.uni-erlangen.de>
To: devel@linuxdriverproject.org
Cc: jic23@cam.ac.uk,
	gregkh@suse.de,
	jbrenner@taosinc.com,
	linux-iio@vger.kernel.org,
	Johannes Tenschert <Johannes.Tenschert@informatik.stud.uni-erlangen.de>
Subject: [PATCH v2 1/2] staging: iio: light: isl29018.c: obsolete use of strict_strtoul
Date: Tue, 13 Dec 2011 00:38:21 +0100
Message-Id: <1323733102-7868-2-git-send-email-Johannes.Tenschert@informatik.stud.uni-erlangen.de>
In-Reply-To: <1323733102-7868-1-git-send-email-Johannes.Tenschert@informatik.stud.uni-erlangen.de>
References: <1323733102-7868-1-git-send-email-Johannes.Tenschert@informatik.stud.uni-erlangen.de>
List-ID: <linux-iio@vger.kernel.org>

The function strict_strtoul is obsolete and replaced by kstrtoul
and kstrtoint.

If kstrto* fails its return code is returned instead of -EINVAL.

Signed-off-by: Johannes Tenschert <Johannes.Tenschert@informatik.stud.uni-erlangen.de>
---
 drivers/staging/iio/light/isl29018.c |   24 +++++++++++++++---------
 1 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index 849d6a5..9806495 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -253,9 +253,11 @@ static ssize_t store_range(struct device *dev,
 	int status;
 	unsigned long lval;
 	unsigned int new_range;
+	int ret;
 
-	if (strict_strtoul(buf, 10, &lval))
-		return -EINVAL;
+	ret = kstrtoul(buf, 10, &lval);
+	if (ret)
+		return ret;
 
 	if (!(lval == 1000UL || lval == 4000UL ||
 			lval == 16000UL || lval == 64000UL)) {
@@ -295,9 +297,11 @@ static ssize_t store_resolution(struct device *dev,
 	int status;
 	unsigned long lval;
 	unsigned int new_adc_bit;
+	int ret;
 
-	if (strict_strtoul(buf, 10, &lval))
-		return -EINVAL;
+	ret = kstrtoul(buf, 10, &lval);
+	if (ret)
+		return ret;
 	if (!(lval == 4 || lval == 8 || lval == 12 || lval == 16)) {
 		dev_err(dev, "The resolution is not supported\n");
 		return -EINVAL;
@@ -333,11 +337,13 @@ static ssize_t store_prox_infrared_supression(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct isl29018_chip *chip = iio_priv(indio_dev);
-	unsigned long lval;
+	int val;
+	int ret;
 
-	if (strict_strtoul(buf, 10, &lval))
-		return -EINVAL;
-	if (!(lval == 0UL || lval == 1UL)) {
+	ret = kstrtoint(buf, 10, &val);
+	if (ret)
+		return ret;
+	if (!(val == 0 || val == 1)) {
 		dev_err(dev, "The mode is not supported\n");
 		return -EINVAL;
 	}
@@ -345,7 +351,7 @@ static ssize_t store_prox_infrared_supression(struct device *dev,
 	/* get the  "proximity scheme" i.e. if the chip does on chip
 	infrared supression (1 means perform on chip supression) */
 	mutex_lock(&chip->lock);
-	chip->prox_scheme = (int)lval;
+	chip->prox_scheme = val;
 	mutex_unlock(&chip->lock);
 
 	return count;
-- 
1.7.5.4
