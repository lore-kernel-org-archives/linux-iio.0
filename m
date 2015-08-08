Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59421 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992441AbbHHQiU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2015 12:38:20 -0400
Subject: Re: [PATCH 7/7] iio:accel:mma8452: reorder Kconfig entry
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
References: <cover.1438483410.git.knaack.h@gmx.de>
 <f2c8c8dd008120917ceb2c87367e2e1bd5bbaf93.1438483410.git.knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Martin Fuzzey <mfuzzey@parkeon.com>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	martink@posteo.de
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55C6307A.8080509@kernel.org>
Date: Sat, 8 Aug 2015 17:38:18 +0100
MIME-Version: 1.0
In-Reply-To: <f2c8c8dd008120917ceb2c87367e2e1bd5bbaf93.1438483410.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/08/15 21:43, Hartmut Knaack wrote:
> Move the entry in Kconfig to its alphabetically correct position.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Applied
> ---
>  drivers/iio/accel/Kconfig | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 00e7bcbdbe24..b8fc12c7640b 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -86,18 +86,6 @@ config KXSD9
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called kxsd9.
>  
> -config MMA8452
> -	tristate "Freescale MMA8452Q Accelerometer Driver"
> -	depends on I2C
> -	select IIO_BUFFER
> -	select IIO_TRIGGERED_BUFFER
> -	help
> -	  Say yes here to build support for the Freescale MMA8452Q 3-axis
> -	  accelerometer.
> -
> -	  To compile this driver as a module, choose M here: the module
> -	  will be called mma8452.
> -
>  config KXCJK1013
>  	tristate "Kionix 3-Axis Accelerometer Driver"
>  	depends on I2C
> @@ -111,6 +99,18 @@ config KXCJK1013
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called kxcjk-1013.
>  
> +config MMA8452
> +	tristate "Freescale MMA8452Q Accelerometer Driver"
> +	depends on I2C
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  Say yes here to build support for the Freescale MMA8452Q 3-axis
> +	  accelerometer.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called mma8452.
> +
>  config MMA9551_CORE
>  	tristate
>  
> 

