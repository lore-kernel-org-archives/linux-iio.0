Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43962 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbbFUNlE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jun 2015 09:41:04 -0400
Message-ID: <5586BEEF.1060401@kernel.org>
Date: Sun, 21 Jun 2015 14:41:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: Fix Measurement Specialties vendor name
References: <1434482823-24065-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1434482823-24065-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/06/15 20:27, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Good spot.

Applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/iio/pressure/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
> index fa62950..b13ea6f 100644
> --- a/drivers/iio/pressure/Kconfig
> +++ b/drivers/iio/pressure/Kconfig
> @@ -53,9 +53,9 @@ config MPL3115
>            will be called mpl3115.
>  
>  config MS5611
> -	tristate "Measurement Specialities MS5611 pressure sensor driver"
> +	tristate "Measurement Specialties MS5611 pressure sensor driver"
>  	help
> -	  Say Y here to build support for the Measurement Specialities
> +	  Say Y here to build support for the Measurement Specialties
>  	  MS5611 pressure and temperature sensor.
>  
>  	  To compile this driver as a module, choose M here: the module will
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
