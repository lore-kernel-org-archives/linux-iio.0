Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:32831 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752231AbdCPRlx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Mar 2017 13:41:53 -0400
Received: by mail-pg0-f68.google.com with SMTP id y17so6830200pgh.0
        for <linux-iio@vger.kernel.org>; Thu, 16 Mar 2017 10:41:04 -0700 (PDT)
Date: Thu, 16 Mar 2017 10:41:02 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: Gargi Sharma <gs051095@gmail.com>
Cc: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        outreachy-kernel@googlegroups.com, Michael.Hennerich@analog.com,
        knaack.h@gmx.de, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: iio: adc: Replace mlock with
 driver private lock
Message-ID: <20170316174101.GA3473@d830.WORKGROUP>
References: <alpine.DEB.2.20.1703122154130.7649@hadrien>
 <CAOCi2DH9bNChZj4kyt3t1eK7R7uSv77zeVc2PkPYxoRDDHZLsA@mail.gmail.com>
 <alpine.DEB.2.20.1703122235320.7649@hadrien>
 <20170312221350.GA14070@d830.WORKGROUP>
 <CAOCi2DEyu6_bBjsrSFzf0VcXcUnZ3LugLf==R9zsSmj+1JdFKw@mail.gmail.com>
 <35231dfd-af42-bbd3-3be6-4e03a728a92f@kernel.org>
 <73d214e0-46d0-0d4a-27e1-7c85cf3c05ed@metafoo.de>
 <CAOCi2DEecT6tdxmz7_9Q5aWC7_+VZCKD1+Vwe9F5gA9jAuQ2=A@mail.gmail.com>
 <38289FBC-9E24-4AC0-ADB2-58DB34DD208F@jic23.retrosnub.co.uk>
 <CAOCi2DFy8ve7dy0WDDqDQkE0fgJs9YWe6Ai2XspO7+dJ20rHfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOCi2DFy8ve7dy0WDDqDQkE0fgJs9YWe6Ai2XspO7+dJ20rHfA@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Mar 15, 2017 at 11:45:11PM +0530, Gargi Sharma wrote:
> On Wed, Mar 15, 2017 at 4:14 AM, Jonathan Cameron
> <jic23@jic23.retrosnub.co.uk> wrote:
> >
> >
> > On 14 March 2017 17:36:16 GMT+00:00, Gargi Sharma <gs051095@gmail.com> wrote:
> >>On Tue, Mar 14, 2017 at 2:24 AM, Lars-Peter Clausen <lars@metafoo.de>
> >>wrote:
> >>> On 03/13/2017 09:51 PM, Jonathan Cameron wrote:
> >>> [...]
> >>>>>> Gargi,
> >>>>>>
> >>>>>> Please insert the new lock above the __cacheline_aligned struct
> >>>>>> member.
> >>>>>
> >>>>> I will do that, but is there any reason why the lock should be
> >>above
> >>>>> ____cacheline_aligned struct member?
> >>>> Yes.  It's in fact very important that nothing comes after that.
> >>>>
> >>>> Will leave the why as an exercise for the reader.   I'll give the
> >>>> hit of spi drivers that do DMA...
> >>>
> >>>
> >>> One hint though, the answer is somewhere in Documentation/DMA-API.txt
> >>
> > >From what I have understood is that cacheline is used for keeping most
> >>frequently accessed values in adjacent cachelines.
> >
> > Why? What does cache line actually mean?
> >
> >> We want the
> >>cacheline_aligned at the end in the struct definition so as to avoid
> >>any holes after the cacheline boundary.
> >
> > Nope.  Try
> > http://www.pebblebay.com/a-guide-to-using-direct-memory-access-in-embedded-systems-part-two/
> >
> > (Hint, search for 'shares')
> 
> Okay, I got two things from the article:
> 1. Hardware that uses DMA reads faster if the data is aligned at
> 16/32/64B boundaries.
> 2. You want to align buffer being accessed for DMa transfers to
> prevent cache incoherence.
> 
> What I still don't understand is why nothing should come after
> __cacheline_aligned struct member?
> 
> Thanks,
> Gargi

Hi Gargi,

Short answer to why nothing can come after, is because it could
indeed share the cacheline.  ___cacheline_aligned only guarantees
alignment at the beginning of the cacheline.

I've been following and reading the posted links.  Here's another
link, kind of ancient, but does a nice explanation of the process
whereby that extra field, sharing your buffers cacheline, could
lead to corruption of that field or the buffer data.
https://lwn.net/Articles/2265/

I still haven't bottomed out on this though. I get the need
to do this to be safe, but I'd like to understand how it fits
in with systems that claim cache coherency.  Is this a case
those schemes cannot handle, or, are there MP systems that
are just not cache incoherent?

alisons
> >
> >>>
> >>--
> >>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> >>the body of a message to majordomo@vger.kernel.org
> >>More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> > --
> > Sent from my Android device with K-9 Mail. Please excuse my brevity.
