Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37849 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755406AbeCHJsR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Mar 2018 04:48:17 -0500
Received: by mail-wm0-f65.google.com with SMTP id 139so9868181wmn.2
        for <linux-iio@vger.kernel.org>; Thu, 08 Mar 2018 01:48:17 -0800 (PST)
Date: Thu, 8 Mar 2018 10:48:13 +0100
From: David Veenstra <davidjulianveenstra@gmail.com>
To: lars@metafoo.de
Cc: linux-iio@vger.kernel.org
Subject: [PATCH] Staging: iio: ad7746: Adjust arguments to match open
 parenthesis
Message-ID: <20180308094813.GA11596@zenbook-arch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch clears all checkpatch.pl CHECKS, about alignment not matching
open parenthesis, whenever it is possible without going beyond 80 columns.

Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
---
 drivers/staging/iio/cdc/ad7746.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index c4a864725376..4882dbc81c53 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -217,7 +217,7 @@ static const unsigned char ad7746_cap_filter_rate_table[][2] = {
 };
 
 static int ad7746_select_channel(struct iio_dev *indio_dev,
-			    struct iio_chan_spec const *chan)
+				 struct iio_chan_spec const *chan)
 {
 	struct ad7746_chip_info *chip = iio_priv(indio_dev);
 	int ret, delay, idx;
@@ -487,13 +487,13 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
 			AD7746_CAPDAC_DACP(val) | AD7746_CAPDAC_DACEN : 0;
 
 		ret = i2c_smbus_write_byte_data(chip->client,
-			AD7746_REG_CAPDACA,
-			chip->capdac[chan->channel][0]);
+						AD7746_REG_CAPDACA,
+						chip->capdac[chan->channel][0]);
 		if (ret < 0)
 			goto out;
 		ret = i2c_smbus_write_byte_data(chip->client,
-			AD7746_REG_CAPDACB,
-			chip->capdac[chan->channel][1]);
+						AD7746_REG_CAPDACB,
+						chip->capdac[chan->channel][1]);
 		if (ret < 0)
 			goto out;
 
@@ -675,7 +675,7 @@ static const struct iio_info ad7746_info = {
  */
 
 static int ad7746_probe(struct i2c_client *client,
-		const struct i2c_device_id *id)
+			const struct i2c_device_id *id)
 {
 	struct ad7746_platform_data *pdata = client->dev.platform_data;
 	struct ad7746_chip_info *chip;
-- 
2.16.2

