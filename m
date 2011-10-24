Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:29656 "EHLO
	TX2EHSOBE009.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932309Ab1JXNFR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2011 09:05:17 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	<linux-iio@vger.kernel.org>,
	<device-drivers-devel@blackfin.uclinux.org>, <drivers@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio:staging: Add documentation for IIO_EVENT_CODE
Date: Mon, 24 Oct 2011 15:05:09 +0200
Message-ID: <1319461509-17434-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Document the different parameters of the IIO_EVENT_CODE macro and friends.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

---
I'm adding this to get a clear definition of what each field is for, because
currently there are somewhat contradicting usages of this macro. So I'm not
quite sure if this is the correct documentation.

---
 drivers/staging/iio/events.h |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/events.h b/drivers/staging/iio/events.h
index 389c781..520a20e 100644
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
+ * @direction:	Direction of the event. Should be one of enum iio_event_direction.
+ * @type:	Type of the event. Should be one enum iio_event_type.
+ * @chan:	Channel number for non-differential channels.
+ * @chan1:	First channel number for differential channels.
+ * @chan2:	Second channel number for differential channels.
+ */
+
 #define IIO_EVENT_CODE(chan_type, diff, modifier, direction,		\
 		       type, chan, chan1, chan2)			\
 	(((u64)type << 56) | ((u64)diff << 55) |			\
@@ -51,10 +63,27 @@ enum iio_event_direction {
 #define IIO_EV_BIT(type, direction)			\
 	(1 << (type*IIO_EV_DIR_MAX + direction))
 
+/**
+ * IIO_MOD_EVENT_CODE() - create event identifier for modified channels
+ * @channelclass: Type of the channel. Should be one of enum iio_chan_type.
+ * @number:	Channel number for non-differential channels.
+ * @modifier:	Modifier for the channel. Should be one of enum iio_modifier.
+ * @type:	Type of the event. Should be one enum iio_event_type.
+ * @direction:	Direction of the event. Should be one of enum iio_event_direction.
+ */
+
 #define IIO_MOD_EVENT_CODE(channelclass, number, modifier,		\
 			   type, direction)				\
 	IIO_EVENT_CODE(channelclass, 0, modifier, direction, type, number, 0, 0)
 
+/**
+ * IIO_UNMOD_EVENT_CODE() - create event identifier for unmodified channels
+ * @channelclass: Type of the channel. Should be one of enum iio_chan_type.
+ * @number:	Channel number for non-differential channels.
+ * @type:	Type of the event. Should be one enum iio_event_type.
+ * @direction:	Direction of the event. Should be one of enum iio_event_direction.
+ */
+
 #define IIO_UNMOD_EVENT_CODE(channelclass, number, type, direction)	\
 	IIO_EVENT_CODE(channelclass, 0, 0, direction, type, number, 0, 0)
 
-- 
1.7.7


