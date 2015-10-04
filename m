Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50963 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbbJDO05 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 4 Oct 2015 10:26:57 -0400
Subject: Re: [PATCH v4 7/7] Typo correction in ms5611 Kconfig
To: Ludovic Tancerel <ludovic.tancerel@maplehightech.com>,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, William.Markezana@meas-spec.com
References: <1443708822-8580-1-git-send-email-ludovic.tancerel@maplehightech.com>
 <1443708822-8580-8-git-send-email-ludovic.tancerel@maplehightech.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5611372F.2070003@kernel.org>
Date: Sun, 4 Oct 2015 15:26:55 +0100
MIME-Version: 1.0
In-Reply-To: <1443708822-8580-8-git-send-email-ludovic.tancerel@maplehightech.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/10/15 15:13, Ludovic Tancerel wrote:
> Signed-off-by: Ludovic Tancerel <ludovic.tancerel@maplehightech.com>
Hmm. I applied this yesterday, but seem to have failed to email to say
that I had!

So... Applied to the togreg branch of iio.git, initially pushed out as
testing for the autobuilders to completely ignore given it's a help
comment fix.

> ---
>  drivers/iio/pressure/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
> index 01e0b6a..53f9a44 100644
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

