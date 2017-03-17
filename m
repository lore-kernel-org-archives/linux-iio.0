Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:10386 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751064AbdCQOeg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Mar 2017 10:34:36 -0400
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
Subject: [PATCH v3 07/11] IIO: consumer: allow to set buffer sizes
Date: Fri, 17 Mar 2017 15:08:20 +0100
Message-ID: <1489759704-30217-8-git-send-email-arnaud.pouliquen@st.com>
In-Reply-To: <1489759704-30217-1-git-send-email-arnaud.pouliquen@st.com>
References: <1489759704-30217-1-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add iio consumer API to set buffer size and watermark according
to sysfs API.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/iio/buffer/industrialio-buffer-cb.c | 12 ++++++++++++
 include/linux/iio/consumer.h                | 13 +++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/iio/buffer/industrialio-buffer-cb.c b/drivers/iio/buffer/industrialio-buffer-cb.c
index b8f550e..43c066a 100644
--- a/drivers/iio/buffer/industrialio-buffer-cb.c
+++ b/drivers/iio/buffer/industrialio-buffer-cb.c
@@ -103,6 +103,18 @@ struct iio_cb_buffer *iio_channel_get_all_cb(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(iio_channel_get_all_cb);
 
+int iio_channel_cb_set_buffer_params(struct iio_cb_buffer *cb_buff,
+				      size_t length, size_t watermark)
+{
+	if (!length || length < watermark)
+		return -EINVAL;
+	cb_buff->buffer.watermark = watermark;
+	cb_buff->buffer.length = length;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iio_channel_start_all_cb);
+
 int iio_channel_start_all_cb(struct iio_cb_buffer *cb_buff)
 {
 	return iio_update_buffers(cb_buff->indio_dev, &cb_buff->buffer,
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index cb44771..0f6e94d 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -134,6 +134,19 @@ struct iio_cb_buffer *iio_channel_get_all_cb(struct device *dev,
 						       void *private),
 					     void *private);
 /**
+ * iio_channel_cb_set_buffer_size() - set the buffer length.
+ * @cb_buffer:		The callback buffer from whom we want the channel
+ *			information.
+ * @length: buffer length in bytes
+ * @watermark: buffer watermark in bytes
+ *
+ * This function allows to configure the buffer length. The watermark if
+ * forced to half of the buffer.
+ */
+int iio_channel_cb_set_buffer_params(struct iio_cb_buffer *cb_buffer,
+				     size_t length, size_t watermark);
+
+/**
  * iio_channel_release_all_cb() - release and unregister the callback.
  * @cb_buffer:		The callback buffer that was allocated.
  */
-- 
1.9.1

