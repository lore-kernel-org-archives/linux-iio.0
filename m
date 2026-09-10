Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE613E0094;
	Thu, 10 Sep 2026 09:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789031270; cv=none; b=NFbEXEcMKmnNs1vcYkTZydm5vkzIfVmZbAuJxXDMvonWyaD7Upr3PUj/ia2Pru1WtmLRxlwXySiU3gbhNMO3hF3LV3zc0wYdDf+J6VvwmRhg+ANPIxzNIzCcEUBQfi9rN52SSjhAUh0XaTunXeay1xp3JYGmykPyBvXNABAQm88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789031270; c=relaxed/simple;
	bh=lmD5/3ZwPUmr1/ChbO9kF822vesFBDrT0YZQx611KaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtFluvvXFBT77tBV+Tmto0pTJOGRIbJ9KjyBuhDVkw1TabpDj06eal5dvcA2xm0g1+6d71mjagqc+45QsZx7bpCdOs3XFc2S0qJky1QphZDY9DQpo9biVs9aGOwPDKcdXdaOMiCJSD5ci7EayQgF5TLBcFWbyQ59oOFjbX4WgAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EZDnNCEc; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EZDnNCEc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789031268; x=1820567268;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lmD5/3ZwPUmr1/ChbO9kF822vesFBDrT0YZQx611KaY=;
  b=EZDnNCEc+MasBk49kGoPceQXyK++pU5NhsmxqZk4ULUL3nrOd/A6UwgM
   nc/DGQ5AMdVcaU9g7sW+PpYHi9Cq5Gcui1u/E+pz2UmEwJob73H3ixF0O
   M6FM0Jfl6m0nC5G6z/zSAM+m9M+D05Phd0siQ6+EJN2NGyXq9LGZgdgET
   6+01azgu1WB83oUQiknjMEOfqPD4Hj9GGS5CeDdZI3JuE162D7R4xE5hH
   WSkZ9SfHldabzL1/E5uwMpXA2i5MCAkYjke62duEr8T5LrnTPqCLcztTP
   3HJyTXuwNinsgVzCAJ4J7dXRO6OJyTfZ3pj7FD8yzeuitGabkf5gEbQTM
   w==;
X-CSE-ConnectionGUID: 8kDxi6qtStmZT++bKOrtXQ==
X-CSE-MsgGUID: NJxbimfjQG2GAkNIfRE+fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="88623127"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="88623127"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 02:07:47 -0700
X-CSE-ConnectionGUID: KkhIZCjsSyGh8Esa9xlHlQ==
X-CSE-MsgGUID: U3hWKtEcRLSyLdsSAI+P3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="295064914"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.177])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 02:07:44 -0700
Date: Thu, 10 Sep 2026 12:07:42 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shi Hao <i.shihao.999@gmail.com>,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Subject: Re: [PATCH v3 2/2] iio: light: add AS7343 multi-spectral sensor
 driver
Message-ID: <aqJzXvxHEWi2Ny1g@ashevche-desk.local>
References: <20260910063813.56419-1-marcus.yu.56@gmail.com>
 <20260910063813.56419-3-marcus.yu.56@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910063813.56419-3-marcus.yu.56@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 09, 2026 at 11:38:13PM -0700, Chang Yu wrote:
> This patch adds a driver for the AMS AS7343 14-channel multi-spectral
> sensor with I2C interface.
> 
> The driver exposes 12 spectral channels (11 visible + 1 near-infrared)
> via the IIO sysfs interface. Each channel's raw data is provided as a
> 16-bit little-endian unsigned integer.
> 
> Basic power management (suspend/resume) is supported. Note that power
> management is designed in such a way that we only stop spectrual
> measurements when susepended and do not power off.
> 
> More complex features such as auto-suspend, interrupts, and
> configurable gain/integration time will be added in future patches.

It's v3 already. Can you browse the linux-iio@ mailing list archive and see
what are the common comments on the new contributions? I think you may ask
AI to help with the summary. This patch has tons of what has been repeated
over and over...

...

> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/dev_printk.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>

> +#include <linux/pm.h>

This is implied by pm_runtime.h IIRC.

> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>

...

> +/* AS7343 registers */
> +#define AS7343_ID	    0x5a
> +
> +#define AS7343_ENABLE	    0x80

Make sure the indentation of the definition of the same kind are the same.

...

> +/*
> + * Integration time is calculated as (ATIME + 1) * ((ASTEP + 1) * 2.78us).
> + * Setting a 30 * 1.67ms = 50.1ms integration test as the default for now.
> + */
> +#define AS7343_ATIME			   0x81

I believe this one is related to the register offsets? (see above why)

...

> +static int as7343_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan, int *val,
> +			   int *val2, long mask)

Please, split logically.

			   struct iio_chan_spec const *chan,
			   int *val, int *val2, long mask)

> +{
> +	struct as7343_data *data = iio_priv(indio_dev);
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;
> +	unsigned int unused;
> +	__le16 result;

Preserve reversed xmas tree order.

> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret)
> +		return ret;

Use PM_RUNTIME_ACQUIRE*().

> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW: {
> +		/* Wait until integration time passes for all 3 cycles. */
> +		msleep(160);
> +
> +		/*
> +		 * Reading ASTATUS latches all data registers to this read.
> +		 * We don't care about the returned saturation/gain status for
> +		 * now.
> +		 */
> +		guard(mutex)(&data->mutex);
> +		ret = regmap_read(data->regmap, AS7343_ASTATUS, &unused);
> +		if (ret)
> +			break;
> +
> +		ret = regmap_bulk_read(data->regmap, chan->address, &result, 2);

sizeof()

> +		if (ret)
> +			break;
> +
> +		*val = le16_to_cpu(result);
> +		ret = IIO_VAL_INT;
> +		break;
> +	}
> +
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	pm_runtime_put(dev);
> +	return ret;
> +}

(All comments for the above function is what has been repeated in many
 contributions for sure.)

 ...

> +static const char *as7343_channel_label(struct iio_chan_spec const *chan)
> +{
> +	switch (chan->channel) {
> +	case AS7343_CHAN_IDX_FZ:
> +		return "FZ";
> +	case AS7343_CHAN_IDX_FY:
> +		return "FY";
> +	case AS7343_CHAN_IDX_FXL:
> +		return "FXL";
> +	case AS7343_CHAN_IDX_NIR:
> +		return "NIR";
> +	case AS7343_CHAN_IDX_F2:
> +		return "F2";
> +	case AS7343_CHAN_IDX_F3:
> +		return "F3";
> +	case AS7343_CHAN_IDX_F4:
> +		return "F4";
> +	case AS7343_CHAN_IDX_F6:
> +		return "F6";
> +	case AS7343_CHAN_IDX_F1:
> +		return "F1";
> +	case AS7343_CHAN_IDX_F7:
> +		return "F7";
> +	case AS7343_CHAN_IDX_F8:
> +		return "F8";
> +	case AS7343_CHAN_IDX_F5:
> +		return "F5";
> +	default:
> +		return NULL;
> +	}

Why not keeping this in a static array?

> +}
> +
> +static int as7343_read_label(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, char *label)
> +{
> +	const char *name;
> +
> +	name = as7343_channel_label(chan);
> +	if (!name)
> +		return -EINVAL;

Why? Can't it be taken from DT?

> +	return sysfs_emit(label, "%s\n", name);
> +}

...

> +static const struct regmap_config as7343_regmap_config = {
> +	.name = "as7343",
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = AS7343_MAX,
> +	.reg_format_endian = REGMAP_ENDIAN_LITTLE,
> +	.val_format_endian = REGMAP_ENDIAN_LITTLE,

> +	.cache_type = REGCACHE_NONE,

Why?! This needs a very good justification.

> +};

...

> +static int as7343_setup_device(struct device *dev, struct as7343_data *data)
> +{

	struct regmap *map = data->regmap;

will help to reduce verbosity of the below, and might even save some LoC...

> +	unsigned int val;
> +	__le16 step;
> +	int ret;
> +
> +	/* Power on */
> +	ret = regmap_set_bits(data->regmap, AS7343_ENABLE, AS7343_ENABLE_PON);
> +	if (ret)
> +		return ret;
> +
> +	/* Need to set REG_BANK to 1 before we can access ID */
> +	ret = regmap_set_bits(data->regmap, AS7343_CFG0, AS7343_CFG0_REG_BANK);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(data->regmap, AS7343_ID, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val != 0x81)
> +		dev_info(dev, "Unknown device ID: %x\n", val);
> +
> +	ret = regmap_clear_bits(data->regmap, AS7343_CFG0,
> +				AS7343_CFG0_REG_BANK);

...for example, here:

	ret = regmap_clear_bits(map, AS7343_CFG0, AS7343_CFG0_REG_BANK);

> +	if (ret)
> +		return ret;
> +
> +	/* Configure the SMUX to readout all channels */

> +	ret = regmap_update_bits(

Huh?! Please, check the formatting and indentation style.

> +		data->regmap, AS7343_CFG20, AS7343_CFG20_AUTO_SMUX,
> +		FIELD_PREP(AS7343_CFG20_AUTO_SMUX,
> +			   AS7343_CFG20_AUTO_SMUX_READOUT_ALL));
> +	if (ret)
> +		return ret;
> +
> +	/* Set 50.1ms integration time and x256 gain for now */
> +	step = cpu_to_le16(AS7343_ASTEP_VAL);
> +	ret = regmap_bulk_write(data->regmap, AS7343_ASTEP, &step, 2);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(data->regmap, AS7343_ATIME, AS7343_ATIME_VAL);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(data->regmap, AS7343_CFG1, AS7343_CFG1_AGAIN,
> +				  FIELD_PREP(AS7343_CFG1_AGAIN,
> +					     AS7343_CFG1_AGAIN_X256));
> +}

...

> +static int as7343_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct as7343_data *data = iio_priv(indio_dev);
> +
> +	return regmap_clear_bits(data->regmap, AS7343_ENABLE,
> +				 AS7343_ENABLE_SP_EN);
> +}
> +
> +static int as7343_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct as7343_data *data = iio_priv(indio_dev);
> +
> +	return regmap_set_bits(data->regmap, AS7343_ENABLE,
> +			       AS7343_ENABLE_SP_EN);
> +}

Same, use temporary for struct regmap.

...

> +static int as7343_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct as7343_data *data;
> +	struct iio_dev *indio_dev;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	regmap = devm_regmap_init_i2c(client, &as7343_regmap_config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->regmap = regmap;

> +	mutex_init(&data->mutex);

devm_mutex_init().

> +
> +	indio_dev->name = "as7343";
> +	indio_dev->info = &as7343_info;
> +	indio_dev->channels = as7343_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(as7343_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return ret;
> +
> +	ret = as7343_setup_device(dev, data);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(dev, as7343_suspend_action, dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to add suspend action\n");
> +
> +	ret = pm_runtime_set_active(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to activate PM runtime\n");
> +
> +	ret = devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable PM runtime\n");
> +
> +	/* Start measurements */
> +	ret = regmap_set_bits(data->regmap, AS7343_ENABLE, AS7343_ENABLE_SP_EN);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

...

> +static DEFINE_RUNTIME_DEV_PM_OPS(as7343_pm_ops, as7343_suspend, as7343_resume,
> +				 NULL);

Again, split logically. Options are:

static DEFINE_RUNTIME_DEV_PM_OPS(as7343_pm_ops, as7343_suspend, as7343_resume, NULL);

static DEFINE_RUNTIME_DEV_PM_OPS(as7343_pm_ops,
				 as7343_suspend, as7343_resume, NULL);

static DEFINE_RUNTIME_DEV_PM_OPS(as7343_pm_ops,
				 as7343_suspend,
				 as7343_resume,
				 NULL);

(I personally prefer compromise as depicted in the second example).

...

> +static const struct of_device_id as7343_of_match[] = {
> +	{ .compatible = "ams,as7343" },
> +	{ },

No comma in the terminator entry.

> +};
> +MODULE_DEVICE_TABLE(of, as7343_of_match);
> +
> +static const struct i2c_device_id as7343_id[] = {
> +	{ .name = "as7343" },
> +	{ },

Ditto.

> +};
> +MODULE_DEVICE_TABLE(i2c, as7343_id);

...

> +static struct i2c_driver as7343_driver = {
> +	.driver = {
> +		.name           = "as7343",
> +		.of_match_table = as7343_of_match,
> +		.pm             = pm_ptr(&as7343_pm_ops),
> +	},
> +	.probe      = as7343_probe,
> +	.id_table   = as7343_id,

Indentation of the assignees with tabs makes it harder to maintain (in case
more lines got added it might require to reindent all of them).

> +};
> +module_i2c_driver(as7343_driver);

-- 
With Best Regards,
Andy Shevchenko


