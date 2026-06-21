Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA567B640;
	Sun, 21 Jun 2026 17:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782062400; cv=none; b=X8xOsBCCT1Hzl12fRgozSRnjdiRiUeHOyCdsPHGnS7ViAs0/XaYAEIxUkRJ+ec/6hGkmTcPU/avUKuKWxI3TYDucjclywEMIgdycYDwp60QLaF4x3y6iXYrTc/Cgi0Zv5RxQPYMeM7JMcZgguSe3CHYgpjH4B9bAtx5hFJK5EMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782062400; c=relaxed/simple;
	bh=nvR5aCtxhSi33HiYSF1SVMzxyEXToehZA0bvbvrG6hw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oioxkREhTkAsj7Gfq8zwV7TZOijz8BF15sQCbWy7INzF6rWq5ny+zUGnDC4oSp6FIIWW2DBgvAzWOzoX9hJ6eLr+5ZZ2KFAY3TK2FctRyaCuBeTHJCtnY8iLxVxmyvjH1qxUF9RnLf07V0J2q84qEmt3H5OR5Rkz7DqHGR7+W4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ga2hHCXB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ga2hHCXB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2B61F00A3A;
	Sun, 21 Jun 2026 17:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782062399;
	bh=PFZDgFF2cbl0nwxL7yWYbB8MPytwRF/TjpK+oQEA7TM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ga2hHCXBhL+nqUBfRLchtpLS8Hmhrmj9V4k5rmU08ISVk74KkKDiolzgDZdkiMXgM
	 3CpQwkAdUsTSfpWobus1r+HywmpusP8Fj2Gvrm8hjqNzOV2y5nhs26MI9/zhf5hWFZ
	 i5Y1DAzg2GqXnWrzDJ7jqIV2Y9dhlCxVkwJthgANf2WtQb9qWyKAu0c3Xn77ZPBOiN
	 IxQxZdeco0oQdUF/NB5XyQwL0dw6CmiOFjn4rwiXW1kYhU44LbUOWSHIIn+nlUJYLF
	 rUui3NM6jTcWlJKTyh4S/WGIxjNuoBH826zXxGxfjckdKJ5fSkAEj++E0NOE4JjEWB
	 gek7e5TOGFGmg==
Date: Sun, 21 Jun 2026 18:19:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V13 5/9] iio: imu: inv_icm42607: Add PM support for
 icm42607
Message-ID: <20260621181948.21d40a09@jic23-huawei>
In-Reply-To: <20260615172554.160910-6-macroalpha82@gmail.com>
References: <20260615172554.160910-1-macroalpha82@gmail.com>
	<20260615172554.160910-6-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Jun 2026 12:25:48 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
>=20
> Add power management support for the ICM42607 device driver.
>=20
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
A few things from taking a look at the sashiko report:
https://sashiko.dev/#/patchset/20260615172554.160910-1-macroalpha82%40gmail=
.com

> ---
>  drivers/iio/imu/inv_icm42607/inv_icm42607.h   |  18 +++
>  .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 139 ++++++++++++++++++
>  .../iio/imu/inv_icm42607/inv_icm42607_i2c.c   |   1 +
>  .../iio/imu/inv_icm42607/inv_icm42607_spi.c   |   1 +
>  4 files changed, 159 insertions(+)
>=20
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/im=
u/inv_icm42607/inv_icm42607.h
> index a6a58571935f..4f4f541027dc 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h

> @@ -334,11 +345,18 @@ struct inv_icm42607_state {
>  #define INV_ICM42607_GYRO_STOP_TIME_MS			45
>  #define INV_ICM42607_TEMP_STARTUP_TIME_MS		77
> =20
> +/*
> + * Suspend delay assumed from other icm42600 series device, not
> + * documented in datasheet.
> + */
> +#define INV_ICM42607_SUSPEND_DELAY_MS			(2 * USEC_PER_MSEC)

Sashiko had a valid comment on this.  MSEC_PER_SEC seems more
appropriate given this is 2 seconds in milli seconds.

> +
>  typedef int (*inv_icm42607_bus_setup)(struct inv_icm42607_state *);
> =20
>  extern const struct regmap_config inv_icm42607_regmap_config;
>  extern const struct inv_icm42607_hw inv_icm42607_hw_data;
>  extern const struct inv_icm42607_hw inv_icm42607p_hw_data;
> +extern const struct dev_pm_ops inv_icm42607_pm_ops;
> =20
>  int inv_icm42607_core_probe(struct regmap *regmap,
>  			    const struct inv_icm42607_hw *hw,
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/i=
io/imu/inv_icm42607/inv_icm42607_core.c
> index 4b8e19091786..64f5d263de4f 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> @@ -4,6 +4,7 @@
>   */
> =20
>  #include <linux/bitfield.h>
> +#include <linux/cleanup.h>
>  #include <linux/delay.h>
>  #include <linux/dev_printk.h>
>  #include <linux/device/devres.h>
> @@ -11,6 +12,7 @@
>  #include <linux/iio/iio.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/time.h>
> @@ -103,6 +105,63 @@ const struct inv_icm42607_hw inv_icm42607p_hw_data =
=3D {
>  };
>  EXPORT_SYMBOL_NS_GPL(inv_icm42607p_hw_data, "IIO_ICM42607");
> =20
> +static int inv_icm42607_set_pwr_mgmt0(struct inv_icm42607_state *st,
> +				      enum inv_icm42607_sensor_mode gyro,
> +				      enum inv_icm42607_sensor_mode accel,
> +				      bool temp, unsigned int *sleep_ms)
> +{
> +	enum inv_icm42607_sensor_mode oldaccel =3D st->conf.accel.mode;
> +	enum inv_icm42607_sensor_mode oldgyro =3D st->conf.gyro.mode;
> +	bool oldtemp =3D st->conf.temp_en;
> +	unsigned int sleepval_ms;
> +	unsigned int val;
> +	int ret;
> +
> +	if (gyro =3D=3D oldgyro && accel =3D=3D oldaccel && temp =3D=3D oldtemp)
> +		return 0;
> +
> +	/*
> +	 * Datasheet on page 14.26 says we need to ensure the gyro sensor is on
> +	 * for a minimum of 45ms. So if we transition from an on state to an
> +	 * off state wait 45ms to ensure a sufficient pause before power off.

Sashiko commented on this..  I think what we could do with adding to the
comment is what the path is that didn't pass through this function which wo=
uld
ensure we have been on for 30 of this msecs already.

> +	 */
> +	if (!gyro && oldgyro)
> +		fsleep(INV_ICM42607_GYRO_STOP_TIME_MS * USEC_PER_MSEC);
> +
> +	val =3D FIELD_PREP(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, gyro);
> +	val |=3D FIELD_PREP(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, accel);
> +	ret =3D regmap_write(st->map, INV_ICM42607_REG_PWR_MGMT0, val);
> +	if (ret)
> +		return ret;
> +
> +	st->conf.gyro.mode =3D gyro;
> +	st->conf.accel.mode =3D accel;
> +	st->conf.temp_en =3D temp;
> +
> +	/*
> +	 * If a state change occurs from off to on, sleep for the startup
> +	 * time of the sensor, unless a sleep_ms is specified. Since more
> +	 * than one sensor can be transitioned from off to on, select the
> +	 * maximum time from each of the sensors changing from off to on.
> +	 */
> +	sleepval_ms =3D 0;
> +	if (temp && !oldtemp)
> +		sleepval_ms =3D max(sleepval_ms, INV_ICM42607_TEMP_STARTUP_TIME_MS);
> +
> +	if (accel && !oldaccel)
> +		sleepval_ms =3D max(sleepval_ms, INV_ICM42607_ACCEL_STARTUP_TIME_MS);
> +
> +	if (gyro && !oldgyro)
> +		sleepval_ms =3D max(sleepval_ms, INV_ICM42607_GYRO_STARTUP_TIME_MS);
> +
> +	if (sleep_ms)
> +		*sleep_ms =3D sleepval_ms;
> +	else if (sleepval_ms)
> +		fsleep(sleepval_ms * USEC_PER_MSEC);
> +
> +	return 0;
> +}

> =20
>  int inv_icm42607_core_probe(struct regmap *regmap,
> @@ -236,6 +305,8 @@ int inv_icm42607_core_probe(struct regmap *regmap,
>  	if (!st)
>  		return -ENOMEM;
> =20
> +	dev_set_drvdata(dev, st);
> +
>  	ret =3D devm_mutex_init(dev, &st->lock);
>  	if (ret)
>  		return ret;
> @@ -271,10 +342,78 @@ int inv_icm42607_core_probe(struct regmap *regmap,
>  	if (ret)
>  		return ret;
> =20
> +	ret =3D devm_pm_runtime_set_active_enabled(dev);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_set_autosuspend_delay(dev, INV_ICM42607_SUSPEND_DELAY_MS);
> +	pm_runtime_use_autosuspend(dev);
Sashiko does put out some stuff here.  Please take a look and work out or
test if it is right (I think not but haven't checked that carefully!)
=46rom a quick look I think that the auto disabling of autosuspend does a
rpm_idle() that should result in it suspending...


> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(inv_icm42607_core_probe, "IIO_ICM42607");
