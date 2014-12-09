Return-Path: <k.wrona@samsung.com>
From: Karol Wrona <k.wrona@samsung.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 Hartmut Knaack <knaack.h@gmx.de>, linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Karol Wrona <wrona.vy@gmail.com>,
 Karol Wrona <k.wrona@samsung.com>
Subject: [RFC PATCH 2/2] iio: kfifo: Add resource management
 devm_iio_kfifo_allocate/free
Date: Tue, 09 Dec 2014 20:29:45 +0100
Message-id: <1418153385-18212-3-git-send-email-k.wrona@samsung.com>
In-reply-to: <1418153385-18212-1-git-send-email-k.wrona@samsung.com>
References: <1418153385-18212-1-git-send-email-k.wrona@samsung.com>
List-ID: <linux-iio@vger.kernel.org>

iio kfifo allocate/free gained their devm_ wrappers.

Change-Id: I10c19ccd7c01491caf088b3629137425ddccd29c
Signed-off-by: Karol Wrona <k.wrona@samsung.com>
Suggested-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/kfifo_buf.c       |   54 +++++++++++++++++++++++++++++++++++++++++
 include/linux/iio/kfifo_buf.h |    3 +++
 2 files changed, 57 insertions(+)

diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c
index 5b5387c..03a133f 100644
--- a/drivers/iio/kfifo_buf.c
+++ b/drivers/iio/kfifo_buf.c
@@ -191,4 +191,58 @@ void iio_kfifo_free(struct iio_buffer *r)
 }
 EXPORT_SYMBOL(iio_kfifo_free);
 
+static void devm_iio_kfifo_release(struct device *dev, void *res)
+{
+	iio_kfifo_free(*(struct iio_buffer **)res);
+}
+
+static int devm_iio_kfifo_match(struct device *dev, void *res, void *data)
+{
+	struct iio_buffer **r = res;
+
+	if (WARN_ON(!r || !*r))
+		return 0;
+
+	return *r == data;
+}
+
+/**
+ * devm_iio_fifo_allocate - Resource-managed iio_kfifo_allocate()
+ * @dev:		Device to allocate kfifo buffer for
+ *
+ * RETURNS:
+ * Pointer to allocated iio_buffer on success, NULL on failure.
+ */
+struct iio_buffer *devm_iio_kfifo_allocate(struct device *dev)
+{
+	struct iio_buffer **ptr, *r;
+
+	ptr = devres_alloc(devm_iio_kfifo_release, sizeof *ptr, GFP_KERNEL);
+	if (!ptr)
+		return NULL;
+
+	r = iio_kfifo_allocate();
+	if (r) {
+		*ptr = r;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return r;
+}
+EXPORT_SYMBOL(devm_iio_kfifo_allocate);
+
+/**
+ * devm_iio_fifo_free - Resource-managed iio_kfifo_free()
+ * @dev:		Device the buffer belongs to
+ * @r:			the buffer associated with the device
+ */
+void devm_iio_kfifo_free(struct device *dev, struct iio_buffer *r)
+{
+	WARN_ON(devres_release(dev, devm_iio_kfifo_release,
+			       devm_iio_kfifo_match, r));
+}
+EXPORT_SYMBOL(devm_iio_kfifo_free);
+
 MODULE_LICENSE("GPL");
diff --git a/include/linux/iio/kfifo_buf.h b/include/linux/iio/kfifo_buf.h
index 1a8d57a..1683bc7 100644
--- a/include/linux/iio/kfifo_buf.h
+++ b/include/linux/iio/kfifo_buf.h
@@ -8,4 +8,7 @@
 struct iio_buffer *iio_kfifo_allocate(void);
 void iio_kfifo_free(struct iio_buffer *r);
 
+struct iio_buffer *devm_iio_kfifo_allocate(struct device *dev);
+void devm_iio_kfifo_free(struct device *dev, struct iio_buffer *r);
+
 #endif
-- 
1.7.9.5
