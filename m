Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: barry.song@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 2/5] staging:iio: Make extensive use of iio_sw_ring_preenable
Date: Wed, 30 Jun 2010 15:27:53 +0100
Message-Id: <1277908076-28592-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1277908076-28592-1-git-send-email-jic23@cam.ac.uk>
References: <1277908076-28592-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16209_ring.c |   31 +--------------------------
 drivers/staging/iio/accel/adis16240_ring.c |   29 +------------------------
 drivers/staging/iio/accel/lis3l02dq_ring.c |   25 +--------------------
 drivers/staging/iio/gyro/adis16260_ring.c  |   29 +------------------------
 drivers/staging/iio/imu/adis16300_ring.c   |   26 +---------------------
 drivers/staging/iio/imu/adis16350_ring.c   |   29 +------------------------
 drivers/staging/iio/imu/adis16400_ring.c   |   26 +---------------------
 7 files changed, 14 insertions(+), 181 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
index f3a9493..25fde65 100644
--- a/drivers/staging/iio/accel/adis16209_ring.c
+++ b/drivers/staging/iio/accel/adis16209_ring.c
@@ -147,34 +147,6 @@ static void adis16209_trigger_bh_to_ring(struct work_struct *work_s)
 	return;
 }
 
-/* in these circumstances is it better to go with unaligned packing and
- * deal with the cost?*/
-static int adis16209_data_rdy_ring_preenable(struct iio_dev *indio_dev)
-{
-	size_t size;
-	dev_dbg(&indio_dev->dev, "%s\n", __func__);
-	/* Check if there are any scan elements enabled, if not fail*/
-	if (!(indio_dev->scan_count || indio_dev->scan_timestamp))
-		return -EINVAL;
-
-	if (indio_dev->ring->access.set_bpd) {
-		if (indio_dev->scan_timestamp)
-			if (indio_dev->scan_count)
-				/* Timestamp (aligned to s64) and data */
-				size = (((indio_dev->scan_count * sizeof(s16))
-					 + sizeof(s64) - 1)
-					& ~(sizeof(s64) - 1))
-					+ sizeof(s64);
-			else /* Timestamp only  */
-				size = sizeof(s64);
-		else /* Data only */
-			size = indio_dev->scan_count*sizeof(s16);
-		indio_dev->ring->access.set_bpd(indio_dev->ring, size);
-	}
-
-	return 0;
-}
-
 void adis16209_unconfigure_ring(struct iio_dev *indio_dev)
 {
 	kfree(indio_dev->pollfunc);
@@ -209,7 +181,8 @@ int adis16209_configure_ring(struct iio_dev *indio_dev)
 	indio_dev->ring = ring;
 	/* Effectively select the ring buffer implementation */
 	iio_ring_sw_register_funcs(&ring->access);
-	ring->preenable = &adis16209_data_rdy_ring_preenable;
+	ring->bpe = 2;
+	ring->preenable = &iio_sw_ring_preenable;
 	ring->postenable = &iio_triggered_ring_postenable;
 	ring->predisable = &iio_triggered_ring_predisable;
 	ring->owner = THIS_MODULE;
diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging/iio/accel/adis16240_ring.c
index a1611bb..cd69a2e 100644
--- a/drivers/staging/iio/accel/adis16240_ring.c
+++ b/drivers/staging/iio/accel/adis16240_ring.c
@@ -139,32 +139,6 @@ static void adis16240_trigger_bh_to_ring(struct work_struct *work_s)
 	return;
 }
 
-static int adis16240_data_rdy_ring_preenable(struct iio_dev *indio_dev)
-{
-	size_t size;
-	dev_dbg(&indio_dev->dev, "%s\n", __func__);
-	/* Check if there are any scan elements enabled, if not fail*/
-	if (!(indio_dev->scan_count || indio_dev->scan_timestamp))
-		return -EINVAL;
-
-	if (indio_dev->ring->access.set_bpd) {
-		if (indio_dev->scan_timestamp)
-			if (indio_dev->scan_count)
-				/* Timestamp (aligned sizeof(s64) and data */
-				size = (((indio_dev->scan_count * sizeof(s16))
-					 + sizeof(s64) - 1)
-					& ~(sizeof(s64) - 1))
-					+ sizeof(s64);
-			else /* Timestamp only  */
-				size = sizeof(s64);
-		else /* Data only */
-			size = indio_dev->scan_count*sizeof(s16);
-		indio_dev->ring->access.set_bpd(indio_dev->ring, size);
-	}
-
-	return 0;
-}
-
 void adis16240_unconfigure_ring(struct iio_dev *indio_dev)
 {
 	kfree(indio_dev->pollfunc);
@@ -197,7 +171,8 @@ int adis16240_configure_ring(struct iio_dev *indio_dev)
 	indio_dev->ring = ring;
 	/* Effectively select the ring buffer implementation */
 	iio_ring_sw_register_funcs(&ring->access);
-	ring->preenable = &adis16240_data_rdy_ring_preenable;
+	ring->bpe = 2;
+	ring->preenable = &iio_sw_ring_preenable;
 	ring->postenable = &iio_triggered_ring_postenable;
 	ring->predisable = &iio_triggered_ring_predisable;
 	ring->owner = THIS_MODULE;
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index a506dab..2c11209 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -315,28 +315,6 @@ static void lis3l02dq_trigger_bh_to_ring(struct work_struct *work_s)
 
 	return;
 }
-/* in these circumstances is it better to go with unaligned packing and
- * deal with the cost?*/
-static int lis3l02dq_data_rdy_ring_preenable(struct iio_dev *indio_dev)
-{
-	size_t size;
-	/* Check if there are any scan elements enabled, if not fail*/
-	if (!(indio_dev->scan_count || indio_dev->scan_timestamp))
-		return -EINVAL;
-
-	if (indio_dev->ring->access.set_bpd) {
-		if (indio_dev->scan_timestamp)
-			if (indio_dev->scan_count) /* Timestamp and data */
-				size = 2*sizeof(s64);
-			else /* Timestamp only  */
-				size = sizeof(s64);
-		else /* Data only */
-			size = indio_dev->scan_count*sizeof(s16);
-		indio_dev->ring->access.set_bpd(indio_dev->ring, size);
-	}
-
-	return 0;
-}
 
 /* Caller responsible for locking as necessary. */
 static int
@@ -543,7 +521,8 @@ int lis3l02dq_configure_ring(struct iio_dev *indio_dev)
 	indio_dev->ring = ring;
 	/* Effectively select the ring buffer implementation */
 	iio_ring_sw_register_funcs(&ring->access);
-	ring->preenable = &lis3l02dq_data_rdy_ring_preenable;
+	ring->bpe = 2;
+	ring->preenable = &iio_sw_ring_preenable;
 	ring->postenable = &iio_triggered_ring_postenable;
 	ring->predisable = &iio_triggered_ring_predisable;
 	ring->owner = THIS_MODULE;
diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/iio/gyro/adis16260_ring.c
index 94b4515..9ef7f90 100644
--- a/drivers/staging/iio/gyro/adis16260_ring.c
+++ b/drivers/staging/iio/gyro/adis16260_ring.c
@@ -142,32 +142,6 @@ static void adis16260_trigger_bh_to_ring(struct work_struct *work_s)
 	return;
 }
 
-static int adis16260_data_rdy_ring_preenable(struct iio_dev *indio_dev)
-{
-	size_t size;
-	dev_dbg(&indio_dev->dev, "%s\n", __func__);
-	/* Check if there are any scan elements enabled, if not fail*/
-	if (!(indio_dev->scan_count || indio_dev->scan_timestamp))
-		return -EINVAL;
-
-	if (indio_dev->ring->access.set_bpd) {
-		if (indio_dev->scan_timestamp)
-			if (indio_dev->scan_count)
-				/* Timestamp (aligned s64) and data */
-				size = (((indio_dev->scan_count * sizeof(s16))
-						+ sizeof(s64) - 1)
-					& ~(sizeof(s64) - 1))
-					+ sizeof(s64);
-			else /* Timestamp only  */
-				size = sizeof(s64);
-		else /* Data only */
-			size = indio_dev->scan_count*sizeof(s16);
-		indio_dev->ring->access.set_bpd(indio_dev->ring, size);
-	}
-
-	return 0;
-}
-
 void adis16260_unconfigure_ring(struct iio_dev *indio_dev)
 {
 	kfree(indio_dev->pollfunc);
@@ -199,7 +173,8 @@ int adis16260_configure_ring(struct iio_dev *indio_dev)
 	indio_dev->ring = ring;
 	/* Effectively select the ring buffer implementation */
 	iio_ring_sw_register_funcs(&ring->access);
-	ring->preenable = &adis16260_data_rdy_ring_preenable;
+	ring->bpe = 2;
+	ring->preenable = &iio_sw_ring_preenable;
 	ring->postenable = &iio_triggered_ring_postenable;
 	ring->predisable = &iio_triggered_ring_predisable;
 	ring->owner = THIS_MODULE;
diff --git a/drivers/staging/iio/imu/adis16300_ring.c b/drivers/staging/iio/imu/adis16300_ring.c
index 3bf9904..fc93160 100644
--- a/drivers/staging/iio/imu/adis16300_ring.c
+++ b/drivers/staging/iio/imu/adis16300_ring.c
@@ -165,29 +165,6 @@ static void adis16300_trigger_bh_to_ring(struct work_struct *work_s)
 
 	return;
 }
-/* in these circumstances is it better to go with unaligned packing and
- * deal with the cost?*/
-static int adis16300_data_rdy_ring_preenable(struct iio_dev *indio_dev)
-{
-	size_t size;
-	dev_dbg(&indio_dev->dev, "%s\n", __func__);
-	/* Check if there are any scan elements enabled, if not fail*/
-	if (!(indio_dev->scan_count || indio_dev->scan_timestamp))
-		return -EINVAL;
-
-	if (indio_dev->ring->access.set_bpd) {
-		if (indio_dev->scan_timestamp)
-			if (indio_dev->scan_count) /* Timestamp and data */
-				size = 4*sizeof(s64);
-			else /* Timestamp only  */
-				size = sizeof(s64);
-		else /* Data only */
-			size = indio_dev->scan_count*sizeof(s16);
-		indio_dev->ring->access.set_bpd(indio_dev->ring, size);
-	}
-
-	return 0;
-}
 
 void adis16300_unconfigure_ring(struct iio_dev *indio_dev)
 {
@@ -224,7 +201,8 @@ int adis16300_configure_ring(struct iio_dev *indio_dev)
 	indio_dev->ring = ring;
 	/* Effectively select the ring buffer implementation */
 	iio_ring_sw_register_funcs(&ring->access);
-	ring->preenable = &adis16300_data_rdy_ring_preenable;
+	ring->bpe = 2;
+	ring->preenable = &iio_sw_ring_preenable;
 	ring->postenable = &iio_triggered_ring_postenable;
 	ring->predisable = &iio_triggered_ring_predisable;
 	ring->owner = THIS_MODULE;
diff --git a/drivers/staging/iio/imu/adis16350_ring.c b/drivers/staging/iio/imu/adis16350_ring.c
index 319aa34..e053e9a 100644
--- a/drivers/staging/iio/imu/adis16350_ring.c
+++ b/drivers/staging/iio/imu/adis16350_ring.c
@@ -166,32 +166,6 @@ static void adis16350_trigger_bh_to_ring(struct work_struct *work_s)
 	return;
 }
 
-static int adis16350_data_rdy_ring_preenable(struct iio_dev *indio_dev)
-{
-	size_t size;
-	dev_dbg(&indio_dev->dev, "%s\n", __func__);
-	/* Check if there are any scan elements enabled, if not fail*/
-	if (!(indio_dev->scan_count || indio_dev->scan_timestamp))
-		return -EINVAL;
-
-	if (indio_dev->ring->access.set_bpd) {
-		if (indio_dev->scan_timestamp)
-			if (indio_dev->scan_count)
-				/* Timestamp (aligned sizeof(s64) and data */
-				size = (((indio_dev->scan_count * sizeof(s16))
-						+ sizeof(s64) - 1)
-					& ~(sizeof(s64) - 1))
-					+ sizeof(s64);
-			else /* Timestamp only  */
-				size = sizeof(s64);
-		else /* Data only */
-			size = indio_dev->scan_count*sizeof(s16);
-		indio_dev->ring->access.set_bpd(indio_dev->ring, size);
-	}
-
-	return 0;
-}
-
 void adis16350_unconfigure_ring(struct iio_dev *indio_dev)
 {
 	kfree(indio_dev->pollfunc);
@@ -229,7 +203,8 @@ int adis16350_configure_ring(struct iio_dev *indio_dev)
 	indio_dev->ring = ring;
 	/* Effectively select the ring buffer implementation */
 	iio_ring_sw_register_funcs(&ring->access);
-	ring->preenable = &adis16350_data_rdy_ring_preenable;
+	ring->bpe = 2;
+	ring->preenable = &iio_sw_ring_preenable;
 	ring->postenable = &iio_triggered_ring_postenable;
 	ring->predisable = &iio_triggered_ring_predisable;
 	ring->owner = THIS_MODULE;
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index c7744ef..949db76 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -174,29 +174,6 @@ static void adis16400_trigger_bh_to_ring(struct work_struct *work_s)
 
 	return;
 }
-/* in these circumstances is it better to go with unaligned packing and
- * deal with the cost?*/
-static int adis16400_data_rdy_ring_preenable(struct iio_dev *indio_dev)
-{
-	size_t size;
-	dev_dbg(&indio_dev->dev, "%s\n", __func__);
-	/* Check if there are any scan elements enabled, if not fail*/
-	if (!(indio_dev->scan_count || indio_dev->scan_timestamp))
-		return -EINVAL;
-
-	if (indio_dev->ring->access.set_bpd) {
-		if (indio_dev->scan_timestamp)
-			if (indio_dev->scan_count) /* Timestamp and data */
-				size = 6*sizeof(s64);
-			else /* Timestamp only  */
-				size = sizeof(s64);
-		else /* Data only */
-			size = indio_dev->scan_count*sizeof(s16);
-		indio_dev->ring->access.set_bpd(indio_dev->ring, size);
-	}
-
-	return 0;
-}
 
 void adis16400_unconfigure_ring(struct iio_dev *indio_dev)
 {
@@ -236,7 +213,8 @@ int adis16400_configure_ring(struct iio_dev *indio_dev)
 	indio_dev->ring = ring;
 	/* Effectively select the ring buffer implementation */
 	iio_ring_sw_register_funcs(&ring->access);
-	ring->preenable = &adis16400_data_rdy_ring_preenable;
+	ring->bpe = 2;
+	ring->preenable = &iio_sw_ring_preenable;
 	ring->postenable = &iio_triggered_ring_postenable;
 	ring->predisable = &iio_triggered_ring_predisable;
 	ring->owner = THIS_MODULE;
-- 
1.7.0.4
