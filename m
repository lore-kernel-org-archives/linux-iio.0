Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C98477E58;
	Mon, 11 May 2026 18:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523115; cv=none; b=Ro6pE+eWkUb24PQPBDztAbufGoWOIoFNZ0BiZWSsWc0Xqfbvbyg+ZLbCbSbKqGlZ/K5ENEZ7MJyr3LHugAylmEyxBiyE8H+FqUBjO1sF7TeLnWZjV29lPEBmb0F/dbNw3h7f+dYExG9zs4n2ZiSbfnx/H5DKdLMYGoNS32FiP1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523115; c=relaxed/simple;
	bh=iviSYU3TUQ6cSqfQ5jF36SN6Bsw2WrvBmkllqgT37LY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MqtUnfQA156marvplfiRchAqNeo1jx+3O5/JRu1ddmlnQIXblXW0/PmDJ9sKetkno1Pu7/8bPjqg2Uy1yTc7HpK7ws8Rd0eXO/FeZqaX6SpJW4O6hIK8lHhVkkQLPBWEPaBDuxJftFwKWoD0nIfWlq9uFw7iOMTOK7zq+DtbINg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWdrd0Ex; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWdrd0Ex"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FFC6C2BCB0;
	Mon, 11 May 2026 18:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778523115;
	bh=iviSYU3TUQ6cSqfQ5jF36SN6Bsw2WrvBmkllqgT37LY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XWdrd0ExOQIFvLj+qwu85fmTnB9sJVrmttZi9bYYY+MCz39LWGc+ZVkWf/5BR42Ow
	 +xggTXa6UATfN2mAB9+nke1/CplPunb+6M0IoSqz2tBxdlv4vzmyPFSMTJibw00FGn
	 pzGWpzH5mH571GwpJnOUCNTkgY3IMZzkBuaABAGSPacleqNOGAB2a65Yn4qEQOpNOh
	 YNemxw8ouhAfOIcaVSwE5KoGu8CPAYTYYDe4OkTWsQR90TdsU+sBa+dHIU+mZEcTUQ
	 Pwo05VgTHtuNayi/6ySMxNLWUPqmoQ2M8Eb8Ji7RsUHmeOTOyiUCiuQlrD32indAqJ
	 2cPFdM9zB/lKw==
Date: Mon, 11 May 2026 19:11:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V5 05/11] iio: imu: inv_icm42607: Add PM support for
 icm42607
Message-ID: <20260511191145.4d853e9d@jic23-huawei>
In-Reply-To: <20260509191907.24734-6-macroalpha82@gmail.com>
References: <20260509191907.24734-1-macroalpha82@gmail.com>
	<20260509191907.24734-6-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  9 May 2026 14:18:59 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add power management support for the ICM42607 device driver.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
More stuff in here from sashikio.

The runtime pm comment in particular feeds into a couple of
other ongoing threads if true:

https://sashiko.dev/#/patchset/20260509191907.24734-1-macroalpha82%40gmail.com

 [PATCH 3/8] iio: magnetometer: ak8975: switch to using managed resources
is the other thread where we have a similar but subtly different setup.


One other thing inline that is related to this. I just left the whole
thing here so we have the code to discuss ways around this runtime_pm devm mess :(

Fairly sure this runs into the other problem we had which
is that the devm_ regulator cleanup can run before we have any
valid state for runtime pm.

I don't have anything setup to hammer these corners of runtime PM.
I can probably get something up in a few days. Overall I think we
really need to find and test a pattern that actually works and
gets the reference counting right for this devm regulator + runtime suspend
regulator combination.  We have gotten it wrong too often :(

Jonathan

> ---
>  drivers/iio/imu/inv_icm42607/inv_icm42607.h   |  10 ++
>  .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 148 +++++++++++++++++-
>  .../iio/imu/inv_icm42607/inv_icm42607_i2c.c   |   1 +
>  .../iio/imu/inv_icm42607/inv_icm42607_spi.c   |   1 +
>  4 files changed, 159 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> index 3ebc06025051..623ff3936b4b 100644
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
> @@ -96,6 +97,12 @@ struct inv_icm42607_hw {
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
> @@ -105,6 +112,7 @@ struct inv_icm42607_hw {
>   *  @irq:		chip irq, required to enable/disable and set wakeup
>   *  @orientation:	sensor chip orientation relative to main hardware.
>   *  @conf:		chip sensors configurations.
> + *  @suspended:		suspended sensors configuration.
>   */
>  struct inv_icm42607_state {
>  	struct mutex lock;
> @@ -114,6 +122,7 @@ struct inv_icm42607_state {
>  	int irq;
>  	struct iio_mount_matrix orientation;
>  	struct inv_icm42607_conf conf;
> +	struct inv_icm42607_suspended suspended;
>  };
>  
>  /* Virtual register addresses: @bank on MSB (4 upper bits), @address on LSB */
> @@ -337,6 +346,7 @@ typedef int (*inv_icm42607_bus_setup)(struct inv_icm42607_state *);
>  extern const struct regmap_config inv_icm42607_regmap_config;
>  extern const struct inv_icm42607_hw inv_icm42607_hw_data;
>  extern const struct inv_icm42607_hw inv_icm42607p_hw_data;
> +extern const struct dev_pm_ops inv_icm42607_pm_ops;
>  
>  int inv_icm42607_core_probe(struct regmap *regmap, const struct inv_icm42607_hw *hw,
>  			    inv_icm42607_bus_setup bus_setup);
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> index 8ff51711ab1f..047de1b40550 100644
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
> @@ -66,6 +67,62 @@ const struct inv_icm42607_hw inv_icm42607p_hw_data = {
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
>  static int inv_icm42607_set_conf(struct inv_icm42607_state *st,
>  				 const struct inv_icm42607_conf *conf)
>  {
> @@ -192,8 +249,10 @@ static int inv_icm42607_enable_vddio_reg(struct inv_icm42607_state *st)
>  static void inv_icm42607_disable_vddio_reg(void *_data)
>  {
>  	struct inv_icm42607_state *st = _data;
> +	struct device *dev = regmap_get_device(st->map);
>  
> -	regulator_disable(st->vddio_supply);
> +	if (!pm_runtime_suspended(dev))

Can this run before we've set the state up?  We had some previous issues with
needing to set active earlier just so the status check would not indicate
it was suspended.

> +		regulator_disable(st->vddio_supply);
>  }
>  
>  int inv_icm42607_core_probe(struct regmap *regmap, const struct inv_icm42607_hw *hw,
> @@ -251,10 +310,97 @@ int inv_icm42607_core_probe(struct regmap *regmap, const struct inv_icm42607_hw
>  	if (ret)
>  		return ret;
>  
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
>  
> +/*
> + * Suspend saves sensors state and turns everything off.
> + * Check first if runtime suspend has not already done the job.
> + */
> +static int inv_icm42607_suspend(struct device *dev)
> +{
> +	struct inv_icm42607_state *st = dev_get_drvdata(dev);
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	if (pm_runtime_suspended(dev))
> +		return 0;
> +
> +	ret = inv_icm42607_set_pwr_mgmt0(st, INV_ICM42607_SENSOR_MODE_OFF,
> +					 INV_ICM42607_SENSOR_MODE_OFF,
> +					 false, NULL);
> +	if (ret)
> +		return ret;
> +	regulator_disable(st->vddio_supply);
> +
> +	return 0;
> +}
> +
> +/*
> + * System resume gets the system back on and restores the sensors state.
> + * Manually put runtime power management in system active state.
> + */
> +static int inv_icm42607_resume(struct device *dev)
> +{
> +	struct inv_icm42607_state *st = dev_get_drvdata(dev);
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
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
> +	int ret = 0;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = inv_icm42607_set_pwr_mgmt0(st, INV_ICM42607_SENSOR_MODE_OFF,
> +					 INV_ICM42607_SENSOR_MODE_OFF, false,
> +					 NULL);
> +	if (ret)
> +		return ret;
> +
> +	regulator_disable(st->vddio_supply);
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
>  MODULE_AUTHOR("InvenSense, Inc.");
>  MODULE_DESCRIPTION("InvenSense ICM-42607x device driver");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
> index 3859517f88c9..d4fab3d12753 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
> @@ -72,6 +72,7 @@ static struct i2c_driver inv_icm42607_driver = {
>  	.driver = {
>  		.name = "inv-icm42607-i2c",
>  		.of_match_table = inv_icm42607_of_matches,
> +		.pm = pm_ptr(&inv_icm42607_pm_ops),
>  	},
>  	.id_table = inv_icm42607_id,
>  	.probe = inv_icm42607_probe,
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
> index 4a38a11f2bae..23204194eca5 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
> @@ -79,6 +79,7 @@ static struct spi_driver inv_icm42607_driver = {
>  	.driver = {
>  		.name = "inv-icm42607-spi",
>  		.of_match_table = inv_icm42607_of_matches,
> +		.pm = pm_ptr(&inv_icm42607_pm_ops),
>  	},
>  	.id_table = inv_icm42607_spi_id_table,
>  	.probe = inv_icm42607_probe,

