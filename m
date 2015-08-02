Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45629 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbbHBSIX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Aug 2015 14:08:23 -0400
Subject: Re: [PATCH v2 5/8] iio:adc:berlin2-adc: use short operator format
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
References: <cover.1438035998.git.knaack.h@gmx.de>
 <ab3f7c3acc465923db3d32cd632547570ab09553.1438035998.git.knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Antoine Tenart <antoine.tenart@free-electrons.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55BE5C96.1010608@kernel.org>
Date: Sun, 2 Aug 2015 19:08:22 +0100
MIME-Version: 1.0
In-Reply-To: <ab3f7c3acc465923db3d32cd632547570ab09553.1438035998.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/07/15 23:39, Hartmut Knaack wrote:
> Use augmented assignment to subtract the offset for negative temperature
> values.
> Specify the amount of private data to be allocated through
> devm_iio_device_alloc() with sizeof(*priv), as it is shorter and common
> practice in IIO.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
> Acked-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Applied.
> ---
>  drivers/iio/adc/berlin2-adc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/berlin2-adc.c b/drivers/iio/adc/berlin2-adc.c
> index 745061091bd3..1e1d618ce152 100644
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
> 

