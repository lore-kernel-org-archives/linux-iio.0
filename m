Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbeIYCTS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 24 Sep 2018 22:19:18 -0400
Date: Mon, 24 Sep 2018 21:15:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-iio@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Subject: Re: [PATCH 2/3] iio: adc: meson-saradc: use
 of_device_get_match_data
Message-ID: <20180924211520.2e26a4e0@archlinux>
In-Reply-To: <20180922222102.12023-3-martin.blumenstingl@googlemail.com>
References: <20180922222102.12023-1-martin.blumenstingl@googlemail.com>
        <20180922222102.12023-3-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 23 Sep 2018 00:21:01 +0200
Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> This simplifies our _probe function by using of_device_get_match_data
> instead of open-coding it. No functional changes.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/meson_saradc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index b97b06bf7713..9d8f2139debc 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -978,11 +978,11 @@ MODULE_DEVICE_TABLE(of, meson_sar_adc_of_match);
>  
>  static int meson_sar_adc_probe(struct platform_device *pdev)
>  {
> +	const struct meson_sar_adc_data *match_data;
>  	struct meson_sar_adc_priv *priv;
>  	struct iio_dev *indio_dev;
>  	struct resource *res;
>  	void __iomem *base;
> -	const struct of_device_id *match;
>  	int irq, ret;
>  
>  	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
> @@ -994,13 +994,13 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
>  	priv = iio_priv(indio_dev);
>  	init_completion(&priv->done);
>  
> -	match = of_match_device(meson_sar_adc_of_match, &pdev->dev);
> -	if (!match) {
> -		dev_err(&pdev->dev, "failed to match device\n");
> +	match_data = of_device_get_match_data(&pdev->dev);
> +	if (!match_data) {
> +		dev_err(&pdev->dev, "failed to get match data\n");
>  		return -ENODEV;
>  	}
>  
> -	priv->data = match->data;
> +	priv->data = match_data;
>  
>  	indio_dev->name = priv->data->name;
>  	indio_dev->dev.parent = &pdev->dev;
