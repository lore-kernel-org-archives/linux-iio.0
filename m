Return-Path: <masneyb@onstation.org>
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] iio: light: tsl2583: return proper error code
Date: Wed, 19 Oct 2016 06:32:04 -0400
Message-Id: <1476873130-24926-1-git-send-email-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

taos_gain_store() and taos_als_calibrate() both have a code path where
-1 was returned. This patch changes the code so that a proper error code
is returned to make the code consistent with the error paths that are
present within those same functions.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2583.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 08f1583..1e42a19 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -359,7 +359,7 @@ static int taos_als_calibrate(struct iio_dev *indio_dev)
 			!= (TSL258X_CNTL_ADC_ENBL | TSL258X_CNTL_PWR_ON)) {
 		dev_err(&chip->client->dev,
 			"taos_als_calibrate failed: device not powered on with ADC enabled\n");
-		return -1;
+		return -ENODATA;
 	}
 
 	ret = i2c_smbus_write_byte(chip->client,
@@ -569,7 +569,7 @@ static ssize_t taos_gain_store(struct device *dev,
 		break;
 	default:
 		dev_err(dev, "Invalid Gain Index (must be 1,8,16,111)\n");
-		return -1;
+		return -EINVAL;
 	}
 
 	return len;
-- 
2.7.4
