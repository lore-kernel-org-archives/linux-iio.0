Return-Path: <manabian@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1445281210-3936-1-git-send-email-manabian@gmail.com>
References: <1445120719-29685-1-git-send-email-manabian@gmail.com>
	<1445281210-3936-1-git-send-email-manabian@gmail.com>
Date: Mon, 19 Oct 2015 23:07:26 +0200
Message-ID: <CAGhQ9Vz6O-SK15U6vng1Zv=gKiY4mSu-RenyYrpQN67YEEP0sA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: accel: add Freescale MMA7455L/MMA7456L 3-axis
 accelerometer driver
From: Joachim  Eastwood <manabian@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	Peter Meerwald <pmeerw@pmeerw.net>
Cc: Joachim Eastwood <manabian@gmail.com>, martink@posteo.de, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On 19 October 2015 at 21:00, Joachim Eastwood <manabian@gmail.com> wrote:
> Add support for Freescale MMA7455L/MMA7456L 3-axis in 10-bit mode for
> I2C and SPI bus. This rather simple driver that currently doesn't
> support all the hardware features of MMA7455L/MMA7456L.
>
> Tested on Embedded Artist's LPC4357 Dev Kit with MMA7455L on I2C bus.
>
> Data sheets for the two devices can be found here:
> http://cache.freescale.com/files/sensors/doc/data_sheet/MMA7455L.pdf
> http://cache.freescale.com/files/sensors/doc/data_sheet/MMA7456L.pdf
>
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> ---
> Hi,
>
> This version address the comments from Lars-Peter Clausen, Peter
> Meerwald and Martin Kepplinger. Thanks for all the constructive
> feedback!
>
> Changes since v1:
> * limit retries to 3 in mma7455_drdy
> * remove mma7455_show_scale_avail
> * use chan->address instead of chan->scan_index for reg addr
> * check that val2 is 0 when setting sample freq
> * use __le16 to hint about endianess in mma7455_trigger_handler
> * fix endianess in mma7455_read_raw function
> * add mma7456 id
> * split it into several source files to support both i2c and spi
>
> I compared the register summary for MMA7455L/MMA7456L and I am
> unable to find any difference at all.
>
>  drivers/iio/accel/Kconfig        |  22 +++
>  drivers/iio/accel/Makefile       |   5 +
>  drivers/iio/accel/mma7455.h      |  20 +++
>  drivers/iio/accel/mma7455_core.c | 321 +++++++++++++++++++++++++++++++++++++++
>  drivers/iio/accel/mma7455_i2c.c  |  57 +++++++
>  drivers/iio/accel/mma7455_spi.c  |  53 +++++++
>  6 files changed, 478 insertions(+)
>  create mode 100644 drivers/iio/accel/mma7455.h
>  create mode 100644 drivers/iio/accel/mma7455_core.c
>  create mode 100644 drivers/iio/accel/mma7455_i2c.c
>  create mode 100644 drivers/iio/accel/mma7455_spi.c

> +static const struct i2c_device_id mma7455_i2c_ids[] = {
> +       { "mma7455", 0 },
> +       { "mma7456", 0 },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(i2c, mma7455_i2c_id);

> +static const struct spi_device_id mma7455_spi_ids[] = {
> +       { "mma7455", 0 },
> +       { "mma7456", 0 },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(spi, mma7455_spi_id);

Seems like I forgot to do a modular and the kbuild bot caught me.
Renamed to *_ids, but forgot to update variable in MODULE_DEVICE_TABLE macro...

I'll send out a new version after people have had a chance to comment
on any other issues.


regards,
Joachim Eastwood
