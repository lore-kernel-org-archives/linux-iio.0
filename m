Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756206AbdJJTma (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 10 Oct 2017 15:42:30 -0400
Date: Tue, 10 Oct 2017 20:40:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: common: st_sensors: check odr address value in
 st_sensors_set_odr()
Message-ID: <20171010204001.76065029@archlinux>
In-Reply-To: <20170917161712.14645-3-lorenzo.bianconi@st.com>
References: <20170917161712.14645-1-lorenzo.bianconi@st.com>
        <20170917161712.14645-3-lorenzo.bianconi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 17 Sep 2017 18:17:10 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> Do not try to configure sample frequency if the sensor do not export
> odr register address in register map. That change will be used to
> properly support LIS3DHH accel sensor.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/common/st_sensors/st_sensors_core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> index 40dfdfc0906b..57db19182e95 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -93,6 +93,9 @@ int st_sensors_set_odr(struct iio_dev *indio_dev, unsigned int odr)
>  	struct st_sensor_odr_avl odr_out = {0, 0};
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
>  
> +	if (!sdata->sensor_settings->odr.addr)
> +		return 0;
> +
>  	err = st_sensors_match_odr(sdata->sensor_settings, odr, &odr_out);
>  	if (err < 0)
>  		goto st_sensors_match_odr_error;

