Return-Path: <lars@metafoo.de>
Message-ID: <4EC2CC2B.3020505@metafoo.de>
Date: Tue, 15 Nov 2011 21:31:39 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Jonathan Cameron <jic23@cam.ac.uk>,
 Michael Hennerich <michael.hennerich@analog.com>,
 linux-iio@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org,
 drivers@analog.com
Subject: Re: [PATCH] staging:iio:dac: Add helper function for formating scale
References: <1321374605-16626-1-git-send-email-lars@metafoo.de> <4EC2C011.4040100@kernel.org>
In-Reply-To: <4EC2C011.4040100@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 11/15/2011 08:40 PM, Jonathan Cameron wrote:
> On 11/15/2011 04:30 PM, Lars-Peter Clausen wrote:
>> We basically use the same for formating the DACs scale in almost all DAC
>> drivers. So put this into a common helper function which does the job for us.
>> The helper function uses 64-bit math to be as accurate as possible to minimize
>> the error we get when multiplying out_voltage_scale with out_voltage_raw.
>>
> Nice idea.
> As stated below, I do wonder if this isn't more general than dacs and
> perhaps needs a more descriptive name?
[...]
> This is actually pretty similar to that used for some adc's as well.
> Maybe it wants a less dac focused and more descriptive name?

Hm, yes. So what it basically does is, it maps the fullscale value to one lsb
based on the channels realbits. I'm open for suggestions for a good name.

Maybe:
iio_channel_[lsb]_get_scale(const struct iio_chan_spec *chan, unsigned long
fullscale, unsigned int *val, unsigned int *val2)


>> +/* iio_dac_format_scale: Helper function for formating the scale attribute for a
>> + * DAC.
> kernel doc formatting please. Close, but few minor differences..

Anything else except the /** and the missing parenthesis after the function name?

>> + *
>> + * @vref_span_uv:	span of the reference voltage in microvolts
>> + * @chan:			channel to format for
>> + * @val:			val of iio raw_write callback
>> + * @val2:			val2 of the iio raw_write callback
>> + */
>> +static inline int iio_dac_format_scale(unsigned long vref_span_uv,
>> +	const struct iio_chan_spec *chan, unsigned int *val, unsigned int *val2)
>> +{
>> +	u64 result;
>> +	u32 _val2;
>> +
>> +	result = (((u64)vref_span_uv) * 1000) >> chan->scan_type.realbits;
>> +
>> +	*val = div_u64_rem(result, 1000000, &_val2);
>> +	*val2 = _val2;
>> +
>> +	return IIO_VAL_INT_PLUS_MICRO;
>> +}
> 
