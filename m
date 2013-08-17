Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 1/5] iio: drop info_mask from struct iio_dev
Date: Sat, 17 Aug 2013 15:39:00 +0100
Message-Id: <1376750344-12817-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1376750344-12817-1-git-send-email-jic23@kernel.org>
References: <1376750344-12817-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

Somehow this got missed when dropping all the code that used it
prior to the split.  Remove it now, there are no users.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 include/linux/iio/iio.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 09ebe0a..dbaa55b 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -146,12 +146,10 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
  *			shift:		Shift right by this before masking out
  *					realbits.
  *			endianness:	little or big endian
- * @info_mask:		What information is to be exported about this channel.
- *			This includes calibbias, scale etc.
  * @info_mask_separate: What information is to be exported that is specific to
  *			this channel.
  * @info_mask_shared_by_type: What information is to be exported that is shared
-*			by all channels of the same type.
+ *			by all channels of the same type.
  * @event_mask:		What events can this channel produce.
  * @ext_info:		Array of extended info attributes for this channel.
  *			The array is NULL terminated, the last element should
@@ -186,7 +184,6 @@ struct iio_chan_spec {
 		u8	shift;
 		enum iio_endian endianness;
 	} scan_type;
-	long			info_mask;
 	long			info_mask_separate;
 	long			info_mask_shared_by_type;
 	long			event_mask;
-- 
1.8.3.4
