Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35735 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507Ab3CBQRn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Mar 2013 11:17:43 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 43/67] iio:light:vcnl4000 move to info_mask_(shared_by_type/separate)
Date: Sat,  2 Mar 2013 16:17:00 +0000
Message-Id: <1362241044-3534-44-git-send-email-jic23@kernel.org>
In-Reply-To: <1362241044-3534-1-git-send-email-jic23@kernel.org>
References: <1362241044-3534-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/light/vcnl4000.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 2aa748f..1014943 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -93,11 +93,11 @@ static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
 static const struct iio_chan_spec vcnl4000_channels[] = {
 	{
 		.type = IIO_LIGHT,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-			IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SCALE),
 	}, {
 		.type = IIO_PROXIMITY,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 	}
 };
 
-- 
1.8.1.4

