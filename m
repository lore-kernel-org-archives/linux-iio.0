Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33134 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbbIWEZM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 23 Sep 2015 00:25:12 -0400
Received: by pacex6 with SMTP id ex6so28789191pac.0
        for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2015 21:25:11 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH] iio: chemical: vz89x hardware i2c workaround
Date: Tue, 22 Sep 2015 21:25:09 -0700
Message-Id: <1442982309-3925-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Chipset sometime updates in the middle of a reading causing it
to reset the data pointer, and causing invalid reading of previous data.

We can check for this invalid state by reading MSB of the resistance
reading that is always zero, and by also confirming the VOC_short isn't
zero.

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/chemical/vz89x.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/chemical/vz89x.c b/drivers/iio/chemical/vz89x.c
index b454200..11e59a5 100644
--- a/drivers/iio/chemical/vz89x.c
+++ b/drivers/iio/chemical/vz89x.c
@@ -85,6 +85,21 @@ static const struct attribute_group vz89x_attrs_group = {
 	.attrs = vz89x_attributes,
 };
 
+/*
+ * Chipset sometime updates in the middle of a reading causing it to reset the
+ * data pointer, and causing invalid reading of previous data.
+ * We can check for this by reading MSB of the resistance reading that is
+ * always zero, and by also confirming the VOC_short isn't zero.
+ */
+
+static int vz89x_measurement_is_valid(struct vz89x_data *data)
+{
+	if (data->buffer[VZ89X_VOC_SHORT_IDX] == 0)
+		return 1;
+
+	return !!(data->buffer[VZ89X_REG_MEASUREMENT_SIZE - 1] > 0);
+}
+
 static int vz89x_get_measurement(struct vz89x_data *data)
 {
 	int ret;
@@ -106,6 +121,10 @@ static int vz89x_get_measurement(struct vz89x_data *data)
 		data->buffer[i] = ret;
 	}
 
+	ret = vz89x_measurement_is_valid(data);
+	if (ret)
+		return -EAGAIN;
+
 	data->last_update = jiffies;
 
 	return 0;
@@ -113,9 +132,9 @@ static int vz89x_get_measurement(struct vz89x_data *data)
 
 static int vz89x_get_resistance_reading(struct vz89x_data *data)
 {
-	u8 *buf = &data->buffer[VZ89X_VOC_TVOC_IDX];
+	u8 *buf = &data->buffer[VZ89X_VOC_RESISTANCE_IDX];
 
-	return buf[0] | (buf[1] << 8) | (buf[2] << 16);
+	return buf[0] | (buf[1] << 8);
 }
 
 static int vz89x_read_raw(struct iio_dev *indio_dev,
-- 
1.9.1

