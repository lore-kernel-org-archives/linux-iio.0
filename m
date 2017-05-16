Return-Path: <SRS0=1DrK=4W=gmail.com=weiyj.lk@kernel.org>
From: Wei Yongjun <weiyj.lk@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
	Lee Jones <lee.jones@linaro.org>,
	Marek Vasut <marex@denx.de>
Cc: Wei Yongjun <weiyongjun1@huawei.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH -next v3] iio: adc: mxs-lradc: Fix return value check in mxs_lradc_adc_probe()
Date: Tue, 16 May 2017 15:26:12 +0000
Message-Id: <20170516152612.19090-1-weiyj.lk@gmail.com>
In-Reply-To: <20170427151413.23843-1-weiyj.lk@gmail.com>
References: <20170427151413.23843-1-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

From: Wei Yongjun <weiyongjun1@huawei.com>

In case of error, the function devm_ioremap() returns NULL pointer
not ERR_PTR(). The IS_ERR() test in the return value check should
be replaced with NULL test. Also add NULL test for iores.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
v2 -> v3: use NULL test instead of devm_ioremap_resource()
---
 drivers/iio/adc/mxs-lradc-adc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
index b0c7d8e..6888167 100644
--- a/drivers/iio/adc/mxs-lradc-adc.c
+++ b/drivers/iio/adc/mxs-lradc-adc.c
@@ -718,9 +718,12 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
 	adc->dev = dev;
 
 	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!iores)
+		return -EINVAL;
+
 	adc->base = devm_ioremap(dev, iores->start, resource_size(iores));
-	if (IS_ERR(adc->base))
-		return PTR_ERR(adc->base);
+	if (!adc->base)
+		return -ENOMEM;
 
 	init_completion(&adc->completion);
 	spin_lock_init(&adc->lock);
