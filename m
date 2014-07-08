Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:35204 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754321AbaGHUMY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 8 Jul 2014 16:12:24 -0400
Message-ID: <53BC512A.7010002@kernel.org>
Date: Tue, 08 Jul 2014 21:14:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 5/6] staging:iio:ad7291 faciliate ad7291_read_event_config()
References: <53BBD0D1.2070507@gmx.de>
In-Reply-To: <53BBD0D1.2070507@gmx.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/07/14 12:06, Hartmut Knaack wrote:
> Save some lines in returning a voltage event.
>
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Applied to the togreg branch of iio.git

Thanks
> ---
> diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
> index 654b39e..06eb0c0 100644
> --- a/drivers/staging/iio/adc/ad7291.c
> +++ b/drivers/staging/iio/adc/ad7291.c
> @@ -242,10 +242,7 @@ static int ad7291_read_event_config(struct iio_dev *indio_dev,
>
>   	switch (chan->type) {
>   	case IIO_VOLTAGE:
> -		if (chip->c_mask & BIT(15 - chan->channel))
> -			return 1;
> -		else
> -			return 0;
> +		return !!(chip->c_mask & BIT(15 - chan->channel));
>   	case IIO_TEMP:
>   		/* always on */
>   		return 1;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

