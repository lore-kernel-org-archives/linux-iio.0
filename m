Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45609 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316AbbHBSGT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Aug 2015 14:06:19 -0400
Subject: Re: [PATCH v2 2/8] iio:adc:berlin2-adc: pass up real error code
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
References: <cover.1438035998.git.knaack.h@gmx.de>
 <37a921c304bd807ed57222453c1ca2bf246c9c21.1438035998.git.knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Antoine Tenart <antoine.tenart@free-electrons.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55BE5C19.80500@kernel.org>
Date: Sun, 2 Aug 2015 19:06:17 +0100
MIME-Version: 1.0
In-Reply-To: <37a921c304bd807ed57222453c1ca2bf246c9c21.1438035998.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/07/15 23:38, Hartmut Knaack wrote:
> Pass up the real error code returned by platform_get_irq_byname().
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
> Acked-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Applied to the togreg branch of iio.git.  Initially pushed out
as testing for the autobuilders to play with it.

Jonathan
> ---
>  drivers/iio/adc/berlin2-adc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/berlin2-adc.c b/drivers/iio/adc/berlin2-adc.c
> index 26fa6e6cb624..b31bcf4c7c90 100644
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
> 

