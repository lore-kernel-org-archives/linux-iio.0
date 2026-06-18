Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E113F24E4A1;
	Thu, 18 Jun 2026 19:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781810822; cv=none; b=h3w9NniJptzoC03Ge5gBT8NSUNTS94X2vkRf37+UML8b5oaKU/ItuN6fIlkNQiRodj3TuqniYFT20BGppBueaiBLNlHwMHDYQHhvlLWj1aqXE47DBrynSi1gA2818os4Drq+Vm6HlUJ33eKLvHyIVnT/BRcyZFKJBvPtWVIztW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781810822; c=relaxed/simple;
	bh=gZl7E79zQDlGE4LtabShpnib8u2NkG9HjLdFnbouWzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScOwV9c/0fncAerA0k1KdsA1q2BV602sqCQfc5oi/VEv7rfWTKnQkCfWYvw/4MpoiVrjY9aysMA6QL8xAH1KAp4bjXMoumi3lU6mXfgw0K+etafrn6HQvtCOjZ0Oc22kJtjQn2YSAXwSUvPBplXq3hBiIH/a5uEehxHj65PKJwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SgRlUiF0; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SgRlUiF0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781810821; x=1813346821;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gZl7E79zQDlGE4LtabShpnib8u2NkG9HjLdFnbouWzI=;
  b=SgRlUiF031Xau1sJldkG1155PoyiJcbByCBw6orHTpCTU7ZVX46jClHI
   5qUnen/Ld395nzyI7fUMITdee34UMEBZxXC1UIrD9CuaT6K7ggT+wbCyL
   +d8Qi5CK7KRPc/iDDYDxjwWVubM1oR4Wz+cLqztDOWWAWwH0JgrQP3Sm6
   JeHWqeKVxGnuZ8RBwMRMYXGEmBfCa8EzJdlIKc06Mnf6ub7TqLD6jYUhf
   l7jB1PvLXfVE6yMJcQszNlQBZyIB9/ySkqrUAafNnLCBHm56eQzCCzCVY
   HLVLzPvatf0+aFFZXAclJwjpNmDD/DAbSXESCzBBU0Y0m+0PN28oPW5NA
   g==;
X-CSE-ConnectionGUID: hLXHh0gdTv2CyDV7zS3Xlg==
X-CSE-MsgGUID: s++o8dDlSW6iuhvqjfG/tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11821"; a="82533156"
X-IronPort-AV: E=Sophos;i="6.24,212,1774335600"; 
   d="scan'208";a="82533156"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 12:27:00 -0700
X-CSE-ConnectionGUID: VX26Ufg1TUCbuoXMZf8BDg==
X-CSE-MsgGUID: cQ9DcmwnTNq+pVbHbOKzPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,212,1774335600"; 
   d="scan'208";a="253432874"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.10])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 12:26:57 -0700
Date: Thu, 18 Jun 2026 22:26:55 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nikhil Gautam <nikhilgtr@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: magnetometer: add support for Melexis
 MLX90393
Message-ID: <ajRGf0YT-fCZA1ih@ashevche-desk.local>
References: <20260618160141.11409-1-nikhilgtr@gmail.com>
 <20260618160141.11409-3-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618160141.11409-3-nikhilgtr@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 18, 2026 at 09:31:41PM +0530, Nikhil Gautam wrote:
> Add Industrial I/O subsystem support for the Melexis
> MLX90393 3-axis magnetometer and temperature sensor.
> 
> The driver currently supports:
> 
> raw magnetic field measurements
> raw temperature measurements
> configurable gain/scale selection
> configurable oversampling ratio
> direct mode operation
> 
> The MLX90393 supports both I2C and SPI interfaces. This
> initial implementation adds support for the I2C interface.
> 
> The driver is structured around a shared sensor core with
> a small transport abstraction layer to simplify future SPI
> support without duplicating sensor logic.

...

> +config MLX90393
> +	tristate "MELEXIS MLX90393 3-axis magnetometer sensor"
> +	depends on I2C

Why not a regmap?

> +	help
> +	  Say yes here to build support for the MELEXIS MLX90393 3-axis
> +	  magnetometer.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called mlx90393.
> +
>  config MMC35240
>  	tristate "MEMSIC MMC35240 3-axis magnetic sensor"
>  	select REGMAP_I2C
> diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/Makefile
> index 9297723a97d8..542c89d38a59 100644
> --- a/drivers/iio/magnetometer/Makefile
> +++ b/drivers/iio/magnetometer/Makefile
> @@ -14,6 +14,8 @@ obj-$(CONFIG_BMC150_MAGN_SPI) += bmc150_magn_spi.o
>  
>  obj-$(CONFIG_MAG3110)	+= mag3110.o
>  obj-$(CONFIG_HID_SENSOR_MAGNETOMETER_3D) += hid-sensor-magn-3d.o
> +obj-$(CONFIG_MLX90393)		+= mlx90393_core.o
> +obj-$(CONFIG_MLX90393)		+= mlx90393_i2c.o
>  obj-$(CONFIG_MMC35240)	+= mmc35240.o

...

> +#ifndef MLX90393_H
> +#define MLX90393_H

> +#include <linux/bitops.h>

> +#include <linux/bits.h>

Not required, it's covered by bitops.h.

> +#include <linux/types.h>

...

> +#define MLX90393_MEASURE_ALL \
> +	(MLX90393_MEASURE_TEMP | MLX90393_MEASURE_X | \
> +	MLX90393_MEASURE_Y | MLX90393_MEASURE_Z)

Split logically.

#define MLX90393_MEASURE_ALL \
	(MLX90393_MEASURE_TEMP | \
	 MLX90393_MEASURE_X | MLX90393_MEASURE_Y | MLX90393_MEASURE_Z)

Or just a (long) single line.

...

> +	int (*xfer)(void *context, const u8 *tx, int tx_len,
> +		    u8 *rx, int rx_len);

One line, it's only 81 characters.

> +};
> +
> +int mlx90393_core_probe(struct device *dev,

You want forward declaration for struct device.

> +			const struct mlx90393_transfer_ops *ops,
> +			void *context);
> +

...

+ array_size.h
+ bitfield.h // FIELD_GET()

> +#include <linux/delay.h>

+ errno.h // -Exxx

> +#include <linux/module.h>
> +#include <linux/mutex.h>

+ types.h // uXX

> +#include <linux/unaligned.h>
> +#include <linux/units.h>

IWYU, please (just pointed out a few missing above, there are more).

...

> +/* Datasheet: Table no.17 */
> +static const int mlx90393_scale_table[MLX90393_AXIS_MAX]
> +				[MLX90393_GAIN_MAX]
> +				[MLX90393_RES_MAX] = {

This is broken indentation.

> +	/* XY axis */
> +	{
> +		{ 751, 1502, 3004, 6009},
> +		{ 601, 1202, 2403, 4840},
> +		{ 451, 901, 1803, 3605},
> +		{ 376, 751, 1502, 3004},
> +		{ 300, 601, 1202, 2403},
> +		{ 250, 501, 1001, 2003},
> +		{ 200, 401, 801, 1602},
> +		{ 150, 300, 601, 1202},
> +	},
> +	/* Z axis */
> +	{
> +		{ 1210, 2420, 4840, 9680},
> +		{ 968, 1936, 3872, 7744},
> +		{ 726, 1452, 2904, 5808},
> +		{ 605, 1210, 2420, 4840},
> +		{ 484, 968, 1936, 3872},
> +		{ 403, 807, 1613, 3227},
> +		{ 323, 645, 1291, 2581},
> +		{ 242, 484, 968, 1936},
> +	}
> +};

...

> +/*
> + * Calculate total conversion time in microseconds.
> + *
> + * Formula derived from datasheet timing equations.

Which formula? Where is datasheet? What if I have no access to it?
Always repeat the important details in the comment in the code.

> + */

> +

Unneeded blank line.

> +static int mlx90393_get_tconv_us(struct mlx90393_data *data)
> +{
> +	const int osr = data->osr;
> +	const int osr2 = data->osr2;
> +	const int df = data->dig_filt;
> +
> +	int tconvm;
> +	int tconvt;
> +
> +	int m = 3; /* X,Y,Z */
> +
> +	/*
> +	 * Datasheet:

What chapter/section/table name? Page number?

> +	 * TCONVM = 67 + 64 * 2^OSR * (2 + 2^DIG_FILT)

What does this cryptic message mean? Please, accompany this with more English
plain text.

> +	 */
> +	tconvm = 67 + (64 * BIT(osr) * (2 + BIT(df)));
> +
> +	/*
> +	 * Datasheet:
> +	 * TCONVT = 67 + 192 * 2^OSR2
> +	 */
> +	tconvt = 67 + (192 * BIT(osr2));
> +	/*
> +	 * Total conversion time:
> +	 * TSTBY + TACTIVE + m * TCONVM + TCONVT + TCONV_END
> +	 */
> +	return 220 + 360 + (m * tconvm) + tconvt + 1100;
> +}

...

> +static int mlx90393_xfer(struct mlx90393_data *data,
> +			 const u8 *tx, int tx_len,
> +			 u8 *rx, int rx_len)
> +{
> +	return data->ops->xfer(data->bus_context,
> +			tx, tx_len,
> +			rx, rx_len);

It's perfectly one line.

Also you might want to have

	if (!...->xfer)
		return -E...;

> +}

...

> +static int mlx90393_check_status(u8 cmd, u8 status)
> +{
> +	/* Always validate error bit */
> +	if (status & MLX90393_STATUS_ERROR)
> +		return -EIO;
> +
> +	switch (cmd & MLX90393_CMD_MASK) {
> +	case MLX90393_CMD_RM:
> +		/*
> +		 * D1:D0 indicates response availability
> +		 * 00 means invalid/no measurement
> +		 */
> +		if ((status & MLX90393_STATUS_RESP) == 0)
> +			return -EIO;
> +		return 0;
> +	case MLX90393_CMD_RT:
> +		/* Reset acknowledge */
> +		if (!(status & MLX90393_STATUS_RT))

For sake of consistency you might want to also compare to 0 here.

> +			return -EIO;
> +		return 0;
> +	default:
> +		return 0;
> +	}
> +}

...

> +static int mlx90393_write_reg(struct mlx90393_data *data, u8 reg, u16 val)

Here the variable is named 'reg' there is 'reg_addr'. As I can see the code is
full of inconsistencies (like 2+ people with different style guidelines wrote
it). Please. take your time and check the code and make it consistent.

> +{
> +	u8 tx[4];
> +	u8 status;
> +	int ret;
> +
> +	tx[0] = MLX90393_CMD_WR;
> +	put_unaligned_be16(val, &tx[1]);
> +	/* Register address is encoded in bits [7:2] */
> +	tx[3] = reg << 2;
> +
> +	ret = mlx90393_xfer(data, tx, sizeof(tx), &status, 1);
> +	if (ret)
> +		return ret;
> +
> +	return mlx90393_check_status(tx[0], status);
> +}
> +
> +static int mlx90393_update_bits(struct mlx90393_data *data, u8 reg_addr,
> +				u16 mask, u16 val)
> +{
> +	u16 reg;
> +	int ret;
> +
> +	ret = mlx90393_read_reg(data, reg_addr, &reg);
> +	if (ret)
> +		return ret;

> +	reg &= ~mask;
> +	reg |= (val << __ffs(mask)) & mask;

bitfield.h has macros for this.


> +	return mlx90393_write_reg(data, reg_addr, reg);
> +}

...

> +static int mlx90393_find_osr(int val, int *osr)
> +{
> +	for (unsigned int i = 0; i < MLX90393_OSR_MAX;  i++)
> +		if (mlx90393_osr_avail[i] == val) {
> +			*osr = i;
> +			return 0;
> +		}

Missing {}.

> +	return -EINVAL;
> +}

...

> +static int mlx90393_get_temp_osr2(struct mlx90393_data *data, int *val)
> +{
> +	*val = mlx90393_osr2_avail[data->osr2];

Missing blank line.

> +	return IIO_VAL_INT;
> +}

...

> +static int mlx90393_write_raw(struct iio_dev *indio_dev,
> +			      const struct iio_chan_spec *chan,
> +			      int val, int val2,
> +			      long mask)
> +{
> +	struct mlx90393_data *data = iio_priv(indio_dev);

> +	int ret;

Not needed, return directly.

> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE: {
> +		guard(mutex)(&data->lock);
> +		ret = mlx90393_set_scale(data, chan, val, val2);
> +		return ret;
> +	}
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO: {
> +		guard(mutex)(&data->lock);
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			return mlx90393_set_temp_osr2(data, val);
> +
> +		case IIO_MAGN:
> +			return mlx90393_set_osr(data, val);
> +
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +			/* Datasheet: 22124 millidegC/LSB */
> +		/* Datasheet: temperature offset */

Again, at least put a page, better to have Section/Table/et cetera title.

...

> +static int mlx90393_read_avail(struct iio_dev *indio_dev,
> +			       const struct iio_chan_spec *chan,
> +			       const int **vals,
> +			       int *type,
> +			       int *length,
> +			       long mask)
> +{
> +	struct mlx90393_data *data = iio_priv(indio_dev);
> +	static int scale_avail[MLX90393_GAIN_MAX][MLX90393_AXIS_MAX];
> +	enum mlx90393_axis_type axis;
> +	u8 res;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE: {
> +		guard(mutex)(&data->lock);
> +		axis = chan->channel2 == IIO_MOD_Z;
> +		res = axis ? data->res_z : data->res_xy;
> +
> +		for (unsigned int i = 0; i < MLX90393_GAIN_MAX; i++) {
> +			scale_avail[i][0] = 0;
> +			scale_avail[i][1] = mlx90393_scale_table[axis][i][res];
> +		}
> +
> +		*vals = &scale_avail[0][0];
> +		*type = IIO_VAL_INT_PLUS_NANO;
> +		*length = MLX90393_GAIN_MAX * MLX90393_AXIS_MAX;
> +		return IIO_AVAIL_LIST;
> +	}
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		if (chan->type == IIO_TEMP) {
> +			*vals = mlx90393_osr2_avail;
> +			*type = IIO_VAL_INT;
> +			*length = MLX90393_OSR2_MAX;
> +		} else {
> +			*vals = mlx90393_osr_avail;
> +			*type = IIO_VAL_INT;
> +			*length = MLX90393_OSR_MAX;
> +		}
> +		return IIO_AVAIL_LIST;
> +
> +	default:
> +		return -EINVAL;
> +	}

> +	return -EINVAL;

Besides missing blank line, this is actually a dead code.

> +}

...

> +static int mlx90393_init(struct mlx90393_data *data)
> +{
> +	int ret;
> +	u16 reg;
> +
> +	/* Exit mode */
> +	ret = mlx90393_write_cmd(data, MLX90393_CMD_EX);
> +	if (ret)
> +		return ret;
> +
> +	/* Wait for device comes out of reset */

Datasheet? Empirical?

> +	fsleep(1000);

1 * USEC_PER_MSEC
(will require time.h to be included).

> +	/* Reset device */
> +	ret = mlx90393_write_cmd(data, MLX90393_CMD_RT);
> +	if (ret)
> +		return ret;
> +
> +	/* Wait for device to reset */
> +	fsleep(6000);

As per above.

> +	ret = mlx90393_read_reg(data, MLX90393_REG_CONF1, &reg);
> +	if (ret)
> +		return ret;
> +
> +	data->gain_sel = FIELD_GET(MLX90393_CONF1_GAIN_SEL, reg);
> +	data->hallconf = FIELD_GET(MLX90393_CONF1_HALLCONF, reg);
> +
> +	ret = mlx90393_read_reg(data, MLX90393_REG_CONF3, &reg);
> +	if (ret)
> +		return ret;
> +
> +	data->res_xy = FIELD_GET(MLX90393_CONF3_RES_X, reg);
> +	data->res_z = FIELD_GET(MLX90393_CONF3_RES_Z, reg);
> +	data->dig_filt = FIELD_GET(MLX90393_CONF3_DIG_FILT, reg);
> +	data->osr = FIELD_GET(MLX90393_CONF3_OSR, reg);
> +	data->osr2 = FIELD_GET(MLX90393_CONF3_OSR2, reg);
> +
> +	return 0;
> +}

...

> +int mlx90393_core_probe(struct device *dev,
> +			const struct mlx90393_transfer_ops *ops,
> +			void *context)
> +{
> +	struct iio_dev *indio_dev;
> +	struct mlx90393_data *data;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	devm_mutex_init(dev, &data->lock);

Nonsense. If we don't check the return code of devm_*(), there is a little
reason to use it in the first place. But then one should not use devm further.
Easy fix: check for returned errors.

> +	data->dev = dev;
> +	data->ops = ops;
> +	data->bus_context = context;
> +
> +	indio_dev->name = "mlx90393";
> +	indio_dev->info = &mlx90393_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = mlx90393_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(mlx90393_channels);
> +
> +	ret = mlx90393_init(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to initialize device\n");
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +EXPORT_SYMBOL_GPL(mlx90393_core_probe);

Make it namespaces.

...

+ array_size.h
+ errno.h

> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/mod_devicetable.h>

...and so on.

Same, follow the IWYU principle.

...

> +/*
> + * MLX90393 commands use repeated-start transfers where
> + * every command is followed by a status/data response.
> + */
> +static int mlx90393_i2c_xfer(void *context,
> +			     const u8 *tx, int tx_len,
> +			     u8 *rx, int rx_len)
> +{
> +	struct i2c_client *client = context;
> +	int ret;
> +	struct i2c_msg msgs[2] = {
> +		[0] = {
> +			.addr = client->addr,
> +			.len = tx_len,
> +			.buf = (u8 *)tx,
> +		},
> +		[1] = {
> +			.addr = client->addr,
> +			.flags = I2C_M_RD,
> +			.len = rx_len,
> +			.buf = rx,
> +		},
> +	};
> +
> +	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
> +	if (ret != ARRAY_SIZE(msgs))
> +		return ret < 0 ? ret : -EIO;

Please, make this to be the regular pattern

	if (ret < 0)
		return ret;
	if (ret != ARRAY_SIZE(msgs))
		return -EIO;

> +	return 0;
> +}

...

> +static struct i2c_driver mlx90393_i2c_driver = {
> +	.driver = {
> +		.name = "mlx90393",
> +		.of_match_table = mlx90393_of_match,
> +	},
> +	.probe = mlx90393_i2c_probe,
> +};

> +

Remove this blank line.

> +module_i2c_driver(mlx90393_i2c_driver);

-- 
With Best Regards,
Andy Shevchenko


