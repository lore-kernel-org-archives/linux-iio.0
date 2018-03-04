Return-Path: <SRS0=gLGt=F2=onstation.org=masneyb@kernel.org>
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-kernel@vger.kernel.org,
	Jon.Brenner@ams.com
Subject: [PATCH 06/12] staging: iio: tsl2x7x: correctly return errors in tsl2x7x_get_prox()
Date: Sat,  3 Mar 2018 20:49:36 -0500
Message-Id: <20180304014942.18727-7-masneyb@onstation.org>
In-Reply-To: <20180304014942.18727-1-masneyb@onstation.org>
References: <20180304014942.18727-1-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

Not all errors that occurred in tsl2x7x_get_prox() were correctly
reported in the return value. This patch changes the error handling
so that errors are now returned properly.

Note that the ret variable is from the call to tsl2x7x_read_status(),
and it already has the correct error check. The -EINVAL error code is
for an unexpected value in the register.

This patch also corrects an unnecessary word wrap in the call to
le16_to_cpup() while changes are being made to this code.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 5c611250127f..cc209b64ed5a 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -489,16 +489,20 @@ static int tsl2x7x_get_prox(struct iio_dev *indio_dev)
 	case tmd2671:
 	case tsl2771:
 	case tmd2771:
-		if (!(ret & TSL2X7X_STA_ADC_VALID))
+		if (!(ret & TSL2X7X_STA_ADC_VALID)) {
+			ret = -EINVAL;
 			goto prox_poll_err;
+		}
 		break;
 	case tsl2572:
 	case tsl2672:
 	case tmd2672:
 	case tsl2772:
 	case tmd2772:
-		if (!(ret & TSL2X7X_STA_PRX_VALID))
+		if (!(ret & TSL2X7X_STA_PRX_VALID)) {
+			ret = -EINVAL;
 			goto prox_poll_err;
+		}
 		break;
 	}
 
@@ -512,14 +516,13 @@ static int tsl2x7x_get_prox(struct iio_dev *indio_dev)
 		chdata[i] = ret;
 	}
 
-	chip->prox_data =
-			le16_to_cpup((const __le16 *)&chdata[0]);
+	chip->prox_data = le16_to_cpup((const __le16 *)&chdata[0]);
+	ret = chip->prox_data;
 
 prox_poll_err:
-
 	mutex_unlock(&chip->prox_mutex);
 
-	return chip->prox_data;
+	return ret;
 }
 
 /**
-- 
2.14.3
