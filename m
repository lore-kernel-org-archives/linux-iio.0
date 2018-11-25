Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727471AbeKYVeM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Nov 2018 16:34:12 -0500
Date: Sun, 25 Nov 2018 10:43:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iio: adc: meson-saradc: fix internal clock names
Message-ID: <20181125104320.06d65625@archlinux>
In-Reply-To: <20181122220111.28808-2-martin.blumenstingl@googlemail.com>
References: <20181122220111.28808-1-martin.blumenstingl@googlemail.com>
        <20181122220111.28808-2-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 22 Nov 2018 23:01:11 +0100
Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> Before this patch we are registering the internal clocks (for example on
> Meson8b, where the SAR ADC IP block implements the divider and gate
> clocks) with the following names:
> - /soc/cbus@c1100000/adc@8680#adc_div
> - /soc/cbus@c1100000/adc@8680#adc_en
> 
> This is bad because the common clock framework uses the clock to create
> a directory in <debugfs>/clk. With such name, the directory creation
> (silently) fails and the debugfs entry ends up being created at the
> debugfs root.
> 
> With this change, the new clock names are:
> - c1108680.adc#adc_div
> - c1108680.adc#adc_en
> 
> This matches the clock naming scheme used in the PWM, Ethernet and MMC
> drivers. It also fixes the problem with debugfs.
> The idea is shamelessly taken from commit b96e9eb62841c5 ("pwm: meson:
> Fix mux clock names").
> 
> Fixes: 3921db46a8c5bc ("iio: Convert to using %pOF instead of full_name")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
As this is debugfs I am not going to push this through the fast path.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/meson_saradc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index 6155d26091eb..729becb2d3d9 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -656,8 +656,8 @@ static int meson_sar_adc_clk_init(struct iio_dev *indio_dev,
>  	struct clk_init_data init;
>  	const char *clk_parents[1];
>  
> -	init.name = devm_kasprintf(&indio_dev->dev, GFP_KERNEL, "%pOF#adc_div",
> -				   indio_dev->dev.of_node);
> +	init.name = devm_kasprintf(&indio_dev->dev, GFP_KERNEL, "%s#adc_div",
> +				   dev_name(indio_dev->dev.parent));
>  	if (!init.name)
>  		return -ENOMEM;
>  
> @@ -678,8 +678,8 @@ static int meson_sar_adc_clk_init(struct iio_dev *indio_dev,
>  	if (WARN_ON(IS_ERR(priv->adc_div_clk)))
>  		return PTR_ERR(priv->adc_div_clk);
>  
> -	init.name = devm_kasprintf(&indio_dev->dev, GFP_KERNEL, "%pOF#adc_en",
> -				   indio_dev->dev.of_node);
> +	init.name = devm_kasprintf(&indio_dev->dev, GFP_KERNEL, "%s#adc_en",
> +				   dev_name(indio_dev->dev.parent));
>  	if (!init.name)
>  		return -ENOMEM;
>  
