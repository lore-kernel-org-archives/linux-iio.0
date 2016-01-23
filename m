Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40348 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbcAWQQ4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Jan 2016 11:16:56 -0500
Subject: Re: [PATCH 1/2] iio:adc:at91-sama5d2: fix vref_uv type
To: Ludovic Desroches <ludovic.desroches@atmel.com>,
	nicolas.ferre@atmel.com
References: <1453106516-17935-1-git-send-email-ludovic.desroches@atmel.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Julia Lawall <Julia.Lawall@lip6.fr>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56A3A775.3090907@kernel.org>
Date: Sat, 23 Jan 2016 16:16:53 +0000
MIME-Version: 1.0
In-Reply-To: <1453106516-17935-1-git-send-email-ludovic.desroches@atmel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/01/16 08:41, Ludovic Desroches wrote:
> vref_uv has to be an int.
> 
Applied, with a reported-by tag for Julia added.

Thanks,

Jonathan
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index ecb2d90..f2d8bd5 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -171,7 +171,7 @@ struct at91_adc_state {
>  	struct clk			*per_clk;
>  	struct regulator		*reg;
>  	struct regulator		*vref;
> -	u32				vref_uv;
> +	int				vref_uv;
>  	const struct iio_chan_spec	*chan;
>  	bool				conversion_done;
>  	u32				conversion_value;
> 

