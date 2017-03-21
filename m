Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:35954 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757944AbdCUQ03 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Mar 2017 12:26:29 -0400
Received: by mail-it0-f65.google.com with SMTP id 190so2108719itm.3
        for <linux-iio@vger.kernel.org>; Tue, 21 Mar 2017 09:26:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170321161146.GB1859@d830.WORKGROUP>
References: <1490112069-30133-1-git-send-email-gs051095@gmail.com> <20170321161146.GB1859@d830.WORKGROUP>
From: Gargi Sharma <gs051095@gmail.com>
Date: Tue, 21 Mar 2017 21:47:35 +0530
Message-ID: <CAOCi2DGQ=gfUPLFRdShfXo7EDG=0dT4TrP7OtdySKj3j0x3h-Q@mail.gmail.com>
Subject: Re: [Outreachy kernel] [RESEND PATCH v3] staging: iio: ad7280:
 Replace mlock with driver private lock
To: Alison Schofield <amsfield22@gmail.com>
Cc: outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Mar 21, 2017 at 9:41 PM, Alison Schofield <amsfield22@gmail.com> wrote:
>
> On Tue, Mar 21, 2017 at 09:31:09PM +0530, Gargi Sharma wrote:
> > The IIO subsystem is redefining iio_dev->mlock to be used by
> > the IIO core only for protecting device operating mode changes.
> > ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.
> >
> > In this driver, mlock was being used to protect hardware state
> > changes.  Replace it with a lock in the devices global data.
> >
> > Acked-by: Jonathan Cameron <jic23@kernel.org>
> > Signed-off-by: Gargi Sharma <gs051095@gmail.com>
>
> Hi Gargi - What's up with the RESEND's?  I see this patch
> sent by you 03/17 and Jonathan replied 03/19 that he applied
> it.  I see it in the IIO tree.
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=testing
>
Hi Alison,

I misread Greg's mail that said that he was caught up with the patches.
I rebased my tree against Greg's staging-next and assumed that since I did
not receive the mail, I should probably resend.

Apologies for the inconvenience caused.

Gargi
> I see a couple of more RESENDs in my box.  Please check if they
> are necessary. Probably not.  RESENDs are typically used if your
> PATCH has been 'missed'...for a long time - like in weeks, not
> hours or even days.
>
> alisons
>
>
>
>
>
>
> > ---
> > Changes in v3:
> >       - Added mutex_init(&st->lock) inside probe function.
> >       - Added driver name in subject line.
> > Changes in v2:
> >         - Made the commit log clearer.
> > ---
> >  drivers/staging/iio/adc/ad7280a.c | 22 ++++++++++++----------
> >  1 file changed, 12 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> > index ee679ac..6a85e28 100644
> > --- a/drivers/staging/iio/adc/ad7280a.c
> > +++ b/drivers/staging/iio/adc/ad7280a.c
> > @@ -134,6 +134,7 @@ struct ad7280_state {
> >       unsigned char                   aux_threshhigh;
> >       unsigned char                   aux_threshlow;
> >       unsigned char                   cb_mask[AD7280A_MAX_CHAIN];
> > +     struct mutex                    lock; /* protect sensor state */
> >
> >       __be32                          buf[2] ____cacheline_aligned;
> >  };
> > @@ -410,7 +411,7 @@ static ssize_t ad7280_store_balance_sw(struct device *dev,
> >       devaddr = this_attr->address >> 8;
> >       ch = this_attr->address & 0xFF;
> >
> > -     mutex_lock(&indio_dev->mlock);
> > +     mutex_lock(&st->lock);
> >       if (readin)
> >               st->cb_mask[devaddr] |= 1 << (ch + 2);
> >       else
> > @@ -418,7 +419,7 @@ static ssize_t ad7280_store_balance_sw(struct device *dev,
> >
> >       ret = ad7280_write(st, devaddr, AD7280A_CELL_BALANCE,
> >                          0, st->cb_mask[devaddr]);
> > -     mutex_unlock(&indio_dev->mlock);
> > +     mutex_unlock(&st->lock);
> >
> >       return ret ? ret : len;
> >  }
> > @@ -433,10 +434,10 @@ static ssize_t ad7280_show_balance_timer(struct device *dev,
> >       int ret;
> >       unsigned int msecs;
> >
> > -     mutex_lock(&indio_dev->mlock);
> > +     mutex_lock(&st->lock);
> >       ret = ad7280_read(st, this_attr->address >> 8,
> >                         this_attr->address & 0xFF);
> > -     mutex_unlock(&indio_dev->mlock);
> > +     mutex_unlock(&st->lock);
> >
> >       if (ret < 0)
> >               return ret;
> > @@ -466,11 +467,11 @@ static ssize_t ad7280_store_balance_timer(struct device *dev,
> >       if (val > 31)
> >               return -EINVAL;
> >
> > -     mutex_lock(&indio_dev->mlock);
> > +     mutex_lock(&st->lock);
> >       ret = ad7280_write(st, this_attr->address >> 8,
> >                          this_attr->address & 0xFF,
> >                          0, (val & 0x1F) << 3);
> > -     mutex_unlock(&indio_dev->mlock);
> > +     mutex_unlock(&st->lock);
> >
> >       return ret ? ret : len;
> >  }
> > @@ -655,7 +656,7 @@ static ssize_t ad7280_write_channel_config(struct device *dev,
> >
> >       val = clamp(val, 0L, 0xFFL);
> >
> > -     mutex_lock(&indio_dev->mlock);
> > +     mutex_lock(&st->lock);
> >       switch ((u32)this_attr->address) {
> >       case AD7280A_CELL_OVERVOLTAGE:
> >               st->cell_threshhigh = val;
> > @@ -674,7 +675,7 @@ static ssize_t ad7280_write_channel_config(struct device *dev,
> >       ret = ad7280_write(st, AD7280A_DEVADDR_MASTER,
> >                          this_attr->address, 1, val);
> >
> > -     mutex_unlock(&indio_dev->mlock);
> > +     mutex_unlock(&st->lock);
> >
> >       return ret ? ret : len;
> >  }
> > @@ -792,13 +793,13 @@ static int ad7280_read_raw(struct iio_dev *indio_dev,
> >
> >       switch (m) {
> >       case IIO_CHAN_INFO_RAW:
> > -             mutex_lock(&indio_dev->mlock);
> > +             mutex_lock(&st->lock);
> >               if (chan->address == AD7280A_ALL_CELLS)
> >                       ret = ad7280_read_all_channels(st, st->scan_cnt, NULL);
> >               else
> >                       ret = ad7280_read_channel(st, chan->address >> 8,
> >                                                 chan->address & 0xFF);
> > -             mutex_unlock(&indio_dev->mlock);
> > +             mutex_unlock(&st->lock);
> >
> >               if (ret < 0)
> >                       return ret;
> > @@ -847,6 +848,7 @@ static int ad7280_probe(struct spi_device *spi)
> >       st = iio_priv(indio_dev);
> >       spi_set_drvdata(spi, indio_dev);
> >       st->spi = spi;
> > +     mutex_init(&st->lock);
> >
> >       if (!pdata)
> >               pdata = &ad7793_default_pdata;
> > --
> > 2.7.4
> >
> > --
> > You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> > To post to this group, send email to outreachy-kernel@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/1490112069-30133-1-git-send-email-gs051095%40gmail.com.
> > For more options, visit https://groups.google.com/d/optout.
