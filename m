Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 12/19] staging:iio:tsl2563: change lux to illuminanc0_input to match new abi
Date: Mon, 26 Apr 2010 21:08:03 +0100
Message-Id: <1272312490-9791-13-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1272312490-9791-12-git-send-email-jic23@cam.ac.uk>
References: <1272312490-9791-1-git-send-email-jic23@cam.ac.uk>
 <1272312490-9791-2-git-send-email-jic23@cam.ac.uk>
 <1272312490-9791-3-git-send-email-jic23@cam.ac.uk>
 <1272312490-9791-4-git-send-email-jic23@cam.ac.uk>
 <1272312490-9791-5-git-send-email-jic23@cam.ac.uk>
 <1272312490-9791-6-git-send-email-jic23@cam.ac.uk>
 <1272312490-9791-7-git-send-email-jic23@cam.ac.uk>
 <1272312490-9791-8-git-send-email-jic23@cam.ac.uk>
 <1272312490-9791-9-git-send-email-jic23@cam.ac.uk>
 <1272312490-9791-10-git-send-email-jic23@cam.ac.uk>
 <1272312490-9791-11-git-send-email-jic23@cam.ac.uk>
 <1272312490-9791-12-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/light/tsl2563.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index 1ba4aa3..911c898 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -592,7 +592,7 @@ static ssize_t tsl2563_calib1_store(struct device *dev,
  * once I understand what they mean */
 static DEVICE_ATTR(adc0, S_IRUGO, tsl2563_adc0_show, NULL);
 static DEVICE_ATTR(adc1, S_IRUGO, tsl2563_adc1_show, NULL);
-static DEVICE_ATTR(lux, S_IRUGO, tsl2563_lux_show, NULL);
+static DEVICE_ATTR(illuminance0_input, S_IRUGO, tsl2563_lux_show, NULL);
 static DEVICE_ATTR(calib0, S_IRUGO | S_IWUSR,
 		   tsl2563_calib0_show, tsl2563_calib0_store);
 static DEVICE_ATTR(calib1, S_IRUGO | S_IWUSR,
@@ -601,7 +601,7 @@ static DEVICE_ATTR(calib1, S_IRUGO | S_IWUSR,
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
