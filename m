Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:51654 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751094AbdCQOfh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Mar 2017 10:35:37 -0400
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
To: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC: <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <kernel@stlinux.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <arnaud.pouliquen@st.com>, olivier moysan <olivier.moysan@st.com>
Subject: [PATCH v3 01/11] iio: Add hardware consumer support
Date: Fri, 17 Mar 2017 15:08:14 +0100
Message-ID: <1489759704-30217-2-git-send-email-arnaud.pouliquen@st.com>
In-Reply-To: <1489759704-30217-1-git-send-email-arnaud.pouliquen@st.com>
References: <1489759704-30217-1-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

Hardware consumer's can be used when one IIO device has a direct connection
to another device in hardware.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
V2 -> V3:
	 Just Adding sign off.  No update but Jonathan comment.
         Need to be taken into account (in agreement with Lars)
         when transforming rfc in patch.
---
 drivers/iio/Kconfig             |   6 ++
 drivers/iio/Makefile            |   1 +
 drivers/iio/hw_consumer.c       | 156 ++++++++++++++++++++++++++++++++++++++++
 include/linux/iio/hw_consumer.h |  12 ++++
 4 files changed, 175 insertions(+)
 create mode 100644 drivers/iio/hw_consumer.c
 create mode 100644 include/linux/iio/hw_consumer.h

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index 6743b18..956dd18 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -30,6 +30,12 @@ config IIO_CONFIGFS
 	  (e.g. software triggers). For more info see
 	  Documentation/iio/iio_configfs.txt.
 
+config IIO_HW_CONSUMER
+	tristate
+	help
+	  Hardware consumer buffer
+
+
 config IIO_TRIGGER
 	bool "Enable triggered sampling support"
 	help
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index 87e4c43..8472b97 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_IIO) += industrialio.o
 industrialio-y := industrialio-core.o industrialio-event.o inkern.o
 industrialio-$(CONFIG_IIO_BUFFER) += industrialio-buffer.o
 industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
+obj-$(CONFIG_IIO_HW_CONSUMER) += hw_consumer.o
 
 obj-$(CONFIG_IIO_CONFIGFS) += industrialio-configfs.o
 obj-$(CONFIG_IIO_SW_DEVICE) += industrialio-sw-device.o
diff --git a/drivers/iio/hw_consumer.c b/drivers/iio/hw_consumer.c
new file mode 100644
index 0000000..66f0732
--- /dev/null
+++ b/drivers/iio/hw_consumer.c
@@ -0,0 +1,156 @@
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/slab.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+
+#include <linux/iio/iio.h>
+#include "iio_core.h"
+#include <linux/iio/machine.h>
+#include <linux/iio/driver.h>
+#include <linux/iio/consumer.h>
+#include <linux/iio/hw_consumer.h>
+#include <linux/iio/buffer.h>
+
+struct iio_hw_consumer {
+	struct list_head buffers;
+	struct iio_channel *channels;
+};
+
+struct hw_consumer_buffer {
+	struct list_head head;
+	struct iio_dev *indio_dev;
+	struct iio_buffer buffer;
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
+	kfree(hw_buf->buffer.scan_mask);
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
+	struct hw_consumer_buffer *buf;
+
+	list_for_each_entry(buf, &hwc->buffers, head) {
+		if (buf->indio_dev == indio_dev)
+			return buf;
+	}
+
+	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
+	if (!buf)
+		return NULL;
+
+	buf->buffer.access = &iio_hw_buf_access;
+	buf->indio_dev = indio_dev;
+	buf->buffer.scan_mask = kcalloc(BITS_TO_LONGS(indio_dev->masklength),
+		sizeof(long), GFP_KERNEL);
+	if (!buf->buffer.scan_mask)
+		goto err_free_buf;
+
+	iio_buffer_init(&buf->buffer);
+	list_add_tail(&buf->head, &hwc->buffers);
+
+	return buf;
+
+err_free_buf:
+	kfree(buf);
+	return NULL;
+}
+
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
+		if (buf == NULL) {
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
+void iio_hw_consumer_free(struct iio_hw_consumer *hwc)
+{
+	struct hw_consumer_buffer *buf;
+
+	iio_channel_release_all(hwc->channels);
+	list_for_each_entry(buf, &hwc->buffers, head)
+		iio_buffer_put(&buf->buffer);
+	kfree(hwc);
+}
+EXPORT_SYMBOL_GPL(iio_hw_consumer_free);
+
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
+void iio_hw_consumer_disable(struct iio_hw_consumer *hwc)
+{
+	struct hw_consumer_buffer *buf;
+
+	list_for_each_entry(buf, &hwc->buffers, head)
+		iio_update_buffers(buf->indio_dev, NULL, &buf->buffer);
+}
+EXPORT_SYMBOL_GPL(iio_hw_consumer_disable);
diff --git a/include/linux/iio/hw_consumer.h b/include/linux/iio/hw_consumer.h
new file mode 100644
index 0000000..f12653d
--- /dev/null
+++ b/include/linux/iio/hw_consumer.h
@@ -0,0 +1,12 @@
+#ifndef LINUX_IIO_HW_CONSUMER_BUFFER_H
+#define LINUX_IIO_HW_CONSUMER_BUFFER_H
+
+struct device;
+struct iio_hw_consumer;
+
+struct iio_hw_consumer *iio_hw_consumer_alloc(struct device *dev);
+void iio_hw_consumer_free(struct iio_hw_consumer *hwc);
+int iio_hw_consumer_enable(struct iio_hw_consumer *hwc);
+void iio_hw_consumer_disable(struct iio_hw_consumer *hwc);
+
+#endif
-- 
1.9.1

