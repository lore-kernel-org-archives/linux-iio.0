Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57952 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1949172AbdDZFXi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Apr 2017 01:23:38 -0400
Subject: Re: [PATCH -next] iio: adc: mxs-lradc: Fix return value check in
 mxs_lradc_adc_probe()
To: Wei Yongjun <weiyj.lk@gmail.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, Marek Vasut <marex@denx.de>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
References: <20170425033612.27251-1-weiyj.lk@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <bff84930-f0d3-fb7f-cdd4-fd1a970ce6b6@kernel.org>
Date: Wed, 26 Apr 2017 06:23:32 +0100
MIME-Version: 1.0
In-Reply-To: <20170425033612.27251-1-weiyj.lk@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/04/17 04:36, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> In case of error, the function devm_ioremap() returns NULL pointer
> not ERR_PTR(). The IS_ERR() test in the return value check should
> be replaced with NULL test.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>

Lee, do you want to pick this up?  If not I'll scoop it up after the merge
window has unwound as a fix.  Needs to be on top of the series:
[PATCH v15 0/5] mxs-lradc: Split driver into MFD

Thanks,

Jonathan
> ---
>  drivers/iio/adc/mxs-lradc-adc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
> index b0c7d8e..493e2a2 100644
> --- a/drivers/iio/adc/mxs-lradc-adc.c
> +++ b/drivers/iio/adc/mxs-lradc-adc.c
> @@ -719,8 +719,8 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
>  
>  	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	adc->base = devm_ioremap(dev, iores->start, resource_size(iores));
> -	if (IS_ERR(adc->base))
> -		return PTR_ERR(adc->base);
> +	if (!adc->base)
> +		return -ENOMEM;
>  
>  	init_completion(&adc->completion);
>  	spin_lock_init(&adc->lock);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

