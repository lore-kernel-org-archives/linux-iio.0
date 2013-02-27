Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59132 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758636Ab3B0UkU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Feb 2013 15:40:20 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Johan Hovold <jhovold@gmail.com>
Subject: [PATCH 41/67] iio:light:lm3533 move to info_mask_(shared_by_type/separate)
Date: Wed, 27 Feb 2013 20:38:47 +0000
Message-Id: <1361997553-31058-42-git-send-email-jic23@kernel.org>
In-Reply-To: <1361997553-31058-1-git-send-email-jic23@kernel.org>
References: <1361997553-31058-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Johan Hovold <jhovold@gmail.com>
---
 drivers/iio/light/lm3533-als.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
index 7503012..b0d52e7 100644
--- a/drivers/iio/light/lm3533-als.c
+++ b/drivers/iio/light/lm3533-als.c
@@ -231,7 +231,7 @@ static int lm3533_als_read_raw(struct iio_dev *indio_dev,
 		.channel	= _channel,				\
 		.indexed	= true,					\
 		.output		= true,					\
-		.info_mask	= IIO_CHAN_INFO_RAW_SEPARATE_BIT,	\
+		.info_mask_separate = IIO_CHAN_INFO_RAW,	\
 	}
 
 static const struct iio_chan_spec lm3533_als_channels[] = {
@@ -239,8 +239,8 @@ static const struct iio_chan_spec lm3533_als_channels[] = {
 		.type		= IIO_LIGHT,
 		.channel	= 0,
 		.indexed	= true,
-		.info_mask	= (IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE_BIT |
-				   IIO_CHAN_INFO_RAW_SEPARATE_BIT),
+		.info_mask_separate = (IIO_CHAN_INFO_AVERAGE_RAW |
+				   IIO_CHAN_INFO_RAW),
 	},
 	CHANNEL_CURRENT(0),
 	CHANNEL_CURRENT(1),
-- 
1.8.1.1

