Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33886 "EHLO
	mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbcFYK1k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 25 Jun 2016 06:27:40 -0400
Received: by mail-qk0-f196.google.com with SMTP id j2so24196590qkf.1
        for <linux-iio@vger.kernel.org>; Sat, 25 Jun 2016 03:27:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACRpkdZa94NwVZLPsSohrcQbYFMLPM8ZAuiHCQ=a5L8m3W-92Q@mail.gmail.com>
References: <1466361242-2994-1-git-send-email-linus.walleij@linaro.org>
 <1466361242-2994-8-git-send-email-linus.walleij@linaro.org>
 <CAC5umyijkFtggSdSLyNzs8YZtk7g4qyFXfcu2W2uVAJ8u-x10g@mail.gmail.com> <CACRpkdZa94NwVZLPsSohrcQbYFMLPM8ZAuiHCQ=a5L8m3W-92Q@mail.gmail.com>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Sat, 25 Jun 2016 19:27:20 +0900
Message-ID: <CAC5umyh7+JNO+xJOK0SLSeYS2CVhpTRmGgQuR4g2XBBTo2YW=g@mail.gmail.com>
Subject: Re: [PATCH 7/9] iio: pressure: bmp280: add SPI interface driver
To: Linus Walleij <linus.walleij@linaro.org>
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

2016-06-23 4:04 GMT+09:00 Linus Walleij <linus.walleij@linaro.org>:
> On Mon, Jun 20, 2016 at 1:06 PM, Akinobu Mita <akinobu.mita@gmail.com> wrote:
>
>> I was also trying to support SPI interface for this driver and found
>> that we can't simply use regmap_init_spi().
>>
>> Quote from 5.3 SPI interface in BMP280 datasheet:
>>
>>         In SPI mode, only 7 bits of the register addresses are used; the MSB of
>>         register address is not used and replaced by a read/write bit (RW = ‘0’
>>         for write and RW = ‘1’ for read).  Example: address 0xF7 is accessed by
>>         using SPI register address 0x77. For write access, the byte 0x77 is
>>         transferred, for read access, the byte 0xF7 is transferred.
>>
>> The write operation used by regmap_init_spi() doesn't replace the RW bit.
>> So we need custom regmap_bus like below.
>
> Aha! OK I added your bus implementation and will add your Signed-off to
> the patch as well, OK?

OK

> It would be great if you could also test the result.

I've tested v2 patches with fixing undefined symbols error, missing
NULL entry in of_device_id, and missing MODULE_LICENSE in bmp280.ko.

The SPI interface for BMP280 works fine as well as I2C interface.

Tested-by: Akinobu Mita <akinobu.mita@gmail.com>
