Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35253 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933605AbdCUSML (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Mar 2017 14:12:11 -0400
Received: by mail-pg0-f66.google.com with SMTP id g2so26540675pge.2
        for <linux-iio@vger.kernel.org>; Tue, 21 Mar 2017 11:12:10 -0700 (PDT)
Date: Tue, 21 Mar 2017 11:12:08 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: Gargi Sharma <gs051095@gmail.com>
Cc: outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [Outreachy kernel] [PATCH] staging: ade7754: Replace mlock with
 buf_lock and refactor code
Message-ID: <20170321181207.GA10699@d830.WORKGROUP>
References: <1489995561-6988-1-git-send-email-gs051095@gmail.com>
 <20170321172438.GC2793@d830.WORKGROUP>
 <CAOCi2DFEbuKpTFhcYiabJjkY3rAWF4LjnG1DWqLPejQLvK1heg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOCi2DFEbuKpTFhcYiabJjkY3rAWF4LjnG1DWqLPejQLvK1heg@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Mar 21, 2017 at 11:18:23PM +0530, Gargi Sharma wrote:
> On Tue, Mar 21, 2017 at 10:54 PM, Alison Schofield <amsfield22@gmail.com> wrote:
> > On Mon, Mar 20, 2017 at 01:09:21PM +0530, Gargi Sharma wrote:
> >> The IIO subsystem is redefining iio_dev->mlock to be used by
> >> the IIO core only for protecting device operating mode changes.
> >> ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.
> >>
> >> In this driver, mlock was being used to protect hardware state
> >> changes. Replace it with buf_lock in the devices global data.
> >>
> >> As buf_lock already protects operations in ade7754_write_frequency,
> >> there isn't a need to acquire the lock inside ade7754_spi_write_reg_8
> >> when writing to the register.
> >
> > Hi Gargi,
> >
> > Looks like something went wrong in your patch below.  It doesn't do what
> > you say it'll do...Instead of removing the lock from _write_reg_8()
> > it inserts a bunch of code.  Anyway, it seems that w_rite_reg_8() is used
> > in multiple places, so removing that lock doesn't appear to be an
> > option.
> >
> > See below...
> >
> > alisons
> >
> >>
> >> Signed-off-by: Gargi Sharma <gs051095@gmail.com>
> >> ---
> >>  drivers/staging/iio/meter/ade7754.c | 13 +++++++++++--
> >>  1 file changed, 11 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
> >> index 024463a..eb03469 100644
> >> --- a/drivers/staging/iio/meter/ade7754.c
> >> +++ b/drivers/staging/iio/meter/ade7754.c
> >> @@ -29,6 +29,15 @@ static int ade7754_spi_write_reg_8(struct device *dev, u8 reg_address, u8 val)
> >>       struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> >>       struct ade7754_state *st = iio_priv(indio_dev);
> >>
> >> +     if (reg_address == ADE7754_WAVMODE) {
> >> +             st->tx[0] = ADE7754_WRITE_REG(reg_address);
> >> +             st->tx[1] = val;
> >> +
> >> +             ret = spi_write(st->us, st->tx, 2);
> >> +
> >> +             return ret;
> >> +     }
> >> +
> > What's this?
> 
> When the function ade_spi_write_reg_8() is called inside
> ade7754_write_frequency(), we are writing to this( ADE7754_WAVMODE)
> register. When writing to this register we don't need to hold the
> buf_lock since ade7754_write_frequency() already takes care of that.

Oh! I see it now. You created a special 'no lock needed' case
inside of --write_reg_8 for  writing frequency.   That works, 
but it's...ummm...sneaky ;)  Let's see if there's another way.  

Look back at Lars suggestion on a similar patch.  Maybe that
will apply here.
http://marc.info/?l=linux-kernel&m=148940648615743&w=2

alisons


> 
> >
> >>       mutex_lock(&st->buf_lock);
> >>       st->tx[0] = ADE7754_WRITE_REG(reg_address);
> >>       st->tx[1] = val;
> >> @@ -430,7 +439,7 @@ static ssize_t ade7754_write_frequency(struct device *dev,
> >>       if (!val)
> >>               return -EINVAL;
> >>
> >> -     mutex_lock(&indio_dev->mlock);
> >> +     mutex_lock(&st->buf_lock);
> >>
> >>       t = 26000 / val;
> >>       if (t > 0)
> >> @@ -451,7 +460,7 @@ static ssize_t ade7754_write_frequency(struct device *dev,
> >>       ret = ade7754_spi_write_reg_8(dev, ADE7754_WAVMODE, reg);
> >>
> >>  out:
> >> -     mutex_unlock(&indio_dev->mlock);
> >> +     mutex_unlock(&st->buf_lock);
> >>
> >>       return ret ? ret : len;
> >>  }
> 
> The buf_lock inside ade7754_write_frequency() takes into account that
> when using the function ade7754_spi_write_reg_8, lock is already held
> and locking is no longer required inside the ade7754_spi_write_reg_8()
> function.
> 
> Let me know if this sounds okay, I can perhaps edit the commit log to
> make this clearer.
> 
> Thanks,
> Gargi
> 
> >> --
> >> 2.7.4
> >>
> >> --
> >> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> >> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> >> To post to this group, send email to outreachy-kernel@googlegroups.com.
> >> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/1489995561-6988-1-git-send-email-gs051095%40gmail.com.
> >> For more options, visit https://groups.google.com/d/optout.
> >
> > --
> > You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> > To post to this group, send email to outreachy-kernel@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20170321172438.GC2793%40d830.WORKGROUP.
> > For more options, visit https://groups.google.com/d/optout.
