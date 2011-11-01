Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: linus.ml.walleij@gmail.com,
	broonie@opensource.wolfsonmicro.com,
	arnd@arndb.de,
	gregkh@suse.de,
	dtor@mail.ru,
	thomas.petazzoni@free-electrons.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 4/5] staging:iio: add a callback buffer for in kernel push interface
Date: Tue,  1 Nov 2011 17:11:52 +0000
Message-Id: <1320167513-587-5-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1320167513-587-1-git-send-email-jic23@cam.ac.uk>
References: <1320167513-587-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This callback buffer is meant to be opaque to users, but basically
adds a very simple pass through buffer to which data may be
pushed when it is inserted into the buffer list.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/Makefile    |    2 +-
 drivers/staging/iio/buffer_cb.c |  115 +++++++++++++++++++++++++++++++++++++++
 drivers/staging/iio/inkern.h    |   35 ++++++++++++
 3 files changed, 151 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
index d5ca5cf..b6e427a 100644
--- a/drivers/staging/iio/Makefile
+++ b/drivers/staging/iio/Makefile
@@ -4,7 +4,7 @@
 obj-y = inkern.o
 obj-$(CONFIG_IIO) += industrialio.o
 industrialio-y := industrialio-core.o
-industrialio-$(CONFIG_IIO_BUFFER) += industrialio-buffer.o
+industrialio-$(CONFIG_IIO_BUFFER) += industrialio-buffer.o buffer_cb.o
 industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
 
 obj-$(CONFIG_IIO_SW_RING) += ring_sw.o
diff --git a/drivers/staging/iio/buffer_cb.c b/drivers/staging/iio/buffer_cb.c
new file mode 100644
index 0000000..8c43a45
--- /dev/null
+++ b/drivers/staging/iio/buffer_cb.c
@@ -0,0 +1,115 @@
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include "buffer.h"
+#include "inkern.h"
+
+struct iio_cb_buffer {
+	struct iio_buffer buffer;
+	int (*cb)(u8 *data, void *private);
+	void *private;
+	struct iio_channel **channels;
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
+struct iio_cb_buffer *iio_st_channel_get_all_cb(const struct device *dev,
+						const char *name,
+						int (*cb)(u8 *data,
+							  void *private),
+						void *private)
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
+	cb_buff->channels = iio_st_channel_get_all(dev, name);
+	if (IS_ERR(cb_buff->channels)) {
+		ret = PTR_ERR(cb_buff->channels);
+		goto error_free_cb_buff;
+	}
+
+	indio_dev = cb_buff->channels[0]->indio_dev;
+	cb_buff->buffer.scan_mask
+		= kzalloc(sizeof(long)*BITS_TO_LONGS(indio_dev->masklength),
+			  GFP_KERNEL);
+	if (cb_buff->buffer.scan_mask == NULL) {
+		ret = -ENOMEM;
+		goto error_release_channels;
+	}
+	chan = cb_buff->channels[0];
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
+	iio_st_channel_release_all(cb_buff->channels);
+error_free_cb_buff:
+	kfree(cb_buff);
+error_ret:
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(iio_st_channel_get_all_cb);
+
+void iio_st_channel_start_all_cb(struct iio_cb_buffer *cb_buff)
+{
+	iio_update_buffers(cb_buff->channels[0]->indio_dev,
+				  &cb_buff->buffer,
+				  NULL);
+}
+EXPORT_SYMBOL_GPL(iio_st_channel_start_all_cb);
+
+void iio_st_channel_stop_all_cb(struct iio_cb_buffer *cb_buff)
+{
+	iio_update_buffers(cb_buff->channels[0]->indio_dev,
+			   NULL,
+			   &cb_buff->buffer);
+}
+EXPORT_SYMBOL_GPL(iio_st_channel_stop_all_cb);
+
+void iio_st_channel_release_all_cb(struct iio_cb_buffer *cb_buff)
+{
+	iio_st_channel_release_all(cb_buff->channels);
+	kfree(cb_buff);
+}
+EXPORT_SYMBOL_GPL(iio_st_channel_release_all_cb);
+
+struct iio_channel
+**iio_st_channel_cb_get_channels(const struct iio_cb_buffer *cb_buffer)
+{
+	return cb_buffer->channels;
+}
+EXPORT_SYMBOL_GPL(iio_st_channel_cb_get_channels);
diff --git a/drivers/staging/iio/inkern.h b/drivers/staging/iio/inkern.h
index fc32896..96da4e7 100644
--- a/drivers/staging/iio/inkern.h
+++ b/drivers/staging/iio/inkern.h
@@ -50,6 +50,41 @@ struct iio_channel **iio_st_channel_get_all(const struct device *dev,
 void iio_st_channel_release_all(struct iio_channel **chan);
 
 /**
+ * iio_st_channel_get_all_cb() - register callback for triggered capture
+ * @dev: device of client
+ * @name: name of client device
+ * @cb: callback
+ * @private: private data passed to callback.
+ *
+ * NB right now we have no ability to mux data from multiple devices.
+ * So if the channels requested come from different devices this will
+ * fail.
+ */
+struct iio_cb_buffer;
+struct iio_cb_buffer *iio_st_channel_get_all_cb(const struct device *dev,
+						const char *name,
+						int (*cb)(u8 *data,
+							  void *private),
+						void *private);
+/**
+ * iio_st_channel_release_all_cb() - release and unregister the callback.
+ * @cb_buffer: the callback buffer that was allocated
+ */
+void iio_st_channel_release_all_cb(struct iio_cb_buffer *cb_buffer);
+
+/**
+ * iio_st_channel_start_all_cb() - start the flow of data through callback
+ * @cb_buff: the callback buffer that was allocated
+ */
+void iio_st_channel_start_all_cb(struct iio_cb_buffer *cb_buff);
+
+void iio_st_channel_stop_all_cb(struct iio_cb_buffer *cb_buff);
+
+
+struct iio_channel
+**iio_st_channel_cb_get_channels(const struct iio_cb_buffer *cb_buffer);
+
+/**
  * iio_st_read_channel_raw() - read from a given channel
  * @channel:	the channel being queried.
  * @val:	value read back.
-- 
1.7.7
