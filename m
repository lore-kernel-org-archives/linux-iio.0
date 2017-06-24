Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751482AbdFXUAu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Jun 2017 16:00:50 -0400
Date: Sat, 24 Jun 2017 21:00:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc: <robh+dt@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <srv_heupstream@mediatek.com>,
        <liguo.zhang@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <sean.wang@mediatek.com>, <matthias.bgg@gmail.com>,
        <s.hauer@pengutronix.de>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 2/3] iio: adc: mt7622: add support for suspend/resume.
Message-ID: <20170624210043.29569f3a@kernel.org>
In-Reply-To: <1498110274-18678-3-git-send-email-zhiyong.tao@mediatek.com>
References: <1498110274-18678-1-git-send-email-zhiyong.tao@mediatek.com>
        <1498110274-18678-3-git-send-email-zhiyong.tao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 22 Jun 2017 13:44:33 +0800
Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:

> This patch supports auxadc suspend/resume flow.
> Disable auxadc clk and power in suspend function.
> Enable axuadc clk and power in resume function.
> 
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
Worth handling the cases where power management is not configured into the
kernel properly.

So a few minor suggestions.  Otherwise looks good to me.
> ---
>  drivers/iio/adc/mt6577_auxadc.c |   37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
> index 2d104c8..2dd7c74 100644
> --- a/drivers/iio/adc/mt6577_auxadc.c
> +++ b/drivers/iio/adc/mt6577_auxadc.c
> @@ -184,6 +184,37 @@ static int mt6577_auxadc_read_raw(struct iio_dev *indio_dev,
>  	.read_raw = &mt6577_auxadc_read_raw,
>  };
>  
> +static int mt6577_auxadc_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct mt6577_auxadc_device *adc_dev = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = clk_prepare_enable(adc_dev->adc_clk);
> +	if (ret) {
> +		pr_err("failed to enable auxadc clock\n");
> +		return ret;
> +	}
> +
> +	mt6577_auxadc_mod_reg(adc_dev->reg_base + MT6577_AUXADC_MISC,
> +			      MT6577_AUXADC_PDN_EN, 0);
> +	mdelay(MT6577_AUXADC_POWER_READY_MS);
> +
> +	return 0;
> +}
> +
> +static int mt6577_auxadc_suspend(struct device *dev)
Mark these __maybe_unused for the CONFIG_PM but not CONFIG_PM_SLEEP case.
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct mt6577_auxadc_device *adc_dev = iio_priv(indio_dev);
> +
> +	mt6577_auxadc_mod_reg(adc_dev->reg_base + MT6577_AUXADC_MISC,
> +			      0, MT6577_AUXADC_PDN_EN);
> +	clk_disable_unprepare(adc_dev->adc_clk);
> +
> +	return 0;
> +}
> +
>  static int mt6577_auxadc_probe(struct platform_device *pdev)
>  {
>  	struct mt6577_auxadc_device *adc_dev;
> @@ -269,6 +300,11 @@ static int mt6577_auxadc_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct dev_pm_ops mt6577_auxadc_pm_ops = {
> +	.suspend = mt6577_auxadc_suspend,
> +	.resume = mt6577_auxadc_resume,
> +};
> +
Use the SIMPLE_SYSTEM_PM_OPS macro to make these assignments magically go away
if PM_CONFIG_SLEEP is not defined.
>  static const struct of_device_id mt6577_auxadc_of_match[] = {
>  	{ .compatible = "mediatek,mt2701-auxadc", },
>  	{ .compatible = "mediatek,mt8173-auxadc", },
> @@ -280,6 +316,7 @@ static int mt6577_auxadc_remove(struct platform_device *pdev)
>  	.driver = {
>  		.name   = "mt6577-auxadc",
>  		.of_match_table = mt6577_auxadc_of_match,
> +		.pm = &mt6577_auxadc_pm_ops,
>  	},
>  	.probe	= mt6577_auxadc_probe,
>  	.remove	= mt6577_auxadc_remove,

