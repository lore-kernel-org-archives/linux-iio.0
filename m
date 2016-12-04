Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:47174 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752237AbcLDCUW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Dec 2016 21:20:22 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
Subject: [PATCH 11/19] staging: iio: isl29028: made column alignment in isl29028_channels consistent
Date: Sat,  3 Dec 2016 21:19:35 -0500
Message-Id: <1480817983-32359-12-git-send-email-masneyb@onstation.org>
In-Reply-To: <1480817983-32359-1-git-send-email-masneyb@onstation.org>
References: <1480817983-32359-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The three info_mask_separate members OR several BIT(xxx) fields
together. This patch changes the column alignment of these fields to be
aligned at the same column to improve the overall code readability. It
also moves the { for the next channel to the next line to improve code
readability.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/isl29028.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
index 0e727ba..218d165 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -419,14 +419,16 @@ static const struct iio_chan_spec isl29028_channels[] = {
 	{
 		.type = IIO_LIGHT,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
-		BIT(IIO_CHAN_INFO_SCALE),
-	}, {
+				      BIT(IIO_CHAN_INFO_SCALE),
+	},
+	{
 		.type = IIO_INTENSITY,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-	}, {
+	},
+	{
 		.type = IIO_PROXIMITY,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-		BIT(IIO_CHAN_INFO_SAMP_FREQ),
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
 	}
 };
 
-- 
2.7.4

