Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:52578 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754686AbaAAXEl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 1 Jan 2014 18:04:41 -0500
Received: from [192.168.0.80] ([188.102.227.0]) by mail.gmx.com (mrgmx101)
 with ESMTPSA (Nemesis) id 0LnTjW-1VVBAf3mb0-00hgVd for
 <linux-iio@vger.kernel.org>; Thu, 02 Jan 2014 00:04:40 +0100
Message-ID: <52C49F06.3010505@gmx.de>
Date: Thu, 02 Jan 2014 00:04:38 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
Subject: [PATCH V2 1/2]staging:iio:ad799x fix error_free_irq, use devm_request_threaded_irq
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Only free an IRQ in error_free_irq, if it has been requested previously.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index e32a555..3deb390 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -590,7 +590,8 @@ static int ad799x_probe(struct i2c_client *client,
 	return 0;
 
 error_free_irq:
-	free_irq(client->irq, indio_dev);
+	if (client->irq > 0)
+		free_irq(client->irq, indio_dev);
 error_cleanup_ring:
 	ad799x_ring_cleanup(indio_dev);
 error_disable_reg:
