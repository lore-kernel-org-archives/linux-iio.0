Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:23190 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933819AbaFRGVr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Jun 2014 02:21:47 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N7C00B9TPO9XX80@mailout2.samsung.com> for
 linux-iio@vger.kernel.org; Wed, 18 Jun 2014 15:21:45 +0900 (KST)
From: Beomho Seo <beomho.seo@samsung.com>
To: linux-iio@vger.kernel.org, jic23@kernel.org,
	j.anaszewski@samsung.com, sachin.kamat@linaro.org,
	ch.naveen@samsung.com, ktsai@capellamicro.com,
	srinivas.pandruvada@linux.intel.com, t.figa@samsung.com
Cc: myungjoo.ham@samsung.com, jh80.chung@samsung.com,
	cw00.choi@samsung.com, Beomho Seo <beomho.seo@samsung.com>
Subject: [PATCH 2/5] iio: light: cm32181: Use devm_* APIs
Date: Wed, 18 Jun 2014 15:21:40 +0900
Message-id: <1403072503-29246-3-git-send-email-beomho.seo@samsung.com>
In-reply-to: <1403072503-29246-1-git-send-email-beomho.seo@samsung.com>
References: <1403072503-29246-1-git-send-email-beomho.seo@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch changes API from iio_device_register() to devm_* API.
Using API make code simpler.

Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
---
 drivers/iio/light/cm32181.c |   11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index d976e6c..ad36b29 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -331,7 +331,7 @@ static int cm32181_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&client->dev, indio_dev);
 	if (ret) {
 		dev_err(&client->dev,
 			"%s: regist device failed\n",
@@ -342,14 +342,6 @@ static int cm32181_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int cm32181_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-
-	iio_device_unregister(indio_dev);
-	return 0;
-}
-
 static const struct i2c_device_id cm32181_id[] = {
 	{ "cm32181", 0 },
 	{ }
@@ -370,7 +362,6 @@ static struct i2c_driver cm32181_driver = {
 	},
 	.id_table       = cm32181_id,
 	.probe		= cm32181_probe,
-	.remove		= cm32181_remove,
 };
 
 module_i2c_driver(cm32181_driver);
-- 
1.7.9.5

