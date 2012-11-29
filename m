Return-Path: <lars@metafoo.de>
Message-ID: <50B72F0F.4040804@metafoo.de>
Date: Thu, 29 Nov 2012 10:46:55 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: Jonathan Cameron <jic23@kernel.org>,
 Denis Ciocca <denis.ciocca@gmail.com>,
 Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
 Pavel Machek <pavel@denx.de>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "burman.yan@gmail.com" <burman.yan@gmail.com>
Subject: Re: STMicroelectronics accelerometers driver.
References: <5072F3B9.4050309@st.com> <5073260C.3010506@metafoo.de> <20121008195007.GA32042@elf.ucw.cz> <507338B5.60307@metafoo.de> <665718a4-de6b-4d09-ba80-35705fcf2595@email.android.com> <CAEE_umojW5OyB3yGgE54wH7_k__dBu9=Yew_0tCCf5--=C2g5g@mail.gmail.com> <507D9EA3.4070009@metafoo.de> <5085128C.7020507@st.com> <50858B44.2080006@kernel.org> <5087E2A8.4070304@st.com> <508A7DA6.7050505@metafoo.de> <508E4492.8080000@st.com> <508E48D1.3000703@metafoo.de> <508E5978.5000907@st.com> <508E5AD5.1040907@metafoo.de> <50914366.4090000@st.com> <5091546D.9000601@metafoo.de> <CAEE_umoKvv9ciBfUSahDqsmcbHi9W=93o5YSpE-vxUduCmqWSQ@mail.gmail.com> <50982F71.3060606@kernel.org> <5098F065.1090009@st.com> <50A12D8C.6040207@st.com> <50A14485.2060902@kernel.org> <50A26967.4050102@st.com> <50A8E083.1050908@kernel.org> <50AFA000.3040906@st.com> <50B0F495.6040409@kernel.org> <50B4A96A.3060505@st.com>
In-Reply-To: <50B4A96A.3060505@st.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 11/27/2012 12:52 PM, Denis CIOCCA wrote:
> Hi everybody,
> 
> I attach the new modified patch with corrections about DMA using SPI.
> Best regards,
> 
> Denis
> 

Hi,

I think the driver looks fine now mostly fine. You need to watch your
kmallocs though, you introduced quite a few memory leaks in the latest
revisions of the driver.

And your e-mail client still replaces tabs with spaces as well as adding
newlines to overlong lines.

Either fix your E-Mail client or just use git send-email[1] which does
pretty good job and is straight forward to use. E.g. what I use to send out
IIO patches is:

git send-email --to "Jonathan Cameron <jic23@cam.ac.uk>" \
    --cc linux-iio@vger.kernel.org --cc drivers@analog.com \
    *.patch

[1] http://www.kernel.org/pub/software/scm/git/docs/git-send-email.html

> 
> 
> 
>  From 1b3c4eb307c1083cafa3dba6f1777f8438f4a6ad Mon Sep 17 00:00:00 2001
> From: Denis Ciocca <denis.ciocca@st.com>
> Date: Mon, 22 Oct 2012 11:17:27 +0200
> Subject: [PATCH 3/3] iio:accel: Add STMicroelectronics accelerometers driver
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
>   drivers/iio/accel/st_accel_buffer.c              |  177 ++++
>   drivers/iio/accel/st_accel_core.c                | 1171
> ++++++++++++++++++++++
>   drivers/iio/accel/st_accel_i2c.c                 |  128 +++
>   drivers/iio/accel/st_accel_spi.c                 |  182 ++++
>   drivers/iio/accel/st_accel_trigger.c             |   83 ++
>   include/linux/iio/accel/st_accel.h               |  102 ++
>   9 files changed, 1893 insertions(+), 0 deletions(-)
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

You use SPI here and SPI_MASTER down below, it would be more consistent to
use SPI_MASTER in both places.

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
> index 0000000..e8419be
> --- /dev/null
[...]
> +
> +static irqreturn_t st_accel_trigger_handler(int irq, void *p)
> +{
> +       int len;
> +       struct iio_poll_func *pf = p;
> +       struct iio_dev *indio_dev = pf->indio_dev;
> +       struct st_accel_data *adata = iio_priv(indio_dev);
> +
> +       len = st_accel_get_buffer_element(indio_dev, adata->buffer_data);
> +       if (len < 0)
> +               goto st_accel_get_buffer_element_error;
> +
> +       if (indio_dev->scan_timestamp)
> +               *(s64 *)((u8 *)adata->buffer_data +
> +                               ALIGN(len, sizeof(s64))) = pf->timestamp;
> +
> +       iio_push_to_buffer(indio_dev->buffer, adata->buffer_data);

I think Jonathan mentioned this before. The interface has slightly changed.
It is iio_push_to_buffers(indio_dev, adata->buffer_data) now

> +
> +st_accel_get_buffer_element_error:
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

I think you go the labels wrong here. You jump to kfree if the allocation
fails...

> +       }
> +
> +       for (i = 0; i < ST_ACCEL_NUMBER_DATA_CHANNELS; i++)
> +               if (test_bit(i, indio_dev->active_scan_mask))
> +                       active_bit |= (1 << i);
> +
> +       err = st_accel_set_axis_enable(indio_dev, active_bit);
> +       if (err < 0)
> +               goto st_accel_buffer_postenable_error;

... but skip the kfree if the allocation succeeded.

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

I think you should still free the buffer

> +
> +       kfree(adata->buffer_data);
> +
> +st_accel_buffer_predisable_error:
> +       return err;
> +}
> +
[...]
> diff --git a/drivers/iio/accel/st_accel_core.c
> b/drivers/iio/accel/st_accel_core.c
> new file mode 100644
> index 0000000..791161e
> --- /dev/null
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -0,0 +1,1171 @@
[...]
> +static int st_accel_write_data_with_mask(struct iio_dev *indio_dev, u8
> reg_addr,
> +                                               u8 mask, short num_bit, u8 data)
> +{
> +       int err;
> +       u8 *prev_data;
> +       u8 new_data;
> +       struct st_accel_data *adata = iio_priv(indio_dev);
> +
> +       prev_data = kmalloc(sizeof(*prev_data), GFP_KERNEL);

Is this ever freed? I think it may make sense to use a global buffer in your
st_accel_data struct instead of allocation a new one for each read. If you
do this make sure that you protect the use of the buffer with a mutex.

> +       if (prev_data == NULL) {
> +               err = -ENOMEM;
> +               goto st_accel_write_data_with_mask_error;
> +       }
> +
> +       err = adata->read_byte(adata, reg_addr, prev_data);
> +       if (err < 0)
> +               goto st_accel_write_data_with_mask_error;
> +
> +       new_data = ((*prev_data & (~mask)) | ((data << __ffs(mask)) & mask));
> +       err = adata->write_byte(adata, reg_addr, new_data);
> +
> +st_accel_write_data_with_mask_error:
> +       return err;
> +}

[...]
> b/drivers/iio/accel/st_accel_spi.c
> new file mode 100644
> index 0000000..6df1440
> --- /dev/null
> +++ b/drivers/iio/accel/st_accel_spi.c
> @@ -0,0 +1,182 @@
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
> +static int st_accel_spi_read(struct st_accel_data *adata,
> +                                               u8 reg_addr, int len, u8 *data)
> +{
> +       struct spi_message msg;
> +       int err;
> +       u8 *tx;
> +
> +       struct spi_transfer xfers[] = {
> +               {
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
> +       tx = kmalloc(sizeof(*tx), GFP_KERNEL);

This is never freed. Again it may make sense to make this buffer a field in
your st_accel_data struct, so you don't have to allocate it for each
transfer. Take a look at how other IIO drivers handle this. The keyword here
is ____cacheline_aligned.

> +       if (tx == NULL) {
> +               err = -ENOMEM;
> +               goto acc_spi_read_error;
> +       }
> +
> +       if ((adata->multiread_bit == true) && (len > 1))
> +               *tx = reg_addr | ACC_SPI_MULTIREAD;
> +       else
> +               *tx = reg_addr | ACC_SPI_READ;
> +
> +       xfers[0].tx_buf = tx;
> +       spi_message_init(&msg);
> +       spi_message_add_tail(&xfers[0], &msg);
> +       spi_message_add_tail(&xfers[1], &msg);
> +       err = spi_sync(to_spi_device(adata->dev), &msg);
> +       if (err)
> +               goto acc_spi_read_error;
> +
> +       return len;
> +
> +acc_spi_read_error:
> +       return err;
> +}
> +
> +
> +static int st_accel_spi_write_byte(struct st_accel_data *adata,
> +                                                       u8 reg_addr, u8 data)
> +{
> +       struct spi_message msg;
> +       int err;
> +       u8 *tx;
> +
> +       struct spi_transfer xfers = {
> +               .bits_per_word = 8,
> +               .len = 2,
> +       };
> +
> +       tx = kmalloc(sizeof(*tx)*2, GFP_KERNEL);

Same here

> +       if (tx == NULL) {
> +               err = -ENOMEM;
> +               goto alloc_memory_error;
> +       }
> +
> +       tx[0] = reg_addr;
> +       tx[1] = data;
> +       xfers.tx_buf = tx;
> +       spi_message_init(&msg);
> +       spi_message_add_tail(&xfers, &msg);
> +       err = spi_sync(to_spi_device(adata->dev), &msg);
> +
> +alloc_memory_error:
> +       return err;
> +}
[...]


> diff --git a/include/linux/iio/accel/st_accel.h
> b/include/linux/iio/accel/st_accel.h
> new file mode 100644
> index 0000000..9e0abd6
> --- /dev/null
> +++ b/include/linux/iio/accel/st_accel.h
[...]
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

You don't need the return here.

> +}
> +#endif /* CONFIG_IIO_BUFFER */
> +
> +#endif /* ST_ACCEL_H */
