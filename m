Return-Path: <akinobu.mita@gmail.com>
MIME-Version: 1.0
In-Reply-To: <570A39CB.9060901@kernel.org>
References: <1460044621-17274-1-git-send-email-akinobu.mita@gmail.com>
	<570A39CB.9060901@kernel.org>
Date: Mon, 11 Apr 2016 09:33:14 +0900
Message-ID: <CAC5umyikBxs_WLrBEj1K_G5cTVs+6dHHXWKPLo86_zh=KvJFmQ@mail.gmail.com>
Subject: Re: [PATCH] iio: pressure: bmp280: add support for BMP180
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Vlad Dogaru <vlad.dogaru@intel.com>,
	Christoph Mair <christoph.mair@gmail.com>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

2016-04-10 20:32 GMT+09:00 Jonathan Cameron <jic23@kernel.org>:
> On 07/04/16 16:57, Akinobu Mita wrote:
>> This adds support for the BMP180 to the bmp280 iio driver.
>> The BMP180 has already been supported by misc/bmp085 driver but it
>> doesn't use iio framework.
>>
>> This also adds ability to control the oversampling ratio of the
>> temperature and pressure measurement for both bmp180 and bmp280.
>> (bmp280 is untested)
>>
>> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
>> Cc: Vlad Dogaru <vlad.dogaru@intel.com>
>> Cc: Christoph Mair <christoph.mair@gmail.com>
>> Cc: Jonathan Cameron <jic23@kernel.org>
>> Cc: Hartmut Knaack <knaack.h@gmx.de>
>> Cc: Lars-Peter Clausen <lars@metafoo.de>
>> Cc: Peter Meerwald <pmeerw@pmeerw.net>
> I absolutely agree that this should be two patches, one for the device
> support and one for the oversampling support.

OK.

> A few suggestions on how to simplify the code inline.
>
> Also, we need to be careful in Kconfig whilst we have two drivers supporting
> the chip.  They probably need to depend on the other one not being selected
> to avoid any issues.

OK.  I'll add the following dependency for CONFIG_BMP280

+       depends on !(BMP085_I2C=y || BMP085_I2C=m)

>> @@ -72,6 +104,15 @@ struct bmp280_data {
>>       struct i2c_client *client;
>>       struct mutex lock;
>>       struct regmap *regmap;
>> +     const struct bmp280_ops *ops;
> I'd define this slightly differently as say
> const struct bmp280_chip_info  and include all the ops as well as the
> various other elements in here that you set depending on which chip it is.
>
> The big assignment in probe should be done in one line rather than 10ish.

OK.  Make a lot of sense.

>> @@ -390,13 +906,15 @@ static int bmp280_probe(struct i2c_client *client,
>>  }
>>
>>  static const struct acpi_device_id bmp280_acpi_match[] = {
>> -     {"BMP0280", 0},
>> +     {"BMP0280", BMP280_CHIP_ID },
> Why not provide ACPI id's for the other devices?

Can I just add "BMP0180" for bmp180 support?
I thought that assigning ACPI id requires someone's agreement.
