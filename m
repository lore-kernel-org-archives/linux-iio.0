Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: gregkh@suse.de
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 05/12] staging:iio: replace combine_8_to_16 with be16_to_cpup where possible.
Date: Sun, 11 Jul 2010 16:39:12 +0100
Message-Id: <1278862759-19028-6-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1278862759-19028-1-git-send-email-jic23@cam.ac.uk>
References: <1278862759-19028-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Barry Song <21cnbao@gmail.com>
---
 drivers/staging/iio/accel/adis16209_ring.c |   17 +++--------------
 drivers/staging/iio/accel/adis16240_ring.c |   17 +++--------------
 drivers/staging/iio/gyro/adis16260_ring.c  |   17 +++--------------
 drivers/staging/iio/imu/adis16300_ring.c   |   17 +++--------------
 drivers/staging/iio/imu/adis16350_ring.c   |   17 +++--------------
 drivers/staging/iio/imu/adis16400_ring.c   |   17 +++--------------
 6 files changed, 18 insertions(+), 84 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
index ad71538..5945d67 100644
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
@@ -139,10 +129,9 @@ static void adis16209_trigger_bh_to_ring(struct work_struct *work_s)
 
 	if (st->indio_dev->scan_count)
 		if (adis16209_read_ring_data(&st->indio_dev->dev, st->rx) >= 0)
-			for (; i < st->indio_dev->scan_count; i++) {
-				data[i] = combine_8_to_16(st->rx[i*2+1],
-							  st->rx[i*2]);
-			}
+			for (; i < st->indio_dev->scan_count; i++)
+				data[i] = be16_to_cpup(
+					(__be16 *)&(st->rx[i*2]));
 
 	/* Guaranteed to be aligned with 8 byte boundary */
 	if (st->indio_dev->scan_timestamp)
diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging/iio/accel/adis16240_ring.c
index 5cced2e..ecf1110 100644
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
@@ -131,10 +121,9 @@ static void adis16240_trigger_bh_to_ring(struct work_struct *work_s)
 
 	if (st->indio_dev->scan_count)
 		if (adis16240_read_ring_data(&st->indio_dev->dev, st->rx) >= 0)
-			for (; i < st->indio_dev->scan_count; i++) {
-				data[i] = combine_8_to_16(st->rx[i*2+1],
-						st->rx[i*2]);
-			}
+			for (; i < st->indio_dev->scan_count; i++)
+				data[i] = be16_to_cpup(
+					(__be16 *)&(st->rx[i*2]));
 
 	/* Guaranteed to be aligned with 8 byte boundary */
 	if (st->indio_dev->scan_timestamp)
diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/iio/gyro/adis16260_ring.c
index 97d7660..57ebc8c 100644
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
@@ -134,10 +124,9 @@ static void adis16260_trigger_bh_to_ring(struct work_struct *work_s)
 
 	if (st->indio_dev->scan_count)
 		if (adis16260_read_ring_data(&st->indio_dev->dev, st->rx) >= 0)
-			for (; i < st->indio_dev->scan_count; i++) {
-				data[i] = combine_8_to_16(st->rx[i*2+1],
-						st->rx[i*2]);
-			}
+			for (; i < st->indio_dev->scan_count; i++)
+				data[i] = be16_to_cpup(
+					(__be16 *)&(st->rx[i*2]));
 
 	/* Guaranteed to be aligned with 8 byte boundary */
 	if (st->indio_dev->scan_timestamp)
diff --git a/drivers/staging/iio/imu/adis16300_ring.c b/drivers/staging/iio/imu/adis16300_ring.c
index 6b25f12..a76d43c 100644
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
 
@@ -158,10 +148,9 @@ static void adis16300_trigger_bh_to_ring(struct work_struct *work_s)
 
 	if (st->indio_dev->scan_count)
 		if (adis16300_spi_read_burst(&st->indio_dev->dev, st->rx) >= 0)
-			for (; i < st->indio_dev->scan_count; i++) {
-				data[i] = combine_8_to_16(st->rx[i*2+1],
-							  st->rx[i*2]);
-			}
+			for (; i < st->indio_dev->scan_count; i++)
+				data[i] = be16_to_cpup(
+					(__be16 *)&(st->rx[i*2]));
 
 	/* Guaranteed to be aligned with 8 byte boundary */
 	if (st->indio_dev->scan_timestamp)
diff --git a/drivers/staging/iio/imu/adis16350_ring.c b/drivers/staging/iio/imu/adis16350_ring.c
index 28c13ef..ca4f685 100644
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
 
@@ -158,10 +148,9 @@ static void adis16350_trigger_bh_to_ring(struct work_struct *work_s)
 
 	if (st->indio_dev->scan_count)
 		if (adis16350_spi_read_burst(&st->indio_dev->dev, st->rx) >= 0)
-			for (; i < st->indio_dev->scan_count; i++) {
-				data[i] = combine_8_to_16(st->rx[i*2+1],
-							  st->rx[i*2]);
-			}
+			for (; i < st->indio_dev->scan_count; i++)
+				data[i] = be16_to_cpup(
+					(__be16 *)&(st->rx[i*2]));
 
 	/* Guaranteed to be aligned with 8 byte boundary */
 	if (st->indio_dev->scan_timestamp)
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index 95f53b2..59d62a7 100644
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
 
@@ -167,10 +157,9 @@ static void adis16400_trigger_bh_to_ring(struct work_struct *work_s)
 
 	if (st->indio_dev->scan_count)
 		if (adis16400_spi_read_burst(&st->indio_dev->dev, st->rx) >= 0)
-			for (; i < st->indio_dev->scan_count; i++) {
-				data[i] = combine_8_to_16(st->rx[i*2+1],
-							  st->rx[i*2]);
-			}
+			for (; i < st->indio_dev->scan_count; i++)
+				data[i]	= be16_to_cpup(
+					(__be16 *)&(st->rx[i*2]));
 
 	/* Guaranteed to be aligned with 8 byte boundary */
 	if (st->indio_dev->scan_timestamp)
-- 
1.7.0.4
