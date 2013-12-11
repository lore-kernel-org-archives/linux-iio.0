Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59701 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507Ab3LKSpw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2013 13:45:52 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, pmeerw@pmeerw.net, o.v.kravchenko@globallogic.com,
	stigge@antcom.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 20/24] iio:light:adjd_s311 replaces IIO_ST macro with explicit entries to struct scan_type
Date: Wed, 11 Dec 2013 18:45:38 +0000
Message-Id: <1386787542-19666-21-git-send-email-jic23@kernel.org>
In-Reply-To: <1386787542-19666-1-git-send-email-jic23@kernel.org>
References: <1386787542-19666-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

IIO_ST is going away as it is a pain to maintain.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/light/adjd_s311.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/adjd_s311.c b/drivers/iio/light/adjd_s311.c
index 83d15c5baf64..90e676ef2a8a 100644
--- a/drivers/iio/light/adjd_s311.c
+++ b/drivers/iio/light/adjd_s311.c
@@ -155,7 +155,12 @@ done:
 		BIT(IIO_CHAN_INFO_INT_TIME), \
 	.channel2 = (IIO_MOD_LIGHT_##_color), \
 	.scan_index = (_scan_idx), \
-	.scan_type = IIO_ST('u', 10, 16, 0), \
+	.scan_type = { \
+		.sign = 'u', \
+		.realbits = 10, \
+		.storagebits = 16, \
+		.endianness = IIO_CPU, \
+		}, \
 }
 
 static const struct iio_chan_spec adjd_s311_channels[] = {
-- 
1.8.4.2

