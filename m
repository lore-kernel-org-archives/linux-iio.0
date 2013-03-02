Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35731 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580Ab3CBQRr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Mar 2013 11:17:47 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Andrew Chew <achew@nvidia.com>
Subject: [PATCH 61/67] staging:iio:mag:ak8975 move to info_mask_(shared_by_type/separate)
Date: Sat,  2 Mar 2013 16:17:18 +0000
Message-Id: <1362241044-3534-62-git-send-email-jic23@kernel.org>
In-Reply-To: <1362241044-3534-1-git-send-email-jic23@kernel.org>
References: <1362241044-3534-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Andrew Chew <achew@nvidia.com>
---
 drivers/staging/iio/magnetometer/ak8975.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/ak8975.c b/drivers/staging/iio/magnetometer/ak8975.c
index 28f080e..b614da1 100644
--- a/drivers/staging/iio/magnetometer/ak8975.c
+++ b/drivers/staging/iio/magnetometer/ak8975.c
@@ -395,8 +395,8 @@ static int ak8975_read_raw(struct iio_dev *indio_dev,
 		.type = IIO_MAGN,					\
 		.modified = 1,						\
 		.channel2 = IIO_MOD_##axis,				\
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |		\
-			     IIO_CHAN_INFO_SCALE_SEPARATE_BIT,		\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+			     BIT(IIO_CHAN_INFO_SCALE),			\
 		.address = index,					\
 	}
 
-- 
1.8.1.4

