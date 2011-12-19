Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:53432 "EHLO
	TX2EHSOBE009.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752597Ab1LSOXX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 19 Dec 2011 09:23:23 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@suse.de>
CC: Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	<devel@driverdev.osuosl.org>, <linux-iio@vger.kernel.org>,
	<device-drivers-devel@blackfin.uclinux.org>, <drivers@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/8] staging:iio: Disallow modifying buffer size when buffer is enabled
Date: Mon, 19 Dec 2011 15:23:44 +0100
Message-ID: <1324304629-24720-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1324304629-24720-1-git-send-email-lars@metafoo.de>
References: <1324304629-24720-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The buffer buffer storage is only update when enabling the buffer. Changing the
buffer size while the buffer is enabled will confuse the buffer in regard to
its actual buffer size and can cause potential memory corruption. Thus it is
only safe to modify the buffer size when the buffer is disabled.

Acked-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/industrialio-buffer.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
index 747b901..5947289 100644
--- a/drivers/staging/iio/industrialio-buffer.c
+++ b/drivers/staging/iio/industrialio-buffer.c
@@ -396,13 +396,20 @@ ssize_t iio_buffer_write_length(struct device *dev,
 		if (val == buffer->access->get_length(buffer))
 			return len;
 
-	if (buffer->access->set_length) {
-		buffer->access->set_length(buffer, val);
-		if (buffer->access->mark_param_change)
-			buffer->access->mark_param_change(buffer);
+	mutex_lock(&indio_dev->mlock);
+	if (iio_buffer_enabled(indio_dev)) {
+		ret = -EBUSY;
+	} else {
+		if (buffer->access->set_length) {
+			buffer->access->set_length(buffer, val);
+			if (buffer->access->mark_param_change)
+				buffer->access->mark_param_change(buffer);
+		}
+		ret = 0;
 	}
+	mutex_unlock(&indio_dev->mlock);
 
-	return len;
+	return ret ? ret : len;
 }
 EXPORT_SYMBOL(iio_buffer_write_length);
 
-- 
1.7.7.3


