Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7DA3822B7;
	Sun, 18 Oct 2026 19:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792351631; cv=none; b=RtoLff8d2DyUrjv+tcGsMJX0R+y+dRFVEWV2IInZk7841nVuXjM1lCM+mca24td6c8rGLFAdGB1ssPeWIILJJHEqGliuN72uG64ScsBYaAajzIVRS0V5vNQb5vcwrQs6vqmVL+WFoODv8wsDDsNwL7YRPREgNxg1Vjro9vT3MPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792351631; c=relaxed/simple;
	bh=vlGuuYwKjsULoGurECIsF4wKWBr7uHIqcOLaHP/f7jw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HzUztKxWBvRcW4dPQ6EFxcTKd3tawnk7IBX1piHM9KGokq1g70B174PWfAfJiGnSIJURezfZGGoedfRyEkEheCXxb3Fka861z2Gz9ZDkM9nkMAlvTV4/BHH2TL9vMy9zBCOIVA65tZ6Cjd4RlDz41abs8DYAvVAeNowGl7+7has=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkXWXpb8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkXWXpb8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2A61F000C4;
	Sun, 18 Oct 2026 19:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792351629;
	bh=4Gzoj6piwXzM3MYrc2vZoyqvTe0zo9qu9OThfWl7y4M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HkXWXpb8Qq1Qt6QXtPM7JvIoXB8KFRGawdvENBEg6e6WA57C1r1QqyRWAN94xg9N1
	 iHJxIeZMr1JCFzXlSZWgwXgVk6RNtvfmB/7GUx5f9E6R/gQ9lq3CmOMCJMSa3bksL5
	 R9f5//kQ5PqqOGTJ7/Ux90TaPBm95hKON8OkY40jR/WRV/7eVBbK+6EqEZb84kRRSn
	 aSszCtWoTZO//VuqGdNUyyfk03IDr2SQapVCKt9q22GQANTAOUjea8FAWoi8kR+vfN
	 YM/FLgnO5RYKZzHnBoJyIa8wrV8xDt9n/YNM0CDOF3qbj64qwkYB4J4j9rJwtZUoGC
	 JekLTi2moGZRQ==
Date: Sun, 18 Oct 2026 20:27:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Guenter Roeck <linux@roeck-us.net>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>, Neil
 Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 3/3] iio: adc: add support for PAC1711
Message-ID: <20261018202704.4ac77274@jic23-hlaptop>
In-Reply-To: <20261007-pac1711-v4-3-6ef34d7a7947@microchip.com>
References: <20261007-pac1711-v4-0-6ef34d7a7947@microchip.com>
	<20261007-pac1711-v4-3-6ef34d7a7947@microchip.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Oct 2026 17:41:55 +0300
Ariana Lazar <ariana.lazar@microchip.com> wrote:

> This is the iio driver for Microchip PAC1711, PAC1721, PAC1811 and
> PAC1821 single-channel power monitors with accumulator. The PAC1711 and
> PAC1721 devices use 12-bit resolution for voltage and current measurements
> and 24 bits for power calculations, while PAC1811 and PAC1821 have 16-bit
> resolution and use 32 bits for power calculations. The 56-bit accumulator
> register accumulates power (energy) or current (Coulomb counter).
> 
> PAC1711 and PAC1811 measure up to 42V Full-Scale Range, respectively 9V for
> PAC1721 and PAC1821.
> 
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
+CC Neil as another user for the be56 patch in here.
I've suggested Ariana carry Neil's patch as well as a precursor to this
one and that way I'll get it with whoever's series merges first.

A few minor comments inline.  Coming together nicely.

Jonathan


> diff --git a/drivers/iio/adc/pac1711.c b/drivers/iio/adc/pac1711.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..c6795d86e38664e52a7aea9ff723c3c1e7139de8
> --- /dev/null
> +++ b/drivers/iio/adc/pac1711.c
> @@ -0,0 +1,1231 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * IIO driver for PAC1711 Single-Channel DC Power/Energy Monitor
> + *
> + * Copyright (C) 2025 Microchip Technology Inc. and its subsidiaries
> + *
> + * Author: Ariana Lazar <ariana.lazar@microchip.com>
> + *
> + * Datasheet links:
> + * [PAC1711]: https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/PAC1711-Data-Sheet-DS20007058.pdf
> + * [PAC1721]: https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/PAC1721-Single-Channel-Power-Monitor-with-Accumulator-DS20007088.pdf
> + * [PAC1811]: https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/PAC1811-Data-Sheet-DS20007066.pdf
> + * [PAC1821]: https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/PAC1821-Data-Sheet-DS20007097.pdf
> + */
> +#include <linux/array_size.h>
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/cleanup.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/jiffies.h>
> +#include <linux/kstrtox.h>
> +#include <linux/module.h>
> +#include <linux/math64.h>
> +#include <linux/mutex.h>
> +#include <linux/overflow.h>
> +#include <linux/property.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>
> +#include <linux/units.h>
> +#include <linux/workqueue.h>
> +#include <asm/byteorder.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

I may be missing something, but please check if you still need this last include.

> +
> +static inline u64 pac1711_get_unaligned_be56(u8 *p)
> +{
> +	return (u64)p[0] << 48 | (u64)p[1] << 40 | (u64)p[2] << 32 |
> +		(u64)p[3] << 24 | p[4] << 16 | p[5] << 8 | p[6];
> +}
Neil Amstrong has a patch on list adding a generic version of this.
https://lore.kernel.org/all/20261013-topic-sm8x50-iio-max34417-adc-v3-2-d3604ae4a229@linaro.org/

If you can add that to start of your series, then I'll deal with
picking it up with whoever's series lands first.
+CC Neil for info on this.


> +
> +static int pac1711_reg_snapshot_locked(struct pac1711_chip_info *info, bool do_refresh,
> +				       u8 refresh_cmd, u32 wait_time)
> +{
> +	struct i2c_client *client = info->client;
...

> +
> +	offset_reg_data_p += PAC1711_VACC_REG_LEN;
> +
> +	/* VBUS */
> +	info->chip_reg_data.vbus = get_unaligned_be16(offset_reg_data_p);
> +
> +	if (info->vbus_mode != PAC1711_FULL_RANGE_UNIPOLAR)
> +		info->chip_reg_data.vbus = sign_extend32(info->chip_reg_data.vbus, 15);
This is the sign extension vs read elsewhere bug that sashiko pointed out.

> +
> +static const struct iio_chan_spec_ext_info pac1711_ext_info[] = {
> +	{
> +		.name = "in_shunt_resistor",
> +		.read = pac1711_read_shunt_resistor,
> +		.write = pac1711_write_shunt_resistor,
> +		.shared = IIO_SHARED_BY_ALL,

Hmm. We'd normally put shared by all stuff in all channels, but
shunt resistor is a bit unusual as it only affects a few of them.

I think I'd still put it in the lot.

> +	},
> +	{ }
> +};
> +
> +#define PAC1711_VBUS_CHANNEL(_index, _address) {				\
> +	.type = IIO_VOLTAGE,							\
> +	.address = (_address),							\
> +	.indexed = 1,								\
> +	.channel = (_index),							\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
> +			      BIT(IIO_CHAN_INFO_SCALE),				\
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
> +	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +}
> +
> +#define PAC1711_VSENSE_CHANNEL(_index, _address) {				\
> +	.type = IIO_CURRENT,							\
> +	.address = (_address),							\
> +	.indexed = 1,								\
> +	.channel = (_index),							\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
> +			      BIT(IIO_CHAN_INFO_SCALE),				\
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
> +	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +	.ext_info = pac1711_ext_info,						\
> +}
> +
> +#define PAC1711_VPOWER_CHANNEL(_index, _address) {				\
> +	.type = IIO_POWER,							\
> +	.address = (_address),							\
> +	.indexed = 1,								\
> +	.channel = (_index),							\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
> +			      BIT(IIO_CHAN_INFO_SCALE),				\
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
> +	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +}
> +
> +#define PAC1711_ACC_CHANNEL(_index, _address, _type) {				\
> +	.type = (_type),							\
> +	.address = (_address),							\
> +	.indexed = 1,								\
> +	.channel = (_index),							\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)	|			\
> +			      BIT(IIO_CHAN_INFO_SCALE)	|			\
> +			      BIT(IIO_CHAN_INFO_ENABLE),			\
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
> +	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +}
> +
> +static int pac1711_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct pac1711_chip_info *info = iio_priv(indio_dev);
> +	u64 tmp = 0;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = pac1711_retrieve_data(info, PAC1711_MIN_UPDATE_WAIT_TIME_US);
> +		if (ret)
> +			return ret;
> +
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			*val = info->chip_reg_data.vbus;
> +			return IIO_VAL_INT;
> +		case IIO_CURRENT:
> +			*val = info->chip_reg_data.vsense;
> +			return IIO_VAL_INT;
> +		case IIO_POWER:
> +			scoped_guard(mutex, &info->lock) {
> +				*val = (u32)info->chip_reg_data.vpower;
> +				*val2 = (u32)(info->chip_reg_data.vpower >> 32);
> +			}
> +			return IIO_VAL_INT_64;
> +		case IIO_ENERGY:
> +		case IIO_CHARGE:
> +			scoped_guard(mutex, &info->lock) {
> +				*val = (u32)info->chip_reg_data.acc_val;

Could use lower_32_bits / upper_32_bits.
Maybe we should just have a helper for this given it is
becoming rather more common.
				iio_fill_val_int_64(info->chip_reg_data.acc_val, val, val2);

I don't mind if you want to leave that a follow up for someone else to do though.

As below on preferring guard where we don't need to control
the scope to part of a case block.

> +				*val2 = (u32)(info->chip_reg_data.acc_val >> 32);
> +			}
> +			return IIO_VAL_INT_64;
> +		default:
> +			return -EINVAL;
> +		}
...

> +		}
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		scoped_guard(mutex, &info->lock) {
Slightly preference for:
	case IIO_CHAN_INFO_SAMP_FREQ: {
		guard(mutex)(&info->lock);
		*val = ...
		return IIO_VAL_INT;
	}
mostly because it reduces the indent a little.

> +			*val = pac1711_samp_rate_map_tbl[info->sample_rate_idx];
> +		}
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_ENABLE:
> +		scoped_guard(mutex, &info->lock) {
> +			*val = info->enable_acc;
> +		}
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}



> +
> +static int pac1711_chip_identify(struct iio_dev *indio_dev, struct pac1711_chip_info *info)
> +{
> +	struct i2c_client *client = info->client;
> +	struct device *dev = &client->dev;
> +	u8 chip_rev_info[3] = {};

{ }; preferred.  I picked the standard for IIO on this a while back as
a fairly random choice.  Not important really.

> +	int ret;
> +
> +	ret = i2c_smbus_read_i2c_block_data(client, PAC1711_PID_REG_ADDR,
> +					    sizeof(chip_rev_info), chip_rev_info);
> +	if (ret != sizeof(chip_rev_info)) {
> +		ret = ret < 0 ? ret : -EIO;
> +		return dev_err_probe(dev, ret, "product ID not recognized\n");
> +	}
> +
> +	info->features = pac1711_get_features_from_id(chip_rev_info[0]);
> +	if (!info->features)
> +		return -ENODEV;
> +
> +	indio_dev->name = info->features->name;
> +
> +	return 0;
> +}
> +
> +static int pac1711_check_range(s32 *vals, bool is_vbus, unsigned int voltage_range_idx)
> +{
> +	int num_ranges = ARRAY_SIZE(pac1711_vbus_range_tbl[PAC1711_VOLTAGE_RANGE_IDX]);
> +	const int (*ranges)[3][2];
> +	int i;
> +
> +	if (is_vbus) {
> +		switch (voltage_range_idx) {
> +		case PAC1711_VOLTAGE_RANGE_IDX:
> +			ranges = &pac1711_vbus_range_tbl[PAC1711_VOLTAGE_RANGE_IDX];
> +			break;
> +		case PAC1721_VOLTAGE_RANGE_IDX:
> +			ranges = &pac1711_vbus_range_tbl[PAC1721_VOLTAGE_RANGE_IDX];
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	} else {
> +		ranges = &pac1711_vsense_range_tbl;
> +	}
> +
> +	for (i = 0; i < num_ranges; i++) {

	for (unsigned int i = 0; i < num_ranges; i++)
look for other places where you can do this as keeps scope of i tighter and
saves a line of code.

> +		if (vals[0] == (*ranges)[i][0] && vals[1] == (*ranges)[i][1])
> +			return i;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int pac1711_init_vbus_vsense_ranges(struct pac1711_chip_info *info, bool is_vbus)
> +{
> +	struct i2c_client *client = info->client;
> +	struct device *dev = &client->dev;
> +	const char *prop_name;
> +	u32 vals[2];
> +	int ret;
> +
> +	if (is_vbus)
> +		prop_name = "microchip,vbus-input-range-microvolt";
> +	else
> +		prop_name = "microchip,vsense-input-range-microvolt";
> +
> +	if (device_property_present(dev, prop_name)) {
> +		ret = device_property_read_u32_array(dev, prop_name, vals, 2);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Cannot read %s property\n", prop_name);
> +

Perhaps add a comment here that we really do want to treat them as signed.

> +		ret = pac1711_check_range((s32 *)vals, is_vbus,
> +					  info->features->voltage_range_idx);
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret,
> +					     "Invalid value %u, %u for prop %s\n",
> +					     vals[0], vals[1], prop_name);
> +	} else {
> +		ret = PAC1711_FULL_RANGE_UNIPOLAR;
> +	}
> +
> +	if (is_vbus)
> +		info->vbus_mode = ret;
> +	else
> +		info->vsense_mode = ret;
> +
> +	return 0;
> +}
> +
> +static int pac1711_parse_fw(struct i2c_client *client, struct pac1711_chip_info *info)
> +{
> +	struct device *dev = &client->dev;
> +	const char *acc_mode;
> +	int ret;
> +
> +	ret = device_property_read_u32(dev, "shunt-resistor-micro-ohms", &info->shunt);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Shunt resistor property error\n");
> +
> +	if (!info->shunt)
> +		return dev_err_probe(dev, -EINVAL, "Invalid value for shunt resistor\n");
> +
> +	ret = pac1711_init_vbus_vsense_ranges(info, true);
> +	if (ret)
> +		return ret;
> +
> +	ret = pac1711_init_vbus_vsense_ranges(info, false);
> +	if (ret)
> +		return ret;
> +
> +	if (device_property_present(dev, "microchip,accumulation-source")) {
> +		ret = device_property_read_string(dev, "microchip,accumulation-source", &acc_mode);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Cannot read accumulation-source\n");
> +
> +		if (!strcmp(acc_mode, PAC1711_ACC_ENERGY_STR))
> +			info->accumulation_mode = PAC1711_ACCMODE_VPOWER;
> +		else if (!strcmp(acc_mode, PAC1711_ACC_CHARGE_STR))
> +			info->accumulation_mode = PAC1711_ACCMODE_VSENSE;

Can we use fwnode_property_match_property_string() for this? 
Could add a device variant for that to make it simpler still.



> +		else
> +			return dev_err_probe(dev, -EINVAL,
> +					     "invalid accumulation-source value %s\n", acc_mode);
> +	} else {
> +		info->accumulation_mode = PAC1711_ACCMODE_VPOWER;
> +		acc_mode = PAC1711_ACC_ENERGY_STR;
> +	}
> +
> +	dev_dbg(dev, "Accumulation source set to: %s\n", acc_mode);
> +
> +	return 0;
> +}


> +static int pac1711_setup_channels(struct iio_dev *indio_dev, struct pac1711_chip_info *info)
> +{
> +	switch (info->accumulation_mode) {
> +	case PAC1711_ACCMODE_VPOWER:
> +		indio_dev->channels = pac1711_energy_chan_spec;
> +		indio_dev->num_channels = ARRAY_SIZE(pac1711_energy_chan_spec);
> +		break;

As you are respinning anyway, I'd slightly prefer a return 0 instead of break.
Saves a couple of lines of code and looking down to see if anything else
happens.  If that means more churn for some future feature patch you haven't posted
yet feel free to ignore this.

> +	case PAC1711_ACCMODE_VSENSE:
> +		indio_dev->channels = pac1711_charge_chan_spec;
> +		indio_dev->num_channels = ARRAY_SIZE(pac1711_charge_chan_spec);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pac1711_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec const *channel,
> +			      const int **vals, int *type, int *length, long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*type = IIO_VAL_INT;
> +		*vals = pac1711_samp_rate_map_tbl;

I think sashiko mentioned this.   The map_tbl is unsigned yet we are using it
as signed here.  Maybe just make it signed?  Looks like all the values fit anyway.

> +		*length = ARRAY_SIZE(pac1711_samp_rate_map_tbl);
> +		return IIO_AVAIL_LIST;
> +	}
> +
> +	return -EINVAL;
> +}



