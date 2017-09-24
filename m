Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751868AbdIXL6r (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Sep 2017 07:58:47 -0400
Date: Sun, 24 Sep 2017 12:58:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        sre@kernel.org, wsa@the-dreams.de, kishon@ti.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: adc: twl4030: Fix an error handling path in
 'twl4030_madc_probe()'
Message-ID: <20170924125842.455f2579@archlinux>
In-Reply-To: <4bcd315895de7135369e6e0d2402fc2794f2ee99.1506146101.git.christophe.jaillet@wanadoo.fr>
References: <cover.1506146101.git.christophe.jaillet@wanadoo.fr>
        <4bcd315895de7135369e6e0d2402fc2794f2ee99.1506146101.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 23 Sep 2017 08:06:18 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> If 'devm_regulator_get()' fails, we should go through the existing error
> handling path instead of returning directly, as done is all the other
> error handling paths in this function.
> 
> Fixes: 7cc97d77ee8a ("iio: adc: twl4030: Fix ADC[3:6] readings")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Applied to the fixes-togreg-post-rc1 branch of iio.git and marked
for stable. 

Thanks,

Jonathan
> ---
>  drivers/iio/adc/twl4030-madc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
> index 1edd99f0c5e5..80ab2ed70b85 100644
> --- a/drivers/iio/adc/twl4030-madc.c
> +++ b/drivers/iio/adc/twl4030-madc.c
> @@ -887,8 +887,10 @@ static int twl4030_madc_probe(struct platform_device *pdev)
>  
>  	/* Enable 3v1 bias regulator for MADC[3:6] */
>  	madc->usb3v1 = devm_regulator_get(madc->dev, "vusb3v1");
> -	if (IS_ERR(madc->usb3v1))
> -		return -ENODEV;
> +	if (IS_ERR(madc->usb3v1)) {
> +		ret = -ENODEV;
> +		goto err_i2c;
> +	}
>  
>  	ret = regulator_enable(madc->usb3v1);
>  	if (ret)

