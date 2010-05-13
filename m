Return-Path: <21cnbao@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1273697625-9685-2-git-send-email-jic23@cam.ac.uk>
References: <1273697625-9685-1-git-send-email-jic23@cam.ac.uk>
	<1273697625-9685-2-git-send-email-jic23@cam.ac.uk>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 13 May 2010 11:13:55 +0800
Message-ID: <AANLkTim-dZbKEPdfLrvl3WBjgcC1NVgVcfAwQtFtiP08@mail.gmail.com>
Subject: Re: [PATCH 1/2] staging:iio: adis16220 vibration sensor driver
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Barry Song <Barry.Song@analog.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Thu, May 13, 2010 at 4:53 AM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
> From: Barry Song <Barry.Song@analog.com>
>
Thanks! Jonathan.

Signed-off-by: Barry Song <Barry.Song@analog.com>

> ---
> =C2=A0drivers/staging/iio/accel/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| =C2=A0 =C2=A07 +
> =C2=A0drivers/staging/iio/accel/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =
=C2=A0 =C2=A03 +
> =C2=A0drivers/staging/iio/accel/accel.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| =C2=A0 =C2=A06 +
> =C2=A0drivers/staging/iio/accel/adis16220.h =C2=A0 =C2=A0 =C2=A0| =C2=A01=
50 +++++++
> =C2=A0drivers/staging/iio/accel/adis16220_core.c | =C2=A0664 ++++++++++++=
++++++++++++++++
> =C2=A05 files changed, 830 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/staging/iio/accel/Kconfig b/drivers/staging/iio/acce=
l/Kconfig
> index 8f3f70f..b4e57d1 100644
> --- a/drivers/staging/iio/accel/Kconfig
> +++ b/drivers/staging/iio/accel/Kconfig
> @@ -12,6 +12,13 @@ config ADIS16209
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Say yes here to build support for Analo=
g Devices adis16209 dual-axis digital inclinometer
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 and accelerometer.
>
> +config ADIS16220
> + =C2=A0 =C2=A0 =C2=A0 tristate "Analog Devices ADIS16220 Programmable Di=
gital Vibration Sensor driver"
> + =C2=A0 =C2=A0 =C2=A0 depends on SPI
> + =C2=A0 =C2=A0 =C2=A0 help
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 Say yes here to build support for Analog De=
vices adis16220 programmable
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 digital vibration sensor.
> +
> =C2=A0config ADIS16240
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tristate "Analog Devices ADIS16240 Programmabl=
e Impact Sensor and Recorder"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on SPI
> diff --git a/drivers/staging/iio/accel/Makefile b/drivers/staging/iio/acc=
el/Makefile
> index 0e6762c..c34b136 100644
> --- a/drivers/staging/iio/accel/Makefile
> +++ b/drivers/staging/iio/accel/Makefile
> @@ -5,6 +5,9 @@ adis16209-y =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :=
=3D adis16209_core.o
> =C2=A0adis16209-$(CONFIG_IIO_RING_BUFFER) +=3D adis16209_ring.o adis16209=
_trigger.o
> =C2=A0obj-$(CONFIG_ADIS16209) +=3D adis16209.o
>
> +adis16220-y =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :=3D adis16220_cor=
e.o
> +obj-$(CONFIG_ADIS16220) +=3D adis16220.o
> +
> =C2=A0adis16240-y =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :=3D adis1624=
0_core.o
> =C2=A0adis16240-$(CONFIG_IIO_RING_BUFFER) +=3D adis16240_ring.o adis16240=
_trigger.o
> =C2=A0obj-$(CONFIG_ADIS16240) +=3D adis16240.o
> diff --git a/drivers/staging/iio/accel/accel.h b/drivers/staging/iio/acce=
l/accel.h
> index 059209c..1b6e37f 100644
> --- a/drivers/staging/iio/accel/accel.h
> +++ b/drivers/staging/iio/accel/accel.h
> @@ -2,6 +2,9 @@
> =C2=A0#include "../sysfs.h"
>
> =C2=A0/* Accelerometer types of attribute */
> +#define IIO_DEV_ATTR_ACCEL_OFFSET(_mode, _show, _store, _addr) \
> + =C2=A0 =C2=A0 =C2=A0 IIO_DEVICE_ATTR(accel_offset, _mode, _show, _store=
, _addr)
> +
> =C2=A0#define IIO_DEV_ATTR_ACCEL_X_OFFSET(_mode, _show, _store, _addr) =
=C2=A0 =C2=A0 =C2=A0 \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0IIO_DEVICE_ATTR(accel_x_offset, _mode, _show, =
_store, _addr)
>
> @@ -20,6 +23,9 @@
> =C2=A0#define IIO_DEV_ATTR_ACCEL_Z_GAIN(_mode, _show, _store, _addr) =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0IIO_DEVICE_ATTR(accel_z_gain, _mode, _show, _s=
tore, _addr)
>
> +#define IIO_DEV_ATTR_ACCEL(_show, _addr) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> + =C2=A0 =C2=A0 =C2=A0 IIO_DEVICE_ATTR(accel_raw, S_IRUGO, _show, NULL, _=
addr)
> +
> =C2=A0#define IIO_DEV_ATTR_ACCEL_X(_show, _addr) =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0IIO_DEVICE_ATTR(accel_x_raw, S_IRUGO, _show, N=
ULL, _addr)
>
> diff --git a/drivers/staging/iio/accel/adis16220.h b/drivers/staging/iio/=
accel/adis16220.h
> new file mode 100644
> index 0000000..6b49f70
> --- /dev/null
> +++ b/drivers/staging/iio/accel/adis16220.h
> @@ -0,0 +1,150 @@
> +#ifndef SPI_ADIS16220_H_
> +#define SPI_ADIS16220_H_
> +
> +#define ADIS16220_STARTUP_DELAY =C2=A0 =C2=A0 =C2=A0 =C2=A0220 /* ms */
> +
> +#define ADIS16220_READ_REG(a) =C2=A0 =C2=A0a
> +#define ADIS16220_WRITE_REG(a) ((a) | 0x80)
> +
> +/* Flash memory write count */
> +#define ADIS16220_FLASH_CNT =C2=A0 =C2=A0 0x00
> +/* Control, acceleration offset adjustment control */
> +#define ADIS16220_ACCL_NULL =C2=A0 =C2=A0 0x02
> +/* Control, AIN1 offset adjustment control */
> +#define ADIS16220_AIN1_NULL =C2=A0 =C2=A0 0x04
> +/* Control, AIN2 offset adjustment control */
> +#define ADIS16220_AIN2_NULL =C2=A0 =C2=A0 0x06
> +/* Output, power supply during capture */
> +#define ADIS16220_CAPT_SUPPLY =C2=A0 0x0A
> +/* Output, temperature during capture */
> +#define ADIS16220_CAPT_TEMP =C2=A0 =C2=A0 0x0C
> +/* Output, peak acceleration during capture */
> +#define ADIS16220_CAPT_PEAKA =C2=A0 =C2=A00x0E
> +/* Output, peak AIN1 level during capture */
> +#define ADIS16220_CAPT_PEAK1 =C2=A0 =C2=A00x10
> +/* Output, peak AIN2 level during capture */
> +#define ADIS16220_CAPT_PEAK2 =C2=A0 =C2=A00x12
> +/* Output, capture buffer for acceleration */
> +#define ADIS16220_CAPT_BUFA =C2=A0 =C2=A0 0x14
> +/* Output, capture buffer for AIN1 */
> +#define ADIS16220_CAPT_BUF1 =C2=A0 =C2=A0 0x16
> +/* Output, capture buffer for AIN2 */
> +#define ADIS16220_CAPT_BUF2 =C2=A0 =C2=A0 0x18
> +/* Control, capture buffer address pointer */
> +#define ADIS16220_CAPT_PNTR =C2=A0 =C2=A0 0x1A
> +/* Control, capture control register */
> +#define ADIS16220_CAPT_CTRL =C2=A0 =C2=A0 0x1C
> +/* Control, capture period (automatic mode) */
> +#define ADIS16220_CAPT_PRD =C2=A0 =C2=A0 =C2=A00x1E
> +/* Control, Alarm A, acceleration peak threshold */
> +#define ADIS16220_ALM_MAGA =C2=A0 =C2=A0 =C2=A00x20
> +/* Control, Alarm 1, AIN1 peak threshold */
> +#define ADIS16220_ALM_MAG1 =C2=A0 =C2=A0 =C2=A00x22
> +/* Control, Alarm 2, AIN2 peak threshold */
> +#define ADIS16220_ALM_MAG2 =C2=A0 =C2=A0 =C2=A00x24
> +/* Control, Alarm S, peak threshold */
> +#define ADIS16220_ALM_MAGS =C2=A0 =C2=A0 =C2=A00x26
> +/* Control, alarm configuration register */
> +#define ADIS16220_ALM_CTRL =C2=A0 =C2=A0 =C2=A00x28
> +/* Control, general I/O configuration */
> +#define ADIS16220_GPIO_CTRL =C2=A0 =C2=A0 0x32
> +/* Control, self-test control, AIN configuration */
> +#define ADIS16220_MSC_CTRL =C2=A0 =C2=A0 =C2=A00x34
> +/* Control, digital I/O configuration */
> +#define ADIS16220_DIO_CTRL =C2=A0 =C2=A0 =C2=A00x36
> +/* Control, filter configuration */
> +#define ADIS16220_AVG_CNT =C2=A0 =C2=A0 =C2=A0 0x38
> +/* Status, system status */
> +#define ADIS16220_DIAG_STAT =C2=A0 =C2=A0 0x3C
> +/* Control, system commands */
> +#define ADIS16220_GLOB_CMD =C2=A0 =C2=A0 =C2=A00x3E
> +/* Status, self-test response */
> +#define ADIS16220_ST_DELTA =C2=A0 =C2=A0 =C2=A00x40
> +/* Lot Identification Code 1 */
> +#define ADIS16220_LOT_ID1 =C2=A0 =C2=A0 =C2=A0 0x52
> +/* Lot Identification Code 2 */
> +#define ADIS16220_LOT_ID2 =C2=A0 =C2=A0 =C2=A0 0x54
> +/* Product identifier; convert to decimal =3D 16220 */
> +#define ADIS16220_PROD_ID =C2=A0 =C2=A0 =C2=A0 0x56
> +/* Serial number */
> +#define ADIS16220_SERIAL_NUM =C2=A0 =C2=A00x58
> +
> +#define ADIS16220_CAPTURE_SIZE =C2=A02048
> +
> +/* MSC_CTRL */
> +#define ADIS16220_MSC_CTRL_SELF_TEST_EN =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0(1 << 8)
> +#define ADIS16220_MSC_CTRL_POWER_SUP_COM_AIN1 =C2=A0(1 << 1)
> +#define ADIS16220_MSC_CTRL_POWER_SUP_COM_AIN2 =C2=A0(1 << 0)
> +
> +/* DIO_CTRL */
> +#define ADIS16220_MSC_CTRL_DIO2_BUSY_IND =C2=A0 =C2=A0 (3<<4)
> +#define ADIS16220_MSC_CTRL_DIO1_BUSY_IND =C2=A0 =C2=A0 (3<<2)
> +#define ADIS16220_MSC_CTRL_DIO2_ACT_HIGH =C2=A0 =C2=A0 (1<<1)
> +#define ADIS16220_MSC_CTRL_DIO1_ACT_HIGH =C2=A0 =C2=A0 (1<<0)
> +
> +/* DIAG_STAT */
> +/* AIN2 sample > ALM_MAG2 */
> +#define ADIS16220_DIAG_STAT_ALM_MAG2 =C2=A0 =C2=A0(1<<14)
> +/* AIN1 sample > ALM_MAG1 */
> +#define ADIS16220_DIAG_STAT_ALM_MAG1 =C2=A0 =C2=A0(1<<13)
> +/* Acceleration sample > ALM_MAGA */
> +#define ADIS16220_DIAG_STAT_ALM_MAGA =C2=A0 =C2=A0(1<<12)
> +/* Error condition programmed into ALM_MAGS[11:0] and ALM_CTRL[5:4] is t=
rue */
> +#define ADIS16220_DIAG_STAT_ALM_MAGS =C2=A0 =C2=A0(1<<11)
> +/* |Peak value in AIN2 data capture| > ALM_MAG2 */
> +#define ADIS16220_DIAG_STAT_PEAK_AIN2 =C2=A0 (1<<10)
> +/* |Peak value in AIN1 data capture| > ALM_MAG1 */
> +#define ADIS16220_DIAG_STAT_PEAK_AIN1 =C2=A0 (1<<9)
> +/* |Peak value in acceleration data capture| > ALM_MAGA */
> +#define ADIS16220_DIAG_STAT_PEAK_ACCEL =C2=A0(1<<8)
> +/* Data ready, capture complete */
> +#define ADIS16220_DIAG_STAT_DATA_RDY =C2=A0 =C2=A0(1<<7)
> +#define ADIS16220_DIAG_STAT_FLASH_CHK =C2=A0(1<<6)
> +#define ADIS16220_DIAG_STAT_SELF_TEST =C2=A0(1<<5)
> +/* Capture period violation/interruption */
> +#define ADIS16220_DIAG_STAT_VIOLATION =C2=A0(1<<4)
> +/* SPI communications failure */
> +#define ADIS16220_DIAG_STAT_SPI_FAIL =C2=A0 (1<<3)
> +/* Flash update failure */
> +#define ADIS16220_DIAG_STAT_FLASH_UPT =C2=A0(1<<2)
> +/* Power supply above 3.625 V */
> +#define ADIS16220_DIAG_STAT_POWER_HIGH (1<<1)
> +/* Power supply below 3.15 V */
> +#define ADIS16220_DIAG_STAT_POWER_LOW =C2=A0(1<<0)
> +
> +/* GLOB_CMD */
> +#define ADIS16220_GLOB_CMD_SW_RESET =C2=A0 =C2=A0(1<<7)
> +#define ADIS16220_GLOB_CMD_SELF_TEST =C2=A0 (1<<2)
> +#define ADIS16220_GLOB_CMD_PWR_DOWN =C2=A0 =C2=A0(1<<1)
> +
> +#define ADIS16220_MAX_TX 2048
> +#define ADIS16220_MAX_RX 2048
> +
> +#define ADIS16220_SPI_BURST =C2=A0 =C2=A0(u32)(1000 * 1000)
> +#define ADIS16220_SPI_FAST =C2=A0 =C2=A0 (u32)(2000 * 1000)
> +
> +/**
> + * struct adis16220_state - device instance specific data
> + * @us: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0actual spi_device
> + * @work_trigger_to_ring: bh for triggered event handling
> + * @work_cont_thresh: CLEAN
> + * @inter: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 used to check if ne=
w interrupt has been triggered
> + * @last_timestamp: =C2=A0 =C2=A0passing timestamp from th to bh of inte=
rrupt handler
> + * @indio_dev: =C2=A0 =C2=A0 =C2=A0 =C2=A0 industrial I/O device structu=
re
> + * @trig: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data ready tri=
gger registered with iio
> + * @tx: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0transmit buffer
> + * @rx: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0recieve buffer
> + * @buf_lock: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex to protect tx and =
rx
> + **/
> +struct adis16220_state {
> + =C2=A0 =C2=A0 =C2=A0 struct spi_device =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 *us;
> + =C2=A0 =C2=A0 =C2=A0 struct iio_dev =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0*indio_dev;
> + =C2=A0 =C2=A0 =C2=A0 u8 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*tx;
> + =C2=A0 =C2=A0 =C2=A0 u8 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*rx;
> + =C2=A0 =C2=A0 =C2=A0 struct bin_attribute =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0accel_bin;
> + =C2=A0 =C2=A0 =C2=A0 struct bin_attribute =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0adc1_bin;
> + =C2=A0 =C2=A0 =C2=A0 struct bin_attribute =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0adc2_bin;
> + =C2=A0 =C2=A0 =C2=A0 struct mutex =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buf_lock;
> +};
> +
> +#endif /* SPI_ADIS16220_H_ */
> diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging=
/iio/accel/adis16220_core.c
> new file mode 100644
> index 0000000..8b845d9
> --- /dev/null
> +++ b/drivers/staging/iio/accel/adis16220_core.c
> @@ -0,0 +1,664 @@
> +/*
> + * ADIS16220 Programmable Digital Vibration Sensor driver
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
> +#include "adis16220.h"
> +
> +#define DRIVER_NAME =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"adis16220"
> +
> +static int adis16220_check_status(struct device *dev);
> +
> +/**
> + * adis16220_spi_write_reg_8() - write single byte to a register
> + * @dev: device associated with child of actual device (iio_dev or iio_t=
rig)
> + * @reg_address: the address of the register to be written
> + * @val: the value to write
> + **/
> +static int adis16220_spi_write_reg_8(struct device *dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 reg_address,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 val)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> + =C2=A0 =C2=A0 =C2=A0 struct iio_dev *indio_dev =3D dev_get_drvdata(dev)=
;
> + =C2=A0 =C2=A0 =C2=A0 struct adis16220_state *st =3D iio_dev_get_devdata=
(indio_dev);
> +
> + =C2=A0 =C2=A0 =C2=A0 mutex_lock(&st->buf_lock);
> + =C2=A0 =C2=A0 =C2=A0 st->tx[0] =3D ADIS16220_WRITE_REG(reg_address);
> + =C2=A0 =C2=A0 =C2=A0 st->tx[1] =3D val;
> +
> + =C2=A0 =C2=A0 =C2=A0 ret =3D spi_write(st->us, st->tx, 2);
> + =C2=A0 =C2=A0 =C2=A0 mutex_unlock(&st->buf_lock);
> +
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}
> +
> +/**
> + * adis16220_spi_write_reg_16() - write 2 bytes to a pair of registers
> + * @dev: device associated with child of actual device (iio_dev or iio_t=
rig)
> + * @reg_address: the address of the lower of the two registers. Second r=
egister
> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is assumed to have a=
ddress one greater.
> + * @val: value to be written
> + **/
> +static int adis16220_spi_write_reg_16(struct device *dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 lower_reg_address,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 value)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> + =C2=A0 =C2=A0 =C2=A0 struct spi_message msg;
> + =C2=A0 =C2=A0 =C2=A0 struct iio_dev *indio_dev =3D dev_get_drvdata(dev)=
;
> + =C2=A0 =C2=A0 =C2=A0 struct adis16220_state *st =3D iio_dev_get_devdata=
(indio_dev);
> + =C2=A0 =C2=A0 =C2=A0 struct spi_transfer xfers[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 .tx_buf =3D st->tx,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 .bits_per_word =3D 8,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 .len =3D 2,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 .cs_change =3D 1,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 .delay_usecs =3D 25,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }, {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 .tx_buf =3D st->tx + 2,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 .bits_per_word =3D 8,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 .len =3D 2,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 .cs_change =3D 1,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 .delay_usecs =3D 25,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 };
> +
> + =C2=A0 =C2=A0 =C2=A0 mutex_lock(&st->buf_lock);
> + =C2=A0 =C2=A0 =C2=A0 st->tx[0] =3D ADIS16220_WRITE_REG(lower_reg_addres=
s);
> + =C2=A0 =C2=A0 =C2=A0 st->tx[1] =3D value & 0xFF;
> + =C2=A0 =C2=A0 =C2=A0 st->tx[2] =3D ADIS16220_WRITE_REG(lower_reg_addres=
s + 1);
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
> + * adis16220_spi_read_reg_16() - read 2 bytes from a 16-bit register
> + * @dev: device associated with child of actual device (iio_dev or iio_t=
rig)
> + * @reg_address: the address of the lower of the two registers. Second r=
egister
> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is assumed to have a=
ddress one greater.
> + * @val: somewhere to pass back the value read
> + **/
> +static int adis16220_spi_read_reg_16(struct device *dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 lower_reg_address,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 *val)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct spi_message msg;
> + =C2=A0 =C2=A0 =C2=A0 struct iio_dev *indio_dev =3D dev_get_drvdata(dev)=
;
> + =C2=A0 =C2=A0 =C2=A0 struct adis16220_state *st =3D iio_dev_get_devdata=
(indio_dev);
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> + =C2=A0 =C2=A0 =C2=A0 struct spi_transfer xfers[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 .tx_buf =3D st->tx,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 .bits_per_word =3D 8,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 .len =3D 2,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 .cs_change =3D 1,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 .delay_usecs =3D 25,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }, {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 .rx_buf =3D st->rx,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 .bits_per_word =3D 8,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 .len =3D 2,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 .cs_change =3D 1,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 .delay_usecs =3D 25,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 };
> +
> + =C2=A0 =C2=A0 =C2=A0 mutex_lock(&st->buf_lock);
> + =C2=A0 =C2=A0 =C2=A0 st->tx[0] =3D ADIS16220_READ_REG(lower_reg_address=
);
> + =C2=A0 =C2=A0 =C2=A0 st->tx[1] =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 st->tx[2] =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 st->tx[3] =3D 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 spi_message_init(&msg);
> + =C2=A0 =C2=A0 =C2=A0 spi_message_add_tail(&xfers[0], &msg);
> + =C2=A0 =C2=A0 =C2=A0 spi_message_add_tail(&xfers[1], &msg);
> + =C2=A0 =C2=A0 =C2=A0 ret =3D spi_sync(st->us, &msg);
> + =C2=A0 =C2=A0 =C2=A0 if (ret) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&st->us->dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 "problem when reading 16 bit register 0x%02X",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
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
> +static ssize_t adis16220_spi_read_signed(struct device *dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct device_attribut=
e *attr,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *buf,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned bits)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> + =C2=A0 =C2=A0 =C2=A0 s16 val =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 unsigned shift =3D 16 - bits;
> + =C2=A0 =C2=A0 =C2=A0 struct iio_dev_attr *this_attr =3D to_iio_dev_attr=
(attr);
> +
> + =C2=A0 =C2=A0 =C2=A0 ret =3D adis16220_spi_read_reg_16(dev, this_attr->=
address, (u16 *)&val);
> + =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 val =3D ((s16)(val << shift) >> shift);
> + =C2=A0 =C2=A0 =C2=A0 return sprintf(buf, "%d\n", val);
> +}
> +
> +static ssize_t adis16220_read_12bit_unsigned(struct device *dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct device_attribut=
e *attr,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *buf)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> + =C2=A0 =C2=A0 =C2=A0 u16 val =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 struct iio_dev_attr *this_attr =3D to_iio_dev_attr=
(attr);
> +
> + =C2=A0 =C2=A0 =C2=A0 ret =3D adis16220_spi_read_reg_16(dev, this_attr->=
address, &val);
> + =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 return sprintf(buf, "%u\n", val & 0x0FFF);
> +}
> +
> +static ssize_t adis16220_read_16bit(struct device *dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct device_attribut=
e *attr,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *buf)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct iio_dev *indio_dev =3D dev_get_drvdata(dev)=
;
> + =C2=A0 =C2=A0 =C2=A0 ssize_t ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Take the iio_dev status lock */
> + =C2=A0 =C2=A0 =C2=A0 mutex_lock(&indio_dev->mlock);
> + =C2=A0 =C2=A0 =C2=A0 ret =3D =C2=A0adis16220_spi_read_signed(dev, attr,=
 buf, 16);
> + =C2=A0 =C2=A0 =C2=A0 mutex_unlock(&indio_dev->mlock);
> +
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}
> +
> +static ssize_t adis16220_write_16bit(struct device *dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct device_attribut=
e *attr,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *buf,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t len)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct iio_dev_attr *this_attr =3D to_iio_dev_attr=
(attr);
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> + =C2=A0 =C2=A0 =C2=A0 long val;
> +
> + =C2=A0 =C2=A0 =C2=A0 ret =3D strict_strtol(buf, 10, &val);
> + =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_ret;
> + =C2=A0 =C2=A0 =C2=A0 ret =3D adis16220_spi_write_reg_16(dev, this_attr-=
>address, val);
> +
> +error_ret:
> + =C2=A0 =C2=A0 =C2=A0 return ret ? ret : len;
> +}
> +
> +static int adis16220_capture(struct device *dev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> + =C2=A0 =C2=A0 =C2=A0 ret =3D adis16220_spi_write_reg_16(dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ADIS16220_GLOB_CMD,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 0xBF08); /* initiates a manual data capture */
> + =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "problem =
beginning capture");
> +
> + =C2=A0 =C2=A0 =C2=A0 msleep(10); /* delay for capture to finish */
> +
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}
> +
> +static int adis16220_reset(struct device *dev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> + =C2=A0 =C2=A0 =C2=A0 ret =3D adis16220_spi_write_reg_8(dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ADIS16220_GLOB_CMD,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ADIS16220_GLOB_CMD_SW_RESET);
> + =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "problem =
resetting device");
> +
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}
> +
> +static ssize_t adis16220_write_reset(struct device *dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct device_attribut=
e *attr,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *buf, size_=
t len)
> +{
> + =C2=A0 =C2=A0 =C2=A0 if (len < 1)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;
> + =C2=A0 =C2=A0 =C2=A0 switch (buf[0]) {
> + =C2=A0 =C2=A0 =C2=A0 case '1':
> + =C2=A0 =C2=A0 =C2=A0 case 'y':
> + =C2=A0 =C2=A0 =C2=A0 case 'Y':
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return adis16220_reset=
(dev) =3D=3D 0 ? len : -EIO;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 return -1;
> +}
> +
> +static ssize_t adis16220_write_capture(struct device *dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct device_attribut=
e *attr,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *buf, size_=
t len)
> +{
> + =C2=A0 =C2=A0 =C2=A0 if (len < 1)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;
> + =C2=A0 =C2=A0 =C2=A0 switch (buf[0]) {
> + =C2=A0 =C2=A0 =C2=A0 case '1':
> + =C2=A0 =C2=A0 =C2=A0 case 'y':
> + =C2=A0 =C2=A0 =C2=A0 case 'Y':
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return adis16220_captu=
re(dev) =3D=3D 0 ? len : -EIO;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 return -1;
> +}
> +
> +static int adis16220_self_test(struct device *dev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> + =C2=A0 =C2=A0 =C2=A0 ret =3D adis16220_spi_write_reg_16(dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ADIS16220_MSC_CTRL,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ADIS16220_MSC_CTRL_SELF_TEST_EN);
> + =C2=A0 =C2=A0 =C2=A0 if (ret) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "problem =
starting self test");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_ret;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 adis16220_check_status(dev);
> +
> +err_ret:
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}
> +
> +static int adis16220_check_status(struct device *dev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 u16 status;
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 ret =3D adis16220_spi_read_reg_16(dev, ADIS16220_D=
IAG_STAT, &status);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (ret < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "Reading =
status failed\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_ret;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 ret =3D status & 0x7F;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (status & ADIS16220_DIAG_STAT_VIOLATION)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "Capture =
period violation/interruption\n");
> + =C2=A0 =C2=A0 =C2=A0 if (status & ADIS16220_DIAG_STAT_SPI_FAIL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "SPI fail=
ure\n");
> + =C2=A0 =C2=A0 =C2=A0 if (status & ADIS16220_DIAG_STAT_FLASH_UPT)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "Flash up=
date failed\n");
> + =C2=A0 =C2=A0 =C2=A0 if (status & ADIS16220_DIAG_STAT_POWER_HIGH)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "Power su=
pply above 5.25V\n");
> + =C2=A0 =C2=A0 =C2=A0 if (status & ADIS16220_DIAG_STAT_POWER_LOW)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "Power su=
pply below 4.75V\n");
> +
> +error_ret:
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}
> +
> +static int adis16220_initial_setup(struct adis16220_state *st)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> + =C2=A0 =C2=A0 =C2=A0 struct device *dev =3D &st->indio_dev->dev;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Do self test */
> + =C2=A0 =C2=A0 =C2=A0 ret =3D adis16220_self_test(dev);
> + =C2=A0 =C2=A0 =C2=A0 if (ret) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "self tes=
t failure");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_ret;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Read status register to check the result */
> + =C2=A0 =C2=A0 =C2=A0 ret =3D adis16220_check_status(dev);
> + =C2=A0 =C2=A0 =C2=A0 if (ret) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adis16220_reset(dev);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "device n=
ot playing ball -> reset");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msleep(ADIS16220_START=
UP_DELAY);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D adis16220_chec=
k_status(dev);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 dev_err(dev, "giving up");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 goto err_ret;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 printk(KERN_INFO DRIVER_NAME ": at CS%d (irq %d)\n=
",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 st->us->chip_select, st->us->irq);
> +
> +err_ret:
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}
> +
> +static ssize_t adis16220_capture_buffer_read(struct adis16220_state *st,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *buf,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 loff_t off,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t count=
,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int addr)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct spi_message msg;
> + =C2=A0 =C2=A0 =C2=A0 struct spi_transfer xfers[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 .tx_buf =3D st->tx,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 .bits_per_word =3D 8,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 .len =3D 2,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 .cs_change =3D 1,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 .delay_usecs =3D 25,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }, {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 .tx_buf =3D st->tx,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 .rx_buf =3D st->rx,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 .bits_per_word =3D 8,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 .cs_change =3D 1,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 .delay_usecs =3D 25,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 };
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> + =C2=A0 =C2=A0 =C2=A0 int i;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (unlikely(!count))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return count;
> +
> + =C2=A0 =C2=A0 =C2=A0 if ((off >=3D ADIS16220_CAPTURE_SIZE) || (count & =
1) || (off & 1))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (off + count > ADIS16220_CAPTURE_SIZE)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 count =3D ADIS16220_CA=
PTURE_SIZE - off;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* write the begin position of capture buffer */
> + =C2=A0 =C2=A0 =C2=A0 ret =3D adis16220_spi_write_reg_16(&st->indio_dev-=
>dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADIS16220_CA=
PT_PNTR,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 off > 1);
> + =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EIO;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* read count/2 values from capture buffer */
> + =C2=A0 =C2=A0 =C2=A0 mutex_lock(&st->buf_lock);
> +
> + =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < count; i +=3D 2) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 st->tx[i] =3D ADIS1622=
0_READ_REG(addr);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 st->tx[i + 1] =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 xfers[1].len =3D count;
> +
> + =C2=A0 =C2=A0 =C2=A0 spi_message_init(&msg);
> + =C2=A0 =C2=A0 =C2=A0 spi_message_add_tail(&xfers[0], &msg);
> + =C2=A0 =C2=A0 =C2=A0 spi_message_add_tail(&xfers[1], &msg);
> + =C2=A0 =C2=A0 =C2=A0 ret =3D spi_sync(st->us, &msg);
> + =C2=A0 =C2=A0 =C2=A0 if (ret) {
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_unlock(&st->buf_=
lock);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EIO;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 memcpy(buf, st->rx, count);
> +
> + =C2=A0 =C2=A0 =C2=A0 mutex_unlock(&st->buf_lock);
> + =C2=A0 =C2=A0 =C2=A0 return count;
> +}
> +
> +static ssize_t adis16220_accel_bin_read(struct kobject *kobj,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct bin_a=
ttribute *attr,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *buf,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 loff_t off,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t count=
)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct device *dev =3D container_of(kobj, struct d=
evice, kobj);
> + =C2=A0 =C2=A0 =C2=A0 struct iio_dev *indio_dev =3D dev_get_drvdata(dev)=
;
> + =C2=A0 =C2=A0 =C2=A0 struct adis16220_state *st =3D iio_dev_get_devdata=
(indio_dev);
> +
> + =C2=A0 =C2=A0 =C2=A0 return adis16220_capture_buffer_read(st, buf,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 off, count,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADIS16220_CA=
PT_BUFA);
> +}
> +
> +static ssize_t adis16220_adc1_bin_read(struct kobject *kobj,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct bin_attribute *attr,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *buf, loff_t off,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t count)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct device *dev =3D container_of(kobj, struct d=
evice, kobj);
> + =C2=A0 =C2=A0 =C2=A0 struct iio_dev *indio_dev =3D dev_get_drvdata(dev)=
;
> + =C2=A0 =C2=A0 =C2=A0 struct adis16220_state *st =3D iio_dev_get_devdata=
(indio_dev);
> +
> + =C2=A0 =C2=A0 =C2=A0 return adis16220_capture_buffer_read(st, buf,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 off, count,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADIS16220_CA=
PT_BUF1);
> +}
> +
> +static ssize_t adis16220_adc2_bin_read(struct kobject *kobj,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct bin_attribute *attr,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *buf, loff_t off,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t count)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct device *dev =3D container_of(kobj, struct d=
evice, kobj);
> + =C2=A0 =C2=A0 =C2=A0 struct iio_dev *indio_dev =3D dev_get_drvdata(dev)=
;
> + =C2=A0 =C2=A0 =C2=A0 struct adis16220_state *st =3D iio_dev_get_devdata=
(indio_dev);
> +
> + =C2=A0 =C2=A0 =C2=A0 return adis16220_capture_buffer_read(st, buf,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 off, count,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADIS16220_CA=
PT_BUF2);
> +}
> +
> +static IIO_DEV_ATTR_IN_NAMED_RAW(supply, adis16220_read_12bit_unsigned,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADIS16220_CAPT_SUPPLY)=
;
> +static IIO_CONST_ATTR(in_supply_scale, "0.0012207");
> +static IIO_DEV_ATTR_ACCEL(adis16220_read_16bit, ADIS16220_CAPT_BUFA);
> +static IIO_DEVICE_ATTR(accel_peak_raw, S_IRUGO, adis16220_read_16bit,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, ADIS16220_CAPT_P=
EAKA);
> +static IIO_DEV_ATTR_ACCEL_OFFSET(S_IWUSR | S_IRUGO,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adis16220_read_16bit,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adis16220_write_16bit,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADIS16220_ACCL_NULL);
> +static IIO_DEV_ATTR_TEMP_RAW(adis16220_read_12bit_unsigned);
> +static IIO_CONST_ATTR(temp_offset, "25");
> +static IIO_CONST_ATTR(temp_scale, "-0.47");
> +
> +static IIO_DEV_ATTR_IN_RAW(0, adis16220_read_16bit, ADIS16220_CAPT_BUF1)=
;
> +static IIO_DEV_ATTR_IN_RAW(1, adis16220_read_16bit, ADIS16220_CAPT_BUF2)=
;
> +
> +static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adis16220_write_reset,=
 0);
> +
> +#define IIO_DEV_ATTR_CAPTURE(_store) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> + =C2=A0 =C2=A0 =C2=A0 IIO_DEVICE_ATTR(capture, S_IWUGO, NULL, _store, 0)
> +
> +static IIO_DEV_ATTR_CAPTURE(adis16220_write_capture);
> +
> +#define IIO_DEV_ATTR_CAPTURE_COUNT(_mode, _show, _store, _addr) =C2=A0 =
=C2=A0 =C2=A0 =C2=A0\
> + =C2=A0 =C2=A0 =C2=A0 IIO_DEVICE_ATTR(capture_count, _mode, _show, _stor=
e, _addr)
> +
> +static IIO_DEV_ATTR_CAPTURE_COUNT(S_IWUSR | S_IRUGO,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adis16220_read_16bit,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adis16220_write_16bit,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADIS16220_CAPT_PNTR);
> +
> +static IIO_CONST_ATTR_AVAIL_SAMP_FREQ("100200");
> +
> +static IIO_CONST_ATTR(name, "adis16220");
> +
> +static struct attribute *adis16220_attributes[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 &iio_dev_attr_in_supply_raw.dev_attr.attr,
> + =C2=A0 =C2=A0 =C2=A0 &iio_const_attr_in_supply_scale.dev_attr.attr,
> + =C2=A0 =C2=A0 =C2=A0 &iio_dev_attr_accel_raw.dev_attr.attr,
> + =C2=A0 =C2=A0 =C2=A0 &iio_dev_attr_accel_offset.dev_attr.attr,
> + =C2=A0 =C2=A0 =C2=A0 &iio_dev_attr_accel_peak_raw.dev_attr.attr,
> + =C2=A0 =C2=A0 =C2=A0 &iio_dev_attr_temp_raw.dev_attr.attr,
> + =C2=A0 =C2=A0 =C2=A0 &iio_dev_attr_in0_raw.dev_attr.attr,
> + =C2=A0 =C2=A0 =C2=A0 &iio_dev_attr_in1_raw.dev_attr.attr,
> + =C2=A0 =C2=A0 =C2=A0 &iio_const_attr_temp_offset.dev_attr.attr,
> + =C2=A0 =C2=A0 =C2=A0 &iio_const_attr_temp_scale.dev_attr.attr,
> + =C2=A0 =C2=A0 =C2=A0 &iio_const_attr_available_sampling_frequency.dev_a=
ttr.attr,
> + =C2=A0 =C2=A0 =C2=A0 &iio_dev_attr_reset.dev_attr.attr,
> + =C2=A0 =C2=A0 =C2=A0 &iio_dev_attr_capture.dev_attr.attr,
> + =C2=A0 =C2=A0 =C2=A0 &iio_dev_attr_capture_count.dev_attr.attr,
> + =C2=A0 =C2=A0 =C2=A0 &iio_const_attr_name.dev_attr.attr,
> + =C2=A0 =C2=A0 =C2=A0 NULL
> +};
> +
> +static const struct attribute_group adis16220_attribute_group =3D {
> + =C2=A0 =C2=A0 =C2=A0 .attrs =3D adis16220_attributes,
> +};
> +
> +static int __devinit adis16220_probe(struct spi_device *spi)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int ret, regdone =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 struct adis16220_state *st =3D kzalloc(sizeof *st,=
 GFP_KERNEL);
> + =C2=A0 =C2=A0 =C2=A0 if (!st) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D =C2=A0-ENOMEM;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_ret;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 /* this is only used for removal purposes */
> + =C2=A0 =C2=A0 =C2=A0 spi_set_drvdata(spi, st);
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Allocate the comms buffers */
> + =C2=A0 =C2=A0 =C2=A0 st->rx =3D kzalloc(sizeof(*st->rx)*ADIS16220_MAX_R=
X, GFP_KERNEL);
> + =C2=A0 =C2=A0 =C2=A0 if (st->rx =3D=3D NULL) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_free_st;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 st->tx =3D kzalloc(sizeof(*st->tx)*ADIS16220_MAX_T=
X, GFP_KERNEL);
> + =C2=A0 =C2=A0 =C2=A0 if (st->tx =3D=3D NULL) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_free_rx;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 st->us =3D spi;
> + =C2=A0 =C2=A0 =C2=A0 mutex_init(&st->buf_lock);
> + =C2=A0 =C2=A0 =C2=A0 /* setup the industrialio driver allocated element=
s */
> + =C2=A0 =C2=A0 =C2=A0 st->indio_dev =3D iio_allocate_device();
> + =C2=A0 =C2=A0 =C2=A0 if (st->indio_dev =3D=3D NULL) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_free_tx;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 st->indio_dev->dev.parent =3D &spi->dev;
> + =C2=A0 =C2=A0 =C2=A0 st->indio_dev->attrs =3D &adis16220_attribute_grou=
p;
> + =C2=A0 =C2=A0 =C2=A0 st->indio_dev->dev_data =3D (void *)(st);
> + =C2=A0 =C2=A0 =C2=A0 st->indio_dev->driver_module =3D THIS_MODULE;
> + =C2=A0 =C2=A0 =C2=A0 st->indio_dev->modes =3D INDIO_DIRECT_MODE;
> +
> + =C2=A0 =C2=A0 =C2=A0 ret =3D iio_device_register(st->indio_dev);
> + =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_free_dev;
> + =C2=A0 =C2=A0 =C2=A0 regdone =3D 1;
> +
> + =C2=A0 =C2=A0 =C2=A0 st->accel_bin.attr.name =3D "accel_bin";
> + =C2=A0 =C2=A0 =C2=A0 st->accel_bin.attr.mode =3D S_IRUGO;
> + =C2=A0 =C2=A0 =C2=A0 st->accel_bin.attr.owner =3D THIS_MODULE;
> + =C2=A0 =C2=A0 =C2=A0 st->accel_bin.read =3D adis16220_accel_bin_read;
> + =C2=A0 =C2=A0 =C2=A0 st->accel_bin.size =3D ADIS16220_CAPTURE_SIZE;
> +
> + =C2=A0 =C2=A0 =C2=A0 ret =3D sysfs_create_bin_file(&st->indio_dev->dev.=
kobj, &st->accel_bin);
> + =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_free_dev;
> +
> + =C2=A0 =C2=A0 =C2=A0 st->adc1_bin.attr.name =3D "adc1_bin";
> + =C2=A0 =C2=A0 =C2=A0 st->adc1_bin.attr.mode =3D S_IRUGO;
> + =C2=A0 =C2=A0 =C2=A0 st->adc1_bin.attr.owner =3D THIS_MODULE;
> + =C2=A0 =C2=A0 =C2=A0 st->adc1_bin.read =3D adis16220_adc1_bin_read;
> + =C2=A0 =C2=A0 =C2=A0 st->adc1_bin.size =3D ADIS16220_CAPTURE_SIZE;
> +
> + =C2=A0 =C2=A0 =C2=A0 ret =3D sysfs_create_bin_file(&st->indio_dev->dev.=
kobj, &st->adc1_bin);
> + =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_rm_accel_bi=
n;
> +
> + =C2=A0 =C2=A0 =C2=A0 st->adc2_bin.attr.name =3D "adc2_bin";
> + =C2=A0 =C2=A0 =C2=A0 st->adc2_bin.attr.mode =3D S_IRUGO;
> + =C2=A0 =C2=A0 =C2=A0 st->adc2_bin.attr.owner =3D THIS_MODULE;
> + =C2=A0 =C2=A0 =C2=A0 st->adc2_bin.read =3D adis16220_adc2_bin_read;
> + =C2=A0 =C2=A0 =C2=A0 st->adc2_bin.size =3D ADIS16220_CAPTURE_SIZE;
> +
> + =C2=A0 =C2=A0 =C2=A0 ret =3D sysfs_create_bin_file(&st->indio_dev->dev.=
kobj, &st->adc2_bin);
> + =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_rm_adc1_bin=
;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Get the device into a sane initial state */
> + =C2=A0 =C2=A0 =C2=A0 ret =3D adis16220_initial_setup(st);
> + =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_rm_adc2_bin=
;
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +
> +error_rm_adc2_bin:
> + =C2=A0 =C2=A0 =C2=A0 sysfs_remove_bin_file(&st->indio_dev->dev.kobj, &s=
t->adc2_bin);
> +error_rm_adc1_bin:
> + =C2=A0 =C2=A0 =C2=A0 sysfs_remove_bin_file(&st->indio_dev->dev.kobj, &s=
t->adc1_bin);
> +error_rm_accel_bin:
> + =C2=A0 =C2=A0 =C2=A0 sysfs_remove_bin_file(&st->indio_dev->dev.kobj, &s=
t->accel_bin);
> +error_free_dev:
> + =C2=A0 =C2=A0 =C2=A0 if (regdone)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iio_device_unregister(=
st->indio_dev);
> + =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iio_free_device(st->in=
dio_dev);
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
> +static int adis16220_remove(struct spi_device *spi)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct adis16220_state *st =3D spi_get_drvdata(spi=
);
> + =C2=A0 =C2=A0 =C2=A0 struct iio_dev *indio_dev =3D st->indio_dev;
> +
> + =C2=A0 =C2=A0 =C2=A0 flush_scheduled_work();
> +
> + =C2=A0 =C2=A0 =C2=A0 sysfs_remove_bin_file(&st->indio_dev->dev.kobj, &s=
t->adc2_bin);
> + =C2=A0 =C2=A0 =C2=A0 sysfs_remove_bin_file(&st->indio_dev->dev.kobj, &s=
t->adc1_bin);
> + =C2=A0 =C2=A0 =C2=A0 sysfs_remove_bin_file(&st->indio_dev->dev.kobj, &s=
t->accel_bin);
> + =C2=A0 =C2=A0 =C2=A0 iio_device_unregister(indio_dev);
> + =C2=A0 =C2=A0 =C2=A0 kfree(st->tx);
> + =C2=A0 =C2=A0 =C2=A0 kfree(st->rx);
> + =C2=A0 =C2=A0 =C2=A0 kfree(st);
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +static struct spi_driver adis16220_driver =3D {
> + =C2=A0 =C2=A0 =C2=A0 .driver =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D "adis16220",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .owner =3D THIS_MODULE=
,
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 .probe =3D adis16220_probe,
> + =C2=A0 =C2=A0 =C2=A0 .remove =3D __devexit_p(adis16220_remove),
> +};
> +
> +static __init int adis16220_init(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return spi_register_driver(&adis16220_driver);
> +}
> +module_init(adis16220_init);
> +
> +static __exit void adis16220_exit(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 spi_unregister_driver(&adis16220_driver);
> +}
> +module_exit(adis16220_exit);
> +
> +MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> +MODULE_DESCRIPTION("Analog Devices ADIS16220 Digital Vibration Sensor");
> +MODULE_LICENSE("GPL v2");
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
>
