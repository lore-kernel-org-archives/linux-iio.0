Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:52873 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756069Ab1ELNhu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 12 May 2011 09:37:50 -0400
Message-ID: <4DCBE34A.4010007@cam.ac.uk>
Date: Thu, 12 May 2011 14:40:26 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH] iio: trigger: iio-trig-bfin-timer: select missing dependency
References: <1305198909-2078-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1305198909-2078-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/12/11 12:15, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> This driver requires CONFIG_BFIN_GPTIMERS.
Feel free to send this sort of thing directly to Greg in future.

> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/trigger/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/staging/iio/trigger/Kconfig b/drivers/staging/iio/trigger/Kconfig
> index c33777e..b8abf54 100644
> --- a/drivers/staging/iio/trigger/Kconfig
> +++ b/drivers/staging/iio/trigger/Kconfig
> @@ -31,6 +31,7 @@ config IIO_SYSFS_TRIGGER
>  config IIO_BFIN_TMR_TRIGGER
>  	tristate "Blackfin TIMER trigger"
>  	depends on BLACKFIN
> +	select BFIN_GPTIMERS
>  	help
>  	  Provides support for using a Blackfin timer as IIO triggers.
>  	  If unsure, say N (but it's safe to say "Y").

