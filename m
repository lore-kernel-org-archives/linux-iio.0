Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:31657 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753810AbbHQJ1H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 17 Aug 2015 05:27:07 -0400
From: "Tirdea, Irina" <irina.tirdea@intel.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Markus Pargmann <mpa@pengutronix.de>,
	Jonathan Cameron <jic23@kernel.org>
CC: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Dogaru, Vlad" <vlad.dogaru@intel.com>,
	Paul Bolle <pebolle@tiscali.nl>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v3 0/6] iio: bmg160: Add SPI connection
Date: Mon, 17 Aug 2015 09:27:04 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F0B1F3A@irsmsx105.ger.corp.intel.com>
References: <1439391009-6051-1-git-send-email-mpa@pengutronix.de>
 <55CB6065.8000901@metafoo.de>
In-Reply-To: <55CB6065.8000901@metafoo.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Lars-Peter Clausen [mailto:lars@metafoo.de]
> Sent: 12 August, 2015 18:04
> To: Markus Pargmann; Jonathan Cameron
> Cc: Srinivas Pandruvada; Dogaru, Vlad; Paul Bolle; linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; kernel@pengutronix.de;
> Tirdea, Irina
> Subject: Re: [PATCH v3 0/6] iio: bmg160: Add SPI connection
> 
> Hi,
> 
> Markus and Irina can you try to synchronize your efforts. This series will
> conflict with http://marc.info/?l=linux-iio&m=143938994602171&w=2
> 

Hi Lars,

Good catch, especially since those patches might have been merged
through another tree. Completely missed this one.

> I think it would be best if the multi-read emulation support is added to
> regmap (which I think Markus' earlier series did).
> 

I think my i2c controllers will work directly with regmap_bulk_read,
so I probably won't need additional changes for regmap. I will rebase
the bmg160 patches on top of the ones that add regmap support.

Thanks,
Irina

> - Lars
> 
> On 08/12/2015 04:50 PM, Markus Pargmann wrote:
> > Hi,
> >
> > bmg160 and bmi055 can be used via I2C and SPI. This series converts the driver
> > to regmap and splits core driver and I2C/SPI.
> >
> > Changes in v3:
> >  - removed 'select REGMAP' as it is selected by REGMAP_I2C
> >  - added EXPORT_SYMBOL_GPL for the core functions
> >  - removed default values from regmap_config
> >  - Added max_register and unset use_single_rw in regmap_config
> >  - Changed Makefile to always compile bmg160-core with either spi or i2c. It is
> >    not possible now to compile the core alone.
> >
> > Changes in v2:
> >  - Added the id->name from the SPI driver to be used as iio device name
> >  - Fixed Kconfig in patch 2 to add selects for REGMAP_I2C
> >  - Fixed regmap configs to be static const
> >
> >
> > Best regards,
> >
> > Markus
> >
> >
> > Markus Pargmann (6):
> >   iio: bmg160: Use i2c regmap instead of direct i2c access
> >   iio: bmg160: Remove i2c_client from data struct
> >   iio: bmg160: Use generic dev_drvdata
> >   iio: bmg160: Remove remaining uses of i2c_client
> >   iio: bmg160: Separate i2c and core driver
> >   iio: bmg160: Add SPI driver
> >
> >  drivers/iio/gyro/Kconfig                     |  28 ++-
> >  drivers/iio/gyro/Makefile                    |   3 +-
> >  drivers/iio/gyro/bmg160.h                    |  10 +
> >  drivers/iio/gyro/{bmg160.c => bmg160_core.c} | 358 +++++++++++----------------
> >  drivers/iio/gyro/bmg160_i2c.c                |  71 ++++++
> >  drivers/iio/gyro/bmg160_spi.c                |  57 +++++
> >  6 files changed, 306 insertions(+), 221 deletions(-)
> >  create mode 100644 drivers/iio/gyro/bmg160.h
> >  rename drivers/iio/gyro/{bmg160.c => bmg160_core.c} (74%)
> >  create mode 100644 drivers/iio/gyro/bmg160_i2c.c
> >  create mode 100644 drivers/iio/gyro/bmg160_spi.c
> >

