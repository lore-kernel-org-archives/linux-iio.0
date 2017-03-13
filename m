Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34974 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751988AbdCNOUE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Mar 2017 10:20:04 -0400
Received: by mail-pg0-f67.google.com with SMTP id g2so20317726pge.2
        for <linux-iio@vger.kernel.org>; Tue, 14 Mar 2017 07:20:03 -0700 (PDT)
Date: Tue, 14 Mar 2017 03:34:25 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org
Subject: [PATCH] staging: iio: cdc: replace mlock with driver private lock
Message-ID: <20170313220425.GA30482@aishwarya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The IIO subsystem is redefining iio_dev mlock to be used by IIO core
only for protecting device operating mode changes.

In driver ad7746 wherever mlock was used to protect hardware state
changes, it has been replaced with a driver private lock.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---
 drivers/staging/iio/cdc/ad7746.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 81f8b9e..6e3f99c 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -91,6 +91,7 @@
 
 struct ad7746_chip_info {
 	struct i2c_client *client;
+	struct mutex lock; /* protect sensor state */
 	/*
 	 * Capacitive channel digital filter setup;
 	 * conversion time/update rate setup per channel
@@ -298,11 +299,11 @@ static inline ssize_t ad7746_start_calib(struct device *dev,
 	if (!doit)
 		return 0;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&chip->lock);
 	regval |= chip->config;
 	ret = i2c_smbus_write_byte_data(chip->client, AD7746_REG_CFG, regval);
 	if (ret < 0) {
-		mutex_unlock(&indio_dev->mlock);
+		mutex_unlock(&chip->lock);
 		return ret;
 	}
 
@@ -310,12 +311,12 @@ static inline ssize_t ad7746_start_calib(struct device *dev,
 		msleep(20);
 		ret = i2c_smbus_read_byte_data(chip->client, AD7746_REG_CFG);
 		if (ret < 0) {
-			mutex_unlock(&indio_dev->mlock);
+			mutex_unlock(&chip->lock);
 			return ret;
 		}
 	} while ((ret == regval) && timeout--);
 
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&chip->lock);
 
 	return len;
 }
@@ -426,7 +427,7 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
 	struct ad7746_chip_info *chip = iio_priv(indio_dev);
 	int ret, reg;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&chip->lock);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_CALIBSCALE:
@@ -521,7 +522,7 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
 	}
 
 out:
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&chip->lock);
 	return ret;
 }
 
@@ -534,7 +535,7 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 	int ret, delay, idx;
 	u8 regval, reg;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&chip->lock);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -658,7 +659,7 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 		ret = -EINVAL;
 	}
 out:
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&chip->lock);
 	return ret;
 }
 
@@ -686,6 +687,7 @@ static int ad7746_probe(struct i2c_client *client,
 	if (!indio_dev)
 		return -ENOMEM;
 	chip = iio_priv(indio_dev);
+	mutex_init(&chip->lock);
 	/* this is only used for device removal purposes */
 	i2c_set_clientdata(client, indio_dev);
 
-- 
2.7.4

