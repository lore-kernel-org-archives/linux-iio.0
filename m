Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53567 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756983AbcA3QNo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Jan 2016 11:13:44 -0500
Subject: Re: [PATCH 2/2] iio: si7005: add support for Hoperf th02
To: Cristina Moraru <cristina.moraru09@gmail.com>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net,
	ludovic.tancerel@maplehightech.com, mranostay@gmail.com,
	geert@linux-m68k.org, k.kozlowski@samsung.com,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	octavian.purdila@intel.com, daniel.baluta@intel.com
References: <1453839667-3626-1-git-send-email-cristina.moraru09@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56ACE136.1010401@kernel.org>
Date: Sat, 30 Jan 2016 16:13:42 +0000
MIME-Version: 1.0
In-Reply-To: <1453839667-3626-1-git-send-email-cristina.moraru09@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/01/16 20:21, Cristina Moraru wrote:
> This patch adds support for Hoperf th02 humidity and
> temperature sensor as it uses same register definitions
> as si7005
> 
> th02 Datasheet: http://www.anglia-live.com/netalogue/pdfs/hrf/datasheets/TH02_V1.1.pdf
> 
> Signed-off-by: Cristina Moraru <cristina.moraru09@gmail.com>
Applied to the togreg branch of iio.git -initially pushed out as testing
for the auto builders to play with it (not really relevant here, but such
is life ;)

Jonathan
> ---
>  drivers/iio/humidity/Kconfig  | 3 ++-
>  drivers/iio/humidity/si7005.c | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
> index c1f3a21..866dda1 100644
> --- a/drivers/iio/humidity/Kconfig
> +++ b/drivers/iio/humidity/Kconfig
> @@ -43,7 +43,8 @@ config SI7005
>  	  humidity and temperature sensor.
>  
>  	  To compile this driver as a module, choose M here: the module
> -	  will be called si7005.
> +	  will be called si7005. This driver also
> +	  supports Hoperf TH02 Humidity and Temperature Sensor.
>  
>  config SI7020
>  	tristate "Si7013/20/21 Relative Humidity and Temperature Sensors"
> diff --git a/drivers/iio/humidity/si7005.c b/drivers/iio/humidity/si7005.c
> index 91972cc..98a022f 100644
> --- a/drivers/iio/humidity/si7005.c
> +++ b/drivers/iio/humidity/si7005.c
> @@ -170,6 +170,7 @@ static int si7005_probe(struct i2c_client *client,
>  
>  static const struct i2c_device_id si7005_id[] = {
>  	{ "si7005", 0 },
> +	{ "th02", 0 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, si7005_id);
> 

