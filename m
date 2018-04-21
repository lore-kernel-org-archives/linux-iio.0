Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:49886 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752902AbeDUAmM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 20 Apr 2018 20:42:12 -0400
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH 05/13] staging: iio: tsl2x7x: remove unnecessary chip status checks in suspend/resume
Date: Fri, 20 Apr 2018 20:41:45 -0400
Message-Id: <20180421004153.19073-6-masneyb@onstation.org>
In-Reply-To: <20180421004153.19073-1-masneyb@onstation.org>
References: <20180421004153.19073-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

tsl2x7x_suspend() and tsl2x7x_resume() both check to see what the
current chip status is. These checks are not necessary so this patch
removes those checks.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index f37fc74b8fbc..8d8af0cf9768 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -1682,27 +1682,15 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
 static int tsl2x7x_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
-	int ret = 0;
-
-	if (chip->tsl2x7x_chip_status == TSL2X7X_CHIP_WORKING) {
-		ret = tsl2x7x_chip_off(indio_dev);
-		chip->tsl2x7x_chip_status = TSL2X7X_CHIP_SUSPENDED;
-	}
 
-	return ret;
+	return tsl2x7x_chip_off(indio_dev);
 }
 
 static int tsl2x7x_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
-	int ret = 0;
 
-	if (chip->tsl2x7x_chip_status == TSL2X7X_CHIP_SUSPENDED)
-		ret = tsl2x7x_chip_on(indio_dev);
-
-	return ret;
+	return tsl2x7x_chip_on(indio_dev);
 }
 
 static int tsl2x7x_remove(struct i2c_client *client)
-- 
2.14.3

