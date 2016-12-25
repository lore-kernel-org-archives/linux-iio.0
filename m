Return-Path: <SRS0=yNKi=YI=matheina.com=scott@kernel.org>
From: Scott Matheina <scott@matheina.com>
To: linux-kernel@vger.kernel.org
Cc: Scott Matheina <scott@matheina.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org
Subject: [PATCHv4 6/8] Fixed code wrap alignment with preceding (.
Date: Sun, 25 Dec 2016 13:56:44 -0600
Message-Id: <1482696216-8013-7-git-send-email-scott@matheina.com>
In-Reply-To: <1482696216-8013-1-git-send-email-scott@matheina.com>
References: <1482696216-8013-1-git-send-email-scott@matheina.com>
List-ID: <linux-iio@vger.kernel.org>

The code wasn't aligned with preceding ( on following lines, fixes
this coding style issue.

Signed-off-by: Scott Matheina <scott@matheina.com>
---
 drivers/staging/iio/addac/adt7316.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 4678a64..91ac222 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -317,8 +317,8 @@ static IIO_DEVICE_ATTR(select_ex_temp, S_IRUGO | S_IWUSR,
 		0);
 
 static ssize_t adt7316_show_mode(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				 struct device_attribute *attr,
+				 char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -358,8 +358,8 @@ static IIO_DEVICE_ATTR(mode, S_IRUGO | S_IWUSR,
 		0);
 
 static ssize_t adt7316_show_all_modes(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				      struct device_attribute *attr,
+				      char *buf)
 {
 	return sprintf(buf, "single_channel\nround_robin\n");
 }
@@ -367,8 +367,8 @@ static ssize_t adt7316_show_all_modes(struct device *dev,
 static IIO_DEVICE_ATTR(all_modes, S_IRUGO, adt7316_show_all_modes, NULL, 0);
 
 static ssize_t adt7316_show_ad_channel(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				       struct device_attribute *attr,
+				       char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -383,7 +383,7 @@ static ssize_t adt7316_show_ad_channel(struct device *dev,
 		return sprintf(buf, "1 - Internal Temperature\n");
 	case ADT7316_AD_SINGLE_CH_EX:
 		if (((chip->id & ID_FAMILY_MASK) == ID_ADT75XX) &&
-			(chip->config1 & ADT7516_SEL_AIN1_2_EX_TEMP_MASK) == 0)
+		    (chip->config1 & ADT7516_SEL_AIN1_2_EX_TEMP_MASK) == 0)
 			return sprintf(buf, "2 - AIN1\n");
 
 		return sprintf(buf, "2 - External Temperature\n");
@@ -451,8 +451,8 @@ static IIO_DEVICE_ATTR(ad_channel, S_IRUGO | S_IWUSR,
 		0);
 
 static ssize_t adt7316_show_all_ad_channels(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+					    struct device_attribute *attr,
+					    char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -472,8 +472,8 @@ static IIO_DEVICE_ATTR(all_ad_channels, S_IRUGO,
 		adt7316_show_all_ad_channels, NULL, 0);
 
 static ssize_t adt7316_show_disable_averaging(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+					      struct device_attribute *attr,
+					      char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -511,8 +511,8 @@ static IIO_DEVICE_ATTR(disable_averaging, S_IRUGO | S_IWUSR,
 		0);
 
 static ssize_t adt7316_show_enable_smbus_timeout(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+						 struct device_attribute *attr,
+						 char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -550,8 +550,8 @@ static IIO_DEVICE_ATTR(enable_smbus_timeout, S_IRUGO | S_IWUSR,
 		0);
 
 static ssize_t adt7316_show_powerdown(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				      struct device_attribute *attr,
+				      char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -588,8 +588,8 @@ static IIO_DEVICE_ATTR(powerdown, S_IRUGO | S_IWUSR,
 		0);
 
 static ssize_t adt7316_show_fast_ad_clock(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+					  struct device_attribute *attr,
+					  char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
-- 
2.7.4
