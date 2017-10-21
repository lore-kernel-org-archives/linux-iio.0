Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932132AbdJURkO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Oct 2017 13:40:14 -0400
Date: Sat, 21 Oct 2017 18:40:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com
Subject: Re: [PATCH 08/13] staging: iio: tsl2x7x: correct alignment of
 parenthesis
Message-ID: <20171021184009.65e2cada@archlinux>
In-Reply-To: <20171019200632.25820-9-masneyb@onstation.org>
References: <20171019200632.25820-1-masneyb@onstation.org>
        <20171019200632.25820-9-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 19 Oct 2017 16:06:27 -0400
Brian Masney <masneyb@onstation.org> wrote:

> Correct error from checkpatch.pl to improve code readibility: Alignment
> should match open parenthesis. This involved shortening the name of
> tsl2x7x_als_gainadj and tsl2x7x_prx_gainadj to tsl2x7x_als_gain and
> tsl2x7x_prx_gain respectively. This also required removing the
> ch0lux and ch1lux local variables in order to get the line short
> enough.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied
> ---
>  drivers/staging/iio/light/tsl2x7x.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 6cc89cd6505e..886be9aa3c0f 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -243,14 +243,14 @@ static const struct tsl2x7x_settings tsl2x7x_default_settings = {
>  	.prox_pulse_count = 8
>  };
>  
> -static const s16 tsl2X7X_als_gainadj[] = {
> +static const s16 tsl2x7x_als_gain[] = {
>  	1,
>  	8,
>  	16,
>  	120
>  };
>  
> -static const s16 tsl2X7X_prx_gainadj[] = {
> +static const s16 tsl2x7x_prx_gain[] = {
>  	1,
>  	2,
>  	4,
> @@ -384,11 +384,10 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
>  	if (p->ratio == 0) {
>  		lux = 0;
>  	} else {
> -		ch0lux = DIV_ROUND_UP(ch0 * p->ch0,
> -			tsl2X7X_als_gainadj[chip->settings.als_gain]);
> -		ch1lux = DIV_ROUND_UP(ch1 * p->ch1,
> -			tsl2X7X_als_gainadj[chip->settings.als_gain]);
> -		lux = ch0lux - ch1lux;
> +		lux = DIV_ROUND_UP(ch0 * p->ch0,
> +				   tsl2x7x_als_gain[chip->settings.als_gain]) -
> +		      DIV_ROUND_UP(ch1 * p->ch1,
> +				   tsl2x7x_als_gain[chip->settings.als_gain]);
>  	}
>  
>  	/* note: lux is 31 bit max at this point */
> @@ -1263,9 +1262,9 @@ static int tsl2x7x_read_raw(struct iio_dev *indio_dev,
>  		break;
>  	case IIO_CHAN_INFO_CALIBSCALE:
>  		if (chan->type == IIO_LIGHT)
> -			*val = tsl2X7X_als_gainadj[chip->settings.als_gain];
> +			*val = tsl2x7x_als_gain[chip->settings.als_gain];
>  		else
> -			*val = tsl2X7X_prx_gainadj[chip->settings.prox_gain];
> +			*val = tsl2x7x_prx_gain[chip->settings.prox_gain];
>  		ret = IIO_VAL_INT;
>  		break;
>  	case IIO_CHAN_INFO_CALIBBIAS:

