Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46539 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755012Ab3C2JWo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 29 Mar 2013 05:22:44 -0400
Message-ID: <51555D65.4030509@kernel.org>
Date: Fri, 29 Mar 2013 09:22:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/6] staging:iio:ad799x: Remove unused ad799x_state fields
References: <1364323384-30863-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1364323384-30863-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/26/2013 06:42 PM, Lars-Peter Clausen wrote:
> Remove fields from the ad799x_state struct which are not used.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Whole series applied to togreg branch of iio.git
> ---
>  drivers/staging/iio/adc/ad799x.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad799x.h b/drivers/staging/iio/adc/ad799x.h
> index 3e363c4..9f50f93 100644
> --- a/drivers/staging/iio/adc/ad799x.h
> +++ b/drivers/staging/iio/adc/ad799x.h
> @@ -104,11 +104,9 @@ struct ad799x_chip_info {
>  struct ad799x_state {
>  	struct i2c_client		*client;
>  	const struct ad799x_chip_info	*chip_info;
> -	struct iio_trigger		*trig;
>  	struct regulator		*reg;
>  	u16				int_vref_mv;
>  	unsigned			id;
> -	char				*name;
>  	u16				config;
>  };
>  
> 
