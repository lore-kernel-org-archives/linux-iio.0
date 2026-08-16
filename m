Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647933016E7;
	Sun, 16 Aug 2026 03:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786849204; cv=none; b=JTJTZbJLxlLKxyWpFbETrhWeP7+puk17WJyv63POKps1YsjkU2QvQDrRc+2gzbiWRIIxX7dfM3JWC6zlD8y5Yc982sXC2tqK3esPNPbk/jxIkFKAWD3+21HO1gs/Jpn2uRDRwC3G8dc0SB/oziEi01Is+c51hrH6sVoL5fMyjhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786849204; c=relaxed/simple;
	bh=zfSOsdMRvTphfQlIklFA5BEvZ/ybgBL9jJJxxnIBqJI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s0agBt9oH4tpCKmxj5vp2hcBOMzSq+XFNIg8PdVyHJXZs89TDKiBzOww9tsBg2aJgIBuc4hQZyYzvvMzQ5RuKz24/dySGOfZh1Ow5OQQ0grxr7mwaX4AmIVfses5T1fJKuCq0Mj38np9YyB4Kvbh0drK8s2rR7PF3dopGBlNVgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMxAPYVo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMxAPYVo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F261F000E9;
	Sun, 16 Aug 2026 02:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786849200;
	bh=9bKB6P+a1TDt7d1rSORLFzz0aQKz0bSTIdHQORlYsUk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WMxAPYVoLncxmQgaiDIiDqJQRJByjsLZy7sJd9FtCM0gfP8fzTzCMXil7mqH8bgQl
	 ++sheMXG5GlMdrgonwo4LcJUoCAIGyqVMWNXWyUWyHF45TfKRzIV6bCPNy0CSC2qSf
	 +IeCJ50J+NFvA+9cKW/haU7Rm8lVmoqKiB8hC9xudUoYfTKaIQ/1LN/RtIaT8lBC1h
	 52R9EgS5GjEHhCRqRW0bKkFDueTn/63HqRYHdOBROCcVsPQbseLRdcBQChxCZErDzi
	 1Dseegj6XoB79pnPWceGIxkH67wlh9/jpMkAnbF6Hz0DQMDOoVSg74fcauFVy2wOtr
	 F24d7Y1zMPUUQ==
Date: Sun, 16 Aug 2026 03:59:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Henrik Grimler" <henrik.grimler@axis.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kernel@axis.com>
Subject: Re: [PATCH v2 2/3] iio: accel: Add support for ICM42370P
Message-ID: <20260816035955.61e4c805@jic23-huawei>
In-Reply-To: <20260813-b4-inv_icm42370p-v2-2-11aedfdf76d3@axis.com>
References: <20260813-b4-inv_icm42370p-v2-0-11aedfdf76d3@axis.com>
	<20260813-b4-inv_icm42370p-v2-2-11aedfdf76d3@axis.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Aug 2026 14:26:11 +0200
Kanak Shilledar <kanak.shilledar@axis.com> wrote:

> Add support for the Invensense ICM42370P MEMS MotionTracking 3-axis
> accelerometer with a built-in temperature sensor. Compared to other
> sensors from the same vendor ICM42370 uses a different way of handling
> register banks. Although the device supports I2C, SPI, and I3C,
> implement only I2C support.  Provide basic support for raw sensor
> reads and a sysfs interface for setting the calibration bias. Keep the
> embedded temperature sensor enabled because the device design does not
> allow it to be turned off.
>=20
> Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
Hi Kanak

Welcome to IIO. Various comments below.

> diff --git a/drivers/iio/accel/inv_icm42370.h b/drivers/iio/accel/inv_icm=
42370.h
> new file mode 100644
> index 0000000000000..a4a822f04355f
> --- /dev/null
> +++ b/drivers/iio/accel/inv_icm42370.h
...

> +
> +#define INV_ICM42370_DRIVE_CONFIG1_I3C_DDR_MASK GENMASK(5, 3)
> +#define INV_ICM42370_DRIVE_CONFIG1_I3C_DDR(_rate) \
> +	FIELD_PREP(INV_ICM42370_DRIVE_CONFIG1_I3C_DDR_MASK, (_rate))
What is readability benefit of this macro over just having
FIELD_PREP() inline where we can it matches with the
mask that is likely being used right next to it.
This sort of things is fine if there is significant complexity
but not in simple cases like this.


...

> +/* Registers in MREG1 USER BANK 1 */
> +#define INV_ICM42370_REG_TMST_CONFIG1 0x00
> +#define INV_ICM42370_REG_FIFO_CONFIG5 0x01
> +#define INV_ICM42370_REG_FIFO_CONFIG6 0x02
> +#define INV_ICM42370_REG_INT_CONFIG1 0x05
> +#define INV_ICM42370_REG_OFFSET_USER4 0x52
> +#define INV_ICM42370_REG_OFFSET_USER5 0x53
> +#define INV_ICM42370_REG_OFFSET_USER6 0x54
> +#define INV_ICM42370_REG_OFFSET_USER7 0x55
> +#define INV_ICM42370_REG_OFFSET_USER8 0x56
> +
> +#define INV_ICM42370_TMST_CONFIG_TMST_DELTA_EN BIT(2)
> +#define INV_ICM42370_TMST_CONFIG_TMST_EN BIT(0)
There are various ways of formatting register defines to make
it easier to see how things fit together. My personal favourite is along th=
e lines
of

#define INV_ICM42370_REG_TMST_CONFIG1 0x00
#define   INV_ICM42370_TMST_CONFIG_TMST_DELTA_EN BIT(2)
#define   INV_ICM42370_TMST_CONFIG_TMST_EN BIT(0)
#define INV_ICM42370_REG_FIFO_CONFIG5 0x01

Where there are masks and values defined just use more indentation
for the values.

> +
> +#define INV_ICM42370_PWR_MGMT0(_mode) FIELD_PREP(GENMASK(1, 0), (_mode))
> +#define INV_ICM42370_ACCEL_CONFIG0_FS(_fs) FIELD_PREP(GENMASK(6, 5), (_f=
s))
> +#define INV_ICM42370_ACCEL_CONFIG0_ODR(_odr) FIELD_PREP(GENMASK(3, 0), (=
_odr))
> +#define INV_ICM42370_TEMP_FILT_BW_DLPF(_dlpf) FIELD_PREP(GENMASK(6, 4), =
(_dlpf))

Define the masks then use FIELD_PREP() inline.  Tends to make it
much easier to see what is going on.

> +
> +#define INV_ICM42370_TEMP_CHAN(_index) \

As below - this might not be needed at all.

> +	{								\
> +		.type =3D IIO_TEMP,					\
> +		.info_mask_separate =3D					\
> +			BIT(IIO_CHAN_INFO_RAW) |			\
> +			BIT(IIO_CHAN_INFO_OFFSET) |			\
> +			BIT(IIO_CHAN_INFO_SCALE),			\
> +		.scan_index =3D _index,					\
> +		.scan_type =3D {						\
> +			.sign =3D 's',					\
> +			.realbits =3D 16,					\
> +			.storagebits =3D 16,				\
> +		},							\
> +	}
> +
> +#define INV_ICM42370_ACCEL_CHAN(_modifier, _index, _ext_info) \

This doesn't belong in a header. Push it down near where it is used
in core.c

> +	{								\
> +		.type =3D IIO_ACCEL,					\
> +		.modified =3D 1,						\


> +enum inv_icm42370_chip {
As below.  An enum of chip identifiers is a lot messier to maintain
and tends to end up with stuff that should be data as constants.
So drop this - you don't need any of this for now anyway as only one suppor=
ted
chip.=20
> +	INV_CHIP_INVALID,
> +	INV_CHIP_ICM42370,
> +	INV_CHIP_NB,
> +};

> +
> +enum inv_icm42370_odr {
> +	INV_ICM42370_ODR_1_6KHZ_LN =3D 5,
> +	INV_ICM42370_ODR_800HZ_LN,
> +	INV_ICM42370_ODR_400HZ,
> +	INV_ICM42370_ODR_200HZ,
> +	INV_ICM42370_ODR_100HZ,
> +	INV_ICM42370_ODR_50HZ,
> +	INV_ICM42370_ODR_25HZ,
> +	INV_ICM42370_ODR_12_5HZ,
> +	INV_ICM42370_ODR_6_25HZ_LP,
> +	INV_ICM42370_ODR_3_125HZ_LP,
> +	INV_ICM42370_ODR_1_5625HZ_LP,
> +	INV_ICM42370_ODR_NB,
Drop trailing commas on entries that terminate an enum
> +};

...
> +
> +typedef int (*inv_icm42370_bus_setup)(struct inv_icm42370_data *);
> +extern const struct regmap_config inv_icm42370_regmap_config;
> +
> +u32 inv_icm42370_odr_to_period(enum inv_icm42370_odr odr);
> +
> +int inv_icm42370_core_probe(struct regmap *regmap, int chip, int irq,
> +			    inv_icm42370_bus_setup bus_setup);
> +
> +struct iio_dev *inv_icm42370_accel_init(struct iio_dev *indio_dev,
> +					struct inv_icm42370_data *data);
> +
> +int inv_icm42370_set_accel_conf(struct inv_icm42370_data *data,
> +				struct inv_icm42370_conf *conf,
> +				unsigned int *sleep_ms);
> +
> +int inv_icm42370_accel_parse_fifo(struct iio_dev *indio_dev);

No such function yet.  Bring it in when the function is added.

> +int inv_icm42370_mreg_write(struct inv_icm42370_data *data, u8 bank, u8 =
addr, u8 val);
> +int inv_icm42370_mreg_read(struct inv_icm42370_data *data, u8 bank, u8 a=
ddr, u8 *val);
> +int inv_icm42370_set_pwr_mgmt0(struct inv_icm42370_data *data,
> +			       enum inv_icm42370_sensor_mode accel,
> +			       unsigned int *sleep_ms);

Will comment on this in next patch perhaps but generally the divide into
core and buffer is part of some ancient history - I'd be tempted to squash =
both
into the core.c file for this device.  That will let you remove a lot of th=
is stuff.


> +
> +#endif
> diff --git a/drivers/iio/accel/inv_icm42370_core.c b/drivers/iio/accel/in=
v_icm42370_core.c
> new file mode 100644
> index 0000000000000..6266362e83f6a
> --- /dev/null
> +++ b/drivers/iio/accel/inv_icm42370_core.c
...

> +
> +static const struct iio_chan_spec inv_icm42370_accel_channels[] =3D {
> +	INV_ICM42370_ACCEL_CHAN(IIO_MOD_X, INV_ICM42370_ACCEL_SCAN_X,
> +				inv_icm42370_accel_ext_infos),

Why have this last parameter as it is same for all ACCEL_CHAN?
Just encode it in the macro.

> +	INV_ICM42370_ACCEL_CHAN(IIO_MOD_Y, INV_ICM42370_ACCEL_SCAN_Y,
> +				inv_icm42370_accel_ext_infos),
> +	INV_ICM42370_ACCEL_CHAN(IIO_MOD_Z, INV_ICM42370_ACCEL_SCAN_Z,
> +				inv_icm42370_accel_ext_infos),
> +	INV_ICM42370_TEMP_CHAN(INV_ICM42370_ACCEL_SCAN_TEMP),

Not sure the macro adds anything given only one useage. I'd define
the temp iio_chan_spec directly here.

> +};
> +
> +/* IIO format int + nano */
> +static const int inv_icm42370_accel_scale[] =3D {

Use a 2 dimensional array and cast it for the read_avail() usage
They end up much easier to read.
	[INV_ICM4370_ACCEL_FS_16] =3D { 0, 4799403 },
etc

Lots of examples of this in tree.

> +	/* +/- 16G =3D> 2*16*9.80665 / (2**15) m/s-2 */
> +	[2 * INV_ICM42370_ACCEL_FS_16G] =3D 0,
> +	[2 * INV_ICM42370_ACCEL_FS_16G + 1] =3D 4788403,
> +	/* +/- 8G =3D> 2*8*9.80665 / (2**15) m/s-2 */
> +	[2 * INV_ICM42370_ACCEL_FS_8G] =3D 0,
> +	[2 * INV_ICM42370_ACCEL_FS_8G + 1] =3D 2394202,
> +	/* +/- 4G =3D> 2*4*9.80665 / (2**15) m/s-2 */
> +	[2 * INV_ICM42370_ACCEL_FS_4G] =3D 0,
> +	[2 * INV_ICM42370_ACCEL_FS_4G + 1] =3D 1197101,
> +	/* +/- 2G =3D> 2*2*9.80665 / (2**15) m/s-2 */
> +	[2 * INV_ICM42370_ACCEL_FS_2G] =3D 0,
> +	[2 * INV_ICM42370_ACCEL_FS_2G + 1] =3D 598550,
> +};
> +
> +/**
> + *  inv_icm42370_odr_to_period() - map ODR to Period
> + *
> + *  @odr: enum of ODR value
> + *
> + * Returns the period in nanoseconds
> + */
> +u32 inv_icm42370_odr_to_period(enum inv_icm42370_odr odr)
> +{
> +	static u32 odr_periods[INV_ICM42370_ODR_NB] =3D {
> +		0, 0, 0, 0, 0,	/* Reserved */
> +		625000,		/* 1.6kHz */
		[INV_ICM42370_ODR_1_6KHZ_LN] =3D 625000,
etc and no comments as they become self documenting.

> +		1250000,	/* 800Hz */
> +		2500000,	/* 400Hz */
> +		5000000,	/* 200Hz */
> +		10000000,	/* 100Hz */
> +		20000000,	/* 50Hz */
> +		40000000,	/* 25Hz */
> +		80000000,	/* 12.5Hz */
> +		160000000,	/* 6.25Hz */
> +		320000000,	/* 3.125Hz */
> +		640000000,	/* 1.5625Hz */
> +	};
> +
> +	return odr_periods[odr];
> +}
> +
> +/* ODR suffixed by LN or LP are Low-Noise or Low-Power mode only */
> +static const int inv_icm42370_accel_odr_conv[] =3D {

Feels like this would be better done with a bit of maths than an aray
of the numbers 5,6 etc to account for that set of reserved low values.

> +	INV_ICM42370_ODR_1_6KHZ_LN,   INV_ICM42370_ODR_800HZ_LN,
> +	INV_ICM42370_ODR_400HZ,	      INV_ICM42370_ODR_200HZ,
> +	INV_ICM42370_ODR_100HZ,	      INV_ICM42370_ODR_50HZ,
> +	INV_ICM42370_ODR_25HZ,	      INV_ICM42370_ODR_12_5HZ,
> +	INV_ICM42370_ODR_6_25HZ_LP,   INV_ICM42370_ODR_3_125HZ_LP,
> +	INV_ICM42370_ODR_1_5625HZ_LP, INV_ICM42370_ODR_NB,
> +};

That NB is an entry that will always be last. As such, drop the trailing ,

> +
> +/**
> + * inv_icm42370_mreg_read() - routine for reading from other bank regist=
ers
> + *
> + * @data: pointer to struct containing the sensor data
> + * @bank: register bank being accessed
> + * @addr: address of the register being accessed
> + * @val: pointer to store the register's data
> + *
> + * Returns 0 on success, negative errno on error
> + */
> +int inv_icm42370_mreg_read(struct inv_icm42370_data *data, u8 bank, u8 a=
ddr, u8 *val)
> +{
> +	int ret;
> +	unsigned int sleep, read_val;
> +
> +	/* set default conf to ensure mreg access */
> +	ret =3D inv_icm42370_set_accel_conf(data, &inv_icm42370_default_conf, &=
sleep);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D inv_icm42370_mreg_check(data->map);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(data->map, INV_ICM42370_REG_BLK_SEL_R, bank);
> +	if (ret)
> +		return -EINVAL;
> +
> +	ret =3D regmap_write(data->map, INV_ICM42370_REG_MADDR_R, addr);
> +	if (ret)
> +		return -EINVAL;
> +
> +	fsleep(10);

All of these sleeps need docs.

> +	ret =3D regmap_read(data->map, INV_ICM42370_REG_M_R, &read_val);
> +	if (ret)
> +		return -EINVAL;
> +
> +	fsleep(10);
Why would you sleep before saving the value to *val?
> +	*val =3D (u8)read_val;
> +
> +	return regmap_write(data->map, INV_ICM42370_REG_BLK_SEL_R, 0x00);
> +}
> +
> +/**
> + * inv_icm42370_set_conf() - set sensor configuration
> + *
> + * @data: pointer to struct containing the sensor data
> + * @conf: pointer to configuration data
> + *
> + * Returns 0 on success, negative errno on error
> + */
> +static int inv_icm42370_set_conf(struct inv_icm42370_data *data,
> +				 const struct inv_icm42370_conf *conf)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	/* set PWR_MGMT0 register (accel sensor mode, temp enabled) */
> +	val =3D INV_ICM42370_PWR_MGMT0(conf->mode);
> +	ret =3D regmap_write(data->map, INV_ICM42370_REG_PWR_MGMT0, val);
> +	if (ret)
> +		return ret;
> +
> +	msleep(200);
> +
> +	/* set ACCEL_CONFIG0 register (accel fullscale & odr) */
> +	val =3D INV_ICM42370_ACCEL_CONFIG0_FS(conf->fs) |
> +	      INV_ICM42370_ACCEL_CONFIG0_ODR(conf->odr);
> +	ret =3D regmap_write(data->map, INV_ICM42370_REG_ACCEL_CONFIG0, val);
> +	if (ret)
> +		return ret;
> +
> +	msleep(200);

Why?  Any sleep really needs a spec reference to say why it has that
value.

> +
> +	data->conf =3D *conf;
> +
> +	return 0;
> +}
> +
> +/**
> + * inv_icm42370_set_pwr_mgmt0() - set the PWR_MGMT0 register for sensor
> + *
> + * @data: pointer to struct containing the sensor data
> + * @accel: enum of sensor power mode
> + * @sleep_ms: pointer to check how long the sensor is in sleep mode
> + *
> + * Returns 0 on success, negative errno on error
> + */
> +int inv_icm42370_set_pwr_mgmt0(struct inv_icm42370_data *data,
> +				      enum inv_icm42370_sensor_mode accel,
> +				      unsigned int *sleep_ms)
> +{
> +	enum inv_icm42370_sensor_mode oldaccel =3D data->conf.mode;
> +	unsigned int sleepval;
> +	unsigned int val;
> +	int ret;
> +
> +	/* if nothing changed, exit */
> +	if (accel =3D=3D oldaccel)
> +		return 0;
> +
> +	val =3D INV_ICM42370_PWR_MGMT0(accel);
> +	ret =3D regmap_write(data->map, INV_ICM42370_REG_PWR_MGMT0, val);
> +	if (ret)
> +		return ret;
> +
> +	data->conf.mode =3D accel;
> +	data->power_mode =3D accel;
> +
> +	/* compute required wait time for sensors to stabilize */
> +	sleepval =3D 0;
> +	/* accel startup time */
> +	if (accel !=3D oldaccel && oldaccel =3D=3D INV_ICM42370_SENSOR_MODE_OFF=
) {
> +		/* block any register write for at least 200 =C2=B5s */
> +		fsleep(100);

Curious why this fsleep()?

> +		if (sleepval < INV_ICM42370_ACCEL_STARTUP_TIME_MS)
> +			sleepval =3D INV_ICM42370_ACCEL_STARTUP_TIME_MS;
> +	}
> +
> +	/* deferred sleep value if sleep pointer is provided or direct sleep */
> +	if (sleep_ms)
> +		*sleep_ms =3D sleepval;
> +	else if (sleepval)
> +		msleep(sleepval);
> +
> +	return 0;
> +}
> +
> +/**
> + * inv_icm42370_set_accel_conf() - set configuration data for accelerome=
ter
> + *
> + * @data: pointer to struct containing the sensor data
> + * @conf: pointer to configuration data
> + * @sleep_ms: pointer to check how long the sensor is in sleep mode
> + *
> + * Returns 0 on success, negative errno on error
> + */
> +int inv_icm42370_set_accel_conf(struct inv_icm42370_data *data,
> +				struct inv_icm42370_conf *conf,
> +				unsigned int *sleep_ms)
> +{
> +	struct inv_icm42370_conf *oldconf =3D &data->conf;
> +	unsigned int val;
> +	int ret;
> +
> +	/* sanitize missing values with current values */
> +	if (conf->mode < 0)
> +		conf->mode =3D oldconf->mode;
> +	if (conf->fs < 0)
> +		conf->fs =3D oldconf->fs;
> +	if (conf->odr < 0)
> +		conf->odr =3D oldconf->odr;
> +	if (conf->filter < 0)
> +		conf->filter =3D oldconf->filter;
> +
> +	/* force power mode against ODR when sensor is on */
> +	switch (conf->mode) {
> +	case INV_ICM42370_SENSOR_MODE_LOW_POWER:
> +	case INV_ICM42370_SENSOR_MODE_LOW_NOISE:
> +		if (conf->odr <=3D INV_ICM42370_ODR_800HZ_LN) {
> +			conf->mode =3D INV_ICM42370_SENSOR_MODE_LOW_NOISE;
> +			conf->filter =3D
> +				INV_ICM42370_UI_FILT_BW_LP_FILTER_BYPASSED;
> +		} else if (conf->odr =3D=3D INV_ICM42370_ODR_400HZ) {
> +			if (conf->filter =3D=3D INV_ICM42370_FILTER_AVG_16X ||
> +			    conf->filter =3D=3D INV_ICM42370_FILTER_AVG_32X ||
> +			    conf->filter =3D=3D INV_ICM42370_FILTER_AVG_64X) {
> +				conf->mode =3D INV_ICM42370_SENSOR_MODE_LOW_NOISE;
> +			} else {
> +				conf->mode =3D INV_ICM42370_SENSOR_MODE_LOW_POWER;
> +			}
> +		} else if (conf->odr =3D=3D INV_ICM42370_ODR_200HZ &&
> +			   conf->filter =3D=3D INV_ICM42370_FILTER_AVG_64X) {
> +			conf->mode =3D INV_ICM42370_SENSOR_MODE_LOW_NOISE;
> +			conf->filter =3D
> +				INV_ICM42370_UI_FILT_BW_LP_FILTER_BYPASSED;
> +		} else if (conf->odr >=3D INV_ICM42370_ODR_6_25HZ_LP) {
> +			conf->mode =3D INV_ICM42370_SENSOR_MODE_LOW_POWER;
> +			conf->filter =3D INV_ICM42370_FILTER_AVG_16X;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	/* set ACCEL_CONFIG0 register (accel fullscale & odr) */
> +	if (conf->fs !=3D oldconf->fs || conf->odr !=3D oldconf->odr) {
> +		val =3D INV_ICM42370_ACCEL_CONFIG0_FS(conf->fs) |
> +		      INV_ICM42370_ACCEL_CONFIG0_ODR(conf->odr);
> +		ret =3D regmap_write(data->map,
> +				   INV_ICM42370_REG_ACCEL_CONFIG0, val);
> +		if (ret)
> +			return ret;
> +
> +		oldconf->fs =3D conf->fs;
> +		oldconf->odr =3D conf->odr;
> +	}
> +
> +	/* set PWR_MGMT0 register (accel sensor mode) */

This comment doesn't add much I think.  Plus if you did want it
don't have a blank line before the thing it is talking about.

> +
> +	return inv_icm42370_set_pwr_mgmt0(data, conf->mode, sleep_ms);
> +}
> +
> +/**
> + * inv_icm42370_setup() - check and setup chip
> + *
> + * @data: pointer to struct containing the sensor data
> + * @bus_setup:	callback to configure bus-specific settings (e.g. I2C)
> + *
> + * Returns 0 on success, a negative error code otherwise.
> + */
> +static int inv_icm42370_setup(struct inv_icm42370_data *data,
> +			      inv_icm42370_bus_setup bus_setup)
> +{
> +	const struct device *dev =3D regmap_get_device(data->map);
> +	unsigned int whoami;
> +	int ret;
> +
> +	/* check chip self-identification value */
> +	ret =3D regmap_read(data->map, INV_ICM42370_REG_WHO_AM_I, &whoami);
> +	if (ret)
> +		return ret;
> +
> +	if (whoami !=3D INV_ICM42370_WHOAMI_VALUE) {

We don't fail on this any more (some drivers still need fixing) as it
breaks the concept of fallback compatibles in device tree.  At most
dev_info() or maybe dev_dbg() then carry on anyway.

> +		dev_err(dev, "Wrong WHO_AM_I: %d (want 0x%02X)\n", whoami,
> +			INV_ICM42370_WHOAMI_VALUE);
> +		return -ENODEV;
> +	}
> +
> +	data->name =3D "inv_icm42370";
What is this for?
> +
> +	/* set chip bus configuration */
> +	ret =3D bus_setup(data);
> +	if (ret)
> +		return ret;
> +
> +	/* sensor data in big-endian (default) */
> +	ret =3D regmap_set_bits(data->map, INV_ICM42370_REG_INTF_CONFIG0,
> +			      INV_ICM42370_INTF_CONFIG0_SENSOR_DATA_ENDIAN);

Why?  Given I doubt you are running this on a big endian host, maybe
little endian would save a bit of work for most users?

> +	if (ret)
> +		return ret;
> +
> +	return inv_icm42370_set_conf(data, &inv_icm42370_default_conf);
> +}
> +
> +static irqreturn_t inv_icm42370_irq_timestamp(int irq, void *_data)
> +{
> +	struct inv_icm42370_data *data =3D _data;
> +
> +	data->timestamp =3D iio_get_time_ns(data->indio_accel);

Maybe it makes sense later, but for now I can't see why this is useful
vs the standard handler iio_pollfunc_store_timestamp

I think it would be better to bring in the interrupt handling only
when there is something to do with it (so probably next patch?)

> +
> +	return IRQ_WAKE_THREAD;
> +}
> +
> +static irqreturn_t inv_icm42370_irq_handler(int irq, void *_data)
> +{
> +	struct inv_icm42370_data *data =3D _data;
> +	unsigned int status;
> +	int ret;
> +
> +	guard(mutex)(&data->lock);
> +
> +	ret =3D regmap_read(data->map, INV_ICM42370_REG_INT_STATUS, &status);
> +	if (ret)
> +		return IRQ_HANDLED;

Hmm. This is rather odd at the moment.  Does reading status clear the
interrupt?  Even if you are going to add proper support later, you should
check if there was an interrupt there and return IRQ_NONE if not.


> +
> +	return IRQ_HANDLED;
> +}
> +
> +/**
> + * inv_icm42370_irq_init() - initialize int pin and interrupt handler
> + * @data:		driver internal state
> + * @irq:	irq number
> + * @irq_type:	irq trigger type
> + * @open_drain:	true if irq is open drain, false for push-pull
> + *
> + * Returns 0 on success, a negative error code otherwise.
> + */
> +static int inv_icm42370_irq_init(struct inv_icm42370_data *data, int irq,
> +				 int irq_type, bool open_drain)
> +{
> +	struct device *dev =3D regmap_get_device(data->map);
> +	u8 val;
> +	int ret;

Where no other strong reason for ordering reverse xmas preferred.

> +
> +	/* configure INT1 interrupt: default is active low on edge */
> +	switch (irq_type) {
> +	case IRQF_TRIGGER_RISING:
> +	case IRQF_TRIGGER_HIGH:
> +		val =3D INV_ICM42370_INT_CONFIG_INT1_ACTIVE_HIGH;
> +		break;
> +	default:
> +		val =3D INV_ICM42370_INT_CONFIG_INT1_ACTIVE_LOW;
> +		break;
> +	}
> +
> +	switch (irq_type) {
> +	case IRQF_TRIGGER_LOW:
> +	case IRQF_TRIGGER_HIGH:
> +		val |=3D INV_ICM42370_INT_CONFIG_INT1_LATCHED;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (!open_drain)
> +		val |=3D INV_ICM42370_INT_CONFIG_INT1_PUSH_PULL;
> +
> +	ret =3D regmap_write(data->map, INV_ICM42370_REG_INT_CONFIG, val);
> +	if (ret)
> +		return ret;
> +
> +	/* Deassert async reset for proper INT pin operation (cf datasheet) */
> +	ret =3D inv_icm42370_mreg_read(data, INV_ICM42370_MREG1,
> +				     INV_ICM42370_REG_INT_CONFIG1, &val);
> +	if (ret)
> +		return ret;
> +
> +	val &=3D ~INV_ICM42370_INT_CONFIG1_ASYNC_RESET;
> +
> +	ret =3D inv_icm42370_mreg_write(data, INV_ICM42370_MREG1,
> +				      INV_ICM42370_REG_INT_CONFIG1, val);
> +	if (ret)
> +		return ret;
> +
> +	irq_type |=3D IRQF_ONESHOT;

After dropping the default below, you can just skip the |=3D and pass
IRQF_ONESHOT in directly as the irq_type, with the rest picked up from firm=
ware

> +	return devm_request_threaded_irq(dev, irq, inv_icm42370_irq_timestamp,
> +					 inv_icm42370_irq_handler, irq_type,
> +					 "inv_icm42370", data);
> +}

> +/**
> + * inv_icm42370_temp_read() - internal function to access temperature se=
nsor registers
> + *
> + * @data: pointer to struct containing the sensor data
> + * @temp: pointer containing the temperature data in s16 format
> + *
> + * Return 0 on success, negative errno on error
> + */
> +static int inv_icm42370_temp_read(struct inv_icm42370_data *data, s16 *t=
emp)
> +{
> +	struct device *dev =3D regmap_get_device(data->map);
> +	__be16 *raw;
> +	int ret;
> +
> +	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev, pm);
> +	ret =3D PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&data->lock);
> +
> +	raw =3D (__be16 *)&data->buffer[0];
> +	ret =3D regmap_bulk_read(data->map, INV_ICM42370_REG_TEMP_DATA1, raw,
> +			       sizeof(*raw));
> +	if (ret)
> +		return ret;
> +
> +	*temp =3D (s16)be16_to_cpup(raw);

Hmm. You are forcing alignment to at least 4 (maybe 8 I can't remember
the minimum) so this is valid, but none the less I'd just do
	*temp =3D get_unaligned_be16(data->buffer);
so that we don't need to think about that complexity or cast the types.

> +
> +	/*
> +	 * Temperature data is invalid if both accel and gyro are off.
> +	 * Return -EBUSY in this case.

Not particularly helpful and currently wrong.  The return bit is obvious
once code fixed so I'd drop that second comment line.

> +	 */
> +	if (*temp =3D=3D INV_ICM42370_DATA_INVALID)
> +		ret =3D -EBUSY;
		return -EBUSY;

> +
> +	return 0;
> +}
> +
> +/**
> + * inv_icm42370_temp_read_raw() - read data from the temperature sensor
> + *
> + * @indio_dev: pointer to the industrial io struct
> + * @chan: pointer to the iio channel specification
> + * @val: integer part of the value
> + * @val2: decimal part of the value
> + * @mask: mask to differentiate between channel info
> + *
> + * Returns 0 on success, negative errno on error
> + */
> +static int inv_icm42370_temp_read_raw(struct iio_dev *indio_dev,
> +				      struct iio_chan_spec const *chan,
> +				      int *val, int *val2, long mask)
> +{
> +	struct inv_icm42370_data *data =3D iio_priv(indio_dev);
> +	s16 temp;
> +	int ret;
> +
> +	if (chan->type !=3D IIO_TEMP)
> +		return -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +		ret =3D inv_icm42370_temp_read(data, &temp);
> +		iio_device_release_direct(indio_dev);
> +		if (ret)
> +			return ret;
> +		*val =3D temp;
> +		return IIO_VAL_INT;
> +	/*
> +	 * T=C2=B0C =3D (temp / 128) + 25
> +	 * Tm=C2=B0C =3D 1000 * ((temp / 128) + 25)
> +	 * Tm=C2=B0C =3D 7.8125 * temp + 25000
> +	 * Tm=C2=B0C =3D (temp + 3200) * 7.8125
> +	 * scale: 1000 / 128 ~=3D 7.8125
> +	 * offset: 3200
> +	 */
> +	case IIO_CHAN_INFO_SCALE:
> +		*val =3D 7;
> +		*val2 =3D 812500;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val =3D 3200;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +/**
> + * inv_icm42370_accel_read_offset() - read offset values from the accele=
rometer
> + *
> + * @data: pointer to struct containing the sensor data
> + * @chan: pointer to iio channel specification
> + * @val: integer part of the value
> + * @val2: decimal part of the value
> + *
> + * Returns 0 on success, negative errno on error
> + */
> +static int inv_icm42370_accel_read_offset(struct inv_icm42370_data *data,
> +					  struct iio_chan_spec const *chan,
> +					  int *val, int *val2)
> +{
> +	struct device *dev =3D regmap_get_device(data->map);
> +	s64 val64;
> +	s32 bias;
> +	unsigned int reg;
> +	s16 offset;
> +	u8 buffer_data[2];
> +	int ret;
> +
> +	if (chan->type !=3D IIO_ACCEL)
> +		return -EINVAL;
> +
> +	switch (chan->channel2) {
> +	case IIO_MOD_X:
> +		reg =3D INV_ICM42370_REG_OFFSET_USER4;
> +		break;
> +	case IIO_MOD_Y:
> +		reg =3D INV_ICM42370_REG_OFFSET_USER6;
> +		break;
> +	case IIO_MOD_Z:
> +		reg =3D INV_ICM42370_REG_OFFSET_USER7;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev, pm);
> +	ret =3D PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&data->lock);
> +
> +	ret =3D inv_icm42370_mreg_read(data, INV_ICM42370_MREG1, reg,
> +				     &data->buffer[0]);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D inv_icm42370_mreg_read(data, INV_ICM42370_MREG1, reg + 1,
> +				     &data->buffer[1]);
> +	if (ret)
> +		return ret;
> +
> +	memcpy(buffer_data, data->buffer, sizeof(buffer_data));
> +
> +	/* 12 bits signed value */
> +	switch (chan->channel2) {
> +	case IIO_MOD_X:
> +		offset =3D sign_extend32(((buffer_data[0] & 0xF0) << 4) | buffer_data[=
1], 11);
> +		break;
> +	case IIO_MOD_Y:
> +		offset =3D sign_extend32(((buffer_data[1] & 0x0F) << 8) | buffer_data[=
0], 11);
> +		break;
> +	case IIO_MOD_Z:
> +		offset =3D sign_extend32(((buffer_data[0] & 0xF0) << 4) | buffer_data[=
1], 11);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * convert raw offset to g then to m/s=C2=B2
> +	 * 12 bits signed raw step 0.5mg to g: 5 / 10000
> +	 * g to m/s=C2=B2: 9.806650
> +	 * result in micro (1000000)
> +	 * (offset * 5 * 9.806650 * 1000000) / 10000
> +	 */
> +	val64 =3D (s64)offset * 5LL * 9806650LL;
> +	/* for rounding, add + or - divisor (10000) divided by 2 */
> +	if (val64 >=3D 0)
> +		val64 +=3D 10000LL / 2LL;
> +	else
> +		val64 -=3D 10000LL / 2LL;
> +
> +	bias =3D div_s64(val64, 10000L);
> +	*val =3D bias / (long)MEGA;
> +	*val2 =3D bias % (long)MEGA;
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +
> +/**
> + * inv_icm42370_accel_write_offset() - write offset values to the accele=
rometer
> + *
> + * @data: pointer to struct containing the sensor data
> + * @chan: pointer to iio channel specification
> + * @val: integer part of the value
> + * @val2: decimal part of the value
> + *
> + * Returns 0 on success, negative errno on error
> + */
> +static int inv_icm42370_accel_write_offset(struct inv_icm42370_data *dat=
a,
> +					   struct iio_chan_spec const *chan,
> +					   int val, int val2)
> +{
> +	struct device *dev =3D regmap_get_device(data->map);
> +	s64 val64;
> +	s32 min, max;
> +	u8 regval;
> +	s16 offset;
> +	int ret;
> +
> +	if (chan->type !=3D IIO_ACCEL)
> +		return -EINVAL;
> +
> +	/* inv_icm42370_accel_calibbias: min - step - max in micro */
> +	min =3D inv_icm42370_accel_calibbias[0] * (long)MEGA +
> +	      inv_icm42370_accel_calibbias[1];
> +	max =3D inv_icm42370_accel_calibbias[4] * (long)MEGA +
> +	      inv_icm42370_accel_calibbias[5];
> +
> +	val64 =3D (s64)val * (s64)MEGA;
> +	if (val >=3D 0)
> +		val64 +=3D (s64)val2;
> +	else
> +		val64 -=3D (s64)val2;
> +
> +	if (val64 < min || val64 > max)
> +		return -EINVAL;
> +
> +	/*
> +	 * convert m/s=C2=B2 to g then to raw value
> +	 * m/s=C2=B2 to g: 1 / 9.806650
> +	 * g to raw 12 bits signed, step 0.5mg: 10000 / 5
> +	 * val in micro (1000000)
> +	 * val * 10000 / (9.806650 * 1000000 * 5)
> +	 */
> +	val64 =3D val64 * 10000LL;
> +
> +	/* for rounding, add + or - divisor (9806650 * 5) divided by 2 */
> +	if (val64 >=3D 0)
> +		val64 +=3D 9806650 * 5 / 2;
> +	else
> +		val64 -=3D 9806650 * 5 / 2;
> +	offset =3D div_s64(val64, 9806650 * 5);
> +
> +	/* clamp value limited to 12 bits signed */
> +	if (offset < -2048)
> +		offset =3D -2048;
> +	else if (offset > 2047)
> +		offset =3D 2047;
> +
> +	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev, pm);
> +	ret =3D PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&data->lock);
> +
> +	switch (chan->channel2) {
> +	case IIO_MOD_X:
> +		/* OFFSET_USER4 register is shared */
> +		ret =3D inv_icm42370_mreg_read(data, INV_ICM42370_MREG1,
> +					     INV_ICM42370_REG_OFFSET_USER4,
> +					     &regval);
> +		if (ret)
> +			return ret;
> +
> +		data->buffer[0] =3D ((offset & 0xF00) >> 4) | (regval & 0x0F);
> +		data->buffer[1] =3D offset & 0xFF;
> +
> +		ret =3D inv_icm42370_mreg_write(data, INV_ICM42370_MREG1,
> +					      INV_ICM42370_REG_OFFSET_USER4,
> +					      data->buffer[0]);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D inv_icm42370_mreg_write(data, INV_ICM42370_MREG1,
> +					      INV_ICM42370_REG_OFFSET_USER5,
> +					      data->buffer[1]);
> +
> +		if (ret)
> +			return ret;
> +		break;
> +
> +	case IIO_MOD_Y:
> +		/* OFFSET_USER7 register is shared */
> +		ret =3D inv_icm42370_mreg_read(data, INV_ICM42370_MREG1,
> +					     INV_ICM42370_REG_OFFSET_USER7,
> +					     &regval);
> +		if (ret)
> +			return ret;
> +
> +		data->buffer[0] =3D offset & 0xFF;
> +		data->buffer[1] =3D ((offset & 0xF00) >> 8) | (regval & 0xF0);
> +
> +		ret =3D inv_icm42370_mreg_write(data, INV_ICM42370_MREG1,
> +					      INV_ICM42370_REG_OFFSET_USER7,
> +					      data->buffer[1]);
> +
> +		if (ret)
> +			return ret;
> +
> +		ret =3D inv_icm42370_mreg_write(data, INV_ICM42370_MREG1,
> +					      INV_ICM42370_REG_OFFSET_USER6,
> +					      data->buffer[0]);
> +		if (ret)
> +			return ret;
> +
> +		break;
> +
> +	case IIO_MOD_Z:
> +		/* OFFSET_USER7 register is shared */
> +		ret =3D inv_icm42370_mreg_read(data, INV_ICM42370_MREG1,
> +					     INV_ICM42370_REG_OFFSET_USER7,
> +					     &regval);
> +		if (ret)
> +			return ret;
> +
> +		data->buffer[0] =3D ((offset & 0xF00) >> 4) | (regval & 0x0F);
> +		data->buffer[1] =3D offset & 0xFF;
> +
> +		ret =3D inv_icm42370_mreg_write(data, INV_ICM42370_MREG1,
> +					      INV_ICM42370_REG_OFFSET_USER7,
> +					      data->buffer[0]);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D inv_icm42370_mreg_write(data, INV_ICM42370_MREG1,
> +					      INV_ICM42370_REG_OFFSET_USER8,
> +					      data->buffer[1]);
> +		if (ret)
> +			return ret;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * inv_icm42370_accel_read_scale() - read scaling data from the accelero=
meter
> + *
> + * @indio_dev: pointer to the industrial io struct
> + * @val: integer part of the value
> + * @val2: decimal part of the value
> + *
> + * Returns 0 on success, negative errno on error
> + */
> +static int inv_icm42370_accel_read_scale(struct iio_dev *indio_dev, int =
*val,
> +					 int *val2)
> +{
> +	struct inv_icm42370_data *data =3D iio_priv(indio_dev);
> +	unsigned int idx;
> +
> +	idx =3D data->conf.fs;
> +
> +	*val =3D data->scales[2 * idx];
> +	*val2 =3D data->scales[2 * idx + 1];
> +	return IIO_VAL_INT_PLUS_NANO;
> +}
> +
> +/**
> + * inv_icm42370_accel_write_scale() - write scaling data to the accelero=
meter
> + *
> + * @indio_dev: pointer to the industrial io struct
> + * @val: integer part of the value
> + * @val2: decimal part of the value
> + *
> + * Returns 0 on success, negative errno on error
> + */
> +static int inv_icm42370_accel_write_scale(struct iio_dev *indio_dev, int=
 val,
> +					  int val2)
> +{
> +	struct inv_icm42370_data *data =3D iio_priv(indio_dev);
> +	struct device *dev =3D regmap_get_device(data->map);
> +	unsigned int idx;
> +	struct inv_icm42370_conf conf =3D INV_ICM42370_SENSOR_CONF_INIT;
> +	int ret;
> +
> +	for (idx =3D 0; idx < data->scales_len; idx +=3D 2) {
> +		if (val =3D=3D data->scales[idx] &&
> +		    val2 =3D=3D data->scales[idx + 1])
> +			break;
> +	}
> +
> +	if (idx >=3D data->scales_len)
> +		return -EINVAL;
> +
> +	conf.fs =3D idx / 2;
> +
> +	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev, pm);
> +	ret =3D PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&data->lock);
> +
> +	ret =3D inv_icm42370_set_accel_conf(data, &conf, NULL);
> +
> +	return ret;
> +}
> +
> +/**
> + * inv_icm42370_accel_read_odr() - read ODR data from the accelerometer
> + *
> + * @data: pointer to struct containing the sensor data
> + * @val: integer part of the value
> + * @val2: decimal part of the value
> + *
> + * Returns 0 on success, negative errno on error
> + */
> +static int inv_icm42370_accel_read_odr(struct inv_icm42370_data *data,
> +				       int *val, int *val2)
> +{
> +	unsigned int odr;
> +	unsigned int i;
> +
> +	odr =3D data->conf.odr;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(inv_icm42370_accel_odr_conv); ++i) {
> +		if (inv_icm42370_accel_odr_conv[i] =3D=3D odr)
> +			break;
> +	}
> +	if (i >=3D ARRAY_SIZE(inv_icm42370_accel_odr_conv))
> +		return -EINVAL;
> +
> +	*val =3D inv_icm42370_accel_odr[2 * i];
> +	*val2 =3D inv_icm42370_accel_odr[2 * i + 1];
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +
> +/**
> + * inv_icm42370_accel_write_odr() - write ODR data to the accelerometer
> + *
> + * @indio_dev: pointer to struct containing the sensor data
> + * @val: integer part of the value
> + * @val2: decimal part of the value
> + *
> + * Returns 0 on success, negative errno on error
> + */
> +static int inv_icm42370_accel_write_odr(struct iio_dev *indio_dev, int v=
al,
> +					int val2)
> +{
> +	struct inv_icm42370_data *data =3D iio_priv(indio_dev);
> +	struct inv_sensors_timestamp *ts =3D &data->ts;
> +	struct device *dev =3D regmap_get_device(data->map);
> +	unsigned int idx;
> +	struct inv_icm42370_conf conf =3D INV_ICM42370_SENSOR_CONF_INIT;
> +	int ret;
> +
> +	for (idx =3D 0; idx < ARRAY_SIZE(inv_icm42370_accel_odr); idx +=3D 2) {
> +		if (val =3D=3D inv_icm42370_accel_odr[idx] &&
> +		    val2 =3D=3D inv_icm42370_accel_odr[idx + 1])
> +			break;
> +	}
> +	if (idx >=3D ARRAY_SIZE(inv_icm42370_accel_odr))
> +		return -EINVAL;
> +
> +	conf.odr =3D inv_icm42370_accel_odr_conv[idx / 2];
> +
> +	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev, pm);
> +	ret =3D PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&data->lock);
> +
> +	ret =3D inv_sensors_timestamp_update_odr(
> +		ts, inv_icm42370_odr_to_period(conf.odr),
> +		iio_buffer_enabled(indio_dev));
> +	if (ret)
> +		return ret;
> +
> +	ret =3D inv_icm42370_set_accel_conf(data, &conf, NULL);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +/**
> + * inv_icm42370_accel_write_raw() - write raw attribute values to the ac=
celerometer
> + * @indio_dev:	pointer to the IIO device structure.
> + * @chan:	pointer to the IIO channel specification.
> + * @val:	integer part of the value to write.
> + * @val2:	fractional part of the value to write.
> + * @mask:	bitmask specifying which attribute to write.
> + *
> + * Returns 0 on success, negative errno on error.
> + */
> +static int inv_icm42370_accel_write_raw(struct iio_dev *indio_dev,
> +					struct iio_chan_spec const *chan,
> +					int val, int val2, long mask)
> +{
> +	struct inv_icm42370_data *data =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	if (chan->type !=3D IIO_ACCEL)
> +		return -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +		ret =3D inv_icm42370_accel_write_scale(indio_dev, val, val2);
> +		iio_device_release_direct(indio_dev);
> +
> +		return ret;
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return inv_icm42370_accel_write_odr(indio_dev, val, val2);
> +
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +
> +		ret =3D inv_icm42370_accel_write_offset(data, chan, val, val2);
> +		iio_device_release_direct(indio_dev);
> +
> +		return ret;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +/**
> + * inv_icm42370_accel_read_sensor() - internal function to read accelero=
meter sensor registers
> + *
> + * @indio_dev: pointer to the industrial I/O struct
> + * @chan: pointer to iio channel specification
> + * @val: pointer containing accelerometer data in s16 format
> + *
> + * Return 0 on success, negative errno on error
> + */
> +static int inv_icm42370_accel_read_sensor(struct iio_dev *indio_dev,
> +					  struct iio_chan_spec const *chan,
> +					  s16 *val)
> +{
> +	struct inv_icm42370_data *data =3D iio_priv(indio_dev);
> +	struct device *dev =3D regmap_get_device(data->map);
> +	struct inv_icm42370_conf conf =3D INV_ICM42370_SENSOR_CONF_INIT;
> +	unsigned int reg;
> +	__be16 *value;
> +	int ret;
> +
> +	if (chan->type !=3D IIO_ACCEL)
> +		return -EINVAL;
> +
> +	switch (chan->channel2) {
> +	case IIO_MOD_X:
> +		reg =3D INV_ICM42370_REG_ACCEL_DATA_X1;
> +		break;
> +	case IIO_MOD_Y:
> +		reg =3D INV_ICM42370_REG_ACCEL_DATA_Y1;
> +		break;
> +	case IIO_MOD_Z:
> +		reg =3D INV_ICM42370_REG_ACCEL_DATA_Z1;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev, pm);
> +	ret =3D PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&data->lock);
> +
> +	/* enable accel sensor */
> +	conf.mode =3D data->power_mode;
> +	conf.filter =3D data->filter;
> +	ret =3D inv_icm42370_set_accel_conf(data, &conf, NULL);
> +	if (ret)
> +		return ret;
> +
> +	/* read accel register data */
> +	value =3D (__be16 *)&data->buffer[0];
> +	ret =3D regmap_bulk_read(data->map, reg, value, sizeof(*value));
> +	if (ret)
> +		return ret;
> +
> +	*val =3D (s16)be16_to_cpup(value);
> +
> +	if (*val =3D=3D INV_ICM42370_DATA_INVALID)
> +		ret =3D -EINVAL;
		return -EINVAL;

	return 0;

as it makes it easier to spot bad vs good paths.

> +
> +	return ret;
> +}
> +
> +/**
> + * inv_icm42370_accel_read_raw() - read data from the accelerometer sens=
or

As below, we'd not normally have kernel-doc for this sort of standard
function callback unless there was something unusual to talk about.
So in the interests of brevity I'd drop it.

> + *
> + * @indio_dev: pointer to the industrial io struct
> + * @chan: pointer to the iio channel specification
> + * @val: integer part of the value
> + * @val2: decimal part of the value
> + * @mask: mask to differentiate between channel info
> + *
> + * Returns 0 on success, negative errno on error
> + */
> +static int inv_icm42370_accel_read_raw(struct iio_dev *indio_dev,
> +				       struct iio_chan_spec const *chan,
> +				       int *val, int *val2, long mask)
> +{
...

> +}

...
> +
> +struct iio_dev *inv_icm42370_accel_init(struct iio_dev *indio_dev,
> +					struct inv_icm42370_data *data)

Given this is setting up a bunch of things in different structures
I'm not sure I see the advantage of factoring it out of probe.
I'd just put this code inline there instead.

> +{
> +	struct inv_sensors_timestamp_chip ts_chip;
> +
> +	data->scales =3D inv_icm42370_accel_scale;
> +	data->scales_len =3D ARRAY_SIZE(inv_icm42370_accel_scale);
> +	data->filter =3D data->conf.filter;
> +	data->power_mode =3D data->conf.mode;
> +
> +	/*
> +	 * clock period is 32kHz (31250ns)
> +	 * jitter is +/- 2% (20 per mille)
> +	 */
> +	ts_chip.clock_period =3D 31250;
> +	ts_chip.jitter =3D 20;
> +	ts_chip.init_period =3D inv_icm42370_odr_to_period(data->conf.odr);
> +	inv_sensors_timestamp_init(&data->ts, &ts_chip);
> +
> +	indio_dev->name =3D "inv_icm42370";
> +	indio_dev->info =3D &inv_icm42370_info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->channels =3D inv_icm42370_accel_channels;
> +	indio_dev->num_channels =3D ARRAY_SIZE(inv_icm42370_accel_channels);
> +
> +	return indio_dev;
> +}
> +
> +/**
> + * inv_icm42370_core_probe() - initialize and register the ICM-42370 dev=
ice
> + * @regmap:	register map for accessing the device's registers.
> + * @chip:	chip identifier, must be %INV_CHIP_ICM42370.
> + * @irq:	interrupt number for the device's data-ready signal.
> + * @bus_setup:	callback to configure bus-specific settings (e.g. I2C).
> + *
> + * Returns 0 on success, a negative error code otherwise.
> + */
> +int inv_icm42370_core_probe(struct regmap *regmap, int chip, int irq,
> +			    inv_icm42370_bus_setup bus_setup)
> +{
> +	struct device *dev =3D regmap_get_device(regmap);
> +	struct fwnode_handle *fwnode =3D dev_fwnode(dev);
> +	struct inv_icm42370_data *data;
> +	struct iio_dev *indio_dev;
> +	int irq_type;
> +	bool open_drain;
> +	int ret;
> +
> +	if (chip !=3D INV_CHIP_ICM42370) {

Pass in a pointer to device specific data and if it is NULL fail out
here. That lets you use the bus specific code to get firmware data like
i2c_get_match_data() that will get it from whatever firmware we have.

> +		dev_err(dev, "invalid chip =3D %d\n", chip);
> +		return -ENODEV;
> +	}
> +
> +	/* get INT1 only supported interrupt or fallback to first interrupt */
> +	irq =3D fwnode_irq_get_byname(fwnode, "INT1");
> +	if (irq < 0 && irq !=3D -EPROBE_DEFER) {
> +		dev_info(dev,
> +			"no INT1 interrupt defined, fallback to first interrupt\n");
> +		irq =3D fwnode_irq_get(fwnode, 0);

If we don't know it is int1 fail probe.  We do this sort of hack only when
we missed in the original driver review that there was a need for interrupt=
-names.
In theory we could have a default in the dt-binding but I don't think it is=
 useful
and you don't have one documented.


> +	}
> +	if (irq < 0)
> +		return dev_err_probe(dev, irq,
> +				     "error missing INT1 interrupt\n");
> +
> +	irq_type =3D irq_get_trigger_type(irq);
> +	if (!irq_type)
> +		irq_type =3D IRQF_TRIGGER_FALLING;

This is papering over broken firmware / old mistakes in drivers that we can=
't
fix now without risking regressions.  Don't do it for a new driver.
If firmware doesn't provide the trigger type then they'll find out
fast when the interrupt doesn't do anything.


> +
> +	open_drain =3D device_property_read_bool(dev, "drive-open-drain");
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data =3D iio_priv(indio_dev);
> +
> +	ret =3D devm_mutex_init(dev, &data->lock);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "unable to initialize mutex\n");
> +
> +	data->chip =3D chip;
> +	data->map =3D regmap;
> +
> +	ret =3D devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable vdd regulator\n");
> +
> +	ret =3D devm_regulator_get_enable(dev, "vddio");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable vddio regulator\n");
> +
> +	ret =3D inv_icm42370_setup(data, bus_setup);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "setup failed\n");
> +
> +	ret =3D iio_read_mount_matrix(dev, &data->orientation);
> +	if (ret) {
> +		dev_err(dev, "failed to retrieve mounting matrix %d\n", ret);
> +		return ret;

		return dev_err_probe() for all errors in probe() and functions
only called from probe.  Minor but it gives nicer looking code and consiste=
nt
formatting.  Deferred handling obviously not relevant for this one!

> +	}
> +
> +	data->indio_accel =3D inv_icm42370_accel_init(indio_dev, data);
> +	if (IS_ERR(data->indio_accel))
> +		return PTR_ERR(data->indio_accel);
> +
> +	ret =3D inv_icm42370_irq_init(data, irq, irq_type, open_drain);
> +	if (ret)
> +		return ret;
> +
> +	/* setup runtime power management */
> +	ret =3D devm_pm_runtime_set_active_enabled(dev);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_set_autosuspend_delay(dev, INV_ICM42370_SUSPEND_DELAY_MS);
> +	pm_runtime_use_autosuspend(dev);
> +
> +	ret =3D devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "unable to register iio device\n");
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(inv_icm42370_core_probe, "IIO_ICM42370");



> diff --git a/drivers/iio/accel/inv_icm42370_i2c.c b/drivers/iio/accel/inv=
_icm42370_i2c.c
> new file mode 100644
> index 0000000000000..c4533671051c4
> --- /dev/null
> +++ b/drivers/iio/accel/inv_icm42370_i2c.c
> @@ -0,0 +1,93 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2020 InvenSense, Inc.
> + * Copyright (C) 2026 Axis Communications AB
> + */
> +
> +#include <linux/device.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +
> +#include "inv_icm42370.h"
> +
> +/**
> + * inv_icm42370_i2c_bus_setup() - I2C bus setup for icm42370

Kind of obvious stuff in this documentation given function and
parameter naming.  I'd drop it and save documentation for where
it provides value or where a function is exported.

> + *
> + * @data: pointer to struct containing the sensor data
> + *
> + * Returns 0 on success, negative errno on error
> + */
> +static int inv_icm42370_i2c_bus_setup(struct inv_icm42370_data *data)
> +{
> +	unsigned int mask, val;
> +	int ret;
> +
> +	/* set slew rates for I2C */
> +	mask =3D INV_ICM42370_DRIVE_CONFIG2_I2C_MASK;
> +	val =3D INV_ICM42370_DRIVE_CONFIG2_I2C(INV_ICM42370_SLEW_RATE_12_36NS);

As noted above, I'd have FIELD_PREP() here so that we can see it is the
relevant mask being used directly.  Don't worry about going a little over 80
chars to do that.

it is far from obvious to em that a field called CONFIG2_I2C would have
anything to do with slew rate.  So rename macros as needed to make it obvio=
us
what the field is alongside the value being written.

> +	ret =3D regmap_update_bits(data->map, INV_ICM42370_REG_DRIVE_CONFIG2,
> +				 mask, val);
> +	if (ret)
> +		return ret;
> +
> +	/* set slew rates for SPI */

In an i2c probe?  this needs an explanation of why we care.

> +	mask =3D INV_ICM42370_DRIVE_CONFIG3_SPI_MASK;
> +	val =3D INV_ICM42370_DRIVE_CONFIG3_SPI(INV_ICM42370_SLEW_RATE_12_36NS);
> +	ret =3D regmap_update_bits(data->map, INV_ICM42370_REG_DRIVE_CONFIG3,
> +				 mask, val);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
Unless this gets more complex in next patch
	return regmap_update_bits()

> +}

One blank line between functions.

> +static int inv_icm42370_probe(struct i2c_client *client)
> +{
> +	const void *match;
> +	enum inv_icm42370_chip chip;
> +	struct regmap *regmap;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_I2C_BLOCK))
> +		return -EOPNOTSUPP;
> +
> +	match =3D device_get_match_data(&client->dev);

As elsewhere if you were doing this (no point yet) then i2c_get_match_data()
to cleanly handle various possible firmware types.

> +	if (!match)
> +		return -EINVAL;
> +	chip =3D (uintptr_t)match;
> +
> +	regmap =3D devm_regmap_init_i2c(client, &inv_icm42370_regmap_config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	return inv_icm42370_core_probe(regmap, chip, client->irq,
> +				       inv_icm42370_i2c_bus_setup);
> +}
> +
> +static const struct i2c_device_id inv_icm42370_id[] =3D {
> +	{ .name =3D "icm42370p", .driver_data =3D INV_CHIP_ICM42370 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, inv_icm42370_id);
> +
> +static const struct of_device_id inv_icm42370_of_matches[] =3D {
> +	{ .compatible =3D "invensense,icm42370p", .data =3D (void *)INV_CHIP_IC=
M42370 },

You are only supporting one device, so for now no .data makes more sense.
When it is added, we very strongly prefer that it be a pointer to a structu=
re
with the device type specific features described. For now rip out the
check on valid data above. We don't really care that much about later
breaking forced device probing from userspace as that is only really a debug
tool and when we have broken it in the past no one has noticed.

That to me is better than making this driver more complex to support multip=
le
parts when it is very common for only one to ever turn up! If you have
other parts you plan to support in the near future, then that is a different
question - add a note on that if so to the cover letter and this patches
description.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, inv_icm42370_of_matches);

