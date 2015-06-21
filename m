Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43863 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110AbbFUN0x (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jun 2015 09:26:53 -0400
Message-ID: <5586BB9B.9030402@kernel.org>
Date: Sun, 21 Jun 2015 14:26:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Kevin Tsai <ktsai@capellamicro.com>,
	Daniel Baluta <daniel.baluta@intel.com>
Subject: Re: [PATCH v2 2/7] iio:light:Kconfig: fix typo in description
References: <cover.1434578207.git.knaack.h@gmx.de> <c2ee8106bc15a8b64782c9adb59dcaa6ee49d9a7.1434578207.git.knaack.h@gmx.de>
In-Reply-To: <c2ee8106bc15a8b64782c9adb59dcaa6ee49d9a7.1434578207.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/06/15 23:32, Hartmut Knaack wrote:
> Fix the typo in the module description for the CM3323.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
> Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>
Applied to the togreg branch of iio.git

Thanks,

Jonathan
> ---
>  drivers/iio/light/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index e6198b7..554f8ee 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -86,7 +86,7 @@ config CM3323
>  	depends on I2C
>  	tristate "Capella CM3323 color light sensor"
>  	help
> -	 Say Y here if you want to build a driver for Capela CM3323
> +	 Say Y here if you want to build a driver for Capella CM3323
>  	 color sensor.
>  
>  	 To compile this driver as a module, choose M here: the module will
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
