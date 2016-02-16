Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <1455634525-2023774-1-git-send-email-arnd@arndb.de>
References: <1455634525-2023774-1-git-send-email-arnd@arndb.de>
Date: Tue, 16 Feb 2016 20:03:29 +0200
Message-ID: <CAEnQRZBk0R-A5VEEd_D+kLKnyhc3nhrm0tv2JOkv0iqywGFtuw@mail.gmail.com>
Subject: Re: [PATCH] iio: pressure: ms5611: select IIO_BUFFER
From: Daniel Baluta <daniel.baluta@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, Feb 16, 2016 at 4:55 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> The ms5611 driver started using the IIO_TRIGGERED_BUFFER infrastructure
> which in turn depend on IIO_BUFFER, and it produces a build error now
> if that is not enabled:
>
> warning: (... && MS5611 && ...) selects IIO_TRIGGERED_BUFFER which has unmet direct dependencies (IIO && IIO_BUFFER)
> buffer/industrialio-triggered-buffer.c: In function 'iio_triggered_buffer_setup':
> buffer/industrialio-triggered-buffer.c:58:2: error: implicit declaration of function 'iio_device_attach_buffer' [-Werror=implicit-function-declaration]
> pressure/ms5611_core.c: In function 'ms5611_trigger_handler':
> pressure/ms5611_core.c:193:2: error: implicit declaration of function 'iio_push_to_buffers_with_timestamp' [-Werror=implicit-function-declaration]
>
> This adds the second select.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 713bbb4efb9d ("iio: pressure: ms5611: Add triggered buffer support")

Acked-by: Daniel Baluta <daniel.baluta@intel.com>

> ---
>  drivers/iio/pressure/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
> index f15f66d6f527..31c0e1fd2202 100644
> --- a/drivers/iio/pressure/Kconfig
> +++ b/drivers/iio/pressure/Kconfig
> @@ -69,6 +69,7 @@ config MPL3115
>
>  config MS5611
>         tristate "Measurement Specialties MS5611 pressure sensor driver"
> +       select IIO_BUFFER
>         select IIO_TRIGGERED_BUFFER
>         help
>           Say Y here to build support for the Measurement Specialties
> --
> 2.7.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
