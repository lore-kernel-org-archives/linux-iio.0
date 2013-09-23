Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58662 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753342Ab3IWSVB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 23 Sep 2013 14:21:01 -0400
Message-ID: <524094B2.5090301@kernel.org>
Date: Mon, 23 Sep 2013 20:21:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Aida Mynzhasova <aida.mynzhasova@skitlab.ru>
CC: axel.lin@ingics.com, lars@metafoo.de, linux-iio@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH v2] iio: dac: ad5446: Add support for AD5641
References: <1379945955-9545-1-git-send-email-aida.mynzhasova@skitlab.ru>
In-Reply-To: <1379945955-9545-1-git-send-email-aida.mynzhasova@skitlab.ru>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/23/13 15:19, Aida Mynzhasova wrote:
> This patch adds support for the AD5641 single channel,
> 14-bit, buffered voltage output DAC.
> 
> Signed-off-by: Aida Mynzhasova <aida.mynzhasova@skitlab.ru>
Applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/iio/dac/Kconfig  | 2 +-
>  drivers/iio/dac/ad5446.c | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index c9c33ce..c1715a9 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -62,7 +62,7 @@ config AD5446
>  	  Say yes here to build support for Analog Devices AD5300, AD5301, AD5310,
>  	  AD5311, AD5320, AD5321, AD5444, AD5446, AD5450, AD5451, AD5452, AD5453,
>  	  AD5512A, AD5541A, AD5542A, AD5543, AD5553, AD5601, AD5602, AD5611, AD5612,
> -	  AD5620, AD5621, AD5622, AD5640, AD5660, AD5662 DACs.
> +	  AD5620, AD5621, AD5622, AD5640, AD5641, AD5660, AD5662 DACs.
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad5446.
> diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
> index cae8f60..b543d09 100644
> --- a/drivers/iio/dac/ad5446.c
> +++ b/drivers/iio/dac/ad5446.c
> @@ -338,6 +338,7 @@ enum ad5446_supported_spi_device_ids {
>  	ID_AD5601,
>  	ID_AD5611,
>  	ID_AD5621,
> +	ID_AD5641,
>  	ID_AD5620_2500,
>  	ID_AD5620_1250,
>  	ID_AD5640_2500,
> @@ -400,6 +401,10 @@ static const struct ad5446_chip_info ad5446_spi_chip_info[] = {
>  		.channel = AD5446_CHANNEL_POWERDOWN(12, 16, 2),
>  		.write = ad5446_write,
>  	},
> +	[ID_AD5641] = {
> +		.channel = AD5446_CHANNEL_POWERDOWN(14, 16, 0),
> +		.write = ad5446_write,
> +	},
>  	[ID_AD5620_2500] = {
>  		.channel = AD5446_CHANNEL_POWERDOWN(12, 16, 2),
>  		.int_vref_mv = 2500,
> @@ -454,6 +459,7 @@ static const struct spi_device_id ad5446_spi_ids[] = {
>  	{"ad5601", ID_AD5601},
>  	{"ad5611", ID_AD5611},
>  	{"ad5621", ID_AD5621},
> +	{"ad5641", ID_AD5641},
>  	{"ad5620-2500", ID_AD5620_2500}, /* AD5620/40/60: */
>  	{"ad5620-1250", ID_AD5620_1250}, /* part numbers may look differently */
>  	{"ad5640-2500", ID_AD5640_2500},
> 
