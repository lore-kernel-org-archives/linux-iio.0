Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41040 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753920AbdKIKOA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Nov 2017 05:14:00 -0500
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
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <arnaud.pouliquen@st.com>
Subject: [PATCH v4 10/12] IIO: consumer: allow to set buffer sizes
Date: Thu, 9 Nov 2017 11:12:32 +0100
Message-ID: <1510222354-15290-11-git-send-email-arnaud.pouliquen@st.com>
In-Reply-To: <1510222354-15290-1-git-send-email-arnaud.pouliquen@st.com>
References: <1510222354-15290-1-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add iio consumer API to set buffer size and watermark according
to sysfs API.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
V3 -> V4 changes:
 - Set only the Watermark not the buffer lenght
 - Rename functions to replace "params" with "watermark"

 drivers/iio/buffer/industrialio-buffer-cb.c | 11 +++++++++++
 include/linux/iio/consumer.h                | 11 +++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/iio/buffer/industrialio-buffer-cb.c b/drivers/iio/buffer/industrialio-buffer-cb.c
index 4847534..ea63c83 100644
--- a/drivers/iio/buffer/industrialio-buffer-cb.c
+++ b/drivers/iio/buffer/industrialio-buffer-cb.c
@@ -104,6 +104,17 @@ struct iio_cb_buffer *iio_channel_get_all_cb(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(iio_channel_get_all_cb);
 
+int iio_channel_cb_set_buffer_watermark(struct iio_cb_buffer *cb_buff,
+					size_t watermark)
+{
+	if (!watermark)
+		return -EINVAL;
+	cb_buff->buffer.watermark = watermark;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iio_channel_cb_set_buffer_watermark);
+
 int iio_channel_start_all_cb(struct iio_cb_buffer *cb_buff)
 {
 	return iio_update_buffers(cb_buff->indio_dev, &cb_buff->buffer,
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index 5e347a9..0d94557 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -134,6 +134,17 @@ struct iio_cb_buffer *iio_channel_get_all_cb(struct device *dev,
 						       void *private),
 					     void *private);
 /**
+ * iio_channel_cb_set_buffer_watermark() - set the buffer watermark.
+ * @cb_buffer:		The callback buffer from whom we want the channel
+ *			information.
+ * @watermark: buffer watermark in bytes.
+ *
+ * This function allows to configure the buffer watermark.
+ */
+int iio_channel_cb_set_buffer_watermark(struct iio_cb_buffer *cb_buffer,
+					size_t watermark);
+
+/**
  * iio_channel_release_all_cb() - release and unregister the callback.
  * @cb_buffer:		The callback buffer that was allocated.
  */
-- 
2.7.4

