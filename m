Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:33165 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbcFVHzQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jun 2016 03:55:16 -0400
Received: by mail-lf0-f45.google.com with SMTP id f6so64289817lfg.0
        for <linux-iio@vger.kernel.org>; Wed, 22 Jun 2016 00:55:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1466361242-2994-1-git-send-email-linus.walleij@linaro.org>
References: <1466361242-2994-1-git-send-email-linus.walleij@linaro.org>
From: Matt Ranostay <mranostay@gmail.com>
Date: Wed, 22 Jun 2016 00:31:13 -0700
Message-ID: <CAKzfze_MasVedhUoTaGTj0CXMQWwamLoNyDnj_GTRq8xV0z_kQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] iio: bmp280: improve driver
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Christoph Mair <christoph.mair@gmail.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Marek Belisko <marek@goldelico.com>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Eric Andersson <eric.andersson@unixphere.com>,
	Neil Brown <neilb@suse.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Jun 19, 2016 at 11:33 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> The goal of the original exercise to enable the driver for my
> Dragonboard expanded when I found the *second* driver for this
> sensor in drivers/misc/bmp085.
>
> So I wrote a patch series to bring the features of the IIO driver
> on par with the misc driver, and beyond it:
>
> - The first patch set stuff augmenting DT bindings and adding
>   regulators and a reset GPIO.
>
> - Split transport from core driver (separate I2C module)
>
> - Added SPI support (which I cannot test, grateful for any help,
>   but pretty sure it works).
>
> - Support for the BMP085 EOC interrupt mechanism rather than
>   waiting for the conversion to happen.
>
> - Do not re-read calibration data all the time, also toss the
>   calibration into the entropy pool.
>
> After this I think the misc driver can be replaced with this
> driver, but I'd love to hear from the maintainers of that driver
> if I've missed something. One of the patches adds all the authors
> of the misc driver listed there as I can clearly see code was
> copied into this driver at several points.
>
> The only thing missing from the misc driver is the sysfs
> interface. If there is real userspace out there using it, we
> can implement a compatibility sysfs ABI. But then I'd like
> to know what userspace it is, so I can test it.

Ok looks okay overall but you are dropping my BME280 part changes here
-> https://git.kernel.org/cgit/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=14beaa8f5ab11b881c5e822e2474f5278d0946d5

>
> Linus Walleij (9):
>   iio: pressure: bmp280: augment DT bindings
>   iio: pressure: bmp280: support device tree initialization
>   iio: pressure: bmp280: add reset GPIO line handling
>   iio: pressure: bmp280: support optional supply regulators
>   iio: pressure: bmp280: split driver in logical parts
>   iio: pressure: bmp280: split off an I2C Kconfig entry
>   iio: pressure: bmp280: add SPI interface driver
>   iio: pressure: bmp280: add support for the BMP058 EOC interrupt
>   iio: pressure: bmp280: read calibration data once
>
>  .../devicetree/bindings/iio/pressure/bmp085.txt    |  11 +-
>  drivers/iio/pressure/Kconfig                       |  27 +-
>  drivers/iio/pressure/Makefile                      |   3 +
>  drivers/iio/pressure/{bmp280.c => bmp280-core.c}   | 428 ++++++++-------------
>  drivers/iio/pressure/bmp280-i2c.c                  |  79 ++++
>  drivers/iio/pressure/bmp280-regmap.c               |  78 ++++
>  drivers/iio/pressure/bmp280-spi.c                  |  79 ++++
>  drivers/iio/pressure/bmp280.h                      |  86 +++++
>  8 files changed, 526 insertions(+), 265 deletions(-)
>  rename drivers/iio/pressure/{bmp280.c => bmp280-core.c} (70%)
>  create mode 100644 drivers/iio/pressure/bmp280-i2c.c
>  create mode 100644 drivers/iio/pressure/bmp280-regmap.c
>  create mode 100644 drivers/iio/pressure/bmp280-spi.c
>  create mode 100644 drivers/iio/pressure/bmp280.h
>
> --
> 2.4.11
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
