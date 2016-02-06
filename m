Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39483 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbcBFLYv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 6 Feb 2016 06:24:51 -0500
Subject: Re: [PATCH 2/2] staging:iio:ad7606: Consolidate channel specs
To: Lars-Peter Clausen <lars@metafoo.de>
References: <1454668354-11450-1-git-send-email-lars@metafoo.de>
 <1454668354-11450-2-git-send-email-lars@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56B5D801.20903@kernel.org>
Date: Sat, 6 Feb 2016 11:24:49 +0000
MIME-Version: 1.0
In-Reply-To: <1454668354-11450-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/02/16 10:32, Lars-Peter Clausen wrote:
> By slightly reordering the channels in the channel spec array we can reuse
> the same array for all variant of the chip.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Fair enough I suppose, though I find it hard to care much about this sort
of consolidation as it trades slight readability disadvantage off against
reduced code size.

Applied to the togreg branch of iio.git.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/adc/ad7606_core.c | 34 ++++++++--------------------------
>  1 file changed, 8 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
> index d0b634d..ce9b2c3 100644
> --- a/drivers/staging/iio/adc/ad7606_core.c
> +++ b/drivers/staging/iio/adc/ad7606_core.c
> @@ -250,7 +250,8 @@ static const struct attribute_group ad7606_attribute_group_range = {
>  		},						\
>  	}
>  
> -static const struct iio_chan_spec ad7606_8_channels[] = {
> +static const struct iio_chan_spec ad7606_channels[] = {
> +	IIO_CHAN_SOFT_TIMESTAMP(8),
>  	AD7606_CHANNEL(0),
>  	AD7606_CHANNEL(1),
>  	AD7606_CHANNEL(2),
> @@ -259,25 +260,6 @@ static const struct iio_chan_spec ad7606_8_channels[] = {
>  	AD7606_CHANNEL(5),
>  	AD7606_CHANNEL(6),
>  	AD7606_CHANNEL(7),
> -	IIO_CHAN_SOFT_TIMESTAMP(8),
> -};
> -
> -static const struct iio_chan_spec ad7606_6_channels[] = {
> -	AD7606_CHANNEL(0),
> -	AD7606_CHANNEL(1),
> -	AD7606_CHANNEL(2),
> -	AD7606_CHANNEL(3),
> -	AD7606_CHANNEL(4),
> -	AD7606_CHANNEL(5),
> -	IIO_CHAN_SOFT_TIMESTAMP(6),
> -};
> -
> -static const struct iio_chan_spec ad7606_4_channels[] = {
> -	AD7606_CHANNEL(0),
> -	AD7606_CHANNEL(1),
> -	AD7606_CHANNEL(2),
> -	AD7606_CHANNEL(3),
> -	IIO_CHAN_SOFT_TIMESTAMP(4),
>  };
>  
>  static const struct ad7606_chip_info ad7606_chip_info_tbl[] = {
> @@ -287,20 +269,20 @@ static const struct ad7606_chip_info ad7606_chip_info_tbl[] = {
>  	[ID_AD7606_8] = {
>  		.name = "ad7606",
>  		.int_vref_mv = 2500,
> -		.channels = ad7606_8_channels,
> -		.num_channels = 8,
> +		.channels = ad7606_channels,
> +		.num_channels = 9,
>  	},
>  	[ID_AD7606_6] = {
>  		.name = "ad7606-6",
>  		.int_vref_mv = 2500,
> -		.channels = ad7606_6_channels,
> -		.num_channels = 6,
> +		.channels = ad7606_channels,
> +		.num_channels = 7,
>  	},
>  	[ID_AD7606_4] = {
>  		.name = "ad7606-4",
>  		.int_vref_mv = 2500,
> -		.channels = ad7606_4_channels,
> -		.num_channels = 4,
> +		.channels = ad7606_channels,
> +		.num_channels = 5,
>  	},
>  };
>  
> 

