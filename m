Return-Path: <lars@metafoo.de>
Message-ID: <501F8509.1030903@metafoo.de>
Date: Mon, 06 Aug 2012 10:49:13 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Marek Vasut <marex@denx.de>
CC: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jonathan Cameron <jic23@kernel.org>,
 Juergen Beisert <jbe@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>,
 Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 2/3 V2] IIO: Add basic MXS LRADC driver
References: <1344007721-11595-1-git-send-email-marex@denx.de> <1344007721-11595-3-git-send-email-marex@denx.de>
In-Reply-To: <1344007721-11595-3-git-send-email-marex@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 08/03/2012 05:28 PM, Marek Vasut wrote:
> This driver is very basic. It supports userland trigger, buffer and
> raw access to channels. The support for delay channels is missing
> altogether.

Looks mostly good to me. Some comments inline.

I think you need to provide a documentation for the devicetree binding, even
though it's a rather simple binding.

> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Juergen Beisert <jbe@pengutronix.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Wolfgang Denk <wd@denx.de>
> ---
>  drivers/staging/iio/adc/Kconfig     |   12 +
>  drivers/staging/iio/adc/Makefile    |    1 +
>  drivers/staging/iio/adc/mxs-lradc.c |  591 +++++++++++++++++++++++++++++++++++
>  3 files changed, 604 insertions(+)
>  create mode 100644 drivers/staging/iio/adc/mxs-lradc.c
> 
> V2: Use delay channel 0 in case of buffered sampling so the samples are deployed
>     continuously.
>     Disallow RAW sampling while buffered mode is enabled to simplify code.
> 
> diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
> index 67711b7..97ca697 100644
> --- a/drivers/staging/iio/adc/Kconfig
> +++ b/drivers/staging/iio/adc/Kconfig
[...]
> + */
> +static int mxs_lradc_read_raw(struct iio_dev *iio_dev,
> +			const struct iio_chan_spec *chan,
> +			int *val, int *val2, long m)
> +{
> [...]
> +
> +	init_completion(&lradc->completion);

This should rather be INIT_COMPLETION. init_completion should only called
once in probe, since it will reinitialize the spinlock which opens up race
conditions.

> [...]
> +
> +	/* Wait for completion on the channel, 1 second max. */
> +	ret = wait_for_completion_killable_timeout(&lradc->completion,
> +						msecs_to_jiffies(1000));

msecs_to_jiffies(1000) = HZ, but I guess both is OK.

> [...]
> +}
[...]
> +
> +static int __devinit mxs_lradc_probe(struct platform_device *pdev)
> +{
> [...]
> +
> +	/* Grab all IRQ sources */
> +	for (i = 0; i < 13; i++) {
> +		lradc->irq[i] = platform_get_irq(pdev, i);
> +		if (lradc->irq[i] < 0) {
> +			ret = -EINVAL;
> +			goto err_addr;
> +		}
> +
> +		ret = devm_request_irq(dev, lradc->irq[i],
> +					mxs_lradc_handle_irq, 0,
> +					mxs_lradc_irq_name[i], iio);

devm_request_irq is a bit dangerous as long we do not have a
devm_iio_device_alloc. The IRQ will only be freed after the memory for the
IIO device has been freed, which means there is a slight window where the
IRQ could fire although the memory has already been freed.

> +		if (ret)
> +			goto err_addr;
> +	}
> +
> +	dev_set_drvdata(&pdev->dev, iio);

platform_set_drvdata

> +
> +	init_completion(&lradc->completion);
> +	mutex_init(&lradc->lock);
> +

[...]
