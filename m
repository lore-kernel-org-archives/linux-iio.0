Return-Path: <lars@metafoo.de>
Message-ID: <5408983D.30002@metafoo.de>
Date: Thu, 04 Sep 2014 18:50:05 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "open list:STAGING - INDUSTR..." <linux-iio@vger.kernel.org>,
 open list:STAGING SUBSYSTEM <devel@driverdev.osuosl.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: iio: adc: mxs-lradc.c: sparse warning of incorrect
 type
References: <1409849142-12185-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1409849142-12185-1-git-send-email-sudipm.mukherjee@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 09/04/2014 06:45 PM, Sudip Mukherjee wrote:
> fixed sparse warning : incorrect type in argument 1
> 		       (different address spaces)
>
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---
>   drivers/staging/iio/adc/mxs-lradc.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
> index 468327f..d8d1fe1 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -1545,9 +1545,12 @@ static int mxs_lradc_probe(struct platform_device *pdev)
>   	/* Grab the memory area */
>   	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   	lradc->dev = &pdev->dev;
> -	lradc->base = devm_ioremap_resource(dev, iores);
> -	if (IS_ERR(lradc->base))
> -		return PTR_ERR(lradc->base);
> +	void *tempptr;
> +
> +	tempptr = devm_ioremap_resource(dev, iores);
> +	if (IS_ERR(tempptr))
> +		return PTR_ERR(tempptr);
> +	lradc->base = tempptr;

This makes no sense at all... devm_ioremap_resource() returns a iomem 
pointer lrdac->base is a iomem pointer.

Please make sure that you have the latest version of sparse installed on 
your system.

>
>   	lradc->clk = devm_clk_get(&pdev->dev, NULL);
>   	if (IS_ERR(lradc->clk)) {
>
