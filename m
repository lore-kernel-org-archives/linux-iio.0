Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: Hector Palacios <hector.palacios@digi.com>
Subject: Re: [PATCH] iio: mxs-lradc: Remove useless check in read_raw
Date: Wed, 3 Jul 2013 13:38:26 +0200
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "fabio.estevam@freescale.com" <fabio.estevam@freescale.com>,
 jic23@kernel.org
References: <1372723722-13902-1-git-send-email-marex@denx.de> <201307021955.45799.marex@denx.de> <51D3EE00.4050907@digi.com>
In-Reply-To: <51D3EE00.4050907@digi.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201307031338.26928.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

Dear Hector Palacios,

> Dear Marek,
> 
> On 07/02/2013 07:55 PM, Marek Vasut wrote:
> > Dear Otavio Salvador,
> > 
> >> On Tue, Jul 2, 2013 at 2:36 PM, Marek Vasut <marex-
ynQEQJNshbs@public.gmane.org> wrote:
> >>> Dear Otavio Salvador,
> >>> 
> >>>> On Tue, Jul 2, 2013 at 1:13 PM, Marek Vasut <marex-
ynQEQJNshbs@public.gmane.org> wrote:
> >>>>> Dear Alexandre Belloni,
> >>>>> 
> >>>>>> On 02/07/2013 14:03, Marek Vasut wrote:
> >>>>>>> Dear Alexandre Belloni,
> >>>>>>> 
> >>>>>>>> Dear Marek,
> >>>>>>>> 
> >>>>>>>> I don't seem to be hitting that issue. I'm using 3.10rc7. Do you
> >>>>>>>> know how to reproduce it ?
> >>>>>>> 
> >>>>>>> The check is just redundant, it's not a bug.
> >>>>>> 
> >>>>>> Ok, that's what I understood first but then got confused by reports
> >>>>>> of it solving a bug.
> >>>>> 
> >>>>> It cannot solve a thing. If it does, then we have a problem.
> >>>>> 
> >>>>> What kind of bug do you see ? How can I replicate it ? Can you send
> >>>>> me a testcase?
> >>>> 
> >>>> As I said this code sometimes work. If you put a printf before this
> >>>> call it sometimes work. So I think we have a race somewhere.
> >>>> 
> >>>> When I were debugging this I found that when it works we have 10
> >>>> active channels, it seems.
> >>> 
> >>> Uh, the read_raw() should exit with -EBUSY, since the mutex_tryload()
> >>> will fail iff buffered operation is in progress. Or what do you mean by
> >>> having "10 active channels"?
> >> 
> >> The read_raw returned invalid. The onehot always returns false and I
> >> have 10 as mask comparing return.
> > 
> > Looking at the code.
> > 
> > the bitmap_set() will set (1 << chan->channel) into "mask" var.
> > 
> > The iio_validate_scan_mask_onehot is implemented like this:
> > 
> > 688 bool iio_validate_scan_mask_onehot(struct iio_dev *indio_dev,
> > 689         const unsigned long *mask)
> > 690 {
> > 691         return bitmap_weight(mask, indio_dev->masklength) == 1;
> > 692 }
> > 
> > So if mask _always_ has exactly one bit set, the
> > iio_validate_scan_mask_onehot will always return 1. Aaaand ... now I see
> > why it fixes a bug for you.
> > 
> > if (ret)
> > 
> >   return -EINVAL;
> > 
> > This stuff above will always be if (1) so will always return -EINVAL.
> > Dang!
> 
> Yes, this was exactly what was happening on my MX28 when trying to read one
> channel. Now, after the different comments I'm confused, was this a bug
> that your patch solved or was I doing something wrong?

This patch accidentally (in completely unintended way) solved a bug, yes. But 
the main idea was to just remove redundant code.

Best regards,
Marek Vasut
