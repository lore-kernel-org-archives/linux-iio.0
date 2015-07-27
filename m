Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:41168 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750723AbbG0HqK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jul 2015 03:46:10 -0400
Date: Mon, 27 Jul 2015 09:46:08 +0200
From: Antoine Tenart <antoine.tenart@free-electrons.com>
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: Re: [PATCH 2/8] iio:adc:berlin2-adc: pass up real error code
Message-ID: <20150727074608.GB16683@kwain>
References: <cover.1437862404.git.knaack.h@gmx.de>
 <7fd11d0f250039515b90b442c9fa264cd43a0537.1437862404.git.knaack.h@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <7fd11d0f250039515b90b442c9fa264cd43a0537.1437862404.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Jul 26, 2015 at 12:43:20AM +0200, Hartmut Knaack wrote:
> Pass up the real error code returned by platform_get_irq_byname().
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>

Acked-by: Antoine Tenart <antoine.tenart@free-electrons.com>

> ---
>  drivers/iio/adc/berlin2-adc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/berlin2-adc.c b/drivers/iio/adc/berlin2-adc.c
> index 97863d1ba79a..b5a099c7bf34 100644
> --- a/drivers/iio/adc/berlin2-adc.c
> +++ b/drivers/iio/adc/berlin2-adc.c
> @@ -301,11 +301,11 @@ static int berlin2_adc_probe(struct platform_device *pdev)
>  
>  	irq = platform_get_irq_byname(pdev, "adc");
>  	if (irq < 0)
> -		return -ENODEV;
> +		return irq;
>  
>  	tsen_irq = platform_get_irq_byname(pdev, "tsen");
>  	if (tsen_irq < 0)
> -		return -ENODEV;
> +		return tsen_irq;
>  
>  	ret = devm_request_irq(&pdev->dev, irq, berlin2_adc_irq, 0,
>  			pdev->dev.driver->name, indio_dev);
> -- 
> 2.4.3
> 

-- 
Antoine Ténart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
