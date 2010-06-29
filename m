Return-Path: <21cnbao@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1277485024-10726-2-git-send-email-jic23@cam.ac.uk>
References: <1277485024-10726-1-git-send-email-jic23@cam.ac.uk>
	<1277485024-10726-2-git-send-email-jic23@cam.ac.uk>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 29 Jun 2010 13:59:52 +0800
Message-ID: <AANLkTikU09E95r3FNcXWl0hArzKb5emuk256b9-ljzpO@mail.gmail.com>
Subject: Re: [PATCH 1/2] staging:iio:imu allow adis16300 and adis16400 to
	build without ring buffer support.
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Barry.Song@analog.com
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sat, Jun 26, 2010 at 12:57 AM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Barry Song <21cnbao@gmail.com>
> ---
> =C2=A0drivers/staging/iio/imu/Kconfig | =C2=A0 10 ++++------
> =C2=A01 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/staging/iio/imu/Kconfig b/drivers/staging/iio/imu/Kc=
onfig
> index 48a712e..31a6233 100644
> --- a/drivers/staging/iio/imu/Kconfig
> +++ b/drivers/staging/iio/imu/Kconfig
> @@ -6,9 +6,8 @@ comment "Inertial measurement units"
> =C2=A0config ADIS16300
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tristate "Analog Devices ADIS16300 IMU SPI dri=
ver"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on SPI
> - =C2=A0 =C2=A0 =C2=A0 select IIO_SW_RING
> - =C2=A0 =C2=A0 =C2=A0 select IIO_RING_BUFFER
> - =C2=A0 =C2=A0 =C2=A0 select IIO_TRIGGER
> + =C2=A0 =C2=A0 =C2=A0 select IIO_SW_RING if IIO_RING_BUFFER
> + =C2=A0 =C2=A0 =C2=A0 select IIO_TRIGGER if IIO_RING_BUFFER
> =C2=A0 =C2=A0 =C2=A0 =C2=A0help
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Say yes here to build support for Analo=
g Devices adis16300 four degrees
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0of freedom inertial sensor.
> @@ -25,9 +24,8 @@ config ADIS16350
> =C2=A0config ADIS16400
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tristate "Analog Devices ADIS16400/5 IMU SPI d=
river"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on SPI
> - =C2=A0 =C2=A0 =C2=A0 select IIO_SW_RING
> - =C2=A0 =C2=A0 =C2=A0 select IIO_RING_BUFFER
> - =C2=A0 =C2=A0 =C2=A0 select IIO_TRIGGER
> + =C2=A0 =C2=A0 =C2=A0 select IIO_SW_RING if IIO_RING_BUFFER
> + =C2=A0 =C2=A0 =C2=A0 select IIO_TRIGGER if IIO_RING_BUFFER
> =C2=A0 =C2=A0 =C2=A0 =C2=A0help
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Say yes here to build support for Analo=
g Devices adis16400/5 triaxial
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0inertial sensor with Magnetometer.
> --
> 1.6.4.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
>
