Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47480 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183AbbHOOtT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 15 Aug 2015 10:49:19 -0400
Subject: Re: [PATCH v3 0/6] iio: bmg160: Add SPI connection
To: Lars-Peter Clausen <lars@metafoo.de>,
	Markus Pargmann <mpa@pengutronix.de>
References: <1439391009-6051-1-git-send-email-mpa@pengutronix.de>
 <55CB6065.8000901@metafoo.de>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Paul Bolle <pebolle@tiscali.nl>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	Irina Tirdea <irina.tirdea@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55CF516B.1030502@kernel.org>
Date: Sat, 15 Aug 2015 15:49:15 +0100
MIME-Version: 1.0
In-Reply-To: <55CB6065.8000901@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/08/15 16:04, Lars-Peter Clausen wrote:
> Hi,
> 
> Markus and Irina can you try to synchronize your efforts. This series will
> conflict with http://marc.info/?l=linux-iio&m=143938994602171&w=2
> 
> I think it would be best if the multi-read emulation support is added to
> regmap (which I think Markus' earlier series did).
Good spot Lars, I'd managed to miss this clash entirely (and had both sets
marked for applying - though I'd marked them for such on totally different
days!)

Anyhow, I'm going to take this series for now and we'll have to deal with
the emulation stuff on top of it.

Jonathan
> 
> - Lars
> 
> On 08/12/2015 04:50 PM, Markus Pargmann wrote:
>> Hi,
>>
>> bmg160 and bmi055 can be used via I2C and SPI. This series converts the driver
>> to regmap and splits core driver and I2C/SPI.
>>
>> Changes in v3:
>>  - removed 'select REGMAP' as it is selected by REGMAP_I2C
>>  - added EXPORT_SYMBOL_GPL for the core functions
>>  - removed default values from regmap_config
>>  - Added max_register and unset use_single_rw in regmap_config
>>  - Changed Makefile to always compile bmg160-core with either spi or i2c. It is
>>    not possible now to compile the core alone.
>>
>> Changes in v2:
>>  - Added the id->name from the SPI driver to be used as iio device name
>>  - Fixed Kconfig in patch 2 to add selects for REGMAP_I2C
>>  - Fixed regmap configs to be static const
>>
>>
>> Best regards,
>>
>> Markus
>>
>>
>> Markus Pargmann (6):
>>   iio: bmg160: Use i2c regmap instead of direct i2c access
>>   iio: bmg160: Remove i2c_client from data struct
>>   iio: bmg160: Use generic dev_drvdata
>>   iio: bmg160: Remove remaining uses of i2c_client
>>   iio: bmg160: Separate i2c and core driver
>>   iio: bmg160: Add SPI driver
>>
>>  drivers/iio/gyro/Kconfig                     |  28 ++-
>>  drivers/iio/gyro/Makefile                    |   3 +-
>>  drivers/iio/gyro/bmg160.h                    |  10 +
>>  drivers/iio/gyro/{bmg160.c => bmg160_core.c} | 358 +++++++++++----------------
>>  drivers/iio/gyro/bmg160_i2c.c                |  71 ++++++
>>  drivers/iio/gyro/bmg160_spi.c                |  57 +++++
>>  6 files changed, 306 insertions(+), 221 deletions(-)
>>  create mode 100644 drivers/iio/gyro/bmg160.h
>>  rename drivers/iio/gyro/{bmg160.c => bmg160_core.c} (74%)
>>  create mode 100644 drivers/iio/gyro/bmg160_i2c.c
>>  create mode 100644 drivers/iio/gyro/bmg160_spi.c
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

