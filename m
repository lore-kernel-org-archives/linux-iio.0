Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Barry.Song@analog.com, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 6/6] staging:iio: replace combine_8_to_16 with be16_to_cpup where possible.
Date: Fri, 25 Jun 2010 16:55:14 +0100
Message-Id: <1277481314-31717-7-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1277481314-31717-6-git-send-email-jic23@cam.ac.uk>
References: <1277481314-31717-1-git-send-email-jic23@cam.ac.uk>
 <1277481314-31717-2-git-send-email-jic23@cam.ac.uk>
 <1277481314-31717-3-git-send-email-jic23@cam.ac.uk>
 <1277481314-31717-4-git-send-email-jic23@cam.ac.uk>
 <1277481314-31717-5-git-send-email-jic23@cam.ac.uk>
 <1277481314-31717-6-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---

 In think I have this one the right way round, but please can someone check!
 The combine_8_to_16 does more complex things in lis3l02dq but copy
 and paste has led to it turning up in lots of places where it isn't
 needed.

 Barry Song's RFC made this obvious.
 
 drivers/staging/iio/accel/adis16209_ring.c |   16 ++--------------
 drivers/staging/iio/accel/adis16240_ring.c |   16 ++--------------
 drivers/staging/iio/gyro/adis16260_ring.c  |   16 ++--------------
 drivers/staging/iio/imu/adis16300_ring.c   |   16 ++--------------
 drivers/staging/iio/imu/adis16350_ring.c   |   16 ++--------------
 drivers/staging/iio/imu/adis16400_ring.c   |   16 ++--------------
 6 files changed, 12 insertions(+), 84 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
index ad71538..53a7677 100644
--- a/drivers/staging/iio/accel/adis16209_ring.c
+++ b/drivers/staging/iio/accel/adis16209_ring.c
@@ -17,16 +17,6 @@
 #include "../trigger.h"
 #include "adis16209.h"
 
-/**
- * combine_8_to_16() utility function to munge to u8s into u16
- **/
-static inline u16 combine_8_to_16(u8 lower, u8 upper)
-{
-	u16 _lower = lower;
-	u16 _upper = upper;
-	return _lower | (_upper << 8);
-}
-
 static IIO_SCAN_EL_C(supply, ADIS16209_SCAN_SUPPLY, IIO_UNSIGNED(14),
 		     ADIS16209_SUPPLY_OUT, NULL);
 static IIO_SCAN_EL_C(accel_x, ADIS16209_SCAN_ACC_X, IIO_SIGNED(14),
@@ -139,10 +129,8 @@ static void adis16209_trigger_bh_to_ring(struct work_struct *work_s)
 
 	if (st->indio_dev->scan_count)
 		if (adis16209_read_ring_data(&st->indio_dev->dev, st->rx) >= 0)
-			for (; i < st->indio_dev->scan_count; i++) {
-				data[i] = combine_8_to_16(st->rx[i*2+1],
-							  st->rx[i*2]);
-			}
+			for (; i < st->indio_dev->scan_count; i++)
+				data[i] = be16_to_cpup((__be16 *)&(st->rx[i*2]));
 
 	/* Guaranteed to be aligned with 8 byte boundary */
 	if (st->indio_dev->scan_timestamp)
diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging/iio/accel/adis16240_ring.c
index 5cced2e..88269a0 100644
--- a/drivers/staging/iio/accel/adis16240_ring.c
+++ b/drivers/staging/iio/accel/adis16240_ring.c
@@ -17,16 +17,6 @@
 #include "../trigger.h"
 #include "adis16240.h"
 
-/**
- * combine_8_to_16() utility function to munge to u8s into u16
- **/
-static inline u16 combine_8_to_16(u8 lower, u8 upper)
-{
-	u16 _lower = lower;
-	u16 _upper = upper;
-	return _lower | (_upper << 8);
-}
-
 static IIO_SCAN_EL_C(supply, ADIS16240_SCAN_SUPPLY, IIO_UNSIGNED(10),
 		ADIS16240_SUPPLY_OUT, NULL);
 static IIO_SCAN_EL_C(accel_x, ADIS16240_SCAN_ACC_X, IIO_SIGNED(10),
@@ -131,10 +121,8 @@ static void adis16240_trigger_bh_to_ring(struct work_struct *work_s)
 
 	if (st->indio_dev->scan_count)
 		if (adis16240_read_ring_data(&st->indio_dev->dev, st->rx) >= 0)
-			for (; i < st->indio_dev->scan_count; i++) {
-				data[i] = combine_8_to_16(st->rx[i*2+1],
-						st->rx[i*2]);
-			}
+			for (; i < st->indio_dev->scan_count; i++)
+				data[i] = be16_to_cpup((__be16 *)&(st->rx[i*2]));
 
 	/* Guaranteed to be aligned with 8 byte boundary */
 	if (st->indio_dev->scan_timestamp)
diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/iio/gyro/adis16260_ring.c
index 97d7660..59f1beb 100644
--- a/drivers/staging/iio/gyro/adis16260_ring.c
+++ b/drivers/staging/iio/gyro/adis16260_ring.c
@@ -17,16 +17,6 @@
 #include "../trigger.h"
 #include "adis16260.h"
 
-/**
- * combine_8_to_16() utility function to munge to u8s into u16
- **/
-static inline u16 combine_8_to_16(u8 lower, u8 upper)
-{
-	u16 _lower = lower;
-	u16 _upper = upper;
-	return _lower | (_upper << 8);
-}
-
 static IIO_SCAN_EL_C(supply, ADIS16260_SCAN_SUPPLY, IIO_UNSIGNED(12),
 		ADIS16260_SUPPLY_OUT, NULL);
 static IIO_SCAN_EL_C(gyro, ADIS16260_SCAN_GYRO, IIO_SIGNED(14),
@@ -134,10 +124,8 @@ static void adis16260_trigger_bh_to_ring(struct work_struct *work_s)
 
 	if (st->indio_dev->scan_count)
 		if (adis16260_read_ring_data(&st->indio_dev->dev, st->rx) >= 0)
-			for (; i < st->indio_dev->scan_count; i++) {
-				data[i] = combine_8_to_16(st->rx[i*2+1],
-						st->rx[i*2]);
-			}
+			for (; i < st->indio_dev->scan_count; i++)
+				data[i] = be16_to_cpup((__be16 *)&(st->rx[i*2]));
 
 	/* Guaranteed to be aligned with 8 byte boundary */
 	if (st->indio_dev->scan_timestamp)
diff --git a/drivers/staging/iio/imu/adis16300_ring.c b/drivers/staging/iio/imu/adis16300_ring.c
index 6b25f12..64f02f5 100644
--- a/drivers/staging/iio/imu/adis16300_ring.c
+++ b/drivers/staging/iio/imu/adis16300_ring.c
@@ -17,16 +17,6 @@
 #include "../trigger.h"
 #include "adis16300.h"
 
-/**
- * combine_8_to_16() utility function to munge to u8s into u16
- **/
-static inline u16 combine_8_to_16(u8 lower, u8 upper)
-{
-	u16 _lower = lower;
-	u16 _upper = upper;
-	return _lower | (_upper << 8);
-}
-
 static IIO_SCAN_EL_C(supply, ADIS16300_SCAN_SUPPLY, IIO_UNSIGNED(14),
 		     ADIS16300_SUPPLY_OUT, NULL);
 
@@ -158,10 +148,8 @@ static void adis16300_trigger_bh_to_ring(struct work_struct *work_s)
 
 	if (st->indio_dev->scan_count)
 		if (adis16300_spi_read_burst(&st->indio_dev->dev, st->rx) >= 0)
-			for (; i < st->indio_dev->scan_count; i++) {
-				data[i] = combine_8_to_16(st->rx[i*2+1],
-							  st->rx[i*2]);
-			}
+			for (; i < st->indio_dev->scan_count; i++)
+				data[i] = be16_to_cpup((__be16 *)&(st->rx[i*2]));
 
 	/* Guaranteed to be aligned with 8 byte boundary */
 	if (st->indio_dev->scan_timestamp)
diff --git a/drivers/staging/iio/imu/adis16350_ring.c b/drivers/staging/iio/imu/adis16350_ring.c
index 28c13ef..f817bfd 100644
--- a/drivers/staging/iio/imu/adis16350_ring.c
+++ b/drivers/staging/iio/imu/adis16350_ring.c
@@ -17,16 +17,6 @@
 #include "../trigger.h"
 #include "adis16350.h"
 
-/**
- * combine_8_to_16() utility function to munge to u8s into u16
- **/
-static inline u16 combine_8_to_16(u8 lower, u8 upper)
-{
-	u16 _lower = lower;
-	u16 _upper = upper;
-	return _lower | (_upper << 8);
-}
-
 static IIO_SCAN_EL_C(supply, ADIS16350_SCAN_SUPPLY, IIO_UNSIGNED(12),
 		ADIS16350_SUPPLY_OUT, NULL);
 
@@ -158,10 +148,8 @@ static void adis16350_trigger_bh_to_ring(struct work_struct *work_s)
 
 	if (st->indio_dev->scan_count)
 		if (adis16350_spi_read_burst(&st->indio_dev->dev, st->rx) >= 0)
-			for (; i < st->indio_dev->scan_count; i++) {
-				data[i] = combine_8_to_16(st->rx[i*2+1],
-							  st->rx[i*2]);
-			}
+			for (; i < st->indio_dev->scan_count; i++)
+				data[i] = be16_to_cpup((__be16 *)&(st->rx[i*2]));
 
 	/* Guaranteed to be aligned with 8 byte boundary */
 	if (st->indio_dev->scan_timestamp)
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index 95f53b2..e7881a0 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -17,16 +17,6 @@
 #include "../trigger.h"
 #include "adis16400.h"
 
-/**
- * combine_8_to_16() utility function to munge to u8s into u16
- **/
-static inline u16 combine_8_to_16(u8 lower, u8 upper)
-{
-	u16 _lower = lower;
-	u16 _upper = upper;
-	return _lower | (_upper << 8);
-}
-
 static IIO_SCAN_EL_C(supply, ADIS16400_SCAN_SUPPLY, IIO_SIGNED(14),
 		     ADIS16400_SUPPLY_OUT, NULL);
 
@@ -167,10 +157,8 @@ static void adis16400_trigger_bh_to_ring(struct work_struct *work_s)
 
 	if (st->indio_dev->scan_count)
 		if (adis16400_spi_read_burst(&st->indio_dev->dev, st->rx) >= 0)
-			for (; i < st->indio_dev->scan_count; i++) {
-				data[i] = combine_8_to_16(st->rx[i*2+1],
-							  st->rx[i*2]);
-			}
+			for (; i < st->indio_dev->scan_count; i++)
+				data[i] = be16_to_cpup((__be16 *)&(st->rx[i*2]));
 
 	/* Guaranteed to be aligned with 8 byte boundary */
 	if (st->indio_dev->scan_timestamp)
-- 
1.6.4.4
