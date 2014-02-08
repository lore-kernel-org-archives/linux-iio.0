Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40114 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841AbaBHKLS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Feb 2014 05:11:18 -0500
Message-ID: <52F602E2.60707@kernel.org>
Date: Sat, 08 Feb 2014 10:11:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH]staging:iio:ad799x fix typo in ad799x_events[]
References: <52F5754B.9060507@gmx.de>
In-Reply-To: <52F5754B.9060507@gmx.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 08/02/14 00:07, Hartmut Knaack wrote:
> This patch fixes a typo in ad799x_events[], which caused the error "Failed to register event set".
>
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Good spot!  Applied to the the fixes-togreg branch and marked for stable.
> ---
> diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
> index c1b601ac..bf9081e 100644
> --- a/drivers/staging/iio/adc/ad799x_core.c
> +++ b/drivers/staging/iio/adc/ad799x_core.c
> @@ -393,7 +393,7 @@ static const struct iio_event_spec ad799x_events[] = {
>   	}, {
>   		.type = IIO_EV_TYPE_THRESH,
>   		.dir = IIO_EV_DIR_FALLING,
> -		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
>   			BIT(IIO_EV_INFO_ENABLE),
>   	}, {
>   		.type = IIO_EV_TYPE_THRESH,
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
