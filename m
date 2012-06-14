Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:50367 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753040Ab2FNWvG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 14 Jun 2012 18:51:06 -0400
Received: from sirene.lan (83-215-0-241.stadt.dyn.salzburg-online.at [83.215.0.241])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: pmeerw)
	by pmeerw.net (Postfix) with ESMTPSA id BF00FC506A1
	for <linux-iio@vger.kernel.org>; Fri, 15 Jun 2012 00:51:02 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Subject: [PATCH 6/6] iio: iio/events.h typos
Date: Fri, 15 Jun 2012 00:51:00 +0200
Message-Id: <1339714260-8361-6-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1339714260-8361-1-git-send-email-pmeerw@pmeerw.net>
References: <1339714260-8361-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

---
 include/linux/iio/events.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/iio/events.h b/include/linux/iio/events.h
index b5acbf9..13ce220 100644
--- a/include/linux/iio/events.h
+++ b/include/linux/iio/events.h
@@ -46,7 +46,7 @@ enum iio_event_direction {
  * @diff:	Whether the event is for an differential channel or not.
  * @modifier:	Modifier for the channel. Should be one of enum iio_modifier.
  * @direction:	Direction of the event. One of enum iio_event_direction.
- * @type:	Type of the event. Should be one enum iio_event_type.
+ * @type:	Type of the event. Should be one of enum iio_event_type.
  * @chan:	Channel number for non-differential channels.
  * @chan1:	First channel number for differential channels.
  * @chan2:	Second channel number for differential channels.
@@ -69,7 +69,7 @@ enum iio_event_direction {
  * @chan_type:	Type of the channel. Should be one of enum iio_chan_type.
  * @number:	Channel number.
  * @modifier:	Modifier for the channel. Should be one of enum iio_modifier.
- * @type:	Type of the event. Should be one enum iio_event_type.
+ * @type:	Type of the event. Should be one of enum iio_event_type.
  * @direction:	Direction of the event. One of enum iio_event_direction.
  */
 
@@ -81,7 +81,7 @@ enum iio_event_direction {
  * IIO_UNMOD_EVENT_CODE() - create event identifier for unmodified channels
  * @chan_type:	Type of the channel. Should be one of enum iio_chan_type.
  * @number:	Channel number.
- * @type:	Type of the event. Should be one enum iio_event_type.
+ * @type:	Type of the event. Should be one of enum iio_event_type.
  * @direction:	Direction of the event. One of enum iio_event_direction.
  */
 
-- 
1.7.9.5

