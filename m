Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:49652 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754750AbaAAXEQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 1 Jan 2014 18:04:16 -0500
Received: from [192.168.0.80] ([188.102.227.0]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0MAQMg-1WA4LE2LOM-00BZqg for
 <linux-iio@vger.kernel.org>; Thu, 02 Jan 2014 00:04:15 +0100
Message-ID: <52C49EED.5000206@gmx.de>
Date: Thu, 02 Jan 2014 00:04:13 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
Subject: [PATCH V2 2/2]staging:iio:ad799x fix error_free_irq, use devm_request_threaded_irq
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Move to devm_request_threaded_irq to make device-removal easier.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index 3deb390..bc886f6 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -573,25 +573,23 @@ static int ad799x_probe(struct i2c_client *client,
 		goto error_disable_reg;
 
 	if (client->irq > 0) {
-		ret = request_threaded_irq(client->irq,
-					   NULL,
-					   ad799x_event_handler,
-					   IRQF_TRIGGER_FALLING |
-					   IRQF_ONESHOT,
-					   client->name,
-					   indio_dev);
+		ret = devm_request_threaded_irq(&client->dev,
+						client->irq,
+						NULL,
+						ad799x_event_handler,
+						IRQF_TRIGGER_FALLING |
+						IRQF_ONESHOT,
+						client->name,
+						indio_dev);
 		if (ret)
 			goto error_cleanup_ring;
 	}
 	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto error_free_irq;
+		goto error_cleanup_ring;
 
 	return 0;
 
-error_free_irq:
-	if (client->irq > 0)
-		free_irq(client->irq, indio_dev);
 error_cleanup_ring:
 	ad799x_ring_cleanup(indio_dev);
 error_disable_reg:
@@ -607,8 +605,6 @@ static int ad799x_remove(struct i2c_client *client)
 	struct ad799x_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-	if (client->irq > 0)
-		free_irq(client->irq, indio_dev);
 
 	ad799x_ring_cleanup(indio_dev);
 	if (!IS_ERR(st->reg))
