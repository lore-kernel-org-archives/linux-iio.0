Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	manuel.stahl@iis.fraunhofer.de,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 06/16] staging:iio:accel:lis3l02dq scrap reading from buffer for sysfs access.
Date: Sun, 27 Nov 2011 13:33:35 +0000
Message-Id: <1322400825-29400-7-git-send-email-jic23@kernel.org>
In-Reply-To: <1322400825-29400-1-git-send-email-jic23@kernel.org>
References: <1322400825-29400-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

No obvious usecase and complicates in kernel interface work.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/lis3l02dq.h      |   12 ----------
 drivers/staging/iio/accel/lis3l02dq_core.c |    9 ++-----
 drivers/staging/iio/accel/lis3l02dq_ring.c |   32 ----------------------------
 3 files changed, 3 insertions(+), 50 deletions(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq.h b/drivers/staging/iio/accel/lis3l02dq.h
index 7237a9a..2db383f 100644
--- a/drivers/staging/iio/accel/lis3l02dq.h
+++ b/drivers/staging/iio/accel/lis3l02dq.h
@@ -181,11 +181,6 @@ int lis3l02dq_disable_all_events(struct iio_dev *indio_dev);
 void lis3l02dq_remove_trigger(struct iio_dev *indio_dev);
 int lis3l02dq_probe_trigger(struct iio_dev *indio_dev);
 
-ssize_t lis3l02dq_read_accel_from_buffer(struct iio_buffer *buffer,
-				       int index,
-				       int *val);
-
-
 int lis3l02dq_configure_buffer(struct iio_dev *indio_dev);
 void lis3l02dq_unconfigure_buffer(struct iio_dev *indio_dev);
 
@@ -212,13 +207,6 @@ static inline int lis3l02dq_probe_trigger(struct iio_dev *indio_dev)
 {
 	return 0;
 }
-static inline ssize_t
-lis3l02dq_read_accel_from_buffer(struct iio_buffer *buffer,
-				 int index,
-				 int *val)
-{
-	return 0;
-}
 
 static int lis3l02dq_configure_buffer(struct iio_dev *indio_dev)
 {
diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index 4dbe4c7..8a3d26b 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -260,12 +260,9 @@ static int lis3l02dq_read_raw(struct iio_dev *indio_dev,
 	case 0:
 		/* Take the iio_dev status lock */
 		mutex_lock(&indio_dev->mlock);
-		if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
-			ret = lis3l02dq_read_accel_from_buffer(indio_dev->
-							       buffer,
-							       chan->scan_index,
-							       val);
-		else {
+		if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
+			ret = -EBUSY;
+		} else {
 			reg = lis3l02dq_axis_map
 				[LIS3L02DQ_ACCEL][chan->address];
 			ret = lis3l02dq_read_reg_s16(indio_dev, reg, val);
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index 978cd4d..c81d0e2 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -38,38 +38,6 @@ irqreturn_t lis3l02dq_data_rdy_trig_poll(int irq, void *private)
 		return IRQ_WAKE_THREAD;
 }
 
-/**
- * lis3l02dq_read_accel_from_buffer() individual acceleration read from buffer
- **/
-ssize_t lis3l02dq_read_accel_from_buffer(struct iio_buffer *buffer,
-					 int index,
-					 int *val)
-{
-	int ret;
-	s16 *data;
-
-	if (!iio_scan_mask_query(buffer, index))
-		return -EINVAL;
-
-	if (!buffer->access->read_last)
-		return -EBUSY;
-
-	data = kmalloc(buffer->access->get_bytes_per_datum(buffer),
-		       GFP_KERNEL);
-	if (data == NULL)
-		return -ENOMEM;
-
-	ret = buffer->access->read_last(buffer, (u8 *)data);
-	if (ret)
-		goto error_free_data;
-	*val = data[bitmap_weight(buffer->scan_mask, index)];
-error_free_data:
-
-	kfree(data);
-
-	return ret;
-}
-
 static const u8 read_all_tx_array[] = {
 	LIS3L02DQ_READ_REG(LIS3L02DQ_REG_OUT_X_L_ADDR), 0,
 	LIS3L02DQ_READ_REG(LIS3L02DQ_REG_OUT_X_H_ADDR), 0,
-- 
1.7.7.3
