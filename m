Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: barry.song@analog.com,
	Barry Song <21cnbao@gmail.com>,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 1/5] staging:iio: Add a bits per element element to ring_generic allowing a general ring_sw_preenable_function.
Date: Wed, 30 Jun 2010 15:27:52 +0100
Message-Id: <1277908076-28592-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1277908076-28592-1-git-send-email-jic23@cam.ac.uk>
References: <1277908076-28592-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

From: Barry Song <21cnbao@gmail.com>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/ring_generic.h |    2 ++
 drivers/staging/iio/ring_sw.c      |   25 +++++++++++++++++++++++++
 drivers/staging/iio/ring_sw.h      |    2 +-
 3 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/ring_generic.h b/drivers/staging/iio/ring_generic.h
index dbf11e1..7ef94d7 100644
--- a/drivers/staging/iio/ring_generic.h
+++ b/drivers/staging/iio/ring_generic.h
@@ -100,6 +100,7 @@ struct iio_ring_access_funcs {
  * @access_id:		device id number
  * @length:		[DEVICE] number of datums in ring
  * @bpd:		[DEVICE] size of individual datum including timestamp
+ * @bpe:		[DEVICE] size of individual channel value
  * @loopcount:		[INTERN] number of times the ring has looped
  * @access_handler:	[INTERN] chrdev access handling
  * @ev_int:		[INTERN] chrdev interface for the event chrdev
@@ -121,6 +122,7 @@ struct iio_ring_buffer {
 	int				access_id;
 	int				length;
 	int				bpd;
+	int				bpe;
 	int				loopcount;
 	struct iio_handler		access_handler;
 	struct iio_event_interface	ev_int;
diff --git a/drivers/staging/iio/ring_sw.c b/drivers/staging/iio/ring_sw.c
index 294272d..ca0e79e 100644
--- a/drivers/staging/iio/ring_sw.c
+++ b/drivers/staging/iio/ring_sw.c
@@ -431,5 +431,30 @@ void iio_sw_rb_free(struct iio_ring_buffer *r)
 		iio_put_ring_buffer(r);
 }
 EXPORT_SYMBOL(iio_sw_rb_free);
+
+int iio_sw_ring_preenable(struct iio_dev *indio_dev)
+{
+	size_t size;
+	dev_dbg(&indio_dev->dev, "%s\n", __func__);
+	/* Check if there are any scan elements enabled, if not fail*/
+	if (!(indio_dev->scan_count || indio_dev->scan_timestamp))
+		return -EINVAL;
+	if (indio_dev->scan_timestamp)
+		if (indio_dev->scan_count)
+			/* Timestamp (aligned to s64) and data */
+			size = (((indio_dev->scan_count * indio_dev->ring->bpe)
+					+ sizeof(s64) - 1)
+				& ~(sizeof(s64) - 1))
+				+ sizeof(s64);
+		else /* Timestamp only  */
+			size = sizeof(s64);
+	else /* Data only */
+		size = indio_dev->scan_count * indio_dev->ring->bpe;
+	indio_dev->ring->access.set_bpd(indio_dev->ring, size);
+
+	return 0;
+}
+EXPORT_SYMBOL(iio_sw_ring_preenable);
+
 MODULE_DESCRIPTION("Industrialio I/O software ring buffer");
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/iio/ring_sw.h b/drivers/staging/iio/ring_sw.h
index fd677f0..5c22936 100644
--- a/drivers/staging/iio/ring_sw.h
+++ b/drivers/staging/iio/ring_sw.h
@@ -207,7 +207,7 @@ struct iio_sw_ring_buffer {
 struct iio_ring_buffer *iio_sw_rb_allocate(struct iio_dev *indio_dev);
 void iio_sw_rb_free(struct iio_ring_buffer *ring);
 
-
+int iio_sw_ring_preenable(struct iio_dev *indio_dev);
 
 #else /* CONFIG_IIO_RING_BUFFER*/
 static inline void iio_ring_sw_register_funcs(struct iio_ring_access_funcs *ra)
-- 
1.7.0.4
