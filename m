Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42671 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750979AbdCYPHX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Mar 2017 11:07:23 -0400
Subject: Re: [PATCH 2/7] iio: cros_ec_sensors: Fix return value to get raw and
 calibbias data.
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lee Jones <lee.jones@linaro.org>,
        Olof Johansson <olof@lixom.net>, bleung@chromium.org
References: <20170324174407.25401-1-enric.balletbo@collabora.com>
 <20170324174407.25401-3-enric.balletbo@collabora.com>
Cc: martinez.javier@gmail.com, Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        rtc-linux@googlegroups.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <bac2ea92-bc32-cdcf-5fce-30909a05784e@kernel.org>
Date: Sat, 25 Mar 2017 15:07:19 +0000
MIME-Version: 1.0
In-Reply-To: <20170324174407.25401-3-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/03/17 17:44, Enric Balletbo i Serra wrote:
> The cros_ec_sensors_read function must return the type of value on all
> cases. This was always true except for RAW and CALIBBIAS data which
> returned an error or 0. This patch just fixes the mistake I introduced
> when submitting the series.
> 
> Fixes: commit c14dca07a31d (iio: cros_ec_sensors: add ChromeOS EC
> Contiguous Sensors driver)
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan
> ---
> 
>   This is another FIX, so would be interesting see it merged in this release
> cycle too. Like the above patch can be picked independently of the other
> patches and should go through IIO Jonathan's Cameron tree.
> 
>  drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> index d6c372b..c17596f 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> @@ -61,7 +61,7 @@ static int cros_ec_sensors_read(struct iio_dev *indio_dev,
>  		ret = st->core.read_ec_sensors_data(indio_dev, 1 << idx, &data);
>  		if (ret < 0)
>  			break;
> -
> +		ret = IIO_VAL_INT;
>  		*val = data;
>  		break;
>  	case IIO_CHAN_INFO_CALIBBIAS:
> @@ -76,7 +76,7 @@ static int cros_ec_sensors_read(struct iio_dev *indio_dev,
>  		for (i = CROS_EC_SENSOR_X; i < CROS_EC_SENSOR_MAX_AXIS; i++)
>  			st->core.calib[i] =
>  				st->core.resp->sensor_offset.offset[i];
> -
> +		ret = IIO_VAL_INT;
>  		*val = st->core.calib[idx];
>  		break;
>  	case IIO_CHAN_INFO_SCALE:
> 

