Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58219 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812Ab3IGUGu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 7 Sep 2013 16:06:50 -0400
Message-ID: <522B9573.6040909@kernel.org>
Date: Sat, 07 Sep 2013 22:06:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, lars@metafoo.de,
	"J. August Brenner" <jbrenner@taosinc.com>
Subject: Re: [PATCH 11/12] staging: iio: tsl2x7x_core: Fix sparse warning
References: <1378373397-22919-1-git-send-email-sachin.kamat@linaro.org> <1378373397-22919-11-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1378373397-22919-11-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/05/13 10:29, Sachin Kamat wrote:
> Silences the following warning:
> drivers/staging/iio/light/tsl2x7x_core.c:553:70:
> warning: Using plain integer as NULL pointer
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: J. August Brenner <jbrenner@taosinc.com>
Thanks,

I've been meaning to fix that one myself for ages :(

Much easier just to apply your patch though.

Applied to the togreg branch of iio.git

> ---
>  drivers/staging/iio/light/tsl2x7x_core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
> index aa86725..3439d37 100644
> --- a/drivers/staging/iio/light/tsl2x7x_core.c
> +++ b/drivers/staging/iio/light/tsl2x7x_core.c
> @@ -550,7 +550,7 @@ prox_poll_err:
>  static void tsl2x7x_defaults(struct tsl2X7X_chip *chip)
>  {
>  	/* If Operational settings defined elsewhere.. */
> -	if (chip->pdata && chip->pdata->platform_default_settings != 0)
> +	if (chip->pdata && chip->pdata->platform_default_settings)
>  		memcpy(&(chip->tsl2x7x_settings),
>  			chip->pdata->platform_default_settings,
>  			sizeof(tsl2x7x_default_settings));
> 
