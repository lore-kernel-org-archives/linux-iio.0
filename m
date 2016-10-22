Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53198 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937874AbcJVPWY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Oct 2016 11:22:24 -0400
Subject: Re: [PATCH 01/13] staging:iio:ad7606: Remove unused int_vref_mv field
To: Lars-Peter Clausen <lars@metafoo.de>
References: <1476896828-10544-1-git-send-email-lars@metafoo.de>
 <1476896828-10544-2-git-send-email-lars@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c8bc16d4-a135-dfa6-c7e3-714e0caeb5df@kernel.org>
Date: Sat, 22 Oct 2016 16:22:22 +0100
MIME-Version: 1.0
In-Reply-To: <1476896828-10544-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/10/16 18:06, Lars-Peter Clausen wrote:
> Remove the int_vref_mv field from the ad7606_chip_info struct since the
> field is never used by the driver. The value is also the same for all
> derivatives of this chip, so if it will ever be used in the driver a
> constant value will work just fine.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git - initially pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/adc/ad7606.h      | 2 --
>  drivers/staging/iio/adc/ad7606_core.c | 3 ---
>  2 files changed, 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
> index 39f5044..b7e59a6 100644
> --- a/drivers/staging/iio/adc/ad7606.h
> +++ b/drivers/staging/iio/adc/ad7606.h
> @@ -43,14 +43,12 @@ struct ad7606_platform_data {
>  /**
>   * struct ad7606_chip_info - chip specific information
>   * @name:		identification string for chip
> - * @int_vref_mv:	the internal reference voltage
>   * @channels:		channel specification
>   * @num_channels:	number of channels
>   */
>  
>  struct ad7606_chip_info {
>  	const char			*name;
> -	u16				int_vref_mv;
>  	const struct iio_chan_spec	*channels;
>  	unsigned int			num_channels;
>  };
> diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
> index 2042225..a1f18d4 100644
> --- a/drivers/staging/iio/adc/ad7606_core.c
> +++ b/drivers/staging/iio/adc/ad7606_core.c
> @@ -261,19 +261,16 @@ static const struct ad7606_chip_info ad7606_chip_info_tbl[] = {
>  	 */
>  	[ID_AD7606_8] = {
>  		.name = "ad7606",
> -		.int_vref_mv = 2500,
>  		.channels = ad7606_channels,
>  		.num_channels = 9,
>  	},
>  	[ID_AD7606_6] = {
>  		.name = "ad7606-6",
> -		.int_vref_mv = 2500,
>  		.channels = ad7606_channels,
>  		.num_channels = 7,
>  	},
>  	[ID_AD7606_4] = {
>  		.name = "ad7606-4",
> -		.int_vref_mv = 2500,
>  		.channels = ad7606_channels,
>  		.num_channels = 5,
>  	},
> 

