Return-Path: <SRS0=Ufxp=5D=gmail.com=andy.shevchenko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170529155154.22580-38-jic23@kernel.org>
References: <20170529155154.22580-1-jic23@kernel.org> <20170529155154.22580-38-jic23@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 29 May 2017 20:56:20 +0300
Message-ID: <CAHp75VfwHXLHBv1E59W7PLCuh1fA8CZhFEmHnqY7uqvCZrTiKw@mail.gmail.com>
Subject: Re: [PATCH 37/38] platform/x86: toshiba_acpi: drop assignment of iio_info.driver_module
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Azael Avalos <coproscefalo@gmail.com>,
	Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Mon, May 29, 2017 at 6:51 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> This is now handled by use of a macro for device registration.  The field
> in iio_info will be going away shortly as it is no longer used.
>
> Cc: Azael Avalos <coproscefalo@gmail.com>
> Cc: <platform-driver-x86@vger.kernel.org>

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/platform/x86/toshiba_acpi.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
> index d0daf75cbed1..ef4301f41727 100644
> --- a/drivers/platform/x86/toshiba_acpi.c
> +++ b/drivers/platform/x86/toshiba_acpi.c
> @@ -2515,7 +2515,6 @@ static const struct iio_chan_spec toshiba_iio_accel_channels[] = {
>  };
>
>  static const struct iio_info toshiba_iio_accel_info = {
> -       .driver_module = THIS_MODULE,
>         .read_raw = &toshiba_iio_accel_read_raw,
>  };
>
> --
> 2.13.0
>



-- 
With Best Regards,
Andy Shevchenko
