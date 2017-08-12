Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751731AbdHLMge (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Aug 2017 08:36:34 -0400
Date: Sat, 12 Aug 2017 13:08:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: adc: fix error return code in
 ad7606_par_probe()
Message-ID: <20170812130854.2a87e2f4@archlinux>
In-Reply-To: <20170809153856.GA22134@embeddedgus>
References: <20170809153856.GA22134@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 9 Aug 2017 10:38:56 -0500
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> platform_get_irq() returns an error code, but the ad7606_par driver
> ignores it and always returns -ENODEV. This is not correct and,
> prevents -EPROBE_DEFER from being propagated properly.
> 
> Print and propagate the return value of platform_get_irq on failure.
> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Applied to the togreg branch of iio.git.

As we have no reports of anyone actually finding this a problem I'm
taking it the slow way and it will wait for the next merge window.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/adc/ad7606_par.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7606_par.c b/drivers/staging/iio/adc/ad7606_par.c
> index cd6c410c..3eb6f8f 100644
> --- a/drivers/staging/iio/adc/ad7606_par.c
> +++ b/drivers/staging/iio/adc/ad7606_par.c
> @@ -57,8 +57,8 @@ static int ad7606_par_probe(struct platform_device *pdev)
>  
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
> -		dev_err(&pdev->dev, "no irq\n");
> -		return -ENODEV;
> +		dev_err(&pdev->dev, "no irq: %d\n", irq);
> +		return irq;
>  	}
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);

