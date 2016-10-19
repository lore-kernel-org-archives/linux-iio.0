Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:59995 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757146AbcJSRHU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Oct 2016 13:07:20 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 01/13] staging:iio:ad7606: Remove unused int_vref_mv field
Date: Wed, 19 Oct 2016 19:06:56 +0200
Message-Id: <1476896828-10544-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1476896828-10544-1-git-send-email-lars@metafoo.de>
References: <1476896828-10544-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Remove the int_vref_mv field from the ad7606_chip_info struct since the
field is never used by the driver. The value is also the same for all
derivatives of this chip, so if it will ever be used in the driver a
constant value will work just fine.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7606.h      | 2 --
 drivers/staging/iio/adc/ad7606_core.c | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
index 39f5044..b7e59a6 100644
--- a/drivers/staging/iio/adc/ad7606.h
+++ b/drivers/staging/iio/adc/ad7606.h
@@ -43,14 +43,12 @@ struct ad7606_platform_data {
 /**
  * struct ad7606_chip_info - chip specific information
  * @name:		identification string for chip
- * @int_vref_mv:	the internal reference voltage
  * @channels:		channel specification
  * @num_channels:	number of channels
  */
 
 struct ad7606_chip_info {
 	const char			*name;
-	u16				int_vref_mv;
 	const struct iio_chan_spec	*channels;
 	unsigned int			num_channels;
 };
diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index 2042225..a1f18d4 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -261,19 +261,16 @@ static const struct ad7606_chip_info ad7606_chip_info_tbl[] = {
 	 */
 	[ID_AD7606_8] = {
 		.name = "ad7606",
-		.int_vref_mv = 2500,
 		.channels = ad7606_channels,
 		.num_channels = 9,
 	},
 	[ID_AD7606_6] = {
 		.name = "ad7606-6",
-		.int_vref_mv = 2500,
 		.channels = ad7606_channels,
 		.num_channels = 7,
 	},
 	[ID_AD7606_4] = {
 		.name = "ad7606-4",
-		.int_vref_mv = 2500,
 		.channels = ad7606_channels,
 		.num_channels = 5,
 	},
-- 
2.1.4

