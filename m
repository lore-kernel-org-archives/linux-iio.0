Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:48647 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754732Ab2FORZc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 15 Jun 2012 13:25:32 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 6/6] iio: iio/events.h typos
Date: Fri, 15 Jun 2012 19:25:28 +0200
Message-Id: <1339781128-2718-6-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1339781128-2718-1-git-send-email-pmeerw@pmeerw.net>
References: <1339781128-2718-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>

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

