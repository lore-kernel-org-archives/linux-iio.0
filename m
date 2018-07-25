Return-Path: <SRS0=Gjn+=KJ=codeaurora.org=smohanad@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Wed, 25 Jul 2018 16:19:24 -0700
From: smohanad@codeaurora.org
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, Hartmut Knaack
 <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter
 Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring <robh+dt@kernel.org>,
 linux-iio-owner@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: Add QCOM SPMI PMIC5 ADC driver
In-Reply-To: <20180712142517.000046dd@huawei.com>
References: <1530210637-16589-1-git-send-email-smohanad@codeaurora.org>
 <20180630170602.0d7829c7@archlinux>
 <9b1586434cb2abe7522dceb434a4ad7b@codeaurora.org>
 <20180712142517.000046dd@huawei.com>
Message-ID: <14e792e2720b3452428c5a4407af8f06@codeaurora.org>
List-ID: <linux-iio@vger.kernel.org>

On 2018-07-12 06:25, Jonathan Cameron wrote:
> On Wed, 11 Jul 2018 14:26:16 -0700
> <smohanad@codeaurora.org> wrote:
> 
>> Hi,
>> 
>> On 2018-06-30 09:06, Jonathan Cameron wrote:
>> > On Thu, 28 Jun 2018 11:30:37 -0700
>> > Siddartha Mohanadoss <smohanad@codeaurora.org> wrote:
>> >
>> >> This patch adds support for QCOM SPMI PMIC5 family
>> >> of ADC driver that supports hardware based offset and
>> >> gain compensation. The ADC peripheral can measure both
>> >> voltage and current channels whose input signal is
>> >> connected to the PMIC ADC AMUX.
>> >>
>> >> The register set and configuration has been refreshed
>> >> compared to the prior QCOM PMIC ADC family. Register
>> >> ADC5 as part of the IIO framework.
>> >>
>> >> Signed-off-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
>> > I guess I missed the oddity that is power channel handling on v1.
>> >
>> > Why are you using IIO_VAL_INT_MULTIPLE?  That was added
>> > to support the weirdness of quaternion outputs so I'm not
>> > sure what the intent is here.
>> 
>> The ADC supports few channels primarily for synchronous reads that
>> measures
>> both voltage and current readings at the same time. I was looking for 
>> an
>> option to return both these values in the result when it's queried.
> 
> Use the buffered interface if you want to do that.  Sysfs rule of thumb
> is one file one reading, there is no concept of synchronization between
> multiple readings.   The only exception is when those readings truly 
> have
> no useful meaning except in a set (which is true of quaternions).

Ok. For this series push, I will remove the power channel handling and 
look
into adding support using the buffered interface and push it out as a
separate patch.

> 
>> 
>> > (and I did a slightly panic ridden grep to see if this was a cut
>> > and paste bug - thankfully not - it seems to be unique to this driver
>> > :)
>> >
>> > Otherwise a few minors.
>> >
>> > Jonathan
>> >
>> >
>> >> ---
>> >>  drivers/iio/adc/Kconfig            |  20 +
>> >>  drivers/iio/adc/Makefile           |   1 +
>> >>  drivers/iio/adc/qcom-spmi-adc5.c   | 878
>> >> +++++++++++++++++++++++++++++++++++++
>> >>  drivers/iio/adc/qcom-vadc-common.c | 230 +++++++++-
>> >>  drivers/iio/adc/qcom-vadc-common.h |  56 +++
>> >>  5 files changed, 1180 insertions(+), 5 deletions(-)
>> >>  create mode 100644 drivers/iio/adc/qcom-spmi-adc5.c
>> >>
>> >> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> >> index 9da7907..93ac929 100644
>> >> --- a/drivers/iio/adc/Kconfig
>> >> +++ b/drivers/iio/adc/Kconfig
>> >> @@ -597,6 +597,26 @@ config QCOM_SPMI_VADC
>> >>  	  To compile this driver as a module, choose M here: the module will
>> >>  	  be called qcom-spmi-vadc.
>> >>
>> >> +config QCOM_SPMI_ADC5
>> >> +	tristate "Qualcomm Technologies Inc. SPMI PMIC5 ADC"
>> >> +	depends on SPMI
>> >> +	select REGMAP_SPMI
>> >> +	select QCOM_VADC_COMMON
>> >> +	help
>> >> +	  This is the IIO Voltage PMIC5 ADC driver for Qualcomm Technologies
>> >> Inc.
>> >> +
>> >> +	  The driver supports multiple channels read. The ADC is a 16-bit
>> >> +	  sigma-delta ADC. The hardware supports calibrated results for
>> >> +	  conversion requests and clients include reading voltage phone
>> >> +	  power, on board system thermistors connected to the PMIC ADC,
>> >> +	  PMIC die temperature, charger temperature, battery current, USB
>> >> voltage
>> >> +	  input, voltage signals connected to supported PMIC GPIO inputs.
>> >> The
>> >> +	  hardware supports internal pull-up for thermistors and can choose
>> >> between
>> >> +	  a 100k, 30k and 400k pull up using the ADC channels.
>> >> +
>> >> +	  To compile this driver as a module, choose M here: the module will
>> >> +	  be called qcom-spmi-adc5.
>> >> +
>> >>  config RCAR_GYRO_ADC
>> >>  	tristate "Renesas R-Car GyroADC driver"
>> >>  	depends on ARCH_RCAR_GEN2 || COMPILE_TEST
>> >> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>> >> index 28a9423..9533a82 100644
>> >> --- a/drivers/iio/adc/Makefile
>> >> +++ b/drivers/iio/adc/Makefile
>> >> @@ -56,6 +56,7 @@ obj-$(CONFIG_PALMAS_GPADC) += palmas_gpadc.o
>> >>  obj-$(CONFIG_QCOM_SPMI_IADC) += qcom-spmi-iadc.o
>> >>  obj-$(CONFIG_QCOM_VADC_COMMON) += qcom-vadc-common.o
>> >>  obj-$(CONFIG_QCOM_SPMI_VADC) += qcom-spmi-vadc.o
>> >> +obj-$(CONFIG_QCOM_SPMI_ADC5) += qcom-spmi-adc5.o
>> >>  obj-$(CONFIG_QCOM_PM8XXX_XOADC) += qcom-pm8xxx-xoadc.o
>> >>  obj-$(CONFIG_RCAR_GYRO_ADC) += rcar-gyroadc.o
>> >>  obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
>> >> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c
>> >> b/drivers/iio/adc/qcom-spmi-adc5.c
>> >> new file mode 100644
>> >> index 0000000..75308df
>> >> --- /dev/null
>> >> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
>> >> @@ -0,0 +1,878 @@
>> >> +/*
>> >> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>> >> + *
>> >> + * This program is free software; you can redistribute it and/or
>> >> modify
>> >> + * it under the terms of the GNU General Public License version 2 and
>> >> + * only version 2 as published by the Free Software Foundation.
>> >> + *
>> >> + * This program is distributed in the hope that it will be useful,
>> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> >> + * GNU General Public License for more details.
>> >
>> > SPDX a possibility?
>> 
>> Ok, i will use only SPDX.
>> 
>> >
>> >> + */
>> >> +
>> >> +#include <linux/bitops.h>
>> >> +#include <linux/completion.h>
>> >> +#include <linux/delay.h>
>> >> +#include <linux/err.h>
>> >> +#include <linux/iio/iio.h>
>> >> +#include <linux/interrupt.h>
>> >> +#include <linux/kernel.h>
>> >> +#include <linux/math64.h>
>> >> +#include <linux/module.h>
>> >> +#include <linux/of.h>
>> >> +#include <linux/platform_device.h>
>> >> +#include <linux/regmap.h>
>> >> +#include <linux/slab.h>
>> >> +#include <linux/log2.h>
>> >> +
>> >> +#include <dt-bindings/iio/qcom,spmi-vadc.h>
>> >> +#include "qcom-vadc-common.h"
>> >> +
>> >> +#define ADC5_USR_REVISION1			0x0
>> >> +#define ADC5_USR_STATUS1			0x8
>> >> +#define ADC5_USR_STATUS1_REQ_STS		BIT(1)
>> >> +#define ADC5_USR_STATUS1_EOC			BIT(0)
>> >> +#define ADC5_USR_STATUS1_REQ_STS_EOC_MASK	0x3
>> >> +
>> >> +#define ADC5_USR_STATUS2			0x9
>> >> +#define ADC5_USR_STATUS2_CONV_SEQ_MASK		0x70
>> >> +#define ADC5_USR_STATUS2_CONV_SEQ_MASK_SHIFT	0x5
>> >> +
>> >> +#define ADC5_USR_IBAT_MEAS			0xf
>> >> +#define ADC5_USR_IBAT_MEAS_SUPPORTED		BIT(0)
>> >> +
>> >> +#define ADC5_USR_DIG_PARAM			0x42
>> >> +#define ADC5_USR_DIG_PARAM_CAL_VAL		BIT(6)
>> >> +#define ADC5_USR_DIG_PARAM_CAL_VAL_SHIFT	6
>> >> +#define ADC5_USR_DIG_PARAM_CAL_SEL		0x30
>> >> +#define ADC5_USR_DIG_PARAM_CAL_SEL_SHIFT	4
>> >> +#define ADC5_USR_DIG_PARAM_DEC_RATIO_SEL	0xc
>> >> +#define ADC5_USR_DIG_PARAM_DEC_RATIO_SEL_SHIFT	2
>> >> +
>> >> +#define ADC5_USR_FAST_AVG_CTL			0x43
>> >> +#define ADC5_USR_FAST_AVG_CTL_EN		BIT(7)
>> >> +#define ADC5_USR_FAST_AVG_CTL_SAMPLES_MASK	0x7
>> >> +
>> >> +#define ADC5_USR_CH_SEL_CTL			0x44
>> >> +
>> >> +#define ADC5_USR_DELAY_CTL			0x45
>> >> +#define ADC5_USR_HW_SETTLE_DELAY_MASK		0xf
>> >> +
>> >> +#define ADC5_USR_EN_CTL1			0x46
>> >> +#define ADC5_USR_EN_CTL1_ADC_EN			BIT(7)
>> >> +
>> >> +#define ADC5_USR_CONV_REQ			0x47
>> >> +#define ADC5_USR_CONV_REQ_REQ			BIT(7)
>> >> +
>> >> +#define ADC5_USR_DATA0				0x50
>> >> +
>> >> +#define ADC5_USR_DATA1				0x51
>> >> +
>> >> +#define ADC5_USR_IBAT_DATA0			0x52
>> >> +
>> >> +#define ADC5_USR_IBAT_DATA1			0x53
>> >> +
>> >> +/*
>> >> + * Conversion time varies based on the decimation, clock rate, fast
>> >> average
>> >> + * samples and measurements queued across different VADC peripherals.
>> >> + * Set the timeout to a max of 100ms.
>> >> + */
>> >> +#define ADC5_CONV_TIME_MIN_US			263
>> >> +#define ADC5_CONV_TIME_MAX_US			264
>> >> +#define ADC5_CONV_TIME_RETRY			400
>> >> +#define ADC5_CONV_TIMEOUT			msecs_to_jiffies(100)
>> >> +
>> >> +/* Digital version >= 5.3 supports hw_settle_2 */
>> >> +#define ADC5_HW_SETTLE_DIFF_MINOR		3
>> >> +#define ADC5_HW_SETTLE_DIFF_MAJOR		5
>> >> +
>> >> +enum adc5_cal_method {
>> >> +	ADC5_NO_CAL = 0,
>> >> +	ADC5_RATIOMETRIC_CAL,
>> >> +	ADC5_ABSOLUTE_CAL
>> >> +};
>> >> +
>> >> +enum adc5_cal_val {
>> >> +	ADC5_TIMER_CAL = 0,
>> >> +	ADC5_NEW_CAL
>> >> +};
>> >> +
>> >> +/**
>> >> + * struct adc5_channel_prop - ADC channel property.
>> >> + * @channel: channel number, refer to the channel list.
>> >> + * @cal_method: calibration method.
>> >> + * @cal_val: calibration value
>> >> + * @decimation: sampling rate supported for the channel.
>> >> + * @prescale: channel scaling performed on the input signal.
>> >> + * @hw_settle_time: the time between AMUX being configured and the
>> >> + *	start of conversion.
>> >> + * @avg_samples: ability to provide single result from the ADC
>> >> + *	that is an average of multiple measurements.
>> >> + * @scale_fn_type: Represents the scaling function to convert voltage
>> >> + *	physical units desired by the client for the channel.
>> >> + * @datasheet_name: Channel name used in device tree.
>> >> + */
>> >> +struct adc5_channel_prop {
>> >> +	unsigned int		channel;
>> >> +	enum adc5_cal_method	cal_method;
>> >> +	enum adc5_cal_val	cal_val;
>> >> +	unsigned int		decimation;
>> >> +	unsigned int		prescale;
>> >> +	unsigned int		hw_settle_time;
>> >> +	unsigned int		avg_samples;
>> >> +	enum vadc_scale_fn_type	scale_fn_type;
>> >> +	const char		*datasheet_name;
>> >> +};
>> >> +
>> >> +/**
>> >> + * struct adc5_chip - ADC private structure.
>> >> + * @regmap: SPMI ADC5 peripheral register map field.
>> >> + * @dev: SPMI ADC5 device.
>> >> + * @base: base address for the ADC peripheral.
>> >> + * @nchannels: number of ADC channels.
>> >> + * @chan_props: array of ADC channel properties.
>> >> + * @iio_chans: array of IIO channels specification.
>> >> + * @poll_eoc: use polling instead of interrupt.
>> >> + * @complete: ADC result notification after interrupt is received.
>> >> + * @lock: ADC lock for access to the peripheral.
>> >> + * @data: software configuration data.
>> >> + */
>> >> +struct adc5_chip {
>> >> +	struct regmap		*regmap;
>> >> +	struct device		*dev;
>> >> +	u16			base;
>> >> +	unsigned int		nchannels;
>> >> +	struct adc5_channel_prop	*chan_props;
>> >> +	struct iio_chan_spec	*iio_chans;
>> >> +	bool			poll_eoc;
>> >> +	struct completion	complete;
>> >> +	struct mutex		lock;
>> >> +	const struct adc_data	*data;
>> >> +};
>> >> +
>> >> +static const struct vadc_prescale_ratio adc5_prescale_ratios[] = {
>> >> +	{.num =  1, .den =  1},
>> >> +	{.num =  1, .den =  3},
>> >> +	{.num =  1, .den =  4},
>> >> +	{.num =  1, .den =  6},
>> >> +	{.num =  1, .den = 20},
>> >> +	{.num =  1, .den =  8},
>> >> +	{.num = 10, .den = 81},
>> >> +	{.num =  1, .den = 10},
>> >> +	{.num =  1, .den = 16}
>> >> +};
>> >> +
>> >> +static int adc5_read(struct adc5_chip *adc, u16 offset, u8 *data, int
>> >> len)
>> >> +{
>> >> +	return regmap_bulk_read(adc->regmap, adc->base + offset, data, len);
>> >> +}
>> >> +
>> >> +static int adc5_write(struct adc5_chip *adc, u16 offset, u8 *data,
>> >> int len)
>> >> +{
>> >> +	return regmap_bulk_write(adc->regmap, adc->base + offset, data,
>> >> len);
>> >> +}
>> >> +
>> >> +static int adc5_prescaling_from_dt(u32 num, u32 den)
>> >> +{
>> >> +	unsigned int pre;
>> >> +
>> >> +	for (pre = 0; pre < ARRAY_SIZE(adc5_prescale_ratios); pre++)
>> >> +		if (adc5_prescale_ratios[pre].num == num &&
>> >> +		    adc5_prescale_ratios[pre].den == den)
>> >> +			break;
>> >> +
>> >> +	if (pre == ARRAY_SIZE(adc5_prescale_ratios))
>> >> +		return -EINVAL;
>> >> +
>> >> +	return pre;
>> >> +}
>> >> +
>> >> +static int adc5_get_dig_version(struct adc5_chip *adc,
>> >> +					u8 *dig_version)
>> >> +{
>> >> +	int ret;
>> >> +
>> >> +	ret = adc5_read(adc, ADC5_USR_REVISION1, dig_version, 2);
>> >
>> > return adc5_read(...)
>> 
>> Ok.
>> 
>> >
>> >> +	if (ret)
>> >> +		return ret;
>> >> +
>> >> +	return 0;
>> >> +}
>> >> +
>> >> +static int adc5_hw_settle_time_from_dt(u32 value,
>> >> +					const unsigned int *hw_settle)
>> >> +{
>> >> +	uint32_t i;
>> >> +
>> >> +	for (i = 0; i < VADC_HW_SETTLE_SAMPLES_MAX; i++) {
>> >> +		if (value == hw_settle[i])
>> >> +			return i;
>> >> +	}
>> >> +
>> >> +	return -EINVAL;
>> >> +}
>> >> +
>> >> +static int adc5_avg_samples_from_dt(u32 value)
>> >> +{
>> >> +	if (!is_power_of_2(value) || value > ADC5_AVG_SAMPLES_MAX)
>> >> +		return -EINVAL;
>> >> +
>> >> +	return __ffs64(value);
>> >> +}
>> >> +
>> >> +static int adc5_decimation_from_dt(u32 value,
>> >> +					const unsigned int *decimation)
>> >> +{
>> >> +	uint32_t i;
>> >> +
>> >> +	for (i = 0; i < ADC5_DECIMATION_SAMPLES_MAX; i++) {
>> >> +		if (value == decimation[i])
>> >> +			return i;
>> >> +	}
>> >> +
>> >> +	return -EINVAL;
>> >> +}
>> >> +
>> >> +static int adc5_read_current_data(struct adc5_chip *adc, u16 *data)
>> >> +{
>> >> +	int ret;
>> >> +	u8 rslt_lsb = 0, rslt_msb = 0;
>> >> +
>> >> +	ret = adc5_read(adc, ADC5_USR_IBAT_DATA0, &rslt_lsb, 1);
>> >> +	if (ret)
>> >> +		return ret;
>> >> +
>> >> +	ret = adc5_read(adc, ADC5_USR_IBAT_DATA1, &rslt_msb, 1);
>> >> +	if (ret)
>> >> +		return ret;
>> >> +
>> >> +	*data = (rslt_msb << 8) | rslt_lsb;
>> >> +
>> >> +	if (*data == ADC5_USR_DATA_CHECK) {
>> >> +		pr_err("Invalid data:0x%x\n", *data);
>> >> +		return -EINVAL;
>> >> +	}
>> >> +
>> >> +	return ret;
>> >> +}
>> >> +
>> >> +static int adc5_read_voltage_data(struct adc5_chip *adc, u16 *data)
>> >> +{
>> >> +	int ret;
>> >> +	u8 rslt_lsb, rslt_msb;
>> >> +
>> >> +	ret = adc5_read(adc, ADC5_USR_DATA0, &rslt_lsb, 1);
>> >> +	if (ret)
>> >> +		return ret;
>> >> +
>> >> +	ret = adc5_read(adc, ADC5_USR_DATA1, &rslt_msb, 1);
>> >> +	if (ret)
>> >> +		return ret;
>> >> +
>> >> +	*data = (rslt_msb << 8) | rslt_lsb;
>> >> +
>> >> +	if (*data == ADC5_USR_DATA_CHECK) {
>> >> +		pr_err("Invalid data:0x%x\n", *data);
>> >> +		return -EINVAL;
>> >> +	}
>> >> +
>> >> +	return ret;
>> >> +}
>> >> +
>> >> +static int adc5_poll_wait_eoc(struct adc5_chip *adc)
>> >> +{
>> >> +	unsigned int count, retry = ADC5_CONV_TIME_RETRY;
>> >> +	u8 status1;
>> >> +	int ret;
>> >> +
>> >> +	for (count = 0; count < retry; count++) {
>> >> +		ret = adc5_read(adc, ADC5_USR_STATUS1, &status1, 1);
>> >> +		if (ret)
>> >> +			return ret;
>> >> +
>> >> +		status1 &= ADC5_USR_STATUS1_REQ_STS_EOC_MASK;
>> >> +		if (status1 == ADC5_USR_STATUS1_EOC)
>> >> +			return 0;
>> >> +		usleep_range(ADC5_CONV_TIME_MIN_US, ADC5_CONV_TIME_MAX_US);
>> >> +	}
>> >> +
>> >> +	return -ETIMEDOUT;
>> >> +}
>> >> +
>> >> +static void adc5_update_dig_param(struct adc5_chip *adc,
>> >> +			struct adc5_channel_prop *prop, u8 *data)
>> >> +{
>> >> +	/* Update calibration value */
>> >> +	*data &= ~ADC5_USR_DIG_PARAM_CAL_VAL;
>> >> +	*data |= (prop->cal_val << ADC5_USR_DIG_PARAM_CAL_VAL_SHIFT);
>> >> +
>> >> +	/* Update calibration select */
>> >> +	*data &= ~ADC5_USR_DIG_PARAM_CAL_SEL;
>> >> +	*data |= (prop->cal_method << ADC5_USR_DIG_PARAM_CAL_SEL_SHIFT);
>> >> +
>> >> +	/* Update decimation ratio select */
>> >> +	*data &= ~ADC5_USR_DIG_PARAM_DEC_RATIO_SEL;
>> >> +	*data |= (prop->decimation <<
>> >> ADC5_USR_DIG_PARAM_DEC_RATIO_SEL_SHIFT);
>> >> +}
>> >> +
>> >> +static int adc5_configure(struct adc5_chip *adc,
>> >> +			struct adc5_channel_prop *prop)
>> >> +{
>> >> +	int ret;
>> >> +	u8 buf[6];
>> >> +
>> >> +	/* Read registers 0x42 through 0x46 */
>> >> +	ret = adc5_read(adc, ADC5_USR_DIG_PARAM, buf, 6);
>> >> +	if (ret < 0)
>> >> +		return ret;
>> >> +
>> >> +	/* Digital param selection */
>> >> +	adc5_update_dig_param(adc, prop, &buf[0]);
>> >> +
>> >> +	/* Update fast average sample value */
>> >> +	buf[1] &= (u8) ~ADC5_USR_FAST_AVG_CTL_SAMPLES_MASK;
>> >> +	buf[1] |= prop->avg_samples;
>> >> +
>> >> +	/* Select ADC channel */
>> >> +	buf[2] = prop->channel;
>> >> +
>> >> +	/* Select HW settle delay for channel */
>> >> +	buf[3] &= (u8) ~ADC5_USR_HW_SETTLE_DELAY_MASK;
>> >> +	buf[3] |= prop->hw_settle_time;
>> >> +
>> >> +	/* Select ADC enable */
>> >> +	buf[4] |= ADC5_USR_EN_CTL1_ADC_EN;
>> >> +
>> >> +	/* Select CONV request */
>> >> +	buf[5] |= ADC5_USR_CONV_REQ_REQ;
>> >> +
>> >> +	if (!adc->poll_eoc)
>> >> +		reinit_completion(&adc->complete);
>> >> +
>> >> +	return adc5_write(adc, ADC5_USR_DIG_PARAM, buf, 6);
>> >> +}
>> >> +
>> >> +static int adc5_do_conversion(struct adc5_chip *adc,
>> >> +			struct adc5_channel_prop *prop,
>> >> +			struct iio_chan_spec const *chan,
>> >> +			u16 *data_volt, u16 *data_cur)
>> >> +{
>> >> +	int ret;
>> >> +
>> >> +	mutex_lock(&adc->lock);
>> >> +
>> >> +	ret = adc5_configure(adc, prop);
>> >> +	if (ret) {
>> >> +		pr_err("ADC configure failed with %d\n", ret);
>> >> +		goto unlock;
>> >> +	}
>> >> +
>> >> +	if (adc->poll_eoc) {
>> >> +		ret = adc5_poll_wait_eoc(adc);
>> >> +		if (ret < 0) {
>> >> +			pr_err("EOC bit not set\n");
>> >> +			goto unlock;
>> >> +		}
>> >> +	} else {
>> >> +		ret = wait_for_completion_timeout(&adc->complete,
>> >> +							ADC5_CONV_TIMEOUT);
>> >> +		if (!ret) {
>> >> +			pr_debug("Did not get completion timeout.\n");
>> >> +			ret = adc5_poll_wait_eoc(adc);
>> >> +			if (ret < 0) {
>> >> +				pr_err("EOC bit not set\n");
>> >> +				goto unlock;
>> >> +			}
>> >> +		}
>> >> +	}
>> >> +
>> >> +	if ((chan->type == IIO_VOLTAGE) || (chan->type == IIO_TEMP))
>> >> +		ret = adc5_read_voltage_data(adc, data_volt);
>> >> +	else if (chan->type == IIO_POWER) {
>> >> +		ret = adc5_read_voltage_data(adc, data_volt);
>> >> +		if (ret)
>> >> +			goto unlock;
>> >> +
>> >> +		ret = adc5_read_current_data(adc, data_cur);
>> >> +	}
>> >> +unlock:
>> >> +	mutex_unlock(&adc->lock);
>> >> +
>> >> +	return ret;
>> >> +}
>> >> +
>> >> +static irqreturn_t adc5_isr(int irq, void *dev_id)
>> >> +{
>> >> +	struct adc5_chip *adc = dev_id;
>> >> +
>> >> +	complete(&adc->complete);
>> >> +
>> >> +	return IRQ_HANDLED;
>> >> +}
>> >> +
>> >> +static int adc5_of_xlate(struct iio_dev *indio_dev,
>> >> +				const struct of_phandle_args *iiospec)
>> >> +{
>> >> +	struct adc5_chip *adc = iio_priv(indio_dev);
>> >> +	int i;
>> >> +
>> >> +	for (i = 0; i < adc->nchannels; i++)
>> >> +		if (adc->chan_props[i].channel == iiospec->args[0])
>> >> +			return i;
>> >> +
>> >> +	return -EINVAL;
>> >> +}
>> >> +
>> >> +static int adc5_read_raw(struct iio_dev *indio_dev,
>> >> +			 struct iio_chan_spec const *chan, int *val, int *val2,
>> >> +			 long mask)
>> >> +{
>> >> +	struct adc5_chip *adc = iio_priv(indio_dev);
>> >> +	struct adc5_channel_prop *prop;
>> >> +	u16 adc_code_volt, adc_code_cur;
>> >> +	int ret;
>> >> +
>> >> +	prop = &adc->chan_props[chan->address];
>> >> +
>> >> +	switch (mask) {
>> >> +	case IIO_CHAN_INFO_PROCESSED:
>> >> +		ret = adc5_do_conversion(adc, prop, chan,
>> >> +				&adc_code_volt, &adc_code_cur);
>> >> +		if (ret)
>> >> +			break;
>> >> +
>> >> +		if ((chan->type == IIO_VOLTAGE) || (chan->type == IIO_TEMP))
>> >> +			ret = qcom_adc5_hw_scale(prop->scale_fn_type,
>> >> +				&adc5_prescale_ratios[prop->prescale],
>> >> +				adc->data,
>> >> +				adc_code_volt, val);
>> >> +		if (ret)
>> >> +			break;
>> >> +
>> >> +		if (chan->type == IIO_POWER) {
>> >> +			ret = qcom_adc5_hw_scale(SCALE_HW_CALIB_DEFAULT,
>> >> +				&adc5_prescale_ratios[ADC5_DEF_VBAT_PRESCALING],
>> >> +				adc->data,
>> >> +				adc_code_volt, val);
>> >> +			if (ret)
>> >> +				break;
>> >> +
>> >> +			ret = qcom_adc5_hw_scale(prop->scale_fn_type,
>> >> +				&adc5_prescale_ratios[prop->prescale],
>> >> +				adc->data,
>> >> +				adc_code_cur, val2);
>> >> +			if (ret)
>> >> +				break;
>> >> +		}
>> >> +
>> >> +		if (chan->type == IIO_POWER)
>> >> +			return IIO_VAL_INT_MULTIPLE;
>> >> +		else
>> >> +			return IIO_VAL_INT;
>> >> +	case IIO_CHAN_INFO_RAW:
>> >> +		ret = adc5_do_conversion(adc, prop, chan,
>> >> +				&adc_code_volt, &adc_code_cur);
>> >> +		if (ret)
>> >> +			break;
>> >> +
>> >> +		*val = (int)adc_code_volt;
>> >> +		*val2 = (int)adc_code_cur;
>> >> +		if (chan->type == IIO_POWER)
>> >> +			return IIO_VAL_INT_MULTIPLE;
>> >
>> > I guess I missed this before.  Why is this a multiple value set?
>> 
>> When querying the channels that support synchronous voltage and 
>> current
>> reads, this option provides a way to return both the results in one
>> query.
>> e.g.
>> #cat in_power_v_i_int_vbat_vdata_input
>> 3802422 101321
>> 
>> >
>> >> +		else
>> >> +			return IIO_VAL_INT;
>> >> +	default:
>> >> +		ret = -EINVAL;
>> >> +		break;
>> >> +	}
>> >> +
>> >> +	return ret;
>> >> +}
>> >> +
>> >> +static const struct iio_info adc5_info = {
>> >> +	.read_raw = adc5_read_raw,
>> >> +	.of_xlate = adc5_of_xlate,
>> >> +};
>> >> +
>> >> +struct adc_channels {
>> >> +	const char *datasheet_name;
>> >> +	unsigned int prescale_index;
>> >> +	enum iio_chan_type type;
>> >> +	long info_mask;
>> >> +	enum vadc_scale_fn_type scale_fn_type;
>> >> +};
>> >> +
>> >> +#define ADC5_CHAN(_dname, _type, _mask, _pre, _scale)			\
>> >> +	{								\
>> >> +		.datasheet_name = (_dname),				\
>> >> +		.prescale_index = _pre,					\
>> >> +		.type = _type,						\
>> >> +		.info_mask = _mask,					\
>> >> +		.scale_fn_type = _scale,				\
>> >> +	},								\
>> >> +
>> >> +#define ADC5_CHAN_TEMP(_dname, _pre, _scale)				\
>> >> +	ADC5_CHAN(_dname, IIO_TEMP,					\
>> >> +		BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_PROCESSED),	\
>> >> +		_pre, _scale)						\
>> >> +
>> >> +#define ADC5_CHAN_VOLT(_dname, _pre, _scale)				\
>> >> +	ADC5_CHAN(_dname, IIO_VOLTAGE,					\
>> >> +		  BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_PROCESSED),\
>> >> +		  _pre, _scale)						\
>> >> +
>> >> +#define ADC5_CHAN_POWER(_dname, _pre, _scale)				\
>> >> +	ADC5_CHAN(_dname, IIO_POWER,					\
>> >> +		  BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_PROCESSED),\
>> >> +		  _pre, _scale)						\
>> >> +
>> >> +static const struct adc_channels adc_chans_pmic5[ADC5_MAX_CHANNEL] =
>> >> {
>> >> +	[ADC5_REF_GND]		= ADC5_CHAN_VOLT("ref_gnd", 1,
>> >> +					SCALE_HW_CALIB_DEFAULT)
>> >> +	[ADC5_1P25VREF]		= ADC5_CHAN_VOLT("vref_1p25", 1,
>> >> +					SCALE_HW_CALIB_DEFAULT)
>> >> +	[ADC5_VPH_PWR]		= ADC5_CHAN_VOLT("vph_pwr", 3,
>> >> +					SCALE_HW_CALIB_DEFAULT)
>> >> +	[ADC5_VBAT_SNS]		= ADC5_CHAN_VOLT("vbat_sns", 3,
>> >> +					SCALE_HW_CALIB_DEFAULT)
>> >> +	[ADC5_DIE_TEMP]		= ADC5_CHAN_TEMP("die_temp", 1,
>> >> +					SCALE_HW_CALIB_PMIC_THERM)
>> >> +	[ADC5_USB_IN_I]		= ADC5_CHAN_VOLT("usb_in_i_uv", 1,
>> >> +					SCALE_HW_CALIB_DEFAULT)
>> >> +	[ADC5_USB_IN_V_16]	= ADC5_CHAN_VOLT("usb_in_v_div_16", 16,
>> >> +					SCALE_HW_CALIB_DEFAULT)
>> >> +	[ADC5_CHG_TEMP]		= ADC5_CHAN_TEMP("chg_temp", 1,
>> >> +					SCALE_HW_CALIB_PM5_CHG_TEMP)
>> >> +	/* Charger prescales SBUx and MID_CHG to fit within 1.8V upper unit
>> >> */
>> >> +	[ADC5_SBUx]		= ADC5_CHAN_VOLT("chg_sbux", 3,
>> >> +					SCALE_HW_CALIB_DEFAULT)
>> >> +	[ADC5_MID_CHG_DIV6]	= ADC5_CHAN_VOLT("chg_mid_chg", 6,
>> >> +					SCALE_HW_CALIB_DEFAULT)
>> >> +	[ADC5_XO_THERM_100K_PU]	= ADC5_CHAN_TEMP("xo_therm", 1,
>> >> +					SCALE_HW_CALIB_XOTHERM)
>> >> +	[ADC5_AMUX_THM1_100K_PU] = ADC5_CHAN_TEMP("amux_thm1_100k_pu", 1,
>> >> +					SCALE_HW_CALIB_THERM_100K_PULLUP)
>> >> +	[ADC5_AMUX_THM2_100K_PU] = ADC5_CHAN_TEMP("amux_thm2_100k_pu", 1,
>> >> +					SCALE_HW_CALIB_THERM_100K_PULLUP)
>> >> +	[ADC5_AMUX_THM3_100K_PU] = ADC5_CHAN_TEMP("amux_thm3_100k_pu", 1,
>> >> +					SCALE_HW_CALIB_THERM_100K_PULLUP)
>> >> +	[ADC5_INT_EXT_ISENSE_VBAT_VDATA] = ADC5_CHAN_POWER("int_ext_isense",
>> >> 1,
>> >> +					SCALE_HW_CALIB_CUR)
>> >> +	[ADC5_EXT_ISENSE_VBAT_VDATA] = ADC5_CHAN_POWER("ext_isense", 1,
>> >> +					SCALE_HW_CALIB_CUR)
>> >> +	[ADC5_PARALLEL_ISENSE_VBAT_VDATA] =
>> >> +					ADC5_CHAN_POWER("parallel_isense", 1,
>> >> +					SCALE_HW_CALIB_CUR)
>> >> +	[ADC5_AMUX_THM2]	= ADC5_CHAN_TEMP("amux_thm2", 1,
>> >> +					SCALE_HW_CALIB_PM5_SMB_TEMP)
>> >> +};
>> >> +
>> >> +static const struct adc_channels adc_chans_rev2[ADC5_MAX_CHANNEL] = {
>> >> +	[ADC5_REF_GND]		= ADC5_CHAN_VOLT("ref_gnd", 1,
>> >> +					SCALE_HW_CALIB_DEFAULT)
>> >> +	[ADC5_1P25VREF]		= ADC5_CHAN_VOLT("vref_1p25", 1,
>> >> +					SCALE_HW_CALIB_DEFAULT)
>> >> +	[ADC5_VPH_PWR]		= ADC5_CHAN_VOLT("vph_pwr", 3,
>> >> +					SCALE_HW_CALIB_DEFAULT)
>> >> +	[ADC5_VBAT_SNS]		= ADC5_CHAN_VOLT("vbat_sns", 3,
>> >> +					SCALE_HW_CALIB_DEFAULT)
>> >> +	[ADC5_VCOIN]		= ADC5_CHAN_VOLT("vcoin", 3,
>> >> +					SCALE_HW_CALIB_DEFAULT)
>> >> +	[ADC5_DIE_TEMP]		= ADC5_CHAN_TEMP("die_temp", 1,
>> >> +					SCALE_HW_CALIB_PMIC_THERM)
>> >> +	[ADC5_AMUX_THM1_100K_PU] = ADC5_CHAN_TEMP("amux_thm1_100k_pu", 1,
>> >> +					SCALE_HW_CALIB_THERM_100K_PULLUP)
>> >> +	[ADC5_AMUX_THM3_100K_PU] = ADC5_CHAN_TEMP("amux_thm3_100k_pu", 1,
>> >> +					SCALE_HW_CALIB_THERM_100K_PULLUP)
>> >> +	[ADC5_AMUX_THM5_100K_PU] = ADC5_CHAN_TEMP("amux_thm5_100k_pu", 1,
>> >> +					SCALE_HW_CALIB_THERM_100K_PULLUP)
>> >> +	[ADC5_XO_THERM_100K_PU]	= ADC5_CHAN_TEMP("xo_therm_100k_pu", 1,
>> >> +					SCALE_HW_CALIB_THERM_100K_PULLUP)
>> >> +};
>> >> +
>> >> +static int adc5_get_dt_channel_data(struct adc5_chip *adc,
>> >> +				    struct adc5_channel_prop *prop,
>> >> +				    struct device_node *node,
>> >> +				    const struct adc_data *data)
>> >> +{
>> >> +	const char *name = node->name, *channel_name;
>> >> +	u32 chan, value, varr[2];
>> >> +	int ret;
>> >> +	struct device *dev = adc->dev;
>> >> +
>> >> +	ret = of_property_read_u32(node, "reg", &chan);
>> >> +	if (ret) {
>> >> +		dev_err(dev, "invalid channel number %s\n", name);
>> >> +		return ret;
>> >> +	}
>> >> +
>> >> +	if (chan > ADC5_PARALLEL_ISENSE_VBAT_IDATA) {
>> >> +		dev_err(dev, "%s invalid channel number %d\n", name, chan);
>> >> +		return -EINVAL;
>> >> +	}
>> >> +
>> >> +	/* the channel has DT description */
>> >> +	prop->channel = chan;
>> >> +
>> >> +	channel_name = of_get_property(node,
>> >> +				"label", NULL) ? : node->name;
>> >> +	if (!channel_name) {
>> >> +		pr_err("Invalid channel name\n");
>> >> +		return -EINVAL;
>> >> +	}
>> >> +	prop->datasheet_name = channel_name;
>> >> +
>> >> +	ret = of_property_read_u32(node, "qcom,decimation", &value);
>> >> +	if (!ret) {
>> >> +		ret = adc5_decimation_from_dt(value, data->decimation);
>> >> +		if (ret < 0) {
>> >> +			dev_err(dev, "%02x invalid decimation %d\n",
>> >> +				chan, value);
>> >> +			return ret;
>> >> +		}
>> >> +		prop->decimation = ret;
>> >> +	} else {
>> >> +		prop->decimation = ADC5_DECIMATION_DEFAULT;
>> >> +	}
>> >> +
>> >> +	ret = of_property_read_u32_array(node, "qcom,pre-scaling", varr, 2);
>> >> +	if (!ret) {
>> >> +		ret = adc5_prescaling_from_dt(varr[0], varr[1]);
>> >> +		if (ret < 0) {
>> >> +			dev_err(dev, "%02x invalid pre-scaling <%d %d>\n",
>> >> +				chan, varr[0], varr[1]);
>> >> +			return ret;
>> >> +		}
>> >> +		prop->prescale = ret;
>> >> +	}
>> >> +
>> >> +	ret = of_property_read_u32(node, "qcom,hw-settle-time", &value);
>> >> +	if (!ret) {
>> >> +		u8 dig_version[2];
>> >> +
>> >> +		ret = adc5_get_dig_version(adc, dig_version);
>> >> +		if (ret < 0) {
>> >> +			dev_err(dev, "Invalid dig version read %d\n", ret);
>> >> +			return ret;
>> >> +		}
>> >> +
>> >> +		pr_debug("dig_ver:minor:%d, major:%d\n", dig_version[0],
>> >> +						dig_version[1]);
>> >> +		/* Digital controller >= 5.3 have hw_settle_2 option */
>> >> +		if (dig_version[0] >= ADC5_HW_SETTLE_DIFF_MINOR &&
>> >> +			dig_version[1] >= ADC5_HW_SETTLE_DIFF_MAJOR)
>> >> +			ret = adc5_hw_settle_time_from_dt(value,
>> >> +							data->hw_settle_2);
>> >> +		else
>> >> +			ret = adc5_hw_settle_time_from_dt(value,
>> >> +							data->hw_settle_1);
>> >> +
>> >> +		if (ret < 0) {
>> >> +			dev_err(dev, "%02x invalid hw-settle-time %d us\n",
>> >> +				chan, value);
>> >> +			return ret;
>> >> +		}
>> >> +		prop->hw_settle_time = ret;
>> >> +	} else {
>> >> +		prop->hw_settle_time = VADC_DEF_HW_SETTLE_TIME;
>> >> +	}
>> >> +
>> >> +	ret = of_property_read_u32(node, "qcom,avg-samples", &value);
>> >> +	if (!ret) {
>> >> +		ret = adc5_avg_samples_from_dt(value);
>> >> +		if (ret < 0) {
>> >> +			dev_err(dev, "%02x invalid avg-samples %d\n",
>> >> +				chan, value);
>> >> +			return ret;
>> >> +		}
>> >> +		prop->avg_samples = ret;
>> >> +	} else {
>> >> +		prop->avg_samples = VADC_DEF_AVG_SAMPLES;
>> >> +	}
>> >> +
>> >> +	if (of_property_read_bool(node, "qcom,ratiometric"))
>> >> +		prop->cal_method = ADC5_RATIOMETRIC_CAL;
>> >> +	else
>> >> +		prop->cal_method = ADC5_ABSOLUTE_CAL;
>> >> +
>> >> +	/*
>> >> +	 * Default to using timer calibration. Using a fresh calibration
>> >> value
>> >> +	 * for every conversion will increase the overall time for a
>> >> request.
>> >> +	 */
>> >> +	prop->cal_val = ADC5_TIMER_CAL;
>> >> +
>> >> +	dev_dbg(dev, "%02x name %s\n", chan, name);
>> >> +
>> >> +	return 0;
>> >> +}
>> >> +
>> >> +const struct adc_data data_pmic5 = {
>> >> +	.full_scale_code_volt = 0x70e4,
>> >> +	.full_scale_code_cur = 0x2710,
>> >> +	.adc_chans = adc_chans_pmic5,
>> >> +	.decimation = (unsigned int [ADC5_DECIMATION_SAMPLES_MAX])
>> >> +				{250, 420, 840},
>> >> +	.hw_settle_1 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
>> >> +				{15, 100, 200, 300, 400, 500, 600, 700,
>> >> +				800, 900, 1, 2, 4, 6, 8, 10},
>> >> +	.hw_settle_2 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
>> >> +				{15, 100, 200, 300, 400, 500, 600, 700,
>> >> +				1, 2, 4, 8, 16, 32, 64, 128},
>> >> +};
>> >> +
>> >> +const struct adc_data data_pmic_rev2 = {
>> >> +	.full_scale_code_volt = 0x4000,
>> >> +	.full_scale_code_cur = 0x1800,
>> >> +	.adc_chans = adc_chans_rev2,
>> >> +	.decimation = (unsigned int [ADC5_DECIMATION_SAMPLES_MAX])
>> >> +				{256, 512, 1024},
>> >> +	.hw_settle_1 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
>> >> +				{0, 100, 200, 300, 400, 500, 600, 700,
>> >> +				800, 900, 1, 2, 4, 6, 8, 10},
>> >> +	.hw_settle_2 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
>> >> +				{15, 100, 200, 300, 400, 500, 600, 700,
>> >> +				1, 2, 4, 8, 16, 32, 64, 128},
>> >> +};
>> >> +
>> >> +static const struct of_device_id adc5_match_table[] = {
>> >> +	{
>> >> +		.compatible = "qcom,spmi-adc5",
>> >> +		.data = &data_pmic5,
>> >> +	},
>> >> +	{
>> >> +		.compatible = "qcom,spmi-adc-rev2",
>> >> +		.data = &data_pmic_rev2,
>> >> +	},
>> >> +	{ }
>> >> +};
>> >> +
>> >> +static int adc5_get_dt_data(struct adc5_chip *adc, struct device_node
>> >> *node)
>> >> +{
>> >> +	const struct adc_channels *adc_chan;
>> >> +	struct iio_chan_spec *iio_chan;
>> >> +	struct adc5_channel_prop prop;
>> >> +	struct device_node *child;
>> >> +	unsigned int index = 0;
>> >> +	const struct of_device_id *id;
>> >> +	const struct adc_data *data;
>> >> +	int ret;
>> >> +
>> >> +	adc->nchannels = of_get_available_child_count(node);
>> >> +	if (!adc->nchannels)
>> >> +		return -EINVAL;
>> >> +
>> >> +	adc->iio_chans = devm_kcalloc(adc->dev, adc->nchannels,
>> >> +				       sizeof(*adc->iio_chans), GFP_KERNEL);
>> >> +	if (!adc->iio_chans)
>> >> +		return -ENOMEM;
>> >> +
>> >> +	adc->chan_props = devm_kcalloc(adc->dev, adc->nchannels,
>> >> +					sizeof(*adc->chan_props), GFP_KERNEL);
>> >> +	if (!adc->chan_props)
>> >> +		return -ENOMEM;
>> >> +
>> >> +	iio_chan = adc->iio_chans;
>> >> +	id = of_match_node(adc5_match_table, node);
>> >> +	if (id)
>> >> +		data = id->data;
>> >> +	else
>> >> +		data = &data_pmic5;
>> >> +	adc->data = data;
>> >> +
>> >> +	for_each_available_child_of_node(node, child) {
>> >> +		ret = adc5_get_dt_channel_data(adc, &prop, child, data);
>> >> +		if (ret) {
>> >> +			of_node_put(child);
>> >> +			return ret;
>> >> +		}
>> >> +
>> >> +		prop.scale_fn_type =
>> >> +			data->adc_chans[prop.channel].scale_fn_type;
>> >> +		adc->chan_props = &prop;
>> >> +		adc_chan = &data->adc_chans[prop.channel];
>> >> +
>> >> +		iio_chan->channel = prop.channel;
>> >> +		iio_chan->datasheet_name = prop.datasheet_name;
>> >> +		iio_chan->extend_name = prop.datasheet_name;
>> >> +		iio_chan->info_mask_separate = adc_chan->info_mask;
>> >> +		iio_chan->type = adc_chan->type;
>> >> +		iio_chan->address = index;
>> >> +		iio_chan++;
>> >> +		adc->chan_props++;
>> >> +		index++;
>> >> +	}
>> >> +
>> >> +	return 0;
>> >> +}
>> >> +
>> >> +static int adc5_probe(struct platform_device *pdev)
>> >> +{
>> >> +	struct device_node *node = pdev->dev.of_node;
>> >> +	struct device *dev = &pdev->dev;
>> >> +	struct iio_dev *indio_dev;
>> >> +	struct adc5_chip *adc;
>> >> +	struct regmap *regmap;
>> >> +	int ret, irq_eoc;
>> >> +	u32 reg;
>> >> +
>> >> +	regmap = dev_get_regmap(dev->parent, NULL);
>> >> +	if (!regmap)
>> >> +		return -ENODEV;
>> >> +
>> >> +	ret = of_property_read_u32(node, "reg", &reg);
>> >> +	if (ret < 0)
>> >> +		return ret;
>> >> +
>> >> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
>> >> +	if (!indio_dev)
>> >> +		return -ENOMEM;
>> >> +
>> >> +	adc = iio_priv(indio_dev);
>> >> +	adc->regmap = regmap;
>> >> +	adc->dev = dev;
>> >> +	adc->base = reg;
>> >> +	init_completion(&adc->complete);
>> >> +	mutex_init(&adc->lock);
>> >> +
>> >> +	ret = adc5_get_dt_data(adc, node);
>> >> +	if (ret) {
>> >> +		pr_err("adc get dt data failed\n");
>> >> +		return ret;
>> >> +	}
>> >> +
>> >> +	irq_eoc = platform_get_irq(pdev, 0);
>> >> +	if (irq_eoc < 0) {
>> >> +		if (irq_eoc == -EPROBE_DEFER || irq_eoc == -EINVAL)
>> >> +			return irq_eoc;
>> >> +		adc->poll_eoc = true;
>> >> +	} else {
>> >> +		ret = devm_request_irq(dev, irq_eoc, adc5_isr, 0,
>> >> +				       "pm-adc5", adc);
>> >> +		if (ret)
>> >> +			return ret;
>> >> +	}
>> >> +
>> >> +	indio_dev->dev.parent = dev;
>> >> +	indio_dev->dev.of_node = node;
>> >> +	indio_dev->name = pdev->name;
>> >> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> >> +	indio_dev->info = &adc5_info;
>> >> +	indio_dev->channels = adc->iio_chans;
>> >> +	indio_dev->num_channels = adc->nchannels;
>> >> +
>> >> +	return devm_iio_device_register(dev, indio_dev);
>> >> +}
>> >> +
>> >> +static struct platform_driver adc5_driver = {
>> >> +	.driver = {
>> >> +		.name = "qcom-spmi-adc5.c",
>> >> +		.of_match_table = adc5_match_table,
>> >> +	},
>> >> +	.probe = adc5_probe,
>> >> +};
>> >> +module_platform_driver(adc5_driver);
>> >> +
>> >> +MODULE_ALIAS("platform:qcom-spmi-adc5");
>> >> +MODULE_DESCRIPTION("Qualcomm Technologies Inc. PMIC5 ADC driver");
>> >> +MODULE_LICENSE("GPL v2");
>> >> diff --git a/drivers/iio/adc/qcom-vadc-common.c
>> >> b/drivers/iio/adc/qcom-vadc-common.c
>> >> index fe3d782..e430f6e 100644
>> >> --- a/drivers/iio/adc/qcom-vadc-common.c
>> >> +++ b/drivers/iio/adc/qcom-vadc-common.c
>> >> @@ -47,8 +47,85 @@
>> >>  	{44,	125}
>> >>  };
>> >>
>> >> +/*
>> >> + * Voltage to temperature table for 100k pull up for NTCG104EF104
>> >> with
>> >> + * 1.875V reference.
>> >> + */
>> >> +static const struct vadc_map_pt adcmap_100k_104ef_104fb_1875_vref[] =
>> >> {
>> >> +	{ 1831,	-40000 },
>> >> +	{ 1814,	-35000 },
>> >> +	{ 1791,	-30000 },
>> >> +	{ 1761,	-25000 },
>> >> +	{ 1723,	-20000 },
>> >> +	{ 1675,	-15000 },
>> >> +	{ 1616,	-10000 },
>> >> +	{ 1545,	-5000 },
>> >> +	{ 1463,	0 },
>> >> +	{ 1370,	5000 },
>> >> +	{ 1268,	10000 },
>> >> +	{ 1160,	15000 },
>> >> +	{ 1049,	20000 },
>> >> +	{ 937,	25000 },
>> >> +	{ 828,	30000 },
>> >> +	{ 726,	35000 },
>> >> +	{ 630,	40000 },
>> >> +	{ 544,	45000 },
>> >> +	{ 467,	50000 },
>> >> +	{ 399,	55000 },
>> >> +	{ 340,	60000 },
>> >> +	{ 290,	65000 },
>> >> +	{ 247,	70000 },
>> >> +	{ 209,	75000 },
>> >> +	{ 179,	80000 },
>> >> +	{ 153,	85000 },
>> >> +	{ 130,	90000 },
>> >> +	{ 112,	95000 },
>> >> +	{ 96,	100000 },
>> >> +	{ 82,	105000 },
>> >> +	{ 71,	110000 },
>> >> +	{ 62,	115000 },
>> >> +	{ 53,	120000 },
>> >> +	{ 46,	125000 },
>> >> +};
>> >> +
>> >> +static int qcom_vadc_scale_hw_calib_volt(
>> >> +				const struct vadc_prescale_ratio *prescale,
>> >> +				const struct adc_data *data,
>> >> +				u16 adc_code, int *result_uv);
>> >> +static int qcom_vadc_scale_hw_calib_therm(
>> >> +				const struct vadc_prescale_ratio *prescale,
>> >> +				const struct adc_data *data,
>> >> +				u16 adc_code, int *result_mdec);
>> >> +static int qcom_vadc_scale_hw_smb_temp(
>> >> +				const struct vadc_prescale_ratio *prescale,
>> >> +				const struct adc_data *data,
>> >> +				u16 adc_code, int *result_mdec);
>> >> +static int qcom_vadc_scale_hw_chg5_temp(
>> >> +				const struct vadc_prescale_ratio *prescale,
>> >> +				const struct adc_data *data,
>> >> +				u16 adc_code, int *result_mdec);
>> >> +static int qcom_vadc_scale_hw_calib_die_temp(
>> >> +				const struct vadc_prescale_ratio *prescale,
>> >> +				const struct adc_data *data,
>> >> +				u16 adc_code, int *result_mdec);
>> >> +static int qcom_adc_scale_hw_calib_cur(
>> >> +				const struct vadc_prescale_ratio *prescale,
>> >> +				const struct adc_data *data,
>> >> +				u16 adc_code, int *result_uamps);
>> >> +
>> >> +
>> >> +static struct qcom_adc5_scale_type scale_adc5_fn[] = {
>> >> +	[SCALE_HW_CALIB_DEFAULT] = {qcom_vadc_scale_hw_calib_volt},
>> >> +	[SCALE_HW_CALIB_THERM_100K_PULLUP] =
>> >> {qcom_vadc_scale_hw_calib_therm},
>> >> +	[SCALE_HW_CALIB_XOTHERM] = {qcom_vadc_scale_hw_calib_therm},
>> >> +	[SCALE_HW_CALIB_PMIC_THERM] = {qcom_vadc_scale_hw_calib_die_temp},
>> >> +	[SCALE_HW_CALIB_PM5_CHG_TEMP] = {qcom_vadc_scale_hw_chg5_temp},
>> >> +	[SCALE_HW_CALIB_PM5_SMB_TEMP] = {qcom_vadc_scale_hw_smb_temp},
>> >> +	[SCALE_HW_CALIB_CUR] = {qcom_adc_scale_hw_calib_cur},
>> >> +};
>> >> +
>> >>  static int qcom_vadc_map_voltage_temp(const struct vadc_map_pt *pts,
>> >> -				      u32 tablesize, s32 input, s64 *output)
>> >> +				      u32 tablesize, s32 input, int *output)
>> >>  {
>> >>  	bool descending = 1;
>> >>  	u32 i = 0;
>> >> @@ -128,7 +205,7 @@ static int qcom_vadc_scale_therm(const struct
>> >> vadc_linear_graph *calib_graph,
>> >>  				 bool absolute, u16 adc_code,
>> >>  				 int *result_mdec)
>> >>  {
>> >> -	s64 voltage = 0, result = 0;
>> >> +	s64 voltage = 0;
>> >>  	int ret;
>> >>
>> >>  	qcom_vadc_scale_calib(calib_graph, adc_code, absolute, &voltage);
>> >> @@ -138,12 +215,11 @@ static int qcom_vadc_scale_therm(const struct
>> >> vadc_linear_graph *calib_graph,
>> >>
>> >>  	ret = qcom_vadc_map_voltage_temp(adcmap_100k_104ef_104fb,
>> >>  					 ARRAY_SIZE(adcmap_100k_104ef_104fb),
>> >> -					 voltage, &result);
>> >> +					 voltage, result_mdec);
>> >>  	if (ret)
>> >>  		return ret;
>> >>
>> >> -	result *= 1000;
>> >> -	*result_mdec = result;
>> >> +	*result_mdec *= 1000;
>> >>
>> >>  	return 0;
>> >>  }
>> >> @@ -191,6 +267,134 @@ static int qcom_vadc_scale_chg_temp(const struct
>> >> vadc_linear_graph *calib_graph,
>> >>  	return 0;
>> >>  }
>> >>
>> >> +static int qcom_vadc_scale_code_voltage_factor(u16 adc_code,
>> >> +				const struct vadc_prescale_ratio *prescale,
>> >> +				const struct adc_data *data,
>> >> +				unsigned int factor)
>> >> +{
>> >> +	s64 voltage, temp, adc_vdd_ref_mv = 1875;
>> >> +
>> >> +	/*
>> >> +	 * The normal data range is between 0V to 1.875V. On cases where
>> >> +	 * we read low voltage values, the ADC code can go beyond the
>> >> +	 * range and the scale result is incorrect so we clamp the values
>> >> +	 * for the cases where the code represents a value below 0V
>> >> +	 */
>> >> +	if (adc_code > VADC5_MAX_CODE)
>> >> +		adc_code = 0;
>> >> +
>> >> +	/* (ADC code * vref_vadc (1.875V)) / full_scale_code */
>> >> +	voltage = (s64) adc_code * adc_vdd_ref_mv * 1000;
>> >> +	voltage = div64_s64(voltage, data->full_scale_code_volt);
>> >> +	if (voltage > 0) {
>> >> +		voltage *= prescale->den;
>> >> +		temp = prescale->num * factor;
>> >> +		voltage = div64_s64(voltage, temp);
>> >> +	} else {
>> >> +		voltage = 0;
>> >> +	}
>> >> +
>> >> +	return (int) voltage;
>> >> +}
>> >> +
>> >> +static int qcom_vadc_scale_hw_calib_volt(
>> >> +				const struct vadc_prescale_ratio *prescale,
>> >> +				const struct adc_data *data,
>> >> +				u16 adc_code, int *result_uv)
>> >> +{
>> >> +	*result_uv = qcom_vadc_scale_code_voltage_factor(adc_code,
>> >> +				prescale, data, 1);
>> >> +
>> >> +	return 0;
>> >> +}
>> >> +
>> >> +static int qcom_vadc_scale_hw_calib_therm(
>> >> +				const struct vadc_prescale_ratio *prescale,
>> >> +				const struct adc_data *data,
>> >> +				u16 adc_code, int *result_mdec)
>> >> +{
>> >> +	int ret, voltage;
>> >> +
>> >> +	voltage = qcom_vadc_scale_code_voltage_factor(adc_code,
>> >> +				prescale, data, 1000);
>> >> +
>> >> +	/* Map voltage to temperature from look-up table */
>> >> +	ret = qcom_vadc_map_voltage_temp(adcmap_100k_104ef_104fb_1875_vref,
>> >> +				 ARRAY_SIZE(adcmap_100k_104ef_104fb_1875_vref),
>> >> +				 voltage, result_mdec);
>> >
>> > return qcom_vadc_map_voltage...
>> 
>> Ok.
>> 
>> >
>> >> +	if (ret)
>> >> +		return ret;
>> >> +
>> >> +	return 0;
>> >> +}
>> >> +
>> >> +static int qcom_vadc_scale_hw_calib_die_temp(
>> >> +				const struct vadc_prescale_ratio *prescale,
>> >> +				const struct adc_data *data,
>> >> +				u16 adc_code, int *result_mdec)
>> >> +{
>> >> +	*result_mdec = qcom_vadc_scale_code_voltage_factor(adc_code,
>> >> +				prescale, data, 2);
>> >> +	*result_mdec -= KELVINMIL_CELSIUSMIL;
>> >> +
>> >> +	return 0;
>> >> +}
>> >> +
>> >> +static int qcom_vadc_scale_hw_smb_temp(
>> >> +				const struct vadc_prescale_ratio *prescale,
>> >> +				const struct adc_data *data,
>> >> +				u16 adc_code, int *result_mdec)
>> >> +{
>> >> +	*result_mdec = qcom_vadc_scale_code_voltage_factor(adc_code * 100,
>> >> +				prescale, data, PMIC5_SMB_TEMP_SCALE_FACTOR);
>> >> +	*result_mdec = PMIC5_SMB_TEMP_CONSTANT - *result_mdec;
>> >> +
>> >> +	return 0;
>> >> +}
>> >> +
>> >> +static int qcom_vadc_scale_hw_chg5_temp(
>> >> +				const struct vadc_prescale_ratio *prescale,
>> >> +				const struct adc_data *data,
>> >> +				u16 adc_code, int *result_mdec)
>> >> +{
>> >> +	*result_mdec = qcom_vadc_scale_code_voltage_factor(adc_code,
>> >> +				prescale, data, 4);
>> >> +	*result_mdec = PMIC5_CHG_TEMP_SCALE_FACTOR - *result_mdec;
>> >> +
>> >> +	return 0;
>> >> +}
>> >> +
>> >> +static int qcom_adc_scale_hw_calib_cur(
>> >> +				const struct vadc_prescale_ratio *prescale,
>> >> +				const struct adc_data *data,
>> >> +				u16 adc_code, int *result_uamps)
>> >> +{
>> >> +	s64 voltage;
>> >> +
>> >> +	/*
>> >> +	 * The measurement data is provided in 2's complement format
>> >> +	 * with the polarity convention as positive current (current
>> >> +	 * going out of the battery) and negative current
>> >> +	 * (current going into the battery).
>> >> +	 *
>> >> +	 * If MSB is set, convert the negative number to decimal,
>> >> +	 * apply scaling factor and place negative sign in front
>> >> +	 * of the final result.
>> >> +	 */
>> >> +	if (adc_code & ADC5_USR_DATA_CHECK)
>> >> +		adc_code = ~adc_code + 1;
>> >> +
>> >> +	voltage = (s64) adc_code * data->full_scale_code_cur * 1000;
>> >> +	voltage = div64_s64(voltage, VADC5_MAX_CODE);
>> >> +	voltage = voltage * prescale->den;
>> >> +	*result_uamps = (int) div64_s64(voltage, prescale->num);
>> >> +
>> >> +	if (adc_code & ADC5_USR_DATA_CHECK)
>> >> +		*result_uamps = -*result_uamps;
>> >> +
>> >> +	return 0;
>> >> +}
>> >> +
>> >>  int qcom_vadc_scale(enum vadc_scale_fn_type scaletype,
>> >>  		    const struct vadc_linear_graph *calib_graph,
>> >>  		    const struct vadc_prescale_ratio *prescale,
>> >> @@ -221,6 +425,22 @@ int qcom_vadc_scale(enum vadc_scale_fn_type
>> >> scaletype,
>> >>  }
>> >>  EXPORT_SYMBOL(qcom_vadc_scale);
>> >>
>> >> +int qcom_adc5_hw_scale(enum vadc_scale_fn_type scaletype,
>> >> +		    const struct vadc_prescale_ratio *prescale,
>> >> +		    const struct adc_data *data,
>> >> +		    u16 adc_code, int *result)
>> >> +{
>> >> +	if (!(scaletype >= SCALE_HW_CALIB_DEFAULT &&
>> >> +		scaletype < SCALE_HW_CALIB_INVALID)) {
>> >> +		pr_err("Invalid scale type %d\n", scaletype);
>> >> +		return -EINVAL;
>> >> +	}
>> >> +
>> >> +	return scale_adc5_fn[scaletype].scale_fn(prescale, data,
>> >> +					adc_code, result);
>> >> +}
>> >> +EXPORT_SYMBOL(qcom_adc5_hw_scale);
>> >> +
>> >>  int qcom_vadc_decimation_from_dt(u32 value)
>> >>  {
>> >>  	if (!is_power_of_2(value) || value < VADC_DECIMATION_MIN ||
>> >> diff --git a/drivers/iio/adc/qcom-vadc-common.h
>> >> b/drivers/iio/adc/qcom-vadc-common.h
>> >> index 1d5354f..1051720 100644
>> >> --- a/drivers/iio/adc/qcom-vadc-common.h
>> >> +++ b/drivers/iio/adc/qcom-vadc-common.h
>> >> @@ -25,15 +25,31 @@
>> >>
>> >>  #define VADC_DECIMATION_MIN			512
>> >>  #define VADC_DECIMATION_MAX			4096
>> >> +#define ADC5_DEF_VBAT_PRESCALING		1 /* 1:3 */
>> >> +#define ADC5_DECIMATION_SHORT			250
>> >> +#define ADC5_DECIMATION_MEDIUM			420
>> >> +#define ADC5_DECIMATION_LONG			840
>> >> +/* Default decimation - 1024 for rev2, 840 for pmic5 */
>> >> +#define ADC5_DECIMATION_DEFAULT			2
>> >> +#define ADC5_DECIMATION_SAMPLES_MAX		3
>> >>
>> >>  #define VADC_HW_SETTLE_DELAY_MAX		10000
>> >> +#define VADC_HW_SETTLE_SAMPLES_MAX		16
>> >>  #define VADC_AVG_SAMPLES_MAX			512
>> >> +#define ADC5_AVG_SAMPLES_MAX			16
>> >>
>> >>  #define KELVINMIL_CELSIUSMIL			273150
>> >> +#define PMIC5_CHG_TEMP_SCALE_FACTOR		377500
>> >> +#define PMIC5_SMB_TEMP_CONSTANT			419400
>> >> +#define PMIC5_SMB_TEMP_SCALE_FACTOR		356
>> >>
>> >>  #define PMI_CHG_SCALE_1				-138890
>> >>  #define PMI_CHG_SCALE_2				391750000000LL
>> >>
>> >> +#define VADC5_MAX_CODE				0x7fff
>> >> +#define ADC5_FULL_SCALE_CODE			0x70e4
>> >> +#define ADC5_USR_DATA_CHECK			0x8000
>> >> +
>> >>  /**
>> >>   * struct vadc_map_pt - Map the graph representation for ADC channel
>> >>   * @x: Represent the ADC digitized code.
>> >> @@ -89,6 +105,19 @@ struct vadc_prescale_ratio {
>> >>   * SCALE_PMIC_THERM: Returns result in milli degree's Centigrade.
>> >>   * SCALE_XOTHERM: Returns XO thermistor voltage in millidegC.
>> >>   * SCALE_PMI_CHG_TEMP: Conversion for PMI CHG temp
>> >> + * SCALE_HW_CALIB_DEFAULT: Default scaling to convert raw adc code to
>> >> + *	voltage (uV) with hardware applied offset/slope values to adc
>> >> code.
>> >> + * SCALE_HW_CALIB_THERM_100K_PULLUP: Returns temperature in millidegC
>> >> using
>> >> + *	lookup table. The hardware applies offset/slope to adc code.
>> >> + * SCALE_HW_CALIB_XOTHERM: Returns XO thermistor voltage in millidegC
>> >> using
>> >> + *	100k pullup. The hardware applies offset/slope to adc code.
>> >> + * SCALE_HW_CALIB_PMIC_THERM: Returns result in milli degree's
>> >> Centigrade.
>> >> + *	The hardware applies offset/slope to adc code.
>> >> + * SCALE_HW_CALIB_CUR: Returns result in uA for PMIC5.
>> >> + * SCALE_HW_CALIB_PM5_CHG_TEMP: Returns result in millidegrees for
>> >> PMIC5
>> >> + *	charger temperature.
>> >> + * SCALE_HW_CALIB_PM5_SMB_TEMP: Returns result in millidegrees for
>> >> PMIC5
>> >> + *	SMB1390 temperature.
>> >>   */
>> >>  enum vadc_scale_fn_type {
>> >>  	SCALE_DEFAULT = 0,
>> >> @@ -96,6 +125,23 @@ enum vadc_scale_fn_type {
>> >>  	SCALE_PMIC_THERM,
>> >>  	SCALE_XOTHERM,
>> >>  	SCALE_PMI_CHG_TEMP,
>> >> +	SCALE_HW_CALIB_DEFAULT,
>> >> +	SCALE_HW_CALIB_THERM_100K_PULLUP,
>> >> +	SCALE_HW_CALIB_XOTHERM,
>> >> +	SCALE_HW_CALIB_PMIC_THERM,
>> >> +	SCALE_HW_CALIB_CUR,
>> >> +	SCALE_HW_CALIB_PM5_CHG_TEMP,
>> >> +	SCALE_HW_CALIB_PM5_SMB_TEMP,
>> >> +	SCALE_HW_CALIB_INVALID,
>> >> +};
>> >> +
>> >> +struct adc_data {
>> >> +	const u32	full_scale_code_volt;
>> >> +	const u32	full_scale_code_cur;
>> >> +	const struct adc_channels *adc_chans;
>> >> +	unsigned int	*decimation;
>> >> +	unsigned int	*hw_settle_1;
>> >> +	unsigned int	*hw_settle_2;
>> >>  };
>> >>
>> >>  int qcom_vadc_scale(enum vadc_scale_fn_type scaletype,
>> >> @@ -104,6 +150,16 @@ int qcom_vadc_scale(enum vadc_scale_fn_type
>> >> scaletype,
>> >>  		    bool absolute,
>> >>  		    u16 adc_code, int *result_mdec);
>> >>
>> >> +struct qcom_adc5_scale_type {
>> >> +	int (*scale_fn)(const struct vadc_prescale_ratio *prescale,
>> >> +		const struct adc_data *data, u16 adc_code, int *result);
>> >> +};
>> >> +
>> >> +int qcom_adc5_hw_scale(enum vadc_scale_fn_type scaletype,
>> >> +		    const struct vadc_prescale_ratio *prescale,
>> >> +		    const struct adc_data *data,
>> >> +		    u16 adc_code, int *result_mdec);
>> >> +
>> >>  int qcom_vadc_decimation_from_dt(u32 value);
>> >>
>> >>  #endif /* QCOM_VADC_COMMON_H */
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" 
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
