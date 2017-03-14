Return-Path: <SRS0=3Lik=2X=gmail.com=rvarsha016@kernel.org>
Message-ID: <58c81906.42d5620a.3e22a.7a2b@mx.google.com>
Date: Tue, 14 Mar 2017 21:53:18 +0530
From: Varsha Rao <rvarsha016@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Barry Song <21cnbao@gmail.com>
Cc: outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org
Subject: [PATCH v2] staging: iio: adis16240: Remove mutex_lock() and
 mutex_unlock() function call.
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

Remove mutex_lock() and mutex_unlock() function calls, as the
adis16240_spi_read_signed() function can be run parallel and safely
multiple times. Also remove the mutex.h header file and comment, which
are no longer required.

As indio_dev is declared and initialized in adis16240_spi_read_signed(),
again declaration to same type and initialization to same value is not
required, remove it from adis16240_read_12bit_signed().

Simplify the return logic, by merging assignment and return into a single
line.

Signed-off-by: Varsha Rao <rvarsha016@gmail.com>
---
Changes in v2:

- mutex_lock() and mutex_unlock() are removed, instead of replacing
  mlock with driver private lock.
- Commit message modified.
- mutex.h header file is removed.
- Unnecessary comment is removed.
- Return logic is compressed to single line.
- Removed indio_dev declaration and initialization from
  adis16240_read_12bit_signed().

 drivers/staging/iio/accel/adis16240.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
index 27d7f6a..3a5f6ab 100644
--- a/drivers/staging/iio/accel/adis16240.c
+++ b/drivers/staging/iio/accel/adis16240.c
@@ -10,7 +10,6 @@
 #include <linux/irq.h>
 #include <linux/gpio.h>
 #include <linux/delay.h>
-#include <linux/mutex.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/spi/spi.h>
@@ -227,15 +226,7 @@ static ssize_t adis16240_read_12bit_signed(struct device *dev,
 					   struct device_attribute *attr,
 					   char *buf)
 {
-	ssize_t ret;
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-
-	/* Take the iio_dev status lock */
-	mutex_lock(&indio_dev->mlock);
-	ret =  adis16240_spi_read_signed(dev, attr, buf, 12);
-	mutex_unlock(&indio_dev->mlock);
-
-	return ret;
+	return adis16240_spi_read_signed(dev, attr, buf, 12);
 }
 
 static IIO_DEVICE_ATTR(in_accel_xyz_squared_peak_raw, 0444,
@@ -295,31 +286,25 @@ static int adis16240_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_CALIBBIAS:
 		bits = 10;
-		mutex_lock(&indio_dev->mlock);
 		addr = adis16240_addresses[chan->scan_index][0];
 		ret = adis_read_reg_16(st, addr, &val16);
 		if (ret) {
-			mutex_unlock(&indio_dev->mlock);
 			return ret;
 		}
 		val16 &= (1 << bits) - 1;
 		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
 		*val = val16;
-		mutex_unlock(&indio_dev->mlock);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_PEAK:
 		bits = 10;
-		mutex_lock(&indio_dev->mlock);
 		addr = adis16240_addresses[chan->scan_index][1];
 		ret = adis_read_reg_16(st, addr, &val16);
 		if (ret) {
-			mutex_unlock(&indio_dev->mlock);
 			return ret;
 		}
 		val16 &= (1 << bits) - 1;
 		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
 		*val = val16;
-		mutex_unlock(&indio_dev->mlock);
 		return IIO_VAL_INT;
 	}
 	return -EINVAL;
-- 
2.9.3
