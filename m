Return-Path: <leonard.crestez@intel.com>
Subject: Re: [PATCH 2/2] ti-adc081c: Initial triggered buffer support
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <cover.1459444547.git.leonard.crestez@intel.com>
 <b0276dfaa9a6a8ac1777bf5d92753dab1fc493b1.1459444547.git.leonard.crestez@intel.com>
 <alpine.DEB.2.02.1604011017450.15685@pmeerw.net>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>, Daniel Baluta <daniel.baluta@intel.com>
From: Leonard Crestez <leonard.crestez@intel.com>
Message-ID: <56FE57EE.2030408@intel.com>
Date: Fri, 1 Apr 2016 14:13:50 +0300
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1604011017450.15685@pmeerw.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 04/01/2016 11:34 AM, Peter Meerwald-Stadler wrote:
>> -static const struct iio_chan_spec adc081c_channel = {
>> -	.type = IIO_VOLTAGE,
>> -	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
>> -	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>> -};
>
> the patch would look cleaner/shorter if adc081c_channel won't get moved
> around

It was not moved around, it is now defined by a macro. Buffer support 
requires defining scan_type which contains a different number of bits.

The macros are now after iio_info adc081c_info instead of before, I can 
move that around. I also noticed that I declared both a struct 
adcxx1c_model and an unused struct adcxx1c_info. I will remove that.

The first patch in the series doesn't use any per-model data and just 
stores the number of bits in driver_data. I can change the series to 
introduce adcxx1c_model in the first patch.

>> +static irqreturn_t adc081c_trigger_handler(int irq, void *p)
>> +{
>> +	struct iio_poll_func *pf = p;
>> +	struct iio_dev *indio_dev = pf->indio_dev;
>> +	struct adc081c *data = iio_priv(indio_dev);
>> +	s64 ts;
>> +	u16 buf[8];
>
> comment: 2 bytes data + 6 bytes padding + 8 bytes timestamp
>
>> +	int ret;
>> +
>> +	/* Otherwise iio_push_to_buffers will corrupt the stack. */
>> +	if (indio_dev->scan_bytes > sizeof(buf)) {
>> +		dev_crit_once(&indio_dev->dev, "Bad iio_scan_bytes=%d > %d\n",
>> +				indio_dev->scan_bytes, (int)sizeof(buf));
>
> rather than casting sizeof(buf), use the correct printf length modifier,
> i.e. %z
>
> not sure if this check is needed

I guess it's not needed. My first version defined the buffer incorrectly 
and caused a messy crash. Calculating manual buffer alignments seems 
very fragile.

It seems that C99 variable-length-arrays work fine, something like:
	u16 buf[indio_dev->scan_bytes / 2];

Would that be acceptable? It compiles without warnings and there some 
other places in the kernel where VLAs are used.

>> +	ret = i2c_smbus_read_word_swapped(data->i2c, REG_CONV_RES);
>
> REG_CONV_RES should be called ADC081C_REG_CONV_RES, but that's a separate
> issue

Yes, but that would be an entirely unrelated renaming.

>
>> +	ts = iio_get_time_ns();
>
> why is the timestamp taken here?, seems strange
> often this is done together with iio_push_to_buffers_with_timestamp()

I wanted to keep it as close to the read as possible. In this case it 
doesn't matter.

>> -	iio->channels = &adc081c_channel;
>> -	iio->num_channels = 1;
>> +	iio->channels = model->channels;
>> +	iio->num_channels = 2;
>
> the number of channels could go into the adcxx1c_info struct

But it's a constant, it does not vary between devices. I could make an 
ADC081C_NUM_CHANNELS define.

--
Regards,
Leonard
