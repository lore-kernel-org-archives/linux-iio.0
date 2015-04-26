Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42541 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184AbbDZSrU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Apr 2015 14:47:20 -0400
Message-ID: <553D32B6.90407@kernel.org>
Date: Sun, 26 Apr 2015 19:47:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Irina Tirdea <irina.tirdea@intel.com>, linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>
CC: linux-kernel@vger.kernel.org, Vlad Dogaru <vlad.dogaru@intel.com>
Subject: Re: [PATCH v2 07/17] iio: accel: mma9553: check for error in reading
 initial activity and stepcnt
References: <1428939664-12503-1-git-send-email-irina.tirdea@intel.com> <1428939664-12503-8-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1428939664-12503-8-git-send-email-irina.tirdea@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/04/15 16:40, Irina Tirdea wrote:
> When configuring gpio, we need to read initial values for activity and
> step count. This function may fail due to i2c read errors.
> 
> Check the error code returned by mma9553_read_activity_stepcnt
> and return the appropriate error in gpio config function.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> Reported-by: Hartmut Knaack <knaack.h@gmx.de>
applied, togreg....
> ---
>  drivers/iio/accel/mma9553.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
> index 365a109..6f0a14b 100644
> --- a/drivers/iio/accel/mma9553.c
> +++ b/drivers/iio/accel/mma9553.c
> @@ -363,9 +363,12 @@ static int mma9553_conf_gpio(struct mma9553_data *data)
>  		return 0;
>  
>  	/* Save initial values for activity and stepcnt */
> -	if (activity_enabled || ev_step_detect->enabled)
> -		mma9553_read_activity_stepcnt(data, &data->activity,
> -					      &data->stepcnt);
> +	if (activity_enabled || ev_step_detect->enabled) {
> +		ret = mma9553_read_activity_stepcnt(data, &data->activity,
> +						    &data->stepcnt);
> +		if (ret < 0)
> +			return ret;
> +	}
>  
>  	ret = mma9551_gpio_config(data->client,
>  				  MMA9553_DEFAULT_GPIO_PIN,
> 

