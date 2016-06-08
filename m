Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35232 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161544AbcFHPfK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 8 Jun 2016 11:35:10 -0400
Received: by mail-wm0-f42.google.com with SMTP id v199so69590569wmv.0
        for <linux-iio@vger.kernel.org>; Wed, 08 Jun 2016 08:35:05 -0700 (PDT)
Date: Wed, 8 Jun 2016 16:35:35 +0100
From: Lee Jones <lee.jones@linaro.org>
To: "Andrew F. Davis" <afd@ti.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dave Gerlach <d-gerlach@ti.com>, linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] mfd: ti_am335x_tscadc: use variable name for
 sizeof() operator
Message-ID: <20160608153535.GU14888@dell>
References: <20160531170013.2649-1-afd@ti.com>
 <20160531170013.2649-7-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20160531170013.2649-7-afd@ti.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 31 May 2016, Andrew F. Davis wrote:

> Fix the code formatting to use the kernel preferred style
> of using the actual variables to determize the size using
> the sizeof() operator.
> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>  drivers/mfd/ti_am335x_tscadc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> index d30bea5..c8f027b 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -168,8 +168,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  	}
>  
>  	/* Allocate memory for device */
> -	tscadc = devm_kzalloc(&pdev->dev,
> -			sizeof(struct ti_tscadc_dev), GFP_KERNEL);
> +	tscadc = devm_kzalloc(&pdev->dev, sizeof(*tscadc), GFP_KERNEL);
>  	if (!tscadc) {
>  		dev_err(&pdev->dev, "failed to allocate memory.\n");
>  		return -ENOMEM;

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
