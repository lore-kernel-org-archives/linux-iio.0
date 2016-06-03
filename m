Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60470 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932174AbcFCKGH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jun 2016 06:06:07 -0400
Subject: Re: [PATCH 2/3] iio: adc: ina3221: Add support for IIO ADC driver for
 TI INA3221
To: Laxman Dewangan <ldewangan@nvidia.com>, robh+dt@kernel.org,
	corbet@lwn.net, lars@metafoo.de
References: <1464784454-7988-1-git-send-email-ldewangan@nvidia.com>
 <1464784454-7988-2-git-send-email-ldewangan@nvidia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org, Jean Delvare <khali@linux-fr.org>,
	Guenter Roeck <linux@roeck-us.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <44e28639-67b6-7586-5e6d-c0180ccded79@kernel.org>
Date: Fri, 3 Jun 2016 11:06:02 +0100
MIME-Version: 1.0
In-Reply-To: <1464784454-7988-2-git-send-email-ldewangan@nvidia.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/06/16 13:34, Laxman Dewangan wrote:
> The INA3221 is a three-channel, high-side current and bus voltage monitor
> with an I2C interface from Texas Instruments. The INA3221 monitors both
> shunt voltage drops and bus supply voltages in addition to having
> programmable conversion times and averaging modes for these signals.
> The INA3221 offers both critical and warning alerts to detect multiple
> programmable out-of-range conditions for each channel.
> 
> Add support for INA3221 SW driver via IIO ADC interface. The device is
> register as iio-device and provides interface for voltage/current and power
> monitor. Also provide interface for setting oneshot/continuous mode and
> critical/warning threshold for the shunt voltage drop.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Hi Laxman,

As ever with any driver lying on the border of IIO and hwmon, please include
a short justification of why you need an IIO driver and also cc the
hwmon list + maintainers. (cc'd on this reply).

I simply won't take a driver where the hwmon maintainers aren't happy.
As it stands I'm not seeing obvious reasons in the code for why this
should be an IIO device.

Funily enough I know this datasheet a little as was evaluating
it for use on some boards at the day job a week or so ago.

Various comments inline. Major points are:
* Don't use 'fake' channels to control events. If the events infrastructure
doesn't handle your events, then fix that rather than working around it.
* There is a lot of ABI in here concerned with oneshot vs continuous.
This seems to me to be more than it should be. We wouldn't expect to
see stuff changing as a result of switching between these modes other
than wrt to when the data shows up.  So I'd expect to not see this
directly exposed at all - but rather sit in oneshot unless either:
1) Buffered mode is running (not currently supported)
2) Alerts are on - which I think requires it to be in continuous mode.

Other question to my mind is whether we should be reporting vshunt or
(using device tree to pass resistance) current.

Code looks good, bu these more fundamental bits need sorting.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/Kconfig   |   12 +
>  drivers/iio/adc/Makefile  |    1 +
>  drivers/iio/adc/ina3221.c | 1175 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1188 insertions(+)
>  create mode 100644 drivers/iio/adc/ina3221.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 25378c5..65f3c27 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -223,6 +223,18 @@ config INA2XX_ADC
>  	  Say yes here to build support for TI INA2xx family of Power Monitors.
>  	  This driver is mutually exclusive with the HWMON version.
>  
> +config INA3221
> +	tristate "TI INA3221 3-Channel Shunt and Bus Voltage Monitor"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  INA3221 is Triple-Channel, High-Side Measurement, Shunt and Bus
> +	  Voltage Monitor device from TI. This driver support the reading
> +	  of all channel's voltage/current and power via IIO interface.
> +	  Say yes here to build support for TI INA3221.	To compile this
> +	  driver as a module, choose M here: the module will be called
> +	  ina3221.
> +
>  config IMX7D_ADC
>  	tristate "IMX7D ADC driver"
>  	depends on ARCH_MXC || COMPILE_TEST
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 38638d4..c24f455 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -24,6 +24,7 @@ obj-$(CONFIG_FSL_MX25_ADC) += fsl-imx25-gcq.o
>  obj-$(CONFIG_HI8435) += hi8435.o
>  obj-$(CONFIG_IMX7D_ADC) += imx7d_adc.o
>  obj-$(CONFIG_INA2XX_ADC) += ina2xx-adc.o
> +obj-$(CONFIG_INA3221) += ina3221.o
>  obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
>  obj-$(CONFIG_LPC18XX_ADC) += lpc18xx_adc.o
>  obj-$(CONFIG_MAX1027) += max1027.o
> diff --git a/drivers/iio/adc/ina3221.c b/drivers/iio/adc/ina3221.c
> new file mode 100644
> index 0000000..a17f688
> --- /dev/null
> +++ b/drivers/iio/adc/ina3221.c
> @@ -0,0 +1,1175 @@
> +/*
> + * IIO driver for INA3221
> + *
> + * Copyright (C) 2016 NVIDIA CORPORATION. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/kfifo_buf.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/util_macros.h>
> +
> +/* INA3221 registers definition */
> +#define INA3221_CONFIG				0x00
> +#define INA3221_SHUNT_VOL_CHAN1			0x01
> +#define INA3221_BUS_VOL_CHAN1			0x02
> +#define INA3221_SHUNT_VOL_CHAN2			0x03
> +#define INA3221_BUS_VOL_CHAN2			0x04
> +#define INA3221_SHUNT_VOL_CHAN3			0x05
> +#define INA3221_BUS_VOL_CHAN3			0x06
> +#define INA3221_CRIT_CHAN1			0x07
> +#define INA3221_WARN_CHAN1			0x08
> +#define INA3221_CRIT_CHAN2			0x09
> +#define INA3221_WARN_CHAN2			0x0A
> +#define INA3221_CRIT_CHAN3			0x0B
> +#define INA3221_WARN_CHAN3			0x0C
> +#define INA3221_MASK_ENABLE			0x0F
> +#define INA3221_POWER_VALID_UPPER_LIMIT		0x10
> +#define INA3221_POWER_VALID_LOWER_LIMIT		0x11
> +#define INA3221_MAN_ID				0xFE
> +#define INA3221_DEV_ID				0xFF
> +
> +#define INA3221_CONFIG_RESET_MASK		BIT(15)
> +#define INA3221_CONFIG_RESET_EN			BIT(15)
> +
> +#define INA3221_CONFIG_MODE_MASK		GENMASK(2, 0)
> +#define INA3221_CONFIG_MODE_POWER_DOWN		0
> +
> +#define INA3221_CONFIG_AVG_MASK			GENMASK(11, 9)
> +#define INA3221_CONFIG_AVG(val)			((val) << 9)
> +
> +#define INA3221_CONFIG_VBUSCT_MASK		GENMASK(8, 6)
> +#define INA3221_CONFIG_VBUSCT(val)		((val) << 6)
> +
> +#define INA3221_CONFIG_SHUNTCT_MASK		GENMASK(5, 3)
> +#define INA3221_CONFIG_SHUNTCT(val)		((val) << 3)
> +
> +#define INA3221_REG_MASK_WEN			BIT(11)
> +#define INA3221_REG_MASK_CEN			BIT(10)
> +#define INA3221_REG_MASK_CVRF			BIT(0)
> +
> +#define PACK_MODE_CHAN(mode, chan)		((mode) | ((chan) << 8))
> +#define UNPACK_MODE(address)			((address) & 0xFF)
> +#define UNPACK_CHAN(address)			(((address) >> 8) & 0xFF)
> +
> +#define INA3221_NUMBER_OF_CHANNELS		3
> +#define INA3221_MAX_CONVERSION_TRIALS		10
> +#define INA3221_CONFIG_AVG_SAMPLE_DEFAULT	4
> +#define INA3221_CONFIG_VBUS_CONV_TIME_DEFAULT	150
> +#define INA3221_CONFIG_SHUNT_CONV_TIME_DEFAULT	150
> +
> +#define INA3221_SHUNT_VOL(i)		(INA3221_SHUNT_VOL_CHAN1 + (i) * 2)
> +#define INA3221_BUS_VOL(i)		(INA3221_BUS_VOL_CHAN1 + (i) * 2)
> +#define INA3221_CRIT(i)			(INA3221_CRIT_CHAN1 + (i) * 2)
> +#define INA3221_WARN(i)			(INA3221_WARN_CHAN1 + (i) * 2)
> +
> +static const struct regmap_range ina3221_readable_ranges[] = {
> +	regmap_reg_range(INA3221_CONFIG, INA3221_POWER_VALID_LOWER_LIMIT),
> +	regmap_reg_range(INA3221_MAN_ID, INA3221_DEV_ID),
> +};
> +
> +static const struct regmap_access_table ina3221_readable_table = {
> +	.yes_ranges = ina3221_readable_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(ina3221_readable_ranges),
> +};
> +
> +static const struct regmap_range ina3221_no_writable_ranges[] = {
> +	regmap_reg_range(INA3221_SHUNT_VOL_CHAN1, INA3221_BUS_VOL_CHAN3),
> +};
> +
> +static const struct regmap_access_table ina3221_writable_table = {
> +	.no_ranges = ina3221_no_writable_ranges,
> +	.n_no_ranges =  ARRAY_SIZE(ina3221_no_writable_ranges),
> +};
> +
> +static const struct regmap_range ina3221_no_volatile_ranges[] = {
> +	regmap_reg_range(INA3221_CONFIG, INA3221_CONFIG),
> +	regmap_reg_range(INA3221_CRIT_CHAN1, INA3221_WARN_CHAN3),
> +	regmap_reg_range(INA3221_POWER_VALID_UPPER_LIMIT,
> +			 INA3221_POWER_VALID_LOWER_LIMIT),
> +	regmap_reg_range(INA3221_MAN_ID, INA3221_DEV_ID),
> +};
> +
> +static const struct regmap_access_table ina3221_volatile_table = {
> +	.no_ranges = ina3221_no_volatile_ranges,
> +	.n_no_ranges =  ARRAY_SIZE(ina3221_no_volatile_ranges),
> +};
> +
> +static const struct regmap_config ina3221_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +	.max_register = INA3221_DEV_ID + 1,
> +	.rd_table = &ina3221_readable_table,
> +	.wr_table = &ina3221_writable_table,
> +	.volatile_table = &ina3221_volatile_table,
> +};
> +
> +struct ina3221_channel_data {
> +	const char *name;
> +	int warn_limits;
> +	int crit_limits;
> +	int shunt_resistance;
> +};
> +
> +struct ina3221_platform_data {
> +	struct ina3221_channel_data channel_data[INA3221_NUMBER_OF_CHANNELS];
> +	bool enable_power;
> +	int oneshot_avg_sample;
> +	int oneshot_vbus_conv_time;
> +	int oneshot_shunt_conv_time;
> +	int cont_avg_sample;
> +	int cont_vbus_conv_time;
> +	int cont_shunt_conv_time;
> +	int continuous_mode;
> +	bool warn_alert;
> +	bool crit_alert;
> +	int active_channel;
> +};
> +
> +struct ina3221_chip_info {
> +	struct device *dev;
> +	struct regmap *rmap;
> +	int oneshot_config;
> +	int continuous_config;
> +	int continuous_mode;
> +	struct mutex state_lock;
> +	struct ina3221_platform_data *pdata;
> +};
> +
> +enum ina3221_address {
> +	INA3221_CHANNEL_NAME,
> +	INA3221_CRIT_CURRENT_LIMIT,
> +	INA3221_WARN_CURRENT_LIMIT,
> +	INA3221_MEASURED_VALUE,
> +	INA3221_OPERATING_MODE,
> +	INA3221_OVERSAMPLING_RATIO,
> +	INA3221_VBUS_CONV_TIME,
> +	INA3221_VSHUNT_CONV_TIME,
> +	INA3221_CHANNEL_ONESHOT,
> +	INA3221_CHANNEL_CONTINUOUS,
> +};
> +
> +static inline int shuntv_register_to_uv(u16 reg)
> +{
> +	int ret = (s16)reg;
> +
> +	return (ret >> 3) * 40;
> +}
> +
> +static inline u16 uv_to_shuntv_register(s32 uv)
> +{
> +	return (u16)(uv / 5);
> +}
> +
> +static inline int busv_register_to_mv(u16 reg)
> +{
> +	int ret = (s16)reg;
> +
> +	return (ret >> 3) * 8;
> +}
> +
> +/* convert shunt voltage register value to current (in mA) */
> +static int shuntv_register_to_ma(u16 reg, int resistance)
> +{
> +	int uv, ma;
> +
> +	uv = (s16)reg;
> +	uv = ((uv >> 3) * 40); /* LSB (4th bit) is 40uV */
> +	/*
> +	 * calculate uv/resistance with rounding knowing that C99 truncates
> +	 * towards zero
> +	 */
> +	if (uv > 0)
> +		ma = ((uv * 2 / resistance) + 1) / 2;
> +	else
> +		ma = ((uv * 2 / resistance) - 1) / 2;
> +	return ma;
> +}
> +
> +static int ina3221_get_closest_index(const int *list, int n_list,
> +				     int val)
> +{
> +	if (val > list[n_list - 1] || (val < list[0]))
> +		return -EINVAL;
> +
> +	return find_closest(val, list, n_list);
> +}
> +
> +/*
> + * Available averaging rates for INA3221. The indices correspond with
> + * the bit values expected by the chip (according to the INA3221 datasheet,
> + * table 3 AVG bit settings, found at
> + */
> +static const int ina3221_avg_tab[] = { 1, 4, 16, 64, 128, 256, 512, 1024};
> +
> +static int ina3221_set_average(struct ina3221_chip_info *chip, unsigned int val,
> +			       unsigned int *config)
> +{
> +	int bits;
> +
> +	bits = ina3221_get_closest_index(ina3221_avg_tab,
> +					 ARRAY_SIZE(ina3221_avg_tab), val);
> +	if (bits < 0)
> +		return bits;
> +
> +	*config &= ~INA3221_CONFIG_AVG_MASK;
> +	*config |= INA3221_CONFIG_AVG(bits) & INA3221_CONFIG_AVG_MASK;
> +
> +	return 0;
> +}
> +
> +/* Conversion times in uS */
> +static const int ina3221_conv_time_tab[] = { 140, 204, 332, 588, 1100,
> +					    2116, 4156, 8244};
> +
> +static int ina3221_set_int_time_vbus(struct ina3221_chip_info *chip,
> +				     unsigned int val_us, unsigned int *config)
> +{
> +	int bits;
> +
> +	bits = ina3221_get_closest_index(ina3221_conv_time_tab,
> +					 ARRAY_SIZE(ina3221_conv_time_tab),
> +					 val_us);
> +	if (bits < 0)
> +		return bits;
> +
> +	*config &= ~INA3221_CONFIG_VBUSCT_MASK;
> +	*config |= INA3221_CONFIG_VBUSCT(bits) & INA3221_CONFIG_VBUSCT_MASK;
> +
> +	return 0;
> +}
> +
> +static int ina3221_set_int_time_vshunt(struct ina3221_chip_info *chip,
> +				       unsigned int val_us,
> +				       unsigned int *config)
> +{
> +	int bits;
> +
> +	bits = ina3221_get_closest_index(ina3221_conv_time_tab,
> +					 ARRAY_SIZE(ina3221_conv_time_tab),
> +					 val_us);
> +	if (bits < 0)
> +		return bits;
> +
> +	*config &= ~INA3221_CONFIG_SHUNTCT_MASK;
> +	*config |= INA3221_CONFIG_SHUNTCT(bits) & INA3221_CONFIG_SHUNTCT_MASK;
> +
> +	return 0;
> +}
> +
> +static int ina3221_do_one_shot_conversion(struct ina3221_chip_info *chip,
> +					  int chan, u16 *vbus, u16 *vsh)
> +{
> +	unsigned int value;
> +	int trials = 0;
> +	int ret;
> +	int conv_time;
> +
> +	conv_time = max(chip->pdata->oneshot_vbus_conv_time,
> +			chip->pdata->oneshot_shunt_conv_time);
> +
> +	ret = regmap_write(chip->rmap, INA3221_CONFIG, chip->oneshot_config);
> +	if (ret < 0)
> +		return 0;
> +
> +	/* Read conversion status */
> +	do {
> +		ret = regmap_read(chip->rmap, INA3221_MASK_ENABLE, &value);
> +		if (ret < 0) {
> +			dev_err(chip->dev,
> +				"Failed to read conversion status: %d\n", ret);
> +			return ret;
> +		}
> +
> +		if (value & INA3221_REG_MASK_CVRF)
> +			break;
> +		usleep_range(conv_time, conv_time * 2);
> +	} while (++trials < INA3221_MAX_CONVERSION_TRIALS);
> +
> +	if (trials == INA3221_MAX_CONVERSION_TRIALS) {
> +		dev_err(chip->dev,
> +			"Conversion not completed for maximum trials\n");
> +		return -EAGAIN;
> +	}
> +
> +	if (vsh) {
> +		ret = regmap_read(chip->rmap, INA3221_SHUNT_VOL(chan), &value);
> +		if (ret < 0)
> +			return ret;
> +		*vsh = (u16)value;
> +	}
> +
> +	if (vbus) {
> +		ret = regmap_read(chip->rmap, INA3221_BUS_VOL(chan), &value);
> +		if (ret < 0)
> +			return ret;
> +		*vbus = (u16)value;
> +	}
> +
> +	ret = regmap_write(chip->rmap, INA3221_CONFIG, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int ina3221_read_continuous_conversion(struct ina3221_chip_info *chip,
> +					      int chan, u16 *vbus, u16 *vsh)
> +{
> +	unsigned int value;
> +	int ret;
> +
> +	if (vsh) {
> +		ret = regmap_read(chip->rmap, INA3221_SHUNT_VOL(chan), &value);
> +		if (ret < 0)
> +			return ret;
> +		*vsh = (u16)value;
> +	}
> +
> +	if (vbus) {
> +		ret = regmap_read(chip->rmap, INA3221_BUS_VOL(chan), &value);
> +		if (ret < 0)
> +			return ret;
> +		*vbus = (u16)value;
> +	}
> +
> +	return ret;
> +}
> +
> +static int ina3221_read_vbus_vshunt(struct ina3221_chip_info *chip,
> +				    int ch, u16 *vbus, u16 *vsh)
> +{
> +	if (chip->continuous_mode)
> +		return ina3221_read_continuous_conversion(chip, ch, vbus, vsh);
> +
> +	return ina3221_do_one_shot_conversion(chip, ch, vbus, vsh);
> +}
> +
> +static int ina3221_get_channel_voltage(struct ina3221_chip_info *chip,
> +				       int chan, int *voltage_uv)
> +{
> +	u16 vbus;
> +	int ret;
> +
> +	ret = ina3221_read_vbus_vshunt(chip, chan, &vbus, NULL);
> +	if (ret < 0)
> +		return ret;
> +
> +	*voltage_uv = busv_register_to_mv(vbus) * 1000;
> +
> +	return 0;
> +}
> +
> +static int ina3221_get_channel_current(struct ina3221_chip_info *chip,
> +				       int chan, int *current_ua)
> +{
> +	int shunt_res = chip->pdata->channel_data[chan].shunt_resistance;
> +	u16 vsh;
> +	int ret;
> +
> +	ret = ina3221_do_one_shot_conversion(chip, chan, NULL, &vsh);
> +	if (ret < 0)
> +		return ret;
> +
> +	*current_ua = shuntv_register_to_ma(vsh, shunt_res) * 1000;
> +
> +	return 0;
> +}
> +
> +static int ina3221_get_channel_power(struct ina3221_chip_info *chip,
> +				     int chan, int *power_uw)
> +{
> +	int shunt_res = chip->pdata->channel_data[chan].shunt_resistance;
> +	u16 vbus, vsh;
> +	int ret;
> +	int current_ma, voltage_mv;
> +
> +	ret = ina3221_do_one_shot_conversion(chip, chan, &vbus, &vsh);
> +	if (ret < 0)
> +		return ret;
> +
> +	current_ma = shuntv_register_to_ma(vsh, shunt_res);
> +	voltage_mv = busv_register_to_mv(vbus);
> +	*power_uw = (voltage_mv * current_ma);
> +
> +	return 0;
> +}
> +
> +static int ina3221_get_channel_critical(struct ina3221_chip_info *chip,
> +					int chan, int *curr_limit_ua)
> +{
> +	*curr_limit_ua = chip->pdata->channel_data[chan].crit_limits;
> +
> +	return 0;
> +}
> +
> +static int ina3221_set_channel_critical(struct ina3221_chip_info *chip,
> +					int chan, int crit_limit_ua)
> +{
> +	int s_res = chip->pdata->channel_data[chan].shunt_resistance;
> +	int shunt_volt_limit;
> +	int crit_limit = crit_limit_ua / 1000;
> +	int ret;
> +
> +	if (crit_limit < 0)
> +		return 0;
> +
> +	shunt_volt_limit = crit_limit * s_res;
> +	shunt_volt_limit = uv_to_shuntv_register(shunt_volt_limit);
> +
> +	ret = regmap_write(chip->rmap, INA3221_CRIT(chan), shunt_volt_limit);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "Failed to write critical reg 0x%02x: %d\n",
> +			INA3221_CRIT(chan), ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ina3221_read_default_channel_critical(struct ina3221_chip_info *chip,
> +						 int chan, int *shunt_curr_ua)
> +{
> +	int shunt_res = chip->pdata->channel_data[chan].shunt_resistance;
> +	int shunt_volt;
> +	unsigned int value;
> +	int ret;
> +
> +	if (shunt_res <= 0) {
> +		dev_err(chip->dev, "Channel %d have invalid shunt resistor\n",
> +			chan);
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_read(chip->rmap, INA3221_CRIT(chan), &value);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "Failed to read critical reg 0x%02x: %d\n",
> +			INA3221_CRIT(chan), ret);
> +		return ret;
> +	}
> +	shunt_volt = shuntv_register_to_uv((u16)value);
> +	*shunt_curr_ua = (shunt_volt / shunt_res) * 1000;
> +
> +	return 0;
> +}
> +
> +static int ina3221_get_channel_warning(struct ina3221_chip_info *chip,
> +				       int chan, int *curr_limit_ua)
> +{
> +	*curr_limit_ua = chip->pdata->channel_data[chan].warn_limits;
> +
> +	return 0;
> +}
> +
> +static int ina3221_set_channel_warning(struct ina3221_chip_info *chip,
> +				       int chan, int warn_limit_ua)
> +{
> +	int s_res = chip->pdata->channel_data[chan].shunt_resistance;
> +	int shunt_volt_limit;
> +	int warn_limit = warn_limit_ua / 1000;
> +	int ret;
> +
> +	if (warn_limit < 0)
> +		return 0;
> +
> +	shunt_volt_limit = warn_limit * s_res;
> +	shunt_volt_limit = uv_to_shuntv_register(shunt_volt_limit);
> +
> +	ret = regmap_write(chip->rmap, INA3221_WARN(chan), shunt_volt_limit);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "Failed to write warning reg 0x%02x: %d\n",
> +			INA3221_CRIT(chan), ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ina3221_read_default_channel_warning(struct ina3221_chip_info *chip,
> +						int chan, int *shunt_curr_ua)
> +{
> +	int shunt_res = chip->pdata->channel_data[chan].shunt_resistance;
> +	int shunt_volt;
> +	unsigned int value;
> +	int ret;
> +
> +	if (shunt_res <= 0) {
> +		dev_err(chip->dev, "Channel %d have invalid shunt resistor\n",
> +			chan);
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_read(chip->rmap, INA3221_WARN(chan), &value);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "Failed to read critical reg 0x%02x: %d\n",
> +			INA3221_CRIT(chan), ret);
> +		return ret;
> +	}
> +	shunt_volt = shuntv_register_to_uv((u16)value);
> +	*shunt_curr_ua = (shunt_volt / shunt_res) * 1000;
> +
> +	return 0;
> +}
> +
> +static int ina3221_get_operating_mode(struct ina3221_chip_info *chip)
> +{
> +	return chip->continuous_mode;
> +}
> +
> +static int ina3221_set_operating_mode(struct ina3221_chip_info *chip,
> +				      int is_continuous)
> +{
> +	unsigned int mask, val;
> +	int ret;
> +
> +	if (!is_continuous) {
> +		ret = regmap_write(chip->rmap, INA3221_CONFIG, 0);
> +		if (ret < 0) {
> +			dev_err(chip->dev,
> +				"Failed to set mode of device: %d\n", ret);
> +			return ret;
> +		}
> +
> +		goto done;
> +	}
> +
> +	if ((chip->pdata->warn_alert || chip->pdata->crit_alert)) {
> +		mask = INA3221_REG_MASK_CEN | INA3221_REG_MASK_WEN;
> +		val = (chip->pdata->warn_alert) ? INA3221_REG_MASK_WEN : 0;
> +		val |= (chip->pdata->crit_alert) ? INA3221_REG_MASK_CEN : 0;
> +
> +		ret = regmap_update_bits(chip->rmap, INA3221_MASK_ENABLE,
> +					 mask, val);
> +		if (ret < 0) {
> +			dev_err(chip->dev,
> +				"Failed to enable warn/crit alert: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	ret = regmap_write(chip->rmap, INA3221_CONFIG, chip->continuous_config);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "Failed to set cont mode: %d\n", ret);
> +		return ret;
> +	}
> +
> +done:
> +	chip->continuous_mode = is_continuous;
> +
> +	return ret;
> +}
> +
> +static int ina3221_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *cspec,
> +			    int *val, int *val2, long mask)
> +{
> +	struct ina3221_chip_info *chip = iio_priv(indio_dev);
> +	int ch = cspec->channel;
> +	int ret = -EINVAL;
> +
> +	if (mask != IIO_CHAN_INFO_PROCESSED)
> +		return -EINVAL;
> +
> +	mutex_lock(&chip->state_lock);
> +
> +	switch (cspec->type) {
> +	case IIO_VOLTAGE:
> +		ret = ina3221_get_channel_voltage(chip, ch, val);
> +		break;
> +
> +	case IIO_CURRENT:
> +		switch (cspec->address) {
> +		case INA3221_MEASURED_VALUE:
> +			ret = ina3221_get_channel_current(chip, ch, val);
> +			break;
> +
> +		case INA3221_CRIT_CURRENT_LIMIT:
> +			ret = ina3221_get_channel_critical(chip, ch, val);
> +			break;
> +
> +		case INA3221_WARN_CURRENT_LIMIT:
> +			ret = ina3221_get_channel_warning(chip, ch, val);
> +			break;
> +		}
> +		break;
> +
> +	case IIO_POWER:
> +		ret = ina3221_get_channel_power(chip, ch, val);
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	mutex_unlock(&chip->state_lock);
> +
> +	return (ret < 0) ? ret : IIO_VAL_INT;
> +}
> +
> +static int ina3221_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *cspec,
> +			     int val, int val2, long mask)
> +{
> +	struct ina3221_chip_info *chip = iio_priv(indio_dev);
> +	int ch = cspec->channel;
> +	int ret = -EINVAL;
> +
> +	if (mask != IIO_CHAN_INFO_PROCESSED)
> +		return -EINVAL;
> +
> +	if (cspec->type != IIO_CURRENT)
> +		return -EINVAL;
> +
> +	mutex_lock(&chip->state_lock);
> +	switch (cspec->address) {
> +	case INA3221_CRIT_CURRENT_LIMIT:
> +		ret = ina3221_set_channel_critical(chip, ch, val);
> +		if (!ret)
> +			chip->pdata->channel_data[ch].crit_limits = val;
> +		break;
> +
> +	case INA3221_WARN_CURRENT_LIMIT:
> +		ret = ina3221_set_channel_warning(chip, ch, val);
> +		if (!ret)
> +			chip->pdata->channel_data[ch].warn_limits = val;
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	mutex_unlock(&chip->state_lock);
> +
> +	return ret;
> +}
> +
> +static ssize_t ina3221_show_channel(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct ina3221_chip_info *chip = iio_priv(indio_dev);
> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +	int mode = UNPACK_MODE(this_attr->address);
> +	int address = UNPACK_CHAN(this_attr->address);
> +	int ret;
> +	int val;
> +
> +	switch (mode) {
> +	case INA3221_CHANNEL_NAME:
> +		return snprintf(buf, PAGE_SIZE, "%s\n",
> +				chip->pdata->channel_data[address].name);
> +
> +	case INA3221_OPERATING_MODE:
> +		ret = ina3221_get_operating_mode(chip);
> +		if (ret)
> +			return snprintf(buf, PAGE_SIZE, "continuous\n");
> +		return snprintf(buf, PAGE_SIZE, "oneshot\n");
> +
> +	case INA3221_OVERSAMPLING_RATIO:
> +		if (address == INA3221_CHANNEL_ONESHOT)
> +			val = chip->pdata->oneshot_avg_sample;
> +		else
> +			val = chip->pdata->cont_avg_sample;
> +		return snprintf(buf, PAGE_SIZE, "%d\n", val);
> +
> +	case INA3221_VBUS_CONV_TIME:
> +		if (address == INA3221_CHANNEL_ONESHOT)
> +			val = chip->pdata->oneshot_vbus_conv_time;
> +		else
> +			val = chip->pdata->cont_vbus_conv_time;
> +		return snprintf(buf, PAGE_SIZE, "%d\n", val);
> +
> +	case INA3221_VSHUNT_CONV_TIME:
> +		if (address == INA3221_CHANNEL_ONESHOT)
> +			val = chip->pdata->oneshot_shunt_conv_time;
> +		else
> +			val = chip->pdata->cont_shunt_conv_time;
> +		return snprintf(buf, PAGE_SIZE, "%d\n", val);
> +
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static ssize_t ina3221_set_channel(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct ina3221_chip_info *chip = iio_priv(indio_dev);
> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +	int mode = UNPACK_MODE(this_attr->address);
> +	int address = UNPACK_CHAN(this_attr->address);
I'd personally use address as an index into an array of static const
struct. Leads to slightly easier to read and more extensible code.

Minor point though.
> +	int o_conf, c_conf;
> +	long val;
> +	int *cont_param = NULL;
> +	int ret = -EINVAL;
> +
> +	if (mode == INA3221_OPERATING_MODE) {
> +		val = ((*buf == 'c') || (*buf == 'C')) ? 1 : 0;
> +	} else {
> +		if (kstrtol(buf, 10, &val) < 0)
> +			return -EINVAL;
> +	}
> +
> +	mutex_lock(&chip->state_lock);
> +
> +	o_conf = chip->oneshot_config;
> +	c_conf = chip->continuous_config;
> +
> +	switch (mode) {
> +	case INA3221_OPERATING_MODE:
> +		if (chip->continuous_mode == val)
> +			break;
> +
> +		ret = ina3221_set_operating_mode(chip, val);
> +		break;
> +
> +	case INA3221_OVERSAMPLING_RATIO:
> +		if (address == INA3221_CHANNEL_ONESHOT) {
> +			ret = ina3221_set_average(chip, val, &o_conf);
> +			if (!ret)
> +				chip->pdata->oneshot_avg_sample = val;
> +		} else {
> +			ret = ina3221_set_average(chip, val, &c_conf);
> +			if (!ret)
> +				cont_param = &chip->pdata->cont_avg_sample;
> +		}
> +		break;
> +
> +	case INA3221_VBUS_CONV_TIME:
> +		if (address == INA3221_CHANNEL_ONESHOT) {
> +			ret = ina3221_set_int_time_vbus(chip, val, &o_conf);
> +			if (!ret)
> +				chip->pdata->oneshot_vbus_conv_time = val;
> +		} else {
> +			ret = ina3221_set_int_time_vbus(chip, val, &c_conf);
> +			if (!ret)
> +				cont_param = &chip->pdata->cont_vbus_conv_time;
> +		}
> +		break;
> +
> +	case INA3221_VSHUNT_CONV_TIME:
> +		if (address == INA3221_CHANNEL_ONESHOT) {
> +			ret = ina3221_set_int_time_vshunt(chip, val, &o_conf);
> +			if (!ret)
> +				chip->pdata->oneshot_shunt_conv_time = val;
> +		} else {
> +			ret = ina3221_set_int_time_vshunt(chip, val, &c_conf);
> +			if (!ret)
> +				cont_param = &chip->pdata->cont_shunt_conv_time;
> +		}
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	if (ret < 0)
> +		goto exit;
> +
> +	chip->oneshot_config = o_conf;
> +	if (chip->continuous_mode && chip->continuous_config != c_conf) {
> +		ret = regmap_write(chip->rmap, INA3221_CONFIG, c_conf);
> +		if (ret < 0)
> +			goto exit;
> +	}
> +	chip->continuous_config = c_conf;
> +	if (cont_param)
> +		*cont_param = val;
> +
> +exit:
> +	mutex_unlock(&chip->state_lock);
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR(rail_name_0, S_IRUGO | S_IWUSR,
> +		ina3221_show_channel, ina3221_set_channel,
> +		PACK_MODE_CHAN(INA3221_CHANNEL_NAME, 0));
> +
> +static IIO_DEVICE_ATTR(rail_name_1, S_IRUGO | S_IWUSR,
> +		ina3221_show_channel, ina3221_set_channel,
> +		PACK_MODE_CHAN(INA3221_CHANNEL_NAME, 1));
> +
> +static IIO_DEVICE_ATTR(rail_name_2, S_IRUGO | S_IWUSR,
> +		ina3221_show_channel, ina3221_set_channel,
> +		PACK_MODE_CHAN(INA3221_CHANNEL_NAME, 2));
> +
> +static IIO_DEVICE_ATTR(operating_mode, S_IRUGO | S_IWUSR,
> +		ina3221_show_channel, ina3221_set_channel,
> +		PACK_MODE_CHAN(INA3221_OPERATING_MODE, 0));
> +
> +static IIO_DEVICE_ATTR(oneshot_oversampling_ratio, S_IRUGO | S_IWUSR,
> +		ina3221_show_channel, ina3221_set_channel,
> +		PACK_MODE_CHAN(INA3221_OVERSAMPLING_RATIO,
> +			       INA3221_CHANNEL_ONESHOT));
> +
> +static IIO_DEVICE_ATTR(continuous_oversampling_ratio, S_IRUGO | S_IWUSR,
> +		ina3221_show_channel, ina3221_set_channel,
> +		PACK_MODE_CHAN(INA3221_OVERSAMPLING_RATIO,
> +			       INA3221_CHANNEL_CONTINUOUS));
> +
> +static IIO_DEVICE_ATTR(oneshot_vbus_conv_time, S_IRUGO | S_IWUSR,
> +		ina3221_show_channel, ina3221_set_channel,
> +		PACK_MODE_CHAN(INA3221_VBUS_CONV_TIME,
> +			       INA3221_CHANNEL_ONESHOT));
> +
> +static IIO_DEVICE_ATTR(continuous_vbus_conv_time, S_IRUGO | S_IWUSR,
> +		ina3221_show_channel, ina3221_set_channel,
> +		PACK_MODE_CHAN(INA3221_VBUS_CONV_TIME,
> +			       INA3221_CHANNEL_CONTINUOUS));
> +
> +static IIO_DEVICE_ATTR(oneshot_vshunt_conv_time, S_IRUGO | S_IWUSR,
> +		ina3221_show_channel, ina3221_set_channel,
> +		PACK_MODE_CHAN(INA3221_VSHUNT_CONV_TIME,
> +			       INA3221_CHANNEL_ONESHOT));
> +
> +static IIO_DEVICE_ATTR(continuous_vshunt_conv_time, S_IRUGO | S_IWUSR,
> +		ina3221_show_channel, ina3221_set_channel,
> +		PACK_MODE_CHAN(INA3221_VSHUNT_CONV_TIME,
> +			       INA3221_CHANNEL_CONTINUOUS));
> +
> +static struct attribute *ina3221_attributes[] = {
> +	&iio_dev_attr_rail_name_0.dev_attr.attr,
> +	&iio_dev_attr_rail_name_1.dev_attr.attr,
> +	&iio_dev_attr_rail_name_2.dev_attr.attr,
> +	&iio_dev_attr_oneshot_oversampling_ratio.dev_attr.attr,
> +	&iio_dev_attr_continuous_oversampling_ratio.dev_attr.attr,
> +	&iio_dev_attr_oneshot_vbus_conv_time.dev_attr.attr,
> +	&iio_dev_attr_continuous_vbus_conv_time.dev_attr.attr,
> +	&iio_dev_attr_oneshot_vshunt_conv_time.dev_attr.attr,
> +	&iio_dev_attr_continuous_vshunt_conv_time.dev_attr.attr,
> +	&iio_dev_attr_operating_mode.dev_attr.attr,
Was about to complain about docs then noticed patch 3.  There's a lot
here and it's mostly non standard.. hmm.
> +	NULL,
> +};
> +
> +static const struct attribute_group ina3221_groups = {
> +	.attrs = ina3221_attributes,
> +};
> +
> +#define channel_type(_type, _add, _channel, _name) {			\
> +	.type = _type,							\
> +	.indexed = 1,							\
> +	.address = _add,						\
> +	.channel = _channel,						\
> +	.extend_name = _name,						\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED)		\
> +}
> +
> +#define channel_spec(ch)						       \
> +	channel_type(IIO_VOLTAGE, 0, ch, NULL),				       \
> +	channel_type(IIO_CURRENT, INA3221_MEASURED_VALUE, ch, NULL),	       \
> +	channel_type(IIO_CURRENT, INA3221_CRIT_CURRENT_LIMIT, ch, "warning"),  \
> +	channel_type(IIO_CURRENT, INA3221_WARN_CURRENT_LIMIT, ch, "critical"), \
These aren't channels that I can see but rather events on a given channel.
There's an issue here as well in that IIO doesn't currently support two
events of the same type on a single channel - our event codes have no
way of distguishing between them.  This needs fixing but we haven't done
it yet.

Also these particular events do make this seem rather more or a power
monitoring chip than we'd normally expect to see in IIO - hence the
need for that justification in the patch description ;)
> +	channel_type(IIO_POWER, 0, ch, NULL)
> +
> +static const struct iio_chan_spec ina3221_channels_spec[] = {
> +	channel_spec(0),
> +	channel_spec(1),
> +	channel_spec(2),
> +};
> +
> +static const struct iio_info ina3221_info = {
> +	.driver_module = THIS_MODULE,
> +	.attrs = &ina3221_groups,
> +	.read_raw = ina3221_read_raw,
> +	.write_raw = ina3221_write_raw,
> +};
> +
> +static int ina3221_process_pdata(struct ina3221_chip_info *chip,
> +				 struct ina3221_platform_data *pdata)
> +{
> +	unsigned int o_conf;
> +	unsigned int c_conf;
> +	int ret;
> +
> +	o_conf = 0x7 << 12;
> +	c_conf = pdata->active_channel << 12;
> +
> +	o_conf |= (chip->pdata->enable_power) ? 0x3 : 0x2;
> +	c_conf |= (chip->pdata->enable_power) ? 0x7 : 0x6;
> +
> +	ret = ina3221_set_average(chip, pdata->oneshot_avg_sample, &o_conf);
> +	if (ret < 0)
> +		return ret;
> +	ret = ina3221_set_average(chip, pdata->cont_avg_sample, &c_conf);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ina3221_set_int_time_vbus(chip, pdata->oneshot_vbus_conv_time,
> +					&o_conf);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ina3221_set_int_time_vbus(chip, pdata->cont_vbus_conv_time,
> +					&c_conf);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ina3221_set_int_time_vshunt(chip, pdata->oneshot_shunt_conv_time,
> +					  &o_conf);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ina3221_set_int_time_vshunt(chip, pdata->cont_shunt_conv_time,
> +					  &c_conf);
> +	if (ret < 0)
> +		return ret;
> +
> +	chip->oneshot_config = o_conf;
> +	chip->continuous_config = c_conf;
> +	return 0;
> +}
> +
There is a lot of moderately controversial stuff in here - I'll reply to
the binding doc instead of here on these though.
> +static int ina3221_get_platform_data_dt(struct ina3221_chip_info *chip)
> +{
> +	struct device *dev = chip->dev;
> +	struct device_node *np = dev->of_node;
> +	struct device_node *np_chan;
> +	struct ina3221_platform_data *pdata;
> +	struct ina3221_channel_data *cdata;
> +	char channel_name[20];
> +	u32 value;
> +	int curr_ua;
> +	int id;
> +	int ret;
> +
> +	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return -ENOMEM;
> +
> +	chip->pdata = pdata;
> +
> +	ret = of_property_read_u32(np, "one-shot-average-sample", &value);
> +	if (!ret)
> +		pdata->oneshot_avg_sample = value;
> +	else
> +		pdata->oneshot_avg_sample = INA3221_CONFIG_AVG_SAMPLE_DEFAULT;
> +
> +	ret = of_property_read_u32(np, "one-shot-vbus-conv-time-us", &value);
> +	if (!ret)
> +		pdata->oneshot_vbus_conv_time = value;
> +	else
> +		pdata->oneshot_vbus_conv_time =
> +					INA3221_CONFIG_VBUS_CONV_TIME_DEFAULT;
> +
> +	ret = of_property_read_u32(np, "one-shot-shunt-conv-time-us",
> +				   &value);
> +	if (!ret)
> +		pdata->oneshot_shunt_conv_time = value;
> +	else
> +		pdata->oneshot_shunt_conv_time =
> +					INA3221_CONFIG_SHUNT_CONV_TIME_DEFAULT;
> +
> +	ret = of_property_read_u32(np, "continuous-average-sample", &value);
> +	if (!ret)
> +		pdata->cont_avg_sample = value;
> +	else
> +		pdata->cont_avg_sample = INA3221_CONFIG_AVG_SAMPLE_DEFAULT;
> +
> +	ret = of_property_read_u32(np, "continuous-vbus-conv-time-us", &value);
> +	if (!ret)
> +		pdata->cont_vbus_conv_time = value;
> +	else
> +		pdata->cont_vbus_conv_time =
> +					INA3221_CONFIG_VBUS_CONV_TIME_DEFAULT;
> +
> +	ret = of_property_read_u32(np, "continuous-shunt-conv-time-us", &value);
> +	if (!ret)
> +		pdata->cont_shunt_conv_time = value;
> +	else
> +		pdata->cont_shunt_conv_time =
> +					INA3221_CONFIG_SHUNT_CONV_TIME_DEFAULT;
> +
> +	pdata->enable_power =  of_property_read_bool(np,
> +						     "enable-power-monitor");
> +	pdata->continuous_mode = of_property_read_bool(np,
> +						"enable-continuous-mode");
> +	pdata->warn_alert =  of_property_read_bool(np, "enable-warning-alert");
> +	pdata->crit_alert =  of_property_read_bool(np, "enable-critical-alert");
> +
> +	for (id = 0; id < INA3221_NUMBER_OF_CHANNELS; ++id) {
> +		sprintf(channel_name, "channel%d", id);
> +		np_chan = of_get_child_by_name(np, channel_name);
> +		if (!np_chan)
> +			continue;
> +
> +		cdata = &pdata->channel_data[id];
> +
> +		ret = of_property_read_string(np_chan, "label", &cdata->name);
> +		if (ret < 0) {
> +			dev_err(dev, "Channel %s does not have label\n",
> +				np_chan->full_name);
> +			continue;
> +		}
> +
> +		ret = of_property_read_u32(np_chan,
> +					   "warning-current-limit-microamp",
> +					   &value);
> +		cdata->warn_limits = (!ret) ? value : ret;
> +
> +		ret = of_property_read_u32(np_chan,
> +					   "critical-current-limit-microamp",
> +					   &value);
> +		cdata->crit_limits = (!ret) ? value : ret;
> +
> +		ret = of_property_read_u32(np_chan, "shunt-resistor-mohm",
> +					   &value);
> +		if (!ret)
> +			cdata->shunt_resistance = value;
> +
> +		pdata->active_channel |= BIT(INA3221_NUMBER_OF_CHANNELS - id -
> +					     1);
> +
> +		if (cdata->crit_limits < 0) {
> +			ret = ina3221_read_default_channel_critical(chip, id,
> +								    &curr_ua);
> +			if (ret < 0)
> +				return ret;
> +			cdata->crit_limits = curr_ua;
> +		} else {
> +			ret = ina3221_set_channel_critical(chip, id,
> +							   cdata->crit_limits);
> +			if (ret < 0)
> +				return ret;
> +		}
> +
> +		if (cdata->warn_limits < 0) {
> +			ret = ina3221_read_default_channel_warning(chip, id,
> +								   &curr_ua);
> +			if (ret < 0)
> +				return ret;
> +			cdata->warn_limits = curr_ua;
> +		} else {
> +			ret = ina3221_set_channel_warning(chip, id,
> +							  cdata->warn_limits);
> +			if (ret < 0)
> +				return ret;
> +		}
> +	}
> +
> +	if (!pdata->active_channel)
> +		return -EINVAL;
> +
> +	ret = ina3221_process_pdata(chip, pdata);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "Failed to process platform data: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ina3221_do_reset(struct ina3221_chip_info *chip)
> +{
> +	int ret;
> +
> +	ret = regmap_update_bits(chip->rmap, INA3221_CONFIG,
> +				 INA3221_CONFIG_RESET_MASK,
> +				 INA3221_CONFIG_RESET_EN);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "Failed to reset device: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = regmap_update_bits(chip->rmap, INA3221_CONFIG,
> +				 INA3221_CONFIG_RESET_MASK, 0);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "Failed to reset device: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ina3221_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct ina3221_chip_info *chip;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	chip = iio_priv(indio_dev);
> +
> +	chip->rmap = devm_regmap_init_i2c(client, &ina3221_regmap_config);
> +	if (IS_ERR(chip->rmap)) {
> +		ret = PTR_ERR(chip->rmap);
> +		dev_err(&client->dev, "Failed to initialise regmap: %d\n", ret);
> +		return ret;
> +	}
> +
> +	chip->dev = &client->dev;
> +	mutex_init(&chip->state_lock);
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	ret = ina3221_do_reset(chip);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ina3221_get_platform_data_dt(chip);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Failed to get platform data: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = ina3221_set_operating_mode(chip, chip->pdata->continuous_mode);
> +	if (ret < 0)
> +		return ret;
> +
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->channels = ina3221_channels_spec;
> +	indio_dev->num_channels = ARRAY_SIZE(ina3221_channels_spec);
> +	indio_dev->name = id->name;
> +	indio_dev->info = &ina3221_info;
> +
> +	return iio_device_register(indio_dev);
> +}
> +
> +static int ina3221_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct ina3221_chip_info *chip = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +
> +	/* Powerdown */
> +	return regmap_update_bits(chip->rmap, INA3221_CONFIG,
> +				  INA3221_CONFIG_MODE_MASK,
> +				  INA3221_CONFIG_MODE_POWER_DOWN);
> +}
> +
> +static const struct i2c_device_id ina3221_id[] = {
> +	{.name = "ina3221"},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(i2c, ina3221_id);
> +
> +static struct i2c_driver ina3221_driver = {
> +	.driver = {
> +		   .name = "ina3221",
> +	},
> +	.probe = ina3221_probe,
> +	.remove = ina3221_remove,
> +	.id_table = ina3221_id,
> +};
> +module_i2c_driver(ina3221_driver);
> +
> +MODULE_DESCRIPTION("Texas Instruments INA3221 ADC driver");
> +MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
> +MODULE_LICENSE("GPL v2");
> 

