Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-029.synserver.de ([212.40.185.29]:1349 "EHLO
	smtp-out-029.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757217Ab2INPWa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 14 Sep 2012 11:22:30 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Milo Kim <Milo.Kim@ti.com>,
	anish kumar <anish198519851985@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/4] iio: consumer.h: Fix kernel doc incosistency
Date: Fri, 14 Sep 2012 17:21:41 +0200
Message-Id: <1347636104-3419-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

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
index 06ab4ec..27759ac3 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -67,7 +67,7 @@ void iio_channel_release_all(struct iio_channel *chan);
  * Note raw reads from iio channels are in adc counts and hence
  * scale will need to be applied if standard units required.
  */
-int iio_read_channel_raw(struct iio_channel *chan,
+int iio_read_channel_raw(struct iio_channel *channel,
 			 int *val);
 
 /**
@@ -90,7 +90,7 @@ int iio_get_channel_type(struct iio_channel *channel,
  * as IIO_VAL_INT_PLUS_MICRO telling us we have a value of val
  * + val2/1e6
  */
-int iio_read_channel_scale(struct iio_channel *chan, int *val,
+int iio_read_channel_scale(struct iio_channel *channel, int *val,
 			   int *val2);
 
 #endif
-- 
1.7.10.4

