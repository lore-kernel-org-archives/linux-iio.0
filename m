Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:33475 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753726AbdHURiH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Aug 2017 13:38:07 -0400
Date: Mon, 21 Aug 2017 19:29:20 +0200
From: jmondi <jacopo@jmondi.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Abhisit Sangjan <s.abhisit@gmail.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, knaack.h@gmx.de,
        lars@metafoo.de, fabrice.gasnier@st.com,
        Lee Jones <lee.jones@linaro.org>, robh@kernel.org,
        Akinobu Mita <akinobu.mita@gmail.com>,
        marek.vasut+renesas@gmail.com, jacopo+renesas@jmondi.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/5] iio: Add support for LMP92001 ADC
Message-ID: <20170821172920.GB6340@w540>
References: <1501578742-4501-1-git-send-email-s.abhisit@gmail.com>
 <alpine.DEB.2.20.1708011317000.5987@vps.pmeerw.net>
 <20170811143847.GA19152@localhost>
 <CAMV_pUa0XvzNYcR0ryHSt=qsdLKCtOLfQNz3LsWxaj9VGmFxLw@mail.gmail.com>
 <20170818025835.GE19152@localhost>
 <CAMV_pUYqGnDQmn+j9y85e9y8f7nuewAHTnDxm-goJ+mW-kMhUg@mail.gmail.com>
 <CAMV_pUaM5MAYL_R+0_9uW52fmp+c5XjBNyWeMFZqCx3MUWD59g@mail.gmail.com>
 <20170820113141.1a26db6b@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170820113141.1a26db6b@archlinux>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Abhisit,

On Sun, Aug 20, 2017 at 11:31:41AM +0100, Jonathan Cameron wrote:
> On Fri, 18 Aug 2017 14:42:59 +0700
> Abhisit Sangjan <s.abhisit@gmail.com> wrote:
>
> > Hi Jmondi,
> >
> > After I removed those cases, I got warnings "no handled in switch".
> >
> > On Fri, Aug 18, 2017 at 10:15 AM, Abhisit Sangjan <s.abhisit@gmail.com>
> > wrote:
> >
> > > Hi Jmondi,
> > >
> > > On Fri, Aug 18, 2017 at 9:58 AM, jmondi <jacopo@jmondi.org> wrote:
> > >
> > >> Hi Abhisit,
> > >>
> > >> On Fri, Aug 18, 2017 at 09:34:16AM +0700, Abhisit Sangjan wrote:
> > >> > Hi Jmondi,
> > >> >
> > >> > Thank you for your recommend, I am testing the code will be send the new
> > >> > patch in soon.
> > >>
> > >> [snip]
> > >>
> > >> > > > > +
> > >> > > > > +        switch (mask)
> > >> > > > > +        {
> > >> > > > > +        case IIO_CHAN_INFO_RAW:
> > >> > > > > +                switch (channel->type) {
> > >> > > > > +                case IIO_VOLTAGE:
> > >> > > > > +                case IIO_TEMP:
> > >> > > > > +                        *val = code;
> > >> > > > > +                        return IIO_VAL_INT;
> > >> > > > > +                default:
> > >> > > > > +                        break;
> > >> > > > > +                }
> > >> > > > > +                break;
> > >> > > > > +        default:
> > >> > > > > +                break;
> > >> > >
> > >> > > You can remove these default cases or return -EINVAL here.
> > >> > >
> > >> >
> > >> > Abhisit: Okay, I will remove it.
> > >> >              Could you tell me in detail. Sorry, I do not understand the
> > >> > Technical.
> > >>
> > >> This can potentially be reduced to
> > >>
> > >>         switch (mask) {
> > >>         case IIO_CHAN_INFO_RAW:
> > >>                 switch (channel->type) {
> > >>                 case IIO_VOLTAGE:
> > >>                 case IIO_TEMP:
> > >>                         *val = code;
> > >>                         return IIO_VAL_INT;
> > >>                 }
>             default:
> 	         return -EINVAL;
> > >>          }
> > >>
> get rid of the below.
> > >>          return -EINVAL;
>
> Sorry, had forgotten about that warning!

My bad, as I have suggested but not compiled that code.
Thanks Jonathan!

>
> Jonathan
>
> > >>
> > >>
> > >> But that's definitely not a big deal, there are no optimization in
> > >> this code change, just less typing and less default: and break; here
> > >> and there
> > >>
> > >
> > > Abhisit: Thank you so much.
> > >
> >
> > Abhisit: If I remove those default cases, I got the warning. How do I would
> > do next to fix warning?  Should I leave this code as it?
> >
> > # What have I changed.
> > diff --git a/drivers/iio/adc/lmp92001-adc.c b/drivers/iio/adc/lmp92001-adc.c
> > index 68f7a6c..ebc6423 100644
> > --- a/drivers/iio/adc/lmp92001-adc.c
> > +++ b/drivers/iio/adc/lmp92001-adc.c
> > @@ -92,12 +92,7 @@ static int lmp92001_read_raw(struct iio_dev *indio_dev,
> >                 case IIO_TEMP:
> >                         *val = code;
> >                         return IIO_VAL_INT;
> > -               default:
> > -                       break;
> >                 }
> > -               break;
> > -       default:
> > -               break;
> >         }
> >
> >         return -EINVAL;
> >
> > # Compilation.
> >   CC      drivers/iio/adc/lmp92001-adc.o
> > drivers/iio/adc/lmp92001-adc.c: In function ‘lmp92001_read_raw’:
> > drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value
> > ‘IIO_CURRENT’ not handled in switch [-Wswitch]
> >    switch (channel->type) {
> >    ^
> > drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value ‘IIO_POWER’
> > not handled in switch [-Wswitch]
> > drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value ‘IIO_ACCEL’
> > not handled in switch [-Wswitch]
> > drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value
> > ‘IIO_ANGL_VEL’ not handled in switch [-Wswitch]
> > drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value ‘IIO_MAGN’
> > not handled in switch [-Wswitch]
> > drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value ‘IIO_LIGHT’
> > not handled in switch [-Wswitch]
> > drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value
> > ‘IIO_INTENSITY’ not handled in switch [-Wswitch]
> > drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value
> > ‘IIO_PROXIMITY’ not handled in switch [-Wswitch]
> > drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value ‘IIO_INCLI’
> > not handled in switch [-Wswitch]
> > drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value ‘IIO_ROT’
> > not handled in switch [-Wswitch]
> > drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value ‘IIO_ANGL’
> > not handled in switch [-Wswitch]
> > drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value
> > ‘IIO_TIMESTAMP’ not handled in switch [-Wswitch]
> > drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value
> > ‘IIO_CAPACITANCE’ not handled in switch [-Wswitch]
> > drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value
> > ‘IIO_ALTVOLTAGE’ not handled in switch [-Wswitch]
> > drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value ‘IIO_CCT’
> > not handled in switch [-Wswitch]
> > drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value
> > ‘IIO_PRESSURE’ not handled in switch [-Wswitch]
> > drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value
> > ‘IIO_HUMIDITYRELATIVE’ not handled in switch [-Wswitch]
> > drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value
> > ‘IIO_ACTIVITY’ not handled in switch [-Wswitch]
> > drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value ‘IIO_STEPS’
> > not handled in switch [-Wswitch]
> > drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value
> > ‘IIO_ENERGY’ not handled in switch [-Wswitch]
> > drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value
> > ‘IIO_DISTANCE’ not handled in switch [-Wswitch]
> > drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value
> > ‘IIO_VELOCITY’ not handled in switch [-Wswitch]
> > drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value
> > ‘IIO_CONCENTRATION’ not handled in switch [-Wswitch]
> > drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value
> > ‘IIO_RESISTANCE’ not handled in switch [-Wswitch]
> > drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value ‘IIO_PH’
> > not handled in switch [-Wswitch]
> > drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value
> > ‘IIO_UVINDEX’ not handled in switch [-Wswitch]
> > drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value
> > ‘IIO_ELECTRICALCONDUCTIVITY’ not handled in switch [-Wswitch]
> > drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value ‘IIO_COUNT’
> > not handled in switch [-Wswitch]
> > drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value ‘IIO_INDEX’
> > not handled in switch [-Wswitch]
> > drivers/iio/adc/lmp92001-adc.c:90:3: warning: enumeration value
> > ‘IIO_GRAVITY’ not handled in switch [-Wswitch]
> >
> >
> > >
> > >
> > >
>
