Return-Path: <SRS0=sxJY=FG=gmail.com=himanshujha199640@kernel.org>
From: Himanshu Jha <himanshujha199640@gmail.com>
To: 21cnbao@gmail.com,
	jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH 3/4] staging: iio: accel: Use sign_extend32 and adjust a switch statement
Date: Mon, 12 Feb 2018 17:24:58 +0530
Message-Id: <1518436499-8584-4-git-send-email-himanshujha199640@gmail.com>
In-Reply-To: <1518436499-8584-1-git-send-email-himanshujha199640@gmail.com>
References: <1518436499-8584-1-git-send-email-himanshujha199640@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Use sign_extend32 function instead of manually coding it. Also, adjust a
switch block to explicitly match channels and return -EINVAL as default
case which improves code readability.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/staging/iio/accel/adis16201.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
index 011d2c5..6800347 100644
--- a/drivers/staging/iio/accel/adis16201.c
+++ b/drivers/staging/iio/accel/adis16201.c
@@ -112,12 +112,17 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_VOLTAGE:
-			if (chan->channel == 0) {
+			switch (chan->channel) {
+			case 0:
 				*val = 1;
 				*val2 = 220000;
-			} else {
+				break;
+			case 1:
 				*val = 0;
 				*val2 = 610000;
+				break;
+			default:
+				return -EINVAL;
 			}
 			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_TEMP:
@@ -155,9 +160,7 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 
-		val16 &= (1 << bits) - 1;
-		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
-		*val = val16;
+		*val = sign_extend32(val16, bits - 1);
 		return IIO_VAL_INT;
 	}
 
-- 
2.7.4
