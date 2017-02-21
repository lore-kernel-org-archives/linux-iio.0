Return-Path: <SRS0=hYFC=2C=gmail.com=eraretuya@kernel.org>
Date: Tue, 21 Feb 2017 23:03:15 +0800
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	dmitry.torokhov@gmail.com, michael.hennerich@analog.com,
	daniel.baluta@gmail.com, amsfield22@gmail.com,
	florian.vaussard@heig-vd.ch, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] iio: accel: adxl345: Split driver into core and
 I2C then add SPI support
Message-ID: <20170221150314.GA3315@Socrates-UM>
References: <cover.1487581433.git.eraretuya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1487581433.git.eraretuya@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Feb 20, 2017 at 05:25:39PM +0800, Eva Rachel Retuya wrote:
> This patchset modifies the adxl345 to use regmap. In doing so, we can
> easily introduce SPI support and let regmap handle the rest.
> 
> Recap of basic features: read_raw for x, y and z axes, scale. After
> applying this series, driver now supports the SPI protocol and enumeration
> of device via ACPI.
> 

Hello all,

Kindly disregard this. Will submit a v3 because I have to drop ACPI and
switch to DT method of enumeration.

Thanks,
Eva

> Changes from v1:
> [PATCH 1/4]
> * Move other deletions from patch 2 in here -- make it clear what got deleted
>   and/or modified that is hard to see previously
> * Introduce the driver header file "adxl345.h" here instead of doing it in the
>   next patch
> * Completely omit traces of i2c_client and let this file (adxl345.c) mirror the
>   core file on the next patch.
> * Improve debugging print about invalid device ID in probe.
> [PATCH 2/4]
> * Update Kconfig to Jonathan's preferred style
> * Improve similarity index from 78% to 100% (rename detection)
> [PATCH 4/4]
> * Correct acpi_device_id: ADX0345 -> ADS0345
> 
> Eva Rachel Retuya (4):
>   iio: accel: adxl345: Use I2C regmap instead of direct I2C access
>   iio: accel: adxl345: Split driver into core and I2C
>   iio: accel: adxl345: Add SPI support
>   iio: accel: adxl345: Add ACPI support
> 
>  drivers/iio/accel/Kconfig        |  18 +++-
>  drivers/iio/accel/Makefile       |   4 +-
>  drivers/iio/accel/adxl345.c      | 194 ---------------------------------------
>  drivers/iio/accel/adxl345.h      |  18 ++++
>  drivers/iio/accel/adxl345_core.c | 182 ++++++++++++++++++++++++++++++++++++
>  drivers/iio/accel/adxl345_i2c.c  |  79 ++++++++++++++++
>  drivers/iio/accel/adxl345_spi.c  |  84 +++++++++++++++++
>  7 files changed, 381 insertions(+), 198 deletions(-)
>  delete mode 100644 drivers/iio/accel/adxl345.c
>  create mode 100644 drivers/iio/accel/adxl345.h
>  create mode 100644 drivers/iio/accel/adxl345_core.c
>  create mode 100644 drivers/iio/accel/adxl345_i2c.c
>  create mode 100644 drivers/iio/accel/adxl345_spi.c
> 
> -- 
> 2.7.4
> 
