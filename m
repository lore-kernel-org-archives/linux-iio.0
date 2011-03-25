Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:34928 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852Ab1CYPN7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 25 Mar 2011 11:13:59 -0400
Message-ID: <4D8CB186.5030101@cam.ac.uk>
Date: Fri, 25 Mar 2011 15:15:18 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] staging:iio: allow channels to be set up using a
 table of iio_channel_spec structures.
References: <1300997125-2896-1-git-send-email-jic23@cam.ac.uk> <1300997125-2896-2-git-send-email-jic23@cam.ac.uk> <201103251537.02030.arnd@arndb.de>
In-Reply-To: <201103251537.02030.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/25/11 14:37, Arnd Bergmann wrote:
> On Thursday 24 March 2011, Jonathan Cameron wrote:
>> +	
>> +/**
>> + * struct iio_chan_spec - specification of a single channel
>> + * @type:	what type of measurement is the channel making
>> + * @channel:	what number or name do we wish to asign the channel
>> + * @channel2:	if there is a second number for a differential
>> + *		channel then this is it.
>> + * @address:	driver specific identifier.
> 
> Better make it "unsigned long" instead of int when it's driver specific.
> That way, a driver can store a pointer here if necessary.
Makes sense. Perhaps a union to make the option explicit would be even
better?

Whilst we are talking about types, some of the masks should probably switch to
fixed length arrays of longs though so we don't have massive changes the
moment we run out of space in the single longs.  All access will have to then
be through the bitmap functions, but that should be fine.
> 
>> +#define IIO_ST(si, rb, sb, sh)						\
>> +	{ .sign = si, .realbits = rb, .storagebits = sb, .shift = sh }
>> +
>> +#define IIO_CHAN(_type, _chan, _inf_mask, _address, _si, _stype)		\
>> +	{ .type = _type, .channel = _chan, .info_mask = _inf_mask,	\
>> +			.address = _address,				\
>> +			.scan_index = _si, .scan_type = _stype }
>> +
>> +#define IIO_CHAN_EV(_type, _chan, _inf_mask, _address, _si,		\
>> +		    _stype, _event_mask, _shared_h)			\
>> +	{ .type = _type,						\
>> +			.channel = _chan,				\
>> +			.info_mask = _inf_mask,				\
>> +			.address = _address,				\
>> +			.scan_index = _si, .scan_type = _stype,		\
>> +			.event_mask = _event_mask,			\
>> +			.shared_handler = _shared_h }
>> +
>> +#define IIO_CHAN_COMPOUND(_type, _chan1, _chan2, _inf_mask,_address, _si, _stype) \
>> +	{ .type = _type, .channel = _chan1, .channel2 = _chan2,		\
>> +			.info_mask = _inf_mask,				\
>> +			.address = _address,				\
>> +			.scan_index = _si, .scan_type = _stype }
>> +
>> +#define IIO_CHAN_COMPOUND_EV(_type, _chan1, _chan2, _inf_mask,		\
>> +			     _address, _si, _stype, _event_mask, _shared_h) \
>> +	{ .type = _type,						\
>> +			.channel = _chan1, .channel2 = _chan2,		\
>> +			.info_mask = _inf_mask,				\
>> +			.address = _address,				\
>> +			.scan_index = _si, .scan_type = _stype,		\
>> +			.event_mask = _event_mask,			\
>> +			.shared_handler = _shared_h}
>> +
>> +#define IIO_CHAN_SOFT_TIMESTAMP(_si)					\
>> +	{ .type = IIO_TIMESTAMP, .channel = -1,				\
>> +			.scan_index = _si, .scan_type = IIO_ST('s', 64, 64, 0) }
> 
> Maybe try to reduce the number of macros here. In many cases, doing the
> assignment manually would be more readable than calling the macro with
> unspecified arguments, IMHO.
Perhaps. The advantage of macros is it gives us a common point to do nasty
tricks like that .channel = -1 in the timestamp macro. What I don't want to
end up with is having to change thousands of calls the moment we need something
to default to a value other than 0.  Having said that, some of these only
really evolved as I wanted to mess around with the internal structure whilst
developing this and can reasonably go away now.
> 
>> @@ -116,6 +248,31 @@ struct iio_dev {
>>  	u32				*available_scan_masks;
>>  	struct iio_trigger		*trig;
>>  	struct iio_poll_func		*pollfunc;
>> +
>> +	struct iio_chan_spec *channels;
>> +	int num_channels;
>> +	struct list_head channel_attr_list;
>> +
>> +	char *name; /*device name - IMPLEMENT */
>> +	int (*read_raw)(struct iio_dev *indio_dev, 
>> +			struct iio_chan_spec *chan,
>> +			int *val,
>> +			long mask);
>> +
>> +	int (*read_event_config)(struct iio_dev *indio_dev,
>> +				 int event_code);
>> +
>> +	int (*write_event_config)(struct iio_dev *indio_dev,
>> +				  int event_code,
>> +				  struct iio_event_handler_list *listel,
>> +				  int state);
>> +
>> +	int (*read_event_value)(struct iio_dev *indio_dev,
>> +				int event_code,
>> +				int *val);
>> +	int (*write_event_value)(struct iio_dev *indio_dev,
>> +				 int event_code,
>> +				 int val);
>>  };
> 
> As mentioned in the comment for 2/3, a number of the members here are
> constant, so you could split the structure into a per-driver constant
> part and a per-device part, like most other subsystems do.
Good idea. Might have to be at a finer level than per driver though.
I can certainly envision some drivers want for example to have a number
of variants of read_raw to account for subtle difference in what channels
are present on individual parts.
However I think this refactoring should wait until after the other
big changes are in. 
> 
> 	Arnd
> 

