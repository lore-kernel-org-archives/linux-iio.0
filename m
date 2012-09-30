Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:36685 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750794Ab2I3KFt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 30 Sep 2012 06:05:49 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 1/3] iio: add IIO_ST macros specifying endianness, IIO_ST_CPU and IIO_ST_BE
Date: Sun, 30 Sep 2012 12:05:43 +0200
Message-Id: <1348999545-19099-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

add IIO_ST_BE (for big endian); we can make use of in a subsequent
patch (max1363 driver and ad_sigma_delta.h)

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 include/linux/iio/iio.h |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index c0ae76a..a5b6a03 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -278,8 +278,14 @@ static inline bool iio_channel_has_info(const struct iio_chan_spec *chan,
 	return chan->info_mask & IIO_CHAN_INFO_BITS(type);
 }
 
-#define IIO_ST(si, rb, sb, sh)						\
-	{ .sign = si, .realbits = rb, .storagebits = sb, .shift = sh }
+#define IIO_ST_CPU(si, rb, sb, sh)					\
+	{ .sign = si, .realbits = rb, .storagebits = sb, .shift = sh,	\
+	  .endianness = IIO_CPU }
+#define IIO_ST_BE(si, rb, sb, sh)					\
+	{ .sign = si, .realbits = rb, .storagebits = sb, .shift = sh,	\
+	  .endianness = IIO_BE }
+
+#define IIO_ST(si, rb, sb, sh) IIO_ST_CPU(si, rb, sb, sh)
 
 #define IIO_CHAN_SOFT_TIMESTAMP(_si)					\
 	{ .type = IIO_TIMESTAMP, .channel = -1,				\
-- 
1.7.9.5

