Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751523AbdJHKed (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Oct 2017 06:34:33 -0400
Date: Sun, 8 Oct 2017 11:34:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Aastha Gupta <aastha.gupta4104@gmail.com>
Cc: outreachy-kernel@googlegroups.com, hennerich@blackfin.uclinux.org,
        knaack.h@gmx.de, lars@metafoo.de,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v4] staging: iio: adc: ad7192: use driver private lock
 to protect hardware state changes
Message-ID: <20171008113429.3a32e5b2@archlinux>
In-Reply-To: <CAHXiS58tq9FQV=e+wZxAXxkH=gENqgeAbVRAsWF15vT2ju4rcg@mail.gmail.com>
References: <1506493919-3189-1-git-send-email-aastha.gupta4104@gmail.com>
        <CAHXiS59kFwR4rdmAUvz=HeSXZqqH5CC0+NgfCCcin9aHUJ=0hg@mail.gmail.com>
        <20171007122910.581f51cf@archlinux>
        <CAHXiS58tq9FQV=e+wZxAXxkH=gENqgeAbVRAsWF15vT2ju4rcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 7 Oct 2017 17:05:00 +0530
Aastha Gupta <aastha.gupta4104@gmail.com> wrote:

> On Sat, Oct 7, 2017 at 4:59 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> > On Fri, 6 Oct 2017 22:58:42 +0530
> > Aastha Gupta <aastha.gupta4104@gmail.com> wrote:
> >  
> >> On Wed, Sep 27, 2017 at 12:01 PM, Aastha Gupta
> >> <aastha.gupta4104@gmail.com> wrote:  
> >> > The IIO subsystem is redefining iio_dev->mlock to be used by
> >> > the IIO core only for protecting device operating mode changes.
> >> > ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.
> >> >
> >> > In this driver, mlock was being used to protect hardware state
> >> > changes.  Replace it with a driver private lock.
> >> >
> >> > Also, as there are state changes in the ad7192_ write_raw function, a lock
> >> > is added to prevent the concurrent state changes.
> >> >
> >> > Signed-off-by: Aastha Gupta <aastha.gupta4104@gmail.com>
> >> > ---
> >> > changes in v4:
> >> >         - added comment for mutex
> >> >         - improved commit message
> >> >  drivers/staging/iio/adc/ad7192.c | 9 +++++++--
> >> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> >> > index d11c6de..c1343ec 100644
> >> > --- a/drivers/staging/iio/adc/ad7192.c
> >> > +++ b/drivers/staging/iio/adc/ad7192.c
> >> > @@ -162,6 +162,7 @@ struct ad7192_state {
> >> >         u32                             scale_avail[8][2];
> >> >         u8                              gpocon;
> >> >         u8                              devid;
> >> > +       struct mutex                    lock;   /* protect sensor state */
> >> >
> >> >         struct ad_sigma_delta           sd;
> >> >  };
> >> > @@ -463,10 +464,10 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
> >> >         case IIO_CHAN_INFO_SCALE:
> >> >                 switch (chan->type) {
> >> >                 case IIO_VOLTAGE:
> >> > -                       mutex_lock(&indio_dev->mlock);
> >> > +                       mutex_lock(&st->lock);
> >> >                         *val = st->scale_avail[AD7192_CONF_GAIN(st->conf)][0];
> >> >                         *val2 = st->scale_avail[AD7192_CONF_GAIN(st->conf)][1];
> >> > -                       mutex_unlock(&indio_dev->mlock);
> >> > +                       mutex_unlock(&st->lock);
> >> >                         return IIO_VAL_INT_PLUS_NANO;
> >> >                 case IIO_TEMP:
> >> >                         *val = 0;
> >> > @@ -510,6 +511,7 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
> >> >         switch (mask) {
> >> >         case IIO_CHAN_INFO_SCALE:
> >> >                 ret = -EINVAL;
> >> > +               mutex_lock(&st->lock);
> >> >                 for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++)
> >> >                         if (val2 == st->scale_avail[i][1]) {
> >> >                                 ret = 0;
> >> > @@ -523,6 +525,7 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
> >> >                                 ad7192_calibrate_all(st);
> >> >                                 break;
> >> >                         }
> >> > +               mutex_unlock(&st->lock);
> >> >                 break;
> >> >         case IIO_CHAN_INFO_SAMP_FREQ:
> >> >                 if (!val) {
> >> > @@ -634,6 +637,8 @@ static int ad7192_probe(struct spi_device *spi)
> >> >
> >> >         st = iio_priv(indio_dev);
> >> >
> >> > +       mutex_init(&st->lock);
> >> > +
> >> >         st->avdd = devm_regulator_get(&spi->dev, "avdd");
> >> >         if (IS_ERR(st->avdd))
> >> >                 return PTR_ERR(st->avdd);
> >> > --
> >> > 2.7.4
> >> >  
> >>
> >> Any update regarding this?  
> >
> > Patch is fine, but Julia had an outstanding question on the commit message.
> >
> > <snip>
> >  
> >> In this driver, mlock was being used to protect hardware state
> >> changes.  Replace it with a driver private lock.
> >>
> >> Also, as there are state changes in the ad7192_ write_raw function, a lock
> >> is added to prevent the concurrent state changes.  
> >
> > Why was it not needed before?
> >
> > julia
> >
> > <snip>
> >
> > Lazy maintainer strategy 15, don't reply to a patch once someone else has
> > raised an reasonably question that hasn't been answered ;)
> >
> > Jonathan
> >
> >  
> 
> This was discussed but due to some mistake not everyone was CC'd.
> I have attached discussion.

Ah - fair enough and discussion seems to have reached a satisfactory
conclusion.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> 
> '''
> > On 27 Sep 2017 12:37 pm, "Julia Lawall" <julia.lawall@lip6.fr> wrote:  
> > >
> > > On Wed, 27 Sep 2017, Aastha Gupta wrote:
> > >  
> > > >
> > > > On 27 Sep 2017 12:25 pm, "Julia Lawall" <julia.lawall@lip6.fr> wrote:  
> > > > >
> > > > >
> > > > >
> > > > > On Wed, 27 Sep 2017, Aastha Gupta wrote:
> > > > >  
> > > > > > The IIO subsystem is redefining iio_dev->mlock to be used by
> > > > > > the IIO core only for protecting device operating mode changes.
> > > > > > ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.
> > > > > >
> > > > > > In this driver, mlock was being used to protect hardware state
> > > > > > changes.  Replace it with a driver private lock.
> > > > > >
> > > > > > Also, as there are state changes in the ad7192_ write_raw function, a  
> > > > lock  
> > > > > > is added to prevent the concurrent state changes.  
> > > > >
> > > > > Why was it not needed before?
> > > > >
> > > > > julia
> > > > >  
> > > >
> > > > It was not there in the file but I think it should be included because these
> > > > state changes are read by ad7192_read_raw function. So to avoid reading of
> > > > invalid state, while writing also there should be a lock.  
> > >
> > > I thought someone told you to merge the patches because the second one was
> > > fixing a problem that the first one introduced.  Do you happen to still
> > > have that mail?
> > >
> > > julia  
> > Yes, But I think that was because in the second patch I was using the same lock that I introduced in the first patch, so he told me to combine those two.  
> 
> OK
> 
> '''
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

