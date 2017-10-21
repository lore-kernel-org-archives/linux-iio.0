Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932179AbdJURtG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Oct 2017 13:49:06 -0400
Date: Sat, 21 Oct 2017 18:49:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, maxime.ripard@free-electrons.com,
        wens@csie.org, pmeerw@pmeerw.net,
        quentin.schulz@free-electrons.com, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: sun4i-gpadc: use of_device_get_match_data
Message-ID: <20171021184900.7e3e42d0@archlinux>
In-Reply-To: <20171020053729.23248-1-clabbe.montjoie@gmail.com>
References: <20171020053729.23248-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 20 Oct 2017 07:37:29 +0200
Corentin Labbe <clabbe.montjoie@gmail.com> wrote:

> The usage of of_device_get_match_data reduce the code size a bit.
> Furthermore, it prevents an improbable dereference when
> of_match_device() return NULL.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Nice little tidy up - thanks.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/sun4i-gpadc-iio.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
> index c4e70f1cad79..04d7147e0110 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -501,17 +501,15 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
>  				struct iio_dev *indio_dev)
>  {
>  	struct sun4i_gpadc_iio *info = iio_priv(indio_dev);
> -	const struct of_device_id *of_dev;
>  	struct resource *mem;
>  	void __iomem *base;
>  	int ret;
>  
> -	of_dev = of_match_device(sun4i_gpadc_of_id, &pdev->dev);
> -	if (!of_dev)
> +	info->data = of_device_get_match_data(&pdev->dev);
> +	if (!info->data)
>  		return -ENODEV;
>  
>  	info->no_irq = true;
> -	info->data = (struct gpadc_data *)of_dev->data;
>  	indio_dev->num_channels = ARRAY_SIZE(sun8i_a33_gpadc_channels);
>  	indio_dev->channels = sun8i_a33_gpadc_channels;
>  

