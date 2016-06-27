Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:33401 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbcF0L30 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jun 2016 07:29:26 -0400
Received: by mail-oi0-f43.google.com with SMTP id u201so195985993oie.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Jun 2016 04:29:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e330827a-7178-9e7e-fc28-3eb5b32f20d4@kernel.org>
References: <1466628819-29784-1-git-send-email-linus.walleij@linaro.org>
 <1466628819-29784-6-git-send-email-linus.walleij@linaro.org> <e330827a-7178-9e7e-fc28-3eb5b32f20d4@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 Jun 2016 13:29:24 +0200
Message-ID: <CACRpkdadfVGawXB_LfcnjL32k8KAVFOZtvgaxuGNxW89ssNyQg@mail.gmail.com>
Subject: Re: [PATCH 5/9 v2] iio: pressure: bmp280: split driver in logical parts
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Akinobu Mita <akinobu.mita@gmail.com>,
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

On Sun, Jun 26, 2016 at 12:04 PM, Jonathan Cameron <jic23@kernel.org> wrote:

> On 22/06/16 21:53, Linus Walleij wrote:
>> This splits the BMP280 driver in three logical parts: the core driver
>> bmp280-core that only operated on a struct device * and a struct regmap *,
>> the regmap driver bmp280-regmap that can be shared between I2C and other
>> transports and the I2C module driver bmp280-i2c.
>>
>> Cleverly bake all functionality into a single object bmp280.o so that
>> we still get the same module binary built for the device in the end,
>> without any fuzz exporting symbols to the left and right.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> Few trivial bits inline.
>
> Main thought here is why not roll the regmap bit into the core?  It's hardly
> a huge addition and that would allow you to also pull all of the header
> register defines etc into there..

It's a bit of a matter of taste: the I2C portion needs to call
devm_regmap_init_i2c() supplying the regmap config, so it needs
access to the regmap config. I can either just keep that in the main
file and export the symbol or split it off in a separate file and share
the symbol from there.

With the addition of SPI it becomes hairer: Akinobu noted that the
default SPI regmap cannot be used so SPI support needs a more
complex regmap setup, modifying the configs & such. Then it seems
more natural to split it into a separate file.

But it's your pick, I'm happy to take it either way.

>> +/*
>> + * Returns humidity in percent, resolution is 0.01 percent. Output value of
>> + * "47445" represents 47445/1024 = 46.333 %RH.
>> + *
>> + * Taken from BME280 datasheet, Section 4.2.3, "Compensation formula".
>> + */
>> +
> Guessing this is from the original cut and paste, but it's inconsistent
> to have a blank line here!

Hm I think the big issue is me forgetting to pass -M to to
git format-patch so you have to see all the code already in the
tree again. (I can make a separate patch for this issue if you
like, here I worry that it'd just be confusing.)

>> +#ifdef CONFIG_OF
>> +static const struct of_device_id bmp280_of_i2c_match[] = {
>> +     { .compatible = "bosch,bme280", .data = (void *)BME280_CHIP_ID },
>> +     { .compatible = "bosch,bmp280", .data = (void *)BMP280_CHIP_ID },
>> +     { .compatible = "bosch,bmp180", .data = (void *)BMP180_CHIP_ID },
>> +     { .compatible = "bosch,bmp085", .data = (void *)BMP180_CHIP_ID },
>
> Fairly obvious, but carry through the empty field from the issue in the
> earlier patch...

Yep fixed in my tree.

Yours,
Linus Walleij
