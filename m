Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39808 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752807AbcJIKdT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Oct 2016 06:33:19 -0400
Subject: Re: [PATCH 3/4] staging: iio: isl29018: rename Kconfig variable to
 match existing light drivers in mainline.
To: Brian Masney <masneyb@onstation.org>
References: <1475801317-29449-1-git-send-email-masneyb@onstation.org>
 <1475801317-29449-3-git-send-email-masneyb@onstation.org>
Cc: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <4efa6955-eaca-312a-009b-5d487688d1b7@kernel.org>
Date: Sun, 9 Oct 2016 11:33:17 +0100
MIME-Version: 1.0
In-Reply-To: <1475801317-29449-3-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/10/16 01:48, Brian Masney wrote:
> Rename CONFIG_SENSORS_ISL29018 to CONFIG_ISL29018 for consistency with
> the other light drivers in mainline.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
I'm always a bit split on these.  It would be lovely to tidy
it up, but it may cause unnecessary breakage to people's
configs for a very minor gain.  Hence I'm not going to apply this.

Jonathan
> ---
>  drivers/staging/iio/light/Kconfig  | 2 +-
>  drivers/staging/iio/light/Makefile | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/Kconfig b/drivers/staging/iio/light/Kconfig
> index ca8d6e6..b0e2948 100644
> --- a/drivers/staging/iio/light/Kconfig
> +++ b/drivers/staging/iio/light/Kconfig
> @@ -3,7 +3,7 @@
>  #
>  menu "Light sensors"
>  
> -config SENSORS_ISL29018
> +config ISL29018
>  	tristate "ISL 29018 light and proximity sensor"
>  	depends on I2C
>  	select REGMAP_I2C
> diff --git a/drivers/staging/iio/light/Makefile b/drivers/staging/iio/light/Makefile
> index 9960fdf..89d6b02 100644
> --- a/drivers/staging/iio/light/Makefile
> +++ b/drivers/staging/iio/light/Makefile
> @@ -2,7 +2,7 @@
>  # Makefile for industrial I/O Light sensors
>  #
>  
> -obj-$(CONFIG_SENSORS_ISL29018)	+= isl29018.o
> +obj-$(CONFIG_ISL29018)	+= isl29018.o
>  obj-$(CONFIG_SENSORS_ISL29028)	+= isl29028.o
>  obj-$(CONFIG_TSL2583)	+= tsl2583.o
>  obj-$(CONFIG_TSL2x7x)	+= tsl2x7x_core.o
> 

