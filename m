Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 92-243-34-74.adsl.nanet.at ([92.243.34.74]:33248 "EHLO
        mail.osadl.at" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1751755AbdGEKMJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Jul 2017 06:12:09 -0400
Date: Wed, 5 Jul 2017 10:11:41 +0000
From: Nicholas Mc Guire <der.herr@hofr.at>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        simran singhal <singhalsimran0@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        linux-iio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] iio: pressure: zpa2326: report interrupted case as
 failure
Message-ID: <20170705101141.GA9837@osadl.at>
References: <1494751435-14189-1-git-send-email-der.herr@hofr.at>
 <CAMuHMdXdcY1fsZsdgUe7=gNUaKannGe==4BvQTwren898QXPfw@mail.gmail.com>
 <20170704200853.16dc9e3a@kernel.org>
 <20170705073705.GA8145@osadl.at>
 <CAMuHMdWyC+fJZO_3jLx7U0dVO5EsBpcR-JLtA3esikwL_MmN_g@mail.gmail.com>
 <20170705085547.GB8789@osadl.at>
 <20170705180609.00003f33@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170705180609.00003f33@huawei.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Jul 05, 2017 at 06:06:09PM +0800, Jonathan Cameron wrote:
> On Wed, 5 Jul 2017 08:55:47 +0000
> Nicholas Mc Guire <der.herr@hofr.at> wrote:
> 
> > On Wed, Jul 05, 2017 at 10:02:17AM +0200, Geert Uytterhoeven wrote:
> > > Hi Nicholas,
> > > 
> > > On Wed, Jul 5, 2017 at 9:37 AM, Nicholas Mc Guire
> > > <der.herr@hofr.at> wrote:  
> > > > On Tue, Jul 04, 2017 at 08:08:53PM +0100, Jonathan Cameron
> > > > wrote:  
> > > >> On Tue, 4 Jul 2017 12:40:33 +0200
> > > >> Geert Uytterhoeven <geert@linux-m68k.org> wrote:  
> > > >> > On Sun, May 14, 2017 at 10:43 AM, Nicholas Mc Guire
> > > >> > <der.herr@hofr.at> wrote:  
> > > >> > > If the timeout-case prints a warning message then probably
> > > >> > > the interrupted case should also. Further,
> > > >> > > wait_for_completion_interruptible_timeout() returns long not
> > > >> > > int.
> > > >> > >
> > > >> > > Fixes: commit 03b262f2bbf4 ("iio:pressure: initial zpa2326
> > > >> > > barometer support") Signed-off-by: Nicholas Mc Guire
> > > >> > > <der.herr@hofr.at> ---
> > > >> > >
> > > >> > > The original control-flow was technically not wrong just
> > > >> > > confusing and a bit complicated. Not clear if reporting the
> > > >> > > interrupted case actually is useful, but given that the
> > > >> > > timeout is relatively long (200ms) it is not that unlikely
> > > >> > > so differentiating the cases seems helpful.
> > > >> > >
> > > >> > > Patch was compile-tested with: x86_64_defconfig +
> > > >> > > CONFIG_IIO=m, CONFIG_ZPA2326=m
> > > >> > >
> > > >> > > Patch is against v4.11 (localversion-next is next-20170512)
> > > >> > >
> > > >> > >  drivers/iio/pressure/zpa2326.c | 17 ++++++++++-------
> > > >> > >  1 file changed, 10 insertions(+), 7 deletions(-)
> > > >> > >
> > > >> > > diff --git a/drivers/iio/pressure/zpa2326.c
> > > >> > > b/drivers/iio/pressure/zpa2326.c index e58a0ad..617926f
> > > >> > > 100644 --- a/drivers/iio/pressure/zpa2326.c
> > > >> > > +++ b/drivers/iio/pressure/zpa2326.c
> > > >> > > @@ -867,12 +867,13 @@ static int
> > > >> > > zpa2326_wait_oneshot_completion(const struct iio_dev
> > > >> > > *indio_dev, { int          ret;
> > > >> > >         unsigned int val;
> > > >> > > +       long     timeout;
> > > >> > >
> > > >> > >         zpa2326_dbg(indio_dev, "waiting for one shot
> > > >> > > completion interrupt");
> > > >> > >
> > > >> > > -       ret = wait_for_completion_interruptible_timeout(
> > > >> > > +       timeout = wait_for_completion_interruptible_timeout(
> > > >> > >                 &private->data_ready,
> > > >> > > ZPA2326_CONVERSION_JIFFIES);
> > > >> > > -       if (ret > 0)
> > > >> > > +       if (timeout > 0)  
> > > >> >
> > > >> > Check for strict positive timeout.
> > > >> >  
> > > >> > >                 /*
> > > >> > >                  * Interrupt handler completed before
> > > >> > > timeout: return operation
> > > >> > >                  * status.
> > > >> > > @@ -882,13 +883,15 @@ static int
> > > >> > > zpa2326_wait_oneshot_completion(const struct iio_dev
> > > >> > > *indio_dev, /* Clear all interrupts just to be sure. */
> > > >> > > regmap_read(private->regmap, ZPA2326_INT_SOURCE_REG, &val);
> > > >> > >
> > > >> > > -       if (!ret)
> > > >> > > +       if (!timeout) {  
> > > >> >
> > > >> > Check for zero timeout.
> > > >> >  
> > > >> > >                 /* Timed out. */
> > > >> > > +               zpa2326_warn(indio_dev, "no one shot
> > > >> > > interrupt occurred (%ld)",
> > > >> > > +                            timeout);
> > > >> > >                 ret = -ETIME;
> > > >> > > -
> > > >> > > -       if (ret != -ERESTARTSYS)
> > > >> > > -               zpa2326_warn(indio_dev, "no one shot
> > > >> > > interrupt occurred (%d)",
> > > >> > > -                            ret);
> > > >> > > +       } else if (timeout < 0) {  
> > > >> >
> > > >> > So if we get here, timeout is always strict negative, so the
> > > >> > check can be removed.
> > > >> >  
> > > >> > > +               zpa2326_warn(indio_dev, "wait for one shot
> > > >> > > interrupt canceled");
> > > >> > > +               ret = -ERESTARTSYS;
> > > >> > > +       }
> > > >> > >
> > > >> > >         return ret;  
> > > >> >
> > > >> > But gcc-4.1.2 is not smart enough:
> > > >> >
> > > >> > drivers/iio/pressure/zpa2326.c:868: warning: ???ret??? may be
> > > >> > used uninitialized in this function  
> > > >> Good analysis.  Care to send the obvious patch?
> > > >>  
> > > > Thanks Geert for finding that - yes ret needs to be
> > > > initialized to 0 here, success case as documented in
> > > > the header of zpa2326_wait_oneshot_completion -  
> > > 
> > > No, ret does not need to be initialized to 0, as it would prevent
> > > the warning from reappearing in case of future logic errors.
> > > 
> > > Instead the last "if" should be removed, as it's always true.
> > > Will send a patch, as requested by Jonathan.
> > >  
> > hmm... the if can be removed but then it would be two return
> > statements and one could simply drop ret all together
> > 
> >         if (!timeout) {
> >                 /* Timed out. */
> >                 zpa2326_warn(indio_dev, "no one shot interrupt
> > occurred (%ld)", timeout);
> >                 return -ETIME;
> >         } 
> >         zpa2326_warn(indio_dev, "wait for one shot interrupt
> > cancelled"); return -ERESTARTSYS
> > 
> > but I assumed that kernel code should try to not end up
> > with too many exit points, in which case the if is needed
> > and the warning could be elimnated by initializing ret to 0
> > even if that is more or less usless.
> Usual rule of thumb for kernel style is that if you have cleanup to
> do (releasing locks etc) then it should be done at a common location.
> If there is no cleanup then you should return directly.  
>
yup - just rechecked "7) Centralized exiting of functions" in coding-style.rst
so the solution I posted was wrong - thanks for the clarification !

thx!
hforat
