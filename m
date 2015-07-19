Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45996 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496AbbGSKCH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jul 2015 06:02:07 -0400
Message-ID: <55AB759D.7040806@kernel.org>
Date: Sun, 19 Jul 2015 11:02:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>
Subject: Re: [PATCH 1/8] iio:magnetometer:bmc150_magn: add regmap dependency
References: <cover.1437090791.git.knaack.h@gmx.de> <b09e8e6a55526102daf53f85c2b8079c497abad5.1437090791.git.knaack.h@gmx.de>
In-Reply-To: <b09e8e6a55526102daf53f85c2b8079c497abad5.1437090791.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/07/15 09:52, Hartmut Knaack wrote:
> bmc150_magn makes use of REGMAP_I2C, so select it to build always without
> errors.
> 
> Fixes: c91746a2361d ("iio: magn: Add support for BMC150 magnetometer")
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan
> ---
>  drivers/iio/magnetometer/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
> index dcadfc4f0661..efb9350b0d76 100644
> --- a/drivers/iio/magnetometer/Kconfig
> +++ b/drivers/iio/magnetometer/Kconfig
> @@ -90,6 +90,7 @@ config IIO_ST_MAGN_SPI_3AXIS
>  config BMC150_MAGN
>  	tristate "Bosch BMC150 Magnetometer Driver"
>  	depends on I2C
> +	select REGMAP_I2C
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	help
> 

