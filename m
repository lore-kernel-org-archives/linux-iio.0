Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 18/19] staging:iio:tsl2563 add a name attribute under the iio
Date: Mon, 26 Apr 2010 21:08:09 +0100
Message-Id: <1272312490-9791-19-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1272312490-9791-18-git-send-email-jic23@cam.ac.uk>
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
 <1272312490-9791-13-git-send-email-jic23@cam.ac.uk>
 <1272312490-9791-14-git-send-email-jic23@cam.ac.uk>
 <1272312490-9791-15-git-send-email-jic23@cam.ac.uk>
 <1272312490-9791-16-git-send-email-jic23@cam.ac.uk>
 <1272312490-9791-17-git-send-email-jic23@cam.ac.uk>
 <1272312490-9791-18-git-send-email-jic23@cam.ac.uk>
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
