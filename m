Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51812 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064Ab3JAIHX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2013 04:07:23 -0400
Message-ID: <524A90E6.8020300@kernel.org>
Date: Tue, 01 Oct 2013 10:07:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org, Josh Wu <josh.wu@atmel.com>
Subject: Re: [PATCH 17/25] iio:at91: Report scale as fractional value
References: <1380360717-26103-1-git-send-email-lars@metafoo.de> <1380360717-26103-17-git-send-email-lars@metafoo.de>
In-Reply-To: <1380360717-26103-17-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/28/13 10:31, Lars-Peter Clausen wrote:
> Move the complexity of calculating the fixed point scale to the core.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Josh Wu <josh.wu@atmel.com>
Applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/iio/adc/at91_adc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 5c8f690..ce169d4 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -366,9 +366,9 @@ static int at91_adc_read_raw(struct iio_dev *idev,
>  		return IIO_VAL_INT;
>  
>  	case IIO_CHAN_INFO_SCALE:
> -		*val = (st->vref_mv * 1000) >> chan->scan_type.realbits;
> -		*val2 = 0;
> -		return IIO_VAL_INT_PLUS_MICRO;
> +		*val = st->vref_mv;
> +		*val2 = chan->scan_type.realbits;
> +		return IIO_VAL_FRACTIONAL_LOG2;
>  	default:
>  		break;
>  	}
> 
