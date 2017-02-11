Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45452 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753232AbdBKLVN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Feb 2017 06:21:13 -0500
Subject: Re: [PATCH 2/3] staging:iio:adc:lpc32xx rename local state structure
 to _state
To: linux-iio@vger.kernel.org
References: <20170205130700.5063-1-jic23@kernel.org>
 <20170205130700.5063-3-jic23@kernel.org>
Cc: Roland Stigge <stigge@antcom.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <37ebc3c1-2964-487e-7a17-3c03fb0b3e6b@kernel.org>
Date: Sat, 11 Feb 2017 11:21:12 +0000
MIME-Version: 1.0
In-Reply-To: <20170205130700.5063-3-jic23@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/02/17 13:06, Jonathan Cameron wrote:
> Previously it was called _info with instances as info.  This caused some
> confusion against the info structure that are used in the core of IIO.
> 
> Since this driver was written it's become a fairly strong convention to
> use _state and st for instances so change to that.
> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/adc/lpc32xx_adc.c | 46 +++++++++++++++++------------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/lpc32xx_adc.c b/drivers/staging/iio/adc/lpc32xx_adc.c
> index 5d13ff008a39..0de709b4288b 100644
> --- a/drivers/staging/iio/adc/lpc32xx_adc.c
> +++ b/drivers/staging/iio/adc/lpc32xx_adc.c
> @@ -61,7 +61,7 @@
>  
>  #define LPC32XXAD_NAME "lpc32xx-adc"
>  
> -struct lpc32xx_adc_info {
> +struct lpc32xx_adc_state {
>  	void __iomem *adc_base;
>  	struct clk *clk;
>  	struct completion completion;
> @@ -75,21 +75,21 @@ static int lpc32xx_read_raw(struct iio_dev *indio_dev,
>  			    int *val2,
>  			    long mask)
>  {
> -	struct lpc32xx_adc_info *info = iio_priv(indio_dev);
> +	struct lpc32xx_adc_state *st = iio_priv(indio_dev);
>  
>  	if (mask == IIO_CHAN_INFO_RAW) {
>  		mutex_lock(&indio_dev->mlock);
> -		clk_prepare_enable(info->clk);
> +		clk_prepare_enable(st->clk);
>  		/* Measurement setup */
>  		__raw_writel(LPC32XXAD_INTERNAL | (chan->address) |
>  			     LPC32XXAD_REFp | LPC32XXAD_REFm,
> -			     LPC32XXAD_SELECT(info->adc_base));
> +			     LPC32XXAD_SELECT(st->adc_base));
>  		/* Trigger conversion */
>  		__raw_writel(LPC32XXAD_PDN_CTRL | LPC32XXAD_STROBE,
> -			     LPC32XXAD_CTRL(info->adc_base));
> -		wait_for_completion(&info->completion); /* set by ISR */
> -		clk_disable_unprepare(info->clk);
> -		*val = info->value;
> +			     LPC32XXAD_CTRL(st->adc_base));
> +		wait_for_completion(&st->completion); /* set by ISR */
> +		clk_disable_unprepare(st->clk);
> +		*val = st->value;
>  		mutex_unlock(&indio_dev->mlock);
>  
>  		return IIO_VAL_INT;
> @@ -120,19 +120,19 @@ static const struct iio_chan_spec lpc32xx_adc_iio_channels[] = {
>  
>  static irqreturn_t lpc32xx_adc_isr(int irq, void *dev_id)
>  {
> -	struct lpc32xx_adc_info *info = dev_id;
> +	struct lpc32xx_adc_state *st = dev_id;
>  
>  	/* Read value and clear irq */
> -	info->value = __raw_readl(LPC32XXAD_VALUE(info->adc_base)) &
> -				LPC32XXAD_VALUE_MASK;
> -	complete(&info->completion);
> +	st->value = __raw_readl(LPC32XXAD_VALUE(st->adc_base)) &
> +		LPC32XXAD_VALUE_MASK;
> +	complete(&st->completion);
>  
>  	return IRQ_HANDLED;
>  }
>  
>  static int lpc32xx_adc_probe(struct platform_device *pdev)
>  {
> -	struct lpc32xx_adc_info *info = NULL;
> +	struct lpc32xx_adc_state *st = NULL;
>  	struct resource *res;
>  	int retval = -ENODEV;
>  	struct iio_dev *iodev = NULL;
> @@ -144,23 +144,23 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
>  		return -ENXIO;
>  	}
>  
> -	iodev = devm_iio_device_alloc(&pdev->dev, sizeof(*info));
> +	iodev = devm_iio_device_alloc(&pdev->dev, sizeof(*st));
>  	if (!iodev)
>  		return -ENOMEM;
>  
> -	info = iio_priv(iodev);
> +	st = iio_priv(iodev);
>  
> -	info->adc_base = devm_ioremap(&pdev->dev, res->start,
> -						resource_size(res));
> -	if (!info->adc_base) {
> +	st->adc_base = devm_ioremap(&pdev->dev, res->start,
> +				    resource_size(res));
> +	if (!st->adc_base) {
>  		dev_err(&pdev->dev, "failed mapping memory\n");
>  		return -EBUSY;
>  	}
>  
> -	info->clk = devm_clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(info->clk)) {
> +	st->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(st->clk)) {
>  		dev_err(&pdev->dev, "failed getting clock\n");
> -		return PTR_ERR(info->clk);
> +		return PTR_ERR(st->clk);
>  	}
>  
>  	irq = platform_get_irq(pdev, 0);
> @@ -170,7 +170,7 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
>  	}
>  
>  	retval = devm_request_irq(&pdev->dev, irq, lpc32xx_adc_isr, 0,
> -				  LPC32XXAD_NAME, info);
> +				  LPC32XXAD_NAME, st);
>  	if (retval < 0) {
>  		dev_err(&pdev->dev, "failed requesting interrupt\n");
>  		return retval;
> @@ -178,7 +178,7 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, iodev);
>  
> -	init_completion(&info->completion);
> +	init_completion(&st->completion);
>  
>  	iodev->name = LPC32XXAD_NAME;
>  	iodev->dev.parent = &pdev->dev;
> 

