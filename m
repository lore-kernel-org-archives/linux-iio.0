Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@suse.de>
CC: Jonathan Cameron <jic23@kernel.org>, Michael Hennerich
	<michael.hennerich@analog.com>, <devel@driverdev.osuosl.org>,
	<linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 6/8] staging:iio: Drop the unused buffer enable() and is_enabled() callbacks
Date: Mon, 19 Dec 2011 15:23:47 +0100
Message-ID: <1324304629-24720-6-git-send-email-lars@metafoo.de>
In-Reply-To: <1324304629-24720-1-git-send-email-lars@metafoo.de>
References: <1324304629-24720-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Currently none of the buffer implementations implements the enable() or
is_enable() nor does core code try to call these. So it is safe to remove them.

Acked-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/Documentation/ring.txt |    4 ----
 drivers/staging/iio/buffer.h               |    5 -----
 2 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/Documentation/ring.txt b/drivers/staging/iio/Documentation/ring.txt
index 7e99ef2..1b77aee 100644
--- a/drivers/staging/iio/Documentation/ring.txt
+++ b/drivers/staging/iio/Documentation/ring.txt
@@ -51,7 +51,3 @@ get_bytes_per_datum, set_bytes_per_datum
 get_length / set_length
   Get/set the number of complete scans that may be held by the buffer.
 
-is_enabled
-  Query if ring buffer is in use
-enable
-  Start the ring buffer.
diff --git a/drivers/staging/iio/buffer.h b/drivers/staging/iio/buffer.h
index eb4938c..b0e04df 100644
--- a/drivers/staging/iio/buffer.h
+++ b/drivers/staging/iio/buffer.h
@@ -31,8 +31,6 @@ struct iio_buffer;
  * @set_bytes_per_datum:set number of bytes per datum
  * @get_length:		get number of datums in buffer
  * @set_length:		set number of datums in buffer
- * @is_enabled:		query if buffer is currently being used
- * @enable:		enable the buffer
  *
  * The purpose of this structure is to make the buffer element
  * modular as event for a given driver, different usecases may require
@@ -58,9 +56,6 @@ struct iio_buffer_access_funcs {
 	int (*set_bytes_per_datum)(struct iio_buffer *buffer, size_t bpd);
 	int (*get_length)(struct iio_buffer *buffer);
 	int (*set_length)(struct iio_buffer *buffer, int length);
-
-	int (*is_enabled)(struct iio_buffer *buffer);
-	int (*enable)(struct iio_buffer *buffer);
 };
 
 /**
-- 
1.7.7.3
