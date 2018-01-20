Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754913AbeATQnu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Jan 2018 11:43:50 -0500
Date: Sat, 20 Jan 2018 16:43:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH -next] iio: ep93xx: remove redundant return value check
 of platform_get_resource()
Message-ID: <20180120164346.4813b6ca@archlinux>
In-Reply-To: <1516188600-170557-1-git-send-email-weiyongjun1@huawei.com>
References: <1516188600-170557-1-git-send-email-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 17 Jan 2018 11:30:00 +0000
Wei Yongjun <weiyongjun1@huawei.com> wrote:

> Remove unneeded error handling on the result of a call
> to platform_get_resource() when the value is passed to
> devm_ioremap_resource().
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ep93xx_adc.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ep93xx_adc.c b/drivers/iio/adc/ep93xx_adc.c
> index 81c9015..5036c392 100644
> --- a/drivers/iio/adc/ep93xx_adc.c
> +++ b/drivers/iio/adc/ep93xx_adc.c
> @@ -167,10 +167,6 @@ static int ep93xx_adc_probe(struct platform_device *pdev)
>  	priv = iio_priv(iiodev);
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res) {
> -		dev_err(&pdev->dev, "Cannot obtain memory resource\n");
> -		return -ENXIO;
> -	}
>  	priv->base = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(priv->base)) {
>  		dev_err(&pdev->dev, "Cannot map memory resource\n");
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

