Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	<linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/8] staging:iio: Disallow modifying buffer size when buffer is enabled
Date: Fri, 16 Dec 2011 11:19:46 +0100
Message-ID: <1324030791-17983-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1324030791-17983-1-git-send-email-lars@metafoo.de>
References: <1324030791-17983-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

The buffer buffer storage is only update when enabling the buffer. Changing the
buffer size while the buffer is enabled will confuse the buffer in regard to
its actual buffer size and can cause potential memory corruption. Thus it is
only safe to modify the buffer size when the buffer is disabled.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/industrialio-buffer.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
index 91cb37a..9528026 100644
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
