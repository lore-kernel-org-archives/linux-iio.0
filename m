Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-014.synserver.de ([212.40.185.14]:1102 "EHLO
	smtp-out-011.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753647Ab3IRUB0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2013 16:01:26 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 10/10] iio:buffer: Ignore noop requests for iio_update_buffers()
Date: Wed, 18 Sep 2013 22:02:54 +0200
Message-Id: <1379534574-11213-10-git-send-email-lars@metafoo.de>
In-Reply-To: <1379534574-11213-1-git-send-email-lars@metafoo.de>
References: <1379534574-11213-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Since the kernel now disables all buffers when a device is unregistered it might
happen that a in-kernel consumer tries to disable that buffer again. So ignore
requests where the buffer already is in the desired state.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-buffer.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 8ceaaaf..2b36cea 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -673,9 +673,21 @@ int iio_update_buffers(struct iio_dev *indio_dev,
 {
 	int ret;
 
+	if (insert_buffer == remove_buffer)
+		return 0;
+
 	mutex_lock(&indio_dev->info_exist_lock);
 	mutex_lock(&indio_dev->mlock);
 
+	if (insert_buffer && iio_buffer_is_active(insert_buffer))
+		insert_buffer = NULL;
+
+	if (remove_buffer && !iio_buffer_is_active(remove_buffer))
+		remove_buffer = NULL;
+
+	if (!insert_buffer && !remove_buffer)
+		return 0;
+
 	if (indio_dev->info == NULL)
 		return -ENODEV;
 
-- 
1.8.0

