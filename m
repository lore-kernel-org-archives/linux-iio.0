Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-108.synserver.de ([212.40.185.108]:1132 "EHLO
	smtp-out-100.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932369AbbJMQFq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 13 Oct 2015 12:05:46 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Cc: Octavian Purdila <octavian.purdila@intel.com>,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 6/6] iio: Add a DMAengine framework based buffer
Date: Tue, 13 Oct 2015 18:05:27 +0200
Message-Id: <1444752327-2629-7-git-send-email-lars@metafoo.de>
In-Reply-To: <1444752327-2629-1-git-send-email-lars@metafoo.de>
References: <1444752327-2629-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add a generic fully device independent DMA buffer implementation that uses
the DMAegnine framework to perform the DMA transfers. This can be used by
converter drivers that whish to provide a DMA buffer for converters that
are connected to a DMA core that implements the DMAengine API.

Apart from allocating the buffer using iio_dmaengine_buffer_alloc() and
freeing it using iio_dmaengine_buffer_free() no additional converter driver
specific code is required when using this DMA buffer implementation.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/buffer/Kconfig                         |  11 ++
 drivers/iio/buffer/Makefile                        |   1 +
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 213 +++++++++++++++++++++
 include/linux/iio/buffer-dmaengine.h               |  18 ++
 4 files changed, 243 insertions(+)
 create mode 100644 drivers/iio/buffer/industrialio-buffer-dmaengine.c
 create mode 100644 include/linux/iio/buffer-dmaengine.h

diff --git a/drivers/iio/buffer/Kconfig b/drivers/iio/buffer/Kconfig
index b2fda1a..4ffd3db 100644
--- a/drivers/iio/buffer/Kconfig
+++ b/drivers/iio/buffer/Kconfig
@@ -18,6 +18,17 @@ config IIO_BUFFER_DMA
 	  Should be selected by drivers that want to use the generic DMA buffer
 	  infrastructure.
 
+config IIO_BUFFER_DMAENGINE
+	tristate
+	select IIO_BUFFER_DMA
+	help
+	  Provides a bonding of the generic IIO DMA buffer infrastructure with the
+	  DMAengine framework. This can be used by converter drivers with a DMA port
+	  connected to an external DMA controller which is supported by the
+	  DMAengine framework.
+
+	  Should be selected by drivers that want to use this functionality.
+
 config IIO_KFIFO_BUF
 	tristate "Industrial I/O buffering based on kfifo"
 	help
diff --git a/drivers/iio/buffer/Makefile b/drivers/iio/buffer/Makefile
index bda3f11..85beaae 100644
--- a/drivers/iio/buffer/Makefile
+++ b/drivers/iio/buffer/Makefile
@@ -5,5 +5,6 @@
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_IIO_BUFFER_CB) += industrialio-buffer-cb.o
 obj-$(CONFIG_IIO_BUFFER_DMA) += industrialio-buffer-dma.o
+obj-$(CONFIG_IIO_BUFFER_DMAENGINE) += industrialio-buffer-dmaengine.o
 obj-$(CONFIG_IIO_TRIGGERED_BUFFER) += industrialio-triggered-buffer.o
 obj-$(CONFIG_IIO_KFIFO_BUF) += kfifo_buf.o
diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
new file mode 100644
index 0000000..ebdb838
--- /dev/null
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -0,0 +1,213 @@
+/*
+ * Copyright 2014-2015 Analog Devices Inc.
+ *  Author: Lars-Peter Clausen <lars@metafoo.de>
+ *
+ * Licensed under the GPL-2 or later.
+ */
+
+#include <linux/slab.h>
+#include <linux/kernel.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/spinlock.h>
+#include <linux/err.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/buffer-dma.h>
+#include <linux/iio/buffer-dmaengine.h>
+
+/*
+ * The IIO DMAengine buffer combines the generic IIO DMA buffer infrastructure
+ * with the DMAengine framework. The generic IIO DMA buffer infrastructure is
+ * used to manage the buffer memory and implement the IIO buffer operations
+ * while the DMAengine framework is used to perform the DMA transfers. Combined
+ * this results in a device independent fully functional DMA buffer
+ * implementation that can be used by device drivers for peripherals which are
+ * connected to a DMA controller which has a DMAengine driver implementation.
+ */
+
+struct dmaengine_buffer {
+	struct iio_dma_buffer_queue queue;
+
+	struct dma_chan *chan;
+	struct list_head active;
+
+	size_t align;
+	size_t max_size;
+};
+
+static struct dmaengine_buffer *iio_buffer_to_dmaengine_buffer(
+		struct iio_buffer *buffer)
+{
+	return container_of(buffer, struct dmaengine_buffer, queue.buffer);
+}
+
+static void iio_dmaengine_buffer_block_done(void *data)
+{
+	struct iio_dma_buffer_block *block = data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&block->queue->list_lock, flags);
+	list_del(&block->head);
+	spin_unlock_irqrestore(&block->queue->list_lock, flags);
+	iio_dma_buffer_block_done(block);
+}
+
+static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
+	struct iio_dma_buffer_block *block)
+{
+	struct dmaengine_buffer *dmaengine_buffer =
+		iio_buffer_to_dmaengine_buffer(&queue->buffer);
+	struct dma_async_tx_descriptor *desc;
+	dma_cookie_t cookie;
+
+	block->bytes_used = min(block->size, dmaengine_buffer->max_size);
+	block->bytes_used = rounddown(block->bytes_used,
+			dmaengine_buffer->align);
+
+	desc = dmaengine_prep_slave_single(dmaengine_buffer->chan,
+		block->phys_addr, block->bytes_used, DMA_DEV_TO_MEM,
+		DMA_PREP_INTERRUPT);
+	if (!desc)
+		return -ENOMEM;
+
+	desc->callback = iio_dmaengine_buffer_block_done;
+	desc->callback_param = block;
+
+	cookie = dmaengine_submit(desc);
+	if (dma_submit_error(cookie))
+		return dma_submit_error(cookie);
+
+	spin_lock_irq(&dmaengine_buffer->queue.list_lock);
+	list_add_tail(&block->head, &dmaengine_buffer->active);
+	spin_unlock_irq(&dmaengine_buffer->queue.list_lock);
+
+	dma_async_issue_pending(dmaengine_buffer->chan);
+
+	return 0;
+}
+
+static void iio_dmaengine_buffer_abort(struct iio_dma_buffer_queue *queue)
+{
+	struct dmaengine_buffer *dmaengine_buffer =
+		iio_buffer_to_dmaengine_buffer(&queue->buffer);
+
+	dmaengine_terminate_all(dmaengine_buffer->chan);
+	/* FIXME: There is a slight chance of a race condition here.
+	 * dmaengine_terminate_all() does not guarantee that all transfer
+	 * callbacks have finished running. Need to introduce a
+	 * dmaengine_terminate_all_sync().
+	 */
+	iio_dma_buffer_block_list_abort(queue, &dmaengine_buffer->active);
+}
+
+static void iio_dmaengine_buffer_release(struct iio_buffer *buf)
+{
+	struct dmaengine_buffer *dmaengine_buffer =
+		iio_buffer_to_dmaengine_buffer(buf);
+
+	iio_dma_buffer_release(&dmaengine_buffer->queue);
+	kfree(dmaengine_buffer);
+}
+
+static const struct iio_buffer_access_funcs iio_dmaengine_buffer_ops = {
+	.read_first_n = iio_dma_buffer_read,
+	.set_bytes_per_datum = iio_dma_buffer_set_bytes_per_datum,
+	.set_length = iio_dma_buffer_set_length,
+	.request_update = iio_dma_buffer_request_update,
+	.enable = iio_dma_buffer_enable,
+	.disable = iio_dma_buffer_disable,
+	.data_available = iio_dma_buffer_data_available,
+	.release = iio_dmaengine_buffer_release,
+
+	.modes = INDIO_BUFFER_HARDWARE,
+	.flags = INDIO_BUFFER_FLAG_FIXED_WATERMARK,
+};
+
+static const struct iio_dma_buffer_ops iio_dmaengine_default_ops = {
+	.submit = iio_dmaengine_buffer_submit_block,
+	.abort = iio_dmaengine_buffer_abort,
+};
+
+/**
+ * iio_dmaengine_buffer_alloc() - Allocate new buffer which uses DMAengine
+ * @dev: Parent device for the buffer
+ * @channel: DMA channel name, typically "rx".
+ *
+ * This allocates a new IIO buffer which internally uses the DMAengine framework
+ * to perform its transfers. The parent device will be used to request the DMA
+ * channel.
+ *
+ * Once done using the buffer iio_dmaengine_buffer_free() should be used to
+ * release it.
+ */
+struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
+	const char *channel)
+{
+	struct dmaengine_buffer *dmaengine_buffer;
+	unsigned int width, src_width, dest_width;
+	struct dma_slave_caps caps;
+	struct dma_chan *chan;
+	int ret;
+
+	dmaengine_buffer = kzalloc(sizeof(*dmaengine_buffer), GFP_KERNEL);
+	if (!dmaengine_buffer)
+		return ERR_PTR(-ENOMEM);
+
+	chan = dma_request_slave_channel_reason(dev, channel);
+	if (IS_ERR(chan)) {
+		ret = PTR_ERR(chan);
+		goto err_free;
+	}
+
+	ret = dma_get_slave_caps(chan, &caps);
+	if (ret < 0)
+		goto err_free;
+
+	/* Needs to be aligned to the maximum of the minimums */
+	if (caps.src_addr_widths)
+		src_width = __ffs(caps.src_addr_widths);
+	else
+		src_width = 1;
+	if (caps.dst_addr_widths)
+		dest_width = __ffs(caps.dst_addr_widths);
+	else
+		dest_width = 1;
+	width = max(src_width, dest_width);
+
+	INIT_LIST_HEAD(&dmaengine_buffer->active);
+	dmaengine_buffer->chan = chan;
+	dmaengine_buffer->align = width;
+	dmaengine_buffer->max_size = dma_get_max_seg_size(chan->device->dev);
+
+	iio_dma_buffer_init(&dmaengine_buffer->queue, chan->device->dev,
+		&iio_dmaengine_default_ops);
+
+	dmaengine_buffer->queue.buffer.access = &iio_dmaengine_buffer_ops;
+
+	return &dmaengine_buffer->queue.buffer;
+
+err_free:
+	kfree(dmaengine_buffer);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL(iio_dmaengine_buffer_alloc);
+
+/**
+ * iio_dmaengine_buffer_free() - Free dmaengine buffer
+ * @buffer: Buffer to free
+ *
+ * Frees a buffer previously allocated with iio_dmaengine_buffer_alloc().
+ */
+void iio_dmaengine_buffer_free(struct iio_buffer *buffer)
+{
+	struct dmaengine_buffer *dmaengine_buffer =
+		iio_buffer_to_dmaengine_buffer(buffer);
+
+	iio_dma_buffer_exit(&dmaengine_buffer->queue);
+	dma_release_channel(dmaengine_buffer->chan);
+
+	iio_buffer_put(buffer);
+}
+EXPORT_SYMBOL_GPL(iio_dmaengine_buffer_free);
diff --git a/include/linux/iio/buffer-dmaengine.h b/include/linux/iio/buffer-dmaengine.h
new file mode 100644
index 0000000..5dcddf4
--- /dev/null
+++ b/include/linux/iio/buffer-dmaengine.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright 2014-2015 Analog Devices Inc.
+ *  Author: Lars-Peter Clausen <lars@metafoo.de>
+ *
+ * Licensed under the GPL-2 or later.
+ */
+
+#ifndef __IIO_DMAENGINE_H__
+#define __IIO_DMAENGINE_H__
+
+struct iio_buffer;
+struct device;
+
+struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
+	const char *channel);
+void iio_dmaengine_buffer_free(struct iio_buffer *buffer);
+
+#endif
-- 
2.1.4

