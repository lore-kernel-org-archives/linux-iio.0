Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:53033 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754835Ab1HZKLY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 26 Aug 2011 06:11:24 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 06/16] staging:iio:adc:ad7152 set correct number of channels for ad7153.
Date: Fri, 26 Aug 2011 11:19:23 +0100
Message-Id: <1314353973-7662-7-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314353973-7662-1-git-send-email-jic23@cam.ac.uk>
References: <1314353973-7662-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Has been broken for some time.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7152.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7152.c b/drivers/staging/iio/adc/ad7152.c
index 8dbc00c..5acaf8a 100644
--- a/drivers/staging/iio/adc/ad7152.c
+++ b/drivers/staging/iio/adc/ad7152.c
@@ -401,6 +401,10 @@ static int __devinit ad7152_probe(struct i2c_client *client,
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->info = &ad7152_info;
 	indio_dev->channels = ad7152_channels;
+	if (id->driver_data == 0)
+		indio_dev->num_channels = ARRAY_SIZE(ad7152_channels);
+	else
+		indio_dev->num_channels = 1;
 	indio_dev->num_channels = ARRAY_SIZE(ad7152_channels);
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
@@ -429,7 +433,7 @@ static int __devexit ad7152_remove(struct i2c_client *client)
 
 static const struct i2c_device_id ad7152_id[] = {
 	{ "ad7152", 0 },
-	{ "ad7153", 0 },
+	{ "ad7153", 1 },
 	{}
 };
 
-- 
1.7.3.4

