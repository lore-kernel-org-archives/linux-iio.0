Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 2/3] ARM: AT91: IIO: Add AT91 ADC driver.
Date: Tue, 17 Jan 2012 17:35:05 +0000
Cc: linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 "Jean-Christophe PLAGNIOL-VILLARD" <plagnioj@jcrosoft.com>,
 Nicolas Ferre <nicolas.ferre@atmel.com>,
 Patrice Vilchez <patrice.vilchez@atmel.com>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jonathan Cameron <jic23@cam.ac.uk>,
 Marek Vasut <marek.vasut@gmail.com>
References: <1326749786-13035-1-git-send-email-maxime.ripard@free-electrons.com> <1326749786-13035-3-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1326749786-13035-3-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201201171735.06166.arnd@arndb.de>
List-ID: <linux-iio@vger.kernel.org>

On Monday 16 January 2012, Maxime Ripard wrote:
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Jonathan Cameron <jic23@cam.ac.uk>
> Cc: Marek Vasut <marek.vasut@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

I think I reviewed this driver before, but I don't remember any of the
details I may have complained about. I assume everything was fixed,
since the driver looks good in this version ;-)

Acked-by: Arnd Bergmann <arnd@arndb.de>

Two general comments:

* Please add a changeset description (i.e. thetext above your
Signed-off-by: line) for every patch you do. Just read a few
dozen patches that get posted to lkml to get a feeling for
what would be useful to have in there. For a new driver, it
would be helpful to know what hardware uses this driver and
what the device does there.

* Over time, we will get stricter in requiring device tree
bindings for new platform devices, to replace platform_data
where appropriate. It's not required yet, but it would be nice
to describe the long-term plan in submissions that add new
platform_data but no device tree bindings.

	Arnd
