Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:54111 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755142AbbGYWnl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 25 Jul 2015 18:43:41 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: [PATCH 5/8] iio:adc:berlin2-adc: use short operator format
Date: Sun, 26 Jul 2015 00:43:23 +0200
Message-Id: <815876954eaf0f9e3556756001679becaabd9570.1437862404.git.knaack.h@gmx.de>
In-Reply-To: <cover.1437862404.git.knaack.h@gmx.de>
References: <cover.1437862404.git.knaack.h@gmx.de>
In-Reply-To: <cover.1437862404.git.knaack.h@gmx.de>
References: <cover.1437862404.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use augmented assignment to subtract the offset for negative temperature
values.
Specify the amount of private data to be allocated through
devm_iio_device_alloc() with sizeof(*priv), as it is shorter and common
practice in IIO.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/adc/berlin2-adc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/berlin2-adc.c b/drivers/iio/adc/berlin2-adc.c
index b7df94a0b879..1d14290ba6f2 100644
--- a/drivers/iio/adc/berlin2-adc.c
+++ b/drivers/iio/adc/berlin2-adc.c
@@ -221,7 +221,7 @@ static int berlin2_adc_read_raw(struct iio_dev *indio_dev,
 			return temp;
 
 		if (temp > 2047)
-			temp = -(4096 - temp);
+			temp -= 4096;
 
 		/* Convert to milli Celsius */
 		*val = ((temp * 100000) / 264 - 270000);
@@ -286,8 +286,7 @@ static int berlin2_adc_probe(struct platform_device *pdev)
 	int irq, tsen_irq;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev,
-					  sizeof(struct berlin2_adc_priv));
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
 	if (!indio_dev)
 		return -ENOMEM;
 
-- 
2.4.3

