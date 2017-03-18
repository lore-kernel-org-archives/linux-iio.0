Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:35793 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751853AbdCRSJ0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Mar 2017 14:09:26 -0400
Received: by mail-it0-f67.google.com with SMTP id y18so9850924itc.2
        for <linux-iio@vger.kernel.org>; Sat, 18 Mar 2017 11:09:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170317171136.GA19487@d830.WORKGROUP>
References: <20170317151110.GA26848@sayli-HP-15-Notebook-PC> <20170317171136.GA19487@d830.WORKGROUP>
From: Gargi Sharma <gs051095@gmail.com>
Date: Sat, 18 Mar 2017 23:08:51 +0530
Message-ID: <CAOCi2DEtSEHxRD9ZW7exOEP9bkQoj7yqCE3z+HT3E2noX7iBrA@mail.gmail.com>
Subject: Re: [Outreachy kernel] [PATCH] staging: iio: meter: ade7758_core:
 Replace mlock with driver's private lock
To: Alison Schofield <amsfield22@gmail.com>
Cc: sayli karnik <karniksayli1995@gmail.com>,
        outreachy-kernel@googlegroups.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Mar 17, 2017 at 10:41 PM, Alison Schofield <amsfield22@gmail.com> wrote:
>
> On Fri, Mar 17, 2017 at 08:41:11PM +0530, sayli karnik wrote:
> > iio_dev->mlock should be used by the IIO core only for protecting
> > device operating mode changes. ie. Changes between INDIO_DIRECT_MODE,
> > INDIO_BUFFER_* modes.
> > Replace mlock with a lock in the device's global data to protect
> > hardware state changes.
>
> Hi Sayli,
>
> There are nested locks here, hence deadlock.  I'm wondering if we can grab
> the lock once at the top layers (read/write_raw functions) and hold it.
> Seems like that's a pattern in IIO drivers.  Let's see what the reviewers
> suggest on this one.
>

Hey Alison,

I was trying to work through a similar patch. I'm having trouble
understanding how a deadlock will be created? Also, Lars suggested in
this{https://groups.google.com/forum/#!msg/outreachy-kernel/GapBLSp5WCo/cju_A8B-AwAJ}
thread that writing a variant of
<driver_name>_spi_{read,write}_reg_16() that does not take a lock and
instead uses read-modify-write cycle in a protected section is the way
to go. Is there any example I can look to for inspiration :). Also, in
similar vain there are other(8 bit) variants for read/write functions
as well. Should they be modified as well?

Thanks!
Gargi

> alisons
>
> >
> > Signed-off-by: sayli karnik <karniksayli1995@gmail.com>
> > ---
> >  drivers/staging/iio/meter/ade7758_core.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
> > index 99c89e6..1723eb8 100644
> > --- a/drivers/staging/iio/meter/ade7758_core.c
> > +++ b/drivers/staging/iio/meter/ade7758_core.c
> > @@ -522,13 +522,14 @@ static int ade7758_read_raw(struct iio_dev *indio_dev,
> >                           int *val2,
> >                           long mask)
> >  {
> > +     struct ade7758_state *st = iio_priv(indio_dev);
> >       int ret;
> >
> >       switch (mask) {
> >       case IIO_CHAN_INFO_SAMP_FREQ:
> > -             mutex_lock(&indio_dev->mlock);
> > +             mutex_lock(&st->buf_lock);
> >               ret = ade7758_read_samp_freq(&indio_dev->dev, val);
> > -             mutex_unlock(&indio_dev->mlock);
> > +             mutex_unlock(&st->buf_lock);
> >               return ret;
> >       default:
> >               return -EINVAL;
> > @@ -541,15 +542,16 @@ static int ade7758_write_raw(struct iio_dev *indio_dev,
> >                            struct iio_chan_spec const *chan,
> >                            int val, int val2, long mask)
> >  {
> > +     struct ade7758_state *st = iio_priv(indio_dev);
> >       int ret;
> >
> >       switch (mask) {
> >       case IIO_CHAN_INFO_SAMP_FREQ:
> >               if (val2)
> >                       return -EINVAL;
> > -             mutex_lock(&indio_dev->mlock);
> > +             mutex_lock(&st->buf_lock);
> >               ret = ade7758_write_samp_freq(&indio_dev->dev, val);
> > -             mutex_unlock(&indio_dev->mlock);
> > +             mutex_unlock(&st->buf_lock);
> >               return ret;
> >       default:
> >               return -EINVAL;
> > --
> > 2.7.4
> >
> > --
> > You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> > To post to this group, send email to outreachy-kernel@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20170317151110.GA26848%40sayli-HP-15-Notebook-PC.
> > For more options, visit https://groups.google.com/d/optout.
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20170317171136.GA19487%40d830.WORKGROUP.
> For more options, visit https://groups.google.com/d/optout.
