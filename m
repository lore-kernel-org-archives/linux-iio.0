Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 12/13] staging:iio:tsl2563: change lux to illuminance0_input to match new abi
Date: Sun, 28 Mar 2010 21:41:18 +0100
Message-Id: <1269808879-28838-13-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1269808879-28838-12-git-send-email-jic23@cam.ac.uk>
References: <1269808879-28838-1-git-send-email-jic23@cam.ac.uk>
 <1269808879-28838-2-git-send-email-jic23@cam.ac.uk>
 <1269808879-28838-3-git-send-email-jic23@cam.ac.uk>
 <1269808879-28838-4-git-send-email-jic23@cam.ac.uk>
 <1269808879-28838-5-git-send-email-jic23@cam.ac.uk>
 <1269808879-28838-6-git-send-email-jic23@cam.ac.uk>
 <1269808879-28838-7-git-send-email-jic23@cam.ac.uk>
 <1269808879-28838-8-git-send-email-jic23@cam.ac.uk>
 <1269808879-28838-9-git-send-email-jic23@cam.ac.uk>
 <1269808879-28838-10-git-send-email-jic23@cam.ac.uk>
 <1269808879-28838-11-git-send-email-jic23@cam.ac.uk>
 <1269808879-28838-12-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
This isn't technically part of the new abi as we didn't allow for
_input type values.  This syntax is lifted from hwmon to allow
for slow devices with complex conversion functions where it
actually makes sense to convert to standard units in kernel.

The other tsl2563 parameters still needs updating appropriately
but this requires some thought about the abi for light sensors

 drivers/staging/iio/light/tsl2563.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index 78b9432..ca7364b 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -591,7 +591,7 @@ static ssize_t tsl2563_calib1_store(struct device *dev,
  * once I understand what they mean */
 static DEVICE_ATTR(adc0, S_IRUGO, tsl2563_adc0_show, NULL);
 static DEVICE_ATTR(adc1, S_IRUGO, tsl2563_adc1_show, NULL);
-static DEVICE_ATTR(lux, S_IRUGO, tsl2563_lux_show, NULL);
+static DEVICE_ATTR(illuminance0_input, S_IRUGO, tsl2563_lux_show, NULL);
 static DEVICE_ATTR(calib0, S_IRUGO | S_IWUSR,
 		   tsl2563_calib0_show, tsl2563_calib0_store);
 static DEVICE_ATTR(calib1, S_IRUGO | S_IWUSR,
@@ -600,7 +600,7 @@ static DEVICE_ATTR(calib1, S_IRUGO | S_IWUSR,
 static struct attribute *tsl2563_attributes[] = {
 	&dev_attr_adc0.attr,
 	&dev_attr_adc1.attr,
-	&dev_attr_lux.attr,
+	&dev_attr_illuminance0_input.attr,
 	&dev_attr_calib0.attr,
 	&dev_attr_calib1.attr,
 	NULL
-- 
1.6.4.4
