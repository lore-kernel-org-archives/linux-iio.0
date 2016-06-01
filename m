Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36066 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbcFASfX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 1 Jun 2016 14:35:23 -0400
Date: Wed, 1 Jun 2016 11:35:19 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Andrew F. Davis" <afd@ti.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Lee Jones <lee.jones@linaro.org>,
	Dave Gerlach <d-gerlach@ti.com>, linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] Input: ti_am335x_tsc - use variable name for
 sizeof() operator
Message-ID: <20160601183519.GG4114@dtor-ws>
References: <20160531170013.2649-1-afd@ti.com>
 <20160531170013.2649-9-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160531170013.2649-9-afd@ti.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, May 31, 2016 at 12:00:13PM -0500, Andrew F. Davis wrote:
> Fix the code formatting to use the kernel preferred style
> of using the actual variables to determize the size using
> the sizeof() operator.
> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/ti_am335x_tsc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
> index 8b3f15c..7953381 100644
> --- a/drivers/input/touchscreen/ti_am335x_tsc.c
> +++ b/drivers/input/touchscreen/ti_am335x_tsc.c
> @@ -406,7 +406,7 @@ static int titsc_probe(struct platform_device *pdev)
>  	int err;
>  
>  	/* Allocate memory for device */
> -	ts_dev = kzalloc(sizeof(struct titsc), GFP_KERNEL);
> +	ts_dev = kzalloc(sizeof(*ts_dev), GFP_KERNEL);
>  	input_dev = input_allocate_device();
>  	if (!ts_dev || !input_dev) {
>  		dev_err(&pdev->dev, "failed to allocate memory.\n");
> -- 
> 2.8.3
> 

-- 
Dmitry
