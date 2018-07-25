Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hosting.pavoucek.net ([46.28.107.168]:59028 "EHLO
        hosting.pavoucek.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728619AbeGYKXL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Jul 2018 06:23:11 -0400
Date: Wed, 25 Jul 2018 11:12:21 +0200
From: Tomas Novotny <tomas@novotny.cz>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2 0/4] iio: vcnl4000: add support for vcnl4200
Message-ID: <20180725111221.69163fa0@tomas.local.tbs-biometrics.cz>
In-Reply-To: <20180724220117.42a922d9@archlinux>
References: <20180717164655.27142-1-tomas@novotny.cz>
        <20180721182526.6d29a6d9@archlinux>
        <20180723195816.00fffa5b@tomas.local.tbs-biometrics.cz>
        <20180724220117.42a922d9@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

On Tue, 24 Jul 2018 22:01:17 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 23 Jul 2018 19:58:16 +0200
> Tomas Novotny <tomas@novotny.cz> wrote:
> 
> > Hi Jonathan,
> > 
> > On Sat, 21 Jul 2018 18:25:26 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >   
> > > On Tue, 17 Jul 2018 18:46:51 +0200
> > > Tomas Novotny <tomas@novotny.cz> wrote:
> > >     
> > > > This is the second iteration of vcnl4200 support. The first one was posted
> > > > on February, sorry for the long delay. I've implemented all notes from
> > > > reviews (thanks to Peter and Jonathan) and nothing more.
> > > > 
> > > > Changes in v2:
> > > > - reading light and proximity values for vcnl4200 is blocking (if you
> > > >   request new value too early)
> > > > - patches 2 and 3 were added; original patch 2 is now patch 4
> > > > - vcnl4010 id is handled (patch 2)
> > > > - warn user on incorrect usage of vcnl40{0,1}0 id (patch 3)
> > > > - minor stuff (add parenthesis, switch instead of if, rename sensors to
> > > >   channels, fix return)
> > > > 
> > > > Please note that I'm not sure if it is still good idea to have same driver
> > > > for vcnl4000 and vcnl4200. The amount of different parts in v2 is even
> > > > bigger. Just see below for differences and add the blocking read which is
> > > > added in v2 for vcnl4200.      
> > > 
> > > Definitely marginal.  My view is it's your choice as the person doing
> > > the work!  Which would you prefer?    
> > 
> > Well, I was thinking about different driver in the first place. But the reason
> > was quite selfish (and not the technical one), as I'm interested only in
> > vcnl4200. But I've seen general attitude to combine similar drivers so I've
> > tried that way and I'm fine with the result. The only ugly part are some chip
> > specific things in a shared data structure.
> >   
> > > I'm pretty happy with these patches if you want to go this way, but
> > > given I assume you might add the support for other features, if you
> > > think that is going to get even worse, then now is the time to make
> > > the decision to not have a unified driver.    
> > 
> > I will probably add some settings, but this should be handled easily. I don't
> > see anything problematic in the future (well, maybe interrupts or
> > thresholds?), as both variants are more or less simple light and proximity
> > chips.
> >   
> > > Sadly it might be a case of doing a 'hatchet' job on the code to
> > > make a separate driver and see what it looks like.  If it's really
> > > short and clean (which it probably is) then go with separate drivers.    
> > 
> > The separate vcnl4200 would be indeed short and clean. The structure and
> > size would be very similar to current vcnl4000.
> > 
> > Anyway, I don't have enough experience to judge what is better. I'm ok to do
> > any variant.  
> 
> Let's go with what you have here on the basis it's marginal but you have
> done the work for this option already which makes this the better option!

ok, thanks for all your comments. I will prepare v3 then.

Tomas

> Jonathan
> 
> > 
> > Thanks for the review,
> > 
> > Tomas
> >   
> > > Jonathan
> > >     
> > > > 
> > > > Cover letter from v1:
> > > > 
> > > > VCNL4200 is another proximity and ambient light sensor from Vishay. I'm
> > > > adding support for that sensor to vcnl4000 driver, which currently supports
> > > > VCNL4000/10/20.
> > > > 
> > > > The VCNL4200 is a bit different from VCNL4000/10/20. Common things are:
> > > > - integrated proximity and ambient light sensor
> > > > - SMBus compatible I2C interface
> > > > - Vishay VCNL4xxx series...
> > > > 
> > > > Different things are:
> > > > - totally different register map
> > > > - 8-bit vs. 16-bit registers. The 16-bit values are in two 8-bit registers
> > > >   on VCNL4000. 16-bit value is in one register on VCNL4200.
> > > > - VCNL4000 has flags when the measurement is finished
> > > > 
> > > > The first patch generalizes the driver to support differencies. The second
> > > > patch adds the support for VCNL4200.
> > > > 
> > > > It is tested on VCNL4020 and VCNL4200.
> > > > 
> > > > Tomas Novotny (4):
> > > >   iio: vcnl4000: make the driver extendable
> > > >   iio: vcnl4000: add VCNL4010 device id
> > > >   iio: vcnl4000: warn on incorrectly specified device id
> > > >   iio: vcnl4000: add support for VCNL4200
> > > > 
> > > >  drivers/iio/light/Kconfig    |   5 +-
> > > >  drivers/iio/light/vcnl4000.c | 219 ++++++++++++++++++++++++++++++++++++++-----
> > > >  2 files changed, 196 insertions(+), 28 deletions(-)
> > > >       
> > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > >     
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
