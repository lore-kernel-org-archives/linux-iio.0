Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751681AbdKYOVP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Nov 2017 09:21:15 -0500
Date: Sat, 25 Nov 2017 14:12:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 07/13] iio: health: max30102: Introduce intensity
 channel macro
Message-ID: <20171125141202.7b1f5de7@archlinux>
In-Reply-To: <CAJCx=gn9g1QajnfD1iA5FoCXM8z7hao096bJ5Ca_1Y6CuMnstA@mail.gmail.com>
References: <1509133543-4597-1-git-send-email-pmeerw@pmeerw.net>
        <1509133543-4597-8-git-send-email-pmeerw@pmeerw.net>
        <CAJCx=gn9g1QajnfD1iA5FoCXM8z7hao096bJ5Ca_1Y6CuMnstA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 19 Nov 2017 12:37:00 -0800
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> On Fri, Oct 27, 2017 at 12:45 PM, Peter Meerwald-Stadler
> <pmeerw@pmeerw.net> wrote:
> > Signed-off-by: Peter Meerwald-Stalder <pmeerw@pmeerw.net>
> > Cc: Matt Ranostay <matt.ranostay@konsulko.com>  
> 
> Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>
Applied.
> 
> > ---
> >  drivers/iio/health/max30102.c | 44 ++++++++++++++++---------------------------
> >  1 file changed, 16 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
> > index c43957e..968b54b 100644
> > --- a/drivers/iio/health/max30102.c
> > +++ b/drivers/iio/health/max30102.c
> > @@ -106,35 +106,23 @@ static const struct regmap_config max30102_regmap_config = {
> >
> >  static const unsigned long max30102_scan_masks[] = {0x3, 0};
> >
> > +#define MAX30102_INTENSITY_CHANNEL(_si, _mod) { \
> > +               .type = IIO_INTENSITY, \
> > +               .channel2 = _mod, \
> > +               .modified = 1, \
> > +               .scan_index = _si, \
> > +               .scan_type = { \
> > +                       .sign = 'u', \
> > +                       .shift = 8, \
> > +                       .realbits = 18, \
> > +                       .storagebits = 32, \
> > +                       .endianness = IIO_BE, \
> > +               }, \
> > +       }
> > +
> >  static const struct iio_chan_spec max30102_channels[] = {
> > -       {
> > -               .type = IIO_INTENSITY,
> > -               .channel2 = IIO_MOD_LIGHT_RED,
> > -               .modified = 1,
> > -
> > -               .scan_index = 0,
> > -               .scan_type = {
> > -                       .sign = 'u',
> > -                       .shift = 8,
> > -                       .realbits = 18,
> > -                       .storagebits = 32,
> > -                       .endianness = IIO_BE,
> > -               },
> > -       },
> > -       {
> > -               .type = IIO_INTENSITY,
> > -               .channel2 = IIO_MOD_LIGHT_IR,
> > -               .modified = 1,
> > -
> > -               .scan_index = 1,
> > -               .scan_type = {
> > -                       .sign = 'u',
> > -                       .shift = 8,
> > -                       .realbits = 18,
> > -                       .storagebits = 32,
> > -                       .endianness = IIO_BE,
> > -               },
> > -       },
> > +       MAX30102_INTENSITY_CHANNEL(0, IIO_MOD_LIGHT_RED),
> > +       MAX30102_INTENSITY_CHANNEL(1, IIO_MOD_LIGHT_IR),
> >         {
> >                 .type = IIO_TEMP,
> >                 .info_mask_separate =
> > --
> > 2.7.4
> >  

