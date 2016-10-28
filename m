Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:50794 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756294AbcJ1KA2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 28 Oct 2016 06:00:28 -0400
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, Mark.Rutland@arm.com
Subject: [PATCH 03/10] staging: iio: tsl2583: return proper error code instead of -1
Date: Fri, 28 Oct 2016 06:00:14 -0400
Message-Id: <1477648821-3786-4-git-send-email-masneyb@onstation.org>
In-Reply-To: <1477648821-3786-1-git-send-email-masneyb@onstation.org>
References: <1477648821-3786-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

taos_als_calibrate() has a code path where -1 is returned. This patch
changes the code so that a proper error code is returned.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2583.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 35c1696..47fd373 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -373,7 +373,7 @@ static int taos_als_calibrate(struct iio_dev *indio_dev)
 			!= (TSL258X_CNTL_ADC_ENBL | TSL258X_CNTL_PWR_ON)) {
 		dev_err(&chip->client->dev,
 			"taos_als_calibrate failed: device not powered on with ADC enabled\n");
-		return -1;
+		return -EINVAL;
 	}
 
 	ret = i2c_smbus_write_byte(chip->client,
-- 
2.7.4

