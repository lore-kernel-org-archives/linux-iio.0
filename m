Return-Path: <SRS0=YVHc=3I=gmail.com=singhalsimran0@kernel.org>
From: simran singhal <singhalsimran0@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] staging: iio: accel: Remove useless type conversion
Date: Fri, 31 Mar 2017 20:38:48 +0530
Message-Id: <1490972930-15476-2-git-send-email-singhalsimran0@gmail.com>
In-Reply-To: <1490972930-15476-1-git-send-email-singhalsimran0@gmail.com>
References: <1490972930-15476-1-git-send-email-singhalsimran0@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Some type conversions like casting a pointer to a pointer of same type,
casting to the original type using addressof(&) operator etc. are not
needed. Therefore, remove them. Done using coccinelle:

@@
type t;
t *p;
t a;
@@
(
- (t)(a)
+ a
|
- (t *)(p)
+ p
|
- (t *)(&a)
+ &a
)

Signed-off-by: simran singhal <singhalsimran0@gmail.com>
---
 drivers/staging/iio/accel/adis16201.c | 2 +-
 drivers/staging/iio/accel/adis16203.c | 2 +-
 drivers/staging/iio/accel/adis16209.c | 2 +-
 drivers/staging/iio/accel/adis16240.c | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
index fbc2406..b7381d3 100644
--- a/drivers/staging/iio/accel/adis16201.c
+++ b/drivers/staging/iio/accel/adis16201.c
@@ -228,7 +228,7 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 		val16 &= (1 << bits) - 1;
-		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
+		val16 = val16 << (16 - bits) >> (16 - bits);
 		*val = val16;
 		return IIO_VAL_INT;
 	}
diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
index b59755a..25e5e52 100644
--- a/drivers/staging/iio/accel/adis16203.c
+++ b/drivers/staging/iio/accel/adis16203.c
@@ -211,7 +211,7 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
 			return ret;
 		}
 		val16 &= (1 << bits) - 1;
-		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
+		val16 = val16 << (16 - bits) >> (16 - bits);
 		*val = val16;
 		mutex_unlock(&indio_dev->mlock);
 		return IIO_VAL_INT;
diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
index 52fa2e0..7aac310 100644
--- a/drivers/staging/iio/accel/adis16209.c
+++ b/drivers/staging/iio/accel/adis16209.c
@@ -259,7 +259,7 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
 			return ret;
 		}
 		val16 &= (1 << bits) - 1;
-		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
+		val16 = val16 << (16 - bits) >> (16 - bits);
 		*val = val16;
 		return IIO_VAL_INT;
 	}
diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
index 6e3c95c..2c55b65 100644
--- a/drivers/staging/iio/accel/adis16240.c
+++ b/drivers/staging/iio/accel/adis16240.c
@@ -220,7 +220,7 @@ static ssize_t adis16240_spi_read_signed(struct device *dev,
 	if (val & ADIS16240_ERROR_ACTIVE)
 		adis_check_status(st);
 
-	val = (s16)(val << shift) >> shift;
+	val = val << shift >> shift;
 	return sprintf(buf, "%d\n", val);
 }
 
@@ -294,7 +294,7 @@ static int adis16240_read_raw(struct iio_dev *indio_dev,
 			return ret;
 		}
 		val16 &= (1 << bits) - 1;
-		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
+		val16 = val16 << (16 - bits) >> (16 - bits);
 		*val = val16;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_PEAK:
@@ -305,7 +305,7 @@ static int adis16240_read_raw(struct iio_dev *indio_dev,
 			return ret;
 		}
 		val16 &= (1 << bits) - 1;
-		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
+		val16 = val16 << (16 - bits) >> (16 - bits);
 		*val = val16;
 		return IIO_VAL_INT;
 	}
-- 
2.7.4
