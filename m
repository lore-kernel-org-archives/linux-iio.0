Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:39555 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755791AbdDFGiY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Apr 2017 02:38:24 -0400
From: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
To: jic23@kernel.org
Cc: pmeerw@pmeerw.net, knaack.h@gmx.de, lars@metafoo.de,
        linux-iio@vger.kernel.org,
        Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Subject: [PATCH 5/6] iio: light: rpr0521 channel numbers reordered
Date: Thu,  6 Apr 2017 09:37:06 +0300
Message-Id: <1491460627-18685-5-git-send-email-mikko.koivunen@fi.rohmeurope.com>
In-Reply-To: <1491460627-18685-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
References: <1491460627-18685-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Moved proximity channel from last to first in structs to avoid confusion
later with buffered triggers. Proximity data output is first in rpr0521
register map.

Signed-off-by: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
---
 drivers/iio/light/rpr0521.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index 579bf6d..fa642b7 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -80,9 +80,9 @@ struct rpr0521_gain {
 };
 
 enum rpr0521_channel {
+	RPR0521_CHAN_PXS,
 	RPR0521_CHAN_ALS_DATA0,
 	RPR0521_CHAN_ALS_DATA1,
-	RPR0521_CHAN_PXS,
 };
 
 struct rpr0521_reg_desc {
@@ -91,6 +91,10 @@ struct rpr0521_reg_desc {
 };
 
 static const struct rpr0521_reg_desc rpr0521_data_reg[] = {
+	[RPR0521_CHAN_PXS]	= {
+		.address	= RPR0521_REG_PXS_DATA,
+		.device_mask	= RPR0521_MODE_PXS_MASK,
+	},
 	[RPR0521_CHAN_ALS_DATA0] = {
 		.address	= RPR0521_REG_ALS_DATA0,
 		.device_mask	= RPR0521_MODE_ALS_MASK,
@@ -99,10 +103,6 @@ struct rpr0521_reg_desc {
 		.address	= RPR0521_REG_ALS_DATA1,
 		.device_mask	= RPR0521_MODE_ALS_MASK,
 	},
-	[RPR0521_CHAN_PXS]	= {
-		.address	= RPR0521_REG_PXS_DATA,
-		.device_mask	= RPR0521_MODE_PXS_MASK,
-	},
 };
 
 static const struct rpr0521_gain_info {
@@ -112,6 +112,13 @@ struct rpr0521_reg_desc {
 	const struct rpr0521_gain *gain;
 	int size;
 } rpr0521_gain[] = {
+	[RPR0521_CHAN_PXS] = {
+		.reg	= RPR0521_REG_PXS_CTRL,
+		.mask	= RPR0521_PXS_GAIN_MASK,
+		.shift	= RPR0521_PXS_GAIN_SHIFT,
+		.gain	= rpr0521_pxs_gain,
+		.size	= ARRAY_SIZE(rpr0521_pxs_gain),
+	},
 	[RPR0521_CHAN_ALS_DATA0] = {
 		.reg	= RPR0521_REG_ALS_CTRL,
 		.mask	= RPR0521_ALS_DATA0_GAIN_MASK,
@@ -126,13 +133,6 @@ struct rpr0521_reg_desc {
 		.gain	= rpr0521_als_gain,
 		.size	= ARRAY_SIZE(rpr0521_als_gain),
 	},
-	[RPR0521_CHAN_PXS] = {
-		.reg	= RPR0521_REG_PXS_CTRL,
-		.mask	= RPR0521_PXS_GAIN_MASK,
-		.shift	= RPR0521_PXS_GAIN_SHIFT,
-		.gain	= rpr0521_pxs_gain,
-		.size	= ARRAY_SIZE(rpr0521_pxs_gain),
-	},
 };
 
 struct rpr0521_samp_freq {
@@ -196,6 +196,14 @@ struct rpr0521_data {
 
 static const struct iio_chan_spec rpr0521_channels[] = {
 	{
+		.type = IIO_PROXIMITY,
+		.address = RPR0521_CHAN_PXS,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_OFFSET) |
+			BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+	},
+	{
 		.type = IIO_INTENSITY,
 		.modified = 1,
 		.address = RPR0521_CHAN_ALS_DATA0,
@@ -213,15 +221,6 @@ struct rpr0521_data {
 			BIT(IIO_CHAN_INFO_SCALE),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 	},
-	{
-		.type = IIO_PROXIMITY,
-		.address = RPR0521_CHAN_PXS,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-			BIT(IIO_CHAN_INFO_OFFSET) |
-			BIT(IIO_CHAN_INFO_SCALE),
-
-		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
-	}
 };
 
 static int rpr0521_als_enable(struct rpr0521_data *data, u8 status)
-- 
1.9.1

