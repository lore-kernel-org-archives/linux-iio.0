Return-Path: <lars@metafoo.de>
Message-ID: <5295AB51.4050804@metafoo.de>
Date: Wed, 27 Nov 2013 09:20:33 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Fugang Duan <fugang.duan@freescale.com>
CC: "jic23@kernel.org" <jic23@kernel.org>,
 "sachin.kamat@linaro.org" <sachin.kamat@linaro.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
 Frank Li <Frank.Li@freescale.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] iio:adc:imx: add Freescale Vybrid vf610 adc driver
References: <1385463394-11157-1-git-send-email-B38611@freescale.com> <1385463394-11157-3-git-send-email-B38611@freescale.com> <52948B45.7030505@metafoo.de> <9848F2DB572E5649BA045B288BE08FBE01898C41@039-SN2MPN1-023.039d.mgd.msft.net>
In-Reply-To: <9848F2DB572E5649BA045B288BE08FBE01898C41@039-SN2MPN1-023.039d.mgd.msft.net>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 11/27/2013 05:44 AM, Fugang Duan wrote:
[...]
>>> +	if (info->vref)
>>> +		info->vref_uv = regulator_get_voltage(info->vref);
>>> +	else if (of_property_read_u32(np, "fsl,adc-vref", &info->vref_uv))
>>> +		dev_err(info->dev,
>>> +			"Miss adc-vref property or vref regulator in the DT.\n");
>>
>> If you have a fixed reference voltage use the fixed voltage regulator. Don't
>> invent custom ways of specifying this.
>>
> Different boards design may use different method to supply the reference voltage.
> There maybe fixed voltage regulator, maybe no regulator just use fixed voltage.

Well the voltage has to come from somewhere and that source should be
described in the DT with a fixed regulator.

> 
>>> +
>>> +	if (of_property_read_u32(np, "fsl,adc-clk-div",
>>> +			&info->adc_feature.clk_div_num)) {
>>> +		info->adc_feature.clk_div_num = 2;
>>> +		dev_info(info->dev,
>>> +			"Miss adc-clk-div in dt, set divider to 2.\n");
>>> +	}
>>> +
>>> +	if (of_property_read_u32(np, "fsl,adc-res",
>>> +			&info->adc_feature.res_mode)) {
>>> +		info->adc_feature.res_mode = 12;
>>> +		dev_info(info->dev,
>>> +			"Miss adc-res property in dt, use 8bit mode.\n");
>>> +	}
>>> +
>>> +	if (of_property_read_u32(np, "fsl,adc-sam-time",
>>> +			&info->adc_feature.sam_time)) {
>>> +		info->adc_feature.sam_time = 4;
>>> +		dev_info(info->dev,
>>> +			"Miss adc-sam-time property in dt, set to 4.\n");
>>> +	}
>>> +
>>> +	info->adc_feature.hw_average = of_property_read_bool(np,
>>> +					"fsl,adc-hw-aver-en");
>>> +	if (info->adc_feature.hw_average &&
>>> +		 of_property_read_u32(np, "fsl,adc-aver-sam-sel",
>>> +				&info->adc_feature.hw_sam)) {
>>> +		info->adc_feature.hw_sam = 4;
>>> +		dev_info(info->dev,
>>> +			"Miss adc-aver-sam-sel property in dt, set to 4.\n");
>>> +	}
>>> +
>>> +	info->adc_feature.lpm = of_property_read_bool(np, "fsl,adc-low-power-
>> mode");
>>> +	info->adc_feature.hs_oper = of_property_read_bool(np,
>>> +"fsl,adc-high-speed-conv");
>>
>> Some of the properties look like they should be runtime configurable rather
>> then board specific settings. E.g. the resolution or the sampling frequency, or
>> whether averaging is enabled.
>>
>>
> So, I have question:
> Since the ADC have many user configurable setting, I have import some of them from DT, and some of them use static define.
> How to set/change them in runtime for user configuration ? 
> Introduce ioctl ?

I think a lot of them already map to standard iio properties. E.g. the
samplerate. So you'd expose them as sysfs attributes. But please use
standard attributes here instead of inventing your own with cryptic names.

- Lars
