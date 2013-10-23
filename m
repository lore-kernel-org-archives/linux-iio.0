Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49996 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622Ab3JWPv5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 23 Oct 2013 11:51:57 -0400
Message-ID: <5267FED8.8070201@kernel.org>
Date: Wed, 23 Oct 2013 17:52:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
CC: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 1/2] iio: adc: nau7802: Remove redundant of_match_ptr
References: <1382347649-3382-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1382347649-3382-1-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/21/13 10:27, Sachin Kamat wrote:
> nau7802_dt_ids is always compiled in. Hence of_match_ptr is not
> needed.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Applied.
> ---
>  drivers/iio/adc/nau7802.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/nau7802.c b/drivers/iio/adc/nau7802.c
> index adff9cb..54c5bab 100644
> --- a/drivers/iio/adc/nau7802.c
> +++ b/drivers/iio/adc/nau7802.c
> @@ -570,7 +570,7 @@ static struct i2c_driver nau7802_driver = {
>  	.id_table = nau7802_i2c_id,
>  	.driver = {
>  		   .name = "nau7802",
> -		   .of_match_table = of_match_ptr(nau7802_dt_ids),
> +		   .of_match_table = nau7802_dt_ids,
>  	},
>  };
>  
> 
