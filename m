Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:37775 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755029AbcGEKX2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 5 Jul 2016 06:23:28 -0400
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, knaack.h@gmx.de,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH 3/4] iio: light: vcnl4000: Cleanup read_raw() returns
Date: Tue,  5 Jul 2016 12:23:20 +0200
Message-Id: <1467714201-11429-4-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1467714201-11429-1-git-send-email-pmeerw@pmeerw.net>
References: <1467714201-11429-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
---
 drivers/iio/light/vcnl4000.c |   27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 7f247ed..9f94b6b 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -109,7 +109,7 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
 				struct iio_chan_spec const *chan,
 				int *val, int *val2, long mask)
 {
-	int ret = -EINVAL;
+	int ret;
 	struct vcnl4000_data *data = iio_priv(indio_dev);
 
 	switch (mask) {
@@ -121,32 +121,27 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
 				VCNL4000_AL_RESULT_HI, val);
 			if (ret < 0)
 				return ret;
-			ret = IIO_VAL_INT;
-			break;
+			return IIO_VAL_INT;
 		case IIO_PROXIMITY:
 			ret = vcnl4000_measure(data,
 				VCNL4000_PS_OD, VCNL4000_PS_RDY,
 				VCNL4000_PS_RESULT_HI, val);
 			if (ret < 0)
 				return ret;
-			ret = IIO_VAL_INT;
-			break;
+			return IIO_VAL_INT;
 		default:
-			break;
+			return -EINVAL;
 		}
-		break;
 	case IIO_CHAN_INFO_SCALE:
-		if (chan->type == IIO_LIGHT) {
-			*val = 0;
-			*val2 = 250000;
-			ret = IIO_VAL_INT_PLUS_MICRO;
-		}
-		break;
+		if (chan->type != IIO_LIGHT)
+			return -EINVAL;
+
+		*val = 0;
+		*val2 = 250000;
+		return IIO_VAL_INT_PLUS_MICRO;
 	default:
-		break;
+		return -EINVAL;
 	}
-
-	return ret;
 }
 
 static const struct iio_info vcnl4000_info = {
-- 
1.7.10.4

