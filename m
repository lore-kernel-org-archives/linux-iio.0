Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:54094 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752614AbdJSUGk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 19 Oct 2017 16:06:40 -0400
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH 09/13] staging: iio: tsl2x7x: correct alignment of parenthesis
Date: Thu, 19 Oct 2017 16:06:28 -0400
Message-Id: <20171019200632.25820-10-masneyb@onstation.org>
In-Reply-To: <20171019200632.25820-1-masneyb@onstation.org>
References: <20171019200632.25820-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Correct error from checkpatch.pl to improve code readibility: Alignment
should match open parenthesis. An unnecessary cast to 'struct
tsl2x7x_lux *' was removed and the return value of static definition of
in_illuminance0_calibscale_available_show() was put on its own line
due to the length of that sysfs attribute.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 886be9aa3c0f..70007117d985 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -521,8 +521,8 @@ static void tsl2x7x_defaults(struct tsl2X7X_chip *chip)
 		       sizeof(chip->pdata->platform_lux_table));
 	else
 		memcpy(chip->tsl2x7x_device_lux,
-		(struct tsl2x7x_lux *)tsl2x7x_default_lux_table_group[chip->id],
-				TSL2X7X_DEFAULT_TABLE_BYTES);
+		       tsl2x7x_default_lux_table_group[chip->id],
+		       TSL2X7X_DEFAULT_TABLE_BYTES);
 }
 
 /**
@@ -867,9 +867,10 @@ static void tsl2x7x_prox_cal(struct iio_dev *indio_dev)
 		tsl2x7x_chip_on(indio_dev);
 }
 
-static ssize_t in_illuminance0_calibscale_available_show(struct device *dev,
-					   struct device_attribute *attr,
-					   char *buf)
+static ssize_t
+in_illuminance0_calibscale_available_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
 {
 	struct tsl2X7X_chip *chip = iio_priv(dev_to_iio_dev(dev));
 
@@ -891,8 +892,8 @@ static IIO_CONST_ATTR(in_illuminance0_integration_time_available,
 		".00272 - .696");
 
 static ssize_t in_illuminance0_target_input_show(struct device *dev,
-					   struct device_attribute *attr,
-					   char *buf)
+						 struct device_attribute *attr,
+						 char *buf)
 {
 	struct tsl2X7X_chip *chip = iio_priv(dev_to_iio_dev(dev));
 
@@ -900,8 +901,8 @@ static ssize_t in_illuminance0_target_input_show(struct device *dev,
 }
 
 static ssize_t in_illuminance0_target_input_store(struct device *dev,
-					    struct device_attribute *attr,
-					    const char *buf, size_t len)
+						  struct device_attribute *attr,
+						  const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
@@ -922,8 +923,8 @@ static ssize_t in_illuminance0_target_input_store(struct device *dev,
 }
 
 static ssize_t in_illuminance0_calibrate_store(struct device *dev,
-				    struct device_attribute *attr,
-				    const char *buf, size_t len)
+					       struct device_attribute *attr,
+					       const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	bool value;
@@ -943,8 +944,8 @@ static ssize_t in_illuminance0_calibrate_store(struct device *dev,
 }
 
 static ssize_t in_illuminance0_lux_table_show(struct device *dev,
-				     struct device_attribute *attr,
-				     char *buf)
+					      struct device_attribute *attr,
+					      char *buf)
 {
 	struct tsl2X7X_chip *chip = iio_priv(dev_to_iio_dev(dev));
 	int i = 0;
@@ -971,8 +972,8 @@ static ssize_t in_illuminance0_lux_table_show(struct device *dev,
 }
 
 static ssize_t in_illuminance0_lux_table_store(struct device *dev,
-				      struct device_attribute *attr,
-				      const char *buf, size_t len)
+					       struct device_attribute *attr,
+					       const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
@@ -1013,8 +1014,8 @@ static ssize_t in_illuminance0_lux_table_store(struct device *dev,
 }
 
 static ssize_t in_proximity0_calibrate_store(struct device *dev,
-					 struct device_attribute *attr,
-					 const char *buf, size_t len)
+					     struct device_attribute *attr,
+					     const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	bool value;
-- 
2.13.6

