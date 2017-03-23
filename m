Return-Path: <SRS0=9Une=3A=gmail.com=aishpant@kernel.org>
Date: Thu, 23 Mar 2017 20:14:53 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Barry Song <21cnbao@gmail.com>
Cc: outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org
Subject: [PATCH] staging: iio: accel: adis16201: remove local variable addr
Message-ID: <20170323144453.GA7093@aishwarya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

Remove local variable addr from adis_read_reg_16() and adis_write_reg_16()
as it is used only once.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---
 drivers/staging/iio/accel/adis16201.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
index fbc2406..b03c4f3 100644
--- a/drivers/staging/iio/accel/adis16201.c
+++ b/drivers/staging/iio/accel/adis16201.c
@@ -175,7 +175,6 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
 	struct adis *st = iio_priv(indio_dev);
 	int ret;
 	int bits;
-	u8 addr;
 	s16 val16;
 
 	switch (mask) {
@@ -223,8 +222,9 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
-		addr = adis16201_addresses[chan->scan_index];
-		ret = adis_read_reg_16(st, addr, &val16);
+		ret = adis_read_reg_16(st,
+				       adis16201_addresses[chan->scan_index],
+				       &val16);
 		if (ret)
 			return ret;
 		val16 &= (1 << bits) - 1;
@@ -244,7 +244,6 @@ static int adis16201_write_raw(struct iio_dev *indio_dev,
 	struct adis *st = iio_priv(indio_dev);
 	int bits;
 	s16 val16;
-	u8 addr;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_CALIBBIAS:
@@ -259,8 +258,9 @@ static int adis16201_write_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 		val16 = val & ((1 << bits) - 1);
-		addr = adis16201_addresses[chan->scan_index];
-		return adis_write_reg_16(st, addr, val16);
+		return adis_write_reg_16(st,
+					 adis16201_addresses[chan->scan_index],
+					 val16);
 	}
 	return -EINVAL;
 }
-- 
2.7.4
