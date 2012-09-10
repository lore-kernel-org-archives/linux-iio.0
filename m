Return-Path: <pmeerw@pmeerw.net>
Date: Mon, 10 Sep 2012 08:54:02 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: add driver for si114x ambient light / proximity
 sensors
In-Reply-To: <504B780F.8090305@kernel.org>
Message-ID: <alpine.DEB.2.01.1209090915400.21990@pmeerw.net>
References: <1346974582-5936-1-git-send-email-pmeerw@pmeerw.net> <504B780F.8090305@kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

Hello Jonathan,

> Generally a brief description of the part in the patch description is
> useful for new drivers.  Tells people why they might want one of these ;)

thanks for the review comments!
I am not affiliated with Silabs, just happen to use the chip

> Anyhow, mostly looking good.  You do have a liking for complex dynamic
> allocation of various structures that are almost always handled in other
> drivers as picking between constant arrays. Sorry but the constant array
> version is easier to read and also means they are shared between multiple
> instances so please change over to that or tell me what I'm missing that
> prevents it :)

I agree that dynamic construction of channels and attributes is tedious :)
one has to decide between a don't-repeat-yourself paradigm in terms of 
channel or attribute spec, and simpler code with redundant data

I'll switch to constant arrays

> Infact when you get down to it most of my comments are about using
> standard easy to read forms to implement stuff.  It's easy for
> reviewers to read code that uses them and also pick up on any
> bugs in them.  As they say, avoid reinventing the wheel if you
> don't have to!

I think the is no wheel (helper API) yet for dynamic allocation of 
attributes; for more than two sets of attributes, the current situation is 
a mess

> Document this structure please.  There are a couple
> of things in here where it is far from obvious what
> they do.  Probaby best to just do kerneldoc for
> the whole thing.
> > +struct si114x_data {
> > +	struct i2c_client *client;
> > +	struct iio_info *info;
> > +	u8 part;
> > +	u8 rev;
> I'd like to see some short docs on what the revisions
> numbers effect of part operation is...

parts basically gives the number of leds: 0x41 -> 1, 0x42 -> 2, etc.
rev is unused
seq is the sequencer/firmware revision: 0x03 -> A03, 0x08 -> A10, 0x09 -> 
A10; there are some minor differences: <= A02 lacks separate controls for 
the IR channel; A10 <= has compresses threshold (which we don't use 
currently; A11 has 16 bit uncompressed threshold values)

the driver targets >= A03
 
> > +static int si114x_update_scan_mode(struct iio_dev *indio_dev,
> > +	const unsigned long *scan_mask)
> > +{
> > +	struct si114x_data *data = iio_priv(indio_dev);
> > +
> > +	kfree(data->buffer);
 
> I'd be tempted to be cynical and just have this as a constant
> sized array in data big enough to take all comers. That way
> you can avoid this fiddly handling.  Actually given the nature
> of memory allocators this may well result in more memory being
> allocated - particularly as i2c doesn't require cacheline separation
> (it copies everything).

the motivation for dynamic allocation is not to be memory-efficient;
in update_scan_mode() the buffer size (== scan_bytes) can be easily 
queried, in probe() I think there is no way to get the maximum buffer size 
given all channels?

so I'd have to hard-code, taking into account the ugly timestamp alignment

> > +	if (data->seq < SI114X_SEQ_REV_A03)
> > +		dev_info(&data->client->dev, "WARNING: old sequencer revision\n");
> That's nice, but what does it mean for the user?

well...
separate gain controls for the IR channel were added in A03; I think the 
driver is still mostly useable (some attribute make no sense)

given the pain with dynamic channels/attributes, I decided to just give a 
message and carry on; but it can be changed to an error, certainly

I don't think that < A03 is that common nowadays

> > +static ssize_t si114x_range_store(struct device *dev,
> > +				struct device_attribute *attr,
> > +				const char *buf, size_t len)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct iio_dev_attr *dev_attr = to_iio_dev_attr(attr);
> > +	struct si114x_data *data = iio_priv(indio_dev);
> > +	int ret;
> > +
> Not keen on this at all.  Does it correspond to numbers in
> any real sense?  Basically one drivers 'normal' is another
> ones 'high' so numbers are the way to go for generality
> when it comes to userspace interfaces dealing with these
> devices...
> (and yes there are some drivers doing this including some
> I wrote, but its a case of 'do as I say rather than as I do...'
> and moan at me when I take this shortcut ;)

well, there is a bit which enables a 14.5x gain multiplier (on top of some 
other gain setting which is set by HARDWAREGAIN); we can of course use 0 
and 1 :)

is there a better way?

> > +static IIO_DEVICE_ATTR(in_intensity_ir_range, S_IRUGO | S_IWUSR,
> > +			si114x_range_show,
> > +			si114x_range_store,
> > +			SI114X_PARAM_ALSIR_ADC_MISC);
> hmm. range again.  I think we agreed a while ago that this could go
> in to the chan_info types which will get rid of these.
> (I always prefered doing the equivalent with scale as it is more
> relevant when you are handling raw outputs rather than processed ones).

well, there is some complication:

there are 3 proximity channels, 1 ALS and 1 ALS-IR
all 3 proximity channels have one range control in common, ALS and ALS-IR 
have their own range control each (unless use have seq. A03 where they 
share the control, let's ignore that)

I could use ext_info for ALS and ALS_IR (as that's per channel), but not 
for proximity; I decided to do range control the same way for all channels
 
> So what we have is channels varying only in the number of leds present
> and hence the number of proximity channels?

yes

> Just put the leds at the end of a static array and change num_channels
> appropriately (quite a few drivers pull this trick)

can do
the timestamp channel can have scanindex 0 in that case?
 
> You will end up with holes in your scan index but that is perfectly
> acceptable under the abi (and again common because of this sort
> of situation).
> The following is the unwound form of what you had I think..
> 
> static const struct iio_chan_spec si114x_channels[] =
> 	{
> 		.type = IIO_INTENSITY,
> 		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
> 			   IIO_CHAN_INFO_HARDWAREGAIN_SEPARATE_BIT,
> 		.scan_type = IIO_ST('u', 16, 16, 0),
> 		.scan_index = 3,
> 		.address = SI114X_REG_ALSVIS_DATA0,
> //this should probably have a modifier as well...

not sure?
I don't think LIGHT_CLEAR makes it any clearer (haha)

> Then simpy have
> indio_dev->num_channels = ARRAY_SIZE(si114x_channels) - 6 + si114x_leds(data)*2;
> + a suitable comment explaining what is going on.

thanks again for the comments; I'll do some more testing and then resubmit

regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
