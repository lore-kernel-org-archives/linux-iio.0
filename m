Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:48773
	"EHLO VA3EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756395Ab1LPKTa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 16 Dec 2011 05:19:30 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	<linux-iio@vger.kernel.org>,
	<device-drivers-devel@blackfin.uclinux.org>, <drivers@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 7/8] staging:iio: Drop the unused buffer enable() and is_enabled() callbacks
Date: Fri, 16 Dec 2011 11:19:50 +0100
Message-ID: <1324030791-17983-7-git-send-email-lars@metafoo.de>
In-Reply-To: <1324030791-17983-1-git-send-email-lars@metafoo.de>
References: <1324030791-17983-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Currently none of the buffer implementations implements the enable() or
is_enable() nor does core code try to call these. So it is safe to remove them.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/Documentation/ring.txt |    4 ----
 drivers/staging/iio/buffer.h               |    5 -----
 2 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/Documentation/ring.txt b/drivers/staging/iio/Documentation/ring.txt
index 5134fd9..0f21479 100644
--- a/drivers/staging/iio/Documentation/ring.txt
+++ b/drivers/staging/iio/Documentation/ring.txt
@@ -49,7 +49,3 @@ get_bytes_per_datum, set_bytes_per_datum
 get_length / set_length
   Get/set the number of complete scans that may be held by the buffer.
 
-is_enabled
-  Query if ring buffer is in use
-enable
-  Start the ring buffer.
diff --git a/drivers/staging/iio/buffer.h b/drivers/staging/iio/buffer.h
index 208c471..ea42b5d 100644
--- a/drivers/staging/iio/buffer.h
+++ b/drivers/staging/iio/buffer.h
@@ -28,8 +28,6 @@ struct iio_buffer;
  * @set_bytes_per_datum:set number of bytes per datum
  * @get_length:		get number of datums in buffer
  * @set_length:		set number of datums in buffer
- * @is_enabled:		query if buffer is currently being used
- * @enable:		enable the buffer
  *
  * The purpose of this structure is to make the buffer element
  * modular as event for a given driver, different usecases may require
@@ -54,9 +52,6 @@ struct iio_buffer_access_funcs {
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


