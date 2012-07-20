Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: "Lars-Peter Clausen" <lars@metafoo.de>
Subject: Re: [PATCH] IIO: Add basic MXS LRADC driver
Date: Fri, 20 Jul 2012 17:12:52 +0200
Cc: linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Jonathan Cameron <jic23@kernel.org>,
 Wolfgang Denk <wd@denx.de>,
 Juergen Beisert <jbe@pengutronix.de>
References: <1341368129-20468-1-git-send-email-marex@denx.de> <201207192126.31772.marex@denx.de> <50096723.2070409@metafoo.de>
In-Reply-To: <50096723.2070409@metafoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201207201712.52745.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

Dear Lars-Peter Clausen,

> On 07/19/2012 09:26 PM, Marek Vasut wrote:
> > Dear Lars-Peter Clausen,
> > 
> >> On 07/19/2012 04:23 PM, Marek Vasut wrote:
> >>> Dear Lars-Peter Clausen,
> >>> 
> >>> Sorry for my late reply, got busy with other crazy stuff.
> >>> 
> >>> [...]
> >>> 
> >>>>>> Is there any reason not to use the mxs_lradc struct directly has the
> >>>>>> iio data?
> >>>>> 
> >>>>> I explained it below in the patch. I hope we'll eventually support
> >>>>> the delay triggers, which will need 4 separate IIO devices. And this
> >>>>> is where this structure will be augmented by other components.
> >>>> 
> >>>> Ok I saw the comment, but it wasn't obvious to me that delay channels
> >>>> will require multiple IIO devices. Might make sense to state this
> >>>> explicitly.
> >>> 
> >>> Fixed.
> >>> 
> >>>>>>> [...]
> >>>>>>> 
> >>>>>>> +
> >>>>>>> +/*
> >>>>>>> + * Channel management
> >>>>>>> + *
> >>>>>>> + * This involves crazy mapping between 8 virtual channels the
> >>>>>>> CTRL4 register + * can harbor and 16 channels total this hardware
> >>>>>>> supports. + */
> >>>>>> 
> >>>>>> I suppose this means only a maximum 8 channels can be active at a
> >>>>>> time. I've recently posted a patch which makes it easy to implement
> >>>>>> such a restriction.
> >>>>>> http://www.spinics.net/lists/linux-iio/msg05936.html and
> >>>>>> http://www.spinics.net/lists/linux-iio/msg05935.html for an example
> >>>>>> validate callback implementation. In your case you'd check for
> >>>>>> bitmap_weight(...) <= 8. Those patches are not yet in IIO though.
> >>>>> 
> >>>>> This is good. When do you expect this to hit linux-next possibly? Or
> >>>>> at least linux-iio?
> >>>> 
> >>>> soon, hopefully.
> >>> 
> >>> So I checked this, not sure how it'll help me though.
> >> 
> >> Right now with your driver you can enable any combination of channels.
> >> If more than 8 channels are enabled and you start sampling it will
> >> fail, since not all channels can be mapped. With those patch you can
> >> implement a validate callback and check for bitmap_weight(scan_mask) <=
> >> 8. This will ensure that it is not possible to select more than 8
> >> channels at once, which again means that starting sampling can't fail
> >> of this.
> > 
> > Ok, I fixed this one. One last thing that I don't really understand is
> > this. I run generic_buffer.c to source samples from the LRADC. Is there
> > any way to continuously sample them? Because right now, I get one sample
> > and that's it, no more samples happen later on (I can 0 data in
> > subsequent read() call).
> 
> I'd consider that a bug in your driver ;)
> The intend with IIO is that once you start sampling by enabling the buffer
> you get a continuous data stream until sampling is stopped and this works
> fine with other drivers.

Ah! Thanks, I'll poke into this.

> - Lars

Best regards,
Marek Vasut
