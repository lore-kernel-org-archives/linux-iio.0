Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752868AbeDUQjc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Apr 2018 12:39:32 -0400
Date: Sat, 21 Apr 2018 17:39:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com
Subject: Re: [PATCH 11/13] staging: iio: tsl2x7x: use device defaults for
 als_time, prox_time and wait_time
Message-ID: <20180421173927.41475990@archlinux>
In-Reply-To: <20180421004153.19073-12-masneyb@onstation.org>
References: <20180421004153.19073-1-masneyb@onstation.org>
        <20180421004153.19073-12-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 20 Apr 2018 20:41:51 -0400
Brian Masney <masneyb@onstation.org> wrote:

> This patch changes the defaults of the als_time, prox_time and
> wait_time to match the defaults according to the TSL2772 datasheet.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied, thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index a7b4fcba7935..293810ff11b9 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -201,11 +201,11 @@ static const struct tsl2x7x_lux *tsl2x7x_default_lux_table_group[] = {
>  };
>  
>  static const struct tsl2x7x_settings tsl2x7x_default_settings = {
> -	.als_time = 219, /* 101 ms */
> +	.als_time = 255, /* 2.73 ms */
>  	.als_gain = 0,
> -	.prox_time = 254, /* 5.4 ms */
> +	.prox_time = 255, /* 2.73 ms */
>  	.prox_gain = 0,
> -	.wait_time = 245,
> +	.wait_time = 255,
>  	.prox_config = 0,
>  	.als_gain_trim = 1000,
>  	.als_cal_target = 150,

