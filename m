Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55401 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932801AbcA2SA1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 29 Jan 2016 13:00:27 -0500
Date: Fri, 29 Jan 2016 11:59:31 -0600
From: Andreas Dannenberg <dannenberg@ti.com>
To: Alexander Koch <mail@alexanderkoch.net>
CC: <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
	<pmeerw@pmeerw.net>, <mhornung.linux@gmail.com>, <balbi@ti.com>,
	<fengguang.wu@intel.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] iio: light: opt3001: extract int. time constants
Message-ID: <20160129175931.GA7960@LTA0797059A>
References: <1452960878-1727-1-git-send-email-mail@alexanderkoch.net>
 <1452960878-1727-2-git-send-email-mail@alexanderkoch.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1452960878-1727-2-git-send-email-mail@alexanderkoch.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Jan 16, 2016 at 05:14:36PM +0100, Alexander Koch wrote:
> Extract integration times as #define constants. This prepares using them
> for delay/timeout length determination.
> 
> Signed-off-by: Alexander Koch <mail@alexanderkoch.net>
> Signed-off-by: Michael Hornung <mhornung.linux@gmail.com>

Tested-by: Andreas Dannenberg <dannenberg@ti.com>

Thanks for the patch series!

> ---
>  drivers/iio/light/opt3001.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
> index 01e111e..aefbd79 100644
> --- a/drivers/iio/light/opt3001.c
> +++ b/drivers/iio/light/opt3001.c
> @@ -65,6 +65,9 @@
>  #define OPT3001_REG_EXPONENT(n)		((n) >> 12)
>  #define OPT3001_REG_MANTISSA(n)		((n) & 0xfff)
>  
> +#define OPT3001_INT_TIME_LONG		800000
> +#define OPT3001_INT_TIME_SHORT		100000
> +
>  /*
>   * Time to wait for conversion result to be ready. The device datasheet
>   * worst-case max value is 880ms. Add some slack to be on the safe side.
> @@ -325,13 +328,13 @@ static int opt3001_set_int_time(struct opt3001 *opt, int time)
>  	reg = ret;
>  
>  	switch (time) {
> -	case 100000:
> +	case OPT3001_INT_TIME_SHORT:
>  		reg &= ~OPT3001_CONFIGURATION_CT;
> -		opt->int_time = 100000;
> +		opt->int_time = OPT3001_INT_TIME_SHORT;
>  		break;
> -	case 800000:
> +	case OPT3001_INT_TIME_LONG:
>  		reg |= OPT3001_CONFIGURATION_CT;
> -		opt->int_time = 800000;
> +		opt->int_time = OPT3001_INT_TIME_LONG;
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -597,9 +600,9 @@ static int opt3001_configure(struct opt3001 *opt)
>  
>  	/* Reflect status of the device's integration time setting */
>  	if (reg & OPT3001_CONFIGURATION_CT)
> -		opt->int_time = 800000;
> +		opt->int_time = OPT3001_INT_TIME_LONG;
>  	else
> -		opt->int_time = 100000;
> +		opt->int_time = OPT3001_INT_TIME_SHORT;
>  
>  	/* Ensure device is in shutdown initially */
>  	opt3001_set_mode(opt, &reg, OPT3001_CONFIGURATION_M_SHUTDOWN);
> -- 
> 2.7.0
> 
