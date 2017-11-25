Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751686AbdKYOVR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Nov 2017 09:21:17 -0500
Date: Sat, 25 Nov 2017 14:15:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 08/13] iio: health: max30102: Add power enable
 parameter to get_temp function
Message-ID: <20171125141511.257959d2@archlinux>
In-Reply-To: <CAJCx=gmxYpmdTmDgBsAfCHbDghfvRhvjtPPfXz51svK3jC=jfA@mail.gmail.com>
References: <1509133543-4597-1-git-send-email-pmeerw@pmeerw.net>
        <1509133543-4597-9-git-send-email-pmeerw@pmeerw.net>
        <CAJCx=gmxYpmdTmDgBsAfCHbDghfvRhvjtPPfXz51svK3jC=jfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 19 Nov 2017 12:41:37 -0800
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> On Fri, Oct 27, 2017 at 12:45 PM, Peter Meerwald-Stadler
> <pmeerw@pmeerw.net> wrote:
> > Chip must not be in shutdown for reading temperature, so briefly leave
> > shutdown if buffer is not already running
> >  
> 
> Looks good to me. I assume there is no setup delay required for power on though?
I assuming not but if there is then a follow up patch now...
> 
> 
> Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

Applied to togreg branch of iio.git.  A bit of fuzz given the other
temperature related patch that went via the fixes tree.

Jonathan


> 
> 
> > Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> > Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> > ---
> >  drivers/iio/health/max30102.c | 36 +++++++++++++++++++++++-------------
> >  1 file changed, 23 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
> > index 968b54b..520d905 100644
> > --- a/drivers/iio/health/max30102.c
> > +++ b/drivers/iio/health/max30102.c
> > @@ -321,20 +321,31 @@ static int max30102_read_temp(struct max30102_data *data, int *val)
> >         return 0;
> >  }
> >
> > -static int max30102_get_temp(struct max30102_data *data, int *val)
> > +static int max30102_get_temp(struct max30102_data *data, int *val, bool en)
> >  {
> >         int ret;
> >
> > +       if (en) {
> > +               ret = max30102_set_powermode(data, true);
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +
> >         /* start acquisition */
> >         ret = regmap_update_bits(data->regmap, MAX30102_REG_TEMP_CONFIG,
> >                                  MAX30102_REG_TEMP_CONFIG_TEMP_EN,
> >                                  MAX30102_REG_TEMP_CONFIG_TEMP_EN);
> >         if (ret)
> > -               return ret;
> > +               goto out;
> >
> >         msleep(35);
> > +       ret = max30102_read_temp(data, val);
> > +
> > +out:
> > +       if (en)
> > +               max30102_set_powermode(data, false);
> >
> > -       return max30102_read_temp(data, val);
> > +       return ret;
> >  }
> >
> >  static int max30102_read_raw(struct iio_dev *indio_dev,
> > @@ -347,20 +358,19 @@ static int max30102_read_raw(struct iio_dev *indio_dev,
> >         switch (mask) {
> >         case IIO_CHAN_INFO_RAW:
> >                 /*
> > -                * Temperature reading can only be acquired while engine
> > -                * is running
> > +                * Temperature reading can only be acquired when not in
> > +                * shutdown; leave shutdown briefly when buffer not running
> >                  */
> >                 mutex_lock(&indio_dev->mlock);
> > -
> >                 if (!iio_buffer_enabled(indio_dev))
> > -                       ret = -EBUSY;
> > -               else {
> > -                       ret = max30102_get_temp(data, val);
> > -                       if (!ret)
> > -                               ret = IIO_VAL_INT;
> > -               }
> > -
> > +                       ret = max30102_get_temp(data, val, true);
> > +               else
> > +                       ret = max30102_get_temp(data, val, false);
> >                 mutex_unlock(&indio_dev->mlock);
> > +               if (ret)
> > +                       return ret;
> > +
> > +               ret = IIO_VAL_INT;
> >                 break;
> >         case IIO_CHAN_INFO_SCALE:
> >                 *val = 1000;  /* 62.5 */
> > --
> > 2.7.4
> >  

