Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/3] staging:iio: Rename IIO_EVENT_CODE_EXTRACT_NUM to IIO_EVENT_CODE_EXTRACT_CHAN
Date: Tue, 3 Jan 2012 15:54:55 +0100
Message-ID: <1325602497-7030-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

We name this field "chan" throughout IIO with the exception of this one macro.
Rename it to be more consistent.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/events.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/events.h b/drivers/staging/iio/events.h
index bfb6340..416800e 100644
--- a/drivers/staging/iio/events.h
+++ b/drivers/staging/iio/events.h
@@ -96,7 +96,7 @@ enum iio_event_direction {
 
 /* Event code number extraction depends on which type of event we have.
  * Perhaps review this function in the future*/
-#define IIO_EVENT_CODE_EXTRACT_NUM(mask) ((__s16)(mask & 0xFFFF))
+#define IIO_EVENT_CODE_EXTRACT_CHAN(mask) ((__s16)(mask & 0xFFFF))
 
 #define IIO_EVENT_CODE_EXTRACT_MODIFIER(mask) ((mask >> 40) & 0xFF)
 
-- 
1.7.7.3
