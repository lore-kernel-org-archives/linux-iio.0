Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754017AbeAGQ2x (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Jan 2018 11:28:53 -0500
Date: Sun, 7 Jan 2018 16:28:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: George Edward Bulmer <gebulmer@googlemail.com>
Cc: gregkh@linuxfoundation.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, masneyb@onstation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: light: Add breaks to lengthy lines
Message-ID: <20180107162848.37108f96@archlinux>
In-Reply-To: <20180107150801.21617-1-gebulmer@googlemail.com>
References: <20180107150801.21617-1-gebulmer@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun,  7 Jan 2018 15:08:01 +0000
George Edward Bulmer <gebulmer@googlemail.com> wrote:

> This fixes three instances of checkpatch warning:
> WARNING: line over 80 characters
> 
> Signed-off-by: George Edward Bulmer <gebulmer@googlemail.com>
Applied, thanks,

Jonathan
> ---
>  drivers/staging/iio/light/tsl2x7x.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 42ed9c015aaf..126e11530ce0 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -1441,7 +1441,8 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
>  
>  static struct attribute *tsl2x7x_ALS_device_attrs[] = {
>  	&dev_attr_in_illuminance0_calibscale_available.attr,
> -	&iio_const_attr_in_illuminance0_integration_time_available.dev_attr.attr,
> +	&iio_const_attr_in_illuminance0_integration_time_available
> +		.dev_attr.attr,
>  	&dev_attr_in_illuminance0_target_input.attr,
>  	&dev_attr_in_illuminance0_calibrate.attr,
>  	&dev_attr_in_illuminance0_lux_table.attr,
> @@ -1455,7 +1456,8 @@ static struct attribute *tsl2x7x_PRX_device_attrs[] = {
>  
>  static struct attribute *tsl2x7x_ALSPRX_device_attrs[] = {
>  	&dev_attr_in_illuminance0_calibscale_available.attr,
> -	&iio_const_attr_in_illuminance0_integration_time_available.dev_attr.attr,
> +	&iio_const_attr_in_illuminance0_integration_time_available
> +		.dev_attr.attr,
>  	&dev_attr_in_illuminance0_target_input.attr,
>  	&dev_attr_in_illuminance0_calibrate.attr,
>  	&dev_attr_in_illuminance0_lux_table.attr,
> @@ -1471,7 +1473,8 @@ static struct attribute *tsl2x7x_PRX2_device_attrs[] = {
>  
>  static struct attribute *tsl2x7x_ALSPRX2_device_attrs[] = {
>  	&dev_attr_in_illuminance0_calibscale_available.attr,
> -	&iio_const_attr_in_illuminance0_integration_time_available.dev_attr.attr,
> +	&iio_const_attr_in_illuminance0_integration_time_available
> +		.dev_attr.attr,
>  	&dev_attr_in_illuminance0_target_input.attr,
>  	&dev_attr_in_illuminance0_calibrate.attr,
>  	&dev_attr_in_illuminance0_lux_table.attr,

