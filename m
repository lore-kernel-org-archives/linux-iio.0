Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20161108135945.2217384-1-arnd@arndb.de>
References: <20161108135945.2217384-1-arnd@arndb.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 8 Nov 2016 16:39:57 +0100
Message-ID: <CACRpkdaZhdF5UbUp8L4aVuJmeQd2nD0+rLHXjTtJZ64d_S1hFw@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: gyro: mpu3050: remove duplicate initializer
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, Nov 8, 2016 at 2:59 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The newly added mpu3050 driver has two initializations for the
> module owner, which causes a warning for 'make W=1':
>
> include/linux/export.h:37:21: error: initialized field overwritten [-Werror=override-init]
> drivers/iio/gyro/mpu3050-core.c:749:19: note: in expansion of macro 'THIS_MODULE'
>
> This removes one of the two.
>
> Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
