Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38159 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753097AbbHVR7V (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 22 Aug 2015 13:59:21 -0400
Subject: Re: [PATCH 02/18] staging: iio: hmc5843: Export missing SPI module
 alias information
To: Javier Martinez Canillas <javier@osg.samsung.com>,
	linux-kernel@vger.kernel.org
References: <1440054451-1223-1-git-send-email-javier@osg.samsung.com>
 <1440054451-1223-3-git-send-email-javier@osg.samsung.com>
Cc: devel@driverdev.osuosl.org, linux-iio@vger.kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hartmut Knaack <knaack.h@gmx.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55D8B875.3060200@kernel.org>
Date: Sat, 22 Aug 2015 18:59:17 +0100
MIME-Version: 1.0
In-Reply-To: <1440054451-1223-3-git-send-email-javier@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/08/15 08:07, Javier Martinez Canillas wrote:
> The SPI core always reports the MODALIAS uevent as "spi:<modalias>"
> regardless of the mechanism that was used to register the device
> (i.e: OF or board code) and the table that is used later to match
> the driver with the device (i.e: SPI id table or OF match table).
> 
> So drivers needs to export the SPI id table and this be built into
> the module or udev won't have the necessary information to autoload
> the needed driver module when the device is added.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Applied to the togreg branch of iio.git.

This is too late for the upcoming merge window so it will be queued up for
the next one.

Thanks,

Jonathan
> ---
> 
>  drivers/staging/iio/magnetometer/hmc5843_spi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/iio/magnetometer/hmc5843_spi.c b/drivers/staging/iio/magnetometer/hmc5843_spi.c
> index 8e658f736e1f..4dfb372d2fec 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843_spi.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843_spi.c
> @@ -81,6 +81,7 @@ static const struct spi_device_id hmc5843_id[] = {
>  	{ "hmc5983", HMC5983_ID },
>  	{ }
>  };
> +MODULE_DEVICE_TABLE(spi, hmc5843_id);
>  
>  static struct spi_driver hmc5843_driver = {
>  		.driver = {
> 

