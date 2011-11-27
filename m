Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	manuel.stahl@iis.fraunhofer.de,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 16/16] staging:iio:buffer stop allowing for read_last callback.
Date: Sun, 27 Nov 2011 13:33:45 +0000
Message-Id: <1322400825-29400-17-git-send-email-jic23@kernel.org>
In-Reply-To: <1322400825-29400-1-git-send-email-jic23@kernel.org>
References: <1322400825-29400-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

No longer needed now we don't allow sysfs acccess to buffer data.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/buffer.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/buffer.h b/drivers/staging/iio/buffer.h
index 98e9efa..7272333 100644
--- a/drivers/staging/iio/buffer.h
+++ b/drivers/staging/iio/buffer.h
@@ -21,7 +21,6 @@ struct iio_buffer;
  * @mark_in_use:	reference counting, typically to prevent module removal
  * @unmark_in_use:	reduce reference count when no longer using buffer
  * @store_to:		actually store stuff to the buffer
- * @read_last:		get the last element stored
  * @read_first_n:	try to get a specified number of elements (must exist)
  * @mark_param_change:	notify buffer that some relevant parameter has changed
  *			Often this means the underlying storage may need to
@@ -48,7 +47,6 @@ struct iio_buffer_access_funcs {
 	void (*unmark_in_use)(struct iio_buffer *buffer);
 
 	int (*store_to)(struct iio_buffer *buffer, u8 *data, s64 timestamp);
-	int (*read_last)(struct iio_buffer *buffer, u8 *data);
 	int (*read_first_n)(struct iio_buffer *buffer,
 			    size_t n,
 			    char __user *buf);
-- 
1.7.7.3
