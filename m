Return-Path: <SRS0=EkxA=E4=gmail.com=embed3d@kernel.org>
Subject: Re: [PATCH v2 07/16] iio: adc: sun4i-gpadc-iio: rework: support nvmem
 calibration data
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
 wens@csie.org, linux@armlinux.org.uk, jic23@kernel.org, knaack.h@gmx.de,
 lars@metafoo.de, pmeerw@pmeerw.net, davem@davemloft.net,
 hans.verkuil@cisco.com, mchehab@kernel.org, rask@formelder.dk,
 clabbe.montjoie@gmail.com, sean@mess.org, krzk@kernel.org,
 quentin.schulz@free-electrons.com, icenowy@aosc.io, edu.molinas@gmail.com,
 singhalsimran0@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
References: <20180128232919.12639-1-embed3d@gmail.com>
 <20180128232919.12639-8-embed3d@gmail.com>
 <20180129094045.sagz2dnzvdadd4yx@flea.lan>
 <e319fde5-9ede-8be0-03ae-f0a22d50250c@gmail.com>
 <20180130083642.cdpd7jnthkdrrk5r@flea.lan>
From: Philipp Rossak <embed3d@gmail.com>
Message-ID: <aacb720f-2337-a016-e4e2-d99bd8da420b@gmail.com>
Date: Fri, 2 Feb 2018 16:24:49 +0100
MIME-Version: 1.0
In-Reply-To: <20180130083642.cdpd7jnthkdrrk5r@flea.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>


>>
>>>>    	/* prevents concurrent reads of temperature and ADC */
>>>>    	struct mutex			mutex;
>>>>    	struct thermal_zone_device	*tzd;
>>>> @@ -561,6 +569,9 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
>>>>    	struct resource *mem;
>>>>    	void __iomem *base;
>>>>    	int ret;
>>>> +	struct nvmem_cell *cell;
>>>> +	ssize_t cell_size;
>>>> +	u64 *cell_data;
>>>>    	info->data = of_device_get_match_data(&pdev->dev);
>>>>    	if (!info->data)
>>>> @@ -575,6 +586,39 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
>>>>    	if (IS_ERR(base))
>>>>    		return PTR_ERR(base);
>>>> +	info->has_calibration_data[0] = false;
>>>> +	info->has_calibration_data[1] = false;
>>>> +
>>>> +	if (!info->data->supports_nvmem)
>>>> +		goto no_nvmem;
>>>> +
>>>> +	cell = nvmem_cell_get(&pdev->dev, "calibration");
>>>> +	if (IS_ERR(cell)) {
>>>> +		if (PTR_ERR(cell) == -EPROBE_DEFER)
>>>> +			return PTR_ERR(cell);
>>>> +		goto no_nvmem;
>>>
>>> goto considered evil ? :)
>>
>> this was a suggestion from Jonatan in version one, to make the code better
>> readable.
> 
> Isn't
> 
> if (info->data->supports_nvmem && IS_ERR(cell = nvmem_cell_get()))
> 
> pretty much the same thing?
> 
> Maxime
> 
I would say :

if (info->data->supports_nvmem && !IS_ERR(cell = nvmem_cell_get())) is

the same.
This would require an else if statement like this:

else if (info->data->supports_nvmem && PTR_ERR(cell) == -EPROBE_DEFER)
		return PTR_ERR(cell);

to avoid errors if the thermal sensor is probed before the sid driver.

Philipp
