Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34835 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1036103AbdD3Qb7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Apr 2017 12:31:59 -0400
Subject: Re: [PATCH -next v2] iio: adc: mxs-lradc: Fix return value check in
 mxs_lradc_adc_probe()
To: Wei Yongjun <weiyj.lk@gmail.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Marek Vasut <marex@denx.de>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
References: <20170425033612.27251-1-weiyj.lk@gmail.com>
 <20170427151413.23843-1-weiyj.lk@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <1fffc4ab-8952-1252-8e84-6e9b6583dfc3@kernel.org>
Date: Sun, 30 Apr 2017 17:31:54 +0100
MIME-Version: 1.0
In-Reply-To: <20170427151413.23843-1-weiyj.lk@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/04/17 16:14, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> In case of error, the function devm_ioremap() returns NULL pointer not
> ERR_PTR(). Use devm_ioremap_resource() instead of devm_ioremap().
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
I'll be wanting a tested-by for this one.

Thanks,

Jonathan
> ---
> v1 -> v2: use devm_ioremap_resource()
> ---
>  drivers/iio/adc/mxs-lradc-adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
> index b0c7d8e..2faf65f 100644
> --- a/drivers/iio/adc/mxs-lradc-adc.c
> +++ b/drivers/iio/adc/mxs-lradc-adc.c
> @@ -718,7 +718,7 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
>  	adc->dev = dev;
>  
>  	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	adc->base = devm_ioremap(dev, iores->start, resource_size(iores));
> +	adc->base = devm_ioremap_resource(dev, iores);
>  	if (IS_ERR(adc->base))
>  		return PTR_ERR(adc->base);
> 

