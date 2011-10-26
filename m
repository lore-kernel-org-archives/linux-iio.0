Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 3/5] iio:staging: Add documentation for IIO_EVENT_CODE
Date: Wed, 26 Oct 2011 17:41:34 +0100
Message-Id: <1319647296-4374-4-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1319647296-4374-1-git-send-email-jic23@cam.ac.uk>
References: <1319647296-4374-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

From: Lars-Peter Clausen <lars@metafoo.de>

Document the different parameters of the IIO_EVENT_CODE macro and friends.

While we are at it standardise the name of channel type parameter.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/events.h |   37 +++++++++++++++++++++++++++++++++----
 1 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/events.h b/drivers/staging/iio/events.h
index 389c781..9275954 100644
--- a/drivers/staging/iio/events.h
+++ b/drivers/staging/iio/events.h
@@ -40,6 +40,18 @@ enum iio_event_direction {
 	IIO_EV_DIR_FALLING,
 };
 
+/**
+ * IIO_EVENT_CODE() - create event identifier
+ * @chan_type:	Type of the channel. Should be one of enum iio_chan_type.
+ * @diff:	Whether the event is for an differential channel or not.
+ * @modifier:	Modifier for the channel. Should be one of enum iio_modifier.
+ * @direction:	Direction of the event. One of enum iio_event_direction.
+ * @type:	Type of the event. Should be one enum iio_event_type.
+ * @chan:	Channel number for non-differential channels.
+ * @chan1:	First channel number for differential channels.
+ * @chan2:	Second channel number for differential channels.
+ */
+
 #define IIO_EVENT_CODE(chan_type, diff, modifier, direction,		\
 		       type, chan, chan1, chan2)			\
 	(((u64)type << 56) | ((u64)diff << 55) |			\
@@ -51,12 +63,29 @@ enum iio_event_direction {
 #define IIO_EV_BIT(type, direction)			\
 	(1 << (type*IIO_EV_DIR_MAX + direction))
 
-#define IIO_MOD_EVENT_CODE(channelclass, number, modifier,		\
+/**
+ * IIO_MOD_EVENT_CODE() - create event identifier for modified channels
+ * @chan_type:	Type of the channel. Should be one of enum iio_chan_type.
+ * @number:	Channel number.
+ * @modifier:	Modifier for the channel. Should be one of enum iio_modifier.
+ * @type:	Type of the event. Should be one enum iio_event_type.
+ * @direction:	Direction of the event. One of enum iio_event_direction.
+ */
+
+#define IIO_MOD_EVENT_CODE(chan_type, number, modifier,		\
 			   type, direction)				\
-	IIO_EVENT_CODE(channelclass, 0, modifier, direction, type, number, 0, 0)
+	IIO_EVENT_CODE(chan_type, 0, modifier, direction, type, number, 0, 0)
+
+/**
+ * IIO_UNMOD_EVENT_CODE() - create event identifier for unmodified channels
+ * @chan_type:	Type of the channel. Should be one of enum iio_chan_type.
+ * @number:	Channel number.
+ * @type:	Type of the event. Should be one enum iio_event_type.
+ * @direction:	Direction of the event. One of enum iio_event_direction.
+ */
 
-#define IIO_UNMOD_EVENT_CODE(channelclass, number, type, direction)	\
-	IIO_EVENT_CODE(channelclass, 0, 0, direction, type, number, 0, 0)
+#define IIO_UNMOD_EVENT_CODE(chan_type, number, type, direction)	\
+	IIO_EVENT_CODE(chan_type, 0, 0, direction, type, number, 0, 0)
 
 #define IIO_EVENT_CODE_EXTRACT_TYPE(mask) ((mask >> 56) & 0xFF)
 
-- 
1.7.7
