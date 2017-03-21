Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33766 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757455AbdCURrT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Mar 2017 13:47:19 -0400
Date: Tue, 21 Mar 2017 10:47:06 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: SIMRAN SINGHAL <singhalsimran0@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        outreachy-kernel <outreachy-kernel@googlegroups.com>
Subject: Re: [Outreachy kernel] [PATCH v6] staging: Use buf_lock instead of
 mlock and Refactor code
Message-ID: <20170321174706.GE2793@d830.WORKGROUP>
References: <20170319200621.GA21295@singhal-Inspiron-5558>
 <20170321164812.GA2793@d830.WORKGROUP>
 <CALrZqyPp30PNGRhVVnvv1FphTb7tK58+_sd=fCeSZ40LQaP9WA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CALrZqyPp30PNGRhVVnvv1FphTb7tK58+_sd=fCeSZ40LQaP9WA@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Mar 21, 2017 at 10:34:01PM +0530, SIMRAN SINGHAL wrote:
> On Tue, Mar 21, 2017 at 10:18 PM, Alison Schofield <amsfield22@gmail.com> wrote:
> > On Mon, Mar 20, 2017 at 01:36:21AM +0530, simran singhal wrote:
> >
> > Hi Simran,
> >
> > I going to ask for a v7 without looking at the code ;)
> > Subject line needs subsystem and driver.
> > Subject and log message can be improved.
> 
> Hi Alison,
> I have already sent v7 with changed subject.

Simran,
I see v7.  Needs subsystem (iio) and to nitpick, driver name
is "adis16060" ;) Other comments still apply. 
Please append all version histories below the --- for review.
v7:
v6:
.
.
v2: 
thanks,
alisons
> 
> >
> >> The IIO subsystem is redefining iio_dev->mlock to be used by
> >> the IIO core only for protecting device operating mode changes.
> >> ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.
> >>
> >> In this driver, mlock was being used to protect hardware state
> >> changes. Replace it with buf_lock in the devices global data.
> >            ^^^^^^^^^^^ this was not done
> >>
> >> As buf_lock protects both the adis16060_spi_write() and
> >> adis16060_spi_read() functions and both are always called in
> >> pair. First write, then read. Thus, refactor the code to have
> >> one single function adis16060_spi_write_than_read() which is
> >> protected by the existing buf_lock.
> > This was done.  So, you were able to obsolete the need for mlock
> > by creating the paired function.
> >
> >>
> >> Removed nested locks as the function adis16060_read_raw call
> >> a lock on &st->buf_lock and then calls the function
> >> adis16060_spi_write which again tries to get hold
> >> of the same lock.
> > ^^^^ this was not done.  Yes, you avoided nested locks through
> > proper coding, but we don't want to give the impression in the
> > log message that there was a pre-existing nested lock issue.
> >
> > I did checkpatch & compile it...but looked no further yet.
> >
> > alisons
> >>
> >> Signed-off-by: simran singhal <singhalsimran0@gmail.com>
> >> ---
> >>
> >>  v6:
> >>    -Change commit message
> >>    -Remove nested lock
> >>
> >>  drivers/staging/iio/gyro/adis16060_core.c | 40 ++++++++++---------------------
> >>  1 file changed, 13 insertions(+), 27 deletions(-)
> >>
> >> diff --git a/drivers/staging/iio/gyro/adis16060_core.c b/drivers/staging/iio/gyro/adis16060_core.c
> >> index c9d46e7..1c6de46 100644
> >> --- a/drivers/staging/iio/gyro/adis16060_core.c
> >> +++ b/drivers/staging/iio/gyro/adis16060_core.c
> >> @@ -40,25 +40,17 @@ struct adis16060_state {
> >>
> >>  static struct iio_dev *adis16060_iio_dev;
> >>
> >> -static int adis16060_spi_write(struct iio_dev *indio_dev, u8 val)
> >> +static int adis16060_spi_write_than_read(struct iio_dev *indio_dev,
> >> +                                      u8 conf, u16 *val)
> >>  {
> >>       int ret;
> >>       struct adis16060_state *st = iio_priv(indio_dev);
> >>
> >> -     mutex_lock(&st->buf_lock);
> >> -     st->buf[2] = val; /* The last 8 bits clocked in are latched */
> >> +     st->buf[2] = conf; /* The last 8 bits clocked in are latched */
> >>       ret = spi_write(st->us_w, st->buf, 3);
> >> -     mutex_unlock(&st->buf_lock);
> >> -
> >> -     return ret;
> >> -}
> >> -
> >> -static int adis16060_spi_read(struct iio_dev *indio_dev, u16 *val)
> >> -{
> >> -     int ret;
> >> -     struct adis16060_state *st = iio_priv(indio_dev);
> >>
> >> -     mutex_lock(&st->buf_lock);
> >> +     if (ret < 0)
> >> +             return ret;
> >>
> >>       ret = spi_read(st->us_r, st->buf, 3);
> >>
> >> @@ -69,8 +61,8 @@ static int adis16060_spi_read(struct iio_dev *indio_dev, u16 *val)
> >>        */
> >>       if (!ret)
> >>               *val = ((st->buf[0] & 0x3) << 12) |
> >> -                     (st->buf[1] << 4) |
> >> -                     ((st->buf[2] >> 4) & 0xF);
> >> +                      (st->buf[1] << 4) |
> >> +                      ((st->buf[2] >> 4) & 0xF);
> >>       mutex_unlock(&st->buf_lock);
> >>
> >>       return ret;
> >> @@ -83,20 +75,18 @@ static int adis16060_read_raw(struct iio_dev *indio_dev,
> >>  {
> >>       u16 tval = 0;
> >>       int ret;
> >> +     struct adis16060_state *st = iio_priv(indio_dev);
> >>
> >>       switch (mask) {
> >>       case IIO_CHAN_INFO_RAW:
> >>               /* Take the iio_dev status lock */
> >> -             mutex_lock(&indio_dev->mlock);
> >> -             ret = adis16060_spi_write(indio_dev, chan->address);
> >> +             mutex_lock(&st->buf_lock);
> >> +             ret = adis16060_spi_write_than_read(indio_dev,
> >> +                                                 chan->address, &tval);
> >> +             mutex_unlock(&st->buf_lock);
> >>               if (ret < 0)
> >> -                     goto out_unlock;
> >> +                     return ret;
> >>
> >> -             ret = adis16060_spi_read(indio_dev, &tval);
> >> -             if (ret < 0)
> >> -                     goto out_unlock;
> >> -
> >> -             mutex_unlock(&indio_dev->mlock);
> >>               *val = tval;
> >>               return IIO_VAL_INT;
> >>       case IIO_CHAN_INFO_OFFSET:
> >> @@ -110,10 +100,6 @@ static int adis16060_read_raw(struct iio_dev *indio_dev,
> >>       }
> >>
> >>       return -EINVAL;
> >> -
> >> -out_unlock:
> >> -     mutex_unlock(&indio_dev->mlock);
> >> -     return ret;
> >>  }
> >>
> >>  static const struct iio_info adis16060_info = {
> >> --
> >> 2.7.4
> >>
> >> --
> >> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> >> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> >> To post to this group, send email to outreachy-kernel@googlegroups.com.
> >> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20170319200621.GA21295%40singhal-Inspiron-5558.
> >> For more options, visit https://groups.google.com/d/optout.
