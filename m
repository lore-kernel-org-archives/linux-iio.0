Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34193 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844AbcE2TGh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 May 2016 15:06:37 -0400
Subject: Re: [PATCH] iio: magnetometer: bmc150: Document Bosch supported chips
To: Daniel Baluta <daniel.baluta@intel.com>
References: <1464093748-4798-1-git-send-email-daniel.baluta@intel.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <7a1e6a77-5b3f-ae28-9f1d-387fd3dc5357@kernel.org>
Date: Sun, 29 May 2016 20:06:35 +0100
MIME-Version: 1.0
In-Reply-To: <1464093748-4798-1-git-send-email-daniel.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/05/16 13:42, Daniel Baluta wrote:
> bmc150 driver supports also BMC156 and BMM150 chips.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
Good to clean this sort of thing up.

Applied, thanks.

Jonathan
> ---
>  drivers/iio/magnetometer/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
> index 84e6559..1f842ab 100644
> --- a/drivers/iio/magnetometer/Kconfig
> +++ b/drivers/iio/magnetometer/Kconfig
> @@ -44,6 +44,7 @@ config BMC150_MAGN_I2C
>  	  This driver is only implementing magnetometer part, which has
>  	  its own address and register map.
>  
> +	  This driver also supports I2C Bosch BMC156 and BMM150 chips.
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called bmc150_magn_i2c.
>  
> @@ -60,6 +61,7 @@ config BMC150_MAGN_SPI
>  	  This driver is only implementing magnetometer part, which has
>  	  its own address and register map.
>  
> +	  This driver also supports SPI Bosch BMC156 and BMM150 chips.
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called bmc150_magn_spi.
>  
> 

