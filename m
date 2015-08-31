Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37946 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753532AbbHaPNr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 31 Aug 2015 11:13:47 -0400
Subject: Re: [PATCH] staging: iio: adc: lpc32xx: use correct reutrn value
To: Peng Fan <van.freenix@gmail.com>, gregkh@linuxfoundation.org
References: <1440922377-16938-1-git-send-email-van.freenix@gmail.com>
Cc: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tapasweni Pathak <tapaswenipathak@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55E46F28.6010904@kernel.org>
Date: Mon, 31 Aug 2015 16:13:44 +0100
MIME-Version: 1.0
In-Reply-To: <1440922377-16938-1-git-send-email-van.freenix@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/08/15 09:12, Peng Fan wrote:
> To lpc32xx_adc driver, when platform_get_resource or
> platform_get_irq failed, we should use -ENXIO as a
> return value, but not -EBUSY.
> 
> Signed-off-by: Peng Fan <van.freenix@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Tapasweni Pathak <tapaswenipathak@gmail.com>
Applied to the togreg branch of iio.git - initially pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/adc/lpc32xx_adc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/lpc32xx_adc.c b/drivers/staging/iio/adc/lpc32xx_adc.c
> index 5331c44..bcf4ebb 100644
> --- a/drivers/staging/iio/adc/lpc32xx_adc.c
> +++ b/drivers/staging/iio/adc/lpc32xx_adc.c
> @@ -137,7 +137,7 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!res) {
>  		dev_err(&pdev->dev, "failed to get platform I/O memory\n");
> -		return -EBUSY;
> +		return -ENXIO;
>  	}
>  
>  	iodev = devm_iio_device_alloc(&pdev->dev, sizeof(*info));
> @@ -162,7 +162,7 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq <= 0) {
>  		dev_err(&pdev->dev, "failed getting interrupt resource\n");
> -		return -EINVAL;
> +		return -ENXIO;
>  	}
>  
>  	retval = devm_request_irq(&pdev->dev, irq, lpc32xx_adc_isr, 0,
> 

