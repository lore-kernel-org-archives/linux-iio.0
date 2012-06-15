Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-061.synserver.de ([212.40.185.61]:1049 "EHLO
	smtp-out-048.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756345Ab2FONWT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jun 2012 09:22:19 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio:buffer: Fix NULL pointer deref caused by empty scan mask
Date: Fri, 15 Jun 2012 15:25:49 +0200
Message-Id: <1339766749-5460-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

iio_scan_mask_match() returns NULL if the passed in scan mask is empty. This
will happen if no channel has been selected and buffer is enabled.
iio_sw_buffer_preenable() will assign NULL to indio_dev->active_scan_mask in
this case and as a result iio_update_demux() will cause a NULL pointer deref,
because it expects active_scan_mask to be non-NULL.

Since it does not make much sense to start data capture if there is no data to
capture this patch updates the code to fail gracefully in iio_scan_mask_match()
instead of crashing the kernel.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-buffer.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index ac185b8..2f35db9 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -553,6 +553,10 @@ int iio_sw_buffer_preenable(struct iio_dev *indio_dev)
 					    buffer->scan_mask);
 	else
 		indio_dev->active_scan_mask = buffer->scan_mask;
+
+	if (indio_dev->active_scan_mask == NULL)
+		return -EINVAL;
+
 	iio_update_demux(indio_dev);
 
 	if (indio_dev->info->update_scan_mode)
-- 
1.7.10

