Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751706AbdKYOVS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Nov 2017 09:21:18 -0500
Date: Sat, 25 Nov 2017 14:16:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 09/13] iio: health: max30102: Introduce indices for
 LED channels
Message-ID: <20171125141624.0d524109@archlinux>
In-Reply-To: <CAJCx=gk94USWjRSqVHoV3_xvpRV-Oi0m5zxaqGB8hp9Dte8Ksw@mail.gmail.com>
References: <1509133543-4597-1-git-send-email-pmeerw@pmeerw.net>
        <1509133543-4597-10-git-send-email-pmeerw@pmeerw.net>
        <CAJCx=gk94USWjRSqVHoV3_xvpRV-Oi0m5zxaqGB8hp9Dte8Ksw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 19 Nov 2017 12:42:35 -0800
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> On Fri, Oct 27, 2017 at 12:45 PM, Peter Meerwald-Stadler
> <pmeerw@pmeerw.net> wrote:
> > Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> > Cc: Matt Ranostay <matt.ranostay@konsulko.com>  
> 
> Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>
Applied.  Thanks,
> 
> > ---
> >  drivers/iio/health/max30102.c | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
> > index 520d905..37176c2 100644
> > --- a/drivers/iio/health/max30102.c
> > +++ b/drivers/iio/health/max30102.c
> > @@ -34,6 +34,11 @@
> >  #define MAX30102_DRV_NAME      "max30102"
> >  #define MAX30102_PART_NUMBER   0x15
> >
> > +enum max3012_led_idx {
> > +       MAX30102_LED_RED,
> > +       MAX30102_LED_IR,
> > +};
> > +
> >  #define MAX30102_REG_INT_STATUS                        0x00
> >  #define MAX30102_REG_INT_STATUS_PWR_RDY                BIT(0)
> >  #define MAX30102_REG_INT_STATUS_PROX_INT       BIT(4)
> > @@ -104,7 +109,10 @@ static const struct regmap_config max30102_regmap_config = {
> >         .val_bits = 8,
> >  };
> >
> > -static const unsigned long max30102_scan_masks[] = {0x3, 0};
> > +static const unsigned long max30102_scan_masks[] = {
> > +       BIT(MAX30102_LED_RED) | BIT(MAX30102_LED_IR),
> > +       0
> > +};
> >
> >  #define MAX30102_INTENSITY_CHANNEL(_si, _mod) { \
> >                 .type = IIO_INTENSITY, \
> > @@ -121,8 +129,8 @@ static const unsigned long max30102_scan_masks[] = {0x3, 0};
> >         }
> >
> >  static const struct iio_chan_spec max30102_channels[] = {
> > -       MAX30102_INTENSITY_CHANNEL(0, IIO_MOD_LIGHT_RED),
> > -       MAX30102_INTENSITY_CHANNEL(1, IIO_MOD_LIGHT_IR),
> > +       MAX30102_INTENSITY_CHANNEL(MAX30102_LED_RED, IIO_MOD_LIGHT_RED),
> > +       MAX30102_INTENSITY_CHANNEL(MAX30102_LED_IR, IIO_MOD_LIGHT_IR),
> >         {
> >                 .type = IIO_TEMP,
> >                 .info_mask_separate =
> > --
> > 2.7.4
> >  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

