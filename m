Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45157 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135AbcAXPBK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Jan 2016 10:01:10 -0500
Subject: Re: [PATCH v2 1/3] iio: light: opt3001: extract int. time constants
To: Alexander Koch <mail@alexanderkoch.net>
References: <1452960878-1727-1-git-send-email-mail@alexanderkoch.net>
 <1452960878-1727-2-git-send-email-mail@alexanderkoch.net>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	mhornung.linux@gmail.com, dannenberg@ti.com, balbi@ti.com,
	fengguang.wu@intel.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56A4E733.6060309@kernel.org>
Date: Sun, 24 Jan 2016 15:01:07 +0000
MIME-Version: 1.0
In-Reply-To: <1452960878-1727-2-git-send-email-mail@alexanderkoch.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/01/16 16:14, Alexander Koch wrote:
> Extract integration times as #define constants. This prepares using them
> for delay/timeout length determination.
> 
> Signed-off-by: Alexander Koch <mail@alexanderkoch.net>
> Signed-off-by: Michael Hornung <mhornung.linux@gmail.com>
Applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to play with it.
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
> 

