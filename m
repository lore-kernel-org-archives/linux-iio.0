Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E560D391E51;
	Wed,  1 Jul 2026 19:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934101; cv=none; b=ei7gqXq7p6NzJZNA3EB9BRNvQGLy0vSENJ4Zmxxb/vlIORV+bVGNFnt+6zhBKB/5940wm6U+uK8hV1eBi9M/t/eRZgGl5/TyhxcBNaXvriG1vy3BSuB8cWa0ltsXy6bs2wr9sreHS0x34xvCbSnDrct5YO3jvLak90hnhrWpAKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934101; c=relaxed/simple;
	bh=l+Zt4rADwSWjzinK5yr5doPXukX2BwnsXorf7iE27gg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kf5ne8yqiXM0iE3/emxp0wYbb88gwXr0lYP6FIP3lQUD/5VINeYGzGR2RgXsI3F2b0yu/i2uxBz82+2OMB0BAxFm1j5uq+aZnOOJevo2tq/PubAxfRKAOJYJpufvoWCSRPVvz3ZdE9qe7Ap7fcq0fcdwex28rPvlcsVa+FkNpcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFUGKGUf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFUGKGUf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD451F000E9;
	Wed,  1 Jul 2026 19:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782934100;
	bh=iiQkD6eWK/0FeR93e8iCJjwPRC2KuodqjyurzLXQu1o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IFUGKGUfO42vn8pd0ZwhKuqfYjuTFFk6cf1ZFpR124BopVtq2noxWtTUy2VuGuMaD
	 KywAhUPbKqz4cxG3p96HmzFCwDR0ihoMJZsUfV+az4HwDWZk45Q4ceTV/zbEoZq9pK
	 9WhEmBihV+eL8tJEnTakXhk8zZqEdqsa54wFOA9oyfFkFWcm/iOMRzaDADOhuYomFB
	 m0ILiklo2zPSjaQR5vb4QHBpuBH+Z3iDEr1CPrNOPjZn0l8MocG/wIfrZ8CfnnKj5+
	 y68E7OBLU/qBYUeiW7B6TwswdPPZxtCNUhuHpFW/gCVpth7lsFGbnRDfTuanoWNbG/
	 8VzzIaiTCHC8g==
Date: Wed, 1 Jul 2026 20:28:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V15 7/9] iio: imu: inv_icm42607: Add Gyroscope to
 icm42607
Message-ID: <20260701202815.7d930b56@jic23-huawei>
In-Reply-To: <20260626161230.93069-8-macroalpha82@gmail.com>
References: <20260626161230.93069-1-macroalpha82@gmail.com>
	<20260626161230.93069-8-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jun 2026 11:12:28 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add gyroscope functions to the icm42607 driver.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Similar comments to those in the accel driver.

Thanks,

Jonathan

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
> new file mode 100644
> index 000000000000..c7215b3826ad
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c

> +static int inv_icm42607_gyro_read_odr(struct inv_icm42607_state *st,
> +				      int *val, int *val2)
> +{
> +	unsigned int odr;
> +	unsigned int i;
> +
> +	guard(mutex)(&st->lock);
> +
> +	odr = st->conf.gyro.odr;
> +
> +	for (i = 5; i < ARRAY_SIZE(inv_icm42607_gyro_odr); ++i) {
> +		if (i == odr)

As below.

> +
> +static int inv_icm42607_gyro_write_odr(struct iio_dev *indio_dev,
> +				       int val, int val2)
> +{
> +	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
> +	struct device *dev = regmap_get_device(st->map);
> +	unsigned int idx;
> +	struct inv_icm42607_sensor_conf conf = INV_ICM42607_SENSOR_CONF_INIT;
> +	int ret;
> +
> +	for (idx = 5; idx < ARRAY_SIZE(inv_icm42607_gyro_odr); ++idx) {

Similar comments to accel. Use the appropriate define for that 5 and
post increment.

> +		if (val == inv_icm42607_gyro_odr[idx][0] &&
> +		    val2 == inv_icm42607_gyro_odr[idx][1])
> +			break;
> +	}

> +static int inv_icm42607_gyro_read_avail(struct iio_dev *indio_dev,
> +					struct iio_chan_spec const *chan,
> +					const int **vals,
> +					int *type, int *length, long mask)
> +{
> +	if (chan->type != IIO_ANGL_VEL)

This was the one sashiko noted was less than ideal as it rules out
reading this for temperature channels - in practice that doesn't happen
but that is due to an internal detail of how we create shared_by_all
attributes. The code should support reading for temperature channels as well.

> +		return -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		*vals = (const int *)inv_icm42607_gyro_scale_nano;
> +		*type = IIO_VAL_INT_PLUS_NANO;
> +		*length = ARRAY_SIZE(inv_icm42607_gyro_scale_nano) * 2;
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*vals = (const int *)inv_icm42607_gyro_odr[5];
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		*length = (ARRAY_SIZE(inv_icm42607_gyro_odr) - 5) * 2;
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}


