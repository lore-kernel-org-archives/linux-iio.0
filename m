Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@suse.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, Michael Hennerich
	<michael.hennerich@analog.com>, <devel@driverdev.osuosl.org>,
	<linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/3] staging:iio: IIO_EVENT_CODE: Clamp channel numbers
Date: Wed, 2 Nov 2011 09:40:01 +0100
Message-ID: <1320223202-26219-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1320223202-26219-1-git-send-email-lars@metafoo.de>
References: <1320223202-26219-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Make sure we only use the allotted space for channel numbers in the event mask
and do not let them override other fields.

Since negative values are valid channel number, cast the channel number to
signed when extracting it from an event mask.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/events.h |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/events.h b/drivers/staging/iio/events.h
index 7cf9306..91b3c45 100644
--- a/drivers/staging/iio/events.h
+++ b/drivers/staging/iio/events.h
@@ -56,7 +56,8 @@ enum iio_event_direction {
 		       type, chan, chan1, chan2)			\
 	(((u64)type << 56) | ((u64)diff << 55) |			\
 	 ((u64)direction << 48) | ((u64)modifier << 40) |		\
-	 ((u64)chan_type << 32) | (chan2 << 16) | chan1 | chan)
+	 ((u64)chan_type << 32) | (((u16)chan2) << 16) | ((u16)chan1) | \
+	 ((u16)chan))
 
 
 #define IIO_EV_DIR_MAX 4
@@ -95,7 +96,7 @@ enum iio_event_direction {
 
 /* Event code number extraction depends on which type of event we have.
  * Perhaps review this function in the future*/
-#define IIO_EVENT_CODE_EXTRACT_NUM(mask) (mask & 0xFFFF)
+#define IIO_EVENT_CODE_EXTRACT_NUM(mask) ((__s16)(mask & 0xFFFF))
 
 #define IIO_EVENT_CODE_EXTRACT_MODIFIER(mask) ((mask >> 40) & 0xFF)
 
-- 
1.7.7
