Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750722AbeELLPM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 May 2018 07:15:12 -0400
Date: Sat, 12 May 2018 12:15:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        drew.paterson@ams.com
Subject: Re: [PATCH v3 1/9] staging: iio: tsl2x7x: remove unnecessary
 whitespace
Message-ID: <20180512121506.3cb3ca08@archlinux>
In-Reply-To: <20180511001223.12378-2-masneyb@onstation.org>
References: <20180511001223.12378-1-masneyb@onstation.org>
        <20180511001223.12378-2-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 10 May 2018 20:12:15 -0400
Brian Masney <masneyb@onstation.org> wrote:

> This patch removes unnecessary whitespace in preparation for moving this
> driver out of staging.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 22 +++++++++++-----------
>  drivers/staging/iio/light/tsl2x7x.h |  1 -
>  2 files changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index cc863e8927f5..3ae2fd19ae9c 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -196,16 +196,16 @@ static const struct tsl2x7x_lux tmd2x72_lux_table[TSL2X7X_DEF_LUX_TABLE_SZ] = {
>  };
>  
>  static const struct tsl2x7x_lux *tsl2x7x_default_lux_table_group[] = {
> -	[tsl2571] =	tsl2x71_lux_table,
> -	[tsl2671] =	tsl2x71_lux_table,
> -	[tmd2671] =	tmd2x71_lux_table,
> -	[tsl2771] =	tsl2x71_lux_table,
> -	[tmd2771] =	tmd2x71_lux_table,
> -	[tsl2572] =	tsl2x72_lux_table,
> -	[tsl2672] =	tsl2x72_lux_table,
> -	[tmd2672] =	tmd2x72_lux_table,
> -	[tsl2772] =	tsl2x72_lux_table,
> -	[tmd2772] =	tmd2x72_lux_table,
> +	[tsl2571] = tsl2x71_lux_table,
> +	[tsl2671] = tsl2x71_lux_table,
> +	[tmd2671] = tmd2x71_lux_table,
> +	[tsl2771] = tsl2x71_lux_table,
> +	[tmd2771] = tmd2x71_lux_table,
> +	[tsl2572] = tsl2x72_lux_table,
> +	[tsl2672] = tsl2x72_lux_table,
> +	[tmd2672] = tmd2x72_lux_table,
> +	[tsl2772] = tsl2x72_lux_table,
> +	[tmd2772] = tmd2x72_lux_table,
>  };
>  
>  static const struct tsl2x7x_settings tsl2x7x_default_settings = {
> @@ -1241,7 +1241,7 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
>  						    0,
>  						    IIO_EV_TYPE_THRESH,
>  						    IIO_EV_DIR_EITHER),
> -						    timestamp);
> +			       timestamp);
>  	}
>  
>  	if (ret & TSL2X7X_STA_ALS_INTR) {
> diff --git a/drivers/staging/iio/light/tsl2x7x.h b/drivers/staging/iio/light/tsl2x7x.h
> index 1097ee890ce2..db344796fc1b 100644
> --- a/drivers/staging/iio/light/tsl2x7x.h
> +++ b/drivers/staging/iio/light/tsl2x7x.h
> @@ -92,7 +92,6 @@ struct tsl2x7x_settings {
>   * struct tsl2X7X_platform_data - Platform callback, glass and defaults
>   * @platform_lux_table:        Device specific glass coefficents
>   * @platform_default_settings: Device specific power on defaults
> - *
>   */
>  struct tsl2X7X_platform_data {
>  	struct tsl2x7x_lux platform_lux_table[TSL2X7X_MAX_LUX_TABLE_SIZE];

