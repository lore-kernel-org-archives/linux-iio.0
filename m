Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B453B3403F4;
	Wed, 20 May 2026 17:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297245; cv=none; b=AASlHm4aQ7XErf22Loq4BdYWbMZCYf/yAXlu5sanXC9SEqRNHfrnBv5yOLVB5rlJI11raS9NrCFPvxP/0EnCLR1f6oibiyB80NAi0EXDM7tmxtAy6fFzoDwh4sPeeT4yEYMsKDV8mYxz15lvS6B4ouLBEcXMtb/o+OAc1pnKEhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297245; c=relaxed/simple;
	bh=EY94YMO9sHh4f4g0Z+qFJvxAsJyptKw8eW7DQ9sIwpU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YwmUr9CCYWZkE+g3VYpDUEzvAdVG02QpTkAsom+R3poUdSTu0AW40c6lQyG9IF5QSFubw3wu6EKvLMgLzFPrbKL1seq86HKWa8ePuDZg3D0wZiQ+pKsxq2pCAQzrzmkf5VwAsSWngWvJw5df8IvVuO1gyFqdtSYp5tjdEPce9g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLNG1H6n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLNG1H6n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04C11F00894;
	Wed, 20 May 2026 17:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779297243;
	bh=O9qgPLHr7QL0P1uZ8nEtWqDN2bcDhBU6RkhI9zGyM4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HLNG1H6nlR1VlzFKDngGW+MuSrpjMZCAftunfsuU+/dDKM7Mr0NDVEl8YYg9yoxlZ
	 qxfMquRjwL2m3+CHL97Xhmr8fEeVFMrUhgh30TuW6eTENshYdZL7RqCBSaoFIrHCKT
	 F7UEwfs3PMCMsLE+o2V+ntBIceDoyAjyFBWhxZvi4IUfCTcrVjXbWawcPp+c313L++
	 KFGxGlZn8nQSqhOXHas4A1DkSwEYVazcmvHl7bvcMHEdgee/hnPEKF0rmO+dYhAk9r
	 25DJVUDrTr/b2G9KtxI8ZKmWkkVT7oyK8aSBoprpY/tmQcs7DbZCqDiEVgUkMrph7m
	 pRY0bZo8EeBgA==
Date: Wed, 20 May 2026 18:13:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V8 05/10] iio: imu: inv_icm42607: Add PM support for
 icm42607
Message-ID: <20260520181353.0a0371cb@jic23-huawei>
In-Reply-To: <20260518200526.458421-6-macroalpha82@gmail.com>
References: <20260518200526.458421-1-macroalpha82@gmail.com>
	<20260518200526.458421-6-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 15:05:20 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add power management support for the ICM42607 device driver.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>

Hi Chris,  runtime PM is my current place to look closest
for bugs because we've had a lot of them recently.

Anyhow, took another look and here I think we can optimize
things a little more.

> ---
>  drivers/iio/imu/inv_icm42607/inv_icm42607.h   |  18 +++
>  .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 147 ++++++++++++++++++
>  .../iio/imu/inv_icm42607/inv_icm42607_i2c.c   |   1 +
>  .../iio/imu/inv_icm42607/inv_icm42607_spi.c   |   1 +
>  4 files changed, 167 insertions(+)
> 
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> index 74d8d3d7c890..b05828415053 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> @@ -10,6 +10,7 @@
>  #include <linux/bitops.h>
>  #include <linux/iio/iio.h>
>  #include <linux/mutex.h>
> +#include <linux/pm.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  
> @@ -96,24 +97,34 @@ struct inv_icm42607_hw {
>  	const struct inv_icm42607_conf *conf;
>  };
>  
> +struct inv_icm42607_suspended {
> +	enum inv_icm42607_sensor_mode gyro;
> +	enum inv_icm42607_sensor_mode accel;
> +	bool temp;
> +};
> +
>  /**
>   *  struct inv_icm42607_state - driver state variables
>   *  @lock:		lock for serializing multiple registers access.
>   *  @hw:		Hardware specific data.
>   *  @map:		regmap pointer.
>   *  @vddio_supply:	I/O voltage regulator for the chip.
> + *  @vddio_en:		I/O voltage status for runtime PM.
>   *  @irq:		chip irq, required to enable/disable and set wakeup
>   *  @orientation:	sensor chip orientation relative to main hardware.
>   *  @conf:		chip sensors configurations.
> + *  @suspended:		suspended sensors configuration.
>   */
>  struct inv_icm42607_state {
>  	struct mutex lock;
>  	const struct inv_icm42607_hw *hw;
>  	struct regmap *map;
>  	struct regulator *vddio_supply;
> +	bool vddio_en;
>  	int irq;
>  	struct iio_mount_matrix orientation;
>  	struct inv_icm42607_conf conf;
> +	struct inv_icm42607_suspended suspended;

Is this used?  If not bring it in only when needed.

>  };

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> index e9c81b52f9ef..bc0cefa2fb77 100644
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
> @@ -72,6 +73,62 @@ const struct inv_icm42607_hw inv_icm42607p_hw_data = {
>  };
>  EXPORT_SYMBOL_NS_GPL(inv_icm42607p_hw_data, "IIO_ICM42607");
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
		sleepval = max(sleepval,)
or just assign it here if not later patches add stuff in between
the assignment to 0 and here.
> +	}
> +	if (accel != oldaccel && oldaccel == INV_ICM42607_SENSOR_MODE_OFF) {
> +		usleep_range(200, 300);

fsleep() + add a comment on why we are sleeping in here.

> +		if (sleepval < INV_ICM42607_ACCEL_STARTUP_TIME_MS)
> +			sleepval = INV_ICM42607_ACCEL_STARTUP_TIME_MS;
		sleepval = max(sleepval, INV...);

> +	}
> +	if (gyro != oldgyro) {
> +		if (oldgyro == INV_ICM42607_SENSOR_MODE_OFF) {
> +			usleep_range(200, 300);

fsleep()

> +			if (sleepval < INV_ICM42607_GYRO_STARTUP_TIME_MS)
> +				sleepval = INV_ICM42607_GYRO_STARTUP_TIME_MS;
I'd use max for these as well.

> +		} else if (gyro == INV_ICM42607_SENSOR_MODE_OFF) {
> +			if (sleepval < INV_ICM42607_GYRO_STARTUP_TIME_MS)
> +				sleepval = INV_ICM42607_GYRO_STARTUP_TIME_MS;
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

>  
> +static int inv_icm42607_suspend(struct device *dev)
> +{
> +	struct inv_icm42607_state *st = dev_get_drvdata(dev);
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
Could you use pm_runtime_force_suspend()?
> +	if (pm_runtime_suspended(dev))
> +		return 0;
> +
> +	ret = inv_icm42607_set_pwr_mgmt0(st, INV_ICM42607_SENSOR_MODE_OFF,
> +					 INV_ICM42607_SENSOR_MODE_OFF,
> +					 false, NULL);
> +	if (ret)
> +		return ret;
> +
> +	inv_icm42607_disable_vddio_reg(st);
> +
> +	return 0;
> +}
> +
> +static int inv_icm42607_resume(struct device *dev)
> +{
> +	struct inv_icm42607_state *st = dev_get_drvdata(dev);
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
Given the bunch of stuff we've run into recently around these
I'm getting more paranoid.
Similar to above, could you use pm_runtime_force_resume()
You would need to gate stuff added later to not occur
though if it wasn't runtime suspended.


> +	if (pm_runtime_suspended(dev))
> +		return 0;
> +
> +	ret = inv_icm42607_enable_vddio_reg(st);
> +	if (ret)
> +		return ret;
> +
> +	/* Nothing else to restore at this time. */
> +
> +	return 0;
> +}
> +
> +static int inv_icm42607_runtime_suspend(struct device *dev)
> +{
> +	struct inv_icm42607_state *st = dev_get_drvdata(dev);
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = inv_icm42607_set_pwr_mgmt0(st, INV_ICM42607_SENSOR_MODE_OFF,
> +					 INV_ICM42607_SENSOR_MODE_OFF, false,
> +					 NULL);
Different alignment to above - aim for consistent choices on this.

> +	if (ret)
> +		return ret;
> +
> +	inv_icm42607_disable_vddio_reg(st);
> +
> +	return 0;
> +}
> +
> +static int inv_icm42607_runtime_resume(struct device *dev)
> +{
> +	struct inv_icm42607_state *st = dev_get_drvdata(dev);
> +
> +	guard(mutex)(&st->lock);
> +
> +	return inv_icm42607_enable_vddio_reg(st);
> +}
> +
> +EXPORT_NS_GPL_DEV_PM_OPS(inv_icm42607_pm_ops, IIO_ICM42607) = {
> +	SYSTEM_SLEEP_PM_OPS(inv_icm42607_suspend, inv_icm42607_resume)
> +	RUNTIME_PM_OPS(inv_icm42607_runtime_suspend,
> +		       inv_icm42607_runtime_resume, NULL)
> +};
> +
