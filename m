Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-194.synserver.de ([212.40.185.194]:1267 "EHLO
	smtp-out-194.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519AbbHLPEK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 11:04:10 -0400
Message-ID: <55CB6065.8000901@metafoo.de>
Date: Wed, 12 Aug 2015 17:04:05 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Markus Pargmann <mpa@pengutronix.de>,
	Jonathan Cameron <jic23@kernel.org>
CC: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Paul Bolle <pebolle@tiscali.nl>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: Re: [PATCH v3 0/6] iio: bmg160: Add SPI connection
References: <1439391009-6051-1-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1439391009-6051-1-git-send-email-mpa@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

Markus and Irina can you try to synchronize your efforts. This series will
conflict with http://marc.info/?l=linux-iio&m=143938994602171&w=2

I think it would be best if the multi-read emulation support is added to
regmap (which I think Markus' earlier series did).

- Lars

On 08/12/2015 04:50 PM, Markus Pargmann wrote:
> Hi,
> 
> bmg160 and bmi055 can be used via I2C and SPI. This series converts the driver
> to regmap and splits core driver and I2C/SPI.
> 
> Changes in v3:
>  - removed 'select REGMAP' as it is selected by REGMAP_I2C
>  - added EXPORT_SYMBOL_GPL for the core functions
>  - removed default values from regmap_config
>  - Added max_register and unset use_single_rw in regmap_config
>  - Changed Makefile to always compile bmg160-core with either spi or i2c. It is
>    not possible now to compile the core alone.
> 
> Changes in v2:
>  - Added the id->name from the SPI driver to be used as iio device name
>  - Fixed Kconfig in patch 2 to add selects for REGMAP_I2C
>  - Fixed regmap configs to be static const
> 
> 
> Best regards,
> 
> Markus
> 
> 
> Markus Pargmann (6):
>   iio: bmg160: Use i2c regmap instead of direct i2c access
>   iio: bmg160: Remove i2c_client from data struct
>   iio: bmg160: Use generic dev_drvdata
>   iio: bmg160: Remove remaining uses of i2c_client
>   iio: bmg160: Separate i2c and core driver
>   iio: bmg160: Add SPI driver
> 
>  drivers/iio/gyro/Kconfig                     |  28 ++-
>  drivers/iio/gyro/Makefile                    |   3 +-
>  drivers/iio/gyro/bmg160.h                    |  10 +
>  drivers/iio/gyro/{bmg160.c => bmg160_core.c} | 358 +++++++++++----------------
>  drivers/iio/gyro/bmg160_i2c.c                |  71 ++++++
>  drivers/iio/gyro/bmg160_spi.c                |  57 +++++
>  6 files changed, 306 insertions(+), 221 deletions(-)
>  create mode 100644 drivers/iio/gyro/bmg160.h
>  rename drivers/iio/gyro/{bmg160.c => bmg160_core.c} (74%)
>  create mode 100644 drivers/iio/gyro/bmg160_i2c.c
>  create mode 100644 drivers/iio/gyro/bmg160_spi.c
> 

