Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:36349 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753781AbcKHPki (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Nov 2016 10:40:38 -0500
Received: by mail-qk0-f172.google.com with SMTP id n21so110265801qka.3
        for <linux-iio@vger.kernel.org>; Tue, 08 Nov 2016 07:40:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161108135945.2217384-2-arnd@arndb.de>
References: <20161108135945.2217384-1-arnd@arndb.de> <20161108135945.2217384-2-arnd@arndb.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 8 Nov 2016 16:40:37 +0100
Message-ID: <CACRpkdY2aMcv_Sko7PQGn3DE1nm=osypGcR5bWUx69CzUj-o1Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: gyro: mpu3050: add I2C dependency
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Nov 8, 2016 at 2:59 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The new mpu3050 driver fails to build if I2C is disabled:
>
> drivers/iio/built-in.o: In function `mpu3050_i2c_driver_exit':
> mpu3050-i2c.c:(.exit.text+0x17f): undefined reference to `i2c_del_driver'
> drivers/iio/built-in.o: In function `mpu3050_i2c_driver_init':
> mpu3050-i2c.c:(.init.text+0x215): undefined reference to `i2c_register_driver'
>
> This adds a Kconfig dependency to ensure we only build it when I2C
> is available.
>
> Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
