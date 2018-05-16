Return-Path: <SRS0=zfDR=ID=codeaurora.org=smohanad@kernel.org>
Subject: Re: [PATCH 2/2] iio: adc: Add Qualcomm SPMI PMIC5 ADC driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring
 <robh+dt@kernel.org>, cdevired@codeaurora.org, rphani@codeaurora.org,
 sivaa@codeaurora.org
References: <1525815536-27781-1-git-send-email-smohanad@codeaurora.org>
 <20180512115652.6ad8413b@archlinux>
From: Siddartha Mohanadoss <smohanad@codeaurora.org>
Message-ID: <bda3623d-27c2-78ee-957a-253e4c588f8c@codeaurora.org>
Date: Tue, 15 May 2018 17:14:33 -0700
MIME-Version: 1.0
In-Reply-To: <20180512115652.6ad8413b@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hi,


On 05/12/2018 03:56 AM, Jonathan Cameron wrote:
> On Tue,  8 May 2018 14:38:56 -0700
> Siddartha Mohanadoss <smohanad@codeaurora.org> wrote:
>
>> This patch adds support for Qualcomm SPMI PMIC5 family
>> of ADC driver that supports hardware based offset and
>> gain compensation. The ADC peripheral can measure both
>> voltage and current channels whose input signal is
>> connected to the PMIC.
>>
>> The register set and configuration has been refreshed
>> compared to the prior Qualcomm PMIC ADC family. Register
>> ADC5 as part of the IIO framework.
>>
>> Signed-off-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
> Various minor comments inline.
>
> Jonathan
Thanks for the review.
>
>> ---
>>   drivers/iio/adc/Kconfig                  |  18 +
>>   drivers/iio/adc/Makefile                 |   1 +
>>   drivers/iio/adc/qcom-spmi-adc5.c         | 818 +++++++++++++++++++++++++++++++
>>   drivers/iio/adc/qcom-vadc-common.c       | 241 +++++++++
>>   drivers/iio/adc/qcom-vadc-common.h       |  51 ++
>>   include/dt-bindings/iio/qcom,spmi-vadc.h | 115 ++++-
>>   6 files changed, 1243 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/iio/adc/qcom-spmi-adc5.c
>>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index 15606f2..ba861a1 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -567,6 +567,24 @@ config QCOM_PM8XXX_XOADC
>>   	  To compile this driver as a module, choose M here: the module
>>   	  will be called qcom-pm8xxx-xoadc.
>>   
>> +config QCOM_SPMI_ADC5
>> +	tristate "Qualcomm Technologies Inc. SPMI PMIC5 ADC"
>> +	depends on SPMI
>> +	select REGMAP_SPMI
>> +	select QCOM_VADC_COMMON
>> +	help
>> +	  This is the IIO Voltage PMIC5 ADC driver for Qualcomm Technologies Inc.
>> +
>> +	  The driver supports multiple channels read. The ADC is a 16-bit
>> +	  sigma-delta ADC. The hardware supports calibrated results for
>> +	  conversion requests and clients include reading voltage phone
>> +	  power, on board system thermistors connected to the PMIC ADC,
>> +	  PMIC die temperature, charger temperature, battery current, USB voltage
>> +	  input, voltage signals connected to supported PMIC GPIO inputs.
>> +
>> +	  To compile this driver as a module, choose M here: the module will
>> +	  be called qcom-spmi-adc5.
>> +
>>   config QCOM_SPMI_IADC
>>   	tristate "Qualcomm SPMI PMIC current ADC"
>>   	depends on SPMI
>> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>> index 28a9423..30ceb65 100644
>> --- a/drivers/iio/adc/Makefile
>> +++ b/drivers/iio/adc/Makefile
>> @@ -55,6 +55,7 @@ obj-$(CONFIG_NAU7802) += nau7802.o
>>   obj-$(CONFIG_PALMAS_GPADC) += palmas_gpadc.o
>>   obj-$(CONFIG_QCOM_SPMI_IADC) += qcom-spmi-iadc.o
>>   obj-$(CONFIG_QCOM_VADC_COMMON) += qcom-vadc-common.o
>> +obj-$(CONFIG_QCOM_SPMI_ADC5) += qcom-spmi-adc5.o
>>   obj-$(CONFIG_QCOM_SPMI_VADC) += qcom-spmi-vadc.o
>>   obj-$(CONFIG_QCOM_PM8XXX_XOADC) += qcom-pm8xxx-xoadc.o
>>   obj-$(CONFIG_RCAR_GYRO_ADC) += rcar-gyroadc.o
>> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
>> new file mode 100644
>> index 0000000..e6bc584
>> --- /dev/null
>> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
>> @@ -0,0 +1,818 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
> Don't normally have both SPDX and a licence statement...
Ok. Will remove SPDX.
>
>> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 and
>> + * only version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/bitops.h>
>> +#include <linux/completion.h>
>> +#include <linux/delay.h>
>> +#include <linux/err.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/kernel.h>
>> +#include <linux/math64.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/slab.h>
>> +#include <linux/log2.h>
>> +
>> +#include <dt-bindings/iio/qcom,spmi-vadc.h>
>> +
>> +#include "qcom-vadc-common.h"
>> +
>> +#define ADC_USR_STATUS1				0x8
> I'd prefer a more unique prefix on these. Even ADC5 as you
> have used elsewhere would be an improvement an cut down
> on potential clashes some tiem in teh future.
Ok. Will prefix with defines and functions with adc5.
>
>> +#define ADC_USR_STATUS1_REQ_STS			BIT(1)
>> +#define ADC_USR_STATUS1_EOC			BIT(0)
>> +#define ADC_USR_STATUS1_REQ_STS_EOC_MASK	0x3
>> +
>> +#define ADC_USR_STATUS2				0x9
>> +#define ADC_USR_STATUS2_CONV_SEQ_MASK		0x70
>> +#define ADC_USR_STATUS2_CONV_SEQ_MASK_SHIFT	0x5
>> +
>> +#define ADC_USR_IBAT_MEAS			0xf
>> +#define ADC_USR_IBAT_MEAS_SUPPORTED		BIT(0)
>> +
>> +#define ADC_USR_DIG_PARAM			0x42
>> +#define ADC_USR_DIG_PARAM_CAL_VAL		BIT(6)
>> +#define ADC_USR_DIG_PARAM_CAL_VAL_SHIFT		6
>> +#define ADC_USR_DIG_PARAM_CAL_SEL		0x30
>> +#define ADC_USR_DIG_PARAM_CAL_SEL_SHIFT		4
>> +#define ADC_USR_DIG_PARAM_DEC_RATIO_SEL		0xc
>> +#define ADC_USR_DIG_PARAM_DEC_RATIO_SEL_SHIFT	2
>> +
>> +#define ADC_USR_FAST_AVG_CTL			0x43
>> +#define ADC_USR_FAST_AVG_CTL_EN			BIT(7)
>> +#define ADC_USR_FAST_AVG_CTL_SAMPLES_MASK	0x7
>> +
>> +#define ADC_USR_CH_SEL_CTL			0x44
>> +
>> +#define ADC_USR_DELAY_CTL			0x45
>> +#define ADC_USR_HW_SETTLE_DELAY_MASK		0xf
>> +
>> +#define ADC_USR_EN_CTL1				0x46
>> +#define ADC_USR_EN_CTL1_ADC_EN			BIT(7)
>> +
>> +#define ADC_USR_CONV_REQ			0x47
>> +#define ADC_USR_CONV_REQ_REQ			BIT(7)
>> +
>> +#define ADC_USR_DATA0				0x50
>> +
>> +#define ADC_USR_DATA1				0x51
>> +
>> +#define ADC_USR_IBAT_DATA0			0x52
>> +
>> +#define ADC_USR_IBAT_DATA1			0x53
>> +
>> +/*
>> + * Conversion time varies based on the decimation, clock rate, fast average
>> + * samples and measurements queued across different VADC peripherals.
>> + * Set the timeout to a max of 100ms.
>> + */
>> +#define ADC_CONV_TIME_MIN_US			263
>> +#define ADC_CONV_TIME_MAX_US			264
>> +#define ADC_CONV_TIME_RETRY			400
>> +#define ADC_CONV_TIMEOUT			msecs_to_jiffies(100)
>> +
>> +enum adc_cal_method {
>> +	ADC_NO_CAL = 0,
>> +	ADC_RATIOMETRIC_CAL,
>> +	ADC_ABSOLUTE_CAL
>> +};
>> +
>> +enum adc_cal_val {
>> +	ADC_TIMER_CAL = 0,
>> +	ADC_NEW_CAL
>> +};
>> +
>> +/**
>> + * struct adc_channel_prop - ADC channel property.
>> + * @channel: channel number, refer to the channel list.
>> + * @cal_method: calibration method.
>> + * @cal_val: calibration value
>> + * @decimation: sampling rate supported for the channel.
>> + * @prescale: channel scaling performed on the input signal.
>> + * @hw_settle_time: the time between AMUX being configured and the
>> + *	start of conversion.
>> + * @avg_samples: ability to provide single result from the ADC
>> + *	that is an average of multiple measurements.
>> + * @scale_fn_type: Represents the scaling function to convert voltage
>> + *	physical units desired by the client for the channel.
>> + * @datasheet_name: Channel name used in device tree.
>> + */
>> +struct adc_channel_prop {
>> +	unsigned int		channel;
>> +	enum adc_cal_method	cal_method;
>> +	enum adc_cal_val	cal_val;
>> +	unsigned int		decimation;
>> +	unsigned int		prescale;
>> +	unsigned int		hw_settle_time;
>> +	unsigned int		avg_samples;
>> +	enum vadc_scale_fn_type	scale_fn_type;
>> +	const char		*datasheet_name;
>> +};
>> +
>> +/**
>> + * struct adc_chip - ADC private structure.
>> + * @regmap: pointer to struct regmap.
>> + * @dev: pointer to struct device.
> The two above aren't really all that informative, anything
> more relevant you could put?
Ok.
>
>> + * @base: base address for the ADC peripheral.
>> + * @nchannels: number of ADC channels.
>> + * @chan_props: array of ADC channel properties.
>> + * @iio_chans: array of IIO channels specification.
>> + * @poll_eoc: use polling instead of interrupt.
>> + * @complete: ADC result notification after interrupt is received.
>> + * @lock: ADC lock for access to the peripheral.
>> + * @data: software configuration data.
>> + */
>> +struct adc_chip {
>> +	struct regmap		*regmap;
>> +	struct device		*dev;
>> +	u16			base;
>> +	unsigned int		nchannels;
>> +	struct adc_channel_prop	*chan_props;
>> +	struct iio_chan_spec	*iio_chans;
>> +	bool			poll_eoc;
>> +	struct completion	complete;
>> +	struct mutex		lock;
>> +	const struct adc_data	*data;
>> +};
>> +
>> +static const struct vadc_prescale_ratio adc_prescale_ratios[] = {
>> +	{.num =  1, .den =  1},
>> +	{.num =  1, .den =  3},
>> +	{.num =  1, .den =  4},
>> +	{.num =  1, .den =  6},
>> +	{.num =  1, .den = 20},
>> +	{.num =  1, .den =  8},
>> +	{.num = 10, .den = 81},
>> +	{.num =  1, .den = 10},
>> +	{.num =  1, .den = 16}
>> +};
>> +
>> +static int adc_read(struct adc_chip *adc, u16 offset, u8 *data, int len)
>> +{
>> +	return regmap_bulk_read(adc->regmap, adc->base + offset, data, len);
>> +}
>> +
>> +static int adc_write(struct adc_chip *adc, u16 offset, u8 *data, int len)
>> +{
>> +	return regmap_bulk_write(adc->regmap, adc->base + offset, data, len);
>> +}
>> +
>> +static int adc_prescaling_from_dt(u32 num, u32 den)
>> +{
>> +	unsigned int pre;
>> +
>> +	for (pre = 0; pre < ARRAY_SIZE(adc_prescale_ratios); pre++)
>> +		if (adc_prescale_ratios[pre].num == num &&
>> +		    adc_prescale_ratios[pre].den == den)
>> +			break;
>> +
>> +	if (pre == ARRAY_SIZE(adc_prescale_ratios))
>> +		return -EINVAL;
>> +
>> +	return pre;
>> +}
>> +
>> +static int adc_hw_settle_time_from_dt(u32 value,
>> +					const unsigned int *hw_settle)
>> +{
>> +	uint32_t i;
>> +
>> +	for (i = 0; i < VADC_HW_SETTLE_SAMPLES_MAX; i++) {
>> +		if (value == hw_settle[i])
>> +			return i;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static int adc_avg_samples_from_dt(u32 value)
>> +{
>> +	if (!is_power_of_2(value) || value > ADC5_AVG_SAMPLES_MAX)
>> +		return -EINVAL;
>> +
>> +	return __ffs64(value);
>> +}
>> +
>> +static int adc_read_current_data(struct adc_chip *adc, u16 *data)
>> +{
>> +	int ret;
>> +	u8 rslt_lsb = 0, rslt_msb = 0;
>> +
>> +	ret = adc_read(adc, ADC_USR_IBAT_DATA0, &rslt_lsb, 1);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = adc_read(adc, ADC_USR_IBAT_DATA1, &rslt_msb, 1);
>> +	if (ret)
>> +		return ret;
>> +
>> +	*data = (rslt_msb << 8) | rslt_lsb;
>> +
>> +	if (*data == ADC_USR_DATA_CHECK) {
>> +		pr_err("Invalid data:0x%x\n", *data);
>> +		return -EINVAL;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int adc_read_voltage_data(struct adc_chip *adc, u16 *data)
>> +{
>> +	int ret;
>> +	u8 rslt_lsb = 0, rslt_msb = 0;
> Seems odd that you need to assign these for any path?
Sure. Will fix this.
>
>> +
>> +	ret = adc_read(adc, ADC_USR_DATA0, &rslt_lsb, 1);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = adc_read(adc, ADC_USR_DATA1, &rslt_msb, 1);
>> +	if (ret)
>> +		return ret;
>> +
>> +	*data = (rslt_msb << 8) | rslt_lsb;
>> +
>> +	if (*data == ADC_USR_DATA_CHECK) {
>> +		pr_err("Invalid data:0x%x\n", *data);
>> +		return -EINVAL;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int adc_poll_wait_eoc(struct adc_chip *adc)
>> +{
>> +	unsigned int count, retry;
>> +	u8 status1;
>> +	int ret;
>> +
>> +	retry = ADC_CONV_TIME_RETRY;
> unsigned int retry = ADC_CONV_TIME_RETRY;
Ok.
>> +
>> +	for (count = 0; count < retry; count++) {
>> +		ret = adc_read(adc, ADC_USR_STATUS1, &status1, 1);
>> +		if (ret)
>> +			return ret;
>> +
>> +		status1 &= ADC_USR_STATUS1_REQ_STS_EOC_MASK;
>> +		if (status1 == ADC_USR_STATUS1_EOC)
>> +			return 0;
>> +		usleep_range(ADC_CONV_TIME_MIN_US, ADC_CONV_TIME_MAX_US);
>> +	}
>> +
>> +	return -ETIMEDOUT;
>> +}
>> +
>> +static void adc_update_dig_param(struct adc_chip *adc,
>> +			struct adc_channel_prop *prop, u8 *data)
>> +{
>> +	/* Update calibration value */
>> +	*data &= ~ADC_USR_DIG_PARAM_CAL_VAL;
>> +	*data |= (prop->cal_val << ADC_USR_DIG_PARAM_CAL_VAL_SHIFT);
>> +
>> +	/* Update calibration select */
>> +	*data &= ~ADC_USR_DIG_PARAM_CAL_SEL;
>> +	*data |= (prop->cal_method << ADC_USR_DIG_PARAM_CAL_SEL_SHIFT);
>> +
>> +	/* Update decimation ratio select */
>> +	*data &= ~ADC_USR_DIG_PARAM_DEC_RATIO_SEL;
>> +	*data |= (prop->decimation << ADC_USR_DIG_PARAM_DEC_RATIO_SEL_SHIFT);
>> +}
>> +
>> +static int adc_configure(struct adc_chip *adc,
>> +			struct adc_channel_prop *prop)
>> +{
>> +	int ret;
>> +	u8 buf[6];
>> +
>> +	/* Read registers 0x42 through 0x46 */
>> +	ret = adc_read(adc, ADC_USR_DIG_PARAM, buf, 6);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* Digital param selection */
>> +	adc_update_dig_param(adc, prop, &buf[0]);
>> +
>> +	/* Update fast average sample value */
>> +	buf[1] &= (u8) ~ADC_USR_FAST_AVG_CTL_SAMPLES_MASK;
>> +	buf[1] |= prop->avg_samples;
>> +
>> +	/* Select ADC channel */
>> +	buf[2] = prop->channel;
>> +
>> +	/* Select HW settle delay for channel */
>> +	buf[3] &= (u8) ~ADC_USR_HW_SETTLE_DELAY_MASK;
>> +	buf[3] |= prop->hw_settle_time;
>> +
>> +	/* Select ADC enable */
>> +	buf[4] |= ADC_USR_EN_CTL1_ADC_EN;
>> +
>> +	/* Select CONV request */
>> +	buf[5] |= ADC_USR_CONV_REQ_REQ;
>> +
>> +	if (!adc->poll_eoc)
>> +		reinit_completion(&adc->complete);
>> +
>> +	ret = adc_write(adc, ADC_USR_DIG_PARAM, buf, 6);
>> +
>> +	return ret;
> return adc_write...
Ok.
>
>> +}
>> +
>> +static int adc_do_conversion(struct adc_chip *adc,
>> +			struct adc_channel_prop *prop,
>> +			struct iio_chan_spec const *chan,
>> +			u16 *data_volt, u16 *data_cur)
>> +{
>> +	int ret;
>> +
>> +	mutex_lock(&adc->lock);
>> +
>> +	ret = adc_configure(adc, prop);
>> +	if (ret) {
>> +		pr_err("ADC configure failed with %d\n", ret);
>> +		goto unlock;
>> +	}
>> +
>> +	if (adc->poll_eoc) {
>> +		ret = adc_poll_wait_eoc(adc);
>> +		if (ret < 0) {
>> +			pr_err("EOC bit not set\n");
>> +			goto unlock;
>> +		}
>> +	} else {
>> +		ret = wait_for_completion_timeout(&adc->complete,
>> +							ADC_CONV_TIMEOUT);
>> +		if (!ret) {
>> +			pr_debug("Did not get completion timeout.\n");
>> +			ret = adc_poll_wait_eoc(adc);
>> +			if (ret < 0) {
>> +				pr_err("EOC bit not set\n");
>> +				goto unlock;
>> +			}
>> +		}
>> +	}
>> +
>> +	if ((chan->type == IIO_VOLTAGE) || (chan->type == IIO_TEMP))
>> +		ret = adc_read_voltage_data(adc, data_volt);
>> +	else if (chan->type == IIO_POWER) {
>> +		ret = adc_read_voltage_data(adc, data_volt);
>> +		if (ret)
>> +			goto unlock;
>> +
>> +		ret = adc_read_current_data(adc, data_cur);
>> +	}
>> +unlock:
>> +	mutex_unlock(&adc->lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static irqreturn_t adc_isr(int irq, void *dev_id)
>> +{
>> +	struct adc_chip *adc = dev_id;
>> +
>> +	complete(&adc->complete);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int adc_of_xlate(struct iio_dev *indio_dev,
>> +				const struct of_phandle_args *iiospec)
>> +{
>> +	struct adc_chip *adc = iio_priv(indio_dev);
>> +	int i;
>> +
>> +	for (i = 0; i < adc->nchannels; i++)
>> +		if (adc->chan_props[i].channel == iiospec->args[0])
>> +			return i;
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static int adc_read_raw(struct iio_dev *indio_dev,
>> +			 struct iio_chan_spec const *chan, int *val, int *val2,
>> +			 long mask)
>> +{
>> +	struct adc_chip *adc = iio_priv(indio_dev);
>> +	struct adc_channel_prop *prop;
>> +	u16 adc_code_volt, adc_code_cur;
>> +	int ret;
>> +
>> +	prop = &adc->chan_props[chan->address];
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_PROCESSED:
>> +		ret = adc_do_conversion(adc, prop, chan,
>> +				&adc_code_volt, &adc_code_cur);
>> +		if (ret)
>> +			break;
>> +
>> +		if ((chan->type == IIO_VOLTAGE) || (chan->type == IIO_TEMP))
>> +			ret = qcom_vadc_hw_scale(prop->scale_fn_type,
>> +				&adc_prescale_ratios[prop->prescale],
>> +				adc->data,
>> +				adc_code_volt, val);
>> +		if (ret)
>> +			break;
>> +
>> +		if (chan->type == IIO_POWER) {
>> +			ret = qcom_vadc_hw_scale(SCALE_HW_CALIB_DEFAULT,
>> +				&adc_prescale_ratios[VADC_DEF_VBAT_PRESCALING],
>> +				adc->data,
>> +				adc_code_volt, val);
>> +			if (ret)
>> +				break;
>> +
>> +			ret = qcom_vadc_hw_scale(prop->scale_fn_type,
>> +				&adc_prescale_ratios[prop->prescale],
>> +				adc->data,
>> +				adc_code_cur, val2);
>> +			if (ret)
>> +				break;
>> +		}
>> +
>> +		if (chan->type == IIO_POWER)
>> +			return IIO_VAL_INT_MULTIPLE;
>> +		else
>> +			return IIO_VAL_INT;
>> +	case IIO_CHAN_INFO_RAW:
>> +		ret = adc_do_conversion(adc, prop, chan,
>> +				&adc_code_volt, &adc_code_cur);
>> +		if (ret)
>> +			break;
>> +
>> +		*val = (int)adc_code_volt;
>> +		*val2 = (int)adc_code_cur;
>> +		if (chan->type == IIO_POWER)
>> +			return IIO_VAL_INT_MULTIPLE;
>> +		else
>> +			return IIO_VAL_INT;
>> +	default:
>> +		ret = -EINVAL;
>> +		break;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct iio_info adc_info = {
>> +	.read_raw = adc_read_raw,
>> +	.of_xlate = adc_of_xlate,
>> +};
>> +
>> +struct adc_channels {
>> +	const char *datasheet_name;
>> +	unsigned int prescale_index;
>> +	enum iio_chan_type type;
>> +	long info_mask;
>> +	enum vadc_scale_fn_type scale_fn_type;
>> +};
>> +
>> +#define ADC_CHAN(_dname, _type, _mask, _pre, _scale)			\
>> +	{								\
>> +		.datasheet_name = (_dname),				\
>> +		.prescale_index = _pre,					\
>> +		.type = _type,						\
>> +		.info_mask = _mask,					\
>> +		.scale_fn_type = _scale,				\
>> +	},								\
>> +
>> +#define ADC_CHAN_TEMP(_dname, _pre, _scale)				\
>> +	ADC_CHAN(_dname, IIO_TEMP,					\
>> +		BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_PROCESSED),	\
>> +		_pre, _scale)						\
>> +
>> +#define ADC_CHAN_VOLT(_dname, _pre, _scale)				\
>> +	ADC_CHAN(_dname, IIO_VOLTAGE,					\
>> +		  BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_PROCESSED),\
>> +		  _pre, _scale)						\
>> +
>> +#define ADC_CHAN_POWER(_dname, _pre, _scale)				\
>> +	ADC_CHAN(_dname, IIO_POWER,					\
>> +		  BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_PROCESSED),\
>> +		  _pre, _scale)						\
>> +
>> +static const struct adc_channels adc_chans_pmic5[ADC_MAX_CHANNEL] = {
>> +	[ADC_REF_GND]		= ADC_CHAN_VOLT("ref_gnd", 1,
>> +					SCALE_HW_CALIB_DEFAULT)
>> +	[ADC_1P25VREF]		= ADC_CHAN_VOLT("vref_1p25", 1,
>> +					SCALE_HW_CALIB_DEFAULT)
>> +	[ADC_VPH_PWR]		= ADC_CHAN_VOLT("vph_pwr", 3,
>> +					SCALE_HW_CALIB_DEFAULT)
>> +	[ADC_VBAT_SNS]		= ADC_CHAN_VOLT("vbat_sns", 3,
>> +					SCALE_HW_CALIB_DEFAULT)
>> +	[ADC_DIE_TEMP]		= ADC_CHAN_TEMP("die_temp", 1,
>> +					SCALE_HW_CALIB_PMIC_THERM)
>> +	[ADC_USB_IN_I]		= ADC_CHAN_VOLT("usb_in_i_uv", 1,
>> +					SCALE_HW_CALIB_DEFAULT)
>> +	[ADC_USB_IN_V_16]	= ADC_CHAN_VOLT("usb_in_v_div_16", 16,
>> +					SCALE_HW_CALIB_DEFAULT)
>> +	[ADC_CHG_TEMP]		= ADC_CHAN_TEMP("chg_temp", 1,
>> +					SCALE_HW_CALIB_PM5_CHG_TEMP)
>> +	/* Charger prescales SBUx and MID_CHG to fit within 1.8V upper unit */
>> +	[ADC_SBUx]		= ADC_CHAN_VOLT("chg_sbux", 3,
>> +					SCALE_HW_CALIB_DEFAULT)
>> +	[ADC_MID_CHG_DIV6]	= ADC_CHAN_VOLT("chg_mid_chg", 6,
>> +					SCALE_HW_CALIB_DEFAULT)
>> +	[ADC_XO_THERM_PU2]	= ADC_CHAN_TEMP("xo_therm", 1,
>> +					SCALE_HW_CALIB_XOTHERM)
>> +	[ADC_AMUX_THM1_PU2]	= ADC_CHAN_TEMP("amux_thm1_pu2", 1,
>> +					SCALE_HW_CALIB_THERM_100K_PULLUP)
>> +	[ADC_AMUX_THM2_PU2]	= ADC_CHAN_TEMP("amux_thm2_pu2", 1,
>> +					SCALE_HW_CALIB_THERM_100K_PULLUP)
>> +	[ADC_AMUX_THM3_PU2]	= ADC_CHAN_TEMP("amux_thm3_pu2", 1,
>> +					SCALE_HW_CALIB_THERM_100K_PULLUP)
>> +	[ADC_INT_EXT_ISENSE_VBAT_VDATA]	= ADC_CHAN_POWER("int_ext_isense", 1,
>> +					SCALE_HW_CALIB_CUR)
>> +	[ADC_EXT_ISENSE_VBAT_VDATA]	= ADC_CHAN_POWER("ext_isense", 1,
>> +					SCALE_HW_CALIB_CUR)
>> +	[ADC_PARALLEL_ISENSE_VBAT_VDATA] = ADC_CHAN_POWER("parallel_isense", 1,
>> +					SCALE_HW_CALIB_CUR)
>> +	[ADC_AMUX_THM2]			= ADC_CHAN_TEMP("amux_thm2", 1,
>> +					SCALE_HW_CALIB_PM5_SMB_TEMP)
>> +};
>> +
>> +static const struct adc_channels adc_chans_rev2[ADC_MAX_CHANNEL] = {
>> +	[ADC_REF_GND]		= ADC_CHAN_VOLT("ref_gnd", 1,
>> +					SCALE_HW_CALIB_DEFAULT)
>> +	[ADC_1P25VREF]		= ADC_CHAN_VOLT("vref_1p25", 1,
>> +					SCALE_HW_CALIB_DEFAULT)
>> +	[ADC_VPH_PWR]		= ADC_CHAN_VOLT("vph_pwr", 3,
>> +					SCALE_HW_CALIB_DEFAULT)
>> +	[ADC_VBAT_SNS]		= ADC_CHAN_VOLT("vbat_sns", 3,
>> +					SCALE_HW_CALIB_DEFAULT)
>> +	[ADC_VCOIN]		= ADC_CHAN_VOLT("vcoin", 3,
>> +					SCALE_HW_CALIB_DEFAULT)
>> +	[ADC_DIE_TEMP]		= ADC_CHAN_TEMP("die_temp", 1,
>> +					SCALE_HW_CALIB_PMIC_THERM)
>> +	[ADC_AMUX_THM1_PU2]	= ADC_CHAN_TEMP("amux_thm1_pu2", 1,
>> +					SCALE_HW_CALIB_THERM_100K_PULLUP)
>> +	[ADC_AMUX_THM3_PU2]	= ADC_CHAN_TEMP("amux_thm3_pu2", 1,
>> +					SCALE_HW_CALIB_THERM_100K_PULLUP)
>> +	[ADC_AMUX_THM5_PU2]	= ADC_CHAN_TEMP("amux_thm5_pu2", 1,
>> +					SCALE_HW_CALIB_THERM_100K_PULLUP)
>> +	[ADC_XO_THERM_PU2]	= ADC_CHAN_TEMP("xo_therm", 1,
>> +					SCALE_HW_CALIB_THERM_100K_PULLUP)
>> +};
>> +
>> +static int adc_get_dt_channel_data(struct device *dev,
>> +				    struct adc_channel_prop *prop,
>> +				    struct device_node *node,
>> +				    const struct adc_data *data)
>> +{
>> +	const char *name = node->name, *channel_name;
>> +	u32 chan, value, varr[2];
>> +	int ret;
>> +
>> +	ret = of_property_read_u32(node, "reg", &chan);
>> +	if (ret) {
>> +		dev_err(dev, "invalid channel number %s\n", name);
>> +		return ret;
>> +	}
>> +
>> +	if (chan > ADC_PARALLEL_ISENSE_VBAT_IDATA) {
>> +		dev_err(dev, "%s invalid channel number %d\n", name, chan);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* the channel has DT description */
>> +	prop->channel = chan;
>> +
>> +	channel_name = of_get_property(node,
>> +				"label", NULL) ? : node->name;
>> +	if (!channel_name) {
>> +		pr_err("Invalid channel name\n");
>> +		return -EINVAL;
>> +	}
>> +	prop->datasheet_name = channel_name;
>> +
>> +	ret = of_property_read_u32(node, "qcom,decimation", &value);
>> +	if (!ret) {
>> +		ret = qcom_adc5_decimation_from_dt(value, data->decimation);
>> +		if (ret < 0) {
>> +			dev_err(dev, "%02x invalid decimation %d\n",
>> +				chan, value);
>> +			return ret;
>> +		}
>> +		prop->decimation = ret;
>> +	} else {
>> +		prop->decimation = ADC_DECIMATION_DEFAULT;
>> +	}
>> +
>> +	ret = of_property_read_u32_array(node, "qcom,pre-scaling", varr, 2);
>> +	if (!ret) {
>> +		ret = adc_prescaling_from_dt(varr[0], varr[1]);
>> +		if (ret < 0) {
>> +			dev_err(dev, "%02x invalid pre-scaling <%d %d>\n",
>> +				chan, varr[0], varr[1]);
>> +			return ret;
>> +		}
>> +		prop->prescale = ret;
>> +	}
>> +
>> +	ret = of_property_read_u32(node, "qcom,hw-settle-time", &value);
>> +	if (!ret) {
>> +		ret = adc_hw_settle_time_from_dt(value, data->hw_settle);
>> +		if (ret < 0) {
>> +			dev_err(dev, "%02x invalid hw-settle-time %d us\n",
>> +				chan, value);
>> +			return ret;
>> +		}
>> +		prop->hw_settle_time = ret;
>> +	} else {
>> +		prop->hw_settle_time = VADC_DEF_HW_SETTLE_TIME;
>> +	}
>> +
>> +	ret = of_property_read_u32(node, "qcom,avg-samples", &value);
>> +	if (!ret) {
>> +		ret = adc_avg_samples_from_dt(value);
>> +		if (ret < 0) {
>> +			dev_err(dev, "%02x invalid avg-samples %d\n",
>> +				chan, value);
>> +			return ret;
>> +		}
>> +		prop->avg_samples = ret;
>> +	} else {
>> +		prop->avg_samples = VADC_DEF_AVG_SAMPLES;
>> +	}
>> +
>> +	if (of_property_read_bool(node, "qcom,ratiometric"))
>> +		prop->cal_method = ADC_RATIOMETRIC_CAL;
>> +	else
>> +		prop->cal_method = ADC_ABSOLUTE_CAL;
>> +
>> +	dev_dbg(dev, "%02x name %s\n", chan, name);
>> +
>> +	return 0;
>> +}
>> +
>> +const struct adc_data data_pmic5 = {
>> +	.full_scale_code_volt = 0x70e4,
>> +	.full_scale_code_cur = 10000,
> Odd hex / decimal mix.
Agree. Will keep it as hex format for the two above full scale code values.
>
>> +	.adc_chans = adc_chans_pmic5,
>> +	.decimation = (unsigned int []) {250, 420, 840},
>> +	.hw_settle = (unsigned int []) {15, 100, 200, 300, 400, 500, 600, 700,
>> +					800, 900, 1, 2, 4, 6, 8, 10},
>> +};
>> +
>> +const struct adc_data data_pmic_rev2 = {
>> +	.full_scale_code_volt = 0x4000,
>> +	.full_scale_code_cur = 0x1800,
>> +	.adc_chans = adc_chans_rev2,
>> +	.decimation = (unsigned int []) {256, 512, 1024},
> As I mention further down I'd rather see these given a specific length so
> that we ensure the numbers are consistent with those used in the relevant
> for loops.  Right now we have to enforce that by review which is more
> fragile than making it explicit.
Ok. Will check.
>
>> +	.hw_settle = (unsigned int []) {0, 100, 200, 300, 400, 500, 600, 700,
>> +					800, 900, 1, 2, 4, 6, 8, 10},
>> +};
>> +
>> +static const struct of_device_id adc_match_table[] = {
>> +	{
>> +		.compatible = "qcom,spmi-adc5",
>> +		.data = &data_pmic5,
>> +	},
>> +	{
>> +		.compatible = "qcom,spmi-adc-rev2",
>> +		.data = &data_pmic_rev2,
>> +	},
>> +	{ }
>> +};
>> +
>> +static int adc_get_dt_data(struct adc_chip *adc, struct device_node *node)
>> +{
>> +	const struct adc_channels *adc_chan;
>> +	struct iio_chan_spec *iio_chan;
>> +	struct adc_channel_prop prop;
>> +	struct device_node *child;
>> +	unsigned int index = 0;
>> +	const struct of_device_id *id;
>> +	const struct adc_data *data;
>> +	int ret;
>> +
>> +	adc->nchannels = of_get_available_child_count(node);
>> +	if (!adc->nchannels)
>> +		return -EINVAL;
>> +
>> +	adc->iio_chans = devm_kcalloc(adc->dev, adc->nchannels,
>> +				       sizeof(*adc->iio_chans), GFP_KERNEL);
>> +	if (!adc->iio_chans)
>> +		return -ENOMEM;
>> +
>> +	adc->chan_props = devm_kcalloc(adc->dev, adc->nchannels,
>> +					sizeof(*adc->chan_props), GFP_KERNEL);
>> +	if (!adc->chan_props)
>> +		return -ENOMEM;
>> +
>> +	iio_chan = adc->iio_chans;
>> +	id = of_match_node(adc_match_table, node);
>> +	if (id)
>> +		data = id->data;
>> +	else
>> +		data = &data_pmic5;
>> +	adc->data = data;
>> +
>> +	for_each_available_child_of_node(node, child) {
>> +		ret = adc_get_dt_channel_data(adc->dev, &prop, child, data);
>> +		if (ret) {
>> +			of_node_put(child);
>> +			return ret;
>> +		}
>> +
>> +		prop.scale_fn_type =
>> +			data->adc_chans[prop.channel].scale_fn_type;
>> +		adc->chan_props[index] = prop;
> It seems a little inconsistent to use an array access for chan_props
> and pointer arithmetic for iio_chan.   I don't mind which style
> you want to use, but I can see a reason not to be consistent.
Ok. Will check.
>
>> +
>> +		adc_chan = &data->adc_chans[prop.channel];
>> +
>> +		iio_chan->channel = prop.channel;
>> +		iio_chan->datasheet_name = prop.datasheet_name;
>> +		iio_chan->extend_name = prop.datasheet_name;
>> +		iio_chan->info_mask_separate = adc_chan->info_mask;
>> +		iio_chan->type = adc_chan->type;
>> +		iio_chan->address = index;
>> +		iio_chan++;
>> +		index++;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int adc_probe(struct platform_device *pdev)
>> +{
>> +	struct device_node *node = pdev->dev.of_node;
>> +	struct device *dev = &pdev->dev;
>> +	struct iio_dev *indio_dev;
>> +	struct adc_chip *adc;
>> +	struct regmap *regmap;
>> +	int ret, irq_eoc;
>> +	u32 reg;
>> +
>> +	regmap = dev_get_regmap(dev->parent, NULL);
>> +	if (!regmap)
>> +		return -ENODEV;
>> +
>> +	ret = of_property_read_u32(node, "reg", &reg);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	adc = iio_priv(indio_dev);
>> +	adc->regmap = regmap;
>> +	adc->dev = dev;
>> +	adc->base = reg;
>> +	init_completion(&adc->complete);
>> +	mutex_init(&adc->lock);
>> +
>> +	ret = adc_get_dt_data(adc, node);
>> +	if (ret) {
>> +		pr_err("adc get dt data failed\n");
>> +		return ret;
>> +	}
>> +
>> +	irq_eoc = platform_get_irq(pdev, 0);
>> +	if (irq_eoc < 0) {
>> +		if (irq_eoc == -EPROBE_DEFER || irq_eoc == -EINVAL)
>> +			return irq_eoc;
>> +		adc->poll_eoc = true;
>> +	} else {
>> +		ret = devm_request_irq(dev, irq_eoc, adc_isr, 0,
>> +				       "pm-adc5", adc);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	indio_dev->dev.parent = dev;
>> +	indio_dev->dev.of_node = node;
>> +	indio_dev->name = pdev->name;
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +	indio_dev->info = &adc_info;
>> +	indio_dev->channels = adc->iio_chans;
>> +	indio_dev->num_channels = adc->nchannels;
>> +
>> +	return devm_iio_device_register(dev, indio_dev);
>> +}
>> +
>> +static struct platform_driver adc_driver = {
>> +	.driver = {
>> +		.name = "qcom-spmi-adc5.c",
>> +		.of_match_table = adc_match_table,
>> +	},
>> +	.probe = adc_probe,
>> +};
>> +module_platform_driver(adc_driver);
>> +
>> +MODULE_ALIAS("platform:qcom-spmi-adc5");
>> +MODULE_DESCRIPTION("Qualcomm Technologies Inc. PMIC5 ADC driver");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
>> index fe3d782..7a37035 100644
>> --- a/drivers/iio/adc/qcom-vadc-common.c
>> +++ b/drivers/iio/adc/qcom-vadc-common.c
>> @@ -47,6 +47,47 @@
>>   	{44,	125}
>>   };
>>   
>> +/*
>> + * Voltage to temperature table for 100k pull up for NTCG104EF104 with
>> + * 1.875V reference.
>> + */
>> +static const struct vadc_map_pt adcmap_100k_104ef_104fb_1875_vref[] = {
>> +	{ 1831,	-40000 },
>> +	{ 1814,	-35000 },
>> +	{ 1791,	-30000 },
>> +	{ 1761,	-25000 },
>> +	{ 1723,	-20000 },
>> +	{ 1675,	-15000 },
>> +	{ 1616,	-10000 },
>> +	{ 1545,	-5000 },
>> +	{ 1463,	0 },
>> +	{ 1370,	5000 },
>> +	{ 1268,	10000 },
>> +	{ 1160,	15000 },
>> +	{ 1049,	20000 },
>> +	{ 937,	25000 },
>> +	{ 828,	30000 },
>> +	{ 726,	35000 },
>> +	{ 630,	40000 },
>> +	{ 544,	45000 },
>> +	{ 467,	50000 },
>> +	{ 399,	55000 },
>> +	{ 340,	60000 },
>> +	{ 290,	65000 },
>> +	{ 247,	70000 },
>> +	{ 209,	75000 },
>> +	{ 179,	80000 },
>> +	{ 153,	85000 },
>> +	{ 130,	90000 },
>> +	{ 112,	95000 },
>> +	{ 96,	100000 },
>> +	{ 82,	105000 },
>> +	{ 71,	110000 },
>> +	{ 62,	115000 },
>> +	{ 53,	120000 },
>> +	{ 46,	125000 },
>> +};
>> +
>>   static int qcom_vadc_map_voltage_temp(const struct vadc_map_pt *pts,
>>   				      u32 tablesize, s32 input, s64 *output)
>>   {
>> @@ -191,6 +232,163 @@ static int qcom_vadc_scale_chg_temp(const struct vadc_linear_graph *calib_graph,
>>   	return 0;
>>   }
>>   
>> +static int qcom_vadc_scale_hw_calib_volt(
>> +				const struct vadc_prescale_ratio *prescale,
>> +				const struct adc_data *data,
>> +				u16 adc_code, int *result_uv)
>> +{
>> +	s64 voltage = 0, result = 0, adc_vdd_ref_mv = 1875;
>> +
>> +	if (adc_code > VADC5_MAX_CODE)
>> +		adc_code = 0;
>> +
>> +	/* (ADC code * vref_vadc (1.875V)) / full_scale_code */
>> +	voltage = (s64) adc_code * adc_vdd_ref_mv * 1000;
>> +	voltage = div64_s64(voltage, data->full_scale_code_volt);
>> +	voltage = voltage * prescale->den;
>> +	result = div64_s64(voltage, prescale->num);
>> +	*result_uv = result;
>> +
>> +	return 0;
>> +}
>> +
>> +static int qcom_vadc_scale_hw_calib_therm(
>> +				const struct vadc_prescale_ratio *prescale,
>> +				const struct adc_data *data,
>> +				u16 adc_code, int *result_mdec)
>> +{
>> +	s64 voltage = 0, result = 0, adc_vdd_ref_mv = 1875;
>> +	int ret;
>> +
>> +	if (adc_code > VADC5_MAX_CODE)
>> +		adc_code = 0;
>> +
>> +	/* (ADC code * vref_vadc (1.875V)) / full_scale_code */
>> +	voltage = (s64) adc_code * adc_vdd_ref_mv * 1000;
>> +	voltage = div64_s64(voltage, (data->full_scale_code_volt
>> +								* 1000));
>> +	ret = qcom_vadc_map_voltage_temp(adcmap_100k_104ef_104fb_1875_vref,
>> +				 ARRAY_SIZE(adcmap_100k_104ef_104fb_1875_vref),
>> +				 voltage, &result);
>> +	if (ret)
>> +		return ret;
>> +
>> +	*result_mdec = result;
>> +
>> +	return 0;
>> +}
>> +
>> +static int qcom_vadc_scale_hw_calib_die_temp(
>> +				const struct vadc_prescale_ratio *prescale,
>> +				const struct adc_data *data,
>> +				u16 adc_code, int *result_mdec)
>> +{
>> +	s64 voltage = 0, adc_vdd_ref_mv = 1875;
>> +	u64 temp; /* Temporary variable for do_div */
>> +
>> +	if (adc_code > VADC5_MAX_CODE)
>> +		adc_code = 0;
>> +
>> +	/* (ADC code * vref_vadc (1.875V)) / full_scale_code */
>> +	voltage = (s64) adc_code * adc_vdd_ref_mv * 1000;
>> +	voltage = div64_s64(voltage, data->full_scale_code_volt);
>> +	if (voltage > 0) {
>> +		temp = voltage * prescale->den;
>> +		do_div(temp, prescale->num * 2);
>> +		voltage = temp;
>> +	} else {
>> +		voltage = 0;
>> +	}
>> +
>> +	voltage -= KELVINMIL_CELSIUSMIL;
>> +	*result_mdec = voltage;
>> +
>> +	return 0;
>> +}
>> +
>> +static int qcom_vadc_scale_hw_smb_temp(
>> +				const struct vadc_prescale_ratio *prescale,
>> +				const struct adc_data *data,
>> +				u16 adc_code, int *result_mdec)
>> +{
> This is very close to the function below, can we not create a utility function
> that does both and save on a lot of code repetition?
The scaling was kept separate so if there are any updates to the scaling
equations across different PMIC chipsets, these are contained for each
channel separately. For now, i will try to merge these two functions and
it can be split later if needed.
>
>> +	s64 voltage = 0, adc_vdd_ref_mv = 1875;
>> +	u64 temp;
>> +
>> +	if (adc_code > VADC5_MAX_CODE)
>> +		adc_code = 0;
>> +
>> +	/* (ADC code * vref_vadc (1.875V)) / full_scale_code */
>> +	voltage = (s64) adc_code * adc_vdd_ref_mv * 1000;
>> +	voltage = div64_s64(voltage, data->full_scale_code_volt);
>> +	if (voltage > 0) {
>> +		temp = voltage * prescale->den;
>> +		temp *= 100;
>> +		do_div(temp, prescale->num * PMIC5_SMB_TEMP_SCALE_FACTOR);
>> +		voltage = temp;
>> +	} else {
>> +		voltage = 0;
>> +	}
>> +
>> +	voltage = PMIC5_SMB_TEMP_CONSTANT - voltage;
>> +	*result_mdec = voltage;
>> +
>> +	return 0;
>> +}
>> +
>> +static int qcom_vadc_scale_hw_chg5_temp(
>> +				const struct vadc_prescale_ratio *prescale,
>> +				const struct adc_data *data,
>> +				u16 adc_code, int *result_mdec)
>> +{
>> +	s64 voltage = 0, adc_vdd_ref_mv = 1875;
>> +	u64 temp;
>> +
>> +	if (adc_code > VADC5_MAX_CODE)
>> +		adc_code = 0;
> That's unusual.  Would normally expect to clamp or return an
> error, why does setting to 0 make sense here? Add a comment.
Will add a comment.
The normal data range is between 0V to 1.875V. On cases
where we read low voltage values, the ADC code can go beyond
this range and the scale result is incorrect so we clamp the values
for cases where the code represents a value below 0V.
>
>> +
>> +	/* (ADC code * vref_vadc (1.875V)) / full_scale_code */
>> +	voltage = (s64) adc_code * adc_vdd_ref_mv * 1000;
>> +	voltage = div64_s64(voltage, data->full_scale_code_volt);
>> +	if (voltage > 0) {
>> +		temp = voltage * prescale->den;
>> +		do_div(temp, prescale->num * 4);
>> +		voltage = temp;
>> +	} else {
>> +		voltage = 0;
>> +	}
>> +
>> +	voltage = PMIC5_CHG_TEMP_SCALE_FACTOR - voltage;
>> +	*result_mdec = voltage;
> Not sure why these last two lines aren't combined?
Will do.
>
>> +
>> +	return 0;
>> +}
>> +
>> +static int qcom_adc_scale_hw_calib_cur(
>> +				const struct vadc_prescale_ratio *prescale,
>> +				const struct adc_data *data,
>> +				u16 adc_code, int *result_uamps)
>> +{
>> +	s64 voltage = 0, result = 0;
> Both are set in both paths, so don't give them values here.
> I would have expected sparse or similar to have picked up on this.
> Please run them on patches before sending out.
Ok.
>
>> +
> This code is 'unusual', please provide some docs on what the two options
> actually are and why they are different.
The data is provided in 2's complement format, with polarity convention
as positive current and negative current (current going into the battery).
Will add this comment as document.
>
>> +	if ((adc_code & ADC_USR_DATA_CHECK) == 0) {
>> +		voltage = (s64) adc_code * data->full_scale_code_cur * 1000;
>> +		voltage = div64_s64(voltage, VADC5_MAX_CODE);
>> +		voltage = voltage * prescale->den;
>> +		result = div64_s64(voltage, prescale->num);
>> +		*result_uamps = result;
>> +	} else {
>> +		adc_code = ~adc_code + 1;
> 2's comp negation? Followed at the end by negation - my immediate
> thought is that this would give exactly the same answer as the
> above path.. What am I missing?
The measurement data is provided in 2's complement format.
We convert the negative number to decimal, apply the scaling
factor and negative sign is placed in front of the final result.
>
>> +		voltage = (s64) adc_code;
> Huh?  You assign voltage then wipe it out on the next line.
>
> There is a lot of sharing between the two paths here.  Only the first and last
> statements are different.  Hmm. I'm torn on whether it would improve
> or hurt readability to have two if blocks (at start and end) rather than
> the bif if else you have currently.
Will add the two if blocks at the start and end.
>
>
>> +		voltage = (s64) adc_code * data->full_scale_code_cur * 1000;
>> +		voltage = div64_s64(voltage, VADC5_MAX_CODE);
>> +		voltage = voltage * prescale->den;
>> +		result = div64_s64(voltage, prescale->num);
>> +		*result_uamps = -result;
> What does the local variable result give you?  just assign directly.
Ok.
>
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   int qcom_vadc_scale(enum vadc_scale_fn_type scaletype,
>>   		    const struct vadc_linear_graph *calib_graph,
>>   		    const struct vadc_prescale_ratio *prescale,
>> @@ -221,6 +419,37 @@ int qcom_vadc_scale(enum vadc_scale_fn_type scaletype,
>>   }
>>   EXPORT_SYMBOL(qcom_vadc_scale);
>>   
>> +int qcom_vadc_hw_scale(enum vadc_scale_fn_type scaletype,
>> +		    const struct vadc_prescale_ratio *prescale,
>> +		    const struct adc_data *data,
>> +		    u16 adc_code, int *result)
>> +{
>> +	switch (scaletype) {
> Superficially this feels like a case for a function pointer look up
> table. Table will be a little sparse but that shouldn't
> matter and it'll clean the code up here nicely.
Will check.
>
>> +	case SCALE_HW_CALIB_DEFAULT:
>> +		return qcom_vadc_scale_hw_calib_volt(prescale, data,
>> +						adc_code, result);
>> +	case SCALE_HW_CALIB_THERM_100K_PULLUP:
>> +	case SCALE_HW_CALIB_XOTHERM:
>> +		return qcom_vadc_scale_hw_calib_therm(prescale, data,
>> +						adc_code, result);
>> +	case SCALE_HW_CALIB_PMIC_THERM:
>> +		return qcom_vadc_scale_hw_calib_die_temp(prescale, data,
>> +						adc_code, result);
>> +	case SCALE_HW_CALIB_CUR:
>> +		return qcom_adc_scale_hw_calib_cur(prescale, data,
>> +						adc_code, result);
>> +	case SCALE_HW_CALIB_PM5_CHG_TEMP:
>> +		return qcom_vadc_scale_hw_chg5_temp(prescale, data,
>> +						adc_code, result);
>> +	case SCALE_HW_CALIB_PM5_SMB_TEMP:
>> +		return qcom_vadc_scale_hw_smb_temp(prescale, data,
>> +						adc_code, result);
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +EXPORT_SYMBOL(qcom_vadc_hw_scale);
>> +
>>   int qcom_vadc_decimation_from_dt(u32 value)
>>   {
>>   	if (!is_power_of_2(value) || value < VADC_DECIMATION_MIN ||
>> @@ -231,5 +460,17 @@ int qcom_vadc_decimation_from_dt(u32 value)
>>   }
>>   EXPORT_SYMBOL(qcom_vadc_decimation_from_dt);
>>   
>> +int qcom_adc5_decimation_from_dt(u32 value, const unsigned int *decimation)
>> +{
>> +	uint32_t i;
>> +
>> +	for (i = 0; i < ADC_DECIMATION_SAMPLES_MAX; i++) {
> Hmm. I would like to see the arrays fed to this clearly using the
> same limits as here.  Right now the code looks fragile to any
> new device where that number is not 3.
Will check.
>> +		if (value == decimation[i])
>> +			return i;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +EXPORT_SYMBOL(qcom_adc5_decimation_from_dt);
> Blank line here would help readability as the next line is not really connected
> to the previous one.
Ok.
>
>>   MODULE_LICENSE("GPL v2");
>>   MODULE_DESCRIPTION("Qualcomm ADC common functionality");
>> diff --git a/drivers/iio/adc/qcom-vadc-common.h b/drivers/iio/adc/qcom-vadc-common.h
>> index 1d5354f..7391bcd 100644
>> --- a/drivers/iio/adc/qcom-vadc-common.h
>> +++ b/drivers/iio/adc/qcom-vadc-common.h
>> @@ -22,18 +22,34 @@
>>   #define VADC_DEF_HW_SETTLE_TIME			0 /* 0 us */
>>   #define VADC_DEF_AVG_SAMPLES			0 /* 1 sample */
>>   #define VADC_DEF_CALIB_TYPE			VADC_CALIB_ABSOLUTE
>> +#define VADC_DEF_VBAT_PRESCALING		1 /* 1:3 */
>>   
>>   #define VADC_DECIMATION_MIN			512
>>   #define VADC_DECIMATION_MAX			4096
>> +#define ADC5_DECIMATION_SHORT			250
>> +#define ADC5_DECIMATION_MEDIUM			420
>> +#define ADC5_DECIMATION_LONG			840
>> +/* Default decimation - 1024 for rev2, 840 for pmic5 */
>> +#define ADC_DECIMATION_DEFAULT			2
>> +#define ADC_DECIMATION_SAMPLES_MAX		3
>>   
>>   #define VADC_HW_SETTLE_DELAY_MAX		10000
>> +#define VADC_HW_SETTLE_SAMPLES_MAX		16
>>   #define VADC_AVG_SAMPLES_MAX			512
>> +#define ADC5_AVG_SAMPLES_MAX			16
>>   
>>   #define KELVINMIL_CELSIUSMIL			273150
>> +#define PMIC5_CHG_TEMP_SCALE_FACTOR		377500
>> +#define PMIC5_SMB_TEMP_CONSTANT			419400
>> +#define PMIC5_SMB_TEMP_SCALE_FACTOR		356
>>   
>>   #define PMI_CHG_SCALE_1				-138890
>>   #define PMI_CHG_SCALE_2				391750000000LL
>>   
>> +#define VADC5_MAX_CODE				0x7fff
>> +#define VADC5_FULL_SCALE_CODE			0x70e4
>> +#define ADC_USR_DATA_CHECK			0x8000
>> +
>>   /**
>>    * struct vadc_map_pt - Map the graph representation for ADC channel
>>    * @x: Represent the ADC digitized code.
>> @@ -89,6 +105,19 @@ struct vadc_prescale_ratio {
>>    * SCALE_PMIC_THERM: Returns result in milli degree's Centigrade.
>>    * SCALE_XOTHERM: Returns XO thermistor voltage in millidegC.
>>    * SCALE_PMI_CHG_TEMP: Conversion for PMI CHG temp
>> + * SCALE_HW_CALIB_DEFAULT: Default scaling to convert raw adc code to
>> + *	voltage (uV) with hardware applied offset/slope values to adc code.
>> + * SCALE_HW_CALIB_THERM_100K_PULLUP: Returns temperature in millidegC using
>> + *	lookup table. The hardware applies offset/slope to adc code.
>> + * SCALE_HW_CALIB_XOTHERM: Returns XO thermistor voltage in millidegC using
>> + *	100k pullup. The hardware applies offset/slope to adc code.
>> + * SCALE_HW_CALIB_PMIC_THERM: Returns result in milli degree's Centigrade.
>> + *	The hardware applies offset/slope to adc code.
>> + * SCALE_HW_CALIB_CUR: Returns result in uA for PMIC5.
>> + * SCALE_HW_CALIB_PM5_CHG_TEMP: Returns result in millidegrees for PMIC5
>> + *	charger temperature.
>> + * SCALE_HW_CALIB_PM5_SMB_TEMP: Returns result in millidegrees for PMIC5
>> + *	SMB1390 temperature.
>>    */
>>   enum vadc_scale_fn_type {
>>   	SCALE_DEFAULT = 0,
>> @@ -96,6 +125,21 @@ enum vadc_scale_fn_type {
>>   	SCALE_PMIC_THERM,
>>   	SCALE_XOTHERM,
>>   	SCALE_PMI_CHG_TEMP,
>> +	SCALE_HW_CALIB_DEFAULT,
>> +	SCALE_HW_CALIB_THERM_100K_PULLUP,
>> +	SCALE_HW_CALIB_XOTHERM,
>> +	SCALE_HW_CALIB_PMIC_THERM,
>> +	SCALE_HW_CALIB_CUR,
>> +	SCALE_HW_CALIB_PM5_CHG_TEMP,
>> +	SCALE_HW_CALIB_PM5_SMB_TEMP,
>> +};
>> +
>> +struct adc_data {
>> +	const u32	full_scale_code_volt;
>> +	const u32	full_scale_code_cur;
>> +	const struct adc_channels *adc_chans;
>> +	unsigned int	*decimation;
>> +	unsigned int	*hw_settle;
>>   };
>>   
>>   int qcom_vadc_scale(enum vadc_scale_fn_type scaletype,
>> @@ -104,6 +148,13 @@ int qcom_vadc_scale(enum vadc_scale_fn_type scaletype,
>>   		    bool absolute,
>>   		    u16 adc_code, int *result_mdec);
>>   
>> +int qcom_vadc_hw_scale(enum vadc_scale_fn_type scaletype,
>> +		    const struct vadc_prescale_ratio *prescale,
>> +		    const struct adc_data *data,
>> +		    u16 adc_code, int *result_mdec);
>> +
>>   int qcom_vadc_decimation_from_dt(u32 value);
>>   
>> +int qcom_adc5_decimation_from_dt(u32 value, const unsigned int *decimation);
>> +
>>   #endif /* QCOM_VADC_COMMON_H */
>> diff --git a/include/dt-bindings/iio/qcom,spmi-vadc.h b/include/dt-bindings/iio/qcom,spmi-vadc.h
>> index 42121fa..4aa35de 100644
>> --- a/include/dt-bindings/iio/qcom,spmi-vadc.h
>> +++ b/include/dt-bindings/iio/qcom,spmi-vadc.h
>> @@ -1,5 +1,5 @@
>>   /*
>> - * Copyright (c) 2012-2014, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2012-2014,2018 The Linux Foundation. All rights reserved.
>>    *
>>    * This program is free software; you can redistribute it and/or modify
>>    * it under the terms of the GNU General Public License version 2 and
>> @@ -116,4 +116,117 @@
>>   #define VADC_LR_MUX10_PU1_PU2_AMUX_USB_ID	0xf9
>>   #define VADC_LR_MUX3_BUF_PU1_PU2_XO_THERM	0xfc
>>   
>> +/* ADC channels for SPMI VADC5*/
> Check general comment formatting.  Should be a space before the */
Ok.
>
>> +
>> +#define ADC_REF_GND				0x00
> Given these are all being added to a generic(ish) header and only
> apply to this new part, we should give them a prefix that makes this
> clear.
Will prefix it with ADC5.
>
>> +#define ADC_1P25VREF				0x01
>> +#define ADC_VREF_VADC				0x02
>> +#define ADC_VREF_VADC_DIV_3			0x82
>> +#define ADC_VPH_PWR				0x83
>> +#define ADC_VBAT_SNS				0x84
>> +#define ADC_VCOIN				0x85
>> +#define ADC_DIE_TEMP				0x06
>> +#define ADC_USB_IN_I				0x07
>> +#define ADC_USB_IN_V_16				0x08
>> +#define ADC_CHG_TEMP				0x09
>> +#define ADC_BAT_THERM				0x0a
>> +#define ADC_BAT_ID				0x0b
>> +#define ADC_XO_THERM				0x0c
>> +#define ADC_AMUX_THM1				0x0d
>> +#define ADC_AMUX_THM2				0x0e
>> +#define ADC_AMUX_THM3				0x0f
>> +#define ADC_AMUX_THM4				0x10
>> +#define ADC_AMUX_THM5				0x11
>> +#define ADC_GPIO1				0x12
>> +#define ADC_GPIO2				0x13
>> +#define ADC_GPIO3				0x14
>> +#define ADC_GPIO4				0x15
>> +#define ADC_GPIO5				0x16
>> +#define ADC_GPIO6				0x17
>> +#define ADC_GPIO7				0x18
>> +#define ADC_SBUx				0x99
>> +#define ADC_MID_CHG_DIV6			0x1e
>> +#define ADC_OFF					0xff
>> +
>> +/* 30k pull-up1 */
> I'd prefer to see the 30k value in the names.
>
> XXX_ADC_BAT_THERM_30K_PU perhaps or something like that?
Ok.
>
>> +#define ADC_BAT_THERM_PU1			0x2a
>> +#define ADC_BAT_ID_PU1				0x2b
>> +#define ADC_XO_THERM_PU1			0x2c
>> +#define ADC_AMUX_THM1_PU1			0x2d
>> +#define ADC_AMUX_THM2_PU1			0x2e
>> +#define ADC_AMUX_THM3_PU1			0x2f
>> +#define ADC_AMUX_THM4_PU1			0x30
>> +#define ADC_AMUX_THM5_PU1			0x31
>> +#define ADC_GPIO1_PU1				0x32
>> +#define ADC_GPIO2_PU1				0x33
>> +#define ADC_GPIO3_PU1				0x34
>> +#define ADC_GPIO4_PU1				0x35
>> +#define ADC_GPIO5_PU1				0x36
>> +#define ADC_GPIO6_PU1				0x37
>> +#define ADC_GPIO7_PU1				0x38
>> +#define ADC_SBUx_PU1				0x39
>> +
>> +/* 100k pull-up2 */
>> +#define ADC_BAT_THERM_PU2			0x4a
>> +#define ADC_BAT_ID_PU2				0x4b
>> +#define ADC_XO_THERM_PU2			0x4c
>> +#define ADC_AMUX_THM1_PU2			0x4d
>> +#define ADC_AMUX_THM2_PU2			0x4e
>> +#define ADC_AMUX_THM3_PU2			0x4f
>> +#define ADC_AMUX_THM4_PU2			0x50
>> +#define ADC_AMUX_THM5_PU2			0x51
>> +#define ADC_GPIO1_PU2				0x52
>> +#define ADC_GPIO2_PU2				0x53
>> +#define ADC_GPIO3_PU2				0x54
>> +#define ADC_GPIO4_PU2				0x55
>> +#define ADC_GPIO5_PU2				0x56
>> +#define ADC_GPIO6_PU2				0x57
>> +#define ADC_GPIO7_PU2				0x58
>> +#define ADC_SBUx_PU2				0x59
>> +
>> +/* 400k pull-up3 */
>> +#define ADC_BAT_THERM_PU3			0x6a
>> +#define ADC_BAT_ID_PU3				0x6b
>> +#define ADC_XO_THERM_PU3			0x6c
>> +#define ADC_AMUX_THM1_PU3			0x6d
>> +#define ADC_AMUX_THM2_PU3			0x6e
>> +#define ADC_AMUX_THM3_PU3			0x6f
>> +#define ADC_AMUX_THM4_PU3			0x70
>> +#define ADC_AMUX_THM5_PU3			0x71
>> +#define ADC_GPIO1_PU3				0x72
>> +#define ADC_GPIO2_PU3				0x73
>> +#define ADC_GPIO3_PU3				0x74
>> +#define ADC_GPIO4_PU3				0x75
>> +#define ADC_GPIO5_PU3				0x76
>> +#define ADC_GPIO6_PU3				0x77
>> +#define ADC_GPIO7_PU3				0x78
>> +#define ADC_SBUx_PU3				0x79
>> +
>> +/* 1/3 Divider */
>> +#define ADC_GPIO1_DIV3				0x92
>> +#define ADC_GPIO2_DIV3				0x93
>> +#define ADC_GPIO3_DIV3				0x94
>> +#define ADC_GPIO4_DIV3				0x95
>> +#define ADC_GPIO5_DIV3				0x96
>> +#define ADC_GPIO6_DIV3				0x97
>> +#define ADC_GPIO7_DIV3				0x98
>> +#define ADC_SBUx_DIV3				0x99
>> +
>> +/* Current and combined current/voltage channels */
>> +#define ADC_INT_EXT_ISENSE			0xa1
>> +#define ADC_PARALLEL_ISENSE			0xa5
>> +#define ADC_CUR_REPLICA_VDS			0xa7
>> +#define ADC_CUR_SENS_BATFET_VDS_OFFSET		0xa9
>> +#define ADC_CUR_SENS_REPLICA_VDS_OFFSET		0xab
>> +#define ADC_EXT_SENS_OFFSET			0xad
>> +
>> +#define ADC_INT_EXT_ISENSE_VBAT_VDATA		0xb0
>> +#define ADC_INT_EXT_ISENSE_VBAT_IDATA		0xb1
>> +#define ADC_EXT_ISENSE_VBAT_VDATA		0xb2
>> +#define ADC_EXT_ISENSE_VBAT_IDATA		0xb3
>> +#define ADC_PARALLEL_ISENSE_VBAT_VDATA		0xb4
>> +#define ADC_PARALLEL_ISENSE_VBAT_IDATA		0xb5
>> +
>> +#define ADC_MAX_CHANNEL				0xc0
>> +
>>   #endif /* _DT_BINDINGS_QCOM_SPMI_VADC_H */
