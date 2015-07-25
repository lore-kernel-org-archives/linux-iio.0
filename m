Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:62325 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755138AbbGYWni (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 25 Jul 2015 18:43:38 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: [PATCH 2/8] iio:adc:berlin2-adc: pass up real error code
Date: Sun, 26 Jul 2015 00:43:20 +0200
Message-Id: <7fd11d0f250039515b90b442c9fa264cd43a0537.1437862404.git.knaack.h@gmx.de>
In-Reply-To: <cover.1437862404.git.knaack.h@gmx.de>
References: <cover.1437862404.git.knaack.h@gmx.de>
In-Reply-To: <cover.1437862404.git.knaack.h@gmx.de>
References: <cover.1437862404.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Pass up the real error code returned by platform_get_irq_byname().

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/adc/berlin2-adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/berlin2-adc.c b/drivers/iio/adc/berlin2-adc.c
index 97863d1ba79a..b5a099c7bf34 100644
--- a/drivers/iio/adc/berlin2-adc.c
+++ b/drivers/iio/adc/berlin2-adc.c
@@ -301,11 +301,11 @@ static int berlin2_adc_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq_byname(pdev, "adc");
 	if (irq < 0)
-		return -ENODEV;
+		return irq;
 
 	tsen_irq = platform_get_irq_byname(pdev, "tsen");
 	if (tsen_irq < 0)
-		return -ENODEV;
+		return tsen_irq;
 
 	ret = devm_request_irq(&pdev->dev, irq, berlin2_adc_irq, 0,
 			pdev->dev.driver->name, indio_dev);
-- 
2.4.3

