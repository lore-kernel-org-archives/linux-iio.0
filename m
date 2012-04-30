Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:37500 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755525Ab2D3JUy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 30 Apr 2012 05:20:54 -0400
Message-ID: <4F9E5973.3060505@cam.ac.uk>
Date: Mon, 30 Apr 2012 10:20:51 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: add Kconfig option and Makefile entry for mcp4725
 I2C DAC driver
References: <1335719618-28295-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1335719618-28295-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Peter,

Welcome to IIO!
This is fine, but needs to be part of the same patch as the actual code.
Convention is to introduce build options in the same patch as what
they cover. Also if like here you introduce it first the kernel becomes
non bisectable inbetween the two patches which won't go down
well if anyone hits it!
> Signed-off-by: Peter Meerwald<pmeerw@pmeerw.net>
>
> ---
>   drivers/staging/iio/dac/Kconfig  |   11 +++++++++++
>   drivers/staging/iio/dac/Makefile |    1 +
>   2 files changed, 12 insertions(+)
>
> diff --git a/drivers/staging/iio/dac/Kconfig b/drivers/staging/iio/dac/Kconfig
> index a57803a..9308118 100644
> --- a/drivers/staging/iio/dac/Kconfig
> +++ b/drivers/staging/iio/dac/Kconfig
> @@ -118,4 +118,15 @@ config MAX517
>   	  This driver can also be built as a module.  If so, the module
>   	  will be called max517.
>
> +config MCP4725
> +	tristate "MCP4725 DAC driver"
> +	depends on I2C
> +	---help---
> +	  Say Y here if you want to build a driver for the Microchip
> +	  MCP 4725 12-bit digital-to-analog convertor (DAC) with I2C
> +	  interface.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called mcp4725.
> +
>   endmenu
> diff --git a/drivers/staging/iio/dac/Makefile b/drivers/staging/iio/dac/Makefile
> index 8ab1d26..9ea3cee 100644
> --- a/drivers/staging/iio/dac/Makefile
> +++ b/drivers/staging/iio/dac/Makefile
> @@ -13,3 +13,4 @@ obj-$(CONFIG_AD5764) += ad5764.o
>   obj-$(CONFIG_AD5791) += ad5791.o
>   obj-$(CONFIG_AD5686) += ad5686.o
>   obj-$(CONFIG_MAX517) += max517.o
> +obj-$(CONFIG_MCP4725) += mcp4725.o

