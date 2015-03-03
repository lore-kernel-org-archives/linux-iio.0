Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from h1.radempa.de ([176.9.142.194]:52865 "EHLO mail.cosmopool.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756199AbbCCLRm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 3 Mar 2015 06:17:42 -0500
From: Harald Geyer <harald@ccbib.org>
To: John Stultz <john.stultz@linaro.org>
cc: Jonathan Cameron <jic23@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-iio@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 1/3] timekeeping: Provide new API to get the current time resolution
In-reply-to: <CALAqxLUzvnSqVrbqMgoV33kP4Attg-vM8Ziu2Ztx5CGQ4gDP1Q@mail.gmail.com>
References: <1425329766-14703-1-git-send-email-harald@ccbib.org> <1425329766-14703-2-git-send-email-harald@ccbib.org> <CALAqxLUzvnSqVrbqMgoV33kP4Attg-vM8Ziu2Ztx5CGQ4gDP1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 03 Mar 2015 12:17:35 +0100
Message-Id: <E1YSkpT-000112-Lc@stardust.g4.wien.funkfeuer.at>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

John Stultz writes:
> On Mon, Mar 2, 2015 at 12:56 PM, Harald Geyer <harald@ccbib.org> wrote:
> > This has been tested on i386, sunxi and mxs.
> 
> So the patch needs to have the actual rational for inclusion here, not
> in the cover-letter, since the cover-letter gets thrown away.
 
Hm, to show the rational I included Patch 3 which is probably not
apt for the commit message. How about the following:

| This patch series introduces a new function
| u32 ktime_get_resolution_ns(void) 
| which allows to clean up some driver code.
|
| In particular the IIO subsystem has a function to provide timestamps for
| events but no means to get their resolution. So currently the dht11 driver
| tries to guess the resolution in a rather messy and convoluted way. We
| can do much better with the new code.

> > Signed-off-by: Harald Geyer <harald@ccbib.org>
> > ---
> >  include/linux/timekeeping.h |    1 +
> >  kernel/time/timekeeping.c   |   18 ++++++++++++++++++
> >  2 files changed, 19 insertions(+), 0 deletions(-)
> >
> > diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
> > index 3eaae47..983b61e 100644
> > --- a/include/linux/timekeeping.h
> > +++ b/include/linux/timekeeping.h
> > @@ -163,6 +163,7 @@ extern ktime_t ktime_get(void);
> >  extern ktime_t ktime_get_with_offset(enum tk_offsets offs);
> >  extern ktime_t ktime_mono_to_any(ktime_t tmono, enum tk_offsets offs);
> >  extern ktime_t ktime_get_raw(void);
> > +extern u32 ktime_get_resolution_ns(void);
> >
> >  /**
> >   * ktime_get_real - get the real (wall-) time in ktime_t format
> > diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> > index 91db941..b823eba 100644
> > --- a/kernel/time/timekeeping.c
> > +++ b/kernel/time/timekeeping.c
> > @@ -586,6 +586,24 @@ ktime_t ktime_get(void)
> >  }
> >  EXPORT_SYMBOL_GPL(ktime_get);
> >
> > +u32 ktime_get_resolution_ns(void)
> > +{
> > +       struct timekeeper *tk = &tk_core.timekeeper;
> > +       unsigned int seq;
> > +       u32 nsecs;
> > +
> > +       WARN_ON(timekeeping_suspended);
> > +
> > +       do {
> > +               seq = read_seqcount_begin(&tk_core.seq);
> > +               nsecs = tk->tkr.mult >> tk->tkr.shift;
> > +       } while (read_seqcount_retry(&tk_core.seq, seq));
> > +
> > +       return nsecs;
> > +}
> > +
> > +EXPORT_SYMBOL_GPL(ktime_get_resolution_ns);
> > +
> 
> So is this always going to be an internal-only interface?

As far as I'm concerned: yes.

> I know in
> the past folks have wanted clock_getres() to return similar hardware
> granular resolution, but Thomas has pushed back against this due to
> the fact that the resolution could fluctuate during the lifetime of a
> system and there's no way to correlate a resolution returned from
> clock_getres and a a value returns from clock_gettime.

I don't see why this would be a hard problem: Just have some counter
incremented every time the clock source changes and expose that counter
to userspace too. But I'm not interested in this. If anybody want's 
this information in userspace, it's theirs to make the case and propose
a solution that suits them.

> So while for internal purposes, we could probably support something
> like this, we really do need to make sure we're not exposing uselessly
> racy interfaces to userland.

Right now I report the resolution in the kernel log (if it is too low).
I think this is okay by your standards. Anything else you have in mind?

thanks,
Harald
