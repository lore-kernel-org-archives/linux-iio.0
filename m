Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43039 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938795AbdAHJsn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2017 04:48:43 -0500
Subject: Re: [PATCH] iio: adc: imx25-gcq: Fix module autoload
To: Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-kernel@vger.kernel.org
References: <1483361146-913-1-git-send-email-javier@osg.samsung.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Markus Pargmann <mpa@pengutronix.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lee Jones <lee.jones@linaro.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Denis Carikli <denis@eukrea.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <7184b366-f628-0c21-c459-c53e32fd4946@kernel.org>
Date: Sat, 7 Jan 2017 22:15:34 +0000
MIME-Version: 1.0
In-Reply-To: <1483361146-913-1-git-send-email-javier@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/01/17 12:45, Javier Martinez Canillas wrote:
> If the driver is built as a module, autoload won't work because the module
> alias information is not filled. So user-space can't match the registered
> device with the corresponding module.
> 
> Export the module alias information using the MODULE_DEVICE_TABLE() macro.
> 
> Before this patch:
> 
> $ modinfo drivers/iio/adc/fsl-imx25-gcq.ko | grep alias
> $
> 
> After this patch:
> 
> $ modinfo drivers/iio/adc/fsl-imx25-gcq.ko | grep alias
> alias:          of:N*T*Cfsl,imx25-gcqC*
> alias:          of:N*T*Cfsl,imx25-gcq
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Applied to the togreg branch of iio.git. Will push out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> ---
> 
>  drivers/iio/adc/fsl-imx25-gcq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
> index 72b32c1ab257..ea264fa9e567 100644
> --- a/drivers/iio/adc/fsl-imx25-gcq.c
> +++ b/drivers/iio/adc/fsl-imx25-gcq.c
> @@ -401,6 +401,7 @@ static const struct of_device_id mx25_gcq_ids[] = {
>  	{ .compatible = "fsl,imx25-gcq", },
>  	{ /* Sentinel */ }
>  };
> +MODULE_DEVICE_TABLE(of, mx25_gcq_ids);
>  
>  static struct platform_driver mx25_gcq_driver = {
>  	.driver		= {
> 

