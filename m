Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59682 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345Ab3LKSpr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2013 13:45:47 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, pmeerw@pmeerw.net, o.v.kravchenko@globallogic.com,
	stigge@antcom.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 04/24] iio:accel:bma180 replaces IIO_ST macro with explicit entries to struct scan_type
Date: Wed, 11 Dec 2013 18:45:22 +0000
Message-Id: <1386787542-19666-5-git-send-email-jic23@kernel.org>
In-Reply-To: <1386787542-19666-1-git-send-email-jic23@kernel.org>
References: <1386787542-19666-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The IIO_ST macro no longer covers all the elements of struct scan_type
and has this has lead to some bugs being introduced.

The drivers are easier to follow with this structure being directly
filled so that is now preferred.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/accel/bma180.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 28b39283bccf..9104f436e0eb 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -455,7 +455,12 @@ static const struct iio_chan_spec_ext_info bma180_ext_info[] = {
 		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),	\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
 	.scan_index = (_index),						\
-	.scan_type = IIO_ST('s', 14, 16, 2),				\
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = 14,					\
+		.storagebits = 16,					\
+		.shift = 2,						\
+		},							\
 	.ext_info = bma180_ext_info,					\
 }
 
-- 
1.8.4.2

