Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35736 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767AbaDWVU2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 23 Apr 2014 17:20:28 -0400
Message-ID: <53582EF3.2040307@kernel.org>
Date: Wed, 23 Apr 2014 22:21:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Linus Walleij <linus.walleij@linaro.org>,
	linux-iio@vger.kernel.org, Denis CIOCCA <denis.ciocca@st.com>
CC: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/6] iio: st_sensors: announce registered sensors
References: <1397416143-4396-1-git-send-email-linus.walleij@linaro.org> <1397416143-4396-2-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1397416143-4396-2-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/04/14 20:08, Linus Walleij wrote:
> It is pretty helpful to know already from dmesg that a certain
> device is successfully registered, instead of having to browse
> sysfs to see if it's actually there.
>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Denis CIOCCA <denis.ciocca@st.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

hmm.. Normally I get irritated with these sorts of I'm here
messages - it's not exactly hard to tell it has been successfully
probed without filling the logs with messages fairly light on
info.  Having said that I tend to let these go in new drivers
so I don't care that strongly...


> ---
>   drivers/iio/accel/st_accel_core.c       | 3 +++
>   drivers/iio/gyro/st_gyro_core.c         | 3 +++
>   drivers/iio/magnetometer/st_magn_core.c | 3 +++
>   drivers/iio/pressure/st_pressure_core.c | 3 +++
>   4 files changed, 12 insertions(+)
>
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index 38caedc76b98..4e06fcf5b891 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -496,6 +496,9 @@ int st_accel_common_probe(struct iio_dev *indio_dev,
>   	if (err)
>   		goto st_accel_device_register_error;
>
> +	dev_info(&indio_dev->dev, "registered accelerometer %s\n",
> +		 indio_dev->name);
> +
>   	return 0;
>
>   st_accel_device_register_error:
> diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
> index a8e174a47bc4..bc71f4d1e2ce 100644
> --- a/drivers/iio/gyro/st_gyro_core.c
> +++ b/drivers/iio/gyro/st_gyro_core.c
> @@ -344,6 +344,9 @@ int st_gyro_common_probe(struct iio_dev *indio_dev,
>   	if (err)
>   		goto st_gyro_device_register_error;
>
> +	dev_info(&indio_dev->dev, "registered gyroscope %s\n",
> +		 indio_dev->name);
> +
>   	return 0;
>
>   st_gyro_device_register_error:
> diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
> index 52bbcfa1e077..8e33a7682d33 100644
> --- a/drivers/iio/magnetometer/st_magn_core.c
> +++ b/drivers/iio/magnetometer/st_magn_core.c
> @@ -387,6 +387,9 @@ int st_magn_common_probe(struct iio_dev *indio_dev,
>   	if (err)
>   		goto st_magn_device_register_error;
>
> +	dev_info(&indio_dev->dev, "registered magnetometer %s\n",
> +		 indio_dev->name);
> +
>   	return 0;
>
>   st_magn_device_register_error:
> diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
> index 7418768ed49c..013becbe8f47 100644
> --- a/drivers/iio/pressure/st_pressure_core.c
> +++ b/drivers/iio/pressure/st_pressure_core.c
> @@ -474,6 +474,9 @@ int st_press_common_probe(struct iio_dev *indio_dev,
>   	if (err)
>   		goto st_press_device_register_error;
>
> +	dev_info(&indio_dev->dev, "registered pressure sensor %s\n",
> +		 indio_dev->name);
> +
>   	return err;
>
>   st_press_device_register_error:
>

