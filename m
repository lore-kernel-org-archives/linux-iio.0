Return-Path: <SRS0=G8mi=GG=gmail.com=himanshujha199640@kernel.org>
From: Himanshu Jha <himanshujha199640@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	daniel.baluta@gmail.com,
	21cnbao@gmail.com,
	Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH v2 6/9] Staging: iio: accel: adis16201: Use sign_extend32 function
Date: Sat, 17 Mar 2018 01:36:23 +0530
Message-Id: <1521230786-18155-7-git-send-email-himanshujha199640@gmail.com>
In-Reply-To: <1521230786-18155-1-git-send-email-himanshujha199640@gmail.com>
References: <1521230786-18155-1-git-send-email-himanshujha199640@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Use sign_extned32() for 32 bit sign extending rather than hard coding.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
v2:
   -no change in this patch.

 drivers/staging/iio/accel/adis16201.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
index 97150ea..298bf90 100644
--- a/drivers/staging/iio/accel/adis16201.c
+++ b/drivers/staging/iio/accel/adis16201.c
@@ -173,9 +173,8 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
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
 
-- 
2.7.4
