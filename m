Return-Path: <SRS0=BDVa=EY=gmail.com=embed3d@kernel.org>
Subject: Re: [PATCH v2 10/16] iio: adc: sun4i-gpadc-iio: add support for A83T
 thermal sensor
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
 <20180128232919.12639-11-embed3d@gmail.com>
 <20180129094803.uiojqkmaeuihbe4p@flea.lan>
From: Philipp Rossak <embed3d@gmail.com>
Message-ID: <94bc070d-8675-95fe-2857-188f7cc66071@gmail.com>
Date: Mon, 29 Jan 2018 12:53:48 +0100
MIME-Version: 1.0
In-Reply-To: <20180129094803.uiojqkmaeuihbe4p@flea.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>



On 29.01.2018 10:48, Maxime Ripard wrote:
> On Mon, Jan 29, 2018 at 12:29:13AM +0100, Philipp Rossak wrote:
>> This patch adds support for the A83T ths sensor.
>>
>> The A83T supports interrupts. The interrupt is configured to update the
>> the sensor values every second.
>>
>> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
>> ---
>>   drivers/iio/adc/sun4i-gpadc-iio.c | 38 ++++++++++++++++++++++++++++++++++++++
>>   include/linux/mfd/sun4i-gpadc.h   | 18 ++++++++++++++++++
>>   2 files changed, 56 insertions(+)
>>
>> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
>> index 8196203d65fe..9f7895ba1966 100644
>> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
>> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
>> @@ -170,6 +170,40 @@ static const struct gpadc_data sun8i_h3_ths_data = {
>>   		SUN8I_H3_THS_TEMP_PERIOD(0x7),
>>   };
>>   
>> +static const struct gpadc_data sun8i_a83t_ths_data = {
>> +	.temp_offset = -2724,
>> +	.temp_scale = -70,
>> +	.temp_data = {SUN8I_H3_THS_TDATA0,
>> +		SUN8I_A83T_THS_TDATA1,
>> +		SUN8I_A83T_THS_TDATA2,
>> +		0},
>> +	.sample_start = sunxi_ths_sample_start,
>> +	.sample_end = sunxi_ths_sample_end,
>> +	.sensor_count = 3,
>> +	.supports_nvmem = false,
>> +	.support_irq = true,
>> +	.ctrl0_map = SUN4I_GPADC_CTRL0_T_ACQ(0x1f3),
>> +	.ctrl2_map = SUN8I_H3_THS_ACQ1(0x1f3),
> 
> Where are these values coming from?
> 

These values are calculated with the formulas from the datasheet and 
also tested on hardware. These settings seem ok.

>> +	.sensor_en_map = SUN8I_H3_THS_TEMP_SENSE_EN0 |
>> +		SUN8I_A83T_THS_TEMP_SENSE_EN1 |
>> +		SUN8I_A83T_THS_TEMP_SENSE_EN2,
>> +	.filter_map = SUN4I_GPADC_CTRL3_FILTER_EN |
>> +		SUN4I_GPADC_CTRL3_FILTER_TYPE(0x2),
>> +	.irq_clear_map = SUN8I_H3_THS_INTS_ALARM_INT_0 |
>> +		SUN8I_A83T_THS_INTS_ALARM_INT_1 |
>> +		SUN8I_A83T_THS_INTS_ALARM_INT_2 |
>> +		SUN8I_H3_THS_INTS_SHUT_INT_0  |
>> +		SUN8I_A83T_THS_INTS_SHUT_INT_1  |
>> +		SUN8I_A83T_THS_INTS_SHUT_INT_2  |
>> +		SUN8I_H3_THS_INTS_TDATA_IRQ_0 |
>> +		SUN8I_A83T_THS_INTS_TDATA_IRQ_1 |
>> +		SUN8I_A83T_THS_INTS_TDATA_IRQ_2,
> 
> Do you reall need to clear all these interrupts if you're using only
> one?
> 

No, I don't think so, I will remove them in the next version.

> Maxime
> 

Philipp
