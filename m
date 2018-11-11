Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727510AbeKKWtU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Nov 2018 17:49:20 -0500
Date: Sun, 11 Nov 2018 13:00:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Giuliano Augusto Faulin Belinassi <giuliano.belinassi@usp.br>
Cc: tduszyns@gmail.com, giuliano.belinassi@gmail.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        gregkh@linuxfoundation.org, Renato Geh <renatogeh@gmail.com>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Kernel USP <kernel-usp@googlegroups.com>
Subject: Re: [PATCH v2 1/2] staging: iio: ad7780: check if ad778x before
 gain update
Message-ID: <20181111130043.175e2ac6@archlinux>
In-Reply-To: <CAEFO=4BVP9GH7-swQHMevuPjfJ=RyaySQmvr2qo+DK5xPB3VjA@mail.gmail.com>
References: <cover.1541681371.git.giuliano.belinassi@usp.br>
        <762e851dd819f27e3955cb695cd8422d84a19438.1541681371.git.giuliano.belinassi@usp.br>
        <55b5de74-a607-94b9-8c85-40658e38fbb5@gmail.com>
        <CAEFO=4BVP9GH7-swQHMevuPjfJ=RyaySQmvr2qo+DK5xPB3VjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 9 Nov 2018 20:15:45 -0200
Giuliano Augusto Faulin Belinassi <giuliano.belinassi@usp.br> wrote:

> > Just some random though. Instead of introducing extra level of indentation you
> > can simply check whether is_ad778x is asserted and simply return.  
> 
> I agree that the patch would be smaller if I do that, but is it really
> an issue? If yes, then I will update the patch with this change
> 
> > Any reason for setting this explicitly? That's going to be false anyway  
> 
> It seems clearer to me :-)

Definitely marginal, but not a strong reason either way so I've
applied this as is.  If there were lots of instances of it I would
have agreed with Tomasz (both suggestions were good but Tomasz said,
minor!)

Jonathan

> On Thu, Nov 8, 2018 at 4:26 PM Tomasz Duszynski <tduszyns@gmail.com> wrote:
> >
> > Hi Giuliano,
> >
> > Comment inline.
> >
> > On 11/8/18 2:03 PM, Giuliano Belinassi wrote:  
> > > Only the ad778x have the 'gain' status bit. Check it before updating
> > > through a new variable is_ad778x in chip_info.
> > >
> > > Signed-off-by: Giuliano Belinassi <giuliano.belinassi@usp.br>
> > > ---
> > > Changes in v2:
> > >       - Squashed is_ad778x declaration commit with the ad778x checkage
> > >       - Changed is_ad778x type to bool
> > >
> > >  drivers/staging/iio/adc/ad7780.c | 15 +++++++++++----
> > >  1 file changed, 11 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
> > > index 91e016d534ed..9ec2b002539e 100644
> > > --- a/drivers/staging/iio/adc/ad7780.c
> > > +++ b/drivers/staging/iio/adc/ad7780.c
> > > @@ -35,6 +35,7 @@ struct ad7780_chip_info {
> > >       struct iio_chan_spec    channel;
> > >       unsigned int            pattern_mask;
> > >       unsigned int            pattern;
> > > +     bool                    is_ad778x;
> > >  };
> > >
> > >  struct ad7780_state {
> > > @@ -113,10 +114,12 @@ static int ad7780_postprocess_sample(struct ad_sigma_delta *sigma_delta,
> > >           ((raw_sample & chip_info->pattern_mask) != chip_info->pattern))
> > >               return -EIO;
> > >
> > > -     if (raw_sample & AD7780_GAIN)
> > > -             st->gain = 1;
> > > -     else
> > > -             st->gain = 128;
> > > +     if (chip_info->is_ad778x) {
> > > +             if (raw_sample & AD7780_GAIN)
> > > +                     st->gain = 1;
> > > +             else
> > > +                     st->gain = 128;
> > > +     }  
> >
> > Just some random though. Instead of introducing extra level of indentation you
> > can simply check whether is_ad778x is asserted and simply return.
> >  
> > >
> > >       return 0;
> > >  }
> > > @@ -135,21 +138,25 @@ static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
> > >               .channel = AD7780_CHANNEL(12, 24),
> > >               .pattern = 0x5,
> > >               .pattern_mask = 0x7,
> > > +             .is_ad778x = false,  
> >
> > Any reason for setting this explicitly? That's going to be false anyway.
> >  
> > >       },
> > >       [ID_AD7171] = {
> > >               .channel = AD7780_CHANNEL(16, 24),
> > >               .pattern = 0x5,
> > >               .pattern_mask = 0x7,
> > > +             .is_ad778x = false,
> > >       },
> > >       [ID_AD7780] = {
> > >               .channel = AD7780_CHANNEL(24, 32),
> > >               .pattern = 0x1,
> > >               .pattern_mask = 0x3,
> > > +             .is_ad778x = true,
> > >       },
> > >       [ID_AD7781] = {
> > >               .channel = AD7780_CHANNEL(20, 32),
> > >               .pattern = 0x1,
> > >               .pattern_mask = 0x3,
> > > +             .is_ad778x = true,
> > >       },
> > >  };
> > >  
> >
> > --
> > You received this message because you are subscribed to the Google Groups "Kernel USP" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to kernel-usp+unsubscribe@googlegroups.com.
> > To post to this group, send email to kernel-usp@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/kernel-usp/55b5de74-a607-94b9-8c85-40658e38fbb5%40gmail.com.
> > For more options, visit https://groups.google.com/d/optout.  
