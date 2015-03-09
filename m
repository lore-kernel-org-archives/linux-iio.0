Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <7968545.0Cq9DcaG85@wuerfel>
References: <7968545.0Cq9DcaG85@wuerfel>
Date: Mon, 9 Mar 2015 11:27:59 +0100
Message-ID: <CAMuHMdU9x_OUReNMdZx+urZE3FDx2qz1m6gDRVp8qJ0r_QF5tA@mail.gmail.com>
Subject: Re: [PATCH] iio: ak8975: fix AK09911 dependencies
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Gwendal Grignou <gwendal@chromium.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Meerwald <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi Arnd,

On Wed, Jan 28, 2015 at 2:58 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> ak8975 depends on I2C and GPIOLIB, so any symbols that selects
> ak8975 must have the same dependency, or we get build errors:
>
> drivers/iio/magnetometer/ak8975.c: In function 'ak8975_who_i_am':
> drivers/iio/magnetometer/ak8975.c:393:2: error: implicit declaration of function 'i2c_smbus_read_i2c_block_data' [-Werror=implicit-function-declaration]
>   ret = i2c_smbus_read_i2c_block_data(client, AK09912_REG_WIA1,
>   ^
> drivers/iio/magnetometer/ak8975.c: In function 'ak8975_set_mode':
> drivers/iio/magnetometer/ak8975.c:431:2: error: implicit declaration of function 'i2c_smbus_write_byte_data' [-Werror=implicit-function-declaration]
>   ret = i2c_smbus_write_byte_data(data->client,
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 57e73a423b1e85 ("iio: ak8975: add ak09911 and ak09912 support")
> ---
> I found this recent regression doing ARM randconfig builds, please apply
>
> diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
> index 4c7a4c52dd06..a5d6de72c523 100644
> --- a/drivers/iio/magnetometer/Kconfig
> +++ b/drivers/iio/magnetometer/Kconfig
> @@ -18,6 +18,8 @@ config AK8975
>
>  config AK09911
>         tristate "Asahi Kasei AK09911 3-axis Compass"
> +       depends on I2C
> +       depends on GPIOLIB
>         select AK8975
>         help
>           Deprecated: AK09911 is now supported by AK8975 driver.

I just saw the AK8975/AK09911 config options disappear for a v4.0-rc3 m68k
allmodconfig kernel. Apparently it built fine with !GPIOLIB before, as many
gpiolib (consumer) functions have dummies for the !GPIOLIB case.

So I think the GPIOLIB dependency can be relaxed to "GPIOLIB || COMPILE_TEST".
The same may be true for many other GPIOLIB consumer drivers.
Will look into it and send patches...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
