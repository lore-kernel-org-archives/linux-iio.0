Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A2130648C;
	Sat, 16 May 2026 18:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778955695; cv=none; b=KopfhlB6cPIjf57tawauFm6dvbA0k07aqohy2LNr8EELKwb9ODuSWXm140RFSpdWNv/CUUBUvhhAdgmurUYz/bc7ce/KBwm8KpX0J/WQkjmN4LlsObGvOBcX0kRmRNRDJagWVLta4RuFuV0z5fvCvwjLS/ZZVT41FUt8M120EOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778955695; c=relaxed/simple;
	bh=SUSn16bSczw+45CXiz8mDNZKNmkHq9fFamg8hKikcp4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qWpLicNYLt5bkTWzQ4PXYZ8KNeQMUubkXBicLQXgWZ4dQaMO0GXzHupKiNNX4+ci6t9u+GRKyq9/GePFUxvkTsJXd/VRXflmHz53gU/cICDwDk1vVi/HHBtlHAmHmXCjJGe20Y1Ruzk3fg+W4jgwCIe+PjFy4tm6JPEf1BdyI5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMZqRnb4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMZqRnb4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8DBC2BCC9;
	Sat, 16 May 2026 18:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778955695;
	bh=SUSn16bSczw+45CXiz8mDNZKNmkHq9fFamg8hKikcp4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iMZqRnb4l06Z+Lhd5B8lVAD+y7WaQVRqRxLh375rQ9AHDds+nVjt+3reQ1G8kifbM
	 kkPyzjSA4bDXVAwfM8+oZgJ6zH/93zQxIaYxkzrW5kF447tCmjG88p4yh2mFjiwt81
	 uiQBqO9uqm8D4fTBtvhBbCxT78dLuPB4+CFvElFurd9jaGXKPglRIvpbnRVKr8IA9/
	 2wYiVoUgRLR9lw6yMHBeolnrtfbmGcwe9R67220mRzT0hkAfIb2iRS5Ch/dfy9MElK
	 VulZHabi6nuvyil5RKzQlu4fGv1jA+rMfVl9dpkirmNDJlIczxFCfDKHyGgFeWZYnS
	 X8mGQqtyZOpEw==
Date: Sat, 16 May 2026 19:21:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <marius.cristea@microchip.com>
Cc: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <broonie@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] iio: adc: add support for PAC194X
Message-ID: <20260516192125.1aa37ff7@jic23-huawei>
In-Reply-To: <20260515092946.10791-3-marius.cristea@microchip.com>
References: <20260515092946.10791-1-marius.cristea@microchip.com>
	<20260515092946.10791-3-marius.cristea@microchip.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 May 2026 12:29:46 +0300
<marius.cristea@microchip.com> wrote:

> From: Marius Cristea <marius.cristea@microchip.com>
> 
> This is the iio driver for Microchip PAC194X and PAC195X series of
> Power Monitors with Accumulator. The PAC194X family supports 9V
> Full-Scale Range and the PAC195X supports 32V Full-Scale Range.
> 
> There are two versions of the PAC194X/5X: the PAC194X/5X-1 devices
> are for high-side current sensing and the PAC194X/5X-2 devices are
> for low-side current sensing or floating VBUS applications. The
> PAC194X/5X-1 is named shortly PAC194X/5X.
> 
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>

If you can find a way to break this up and add features over a series
of patches that would make it a lot easier to review.

The huge nature of the patch means review quality will be down
(I'm definitely tired now!).

Sashiko had fun
https://sashiko.dev/#/patchset/20260515092946.10791-1-marius.cristea%40microchip.com

Not all are necessarily write but some definitely are.
The DMA + stack stuff is relevant for i2c which will by default bounce data
anyway.

Biggest thing in here is I wonder if we can make the _acc bit a modifier
and then fit the majority if not all of the custom attrs related to that
into standard channel definitions.

Jonathan



> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 097357d146ba..0e1cc47b68a1 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -113,6 +113,7 @@ obj-$(CONFIG_NPCM_ADC) += npcm_adc.o
>  obj-$(CONFIG_NXP_SAR_ADC) += nxp-sar-adc.o
>  obj-$(CONFIG_PAC1921) += pac1921.o
>  obj-$(CONFIG_PAC1934) += pac1934.o
> +obj-$(CONFIG_PAC1934) += pac1944.o

Sashiko got this one. I doubt many humans would notice but that's
the wrong CONFIG.

Anyhow, I'll not point out everything it raised - will assume
you've dealt with any that are correct.

>  obj-$(CONFIG_PALMAS_GPADC) += palmas_gpadc.o
>  obj-$(CONFIG_QCOM_PM8XXX_XOADC) += qcom-pm8xxx-xoadc.o
>  obj-$(CONFIG_QCOM_SPMI_ADC5) += qcom-spmi-adc5.o
> diff --git a/drivers/iio/adc/pac1944.c b/drivers/iio/adc/pac1944.c
> new file mode 100644
> index 000000000000..3938bbcd7e6b
> --- /dev/null
> +++ b/drivers/iio/adc/pac1944.c
> @@ -0,0 +1,2172 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * IIO driver for PAC194X and PAC195X series chips
> + *
> + * Copyright (C) 2022-2026 Microchip Technology Inc. and its subsidiaries
> + *
> + * Author: Marius Cristea marius.cristea@microchip.com
> + *
> + * Datasheet for PAC1941, PAC1942, PAC1943 and PAC1944 can be found here:
> + * https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/PAC194X-Family-Data-Sheet-DS20006543.pdf
> + * Datasheet for PAC1951, PAC1952, PAC1953 and PAC1954 can be found here:
> + * https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/PAC195X-Family-Data-Sheet-DS20006539.pdf
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
This looks too minimal.

Apply the somewhat fuzzy include what we use stuff we use for kernel.
dev_printk.h is missing for instance as is mod_devicetable.h
I haven't looked beyond those.

> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/property.h>
> +#include <linux/unaligned.h>
> +

> +/* Maximum power-product value - 32 V * 0.1 V */
> +#define PAC195X_PRODUCT_VOLTAGE_PV_FSR		3200000000000UL
> +
> +/* Maximum power-product value - 9 V * 0.1 V */
> +#define PAC194X_PRODUCT_VOLTAGE_PV_FSR		900000000000UL

Can we use some of the multiplier types to express that in a form
that doesn't leave us counting zeros.  Same for other cases
with more than say 6 zeros.



> +
> +#define PAC1944_MEAS_REG_SNAPSHOT_LEN		80
> +#define PAC1944_CTRL_REG_SNAPSHOT_LEN		24

> +static const int pac1944_adc_range_tbl[][2] = {
> +	[PAC1944_ADC_FULL_RANGE_BIPOLAR] = {-9000000, 9000000},
> +	[PAC1944_ADC_HALF_RANGE_BIPOLAR] = {-4500000, 4500000},
> +	[PAC1944_ADC_FULL_RANGE_UNIPOLAR] = {0, 9000000},
> +};
> +
> +static const int pac1954_adc_range_tbl[][2] = {
> +	[PAC1944_ADC_FULL_RANGE_BIPOLAR] = {-32000000, 32000000},
> +	[PAC1944_ADC_HALF_RANGE_BIPOLAR] = {-16000000, 16000000},
> +	[PAC1944_ADC_FULL_RANGE_UNIPOLAR] = {0, 32000000},
> +};
> +
> +static const int pac1944_adc_vsense_range_tbl[][2] = {
> +	[PAC1944_ADC_FULL_RANGE_BIPOLAR] = {-100000, 100000},
> +	[PAC1944_ADC_HALF_RANGE_BIPOLAR] = {-50000, 50000},
> +	[PAC1944_ADC_FULL_RANGE_UNIPOLAR] = {0, 100000},
Trivial but I'm trying to standardize some formatting beyond what kernel
wide kernel style says.
	[PAC1944_ADC_FULL_RANGE_UNIPOLAR] = { 0, 100000 },


	
> +};
> +
> +/**
> + * struct reg_data - data from the registers
> + * @vsense_mode:array of values, Full Scale Range (FSR) mode for V Sense
> + * @vbus_mode: array of values, Full Scale Range (FSR) mode for V Bus
Order doesn't match.

> + * @accumulation_mode: array of values, accumulation mode for hardware accumulator
> + * @meas_regs: snapshot of raw measurements registers
> + * @ctrl_act_reg: snapshot of the ctrl_act register
> + * @ctrl_lat_reg: snapshot of the ctrl_lat register
> + * @acc_count: snapshot of the acc_count register
> + * @acc_val: accumulated values per second
> + * @vacc: accumulated vpower values
> + * @vpower: snapshot of vpower registers
> + * @vbus: snapshot of vbus registers
> + * @vbus_avg: averages of vbus registers
> + * @vsense: snapshot of vsense registers
> + * @vsense_avg: averages of vsense registers
> + * @jiffies_tstamp: chip's uptime
> + */
> +struct reg_data {
> +	u8	vbus_mode[PAC1944_MAX_CH];
> +	u8	vsense_mode[PAC1944_MAX_CH];
> +	u8	accumulation_mode[PAC1944_MAX_CH];
> +	u8	meas_regs[PAC1944_MEAS_REG_SNAPSHOT_LEN];
> +	u16	ctrl_act_reg;
> +	u16	ctrl_lat_reg;
> +	u32	acc_count;
> +	s64	acc_val[PAC1944_MAX_CH];
> +	s64	vacc[PAC1944_MAX_CH];
> +	s32	vpower[PAC1944_MAX_CH];
> +	s32	vbus[PAC1944_MAX_CH];
> +	s32	vbus_avg[PAC1944_MAX_CH];
> +	s32	vsense[PAC1944_MAX_CH];
> +	s32	vsense_avg[PAC1944_MAX_CH];
> +	unsigned long jiffies_tstamp;
> +};
> +
> +/**
> + * struct pac1944_chip_info - chip configuration
> + * @channels: array of values, true means that channel is active
> + * @iio_info: pointer to iio_info structure
> + * @client: a pointer to the i2c client associated with the device
> + * @lock: lock to prevent concurrent reads/writes
> + * @work_chip_rfsh: chip refresh workqueue implementation
> + * @active_channels_mask: active channels
> + * @phys_channels: number of physical channels for the device
> + * @shunts: array of values, shunt resistor values
> + * @chip_reg_data: pointer to structure, containing data from the device registers
> + * @labels: array of string, name of each channel
> + * @is_pac195x_family: true if device is part of the PAC195x family
> + * @sampling_mode: sampling mode used by the device
> + * @num_enabled_channels: count of how many chip channels are currently enabled
> + * @enable_acc: array of values, true means that accumulation channel is measured
> + */
> +struct pac1944_chip_info {
> +	const struct iio_chan_spec  *channels;
> +	struct iio_info		iio_info;
> +	struct i2c_client	*client;
> +	struct mutex		lock; /* lock to prevent concurrent reads/writes */
> +	struct delayed_work	work_chip_rfsh;
> +	unsigned long	active_channels_mask;

DECLARE_BITMAP() Is probably the right option even if it's only
ever going to be 1 unsigned long.  Makes it obvious it's a bitmap.


> +	u8		phys_channels;
> +	u32		shunts[PAC1944_MAX_CH];
> +	struct reg_data chip_reg_data;
> +	char		*labels[PAC1944_MAX_CH];
> +	bool		is_pac195x_family;
> +	u8		sampling_mode;
> +	u8		num_enabled_channels;
> +	bool		enable_acc[PAC1944_MAX_CH];
> +};

> +
> +/* Low-level I2c functions used to transfer more then 32 bytes at once */
> +static int pac1944_i2c_read(struct i2c_client *client, u8 reg_addr,
> +			    void *databuf, u8 len)
> +{
> +	struct i2c_msg msgs[2] = {
> +		{
> +		 .addr = client->addr,
Should be indented one table more than {
			.addr = client->addr,

Is this the same as i2c_smbus_read_i2c_block_data() ?

> +		 .len = 1,
> +		 .buf = (u8 *)&reg_addr,
> +		 .flags = 0
> +		},
> +		{
> +		 .addr = client->addr,
> +		 .len = len,
> +		 .buf = databuf,
> +		 .flags = I2C_M_RD
> +		}
> +	};
> +
> +	return i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
> +}

> +
> +#define PAC1944_VPOWER_CHANNEL(_index, _address) {		\
> +	.type = IIO_POWER,					\
> +	.address = (_address),					\
> +	.indexed = 1,						\
> +	.channel = (_index) + 1,				\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
> +			      BIT(IIO_CHAN_INFO_SCALE),		\
> +	.ext_info = pac1944_ext_info				\

If these are only used once, just put the value setting in line at the place
they are used.  Separate macros just make us go looking for them.

> +}
> +
> +static int pac1944_send_refresh(struct pac1944_chip_info *info, u8 refresh_addr,
> +				u32 wait_time)
> +{
> +	struct i2c_client *client = info->client;
> +	int ret;
> +
> +	/* Writing a REFRESH or a REFRESH_V command. */
> +	ret = i2c_smbus_write_byte(client, refresh_addr);
> +	if (ret) {
> +		dev_err(&client->dev, "%s - cannot send Refresh cmd (0x%02X) to PAC1944\n",
> +			__func__, refresh_addr);
> +		return ret;
> +	}
> +
> +	/* Register data retrieval timestamp. */
> +	info->chip_reg_data.jiffies_tstamp = jiffies;
> +	/* Wait till the data is available. */
> +	usleep_range(wait_time, wait_time + 100);

fsleep()

> +
> +	return 0;
> +}
> +
> +static int pac1944_reg_snapshot(struct pac1944_chip_info *info, bool do_refresh,
> +				u8 refresh_addr, u32 wait_time)
> +{
...

> +	/*
> +	 * Check if the channel is active (within the data read from the chip),
> +	 * skip all fields if disabled.
> +	 */
> +	for_each_set_bit(cnt, &info->active_channels_mask, info->phys_channels) {
> +		/* skip if the energy accumulation is disabled */
> +		if (!info->enable_acc[cnt]) {
> +			offset_reg_data_p += PAC1944_VACC_REG_LEN;
> +			continue;
> +		}
> +
> +		stored_value = info->chip_reg_data.acc_val[cnt];
> +
> +		info->chip_reg_data.vacc[cnt] = pac1944_get_unaligned_be56(offset_reg_data_p);
> +
> +		is_unipolar = true;
> +		switch (info->chip_reg_data.accumulation_mode[cnt]) {
> +		case PAC1944_ACCMODE_VPOWER:
> +			if (info->chip_reg_data.vbus_mode[cnt] != PAC1944_UNIPOLAR_FSR_CFG ||
> +			    info->chip_reg_data.vsense_mode[cnt] != PAC1944_UNIPOLAR_FSR_CFG)
> +				is_unipolar = false;
> +			break;
> +		case PAC1944_ACCMODE_VSENSE:
> +			if (info->chip_reg_data.vsense_mode[cnt] != PAC1944_UNIPOLAR_FSR_CFG)
> +				is_unipolar = false;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		if (!is_unipolar)
> +			info->chip_reg_data.vacc[cnt] =
> +				sign_extend64(info->chip_reg_data.vacc[cnt], 55);
> +
> +		/*
> +		 * Integrate the accumulated power or current over the elapsed
> +		 * interval.
> +		 */
> +		smpl_mode = FIELD_GET(PAC1944_CTRL_SAMPLE_MASK, info->chip_reg_data.ctrl_lat_reg);
> +
> +		if (smpl_mode <= PAC1944_SAMP_8SPS) {
> +			tmp_s64 = info->chip_reg_data.vacc[cnt];
> +			/*
> +			 * Find how much shift is required by the sample rate.
> +			 * The chip's sampling rate is 2^shift samples/sec.
> +			 */
> +			shift = shift_map_tbl[smpl_mode];
> +			inc = tmp_s64 >> shift;
> +		} else {
> +			dev_err(dev, "Invalid sample rate index: %d!\n", smpl_mode);
> +			return -EINVAL;

Flip condition to handle error first. Then indent reduces on the rest.

> +		}
> +
> +		if (check_add_overflow(stored_value, inc, &stored_value)) {
> +			if (stored_value < 0)
> +				info->chip_reg_data.acc_val[cnt] = S64_MIN;
> +			else
> +				info->chip_reg_data.acc_val[cnt] = S64_MAX;
> +
> +			dev_err(dev, "Overflow detected on channel [%d]!\n", cnt + 1);

Why carry on in this case?  Perhaps add a comment.

> +		} else {
> +			info->chip_reg_data.acc_val[cnt] = stored_value;
> +		}
> +
> +		offset_reg_data_p += PAC1944_VACC_REG_LEN;
> +	}

...

> +}

> +static ssize_t pac1944_in_power_acc_raw_show(struct device *dev,
> +					     struct device_attribute *attr,
> +					     char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct pac1944_chip_info *info = iio_priv(indio_dev);
> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +	s64 curr_energy, int_part;
> +	int ret;
> +	int rem;
> +
> +	ret = pac1944_retrieve_data(info, PAC1944_MIN_UPDATE_WAIT_TIME_US);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * Expresses the 64 bit energy value as a
> +	 * 64 bit integer and a 32 bit nano value
> +	 */
> +	curr_energy = info->chip_reg_data.acc_val[this_attr->address];
> +	int_part = div_s64_rem(curr_energy, 1000000000, &rem);
> +
> +	if (rem < 0)
> +		return sysfs_emit(buf, "-%lld.%09u\n", abs(int_part), -rem);
> +	else
> +		return sysfs_emit(buf, "%lld.%09u\n", int_part, abs(rem));

It's coming ultimately from a single 64 bit value?  Can we use a different
scale if it's a modified channel and hence use the IIO_VAL_INT64 and
standard read_raw stuff?

> +}
> +
> +static ssize_t pac1944_in_power_acc_scale_show(struct device *dev,
> +					       struct device_attribute *attr,
> +					       char *buf)
> +{
> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct pac1944_chip_info *info = iio_priv(indio_dev);
> +	unsigned int shunt, rem;
> +	u64 tmp, ref;
> +
> +	if (info->is_pac195x_family)
> +		ref = PAC195X_MAX_VPOWER_RSHIFTED_BY_29B;
> +	else
> +		ref = PAC194X_MAX_VPOWER_RSHIFTED_BY_29B;
> +
> +	if ((info->chip_reg_data.vbus_mode[this_attr->address] == PAC1944_UNIPOLAR_FSR_CFG &&
> +	     info->chip_reg_data.vsense_mode[this_attr->address] == PAC1944_UNIPOLAR_FSR_CFG) ||
> +	    info->chip_reg_data.vbus_mode[this_attr->address] == PAC1944_BIPOLAR_HALF_FSR_CFG ||
> +	    info->chip_reg_data.vsense_mode[this_attr->address] == PAC1944_BIPOLAR_HALF_FSR_CFG)
> +		ref = ref >> 1;
> +
> +	shunt = info->shunts[this_attr->address];
> +
> +	tmp = div_u64(ref * 1000000000LL, shunt);
> +	rem = do_div(tmp, 1000000000LL);
> +
> +	return sysfs_emit(buf, "%lld.%09u\n", tmp, rem);
> +}

> +
> +static ssize_t pac1944_in_current_acc_raw_show(struct device *dev,
> +					       struct device_attribute *attr,
> +					       char *buf)
> +{
> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct pac1944_chip_info *info = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = pac1944_retrieve_data(info, PAC1944_MIN_UPDATE_WAIT_TIME_US);
> +	if (ret < 0)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%lld\n", info->chip_reg_data.acc_val[this_attr->address]);
We do have 64 bit types for standard channels so maybe this works fine.

> +}
> +
> +static ssize_t pac1944_in_current_acc_scale_show(struct device *dev,
> +						 struct device_attribute *attr,
> +						 char *buf)
> +{
> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct pac1944_chip_info *info = iio_priv(indio_dev);
> +	u64 tmp_u64, ref;
> +	int shunt, rem;
> +
> +	/*
> +	 * Currents - scale for mA - depends on the channel's shunt value
> +	 * (100mV * 1000000) / (2^16 * shunt(uOhm))
> +	 */
> +	ref = PAC1944_MAX_VSENSE_NANO;
> +
> +	switch (info->chip_reg_data.vsense_mode[this_attr->address]) {
> +	case PAC1944_UNIPOLAR_FSR_CFG:
> +	case PAC1944_BIPOLAR_HALF_FSR_CFG:
> +		shunt = info->shunts[this_attr->address];
> +		break;
> +	case PAC1944_BIPOLAR_FSR_CFG:
> +		ref = ref << 1;
> +		shunt = info->shunts[this_attr->address];
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Increasing precision
> +	 * (100mV * 1000000 * 1000000000) / 2^16 )
> +	 */
> +	tmp_u64 = div_u64(ref, shunt);
> +	rem = do_div(tmp_u64, 1000000000LL);
> +
> +	return sysfs_emit(buf, "%lld.%09u\n", tmp_u64, rem);

How bit does tmp_u64 really get?  Can we represent it as a normal
channel attribute - IIO_VAL_INT_PLUS_NANO?

this matters for discussion below about using standard channel
info mask elements for these.

If we can't then fair enough that we have to do something like this
but an ext_info would be preferable so the naming etc is constructed.
	
> +}
> +
> +static IIO_DEVICE_ATTR(in_energy1_raw, 0444, pac1944_in_power_acc_raw_show, NULL, 0);
> +static IIO_DEVICE_ATTR(in_energy2_raw, 0444, pac1944_in_power_acc_raw_show, NULL, 1);
> +static IIO_DEVICE_ATTR(in_energy3_raw, 0444, pac1944_in_power_acc_raw_show, NULL, 2);
> +static IIO_DEVICE_ATTR(in_energy4_raw, 0444, pac1944_in_power_acc_raw_show, NULL, 3);
> +
> +static IIO_DEVICE_ATTR(in_energy1_scale, 0444, pac1944_in_power_acc_scale_show, NULL, 0);
> +static IIO_DEVICE_ATTR(in_energy2_scale, 0444, pac1944_in_power_acc_scale_show, NULL, 1);
> +static IIO_DEVICE_ATTR(in_energy3_scale, 0444, pac1944_in_power_acc_scale_show, NULL, 2);
> +static IIO_DEVICE_ATTR(in_energy4_scale, 0444, pac1944_in_power_acc_scale_show, NULL, 3);
> +
> +static IIO_DEVICE_ATTR(in_energy1_en, 0644, pac1944_in_enable_acc_show,
> +		       pac1944_in_enable_acc_store, 0);
> +static IIO_DEVICE_ATTR(in_energy2_en, 0644, pac1944_in_enable_acc_show,
> +		       pac1944_in_enable_acc_store, 1);
> +static IIO_DEVICE_ATTR(in_energy3_en, 0644, pac1944_in_enable_acc_show,
> +		       pac1944_in_enable_acc_store, 2);
> +static IIO_DEVICE_ATTR(in_energy4_en, 0644, pac1944_in_enable_acc_show,
> +		       pac1944_in_enable_acc_store, 3);
> +
> +static IIO_DEVICE_ATTR(in_current_acc1_raw, 0444, pac1944_in_current_acc_raw_show, NULL, 0);
> +static IIO_DEVICE_ATTR(in_current_acc2_raw, 0444, pac1944_in_current_acc_raw_show, NULL, 1);
> +static IIO_DEVICE_ATTR(in_current_acc3_raw, 0444, pac1944_in_current_acc_raw_show, NULL, 2);
> +static IIO_DEVICE_ATTR(in_current_acc4_raw, 0444, pac1944_in_current_acc_raw_show, NULL, 3);
> +
> +static IIO_DEVICE_ATTR(in_current_acc1_scale, 0444, pac1944_in_current_acc_scale_show, NULL, 0);
> +static IIO_DEVICE_ATTR(in_current_acc2_scale, 0444, pac1944_in_current_acc_scale_show, NULL, 1);
> +static IIO_DEVICE_ATTR(in_current_acc3_scale, 0444, pac1944_in_current_acc_scale_show, NULL, 2);
> +static IIO_DEVICE_ATTR(in_current_acc4_scale, 0444, pac1944_in_current_acc_scale_show, NULL, 3);
> +
> +static IIO_DEVICE_ATTR(in_current_acc1_en, 0644, pac1944_in_enable_acc_show,
> +		       pac1944_in_enable_acc_store, 0);
> +static IIO_DEVICE_ATTR(in_current_acc2_en, 0644, pac1944_in_enable_acc_show,
> +		       pac1944_in_enable_acc_store, 1);
> +static IIO_DEVICE_ATTR(in_current_acc3_en, 0644, pac1944_in_enable_acc_show,
> +		       pac1944_in_enable_acc_store, 2);
> +static IIO_DEVICE_ATTR(in_current_acc4_en, 0644, pac1944_in_enable_acc_show,
> +		       pac1944_in_enable_acc_store, 3);
> +
> +static struct attribute *pac1944_power_acc_attr[] = {
These are all standard ABI elements I think. I'd much
prefer if we worked out how to build the channels rather than
doing it as custom attributes like this.

The acc modifier suggestion below might help with that.

They might be beyond represenable scale though. In which case ignore
this but scatter some more comments on that about so I remember
on v5.


> +	&iio_dev_attr_in_energy1_raw.dev_attr.attr,
> +	&iio_dev_attr_in_energy2_raw.dev_attr.attr,
> +	&iio_dev_attr_in_energy3_raw.dev_attr.attr,
> +	&iio_dev_attr_in_energy4_raw.dev_attr.attr,
> +	&iio_dev_attr_in_energy1_scale.dev_attr.attr,
> +	&iio_dev_attr_in_energy2_scale.dev_attr.attr,
> +	&iio_dev_attr_in_energy3_scale.dev_attr.attr,
> +	&iio_dev_attr_in_energy4_scale.dev_attr.attr,
> +	&iio_dev_attr_in_energy1_en.dev_attr.attr,
> +	&iio_dev_attr_in_energy2_en.dev_attr.attr,
> +	&iio_dev_attr_in_energy3_en.dev_attr.attr,
> +	&iio_dev_attr_in_energy4_en.dev_attr.attr,
> +	NULL
> +};
> +
> +static struct attribute *pac1944_current_acc_attr[] = {
> +	&iio_dev_attr_in_current_acc1_raw.dev_attr.attr,
> +	&iio_dev_attr_in_current_acc2_raw.dev_attr.attr,
> +	&iio_dev_attr_in_current_acc3_raw.dev_attr.attr,
> +	&iio_dev_attr_in_current_acc4_raw.dev_attr.attr,
> +	&iio_dev_attr_in_current_acc1_scale.dev_attr.attr,
> +	&iio_dev_attr_in_current_acc2_scale.dev_attr.attr,
> +	&iio_dev_attr_in_current_acc3_scale.dev_attr.attr,
> +	&iio_dev_attr_in_current_acc4_scale.dev_attr.attr,
> +	&iio_dev_attr_in_current_acc1_en.dev_attr.attr,
> +	&iio_dev_attr_in_current_acc2_en.dev_attr.attr,
> +	&iio_dev_attr_in_current_acc3_en.dev_attr.attr,
> +	&iio_dev_attr_in_current_acc4_en.dev_attr.attr,
> +	NULL
> +};
> +
> +static int pac1944_prep_custom_attributes(struct pac1944_chip_info *info,
> +					  struct iio_dev *indio_dev)
> +{
> +	struct attribute **pac1944_custom_attrs, **tmp_attr;
> +	struct i2c_client *client = info->client;
> +	struct attribute_group *pac1944_group;
> +	int active_channels_count = 0;
> +	int custom_attr_cnt;
> +	int ch, i, j;
> +
> +	active_channels_count = info->num_enabled_channels;
> +
> +	pac1944_group = devm_kzalloc(&client->dev, sizeof(*pac1944_group), GFP_KERNEL);
> +	if (!pac1944_group)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Attributes for channel X:
> +	 *	- in_shunt_value_X
> +	 *	- one of attributes:
> +	 *		- in_power_accX_raw,in_power_accX_scale and in_power_accX_en
space after ,

Hmm. this does make me wonder, should we just have a modifier for acc?
That would make these separate channels but that should work out ok.

acc is a maths modifier like SUM_SQUARED_* ones.  Might make this simpler
even though it is a little bit of an obscure way to use modifiers.
 

> +	 *		- in_current_accX_raw, in_current_accX_scale and in_current_accX_en
> +	 */
> +	custom_attr_cnt = PAC1944_COMMON_DEVATTR * active_channels_count;
> +	custom_attr_cnt += PAC1944_ACC_DEVATTR * active_channels_count;
> +
> +	pac1944_custom_attrs = devm_kcalloc(&client->dev, custom_attr_cnt + 1,
> +					    sizeof(*pac1944_custom_attrs), GFP_KERNEL);
> +	if (!pac1944_custom_attrs)
> +		return -ENOMEM;
> +
> +	j = 0;
> +
> +	for_each_set_bit(ch, &info->active_channels_mask, info->phys_channels) {
> +		for (i = 0; i < PAC1944_COMMON_DEVATTR; i++)
> +			pac1944_custom_attrs[j++] =
> +				pac1944_all_attrs[PAC1944_COMMON_DEVATTR * ch + i];
> +
> +		switch (info->chip_reg_data.accumulation_mode[ch]) {
> +		case PAC1944_ACCMODE_VPOWER:
> +			tmp_attr = pac1944_power_acc_attr;
> +			break;
> +		case PAC1944_ACCMODE_VSENSE:
> +			tmp_attr = pac1944_current_acc_attr;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		pac1944_custom_attrs[j++] = tmp_attr[ch];
> +		pac1944_custom_attrs[j++] = tmp_attr[PAC1944_MAX_CH + ch];
> +		pac1944_custom_attrs[j++] = tmp_attr[2 * PAC1944_MAX_CH + ch];
> +	}
> +
> +	pac1944_group->attrs = pac1944_custom_attrs;
> +	info->iio_info.attrs = pac1944_group;
> +
> +	return 0;
> +}
> +
> +static int pac1944_frequency_set(struct iio_dev *indio_dev,
> +				 const struct iio_chan_spec *chan,
> +				 unsigned int mode)
> +{
> +	struct pac1944_chip_info *info = iio_priv(indio_dev);
> +	struct i2c_client *client = info->client;
> +	u16 tmp_u16;
> +	int ret;
> +
> +	ret = i2c_smbus_read_word_swapped(client, PAC1944_CTRL_ACT_REG_ADDR);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "cannot read PAC1944 regs from 0x%02X\n",
> +			PAC1944_CTRL_ACT_REG_ADDR);
> +		return ret;
> +	}
> +
> +	tmp_u16 = ret;
> +	tmp_u16 &= ~PAC1944_CTRL_SAMPLE_MASK;
> +	tmp_u16 |= FIELD_PREP(PAC1944_CTRL_SAMPLE_MASK, mode);
> +
> +	scoped_guard(mutex, &info->lock) {
> +		ret = i2c_smbus_write_word_swapped(client, PAC1944_CTRL_REG_ADDR, tmp_u16);
> +		if (ret < 0) {
> +			dev_err(&client->dev, "Failed to configure sampling mode\n");
> +			return ret;
> +		}
> +
> +		info->sampling_mode = mode;
> +		info->chip_reg_data.ctrl_act_reg = tmp_u16;
> +	}
> +
> +	return pac1944_retrieve_data(info, PAC1944_MIN_UPDATE_WAIT_TIME_US);
> +}
> +
> +static int pac1944_frequency_get(struct iio_dev *indio_dev,
> +				 const struct iio_chan_spec *chan)
> +{
> +	struct pac1944_chip_info *info = iio_priv(indio_dev);
> +
> +	return info->sampling_mode;
> +}
> +
> +static const struct iio_enum sampling_mode_enum = {

Add a comment somewhere here on why we need these rather than using standard
handling via info_mask and read raw.


> +	.items = pac1944_frequency_avail,
> +	.num_items = ARRAY_SIZE(pac1944_frequency_avail),
> +	.set = pac1944_frequency_set,
> +	.get = pac1944_frequency_get,
> +};
> +
> +static const struct iio_chan_spec_ext_info pac1944_ext_info[] = {
> +	IIO_ENUM("sampling_frequency", IIO_SHARED_BY_ALL, &sampling_mode_enum),
> +	{
> +		.name = "sampling_frequency_available",
> +		.shared = IIO_SHARED_BY_ALL,
> +		.read = iio_enum_available_read,
> +		.private = (uintptr_t)&sampling_mode_enum,
> +	},
> +	{ }
> +};

> +static int pac1944_read_label(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan, char *label)
> +{
> +	struct pac1944_chip_info *info = iio_priv(indio_dev);
> +	int idx;
> +
> +	/*
> +	 * In the datasheet channels are referred to as 1 to 4. For AVG the index
> +	 * should be between 5 to 8. To calculate PAC1944_CH_VOLTAGE_AVERAGE and
> +	 * PAC1944_CH_CURRENT_AVERAGE real index, we need to remove the added
> +	 * offset (PAC1944_MAX_CH).
> +	 */
> +	idx = (chan->channel - 1) % PAC1944_MAX_CH;
> +
> +	switch (chan->address) {
> +	case PAC1944_VBUS_1_ADDR:
> +	case PAC1944_VBUS_2_ADDR:
> +	case PAC1944_VBUS_3_ADDR:
> +	case PAC1944_VBUS_4_ADDR:
> +		if (info->labels[idx])
> +			return sysfs_emit(label, "%s_VBUS_%d\n", info->labels[idx], idx + 1);
> +
> +		return sysfs_emit(label, "VBUS_%d\n", idx + 1);
> +	case PAC1944_VBUS_AVG_1_ADDR:
> +	case PAC1944_VBUS_AVG_2_ADDR:
> +	case PAC1944_VBUS_AVG_3_ADDR:
> +	case PAC1944_VBUS_AVG_4_ADDR:
> +		if (info->labels[idx])
> +			return sysfs_emit(label, "%s_VBUS_AVG_%d\n", info->labels[idx], idx + 1);
> +
> +		return sysfs_emit(label, "VBUS_AVG_%d\n", idx + 1);
> +	case PAC1944_VSENSE_1_ADDR:
> +	case PAC1944_VSENSE_2_ADDR:
> +	case PAC1944_VSENSE_3_ADDR:
> +	case PAC1944_VSENSE_4_ADDR:
> +		if (info->labels[idx])
> +			return sysfs_emit(label, "%s_IBUS_%d\n", info->labels[idx], idx + 1);
> +
> +		return sysfs_emit(label, "IBUS_%d\n", idx + 1);
> +	case PAC1944_VSENSE_AVG_1_ADDR:
> +	case PAC1944_VSENSE_AVG_2_ADDR:
> +	case PAC1944_VSENSE_AVG_3_ADDR:
> +	case PAC1944_VSENSE_AVG_4_ADDR:
> +		if (info->labels[idx])
> +			return sysfs_emit(label, "%s_IBUS_AVG_%d\n", info->labels[idx], idx + 1);
> +
> +		return sysfs_emit(label, "IBUS_AVG_%d\n", idx + 1);
> +	case PAC1944_VPOWER_1_ADDR:
> +	case PAC1944_VPOWER_2_ADDR:
> +	case PAC1944_VPOWER_3_ADDR:
> +	case PAC1944_VPOWER_4_ADDR:
> +		if (info->labels[idx])
> +			return sysfs_emit(label, "%s_POWER_%d\n", info->labels[idx], idx + 1);
> +
> +		return sysfs_emit(label, "POWER_%d\n", idx + 1);
> +	}
> +
> +	return 0;
Add a comment on when we get here. If it's only on error return an error code.
End of day so I'm not checking ;)
> +}

> +
> +/*
> + * Universal Unique Identifier (UUID),
> + * 721F1534-5D27-4B60-9DF4-41A3C4B7DA3A,
> + * is reserved to Microchip for the PAC194x and PAC195x.
> + */
> +#define PAC1944_DSM_UUID       "721F1534-5D27-4B60-9DF4-41A3C4B7DA3A"
> +
> +/*
> + * documentation related to the ACPI device definition
> + * https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/UserGuides/PAC194X_5X-UEFI-BIOS-Integration-and-Microsoft-Windows-10-and-Windows-11-Energy-Meter-Interface-Device-Driver-Users-Guide-DS50003155.pdf
> + */
> +static int pac1944_acpi_parse_channel_config(struct i2c_client *client,
> +					     struct pac1944_chip_info *info)
> +{
> +	struct device *dev = &client->dev;
> +	const struct acpi_device_id *id;
> +	unsigned short bi_dir_mask;
> +	union acpi_object *rez;
> +	acpi_handle handle;
> +	guid_t guid;
> +	int i;
> +
> +	handle = ACPI_HANDLE(dev);
> +
> +	id = acpi_match_device(dev->driver->acpi_match_table, dev);
> +	if (!id)
> +		return -ENODEV;
> +
> +	guid_parse(PAC1944_DSM_UUID, &guid);
> +
> +	rez = acpi_evaluate_dsm(handle, &guid, 0, PAC1944_ACPI_GET_NAMES, NULL);
> +	if (!rez)
> +		return -EINVAL;
> +
> +	if (rez->package.count > PAC1944_MAX_CH) {
> +		ACPI_FREE(rez);
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < rez->package.count; i++) {
> +		if (rez->package.elements[i].type != ACPI_TYPE_STRING) {
> +			ACPI_FREE(rez);
> +			return -EINVAL;
> +		}
> +
> +		info->labels[i] = devm_kmemdup(dev, rez->package.elements[i].string.pointer,
> +					       (size_t)rez->package.elements[i].string.length + 1,
> +					       GFP_KERNEL);
> +		if (!info->labels[i]) {
> +			ACPI_FREE(rez);
> +			return -ENOMEM;
> +		}
> +
> +		info->labels[i][rez->package.elements[i].string.length] = '\0';
> +	}
> +
> +	ACPI_FREE(rez);
> +
> +	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1944_ACPI_GET_UOHMS_VALS, NULL);
> +	if (!rez)
> +		return -EINVAL;
> +
> +	if (rez->package.count > PAC1944_MAX_CH) {
> +		ACPI_FREE(rez);
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < rez->package.count; i++) {
> +		if (rez->package.elements[i].type != ACPI_TYPE_INTEGER) {
> +			ACPI_FREE(rez);
> +			return -EINVAL;
> +		}
> +
> +		info->shunts[i] = rez->package.elements[i].integer.value;
> +		if (info->shunts[i])
> +			set_bit(i, &info->active_channels_mask);
> +	}
> +
> +	ACPI_FREE(rez);
> +
> +	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1944_ACPI_GET_BIPOLAR_SETTINGS, NULL);
> +	if (!rez)
> +		return -EINVAL;
> +
> +	if (rez->package.count != 2 * PAC1944_MAX_CH) {
> +		ACPI_FREE(rez);
> +		return -EINVAL;
> +	}
> +
> +	for_each_set_bit(i, &info->active_channels_mask, info->phys_channels) {
> +		if (rez->package.elements[i].type != ACPI_TYPE_INTEGER) {
> +			ACPI_FREE(rez);
> +			return -EINVAL;
> +		}
> +
> +		bi_dir_mask = rez->package.elements[i].integer.value;
> +
> +		if (bi_dir_mask == PAC1944_UNIPOLAR_FSR_CFG ||
> +		    bi_dir_mask == PAC1944_BIPOLAR_FSR_CFG  ||
> +		    bi_dir_mask == PAC1944_BIPOLAR_HALF_FSR_CFG) {
> +			dev_dbg(dev, "VBUS{%d} mode set to: %d\n", i, bi_dir_mask);
> +			info->chip_reg_data.vbus_mode[i] = bi_dir_mask;
> +		} else {
> +			return dev_err_probe(dev, -EINVAL, "invalid vbus-mode value on %i\n", i);
> +		}
> +
> +		if (rez->package.elements[i + PAC1944_MAX_CH].type != ACPI_TYPE_INTEGER) {
> +			ACPI_FREE(rez);
> +			return -EINVAL;
> +		}
> +
> +		bi_dir_mask = rez->package.elements[i + PAC1944_MAX_CH].integer.value;
> +
> +		if (bi_dir_mask == PAC1944_UNIPOLAR_FSR_CFG ||
> +		    bi_dir_mask == PAC1944_BIPOLAR_FSR_CFG  ||
> +		    bi_dir_mask == PAC1944_BIPOLAR_HALF_FSR_CFG) {
> +			dev_dbg(dev, "VSENSE{%d} mode set to: %d\n", i, bi_dir_mask);
> +			info->chip_reg_data.vsense_mode[i] = bi_dir_mask;
> +		} else {
> +			return dev_err_probe(dev, -EINVAL, "invalid vsense-mode value on %i\n", i);

Probably flip condition to error out first and reduce indent on the others.
Same applies in other cases above.  Or use a switch so the error is in the default.


> +		}
> +	}
> +
> +	ACPI_FREE(rez);
> +
> +	return 0;
> +}
> +
> +static int pac1944_check_range(s32 *vals, const int ranges[][2], int num_ranges)
> +{
> +	int i;
> +
> +	for (i = 0; i < num_ranges; i++) {

for (unsigned int i = 0; ...


> +		if (vals[0] == ranges[i][0] && vals[1] == ranges[i][1])
> +			return i;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int pac1944_setup_adc_vbus_range(const struct fwnode_handle *child,
> +					struct pac1944_chip_info *info, int idx)
> +{
> +	const char *prop_name = "microchip,vbus-input-range-microvolt";
> +	struct i2c_client *client = info->client;
> +	struct device *dev = &client->dev;
> +	bool is_bipolar, is_half_fsr;
> +	unsigned int tbl_len;
> +	s32 vals[2];
> +	int ret;
> +
> +	/* default value is unipolar and Full Scale Range */
> +	is_bipolar = false;
> +	is_half_fsr = false;
> +
> +	ret = fwnode_property_read_u32_array(child, prop_name, vals, 2);
> +	if (!ret) {
> +		if (info->is_pac195x_family) {
> +			tbl_len = ARRAY_SIZE(pac1954_adc_range_tbl);
> +			ret = pac1944_check_range(vals, pac1954_adc_range_tbl, tbl_len);
> +		} else {
> +			tbl_len = ARRAY_SIZE(pac1944_adc_range_tbl);
> +			ret = pac1944_check_range(vals, pac1944_adc_range_tbl, tbl_len);
> +		}
> +		if (ret < 0) {
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Invalid value %d, %d for prop %s\n",
> +					     vals[0], vals[1], prop_name);
> +		}
> +
> +		if (ret != PAC1944_ADC_FULL_RANGE_UNIPOLAR)
> +			is_bipolar = true;
> +		if (ret == PAC1944_ADC_HALF_RANGE_BIPOLAR)
> +			is_half_fsr = true;
> +	}
> +
> +	info->chip_reg_data.vbus_mode[idx] = PAC1944_UNIPOLAR_FSR_CFG;
> +	if (is_half_fsr)
> +		info->chip_reg_data.vbus_mode[idx] = PAC1944_BIPOLAR_HALF_FSR_CFG;
> +	else if (is_bipolar)
> +		info->chip_reg_data.vbus_mode[idx] = PAC1944_BIPOLAR_FSR_CFG;
Similar to below for this function most if not all comments apply
(note I review upwards)

> +
> +	return 0;
> +}
> +
> +static int pac1944_setup_adc_vsense_range(const struct fwnode_handle *child,
> +					  struct pac1944_chip_info *info, int idx)
> +{
> +	const char *prop_name = "microchip,vsense-input-range-microvolt";
> +	struct i2c_client *client = info->client;
> +	struct device *dev = &client->dev;
> +	bool is_bipolar, is_half_fsr;
> +	unsigned int tbl_len;
> +	s32 vals[2];
> +	int ret;
> +
> +	/* default value is unipolar and Full Scale Range */
> +	is_bipolar = false;
> +	is_half_fsr = false;
> +
> +	ret = fwnode_property_read_u32_array(child, prop_name, vals, 2);
ARRAY_SIZE(vals)

> +	if (!ret) {
> +		tbl_len = ARRAY_SIZE(pac1944_adc_vsense_range_tbl);
> +		ret = pac1944_check_range(vals, pac1944_adc_vsense_range_tbl, tbl_len);
Seems fine as:
		ret = pac1944_check_range(vals, pac1944_adc_vsense_range_tbl,
					  ARRAY_SIZE(pac1944_adc_vsense_range_tbl));
and if anything slightly more readable without the local variable.


> +		if (ret < 0) {
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Invalid value %d, %d for prop %s\n",
> +					     vals[0], vals[1], prop_name);
> +		}

No brackets as single statement.  The coding style is a little unclear on these
but we tend to use that convention in IIO even if several lines due to breaks
for long lines.

> +
> +		if (ret != PAC1944_ADC_FULL_RANGE_UNIPOLAR)
> +			is_bipolar = true;
> +		if (ret == PAC1944_ADC_HALF_RANGE_BIPOLAR)
> +			is_half_fsr = true;
> +	}
> +
> +	info->chip_reg_data.vsense_mode[idx] = PAC1944_UNIPOLAR_FSR_CFG;
> +	if (is_half_fsr)
> +		info->chip_reg_data.vsense_mode[idx] = PAC1944_BIPOLAR_HALF_FSR_CFG;
> +	else if (is_bipolar)
> +		info->chip_reg_data.vsense_mode[idx] = PAC1944_BIPOLAR_FSR_CFG;

I'd put the default in an else - Makes it easier to spot that this is a choice
between modes.

> +
> +	return 0;
> +}
> +
> +static int pac1944_of_parse_channel_config(struct i2c_client *client,
> +					   struct pac1944_chip_info *info)
> +{
> +	struct device *dev = &client->dev;
> +	unsigned int current_channel;
> +	int ret, acc_mode;
> +	u32 idx;
> +
> +	current_channel = 1;
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		ret = fwnode_property_read_u32(child, "reg", &idx);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "reading invalid channel index\n");
> +
> +		if (current_channel > info->phys_channels || idx > info->phys_channels || idx == 0)
> +			return dev_err_probe(dev, -EINVAL, "invalid channel index %d value\n", idx);

Perhaps split this and check current_channel on entering the loop - before reading
the reg property.

Also I'd break the longest lines in here as they are getting rather unreadable.


> +
> +		/* adjust idx to match channel index (1 to 4) from the datasheet */
This comment seems odd given you are adjusting it down - > I'd assume to 0..3

> +		idx--;
> +
> +		if (test_and_set_bit(idx, &info->active_channels_mask))
> +			return dev_err_probe(dev, -EINVAL, "duplicate reg value %u\n", idx + 1);
> +
> +		ret = fwnode_property_read_u32(child, "shunt-resistor-micro-ohms",
> +					       &info->shunts[idx]);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "%s: invalid shunt-resistor value\n",
> +					     fwnode_get_name(child));
> +
> +		fwnode_property_read_string(child, "label", (const char **)&info->labels[idx]);
> +
> +		ret = pac1944_setup_adc_vbus_range(child, info, idx);
> +		if (ret)
> +			return ret;
> +
> +		ret = pac1944_setup_adc_vsense_range(child, info, idx);
> +		if (ret)
> +			return ret;
> +
> +		ret = fwnode_property_read_u32(child, "microchip,accumulation-mode", &acc_mode);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "invalid accumulation-mode value on %s\n",
> +					     fwnode_get_name(child));
> +		if (acc_mode == PAC1944_ACCMODE_VPOWER ||
> +		    acc_mode == PAC1944_ACCMODE_VSENSE) {
> +			dev_dbg(dev, "Accumulation{%d} mode set to: %d\n", idx, acc_mode);

This feels noisy - can we not see that from channels registered?

> +			info->chip_reg_data.accumulation_mode[idx] = acc_mode;
> +		} else {
> +			return dev_err_probe(dev, -EINVAL,
> +					     "invalid mode for accumulator value on %s\n",
> +					     fwnode_get_name(child));
If possible to do easily flip logic so only the bad path is out of line.
		if (acc_mode != PAC... && acc_mode != ...
			return dev_err.
		dev_dbg...

Keeping to that form where possible makes the code slightly easier to review.

> +		}
> +		current_channel++;
> +	}
> +
> +	return 0;
> +}

> +
> +static int pac1944_chip_identify(struct iio_dev *indio_dev, struct pac1944_chip_info *info)
> +{
> +	struct i2c_client *client = info->client;
> +	u8 chip_rev[3];
> +	int ret;
> +
> +	ret = i2c_smbus_read_i2c_block_data(client, PAC1944_PID_REG_ADDR,
> +					    sizeof(chip_rev),
> +					    chip_rev);
> +	if (ret < 0)
> +		return dev_err_probe(&client->dev, ret, "cannot read revision\n");
> +
> +	dev_info(&client->dev, "Chip revision: 0x%02X\n", chip_rev[2]);
> +
> +	if (chip_rev[0] >= PAC_PRODUCT_ID_1941 && chip_rev[0] <= PAC_PRODUCT_ID_1942_2) {
> +		info->is_pac195x_family = false;
> +	} else if (chip_rev[0] >= PAC_PRODUCT_ID_1951 && chip_rev[0] <= PAC_PRODUCT_ID_1952_2) {
> +		info->is_pac195x_family = true;
> +	} else {
> +		dev_err(&client->dev,
> +			"product ID (0x%02X, 0x%02X, 0x%02X) for this part doesn't match\n",
> +			chip_rev[0], chip_rev[1], chip_rev[2]);

Given you fallback to matching via fallbacks compat, this probably wants to not be a dev_err()
dev_info() or dev_dbg().  Will look very ugly otherwise if we are using that path.

> +		return -EINVAL;
> +	}
> +
> +	switch (chip_rev[0]) {
...

> +	case PAC_PRODUCT_ID_1952_2:
> +		info->phys_channels = pac1952_2_chip_config.phys_channels;
> +		indio_dev->name = pac1952_2_chip_config.name;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
I'd return rather than break above.  Means we know we are done in each leg.

> +}
> +
> +static int pac1944_chip_configure(struct pac1944_chip_info *info)
> +{
> +	struct i2c_client *client = info->client;
> +	u32 wait_time;
> +	u16 cfg = 0;
> +	u8 acc_cfg;
> +	int ret, i;
> +
> +	/*
> +	 * Count how many channels are enabled and store this information within
> +	 * the driver data.
> +	 */
> +	info->num_enabled_channels = hweight_long(info->active_channels_mask);
> +
> +	/* get sampling rate from PAC */
> +	ret = i2c_smbus_read_word_swapped(client, PAC1944_CTRL_REG_ADDR);
> +	if (ret < 0)
> +		return dev_err_probe(&client->dev, ret, "cannot read CTRL reg\n");
> +
> +	info->sampling_mode = FIELD_GET(PAC1944_CTRL_SAMPLE_MASK, ret);
> +
> +	if (info->sampling_mode > PAC1944_SAMP_8SPS)
> +		return dev_err_probe(&client->dev, -EINVAL, "Unsupported sample mode\n");
> +
> +	/*
> +	 * The current/voltage can be measured unidirectional, bidirectional or half FSR
> +	 * no SLOW triggered REFRESH, clear POR
> +	 */
> +	for_each_set_bit(i, &info->active_channels_mask, PAC1944_MAX_CH)
> +		cfg |= (info->chip_reg_data.vbus_mode[i] << (6 - 2 * i)) |
> +			info->chip_reg_data.vsense_mode[i] << (14 - 2 * i);
> +
> +	ret = i2c_smbus_write_word_swapped(client, PAC1944_NEG_PWR_FSR_REG_ADDR, cfg);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret, "cannot write NEG_PWR_FSR reg\n");
> +
> +	ret = i2c_smbus_write_word_data(client, PAC1944_SLOW_REG_ADDR, 0);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret, "cannot write SLOW reg\n");
> +
> +	/* Write the CHANNEL_N_OFF from CTRL REGISTER */
> +	cfg = FIELD_PREP(PAC1944_CTRL_SAMPLE_MASK, info->sampling_mode) |
> +		FIELD_PREP(PAC1944_CTRL_GPIO_ALERT2_MASK, 0) |
> +		FIELD_PREP(PAC1944_CTRL_SLOW_ALERT1_MASK, 0) |
> +		FIELD_PREP(PAC1944_CTRL_CH_1_OFF_MASK, !test_bit(0, &info->active_channels_mask)) |
> +		FIELD_PREP(PAC1944_CTRL_CH_2_OFF_MASK, !test_bit(1, &info->active_channels_mask)) |
> +		FIELD_PREP(PAC1944_CTRL_CH_3_OFF_MASK, !test_bit(2, &info->active_channels_mask)) |
> +		FIELD_PREP(PAC1944_CTRL_CH_4_OFF_MASK, !test_bit(3, &info->active_channels_mask));
> +
> +	ret = i2c_smbus_write_word_swapped(client, PAC1944_CTRL_REG_ADDR, cfg);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret, "cannot write CTRL reg\n");
> +
> +	acc_cfg = ACCUM_REG(info->chip_reg_data.accumulation_mode[0],
> +			    info->chip_reg_data.accumulation_mode[1],
> +			    info->chip_reg_data.accumulation_mode[2],
> +			    info->chip_reg_data.accumulation_mode[3]);
> +
> +	ret = i2c_smbus_write_byte_data(client, PAC1944_ACCUM_CFG_REG_ADDR, acc_cfg);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret, "cannot write ACCUM_CFG reg\n");
> +
> +	/*
> +	 * Sending a REFRESH to the chip, so the new settings take place
> +	 * as well as resetting the accumulators
> +	 */
> +	ret = i2c_smbus_write_byte(client, PAC1944_REFRESH_REG_ADDR);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret, "cannot write REFRESH reg\n");
> +
> +	/*
> +	 * Get the current (in the chip) sampling speed and compute the
> +	 * required timeout based on its value the timeout is 1/sampling_speed
> +	 * wait the maximum amount of time to be on the safe side - the
> +	 * maximum wait time is for 8sps
> +	 */
> +	wait_time = (1024 / pac1944_samp_rate_map_tbl[info->sampling_mode]) * 1000;
> +	usleep_range(wait_time, wait_time + 100);

fsleep() for this sort of fuzzy sleep at least this many usecs.

> +
> +	INIT_DELAYED_WORK(&info->work_chip_rfsh, pac1944_work_periodic_rfsh);
> +	/* Setup the latest moment for reading the regs before saturation */
> +	mod_delayed_work(system_percpu_wq, &info->work_chip_rfsh,
> +			 msecs_to_jiffies(PAC1944_MAX_RFSH_LIMIT_MS));
> +
> +	return devm_add_action_or_reset(&client->dev, pac1944_cancel_delayed_work,
> +					&info->work_chip_rfsh);
> +}

> +static int pac1944_prep_iio_channels(struct pac1944_chip_info *info,
> +				     struct iio_dev *indio_dev)
> +{
> +	struct device *dev = &info->client->dev;
> +	int channel_size, attribute_count, cnt;
> +	struct iio_chan_spec *ch_sp;
> +
> +	/* Finding out dynamically how many IIO channels we need */
> +	attribute_count = 0;
> +	channel_size = 0;
> +
> +	for_each_set_bit(cnt, &info->active_channels_mask, info->phys_channels) {
> +		/* add the size of the properties of one chip physical channel */
> +		channel_size += sizeof(pac1944_single_channel);
> +		/* count how many enabled channels we have */
> +		attribute_count += ARRAY_SIZE(pac1944_single_channel);
> +		dev_dbg(dev, ":%s: Channel %d active\n", __func__, cnt + 1);
> +	}
> +
> +	ch_sp = devm_kzalloc(dev, channel_size, GFP_KERNEL);
> +	if (!ch_sp)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Send the updated dynamic channel structure information towards IIO
> +	 * prepare the required field for IIO class registration
> +	 */
> +	indio_dev->num_channels = attribute_count;
> +	indio_dev->channels = ch_sp;
> +
> +	/* Populate the dynamic channels and make all the adjustments */
> +	for_each_set_bit(cnt, &info->active_channels_mask, info->phys_channels) {
> +		memcpy(ch_sp, pac1944_single_channel, sizeof(pac1944_single_channel));
> +		/*
> +		 * In the datasheet channels are referred to as 1 to 4, so we will
> +		 * adjust the channel to match channel index (1 to 4) from the
> +		 * datasheet.

Hmm. Ok I guess. We don't normally apply such an offset, relying datasheet_name
+ labels to indicate such a relationship. However it doesn't hurt in this case
so I guess why not.

> +		 */
> +		ch_sp[PAC1944_CH_POWER].channel = cnt + 1;
> +		ch_sp[PAC1944_CH_POWER].address = cnt + PAC1944_VPOWER_1_ADDR;
> +		ch_sp[PAC1944_CH_VOLTAGE].channel = cnt + 1;
> +		ch_sp[PAC1944_CH_VOLTAGE].address = cnt + PAC1944_VBUS_1_ADDR;
> +		ch_sp[PAC1944_CH_CURRENT].channel = cnt + 1;
> +		ch_sp[PAC1944_CH_CURRENT].address = cnt + PAC1944_VSENSE_1_ADDR;
> +		/*
> +		 * In order to be able to use labels for PAC1944_CH_VOLTAGE and
> +		 * PAC1944_CH_VOLTAGE_AVERAGE, respectively PAC1944_CH_CURRENT
> +		 * and PAC1944_CH_CURRENT_AVERAGE we need to use different channel numbers.
> +		 * We will add  +5 (+1 to maximum PAC channels).
> +		 */
> +		ch_sp[PAC1944_CH_VOLTAGE_AVERAGE].channel = cnt + PAC1944_MAX_CH + 1;
> +		ch_sp[PAC1944_CH_VOLTAGE_AVERAGE].address = cnt + PAC1944_VBUS_AVG_1_ADDR;
> +		ch_sp[PAC1944_CH_CURRENT_AVERAGE].channel = cnt + PAC1944_MAX_CH + 1;
> +		ch_sp[PAC1944_CH_CURRENT_AVERAGE].address = cnt + PAC1944_VSENSE_AVG_1_ADDR;
> +
> +		/* advance the pointer */
> +		ch_sp += ARRAY_SIZE(pac1944_single_channel);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct iio_info pac1944_info = {
> +	.read_raw = pac1944_read_raw,
> +	.read_label = pac1944_read_label,
> +};
> +
> +static int pac1944_probe(struct i2c_client *client)
> +{
> +	const struct pac1944_features *chip;
> +	struct device *dev = &client->dev;
> +	struct pac1944_chip_info *info;
> +	struct iio_dev *indio_dev;
> +	int cnt, ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*info));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	info = iio_priv(indio_dev);
> +	info->client = client;
> +
> +	ret = pac1944_chip_identify(indio_dev, info);
> +	if (ret < 0) {
> +		dev_dbg(dev, "Failed to identify the device based on HW ID\n");
> +		/*
> +		 * If failed to identify the hardware based on internal registers,
> +		 * try using fallback compatible in device tree to deal with
> +		 * some newer part number.
> +		 */
> +		chip = i2c_get_match_data(client);
> +		if (!chip)
> +			return -EINVAL;
> +
> +		info->phys_channels = chip->phys_channels;
> +		indio_dev->name = chip->name;
> +
> +		switch (chip->prod_id) {
> +		case PAC_PRODUCT_ID_1941:
> +		case PAC_PRODUCT_ID_1942:
> +		case PAC_PRODUCT_ID_1943:
> +		case PAC_PRODUCT_ID_1944:
> +		case PAC_PRODUCT_ID_1941_2:
> +		case PAC_PRODUCT_ID_1942_2:
> +			info->is_pac195x_family = false;
> +			break;
> +		case PAC_PRODUCT_ID_1951:
> +		case PAC_PRODUCT_ID_1952:
> +		case PAC_PRODUCT_ID_1953:
> +		case PAC_PRODUCT_ID_1954:
> +		case PAC_PRODUCT_ID_1951_2:
> +		case PAC_PRODUCT_ID_1952_2:
> +			info->is_pac195x_family = true;
> +			break;
> +		default:
> +			dev_err(&client->dev,
> +				"Unknown product ID (0x%02X)\n", chip->prod_id);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	for (cnt = 0; cnt < info->phys_channels; cnt++) {

For modern kernel style we can do
	for (unsigned int cnt = 0; cnt < info->phys_channels; cnt++)
and keep cnt's scope tightly defined.

> +		/* always start with accumulation channels enabled */
> +		info->enable_acc[cnt] = true;
> +	}
> +
> +	if (ACPI_HANDLE(dev))
> +		ret = pac1944_acpi_parse_channel_config(client, info);
> +	else
> +		ret = pac1944_of_parse_channel_config(client, info);
> +

Trivial: No blank line here to keep it tightly coupled with the stuff
it's checking.

> +	if (ret)
> +		return dev_err_probe(dev, ret, "parameter parsing returned an error\n");
> +
> +	ret = devm_mutex_init(dev, &info->lock);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = pac1944_chip_configure(info);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = pac1944_prep_iio_channels(info, indio_dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	info->iio_info = pac1944_info;
> +	indio_dev->info = &info->iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = pac1944_prep_custom_attributes(info, indio_dev);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Can't configure custom attributes for device\n");

Probably wrap the longest of these. They are way over 80 chars and it won't
hurt readability.  I don't mind a little over 80 but this is near enough 100.

> +
> +	ret = pac1944_reg_snapshot(info, true, PAC1944_REFRESH_REG_ADDR,
> +				   PAC1944_MIN_UPDATE_WAIT_TIME_US);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Can't register IIO device\n");
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id pac1944_id[] = {
> +	{ .name = "pac1941", .driver_data = (kernel_ulong_t)&pac1941_chip_config },
> +	{ .name = "pac1941-2", .driver_data = (kernel_ulong_t)&pac1941_2_chip_config },
> +	{ .name = "pac1942", .driver_data = (kernel_ulong_t)&pac1942_chip_config },
> +	{ .name = "pac1942-2", .driver_data = (kernel_ulong_t)&pac1942_2_chip_config },
> +	{ .name = "pac1943", .driver_data = (kernel_ulong_t)&pac1943_chip_config },
> +	{ .name = "pac1944", .driver_data = (kernel_ulong_t)&pac1944_chip_config },
> +	{ .name = "pac1951", .driver_data = (kernel_ulong_t)&pac1951_chip_config },
> +	{ .name = "pac1951-2", .driver_data = (kernel_ulong_t)&pac1951_2_chip_config },
> +	{ .name = "pac1952", .driver_data = (kernel_ulong_t)&pac1952_chip_config },
> +	{ .name = "pac1952-2", .driver_data = (kernel_ulong_t)&pac1952_2_chip_config },
> +	{ .name = "pac1953", .driver_data = (kernel_ulong_t)&pac1953_chip_config },
> +	{ .name = "pac1954", .driver_data = (kernel_ulong_t)&pac1954_chip_config },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, pac1944_id);
> +
> +static const struct of_device_id pac1944_of_match[] = {
> +	{
> +		.compatible = "microchip,pac1941",
> +		.data = &pac1941_chip_config
> +	},
Small thing but it's fine for kernel style to use
	}, {
when you have lots of structures like this. Nice to reduce the scrolling a little.

Or given these aren't any longer than the i2c_device_id entrees you can just do
	{ .compatible = "microchip,pac1941", .data = &pac1941_chip_config }.
etc.

> +	{
> +		.compatible = "microchip,pac1941-2",
> +		.data = &pac1941_2_chip_config
> +	},
> +	{
> +		.compatible = "microchip,pac1942",
> +		.data = &pac1942_chip_config
> +	},
> +	{
> +		.compatible = "microchip,pac1942-2",
> +		.data = &pac1942_2_chip_config
> +	},
> +	{
> +		.compatible = "microchip,pac1943",
> +		.data = &pac1943_chip_config
> +	},
> +	{
> +		.compatible = "microchip,pac1944",
> +		.data = &pac1944_chip_config
> +	},
> +	{
> +		.compatible = "microchip,pac1951",
> +		.data = &pac1951_chip_config
> +	},
> +	{
> +		.compatible = "microchip,pac1951-2",
> +		.data = &pac1951_2_chip_config
> +	},
> +	{
> +		.compatible = "microchip,pac1952",
> +		.data = &pac1952_chip_config
> +	},
> +	{
> +		.compatible = "microchip,pac1952-2",
> +		.data = &pac1952_2_chip_config
> +	},
> +	{
> +		.compatible = "microchip,pac1953",
> +		.data = &pac1953_chip_config
> +	},
> +	{
> +		.compatible = "microchip,pac1954",
> +		.data = &pac1954_chip_config
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, pac1944_of_match);
> +
> +static const struct acpi_device_id pac1944_acpi_match[] = {
> +	{ "MCHP1940", .driver_data = (kernel_ulong_t)&pac1944_chip_config },

For consistency .id =
 

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, pac1944_acpi_match);
> +
> +static struct i2c_driver pac1944_driver = {
> +	.driver = {
> +		.name = "pac1944",
> +		.of_match_table = pac1944_of_match,
> +		.acpi_match_table = pac1944_acpi_match
> +	},
> +	.probe = pac1944_probe,
> +	.id_table = pac1944_id,
> +};
> +module_i2c_driver(pac1944_driver);
> +
> +MODULE_AUTHOR("Marius Cristea <marius.cristea@microchip.com>");
> +MODULE_DESCRIPTION("Microchip PAC194X and PAC195X Power Monitor");
> +MODULE_LICENSE("GPL");

