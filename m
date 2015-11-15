Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46144 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbbKOLOo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Nov 2015 06:14:44 -0500
Subject: Re: [PATCH] iio: adc: ad7793: removed unnecessary else.
To: Nizam Haider <nizamhaider786@gmail.com>
References: <1447073445-9231-1-git-send-email-nizamhaider786@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Nizam Haider <nijamh@cdac.in>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56486922.4030705@kernel.org>
Date: Sun, 15 Nov 2015 11:14:42 +0000
MIME-Version: 1.0
In-Reply-To: <1447073445-9231-1-git-send-email-nizamhaider786@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/11/15 12:50, Nizam Haider wrote:
> Else is not generally useful after a break or return.
> 
> Signed-off-by: Nizam Haider <nijamh@cdac.in>
Applied, thanks.

Jonathan
> ---
>  drivers/iio/adc/ad7793.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
> index eea0c79..3bc5655 100644
> --- a/drivers/iio/adc/ad7793.c
> +++ b/drivers/iio/adc/ad7793.c
> @@ -478,10 +478,9 @@ static int ad7793_read_raw(struct iio_dev *indio_dev,
>  				*val2 = st->
>  					scale_avail[(st->conf >> 8) & 0x7][1];
>  				return IIO_VAL_INT_PLUS_NANO;
> -			} else {
> -				/* 1170mV / 2^23 * 6 */
> -				scale_uv = (1170ULL * 1000000000ULL * 6ULL);
>  			}
> +			/* 1170mV / 2^23 * 6 */
> +			scale_uv = (1170ULL * 1000000000ULL * 6ULL);
>  			break;
>  		case IIO_TEMP:
>  				/* 1170mV / 0.81 mV/C / 2^23 */
> 

