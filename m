Return-Path: <SRS0=kktx=I4=gmail.com=karim.eshapa@kernel.org>
From: Karim Eshapa <karim.eshapa@gmail.com>
To: lars@metafoo.de
Cc: Michael.Hennerich@analog.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Karim Eshapa <karim.eshapa@gmail.com>
Subject: [PATCH] staging:iio:accel: use sign extend function avoiding code duplication
Date: Mon, 11 Jun 2018 00:09:20 +0200
Message-Id: <20180610220920.12244-1-karim.eshapa@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Use sign_extend32 kernel function instead of code duplication.
This function is also safe for 16 bits.

Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
---
 drivers/staging/iio/accel/adis16201.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
index 0fae8aaf1cf4..fe4494e65395 100644
--- a/drivers/staging/iio/accel/adis16201.c
+++ b/drivers/staging/iio/accel/adis16201.c
@@ -227,9 +227,7 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
 		ret = adis_read_reg_16(st, addr, &val16);
 		if (ret)
 			return ret;
-		val16 &= (1 << bits) - 1;
-		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
-		*val = val16;
+		*val = sign_extend32(val16, bits);
 		return IIO_VAL_INT;
 	}
 
-- 
2.17.1
