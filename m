Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49595 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbaAKQIh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 11 Jan 2014 11:08:37 -0500
Message-ID: <52D16C8A.20101@kernel.org>
Date: Sat, 11 Jan 2014 16:08:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/5] iio:magnetometer:mag3110: Scale factor missing for
 temperature
References: <1389391163-9622-1-git-send-email-pmeerw@pmeerw.net> <1389391163-9622-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1389391163-9622-3-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 10/01/14 21:59, Peter Meerwald wrote:
> temperature is reported in milli-Celsius
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
This one is sort of new functionality rather than a fix so I've going to hold
this one until after the others have propogated through then apply it
via the normal togreg branch.

> ---
>   drivers/iio/magnetometer/mag3110.c | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/mag3110.c
> index f66955f..02e4f97 100644
> --- a/drivers/iio/magnetometer/mag3110.c
> +++ b/drivers/iio/magnetometer/mag3110.c
> @@ -183,8 +183,17 @@ static int mag3110_read_raw(struct iio_dev *indio_dev,
>   			return -EINVAL;
>   		}
>   	case IIO_CHAN_INFO_SCALE:
> -		*val = 0;
> -		*val2 = 1000;
> +		switch (chan->type) {
> +		case IIO_MAGN:
> +			*val = 0;
> +			*val2 = 1000;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		case IIO_TEMP:
> +			*val = 1000;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
>   		return IIO_VAL_INT_PLUS_MICRO;
>   	case IIO_CHAN_INFO_SAMP_FREQ:
>   		i = data->ctrl_reg1 >> MAG3110_CTRL_DR_SHIFT;
> @@ -270,7 +279,8 @@ static const struct iio_chan_spec mag3110_channels[] = {
>   	MAG3110_CHANNEL(Z, 2),
>   	{
>   		.type = IIO_TEMP,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_SCALE),
>   		.scan_index = 3,
>   		.scan_type = {
>   			.sign = 's',
>
