Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59139 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759604Ab3B0Uk0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Feb 2013 15:40:26 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH 62/67] staging:iio:hmc5843 move to info_mask_(shared_by_type/separate)
Date: Wed, 27 Feb 2013 20:39:08 +0000
Message-Id: <1361997553-31058-63-git-send-email-jic23@kernel.org>
In-Reply-To: <1361997553-31058-1-git-send-email-jic23@kernel.org>
References: <1361997553-31058-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/staging/iio/magnetometer/hmc5843.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index 1a520ec..66c0194 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -564,8 +564,8 @@ static int hmc5843_read_raw(struct iio_dev *indio_dev,
 		.type = IIO_MAGN,					\
 		.modified = 1,						\
 		.channel2 = IIO_MOD_##axis,				\
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |		\
-			     IIO_CHAN_INFO_SCALE_SHARED_BIT,		\
+		.info_mask_separate = IIO_CHAN_INFO_RAW,		\
+		.info_mask_shared_by_type = IIO_CHAN_INFO_SCALE,	\
 		.address = add						\
 	}
 
-- 
1.8.1.1

