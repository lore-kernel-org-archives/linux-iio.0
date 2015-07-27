Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:41236 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750940AbbG0HtL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jul 2015 03:49:11 -0400
Date: Mon, 27 Jul 2015 09:49:09 +0200
From: Antoine Tenart <antoine.tenart@free-electrons.com>
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: Re: [PATCH 5/8] iio:adc:berlin2-adc: use short operator format
Message-ID: <20150727074909.GE16683@kwain>
References: <cover.1437862404.git.knaack.h@gmx.de>
 <815876954eaf0f9e3556756001679becaabd9570.1437862404.git.knaack.h@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <815876954eaf0f9e3556756001679becaabd9570.1437862404.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Jul 26, 2015 at 12:43:23AM +0200, Hartmut Knaack wrote:
> Use augmented assignment to subtract the offset for negative temperature
> values.
> Specify the amount of private data to be allocated through
> devm_iio_device_alloc() with sizeof(*priv), as it is shorter and common
> practice in IIO.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>

Acked-by: Antoine Tenart <antoine.tenart@free-electrons.com>

> ---
>  drivers/iio/adc/berlin2-adc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/berlin2-adc.c b/drivers/iio/adc/berlin2-adc.c
> index b7df94a0b879..1d14290ba6f2 100644
> --- a/drivers/iio/adc/berlin2-adc.c
> +++ b/drivers/iio/adc/berlin2-adc.c
> @@ -221,7 +221,7 @@ static int berlin2_adc_read_raw(struct iio_dev *indio_dev,
>  			return temp;
>  
>  		if (temp > 2047)
> -			temp = -(4096 - temp);
> +			temp -= 4096;
>  
>  		/* Convert to milli Celsius */
>  		*val = ((temp * 100000) / 264 - 270000);
> @@ -286,8 +286,7 @@ static int berlin2_adc_probe(struct platform_device *pdev)
>  	int irq, tsen_irq;
>  	int ret;
>  
> -	indio_dev = devm_iio_device_alloc(&pdev->dev,
> -					  sizeof(struct berlin2_adc_priv));
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> -- 
> 2.4.3
> 

-- 
Antoine Ténart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
