Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-43.csi.cam.ac.uk ([131.111.8.143]:57929 "EHLO
	ppsw-43.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760010Ab0EDNkV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 May 2010 09:40:21 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: gregkh@suse.de
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 12/20] staging:iio:tsl2563: change lux to illuminance0_input to match new abi
Date: Tue,  4 May 2010 14:43:07 +0100
Message-Id: <1272980595-11033-13-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1272980595-11033-12-git-send-email-jic23@cam.ac.uk>
References: <1272980595-11033-1-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-2-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-3-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-4-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-5-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-6-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-7-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-8-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-9-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-10-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-11-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-12-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

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

