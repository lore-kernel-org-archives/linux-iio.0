Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:34655 "EHLO mail.aswsp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755292AbcHYOm2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 25 Aug 2016 10:42:28 -0400
Message-ID: <57BF0488.4000902@parrot.com>
Date: Thu, 25 Aug 2016 16:45:28 +0200
From: Gregor Boirie <gregor.boirie@parrot.com>
MIME-Version: 1.0
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC: <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 3/3] iio:pressure: initial zpa2326 barometer support
References: <cover.1472050374.git.gregor.boirie@parrot.com> <a16becf5ac0ac811a993a26de32a0d41f3eb4ffa.1472050374.git.gregor.boirie@parrot.com> <alpine.DEB.2.02.1608242115340.4077@pmeerw.net>
In-Reply-To: <alpine.DEB.2.02.1608242115340.4077@pmeerw.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Answers inline

On 08/25/2016 08:34 AM, Peter Meerwald-Stadler wrote:

> +#define ZPA_CONVERSION_TIMEOUT (HZ / 5)
> ZPA2326_ prefix would be expected by convention
It seems such a long prefix to me. I would prefer "zpa" but it's not 
distinctive enough.
Anyway, convention prevails.

>
>> +
>> +/* Registers map. */
> Register map
>
>> +#define ZPA_REF_P_XL_REG                     ((u8)0x8)
> do we really need u8 here?
nop.

>   why?
Just to inform reader addresses are encoded onto 8 bits. Removed.

> +/*
> + * Enable device, i.e. get out of low power mode.
> + *
> + * Required to access complete register space and to perform any sampling
> + * or control operations.
> + */
> +static int zpa_enable_device(const struct iio_dev *indio_dev)
> +{
> +	int err = zpa_write_byte(indio_dev, ZPA_CTRL_REG0_REG,
> +				 ZPA_CTRL_REG0_ENABLE);
> +	if (err) {
> +		zpa_err(indio_dev, "failed to enable device (%d)", err);
> I think messages should end with \n
Why ? Enforce flushing ? dev_err adds an implicit "\n". It saves a few 
characters and
sometimes makes strings fit into 80 columns :)

> +/* Enqueue new channel samples to IIO buffer. */
> +static int zpa_fill_sample_buffer(struct iio_dev           *indio_dev,
> +				  const struct zpa_private *private)
> +{
> +	struct {
> +		u32 pressure;
> +		u16 temperature;
> timestamp should be 8-byte aligned, padding needed
This one surprises me. I may completly miss the point but unless using
the packed attribute, compiler implicitly aligns "timestamp" upon 8 bytes
boundary in this case.

>
>> +		u64 timestamp;
>> +	}   sample;
> extra spaces before 'sample'
text-aligned onto the below variable declaration.

>
>> +	int err;
>> +
>> +	if (test_bit(0, indio_dev->active_scan_mask)) {
>> +		/* Get current pressure from hardware fifo. */
>> +		err = zpa_dequeue_pressure(indio_dev, &sample.pressure);
> pressure is 4 bytes, but only 3 bytes are read; one byte uninitialized?
arrrgh! Many thanks for this. My mind must have been floating around while
coding this.
>
>> +		if (err) {
>> +			zpa_warn(indio_dev, "failed to fetch pressure (%d)",
> here and elsewhere: why zpa_warn() on error?
Because this error does not put kernel and/or driver functional 
stability in danger.
Maybe we can recover from it at next sampling round. It just requires user
attention.

I've always been a bit confused as to which log level to use and from 
which context.
Any rule of thumb ?

> +/* Retrieve a raw sample and convert it to CPU endianness. */
> +static int zpa_fetch_raw_sample(const struct iio_dev *indio_dev,
> +				enum iio_chan_type    type,
> +				int                  *value)
> +{
> +	int err;
> +
> +	switch (type) {
> +	case IIO_PRESSURE:
> +		zpa_dbg(indio_dev, "fetching raw pressure sample");
> +
> +		err = zpa_read_block(indio_dev, ZPA_PRESS_OUT_XL_REG, 3,
> +				     (u8 *)value);
> +		if (err) {
> +			zpa_warn(indio_dev, "failed to fetch pressure (%d)",
> +				 err);
> +			return err;
> +		}
> +
> +		/* Pressure is a 24 bits wide little-endian unsigned int. */
> +		*value = (((u8 *)value)[2] << 16) | (((u8 *)value)[1] << 8) |
> +			 ((u8 *)value)[0];
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_TEMP:
> +		zpa_dbg(indio_dev, "fetching raw temperature sample");
> +
> +		err = zpa_read_block(indio_dev, ZPA_TEMP_OUT_L_REG, 2,
> +				     (u8 *)value);
> +		if (err) {
> +			zpa_warn(indio_dev, "failed to fetch temperature (%d)",
> +				 err);
> +			return err;
> +		}
> +
> +		/* Temperature is a 16 bits wide little-endian signed int. */
> +		*value = (int)le16_to_cpup((__le16 *)value);
> +
> +		return IIO_VAL_INT;
> +
> +	default:
> +		BUG();
> return -EINVAL
This case is clearly a coding bug since if channels are properly defined
this will never happen unless IIO layer is completly screwed up.
Why returning an error then ? This is a situation that requires debug / 
code rework.
Same for other BUG() invocations.

I'm not reluctant to change anything here, I just want to properly 
understand
the rationales.

>
> +static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
> +			      zpa_show_frequency,
> +			      zpa_store_frequency);
> +
> +/* Expose supported hardware sampling frequencies (Hz) through sysfs. */
> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("1 5 11 23");
> +
> +static struct attribute *zpa_attributes[] = {
> +	&iio_dev_attr_sampling_frequency.dev_attr.attr,
> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group zpa_attribute_group = {
> +	.attrs = zpa_attributes,
> +};
> +
> +static const struct iio_chan_spec zpa_channels[] = {
> +	[0] = {
> +		.type                   = IIO_PRESSURE,
> +		.channel                = 0,
> .channel is not needed since channels are not indexed
ack'ed

>> +
>> +	zpa_init_runtime(slave);
>> +
>> +	err = devm_iio_device_register(slave, indio_dev);
> can't use devm_ register if there is a non-empty remove()
Removal hooks are registered onto bus specific devices not onto
IIO ones. Enabling devm debug outputs a removal flow trace that
seems correct. Is this really wrong ?

Many thanks for the review. Regards,
Greg.
