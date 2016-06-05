Return-Path: <mranostay@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1464958312-2720-3-git-send-email-martink@posteo.de>
References: <1464958312-2720-1-git-send-email-martink@posteo.de> <1464958312-2720-3-git-send-email-martink@posteo.de>
From: Matt Ranostay <mranostay@gmail.com>
Date: Sun, 5 Jun 2016 14:22:36 -0700
Message-ID: <CAKzfze9hV+wNY_ryc3h3q3DfVXC8K2EE2d8qqWU-15HKu9znyQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: mma8452: update Freescale company information
To: Martin Kepplinger <martink@posteo.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

At this rate of acquisitions we may need a .mailmap for companies :)

On Fri, Jun 3, 2016 at 5:51 AM, Martin Kepplinger <martink@posteo.de> wrote:
> NXP took over Freescale, so add NXP to the driver descriptions
>
> Signed-off-by: Martin Kepplinger <martink@posteo.de>
> ---
>  drivers/iio/accel/Kconfig   | 4 ++--
>  drivers/iio/accel/mma8452.c | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 3132587..89d7820 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -157,12 +157,12 @@ config MMA7660
>           will be called mma7660.
>
>  config MMA8452
> -       tristate "Freescale MMA8452Q and similar Accelerometers Driver"
> +       tristate "Freescale / NXP MMA8452Q and similar Accelerometers Driver"
>         depends on I2C
>         select IIO_BUFFER
>         select IIO_TRIGGERED_BUFFER
>         help
> -         Say yes here to build support for the following Freescale 3-axis
> +         Say yes here to build support for the following Freescale / NXP 3-axis
>           accelerometers: MMA8451Q, MMA8452Q, MMA8453Q, MMA8652FC, MMA8653FC,
>           FXLS8471Q.
>
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 4be2a18..799fe64 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -1,5 +1,5 @@
>  /*
> - * mma8452.c - Support for following Freescale 3-axis accelerometers:
> + * mma8452.c - Support for following Freescale / NXP 3-axis accelerometers:
>   *
>   * device name digital output  7-bit I2C slave address (pin selectable)
>   * ---------------------------------------------------------------------
> @@ -108,7 +108,7 @@ struct mma8452_data {
>  };
>
>  /**
> - * struct mma_chip_info - chip specific data for Freescale's accelerometers
> + * struct mma_chip_info - chip specific data
>   * @chip_id:                   WHO_AM_I register's value
>   * @channels:                  struct iio_chan_spec matching the device's
>   *                             capabilities
> @@ -1693,5 +1693,5 @@ static struct i2c_driver mma8452_driver = {
>  module_i2c_driver(mma8452_driver);
>
>  MODULE_AUTHOR("Peter Meerwald <pmeerw@pmeerw.net>");
> -MODULE_DESCRIPTION("Freescale MMA8452 accelerometer driver");
> +MODULE_DESCRIPTION("Freescale / NXP MMA8452 accelerometer driver");
>  MODULE_LICENSE("GPL");
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
