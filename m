Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59820 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841AbbGENb7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 5 Jul 2015 09:31:59 -0400
Message-ID: <559931CC.4030809@kernel.org>
Date: Sun, 05 Jul 2015 14:31:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Tomasz Duszynski <tduszyns@gmail.com>
CC: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: pressure: ms5611: remove IIO_CHAN_INFO_SCALE
 from mask
References: <1435085148-12404-1-git-send-email-tduszyns@gmail.com>
In-Reply-To: <1435085148-12404-1-git-send-email-tduszyns@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/06/15 19:45, Tomasz Duszynski wrote:
> IIO_CHAN_INFO_SCALE is useful whenever conversion to standard units is done
> in userspace. In this case conversion is handled by driver so this bit
> is unnecessary.
> 
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
Applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/iio/pressure/ms5611_core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
> index e42c853..1109513 100644
> --- a/drivers/iio/pressure/ms5611_core.c
> +++ b/drivers/iio/pressure/ms5611_core.c
> @@ -163,13 +163,11 @@ static int ms5611_read_raw(struct iio_dev *indio_dev,
>  static const struct iio_chan_spec ms5611_channels[] = {
>  	{
>  		.type = IIO_PRESSURE,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> -			BIT(IIO_CHAN_INFO_SCALE)
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
>  	},
>  	{
>  		.type = IIO_TEMP,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> -			BIT(IIO_CHAN_INFO_SCALE)
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
>  	}
>  };
>  
> 

