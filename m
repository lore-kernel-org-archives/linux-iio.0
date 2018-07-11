Return-Path: <SRS0=qPZi=J3=codeaurora.org=smohanad@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Wed, 11 Jul 2018 14:12:28 -0700
From: smohanad@codeaurora.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, Hartmut Knaack
 <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter
 Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring <robh+dt@kernel.org>,
 Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 2/2] iio: adc: Add QCOM SPMI PMIC5 ADC driver
In-Reply-To: <20180629233357.GX129942@google.com>
References: <1530210637-16589-1-git-send-email-smohanad@codeaurora.org>
 <20180629233357.GX129942@google.com>
Message-ID: <7eddda616f8091063597ee027082364a@codeaurora.org>
List-ID: <linux-iio@vger.kernel.org>

Hi,

On 2018-06-29 16:33, Matthias Kaehlcke wrote:
> Hi,
> 
> not a full review, just two nits I noticed when glacing over the first
> lines, and more importantly a regression wrt v1 I found while testing.
> 
> On Thu, Jun 28, 2018 at 11:30:37AM -0700, Siddartha Mohanadoss wrote:
>> This patch adds support for QCOM SPMI PMIC5 family
>> of ADC driver that supports hardware based offset and
>> gain compensation. The ADC peripheral can measure both
>> voltage and current channels whose input signal is
>> connected to the PMIC ADC AMUX.
>> 
>> The register set and configuration has been refreshed
>> compared to the prior QCOM PMIC ADC family. Register
>> ADC5 as part of the IIO framework.
>> 
>> Signed-off-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
>> ---
>>  drivers/iio/adc/Kconfig            |  20 +
>>  drivers/iio/adc/Makefile           |   1 +
>>  drivers/iio/adc/qcom-spmi-adc5.c   | 878 
>> +++++++++++++++++++++++++++++++++++++
>>  drivers/iio/adc/qcom-vadc-common.c | 230 +++++++++-
>>  drivers/iio/adc/qcom-vadc-common.h |  56 +++
>>  5 files changed, 1180 insertions(+), 5 deletions(-)
>>  create mode 100644 drivers/iio/adc/qcom-spmi-adc5.c
>> 
>> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>> index 28a9423..9533a82 100644
>> --- a/drivers/iio/adc/Makefile
>> +++ b/drivers/iio/adc/Makefile
>> @@ -56,6 +56,7 @@ obj-$(CONFIG_PALMAS_GPADC) += palmas_gpadc.o
>>  obj-$(CONFIG_QCOM_SPMI_IADC) += qcom-spmi-iadc.o
>>  obj-$(CONFIG_QCOM_VADC_COMMON) += qcom-vadc-common.o
>>  obj-$(CONFIG_QCOM_SPMI_VADC) += qcom-spmi-vadc.o
>> +obj-$(CONFIG_QCOM_SPMI_ADC5) += qcom-spmi-adc5.o
> 
> In general this file uses alphabetical ordering, though the QCOM
> drivers don't respect that. Still no reason to continue with the
> tradition, best insert this one before CONFIG_QCOM_SPMI_IADC.

Sure, will add it before CONFIG_QCOM_SPMI_IADC.

> 
>> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c 
>> b/drivers/iio/adc/qcom-spmi-adc5.c
>> new file mode 100644
>> index 0000000..75308df
>> --- /dev/null
>> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
>> @@ -0,0 +1,878 @@
>> +/*
>> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or 
>> modify
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
> 
> Move 'log2.h' to it's position in alphabetical order, i.e. after 
> 'kernel.h'

Ok.

> 
>> +static int adc5_get_dt_data(struct adc5_chip *adc, struct device_node 
>> *node)
>> +{
>> +	const struct adc_channels *adc_chan;
>> +	struct iio_chan_spec *iio_chan;
>> +	struct adc5_channel_prop prop;
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
>> +	id = of_match_node(adc5_match_table, node);
>> +	if (id)
>> +		data = id->data;
>> +	else
>> +		data = &data_pmic5;
>> +	adc->data = data;
>> +
>> +	for_each_available_child_of_node(node, child) {
>> +		ret = adc5_get_dt_channel_data(adc, &prop, child, data);
>> +		if (ret) {
>> +			of_node_put(child);
>> +			return ret;
>> +		}
>> +
>> +		prop.scale_fn_type =
>> +			data->adc_chans[prop.channel].scale_fn_type;
>> +		adc->chan_props = &prop;
> 
> I suppose this intends to address Jonathan's comment about array
> access vs pointer arithmetics on v1.
> 
> However it overwrites the address of the memory we allocated above
> with the address of the stack object 'prop'.

Thanks for the catch. Will fix this.

> 
> You probably want to create a chan_props pointer and change the
> assignment to:
> 
> *chan_props = prop;
> 
>> +		adc_chan = &data->adc_chans[prop.channel];
>> +
>> +		iio_chan->channel = prop.channel;
>> +		iio_chan->datasheet_name = prop.datasheet_name;
>> +		iio_chan->extend_name = prop.datasheet_name;
>> +		iio_chan->info_mask_separate = adc_chan->info_mask;
>> +		iio_chan->type = adc_chan->type;
>> +		iio_chan->address = index;
>> +		iio_chan++;
>> +		adc->chan_props++;
> 
> And this changes the pointer in the adc object. I think you want to do:
> 
> chan_props++;
> 
> Cheers
> 
> Matthias
