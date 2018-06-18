Return-Path: <SRS0=/ZAZ=JE=gmail.com=karim.eshapa@kernel.org>
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
Subject: [PATCH v3] staging:iio:accel:adis16240: sign extend function replace hard code duplication
Date: Mon, 18 Jun 2018 19:44:50 +0200
Message-Id: <20180618174450.3399-1-karim.eshapa@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Use sign_extend32 kernel function instead of code duplication,
Safe also for 16 bit. and remove declaration of bits variable not needed.

Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
---
 drivers/staging/iio/accel/adis16240.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
index fff6d99089cc..24e525f1ef25 100644
--- a/drivers/staging/iio/accel/adis16240.c
+++ b/drivers/staging/iio/accel/adis16240.c
@@ -250,7 +250,6 @@ static int adis16240_read_raw(struct iio_dev *indio_dev,
 {
 	struct adis *st = iio_priv(indio_dev);
 	int ret;
-	int bits;
 	u8 addr;
 	s16 val16;
 
@@ -287,24 +286,18 @@ static int adis16240_read_raw(struct iio_dev *indio_dev,
 		*val = 25000 / 244 - 0x133; /* 25 C = 0x133 */
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_CALIBBIAS:
-		bits = 10;
 		addr = adis16240_addresses[chan->scan_index][0];
 		ret = adis_read_reg_16(st, addr, &val16);
 		if (ret)
 			return ret;
-		val16 &= (1 << bits) - 1;
-		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
-		*val = val16;
+		*val = sign_extend32(val16, 9);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_PEAK:
-		bits = 10;
 		addr = adis16240_addresses[chan->scan_index][1];
 		ret = adis_read_reg_16(st, addr, &val16);
 		if (ret)
 			return ret;
-		val16 &= (1 << bits) - 1;
-		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
-		*val = val16;
+		*val = sign_extend32(val16, 9);
 		return IIO_VAL_INT;
 	}
 	return -EINVAL;
-- 
2.17.1
