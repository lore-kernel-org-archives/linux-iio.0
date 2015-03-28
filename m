Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60409 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752804AbbC1Nn4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2015 09:43:56 -0400
Message-ID: <5516B017.8050409@kernel.org>
Date: Sat, 28 Mar 2015 13:43:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: =?UTF-8?B?Vmlhbm5leSBsZSBDbMOpbWVudCBkZSBTYWludC1NYXJjcQ==?=
	<vianney.leclement@essensium.com>, linux-iio@vger.kernel.org
CC: "Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>
Subject: Re: [PATCH v2 7/7] iio: mlx90614: Check for errors in read values
References: <1427212459-31585-1-git-send-email-vianney.leclement@essensium.com> <1427212459-31585-8-git-send-email-vianney.leclement@essensium.com>
In-Reply-To: <1427212459-31585-8-git-send-email-vianney.leclement@essensium.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/03/15 15:54, Vianney le Clément de Saint-Marcq wrote:
> The device uses the MSB of the returned temperature values as an error
> flag.  Return a read error when this bit is set.
> 
> Signed-off-by: Vianney le Clément de Saint-Marcq <vianney.leclement@essensium.com>
> Cc: Arnout Vandecappelle (Essensium/Mind) <arnout@mind.be>
> 
Hmm. Does it really signify a remote IO issue.  I'd have thought EIO was
more appropriate.

I see one -EREMOTEIO using driver (vybrid ADC) but in other similar
cases we've always gone with EIO.

J
> ---
> 
> v2: new patch
> ---
>  drivers/iio/temperature/mlx90614.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
> index 6b9bfcd..6cb1e81 100644
> --- a/drivers/iio/temperature/mlx90614.c
> +++ b/drivers/iio/temperature/mlx90614.c
> @@ -196,6 +196,11 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
>  
>  		if (ret < 0)
>  			return ret;
> +
> +		/* MSB is an error flag */
> +		if (ret & 0x8000)
> +			return -EREMOTEIO;
> +
>  		*val = ret;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_OFFSET:
> 

