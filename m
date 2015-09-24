Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46209 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752470AbbIXLas (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 24 Sep 2015 07:30:48 -0400
In-Reply-To: <20150924071107.GV32203@pengutronix.de>
References: <1442832916-30774-1-git-send-email-mpa@pengutronix.de> <1F3AC3675D538145B1661F571FE1805F2F0E78D7@irsmsx105.ger.corp.intel.com> <20150924071107.GV32203@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH v3 0/4] iio: bmc150 regmap and SPI
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Thu, 24 Sep 2015 12:30:21 +0100
To: Markus Pargmann <mpa@pengutronix.de>,
	"Tirdea, Irina" <irina.tirdea@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Message-ID: <A703BDB3-CDD6-4095-BC4F-32AF79DBBE39@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 24 September 2015 08:11:07 BST, Markus Pargmann <mpa@pengutronix.de> wrote:
>Hi Irina,
>
>On Wed, Sep 23, 2015 at 12:46:04PM +0000, Tirdea, Irina wrote:
>> 
>> 
>> > -----Original Message-----
>> > From: Markus Pargmann [mailto:mpa@pengutronix.de]
>> > Sent: 21 September, 2015 13:55
>> > To: Jonathan Cameron
>> > Cc: Srinivas Pandruvada; Tirdea, Irina; Lars-Peter Clausen;
>linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org;
>> > kernel@pengutronix.de; Markus Pargmann
>> > Subject: [PATCH v3 0/4] iio: bmc150 regmap and SPI
>> > 
>> > Hi,
>> > 
>> 
>> Hi Markus,
>> 
>> I tested the new version of you patches and everything works fine.
>> 
>> I used a BMA250E chip connected on the i2c bus.
>> The tests included the iio buffer code path and the i2c code path
>> (including using the fifo and forcing the i2c bus to use
>> the regmap_i2c_smbus_i2c_block calls you added to regmap).
>> 
>> > this series converts the bmc150 driver to use regmap and adds an
>SPI interface.
>> > 
>> > Thanks for testing and review so far. I rebased the series onto
>v4.3-rc2 now
>> > (the togreg branch seems to be on v4.2).
>> > It still works for me but there were some differences regarding the
>chip id.
>> > 
>> 
>> I actually used the togreg branch (to get the latest bmc150 driver
>changes) and
>> cherry-picked the regmap patches. Everything applied without any
>conflicts.
>
>Thank you.
>
>It is probably best if I rebase this onto togreg then as soon as it is
>based on v4.3 to have the necessary regmap dependencies.
I will hopefully get a pull request off to Greg this evening then fast forward that branch sometime over the weekend.
>
>Best Regards,
>
>Markus
>
>> 
>> Thanks,
>> Irina
>> 
>> > Changes in v3:
>> > - Fixed type of variable 'step' which lead to compile warnings.
>Type is now
>> >   size_t.
>> > - Fixed patch that moved irq variable without reason
>> > - Readded MODULE_* to the core driver
>> > - Reintroduced check id NULL check
>> > 
>> > Changes in v2:
>> > - Removed default values for regmap_config fields.
>> > - Redesigned the fifo_transfer function to avoid running in errors
>first.
>> > - Dropped irq checks patch as it is already mainline
>> > - Core can now be built as module with autoselection of i2c and spi
>parts
>> > 
>> > As my hardware is missing an interrupt line from the SPI connected
>bmc150 I am
>> > not able to test the iio buffer code path and the i2c code path.
>Tests would be
>> > appreciated.
>> > 
>> > @Srinivas:
>> > As there were some rebase conflicts on the first patch, I removed
>your
>> > reviewed-by tag again for the moment.
>> > 
>> > Best regards,
>> > 
>> > Markus
>> > 
>> > 
>> > Markus Pargmann (4):
>> >   iio: bmc150: Use i2c regmap
>> >   iio: bcm150: Remove i2c_client from private data
>> >   iio: bmc150: Split the driver into core and i2c
>> >   iio: bmc150: Add SPI driver
>> > 
>> >  drivers/iio/accel/Kconfig                          |  14 +-
>> >  drivers/iio/accel/Makefile                         |   4 +-
>> >  .../accel/{bmc150-accel.c => bmc150-accel-core.c}  | 388
>++++++++-------------
>> >  drivers/iio/accel/bmc150-accel-i2c.c               | 102 ++++++
>> >  drivers/iio/accel/bmc150-accel-spi.c               |  80 +++++
>> >  drivers/iio/accel/bmc150-accel.h                   |  20 ++
>> >  6 files changed, 366 insertions(+), 242 deletions(-)
>> >  rename drivers/iio/accel/{bmc150-accel.c => bmc150-accel-core.c}
>(82%)
>> >  create mode 100644 drivers/iio/accel/bmc150-accel-i2c.c
>> >  create mode 100644 drivers/iio/accel/bmc150-accel-spi.c
>> >  create mode 100644 drivers/iio/accel/bmc150-accel.h
>> > 
>> > --
>> > 2.5.1
>> 
>> 

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
