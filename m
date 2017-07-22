Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750865AbdGVUeJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jul 2017 16:34:09 -0400
Date: Sat, 22 Jul 2017 21:34:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jaya Durga <rjdurga@gmail.com>
Cc: gregkh@linuxfoundation.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] Staging: iio: light: tsl2x7x_core.c: Replace
 symbolic  permission with octal permission
Message-ID: <20170722213405.542a84da@kernel.org>
In-Reply-To: <1500467157-14739-2-git-send-email-rjdurga@gmail.com>
References: <1500467157-14739-1-git-send-email-rjdurga@gmail.com>
        <1500467157-14739-2-git-send-email-rjdurga@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 19 Jul 2017 17:55:56 +0530
Jaya Durga <rjdurga@gmail.com> wrote:

> Replace symbolic permissions with their
> octect representation to fix checkpatch warnings.
> 
> Signed-off-by: Jaya Durga <rjdurga@gmail.com>
The IIO drivers in staging are handled via the iio
tree on git.kernel.org from which Greg pulls a few
times a cycle (when I get enough queued up to make
it worth a pull request).

This code has changed substantially and these symbolic
permissions aren't there any more.

I'll probably be sending Greg a pull request sometime
this week and some time after that these will show
up in staging tree.

Thanks and unfortunate you were working on a driver
that is seeing a lot of changes at the moment as 
Brian tries to clean it up entirely for a move out of
staging.

Jonathan
> ---
>  drivers/staging/iio/light/tsl2x7x_core.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
> index af3910b..c63fe6a 100644
> --- a/drivers/staging/iio/light/tsl2x7x_core.c
> +++ b/drivers/staging/iio/light/tsl2x7x_core.c
> @@ -1498,34 +1498,34 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
>  	return 0;
>  }
>  
> -static DEVICE_ATTR(power_state, S_IRUGO | S_IWUSR,
> +static DEVICE_ATTR(power_state, 0644,
>  		tsl2x7x_power_state_show, tsl2x7x_power_state_store);
>  
> -static DEVICE_ATTR(in_proximity0_calibscale_available, S_IRUGO,
> +static DEVICE_ATTR(in_proximity0_calibscale_available, 0444,
>  		tsl2x7x_prox_gain_available_show, NULL);
>  
> -static DEVICE_ATTR(in_illuminance0_calibscale_available, S_IRUGO,
> +static DEVICE_ATTR(in_illuminance0_calibscale_available, 0444,
>  		tsl2x7x_gain_available_show, NULL);
>  
> -static DEVICE_ATTR(in_illuminance0_integration_time, S_IRUGO | S_IWUSR,
> +static DEVICE_ATTR(in_illuminance0_integration_time, 0644,
>  		tsl2x7x_als_time_show, tsl2x7x_als_time_store);
>  
> -static DEVICE_ATTR(in_illuminance0_target_input, S_IRUGO | S_IWUSR,
> +static DEVICE_ATTR(in_illuminance0_target_input, 0644,
>  		tsl2x7x_als_cal_target_show, tsl2x7x_als_cal_target_store);
>  
> -static DEVICE_ATTR(in_illuminance0_calibrate, S_IWUSR, NULL,
> +static DEVICE_ATTR(in_illuminance0_calibrate, 0200, NULL,
>  		tsl2x7x_do_calibrate);
>  
> -static DEVICE_ATTR(in_proximity0_calibrate, S_IWUSR, NULL,
> +static DEVICE_ATTR(in_proximity0_calibrate, 0200, NULL,
>  		tsl2x7x_do_prox_calibrate);
>  
> -static DEVICE_ATTR(in_illuminance0_lux_table, S_IRUGO | S_IWUSR,
> +static DEVICE_ATTR(in_illuminance0_lux_table, 0644,
>  		tsl2x7x_luxtable_show, tsl2x7x_luxtable_store);
>  
> -static DEVICE_ATTR(in_intensity0_thresh_period, S_IRUGO | S_IWUSR,
> +static DEVICE_ATTR(in_intensity0_thresh_period, 0644,
>  		tsl2x7x_als_persistence_show, tsl2x7x_als_persistence_store);
>  
> -static DEVICE_ATTR(in_proximity0_thresh_period, S_IRUGO | S_IWUSR,
> +static DEVICE_ATTR(in_proximity0_thresh_period, 0644,
>  		tsl2x7x_prox_persistence_show, tsl2x7x_prox_persistence_store);
>  
>  /* Use the default register values to identify the Taos device */

