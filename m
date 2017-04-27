Return-Path: <SRS0=lvGo=4D=gmail.com=weiyj.lk@kernel.org>
From: Wei Yongjun <weiyj.lk@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Marek Vasut <marex@denx.de>,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
	Lee Jones <lee.jones@linaro.org>
Cc: Wei Yongjun <weiyongjun1@huawei.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH -next v2] iio: adc: mxs-lradc: Fix return value check in mxs_lradc_adc_probe()
Date: Thu, 27 Apr 2017 15:14:13 +0000
Message-Id: <20170427151413.23843-1-weiyj.lk@gmail.com>
In-Reply-To: <20170425033612.27251-1-weiyj.lk@gmail.com>
References: <20170425033612.27251-1-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

From: Wei Yongjun <weiyongjun1@huawei.com>

In case of error, the function devm_ioremap() returns NULL pointer not
ERR_PTR(). Use devm_ioremap_resource() instead of devm_ioremap().

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
v1 -> v2: use devm_ioremap_resource()
---
 drivers/iio/adc/mxs-lradc-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
index b0c7d8e..2faf65f 100644
--- a/drivers/iio/adc/mxs-lradc-adc.c
+++ b/drivers/iio/adc/mxs-lradc-adc.c
@@ -718,7 +718,7 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
 	adc->dev = dev;
 
 	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	adc->base = devm_ioremap(dev, iores->start, resource_size(iores));
+	adc->base = devm_ioremap_resource(dev, iores);
 	if (IS_ERR(adc->base))
 		return PTR_ERR(adc->base);
