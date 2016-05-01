Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41519 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421AbcEAUhb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 1 May 2016 16:37:31 -0400
From: "Andrew F. Davis" <afd@ti.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: <linux-iio@vger.kernel.org>, <linux-api@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 06/13] iio: health/afe440x: Remove unneeded offset handling
Date: Sun, 1 May 2016 15:36:56 -0500
Message-ID: <1462135023-14445-7-git-send-email-afd@ti.com>
In-Reply-To: <1462135023-14445-1-git-send-email-afd@ti.com>
References: <1462135023-14445-1-git-send-email-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

No channel in the afe4403 driver has IIO_CHAN_INFO_OFFSET set so
remove the handlers for this.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/iio/health/afe4403.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
index bcff528..cac6090 100644
--- a/drivers/iio/health/afe4403.c
+++ b/drivers/iio/health/afe4403.c
@@ -293,14 +293,6 @@ static int afe4403_read_raw(struct iio_dev *indio_dev,
 			if (ret)
 				return ret;
 			return IIO_VAL_INT;
-		case IIO_CHAN_INFO_OFFSET:
-			ret = regmap_read(afe->regmap, reg_info.offreg,
-					  val);
-			if (ret)
-				return ret;
-			*val &= reg_info.mask;
-			*val >>= reg_info.shift;
-			return IIO_VAL_INT;
 		}
 		break;
 	case IIO_CURRENT:
@@ -333,15 +325,6 @@ static int afe4403_write_raw(struct iio_dev *indio_dev,
 	const struct afe440x_reg_info reg_info = afe4403_reg_info[chan->address];
 
 	switch (chan->type) {
-	case IIO_INTENSITY:
-		switch (mask) {
-		case IIO_CHAN_INFO_OFFSET:
-			return regmap_update_bits(afe->regmap,
-				reg_info.offreg,
-				reg_info.mask,
-				(val << reg_info.shift));
-		}
-		break;
 	case IIO_CURRENT:
 		switch (mask) {
 		case IIO_CHAN_INFO_RAW:
-- 
2.8.1

