Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729407AbeKQEq0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 16 Nov 2018 23:46:26 -0500
Date: Fri, 16 Nov 2018 18:32:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc: "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "renatogeh@gmail.com" <renatogeh@gmail.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "giuliano.belinassi@gmail.com" <giuliano.belinassi@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/2] staging: iio: ad7780: check if ad778x before
 gain update
Message-ID: <20181116183250.3263bf66@archlinux>
In-Reply-To: <d606520397eaf3b57372fa2fffc6f17b567eee61.camel@analog.com>
References: <cover.1541681371.git.giuliano.belinassi@usp.br>
        <762e851dd819f27e3955cb695cd8422d84a19438.1541681371.git.giuliano.belinassi@usp.br>
        <77c3b6ee484b077152138cb8e1b7e03295114e54.camel@analog.com>
        <20181111125859.7263bc15@archlinux>
        <d606520397eaf3b57372fa2fffc6f17b567eee61.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 12 Nov 2018 07:57:58 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Sun, 2018-11-11 at 12:58 +0000, Jonathan Cameron wrote:
> > On Thu, 8 Nov 2018 13:44:17 +0000
> > "Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:
> >   
> > > On Thu, 2018-11-08 at 11:03 -0200, Giuliano Belinassi wrote:  
> > > > Only the ad778x have the 'gain' status bit. Check it before updating
> > > > through a new variable is_ad778x in chip_info.
> > > >     
> > > 
> > > Looks good.  
> > 
> > Alex, formal tags definitely preferred!  It's not as though a
> > looks good is any less of a review than an Ack, it's just better
> > hidden as people need to look at mailing list archives...
> > 
> > Jonathan
> >   
> 
> Acked-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
I haven't pushed out togreg yet so can still rebase.

Added. Thanks,

Jonathan

> 
> // Will remember that next time :)
> 
> Thanks
> Alex
> 
> > > 
> > > Alex
> > >   
> > > > Signed-off-by: Giuliano Belinassi <giuliano.belinassi@usp.br>
> > > > ---
> > > > Changes in v2:
> > > > 	- Squashed is_ad778x declaration commit with the ad778x checkage
> > > > 	- Changed is_ad778x type to bool
> > > >  
> > > >  drivers/staging/iio/adc/ad7780.c | 15 +++++++++++----
> > > >  1 file changed, 11 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/iio/adc/ad7780.c
> > > > b/drivers/staging/iio/adc/ad7780.c
> > > > index 91e016d534ed..9ec2b002539e 100644
> > > > --- a/drivers/staging/iio/adc/ad7780.c
> > > > +++ b/drivers/staging/iio/adc/ad7780.c
> > > > @@ -35,6 +35,7 @@ struct ad7780_chip_info {
> > > >  	struct iio_chan_spec	channel;
> > > >  	unsigned int		pattern_mask;
> > > >  	unsigned int		pattern;
> > > > +	bool			is_ad778x;
> > > >  };
> > > >  
> > > >  struct ad7780_state {
> > > > @@ -113,10 +114,12 @@ static int ad7780_postprocess_sample(struct
> > > > ad_sigma_delta *sigma_delta,
> > > >  	    ((raw_sample & chip_info->pattern_mask) != chip_info->pattern))
> > > >  		return -EIO;
> > > >  
> > > > -	if (raw_sample & AD7780_GAIN)
> > > > -		st->gain = 1;
> > > > -	else
> > > > -		st->gain = 128;
> > > > +	if (chip_info->is_ad778x) {
> > > > +		if (raw_sample & AD7780_GAIN)
> > > > +			st->gain = 1;
> > > > +		else
> > > > +			st->gain = 128;
> > > > +	}
> > > >  
> > > >  	return 0;
> > > >  }
> > > > @@ -135,21 +138,25 @@ static const struct ad7780_chip_info
> > > > ad7780_chip_info_tbl[] = {
> > > >  		.channel = AD7780_CHANNEL(12, 24),
> > > >  		.pattern = 0x5,
> > > >  		.pattern_mask = 0x7,
> > > > +		.is_ad778x = false,
> > > >  	},
> > > >  	[ID_AD7171] = {
> > > >  		.channel = AD7780_CHANNEL(16, 24),
> > > >  		.pattern = 0x5,
> > > >  		.pattern_mask = 0x7,
> > > > +		.is_ad778x = false,
> > > >  	},
> > > >  	[ID_AD7780] = {
> > > >  		.channel = AD7780_CHANNEL(24, 32),
> > > >  		.pattern = 0x1,
> > > >  		.pattern_mask = 0x3,
> > > > +		.is_ad778x = true,
> > > >  	},
> > > >  	[ID_AD7781] = {
> > > >  		.channel = AD7780_CHANNEL(20, 32),
> > > >  		.pattern = 0x1,
> > > >  		.pattern_mask = 0x3,
> > > > +		.is_ad778x = true,
> > > >  	},
> > > >  };
> > > >      
> > 
> >   
