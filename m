Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39509 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755798Ab3INJhf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 Sep 2013 05:37:35 -0400
Message-ID: <52343C7E.9050107@kernel.org>
Date: Sat, 14 Sep 2013 11:37:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/5] iio: dac: ad5686: Remove redundant break
References: <1378894829-8173-1-git-send-email-sachin.kamat@linaro.org> <1378894829-8173-4-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1378894829-8173-4-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/11/13 11:20, Sachin Kamat wrote:
> 'break' after return is redundant. Remove it.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Applied to the togreg branch of iio.git
> ---
>  drivers/iio/dac/ad5686.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index 57825ea..3e1080f 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -213,7 +213,6 @@ static int ad5686_read_raw(struct iio_dev *indio_dev,
>  			return ret;
>  		*val = ret;
>  		return IIO_VAL_INT;
> -		break;
>  	case IIO_CHAN_INFO_SCALE:
>  		scale_uv = (st->vref_mv * 100000)
>  			>> (chan->scan_type.realbits);
> 
