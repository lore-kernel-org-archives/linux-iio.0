Return-Path: <pmeerw@pmeerw.net>
Date: Thu, 2 Jan 2014 11:32:37 +0100 (CET)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
    linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFC 1/2] IIO : core: Enhance read_raw capability
In-Reply-To: <52C42A18.3040603@kernel.org>
Message-ID: <alpine.DEB.2.01.1401021046450.11135@pmeerw.net>
References: <1387901990-3469-1-git-send-email-srinivas.pandruvada@linux.intel.com> <52C42A18.3040603@kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

Hello,

one option would be to not support quaternions via read_raw() and ask 
to use buffered mode; 

I see some inconsistency/redundancy problem:
for example R/G/B light values could be handled either as separate 
channels via modifiers or as the new repeated type -- both ways have some 
merit

some minor comments below

regards, p.

> On 24/12/13 16:19, Srinivas Pandruvada wrote:
> > Sampling Issue:
> > In some data types, unless all of its component present, data has no
> > meaning.
> > A quaternion type falls under this category.
> > A quaternion is usually represented as a vector, [w, x, y, z]. They are
> > related by equation
> > sq(i) = sq(j) = sq(k) = ijk = -1
> > 
> > Idea is to ensure some mechanism where multiple elements can be read in one
> > call not just current val and val2.
> > 
> > Jonathan suggested the following for adding quaternion type values to IIO
> > raw_reads (mail dated : 7th Dec, 2013)
> > 
> > 1) Introduced an IIO_VAL_QUATERNION
> > 
> > 2) Introduced a replacement for read_raw
> > 	int (*read_raw)(struct iio_dev *indio_dev,
> > 			struct iio_chan_spec const *chan,
> > 			int val_len,
> > 			int *vals,
> > 			long mask);
> > 
> > - for previous cases vals[0] <- val and vals[1] <- val2
> > - for quaternion vals[0] <- i component, vals[1] <- j component etc
> > <done>
> > 
> > 3) Add a case to iio_read_channel_info in industrialio-core.c to handle
> > the new type and pretty print it appropriately - possibly expand
> > iio_format_value to handle the new parameters.
> > 
> > <A QUATERNION type will be formated by separating each component by ":"
> > x:y:z:w>
> > 
> > 4) Buffered support is only trickier in that the buffer element needs
> > describing and there is a lot of possible flexibility in there...
> > 
> > current format is :
> > 
> >   [be|le]:[s|u]bits/storagebits[>>shift].
> > 
> > Reasonable to assume that whole thing is either be or le and that elements
> > are
> > byte aligned plus all are signed (but need to state this)
> > 
> > Hence perhaps either
> > [be|le]:[s|u]bitsI/storagebitsI,bitsJ/storagebitsJ,bitsK/storagebitsK,bitsA/storagebitsA
> > 
> > or we assume that the elements are effectively independent but have the same
> > placement and indicated perhaps as
> > be:s12/16x4 or similar?
> > <
> > I have a used a regular expression format.
> > For example
> > 	scan_elements/in_quat_rot_quaternion_type:le:(s32/32){4}>>0
> > 	Here {sign real/storage bits} repeated four times for four components.
> > This is done by adding additional "repeat" field in scan_type structure.
> > This
> > format will be only used if repeat field is set to more than 1. So for the
> > ABI
> > exposed by current drivers, there will be no change.
> > > 
> > 
> > Drawback of adding this change will require changes in read_raw callbacks in
> > every IIO driver.
> 
> I rather like the approach of using a repeat value to specify the channel
> type.
> I'm sure we'll get some horendous packing in a driver at somepoint, but this
> is nice and simple for the common case.  Perhaps we enforce sensible packing
> for these attributes and make drivers reorganise the data if needed to meet
> the requirements.
> 
> The only change I will request here is to make it simple to implement the move
> to the new read function across the tree.  Please introduce a new 'read'
> callback rather than changing the current read_raw parameters.  There will be
> a few extra lines of code in the core for a
> while but that's not a problem.  We just pushed a similar scale of change
> through for the event description interfaces without any problems.
> 
> That way we can do one driver at a time, rather than having to move the lot
> over in one go.  If we are lucky, Lars-Peter will fire up his semantic
> patching skills and send us a 5 line coccinelle script to do the lot for us ;)
> 
> These sorts of treewide changes are a little tedious from the point of
> view of merge clashes but I think this one is well worth doing (just perhaps
> not all in one kernel cycle).
> 
> I've cc'd a few extra people to draw their attention to this patch and see if
> they have any opinions/suggestions.
> 
> Jonathan
> 
> > 
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > ---
> >   drivers/iio/iio_core.h            |  2 +-
> >   drivers/iio/industrialio-buffer.c | 41
> > +++++++++++++++++++++++++++++++------
> >   drivers/iio/industrialio-core.c   | 43
> > ++++++++++++++++++++-------------------
> >   drivers/iio/industrialio-event.c  |  6 ++++--
> >   drivers/iio/inkern.c              | 10 +++++++--
> >   include/linux/iio/iio.h           | 13 +++++++++---
> >   6 files changed, 80 insertions(+), 35 deletions(-)
> > 
> > diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
> > index f6db6af..4172f22 100644
> > --- a/drivers/iio/iio_core.h
> > +++ b/drivers/iio/iio_core.h
> > @@ -35,7 +35,7 @@ int __iio_add_chan_devattr(const char *postfix,
> >   			   struct list_head *attr_list);
> >   void iio_free_chan_devattr_list(struct list_head *attr_list);
> > 
> > -ssize_t iio_format_value(char *buf, unsigned int type, int val, int val2);
> > +ssize_t iio_format_value(char *buf, unsigned int type, int *vals);
> > 
> >   /* Event interface flags */
> >   #define IIO_BUSY_BIT_POS 1
> > diff --git a/drivers/iio/industrialio-buffer.c
> > b/drivers/iio/industrialio-buffer.c
> > index 7f9152c..ee57d94 100644
> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
> > @@ -121,7 +121,16 @@ static ssize_t iio_show_fixed_type(struct device *dev,
> >   		type = IIO_BE;
> >   #endif
> >   	}
> > -	return sprintf(buf, "%s:%c%d/%d>>%u\n",
> > +	if (this_attr->c->scan_type.repeat > 1)
> > +		return sprintf(buf, "%s:(%c%d/%d){%d}>>%u\n",
> > +		       iio_endian_prefix[type],
> > +		       this_attr->c->scan_type.sign,
> > +		       this_attr->c->scan_type.realbits,
> > +		       this_attr->c->scan_type.storagebits,
> > +		       this_attr->c->scan_type.repeat,
> > +		       this_attr->c->scan_type.shift);
> > +		else
> > +			return sprintf(buf, "%s:%c%d/%d>>%u\n",
> >   		       iio_endian_prefix[type],
> >   		       this_attr->c->scan_type.sign,
> >   		       this_attr->c->scan_type.realbits,
> > @@ -446,14 +455,22 @@ static int iio_compute_scan_bytes(struct iio_dev
> > *indio_dev,
> >   	for_each_set_bit(i, mask,
> >   			 indio_dev->masklength) {
> >   		ch = iio_find_channel_from_si(indio_dev, i);
> > -		length = ch->scan_type.storagebits / 8;
> > +		if (ch->scan_type.repeat > 1)
> > +			length = ch->scan_type.storagebits / 8 *
> > +				ch->scan_type.repeat;

this should be 
length = (ch->scan_type.storagebits * ch->scan_type.repeat + 7) / 8;
unless storagebits is guaranteed to be a multiple of 8

> > +		else
> > +			length = ch->scan_type.storagebits / 8;
> >   		bytes = ALIGN(bytes, length);
> >   		bytes += length;
> >   	}
> >   	if (timestamp) {
> >   		ch = iio_find_channel_from_si(indio_dev,
> >   					      indio_dev->scan_index_timestamp);
> > -		length = ch->scan_type.storagebits / 8;
> > +		if (ch->scan_type.repeat > 1)
> > +			length = ch->scan_type.storagebits / 8 *
> > +				ch->scan_type.repeat;
> > +		else
> > +			length = ch->scan_type.storagebits / 8;
> >   		bytes = ALIGN(bytes, length);
> >   		bytes += length;
> >   	}
> > @@ -932,7 +949,11 @@ static int iio_buffer_update_demux(struct iio_dev
> > *indio_dev,
> >   					       indio_dev->masklength,
> >   					       in_ind + 1);
> >   			ch = iio_find_channel_from_si(indio_dev, in_ind);
> > -			length = ch->scan_type.storagebits/8;
> > +			if (ch->scan_type.repeat > 1)
> > +				length = ch->scan_type.storagebits / 8 *
> > +					ch->scan_type.repeat;
> > +			else
> > +				length = ch->scan_type.storagebits / 8;
> >   			/* Make sure we are aligned */
> >   			in_loc += length;
> >   			if (in_loc % length)
> > @@ -944,7 +965,11 @@ static int iio_buffer_update_demux(struct iio_dev
> > *indio_dev,
> >   			goto error_clear_mux_table;
> >   		}
> >   		ch = iio_find_channel_from_si(indio_dev, in_ind);
> > -		length = ch->scan_type.storagebits/8;
> > +		if (ch->scan_type.repeat > 1)
> > +			length = ch->scan_type.storagebits / 8 *
> > +				ch->scan_type.repeat;
> > +		else
> > +			length = ch->scan_type.storagebits / 8;
> >   		if (out_loc % length)
> >   			out_loc += length - out_loc % length;
> >   		if (in_loc % length)
> > @@ -965,7 +990,11 @@ static int iio_buffer_update_demux(struct iio_dev
> > *indio_dev,
> >   		}
> >   		ch = iio_find_channel_from_si(indio_dev,
> >   			indio_dev->scan_index_timestamp);
> > -		length = ch->scan_type.storagebits/8;
> > +		if (ch->scan_type.repeat > 1)
> > +			length = ch->scan_type.storagebits / 8 *
> > +				ch->scan_type.repeat;
> > +		else
> > +			length = ch->scan_type.storagebits / 8;
> >   		if (out_loc % length)
> >   			out_loc += length - out_loc % length;
> >   		if (in_loc % length)
> > diff --git a/drivers/iio/industrialio-core.c
> > b/drivers/iio/industrialio-core.c
> > index 18f72e3..f0f2a1a 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -367,41 +367,42 @@ EXPORT_SYMBOL_GPL(iio_enum_write);
> >    * @buf: The buffer to which the formated value gets written
> >    * @type: One of the IIO_VAL_... constants. This decides how the val and
> > val2
> >    *        parameters are formatted.
> > - * @val: First part of the value, exact meaning depends on the type
> > parameter.
> > - * @val2: Second part of the value, exact meaning depends on the type
> > parameter.
> > + * @val: pointer to the values, exact meaning depends on the the type
> > parameter.

the the

> >    */
> > -ssize_t iio_format_value(char *buf, unsigned int type, int val, int val2)
> > +ssize_t iio_format_value(char *buf, unsigned int type, int *vals)
> >   {
> >   	unsigned long long tmp;
> >   	bool scale_db = false;
> > 
> >   	switch (type) {
> >   	case IIO_VAL_INT:
> > -		return sprintf(buf, "%d\n", val);
> > +		return sprintf(buf, "%d\n", vals[0]);
> >   	case IIO_VAL_INT_PLUS_MICRO_DB:
> >   		scale_db = true;
> >   	case IIO_VAL_INT_PLUS_MICRO:
> > -		if (val2 < 0)
> > -			return sprintf(buf, "-%ld.%06u%s\n", abs(val), -val2,
> > +		if (vals[1] < 0)
> > +			return sprintf(buf, "-%ld.%06u%s\n", abs(vals[0]),
> > +					-vals[1],
> >   				scale_db ? " dB" : "");
> >   		else
> > -			return sprintf(buf, "%d.%06u%s\n", val, val2,
> > +			return sprintf(buf, "%d.%06u%s\n", vals[0], vals[1],
> >   				scale_db ? " dB" : "");
> >   	case IIO_VAL_INT_PLUS_NANO:
> > -		if (val2 < 0)
> > -			return sprintf(buf, "-%ld.%09u\n", abs(val), -val2);
> > +		if (vals[1] < 0)
> > +			return sprintf(buf, "-%ld.%09u\n", abs(vals[0]),
> > +					-vals[1]);
> >   		else
> > -			return sprintf(buf, "%d.%09u\n", val, val2);
> > +			return sprintf(buf, "%d.%09u\n", vals[0], vals[1]);
> >   	case IIO_VAL_FRACTIONAL:
> > -		tmp = div_s64((s64)val * 1000000000LL, val2);
> > -		val2 = do_div(tmp, 1000000000LL);
> > -		val = tmp;
> > -		return sprintf(buf, "%d.%09u\n", val, val2);
> > +		tmp = div_s64((s64)vals[0] * 1000000000LL, vals[1]);
> > +		vals[1] = do_div(tmp, 1000000000LL);
> > +		vals[0] = tmp;
> > +		return sprintf(buf, "%d.%09u\n", vals[0], vals[1]);
> >   	case IIO_VAL_FRACTIONAL_LOG2:
> > -		tmp = (s64)val * 1000000000LL >> val2;
> > -		val2 = do_div(tmp, 1000000000LL);
> > -		val = tmp;
> > -		return sprintf(buf, "%d.%09u\n", val, val2);
> > +		tmp = (s64)vals[0] * 1000000000LL >> vals[1];
> > +		vals[1] = do_div(tmp, 1000000000LL);
> > +		vals[0] = tmp;
> > +		return sprintf(buf, "%d.%09u\n", vals[0], vals[1]);
> >   	default:
> >   		return 0;
> >   	}
> > @@ -413,14 +414,14 @@ static ssize_t iio_read_channel_info(struct device
> > *dev,
> >   {
> >   	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> >   	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> > -	int val, val2;
> > +	int vals[INDIO_MAX_RAW_ELEMENTS];
> >   	int ret = indio_dev->info->read_raw(indio_dev, this_attr->c,
> > -					    &val, &val2, this_attr->address);
> > +			    INDIO_MAX_RAW_ELEMENTS, vals, this_attr->address);
> > 
> >   	if (ret < 0)
> >   		return ret;
> > 
> > -	return iio_format_value(buf, ret, val, val2);
> > +	return iio_format_value(buf, ret, vals);
> >   }
> > 
> >   /**
> > diff --git a/drivers/iio/industrialio-event.c
> > b/drivers/iio/industrialio-event.c
> > index c10eab6..b249b48 100644
> > --- a/drivers/iio/industrialio-event.c
> > +++ b/drivers/iio/industrialio-event.c
> > @@ -274,7 +274,7 @@ static ssize_t iio_ev_value_show(struct device *dev,
> >   {
> >   	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> >   	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> > -	int val, val2;
> > +	int val, val2, val_arr[2];
> >   	int ret;
> > 
> >   	if (indio_dev->info->read_event_value) {
> > @@ -290,7 +290,9 @@ static ssize_t iio_ev_value_show(struct device *dev,
> >   			&val, &val2);
> >   		if (ret < 0)
> >   			return ret;
> > -		return iio_format_value(buf, ret, val, val2);
> > +		val_arr[0] = val;
> > +		val_arr[1] = val2;
> > +		return iio_format_value(buf, ret, val_arr);
> >   	}
> >   }
> > 
> > diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> > index 0cf5f8e..76d8b26 100644
> > --- a/drivers/iio/inkern.c
> > +++ b/drivers/iio/inkern.c
> > @@ -417,12 +417,18 @@ static int iio_channel_read(struct iio_channel *chan,
> > int *val, int *val2,
> >   	enum iio_chan_info_enum info)
> >   {
> >   	int unused;
> > +	int vals[INDIO_MAX_RAW_ELEMENTS];
> > +	int ret;
> > 
> >   	if (val2 == NULL)
> >   		val2 = &unused;
> > 
> > -	return chan->indio_dev->info->read_raw(chan->indio_dev, chan->channel,
> > -						val, val2, info);
> > +	ret = chan->indio_dev->info->read_raw(chan->indio_dev, chan->channel,
> > +					INDIO_MAX_RAW_ELEMENTS, vals, info);
> > +	*val = vals[0];
> > +	*val2 = vals[1];
> > +
> > +	return ret;
> >   }
> > 
> >   int iio_read_channel_raw(struct iio_channel *chan, int *val)
> > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > index 256a90a..0ba16b6 100644
> > --- a/include/linux/iio/iio.h
> > +++ b/include/linux/iio/iio.h
> > @@ -176,6 +176,8 @@ struct iio_event_spec {
> >    *			storage_bits:	Realbits + padding
> >    *			shift:		Shift right by this before masking out
> >    *					realbits.
> > + *			repeat:		No. of times real/storage bits repeats
> > + *					.Default: 1, unless set to other
> > value.

0 could be the default for 'repeat' and mean 1 (the default)

> >    *			endianness:	little or big endian
> >    * @info_mask_separate: What information is to be exported that is
> > specific to
> >    *			this channel.
> > @@ -220,6 +222,7 @@ struct iio_chan_spec {
> >   		u8	realbits;
> >   		u8	storagebits;
> >   		u8	shift;
> > +		u8	repeat;
> >   		enum iio_endian endianness;

repeat should be added to the end of the struct for compatibility reasons?

> >   	} scan_type;
> >   	long			info_mask_separate;
> > @@ -286,6 +289,8 @@ static inline s64 iio_get_time_ns(void)
> >   #define INDIO_ALL_BUFFER_MODES					\
> >   	(INDIO_BUFFER_TRIGGERED | INDIO_BUFFER_HARDWARE)
> > 
> > +#define INDIO_MAX_RAW_ELEMENTS		4
> > +
> >   struct iio_trigger; /* forward declaration */
> >   struct iio_dev;
> > 
> > @@ -298,8 +303,10 @@ struct iio_dev;
> >    * @read_raw:		function to request a value from the device.
> >    *			mask specifies which value. Note 0 means a reading of
> >    *			the channel in question.  Return value will specify
> > the
> > - *			type of value returned by the device. val and val2
> > will
> > + *			type of value returned by the device. val pointer
> >    *			contain the elements making up the returned value.
> > + *			val_len specifies maximum number of elements
> > + *			val pointer can contain.
> >    * @write_raw:		function to write a value to the device.
> >    *			Parameters are the same as for read_raw.
> >    * @write_raw_get_fmt:	callback function to query the expected
> > @@ -330,8 +337,8 @@ struct iio_info {
> > 
> >   	int (*read_raw)(struct iio_dev *indio_dev,
> >   			struct iio_chan_spec const *chan,
> > -			int *val,
> > -			int *val2,
> > +			int val_len,
> > +			int *vals,
> >   			long mask);
> > 
> >   	int (*write_raw)(struct iio_dev *indio_dev,
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
