Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:42389 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752997AbeDMQhp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Apr 2018 12:37:45 -0400
Received: by mail-qt0-f196.google.com with SMTP id j3so8640017qtn.9
        for <linux-iio@vger.kernel.org>; Fri, 13 Apr 2018 09:37:45 -0700 (PDT)
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
Subject: [PATCH v2 01/14] staging: iio: ad7746: Automatically swap values in readings/writings
Date: Fri, 13 Apr 2018 13:36:38 -0300
Message-Id: <1523637411-8531-2-git-send-email-hernan@vanguardiasur.com.ar>
In-Reply-To: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Data to read or write was being handled with the swab16() macro instead
of using i2c_smbus_{read,write}_swapped.

Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
---
 drivers/staging/iio/cdc/ad7746.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 4882dbc..53e28ae 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -451,7 +451,7 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
 			goto out;
 		}
 
-		ret = i2c_smbus_write_word_data(chip->client, reg, swab16(val));
+		ret = i2c_smbus_write_word_swapped(chip->client, reg, val);
 		if (ret < 0)
 			goto out;
 
@@ -462,8 +462,8 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
 			ret = -EINVAL;
 			goto out;
 		}
-		ret = i2c_smbus_write_word_data(chip->client,
-				AD7746_REG_CAP_OFFH, swab16(val));
+		ret = i2c_smbus_write_word_swapped(chip->client,
+						   AD7746_REG_CAP_OFFH, val);
 		if (ret < 0)
 			goto out;
 
@@ -594,21 +594,21 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 			goto out;
 		}
 
-		ret = i2c_smbus_read_word_data(chip->client, reg);
+		ret = i2c_smbus_read_word_swapped(chip->client, reg);
 		if (ret < 0)
 			goto out;
 		/* 1 + gain_val / 2^16 */
 		*val = 1;
-		*val2 = (15625 * swab16(ret)) / 1024;
+		*val2 = (15625 * ret) / 1024;
 
 		ret = IIO_VAL_INT_PLUS_MICRO;
 		break;
 	case IIO_CHAN_INFO_CALIBBIAS:
-		ret = i2c_smbus_read_word_data(chip->client,
-					       AD7746_REG_CAP_OFFH);
+		ret = i2c_smbus_read_word_swapped(chip->client,
+						  AD7746_REG_CAP_OFFH);
 		if (ret < 0)
 			goto out;
-		*val = swab16(ret);
+		*val = ret;
 
 		ret = IIO_VAL_INT;
 		break;
-- 
2.7.4

