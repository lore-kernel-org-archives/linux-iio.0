Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:58492 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753796AbdHRC6s (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Aug 2017 22:58:48 -0400
Date: Fri, 18 Aug 2017 09:58:35 +0700
From: jmondi <jacopo@jmondi.org>
To: Abhisit Sangjan <s.abhisit@gmail.com>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, fabrice.gasnier@st.com,
        Lee Jones <lee.jones@linaro.org>, robh@kernel.org,
        Akinobu Mita <akinobu.mita@gmail.com>,
        marek.vasut+renesas@gmail.com, jacopo+renesas@jmondi.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/5] iio: Add support for LMP92001 ADC
Message-ID: <20170818025835.GE19152@localhost>
References: <1501578742-4501-1-git-send-email-s.abhisit@gmail.com>
 <alpine.DEB.2.20.1708011317000.5987@vps.pmeerw.net>
 <20170811143847.GA19152@localhost>
 <CAMV_pUa0XvzNYcR0ryHSt=qsdLKCtOLfQNz3LsWxaj9VGmFxLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAMV_pUa0XvzNYcR0ryHSt=qsdLKCtOLfQNz3LsWxaj9VGmFxLw@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Abhisit,

On Fri, Aug 18, 2017 at 09:34:16AM +0700, Abhisit Sangjan wrote:
> Hi Jmondi,
>
> Thank you for your recommend, I am testing the code will be send the new
> patch in soon.

[snip]

> > > > +
> > > > +        switch (mask)
> > > > +        {
> > > > +        case IIO_CHAN_INFO_RAW:
> > > > +                switch (channel->type) {
> > > > +                case IIO_VOLTAGE:
> > > > +                case IIO_TEMP:
> > > > +                        *val = code;
> > > > +                        return IIO_VAL_INT;
> > > > +                default:
> > > > +                        break;
> > > > +                }
> > > > +                break;
> > > > +        default:
> > > > +                break;
> >
> > You can remove these default cases or return -EINVAL here.
> >
>
> Abhisit: Okay, I will remove it.
>              Could you tell me in detail. Sorry, I do not understand the
> Technical.

This can potentially be reduced to

        switch (mask) {
        case IIO_CHAN_INFO_RAW:
                switch (channel->type) {
                case IIO_VOLTAGE:
                case IIO_TEMP:
                        *val = code;
                        return IIO_VAL_INT;
                }
         }

         return -EINVAL;


But that's definitely not a big deal, there are no optimization in
this code change, just less typing and less default: and break; here
and there

