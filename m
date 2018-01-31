Return-Path: <SRS0=WHON=E2=gmail.com=embed3d@kernel.org>
Subject: Re: [PATCH v2 04/16] iio: adc: sun4i-gpadc-iio: rework: sampling
 start/end code readout reg
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
 maxime.ripard@free-electrons.com, wens@csie.org, linux@armlinux.org.uk,
 jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 davem@davemloft.net, hans.verkuil@cisco.com, mchehab@kernel.org,
 rask@formelder.dk, clabbe.montjoie@gmail.com, sean@mess.org,
 krzk@kernel.org, icenowy@aosc.io, edu.molinas@gmail.com,
 singhalsimran0@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
References: <20180128232919.12639-1-embed3d@gmail.com>
 <20180128232919.12639-5-embed3d@gmail.com>
 <20180131175106.agrvwioaruioavqk@qschulz>
From: Philipp Rossak <embed3d@gmail.com>
Message-ID: <025fc383-8a54-cc22-bdf3-0919b8ca2507@gmail.com>
Date: Wed, 31 Jan 2018 19:35:55 +0100
MIME-Version: 1.0
In-Reply-To: <20180131175106.agrvwioaruioavqk@qschulz>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>



On 31.01.2018 18:51, Quentin Schulz wrote:
> Hi Philipp,
> 
> On Mon, Jan 29, 2018 at 12:29:07AM +0100, Philipp Rossak wrote:
>> For adding newer sensor some basic rework of the code is necessary.
>>
>> This commit reworks the code and allows the sampling start/end code and
>> the position of value readout register to be altered. Later the start/end
>> functions will be used to configure the ths and start/stop the
>> sampling.
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
>> ---
>>   drivers/iio/adc/sun4i-gpadc-iio.c | 44 ++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 39 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
>> index 03804ff9c006..db57d9fffe48 100644
>> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
>> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
>> @@ -49,6 +49,15 @@ static unsigned int sun6i_gpadc_chan_select(unsigned int chan)
>>   	return SUN6I_GPADC_CTRL1_ADC_CHAN_SELECT(chan);
>>   }
>>   
>> +struct sun4i_gpadc_iio;
>> +
>> +/*
>> + * Prototypes for these functions, which enable these functions to be
>> + * referenced in gpadc_data structures.
>> + */
> 
> Comment not needed.
> 
>> +static int sun4i_gpadc_sample_start(struct sun4i_gpadc_iio *info);
>> +static int sun4i_gpadc_sample_end(struct sun4i_gpadc_iio *info);
>> +
>>   struct gpadc_data {
>>   	int		temp_offset;
>>   	int		temp_scale;
>> @@ -56,6 +65,9 @@ struct gpadc_data {
>>   	unsigned int	tp_adc_select;
>>   	unsigned int	(*adc_chan_select)(unsigned int chan);
>>   	unsigned int	adc_chan_mask;
>> +	unsigned int	temp_data;
> 
> Does not really have anything to do with sample_start/end. I would have
> made a different commit for it.
> 
> Otherwise,
> Reviewed-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> 
> Quentin
> 

Ok I will split this.

Thanks,
Philipp
