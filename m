Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 3/4] staging:iio: add a callback buffer for in kernel push interface
Date: Wed, 30 May 2012 20:36:33 +0100
Message-Id: <1338406594-14550-4-git-send-email-jic23@kernel.org>
In-Reply-To: <1338406594-14550-1-git-send-email-jic23@kernel.org>
References: <1338406594-14550-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

This callback buffer is meant to be opaque to users, but basically
adds a very simple pass through buffer to which data may be
pushed when it is inserted into the buffer list.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/Kconfig          |    6 +++
 drivers/iio/Makefile         |    1 +
 drivers/iio/buffer_cb.c      |  115 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/iio/consumer.h |   46 +++++++++++++++++
 4 files changed, 168 insertions(+)

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index 62fda86..c9e9483 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -21,6 +21,12 @@ config IIO_BUFFER
 
 if IIO_BUFFER
 
+config IIO_BUFFER_CB
+       boolean "IIO callback buffer used for push in kernel interfaces"
+       help
+         Should be selected by any drivers that do inkernel push
+	 usage.  That is, those where the data is pushed to the consumer.
+
 config IIO_KFIFO_BUF
 	select IIO_TRIGGER
 	tristate "Industrial I/O buffering based on kfifo"
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index 30a9144..2df439c 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_IIO) += industrialio.o
 industrialio-y := industrialio-core.o industrialio-event.o inkern.o
 industrialio-$(CONFIG_IIO_BUFFER) += industrialio-buffer.o
 industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
+industrialio-$(CONFIG_IIO_BUFFER_CB) += buffer_cb.o
 
 obj-$(CONFIG_IIO_KFIFO_BUF) += kfifo_buf.o
 
diff --git a/drivers/iio/buffer_cb.c b/drivers/iio/buffer_cb.c
new file mode 100644
index 0000000..d686bdf
--- /dev/null
+++ b/drivers/iio/buffer_cb.c
@@ -0,0 +1,115 @@
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/consumer.h>
+
+struct iio_cb_buffer {
+	struct iio_buffer buffer;
+	int (*cb)(u8 *data, void *private);
+	void *private;
+	struct iio_channel *channels;
+};
+
+static int iio_buffer_cb_store_to(struct iio_buffer *buffer,
+				  u8 *data,
+				  s64 timestamp)
+{
+	struct iio_cb_buffer *cb_buff = container_of(buffer,
+						     struct iio_cb_buffer,
+						     buffer);
+
+	return cb_buff->cb(data, cb_buff->private);
+}
+
+static struct iio_buffer_access_funcs iio_cb_access = {
+	.store_to = &iio_buffer_cb_store_to,
+};
+
+struct iio_cb_buffer *iio_channel_get_all_cb(const char *name,
+					     int (*cb)(u8 *data,
+						       void *private),
+					     void *private)
+{
+	int ret;
+	struct iio_cb_buffer *cb_buff;
+	struct iio_dev *indio_dev;
+	struct iio_channel *chan;
+
+	cb_buff = kzalloc(sizeof *cb_buff, GFP_KERNEL);
+	if (cb_buff == NULL) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+
+	cb_buff->private = private;
+	cb_buff->cb = cb;
+	cb_buff->buffer.access = &iio_cb_access;
+	INIT_LIST_HEAD(&cb_buff->buffer.demux_list);
+
+	cb_buff->channels = iio_channel_get_all(name);
+	if (IS_ERR(cb_buff->channels)) {
+		ret = PTR_ERR(cb_buff->channels);
+		goto error_free_cb_buff;
+	}
+
+	indio_dev = cb_buff->channels[0].indio_dev;
+	cb_buff->buffer.scan_mask
+		= kzalloc(sizeof(long)*BITS_TO_LONGS(indio_dev->masklength),
+			  GFP_KERNEL);
+	if (cb_buff->buffer.scan_mask == NULL) {
+		ret = -ENOMEM;
+		goto error_release_channels;
+	}
+	chan = &cb_buff->channels[0];
+	while (chan->indio_dev) {
+		if (chan->indio_dev != indio_dev) {
+			ret = -EINVAL;
+			goto error_release_channels;
+		}
+		set_bit(chan->channel->scan_index,
+			cb_buff->buffer.scan_mask);
+		chan++;
+	}
+
+	return cb_buff;
+
+error_release_channels:
+	iio_channel_release_all(cb_buff->channels);
+error_free_cb_buff:
+	kfree(cb_buff);
+error_ret:
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(iio_channel_get_all_cb);
+
+void iio_channel_start_all_cb(struct iio_cb_buffer *cb_buff)
+{
+	iio_update_buffers(cb_buff->channels[0].indio_dev,
+				  &cb_buff->buffer,
+				  NULL);
+}
+EXPORT_SYMBOL_GPL(iio_channel_start_all_cb);
+
+void iio_channel_stop_all_cb(struct iio_cb_buffer *cb_buff)
+{
+	iio_update_buffers(cb_buff->channels[0].indio_dev,
+			   NULL,
+			   &cb_buff->buffer);
+}
+EXPORT_SYMBOL_GPL(iio_channel_stop_all_cb);
+
+void iio_channel_release_all_cb(struct iio_cb_buffer *cb_buff)
+{
+	iio_channel_release_all(cb_buff->channels);
+	kfree(cb_buff);
+}
+EXPORT_SYMBOL_GPL(iio_channel_release_all_cb);
+
+struct iio_channel
+*iio_channel_cb_get_channels(const struct iio_cb_buffer *cb_buffer)
+{
+	return cb_buffer->channels;
+}
+EXPORT_SYMBOL_GPL(iio_channel_cb_get_channels);
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index 26040c2..efd377e 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -61,6 +61,52 @@ struct iio_channel *iio_channel_get_all(const char *name);
  */
 void iio_channel_release_all(struct iio_channel *chan);
 
+struct iio_cb_buffer;
+/**
+ * iio_channel_get_all_cb() - register callback for triggered capture
+ * @name:		Name of client device.
+ * @cb:			Callback function.
+ * @private:		Private data passed to callback.
+ *
+ * NB right now we have no ability to mux data from multiple devices.
+ * So if the channels requested come from different devices this will
+ * fail.
+ */
+struct iio_cb_buffer *iio_channel_get_all_cb(const char *name,
+					     int (*cb)(u8 *data,
+						       void *private),
+					     void *private);
+/**
+ * iio_channel_release_all_cb() - release and unregister the callback.
+ * @cb_buffer:		The callback buffer that was allocated.
+ */
+void iio_channel_release_all_cb(struct iio_cb_buffer *cb_buffer);
+
+/**
+ * iio_channel_start_all_cb() - start the flow of data through callback.
+ * @cb_buff:		The callback buffer we are starting.
+ */
+void iio_channel_start_all_cb(struct iio_cb_buffer *cb_buff);
+
+/**
+ * iio_channel_stop_all_cb() - stop the flow of data through the callback.
+ * @cb_buff:		The callback buffer we are stopping.
+ */
+void iio_channel_stop_all_cb(struct iio_cb_buffer *cb_buff);
+
+/**
+ * iio_channel_cb_get_channels() - get access to the underlying channels.
+ * @cb_buff:		The callback buffers from whom we want the channel
+ *			information.
+ *
+ * This function allows one to obtain information about the channels.
+ * Whilst this may allow direct reading if all buffers are disabled, the
+ * primary aim is to allow drivers that are consuming a channel to query
+ * things like scaling of the channel.
+ */
+struct iio_channel
+*iio_channel_cb_get_channels(const struct iio_cb_buffer *cb_buffer);
+
 /**
  * iio_read_channel_raw() - read from a given channel
  * @channel:		The channel being queried.
-- 
1.7.10.2
