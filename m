Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:32974 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821AbaEXKpn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 24 May 2014 06:45:43 -0400
Message-ID: <538078BC.9090409@kernel.org>
Date: Sat, 24 May 2014 11:47:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: Fix two mpl3115 issues in measurement conversion
References: <1400571365-23380-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1400571365-23380-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/05/14 08:36, Peter Meerwald wrote:
> (i) pressure is 20-bit unsigned, not signed; the buffer description
> is incorrect; for raw reads, this is just cosmetic
>
> (ii) temperature is 12-bit signed, not 16-bit; this affects
> readout of temperatures below zero as the sign bit is incorrectly
> processed
>
> reported via private mail
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Reported-by: Robert Deliën <robert@delien.nl>
Given how late we are in the current cycle I've applied this to the togreg
branch of iio.git (for the next merge window) but also marked it for stable.

Thanks,

Jonathan
> ---
>   drivers/iio/pressure/mpl3115.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
> index ba6d0c5..01b2e0b 100644
> --- a/drivers/iio/pressure/mpl3115.c
> +++ b/drivers/iio/pressure/mpl3115.c
> @@ -98,7 +98,7 @@ static int mpl3115_read_raw(struct iio_dev *indio_dev,
>   			mutex_unlock(&data->lock);
>   			if (ret < 0)
>   				return ret;
> -			*val = sign_extend32(be32_to_cpu(tmp) >> 12, 23);
> +			*val = be32_to_cpu(tmp) >> 12;
>   			return IIO_VAL_INT;
>   		case IIO_TEMP: /* in 0.0625 celsius / LSB */
>   			mutex_lock(&data->lock);
> @@ -112,7 +112,7 @@ static int mpl3115_read_raw(struct iio_dev *indio_dev,
>   			mutex_unlock(&data->lock);
>   			if (ret < 0)
>   				return ret;
> -			*val = sign_extend32(be32_to_cpu(tmp) >> 20, 15);
> +			*val = sign_extend32(be32_to_cpu(tmp) >> 20, 11);
>   			return IIO_VAL_INT;
>   		default:
>   			return -EINVAL;
> @@ -185,7 +185,7 @@ static const struct iio_chan_spec mpl3115_channels[] = {
>   			BIT(IIO_CHAN_INFO_SCALE),
>   		.scan_index = 0,
>   		.scan_type = {
> -			.sign = 's',
> +			.sign = 'u',
>   			.realbits = 20,
>   			.storagebits = 32,
>   			.shift = 12,
>

