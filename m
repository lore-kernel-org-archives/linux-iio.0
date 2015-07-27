Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:59963 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754704AbbG0WjP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 27 Jul 2015 18:39:15 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: [PATCH v2 2/8] iio:adc:berlin2-adc: pass up real error code
Date: Tue, 28 Jul 2015 00:38:58 +0200
Message-Id: <37a921c304bd807ed57222453c1ca2bf246c9c21.1438035998.git.knaack.h@gmx.de>
In-Reply-To: <cover.1438035998.git.knaack.h@gmx.de>
References: <cover.1438035998.git.knaack.h@gmx.de>
In-Reply-To: <cover.1438035998.git.knaack.h@gmx.de>
References: <cover.1438035998.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Pass up the real error code returned by platform_get_irq_byname().

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Acked-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/iio/adc/berlin2-adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/berlin2-adc.c b/drivers/iio/adc/berlin2-adc.c
index 26fa6e6cb624..b31bcf4c7c90 100644
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
2.4.6

