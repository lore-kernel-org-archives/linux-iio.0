Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727549AbeGUSS4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Jul 2018 14:18:56 -0400
Date: Sat, 21 Jul 2018 18:25:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Tomas Novotny <tomas@novotny.cz>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2 0/4] iio: vcnl4000: add support for vcnl4200
Message-ID: <20180721182526.6d29a6d9@archlinux>
In-Reply-To: <20180717164655.27142-1-tomas@novotny.cz>
References: <20180717164655.27142-1-tomas@novotny.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 17 Jul 2018 18:46:51 +0200
Tomas Novotny <tomas@novotny.cz> wrote:

> This is the second iteration of vcnl4200 support. The first one was posted
> on February, sorry for the long delay. I've implemented all notes from
> reviews (thanks to Peter and Jonathan) and nothing more.
> 
> Changes in v2:
> - reading light and proximity values for vcnl4200 is blocking (if you
>   request new value too early)
> - patches 2 and 3 were added; original patch 2 is now patch 4
> - vcnl4010 id is handled (patch 2)
> - warn user on incorrect usage of vcnl40{0,1}0 id (patch 3)
> - minor stuff (add parenthesis, switch instead of if, rename sensors to
>   channels, fix return)
> 
> Please note that I'm not sure if it is still good idea to have same driver
> for vcnl4000 and vcnl4200. The amount of different parts in v2 is even
> bigger. Just see below for differences and add the blocking read which is
> added in v2 for vcnl4200.

Definitely marginal.  My view is it's your choice as the person doing
the work!  Which would you prefer?

I'm pretty happy with these patches if you want to go this way, but
given I assume you might add the support for other features, if you
think that is going to get even worse, then now is the time to make
the decision to not have a unified driver.

Sadly it might be a case of doing a 'hatchet' job on the code to
make a separate driver and see what it looks like.  If it's really
short and clean (which it probably is) then go with separate drivers.

Jonathan

> 
> Cover letter from v1:
> 
> VCNL4200 is another proximity and ambient light sensor from Vishay. I'm
> adding support for that sensor to vcnl4000 driver, which currently supports
> VCNL4000/10/20.
> 
> The VCNL4200 is a bit different from VCNL4000/10/20. Common things are:
> - integrated proximity and ambient light sensor
> - SMBus compatible I2C interface
> - Vishay VCNL4xxx series...
> 
> Different things are:
> - totally different register map
> - 8-bit vs. 16-bit registers. The 16-bit values are in two 8-bit registers
>   on VCNL4000. 16-bit value is in one register on VCNL4200.
> - VCNL4000 has flags when the measurement is finished
> 
> The first patch generalizes the driver to support differencies. The second
> patch adds the support for VCNL4200.
> 
> It is tested on VCNL4020 and VCNL4200.
> 
> Tomas Novotny (4):
>   iio: vcnl4000: make the driver extendable
>   iio: vcnl4000: add VCNL4010 device id
>   iio: vcnl4000: warn on incorrectly specified device id
>   iio: vcnl4000: add support for VCNL4200
> 
>  drivers/iio/light/Kconfig    |   5 +-
>  drivers/iio/light/vcnl4000.c | 219 ++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 196 insertions(+), 28 deletions(-)
> 

