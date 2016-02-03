Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33924 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965248AbcBCT3n (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 3 Feb 2016 14:29:43 -0500
Received: by mail-pa0-f44.google.com with SMTP id uo6so18559363pac.1
        for <linux-iio@vger.kernel.org>; Wed, 03 Feb 2016 11:29:43 -0800 (PST)
From: Keith Mok <ek9852@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Keith Mok <ek9852@gmail.com>
Subject: [PATCH] iio: use boot time instead of realtime
Date: Wed,  3 Feb 2016 11:29:37 -0800
Message-Id: <1454527777-16565-1-git-send-email-ek9852@Gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Keith Mok <ek9852@gmail.com>

Advanced sensor has fifo/ring buffer internally,
they can store data when the system is suspend,
we need a timestamp that is able to take into
account of the time when the system is suspend also.

Signed-off-by: Keith Mok <ek9852@gmail.com>
---
 include/linux/iio/iio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index b589411..7092877 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -286,7 +286,7 @@ static inline bool iio_channel_has_info(const struct iio_chan_spec *chan,
  **/
 static inline s64 iio_get_time_ns(void)
 {
-	return ktime_get_real_ns();
+	return ktime_get_boot_ns();
 }
 
 /* Device operating modes */
-- 
2.5.1

