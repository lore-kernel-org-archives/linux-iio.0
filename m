Return-Path: <cristina.ciocan@intel.com>
From: Cristina Ciocan <cristina.ciocan@intel.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Cristina Ciocan <cristina.ciocan@intel.com>
Subject: [PATCH] iio: Fix IIO_EVENT_CODE_EXTRACT_DIR bit mask
Date: Tue, 11 Nov 2014 16:07:42 +0200
Message-Id: <1415714862-5709-1-git-send-email-cristina.ciocan@intel.com>
List-ID: <linux-iio@vger.kernel.org>

The direction field is set on 7 bits, thus we need to AND it with 0111 111 mask
in order to retrieve it, that is 0x7F, not 0xCF as it is now.

Fixes: ade7ef7ba (staging:iio: Differential channel handling)
Signed-off-by: Cristina Ciocan <cristina.ciocan@intel.com>
---
 include/linux/iio/events.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/events.h b/include/linux/iio/events.h
index 8bbd7bc..03fa332 100644
--- a/include/linux/iio/events.h
+++ b/include/linux/iio/events.h
@@ -72,7 +72,7 @@ struct iio_event_data {

 #define IIO_EVENT_CODE_EXTRACT_TYPE(mask) ((mask >> 56) & 0xFF)

-#define IIO_EVENT_CODE_EXTRACT_DIR(mask) ((mask >> 48) & 0xCF)
+#define IIO_EVENT_CODE_EXTRACT_DIR(mask) ((mask >> 48) & 0x7F)

 #define IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(mask) ((mask >> 32) & 0xFF)

--
1.8.1.2
