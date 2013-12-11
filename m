Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59701 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512Ab3LKSpy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2013 13:45:54 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, pmeerw@pmeerw.net, o.v.kravchenko@globallogic.com,
	stigge@antcom.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 24/24] iio:drop IIO_ST macro
Date: Wed, 11 Dec 2013 18:45:42 +0000
Message-Id: <1386787542-19666-25-git-send-email-jic23@kernel.org>
In-Reply-To: <1386787542-19666-1-git-send-email-jic23@kernel.org>
References: <1386787542-19666-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This macro no longer allows all the elements of the scan_type structure
to be set.  Missinterpretation of the parameters also caused a couple of
recent bugs.  No mainline drivers now use this macro so drop it.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 include/linux/iio/iio.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 75a8a20c8179..5f2d00e7e488 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -254,12 +254,16 @@ static inline bool iio_channel_has_info(const struct iio_chan_spec *chan,
 		(chan->info_mask_shared_by_all & BIT(type));
 }
 
-#define IIO_ST(si, rb, sb, sh)						\
-	{ .sign = si, .realbits = rb, .storagebits = sb, .shift = sh }
-
-#define IIO_CHAN_SOFT_TIMESTAMP(_si)					\
-	{ .type = IIO_TIMESTAMP, .channel = -1,				\
-			.scan_index = _si, .scan_type = IIO_ST('s', 64, 64, 0) }
+#define IIO_CHAN_SOFT_TIMESTAMP(_si) {					\
+	.type = IIO_TIMESTAMP,						\
+	.channel = -1,							\
+	.scan_index = _si,						\
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = 64,					\
+		.storagebits = 64,					\
+		},							\
+}
 
 /**
  * iio_get_time_ns() - utility function to get a time stamp for events etc
-- 
1.8.4.2

