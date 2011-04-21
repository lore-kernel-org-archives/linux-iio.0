Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:33508 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799Ab1DUIxn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 21 Apr 2011 04:53:43 -0400
Message-ID: <4DAFF10F.60708@cam.ac.uk>
Date: Thu, 21 Apr 2011 09:55:43 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH] IIO-onwards: TRIGGER: iio-trig-bfin-timer: Fix build
 issues
References: <1303310503-4137-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1303310503-4137-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/20/11 15:41, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Fix typos
Oops ;) Should probably set myself up a blackfin toolchain at some point...
> select BFIN_GPTIMERS
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> ---
>  drivers/staging/iio/trigger/Kconfig               |    1 +
>  drivers/staging/iio/trigger/iio-trig-bfin-timer.c |    4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
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
> diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> index 096559d..43b3605 100644
> --- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> +++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> @@ -116,7 +116,7 @@ static const struct attribute_group iio_bfin_tmr_trigger_attr_group = {
>  	.attrs = iio_bfin_tmr_trigger_attrs,
>  };
>  
> -static const sturc attribute_group *iio_bfin_tmr_trigger_attr_groups[] = {
> +static const struct attribute_group *iio_bfin_tmr_trigger_attr_groups[] = {
>  	&iio_bfin_tmr_trigger_attr_group,
>  	NULL
>  };
> @@ -176,7 +176,7 @@ static int __devinit iio_bfin_tmr_trigger_probe(struct platform_device *pdev)
>  
>  	st->trig->private_data = st;
>  	st->trig->owner = THIS_MODULE;
> -	trig->dev.groups = iio_bfin_tmr_trigger_attr_groups;
> +	st->trig->dev.groups = iio_bfin_tmr_trigger_attr_groups;
>  	ret = iio_trigger_register(st->trig);
>  	if (ret)
>  		goto out2;

