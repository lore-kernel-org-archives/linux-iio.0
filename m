Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59134 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759064Ab3B0UkU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Feb 2013 15:40:20 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Jon Brenner <jbrenner@taosinc.com>
Subject: [PATCH 42/67] iio:light:tsl2563 move to info_mask_(shared_by_type/separate)
Date: Wed, 27 Feb 2013 20:38:48 +0000
Message-Id: <1361997553-31058-43-git-send-email-jic23@kernel.org>
In-Reply-To: <1361997553-31058-1-git-send-email-jic23@kernel.org>
References: <1361997553-31058-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Jon Brenner <jbrenner@taosinc.com>
---
 drivers/iio/light/tsl2563.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
index fd8be69..08463b4 100644
--- a/drivers/iio/light/tsl2563.c
+++ b/drivers/iio/light/tsl2563.c
@@ -530,14 +530,14 @@ static const struct iio_chan_spec tsl2563_channels[] = {
 	{
 		.type = IIO_LIGHT,
 		.indexed = 1,
-		.info_mask = IIO_CHAN_INFO_PROCESSED_SEPARATE_BIT,
+		.info_mask_separate = IIO_CHAN_INFO_PROCESSED,
 		.channel = 0,
 	}, {
 		.type = IIO_INTENSITY,
 		.modified = 1,
 		.channel2 = IIO_MOD_LIGHT_BOTH,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT,
+		.info_mask_separate = IIO_CHAN_INFO_RAW |
+		IIO_CHAN_INFO_CALIBSCALE,
 		.event_mask = (IIO_EV_BIT(IIO_EV_TYPE_THRESH,
 					  IIO_EV_DIR_RISING) |
 			       IIO_EV_BIT(IIO_EV_TYPE_THRESH,
@@ -546,8 +546,8 @@ static const struct iio_chan_spec tsl2563_channels[] = {
 		.type = IIO_INTENSITY,
 		.modified = 1,
 		.channel2 = IIO_MOD_LIGHT_IR,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT,
+		.info_mask_separate = IIO_CHAN_INFO_RAW |
+		IIO_CHAN_INFO_CALIBSCALE,
 	}
 };
 
-- 
1.8.1.1

