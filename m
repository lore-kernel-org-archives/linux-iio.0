Return-Path: <SRS0=2H+Q=GT=gmail.com=shreeya.patel23498@kernel.org>
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	daniel.baluta@gmail.com
Cc: Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: [PATCH v6 5/6] Staging: iio: adis16209: Use GENMASK
Date: Thu, 29 Mar 2018 14:51:19 +0530
Message-Id: <5d43c34c95f3b58f5b79254ae67bf7a080f39a92.1522306893.git.shreeya.patel23498@gmail.com>
In-Reply-To: <cover.1522306893.git.shreeya.patel23498@gmail.com>
References: <cover.1522306893.git.shreeya.patel23498@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Use GENMASK to improve readability and remove the local
variables used to store intermediate data.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---

Changes in v6
  -Introduce this new patch in the series.

 drivers/staging/iio/accel/adis16209.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
index ed6d7c7..cc50667 100644
--- a/drivers/staging/iio/accel/adis16209.c
+++ b/drivers/staging/iio/accel/adis16209.c
@@ -112,25 +112,22 @@ static int adis16209_write_raw(struct iio_dev *indio_dev,
 			       long mask)
 {
 	struct adis *st = iio_priv(indio_dev);
-	int bits;
-	s16 val16;
-	u8 addr;
+	int m;
+
+	if (mask != IIO_CHAN_INFO_CALIBBIAS)
+		return -EINVAL;
 
-	switch (mask) {
-	case IIO_CHAN_INFO_CALIBBIAS:
 		switch (chan->type) {
 		case IIO_ACCEL:
 		case IIO_INCLI:
-			bits = 14;
+			m = GENMASK(13, 0);
 			break;
 		default:
 			return -EINVAL;
 		}
-		val16 = val & ((1 << bits) - 1);
-		addr = adis16209_addresses[chan->scan_index][0];
-		return adis_write_reg_16(st, addr, val16);
-	}
-	return -EINVAL;
+
+	return adis_write_reg_16(st, adis16209_addresses[chan->scan_index][0],
+				 val & m);
 }
 
 static int adis16209_read_raw(struct iio_dev *indio_dev,
-- 
2.7.4
