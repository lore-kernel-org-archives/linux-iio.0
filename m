Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:63102 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbbADLji (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 4 Jan 2015 06:39:38 -0500
Date: Sun, 4 Jan 2015 12:39:23 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
Reply-To: Stefan Wahren <stefan.wahren@i2se.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: pmeerw@pmeerw.net, robert.hodaszi@digi.com, knaack.h@gmx.de,
	lars@metafoo.de, alexandre.belloni@free-electrons.com,
	fabio.estevam@freescale.com, linux-iio@vger.kernel.org,
	marex@denx.de
Message-ID: <1818754820.704464.1420371563334.JavaMail.open-xchange@oxbaltgw01.schlund.de>
In-Reply-To: <54A91E2C.7070109@kernel.org>
References: <1420317252-19761-1-git-send-email-stefan.wahren@i2se.com> <54A91E2C.7070109@kernel.org>
Subject: Re: [PATCH V2] iio: mxs-lradc: fix iio channel map regression
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

> Jonathan Cameron <jic23@kernel.org> hat am 4. Januar 2015 um 12:04
> geschrieben:
>
>
> On 03/01/15 20:34, Stefan Wahren wrote:
> > Since commit c8231a9af8147f8a ("iio: mxs-lradc: compute temperature
> > from channel 8 and 9") with the removal of adc channel 9 there is
> > no 1-1 mapping in the channel spec.
> >
> > All hwmon channel values above 9 are accessible via there index minus
> > one. So add a hidden iio channel 9 to fix this issue.
> >
> > Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> I'll have to hold this for a bit. I'm running rather behind with
> pull requests so my fixes tree is still pre the last release and
> hence doesn't have the patch that caused the problem yet...
>
> Should unwind that this week.

i forgot to mention this patch in version 2 is the solution of this old
discussion:

https://lkml.org/lkml/2014/6/14/69

So the problem should be in your fixes tree. Sorry for the confusion.

Stefan

>
> Jonathan
> > ---
> > Changes in V2:
> > - define hidden channel instead of a bogus one
> >
> > drivers/staging/iio/adc/mxs-lradc.c | 7 +++++++
> > 1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/staging/iio/adc/mxs-lradc.c
> > b/drivers/staging/iio/adc/mxs-lradc.c
> > index d9d6fad..594684d 100644
> > --- a/drivers/staging/iio/adc/mxs-lradc.c
> > +++ b/drivers/staging/iio/adc/mxs-lradc.c
> > @@ -1413,6 +1413,13 @@ static const struct iio_chan_spec
> > mxs_lradc_chan_spec[] = {
> > .channel = 8,
> > .scan_type = {.sign = 'u', .realbits = 18, .storagebits = 32,},
> > },
> > + /* Hidden channel to keep indexes */
> > + {
> > + .type = IIO_TEMP,
> > + .indexed = 1,
> > + .scan_index = -1,
> > + .channel = 9,
> > + },
> > MXS_ADC_CHAN(10, IIO_VOLTAGE), /* VDDIO */
> > MXS_ADC_CHAN(11, IIO_VOLTAGE), /* VTH */
> > MXS_ADC_CHAN(12, IIO_VOLTAGE), /* VDDA */
> > --
> > 1.7.9.5
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at http://vger.kernel.org/majordomo-info.html
> >
>
