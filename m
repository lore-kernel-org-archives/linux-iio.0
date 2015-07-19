Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH V2 0/6] iio: mxs-lradc: Clean up and add datasheet names
Date: Mon, 20 Jul 2015 00:11:27 +0200
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
 Hartmut Knaack <knaack.h@gmx.de>,
 "Lars-Peter Clausen" <lars@metafoo.de>,
 Peter Meerwald <pmeerw@pmeerw.net>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 Kristina
 =?utf-8?q?Mart=C5=A1enko?= <kristina.martsenko@gmail.com>,
 Fabio Estevam <fabio.estevam@freescale.com>,
 linux-iio@vger.kernel.org,
 devel@driverdev.osuosl.org
References: <1437222646-8742-1-git-send-email-stefan.wahren@i2se.com> <201507181738.21236.marex@denx.de> <55AB71B9.8070307@kernel.org>
In-Reply-To: <55AB71B9.8070307@kernel.org>
MIME-Version: 1.0
Message-Id: <201507200011.27653.marex@denx.de>
Content-Type: Text/Plain;
  charset="us-ascii"
List-ID: <linux-iio@vger.kernel.org>

On Sunday, July 19, 2015 at 11:45:29 AM, Jonathan Cameron wrote:
> On 18/07/15 16:38, Marek Vasut wrote:
> > On Saturday, July 18, 2015 at 02:30:40 PM, Stefan Wahren wrote:
> >> This patch series does some clean up in mxs-lradc and finally add the
> >> datasheet names for every usable channel.
> >> 
> >> Changes in V2:
> >>   - remove confusing i.MX28 specific comments
> >>   - fix some spelling errors
> >>   - fix up includes
> >>   - separate channel spec for i.MX23 and i.MX28
> >> 
> >> Stefan Wahren (6):
> >>   iio: mxs-lradc: clarify supported devices
> >>   iio: mxs-lradc: fix some spelling errors
> >>   iio: mxs-lradc: add missing include
> >>   iio: mxs-lradc: remove unnecessary header includes
> >>   iio: mxs-lradc: reorder header includes
> >>   iio: mxs-lradc: add datasheet name for every usable channel
> >>  
> >>  .../bindings/staging/iio/adc/mxs-lradc.txt         |    2 +-
> >>  drivers/staging/iio/adc/mxs-lradc.c                |  122
> >> 
> >> +++++++++++++------- 2 files changed, 82 insertions(+), 42 deletions(-)
> > 
> > Entire series
> > 
> > Reviewed-by: Marek Vasut <marex@denx.de>
> 
> Thanks for looking through these.
> 
> Just to let you know, there is currently a rather extended discussion going
> on (as part of a suggested topic for the kernel summit) about when
> reviewed-by tags are appropriate.

Oh, I didn't know that. I'll keep an eye on this, thanks for letting me know!

> The general feeling is they must in someway indicate some substantial work.
>  Here as a result I'd say it was appropriate for patch 6 whereas an
> Acked-by would be more appropriate for the cleanups (where there is
> nothing 'interesting'). I've left these as reviewed by for this set
> though!
> 
> Note to all reviewers I may also start added reviewed by tags that you
> haven't sent if I happen to feel you made a big contribution to review of
> a patch, but perhaps haven't revisited later versions.  I'll probably send
> out an email about this outside of this thread at some point to get
> possible wider circulation.

The explanation is also quite good. I considered Reviewed-by to mean that
you just went through the code and don't see anything obviously wrong
or something where you disagree. Acked-by is in my opinion much stronger,
where you vouch for the code correctness yourself too.

Best regards,
Marek Vasut
