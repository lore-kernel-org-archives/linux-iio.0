Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:58865 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757965Ab1GKP6N (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jul 2011 11:58:13 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Device-drivers-devel@blackfin.uclinux.org,
	manuel.stahl@iis.fraunhofer.de, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 3/4] staging:iio:imu:adis16400: use strtobool for reset sysfs and don't assign unused tx members.
Date: Mon, 11 Jul 2011 16:58:06 +0100
Message-Id: <1310399887-4049-4-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1310399887-4049-1-git-send-email-jic23@cam.ac.uk>
References: <1310399887-4049-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/imu/adis16400_core.c |   23 +++++++++++------------
 1 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index f034330..75d4734 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -146,8 +146,6 @@ static int adis16400_spi_read_reg_16(struct iio_dev *indio_dev,
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = ADIS16400_READ_REG(lower_reg_address);
 	st->tx[1] = 0;
-	st->tx[2] = 0;
-	st->tx[3] = 0;
 
 	spi_message_init(&msg);
 	spi_message_add_tail(&xfers[0], &msg);
@@ -236,17 +234,18 @@ static ssize_t adis16400_write_reset(struct device *dev,
 		struct device_attribute *attr,
 		const char *buf, size_t len)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	bool val;
+	int ret;
 
-	if (len < 1)
-		return -1;
-	switch (buf[0]) {
-	case '1':
-	case 'y':
-	case 'Y':
-		return adis16400_reset(indio_dev);
-	}
-	return -1;
+	ret = strtobool(buf, &val);
+	if (ret < 0)
+		return ret;
+	if (val)
+		ret = adis16400_reset(dev_get_drvdata(dev));
+	if (ret < 0)
+		return ret;
+
+	return len;
 }
 
 int adis16400_set_irq(struct iio_dev *indio_dev, bool enable)
-- 
1.7.3.4

