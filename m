Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:50820 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751786Ab3L2Lvg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 29 Dec 2013 06:51:36 -0500
Received: from [192.168.0.80] ([188.102.214.102]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0M9KR0-1W9ucy1hAU-00CgKO for
 <linux-iio@vger.kernel.org>; Sun, 29 Dec 2013 12:51:34 +0100
Message-ID: <52C00CC5.3030209@gmx.de>
Date: Sun, 29 Dec 2013 12:51:33 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
Subject: [PATCH]staging:iio:ad799x use devm_request_threaded_irq
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Move to devm_request_threaded_irq to make device-removal easier, and also fix
error_free_irq, which did not check if an irq was requested at all.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index e32a555..bc886f6 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -573,24 +573,23 @@ static int ad799x_probe(struct i2c_client *client,
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
-	free_irq(client->irq, indio_dev);
 error_cleanup_ring:
 	ad799x_ring_cleanup(indio_dev);
 error_disable_reg:
@@ -606,8 +605,6 @@ static int ad799x_remove(struct i2c_client *client)
 	struct ad799x_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-	if (client->irq > 0)
-		free_irq(client->irq, indio_dev);
 
 	ad799x_ring_cleanup(indio_dev);
 	if (!IS_ERR(st->reg))
