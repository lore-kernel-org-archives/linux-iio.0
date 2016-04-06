Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:9275 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752658AbcDFHDH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 6 Apr 2016 03:03:07 -0400
Subject: Re: [PATCH 1/9] iio: adc: exynos_adc: use regmap to retrieve struct
 device
To: Alison Schofield <amsfield22@gmail.com>, jic23@kernel.org
References: <cover.1459918214.git.amsfield22@gmail.com>
 <2329d20396db00b60f4e7d2e783ea46b48eea9c1.1459918214.git.amsfield22@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	kgene@kernel.org, k.kozlowski@samsung.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-id: <5704B4A4.1070704@samsung.com>
Date: Wed, 06 Apr 2016 09:03:00 +0200
MIME-version: 1.0
In-reply-to: <2329d20396db00b60f4e7d2e783ea46b48eea9c1.1459918214.git.amsfield22@gmail.com>
Content-type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

On 2016-04-06 07:15, Alison Schofield wrote:
> Driver includes struct regmap and struct device in its global data.
> Remove the struct device and use regmap API to retrieve device info.
>
> Patch created using Coccinelle plus manual edits.
>
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>

This patch changes the struct device which is used by the driver to 
report errors. The driver used correctly the struct device associated 
with its device tree node, while after the patch it will use device 
which is associated with PMU regmap, which is a different device. PMU 
regmap is there only to enable/disable the ADC block and it is not the 
regmap used to access registers of the ADC device.

I would prefer to drop this patch.

> ---
>   drivers/iio/adc/exynos_adc.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
> index c15756d..0313e0f 100644
> --- a/drivers/iio/adc/exynos_adc.c
> +++ b/drivers/iio/adc/exynos_adc.c
> @@ -130,7 +130,6 @@
>   
>   struct exynos_adc {
>   	struct exynos_adc_data	*data;
> -	struct device		*dev;
>   	struct input_dev	*input;
>   	void __iomem		*regs;
>   	struct regmap		*pmu_map;
> @@ -173,11 +172,12 @@ static void exynos_adc_unprepare_clk(struct exynos_adc *info)
>   
>   static int exynos_adc_prepare_clk(struct exynos_adc *info)
>   {
> +	struct device *dev = regmap_get_device(info->pmu_map);
>   	int ret;
>   
>   	ret = clk_prepare(info->clk);
>   	if (ret) {
> -		dev_err(info->dev, "failed preparing adc clock: %d\n", ret);
> +		dev_err(dev, "failed preparing adc clock: %d\n", ret);
>   		return ret;
>   	}
>   
> @@ -185,7 +185,7 @@ static int exynos_adc_prepare_clk(struct exynos_adc *info)
>   		ret = clk_prepare(info->sclk);
>   		if (ret) {
>   			clk_unprepare(info->clk);
> -			dev_err(info->dev,
> +			dev_err(dev,
>   				"failed preparing sclk_adc clock: %d\n", ret);
>   			return ret;
>   		}
> @@ -203,11 +203,12 @@ static void exynos_adc_disable_clk(struct exynos_adc *info)
>   
>   static int exynos_adc_enable_clk(struct exynos_adc *info)
>   {
> +	struct device *dev = regmap_get_device(info->pmu_map);
>   	int ret;
>   
>   	ret = clk_enable(info->clk);
>   	if (ret) {
> -		dev_err(info->dev, "failed enabling adc clock: %d\n", ret);
> +		dev_err(dev, "failed enabling adc clock: %d\n", ret);
>   		return ret;
>   	}
>   
> @@ -215,7 +216,7 @@ static int exynos_adc_enable_clk(struct exynos_adc *info)
>   		ret = clk_enable(info->sclk);
>   		if (ret) {
>   			clk_disable(info->clk);
> -			dev_err(info->dev,
> +			dev_err(dev,
>   				"failed enabling sclk_adc clock: %d\n", ret);
>   			return ret;
>   		}
> @@ -610,13 +611,14 @@ static irqreturn_t exynos_adc_isr(int irq, void *dev_id)
>   static irqreturn_t exynos_ts_isr(int irq, void *dev_id)
>   {
>   	struct exynos_adc *info = dev_id;
> -	struct iio_dev *dev = dev_get_drvdata(info->dev);
> +	struct device *dev = regmap_get_device(info->pmu_map);
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>   	u32 x, y;
>   	bool pressed;
>   	int ret;
>   
>   	while (info->input->users) {
> -		ret = exynos_read_s3c64xx_ts(dev, &x, &y);
> +		ret = exynos_read_s3c64xx_ts(indio_dev, &x, &y);
>   		if (ret == -ETIMEDOUT)
>   			break;
>   
> @@ -800,8 +802,6 @@ static int exynos_adc_probe(struct platform_device *pdev)
>   
>   	info->tsirq = irq;
>   
> -	info->dev = &pdev->dev;
> -
>   	init_completion(&info->completion);
>   
>   	info->clk = devm_clk_get(&pdev->dev, "adc");

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

