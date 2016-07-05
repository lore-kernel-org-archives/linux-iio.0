Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:41608 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754943AbcGELzr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 5 Jul 2016 07:55:47 -0400
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, knaack.h@gmx.de,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH 2/9] staging: iio: isl29018: Remove excessive output messages
Date: Tue,  5 Jul 2016 13:55:37 +0200
Message-Id: <1467719744-19450-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1467719744-19450-1-git-send-email-pmeerw@pmeerw.net>
References: <1467719744-19450-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
---
 drivers/staging/iio/light/isl29018.c |   16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index 0599337..875007f 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -341,10 +341,8 @@ static ssize_t store_prox_infrared_suppression(struct device *dev,
 
 	if (kstrtoint(buf, 10, &val))
 		return -EINVAL;
-	if (!(val == 0 || val == 1)) {
-		dev_err(dev, "The mode is not supported\n");
+	if (!(val == 0 || val == 1))
 		return -EINVAL;
-	}
 
 	/*
 	 * get the  "proximity scheme" i.e. if the chip does on chip
@@ -727,10 +725,8 @@ static int isl29018_probe(struct i2c_client *client,
 	int dev_id = 0;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
-	if (!indio_dev) {
-		dev_err(&client->dev, "iio allocation fails\n");
+	if (!indio_dev)
 		return -ENOMEM;
-	}
 	chip = iio_priv(indio_dev);
 
 	i2c_set_clientdata(client, indio_dev);
@@ -770,13 +766,7 @@ static int isl29018_probe(struct i2c_client *client,
 	indio_dev->name = name;
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	err = devm_iio_device_register(&client->dev, indio_dev);
-	if (err) {
-		dev_err(&client->dev, "iio registration fails\n");
-		return err;
-	}
-
-	return 0;
+	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
1.7.10.4

