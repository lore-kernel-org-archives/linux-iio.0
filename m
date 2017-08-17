Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751620AbdHQPBD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 17 Aug 2017 11:01:03 -0400
Date: Thu, 17 Aug 2017 16:00:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org, linus.walleij@linaro.org,
        lorenzo.bianconi@st.com, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/5] iio: st_sensors: do not always write enable_axis
 register
Message-ID: <20170817160057.2f25fd92@archlinux>
In-Reply-To: <20170816191316.11469-3-lorenzo.bianconi@st.com>
References: <20170816191316.11469-1-lorenzo.bianconi@st.com>
        <20170816191316.11469-3-lorenzo.bianconi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 16 Aug 2017 21:13:13 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> New devices (e.g. LIS2DW12) enable all axis by default and do not export
> that capability in register map. Check if the enable_axis register
> address has been declared in st_sensor_settings map in order to verify if
> the driver needs to enable all sensor axis
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>

Sounds like the software guys have been feeding back what is useful
to the hardware team ;)

Anyhow, patch is fine.  Will pick up in V2.

Jonathan

> ---
>  drivers/iio/common/st_sensors/st_sensors_core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> index a26217b0604f..6331cc91e02d 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -221,11 +221,14 @@ EXPORT_SYMBOL(st_sensors_set_enable);
>  int st_sensors_set_axis_enable(struct iio_dev *indio_dev, u8 axis_enable)
>  {
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
> +	int err = 0;
>  
> -	return st_sensors_write_data_with_mask(indio_dev,
> +	if (sdata->sensor_settings->enable_axis.addr)
> +		err = st_sensors_write_data_with_mask(indio_dev,
>  				sdata->sensor_settings->enable_axis.addr,
>  				sdata->sensor_settings->enable_axis.mask,
>  				axis_enable);
> +	return err;
>  }
>  EXPORT_SYMBOL(st_sensors_set_axis_enable);
>  

