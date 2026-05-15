Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832E33E277A;
	Fri, 15 May 2026 19:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872852; cv=none; b=EqaXmvPUAaFixTy4Z6QvSTYOqy8YLOmQsecdLb5l8WAawl4PX34UJeiHN7qS6Ejsnd5RAOy1Jwz9yBKaQgDZyC2HACo75QqbODTZEh72ph7m4WR6gbazzeaXW/HtwmWXc/xnHhDC8KspsuqPm+OMUCCA6H1LsfDPps4NfgVKlkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872852; c=relaxed/simple;
	bh=g9luOAZQIlOMKkj2tUnIXZCX/r1kCQ5t04vIydNyo5c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XEJMtxhVbynkkIy8kZEbbOCgszWSERARDorvyX5v9LMy4GFTOFNuCowIq7sTMBLK0n7LuYcZZmG8nKGBoX70DSN9ebt/0fqk6bLzTKHiGlpRIKxC5g+4YpkDIz/RT/VTu0kid8PN6gM0d2wSp3tfb8NRBnYEwNqOAyjLKIl/mvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2kt7l+W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2kt7l+W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E81C2BCF6;
	Fri, 15 May 2026 19:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778872851;
	bh=g9luOAZQIlOMKkj2tUnIXZCX/r1kCQ5t04vIydNyo5c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n2kt7l+W2CBL8fIN9AS0PfqH+SapQ3BnEyHVcmn69/4DYk7h9B4Gixp2DDsFkqPpC
	 i28GAZYh/EE+vnpzPWbwE/Urly1n3TPx6OgWvM7Ykq/sVbdKvMB/FwJoVUPwNKmcJ0
	 sw2nCNCR07CmJWR3atQhEQrN8fhx1Cr1f2qC5KdpnwBtaAfHj1u754uNeEpTiskASU
	 7UioQrm3MXET4Y9DhgtMhus+4Z2bUywtY4/3YMv0fylkS0SINOoTE0jj3e+cXWbaMv
	 ougWJSVQHfnFq8t28GXP1tsdbW3WLQKLbPpMj/z0JgsLltmuiglD5+iwmMK+CbpEul
	 H1D6NNMSgNF1w==
Date: Fri, 15 May 2026 20:20:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V7 06/11] iio: imu: inv_icm42607: Add Buffer support for
 icm42607
Message-ID: <20260515202043.251a14fd@jic23-huawei>
In-Reply-To: <20260515130018.237378-7-macroalpha82@gmail.com>
References: <20260515130018.237378-1-macroalpha82@gmail.com>
	<20260515130018.237378-7-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 May 2026 08:00:11 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add all FIFO parsing and reading functions to support
> inv_icm42607 hardware.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Sashiko didn't do so well on this one so some of what it raised
looks wrong.  E.g. the fifo stuff where you are deliberately clearing
bits with the writes rather than 'accidentally' writing over them.


There is one odd misbalance in here for fifo_en() calls
that I'd like a some comments on in the code.
It's not unheard of that we can't deal with the complexity
of update_scan_mode() only occuring in setup path for buffers
but most of the time we can by pushing stuff to posteenable()
/predisable()

The model for how the buffer setup flow works vs tear down doesn't
quite fit everything despite there being a lot of possible callbacks
so what you have may well be the best that we can do.  However it
isn't obviously correct so a few comments please!

> ---
>  drivers/iio/imu/inv_icm42607/Makefile         |   1 +
>  drivers/iio/imu/inv_icm42607/inv_icm42607.h   |  27 +
>  .../imu/inv_icm42607/inv_icm42607_buffer.c    | 483 ++++++++++++++++++
>  .../imu/inv_icm42607/inv_icm42607_buffer.h    |  93 ++++
>  .../iio/imu/inv_icm42607/inv_icm42607_core.c  |  54 +-
>  5 files changed, 657 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.h
> 
> diff --git a/drivers/iio/imu/inv_icm42607/Makefile b/drivers/iio/imu/inv_icm42607/Makefile
> index be109102e203..3c9d08509793 100644
> --- a/drivers/iio/imu/inv_icm42607/Makefile
> +++ b/drivers/iio/imu/inv_icm42607/Makefile
> @@ -2,6 +2,7 @@
>  
>  obj-$(CONFIG_INV_ICM42607) += inv-icm42607.o
>  inv-icm42607-y += inv_icm42607_core.o
> +inv-icm42607-y += inv_icm42607_buffer.o
>  
>  obj-$(CONFIG_INV_ICM42607_I2C) += inv-icm42607-i2c.o
>  inv-icm42607-i2c-y += inv_icm42607_i2c.o
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> index 5f37999e39a5..b00ee6a4d451 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> @@ -14,6 +14,10 @@
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  
> +#include <linux/iio/common/inv_sensors_timestamp.h>
> +
> +#include "inv_icm42607_buffer.h"
> +
>  /* serial bus slew rates */
>  enum inv_icm42607_slew_rate {
>  	INV_ICM42607_SLEW_RATE_20_60NS,
> @@ -84,6 +88,7 @@ struct inv_icm42607_sensor_conf {
>  	int odr;
>  	int filter;
>  };
> +#define INV_ICM42607_SENSOR_CONF_INIT		{-1, -1, -1, -1}
Spaces after { and before } but perhaps more interestingly - why is this
here given I don't see it used in this patch?


> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c
> new file mode 100644
> index 000000000000..74e5213d9267
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c


> +
> +static int inv_icm42607_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
> +	struct device *dev = regmap_get_device(st->map);
> +	unsigned int sensor;
> +	unsigned int *watermark;
> +	unsigned int sleep_temp = 0;
> +	unsigned int sleep_sensor = 0;
> +	unsigned int sleep;
> +	int ret;
> +
> +	if (indio_dev == st->indio_gyro) {
> +		sensor = INV_ICM42607_SENSOR_GYRO;
> +		watermark = &st->fifo.watermark.gyro;
> +	} else if (indio_dev == st->indio_accel) {
> +		sensor = INV_ICM42607_SENSOR_ACCEL;
> +		watermark = &st->fifo.watermark.accel;
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&st->lock);
> +
> +	ret = inv_icm42607_buffer_set_fifo_en(st, st->fifo.en & ~sensor);

This is a little odd as normally I'd expect to see balance between
preenable and postdisable.

Seems you are unwinding stuff that ends up ultimately in update_scan_mode
If that's absolutely necessary (and you can't shift to the balanced calls
- given it's late in sequence postenable / predisable probably..)
then add a comment here.

> +	if (ret)
> +		goto out_unlock;
> +
> +	*watermark = 0;
> +	ret = inv_icm42607_buffer_update_watermark(st);
> +	if (ret)
> +		goto out_unlock;
> +
> +out_unlock:
> +	mutex_unlock(&st->lock);
> +
> +	/* sleep maximum required time */
> +	sleep = max(sleep_sensor, sleep_temp);
> +	if (sleep)
> +		msleep(sleep);

Maybe introduce this stuff only when the values are not 0.

> +
> +	pm_runtime_put_autosuspend(dev);
> +
> +	return ret;
> +}
> +
> +const struct iio_buffer_setup_ops inv_icm42607_buffer_ops = {
> +	.preenable = inv_icm42607_buffer_preenable,
> +	.postenable = inv_icm42607_buffer_postenable,
> +	.predisable = inv_icm42607_buffer_predisable,
> +	.postdisable = inv_icm42607_buffer_postdisable,
> +};
> +



> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> index e27ad0319a12..d5885fc3f7da 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> @@ -15,6 +15,7 @@
>  #include <linux/regulator/consumer.h>
>  
>  #include "inv_icm42607.h"
> +#include "inv_icm42607_buffer.h"
>  
>  static bool inv_icm42607_is_volatile_reg(struct device *dev, unsigned int reg)
>  {
> @@ -73,6 +74,40 @@ const struct inv_icm42607_hw inv_icm42607p_hw_data = {
>  };
>  EXPORT_SYMBOL_NS_GPL(inv_icm42607p_hw_data, "IIO_ICM42607");
>  
> +u32 inv_icm42607_odr_to_period(enum inv_icm42607_odr odr)
> +{
> +	static const u32 odr_periods[INV_ICM42607_ODR_NB] = {
> +		/* Reserved values */
> +		0, 0, 0, 0, 0,
> +		/* 1600Hz */
[INV_ICM42607_ODR_1600HZ] = 625000,
etc and drop the comments.

> +		625000,
> +		/* 800Hz */
> +		1250000,
> +		/* 400Hz */
> +		2500000,
> +		/* 200Hz */
> +		5000000,
> +		/* 100 Hz */
> +		10000000,
> +		/* 50Hz */
> +		20000000,
> +		/* 25Hz */
> +		40000000,
> +		/* 12.5Hz */
> +		80000000,
> +		/* 6.25Hz */
> +		160000000,
> +		/* 3.125Hz */
> +		320000000,
> +		/* 1.5625Hz */
> +		640000000,
> +	};
> +
> +	odr = clamp(odr, INV_ICM42607_ODR_1600HZ, INV_ICM42607_ODR_1_5625HZ_LP);

Then this clamp will be more obviously correct.

> +
> +	return odr_periods[odr];
> +}

