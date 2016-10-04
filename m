Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:32839 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752877AbcJDXsB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Oct 2016 19:48:01 -0400
Received: by mail-pa0-f65.google.com with SMTP id hh10so3270876pac.0
        for <linux-iio@vger.kernel.org>; Tue, 04 Oct 2016 16:48:01 -0700 (PDT)
Date: Tue, 4 Oct 2016 16:47:58 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: sayli karnik <karniksayli1995@gmail.com>
Cc: outreachy-kernel <outreachy-kernel@googlegroups.com>,
        linux-iio@vger.kernel.org, lars@metafoo.de
Subject: Re: [Outreachy kernel] [PATCH] iio: imu: bmi160: bmi160_core: Fix
 sparse warning
Message-ID: <20161004234757.GA5635@d830.WORKGROUP>
References: <20161001110418.GA25515@sayli-HP-15-Notebook-PC>
 <20161002050032.GA14117@d830.WORKGROUP>
 <e4800421-2dc9-2460-470b-a043d198f469@metafoo.de>
 <20161002232524.GA2822@d830.WORKGROUP>
 <CAKG5xWi6M5jemARfENuVgigaqUbvdJmeVbwpR3kWDM9d8LBW-w@mail.gmail.com>
 <20161003171601.GC3132@d830.WORKGROUP>
 <CAKG5xWj7RSTpeGcnJtA-2PJk5NVFO_2DV-Fgo938wAafvhS8PA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKG5xWj7RSTpeGcnJtA-2PJk5NVFO_2DV-Fgo938wAafvhS8PA@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Oct 05, 2016 at 03:17:22AM +0530, sayli karnik wrote:
> On Mon, Oct 3, 2016 at 10:46 PM, Alison Schofield <amsfield22@gmail.com> wrote:
> > On Mon, Oct 03, 2016 at 07:07:39PM +0530, sayli karnik wrote:
> >> On Mon, Oct 3, 2016 at 4:55 AM, Alison Schofield <amsfield22@gmail.com> wrote:
> >> > On Sun, Oct 02, 2016 at 05:53:08PM +0200, Lars-Peter Clausen wrote:
> >> >> On 10/02/2016 07:00 AM, Alison Schofield wrote:
> >> >> [...]
> >> >> >> ---
> >> >> >>  drivers/iio/imu/bmi160/bmi160_core.c | 3 ++-
> >> >> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >> >> >>
> >> >> >> diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
> >> >> >> index e0251b8..5355507 100644
> >> >> >> --- a/drivers/iio/imu/bmi160/bmi160_core.c
> >> >> >> +++ b/drivers/iio/imu/bmi160/bmi160_core.c
> >> >> >> @@ -398,7 +398,8 @@ static irqreturn_t bmi160_trigger_handler(int irq, void *p)
> >> >> >>    struct iio_poll_func *pf = p;
> >> >> >>    struct iio_dev *indio_dev = pf->indio_dev;
> >> >> >>    struct bmi160_data *data = iio_priv(indio_dev);
> >> >> >> -  s16 buf[16]; /* 3 sens x 3 axis x s16 + 3 x s16 pad + 4 x s16 tstamp */
> >> >> >> +  __le16 buf[16];
> >> >> >> +  /* 3 sens x 3 axis x __le16 + 3 x __le16 pad + 4 x __le16 tstamp */
> >> >> >>    int i, ret, j = 0, base = BMI160_REG_DATA_MAGN_XOUT_L;
> >> >> >>    __le16 sample;
> >> >> >
> >> >> > Wondering about this option below.  Data was read into an __le16, so that
> >> >> > was good diligence on drivers part.  Seems we can use le16_to_cpu() for the
> >> >> > conversion into the buf.
> >> >> >
> >> >> > --- a/drivers/iio/imu/bmi160/bmi160_core.c
> >> >> > +++ b/drivers/iio/imu/bmi160/bmi160_core.c
> >> >> > @@ -408,7 +408,7 @@ static irqreturn_t bmi160_trigger_handler(int irq, void *p)
> >> >> >                                    &sample, sizeof(__le16));
> >> >> >             if (ret < 0)
> >> >> >                     goto done;
> >> >> > -           buf[j++] = sample;
> >> >> > +           buf[j++] = le16_to_cpu(sample);
> >> >> >     }
> >> >>
> >> >> This conversion is usually skipped on purpose and delayed until it is
> >> >> actually needed by the user. The IIO channel is accordingly marked that it
> >> >> will produce LE data.
> >> > Thanks Lars.  I knew that for buffers, overlooked it, now I'll know it
> >> > better!
> >> >
> >> > So, Sayli, you probably got this from the analysis of the last patch.
> >> > In buffered mode, we'll go ahead and return the data in it's 'native'
> >> > order.  So, my suggestion to convert it here, is wrong.  Ignore ;)
> >> >
> >> Oh I see! So should I resend the patch with an updated
> >> description?(cosmetic/bug fix)
> >
> > Yes.  In the commit message, you can leave out the subdirs (imu: bmc160:)
> > so that you have more space for a descriptive message of the change.
> 
> A quick question about this being a bug fix or not. This would have
> worked fine on little endian systems. But wouldn't the byte order have
> changed in case of a big endian buffer, when the little endian samples
> are stored in it?
> If not, then this will be a cosmetic patch.
> 
> thanks,
> sayli

Hi Sayli,
Pulling linux-iio back in.  Once we've started group thread, we need to
keep replying to 'all'.  It helps those invested in this particular
patch, and also helps those who search in the future with similar
issues.

To answer your question.  I say cosmetic, because the le16 is going
into a 16bit buf element, and is labelled as IIO_LE in the channel
buffer definition.  That's why Lars was saying we don't need to do
any conversion.  We'll pass the bits as they came in, and tell the
readers of the buf that they are in little endian format.  (And, also
note we weren't truncating any as was the case in your first endian fix.)

OK - having said that, I stare at this code more, and wonder why
we are even bothering to label the sample as __le16, and whether
we should just label it as s16.  Also, I'm wondering about the use
of sizeof().  Shouldn't we be saying sizeof(sample) not sizeof(__le16)?
It's not a checkpatch error, but I feel like I've seen coccichecks
or coccinelle script patches repairing these misuses of sizeof

See what you think, group reply with questions, and we'll get to the
bottom of this one soon!  

Thanks,
alisons

