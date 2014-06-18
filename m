Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:28211 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756649AbaFRGV5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Jun 2014 02:21:57 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N7C00HT9PO9VR10@mailout4.samsung.com> for
 linux-iio@vger.kernel.org; Wed, 18 Jun 2014 15:21:45 +0900 (KST)
From: Beomho Seo <beomho.seo@samsung.com>
To: linux-iio@vger.kernel.org, jic23@kernel.org,
	j.anaszewski@samsung.com, sachin.kamat@linaro.org,
	ch.naveen@samsung.com, ktsai@capellamicro.com,
	srinivas.pandruvada@linux.intel.com, t.figa@samsung.com
Cc: myungjoo.ham@samsung.com, jh80.chung@samsung.com,
	cw00.choi@samsung.com, Beomho Seo <beomho.seo@samsung.com>
Subject: [PATCH 3/5] iio: light: cm36651: Use devm_* APIs
Date: Wed, 18 Jun 2014 15:21:41 +0900
Message-id: <1403072503-29246-4-git-send-email-beomho.seo@samsung.com>
In-reply-to: <1403072503-29246-1-git-send-email-beomho.seo@samsung.com>
References: <1403072503-29246-1-git-send-email-beomho.seo@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch changes APIs from request_threaded_irq()
and iio_device_register() to devm_* APIS.
Using them make code simpler.

Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
---
 drivers/iio/light/cm36651.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/cm36651.c b/drivers/iio/light/cm36651.c
index 39fc67e..2fd9579 100644
--- a/drivers/iio/light/cm36651.c
+++ b/drivers/iio/light/cm36651.c
@@ -679,7 +679,8 @@ static int cm36651_probe(struct i2c_client *client,
 		goto error_i2c_unregister_ara;
 	}
 
-	ret = request_threaded_irq(client->irq, NULL, cm36651_irq_handler,
+	ret = devm_request_threaded_irq(&client->dev, client->irq,
+					NULL, cm36651_irq_handler,
 					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 							"cm36651", indio_dev);
 	if (ret) {
@@ -687,16 +688,14 @@ static int cm36651_probe(struct i2c_client *client,
 		goto error_i2c_unregister_ara;
 	}
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&client->dev, indio_dev);
 	if (ret) {
 		dev_err(&client->dev, "%s: regist device failed\n", __func__);
-		goto error_free_irq;
+		goto error_i2c_unregister_ara;
 	}
 
 	return 0;
 
-error_free_irq:
-	free_irq(client->irq, indio_dev);
 error_i2c_unregister_ara:
 	i2c_unregister_device(cm36651->ara_client);
 error_i2c_unregister_ps:
@@ -711,9 +710,7 @@ static int cm36651_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct cm36651_data *cm36651 = iio_priv(indio_dev);
 
-	iio_device_unregister(indio_dev);
 	regulator_disable(cm36651->vled_reg);
-	free_irq(client->irq, indio_dev);
 	i2c_unregister_device(cm36651->ps_client);
 	i2c_unregister_device(cm36651->ara_client);
 
-- 
1.7.9.5

