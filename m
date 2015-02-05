Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:33544 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbbBEUEz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 5 Feb 2015 15:04:55 -0500
Received: by mail-wi0-f172.google.com with SMTP id h11so182906wiw.5
        for <linux-iio@vger.kernel.org>; Thu, 05 Feb 2015 12:04:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <54D3520A.6020705@kernel.org>
References: <1419122556-8100-1-git-send-email-octavian.purdila@intel.com>
	<1419122556-8100-12-git-send-email-octavian.purdila@intel.com>
	<54A97375.8090606@kernel.org>
	<CAE1zot+7NPJGDcNFHnPofWZUt=_q9_q__N8BpXgo3G6fUbzjOQ@mail.gmail.com>
	<54D25406.8040109@kernel.org>
	<CAE1zot+H7y0Nu_kYzHAeNd7d4org4dW8RyCCx8egQTEv0q0LMA@mail.gmail.com>
	<54D3520A.6020705@kernel.org>
Date: Thu, 5 Feb 2015 22:04:45 +0200
Message-ID: <CAE1zotJadTMe09ZjXRVcazc77G1drfBaHKhy24XH1hZwDy-AWg@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] iio: bmc150: add support for hardware fifo
From: Octavian Purdila <octavian.purdila@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Feb 5, 2015 at 1:20 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On 04/02/15 20:18, Octavian Purdila wrote:
> > On Wed, Feb 4, 2015 at 7:16 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> > <snip>
> >>>> As this is on the flush rather than an interrupt these are going
> >>>> to be of dubious benefit... There isn't an obvious way of doing better though
> >>>> unless we do have an interrupt.  In that case you want to grab them as
> >>>> early as possible (typically even in the interrupt top half) and pass it
> >>>> down to where you want to use it.
> >>>
> >>> Actually flush gets called from two places: from the watermark trigger
> >>> and in this case we take the timestamp in the IRQ handler, and when we
> >>> do a read or poll and there is not enough data available in the
> >>> buffer.
> >>>
> >>> For this later case we will have an error of up to a maximum of a one
> >>> sample period since flush was called in between one of the sampling
> >>> periods - the watermark interrupt makes sure we don't stall forever.
> >>> That is not that bad.
> >> Not terrible.  I wonder if we want to indicated a dubious timestamp
> >> in some way?  Or maybe event specify a jitter on the channel?
> >> (been wondering if we want this sort of description for channels in
> >> general - how noisy are they?)  Can be very useful to userspace and
> >> is often tied up with the particular settings of the device.
> >
> > Do you mean adding something like IIO_CHAN_INFO_JITTER? That would be
> > nice, but in this case the value is variable and depends on the
> > sampling frequency. What could work would be to also add a new event
> > IIO_EV_TYPE_JITTER_CHANGED and issue it when the sampling frequency is
> > changed.
> General principle has always been that any sysfs type writes can effect
> any of other attributes, so if userspace cares it should verify that
> everything is as it expects.
> >
> > But at this point is getting too complex and I don't know how much it
> > helps userspace.
> Definitely a job for another day!
>
> Also in this category is having _available type information for all
> attributes, rather just some. Makes for nicer handling in userspace
> but adds a lot of additional sysfs files!
> >
> >
> >>> Also, the later case should be an exception if the application sets
> >>> the right watermark level and uses the right timeout. Otherwise it
> >>> will not use power optimally which is the whole point of the hw fifo.
> >>>
> >>>>> +
> >>>>> +     tstamp = data->timestamp - count * sample_freq;
> >>>>> +
> >>>>> +     for (i = 0; i < count; i++) {
> >>>>> +             u16 sample[8];
> >>>>> +             int j, bit;
> >>>>> +
> >>>>> +             j = 0;
> >>>>> +             for_each_set_bit(bit, indio_dev->buffer->scan_mask,
> >>>>> +                              indio_dev->masklength) {
> >>>>> +                     memcpy(&sample[j++], &buffer[i * 3 + bit], 2);
> >>>>> +             }
> >>>>
> >>>> A local demux rather than using the main iio one. Given you clearly read the
> >>>> lot anyway is there any reason not to just pass it all on and let the IIO
> >>>> demux handling the demux on the way to the kfifo?
> >>>>
> >>>
> >>> Hmm, isn't the demux part only used when we have client buffers?  The
> >>> demux part is not used at all in my tests, due to
> >>> indio_dev->active_scan_mask being equal to buffer->scan_mask.
> >> I'm guessing you figured this out. Yes, only used with client buffers,
> >> but the normal buffered access is a client buffer :)
> >>>
> >
> > Correct me if I am wrong: when we only use normal buffer access (no
> > kernel clients) the active_scan_mask is always equal to
> > buffer->scan_mask thus no demux will happen in core. So we still need
> > to do the demux in the driver.
> >
> > In fact the above is true when we have only one client, be it user or kernel.
> Not quite.  If the device driver provides available_scan_masks (e.g. indicates
> that general random access is not possible) then the demux is used to pull
> out what the buffer wants from the in coming stream.
>
> Basically, there is no point in doing local demux of incoming data as this
> is better left to the core (which knows about everything that wants the data
> and can chose appropriately).
>
> Now, if you have a true random access part (any channel, any order any time -
> so basically convert on demand devices) then don't provide available_scan_masks
> and everything works as you say.


Aha so that is what available_scan_masks is for !

Now, if I set available_scan_masks it means that we should also change
the bmc150_accel_trigger_handler to always read the 3 axes, right?

This actually fits well with some optimizations Irina has in the works.
