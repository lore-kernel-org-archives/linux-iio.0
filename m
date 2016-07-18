Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57867 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752551AbcGSFgU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jul 2016 01:36:20 -0400
Subject: Re: [PATCH 01/10] mfd: cros_ec: add ChromeOS EC sensor platform
 information.
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <1468825370-20075-1-git-send-email-enric.balletbo@collabora.com>
 <1468825370-20075-2-git-send-email-enric.balletbo@collabora.com>
Cc: Olof Johansson <olof@lixom.net>, Lee Jones <lee.jones@linaro.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Guenter Roeck <groeck@chromium.org>,
	Gwendal Grignou <gwendal@chromium.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <eaae9ae6-7cc0-1fe2-88b1-c3fc42bf42f5@kernel.org>
Date: Mon, 18 Jul 2016 14:43:30 +0100
MIME-Version: 1.0
In-Reply-To: <1468825370-20075-2-git-send-email-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/07/16 08:02, Enric Balletbo i Serra wrote:
> The platform information will be used for the new cros-ec sensors driver
> that presents sensors attached to the ChromeOS Embedded Controller.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Bring this in as an when you need it in the rest of the series.
It certainly doesn't need it's own patch.
> ---
>  include/linux/mfd/cros_ec.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
> index d6539c1..cd4833a 100644
> --- a/include/linux/mfd/cros_ec.h
> +++ b/include/linux/mfd/cros_ec.h
> @@ -151,6 +151,16 @@ struct cros_ec_device {
>  	int event_size;
>  };
>  
Check your kernel doc formatting.
> +/* struct cros_ec_sensor_platform - ChromeOS EC sensor platform information
> + *
> + * On top of cros_ec_devicem information cros_ec_sensors needs.
> + *
> + * @sensor_num: Id of the sensor, as reported by the EC.
> + */
> +struct cros_ec_sensor_platform {
> +	u8 sensor_num;
> +};
> +
>  /* struct cros_ec_platform - ChromeOS EC platform information
>   *
>   * @ec_name: name of EC device (e.g. 'cros-ec', 'cros-pd', ...)
> 

