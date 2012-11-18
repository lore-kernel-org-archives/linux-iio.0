Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59439 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900Ab2KRNUJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 18 Nov 2012 08:20:09 -0500
Message-ID: <50A8E083.1050908@kernel.org>
Date: Sun, 18 Nov 2012 13:20:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: Denis Ciocca <denis.ciocca@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
	Pavel Machek <pavel@denx.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"burman.yan@gmail.com" <burman.yan@gmail.com>
Subject: Re: STMicroelectronics accelerometers driver.
References: <5072F3B9.4050309@st.com> <5073260C.3010506@metafoo.de> <20121008195007.GA32042@elf.ucw.cz> <507338B5.60307@metafoo.de> <665718a4-de6b-4d09-ba80-35705fcf2595@email.android.com> <CAEE_umojW5OyB3yGgE54wH7_k__dBu9=Yew_0tCCf5--=C2g5g@mail.gmail.com> <507D9EA3.4070009@metafoo.de> <5085128C.7020507@st.com> <50858B44.2080006@kernel.org> <5087E2A8.4070304@st.com> <508A7DA6.7050505@metafoo.de> <508E4492.8080000@st.com> <508E48D1.3000703@metafoo.de> <508E5978.5000907@st.com> <508E5AD5.1040907@metafoo.de> <50914366.4090000@st.com> <5091546D.9000601@metafoo.de> <CAEE_umoKvv9ciBfUSahDqsmcbHi9W=93o5YSpE-vxUduCmqWSQ@mail.gmail.com> <50982F71.3060606@kernel.org> <5098F065.1090009@st.com> <50A12D8C.6040207@st.com> <50A14485.2060902@kernel.org> <50A26967.4050102@st.com>
In-Reply-To: <50A26967.4050102@st.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/13/2012 03:38 PM, Denis CIOCCA wrote:
> Hi Jonathan,
>
> I have reviewed my code and I applied your stylish comment to decrease
> the lines number of the code.
> For now I also deleted the platform_data, I will do this in a future patch.
>
> I attached to you the new patch, if the code is ok I will send this with
> git.
>
> Thanks,
>
> Denis
>
Hi Denis,

I'm sorry but I'd missed one big issue with the spi support before.
For spi dma requirements mean that the buffers MUST sit in their
own cachelines or you will sometimes randomly corrupt nearby memory.

The code to allow individual channels to be disabled for buffering
turned out more complex than I expected.  Perhaps with hindsight
grabbing them all and letting the core handle demuxing the data
flow would have been cleaner.  Never mind though. What you have
is correct and a valid solution so lets stay with it!

Couple of other nitpicks inline.

Jonathan
>
>
>
>  From 8bb6479aa8814ad4b82c359a0aaea99b04a7ecef Mon Sep 17 00:00:00 2001
> From: Denis Ciocca <denis.ciocca@st.com>
> Date: Mon, 22 Oct 2012 11:17:27 +0200
> Subject: [PATCH] iio:accel: Add STMicroelectronics accelerometers driver
>
> This patch adds generic accelerometer driver for STMicroelectronics
> accelerometers, currently it supports:
> LSM303DLH, LSM303DLHC, LIS3DH, LSM330D, LSM330DL, LSM330DLC, LSM303D,
> LSM9DS0, LIS331DLH, LSM303DL, LSM303DLM, LSM330
>
> Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
> ---
>   Documentation/ABI/testing/sysfs-bus-iio-accel-st |    7 +
>   drivers/iio/accel/Kconfig                        |   37 +
>   drivers/iio/accel/Makefile                       |    6 +
>   drivers/iio/accel/st_accel_buffer.c              |  176 ++++
>   drivers/iio/accel/st_accel_core.c                | 1154
> ++++++++++++++++++++++
>   drivers/iio/accel/st_accel_i2c.c                 |  128 +++
>   drivers/iio/accel/st_accel_spi.c                 |  186 ++++
>   drivers/iio/accel/st_accel_trigger.c             |   83 ++
>   include/linux/iio/accel/st_accel.h               |  102 ++
>   9 files changed, 1879 insertions(+), 0 deletions(-)
>   create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-accel-st
>   create mode 100644 drivers/iio/accel/st_accel_buffer.c
>   create mode 100644 drivers/iio/accel/st_accel_core.c
>   create mode 100644 drivers/iio/accel/st_accel_i2c.c
>   create mode 100644 drivers/iio/accel/st_accel_spi.c
>   create mode 100644 drivers/iio/accel/st_accel_trigger.c
>   create mode 100644 include/linux/iio/accel/st_accel.h
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-accel-st
> b/Documentation/ABI/testing/sysfs-bus-iio-accel-st
> new file mode 100644
> index 0000000..f426c02
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-accel-st
> @@ -0,0 +1,7 @@
> +What:          /sys/bus/iio/devices/iio:deviceX/powerdown
> +KernelVersion: 3.7.0
> +Contact:       linux-iio@vger.kernel.org
> +Description:
> +               Reading returns either '1' or '0'.
> +               '1' means that the device in question is off.
> +               '0' means that the devices in question is on.
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index b2510c4..d65e66a 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -13,4 +13,41 @@ config HID_SENSOR_ACCEL_3D
>           Say yes here to build support for the HID SENSOR
>           accelerometers 3D.
>
> +config ST_ACCEL_3AXIS
> +       tristate "STMicroelectronics accelerometers 3-Axis Driver"
> +       depends on (I2C || SPI) && SYSFS
> +       help
> +         Say yes here to build support for STMicroelectronics accelerometers:
> +         LSM303DLH, LSM303DLHC, LIS3DH, LSM330D, LSM330DL, LSM330DLC, LSM303D,
> +         LSM9DS0, LIS331DLH, LSM303DL, LSM303DLM, LSM330.
> +
> +         This driver can also be built as a module. If so, the module
> +         will be called st_accel.
> +
> +config ST_ACCEL_3AXIS_I2C
> +       tristate "support I2C bus connection"
> +       depends on ST_ACCEL_3AXIS && I2C
> +       help
> +         Say yes here to build I2C support for STMicroelectronics accelerometers.
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called st_accel_i2c.
> +
> +config ST_ACCEL_3AXIS_SPI
> +       tristate "support SPI bus connection"
> +       depends on ST_ACCEL_3AXIS && SPI_MASTER
> +       help
> +         Say yes here to build SPI support for STMicroelectronics accelerometers.
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called st_accel_spi.
> +
> +config ST_ACCEL_3AXIS_TRIGGERED_BUFFER
> +       tristate "support triggered buffer"
> +       depends on ST_ACCEL_3AXIS
> +       select IIO_TRIGGERED_BUFFER
> +       select IIO_BUFFER
> +       help
> +         Default trigger and buffer for STMicroelectronics accelerometers driver.
> +
>   endmenu
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index 5bc6855..1541236 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -3,3 +3,9 @@
>   #
>
>   obj-$(CONFIG_HID_SENSOR_ACCEL_3D) += hid-sensor-accel-3d.o
> +
> +st_accel-y := st_accel_core.o
> +obj-$(CONFIG_ST_ACCEL_3AXIS_I2C) += st_accel_i2c.o
> +obj-$(CONFIG_ST_ACCEL_3AXIS_SPI) += st_accel_spi.o
> +obj-$(CONFIG_ST_ACCEL_3AXIS_TRIGGERED_BUFFER) += st_accel_trigger.o
> st_accel_buffer.o
> +obj-$(CONFIG_ST_ACCEL_3AXIS) += st_accel.o
> diff --git a/drivers/iio/accel/st_accel_buffer.c
> b/drivers/iio/accel/st_accel_buffer.c
> new file mode 100644
> index 0000000..af5d333
> --- /dev/null
> +++ b/drivers/iio/accel/st_accel_buffer.c
> @@ -0,0 +1,176 @@
> +/*
> + * STMicroelectronics accelerometers driver
> + *
> + * Copyright 2012 STMicroelectronics Inc.
> + *
> + * Denis Ciocca <denis.ciocca@st.com>
> + *
> + * Licensed under the GPL-2.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/stat.h>
> +#include <linux/interrupt.h>
> +#include <linux/byteorder/generic.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
> +#include <linux/iio/accel/st_accel.h>
> +
> +
> +#define ST_ACCEL_ENABLE_ALL_CHANNELS           0x07
> +
This probably wants renaming as it isn't reading all any more.
It's also only called from one place, I'd squish the code in there
and drop this additional function.
> +static int st_accel_read_all(struct iio_dev *indio_dev, u8 *rx_array)
> +{
> +       int len = 0, i, n = 0;
> +       u8 reg_addr[ST_ACCEL_NUMBER_DATA_CHANNELS];
> +       struct st_accel_data *adata = iio_priv(indio_dev);
> +
> +       for (i = 0; i < ST_ACCEL_NUMBER_DATA_CHANNELS; i++) {
> +               if (test_bit(i, indio_dev->active_scan_mask)) {
> +                       reg_addr[n] = indio_dev->channels[i].address;
Normally this would be set up in the update_scan_mode callback - but given
the complexity here I suppose it doesn't really matter.
> +                       n++;
> +               }
> +       }
> +       switch (n) {
> +       case 1:
> +               len = adata->read_multiple_byte(adata, reg_addr[0],
> +                                       ST_ACCEL_BYTE_FOR_CHANNEL, rx_array);
> +               break;
> +       case 2:
> +               if ((reg_addr[1] - reg_addr[0]) == ST_ACCEL_BYTE_FOR_CHANNEL) {
> +                       len = adata->read_multiple_byte(adata, reg_addr[0],
> +                                       ST_ACCEL_BYTE_FOR_CHANNEL*n,
> +                                       rx_array);
> +               } else {
> +                       len = adata->read_multiple_byte(adata, reg_addr[0],
> +                               ST_ACCEL_BYTE_FOR_CHANNEL*
> +                               ST_ACCEL_NUMBER_DATA_CHANNELS,
> +                               rx_array);
> +                       rx_array[2] = rx_array[4];
> +                       rx_array[3] = rx_array[5];
> +                       len = ST_ACCEL_BYTE_FOR_CHANNEL*n;
> +               }
Ouch.  This complexity might argue in favour of always reading everything
then letting the core demux handle pulling the requested data out of the
stream.  I hadn't realised this complexity would occur if one turned individual
channels off.  Maybe handle the one channel and the 3 channel. Let the core
code deal with the two (just a case of seeing up the appropriate available_scan_masks.  See how the adc/max1363 does it
for example).

Maybe just leaving it as you have here is best at this stage though!

> +               break;
> +       case 3:
> +               len = adata->read_multiple_byte(adata, reg_addr[0],
> +                       ST_ACCEL_BYTE_FOR_CHANNEL*ST_ACCEL_NUMBER_DATA_CHANNELS,
> +                       rx_array);
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       return len;
> +}
> +
> +static int st_accel_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
> +{
> +       int ret, i, scan_count;
> +       u8 rx_array[ST_ACCEL_BYTE_FOR_CHANNEL*ST_ACCEL_NUMBER_DATA_CHANNELS];
> +       s16 *data = (s16 *)buf;
> +
> +       ret = st_accel_read_all(indio_dev, rx_array);
> +       if (ret < 0)
> +               return ret;
> +
> +       scan_count = bitmap_weight(indio_dev->active_scan_mask,
> +                                                       indio_dev->masklength);
> +
> +       for (i = 0; i < scan_count; i++)
> +               memcpy(data+i, &rx_array[i*2], sizeof(s16));
I think you now only actually have the correct channels correctly packed.
Hence why the copy?
> +
> +       return i*sizeof(data[0]);
> +}
> +
> +static irqreturn_t st_accel_trigger_handler(int irq, void *p)
> +{
> +       int len = 0;
> +       struct iio_poll_func *pf = p;
> +       struct iio_dev *indio_dev = pf->indio_dev;
> +       struct st_accel_data *adata = iio_priv(indio_dev);
> +
> +       len = st_accel_get_buffer_element(indio_dev, adata->buffer_data);
> +       if (indio_dev->scan_timestamp)
> +               *(s64 *)((u8 *)adata->buffer_data +
> +                               ALIGN(len, sizeof(s64))) = pf->timestamp;
> +
> +       iio_push_to_buffer(indio_dev->buffer, adata->buffer_data);
Sorry, iio has changed in the mean time.
Now iio_push_to_buffers(indio_dev, adata->buffer_data);

> +       iio_trigger_notify_done(indio_dev->trig);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int st_accel_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +       int err, i;
> +       u8 active_bit = 0x00;
> +       struct st_accel_data *adata = iio_priv(indio_dev);
> +
> +       adata->buffer_data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
> +       if (adata->buffer_data == NULL) {
> +               err = -ENOMEM;
> +               goto allocate_memory_error;
> +       }
> +
> +       for (i = 0; i < ST_ACCEL_NUMBER_DATA_CHANNELS; i++)
> +               if (test_bit(i, indio_dev->active_scan_mask))
> +                       active_bit |= (1 << i);
> +
> +       err = st_accel_set_axis_enable(indio_dev, active_bit);
> +       if (err < 0)
> +               goto st_accel_buffer_postenable_error;
> +
> +       err = iio_triggered_buffer_postenable(indio_dev);
> +
> +       return err;
> +
> +allocate_memory_error:
> +       kfree(adata->buffer_data);
> +st_accel_buffer_postenable_error:
> +       return err;
> +}
> +
> +static int st_accel_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +       int err;
> +       struct st_accel_data *adata = iio_priv(indio_dev);
> +
> +       err = iio_triggered_buffer_predisable(indio_dev);
> +       if (err < 0)
> +               goto st_accel_buffer_predisable_error;
> +
> +       err = st_accel_set_axis_enable(indio_dev, ST_ACCEL_ENABLE_ALL_CHANNELS);
> +       if (err < 0)
> +               goto st_accel_buffer_predisable_error;
> +
> +       kfree(adata->buffer_data);
> +
> +st_accel_buffer_predisable_error:
> +       return err;
> +}
> +
> +static const struct iio_buffer_setup_ops st_accel_buffer_setup_ops = {
> +       .preenable = &iio_sw_buffer_preenable,
> +       .postenable = &st_accel_buffer_postenable,
> +       .predisable = &st_accel_buffer_predisable,
> +};
> +
> +int st_accel_allocate_ring(struct iio_dev *indio_dev)
> +{
> +       indio_dev->scan_timestamp = true;
Why?  That should be entirely up to userspace.  Sometimes we want the timestamp
sometimes it is pointless overhead?

> +       return iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
> +                       &st_accel_trigger_handler, &st_accel_buffer_setup_ops);
> +}
> +EXPORT_SYMBOL(st_accel_allocate_ring);
> +
> +void st_accel_deallocate_ring(struct iio_dev *indio_dev)
> +{
> +       iio_triggered_buffer_cleanup(indio_dev);
> +}
> +EXPORT_SYMBOL(st_accel_deallocate_ring);
> diff --git a/drivers/iio/accel/st_accel_core.c
> b/drivers/iio/accel/st_accel_core.c
> new file mode 100644
> index 0000000..0a787df
> --- /dev/null
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -0,0 +1,1154 @@
> +/*
> + * STMicroelectronics accelerometers driver
> + *
> + * Copyright 2012 STMicroelectronics Inc.
> + *
> + * Denis Ciocca <denis.ciocca@st.com>
> + *
> + * Licensed under the GPL-2.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/errno.h>
> +#include <linux/types.h>
> +#include <linux/mutex.h>
> +#include <linux/interrupt.h>
> +#include <linux/i2c.h>
> +#include <linux/gpio.h>
> +#include <linux/irq.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/buffer.h>
> +
> +#include <linux/iio/accel/st_accel.h>
> +
> +
> +#define ST_ACCEL_FULLSCALE_AVL_MAX             5
> +#define ST_ACCEL_ODR_LIST_MAX                  10
> +#define ST_ACCEL_ENABLE_ALL_CHANNELS           0x07
> +
> +/* DEFAULT VALUE FOR SENSORS */
> +#define ST_ACCEL_DEFAULT_OUT_X_L_ADDR          0x28
> +#define ST_ACCEL_DEFAULT_OUT_X_H_ADDR          0x29
> +#define ST_ACCEL_DEFAULT_OUT_Y_L_ADDR          0x2a
> +#define ST_ACCEL_DEFAULT_OUT_Y_H_ADDR          0x2b
> +#define ST_ACCEL_DEFAULT_OUT_Z_L_ADDR          0x2c
> +#define ST_ACCEL_DEFAULT_OUT_Z_H_ADDR          0x2d
> +#define ST_ACCEL_DEFAULT_WAI_ADDRESS           0x0f
> +#define ST_ACCEL_DEFAULT_POWER_ON_VALUE                0x01
> +#define ST_ACCEL_DEFAULT_POWER_OFF_VALUE       0x00
> +#define ST_ACCEL_DEFAULT_12_REALBITS           12
> +#define ST_ACCEL_DEFAULT_16_REALBITS           16
> +#define ST_ACCEL_DEFAULT_AXIS_ADDR             0x20
> +#define ST_ACCEL_DEFAULT_AXIS_MASK             0x07
> +#define ST_ACCEL_DEFAULT_AXIS_N_BIT            3
> +
> +/* FULLSCALE */
> +#define ST_ACCEL_FS_AVL_2G                     2
> +#define ST_ACCEL_FS_AVL_4G                     4
> +#define ST_ACCEL_FS_AVL_6G                     6
> +#define ST_ACCEL_FS_AVL_8G                     8
> +#define ST_ACCEL_FS_AVL_16G                    16
> +
> +/* CUSTOM VALUES FOR SENSOR 1 */
> +#define ST_ACCEL_1_WAI_EXP                     0x33
> +#define ST_ACCEL_1_ODR_ADDR                    0x20
> +#define ST_ACCEL_1_ODR_MASK                    0xf0
> +#define ST_ACCEL_1_ODR_N_BIT                   4
> +#define ST_ACCEL_1_ODR_AVL_1HZ_VAL             0x01
> +#define ST_ACCEL_1_ODR_AVL_10HZ_VAL            0x02
> +#define ST_ACCEL_1_ODR_AVL_25HZ_VAL            0x03
> +#define ST_ACCEL_1_ODR_AVL_50HZ_VAL            0x04
> +#define ST_ACCEL_1_ODR_AVL_100HZ_VAL           0x05
> +#define ST_ACCEL_1_ODR_AVL_200HZ_VAL           0x06
> +#define ST_ACCEL_1_ODR_AVL_400HZ_VAL           0x07
> +#define ST_ACCEL_1_ODR_AVL_1600HZ_VAL          0x08
> +#define ST_ACCEL_1_FS_N_BIT                    2
> +#define ST_ACCEL_1_FS_ADDR                     0x23
> +#define ST_ACCEL_1_FS_MASK                     0x30
> +#define ST_ACCEL_1_FS_AVL_2_VAL                        0x00
> +#define ST_ACCEL_1_FS_AVL_4_VAL                        0x01
> +#define ST_ACCEL_1_FS_AVL_8_VAL                        0x02
> +#define ST_ACCEL_1_FS_AVL_16_VAL               0x03
> +#define ST_ACCEL_1_FS_AVL_2_GAIN               IIO_G_TO_M_S_2(1000)
> +#define ST_ACCEL_1_FS_AVL_4_GAIN               IIO_G_TO_M_S_2(2000)
> +#define ST_ACCEL_1_FS_AVL_8_GAIN               IIO_G_TO_M_S_2(4000)
> +#define ST_ACCEL_1_FS_AVL_16_GAIN              IIO_G_TO_M_S_2(12000)
> +#define ST_ACCEL_1_BDU_ADDR                    0x23
> +#define ST_ACCEL_1_BDU_MASK                    0x80
> +#define ST_ACCEL_1_DRDY_IRQ_ADDR               0x22
> +#define ST_ACCEL_1_DRDY_IRQ_MASK               0x10
> +#define ST_ACCEL_1_MULTIREAD_BIT               true
> +
> +/* CUSTOM VALUES FOR SENSOR 2 */
> +#define ST_ACCEL_2_WAI_EXP                     0x49
> +#define ST_ACCEL_2_ODR_ADDR                    0x20
> +#define ST_ACCEL_2_ODR_MASK                    0xf0
> +#define ST_ACCEL_2_ODR_N_BIT                   4
> +#define ST_ACCEL_2_ODR_AVL_3HZ_VAL             0x01
> +#define ST_ACCEL_2_ODR_AVL_6HZ_VAL             0x02
> +#define ST_ACCEL_2_ODR_AVL_12HZ_VAL            0x03
> +#define ST_ACCEL_2_ODR_AVL_25HZ_VAL            0x04
> +#define ST_ACCEL_2_ODR_AVL_50HZ_VAL            0x05
> +#define ST_ACCEL_2_ODR_AVL_100HZ_VAL           0x06
> +#define ST_ACCEL_2_ODR_AVL_200HZ_VAL           0x07
> +#define ST_ACCEL_2_ODR_AVL_400HZ_VAL           0x08
> +#define ST_ACCEL_2_ODR_AVL_800HZ_VAL           0x09
> +#define ST_ACCEL_2_ODR_AVL_1600HZ_VAL          0x0a
> +#define ST_ACCEL_2_FS_N_BIT                    3
> +#define ST_ACCEL_2_FS_ADDR                     0x21
> +#define ST_ACCEL_2_FS_MASK                     0x38
> +#define ST_ACCEL_2_FS_AVL_2_VAL                        0X00
> +#define ST_ACCEL_2_FS_AVL_4_VAL                        0X01
> +#define ST_ACCEL_2_FS_AVL_6_VAL                        0x02
> +#define ST_ACCEL_2_FS_AVL_8_VAL                        0x03
> +#define ST_ACCEL_2_FS_AVL_16_VAL               0x04
> +#define ST_ACCEL_2_FS_AVL_2_GAIN               IIO_G_TO_M_S_2(61)
> +#define ST_ACCEL_2_FS_AVL_4_GAIN               IIO_G_TO_M_S_2(122)
> +#define ST_ACCEL_2_FS_AVL_6_GAIN               IIO_G_TO_M_S_2(183)
> +#define ST_ACCEL_2_FS_AVL_8_GAIN               IIO_G_TO_M_S_2(244)
> +#define ST_ACCEL_2_FS_AVL_16_GAIN              IIO_G_TO_M_S_2(732)
> +#define ST_ACCEL_2_BDU_ADDR                    0x20
> +#define ST_ACCEL_2_BDU_MASK                    0x08
> +#define ST_ACCEL_2_DRDY_IRQ_ADDR               0x22
> +#define ST_ACCEL_2_DRDY_IRQ_MASK               0x04
> +#define ST_ACCEL_2_MULTIREAD_BIT               true
> +
> +/* CUSTOM VALUES FOR SENSOR 3 */
> +#define ST_ACCEL_3_WAI_EXP                     0x32
> +#define ST_ACCEL_3_ODR_ADDR                    0x20
> +#define ST_ACCEL_3_ODR_MASK                    0x18
> +#define ST_ACCEL_3_ODR_N_BIT                   2
> +#define ST_ACCEL_3_ODR_AVL_50HZ_VAL            0x00
> +#define ST_ACCEL_3_ODR_AVL_100HZ_VAL           0x01
> +#define ST_ACCEL_3_ODR_AVL_400HZ_VAL           0x02
> +#define ST_ACCEL_3_ODR_AVL_1000HZ_VAL          0x03
> +#define ST_ACCEL_3_PW_ADDR                     0x20
> +#define ST_ACCEL_3_PW_MASK                     0xe0
> +#define ST_ACCEL_3_PW_N_BIT                    3
> +#define ST_ACCEL_3_FS_N_BIT                    2
> +#define ST_ACCEL_3_FS_ADDR                     0x23
> +#define ST_ACCEL_3_FS_MASK                     0x30
> +#define ST_ACCEL_3_FS_AVL_2_VAL                        0X00
> +#define ST_ACCEL_3_FS_AVL_4_VAL                        0X01
> +#define ST_ACCEL_3_FS_AVL_8_VAL                        0x03
> +#define ST_ACCEL_3_FS_AVL_2_GAIN               IIO_G_TO_M_S_2(1000)
> +#define ST_ACCEL_3_FS_AVL_4_GAIN               IIO_G_TO_M_S_2(2000)
> +#define ST_ACCEL_3_FS_AVL_8_GAIN               IIO_G_TO_M_S_2(3900)
> +#define ST_ACCEL_3_BDU_ADDR                    0x23
> +#define ST_ACCEL_3_BDU_MASK                    0x80
> +#define ST_ACCEL_3_DRDY_IRQ_ADDR               0x22
> +#define ST_ACCEL_3_DRDY_IRQ_MASK               0x02
> +#define ST_ACCEL_3_MULTIREAD_BIT               true
> +
> +/* CUSTOM VALUES FOR SENSOR 4 */
> +#define ST_ACCEL_4_WAI_EXP                     0x40
> +#define ST_ACCEL_4_ODR_ADDR                    0x20
> +#define ST_ACCEL_4_ODR_MASK                    0xf0
> +#define ST_ACCEL_4_ODR_N_BIT                   4
> +#define ST_ACCEL_4_ODR_AVL_3HZ_VAL             0x01
> +#define ST_ACCEL_4_ODR_AVL_6HZ_VAL             0x02
> +#define ST_ACCEL_4_ODR_AVL_12HZ_VAL            0x03
> +#define ST_ACCEL_4_ODR_AVL_25HZ_VAL            0x04
> +#define ST_ACCEL_4_ODR_AVL_50HZ_VAL            0x05
> +#define ST_ACCEL_4_ODR_AVL_100HZ_VAL           0x06
> +#define ST_ACCEL_4_ODR_AVL_200HZ_VAL           0x07
> +#define ST_ACCEL_4_ODR_AVL_400HZ_VAL           0x08
> +#define ST_ACCEL_4_ODR_AVL_800HZ_VAL           0x09
> +#define ST_ACCEL_4_ODR_AVL_1600HZ_VAL          0x0a
> +#define ST_ACCEL_4_FS_N_BIT                    3
> +#define ST_ACCEL_4_FS_ADDR                     0x24
> +#define ST_ACCEL_4_FS_MASK                     0x38
> +#define ST_ACCEL_4_FS_AVL_2_VAL                        0X00
> +#define ST_ACCEL_4_FS_AVL_4_VAL                        0X01
> +#define ST_ACCEL_4_FS_AVL_6_VAL                        0x02
> +#define ST_ACCEL_4_FS_AVL_8_VAL                        0x03
> +#define ST_ACCEL_4_FS_AVL_16_VAL               0x04
> +#define ST_ACCEL_4_FS_AVL_2_GAIN               IIO_G_TO_M_S_2(61)
> +#define ST_ACCEL_4_FS_AVL_4_GAIN               IIO_G_TO_M_S_2(122)
> +#define ST_ACCEL_4_FS_AVL_6_GAIN               IIO_G_TO_M_S_2(183)
> +#define ST_ACCEL_4_FS_AVL_8_GAIN               IIO_G_TO_M_S_2(244)
> +#define ST_ACCEL_4_FS_AVL_16_GAIN              IIO_G_TO_M_S_2(732)
> +#define ST_ACCEL_4_BDU_ADDR                    0x20
> +#define ST_ACCEL_4_BDU_MASK                    0x08
> +#define ST_ACCEL_4_DRDY_IRQ_ADDR               0x23
> +#define ST_ACCEL_4_DRDY_IRQ_MASK               0x80
> +#define ST_ACCEL_4_IG1_EN_ADDR                 0x23
> +#define ST_ACCEL_4_IG1_EN_MASK                 0x08
> +#define ST_ACCEL_4_MULTIREAD_BIT               false
> +
> +struct st_accel_odr_available {
> +       unsigned int hz;
> +       u8 value;
> +};
> +
> +struct st_accel_odr {
> +       u8 addr;
> +       u8 mask;
> +       short num_bit;
> +       struct st_accel_odr_available odr_avl[ST_ACCEL_ODR_LIST_MAX];
> +};
> +
> +struct st_accel_power {
> +       u8 addr;
> +       u8 mask;
> +       unsigned short num_bit;
> +       u8 value_off;
> +       u8 value_on;
> +};
> +
> +struct st_accel_axis {
> +       u8 addr;
> +       u8 mask;
> +};
> +
> +struct st_accel_fullscale_available {
> +       unsigned int num;
> +       u8 value;
> +       unsigned int gain;
> +};
> +
> +struct st_accel_fullscale {
> +       u8 addr;
> +       u8 mask;
> +       unsigned short num_bit;
> +       struct st_accel_fullscale_available fs_avl[ST_ACCEL_FULLSCALE_AVL_MAX];
> +};
> +
> +struct st_accel_bdu {
> +       u8 addr;
> +       u8 mask;
> +};
> +
> +struct st_accel_interrupt_generator {
> +       u8 en_addr;
> +       u8 latch_mask_addr;
> +       u8 en_mask;
> +       u8 latching_mask;
> +};
> +
> +struct st_accel_data_ready_irq {
> +       u8 addr;
> +       u8 mask;
> +       struct st_accel_interrupt_generator ig1;
> +};
> +
> +#define ST_ACCEL_LSM_CHANNELS(index, mod, endian, bits, addr) \
> +{ \
> +       .type = IIO_ACCEL, \
> +       .modified = 1, \
> +       .info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT | \
> +                                       IIO_CHAN_INFO_SCALE_SEPARATE_BIT, \
> +       .scan_index = index, \
> +       .channel2 = mod, \
> +       .address = addr, \
> +       .scan_type = { \
> +               .sign = 's', \
> +               .realbits = bits, \
> +               .shift = 16 - bits, \
> +               .storagebits = 16, \
> +               .endianness = endian, \
> +       }, \
> +}
> +
> +static const struct iio_chan_spec st_accel_12bit_channels[] = {
> +       ST_ACCEL_LSM_CHANNELS(ST_ACCEL_SCAN_X, IIO_MOD_X, IIO_LE,
> +               ST_ACCEL_DEFAULT_12_REALBITS, ST_ACCEL_DEFAULT_OUT_X_L_ADDR),
> +       ST_ACCEL_LSM_CHANNELS(ST_ACCEL_SCAN_Y, IIO_MOD_Y, IIO_LE,
> +               ST_ACCEL_DEFAULT_12_REALBITS, ST_ACCEL_DEFAULT_OUT_Y_L_ADDR),
> +       ST_ACCEL_LSM_CHANNELS(ST_ACCEL_SCAN_Z, IIO_MOD_Z, IIO_LE,
> +               ST_ACCEL_DEFAULT_12_REALBITS, ST_ACCEL_DEFAULT_OUT_Z_L_ADDR),
> +       IIO_CHAN_SOFT_TIMESTAMP(3)
> +};
> +
> +static const struct iio_chan_spec st_accel_16bit_channels[] = {
> +       ST_ACCEL_LSM_CHANNELS(ST_ACCEL_SCAN_X, IIO_MOD_X, IIO_LE,
> +               ST_ACCEL_DEFAULT_16_REALBITS, ST_ACCEL_DEFAULT_OUT_X_L_ADDR),
> +       ST_ACCEL_LSM_CHANNELS(ST_ACCEL_SCAN_Y, IIO_MOD_Y, IIO_LE,
> +               ST_ACCEL_DEFAULT_16_REALBITS, ST_ACCEL_DEFAULT_OUT_Y_L_ADDR),
> +       ST_ACCEL_LSM_CHANNELS(ST_ACCEL_SCAN_Z, IIO_MOD_Z, IIO_LE,
> +               ST_ACCEL_DEFAULT_16_REALBITS, ST_ACCEL_DEFAULT_OUT_Z_L_ADDR),
> +       IIO_CHAN_SOFT_TIMESTAMP(3)
> +};
> +
> +/**
> + * struct st_accel_sensors - ST accel sensors list
> + * @wai: Contents of WhoAmI register.
> + * @ch: IIO channels for the sensor.
> + * @odr: Output data rate register and odr list available.
> + * @pw: Power register of the sensor.
> + * @enable_axis: Enable one or more axis of the sensor.
> + * @fs: Full scale register and fs list available.
> + * @bdu: Block data update register.
> + * @drdy_irq: Data ready register of the sensor.
> + * @multi_read_bit: Use or not particular bit for [I2C/SPI] multiread.
> + */
> +static const struct st_accel_sensors {
> +       u8 wai;
> +       struct iio_chan_spec *ch;
> +       struct st_accel_odr odr;
> +       struct st_accel_power pw;
> +       struct st_accel_axis enable_axis;
> +       struct st_accel_fullscale fs;
> +       struct st_accel_bdu bdu;
> +       struct st_accel_data_ready_irq drdy_irq;
> +       bool multi_read_bit;
> +} st_accel_sensors[] = {
> +       {
> +               .wai = ST_ACCEL_1_WAI_EXP,
> +               .ch = (struct iio_chan_spec *)st_accel_12bit_channels,
> +               .odr = {
> +                       .addr = ST_ACCEL_1_ODR_ADDR,
> +                       .mask = ST_ACCEL_1_ODR_MASK,
> +                       .num_bit = ST_ACCEL_1_ODR_N_BIT,
> +                       .odr_avl = {
> +                               { 1, ST_ACCEL_1_ODR_AVL_1HZ_VAL, },
> +                               { 10, ST_ACCEL_1_ODR_AVL_10HZ_VAL, },
> +                               { 25, ST_ACCEL_1_ODR_AVL_25HZ_VAL, },
> +                               { 50, ST_ACCEL_1_ODR_AVL_50HZ_VAL, },
> +                               { 100, ST_ACCEL_1_ODR_AVL_100HZ_VAL, },
> +                               { 200, ST_ACCEL_1_ODR_AVL_200HZ_VAL, },
> +                               { 400, ST_ACCEL_1_ODR_AVL_400HZ_VAL, },
> +                               { 1600, ST_ACCEL_1_ODR_AVL_1600HZ_VAL, },
> +                       },
> +               },
> +               .pw = {
> +                       .addr = ST_ACCEL_1_ODR_ADDR,
> +                       .mask = ST_ACCEL_1_ODR_MASK,
> +                       .num_bit = ST_ACCEL_1_ODR_N_BIT,
> +                       .value_off = ST_ACCEL_DEFAULT_POWER_OFF_VALUE,
> +               },
> +               .enable_axis = {
> +                       .addr = ST_ACCEL_DEFAULT_AXIS_ADDR,
> +                       .mask = ST_ACCEL_DEFAULT_AXIS_MASK,
> +               },
> +               .fs = {
> +                       .addr = ST_ACCEL_1_FS_ADDR,
> +                       .mask = ST_ACCEL_1_FS_MASK,
> +                       .num_bit = ST_ACCEL_1_FS_N_BIT,
> +                       .fs_avl = {
> +                               [0] = {
> +                                       .num = ST_ACCEL_FS_AVL_2G,
> +                                       .value = ST_ACCEL_1_FS_AVL_2_VAL,
> +                                       .gain = ST_ACCEL_1_FS_AVL_2_GAIN,
> +                               },
> +                               [1] = {
> +                                       .num = ST_ACCEL_FS_AVL_4G,
> +                                       .value = ST_ACCEL_1_FS_AVL_4_VAL,
> +                                       .gain = ST_ACCEL_1_FS_AVL_4_GAIN,
> +                               },
> +                               [2] = {
> +                                       .num = ST_ACCEL_FS_AVL_8G,
> +                                       .value = ST_ACCEL_1_FS_AVL_8_VAL,
> +                                       .gain = ST_ACCEL_1_FS_AVL_8_GAIN,
> +                               },
> +                               [3] = {
> +                                       .num = ST_ACCEL_FS_AVL_16G,
> +                                       .value = ST_ACCEL_1_FS_AVL_16_VAL,
> +                                       .gain = ST_ACCEL_1_FS_AVL_16_GAIN,
> +                               },
> +                       },
> +               },
> +               .bdu = {
> +                       .addr = ST_ACCEL_1_BDU_ADDR,
> +                       .mask = ST_ACCEL_1_BDU_MASK,
> +               },
> +               .drdy_irq = {
> +                       .addr = ST_ACCEL_1_DRDY_IRQ_ADDR,
> +                       .mask = ST_ACCEL_1_DRDY_IRQ_MASK,
> +               },
> +               .multi_read_bit = ST_ACCEL_1_MULTIREAD_BIT,
> +       },
> +       {
> +               .wai = ST_ACCEL_2_WAI_EXP,
> +               .ch = (struct iio_chan_spec *)st_accel_16bit_channels,
> +               .odr = {
> +                       .addr = ST_ACCEL_2_ODR_ADDR,
> +                       .mask = ST_ACCEL_2_ODR_MASK,
> +                       .num_bit = ST_ACCEL_2_ODR_N_BIT,
> +                       .odr_avl = {
> +                               { 3, ST_ACCEL_2_ODR_AVL_3HZ_VAL, },
> +                               { 6, ST_ACCEL_2_ODR_AVL_6HZ_VAL, },
> +                               { 12, ST_ACCEL_2_ODR_AVL_12HZ_VAL, },
> +                               { 25, ST_ACCEL_2_ODR_AVL_25HZ_VAL, },
> +                               { 50, ST_ACCEL_2_ODR_AVL_50HZ_VAL, },
> +                               { 100, ST_ACCEL_2_ODR_AVL_100HZ_VAL, },
> +                               { 200, ST_ACCEL_2_ODR_AVL_200HZ_VAL, },
> +                               { 400, ST_ACCEL_2_ODR_AVL_400HZ_VAL, },
> +                               { 800, ST_ACCEL_2_ODR_AVL_800HZ_VAL, },
> +                               { 1600, ST_ACCEL_2_ODR_AVL_1600HZ_VAL, },
> +                       },
> +               },
> +               .pw = {
> +                       .addr = ST_ACCEL_2_ODR_ADDR,
> +                       .mask = ST_ACCEL_2_ODR_MASK,
> +                       .num_bit = ST_ACCEL_2_ODR_N_BIT,
> +                       .value_off = ST_ACCEL_DEFAULT_POWER_OFF_VALUE,
> +               },
> +               .enable_axis = {
> +                       .addr = ST_ACCEL_DEFAULT_AXIS_ADDR,
> +                       .mask = ST_ACCEL_DEFAULT_AXIS_MASK,
> +               },
> +               .fs = {
> +                       .addr = ST_ACCEL_2_FS_ADDR,
> +                       .mask = ST_ACCEL_2_FS_MASK,
> +                       .num_bit = ST_ACCEL_2_FS_N_BIT,
> +                       .fs_avl = {
> +                               [0] = {
> +                                       .num = ST_ACCEL_FS_AVL_2G,
> +                                       .value = ST_ACCEL_2_FS_AVL_2_VAL,
> +                                       .gain = ST_ACCEL_2_FS_AVL_2_GAIN,
> +                               },
> +                               [1] = {
> +                                       .num = ST_ACCEL_FS_AVL_4G,
> +                                       .value = ST_ACCEL_2_FS_AVL_4_VAL,
> +                                       .gain = ST_ACCEL_2_FS_AVL_4_GAIN,
> +                               },
> +                               [2] = {
> +                                       .num = ST_ACCEL_FS_AVL_6G,
> +                                       .value = ST_ACCEL_2_FS_AVL_6_VAL,
> +                                       .gain = ST_ACCEL_2_FS_AVL_6_GAIN,
> +                               },
> +                               [3] = {
> +                                       .num = ST_ACCEL_FS_AVL_8G,
> +                                       .value = ST_ACCEL_2_FS_AVL_8_VAL,
> +                                       .gain = ST_ACCEL_2_FS_AVL_8_GAIN,
> +                               },
> +                               [4] = {
> +                                       .num = ST_ACCEL_FS_AVL_16G,
> +                                       .value = ST_ACCEL_2_FS_AVL_16_VAL,
> +                                       .gain = ST_ACCEL_2_FS_AVL_16_GAIN,
> +                               },
> +                       },
> +               },
> +               .drdy_irq = {
> +                       .addr = ST_ACCEL_2_DRDY_IRQ_ADDR,
> +                       .mask = ST_ACCEL_2_DRDY_IRQ_MASK,
> +               },
> +               .bdu = {
> +                       .addr = ST_ACCEL_2_BDU_ADDR,
> +                       .mask = ST_ACCEL_2_BDU_MASK,
> +               },
> +               .multi_read_bit = ST_ACCEL_2_MULTIREAD_BIT,
> +       },
> +       {
> +               .wai = ST_ACCEL_3_WAI_EXP,
> +               .ch = (struct iio_chan_spec *)st_accel_12bit_channels,
> +               .odr = {
> +                       .addr = ST_ACCEL_3_ODR_ADDR,
> +                       .mask = ST_ACCEL_3_ODR_MASK,
> +                       .num_bit = ST_ACCEL_3_ODR_N_BIT,
> +                       .odr_avl = {
> +                               { 50, ST_ACCEL_3_ODR_AVL_50HZ_VAL, },
> +                               { 100, ST_ACCEL_3_ODR_AVL_100HZ_VAL, },
> +                               { 400, ST_ACCEL_3_ODR_AVL_400HZ_VAL, },
> +                               { 1000, ST_ACCEL_3_ODR_AVL_1000HZ_VAL, },
> +                       },
> +               },
> +               .pw = {
> +                       .addr = ST_ACCEL_3_PW_ADDR,
> +                       .mask = ST_ACCEL_3_PW_MASK,
> +                       .num_bit = ST_ACCEL_3_PW_N_BIT,
> +                       .value_on = ST_ACCEL_DEFAULT_POWER_ON_VALUE,
> +                       .value_off = ST_ACCEL_DEFAULT_POWER_OFF_VALUE,
> +               },
> +               .enable_axis = {
> +                       .addr = ST_ACCEL_DEFAULT_AXIS_ADDR,
> +                       .mask = ST_ACCEL_DEFAULT_AXIS_MASK,
> +               },
> +               .fs = {
> +                       .addr = ST_ACCEL_3_FS_ADDR,
> +                       .mask = ST_ACCEL_3_FS_MASK,
> +                       .num_bit = ST_ACCEL_3_FS_N_BIT,
> +                       .fs_avl = {
> +                               [0] = {
> +                                       .num = ST_ACCEL_FS_AVL_2G,
> +                                       .value = ST_ACCEL_3_FS_AVL_2_VAL,
> +                                       .gain = ST_ACCEL_3_FS_AVL_2_GAIN,
> +                               },
> +                               [1] = {
> +                                       .num = ST_ACCEL_FS_AVL_4G,
> +                                       .value = ST_ACCEL_3_FS_AVL_4_VAL,
> +                                       .gain = ST_ACCEL_3_FS_AVL_4_GAIN,
> +                               },
> +                               [2] = {
> +                                       .num = ST_ACCEL_FS_AVL_8G,
> +                                       .value = ST_ACCEL_3_FS_AVL_8_VAL,
> +                                       .gain = ST_ACCEL_3_FS_AVL_8_GAIN,
> +                               },
> +                       },
> +               },
> +               .bdu = {
> +                       .addr = ST_ACCEL_3_BDU_ADDR,
> +                       .mask = ST_ACCEL_3_BDU_MASK,
> +               },
> +               .drdy_irq = {
> +                       .addr = ST_ACCEL_3_DRDY_IRQ_ADDR,
> +                       .mask = ST_ACCEL_3_DRDY_IRQ_MASK,
> +               },
> +               .multi_read_bit = ST_ACCEL_3_MULTIREAD_BIT,
> +       },
> +       {
> +               .wai = ST_ACCEL_4_WAI_EXP,
> +               .ch = (struct iio_chan_spec *)st_accel_16bit_channels,
> +               .odr = {
> +                       .addr = ST_ACCEL_4_ODR_ADDR,
> +                       .mask = ST_ACCEL_4_ODR_MASK,
> +                       .num_bit = ST_ACCEL_4_ODR_N_BIT,
> +                       .odr_avl = {
> +                               { 3, ST_ACCEL_4_ODR_AVL_3HZ_VAL },
> +                               { 6, ST_ACCEL_4_ODR_AVL_6HZ_VAL, },
> +                               { 12, ST_ACCEL_4_ODR_AVL_12HZ_VAL, },
> +                               { 25, ST_ACCEL_4_ODR_AVL_25HZ_VAL, },
> +                               { 50, ST_ACCEL_4_ODR_AVL_50HZ_VAL, },
> +                               { 100, ST_ACCEL_4_ODR_AVL_100HZ_VAL, },
> +                               { 200, ST_ACCEL_4_ODR_AVL_200HZ_VAL, },
> +                               { 400, ST_ACCEL_4_ODR_AVL_400HZ_VAL, },
> +                               { 800, ST_ACCEL_4_ODR_AVL_800HZ_VAL, },
> +                               { 1600, ST_ACCEL_4_ODR_AVL_1600HZ_VAL, },
> +                       },
> +               },
> +               .pw = {
> +                       .addr = ST_ACCEL_4_ODR_ADDR,
> +                       .mask = ST_ACCEL_4_ODR_MASK,
> +                       .num_bit = ST_ACCEL_4_ODR_N_BIT,
> +                       .value_off = ST_ACCEL_DEFAULT_POWER_OFF_VALUE,
> +               },
> +               .enable_axis = {
> +                       .addr = ST_ACCEL_DEFAULT_AXIS_ADDR,
> +                       .mask = ST_ACCEL_DEFAULT_AXIS_MASK,
> +               },
> +               .fs = {
> +                       .addr = ST_ACCEL_4_FS_ADDR,
> +                       .mask = ST_ACCEL_4_FS_MASK,
> +                       .num_bit = ST_ACCEL_4_FS_N_BIT,
> +                       .fs_avl = {
> +                               [0] = {
> +                                       .num = ST_ACCEL_FS_AVL_2G,
> +                                       .value = ST_ACCEL_4_FS_AVL_2_VAL,
> +                                       .gain = ST_ACCEL_4_FS_AVL_2_GAIN,
> +                               },
> +                               [1] = {
> +                                       .num = ST_ACCEL_FS_AVL_4G,
> +                                       .value = ST_ACCEL_4_FS_AVL_4_VAL,
> +                                       .gain = ST_ACCEL_4_FS_AVL_4_GAIN,
> +                               },
> +                               [2] = {
> +                                       .num = ST_ACCEL_FS_AVL_6G,
> +                                       .value = ST_ACCEL_4_FS_AVL_6_VAL,
> +                                       .gain = ST_ACCEL_4_FS_AVL_6_GAIN,
> +                               },
> +                               [3] = {
> +                                       .num = ST_ACCEL_FS_AVL_8G,
> +                                       .value = ST_ACCEL_4_FS_AVL_8_VAL,
> +                                       .gain = ST_ACCEL_4_FS_AVL_8_GAIN,
> +                               },
> +                               [4] = {
> +                                       .num = ST_ACCEL_FS_AVL_16G,
> +                                       .value = ST_ACCEL_4_FS_AVL_16_VAL,
> +                                       .gain = ST_ACCEL_4_FS_AVL_16_GAIN,
> +                               },
> +                       },
> +               },
> +               .bdu = {
> +                       .addr = ST_ACCEL_4_BDU_ADDR,
> +                       .mask = ST_ACCEL_4_BDU_MASK,
> +               },
> +               .drdy_irq = {
> +                       .addr = ST_ACCEL_4_DRDY_IRQ_ADDR,
> +                       .mask = ST_ACCEL_4_DRDY_IRQ_MASK,
> +                       .ig1 = {
> +                               .en_addr = ST_ACCEL_4_IG1_EN_ADDR,
> +                               .en_mask = ST_ACCEL_4_IG1_EN_MASK,
> +                       },
> +               },
> +               .multi_read_bit = ST_ACCEL_4_MULTIREAD_BIT,
> +       },
> +};
> +
> +static int st_accel_write_data_with_mask(struct iio_dev *indio_dev, u8
> reg_addr,
> +                                               u8 mask, short num_bit, u8 data)
> +{
> +       int err;
> +       u8 prev_data;
> +       u8 new_data;
> +       struct st_accel_data *adata = iio_priv(indio_dev);
> +
> +       err = adata->read_byte(adata, reg_addr, &prev_data);
> +       if (err < 0)
> +               goto st_accel_write_data_with_mask_error;
> +
> +       new_data = ((prev_data & (~mask)) | ((data << __ffs(mask)) & mask));
> +       err = adata->write_byte(adata, reg_addr, new_data);
> +
> +st_accel_write_data_with_mask_error:
> +       return err;
> +}
> +
> +static int st_accel_match_odr(const struct st_accel_sensors *sensor,
> +               unsigned int odr, struct st_accel_odr_available *odr_out)
> +{
> +       int i, ret = -EINVAL;
> +
> +       for (i = 0; i < ARRAY_SIZE(sensor->odr.odr_avl); i++) {
> +               if (sensor->odr.odr_avl[i].hz == odr) {
> +                       odr_out->hz = sensor->odr.odr_avl[i].hz;
> +                       odr_out->value = sensor->odr.odr_avl[i].value;
> +                       ret = 0;
> +                       break;
> +               }
> +       }
> +
> +       return ret;
> +}
> +
> +static int st_accel_match_fs(const struct st_accel_sensors *sensor,
> +               unsigned int fs, struct st_accel_fullscale_available *fs_out)
> +{
> +       int i, ret = -EINVAL;
> +
> +       for (i = 0; i < ARRAY_SIZE(sensor->fs.fs_avl); i++) {
> +               if (sensor->fs.fs_avl[i].num == fs) {
> +                       fs_out->num = sensor->fs.fs_avl[i].num;
> +                       fs_out->gain = sensor->fs.fs_avl[i].gain;
> +                       fs_out->value = sensor->fs.fs_avl[i].value;
> +                       ret = 0;
> +                       break;
> +               }
> +       }
> +
> +       return ret;
> +}
> +
> +static int st_accel_match_scale(const struct st_accel_sensors *sensor,
> +                       int scale, struct st_accel_fullscale_available *fs_out)
> +{
> +       int i, ret = -EINVAL;
> +
> +       for (i = 0; i < ARRAY_SIZE(sensor->fs.fs_avl); i++) {
> +               if (sensor->fs.fs_avl[i].gain == scale) {
> +                       fs_out->num = sensor->fs.fs_avl[i].num;
> +                       fs_out->gain = sensor->fs.fs_avl[i].gain;
> +                       fs_out->value = sensor->fs.fs_avl[i].value;
> +                       ret = 0;
> +                       break;
> +               }
> +       }
> +
> +       return ret;
> +}
> +
> +int st_accel_set_dataready_irq(struct iio_dev *indio_dev, bool enable)
> +{
> +       int err;
> +       struct st_accel_data *adata;
> +
> +       adata = iio_priv(indio_dev);
> +       if (st_accel_sensors[adata->index].drdy_irq.ig1.en_addr > 0) {
> +               err = st_accel_write_data_with_mask(indio_dev,
> +                       st_accel_sensors[adata->index].drdy_irq.ig1.en_addr,
> +                       st_accel_sensors[adata->index].drdy_irq.ig1.en_mask, 1,
> +                       (int)enable);
> +               if (err < 0)
> +                       goto st_accel_set_dataready_irq_error;
> +       }
> +
> +       if (st_accel_sensors[adata->index].drdy_irq.ig1.latch_mask_addr > 0) {
> +               err = st_accel_write_data_with_mask(indio_dev,
> +               st_accel_sensors[adata->index].drdy_irq.ig1.latch_mask_addr,
> +               st_accel_sensors[adata->index].drdy_irq.ig1.latching_mask, 1,
> +                       (int)enable);
> +               if (err < 0)
> +                       goto st_accel_set_dataready_irq_error;
> +       }
> +
> +       err = st_accel_write_data_with_mask(indio_dev,
> +               st_accel_sensors[adata->index].drdy_irq.addr,
> +               st_accel_sensors[adata->index].drdy_irq.mask, 1, (int)enable);
> +
> +st_accel_set_dataready_irq_error:
> +       return err;
> +}
> +EXPORT_SYMBOL(st_accel_set_dataready_irq);
> +
> +static int st_accel_set_bdu(struct iio_dev *indio_dev,
> +                               const struct st_accel_bdu *bdu, bool value)
> +{
> +       return st_accel_write_data_with_mask(indio_dev, bdu->addr, bdu->mask,
> +                                                               1, (u8)value);
> +}
> +
> +static int st_accel_set_odr(struct iio_dev *indio_dev,
> +                               struct st_accel_odr_available *odr_available)
> +{
> +       int err;
> +       struct st_accel_data *adata = iio_priv(indio_dev);
> +
> +       if ((st_accel_sensors[adata->index].odr.addr ==
> +               st_accel_sensors[adata->index].pw.addr) &&
> +               (st_accel_sensors[adata->index].odr.mask ==
> +                               st_accel_sensors[adata->index].pw.mask)) {
> +               if (adata->enabled == true) {
> +                       err = st_accel_write_data_with_mask(indio_dev,
> +                               st_accel_sensors[adata->index].odr.addr,
> +                               st_accel_sensors[adata->index].odr.mask,
> +                               st_accel_sensors[adata->index].odr.num_bit,
> +                               odr_available->value);
> +               } else {
> +                       adata->odr = odr_available->hz;
> +                       err = 0;
> +               }
> +       } else {
> +               err = st_accel_write_data_with_mask(indio_dev,
> +                               st_accel_sensors[adata->index].odr.addr,
> +                               st_accel_sensors[adata->index].odr.mask,
> +                               st_accel_sensors[adata->index].odr.num_bit,
> +                               odr_available->value);
> +       }
> +
> +       return err;
> +}
> +
> +int st_accel_set_axis_enable(struct iio_dev *indio_dev, u8 axis_enable)
> +{
> +       int err;
> +       struct st_accel_data *adata = iio_priv(indio_dev);
> +
> +       err = st_accel_write_data_with_mask(indio_dev,
> +                       st_accel_sensors[adata->index].enable_axis.addr,
> +                       st_accel_sensors[adata->index].enable_axis.mask,
> +                       ST_ACCEL_DEFAULT_AXIS_N_BIT, axis_enable);
> +
> +       return err;
> +}
> +
> +static int st_accel_set_enable(struct iio_dev *indio_dev, bool enable)
> +{
> +       int err = -EINVAL;
> +       bool found;
> +       u8 tmp_value;
> +       struct st_accel_odr_available odr_out;
> +       struct st_accel_data *adata = iio_priv(indio_dev);
> +
> +       if (enable) {
> +               found = false;
> +               tmp_value = st_accel_sensors[adata->index].pw.value_on;
> +               if ((st_accel_sensors[adata->index].odr.addr ==
> +                               st_accel_sensors[adata->index].pw.addr) &&
> +                       (st_accel_sensors[adata->index].odr.mask ==
> +                               st_accel_sensors[adata->index].pw.mask)) {
> +                       err = st_accel_match_odr(
> +                               &st_accel_sensors[adata->index], adata->odr,
> +                                       &odr_out);
> +                       if (err < 0)
> +                               goto set_enable_error;
> +                       tmp_value = odr_out.value;
> +                       found = true;
> +               }
> +               err = st_accel_write_data_with_mask(indio_dev,
> +                               st_accel_sensors[adata->index].pw.addr,
> +                               st_accel_sensors[adata->index].pw.mask,
> +                               st_accel_sensors[adata->index].pw.num_bit,
> +                               tmp_value);
> +               if (err < 0)
> +                       goto set_enable_error;
> +               adata->enabled = true;
> +               if (found)
> +                       adata->odr = odr_out.hz;
> +       } else {
> +               err = st_accel_write_data_with_mask(indio_dev,
> +                               st_accel_sensors[adata->index].pw.addr,
> +                               st_accel_sensors[adata->index].pw.mask,
> +                               st_accel_sensors[adata->index].pw.num_bit,
> +                               st_accel_sensors[adata->index].pw.value_off);
> +               if (err < 0)
> +                       goto set_enable_error;
> +               adata->enabled = false;
> +       }
> +
> +set_enable_error:
> +       return err;
> +}
> +
> +static int st_accel_set_fullscale(struct iio_dev *indio_dev,
> +                               struct st_accel_fullscale_available *fs_avl)
> +{
> +       int err;
> +       struct st_accel_data *adata = iio_priv(indio_dev);
> +
> +       err = st_accel_write_data_with_mask(indio_dev,
> +                               st_accel_sensors[adata->index].fs.addr,
> +                               st_accel_sensors[adata->index].fs.mask,
> +                               st_accel_sensors[adata->index].fs.num_bit,
> +                               fs_avl->value);
> +       if (err < 0)
> +               goto st_accel_set_fullscale_error;
> +
> +       adata->fullscale = fs_avl->num;
> +       adata->gain = fs_avl->gain;
> +       return err;
> +
> +st_accel_set_fullscale_error:
> +       dev_err(&indio_dev->dev, "failed to set new fullscale.\n");
> +       return err;
> +}
> +
> +static int st_accel_read_raw(struct iio_dev *indio_dev,
> +                       struct iio_chan_spec const *ch, int *val,
> +                                                       int *val2, long mask)
> +{
> +       int err;
> +       u8 outdata[ST_ACCEL_BYTE_FOR_CHANNEL];
Outdata will need to be in it's own cacheline.  Either allocate
it dynamically here, or put it in adata and enforce the alignment.
This requirement is always there for spi drivers because they use
the buffer directly in dma (whereas i2c always copies it).

> +       struct st_accel_data *adata = iio_priv(indio_dev);
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_RAW:
> +               mutex_lock(&indio_dev->mlock);
> +               if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
> +                       err = -EBUSY;
> +                       goto read_error;
> +               } else {
> +                       if (!adata->enabled) {
> +                               err = -EIO;
> +                               goto read_error;
> +                       } else {
> +                               err = adata->read_multiple_byte(adata,
> +                                       ch->address, ST_ACCEL_BYTE_FOR_CHANNEL,
> +                                       outdata);
> +                               if (err < 0)
> +                                       goto read_error;
> +
> +                               *val = ((s16)cpu_to_le16p((u16 *)outdata))
> +                                                       >> ch->scan_type.shift;
Going from cpu to le16 seems a little odd.  Surely le16_to_cpu?

> +                       }
> +               }
> +               mutex_unlock(&indio_dev->mlock);
> +               return IIO_VAL_INT;
> +       case IIO_CHAN_INFO_SCALE:
> +               *val = 0;
> +               *val2 = adata->gain;
> +               return IIO_VAL_INT_PLUS_MICRO;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +read_error:
> +       mutex_unlock(&indio_dev->mlock);
> +       return err;
> +}
> +
> +static int st_accel_write_raw(struct iio_dev *indio_dev,
> +               struct iio_chan_spec const *chan, int val, int val2, long mask)
> +{
> +       int err;
> +       struct st_accel_fullscale_available fs_out;
> +       struct st_accel_data *adata = iio_priv(indio_dev);
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_SCALE:
> +               err = st_accel_match_scale(&st_accel_sensors[adata->index],
> +                                                               val2, &fs_out);
> +               if (err < 0)
> +                       goto write_error;
> +
> +               err = st_accel_set_fullscale(indio_dev, &fs_out);
> +               break;
> +       default:
> +               err = -EINVAL;
> +       }
> +
> +write_error:
> +       return err;
> +}
> +
> +static int st_accel_check_device_list(struct iio_dev *indio_dev, u8 wai)
> +{
> +       int i;
> +       struct st_accel_data *adata = iio_priv(indio_dev);
> +
> +       for (i = 0; i < ARRAY_SIZE(st_accel_sensors); i++) {
> +               if (st_accel_sensors[i].wai == wai)
> +                       break;
> +       }
> +       if (i == ARRAY_SIZE(st_accel_sensors))
> +               goto check_device_error;
> +
> +       adata->index = i;
> +
> +       return i;
> +
> +check_device_error:
> +       dev_err(&indio_dev->dev, "device not supported -> wai (0x%x).\n", wai);
> +       return -ENODEV;
> +}
> +
> +static int st_accel_get_wai_device(struct iio_dev *indio_dev, u8 reg_addr,
> +                                                               u8 *value)
> +{
> +       int ret;
> +       struct st_accel_data *adata = iio_priv(indio_dev);
> +
> +       ret = adata->read_byte(adata, reg_addr, value);
> +       if (ret < 0)
> +               goto read_byte_wai_error;
> +
> +       return 0;
> +
> +read_byte_wai_error:
> +       dev_err(&indio_dev->dev,
> +                       "failed to read WhoAmI (register 0x%x).\n", reg_addr);
> +       return -EIO;
> +}
> +
> +static ssize_t st_accel_sysfs_set_sampling_frequency(struct device *dev,
> +               struct device_attribute *attr, const char *buf, size_t size)
> +{
> +       int err;
> +       unsigned int freq;
> +       struct st_accel_odr_available odr_out;
> +       struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +       struct st_accel_data *adata = iio_priv(indio_dev);
> +
> +       err = kstrtoint(buf, 10, &freq);
> +       if (err < 0)
> +               goto conversion_error;
> +
> +       mutex_lock(&indio_dev->mlock);
> +       err = st_accel_match_odr(&st_accel_sensors[adata->index],
> +                                                               freq, &odr_out);
> +       if (err < 0)
> +               goto st_accel_sysfs_set_sampling_frequency_error;
> +
> +       err = st_accel_set_odr(indio_dev, &odr_out);
> +       if (err < 0) {
> +               dev_err(&indio_dev->dev,
> +                       "failed to set sampling frequency to %d.\n", freq);
> +               goto st_accel_sysfs_set_sampling_frequency_error;
> +       }
> +       adata->odr = odr_out.hz;
> +
> +st_accel_sysfs_set_sampling_frequency_error:
> +       mutex_unlock(&indio_dev->mlock);
> +conversion_error:
> +       return size;
> +}
> +
> +static ssize_t st_accel_sysfs_get_sampling_frequency(struct device *dev,
> +                               struct device_attribute *attr, char *buf)
> +{
> +       struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +       struct st_accel_data *adata = iio_priv(indio_dev);
> +
> +       return sprintf(buf, "%d\n", adata->odr);
> +}
> +
> +static ssize_t st_accel_sysfs_set_powerdown(struct device *dev,
> +               struct device_attribute *attr, const char *buf, size_t size)
> +{
> +       int err;
> +       bool powerdown;
> +       struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +
> +       err = strtobool(buf, &powerdown);
> +       if (err < 0)
> +               goto set_enable_error;
> +
> +       mutex_lock(&indio_dev->mlock);
> +       err = st_accel_set_enable(indio_dev, !powerdown);
> +       if (err < 0)
> +               dev_err(&indio_dev->dev,
> +                       "failed to set powerdown to %d.\n", (int)(powerdown));
> +       mutex_unlock(&indio_dev->mlock);
> +
> +set_enable_error:
> +       return size;
> +}
> +
> +static ssize_t st_accel_sysfs_get_powerdown(struct device *dev,
> +                               struct device_attribute *attr, char *buf)
> +{
> +       struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +       struct st_accel_data *adata = iio_priv(indio_dev);
> +
> +       return sprintf(buf, "%d\n", (int)(!adata->enabled));
> +}
> +
> +static ssize_t st_accel_sysfs_scale_available(struct device *dev,
> +                               struct device_attribute *attr, char *buf)
> +{
> +       int i, len = 0;
> +       struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +       struct st_accel_data *adata = iio_priv(indio_dev);
> +
> +       mutex_lock(&indio_dev->mlock);
> +       for (i = 0; i < ARRAY_SIZE(st_accel_sensors[adata->index].fs.fs_avl);
> +                                                                       i++) {
> +               if (st_accel_sensors[adata->index].fs.fs_avl[i].num == 0)
> +                       break;
> +
> +               len += sprintf(buf+len, "0.%06u ",
> +                       st_accel_sensors[adata->index].fs.fs_avl[i].gain);
> +       }
> +       mutex_unlock(&indio_dev->mlock);
> +       buf[len-1] = '\n';
> +
> +       return len;
> +}
> +
> +static ssize_t st_accel_sysfs_sampling_frequency_available(struct
> device *dev,
> +                               struct device_attribute *attr, char *buf)
> +{
> +       int i, len = 0;
> +       struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +       struct st_accel_data *adata = iio_priv(indio_dev);
> +
> +       mutex_lock(&indio_dev->mlock);
> +       for (i = 0; i < ARRAY_SIZE(st_accel_sensors[adata->index].odr.odr_avl);
> +                                                                       i++) {
> +               if (st_accel_sensors[adata->index].odr.odr_avl[i].hz == 0)
> +                       break;
> +
> +               len += sprintf(buf + len, "%d ",
> +                       st_accel_sensors[adata->index].odr.odr_avl[i].hz);
> +       }
> +       mutex_unlock(&indio_dev->mlock);
> +       buf[len - 1] = '\n';
> +
> +       return len;
> +}
> +
> +static IIO_DEVICE_ATTR(sampling_frequency_available, S_IRUGO,
> +               st_accel_sysfs_sampling_frequency_available, NULL , 0);
> +
> +static IIO_DEVICE_ATTR(in_accel_scale_available, S_IRUGO,
> +                               st_accel_sysfs_scale_available, NULL , 0);
> +
> +static IIO_DEVICE_ATTR(powerdown, S_IWUSR | S_IRUGO,
> +               st_accel_sysfs_get_powerdown, st_accel_sysfs_set_powerdown , 0);
> +
> +static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
> +                       st_accel_sysfs_get_sampling_frequency,
> +                                       st_accel_sysfs_set_sampling_frequency);
> +
> +static struct attribute *st_accel_attributes[] = {
> +       &iio_dev_attr_sampling_frequency_available.dev_attr.attr,
> +       &iio_dev_attr_in_accel_scale_available.dev_attr.attr,
> +       &iio_dev_attr_powerdown.dev_attr.attr,
> +       &iio_dev_attr_sampling_frequency.dev_attr.attr,
> +       NULL,
> +};
> +
> +static const struct attribute_group st_accel_attribute_group = {
> +       .attrs = st_accel_attributes,
> +};
> +
> +static const struct iio_info acc_info = {
> +       .driver_module = THIS_MODULE,
> +       .attrs = &st_accel_attribute_group,
> +       .read_raw = &st_accel_read_raw,
> +       .write_raw = &st_accel_write_raw,
> +};
> +
> +static int st_accel_init_sensor(struct iio_dev *indio_dev)
> +{
> +       int err;
> +       struct st_accel_odr_available odr_out;
> +       struct st_accel_fullscale_available fs_out;
> +       struct st_accel_data *adata = iio_priv(indio_dev);
> +
> +       err = st_accel_set_enable(indio_dev, false);
> +       if (err < 0)
> +               goto init_error;
> +
> +       err = st_accel_set_axis_enable(indio_dev, ST_ACCEL_ENABLE_ALL_CHANNELS);
> +       if (err < 0)
> +               goto init_error;
> +
> +       st_accel_match_fs(&st_accel_sensors[adata->index],
> +                                               adata->fullscale, &fs_out);
> +       err = st_accel_set_fullscale(indio_dev, &fs_out);
> +       if (err < 0)
> +               goto init_error;
> +
> +       st_accel_match_odr(&st_accel_sensors[adata->index],
> +                                                       adata->odr, &odr_out);
> +       err = st_accel_set_odr(indio_dev, &odr_out);
> +       if (err < 0)
> +               goto init_error;
> +
> +       err = st_accel_set_bdu(indio_dev,
> +                               &st_accel_sensors[adata->index].bdu, true);
> +
> +init_error:
> +       return err;
> +}
> +
> +int st_accel_iio_probe(struct iio_dev *indio_dev, int irq)
> +{
> +       int err;
> +       u8 wai;
> +       struct st_accel_data *adata = iio_priv(indio_dev);
> +
> +       indio_dev->modes = INDIO_DIRECT_MODE;
> +       indio_dev->info = &acc_info;
> +
> +       err = st_accel_get_wai_device(indio_dev,
> +                                       ST_ACCEL_DEFAULT_WAI_ADDRESS, &wai);
> +       if (err < 0)
> +               goto st_accel_iio_probe_error;
> +
> +       err = st_accel_check_device_list(indio_dev, wai);
> +       if (err < 0)
> +               goto st_accel_iio_probe_error;
> +
> +       adata->multiread_bit = st_accel_sensors[adata->index].multi_read_bit;
> +       indio_dev->channels = st_accel_sensors[adata->index].ch;
> +       indio_dev->num_channels = ST_ACCEL_NUMBER_ALL_CHANNELS;
> +
> +       adata->fullscale = ST_ACCEL_FS_AVL_2G;
> +       adata->odr = 100;
> +
> +       err = st_accel_init_sensor(indio_dev);
> +       if (err < 0)
> +               goto st_accel_iio_probe_error;
> +
> +       err = st_accel_allocate_ring(indio_dev);
> +       if (err < 0)
> +               goto st_accel_iio_probe_error;
> +
> +       if (irq > 0) {
> +               err = st_accel_probe_trigger(indio_dev, irq);
> +               if (err < 0)
> +                       goto acc_probe_trigger_error;
> +       }
> +
> +       err = iio_device_register(indio_dev);
> +       if (err)
> +               goto iio_device_register_error;
> +
> +       return err;
> +
> +iio_device_register_error:
> +       st_accel_remove_trigger(indio_dev, irq);
> +acc_probe_trigger_error:
> +       st_accel_deallocate_ring(indio_dev);
> +st_accel_iio_probe_error:
> +       return err;
> +}
> +EXPORT_SYMBOL(st_accel_iio_probe);
> +
> +void st_accel_iio_remove(struct iio_dev *indio_dev, int irq)
> +{
> +       iio_device_unregister(indio_dev);
> +       st_accel_remove_trigger(indio_dev, irq);
> +       st_accel_deallocate_ring(indio_dev);
> +       iio_device_free(indio_dev);
> +}
> +EXPORT_SYMBOL(st_accel_iio_remove);
> +
> +MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
> +MODULE_DESCRIPTION("STMicroelectronics accelerometers driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/accel/st_accel_i2c.c
> b/drivers/iio/accel/st_accel_i2c.c
> new file mode 100644
> index 0000000..f4680a2
> --- /dev/null
> +++ b/drivers/iio/accel/st_accel_i2c.c
> @@ -0,0 +1,128 @@
> +/*
> + * STMicroelectronics accelerometers driver
> + *
> + * Copyright 2012 STMicroelectronics Inc.
> + *
> + * Denis Ciocca <denis.ciocca@st.com>
> + *
> + * Licensed under the GPL-2.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
> +
> +#include <linux/iio/accel/st_accel.h>
> +
> +#define ST_ACCEL_I2C_MULTIREAD                 0x80
> +
> +static int st_accel_i2c_read_byte(struct st_accel_data *adata,
> +                                               u8 reg_addr, u8 *res_byte)
> +{
> +       int err;
> +
> +       err = i2c_smbus_read_byte_data(to_i2c_client(adata->dev), reg_addr);
> +       if (err < 0)
> +               goto st_accel_i2c_read_byte_error;
> +
> +       *res_byte = err & 0xff;
> +
> +st_accel_i2c_read_byte_error:
> +       return err;
> +}
> +
> +static int st_accel_i2c_read_multiple_byte(struct st_accel_data *adata,
> +                                               u8 reg_addr, int len, u8 *data)
> +{
> +       if (adata->multiread_bit == true)
> +               reg_addr |= ST_ACCEL_I2C_MULTIREAD;
> +
> +       return i2c_smbus_read_i2c_block_data(to_i2c_client(adata->dev),
> +                                                       reg_addr, len, data);
> +}
> +
> +static int st_accel_i2c_write_byte(struct st_accel_data *adata,
> +                                                       u8 reg_addr, u8 data)
> +{
> +       return i2c_smbus_write_byte_data(to_i2c_client(adata->dev),
> +                                                               reg_addr, data);
> +}
> +
> +static int __devinit st_accel_i2c_probe(struct i2c_client *client,
> +                               const struct i2c_device_id *id)
> +{
> +       struct iio_dev *indio_dev;
> +       struct st_accel_data *adata;
> +       int err;
> +
> +       indio_dev = iio_device_alloc(sizeof(*adata));
> +       if (indio_dev == NULL) {
> +               err = -ENOMEM;
> +               goto iio_device_alloc_error;
> +       }
> +
> +       adata = iio_priv(indio_dev);
> +       adata->dev = &client->dev;
> +       i2c_set_clientdata(client, indio_dev);
> +
> +       indio_dev->dev.parent = &client->dev;
> +       indio_dev->name = client->name;
> +
> +       adata->read_byte = st_accel_i2c_read_byte;
> +       adata->write_byte = st_accel_i2c_write_byte;
> +       adata->read_multiple_byte = st_accel_i2c_read_multiple_byte;
> +
> +       err = st_accel_iio_probe(indio_dev, client->irq);
> +       if (err < 0)
> +               goto acc_iio_default_error;
> +
> +       return 0;
> +
> +acc_iio_default_error:
> +       iio_device_free(indio_dev);
> +iio_device_alloc_error:
> +       return err;
> +}
> +
> +static int __devexit st_accel_i2c_remove(struct i2c_client *client)
> +{
> +       struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +       st_accel_iio_remove(indio_dev, client->irq);
> +
> +       return 0;
> +}
> +
> +static const struct i2c_device_id st_accel_id_table[] = {
> +       { LSM303DLH_ACCEL_DEV_NAME },
> +       { LSM303DLHC_ACCEL_DEV_NAME },
> +       { LIS3DH_ACCEL_DEV_NAME },
> +       { LSM330D_ACCEL_DEV_NAME },
> +       { LSM330DL_ACCEL_DEV_NAME },
> +       { LSM330DLC_ACCEL_DEV_NAME },
> +       { LSM303D_ACCEL_DEV_NAME },
> +       { LSM9DS0_ACCEL_DEV_NAME },
> +       { LIS331DLH_ACCEL_DEV_NAME },
> +       { LSM303DL_ACCEL_DEV_NAME },
> +       { LSM303DLM_ACCEL_DEV_NAME },
> +       { LSM330_ACCEL_DEV_NAME },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
> +
> +static struct i2c_driver st_accel_driver = {
> +       .driver = {
> +               .owner = THIS_MODULE,
> +               .name = "st-accel-i2c",
> +       },
> +       .probe = st_accel_i2c_probe,
> +       .remove = __devexit_p(st_accel_i2c_remove),
> +       .id_table = st_accel_id_table,
> +};
> +module_i2c_driver(st_accel_driver);
> +
> +MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
> +MODULE_DESCRIPTION("STMicroelectronics accelerometers i2c driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/accel/st_accel_spi.c
> b/drivers/iio/accel/st_accel_spi.c
> new file mode 100644
> index 0000000..1f7f167
> --- /dev/null
> +++ b/drivers/iio/accel/st_accel_spi.c
> @@ -0,0 +1,186 @@
> +/*
> + * STMicroelectronics accelerometers driver
> + *
> + * Copyright 2012 STMicroelectronics Inc.
> + *
> + * Denis Ciocca <denis.ciocca@st.com>
> + *
> + * Licensed under the GPL-2.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/spi/spi.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
> +
> +#include <linux/iio/accel/st_accel.h>
> +
> +
> +#define ACC_SPI_READ           0x80;
> +#define ACC_SPI_MULTIREAD      0xc0
> +
> +static int st_accel_spi_read_byte(struct st_accel_data *adata,
> +                                               u8 reg_addr, u8 *res_byte)
> +{
> +       struct spi_message msg;
> +       int err;
> +       u8 tx;
> +
> +       struct spi_transfer xfers[] = {
> +               {
> +                       .tx_buf = &tx,
> +                       .bits_per_word = 8,
> +                       .len = 1,
> +               },
> +               {
> +                       .rx_buf = res_byte,
> +                       .bits_per_word = 8,
> +                       .len = 1,
> +               }
> +       };
> +
> +       tx = reg_addr | ACC_SPI_READ;
> +       spi_message_init(&msg);
> +       spi_message_add_tail(&xfers[0], &msg);
> +       spi_message_add_tail(&xfers[1], &msg);
> +       err = spi_sync(to_spi_device(adata->dev), &msg);
Little tidy up, but could a single util function called by both
the read_multiple below and this one reduce code repitition?
> +
> +       return err;
> +}
> +
> +static int st_accel_spi_read_multiple_byte(struct st_accel_data *adata,
> +                                               u8 reg_addr, int len, u8 *data)
> +{
> +       struct spi_message msg;
> +       int err;
> +       u8 tx;
> +
> +       struct spi_transfer xfers[] = {
> +               {
> +                       .tx_buf = &tx,
> +                       .bits_per_word = 8,
> +                       .len = 1,
> +               },
> +               {
> +                       .rx_buf = data,
> +                       .bits_per_word = 8,
> +                       .len = len,
> +               }
> +       };
> +
> +       if (adata->multiread_bit == true)
> +               tx = reg_addr | ACC_SPI_MULTIREAD;
> +       else
> +               tx = reg_addr | ACC_SPI_READ;
> +
> +       spi_message_init(&msg);
> +       spi_message_add_tail(&xfers[0], &msg);
> +       spi_message_add_tail(&xfers[1], &msg);
> +       err = spi_sync(to_spi_device(adata->dev), &msg);
> +       if (err)
> +               goto acc_spi_read_multiple_byte_error;
> +
> +       return len;
> +
> +acc_spi_read_multiple_byte_error:
> +       return err;
> +}
> +
> +static int st_accel_spi_write_byte(struct st_accel_data *adata,
> +                                                       u8 reg_addr, u8 data)
> +{
> +       struct spi_message msg;
> +       int err;
> +       u8 tx[2];
We may have a cacheline issue here for some spi controllers.
As they often use dma one needs to ensure the buffers are in
different cachelines from anything else.  Usual trick
is to dynamically allocate them either separately with a kmalloc
or in the adata structure using appropriate alignment forcing.

 Basically any buffers being used in spi transfers must be in a different
cacheline from the rest of the code (no problem with tx and rx being in
the same line as far as I know).
> +
> +       struct spi_transfer xfers = {
> +               .tx_buf = tx,
> +               .bits_per_word = 8,
> +               .len = 2,
> +       };
> +
> +       tx[0] = reg_addr;
> +       tx[1] = data;
> +       spi_message_init(&msg);
> +       spi_message_add_tail(&xfers, &msg);
> +       err = spi_sync(to_spi_device(adata->dev), &msg);
> +
> +       return err;
> +}
> +
> +static int __devinit st_accel_spi_probe(struct spi_device *spi)
> +{
> +       struct iio_dev *indio_dev;
> +       struct st_accel_data *adata;
> +       int err;
> +
> +       indio_dev = iio_device_alloc(sizeof(*adata));
> +       if (indio_dev == NULL) {
> +               err = -ENOMEM;
> +               goto iio_device_alloc_error;
> +       }
> +
> +       adata = iio_priv(indio_dev);
> +       adata->dev = &spi->dev;
> +       spi_set_drvdata(spi, indio_dev);
> +
> +       indio_dev->dev.parent = &spi->dev;
> +       indio_dev->name = spi->modalias;
> +
> +       adata->read_byte = st_accel_spi_read_byte;
> +       adata->write_byte = st_accel_spi_write_byte;
> +       adata->read_multiple_byte = st_accel_spi_read_multiple_byte;
> +
> +       err = st_accel_iio_probe(indio_dev, spi->irq);
> +       if (err < 0)
> +               goto acc_iio_default_error;
> +
> +       return 0;
> +
> +acc_iio_default_error:
> +       iio_device_free(indio_dev);
> +iio_device_alloc_error:
> +       return err;
> +}
> +
> +static int __devexit st_accel_spi_remove(struct spi_device *spi)
> +{
> +       struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +       st_accel_iio_remove(indio_dev, spi->irq);
> +
> +       return 0;
> +}
> +
> +static const struct spi_device_id st_accel_id_table[] = {
> +       { LSM303DLH_ACCEL_DEV_NAME },
> +       { LSM303DLHC_ACCEL_DEV_NAME },
> +       { LIS3DH_ACCEL_DEV_NAME },
> +       { LSM330D_ACCEL_DEV_NAME },
> +       { LSM330DL_ACCEL_DEV_NAME },
> +       { LSM330DLC_ACCEL_DEV_NAME },
> +       { LSM303D_ACCEL_DEV_NAME },
> +       { LSM9DS0_ACCEL_DEV_NAME },
> +       { LIS331DLH_ACCEL_DEV_NAME },
> +       { LSM303DL_ACCEL_DEV_NAME },
> +       { LSM303DLM_ACCEL_DEV_NAME },
> +       { LSM330_ACCEL_DEV_NAME },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(spi, st_accel_id_table);
> +
> +static struct spi_driver st_accel_driver = {
> +       .driver = {
> +               .owner = THIS_MODULE,
> +               .name = "st-accel-spi",
> +       },
> +       .probe = st_accel_spi_probe,
> +       .remove = __devexit_p(st_accel_spi_remove),
> +       .id_table = st_accel_id_table,
> +};
> +module_spi_driver(st_accel_driver);
> +
> +MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
> +MODULE_DESCRIPTION("STMicroelectronics accelerometers spi driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/accel/st_accel_trigger.c
> b/drivers/iio/accel/st_accel_trigger.c
> new file mode 100644
> index 0000000..68813f7
> --- /dev/null
> +++ b/drivers/iio/accel/st_accel_trigger.c
> @@ -0,0 +1,83 @@
> +/*
> + * STMicroelectronics accelerometers driver
> + *
> + * Copyright 2012 STMicroelectronics Inc.
> + *
> + * Denis Ciocca <denis.ciocca@st.com>
> + *
> + * Licensed under the GPL-2.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/stat.h>
> +#include <linux/interrupt.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
> +
> +#include <linux/iio/accel/st_accel.h>
> +
> +static int st_accel_trig_acc_set_state(struct iio_trigger *trig, bool
> state)
> +{
> +       struct iio_dev *indio_dev = trig->private_data;
> +       return st_accel_set_dataready_irq(indio_dev, state);
> +}
> +
> +static const struct iio_trigger_ops st_accel_trigger_ops = {
> +       .owner = THIS_MODULE,
> +       .set_trigger_state = &st_accel_trig_acc_set_state,
> +};
> +
> +int st_accel_probe_trigger(struct iio_dev *indio_dev, int irq)
> +{
> +       int err;
> +       struct st_accel_data *adata = iio_priv(indio_dev);
> +
> +       adata->trig = iio_trigger_alloc("%s-trigger", indio_dev->name);
> +       if (adata->trig == NULL) {
> +               err = -ENOMEM;
> +               dev_err(&indio_dev->dev, "failed to allocate iio trigger.\n");
> +               goto iio_trigger_alloc_error;
> +       }
> +
> +       err = request_threaded_irq(irq,
> +                       iio_trigger_generic_data_rdy_poll,
> +                       NULL,
> +                       IRQF_TRIGGER_RISING,
> +                       adata->trig->name,
> +                       adata->trig);
> +       if (err)
> +               goto request_irq_error;
> +
> +       adata->trig->private_data = indio_dev;
> +       adata->trig->ops = &st_accel_trigger_ops;
> +       adata->trig->dev.parent = adata->dev;
> +
> +       err = iio_trigger_register(adata->trig);
> +       if (err < 0) {
> +               dev_err(&indio_dev->dev, "failed to register iio trigger.\n");
> +               goto iio_trigger_register_error;
> +       }
> +       indio_dev->trig = adata->trig;
> +
> +       return 0;
> +
> +iio_trigger_register_error:
> +       free_irq(irq, adata->trig);
> +request_irq_error:
> +       iio_trigger_free(adata->trig);
> +iio_trigger_alloc_error:
> +       return err;
> +}
> +EXPORT_SYMBOL(st_accel_probe_trigger);
> +
> +void st_accel_remove_trigger(struct iio_dev *indio_dev, int irq)
> +{
> +       struct st_accel_data *adata = iio_priv(indio_dev);
> +
> +       iio_trigger_unregister(adata->trig);
> +       free_irq(irq, adata->trig);
> +       iio_trigger_free(adata->trig);
> +}
> +EXPORT_SYMBOL(st_accel_remove_trigger);
> diff --git a/include/linux/iio/accel/st_accel.h
> b/include/linux/iio/accel/st_accel.h
> new file mode 100644
> index 0000000..9e0abd6
> --- /dev/null
> +++ b/include/linux/iio/accel/st_accel.h
> @@ -0,0 +1,102 @@
> +/*
> + * STMicroelectronics accelerometers driver
> + *
> + * Copyright 2012 STMicroelectronics Inc.
> + *
> + * Denis Ciocca <denis.ciocca@st.com>
> + * v. 1.0.0
> + * Licensed under the GPL-2.
> + */
> +
> +#ifndef ST_ACCEL_H
> +#define ST_ACCEL_H
> +
> +#define LSM303DLH_ACCEL_DEV_NAME       "lsm303dlh_accel"
> +#define LSM303DLHC_ACCEL_DEV_NAME      "lsm303dlhc_accel"
> +#define LIS3DH_ACCEL_DEV_NAME          "lis3dh"
> +#define LSM330D_ACCEL_DEV_NAME         "lsm330d_accel"
> +#define LSM330DL_ACCEL_DEV_NAME                "lsm330dl_accel"
> +#define LSM330DLC_ACCEL_DEV_NAME       "lsm330dlc_accel"
> +#define LSM303D_ACCEL_DEV_NAME         "lsm303d"
> +#define LSM9DS0_ACCEL_DEV_NAME         "lsm9ds0"
> +#define LIS331DLH_ACCEL_DEV_NAME       "lis331dlh"
> +#define LSM303DL_ACCEL_DEV_NAME                "lsm303dl_accel"
> +#define LSM303DLM_ACCEL_DEV_NAME       "lsm303dlm_accel"
> +#define LSM330_ACCEL_DEV_NAME          "lsm330_accel"
> +
> +#define ST_ACCEL_NUMBER_ALL_CHANNELS   4
> +#define ST_ACCEL_NUMBER_DATA_CHANNELS  3
> +#define ST_ACCEL_BYTE_FOR_CHANNEL      2
> +#define ST_ACCEL_SCAN_X                        0
> +#define ST_ACCEL_SCAN_Y                        1
> +#define ST_ACCEL_SCAN_Z                        2
> +
> +/**
> + * struct st_accel_data - ST accel device status
> + * @dev: Pointer to instance of struct device (I2C or SPI).
> + * @trig: The trigger in use by the core driver.
> + * @enabled: Status of the sensor (false->off, true->on).
> + * @multiread_bit: Use or not particular bit for [I2C/SPI] multiread.
> + * @index: Number used to point the sensor being used in the
> + *     st_accel_sensors struct.
> + * @buffer_data: Data used by buffer part.
> + * @fullscale: Maximum range of measure by the sensor.
> + * @gain: Sensitivity of the sensor [m/s^2/LSB].
> + * @odr: Output data rate of the sensor [Hz].
> + * @read_byte: Function used to read one byte.
> + * @write_byte: Function used to write one byte.
> + * @read_multiple_byte: Function used to read multiple byte.
> + */
> +
> +struct st_accel_data {
> +       struct device *dev;
> +       struct iio_trigger *trig;
> +
> +       bool enabled;
> +       bool multiread_bit;
> +
> +       short index;
> +
> +       char *buffer_data;
> +
> +       unsigned int fullscale;
> +       unsigned int gain;
> +       unsigned int odr;
> +
> +       int (*read_byte) (struct st_accel_data *adata, u8 reg_addr,
> +                                                               u8 *res_byte);
> +       int (*write_byte) (struct st_accel_data *adata, u8 reg_addr, u8 data);
> +       int (*read_multiple_byte) (struct st_accel_data *adata, u8 reg_addr,
> +                                                       int len, u8 *data);
> +};
> +
> +int st_accel_iio_probe(struct iio_dev *indio_dev, int irq);
> +void st_accel_iio_remove(struct iio_dev *indio_dev, int irq);
> +int st_accel_set_dataready_irq(struct iio_dev *indio_dev, bool enable);
> +int st_accel_set_axis_enable(struct iio_dev *indio_dev, u8 axis_enable);
> +
> +#ifdef CONFIG_IIO_BUFFER
> +int st_accel_probe_trigger(struct iio_dev *indio_dev, int irq);
> +void st_accel_remove_trigger(struct iio_dev *indio_dev, int irq);
> +int st_accel_allocate_ring(struct iio_dev *indio_dev);
> +void st_accel_deallocate_ring(struct iio_dev *indio_dev);
> +#else /* CONFIG_IIO_BUFFER */
> +static inline int st_accel_probe_trigger(struct iio_dev *indio_dev, int
> irq)
> +{
> +       return 0;
> +}
> +static inline void st_accel_remove_trigger(struct iio_dev *indio_dev,
> int irq)
> +{
> +       return;
> +}
> +static inline int st_accel_allocate_ring(struct iio_dev *indio_dev)
> +{
> +       return 0;
> +}
> +static inline void st_accel_deallocate_ring(struct iio_dev *indio_dev)
> +{
> +       return;
> +}
> +#endif /* CONFIG_IIO_BUFFER */
> +
> +#endif /* ST_ACCEL_H */
> --
> 1.7.0.4
>
