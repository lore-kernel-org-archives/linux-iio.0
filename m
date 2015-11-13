Return-Path: <lars@metafoo.de>
Message-ID: <5645B2E8.8070906@metafoo.de>
Date: Fri, 13 Nov 2015 10:52:40 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Haibo Chen <haibo.chen@freescale.com>
CC: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
 ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
 shawnguo@kernel.org, kernel@pengutronix.de, linux@arm.linux.org.uk,
 jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/4] iio: adc: add IMX7D ADC driver support
References: <1447075704-4605-1-git-send-email-haibo.chen@freescale.com> <1447075704-4605-2-git-send-email-haibo.chen@freescale.com> <56420606.4070505@metafoo.de> <20151113093934.GA21068@b51421-server.ap.freescale.net>
In-Reply-To: <20151113093934.GA21068@b51421-server.ap.freescale.net>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 11/13/2015 10:39 AM, Haibo Chen wrote:
[...]
>>> +static void imx7d_adc_feature_config(struct imx7d_adc *info)
>>> +{
>>> +	info->adc_feature.clk_pre_div = IMX7D_ADC_ANALOG_CLK_PRE_DIV_4;
>>> +	info->adc_feature.avg_num = IMX7D_ADC_AVERAGE_NUM_32;
>>> +	info->adc_feature.core_time_unit = 1;
>>> +	info->adc_feature.average_en = true;
>>
>> What's the plan for these? Right now they are always initialized to the same
>> static value.
>>
> 
> In future, we can get these values from dts file, currently we just use the static value.

Those seem to be software configuration values though, not part of hardware
description.

> 
>>
>>> +}
>> [...]
>>> +static int imx7d_adc_read_raw(struct iio_dev *indio_dev,
>>> +			struct iio_chan_spec const *chan,
>>> +			int *val,
>>> +			int *val2,
>>> +			long mask)
>>> +{
>>> +	struct imx7d_adc *info = iio_priv(indio_dev);
>>> +
>>> +	u32 channel;
>>> +	long ret;
>>> +
>>> +	switch (mask) {
>>> +	case IIO_CHAN_INFO_RAW:
>>> +		mutex_lock(&indio_dev->mlock);
>>> +		reinit_completion(&info->completion);
>>> +
>>> +		channel = (chan->channel) & 0x0f;
>>> +		info->channel = channel;
>>> +		imx7d_adc_channel_set(info);
>>
>> How about just passing channel directy adc_channel_set() instead of doing it
>> implicitly through the info struct?
>>
> 
> I think there is no difference, besides, using this parameter info struct can keep align with other functions.
> eg.  imx7d_adc_sample_set(), imx7d_adc_hw_init(), imx7d_adc_get_sample_rate(), all these functions have the same parameter.
> 
>> [...]
>>> +static irqreturn_t imx7d_adc_isr(int irq, void *dev_id)
>>> +{
>>> +	struct imx7d_adc *info = (struct imx7d_adc *)dev_id;
>>> +	int status;
>>> +
>>> +	status = readl(info->regs + IMX7D_REG_ADC_INT_STATUS);
>>> +	if (status & IMX7D_REG_ADC_INT_STATUS_CHANNEL_INT_STATUS) {
>>> +		info->value = imx7d_adc_read_data(info);
>>> +		complete(&info->completion);
>>> +	}
>>> +	writel(0, info->regs + IMX7D_REG_ADC_INT_STATUS);
>>
>> Is the hardware really this broken? If the interrupt happens between reading
>> the status register and clearing it here it will be missed.
>>
> 
> I think interrupt can't happen between reading the status register and clearing it.
> Because in function imx7d_adc_read_raw(), we call the function 
> imx7d_adc_channel_set(info), in this function, we config the register
> REG_ADC_CH_A\B\C\D_CFG1 and REG_ADC_CH_A\B\C\D_CFG2, only when these registers
> is configed, ADC start a conversion. Once the conversion complete, ADC trigger an 
> interrupt, and call the imx7d_adc_isr().

Well an interrupt can always happen, its running fully asynchronous to the
CPU. If you have multiple interrupt sources enabled and the first one fires
and you run then start the irq handler, read the status register, now the
second irq sources fires, and then you clear the status interrupt register.
This means the driver will not see the irq from the second source.

> 
>>> +
>>> +	return IRQ_HANDLED;
>>
>> You should only return IRQ_HANDLED if you actually handled are interrupt.
>>
> 
> Here in the interrupt, we just handle the channel conversion finished flag, for
> other flag, ignore them this time, Will add other flag in future.

Yeah, but if you don't handle any interrupt you should return IRQ_NONE. This
will make sure that the system can recover in case the hardware (or the
driver) is broken and generates unexpected interrupts. If there are a 1000
or so IRQ_NONEs in a row in a short time frame the kernel will disable the IRQ.

>> [...]
>>> +	ret  = of_property_read_u32(pdev->dev.of_node,
>>
>> Extra space.
>>
>>> +					"num-channels", &channels);
>>
>> What decides how many channels are in use?
>>
> 
> The board decides the channel number.
> In dts file, there is a line:     num-channels = <4>;

Yes, but what decides how this property should be configured?

> 
> 
>>> +	if (ret)
>>> +		channels = ARRAY_SIZE(imx7d_adc_iio_channels);
>>> +
>>> +	indio_dev->name = dev_name(&pdev->dev);
>>> +	indio_dev->dev.parent = &pdev->dev;
>>> +	indio_dev->dev.of_node = pdev->dev.of_node;
>>> +	indio_dev->info = &imx7d_adc_iio_info;
>>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>>> +	indio_dev->channels = imx7d_adc_iio_channels;
>>> +	indio_dev->num_channels = (int)channels;
>>
>> I don't think you need the case here.
>>
> 
> Sorry, can't get your point, you mean I should not indio_dev-> ?

Sorry, I meant the (int) cast.

> 
>>> [...]
> 
