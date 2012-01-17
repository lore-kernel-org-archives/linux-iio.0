Return-Path: <maxime.ripard@free-electrons.com>
Message-ID: <4F15C733.8000404@free-electrons.com>
Date: Tue, 17 Jan 2012 20:08:35 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
 Nicolas Ferre <nicolas.ferre@atmel.com>,
 Patrice Vilchez <patrice.vilchez@atmel.com>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jonathan Cameron <jic23@cam.ac.uk>,
 Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH 2/3] ARM: AT91: IIO: Add AT91 ADC driver.
References: <1326749786-13035-1-git-send-email-maxime.ripard@free-electrons.com> <1326749786-13035-3-git-send-email-maxime.ripard@free-electrons.com> <201201171735.06166.arnd@arndb.de>
In-Reply-To: <201201171735.06166.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-iio@vger.kernel.org>

Hi Arnd,

On 17/01/2012 18:35, Arnd Bergmann wrote:
> On Monday 16 January 2012, Maxime Ripard wrote:
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>>
>> Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
>> Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
>> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> Cc: Jonathan Cameron <jic23@cam.ac.uk>
>> Cc: Marek Vasut <marek.vasut@gmail.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
> 
> I think I reviewed this driver before, but I don't remember any of the
> details I may have complained about. I assume everything was fixed,
> since the driver looks good in this version ;-)

You did, and as far as I remember, you did not complained much. but
actually, I've rewritten a large enough part of this driver to make the
Acked-by you gave at the time at best outdated. That's why I dropped all
the SoB and friends to a Cc.

I mentionned it in the cover letter, but I forgot to Cc you one that one
too, my bad...

> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Two general comments:
> 
> * Please add a changeset description (i.e. thetext above your
> Signed-off-by: line) for every patch you do. Just read a few
> dozen patches that get posted to lkml to get a feeling for
> what would be useful to have in there. For a new driver, it
> would be helpful to know what hardware uses this driver and
> what the device does there.

Ok, will do.

> * Over time, we will get stricter in requiring device tree
> bindings for new platform devices, to replace platform_data
> where appropriate. It's not required yet, but it would be nice
> to describe the long-term plan in submissions that add new
> platform_data but no device tree bindings.

The main point of rewriting a part of it was exactly to make the
transition to device-tree and single kernel image easier when the time
comes.

Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
