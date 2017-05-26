Return-Path: <SRS0=reQG=5A=gmail.com=arvind.yadav.cs@kernel.org>
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	soren.brinkmann@xilinx.com
Cc: linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: xilinx: Handle return value of clk_prepare_enable
Date: Fri, 26 May 2017 12:07:41 +0530
Message-Id: <29dda0d20f714ce828e294f99b7f400e89f5b35a.1495780467.git.arvind.yadav.cs@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 56cf590..4a60497 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1204,7 +1204,10 @@ static int xadc_probe(struct platform_device *pdev)
 		ret = PTR_ERR(xadc->clk);
 		goto err_free_samplerate_trigger;
 	}
-	clk_prepare_enable(xadc->clk);
+
+	ret = clk_prepare_enable(xadc->clk);
+	if (ret)
+		goto err_free_samplerate_trigger;
 
 	ret = xadc->ops->setup(pdev, indio_dev, irq);
 	if (ret)
-- 
1.9.1
