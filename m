Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750775AbdFCIxB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Jun 2017 04:53:01 -0400
Date: Sat, 3 Jun 2017 09:52:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Paolo Cretaro <paolocretaro@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: meson-saradc: use NULL instead of 0 for
 pointer
Message-ID: <20170603095257.2a4042bf@kernel.org>
In-Reply-To: <CAFBinCC9OQ1P-0K5DZyiFrod97xEuhk__bCSbmvPciXB3KnBBg@mail.gmail.com>
References: <20170528112438.10427-1-paolocretaro@gmail.com>
        <20170528154309.243555e3@kernel.org>
        <CAFBinCC9OQ1P-0K5DZyiFrod97xEuhk__bCSbmvPciXB3KnBBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 28 May 2017 23:17:57 +0200
Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> Hi Paolo, Hi Jonathan,
> 
> On Sun, May 28, 2017 at 4:43 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> > On Sun, 28 May 2017 13:24:38 +0200
> > Paolo Cretaro <paolocretaro@gmail.com> wrote:
> >  
> >> Fix sparse warning: Using plain integer as NULL pointer
> >>
> >> Signed-off-by: Paolo Cretaro <paolocretaro@gmail.com>  
> > This looks fine to me, but ideally you should always try to include
> > the driver author - particularly in the case of patches to a recent
> > driver such as this one.
> >
> > To that end I've cc'd Martin.  
> thanks for spotting this (and providing a patch to fix it)
> this looks good to me, so:
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> if you can wait until next weekend then I can also test this on real hardware.
I've applied it to the togreg branch of iio.git but as that always goes out
as testing for at least a few days first (which I will happily rebase) give
me a shout if anything goes wrong!

Jonathan
> 
> > Jonathan  
> >> ---
> >>  drivers/iio/adc/meson_saradc.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> >> index 81cd39a57fe3..fb3f67a9ae1f 100644
> >> --- a/drivers/iio/adc/meson_saradc.c
> >> +++ b/drivers/iio/adc/meson_saradc.c
> >> @@ -481,7 +481,7 @@ static void meson_sar_adc_clear_fifo(struct iio_dev *indio_dev)
> >>               if (!meson_sar_adc_get_fifo_count(indio_dev))
> >>                       break;
> >>
> >> -             regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, 0);
> >> +             regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, NULL);
> >>       }
> >>  }
> >>  
> >  
> 
> Regards,
> Martin

