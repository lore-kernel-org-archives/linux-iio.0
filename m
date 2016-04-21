Return-Path: <dmitry.torokhov@gmail.com>
Date: Thu, 21 Apr 2016 14:08:10 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Marek Vasut <marex@denx.de>, Fabio Estevam <fabio.estevam@nxp.com>,
	Juergen Borleis <jbe@pengutronix.de>, linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFT V2 3/3] iio: mxs-lradc: implement suspend/resume
 support
Message-ID: <20160421210810.GC25466@dtor-ws>
References: <1461269478-449-1-git-send-email-stefan.wahren@i2se.com>
 <1461269478-449-4-git-send-email-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461269478-449-4-git-send-email-stefan.wahren@i2se.com>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Apr 21, 2016 at 08:11:18PM +0000, Stefan Wahren wrote:
> This patch implements suspend/resume support for mxs-lradc.
> It's possible to use the touchscreen as wakeup source.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  drivers/iio/adc/mxs-lradc.c |   61 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/drivers/iio/adc/mxs-lradc.c b/drivers/iio/adc/mxs-lradc.c
> index cfc558f..6bd387f 100644
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

I'd rather we had it right after we do:

			ret = enable_irq_wake(lradc->irq[0]);

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

Do we need to fail resume if this call fails?

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
> -- 
> 1.7.9.5
> 

Thanks.

-- 
Dmitry
