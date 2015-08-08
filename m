Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58701 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754102AbbHHOKc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2015 10:10:32 -0400
Subject: Re: [PATCH 9/9] iio: adis16136: Add ADIS16137 support
To: Lars-Peter Clausen <lars@metafoo.de>
References: <1438781901-28000-1-git-send-email-lars@metafoo.de>
 <1438781901-28000-10-git-send-email-lars@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55C60DD7.90006@kernel.org>
Date: Sat, 8 Aug 2015 15:10:31 +0100
MIME-Version: 1.0
In-Reply-To: <1438781901-28000-10-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/08/15 14:38, Lars-Peter Clausen wrote:
> The ADIS16137 is register map compatible to the ADIS16136, but has a
> different scale factor for the gyroscope output.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied - as usual initially pushed out as testing to let the autobuilder
do all the hardwork (remember when one locally built the patches for
a couple of architectures before pushing everything? - isn't it nice now
to do a cursory check and let the experts take over ;)

Thanks

Jonathan
> ---
>  drivers/iio/gyro/adis16136.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
> index 591bd55..26de876 100644
> --- a/drivers/iio/gyro/adis16136.c
> +++ b/drivers/iio/gyro/adis16136.c
> @@ -473,6 +473,7 @@ enum adis16136_id {
>  	ID_ADIS16133,
>  	ID_ADIS16135,
>  	ID_ADIS16136,
> +	ID_ADIS16137,
>  };
>  
>  static const struct adis16136_chip_info adis16136_chip_info[] = {
> @@ -488,6 +489,10 @@ static const struct adis16136_chip_info adis16136_chip_info[] = {
>  		.precision = IIO_DEGREE_TO_RAD(450),
>  		.fullscale = 24623,
>  	},
> +	[ID_ADIS16137] = {
> +		.precision = IIO_DEGREE_TO_RAD(1000),
> +		.fullscale = 24609,
> +	},
>  };
>  
>  static int adis16136_probe(struct spi_device *spi)
> @@ -557,6 +562,7 @@ static const struct spi_device_id adis16136_ids[] = {
>  	{ "adis16133", ID_ADIS16133 },
>  	{ "adis16135", ID_ADIS16135 },
>  	{ "adis16136", ID_ADIS16136 },
> +	{ "adis16137", ID_ADIS16137 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, adis16136_ids);
> 

