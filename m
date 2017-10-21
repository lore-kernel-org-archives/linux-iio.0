Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932102AbdJUQjZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Oct 2017 12:39:25 -0400
Date: Sat, 21 Oct 2017 17:39:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Phil Reid <preid@electromag.com.au>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/1] iio: inkern: add helper to enable a channel
Message-ID: <20171021173920.31a90145@archlinux>
In-Reply-To: <10792f6e-76d0-5804-8306-e893d8b8f23c@electromag.com.au>
References: <1507171066-83517-1-git-send-email-preid@electromag.com.au>
        <20171008114115.7002f440@archlinux>
        <10792f6e-76d0-5804-8306-e893d8b8f23c@electromag.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 16 Oct 2017 09:50:34 +0800
Phil Reid <preid@electromag.com.au> wrote:

> On 8/10/2017 18:41, Jonathan Cameron wrote:
> > On Thu,  5 Oct 2017 10:37:46 +0800
> > Phil Reid <preid@electromag.com.au> wrote:
> >   
> >> This is done by calling a generic write attribute helper similar
> >> to the existing read attribute helper. Update write raw helper
> >> to use new write attribute function.
> >>
> >> Signed-off-by: Phil Reid <preid@electromag.com.au>  
> > 
> > Hi Phil,
> > 
> > In principle this is fine but there are a few subtle details that need
> > tidying up...
> > 
> > Also - normally a core ABI patch like this would only be applied as
> > part of a series that is using the change.  Is such a series on its
> > way?  We would want to see a usecase to evaluate the additional
> > interface.  
> 
> G'day Jonathan,
> 
> Not really. The hardware for the driver is custom fpga core and external hardware device.
> No reason it can't be up-streamed but I doubt it'd be of use to anyone else and I haven't
> made much effort to write the driver to meet the kernel coding standards.
> 
> Driver is basically a posix clock using an OCXO that is tuned using a DAC.
> Don't know if there's any interest in such a thing.
Yeah - that one is a little random ;)

Hohum.  Lets make an exception - with the tidy ups below I'll take this
even though we don't have an in kernel user for now...

Jonathan
> 
> 
> > 
> > Thanks,
> > 
> > Jonathan  
> >> ---
> >>   drivers/iio/inkern.c         | 17 +++++++++++++++--
> >>   include/linux/iio/consumer.h |  9 +++++++++
> >>   2 files changed, 24 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> >> index 069defc..51c5c967 100644
> >> --- a/drivers/iio/inkern.c
> >> +++ b/drivers/iio/inkern.c
> >> @@ -850,7 +850,9 @@ static int iio_channel_write(struct iio_channel *chan, int val, int val2,
> >>   						chan->channel, val, val2, info);
> >>   }
> >>   
> >> -int iio_write_channel_raw(struct iio_channel *chan, int val)
> >> +static int iio_write_channel_attribute(struct iio_channel *chan,
> >> +				       int val, int val2,
> >> +				       enum iio_chan_info_enum attribute)  
> > 
> > Hmm. Val2 only has meaning if we know the type of the write value
> > - i.e. how the driver is going to interpret val and val2. I would
> > suggest that we also need a function to allow the consumer driver to access
> > that information.
> > 
> > In this patch you aren't actually using val2 anyway so I'm not sure why
> > this is here.  
> 
> Yes this is true but the intention was that it is a mutex locked wrapper for the existing
> iio_channel_write function that has val / val2. So my thought was including it would make it
> easy to add other helpers in the future that use val2.
> 
> >   
> >>   {
> >>   	int ret;
> >>   
> >> @@ -860,14 +862,25 @@ int iio_write_channel_raw(struct iio_channel *chan, int val)
> >>   		goto err_unlock;
> >>   	}
> >>   
> >> -	ret = iio_channel_write(chan, val, 0, IIO_CHAN_INFO_RAW);
> >> +	ret = iio_channel_write(chan, val, val2, attribute);
> >>   err_unlock:
> >>   	mutex_unlock(&chan->indio_dev->info_exist_lock);
> >>   
> >>   	return ret;
> >>   }
> >> +
> >> +int iio_write_channel_raw(struct iio_channel *chan, int val)
> >> +{
> >> +	return iio_write_channel_attribute(chan, val, 0, IIO_CHAN_INFO_RAW);
> >> +}
> >>   EXPORT_SYMBOL_GPL(iio_write_channel_raw);
> >>   
> >> +int iio_write_channel_enable(struct iio_channel *chan, int val)
> >> +{
> >> +	return iio_write_channel_attribute(chan, val, 0, IIO_CHAN_INFO_ENABLE);
> >> +}
> >> +EXPORT_SYMBOL_GPL(iio_write_channel_enable);
> >> +
> >>   unsigned int iio_get_channel_ext_info_count(struct iio_channel *chan)
> >>   {
> >>   	const struct iio_chan_spec_ext_info *ext_info;
> >> diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
> >> index 5e347a9..4a5a90d 100644
> >> --- a/include/linux/iio/consumer.h
> >> +++ b/include/linux/iio/consumer.h
> >> @@ -226,6 +226,15 @@ int iio_read_channel_raw(struct iio_channel *chan,
> >>   int iio_write_channel_raw(struct iio_channel *chan, int val);
> >>   
> >>   /**
> >> + * iio_write_channel_enable() - enable a given channel
> >> + * @chan:		The channel being queried.
> >> + * @val:		Value being written.
> >> + *
> >> + * Enable / disable the channel.
> >> + */
> >> +int iio_write_channel_enable(struct iio_channel *chan, int val);
> >> +
> >> +/**
> >>    * iio_read_max_channel_raw() - read maximum available raw value from a given
> >>    *				channel, i.e. the maximum possible value.
> >>    * @chan:		The channel being queried.  
> > 
> > 
> >   
> 
> 

