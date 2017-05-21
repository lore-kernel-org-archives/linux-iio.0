Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37101 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753357AbdEUMMk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 May 2017 08:12:40 -0400
Subject: Re: [PATCH -next v3] iio: adc: mxs-lradc: Fix return value check in
 mxs_lradc_adc_probe()
To: Wei Yongjun <weiyj.lk@gmail.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, Marek Vasut <marex@denx.de>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
References: <20170427151413.23843-1-weiyj.lk@gmail.com>
 <20170516152612.19090-1-weiyj.lk@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <e7789db6-27f3-0da7-cacb-bdc2b98a5e02@kernel.org>
Date: Sun, 21 May 2017 13:12:37 +0100
MIME-Version: 1.0
In-Reply-To: <20170516152612.19090-1-weiyj.lk@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/05/17 16:26, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> In case of error, the function devm_ioremap() returns NULL pointer
> not ERR_PTR(). The IS_ERR() test in the return value check should
> be replaced with NULL test. Also add NULL test for iores.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Hi Wei,

At the moment I haven't yet sent a pull request to Greg since the
merge window closed.  Up shot is that I don't have the current version
of this code in my tree just yet.  That should be sorted in the
next week or so.  Please remind me if it looks like I have forgotten
this patch.

Thanks,

Jonathan
> ---
> v2 -> v3: use NULL test instead of devm_ioremap_resource()
> ---
>   drivers/iio/adc/mxs-lradc-adc.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
> index b0c7d8e..6888167 100644
> --- a/drivers/iio/adc/mxs-lradc-adc.c
> +++ b/drivers/iio/adc/mxs-lradc-adc.c
> @@ -718,9 +718,12 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
>   	adc->dev = dev;
>   
>   	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!iores)
> +		return -EINVAL;
> +
>   	adc->base = devm_ioremap(dev, iores->start, resource_size(iores));
> -	if (IS_ERR(adc->base))
> -		return PTR_ERR(adc->base);
> +	if (!adc->base)
> +		return -ENOMEM;
>   
>   	init_completion(&adc->completion);
>   	spin_lock_init(&adc->lock);
> 

