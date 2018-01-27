Return-Path: <SRS0=H2ED=EW=gmail.com=embed3d@kernel.org>
Subject: Re: [linux-sunxi] [PATCH 10/16] iio: adc: sun4i-gpadc-iio: add
 support for A83T thermal sensor
To: =?UTF-8?Q?Ond=c5=99ej_Jirman?= <x@xff.cz>
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
 maxime.ripard@free-electrons.com, wens@csie.org, linux@armlinux.org.uk,
 jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 davem@davemloft.net, hans.verkuil@cisco.com, mchehab@kernel.org,
 rask@formelder.dk, clabbe.montjoie@gmail.com, sean@mess.org,
 krzk@kernel.org, quentin.schulz@free-electrons.com, icenowy@aosc.io,
 edu.molinas@gmail.com, singhalsimran0@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
References: <20180126151941.12183-1-embed3d@gmail.com>
 <20180126151941.12183-11-embed3d@gmail.com>
 <20180126174602.qolcswhqblgmlad7@core.my.home>
From: Philipp Rossak <embed3d@gmail.com>
Message-ID: <d00581c9-9e4f-8f01-cb8e-95e7ef17811e@gmail.com>
Date: Sat, 27 Jan 2018 05:30:36 +0100
MIME-Version: 1.0
In-Reply-To: <20180126174602.qolcswhqblgmlad7@core.my.home>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>



On 26.01.2018 18:46, Ondřej Jirman wrote:
> Hi,
> 
> On Fri, Jan 26, 2018 at 04:19:35PM +0100, Philipp Rossak wrote:
>> This patch adds support for the A83T ths sensor.
>>
>> The A83T does not support interrupts. This seems to be broken.
> 
> Though, you use support_irq = true below. And in my tests, IRQ for THS works on
> A83T.
> 
> regards,
>    o.

Oh I totally forgot to update this commit message, after I fixed the 
devicetree and got it running.
I will fix that in the next version of this patch series.

>> The calibration data is writen at the begin of the init process.
>>
>> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
>> ---
>>   drivers/iio/adc/sun4i-gpadc-iio.c | 38 ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>
>> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
>> index f2e0ec65c53e..b8693afcdbea 100644
>> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
>> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
>> @@ -170,6 +170,40 @@ static const struct gpadc_data sun8i_h3_ths_data = {
>>   		SUNXI_THS_TEMP_PERIOD(0x7),
>>   };
>>   
>> +static const struct gpadc_data sun8i_a83t_ths_data = {
>> +	.temp_offset = -2724,
>> +	.temp_scale = -70,
>> +	.temp_data = {SUNXI_THS_TDATA0,
>> +		SUNXI_THS_TDATA1,
>> +		SUNXI_THS_TDATA2,
>> +		0},
>> +	.sample_start = sunxi_ths_sample_start,
>> +	.sample_end = sunxi_ths_sample_end,
>> +	.sensor_count = 3,
>> +	.supports_nvmem = false,
>> +	.support_irq = true,
>> +	.ctrl0_map = SUNXI_THS_ACQ0(0x1f3),
>> +	.ctrl2_map = SUNXI_THS_ACQ1(0x1f3),
>> +	.sensor_en_map = SUNXI_THS_TEMP_SENSE_EN0 |
>> +		SUNXI_THS_TEMP_SENSE_EN1 |
>> +		SUNXI_THS_TEMP_SENSE_EN2,
>> +	.filter_map = SUNXI_THS_FILTER_EN |
>> +		SUNXI_THS_FILTER_TYPE(0x2),
>> +	.irq_clear_map = SUNXI_THS_INTS_ALARM_INT_0 |
>> +		SUNXI_THS_INTS_ALARM_INT_1 |
>> +		SUNXI_THS_INTS_ALARM_INT_2 |
>> +		SUNXI_THS_INTS_SHUT_INT_0  |
>> +		SUNXI_THS_INTS_SHUT_INT_1  |
>> +		SUNXI_THS_INTS_SHUT_INT_2  |
>> +		SUNXI_THS_INTS_TDATA_IRQ_0 |
>> +		SUNXI_THS_INTS_TDATA_IRQ_1 |
>> +		SUNXI_THS_INTS_TDATA_IRQ_2,
>> +	.irq_control_map = SUNXI_THS_INTC_TDATA_IRQ_EN0 |
>> +		SUNXI_THS_INTC_TDATA_IRQ_EN1 |
>> +		SUNXI_THS_INTC_TDATA_IRQ_EN2 |
>> +		SUNXI_THS_TEMP_PERIOD(0x257),
>> +};
>> +
>>   struct sun4i_gpadc_iio {
>>   	struct iio_dev			*indio_dev;
>>   	struct completion		completion;
>> @@ -672,6 +706,10 @@ static const struct of_device_id sun4i_gpadc_of_id[] = {
>>   		.compatible = "allwinner,sun8i-h3-ths",
>>   		.data = &sun8i_h3_ths_data,
>>   	},
>> +	{
>> +		.compatible = "allwinner,sun8i-a83t-ths",
>> +		.data = &sun8i_a83t_ths_data,
>> +	},
>>   	{ /* sentinel */ }
>>   };
>>   
>> -- 
>> 2.11.0
>>
>> -- 
>> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
>> For more options, visit https://groups.google.com/d/optout.

Thanks,
Philipp
