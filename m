Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49976 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709Ab3JWPvA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 23 Oct 2013 11:51:00 -0400
Message-ID: <5267FE9E.2050107@kernel.org>
Date: Wed, 23 Oct 2013 17:51:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/1] iio: adc: twl6030-gpadc: Remove redundant of_match_ptr
References: <1382343956-18483-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1382343956-18483-1-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/21/13 09:25, Sachin Kamat wrote:
> of_twl6030_match_tbl is always compiled in. Hence of_match_ptr is
> not necessary.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Applied to the togreg branch of iio.git

thanks,
> ---
>  drivers/iio/adc/twl6030-gpadc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
> index 0ea96c0..2edfc7b 100644
> --- a/drivers/iio/adc/twl6030-gpadc.c
> +++ b/drivers/iio/adc/twl6030-gpadc.c
> @@ -887,7 +887,7 @@ static int twl6030_gpadc_probe(struct platform_device *pdev)
>  	int irq;
>  	int ret;
>  
> -	match = of_match_device(of_match_ptr(of_twl6030_match_tbl), dev);
> +	match = of_match_device(of_twl6030_match_tbl, dev);
>  	if (!match)
>  		return -EINVAL;
>  
> 
