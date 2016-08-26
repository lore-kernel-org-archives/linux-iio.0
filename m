Return-Path: <weiyj.lk@gmail.com>
From: Wei Yongjun <weiyj.lk@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH -next] iio: adc: mt2701: Remove redundant dev_err call in mt6577_auxadc_probe()
Date: Fri, 26 Aug 2016 14:26:21 +0000
Message-Id: <1472221581-28836-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

From: Wei Yongjun <weiyongjun1@huawei.com>

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/iio/adc/mt6577_auxadc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
index 2d104c8..a268954 100644
--- a/drivers/iio/adc/mt6577_auxadc.c
+++ b/drivers/iio/adc/mt6577_auxadc.c
@@ -206,10 +206,8 @@ static int mt6577_auxadc_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	adc_dev->reg_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(adc_dev->reg_base)) {
-		dev_err(&pdev->dev, "failed to get auxadc base address\n");
+	if (IS_ERR(adc_dev->reg_base))
 		return PTR_ERR(adc_dev->reg_base);
-	}
 
 	adc_dev->adc_clk = devm_clk_get(&pdev->dev, "main");
 	if (IS_ERR(adc_dev->adc_clk)) {
