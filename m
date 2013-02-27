Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59136 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759552Ab3B0UkV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Feb 2013 15:40:21 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 47/67] staging:iio:accel:sca3000 move to info_mask_(shared_by_type/separate)
Date: Wed, 27 Feb 2013 20:38:53 +0000
Message-Id: <1361997553-31058-48-git-send-email-jic23@kernel.org>
In-Reply-To: <1361997553-31058-1-git-send-email-jic23@kernel.org>
References: <1361997553-31058-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/sca3000_core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index 14683f5..68c8b7b 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -419,8 +419,6 @@ static IIO_DEVICE_ATTR(measurement_mode, S_IRUGO | S_IWUSR,
 
 static IIO_DEVICE_ATTR(revision, S_IRUGO, sca3000_show_rev, NULL, 0);
 
-#define SCA3000_INFO_MASK			\
-	IIO_CHAN_INFO_RAW_SEPARATE_BIT | IIO_CHAN_INFO_SCALE_SHARED_BIT
 #define SCA3000_EVENT_MASK					\
 	(IIO_EV_BIT(IIO_EV_TYPE_MAG, IIO_EV_DIR_RISING))
 
@@ -429,7 +427,8 @@ static IIO_DEVICE_ATTR(revision, S_IRUGO, sca3000_show_rev, NULL, 0);
 		.type = IIO_ACCEL,				\
 		.modified = 1,					\
 		.channel2 = mod,				\
-		.info_mask = SCA3000_INFO_MASK,			\
+		.info_mask_separate = IIO_CHAN_INFO_RAW,	\
+		.info_mask_shared_by_type = IIO_CHAN_INFO_SCALE,\
 		.address = index,				\
 		.scan_index = index,				\
 		.scan_type = {					\
-- 
1.8.1.1

