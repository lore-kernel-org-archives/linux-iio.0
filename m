Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53579 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757002AbcA3QO1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Jan 2016 11:14:27 -0500
Subject: Re: [PATCH 1/2] iio: si7020: add support for Hoperf th06
To: Cristina Moraru <cristina.moraru09@gmail.com>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net,
	ludovic.tancerel@maplehightech.com, mranostay@gmail.com,
	geert@linux-m68k.org, andrew.smirnov@gmail.com, nicola@corna.info,
	chris.lesiak@licor.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, octavian.purdila@intel.com,
	daniel.baluta@intel.com
References: <1453839469-3537-1-git-send-email-cristina.moraru09@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56ACE161.9050209@kernel.org>
Date: Sat, 30 Jan 2016 16:14:25 +0000
MIME-Version: 1.0
In-Reply-To: <1453839469-3537-1-git-send-email-cristina.moraru09@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/01/16 20:17, Cristina Moraru wrote:
> This patch adds support for Hoperf th06 humidity and
> temperature sensor as it uses same register definitions
> as si7020
> 
> th06 Datasheet: http://www.hoperf.com/upload/sensor/TH06.pdf
> 
> Signed-off-by: Cristina Moraru <cristina.moraru09@gmail.com>
Applied - thanks,

Jonathan
> ---
> Previously sent: http://marc.info/?l=linux-iio&m=145255305514311&w=2
> 
>  drivers/iio/humidity/Kconfig  | 3 ++-
>  drivers/iio/humidity/si7020.c | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
> index 6a23698..c1f3a21 100644
> --- a/drivers/iio/humidity/Kconfig
> +++ b/drivers/iio/humidity/Kconfig
> @@ -50,7 +50,8 @@ config SI7020
>  	depends on I2C
>  	help
>  	  Say yes here to build support for the Silicon Labs Si7013/20/21
> -	  Relative Humidity and Temperature Sensors.
> +	  Relative Humidity and Temperature Sensors. This driver also
> +	  supports Hoperf TH06 Humidity and Temperature Sensor.
>  
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called si7020.
> diff --git a/drivers/iio/humidity/si7020.c b/drivers/iio/humidity/si7020.c
> index 71991b5..5ab4e06 100644
> --- a/drivers/iio/humidity/si7020.c
> +++ b/drivers/iio/humidity/si7020.c
> @@ -149,6 +149,7 @@ static int si7020_probe(struct i2c_client *client,
>  
>  static const struct i2c_device_id si7020_id[] = {
>  	{ "si7020", 0 },
> +	{ "th06", 0 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, si7020_id);
> 

