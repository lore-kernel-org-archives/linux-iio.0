Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-108.synserver.de ([212.40.185.108]:1054 "EHLO
	smtp-out-100.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752976AbbJMQFi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 13 Oct 2015 12:05:38 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Cc: Octavian Purdila <octavian.purdila@intel.com>,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 1/6] iio: Set device watermark based on watermark of all attached buffers
Date: Tue, 13 Oct 2015 18:05:22 +0200
Message-Id: <1444752327-2629-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1444752327-2629-1-git-send-email-lars@metafoo.de>
References: <1444752327-2629-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Currently the watermark of the device is only set based on the watermark
that is set for the user space buffer. This doesn't consider the watermarks
set on any attached in-kernel buffers.

Change this so that the watermark of the device should be the minimum of
the watermarks over all attached buffers.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-buffer.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index d7e908a..7340922 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -610,6 +610,7 @@ static void iio_free_scan_mask(struct iio_dev *indio_dev,
 
 struct iio_device_config {
 	unsigned int mode;
+	unsigned int watermark;
 	const unsigned long *scan_mask;
 	unsigned int scan_bytes;
 	bool scan_timestamp;
@@ -642,10 +643,14 @@ static int iio_verify_update(struct iio_dev *indio_dev,
 		if (buffer == remove_buffer)
 			continue;
 		modes &= buffer->access->modes;
+		config->watermark = min(config->watermark, buffer->watermark);
 	}
 
-	if (insert_buffer)
+	if (insert_buffer) {
 		modes &= insert_buffer->access->modes;
+		config->watermark = min(config->watermark,
+			insert_buffer->watermark);
+	}
 
 	/* Definitely possible for devices to support both of these. */
 	if ((modes & INDIO_BUFFER_TRIGGERED) && indio_dev->trig) {
@@ -743,6 +748,10 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
 		}
 	}
 
+	if (indio_dev->info->hwfifo_set_watermark)
+		indio_dev->info->hwfifo_set_watermark(indio_dev,
+			config->watermark);
+
 	indio_dev->currentmode = config->mode;
 
 	if (indio_dev->setup_ops->postenable) {
@@ -974,9 +983,6 @@ static ssize_t iio_buffer_store_watermark(struct device *dev,
 	}
 
 	buffer->watermark = val;
-
-	if (indio_dev->info->hwfifo_set_watermark)
-		indio_dev->info->hwfifo_set_watermark(indio_dev, val);
 out:
 	mutex_unlock(&indio_dev->mlock);
 
-- 
2.1.4

