Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	Milo Kim <Milo.Kim@ti.com>,
	anish kumar <anish198519851985@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 1/3] iio: consumer.h: Fix kernel doc incosistency
Date: Mon, 17 Sep 2012 14:17:33 +0200
Message-Id: <1347884255-24870-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

For the iio_read_channel_raw and iio_read_channel_scale the kerneldoc comment
refers to an argument called "channel", while the argument is called "chan" in
the function signature. This leads to the following warnings from kerneldoc:

	Warning(include/linux/iio/consumer.h:71): No description found for parameter 'chan'
	Warning(include/linux/iio/consumer.h:71): Excess function parameter 'channel' description in 'iio_read_channel_raw'
	Warning(include/linux/iio/consumer.h:109): No description found for parameter 'chan'
	Warning(include/linux/iio/consumer.h:109): Excess function parameter 'channel' description in 'iio_read_channel_scale'

This patch fixes the warnings by naming them consistently.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/linux/iio/consumer.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index 06ab4ec..62118dd 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -61,7 +61,7 @@ void iio_channel_release_all(struct iio_channel *chan);
 
 /**
  * iio_read_channel_raw() - read from a given channel
- * @channel:		The channel being queried.
+ * @chan:		The channel being queried.
  * @val:		Value read back.
  *
  * Note raw reads from iio channels are in adc counts and hence
@@ -82,7 +82,7 @@ int iio_get_channel_type(struct iio_channel *channel,
 
 /**
  * iio_read_channel_scale() - read the scale value for a channel
- * @channel:		The channel being queried.
+ * @chan:		The channel being queried.
  * @val:		First part of value read back.
  * @val2:		Second part of value read back.
  *
-- 
1.7.10.4
