Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36376 "EHLO
	mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbcF1Npg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jun 2016 09:45:36 -0400
Received: by mail-qk0-f193.google.com with SMTP id r68so736598qka.3
        for <linux-iio@vger.kernel.org>; Tue, 28 Jun 2016 06:44:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1467045020-2665-6-git-send-email-linus.walleij@linaro.org>
References: <1467045020-2665-1-git-send-email-linus.walleij@linaro.org> <1467045020-2665-6-git-send-email-linus.walleij@linaro.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Tue, 28 Jun 2016 22:43:51 +0900
Message-ID: <CAC5umygPpeP-zjcpMCERoWh6R4QGu6MmBHiP1oTUbrO1K5ZzMg@mail.gmail.com>
Subject: Re: [PATCH 05/10 v3] iio: pressure: bmp280: split driver in logical parts
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Matt Ranostay <mranostay@gmail.com>,
	Christoph Mair <christoph.mair@gmail.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Marek Belisko <marek@goldelico.com>,
	Eric Andersson <eric.andersson@unixphere.com>,
	Neil Brown <neilb@suse.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

2016-06-28 1:30 GMT+09:00 Linus Walleij <linus.walleij@linaro.org>:
> This splits the BMP280 driver in three logical parts: the core driver
> bmp280-core that only operated on a struct device * and a struct regmap *,
> the regmap driver bmp280-regmap that can be shared between I2C and other
> transports and the I2C module driver bmp280-i2c.
>
> Cleverly bake all functionality into a single object bmp280.o so that
> we still get the same module binary built for the device in the end,
> without any fuzz exporting symbols to the left and right.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Rebasing, hopefully remember to use -M when formatting patches
> ChangeLog v1->v2:
> - Rebased on top of Matt Ranostays BME280 with humidity sensor support
> - Rebased on top of other changes to e.g. regulator handling
> ---
>  drivers/iio/pressure/Makefile                    |   1 +
>  drivers/iio/pressure/{bmp280.c => bmp280-core.c} | 313 +++--------------------
>  drivers/iio/pressure/bmp280-i2c.c                |  89 +++++++
>  drivers/iio/pressure/bmp280-regmap.c             |  81 ++++++
>  drivers/iio/pressure/bmp280.h                    | 108 ++++++++
>  5 files changed, 319 insertions(+), 273 deletions(-)
>  rename drivers/iio/pressure/{bmp280.c => bmp280-core.c} (72%)
>  create mode 100644 drivers/iio/pressure/bmp280-i2c.c
>  create mode 100644 drivers/iio/pressure/bmp280-regmap.c
>  create mode 100644 drivers/iio/pressure/bmp280.h
>
> diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
> index 17d6e7afa1ff..2d98a7ff77a8 100644
> --- a/drivers/iio/pressure/Makefile
> +++ b/drivers/iio/pressure/Makefile
> @@ -4,6 +4,7 @@
>
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_BMP280) += bmp280.o
> +bmp280-objs := bmp280-core.o bmp280-regmap.o bmp280-i2c.o
>  obj-$(CONFIG_HID_SENSOR_PRESS)   += hid-sensor-press.o
>  obj-$(CONFIG_HP03) += hp03.o
>  obj-$(CONFIG_MPL115) += mpl115.o
> diff --git a/drivers/iio/pressure/bmp280.c b/drivers/iio/pressure/bmp280-core.c
> similarity index 72%
> rename from drivers/iio/pressure/bmp280.c
> rename to drivers/iio/pressure/bmp280-core.c
> index d895973a966d..fedb43082971 100644
> --- a/drivers/iio/pressure/bmp280.c
> +++ b/drivers/iio/pressure/bmp280-core.c
...

> -MODULE_AUTHOR("Vlad Dogaru <vlad.dogaru@intel.com>");
> -MODULE_DESCRIPTION("Driver for Bosch Sensortec BMP180/BMP280 pressure and temperature sensor");
> -MODULE_LICENSE("GPL v2");

We should keep these MODULE_* for core driver module.
Especially for MODULE_LICENSE(), otherwise we get:
        bmp280: module license 'unspecified' taints kernel.
