Return-Path: <SRS0=QH+w=EF=sirena.org.uk=broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Arnaud Pouliquen <arnaud.pouliquen@st.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Alexandre Torgue <alexandre.torgue@st.com>, linux-iio@vger.kernel.org, arnaud.pouliquen@st.com, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Subject: Applied "iio: Add hardware consumer buffer support" to the asoc tree
In-Reply-To: <1512744566-13233-2-git-send-email-arnaud.pouliquen@st.com>
Message-Id: <E1eZEKG-000552-6y@debutante>
Date: Wed, 10 Jan 2018 11:13:44 +0000
List-ID: <linux-iio@vger.kernel.org>

The patch

   iio: Add hardware consumer buffer support

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 48b66f8f936f369bb1a43c12aedbfeb2975baf4c Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Wed, 10 Jan 2018 11:13:03 +0100
Subject: [PATCH] iio: Add hardware consumer buffer support

Hardware consumer interface can be used when one IIO device has
a direct connection to another device in hardware.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/iio/buffer/Kconfig                    |  10 ++
 drivers/iio/buffer/Makefile                   |   1 +
 drivers/iio/buffer/industrialio-hw-consumer.c | 181 ++++++++++++++++++++++++++
 include/linux/iio/hw-consumer.h               |  19 +++
 4 files changed, 211 insertions(+)
 create mode 100644 drivers/iio/buffer/industrialio-hw-consumer.c
 create mode 100644 include/linux/iio/hw-consumer.h

diff --git a/drivers/iio/buffer/Kconfig b/drivers/iio/buffer/Kconfig
index 4ffd3db7817f..338774cba19b 100644
--- a/drivers/iio/buffer/Kconfig
+++ b/drivers/iio/buffer/Kconfig
@@ -29,6 +29,16 @@ config IIO_BUFFER_DMAENGINE
 
 	  Should be selected by drivers that want to use this functionality.
 
+config IIO_BUFFER_HW_CONSUMER
+	tristate "Industrial I/O HW buffering"
+	help
+	  Provides a way to bonding when an IIO device has a direct connection
+	  to another device in hardware. In this case buffers for data transfers
+	  are handled by hardware.
+
+	  Should be selected by drivers that want to use the generic Hw consumer
+	  interface.
+
 config IIO_KFIFO_BUF
 	tristate "Industrial I/O buffering based on kfifo"
 	help
diff --git a/drivers/iio/buffer/Makefile b/drivers/iio/buffer/Makefile
index 95f9f41c58b7..1403eb2f9409 100644
--- a/drivers/iio/buffer/Makefile
+++ b/drivers/iio/buffer/Makefile
@@ -7,5 +7,6 @@
 obj-$(CONFIG_IIO_BUFFER_CB) += industrialio-buffer-cb.o
 obj-$(CONFIG_IIO_BUFFER_DMA) += industrialio-buffer-dma.o
 obj-$(CONFIG_IIO_BUFFER_DMAENGINE) += industrialio-buffer-dmaengine.o
+obj-$(CONFIG_IIO_BUFFER_HW_CONSUMER) += industrialio-hw-consumer.o
 obj-$(CONFIG_IIO_TRIGGERED_BUFFER) += industrialio-triggered-buffer.o
 obj-$(CONFIG_IIO_KFIFO_BUF) += kfifo_buf.o
diff --git a/drivers/iio/buffer/industrialio-hw-consumer.c b/drivers/iio/buffer/industrialio-hw-consumer.c
new file mode 100644
index 000000000000..993ecdcdab64
--- /dev/null
+++ b/drivers/iio/buffer/industrialio-hw-consumer.c
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2017 Analog Devices Inc.
+ *  Author: Lars-Peter Clausen <lars@metafoo.de>
+ */
+
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/consumer.h>
+#include <linux/iio/hw-consumer.h>
+#include <linux/iio/buffer_impl.h>
+
+/**
+ * struct iio_hw_consumer - IIO hw consumer block
+ * @buffers: hardware buffers list head.
+ * @channels: IIO provider channels.
+ */
+struct iio_hw_consumer {
+	struct list_head buffers;
+	struct iio_channel *channels;
+};
+
+struct hw_consumer_buffer {
+	struct list_head head;
+	struct iio_dev *indio_dev;
+	struct iio_buffer buffer;
+	long scan_mask[];
+};
+
+static struct hw_consumer_buffer *iio_buffer_to_hw_consumer_buffer(
+	struct iio_buffer *buffer)
+{
+	return container_of(buffer, struct hw_consumer_buffer, buffer);
+}
+
+static void iio_hw_buf_release(struct iio_buffer *buffer)
+{
+	struct hw_consumer_buffer *hw_buf =
+		iio_buffer_to_hw_consumer_buffer(buffer);
+	kfree(hw_buf);
+}
+
+static const struct iio_buffer_access_funcs iio_hw_buf_access = {
+	.release = &iio_hw_buf_release,
+	.modes = INDIO_BUFFER_HARDWARE,
+};
+
+static struct hw_consumer_buffer *iio_hw_consumer_get_buffer(
+	struct iio_hw_consumer *hwc, struct iio_dev *indio_dev)
+{
+	size_t mask_size = BITS_TO_LONGS(indio_dev->masklength) * sizeof(long);
+	struct hw_consumer_buffer *buf;
+
+	list_for_each_entry(buf, &hwc->buffers, head) {
+		if (buf->indio_dev == indio_dev)
+			return buf;
+	}
+
+	buf = kzalloc(sizeof(*buf) + mask_size, GFP_KERNEL);
+	if (!buf)
+		return NULL;
+
+	buf->buffer.access = &iio_hw_buf_access;
+	buf->indio_dev = indio_dev;
+	buf->buffer.scan_mask = buf->scan_mask;
+
+	iio_buffer_init(&buf->buffer);
+	list_add_tail(&buf->head, &hwc->buffers);
+
+	return buf;
+}
+
+/**
+ * iio_hw_consumer_alloc() - Allocate IIO hardware consumer
+ * @dev: Pointer to consumer device.
+ *
+ * Returns a valid iio_hw_consumer on success or a ERR_PTR() on failure.
+ */
+struct iio_hw_consumer *iio_hw_consumer_alloc(struct device *dev)
+{
+	struct hw_consumer_buffer *buf;
+	struct iio_hw_consumer *hwc;
+	struct iio_channel *chan;
+	int ret;
+
+	hwc = kzalloc(sizeof(*hwc), GFP_KERNEL);
+	if (!hwc)
+		return ERR_PTR(-ENOMEM);
+
+	INIT_LIST_HEAD(&hwc->buffers);
+
+	hwc->channels = iio_channel_get_all(dev);
+	if (IS_ERR(hwc->channels)) {
+		ret = PTR_ERR(hwc->channels);
+		goto err_free_hwc;
+	}
+
+	chan = &hwc->channels[0];
+	while (chan->indio_dev) {
+		buf = iio_hw_consumer_get_buffer(hwc, chan->indio_dev);
+		if (!buf) {
+			ret = -ENOMEM;
+			goto err_put_buffers;
+		}
+		set_bit(chan->channel->scan_index, buf->buffer.scan_mask);
+		chan++;
+	}
+
+	return hwc;
+
+err_put_buffers:
+	list_for_each_entry(buf, &hwc->buffers, head)
+		iio_buffer_put(&buf->buffer);
+	iio_channel_release_all(hwc->channels);
+err_free_hwc:
+	kfree(hwc);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(iio_hw_consumer_alloc);
+
+/**
+ * iio_hw_consumer_free() - Free IIO hardware consumer
+ * @hwc: hw consumer to free.
+ */
+void iio_hw_consumer_free(struct iio_hw_consumer *hwc)
+{
+	struct hw_consumer_buffer *buf, *n;
+
+	iio_channel_release_all(hwc->channels);
+	list_for_each_entry_safe(buf, n, &hwc->buffers, head)
+		iio_buffer_put(&buf->buffer);
+	kfree(hwc);
+}
+EXPORT_SYMBOL_GPL(iio_hw_consumer_free);
+
+/**
+ * iio_hw_consumer_enable() - Enable IIO hardware consumer
+ * @hwc: iio_hw_consumer to enable.
+ *
+ * Returns 0 on success.
+ */
+int iio_hw_consumer_enable(struct iio_hw_consumer *hwc)
+{
+	struct hw_consumer_buffer *buf;
+	int ret;
+
+	list_for_each_entry(buf, &hwc->buffers, head) {
+		ret = iio_update_buffers(buf->indio_dev, &buf->buffer, NULL);
+		if (ret)
+			goto err_disable_buffers;
+	}
+
+	return 0;
+
+err_disable_buffers:
+	list_for_each_entry_continue_reverse(buf, &hwc->buffers, head)
+		iio_update_buffers(buf->indio_dev, NULL, &buf->buffer);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iio_hw_consumer_enable);
+
+/**
+ * iio_hw_consumer_disable() - Disable IIO hardware consumer
+ * @hwc: iio_hw_consumer to disable.
+ */
+void iio_hw_consumer_disable(struct iio_hw_consumer *hwc)
+{
+	struct hw_consumer_buffer *buf;
+
+	list_for_each_entry(buf, &hwc->buffers, head)
+		iio_update_buffers(buf->indio_dev, NULL, &buf->buffer);
+}
+EXPORT_SYMBOL_GPL(iio_hw_consumer_disable);
+
+MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
+MODULE_DESCRIPTION("Hardware consumer buffer the IIO framework");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/iio/hw-consumer.h b/include/linux/iio/hw-consumer.h
new file mode 100644
index 000000000000..db8c00b9c7a5
--- /dev/null
+++ b/include/linux/iio/hw-consumer.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Industrial I/O in kernel hardware consumer interface
+ *
+ * Copyright 2017 Analog Devices Inc.
+ *  Author: Lars-Peter Clausen <lars@metafoo.de>
+ */
+
+#ifndef LINUX_IIO_HW_CONSUMER_H
+#define LINUX_IIO_HW_CONSUMER_H
+
+struct iio_hw_consumer;
+
+struct iio_hw_consumer *iio_hw_consumer_alloc(struct device *dev);
+void iio_hw_consumer_free(struct iio_hw_consumer *hwc);
+int iio_hw_consumer_enable(struct iio_hw_consumer *hwc);
+void iio_hw_consumer_disable(struct iio_hw_consumer *hwc);
+
+#endif
-- 
2.15.1
