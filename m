Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42423 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbeBQQVj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 17 Feb 2018 11:21:39 -0500
Received: by mail-pl0-f65.google.com with SMTP id 31so3331648ple.9
        for <linux-iio@vger.kernel.org>; Sat, 17 Feb 2018 08:21:39 -0800 (PST)
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, daniel.baluta@nxp.com
Cc: Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: [PATCH 3/3] Staging: iio: adis16209: Use sign_extend32 and adjust a switch statement
Date: Sat, 17 Feb 2018 21:51:35 +0530
Message-Id: <317f97b7a3b53bf3ae1457d7c38f78befc4b99db.1518883035.git.shreeya.patel23498@gmail.com>
In-Reply-To: <cover.1518883035.git.shreeya.patel23498@gmail.com>
References: <cover.1518883035.git.shreeya.patel23498@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use sign_extend32 function instead of manually coding it. Also, adjust a
switch block to explicitly match channels and return -EINVAL as default
case which improves code readability.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---
 drivers/staging/iio/accel/adis16209.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
index 6101212..f7c228b 100644
--- a/drivers/staging/iio/accel/adis16209.c
+++ b/drivers/staging/iio/accel/adis16209.c
@@ -150,10 +150,16 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
 		switch (chan->type) {
 		case IIO_VOLTAGE:
 			*val = 0;
-			if (chan->channel == 0)
+			switch (chan->channel) {
+			case 0:
 				*val2 = 305180;
-			else
+				break;
+			case 1:
 				*val2 = 610500;
+				break;
+			default:
+				return -EINVAL;
+			}
 			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_TEMP:
 			*val = -470;
@@ -187,9 +193,8 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
 		ret = adis_read_reg_16(st, addr, &val16);
 		if (ret)
 			return ret;
-		val16 &= (1 << bits) - 1;
-		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
-		*val = val16;
+
+		*val = sign_extend32(val16, bits - 1);
 		return IIO_VAL_INT;
 	}
 	return -EINVAL;
-- 
2.7.4

