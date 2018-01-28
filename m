Return-Path: <SRS0=zW5g=EX=gmail.com=embed3d@kernel.org>
Subject: Re: [PATCH 07/16] iio: adc: sun4i-gpadc-iio: rework: support nvmem
 calibration data
To: Icenowy Zheng <icenowy@aosc.io>, linux-arm-kernel@lists.infradead.org,
 Jonathan Cameron <jic23@kernel.org>
Cc: mark.rutland@arm.com, sean@mess.org, linux-iio@vger.kernel.org,
 linux-sunxi@googlegroups.com, clabbe.montjoie@gmail.com, pmeerw@pmeerw.net,
 lee.jones@linaro.org, lars@metafoo.de, edu.molinas@gmail.com,
 linux@armlinux.org.uk, krzk@kernel.org, wens@csie.org,
 hans.verkuil@cisco.com, rask@formelder.dk, devicetree@vger.kernel.org,
 mchehab@kernel.org, robh+dt@kernel.org, singhalsimran0@gmail.com,
 linux-kernel@vger.kernel.org, quentin.schulz@free-electrons.com,
 knaack.h@gmx.de, maxime.ripard@free-electrons.com, davem@davemloft.net
References: <20180126151941.12183-1-embed3d@gmail.com>
 <20180126151941.12183-8-embed3d@gmail.com>
 <20180128090258.56e8ac93@archlinux>
 <6ebbb5e0-eb5f-afe4-50e8-eb3cee8ec7fa@gmail.com>
 <1927F24D-D3ED-49CF-9B7C-A7C8C873F0CF@aosc.io>
From: Philipp Rossak <embed3d@gmail.com>
Message-ID: <c6f8c2ac-e1c5-461a-b55d-364e1239beb0@gmail.com>
Date: Sun, 28 Jan 2018 15:39:15 +0100
MIME-Version: 1.0
In-Reply-To: <1927F24D-D3ED-49CF-9B7C-A7C8C873F0CF@aosc.io>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>



On 28.01.2018 14:52, Icenowy Zheng wrote:
> 
> 
> 于 2018年1月28日 GMT+08:00 下午9:46:18, Philipp Rossak <embed3d@gmail.com> 写到:
>>
>>
>> On 28.01.2018 10:02, Jonathan Cameron wrote:
>>> On Fri, 26 Jan 2018 16:19:32 +0100
>>> Philipp Rossak <embed3d@gmail.com> wrote:
>>>
>>>> This patch reworks the driver to support nvmem calibration cells.
>>>> The driver checks if the nvmem calibration is supported and reads
>> out
>>>> the nvmem. At the beginning of the startup process the calibration
>> data
>>>> is written to the related registers.
>>>>
>>>> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
>>>
>>> A few minor suggestions inline.
>>>
>>> Jonathan
>>>
>>>> ---
>>>>    drivers/iio/adc/sun4i-gpadc-iio.c | 52
>> +++++++++++++++++++++++++++++++++++++++
>>>>    include/linux/mfd/sun4i-gpadc.h   |  2 ++
>>>>    2 files changed, 54 insertions(+)
>>>>
>>>> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c
>> b/drivers/iio/adc/sun4i-gpadc-iio.c
>>>> index bff06f2798e8..7b12666cdd9e 100644
>>>> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
>>>> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
>>>> @@ -27,6 +27,7 @@
>>>>    #include <linux/interrupt.h>
>>>>    #include <linux/io.h>
>>>>    #include <linux/module.h>
>>>> +#include <linux/nvmem-consumer.h>
>>>>    #include <linux/of.h>
>>>>    #include <linux/of_device.h>
>>>>    #include <linux/platform_device.h>
>>>> @@ -81,6 +82,7 @@ struct gpadc_data {
>>>>    	bool		has_bus_rst;
>>>>    	bool		has_mod_clk;
>>>>    	int		sensor_count;
>>>> +	bool		supports_nvmem;
>>>>    };
>>>>    
>>>>    static const struct gpadc_data sun4i_gpadc_data = {
>>>> @@ -94,6 +96,7 @@ static const struct gpadc_data sun4i_gpadc_data =
>> {
>>>>    	.sample_start = sun4i_gpadc_sample_start,
>>>>    	.sample_end = sun4i_gpadc_sample_end,
>>>>    	.sensor_count = 1,
>>>> +	.supports_nvmem = false,
>>>>    };
>>>>    
>>>>    static const struct gpadc_data sun5i_gpadc_data = {
>>>> @@ -107,6 +110,7 @@ static const struct gpadc_data sun5i_gpadc_data
>> = {
>>>>    	.sample_start = sun4i_gpadc_sample_start,
>>>>    	.sample_end = sun4i_gpadc_sample_end,
>>>>    	.sensor_count = 1,
>>>> +	.supports_nvmem = false,
>>>>    };
>>>>    
>>>>    static const struct gpadc_data sun6i_gpadc_data = {
>>>> @@ -120,6 +124,7 @@ static const struct gpadc_data sun6i_gpadc_data
>> = {
>>>>    	.sample_start = sun4i_gpadc_sample_start,
>>>>    	.sample_end = sun4i_gpadc_sample_end,
>>>>    	.sensor_count = 1,
>>>> +	.supports_nvmem = false,
>>>>    };
>>>>    
>>>>    static const struct gpadc_data sun8i_a33_gpadc_data = {
>>>> @@ -130,6 +135,7 @@ static const struct gpadc_data
>> sun8i_a33_gpadc_data = {
>>>>    	.sample_start = sun4i_gpadc_sample_start,
>>>>    	.sample_end = sun4i_gpadc_sample_end,
>>>>    	.sensor_count = 1,
>>>> +	.supports_nvmem = false,
> 
> BTW A33 claims to support calibration data according to the manual.
> 

Yes that's true, but I haven't seen a sid/nvmem driver for the a33. If 
that is available, we can change this for true (same on a83t).

>>>>    };
>>>>    
>>>>    struct sun4i_gpadc_iio {
>>>> @@ -148,6 +154,8 @@ struct sun4i_gpadc_iio {
>>>>    	struct clk			*mod_clk;
>>>>    	struct reset_control		*reset;
>>>>    	int				sensor_id;
>>>> +	u32				calibration_data[2];
>>>> +	bool				has_calibration_data[2];
>>>>    	/* prevents concurrent reads of temperature and ADC */
>>>>    	struct mutex			mutex;
>>>>    	struct thermal_zone_device	*tzd;
>>>> @@ -459,6 +467,17 @@ static int sun4i_gpadc_runtime_suspend(struct
>> device *dev)
>>>>    	return info->data->sample_end(info);
>>>>    }
>>>>    
>>>> +static void sunxi_calibrate(struct sun4i_gpadc_iio *info)
>>>> +{
>>>> +	if (info->has_calibration_data[0])
>>>> +		regmap_write(info->regmap, SUNXI_THS_CDATA_0_1,
>>>> +			info->calibration_data[0]);
>>>> +
>>>> +	if (info->has_calibration_data[1])
>>>> +		regmap_write(info->regmap, SUNXI_THS_CDATA_2_3,
>>>> +			info->calibration_data[1]);
>>>> +}
>>>> +
>>>>    static int sun4i_gpadc_sample_start(struct sun4i_gpadc_iio *info)
>>>>    {
>>>>    	/* clkin = 6MHz */
>>>> @@ -481,6 +500,7 @@ static int sun4i_gpadc_sample_start(struct
>> sun4i_gpadc_iio *info)
>>>>    static int sunxi_ths_sample_start(struct sun4i_gpadc_iio *info)
>>>>    {
>>>>    	u32 value;
>>>> +	sunxi_calibrate(info);
>>>>    
>>>>    	if (info->data->ctrl0_map)
>>>>    		regmap_write(info->regmap, SUNXI_THS_CTRL0,
>>>> @@ -602,6 +622,9 @@ static int sun4i_gpadc_probe_dt(struct
>> platform_device *pdev,
>>>>    	struct resource *mem;
>>>>    	void __iomem *base;
>>>>    	int ret;
>>>> +	struct nvmem_cell *cell;
>>>> +	ssize_t cell_size;
>>>> +	u64 *cell_data;
>>>>    
>>>>    	info->data = of_device_get_match_data(&pdev->dev);
>>>>    	if (!info->data)
>>>> @@ -616,6 +639,35 @@ static int sun4i_gpadc_probe_dt(struct
>> platform_device *pdev,
>>>>    	if (IS_ERR(base))
>>>>    		return PTR_ERR(base);
>>>>    
>>>> +	info->has_calibration_data[0] = false;
>>>> +	info->has_calibration_data[1] = false;
>>>> +
>>>> +	if (!info->data->supports_nvmem)
>>>> +		goto no_nvmem;
>>>> +
>>>> +	cell = devm_nvmem_cell_get(&pdev->dev, "calibration");
>>>> +	if (IS_ERR(cell)) {
>>>> +		if (PTR_ERR(cell) == -EPROBE_DEFER)
>>>> +			return PTR_ERR(cell);
>>> Use a goto here to no_nvmem.
>>>
>>> Then you can drop the below else to make things more readable.
>>>> +	} else {
>>>> +		cell_data = (u64 *)nvmem_cell_read(cell, &cell_size);
>>>> +		devm_nvmem_cell_put(&pdev->dev, cell);
>>>
>>> I'm really not keen on use of devm for things we are intending
>>> to drop almost immediately.  Just use the non managed versions
>>> and clean up properly in the error paths (if there are any
>>> where it is needed - which there aren't that I can see)
>>>
>>
>> ^^ Ok, I will rework that.
>>
>>>> +		if (cell_size <= 4) {
>>> Is it valid if it is anything other than 4?
>>
>> For sensors with only one sensor would be also a 2 valid, for those
>> with
>> 2 sensors ==> 4, with 3 sensors ==> 6 and with and with 4 sensors ==>
>> 8.
>>
>> In hardware we have in total to 32bit registers for calibration, thus I
>>
>> thought it would be a good idea to use always four bytes per register.
>> If two bytes are used, they should be the default value.
>>
>> But I agree, this needs a rework.
>>
>>>> +			info->has_calibration_data[0] = true;
>>>> +			info->calibration_data[0] = be32_to_cpu(cell_data[0] &
>>>> +					GENMASK(31, 0));
>>>
>>> Masking isn't needed,  If you want to be paranoid there is the
>> lower_32_bits
>>> function..
>>>
>> ^^ Ok, I will rework that.
>>>> +		} else if (cell_size <= 8) {
>>>> +			info->has_calibration_data[0] = true;
>>>> +			info->calibration_data[0] = be32_to_cpu(cell_data[0] &
>>>> +					GENMASK(31, 0));
>>>
>>> This first block is repeated.  Easy enough to avoid I think...
>>>
>>
>> ^^ Ok, I will rework that.
>>
>>>> +			info->has_calibration_data[1] = true;
>>>> +			info->calibration_data[1] = be32_to_cpu(
>>>> +					(cell_data[0] >> 32) & GENMASK(31, 0));
>>>> +		}
>>>> +	}
>>>> +
>>>> +no_nvmem:
>>>> +
>>>>    	info->regmap = devm_regmap_init_mmio(&pdev->dev, base,
>>>>    					     &sun4i_gpadc_regmap_config);
>>>>    	if (IS_ERR(info->regmap)) {
>>>> diff --git a/include/linux/mfd/sun4i-gpadc.h
>> b/include/linux/mfd/sun4i-gpadc.h
>>>> index 40b4dd9d2405..c251002431bd 100644
>>>> --- a/include/linux/mfd/sun4i-gpadc.h
>>>> +++ b/include/linux/mfd/sun4i-gpadc.h
>>>> @@ -90,6 +90,8 @@
>>>>    #define SUNXI_THS_CTRL0					0x00
>>>>    #define SUNXI_THS_CTRL2					0x40
>>>>    #define SUNXI_THS_FILTER				0x70
>>>> +#define SUNXI_THS_CDATA_0_1				0x74
>>>> +#define SUNXI_THS_CDATA_2_3				0x78
>>>>    #define SUNXI_THS_TDATA0				0x80
>>>>    #define SUNXI_THS_TDATA1				0x84
>>>>    #define SUNXI_THS_TDATA2				0x88
>>>
>> Thanks,
>> Philipp
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
