Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:55641 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922Ab1CYPhE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 25 Mar 2011 11:37:04 -0400
Message-ID: <4D8CB6EF.2000808@cam.ac.uk>
Date: Fri, 25 Mar 2011 15:38:23 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] staging:iio:lis3l02dq - experimental move to new
 channel_spec approach.
References: <1300997125-2896-1-git-send-email-jic23@cam.ac.uk> <1300997125-2896-3-git-send-email-jic23@cam.ac.uk> <201103251526.16233.arnd@arndb.de>
In-Reply-To: <201103251526.16233.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/25/11 14:26, Arnd Bergmann wrote:
> I like the changes. The savings are a little less than what I had hoped
> for, but a lot of the redundant code that gets copied to each driver
> is gone.
> 
> On Thursday 24 March 2011, Jonathan Cameron wrote:
>> -/**
>> - * lis3l02dq_spi_read_reg_8() - read single byte from a single register
>> - * @dev: device asosciated with child of actual device (iio_dev or iio_trig)
>> - * @reg_address: the address of the register to be read
>> - * @val: pass back the resulting value
>> - **/
>> -int lis3l02dq_spi_read_reg_8(struct device *dev, u8 reg_address, u8 *val)
>> +static int __lis3l02dq_spi_read_reg_8(struct lis3l02dq_state *st,
>> +				      u8 reg_address, u8 *val)
>>  {
>> -	int ret;
>>  	struct spi_message msg;
>> -	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> -	struct iio_sw_ring_helper_state *h = iio_dev_get_devdata(indio_dev);
>> -	struct lis3l02dq_state *st = lis3l02dq_h_to_s(h);
>> -
>> +	int ret;
>>  	struct spi_transfer xfer = {
>>  		.tx_buf = st->tx,
>>  		.rx_buf = st->rx,
>>
>> @@ -73,6 +64,19 @@ int lis3l02dq_spi_read_reg_8(struct device *dev, u8 reg_address, u8 *val)
>>  
>>  	return ret;
>>  }
>> +/**
>> + * lis3l02dq_spi_read_reg_8() - read single byte from a single register
>> + * @dev: device asosciated with child of actual device (iio_dev or iio_trig)
>> + * @reg_address: the address of the register to be read
>> + * @val: pass back the resulting value
>> + **/
>> +int lis3l02dq_spi_read_reg_8(struct device *dev, u8 reg_address, u8 *val)
>> +{
>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +	struct iio_sw_ring_helper_state *h = iio_dev_get_devdata(indio_dev);
>> +	struct lis3l02dq_state *st = lis3l02dq_h_to_s(h);
>> +	return __lis3l02dq_spi_read_reg_8(st, reg_address, val);
>> +}
> 
> 
> This change seems unrelated to the main intention of the driver.
> I think the cleanest way to handle this would be to always pass the
> iio_dev to the low-level functions. Passing a bare struct device
> is hardly ever helpful, and from the iio_dev, you can easily get to
> both the device and the lis3l02dq_state.
Good point. I should have taken a closer look at where we've ended up in
this driver. Some of this has evolved from pre IIO days!
> 
>> +enum lis3l02dq_rm_ind {
>> +	LIS3L02DQ_ACCEL,
>> +	LIS3L02DQ_GAIN,
>> +	LIS3L02DQ_BIAS,
>> +};
>>  
>> +static u8 lis3l02dq_axis_map[3][3] = {
>> +	[LIS3L02DQ_ACCEL] = { LIS3L02DQ_REG_OUT_X_L_ADDR,
>> +			      LIS3L02DQ_REG_OUT_Y_L_ADDR,
>> +			      LIS3L02DQ_REG_OUT_Z_L_ADDR },
>> +	[LIS3L02DQ_GAIN] = { LIS3L02DQ_REG_GAIN_X_ADDR,
>> +			     LIS3L02DQ_REG_GAIN_Y_ADDR,
>> +			     LIS3L02DQ_REG_GAIN_Z_ADDR },
>> +	[LIS3L02DQ_BIAS] = { LIS3L02DQ_REG_OFFSET_X_ADDR,
>> +			     LIS3L02DQ_REG_OFFSET_Y_ADDR,
>> +			     LIS3L02DQ_REG_OFFSET_Z_ADDR }
>> +};
> 
> The table looks nice and small, but I can't see where the BIAS
> value is used. Is that something that the hardware supports but
> the driver does not?
Gah. That's just a straight bug. BIAS on the chip maps to calibbias
in sysfs. Last case statement in lis3l02dq_read_raw has the wrong element
of the array. Good spot!
> 
>> +static int lis3l02dq_read_thresh(struct iio_dev *indio_dev,
>> +				 int e,
>> +				 int *val)
>>  {
>> +	struct iio_sw_ring_helper_state *h
>> +		= iio_dev_get_devdata(indio_dev);
>> +	struct lis3l02dq_state *st = lis3l02dq_h_to_s(h);
>>  
>> +	return lis3l02dq_read_16bit_s(st, LIS3L02DQ_REG_THS_L_ADDR, val);
>>  }
>>  
>> +static int lis3l02dq_write_thresh(struct iio_dev *indio_dev,
>> +				  int event_code,
>> +				  int val)
>>  {
>> +	u16 value = val;
>> +	return lis3l02dq_spi_write_reg_s16(&indio_dev->dev,
>> +					   LIS3L02DQ_REG_THS_L_ADDR,
>> +					   value);
>>  }
> 
> Can be made even smaller if you drop the u16 value variable and
> rely on the implicit type conversion ;-)
Should probably have some specific checking on that parameter rather
than clamping it down to a u16 instead.
> 
>> +static int lis3l02dq_read_raw(struct iio_dev *indio_dev,
>> +			      struct iio_chan_spec *chan,
>> +			      int *val,
>> +			      long mask)
>>  {
> 
> I guess that in the mask work, you can only pass one bit at most,
> right? How about passing the bit number instead?
Fair point.
> 
> 
>> +/* A shared handler for a number of threshold types */
>> +IIO_EVENT_SH(threshold, &lis3l02dq_thresh_handler_th);
>>  
>> +#define LIS3L02DQ_INFO_MASK				\
>> +	(1 << IIO_CHAN_INFO_SCALE_SHARED) |		\
>> +	(1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE) |	\
>> +	(1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE)
>> +
>> +#define LIS3L02DQ_EVENT_MASK					\
>> +	IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING) |	\
>> +	IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING)
>> +
>> +static struct iio_chan_spec lis3l02dq_channels[] = {
>> +	IIO_CHAN_EV(IIO_ACCEL, 'x', LIS3L02DQ_INFO_MASK,
>> +		    0, 0, IIO_ST('s', 12, 16, 0),
>> +		    LIS3L02DQ_EVENT_MASK, &iio_event_threshold),
>> +	IIO_CHAN_EV(IIO_ACCEL, 'y', LIS3L02DQ_INFO_MASK,
>> +		    1, 1, IIO_ST('s', 12, 16, 0),
>> +		    LIS3L02DQ_EVENT_MASK, &iio_event_threshold),
>> +	IIO_CHAN(IIO_ACCEL, 'z', LIS3L02DQ_INFO_MASK,
>> +		 2, 2, IIO_ST('s', 12, 16, 0)),
>> +	IIO_CHAN_SOFT_TIMESTAMP(3)
>> +};
> 
> Hmm, this has turned out more complex than I had hoped for,
> but that's probably the way things go when you put them into
> real code.
Interestingly it's actually a touch simpler than I thought it would be ;)
> 
>> +static ssize_t lis3l02dq_read_event_config(struct iio_dev *indio_dev,
>> +					   int event_code)
>> +{
>> +
>> +	u8 val;
>> +	int ret;
>> +	u8 mask = (1 << (IIO_EVENT_CODE_EXTRACT_MODIFIER(event_code)*2 +
>> +			 (IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
>> +			  IIO_EV_DIR_RISING)));
>> +	ret = lis3l02dq_spi_read_reg_8(&indio_dev->dev,
>>  				       LIS3L02DQ_REG_WAKE_UP_CFG_ADDR,
>> +				       &val);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return !!(val & mask);
>> +}
> 
> I need some background information here. Why do you expose the configuration
> register directly? Is this something that users normally access?
> 
> I would assume that it's highly device specific and would need to be
> abstracted by the kernel.
We could cache what events are enabled, and in some drivers we do.  Here it is
just simpler to ask the device as it has a convenient bitmap of what is enabled.

It's actually a real pain to completely abstract this away because some
devices only support sets of events at a time and exactly which are
supported can be extremely complex.  The common cases are:

1) Separate comparators for each event. (simple as we have here!)
2) n comparators which can be configured to any n events from a large list (adis16350
	is a classic example though we haven't finally merged event support for that
	part yet).
3) n comparators each of which can be configured to a subset of thresholds. e.g. one
	comparator per channel, lots of different things it can compare about the channel.

It is possible that we can abstract these at some point, but right now I'm not even
tempted to try!  We are mostly avoiding the nastiest case at the moment which is
where you have controllable compound events.  In this particular device you can
either have the events as 'or' as we do or 'and' for any set of them.  Right now
we simply don't implement the 'and' case. 
> 
>> @@ -813,7 +690,13 @@ static int __devinit lis3l02dq_probe(struct spi_device *spi)
>>  
>>  	st->help.indio_dev->dev.parent = &spi->dev;
>>  	st->help.indio_dev->num_interrupt_lines = 1;
>> -	st->help.indio_dev->event_attrs = &lis3l02dq_event_attribute_group;
>> +	st->help.indio_dev->channels = lis3l02dq_channels;
>> +	st->help.indio_dev->num_channels = ARRAY_SIZE(lis3l02dq_channels);
>> +	st->help.indio_dev->read_raw = &lis3l02dq_read_raw;
>> +	st->help.indio_dev->read_event_value = &lis3l02dq_read_thresh;
>> +	st->help.indio_dev->write_event_value = &lis3l02dq_write_thresh;
>> +	st->help.indio_dev->write_event_config = &lis3l02dq_write_event_config;
>> +	st->help.indio_dev->read_event_config = &lis3l02dq_read_event_config;
>>  	st->help.indio_dev->attrs = &lis3l02dq_attribute_group;
>>  	st->help.indio_dev->dev_data = (void *)(&st->help);
>>  	st->help.indio_dev->driver_module = THIS_MODULE;
> 
> I think a lof of this can be turned from code into data if you define
> a new structure for all the constant members:
I agree entirely. I just haven't done it yet!
> 
> static const struct iio_dev_ops = {
> 	.owner = THIS_MODULE,
> 	.attrs = &lis3l02dq_attribute_group,
> 	.channels = lis3l02dq_channels,
> 	...
> };
> 
> 	st->help.indio_dev->ops = &iio_dev_ops;
> 	st->help.indio_dev->dev_data = (void *)(&st->help);
> 
> => somewhat more readable, and smaller object code.
> 
> 	Arnd
> 

