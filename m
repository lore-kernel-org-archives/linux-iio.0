Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47456 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135Ab0EGDA3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 6 May 2010 23:00:29 -0400
Received: by gyg13 with SMTP id 13so399294gyg.19
        for <linux-iio@vger.kernel.org>; Thu, 06 May 2010 20:00:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1273153355-18179-2-git-send-email-jic23@cam.ac.uk>
References: <1273153355-18179-1-git-send-email-jic23@cam.ac.uk>
	<1273153355-18179-2-git-send-email-jic23@cam.ac.uk>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 7 May 2010 10:54:16 +0800
Message-ID: <v2t3c17e3571005061954ya1699967zb4f21eb0a339c90f@mail.gmail.com>
Subject: Re: [PATCH 2/2] staging:iio: adis16240 driver
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Barry Song <Barry.Song@analog.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, May 6, 2010 at 9:42 PM, Jonathan Cameron <jic23@cam.ac.uk> wrot=
e:
> From: Barry Song <Barry.Song@analog.com>
>
> Signed-off-by: Barry Song <Barry.Song@analog.com>
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>
> =C2=A0This one is new to the list. Barry informed me that they have c=
ompleted
> =C2=A0testing and hopefully I haven't broken anything. (Barry, please=
 confirm
> =C2=A0your sign off, I've put it above to make sure I don't forget it=
)
Thanks!

Signed-off-by: Barry Song <Barry.Song@analog.com>

>
> =C2=A0Changes I've made in merging this with mainline tree:
> =C2=A0* Usual renames to add _raw and get rid of volt etc.
> =C2=A0* Other changes:
> =C2=A0 * accel_xpeak -> accel_x_peak_raw
> =C2=A0 * accel_xyzpeak -> accel_xyz_squared_raw
> =C2=A0* I have taken a number of attribute definitions out of accel.h=
 and into
> =C2=A0 this driver as I am yet to be convinced that they are general =
enough.
> =C2=A0 They can move to there at a later date if we get them turning =
up in a
> =C2=A0 couple of drivers.
> =C2=A0* Checkpatch and sparse related fixes
>
> Clearly this is a very interesting chip and there are lots of interes=
ting
> features not currently supported by the driver. =C2=A0Still is a very=
 good base
> to build on.
>
> =C2=A0drivers/staging/iio/accel/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 =C2=A09 +
> =C2=A0drivers/staging/iio/accel/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| =C2=A0 =C2=A04 +
> =C2=A0drivers/staging/iio/accel/adis16240_core.c =C2=A0 =C2=A0| =C2=A0=
599 +++++++++++++++++++++++++
> =C2=A0drivers/staging/iio/accel/adis16240_ring.c =C2=A0 =C2=A0| =C2=A0=
254 +++++++++++
> =C2=A0drivers/staging/iio/accel/adis16240_trigger.c | =C2=A0124 +++++
> =C2=A05 files changed, 990 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/staging/iio/accel/Kconfig b/drivers/staging/iio/=
accel/Kconfig
> index 1d89e21..8f3f70f 100644
> --- a/drivers/staging/iio/accel/Kconfig
> +++ b/drivers/staging/iio/accel/Kconfig
> @@ -12,6 +12,15 @@ config ADIS16209
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Say yes here to build support for A=
nalog Devices adis16209 dual-axis digital inclinometer
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 and accelerometer.
>
> +config ADIS16240
> + =C2=A0 =C2=A0 =C2=A0 tristate "Analog Devices ADIS16240 Programmabl=
e Impact Sensor and Recorder"
> + =C2=A0 =C2=A0 =C2=A0 depends on SPI
> + =C2=A0 =C2=A0 =C2=A0 select IIO_TRIGGER if IIO_RING_BUFFER
> + =C2=A0 =C2=A0 =C2=A0 select IIO_SW_RING if IIO_RING_BUFFER
> + =C2=A0 =C2=A0 =C2=A0 help
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 Say yes here to build support for Analo=
g Devices adis16240 programmable
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0impact Sensor and recorder.
> +
> =C2=A0config KXSD9
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tristate "Kionix KXSD9 Accelerometer Drive=
r"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on SPI
> diff --git a/drivers/staging/iio/accel/Makefile b/drivers/staging/iio=
/accel/Makefile
> index f8f2124..0e6762c 100644
> --- a/drivers/staging/iio/accel/Makefile
> +++ b/drivers/staging/iio/accel/Makefile
> @@ -5,6 +5,10 @@ adis16209-y =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 :=3D adis16209_core.o
> =C2=A0adis16209-$(CONFIG_IIO_RING_BUFFER) +=3D adis16209_ring.o adis1=
6209_trigger.o
> =C2=A0obj-$(CONFIG_ADIS16209) +=3D adis16209.o
>
> +adis16240-y =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :=3D adis16240=
_core.o
> +adis16240-$(CONFIG_IIO_RING_BUFFER) +=3D adis16240_ring.o adis16240_=
trigger.o
> +obj-$(CONFIG_ADIS16240) +=3D adis16240.o
> +
> =C2=A0obj-$(CONFIG_KXSD9) =C2=A0 =C2=A0+=3D kxsd9.o
>
> =C2=A0lis3l02dq-y =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0:=3D lis3l=
02dq_core.o
> diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/sta=
ging/iio/accel/adis16240_core.c
> new file mode 100644
> index 0000000..54fd6d7
> --- /dev/null
> +++ b/drivers/staging/iio/accel/adis16240_core.c
> @@ -0,0 +1,599 @@
> +/*
> + * ADIS16240 Programmable Impact Sensor and Recorder driver
> + *
> + * Copyright 2010 Analog Devices Inc.
> + *
> + * Licensed under the GPL-2 or later.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/gpio.h>
> +#include <linux/delay.h>
> +#include <linux/mutex.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/spi/spi.h>
> +
> +#include <linux/sysfs.h>
> +#include <linux/list.h>
> +
> +#include "../iio.h"
> +#include "../sysfs.h"
> +#include "accel.h"
> +#include "../adc/adc.h"
> +
> +#include "adis16240.h"
> +
> +#define DRIVER_NAME =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"adis16=
240"
> +
> +static int adis16240_check_status(struct device *dev);
> +
> +/**
> + * adis16240_spi_write_reg_8() - write single byte to a register
> + * @dev: device associated with child of actual device (iio_dev or i=
io_trig)
> + * @reg_address: the address of the register to be written
> + * @val: the value to write
> + **/
> +static int adis16240_spi_write_reg_8(struct device *dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 reg_address,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 val)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> + =C2=A0 =C2=A0 =C2=A0 struct iio_dev *indio_dev =3D dev_get_drvdata(=
dev);
> + =C2=A0 =C2=A0 =C2=A0 struct adis16240_state *st =3D iio_dev_get_dev=
data(indio_dev);
> +
> + =C2=A0 =C2=A0 =C2=A0 mutex_lock(&st->buf_lock);
> + =C2=A0 =C2=A0 =C2=A0 st->tx[0] =3D ADIS16240_WRITE_REG(reg_address)=
;
> + =C2=A0 =C2=A0 =C2=A0 st->tx[1] =3D val;
> +
> + =C2=A0 =C2=A0 =C2=A0 ret =3D spi_write(st->us, st->tx, 2);
> + =C2=A0 =C2=A0 =C2=A0 mutex_unlock(&st->buf_lock);
> +
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}
> +
> +/**
> + * adis16240_spi_write_reg_16() - write 2 bytes to a pair of registe=
rs
> + * @dev: device associated with child of actual device (iio_dev or i=
io_trig)
> + * @reg_address: the address of the lower of the two registers. Seco=
nd register
> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is assumed to ha=
ve address one greater.
> + * @val: value to be written
> + **/
> +static int adis16240_spi_write_reg_16(struct device *dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 lower_reg_addre=
ss,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 value)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> + =C2=A0 =C2=A0 =C2=A0 struct spi_message msg;
> + =C2=A0 =C2=A0 =C2=A0 struct iio_dev *indio_dev =3D dev_get_drvdata(=
dev);
> + =C2=A0 =C2=A0 =C2=A0 struct adis16240_state *st =3D iio_dev_get_dev=
data(indio_dev);
> + =C2=A0 =C2=A0 =C2=A0 struct spi_transfer xfers[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 .tx_buf =3D st->tx,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 .bits_per_word =3D 8,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 .len =3D 2,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 .cs_change =3D 1,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 .delay_usecs =3D 25,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }, {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 .tx_buf =3D st->tx + 2,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 .bits_per_word =3D 8,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 .len =3D 2,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 .cs_change =3D 1,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 .delay_usecs =3D 25,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 };
> +
> + =C2=A0 =C2=A0 =C2=A0 mutex_lock(&st->buf_lock);
> + =C2=A0 =C2=A0 =C2=A0 st->tx[0] =3D ADIS16240_WRITE_REG(lower_reg_ad=
dress);
> + =C2=A0 =C2=A0 =C2=A0 st->tx[1] =3D value & 0xFF;
> + =C2=A0 =C2=A0 =C2=A0 st->tx[2] =3D ADIS16240_WRITE_REG(lower_reg_ad=
dress + 1);
> + =C2=A0 =C2=A0 =C2=A0 st->tx[3] =3D (value >> 8) & 0xFF;
> +
> + =C2=A0 =C2=A0 =C2=A0 spi_message_init(&msg);
> + =C2=A0 =C2=A0 =C2=A0 spi_message_add_tail(&xfers[0], &msg);
> + =C2=A0 =C2=A0 =C2=A0 spi_message_add_tail(&xfers[1], &msg);
> + =C2=A0 =C2=A0 =C2=A0 ret =3D spi_sync(st->us, &msg);
> + =C2=A0 =C2=A0 =C2=A0 mutex_unlock(&st->buf_lock);
> +
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}
> +
> +/**
> + * adis16240_spi_read_reg_16() - read 2 bytes from a 16-bit register
> + * @dev: device associated with child of actual device (iio_dev or i=
io_trig)
> + * @reg_address: the address of the lower of the two registers. Seco=
nd register
> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is assumed to ha=
ve address one greater.
> + * @val: somewhere to pass back the value read
> + **/
> +static int adis16240_spi_read_reg_16(struct device *dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 lower_reg_addre=
ss,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 *val)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct spi_message msg;
> + =C2=A0 =C2=A0 =C2=A0 struct iio_dev *indio_dev =3D dev_get_drvdata(=
dev);
> + =C2=A0 =C2=A0 =C2=A0 struct adis16240_state *st =3D iio_dev_get_dev=
data(indio_dev);
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> + =C2=A0 =C2=A0 =C2=A0 struct spi_transfer xfers[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 .tx_buf =3D st->tx,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 .bits_per_word =3D 8,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 .len =3D 2,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 .cs_change =3D 1,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 .delay_usecs =3D 25,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }, {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 .rx_buf =3D st->rx,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 .bits_per_word =3D 8,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 .len =3D 2,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 .cs_change =3D 1,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 .delay_usecs =3D 25,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 };
> +
> + =C2=A0 =C2=A0 =C2=A0 mutex_lock(&st->buf_lock);
> + =C2=A0 =C2=A0 =C2=A0 st->tx[0] =3D ADIS16240_READ_REG(lower_reg_add=
ress);
> + =C2=A0 =C2=A0 =C2=A0 st->tx[1] =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 st->tx[2] =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 st->tx[3] =3D 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 spi_message_init(&msg);
> + =C2=A0 =C2=A0 =C2=A0 spi_message_add_tail(&xfers[0], &msg);
> + =C2=A0 =C2=A0 =C2=A0 spi_message_add_tail(&xfers[1], &msg);
> + =C2=A0 =C2=A0 =C2=A0 ret =3D spi_sync(st->us, &msg);
> + =C2=A0 =C2=A0 =C2=A0 if (ret) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&st->us->d=
ev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 "problem when reading 16 bit register 0x%02X",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 lower_reg_address);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_ret;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 *val =3D (st->rx[0] << 8) | st->rx[1];
> +
> +error_ret:
> + =C2=A0 =C2=A0 =C2=A0 mutex_unlock(&st->buf_lock);
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}
> +
> +static ssize_t adis16240_spi_read_signed(struct device *dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct device_attr=
ibute *attr,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *buf,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned bits)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> + =C2=A0 =C2=A0 =C2=A0 s16 val =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 unsigned shift =3D 16 - bits;
> + =C2=A0 =C2=A0 =C2=A0 struct iio_dev_attr *this_attr =3D to_iio_dev_=
attr(attr);
> +
> + =C2=A0 =C2=A0 =C2=A0 ret =3D adis16240_spi_read_reg_16(dev, this_at=
tr->address, (u16 *)&val);
> + =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (val & ADIS16240_ERROR_ACTIVE)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adis16240_check_st=
atus(dev);
> +
> + =C2=A0 =C2=A0 =C2=A0 val =3D ((s16)(val << shift) >> shift);
> + =C2=A0 =C2=A0 =C2=A0 return sprintf(buf, "%d\n", val);
> +}
> +
> +static ssize_t adis16240_read_10bit_unsigned(struct device *dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct device_attr=
ibute *attr,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *buf)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> + =C2=A0 =C2=A0 =C2=A0 u16 val =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 struct iio_dev_attr *this_attr =3D to_iio_dev_=
attr(attr);
> +
> + =C2=A0 =C2=A0 =C2=A0 ret =3D adis16240_spi_read_reg_16(dev, this_at=
tr->address, &val);
> + =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (val & ADIS16240_ERROR_ACTIVE)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adis16240_check_st=
atus(dev);
> +
> + =C2=A0 =C2=A0 =C2=A0 return sprintf(buf, "%u\n", val & 0x03FF);
> +}
> +
> +static ssize_t adis16240_read_10bit_signed(struct device *dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct device_attr=
ibute *attr,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *buf)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct iio_dev *indio_dev =3D dev_get_drvdata(=
dev);
> + =C2=A0 =C2=A0 =C2=A0 ssize_t ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Take the iio_dev status lock */
> + =C2=A0 =C2=A0 =C2=A0 mutex_lock(&indio_dev->mlock);
> + =C2=A0 =C2=A0 =C2=A0 ret =3D =C2=A0adis16240_spi_read_signed(dev, a=
ttr, buf, 10);
> + =C2=A0 =C2=A0 =C2=A0 mutex_unlock(&indio_dev->mlock);
> +
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}
> +
> +static ssize_t adis16240_read_12bit_signed(struct device *dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct device_attr=
ibute *attr,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *buf)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct iio_dev *indio_dev =3D dev_get_drvdata(=
dev);
> + =C2=A0 =C2=A0 =C2=A0 ssize_t ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Take the iio_dev status lock */
> + =C2=A0 =C2=A0 =C2=A0 mutex_lock(&indio_dev->mlock);
> + =C2=A0 =C2=A0 =C2=A0 ret =3D =C2=A0adis16240_spi_read_signed(dev, a=
ttr, buf, 12);
> + =C2=A0 =C2=A0 =C2=A0 mutex_unlock(&indio_dev->mlock);
> +
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}
> +
> +static ssize_t adis16240_write_16bit(struct device *dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct device_attr=
ibute *attr,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *buf,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t len)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct iio_dev_attr *this_attr =3D to_iio_dev_=
attr(attr);
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> + =C2=A0 =C2=A0 =C2=A0 long val;
> +
> + =C2=A0 =C2=A0 =C2=A0 ret =3D strict_strtol(buf, 10, &val);
> + =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_ret;
> + =C2=A0 =C2=A0 =C2=A0 ret =3D adis16240_spi_write_reg_16(dev, this_a=
ttr->address, val);
> +
> +error_ret:
> + =C2=A0 =C2=A0 =C2=A0 return ret ? ret : len;
> +}
> +
> +static int adis16240_reset(struct device *dev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> + =C2=A0 =C2=A0 =C2=A0 ret =3D adis16240_spi_write_reg_8(dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ADIS16240_GLOB_CMD,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ADIS16240_GLOB_CMD_SW_RESET);
> + =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "prob=
lem resetting device");
> +
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}
> +
> +static ssize_t adis16240_write_reset(struct device *dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct device_attr=
ibute *attr,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *buf, s=
ize_t len)
> +{
> + =C2=A0 =C2=A0 =C2=A0 if (len < 1)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> + =C2=A0 =C2=A0 =C2=A0 switch (buf[0]) {
> + =C2=A0 =C2=A0 =C2=A0 case '1':
> + =C2=A0 =C2=A0 =C2=A0 case 'y':
> + =C2=A0 =C2=A0 =C2=A0 case 'Y':
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return adis16240_r=
eset(dev);
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> +}
> +
> +int adis16240_set_irq(struct device *dev, bool enable)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int ret =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 u16 msc;
> +
> + =C2=A0 =C2=A0 =C2=A0 ret =3D adis16240_spi_read_reg_16(dev, ADIS162=
40_MSC_CTRL, &msc);
> + =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 msc |=3D ADIS16240_MSC_CTRL_ACTIVE_HIGH;
> + =C2=A0 =C2=A0 =C2=A0 msc &=3D ~ADIS16240_MSC_CTRL_DATA_RDY_DIO2;
> + =C2=A0 =C2=A0 =C2=A0 if (enable)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msc |=3D ADIS16240=
_MSC_CTRL_DATA_RDY_EN;
> + =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msc &=3D ~ADIS1624=
0_MSC_CTRL_DATA_RDY_EN;
> +
> + =C2=A0 =C2=A0 =C2=A0 ret =3D adis16240_spi_write_reg_16(dev, ADIS16=
240_MSC_CTRL, msc);
> +
> +error_ret:
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}
> +
> +static int adis16240_self_test(struct device *dev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> + =C2=A0 =C2=A0 =C2=A0 ret =3D adis16240_spi_write_reg_16(dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ADIS16240_MSC_CTRL,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ADIS16240_MSC_CTRL_SELF_TEST_EN);
> + =C2=A0 =C2=A0 =C2=A0 if (ret) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "prob=
lem starting self test");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_ret;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 msleep(ADIS16240_STARTUP_DELAY);
> +
> + =C2=A0 =C2=A0 =C2=A0 adis16240_check_status(dev);
> +
> +err_ret:
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}
> +
> +static int adis16240_check_status(struct device *dev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 u16 status;
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 ret =3D adis16240_spi_read_reg_16(dev, ADIS162=
40_DIAG_STAT, &status);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (ret < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "Read=
ing status failed\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_ret;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 ret =3D status & 0x2F;
> + =C2=A0 =C2=A0 =C2=A0 if (status & ADIS16240_DIAG_STAT_PWRON_FAIL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "Powe=
r-on, self-test fail\n");
> + =C2=A0 =C2=A0 =C2=A0 if (status & ADIS16240_DIAG_STAT_SPI_FAIL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "SPI =
failure\n");
> + =C2=A0 =C2=A0 =C2=A0 if (status & ADIS16240_DIAG_STAT_FLASH_UPT)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "Flas=
h update failed\n");
> + =C2=A0 =C2=A0 =C2=A0 if (status & ADIS16240_DIAG_STAT_POWER_HIGH)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "Powe=
r supply above 3.625V\n");
> + =C2=A0 =C2=A0 =C2=A0 if (status & ADIS16240_DIAG_STAT_POWER_LOW)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "Powe=
r supply below 2.225V\n");
> +
> +error_ret:
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}
> +
> +static int adis16240_initial_setup(struct adis16240_state *st)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> + =C2=A0 =C2=A0 =C2=A0 struct device *dev =3D &st->indio_dev->dev;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Disable IRQ */
> + =C2=A0 =C2=A0 =C2=A0 ret =3D adis16240_set_irq(dev, false);
> + =C2=A0 =C2=A0 =C2=A0 if (ret) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "disa=
ble irq failed");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_ret;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Do self test */
> + =C2=A0 =C2=A0 =C2=A0 ret =3D adis16240_self_test(dev);
> + =C2=A0 =C2=A0 =C2=A0 if (ret) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "self=
 test failure");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_ret;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Read status register to check the result */
> + =C2=A0 =C2=A0 =C2=A0 ret =3D adis16240_check_status(dev);
> + =C2=A0 =C2=A0 =C2=A0 if (ret) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adis16240_reset(de=
v);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "devi=
ce not playing ball -> reset");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msleep(ADIS16240_S=
TARTUP_DELAY);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D adis16240_=
check_status(dev);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 dev_err(dev, "giving up");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 goto err_ret;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 printk(KERN_INFO DRIVER_NAME ": at CS%d (irq %=
d)\n",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 st->us->chip_select, st->us->irq);
> +
> +err_ret:
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}
> +
> +static IIO_DEV_ATTR_IN_NAMED_RAW(supply, adis16240_read_10bit_unsign=
ed,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADIS16240_SUPPLY_O=
UT);
> +static IIO_DEV_ATTR_IN_RAW(0, adis16240_read_10bit_signed,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADIS16240_AUX_ADC)=
;
> +static IIO_CONST_ATTR(in_supply_scale, "0.00488");
> +static IIO_DEV_ATTR_ACCEL_X(adis16240_read_10bit_signed,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADIS16240_XACCL_OU=
T);
> +static IIO_DEVICE_ATTR(accel_x_peak_raw, S_IRUGO,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0adis16240_read_10bit_signed, NULL,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ADIS16240_XPEAK_OUT);
> +static IIO_DEV_ATTR_ACCEL_Y(adis16240_read_10bit_signed,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADIS16240_YACCL_OU=
T);
> +static IIO_DEVICE_ATTR(accel_y_peak_raw, S_IRUGO,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0adis16240_read_10bit_signed, NULL,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ADIS16240_YPEAK_OUT);
> +static IIO_DEV_ATTR_ACCEL_Z(adis16240_read_10bit_signed,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADIS16240_ZACCL_OU=
T);
> +static IIO_DEVICE_ATTR(accel_z_peak_raw, S_IRUGO,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0adis16240_read_10bit_signed, NULL,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ADIS16240_ZPEAK_OUT);
> +
> +static IIO_DEVICE_ATTR(accel_xyz_squared_peak_raw, S_IRUGO,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0adis16240_read_12bit_signed, NULL,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ADIS16240_XYZPEAK_OUT);
> +static IIO_DEV_ATTR_ACCEL_X_OFFSET(S_IWUSR | S_IRUGO,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adis16240_read_10b=
it_signed,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adis16240_write_16=
bit,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADIS16240_XACCL_OF=
=46);
> +static IIO_DEV_ATTR_ACCEL_Y_OFFSET(S_IWUSR | S_IRUGO,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adis16240_read_10b=
it_signed,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adis16240_write_16=
bit,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADIS16240_YACCL_OF=
=46);
> +static IIO_DEV_ATTR_ACCEL_Z_OFFSET(S_IWUSR | S_IRUGO,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adis16240_read_10b=
it_signed,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adis16240_write_16=
bit,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADIS16240_ZACCL_OF=
=46);
> +static IIO_DEV_ATTR_TEMP_RAW(adis16240_read_10bit_unsigned);
> +static IIO_CONST_ATTR(temp_scale, "0.244");
> +
> +static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, adis16240_write_reset, =
0);
> +
> +static IIO_CONST_ATTR_AVAIL_SAMP_FREQ("4096");
> +
> +static IIO_CONST_ATTR(name, "adis16240");
> +
> +static struct attribute *adis16240_event_attributes[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 NULL
> +};
> +
> +static struct attribute_group adis16240_event_attribute_group =3D {
> + =C2=A0 =C2=A0 =C2=A0 .attrs =3D adis16240_event_attributes,
> +};
> +
> +static struct attribute *adis16240_attributes[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 &iio_dev_attr_in_supply_raw.dev_attr.attr,
> + =C2=A0 =C2=A0 =C2=A0 &iio_const_attr_in_supply_scale.dev_attr.attr,
> + =C2=A0 =C2=A0 =C2=A0 &iio_dev_attr_in0_raw.dev_attr.attr,
> + =C2=A0 =C2=A0 =C2=A0 &iio_dev_attr_accel_x_raw.dev_attr.attr,
> + =C2=A0 =C2=A0 =C2=A0 &iio_dev_attr_accel_x_offset.dev_attr.attr,
> + =C2=A0 =C2=A0 =C2=A0 &iio_dev_attr_accel_x_peak_raw.dev_attr.attr,
> + =C2=A0 =C2=A0 =C2=A0 &iio_dev_attr_accel_y_raw.dev_attr.attr,
> + =C2=A0 =C2=A0 =C2=A0 &iio_dev_attr_accel_y_offset.dev_attr.attr,
> + =C2=A0 =C2=A0 =C2=A0 &iio_dev_attr_accel_y_peak_raw.dev_attr.attr,
> + =C2=A0 =C2=A0 =C2=A0 &iio_dev_attr_accel_z_raw.dev_attr.attr,
> + =C2=A0 =C2=A0 =C2=A0 &iio_dev_attr_accel_z_offset.dev_attr.attr,
> + =C2=A0 =C2=A0 =C2=A0 &iio_dev_attr_accel_z_peak_raw.dev_attr.attr,
> + =C2=A0 =C2=A0 =C2=A0 &iio_dev_attr_accel_xyz_squared_peak_raw.dev_a=
ttr.attr,
> + =C2=A0 =C2=A0 =C2=A0 &iio_dev_attr_temp_raw.dev_attr.attr,
> + =C2=A0 =C2=A0 =C2=A0 &iio_const_attr_temp_scale.dev_attr.attr,
> + =C2=A0 =C2=A0 =C2=A0 &iio_const_attr_available_sampling_frequency.d=
ev_attr.attr,
> + =C2=A0 =C2=A0 =C2=A0 &iio_dev_attr_reset.dev_attr.attr,
> + =C2=A0 =C2=A0 =C2=A0 &iio_const_attr_name.dev_attr.attr,
> + =C2=A0 =C2=A0 =C2=A0 NULL
> +};
> +
> +static const struct attribute_group adis16240_attribute_group =3D {
> + =C2=A0 =C2=A0 =C2=A0 .attrs =3D adis16240_attributes,
> +};
> +
> +static int __devinit adis16240_probe(struct spi_device *spi)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int ret, regdone =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 struct adis16240_state *st =3D kzalloc(sizeof =
*st, GFP_KERNEL);
> + =C2=A0 =C2=A0 =C2=A0 if (!st) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D =C2=A0-ENO=
MEM;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_ret;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 /* this is only used for removal purposes */
> + =C2=A0 =C2=A0 =C2=A0 spi_set_drvdata(spi, st);
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Allocate the comms buffers */
> + =C2=A0 =C2=A0 =C2=A0 st->rx =3D kzalloc(sizeof(*st->rx)*ADIS16240_M=
AX_RX, GFP_KERNEL);
> + =C2=A0 =C2=A0 =C2=A0 if (st->rx =3D=3D NULL) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_free_st=
;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 st->tx =3D kzalloc(sizeof(*st->tx)*ADIS16240_M=
AX_TX, GFP_KERNEL);
> + =C2=A0 =C2=A0 =C2=A0 if (st->tx =3D=3D NULL) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_free_rx=
;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 st->us =3D spi;
> + =C2=A0 =C2=A0 =C2=A0 mutex_init(&st->buf_lock);
> + =C2=A0 =C2=A0 =C2=A0 /* setup the industrialio driver allocated ele=
ments */
> + =C2=A0 =C2=A0 =C2=A0 st->indio_dev =3D iio_allocate_device();
> + =C2=A0 =C2=A0 =C2=A0 if (st->indio_dev =3D=3D NULL) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_free_tx=
;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 st->indio_dev->dev.parent =3D &spi->dev;
> + =C2=A0 =C2=A0 =C2=A0 st->indio_dev->num_interrupt_lines =3D 1;
> + =C2=A0 =C2=A0 =C2=A0 st->indio_dev->event_attrs =3D &adis16240_even=
t_attribute_group;
> + =C2=A0 =C2=A0 =C2=A0 st->indio_dev->attrs =3D &adis16240_attribute_=
group;
> + =C2=A0 =C2=A0 =C2=A0 st->indio_dev->dev_data =3D (void *)(st);
> + =C2=A0 =C2=A0 =C2=A0 st->indio_dev->driver_module =3D THIS_MODULE;
> + =C2=A0 =C2=A0 =C2=A0 st->indio_dev->modes =3D INDIO_DIRECT_MODE;
> +
> + =C2=A0 =C2=A0 =C2=A0 ret =3D adis16240_configure_ring(st->indio_dev=
);
> + =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_free_de=
v;
> +
> + =C2=A0 =C2=A0 =C2=A0 ret =3D iio_device_register(st->indio_dev);
> + =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_unreg_r=
ing_funcs;
> + =C2=A0 =C2=A0 =C2=A0 regdone =3D 1;
> +
> + =C2=A0 =C2=A0 =C2=A0 ret =3D adis16240_initialize_ring(st->indio_de=
v->ring);
> + =C2=A0 =C2=A0 =C2=A0 if (ret) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_ERR "f=
ailed to initialize the ring\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_unreg_r=
ing_funcs;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 if (spi->irq) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D iio_regist=
er_interrupt_line(spi->irq,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 st->indio_dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IRQF_TRIGGER_RISING,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "adis16240");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 goto error_uninitialize_ring;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D adis16240_=
probe_trigger(st->indio_dev);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 goto error_unregister_line;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Get the device into a sane initial state */
> + =C2=A0 =C2=A0 =C2=A0 ret =3D adis16240_initial_setup(st);
> + =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_remove_=
trigger;
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +
> +error_remove_trigger:
> + =C2=A0 =C2=A0 =C2=A0 adis16240_remove_trigger(st->indio_dev);
> +error_unregister_line:
> + =C2=A0 =C2=A0 =C2=A0 if (spi->irq)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iio_unregister_int=
errupt_line(st->indio_dev, 0);
> +error_uninitialize_ring:
> + =C2=A0 =C2=A0 =C2=A0 adis16240_uninitialize_ring(st->indio_dev->rin=
g);
> +error_unreg_ring_funcs:
> + =C2=A0 =C2=A0 =C2=A0 adis16240_unconfigure_ring(st->indio_dev);
> +error_free_dev:
> + =C2=A0 =C2=A0 =C2=A0 if (regdone)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iio_device_unregis=
ter(st->indio_dev);
> + =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iio_free_device(st=
->indio_dev);
> +error_free_tx:
> + =C2=A0 =C2=A0 =C2=A0 kfree(st->tx);
> +error_free_rx:
> + =C2=A0 =C2=A0 =C2=A0 kfree(st->rx);
> +error_free_st:
> + =C2=A0 =C2=A0 =C2=A0 kfree(st);
> +error_ret:
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}
> +
> +static int adis16240_remove(struct spi_device *spi)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct adis16240_state *st =3D spi_get_drvdata=
(spi);
> + =C2=A0 =C2=A0 =C2=A0 struct iio_dev *indio_dev =3D st->indio_dev;
> +
> + =C2=A0 =C2=A0 =C2=A0 flush_scheduled_work();
> +
> + =C2=A0 =C2=A0 =C2=A0 adis16240_remove_trigger(indio_dev);
> + =C2=A0 =C2=A0 =C2=A0 if (spi->irq)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iio_unregister_int=
errupt_line(indio_dev, 0);
> +
> + =C2=A0 =C2=A0 =C2=A0 adis16240_uninitialize_ring(indio_dev->ring);
> + =C2=A0 =C2=A0 =C2=A0 iio_device_unregister(indio_dev);
> + =C2=A0 =C2=A0 =C2=A0 adis16240_unconfigure_ring(indio_dev);
> + =C2=A0 =C2=A0 =C2=A0 kfree(st->tx);
> + =C2=A0 =C2=A0 =C2=A0 kfree(st->rx);
> + =C2=A0 =C2=A0 =C2=A0 kfree(st);
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +static struct spi_driver adis16240_driver =3D {
> + =C2=A0 =C2=A0 =C2=A0 .driver =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D "adis162=
40",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .owner =3D THIS_MO=
DULE,
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 .probe =3D adis16240_probe,
> + =C2=A0 =C2=A0 =C2=A0 .remove =3D __devexit_p(adis16240_remove),
> +};
> +
> +static __init int adis16240_init(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return spi_register_driver(&adis16240_driver);
> +}
> +module_init(adis16240_init);
> +
> +static __exit void adis16240_exit(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 spi_unregister_driver(&adis16240_driver);
> +}
> +module_exit(adis16240_exit);
> +
> +MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> +MODULE_DESCRIPTION("Analog Devices Programmable Impact Sensor and Re=
corder");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/sta=
ging/iio/accel/adis16240_ring.c
> new file mode 100644
> index 0000000..26b677b
> --- /dev/null
> +++ b/drivers/staging/iio/accel/adis16240_ring.c
> @@ -0,0 +1,254 @@
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/gpio.h>
> +#include <linux/workqueue.h>
> +#include <linux/mutex.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/spi/spi.h>
> +#include <linux/sysfs.h>
> +#include <linux/list.h>
> +
> +#include "../iio.h"
> +#include "../sysfs.h"
> +#include "../ring_sw.h"
> +#include "accel.h"
> +#include "../trigger.h"
> +#include "adis16240.h"
> +
> +/**
> + * combine_8_to_16() utility function to munge to u8s into u16
> + **/
> +static inline u16 combine_8_to_16(u8 lower, u8 upper)
> +{
> + =C2=A0 =C2=A0 =C2=A0 u16 _lower =3D lower;
> + =C2=A0 =C2=A0 =C2=A0 u16 _upper =3D upper;
> + =C2=A0 =C2=A0 =C2=A0 return _lower | (_upper << 8);
> +}
> +
> +static IIO_SCAN_EL_C(supply, ADIS16240_SCAN_SUPPLY, IIO_UNSIGNED(10)=
,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADIS16240_SUPPLY_O=
UT, NULL);
> +static IIO_SCAN_EL_C(accel_x, ADIS16240_SCAN_ACC_X, IIO_SIGNED(10),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADIS16240_XACCL_OU=
T, NULL);
> +static IIO_SCAN_EL_C(accel_y, ADIS16240_SCAN_ACC_Y, IIO_SIGNED(10),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADIS16240_YACCL_OU=
T, NULL);
> +static IIO_SCAN_EL_C(accel_z, ADIS16240_SCAN_ACC_Z, IIO_SIGNED(10),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADIS16240_ZACCL_OU=
T, NULL);
> +static IIO_SCAN_EL_C(aux_adc, ADIS16240_SCAN_AUX_ADC, IIO_UNSIGNED(1=
0),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADIS16240_AUX_ADC,=
 NULL);
> +static IIO_SCAN_EL_C(temp, ADIS16240_SCAN_TEMP, IIO_UNSIGNED(10),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADIS16240_TEMP_OUT=
, NULL);
> +
> +static IIO_SCAN_EL_TIMESTAMP(6);
> +
> +static struct attribute *adis16240_scan_el_attrs[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 &iio_scan_el_supply.dev_attr.attr,
> + =C2=A0 =C2=A0 =C2=A0 &iio_scan_el_accel_x.dev_attr.attr,
> + =C2=A0 =C2=A0 =C2=A0 &iio_scan_el_accel_y.dev_attr.attr,
> + =C2=A0 =C2=A0 =C2=A0 &iio_scan_el_accel_z.dev_attr.attr,
> + =C2=A0 =C2=A0 =C2=A0 &iio_scan_el_aux_adc.dev_attr.attr,
> + =C2=A0 =C2=A0 =C2=A0 &iio_scan_el_temp.dev_attr.attr,
> + =C2=A0 =C2=A0 =C2=A0 &iio_scan_el_timestamp.dev_attr.attr,
> + =C2=A0 =C2=A0 =C2=A0 NULL,
> +};
> +
> +static struct attribute_group adis16240_scan_el_group =3D {
> + =C2=A0 =C2=A0 =C2=A0 .attrs =3D adis16240_scan_el_attrs,
> + =C2=A0 =C2=A0 =C2=A0 .name =3D "scan_elements",
> +};
> +
> +/**
> + * adis16240_poll_func_th() top half interrupt handler called by tri=
gger
> + * @private_data: =C2=A0 =C2=A0 =C2=A0iio_dev
> + **/
> +static void adis16240_poll_func_th(struct iio_dev *indio_dev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct adis16240_state *st =3D iio_dev_get_dev=
data(indio_dev);
> + =C2=A0 =C2=A0 =C2=A0 st->last_timestamp =3D indio_dev->trig->timest=
amp;
> + =C2=A0 =C2=A0 =C2=A0 schedule_work(&st->work_trigger_to_ring);
> +}
> +
> +/**
> + * adis16240_read_ring_data() read data registers which will be plac=
ed into ring
> + * @dev: device associated with child of actual device (iio_dev or i=
io_trig)
> + * @rx: somewhere to pass back the value read
> + **/
> +static int adis16240_read_ring_data(struct device *dev, u8 *rx)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct spi_message msg;
> + =C2=A0 =C2=A0 =C2=A0 struct iio_dev *indio_dev =3D dev_get_drvdata(=
dev);
> + =C2=A0 =C2=A0 =C2=A0 struct adis16240_state *st =3D iio_dev_get_dev=
data(indio_dev);
> + =C2=A0 =C2=A0 =C2=A0 struct spi_transfer xfers[ADIS16240_OUTPUTS + =
1];
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> + =C2=A0 =C2=A0 =C2=A0 int i;
> +
> + =C2=A0 =C2=A0 =C2=A0 mutex_lock(&st->buf_lock);
> +
> + =C2=A0 =C2=A0 =C2=A0 spi_message_init(&msg);
> +
> + =C2=A0 =C2=A0 =C2=A0 memset(xfers, 0, sizeof(xfers));
> + =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i <=3D ADIS16240_OUTPUTS; i++) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xfers[i].bits_per_=
word =3D 8;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xfers[i].cs_change=
 =3D 1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xfers[i].len =3D 2=
;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xfers[i].delay_use=
cs =3D 30;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xfers[i].tx_buf =3D=
 st->tx + 2 * i;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 st->tx[2 * i]
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =3D ADIS16240_READ_REG(ADIS16240_SUPPLY_OUT + 2 * i);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 st->tx[2 * i + 1] =
=3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i >=3D 1)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 xfers[i].rx_buf =3D rx + 2 * (i - 1);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spi_message_add_ta=
il(&xfers[i], &msg);
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 ret =3D spi_sync(st->us, &msg);
> + =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&st->us->d=
ev, "problem when burst reading");
> +
> + =C2=A0 =C2=A0 =C2=A0 mutex_unlock(&st->buf_lock);
> +
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}
> +
> +
> +static void adis16240_trigger_bh_to_ring(struct work_struct *work_s)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct adis16240_state *st
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D container_of(w=
ork_s, struct adis16240_state,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 work_trigger_to_ring);
> +
> + =C2=A0 =C2=A0 =C2=A0 int i =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 s16 *data;
> + =C2=A0 =C2=A0 =C2=A0 size_t datasize =3D st->indio_dev
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ->ring->access.get=
_bpd(st->indio_dev->ring);
> +
> + =C2=A0 =C2=A0 =C2=A0 data =3D kmalloc(datasize , GFP_KERNEL);
> + =C2=A0 =C2=A0 =C2=A0 if (data =3D=3D NULL) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&st->us->d=
ev, "memory alloc failed in ring bh");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 if (st->indio_dev->scan_count)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (adis16240_read=
_ring_data(&st->indio_dev->dev, st->rx) >=3D 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 for (; i < st->indio_dev->scan_count; i++) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data[i] =3D combine_8_to_16(st->rx[=
i*2+1],
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 st->rx[i*2]);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Guaranteed to be aligned with 8 byte bounda=
ry */
> + =C2=A0 =C2=A0 =C2=A0 if (st->indio_dev->scan_timestamp)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *((s64 *)(data + (=
(i + 3)/4)*4)) =3D st->last_timestamp;
> +
> + =C2=A0 =C2=A0 =C2=A0 st->indio_dev->ring->access.store_to(st->indio=
_dev->ring,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 (u8 *)data,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 st->last_timestamp);
> +
> + =C2=A0 =C2=A0 =C2=A0 iio_trigger_notify_done(st->indio_dev->trig);
> + =C2=A0 =C2=A0 =C2=A0 kfree(data);
> +
> + =C2=A0 =C2=A0 =C2=A0 return;
> +}
> +
> +static int adis16240_data_rdy_ring_preenable(struct iio_dev *indio_d=
ev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 size_t size;
> + =C2=A0 =C2=A0 =C2=A0 dev_dbg(&indio_dev->dev, "%s\n", __func__);
> + =C2=A0 =C2=A0 =C2=A0 /* Check if there are any scan elements enable=
d, if not fail*/
> + =C2=A0 =C2=A0 =C2=A0 if (!(indio_dev->scan_count || indio_dev->scan=
_timestamp))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (indio_dev->ring->access.set_bpd) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (indio_dev->sca=
n_timestamp)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (indio_dev->scan_count)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Timestamp (aligned sizeof(s64) a=
nd data */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D (((indio_dev->scan_count *=
 sizeof(s16))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=
 sizeof(s64) - 1)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 & ~(siz=
eof(s64) - 1))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 + sizeo=
f(s64);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 else /* Timestamp only =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D sizeof(s64);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else /* Data only =
*/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 size =3D indio_dev->scan_count*sizeof(s16);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 indio_dev->ring->a=
ccess.set_bpd(indio_dev->ring, size);
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +static int adis16240_data_rdy_ring_postenable(struct iio_dev *indio_=
dev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return indio_dev->trig
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ? iio_trigger_atta=
ch_poll_func(indio_dev->trig,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 indio_dev->pollfunc)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 0;
> +}
> +
> +static int adis16240_data_rdy_ring_predisable(struct iio_dev *indio_=
dev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return indio_dev->trig
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ? iio_trigger_dett=
ach_poll_func(indio_dev->trig,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 indio_dev->pollfunc)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 0;
> +}
> +
> +void adis16240_unconfigure_ring(struct iio_dev *indio_dev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 kfree(indio_dev->pollfunc);
> + =C2=A0 =C2=A0 =C2=A0 iio_sw_rb_free(indio_dev->ring);
> +}
> +
> +int adis16240_configure_ring(struct iio_dev *indio_dev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int ret =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 struct adis16240_state *st =3D indio_dev->dev_=
data;
> + =C2=A0 =C2=A0 =C2=A0 struct iio_ring_buffer *ring;
> + =C2=A0 =C2=A0 =C2=A0 INIT_WORK(&st->work_trigger_to_ring, adis16240=
_trigger_bh_to_ring);
> + =C2=A0 =C2=A0 =C2=A0 /* Set default scan mode */
> +
> + =C2=A0 =C2=A0 =C2=A0 iio_scan_mask_set(indio_dev, iio_scan_el_suppl=
y.number);
> + =C2=A0 =C2=A0 =C2=A0 iio_scan_mask_set(indio_dev, iio_scan_el_accel=
_x.number);
> + =C2=A0 =C2=A0 =C2=A0 iio_scan_mask_set(indio_dev, iio_scan_el_accel=
_y.number);
> + =C2=A0 =C2=A0 =C2=A0 iio_scan_mask_set(indio_dev, iio_scan_el_accel=
_z.number);
> + =C2=A0 =C2=A0 =C2=A0 iio_scan_mask_set(indio_dev, iio_scan_el_temp.=
number);
> + =C2=A0 =C2=A0 =C2=A0 iio_scan_mask_set(indio_dev, iio_scan_el_aux_a=
dc.number);
> + =C2=A0 =C2=A0 =C2=A0 indio_dev->scan_timestamp =3D true;
> +
> + =C2=A0 =C2=A0 =C2=A0 indio_dev->scan_el_attrs =3D &adis16240_scan_e=
l_group;
> +
> + =C2=A0 =C2=A0 =C2=A0 ring =3D iio_sw_rb_allocate(indio_dev);
> + =C2=A0 =C2=A0 =C2=A0 if (!ring) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 indio_dev->ring =3D ring;
> + =C2=A0 =C2=A0 =C2=A0 /* Effectively select the ring buffer implemen=
tation */
> + =C2=A0 =C2=A0 =C2=A0 iio_ring_sw_register_funcs(&ring->access);
> + =C2=A0 =C2=A0 =C2=A0 ring->preenable =3D &adis16240_data_rdy_ring_p=
reenable;
> + =C2=A0 =C2=A0 =C2=A0 ring->postenable =3D &adis16240_data_rdy_ring_=
postenable;
> + =C2=A0 =C2=A0 =C2=A0 ring->predisable =3D &adis16240_data_rdy_ring_=
predisable;
> + =C2=A0 =C2=A0 =C2=A0 ring->owner =3D THIS_MODULE;
> +
> + =C2=A0 =C2=A0 =C2=A0 indio_dev->pollfunc =3D kzalloc(sizeof(*indio_=
dev->pollfunc), GFP_KERNEL);
> + =C2=A0 =C2=A0 =C2=A0 if (indio_dev->pollfunc =3D=3D NULL) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_iio_sw_=
rb_free;;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 indio_dev->pollfunc->poll_func_main =3D &adis1=
6240_poll_func_th;
> + =C2=A0 =C2=A0 =C2=A0 indio_dev->pollfunc->private_data =3D indio_de=
v;
> + =C2=A0 =C2=A0 =C2=A0 indio_dev->modes |=3D INDIO_RING_TRIGGERED;
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +
> +error_iio_sw_rb_free:
> + =C2=A0 =C2=A0 =C2=A0 iio_sw_rb_free(indio_dev->ring);
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}
> +
> +int adis16240_initialize_ring(struct iio_ring_buffer *ring)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return iio_ring_buffer_register(ring, 0);
> +}
> +
> +void adis16240_uninitialize_ring(struct iio_ring_buffer *ring)
> +{
> + =C2=A0 =C2=A0 =C2=A0 iio_ring_buffer_unregister(ring);
> +}
> diff --git a/drivers/staging/iio/accel/adis16240_trigger.c b/drivers/=
staging/iio/accel/adis16240_trigger.c
> new file mode 100644
> index 0000000..df1312e
> --- /dev/null
> +++ b/drivers/staging/iio/accel/adis16240_trigger.c
> @@ -0,0 +1,124 @@
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/mutex.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/sysfs.h>
> +#include <linux/list.h>
> +#include <linux/spi/spi.h>
> +
> +#include "../iio.h"
> +#include "../sysfs.h"
> +#include "../trigger.h"
> +#include "adis16240.h"
> +
> +/**
> + * adis16240_data_rdy_trig_poll() the event handler for the data rdy=
 trig
> + **/
> +static int adis16240_data_rdy_trig_poll(struct iio_dev *dev_info,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int inde=
x,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s64 time=
stamp,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int no_t=
est)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct adis16240_state *st =3D iio_dev_get_dev=
data(dev_info);
> + =C2=A0 =C2=A0 =C2=A0 struct iio_trigger *trig =3D st->trig;
> +
> + =C2=A0 =C2=A0 =C2=A0 trig->timestamp =3D timestamp;
> + =C2=A0 =C2=A0 =C2=A0 iio_trigger_poll(trig);
> +
> + =C2=A0 =C2=A0 =C2=A0 return IRQ_HANDLED;
> +}
> +
> +IIO_EVENT_SH(data_rdy_trig, &adis16240_data_rdy_trig_poll);
> +
> +static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
> +
> +static struct attribute *adis16240_trigger_attrs[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 &dev_attr_name.attr,
> + =C2=A0 =C2=A0 =C2=A0 NULL,
> +};
> +
> +static const struct attribute_group adis16240_trigger_attr_group =3D=
 {
> + =C2=A0 =C2=A0 =C2=A0 .attrs =3D adis16240_trigger_attrs,
> +};
> +
> +/**
> + * adis16240_data_rdy_trigger_set_state() set datardy interrupt stat=
e
> + **/
> +static int adis16240_data_rdy_trigger_set_state(struct iio_trigger *=
trig,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 bool state)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct adis16240_state *st =3D trig->private_d=
ata;
> + =C2=A0 =C2=A0 =C2=A0 struct iio_dev *indio_dev =3D st->indio_dev;
> + =C2=A0 =C2=A0 =C2=A0 int ret =3D 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__=
, state);
> + =C2=A0 =C2=A0 =C2=A0 ret =3D adis16240_set_irq(&st->indio_dev->dev,=
 state);
> + =C2=A0 =C2=A0 =C2=A0 if (state =3D=3D false) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iio_remove_event_f=
rom_list(&iio_event_data_rdy_trig,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0&indio_dev->interrupts[0]
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0->ev_list);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flush_scheduled_wo=
rk();
> + =C2=A0 =C2=A0 =C2=A0 } else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iio_add_event_to_l=
ist(&iio_event_data_rdy_trig,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &indio_dev->in=
terrupts[0]->ev_list);
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}
> +
> +/**
> + * adis16240_trig_try_reen() try renabling irq for data rdy trigger
> + * @trig: =C2=A0 =C2=A0 =C2=A0the datardy trigger
> + **/
> +static int adis16240_trig_try_reen(struct iio_trigger *trig)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct adis16240_state *st =3D trig->private_d=
ata;
> + =C2=A0 =C2=A0 =C2=A0 enable_irq(st->us->irq);
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +int adis16240_probe_trigger(struct iio_dev *indio_dev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> + =C2=A0 =C2=A0 =C2=A0 struct adis16240_state *st =3D indio_dev->dev_=
data;
> +
> + =C2=A0 =C2=A0 =C2=A0 st->trig =3D iio_allocate_trigger();
> + =C2=A0 =C2=A0 =C2=A0 st->trig->name =3D kmalloc(IIO_TRIGGER_NAME_LE=
NGTH, GFP_KERNEL);
> + =C2=A0 =C2=A0 =C2=A0 if (!st->trig->name) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_free_tr=
ig;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 snprintf((char *)st->trig->name,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0IIO_TRIGGER_=
NAME_LENGTH,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"adis16240-d=
ev%d", indio_dev->id);
> + =C2=A0 =C2=A0 =C2=A0 st->trig->dev.parent =3D &st->us->dev;
> + =C2=A0 =C2=A0 =C2=A0 st->trig->owner =3D THIS_MODULE;
> + =C2=A0 =C2=A0 =C2=A0 st->trig->private_data =3D st;
> + =C2=A0 =C2=A0 =C2=A0 st->trig->set_trigger_state =3D &adis16240_dat=
a_rdy_trigger_set_state;
> + =C2=A0 =C2=A0 =C2=A0 st->trig->try_reenable =3D &adis16240_trig_try=
_reen;
> + =C2=A0 =C2=A0 =C2=A0 st->trig->control_attrs =3D &adis16240_trigger=
_attr_group;
> + =C2=A0 =C2=A0 =C2=A0 ret =3D iio_trigger_register(st->trig);
> +
> + =C2=A0 =C2=A0 =C2=A0 /* select default trigger */
> + =C2=A0 =C2=A0 =C2=A0 indio_dev->trig =3D st->trig;
> + =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_free_tr=
ig_name;
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +
> +error_free_trig_name:
> + =C2=A0 =C2=A0 =C2=A0 kfree(st->trig->name);
> +error_free_trig:
> + =C2=A0 =C2=A0 =C2=A0 iio_free_trigger(st->trig);
> +
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}
> +
> +void adis16240_remove_trigger(struct iio_dev *indio_dev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct adis16240_state *state =3D indio_dev->d=
ev_data;
> +
> + =C2=A0 =C2=A0 =C2=A0 iio_trigger_unregister(state->trig);
> + =C2=A0 =C2=A0 =C2=A0 kfree(state->trig->name);
> + =C2=A0 =C2=A0 =C2=A0 iio_free_trigger(state->trig);
> +}
> --
> 1.6.4.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
