Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53047 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571AbcDQKs3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 Apr 2016 06:48:29 -0400
Subject: Re: [PATCH RFT 5/5] iio: mxs-lradc: implement suspend/resume support
To: Stefan Wahren <stefan.wahren@i2se.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Marek Vasut <marex@denx.de>
References: <1460648909-2657-1-git-send-email-stefan.wahren@i2se.com>
 <1460648909-2657-6-git-send-email-stefan.wahren@i2se.com>
Cc: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Juergen Borleis <jbe@pengutronix.de>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <571369FB.8010803@kernel.org>
Date: Sun, 17 Apr 2016 11:48:27 +0100
MIME-Version: 1.0
In-Reply-To: <1460648909-2657-6-git-send-email-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/04/16 16:48, Stefan Wahren wrote:
> This patch implements suspend/resume support for mxs-lradc.
> It's possible to use the touchscreen as wakeup source.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Looks good to me pending replies to the previous patch comments.
> ---
>  drivers/iio/adc/mxs-lradc.c |   61 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/drivers/iio/adc/mxs-lradc.c b/drivers/iio/adc/mxs-lradc.c
> index 97c993f..64704c9 100644
> --- a/drivers/iio/adc/mxs-lradc.c
> +++ b/drivers/iio/adc/mxs-lradc.c
> @@ -29,6 +29,7 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm.h>
>  #include <linux/slab.h>
>  #include <linux/stmp_device.h>
>  #include <linux/sysfs.h>
> @@ -1745,10 +1746,70 @@ static int mxs_lradc_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static int __maybe_unused mxs_lradc_suspend(struct device *dev)
> +{
> +	struct iio_dev *iio = dev_get_drvdata(dev);
> +	struct mxs_lradc *lradc = iio_priv(iio);
> +	struct input_dev *input = lradc->ts_input;
> +	int ret = 0;
> +
> +	if (input) {
> +		mutex_lock(&input->mutex);
> +
> +		/* Enable touchscreen wakeup irq */
> +		if (input->users && device_may_wakeup(dev))
> +			ret = enable_irq_wake(lradc->irq[0]);
> +		else
> +			mxs_lradc_disable_ts(lradc);
> +
> +		mutex_unlock(&input->mutex);
> +	}
> +
> +	if (ret)
> +		return ret;
> +
> +	mxs_lradc_hw_stop(lradc);
> +
> +	clk_disable_unprepare(lradc->clk);
> +
> +	return ret;
> +}
> +
> +static int __maybe_unused mxs_lradc_resume(struct device *dev)
> +{
> +	struct iio_dev *iio = dev_get_drvdata(dev);
> +	struct mxs_lradc *lradc = iio_priv(iio);
> +	struct input_dev *input = lradc->ts_input;
> +	int ret;
> +
> +	ret = clk_prepare_enable(lradc->clk);
> +	if (ret)
> +		return ret;
> +
> +	mxs_lradc_hw_init(lradc);
> +
> +	if (input) {
> +		mutex_lock(&input->mutex);
> +
> +		/* Disable touchscreen wakeup irq */
> +		if (input->users && device_may_wakeup(dev))
> +			ret = disable_irq_wake(lradc->irq[0]);
> +		else
> +			mxs_lradc_enable_touch_detection(lradc);
> +
> +		mutex_unlock(&input->mutex);
> +	}
> +
> +	return ret;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(mxs_lradc_pm_ops, mxs_lradc_suspend, mxs_lradc_resume);
> +
>  static struct platform_driver mxs_lradc_driver = {
>  	.driver	= {
>  		.name	= DRIVER_NAME,
>  		.of_match_table = mxs_lradc_dt_ids,
> +		.pm	= &mxs_lradc_pm_ops,
>  	},
>  	.probe	= mxs_lradc_probe,
>  	.remove	= mxs_lradc_remove,
> 

