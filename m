Return-Path: <SRS0=EVNj=76=gmail.com=lorenzo.bianconi83@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170817173729.10899-1-lorenzo.bianconi@st.com>
References: <20170817173729.10899-1-lorenzo.bianconi@st.com>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Date: Mon, 28 Aug 2017 15:41:52 +0200
Message-ID: <CAA2SeNJZr5RN-ouLqHQgiU2tAtqc2thNiPsBu7=pvgnJJYakSA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Add support to LIS2DW12 accel sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
	Lorenzo BIANCONI <lorenzo.bianconi@st.com>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

> Modify management of drdy line and status register in order to support
> LIS2DW12 device
>
> Changes since v1:
> - remove drdy_irq parameter from LPS001WP settings since the sensor
> does not support data-ready interrupts
>
> Lorenzo Bianconi (5):
>   iio: st_sensors: decouple irq1 configuration parameters from the irq2
>     ones
>   iio: st_sensors: do not always write enable_axis register
>   iio: st_sensors: add register mask for status register
>   iio: accel: add support to LIS2DW12
>   dt-bindings: iio: accel: add LIS2DW12 sensor device binding
>
>  .../devicetree/bindings/iio/st-sensors.txt         |   1 +
>  drivers/iio/accel/st_accel.h                       |   2 +
>  drivers/iio/accel/st_accel_core.c                  | 180 +++++++++++++++++----
>  drivers/iio/accel/st_accel_i2c.c                   |   5 +
>  drivers/iio/accel/st_accel_spi.c                   |   5 +
>  drivers/iio/common/st_sensors/st_sensors_core.c    |  33 ++--
>  drivers/iio/common/st_sensors/st_sensors_trigger.c |  16 +-
>  drivers/iio/gyro/st_gyro_core.c                    |  33 ++--
>  drivers/iio/magnetometer/st_magn_core.c            |  11 +-
>  drivers/iio/pressure/st_pressure_core.c            |  46 ++++--
>  include/linux/iio/common/st_sensors.h              |  23 ++-
>  11 files changed, 265 insertions(+), 90 deletions(-)
>
> --
> 2.14.0
>

Hi Jonathan,

please ignore v2 series, I will send a v3 based on an irq fix for
LIS3MDL magn sensor.
Have a nice vacation :)
Thanks,

Regards,
Lorenzo

-- 
UNIX is Sexy: who | grep -i blonde | talk; cd ~; wine; talk; touch;
unzip; touch; strip; gasp; finger; gasp; mount; fsck; more; yes; gasp;
umount; make clean; sleep
