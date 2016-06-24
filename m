Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <4374A107-10EC-4E0C-988F-0BF10161DFFD@goldelico.com>
References: <1466628819-29784-1-git-send-email-linus.walleij@linaro.org>
 <1466628819-29784-6-git-send-email-linus.walleij@linaro.org> <4374A107-10EC-4E0C-988F-0BF10161DFFD@goldelico.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 24 Jun 2016 12:28:35 +0200
Message-ID: <CACRpkdYQpf=ZVHfOVUN_OUR-dvO7cW7Zzfk7Sni-kvtwKm4KJA@mail.gmail.com>
Subject: Re: [PATCH 5/9 v2] iio: pressure: bmp280: split driver in logical parts
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Akinobu Mita <akinobu.mita@gmail.com>,
	Matt Ranostay <mranostay@gmail.com>, Christoph Mair <christoph.mair@gmail.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>, Hartmut Knaack <knaack.h@gmx.de>,
	Marek Belisko <marek@goldelico.com>, Eric Andersson <eric.andersson@unixphere.com>,
	Neil Brown <neilb@suse.de>,
	Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Thu, Jun 23, 2016 at 10:18 AM, H. Nikolaus Schaller
<hns@goldelico.com> wrote:
>> Am 22.06.2016 um 22:53 schrieb Linus Walleij <linus.walleij@linaro.org>:

>> # When adding new entries keep the list in alphabetical order
>> obj-$(CONFIG_BMP280) += bmp280.o
>> +bmp280-objs := bmp280-core.o bmp280-regmap.o bmp280-i2c.o
>
> With menuconfig setting to 'M'
>
> CONFIG_BMP280=m
> CONFIG_BMP280_I2C=m
> CONFIG_BMP280_SPI=m
>
> I get
>
> ERROR: "bmp280_regmap_config" [drivers/iio/pressure/bmp280-spi.ko] undefined!
> ERROR: "bmp180_regmap_config" [drivers/iio/pressure/bmp280-spi.ko] undefined!
> ERROR: "bmp280_common_probe" [drivers/iio/pressure/bmp280-spi.ko] undefined!
> ERROR: "bmp280_regmap_config" [drivers/iio/pressure/bmp280-i2c.ko] undefined!
> ERROR: "bmp180_regmap_config" [drivers/iio/pressure/bmp280-i2c.ko] undefined!
> ERROR: "bmp280_common_probe" [drivers/iio/pressure/bmp280-i2c.ko] undefined!

Yeah module deps is one of my weak spots :(
The build robot found it too.

Fixing in v3. Thanks!

Yours,
Linus Walleij
