Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:32810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727510AbeKKWxF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Nov 2018 17:53:05 -0500
Date: Sun, 11 Nov 2018 13:04:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Giuliano Augusto Faulin Belinassi <giuliano.belinassi@usp.br>
Cc: alexandru.Ardelean@analog.com, lars@metafoo.de, knaack.h@gmx.de,
        Michael.Hennerich@analog.com, Renato Geh <renatogeh@gmail.com>,
        giuliano.belinassi@gmail.com,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        Kernel USP <kernel-usp@googlegroups.com>
Subject: Re: [PATCH v2 2/2] staging: iio: ad7780: generates pattern_mask
 from PAT bits
Message-ID: <20181111130427.655297f2@archlinux>
In-Reply-To: <CAEFO=4As4sKqB5tD1vSjVsD2s2zXBWC8-Az603Vy-7L=QdttLA@mail.gmail.com>
References: <cover.1541681371.git.giuliano.belinassi@usp.br>
        <ce8ebadd1638810eaaa3b0b30a961a7b3f88ae34.1541681371.git.giuliano.belinassi@usp.br>
        <43efc182fc7ab9aa1d2f1ca798e27d85c7132e1f.camel@analog.com>
        <CAEFO=4As4sKqB5tD1vSjVsD2s2zXBWC8-Az603Vy-7L=QdttLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 9 Nov 2018 20:18:58 -0200
Giuliano Augusto Faulin Belinassi <giuliano.belinassi@usp.br> wrote:

> Hi
> 
> >While I agree that it looks nicer to indent all these to the same level,
> >you also need to think about the fact that the kernel git repo is already
> >pretty big as-is, so it's a good idea if a patch adds as much code/semantic
> >value [as possible] with as little change [as possible] and with as good of
> >readability [as possible].  
> 
> Understood. But can't someone else submit another patch fixing these
> indentation issues? That would be another commit and more stuff to the
> repository.

Separating real changes from white space changes is much more important
from a reviewability point of view.  This patch is small enough that it
doesn't 'really matter' but I would have preferred it as a realignment patch
and a follow up patch making the real change.

Anyhow, it doesn't matter that much for such a small case, so applied to
the togreg branch of iio.git and pushed out as testing for the autobuilders
to play with it.

Thanks,

Jonathan


> On Thu, Nov 8, 2018 at 11:51 AM Ardelean, Alexandru
> <alexandru.Ardelean@analog.com> wrote:
> >
> > On Thu, 2018-11-08 at 11:03 -0200, Giuliano Belinassi wrote:  
> > > Previously, all pattern_masks and patterns in the chip_info table were
> > > hardcoded. Now they are generated using the PAT macros, as described in
> > > the datasheets.  
> >
> > One comment about indentation/whitespace.
> >
> > Rest looks good.
> >
> > Alex
> >  
> > >
> > > Signed-off-by: Giuliano Belinassi <giuliano.belinassi@usp.br>
> > > ---
> > > Changes in v2:
> > >       - Added the PATTERN and PATTERN_MASK macros
> > >       - Update BIT macros alignment to match with PATTERN
> > >       - Generate pattern mask with PATTERN_MASK macros.
> > >
> > > drivers/staging/iio/adc/ad7780.c | 40 +++++++++++++++++++-------------
> > >  1 file changed, 24 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/drivers/staging/iio/adc/ad7780.c
> > > b/drivers/staging/iio/adc/ad7780.c
> > > index 9ec2b002539e..ff8e3b2d0efc 100644
> > > --- a/drivers/staging/iio/adc/ad7780.c
> > > +++ b/drivers/staging/iio/adc/ad7780.c
> > > @@ -22,14 +22,22 @@
> > >  #include <linux/iio/sysfs.h>
> > >  #include <linux/iio/adc/ad_sigma_delta.h>
> > >
> > > -#define AD7780_RDY   BIT(7)
> > > -#define AD7780_FILTER        BIT(6)
> > > -#define AD7780_ERR   BIT(5)
> > > -#define AD7780_ID1   BIT(4)
> > > -#define AD7780_ID0   BIT(3)
> > > -#define AD7780_GAIN  BIT(2)
> > > -#define AD7780_PAT1  BIT(1)
> > > -#define AD7780_PAT0  BIT(0)
> > > +#define AD7780_RDY           BIT(7)
> > > +#define AD7780_FILTER                BIT(6)
> > > +#define AD7780_ERR           BIT(5)
> > > +#define AD7780_ID1           BIT(4)
> > > +#define AD7780_ID0           BIT(3)
> > > +#define AD7780_GAIN          BIT(2)
> > > +#define AD7780_PAT1          BIT(1)
> > > +#define AD7780_PAT0          BIT(0)  
> >
> > Changing indentation here doesn't add much value; it's mostly
> > patch/whitespace noise.
> >
> > While I agree that it looks nicer to indent all these to the same level,
> > you also need to think about the fact that the kernel git repo is already
> > pretty big as-is, so it's a good idea if a patch adds as much code/semantic
> > value [as possible] with as little change [as possible] and with as good of
> > readability [as possible].
> > [ Kind of sounds like a balance act between the 3 things ].
> >
> >  
> > > +
> > > +#define AD7780_PATTERN               (AD7780_PAT0)
> > > +#define AD7780_PATTERN_MASK  (AD7780_PAT0 | AD7780_PAT1)
> > > +
> > > +#define AD7170_PAT2          BIT(2)
> > > +
> > > +#define AD7170_PATTERN               (AD7780_PAT0 | AD7170_PAT2)
> > > +#define AD7170_PATTERN_MASK  (AD7780_PAT0 | AD7780_PAT1 | AD7170_PAT2)
> > >
> > >  struct ad7780_chip_info {
> > >       struct iio_chan_spec    channel;
> > > @@ -136,26 +144,26 @@ static const struct ad_sigma_delta_info
> > > ad7780_sigma_delta_info = {
> > >  static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
> > >       [ID_AD7170] = {
> > >               .channel = AD7780_CHANNEL(12, 24),
> > > -             .pattern = 0x5,
> > > -             .pattern_mask = 0x7,
> > > +             .pattern = AD7170_PATTERN,
> > > +             .pattern_mask = AD7170_PATTERN_MASK,
> > >               .is_ad778x = false,
> > >       },
> > >       [ID_AD7171] = {
> > >               .channel = AD7780_CHANNEL(16, 24),
> > > -             .pattern = 0x5,
> > > -             .pattern_mask = 0x7,
> > > +             .pattern = AD7170_PATTERN,
> > > +             .pattern_mask = AD7170_PATTERN_MASK,
> > >               .is_ad778x = false,
> > >       },
> > >       [ID_AD7780] = {
> > >               .channel = AD7780_CHANNEL(24, 32),
> > > -             .pattern = 0x1,
> > > -             .pattern_mask = 0x3,
> > > +             .pattern = AD7780_PATTERN,
> > > +             .pattern_mask = AD7780_PATTERN_MASK,
> > >               .is_ad778x = true,
> > >       },
> > >       [ID_AD7781] = {
> > >               .channel = AD7780_CHANNEL(20, 32),
> > > -             .pattern = 0x1,
> > > -             .pattern_mask = 0x3,
> > > +             .pattern = AD7780_PATTERN,
> > > +             .pattern_mask = AD7780_PATTERN_MASK,
> > >               .is_ad778x = true,
> > >       },
> > >  };  
> >
> > --
> > You received this message because you are subscribed to the Google Groups "Kernel USP" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to kernel-usp+unsubscribe@googlegroups.com.
> > To post to this group, send email to kernel-usp@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/kernel-usp/43efc182fc7ab9aa1d2f1ca798e27d85c7132e1f.camel%40analog.com.
> > For more options, visit https://groups.google.com/d/optout.  
