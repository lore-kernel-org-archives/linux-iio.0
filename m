Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B79A3E866C;
	Mon,  4 May 2026 18:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777919199; cv=none; b=gH0SuY7zVvSgHxGIag6oyaXl2o8ki58n6IbtFduGHWJDEO6fa9wzG0md5LnGmExrblYjehiDNruo+KJjMmWrh/0tBkC67vSyJ6RcIzGNusZCEkZGwEgA+9gxP3Zke1p9BPtCyBm6dZrqILhdZPHtt1B6N68hmXapDaxrXVAeA6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777919199; c=relaxed/simple;
	bh=37Ot73A4fj0D5GowVRnxYtFfCqaZs359WtRnBjznzU4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u0Wlbw9VVzBtnBMqNjnAG6n8y7HNIxocv/I7IiJcKANJbP0+pvxsbV/taGhgQwZFsEnfNEY5ehX8a4D2HBzU1iA7JWRdAb3doUUPDuPYHOBVIY9IlSxKO9t5GwilCvNbnpGN5r2xRTi/EQ0uXT3NLkEA59br982eIMDw5gEts8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSUwpjzn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSUwpjzn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB13C2BCB8;
	Mon,  4 May 2026 18:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777919199;
	bh=37Ot73A4fj0D5GowVRnxYtFfCqaZs359WtRnBjznzU4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qSUwpjznKGAEqwntxKcoOXrL6pCU2OsVZgZuRu6sMWy9TTRqw3IMQ/wn3Y+83vmIL
	 16i17TFaz5Fpup7d0XO/401IatwBwzUCAYQuSM8FQhZzvwUcidtPMOboOK8mW/Bhnz
	 Zr51HKy1HPDSSBQo/OOUn/h0SmqU9TY7QO0KFA9x/F4ceOudefmw+828sa6T0shDJq
	 /ZjEPFj6LEeQrb4udjSwJ/p9tKPY+N/M6AIR0hYc/pQHjbry8JHkcFX0nYZfvd/K7d
	 hdRu6Y3pMUuB/FPGz3scfHV189Z0poxi3nHnDnD2sViGH6x+NRGqABpjtxytX2lKDF
	 1A5a8EQBsaDeQ==
Date: Mon, 4 May 2026 19:26:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V4 04/10] iio: imu: inv_icm42607: Add PM support for
 icm42607
Message-ID: <20260504192629.64e2f1d9@jic23-huawei>
In-Reply-To: <20260501221152.194251-5-macroalpha82@gmail.com>
References: <20260501221152.194251-1-macroalpha82@gmail.com>
	<20260501221152.194251-5-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  1 May 2026 17:11:43 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add power management support for the ICM42607 device driver.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>

I think this suffers from usual problem we get when runtime_pm
handles a regulator that we are also registering to be turned off
via devm.  That devm path needs to check if device is already runtime
suspended. Be careful about paths in probe() where we might check
runtime suspend state that isn't set yet.

https://sashiko.dev/#/patchset/20260501221152.194251-1-macroalpha82%40gmail.com
Has quite a bit to say no the series in general. It may
not always be right but some of the stuff in this patch is.

> ---
>  drivers/iio/imu/inv_icm42607/inv_icm42607.h   |   2 +
>  .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 177 ++++++++++++++++++
>  .../iio/imu/inv_icm42607/inv_icm42607_i2c.c   |   1 +
>  .../iio/imu/inv_icm42607/inv_icm42607_spi.c   |   1 +
>  4 files changed, 181 insertions(+)
> 
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> index 763d731ccc60..7facc114adc5 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> @@ -11,6 +11,7 @@
>  #include <linux/iio/common/inv_sensors_timestamp.h>
>  #include <linux/iio/iio.h>
>  #include <linux/mutex.h>
> +#include <linux/pm.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  
> @@ -390,6 +391,7 @@ struct inv_icm42607_sensor_state {
>  typedef int (*inv_icm42607_bus_setup)(struct inv_icm42607_state *);
>  
>  extern const struct regmap_config inv_icm42607_regmap_config;
> +extern const struct dev_pm_ops inv_icm42607_pm_ops;
>  
>  u32 inv_icm42607_odr_to_period(enum inv_icm42607_odr odr);
>  
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> index 1ac3a573863c..af3784040b7a 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> @@ -9,6 +9,7 @@
>  #include <linux/irq.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
> @@ -106,6 +107,62 @@ u32 inv_icm42607_odr_to_period(enum inv_icm42607_odr odr)
>  	return odr_periods[odr];
>  }
>  
> +static int inv_icm42607_set_pwr_mgmt0(struct inv_icm42607_state *st,
> +				      enum inv_icm42607_sensor_mode gyro,
> +				      enum inv_icm42607_sensor_mode accel,
> +				      bool temp, unsigned int *sleep_ms)
> +{
> +	enum inv_icm42607_sensor_mode oldgyro = st->conf.gyro.mode;
> +	enum inv_icm42607_sensor_mode oldaccel = st->conf.accel.mode;
> +	bool oldtemp = st->conf.temp_en;
> +	unsigned int sleepval;
> +	unsigned int val;
> +	int ret;
> +
> +	if (gyro == oldgyro && accel == oldaccel && temp == oldtemp)
> +		return 0;
> +
> +	val = FIELD_PREP(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, gyro);
> +	val |= FIELD_PREP(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, accel);
> +	if (!temp)
> +		val |= INV_ICM42607_PWR_MGMT0_ACCEL_LP_CLK_SEL;
> +	ret = regmap_write(st->map, INV_ICM42607_REG_PWR_MGMT0, val);
> +	if (ret)
> +		return ret;
> +
> +	st->conf.gyro.mode = gyro;
> +	st->conf.accel.mode = accel;
> +	st->conf.temp_en = temp;
> +
> +	sleepval = 0;
> +	if (temp && !oldtemp) {
> +		if (sleepval < INV_ICM42607_TEMP_STARTUP_TIME_MS)
> +			sleepval = INV_ICM42607_TEMP_STARTUP_TIME_MS;
> +	}
> +	if (accel != oldaccel && oldaccel == INV_ICM42607_SENSOR_MODE_OFF) {
> +		usleep_range(200, 300);
> +		if (sleepval < INV_ICM42607_ACCEL_STARTUP_TIME_MS)
> +			sleepval = INV_ICM42607_ACCEL_STARTUP_TIME_MS;
> +	}
> +	if (gyro != oldgyro) {
> +		if (oldgyro == INV_ICM42607_SENSOR_MODE_OFF) {
> +			usleep_range(200, 300);
> +			if (sleepval < INV_ICM42607_GYRO_STARTUP_TIME_MS)
> +				sleepval = INV_ICM42607_GYRO_STARTUP_TIME_MS;
> +		} else if (gyro == INV_ICM42607_SENSOR_MODE_OFF) {
> +			if (sleepval < INV_ICM42607_GYRO_STOP_TIME_MS)
> +				sleepval = INV_ICM42607_GYRO_STOP_TIME_MS;
> +		}
> +	}
> +
> +	if (sleep_ms)
> +		*sleep_ms = sleepval;
> +	else if (sleepval)
> +		msleep(sleepval);
> +
> +	return 0;
> +}
> +
>  int inv_icm42607_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
>  			     unsigned int writeval, unsigned int *readval)
>  {
> @@ -313,10 +370,130 @@ int inv_icm42607_core_probe(struct regmap *regmap, int chip,
>  	if (ret)
>  		return ret;
>  
> +	ret = devm_pm_runtime_set_active_enabled(dev);

This will interact with the status setup you need as mentioned above for devm
code to work right.

> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_set_autosuspend_delay(dev, INV_ICM42607_SUSPEND_DELAY_MS);
> +	pm_runtime_use_autosuspend(dev);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(inv_icm42607_core_probe, "IIO_ICM42607");
>  
> +/*
> + * Suspend saves sensors state and turns everything off.
> + * Check first if runtime suspend has not already done the job.
> + */
> +static int inv_icm42607_suspend(struct device *dev)
> +{
> +	struct inv_icm42607_state *st = dev_get_drvdata(dev);
> +	struct device *accel_dev;
> +	bool wakeup;
> +	int accel_conf;
> +	int ret = 0;

Always set before use so no need to init here.

> +
> +	guard(mutex)(&st->lock);
> +
> +	st->suspended.gyro = st->conf.gyro.mode;
> +	st->suspended.accel = st->conf.accel.mode;
> +	st->suspended.temp = st->conf.temp_en;
> +	if (pm_runtime_suspended(dev))
> +		return 0;
> +
> +	/* keep chip on and wake-up capable if APEX and wakeup on */
> +	accel_dev = &st->indio_accel->dev;

Never set at this point in series. (Sashiko raised this)


> +	wakeup = st->apex.on && device_may_wakeup(accel_dev);
> +	if (wakeup) {
> +		/* keep accel on and setup irq for wakeup */
> +		accel_conf = st->conf.accel.mode;
> +		enable_irq_wake(st->irq);
> +		disable_irq(st->irq);
> +	} else {
> +		accel_conf = INV_ICM42607_SENSOR_MODE_OFF;
> +	}
> +
> +	ret = inv_icm42607_set_pwr_mgmt0(st, INV_ICM42607_SENSOR_MODE_OFF,
> +					 INV_ICM42607_SENSOR_MODE_OFF, false,
> +					 NULL);
> +	if (ret)
> +		return ret;
> +
> +	if (!wakeup)
> +		regulator_disable(st->vddio_supply);
> +
> +	return 0;
> +}
