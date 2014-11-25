Return-Path: <Ezequiel.Garcia@imgtec.com>
Message-ID: <5474FCC8.8080906@imgtec.com>
Date: Tue, 25 Nov 2014 19:03:52 -0300
From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, Andrew Bresticker
	<abrestic@chromium.org>, James Hartley <james.hartley@imgtec.com>,
	"Lars-Peter Clausen" <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<robh+dt@kernel.org>, <Pawel.Moll@arm.com>, <Mark.Rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<Naidu.Tellapati@imgtec.com>, Phani Movva <Phani.Movva@imgtec.com>
Subject: Re: [PATCH v3 1/3] iio: adc: Cosmic Circuits 10001 ADC driver
References: <1415888044-16635-1-git-send-email-ezequiel.garcia@imgtec.com> <1415888044-16635-2-git-send-email-ezequiel.garcia@imgtec.com> <546FE3A7.6040308@gmx.de> <5474C062.2020604@imgtec.com> <5474F7A5.6030008@gmx.de>
In-Reply-To: <5474F7A5.6030008@gmx.de>
Content-Type: text/plain; charset="iso-8859-15"
List-ID: <linux-iio@vger.kernel.org>



On 11/25/2014 06:41 PM, Hartmut Knaack wrote:
>>
>> Unless I'm missing something, that's exactly what XOR does.
>>
>> Example:
>>
>> reserved_channels = 0x2;
>> channel_map = 0x7 ^ reserved_channels -> 0x5
>>
> You miss to check ret for a valid range, which you don't need to do when masking out channels.
> Example:
> reserved_channels = 0x8;
> channel_map = 0x7 ^ reserved_channels -> 0xf
> And this is actually happening in the current revision (with the wrong channel_map assignment), that a reserved channel in DT would become usable.

Right, definitely a check is needed.

>>>> +
>>>> +	adc_dev->reg = devm_regulator_get(&pdev->dev, "vref");
>>>> +	if (IS_ERR_OR_NULL(adc_dev->reg))
>>>> +		return -EINVAL;
>>> 	if (IS_ERR(adc_dev->reg))
>>> 		return PTR_ERR(adc_dev->reg);
>>
>> Are you sure? What if devm_regulator_get() returns NULL?
>>
> I had a look at it, but couldn't figure out a condition in which it would return NULL. But I'd be happy to be informed of anything different.

If CONFIG_REGULATOR=n you get NULL there (although I added a select REGULATOR
on the v4 I just posted).

>>>> +
>>>> +	ret = regulator_enable(adc_dev->reg);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	indio_dev->dev.parent = &pdev->dev;
>>>> +	indio_dev->name = dev_name(&pdev->dev);
>>>> +	indio_dev->info = &cc10001_adc_info;
>>>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>>>> +
>>>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>> +	adc_dev->reg_base = devm_ioremap_resource(&pdev->dev, res);
>>>> +	if (IS_ERR(adc_dev->reg_base))
>>> Need to put error code into ret.
>>
>> Right.
>>
>>>> +		goto err_disable_reg;
>>>> +
>>>> +	adc_dev->adc_clk = devm_clk_get(&pdev->dev, "adc");
>>>> +	if (IS_ERR(adc_dev->adc_clk)) {
>>>> +		dev_err(&pdev->dev, "Failed to get the clock\n");
>>> Need to put error code into ret.
>>>> +		goto err_disable_reg;
>>>> +	}
>>>> +
>>>> +	ret = clk_prepare_enable(adc_dev->adc_clk);
>>>> +	if (ret) {
>>>> +		dev_err(&pdev->dev, "Failed to enable the clock\n");
>>>> +		goto err_disable_reg;
>>>> +	}
>>>> +
>>>> +	adc_clk_rate = clk_get_rate(adc_dev->adc_clk);
>>>> +	if (!adc_clk_rate) {
>>>> +		ret = -EINVAL;
>>>> +		dev_err(&pdev->dev, "null clock rate!\n");
>>> Start message with upper case?
>>
>> Actually, I'd rather make the others start with lower case.
> Fair enough, unless they are full sentences like here. My english grammar tells me they should start with capital letters.

Yeah, but it's not the start of the message, as it's prefixed
with the device stuff.

>>
>>>> +		goto err_disable_clk;
>>>> +	}
>>>> +
>>>> +	adc_dev->eoc_delay_ns = NSEC_PER_SEC / adc_clk_rate;
>>>> +	adc_dev->start_delay_ns = adc_dev->eoc_delay_ns * CC10001_WAIT_CYCLES;
>>>> +
>>>> +	/* Setup the ADC channels available on the device */
>>>> +	ret = cc10001_adc_channel_init(indio_dev);
>>>> +	if (ret < 0) {
>>>> +		dev_err(&pdev->dev, "Could not initialize the channels.\n");
>>>> +		goto err_disable_clk;
>>>> +	}
>>>> +
>>>> +	mutex_init(&adc_dev->lock);
>>>> +
>>>> +	ret = iio_triggered_buffer_setup(indio_dev, NULL,
>>>> +					 &cc10001_adc_trigger_h, NULL);
>>>> +	if (ret < 0)
>>>> +		goto err_disable_clk;
>>>> +
>>>> +	ret = iio_device_register(indio_dev);
>>>> +	if (ret < 0)
>>>> +		goto err_cleanup_buffer;
>>>> +
>>>> +	platform_set_drvdata(pdev, indio_dev);
>>> Move this above iio_device_register.
>>
>> What for?
> To make iio_device_register the last operation of the probe.

I really don't think it matters, since platform_get_drvdata
is only called in the remove.

I'll move it if you think it's worth it, though.

Thanks for the review!
-- 
Ezequiel
