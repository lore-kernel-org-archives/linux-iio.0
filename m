Return-Path: <SRS0=8HRq=KH=xilinx.com=MNARANI@kernel.org>
From: Manish Narani <manish.narani@xilinx.com>
To: <lakshmi.sai.krishna.potthuri@xilinx.com>, <manish.narani@xilinx.com>,
	<michal.simek@xilinx.com>, <pmeerw@pmeerw.net>, <lars@metafoo.de>,
	<knaack.h@gmx.de>, <jic23@kernel.org>
CC: <anirudh@xilinx.com>, <sgoud@xilinx.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>
Subject: [PATCH v2 4/4] iio: adc: xilinx: Move request_irq before enabling interrupts
Date: Mon, 23 Jul 2018 20:32:03 +0530
Message-ID: <1532358123-23485-5-git-send-email-manish.narani@xilinx.com>
In-Reply-To: <1532358123-23485-1-git-send-email-manish.narani@xilinx.com>
References: <1532358123-23485-1-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Enabling the Interrupts before registering the irq handler is a bad
idea. This patch corrects the same for XADC driver.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 44a2519..3f6be5a 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1226,15 +1226,15 @@ static int xadc_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_free_samplerate_trigger;
 
-	ret = xadc->ops->setup(pdev, indio_dev, xadc->irq);
-	if (ret)
-		goto err_clk_disable_unprepare;
-
 	ret = request_irq(xadc->irq, xadc->ops->interrupt_handler, 0,
 			dev_name(&pdev->dev), indio_dev);
 	if (ret)
 		goto err_clk_disable_unprepare;
 
+	ret = xadc->ops->setup(pdev, indio_dev, xadc->irq);
+	if (ret)
+		goto err_free_irq;
+
 	for (i = 0; i < 16; i++)
 		xadc_read_adc_reg(xadc, XADC_REG_THRESHOLD(i),
 			&xadc->threshold[i]);
-- 
2.1.1
