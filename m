Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/3] staging:iio: Add missing event code extract macros
Date: Tue, 3 Jan 2012 15:54:56 +0100
Message-ID: <1325602497-7030-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1325602497-7030-1-git-send-email-lars@metafoo.de>
References: <1325602497-7030-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Add macros for extracting whether the event is for a differential channel and
the second channel number from the event code. These were the only two fields
which did not have such an macro yet.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/events.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/events.h b/drivers/staging/iio/events.h
index 416800e..c25f0e3 100644
--- a/drivers/staging/iio/events.h
+++ b/drivers/staging/iio/events.h
@@ -97,7 +97,9 @@ enum iio_event_direction {
 /* Event code number extraction depends on which type of event we have.
  * Perhaps review this function in the future*/
 #define IIO_EVENT_CODE_EXTRACT_CHAN(mask) ((__s16)(mask & 0xFFFF))
+#define IIO_EVENT_CODE_EXTRACT_CHAN2(mask) ((__s16)(((mask) >> 16) & 0xFFFF))
 
 #define IIO_EVENT_CODE_EXTRACT_MODIFIER(mask) ((mask >> 40) & 0xFF)
+#define IIO_EVENT_CODE_EXTRACT_DIFF(mask) (((mask) >> 55) & 0x1)
 
 #endif
-- 
1.7.7.3
