Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41896 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754273AbcKHU36 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Nov 2016 15:29:58 -0500
Subject: Re: [PATCH 2/2] iio: gyro: mpu3050: add I2C dependency
To: Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
References: <20161108135945.2217384-1-arnd@arndb.de>
 <20161108135945.2217384-2-arnd@arndb.de>
 <CACRpkdY2aMcv_Sko7PQGn3DE1nm=osypGcR5bWUx69CzUj-o1Q@mail.gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <351f0000-eeb4-32cf-db81-f5c88b27da19@kernel.org>
Date: Tue, 8 Nov 2016 20:29:55 +0000
MIME-Version: 1.0
In-Reply-To: <CACRpkdY2aMcv_Sko7PQGn3DE1nm=osypGcR5bWUx69CzUj-o1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/11/16 15:40, Linus Walleij wrote:
> On Tue, Nov 8, 2016 at 2:59 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
>> The new mpu3050 driver fails to build if I2C is disabled:
>>
>> drivers/iio/built-in.o: In function `mpu3050_i2c_driver_exit':
>> mpu3050-i2c.c:(.exit.text+0x17f): undefined reference to `i2c_del_driver'
>> drivers/iio/built-in.o: In function `mpu3050_i2c_driver_init':
>> mpu3050-i2c.c:(.init.text+0x215): undefined reference to `i2c_register_driver'
>>
>> This adds a Kconfig dependency to ensure we only build it when I2C
>> is available.
>>
>> Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
Applied.  Thanks.

Jonathan
> 
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

