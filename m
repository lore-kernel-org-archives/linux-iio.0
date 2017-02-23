Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:35839 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751119AbdBWRhB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Feb 2017 12:37:01 -0500
Subject: Re: [PATCH v3 4/4] iio: accel: adxl345: Add SPI support
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Eva Rachel Retuya <eraretuya@gmail.com>
References: <cover.1487757223.git.eraretuya@gmail.com>
 <515297e48abd139993cab56dbf980711400d6534.1487757223.git.eraretuya@gmail.com>
 <CAHp75VdmB1YqY4YyntbvHUaK_9yjY8wFeX6i9hmMDaScajKNOw@mail.gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Alison Schofield <amsfield22@gmail.com>,
        Florian Vaussard <florian.vaussard@heig-vd.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <cb64adc9-f468-11f8-4a8a-fd3f5779fee0@metafoo.de>
Date: Thu, 23 Feb 2017 17:47:59 +0100
MIME-Version: 1.0
In-Reply-To: <CAHp75VdmB1YqY4YyntbvHUaK_9yjY8wFeX6i9hmMDaScajKNOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/23/2017 05:43 PM, Andy Shevchenko wrote:
> On Wed, Feb 22, 2017 at 12:23 PM, Eva Rachel Retuya <eraretuya@gmail.com> wrote:
>> Add SPI driver that initializes SPI regmap for the adxl345 core driver.
>> The driver supports the same functionality as I2C namely the x, y, z and
>> scale readings.
> 
>> --- a/drivers/iio/accel/Kconfig
>> +++ b/drivers/iio/accel/Kconfig
>> @@ -8,20 +8,26 @@ menu "Accelerometers"
>>  config ADXL345
>>         tristate "Analog Devices ADXL345 3-Axis Digital Accelerometer Driver"
>>         depends on !(INPUT_ADXL34X=y || INPUT_ADXL34X=m)
>> +       depends on (I2C || SPI)
>>         select REGMAP
>>         select ADXL345_I2C if I2C
>> +       select ADXL345_SPI if SPI
>>         help
>>           Say Y here if you want to build support for the Analog Devices
>>           ADXL345 3-axis digital accelerometer.
>>
>>           To compile this driver as a module, choose M here: the core
>>           module will be called adxl345_core and you will also get
>> -         adxl345_i2c for I2C.
>> +         adxl345_i2c for I2C and/or adxl345_spi for SPI.
>>
>>  config ADXL345_I2C
>>         tristate
>>         select REGMAP_I2C
>>
>> +config ADXL345_SPI
>> +       tristate
>> +       select REGMAP_SPI
> 
> Hmm...
> I saw another pattern
> 
> Library / core part is non-visible to user, while
> SPI and I2C parts are selectable by user.
> 
> Why do you use inverted pattern? What did I miss?

The first version of the patch used the other pattern SPI/I2C visible.
Jonathan suggested this other pattern. I prefer the explicit SPI/I2C visible
pattern, but in the end it doesn't really matter as long as both work.

