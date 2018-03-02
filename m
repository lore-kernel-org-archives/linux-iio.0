Return-Path: <SRS0=gG0f=FY=gmail.com=shreeya.patel23498@kernel.org>
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	daniel.baluta@gmail.com
Cc: Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: [PATCH 6/6] Staging: iio: adis16209: Use sign_extend32 and adjust a switch statement
Date: Fri,  2 Mar 2018 19:04:49 +0530
Message-Id: <982b80d683b8c8e8c61cbc5b0864c265ea2ac768.1519995673.git.shreeya.patel23498@gmail.com>
In-Reply-To: <cover.1519995673.git.shreeya.patel23498@gmail.com>
References: <cover.1519995673.git.shreeya.patel23498@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Use sign_extend32 function instead of manually coding it.
Also, adjust a switch block to explicitly match channels
and return -EINVAL as default case which makes the code
semantically more clear.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---
 drivers/staging/iio/accel/adis16209.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
index 7363fd0..5ab44a4 100644
--- a/drivers/staging/iio/accel/adis16209.c
+++ b/drivers/staging/iio/accel/adis16209.c
@@ -150,10 +150,16 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
 		switch (chan->type) {
 		case IIO_VOLTAGE:
 			*val = 0;
-			if (chan->channel == 0)
+			switch (chan->channel) {
+			case 0:
 				*val2 = 305180; /* 0.30518 mV */
-			else
+				break;
+			case 1:
 				*val2 = 610500; /* 0.6105 mV */
+				break;
+			default:
+				return -EINVAL;
+			}
 			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_TEMP:
 			*val = -470;
@@ -197,9 +203,8 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
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
