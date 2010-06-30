Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: barry.song@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 3/5] staging:iio: Add iio_sw_ring_helper_state and functions to cover common case.
Date: Wed, 30 Jun 2010 15:27:54 +0100
Message-Id: <1277908076-28592-4-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1277908076-28592-1-git-send-email-jic23@cam.ac.uk>
References: <1277908076-28592-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/ring_sw.c |   43 +++++++++++++++++++++++++++++++++++++++++
 drivers/staging/iio/ring_sw.h |   10 +++++++++
 2 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/ring_sw.c b/drivers/staging/iio/ring_sw.c
index ca0e79e..293df5c 100644
--- a/drivers/staging/iio/ring_sw.c
+++ b/drivers/staging/iio/ring_sw.c
@@ -13,6 +13,7 @@
 #include <linux/device.h>
 #include <linux/workqueue.h>
 #include "ring_sw.h"
+#include "trigger.h"
 
 static inline int __iio_allocate_sw_ring_buffer(struct iio_sw_ring_buffer *ring,
 						int bytes_per_datum, int length)
@@ -456,5 +457,47 @@ int iio_sw_ring_preenable(struct iio_dev *indio_dev)
 }
 EXPORT_SYMBOL(iio_sw_ring_preenable);
 
+void iio_sw_trigger_bh_to_ring(struct work_struct *work_s)
+{
+	struct iio_sw_ring_helper_state *st
+		= container_of(work_s, struct iio_sw_ring_helper_state,
+			work_trigger_to_ring);
+	int len = 0;
+	size_t datasize = st->indio_dev
+		->ring->access.get_bpd(st->indio_dev->ring);
+	char *data = kmalloc(datasize, GFP_KERNEL);
+	
+	if (data == NULL) {
+		dev_err(st->indio_dev->dev.parent,
+			"memory alloc failed in ring bh");
+		return;
+	}
+
+	if (st->indio_dev->scan_count)
+		len = st->get_ring_element(st, data);
+	
+	  /* Guaranteed to be aligned with 8 byte boundary */
+	if (st->indio_dev->scan_timestamp)
+		*(s64 *)(((u32)data + len + sizeof(s64) - 1) & ~(sizeof(s64) - 1))
+			= st->last_timestamp;
+	  st->indio_dev->ring->access.store_to(st->indio_dev->ring,
+					(u8 *)data,
+			st->last_timestamp);
+
+	iio_trigger_notify_done(st->indio_dev->trig);
+	kfree(data);
+
+	return;
+}
+EXPORT_SYMBOL(iio_sw_trigger_bh_to_ring);
+
+void iio_sw_poll_func_th(struct iio_dev *indio_dev, s64 time)
+{	struct iio_sw_ring_helper_state *h
+		= iio_dev_get_devdata(indio_dev);
+	h->last_timestamp = time;
+	schedule_work(&h->work_trigger_to_ring);
+}
+EXPORT_SYMBOL(iio_sw_poll_func_th);
+
 MODULE_DESCRIPTION("Industrialio I/O software ring buffer");
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/iio/ring_sw.h b/drivers/staging/iio/ring_sw.h
index 5c22936..59c99c0 100644
--- a/drivers/staging/iio/ring_sw.h
+++ b/drivers/staging/iio/ring_sw.h
@@ -209,6 +209,16 @@ void iio_sw_rb_free(struct iio_ring_buffer *ring);
 
 int iio_sw_ring_preenable(struct iio_dev *indio_dev);
 
+struct iio_sw_ring_helper_state {
+	struct work_struct		work_trigger_to_ring;
+	struct iio_dev			*indio_dev;
+	int (*get_ring_element)(struct iio_sw_ring_helper_state *st, u8 *buf);
+	s64 				last_timestamp;
+};
+
+void iio_sw_poll_func_th(struct iio_dev *indio_dev, s64 time);
+void iio_sw_trigger_bh_to_ring(struct work_struct *work_s);
+
 #else /* CONFIG_IIO_RING_BUFFER*/
 static inline void iio_ring_sw_register_funcs(struct iio_ring_access_funcs *ra)
 {};
-- 
1.7.0.4
