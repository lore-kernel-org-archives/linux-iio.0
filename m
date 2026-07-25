Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD5B2D47FF;
	Sat, 25 Jul 2026 00:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784938563; cv=none; b=gRqeYnxKnKXwpGRUUjcE8fbceEvlFKDmfixXQTexjoRzaAJZ+D2OP3stN47vYCsLprW9M4vV5ZWSV0m19bQKsaRa8d0MYQptwudSm7sypUJZDKhpqec0DJw3II2KiVXY8qyOxyy7orf7yVKuNWACcRqh44jbM8zb/noWLyc0zLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784938563; c=relaxed/simple;
	bh=nkibiMoFRfoJwLCOR+drP74l8XzTsvLx2px19u9uUFs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TmtL4rFQ91S/+prHAILypvuP2rdzTLGEnPhdQm1vAP72afkl7IwaVI0biDSBzRUg3G9Y/ZBJlJi4t6DteAkimA5eNYAucLEiE275cQAMW2hroGl+HNbsO0dFj1ntg3Oo9Ggpl6dYyUohGEWMMfYRT1fGLmWpY46ut3Ad/g6ed+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuea54eO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuea54eO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 215DA1F000E9;
	Sat, 25 Jul 2026 00:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784938562;
	bh=IsJR6O4cuUuSOESjrdR4auMydcz5x6NXnnJ1/M2/xJA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cuea54eOm7lnglQkdpRO21NteRgYUfWpV/D3jxu65QN4+PRV9usGaMC1kF1poAun1
	 1jJ9sPI1RcypBFh4jkVcFl99jvA9GqM9UiLOgyLkhWLFHfdR2W8HOM/N+zLxPSib+c
	 8aJj2moBh0nneD/Xn6kBRLR8WKedGWUqUT3vb1FLIGPZVW+xSfTrHrVheOD/1nEOmc
	 ocx0ZDWkq/BYmz3LfiDpMaPOI0uOWPUeh3yGx/ofxa5Kh4wwU7xpsnaNhZd5HUcabh
	 7mUolWVJPS5xBovyC71JsAvuI0FfKDrLiBxC4Oo9uFXju3uNAJfNUo/yDdWXk8vcfK
	 /0m0PLhqPuHwA==
Date: Sat, 25 Jul 2026 01:15:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V19 5/9] iio: imu: inv_icm42607: Add PM support for
 icm42607
Message-ID: <20260725011557.2336b2cd@jic23-huawei>
In-Reply-To: <20260722153942.144387-6-macroalpha82@gmail.com>
References: <20260722153942.144387-1-macroalpha82@gmail.com>
	<20260722153942.144387-6-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jul 2026 10:39:36 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add power management support for the ICM42607 device driver.

Not quite as you've probably noticed from sashiko commenting
again on the cleanup :(

Power management sequences are annoyingly fiddly to get right.
I keep meaning to find some time to bother explore all the common
scenarios and write up patterns that are appropriate for each one.
Never get the time unfortunately.

> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  drivers/iio/imu/inv_icm42607/inv_icm42607.h   |  16 ++
>  .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 173 ++++++++++++++++++
>  .../iio/imu/inv_icm42607/inv_icm42607_i2c.c   |  10 +
>  .../iio/imu/inv_icm42607/inv_icm42607_spi.c   |  10 +
>  4 files changed, 209 insertions(+)


> index 6ec1d730017e..d85eaedef070 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
...
> +
> +static int inv_icm42607_set_pwr_mgmt0(struct inv_icm42607_state *st,
> +				      enum inv_icm42607_sensor_mode gyro,
> +				      enum inv_icm42607_sensor_mode accel)
> +{
> +	enum inv_icm42607_sensor_mode oldaccel, oldgyro;
> +	unsigned int sleepval_us;
> +	unsigned int val;
> +	s64 disable_wait;
> +	int ret;
> +
> +	ret = inv_icm42607_get_pwr_mgmt0(st, &oldgyro, &oldaccel);
> +	if (ret)
> +		return ret;
> +
> +	if (gyro == oldgyro && accel == oldaccel)
> +		return 0;
> +
> +	/*
> +	 * Datasheet on page 14.26 says we need to ensure the gyro sensor is on
> +	 * for a minimum of 45ms. So if we transition from an on state to an
> +	 * off state make sure at least 45ms have passed before power off and
> +	 * wait if it hasn't. In case some platforms don't respond well to a
> +	 * sleep of 0, make sure the fsleep duration is > 0.
> +	 */
> +	if (!gyro && oldgyro) {
> +		disable_wait = clamp(ktime_us_delta(st->conf.gyro_stop, ktime_get()),
> +				     0, INV_ICM42607_GYRO_STOP_TIME_US);
> +
> +		if (disable_wait > 0)
> +			fsleep(disable_wait);
> +	}
> +
> +	val = FIELD_PREP(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, gyro) |
> +	      FIELD_PREP(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, accel);
> +	ret = regmap_write(st->map, INV_ICM42607_REG_PWR_MGMT0, val);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * If a state change occurs from off to on, sleep for the startup
> +	 * time of the sensor, unless a sleep_ms is specified. Since more
> +	 * than one sensor can be transitioned from off to on, select the
> +	 * maximum time from each of the sensors changing from off to on.
> +	 * The startup time for the temp sensor is considerably smaller
> +	 * than the startup time for the other sensors and one or more are
> +	 * required to be on for the temp sensor to function, so any start
> +	 * delay should be enough.
> +	 */
> +	sleepval_us = 0;
> +	if (accel && !oldaccel)
> +		sleepval_us = max(sleepval_us, INV_ICM42607_ACCEL_STARTUP_TIME_US);
> +
> +	if (gyro && !oldgyro) {
> +		sleepval_us = max(sleepval_us, INV_ICM42607_GYRO_STARTUP_TIME_US);
> +		/* Track the earliest we can turn off the gyroscope. */
> +		st->conf.gyro_stop = ktime_add_us(ktime_get(),
> +						  INV_ICM42607_GYRO_STOP_TIME_US);
> +	}
> +
> +	/*
> +	 * Only sleep if sleepval_us is greater than 0 in case some
> +	 * platforms have issues with a 0 delay. The 0 delay can happen

Trivial but wrap comments to 80 chars unless there is some other reason.

> +	 * if one or both sensors is shut down.
> +	 */
> +	if (sleepval_us > 0)
> +		fsleep(sleepval_us);
> +
> +	return 0;
> +}

>  int inv_icm42607_core_probe(struct regmap *regmap,
> @@ -240,6 +352,8 @@ int inv_icm42607_core_probe(struct regmap *regmap,
>  	if (!st)
>  		return -ENOMEM;
>  
> +	dev_set_drvdata(dev, st);
> +
>  	ret = devm_mutex_init(dev, &st->lock);
>  	if (ret)
>  		return ret;
> @@ -275,10 +389,69 @@ int inv_icm42607_core_probe(struct regmap *regmap,
>  	if (ret)
>  		return ret;
>  

So for the devm_add_action_or_reset() it probably wants to be somewhere near
here as I'd assume the power down effectively undoes something that starts
from setup?  If it is coupled to nothing at all (can happen if power up
only occurs later due to userspace input) then put it at the end of probe
with a comment saying why it is there.


> +	ret = devm_pm_runtime_set_active_enabled(dev);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_set_autosuspend_delay(dev, INV_ICM42607_SUSPEND_DELAY_MS);
> +	pm_runtime_use_autosuspend(dev);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(inv_icm42607_core_probe, "IIO_ICM42607");



> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
> index f2b9067815b0..4a8e4f716803 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
> @@ -8,6 +8,7 @@
>  #include <linux/err.h>
>  #include <linux/i2c.h>
>  #include <linux/module.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  
>  #include "inv_icm42607.h"
> @@ -56,6 +57,13 @@ static int inv_icm42607_probe(struct i2c_client *client)
>  	return inv_icm42607_core_probe(regmap, hw, inv_icm42607_i2c_bus_setup);
>  }
>  
> +static void inv_icm42607_i2c_remove(struct i2c_client *client)

Sorry but no this is not the way to solve the pm dance.
As Sashiko points out mixing devm and not like this is a path to pain.

The usual solution to this is to use a devm_add_action_or_reset()
at appropriate place in probe.  When runtime pm is involved it can
get complex.  There are various options, but often the easiest is
to add a driver flag that says if the device is powered off and
just check it before powering down.

> +{
> +	struct inv_icm42607_state *st = dev_get_drvdata(&client->dev);
> +
> +	inv_icm42607_sensors_off(st);
> +}

...

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
> index eb04036a6712..99e112c958a0 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
> @@ -7,6 +7,7 @@
>  #include <linux/dev_printk.h>
>  #include <linux/err.h>
>  #include <linux/module.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/spi/spi.h>
>  
> @@ -65,6 +66,13 @@ static int inv_icm42607_probe(struct spi_device *spi)
>  	return inv_icm42607_core_probe(regmap, hw, inv_icm42607_spi_bus_setup);
>  }
>  
> +static void inv_icm42607_spi_remove(struct spi_device *spi)
> +{
> +	struct inv_icm42607_state *st = dev_get_drvdata(&spi->dev);
> +
> +	inv_icm42607_sensors_off(st);
> +}

Same issue - Remove here ends up out of sequence with the runtime pm disable
handled by devm cleanup. It needs to be a custom devm callback so it
can be done in right order using that infrastructure.

Thanks,

Jonathan

