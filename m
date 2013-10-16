Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-207.synserver.de ([212.40.185.207]:1103 "EHLO
	smtp-out-207.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934549Ab3JPUnx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Oct 2013 16:43:53 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Stefan Roese <sr@denx.de>
Subject: [PATCH 2/2] staging:iio:spear_adc: Fix IRQ check
Date: Wed, 16 Oct 2013 22:45:52 +0200
Message-Id: <1381956352-13311-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1381956352-13311-1-git-send-email-lars@metafoo.de>
References: <1381956352-13311-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The test in the spear_adc driver which checks whether the IRQ number returned
by platform_get_irq() has multiple problems. It accepts 0 even though this is
an invalid IRQ. It also rejects IRQ numbers that are larger or equal than
NR_IRQS. First of all drivers should never need to reference NR_IRQS and
secondly with CONFIG_SPARSE_IRQ NR_IRQS is not the upper limit, so the check
might reject valid IRQ numbers. This patch modifies the check to only test
against less or equal to 0.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Cc: Stefan Roese <sr@denx.de>
---
 drivers/staging/iio/adc/spear_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/spear_adc.c b/drivers/staging/iio/adc/spear_adc.c
index e6555b6..970d9ed 100644
--- a/drivers/staging/iio/adc/spear_adc.c
+++ b/drivers/staging/iio/adc/spear_adc.c
@@ -333,7 +333,7 @@ static int spear_adc_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if ((irq < 0) || (irq >= NR_IRQS)) {
+	if (irq <= 0) {
 		dev_err(dev, "failed getting interrupt resource\n");
 		ret = -EINVAL;
 		goto errout3;
-- 
1.8.0

