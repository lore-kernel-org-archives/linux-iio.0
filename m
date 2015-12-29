Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33832 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756AbbL2Lqy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Dec 2015 06:46:54 -0500
Received: by mail-pf0-f194.google.com with SMTP id 65so8327431pff.1
        for <linux-iio@vger.kernel.org>; Tue, 29 Dec 2015 03:46:54 -0800 (PST)
From: Shraddha Barke <shraddha.6596@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, Shraddha Barke <shraddha.6596@gmail.com>
Subject: [PATCH 3/5] Staging: iio: cdc: ad7152: Fix alignment should match open parenthesis
Date: Tue, 29 Dec 2015 16:57:29 +0530
Message-Id: <1451388451-10342-4-git-send-email-shraddha.6596@gmail.com>
In-Reply-To: <1451388451-10342-1-git-send-email-shraddha.6596@gmail.com>
References: <1451388451-10342-1-git-send-email-shraddha.6596@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix checkpatch warning of "Alignment should match open parenthesis".

Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>
---
 drivers/staging/iio/cdc/ad7152.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
index 472836d..15bbbe5 100644
--- a/drivers/staging/iio/cdc/ad7152.c
+++ b/drivers/staging/iio/cdc/ad7152.c
@@ -166,8 +166,8 @@ static const unsigned char ad7152_filter_rate_table[][2] = {
 };
 
 static ssize_t ad7152_show_filter_rate_setup(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+					     struct device_attribute *attr,
+					     char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7152_chip_info *chip = iio_priv(indio_dev);
@@ -177,9 +177,9 @@ static ssize_t ad7152_show_filter_rate_setup(struct device *dev,
 }
 
 static ssize_t ad7152_store_filter_rate_setup(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+					      struct device_attribute *attr,
+					      const char *buf,
+					      size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7152_chip_info *chip = iio_priv(indio_dev);
@@ -199,7 +199,7 @@ static ssize_t ad7152_store_filter_rate_setup(struct device *dev,
 
 	mutex_lock(&indio_dev->mlock);
 	ret = i2c_smbus_write_byte_data(chip->client,
-			AD7152_REG_CFG2, AD7152_CFG2_OSR(i));
+					AD7152_REG_CFG2, AD7152_CFG2_OSR(i));
 	if (ret < 0) {
 		mutex_unlock(&indio_dev->mlock);
 		return ret;
@@ -268,8 +268,8 @@ static int ad7152_write_raw(struct iio_dev *indio_dev,
 		val = (val2 * 1024) / 15625;
 
 		ret = i2c_smbus_write_word_data(chip->client,
-				ad7152_addresses[chan->channel][AD7152_GAIN],
-				swab16(val));
+						ad7152_addresses[chan->channel][AD7152_GAIN],
+						swab16(val));
 		if (ret < 0)
 			goto out;
 
@@ -282,8 +282,8 @@ static int ad7152_write_raw(struct iio_dev *indio_dev,
 			goto out;
 		}
 		ret = i2c_smbus_write_word_data(chip->client,
-				ad7152_addresses[chan->channel][AD7152_OFFS],
-				swab16(val));
+						ad7152_addresses[chan->channel][AD7152_OFFS],
+						swab16(val));
 		if (ret < 0)
 			goto out;
 
@@ -302,8 +302,8 @@ static int ad7152_write_raw(struct iio_dev *indio_dev,
 		chip->setup[chan->channel] |= AD7152_SETUP_RANGE(i);
 
 		ret = i2c_smbus_write_byte_data(chip->client,
-				ad7152_addresses[chan->channel][AD7152_SETUP],
-				chip->setup[chan->channel]);
+						ad7152_addresses[chan->channel][AD7152_SETUP],
+						chip->setup[chan->channel]);
 		if (ret < 0)
 			goto out;
 
-- 
2.1.4

