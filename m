Return-Path: <harald@ccbib.org>
From: Harald Geyer <harald@ccbib.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Jonathan Bell <jonathan@raspberrypi.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Harald Geyer <harald@ccbib.org>
Subject: [PATCHv3 3/4] iio: dht11: avoid multiple assignments to make checkpatch.pl --strict happy
Date: Tue,  7 Jul 2015 13:39:30 +0000
Message-Id: <1436276371-7480-3-git-send-email-harald@ccbib.org>
In-Reply-To: <1436276371-7480-1-git-send-email-harald@ccbib.org>
References: <55991FEA.50703@kernel.org>
 <1436276371-7480-1-git-send-email-harald@ccbib.org>
List-ID: <linux-iio@vger.kernel.org>

We just do the assignments in two steps.

Signed-off-by: Harald Geyer <harald@ccbib.org>
---
 drivers/iio/humidity/dht11.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
index bb5ad57..91976e0 100644
--- a/drivers/iio/humidity/dht11.c
+++ b/drivers/iio/humidity/dht11.c
@@ -263,9 +263,10 @@ static int dht11_probe(struct platform_device *pdev)
 	dht11 = iio_priv(iio);
 	dht11->dev = dev;
 
-	dht11->gpio = ret = of_get_gpio(node, 0);
+	ret = of_get_gpio(node, 0);
 	if (ret < 0)
 		return ret;
+	dht11->gpio = ret;
 	ret = devm_gpio_request_one(dev, dht11->gpio, GPIOF_IN, pdev->name);
 	if (ret)
 		return ret;
-- 
1.7.10.4
