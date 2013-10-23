Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50003 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751839Ab3JWPwI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 23 Oct 2013 11:52:08 -0400
Message-ID: <5267FEE3.6070908@kernel.org>
Date: Wed, 23 Oct 2013 17:52:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ti_am335x_adc: Remove redundant of_match_ptr
References: <1382347649-3382-1-git-send-email-sachin.kamat@linaro.org> <1382347649-3382-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1382347649-3382-2-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/21/13 10:27, Sachin Kamat wrote:
> ti_adc_dt_ids is always compiled in. Hence of_match_ptr is not
> needed.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Applied
> ---
>  drivers/iio/adc/ti_am335x_adc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index 8fb5429..ef553d0 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -515,7 +515,7 @@ static struct platform_driver tiadc_driver = {
>  		.name   = "TI-am335x-adc",
>  		.owner	= THIS_MODULE,
>  		.pm	= TIADC_PM_OPS,
> -		.of_match_table = of_match_ptr(ti_adc_dt_ids),
> +		.of_match_table = ti_adc_dt_ids,
>  	},
>  	.probe	= tiadc_probe,
>  	.remove	= tiadc_remove,
> 
