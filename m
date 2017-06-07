Return-Path: <SRS0=iTw/=5M=gmail.com=coproscefalo@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170529155154.22580-38-jic23@kernel.org>
References: <20170529155154.22580-1-jic23@kernel.org> <20170529155154.22580-38-jic23@kernel.org>
From: Azael Avalos <coproscefalo@gmail.com>
Date: Wed, 7 Jun 2017 08:53:09 -0600
Message-ID: <CAGdLNWGf4+5zJUe2dREadjs92Vg_SHbANjG1kz6f4JsTGL-TPQ@mail.gmail.com>
Subject: Re: [PATCH 37/38] platform/x86: toshiba_acpi: drop assignment of iio_info.driver_module
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

Sorry for being this late, been a bit busy.

2017-05-29 9:51 GMT-06:00 Jonathan Cameron <jic23@kernel.org>:
> This is now handled by use of a macro for device registration.  The field
> in iio_info will be going away shortly as it is no longer used.
>
> Cc: Azael Avalos <coproscefalo@gmail.com>
> Cc: <platform-driver-x86@vger.kernel.org>

Acked-by: Azael Avalos <coproscefalo@gmail.com>

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
-- El mundo apesta y vosotros apestais tambien --
