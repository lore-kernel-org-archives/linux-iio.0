Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33093 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752376AbcHXEcn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Aug 2016 00:32:43 -0400
Received: by mail-pf0-f196.google.com with SMTP id i6so424314pfe.0
        for <linux-iio@vger.kernel.org>; Tue, 23 Aug 2016 21:32:43 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH] iio: chemical: ams-iaq-core: remove mutex and replace with iio_device_*_direct_mode helpers
Date: Tue, 23 Aug 2016 21:32:39 -0700
Message-Id: <1472013159-9903-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Using a separate mutex doesn't make sense with the
iio_device_*_direct_mode helpers that use the indio_dev->mlock mutex
that already exists.

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/chemical/ams-iaq-core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/chemical/ams-iaq-core.c b/drivers/iio/chemical/ams-iaq-core.c
index 41a8e6f2e31d..4dd5a4db6a75 100644
--- a/drivers/iio/chemical/ams-iaq-core.c
+++ b/drivers/iio/chemical/ams-iaq-core.c
@@ -36,7 +36,6 @@ struct ams_iaqcore_reading {
 
 struct ams_iaqcore_data {
 	struct i2c_client *client;
-	struct mutex lock;
 	unsigned long last_update;
 
 	struct ams_iaqcore_reading buffer;
@@ -108,7 +107,10 @@ static int ams_iaqcore_read_raw(struct iio_dev *indio_dev,
 	if (mask != IIO_CHAN_INFO_PROCESSED)
 		return -EINVAL;
 
-	mutex_lock(&data->lock);
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
+
 	ret = ams_iaqcore_get_measurement(data);
 
 	if (ret)
@@ -134,7 +136,7 @@ static int ams_iaqcore_read_raw(struct iio_dev *indio_dev,
 	}
 
 err_out:
-	mutex_unlock(&data->lock);
+	iio_device_release_direct_mode(indio_dev);
 
 	return ret;
 }
@@ -160,7 +162,6 @@ static int ams_iaqcore_probe(struct i2c_client *client,
 
 	/* so initial reading will complete */
 	data->last_update = jiffies - HZ;
-	mutex_init(&data->lock);
 
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->info = &ams_iaqcore_info,
-- 
2.7.4

