Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:14973 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbcFWIVI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jun 2016 04:21:08 -0400
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 0/9] Improve BMP280 driver v2
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <1466628819-29784-1-git-send-email-linus.walleij@linaro.org>
Date: Thu, 23 Jun 2016 10:17:47 +0200
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Matt Ranostay <mranostay@gmail.com>,
	Christoph Mair <christoph.mair@gmail.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Marek Belisko <marek@goldelico.com>,
	Eric Andersson <eric.andersson@unixphere.com>,
	Neil Brown <neilb@suse.de>,
	letux-kernel-bounces@openphoenux.org, kernel@pyra-handheld.com
Message-Id: <2B826474-77DF-4AA8-AC8A-FEDA021668D2@goldelico.com>
References: <1466628819-29784-1-git-send-email-linus.walleij@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> Am 22.06.2016 um 22:53 schrieb Linus Walleij <linus.walleij@linaro.org>:
> 
> This is version two of the previous patchset. Changes:
> 
> - Rebased on top of Matt Ranostays BME280 support patch so everything
>  applies cleanly on top of Jonathans development branch
> 
> - Added Akinobu Mitas special SPI bus handling code snippets
> 
> - Made the regulators non-optional: if the chip has supplies, it should
>  have regulators for them
> 
> - Fixed review comments and build remarks provided by the zeroday
>  build robot
> 
> Linus Walleij (9):
>  iio: pressure: bmp280: augment DT bindings
>  iio: pressure: bmp280: support device tree initialization
>  iio: pressure: bmp280: add reset GPIO line handling
>  iio: pressure: bmp280: support supply regulators
>  iio: pressure: bmp280: split driver in logical parts
>  iio: pressure: bmp280: split off an I2C Kconfig entry
>  iio: pressure: bmp280: add SPI interface driver
>  iio: pressure: bmp280: add support for BMP085 EOC interrupt
>  iio: pressure: bmp280: read calibration data once
> 
> .../devicetree/bindings/iio/pressure/bmp085.txt    |   15 +-
> drivers/iio/pressure/Kconfig                       |   29 +-
> drivers/iio/pressure/Makefile                      |    3 +
> drivers/iio/pressure/bmp280-core.c                 | 1009 ++++++++++++++++++
> drivers/iio/pressure/bmp280-i2c.c                  |   83 ++
> drivers/iio/pressure/bmp280-regmap.c               |   81 ++
> drivers/iio/pressure/bmp280-spi.c                  |  118 +++
> drivers/iio/pressure/bmp280.c                      | 1118 --------------------
> drivers/iio/pressure/bmp280.h                      |  108 ++
> 9 files changed, 1437 insertions(+), 1127 deletions(-)
> create mode 100644 drivers/iio/pressure/bmp280-core.c
> create mode 100644 drivers/iio/pressure/bmp280-i2c.c
> create mode 100644 drivers/iio/pressure/bmp280-regmap.c
> create mode 100644 drivers/iio/pressure/bmp280-spi.c
> delete mode 100644 drivers/iio/pressure/bmp280.c
> create mode 100644 drivers/iio/pressure/bmp280.h

Tests on GTA04 (BMP085 with EOC) by reading /sys/bus/iio /.../in_*_input
- temperature value in m°C is perfect and
  typical value: 34300 (for 34.3°C)
- pressure seems to be reasonable (if multiplied by 10 to give mBar)
  typical value: 95.108000000 (would it be better to report µBar as integer?)

Tests on Pyra-Handheld (BME280 w/o EOC)
- temp and pressure seem to agree with GTA04
- humitidy reports RH = 71.854492187 % which might be correct or not (can't check)

Detailed suggestions follow for individual patches.

Thanks,
Nikolaus

