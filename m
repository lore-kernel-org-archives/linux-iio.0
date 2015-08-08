Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59238 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992440AbbHHQM0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2015 12:12:26 -0400
Subject: Re: [PATCH v2 0/6] iio: bmg160: Add SPI connection
To: Markus Pargmann <mpa@pengutronix.de>
References: <1438686179-18635-1-git-send-email-mpa@pengutronix.de>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Paul Bolle <pebolle@tiscali.nl>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55C62A68.5060508@kernel.org>
Date: Sat, 8 Aug 2015 17:12:24 +0100
MIME-Version: 1.0
In-Reply-To: <1438686179-18635-1-git-send-email-mpa@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/08/15 12:02, Markus Pargmann wrote:
> Hi,
> 
> bmg160 and bmi055 can be used via I2C and SPI. This series converts the driver
> to regmap and splits core driver and I2C/SPI.
> 
> Changes in v2:
>  - Added the id->name from the SPI driver to be used as iio device name
>  - Fixed Kconfig in patch 2 to add selects for REGMAP_I2C
>  - Fixed regmap configs to be static const
> 
> Best regards,
> 
> Markus
I am more or less happy with these, but want a reviewed-by/acked-by from
Srinivas.
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
>  drivers/iio/gyro/Kconfig                     |  29 ++-
>  drivers/iio/gyro/Makefile                    |   4 +-
>  drivers/iio/gyro/bmg160.h                    |  10 +
>  drivers/iio/gyro/{bmg160.c => bmg160_core.c} | 356 +++++++++++----------------
>  drivers/iio/gyro/bmg160_i2c.c                |  73 ++++++
>  drivers/iio/gyro/bmg160_spi.c                |  60 +++++
>  6 files changed, 311 insertions(+), 221 deletions(-)
>  create mode 100644 drivers/iio/gyro/bmg160.h
>  rename drivers/iio/gyro/{bmg160.c => bmg160_core.c} (74%)
>  create mode 100644 drivers/iio/gyro/bmg160_i2c.c
>  create mode 100644 drivers/iio/gyro/bmg160_spi.c
> 

