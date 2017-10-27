Return-Path: <SRS0=wbiz=B2=pmeerw.net=pmeerw@kernel.org>
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Matt Ranostay <matt@ranostay.consulting>
Subject: [PATCH 02/13] iio: health: max30102: Temperature should be in milli Celsius
Date: Fri, 27 Oct 2017 21:29:39 +0200
Message-Id: <1509132593-1815-5-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1509132593-1815-1-git-send-email-pmeerw@pmeerw.net>
References: <1509132593-1815-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

As per ABI temperature should be in milli Celsius after scaling,
not Celsius

Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Matt Ranostay <matt@ranostay.consulting>
---
 drivers/iio/health/max30102.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index 7635bef..6404ac1 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -371,7 +371,7 @@ static int max30102_read_raw(struct iio_dev *indio_dev,
 		mutex_unlock(&indio_dev->mlock);
 		break;
 	case IIO_CHAN_INFO_SCALE:
-		*val = 1;  /* 0.0625 */
+		*val = 1000;  /* 62.5 */
 		*val2 = 16;
 		ret = IIO_VAL_FRACTIONAL;
 		break;
-- 
2.7.4
