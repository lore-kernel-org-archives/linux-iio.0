Return-Path: <lars@metafoo.de>
Message-ID: <4E984CA1.40702@metafoo.de>
Date: Fri, 14 Oct 2011 16:52:17 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Michael Hennerich <michael.hennerich@analog.com>,
 linux-iio@vger.kernel.org, Device-drivers-devel@blackfin.uclinux.org,
 drivers@analog.com
Subject: Re: [PATCH] staging:iio:dac Add AD5064 driver
References: <1318506028-5041-1-git-send-email-lars@metafoo.de> <4E98458D.70603@cam.ac.uk>
In-Reply-To: <4E98458D.70603@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 10/14/2011 04:22 PM, Jonathan Cameron wrote:
> On 10/13/11 12:40, Lars-Peter Clausen wrote:
>> This patch adds support for the Analog Devices AD6064, AD6064-1, AD6044, AD6024
>> quad channel digital-to-analog converter devices.
> Very nice.
> 
> Dependency has gone to Greg just now so please send this on as well.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
>>
>>[...]
>> +
>> +struct ad5064_state {
>> +	struct spi_device		*spi;
>> +	const struct ad5064_chip_info	*chip_info;
>> +	struct regulator_bulk_data	vref_reg[AD5064_DAC_CHANNELS];
>> +	bool				pwr_down[AD5064_DAC_CHANNELS];
>> +	u8				pwr_down_mode[AD5064_DAC_CHANNELS];
>> +	unsigned int			dac_cache[AD5064_DAC_CHANNELS];
> 
> utter nitpick, but probably blank line before this and not after?

uhm, yes. I'll fix this in the version I'll send out to GregKH.

>> +	/*
>> +	 * DMA (thus cache coherency maintenance) requires the
>> +	 * transfer buffers to live in their own cache lines.
>> +	 */
>> +
>> +	__be32 data ____cacheline_aligned;
>> +};
>> [...]
>> +
>> +static int ad5064_write_raw(struct iio_dev *indio_dev,
>> +	struct iio_chan_spec const *chan, int val, int val2, long mask)
>> +{
>> +	struct ad5064_state *st = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	switch (mask) {
>> +	case 0:
>> +		if (val > (1 << chan->scan_type.realbits))

I'll also change this check to reject negative values as well.

>> +			return -EINVAL;
>> +
>> +		mutex_lock(&indio_dev->mlock);
>> +		ret = ad5064_spi_write(st, AD5064_CMD_WRITE_INPUT_N_UPDATE_N,
>> +				chan->address, val, chan->scan_type.shift);
>> +		if (ret == 0)
>> +			st->dac_cache[chan->channel] = val;
>> +		mutex_unlock(&indio_dev->mlock);
>> +		break;
>> +	default:
>> +		ret = -EINVAL;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> [...]
