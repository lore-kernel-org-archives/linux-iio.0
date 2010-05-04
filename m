Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: gregkh@suse.de
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 17/20] staging:iio:tsl2563 add a name attribute under the iio
Date: Tue,  4 May 2010 14:43:12 +0100
Message-Id: <1272980595-11033-18-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1272980595-11033-17-git-send-email-jic23@cam.ac.uk>
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
 <1272980595-11033-13-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-14-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-15-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-16-git-send-email-jic23@cam.ac.uk>
 <1272980595-11033-17-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/light/tsl2563.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index 911c898..da3d51c 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -598,12 +598,24 @@ static DEVICE_ATTR(calib0, S_IRUGO | S_IWUSR,
 static DEVICE_ATTR(calib1, S_IRUGO | S_IWUSR,
 		   tsl2563_calib1_show, tsl2563_calib1_store);
 
+static ssize_t tsl2563_show_name(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct tsl2563_chip *chip = indio_dev->dev_data;
+	return sprintf(buf, "%s\n", chip->client->name);
+}
+
+DEVICE_ATTR(name, S_IRUGO, tsl2563_show_name, NULL);
+
 static struct attribute *tsl2563_attributes[] = {
 	&dev_attr_adc0.attr,
 	&dev_attr_adc1.attr,
 	&dev_attr_illuminance0_input.attr,
 	&dev_attr_calib0.attr,
 	&dev_attr_calib1.attr,
+	&dev_attr_name.attr,
 	NULL
 };
 
-- 
1.6.4.4
