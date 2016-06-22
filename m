Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:36836 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333AbcFVTEm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jun 2016 15:04:42 -0400
Received: by mail-oi0-f42.google.com with SMTP id f189so36499192oig.3
        for <linux-iio@vger.kernel.org>; Wed, 22 Jun 2016 12:04:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAC5umyijkFtggSdSLyNzs8YZtk7g4qyFXfcu2W2uVAJ8u-x10g@mail.gmail.com>
References: <1466361242-2994-1-git-send-email-linus.walleij@linaro.org>
 <1466361242-2994-8-git-send-email-linus.walleij@linaro.org> <CAC5umyijkFtggSdSLyNzs8YZtk7g4qyFXfcu2W2uVAJ8u-x10g@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 22 Jun 2016 21:04:41 +0200
Message-ID: <CACRpkdZa94NwVZLPsSohrcQbYFMLPM8ZAuiHCQ=a5L8m3W-92Q@mail.gmail.com>
Subject: Re: [PATCH 7/9] iio: pressure: bmp280: add SPI interface driver
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
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

On Mon, Jun 20, 2016 at 1:06 PM, Akinobu Mita <akinobu.mita@gmail.com> wrote:

> I was also trying to support SPI interface for this driver and found
> that we can't simply use regmap_init_spi().
>
> Quote from 5.3 SPI interface in BMP280 datasheet:
>
>         In SPI mode, only 7 bits of the register addresses are used; the MSB of
>         register address is not used and replaced by a read/write bit (RW = ‘0’
>         for write and RW = ‘1’ for read).  Example: address 0xF7 is accessed by
>         using SPI register address 0x77. For write access, the byte 0x77 is
>         transferred, for read access, the byte 0xF7 is transferred.
>
> The write operation used by regmap_init_spi() doesn't replace the RW bit.
> So we need custom regmap_bus like below.

Aha! OK I added your bus implementation and will add your Signed-off to
the patch as well, OK?

It would be great if you could also test the result.

Yours,
Linus Walleij
