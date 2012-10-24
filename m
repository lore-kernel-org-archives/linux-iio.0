Return-Path: <denis.ciocca@st.com>
From: Denis CIOCCA <denis.ciocca@st.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Denis Ciocca <denis.ciocca@gmail.com>,
	Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
	Pavel Machek <pavel@denx.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"burman.yan@gmail.com" <burman.yan@gmail.com>
Date: Wed, 24 Oct 2012 14:44:24 +0200
Subject: Re: STMicroelectronics accelerometers driver.
Message-ID: <5087E2A8.4070304@st.com>
References: <5072F3B9.4050309@st.com> <5073260C.3010506@metafoo.de>
 <20121008195007.GA32042@elf.ucw.cz> <507338B5.60307@metafoo.de>
 <665718a4-de6b-4d09-ba80-35705fcf2595@email.android.com>
 <CAEE_umojW5OyB3yGgE54wH7_k__dBu9=Yew_0tCCf5--=C2g5g@mail.gmail.com>
 <507D9EA3.4070009@metafoo.de> <5085128C.7020507@st.com>
 <50858B44.2080006@kernel.org>
In-Reply-To: <50858B44.2080006@kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,


> For the non buffered case - reading is slow anyway so if anyone cares
> they will be doing buffered reads.  For buffered reads this isn't going
> to change often (and there is a lot of cost associated with bringing the =
buffer
> up and down anyway) so a little cost in disabling the channel is minor
> compared to the cost of hammering the bus unecessarily - particularly wit=
h
> good old slow i2c.
>
> So I'd be inclined to turn on only channels we care about.  Do you have
> an estimate of how long it will take to turn one on for a single read?

I have checked what you tell me about power on/off of the axis. For the
buffered case I have modify the driver to power on and off the single
axis. What you think about my driver now? It is necessary other modify?
Thanks

Denis


(If you want I send this patch by git because I don't know if this is
the better way)



 From b34e061a37655da5ab9bacde4d9a38bb9d3cf69f Mon Sep 17 00:00:00 2001
From: Denis Ciocca <denis.ciocca@st.com>
Date: Mon, 22 Oct 2012 11:17:27 +0200
Subject: [PATCH 1/2] iio:accel: Add STMicroelectronics accelerometers drive=
r

This patch adds generic accelerometer driver for STMicroelectronics
accelerometers, currently it supports:
LSM303DLH, LSM303DLHC, LIS3DH, LSM330D, LSM330DL, LSM330DLC, LSM303D,
LSM9DS0, LIS331DLH, LSM303DL, LSM303DLM, LSM330

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
  drivers/iio/accel/Kconfig                    |   37 +
  drivers/iio/accel/Makefile                   |    6 +
  drivers/iio/accel/st_accel_buffer.c          |  166 ++++
  drivers/iio/accel/st_accel_core.c            | 1342
++++++++++++++++++++++++++
  drivers/iio/accel/st_accel_i2c.c             |  139 +++
  drivers/iio/accel/st_accel_spi.c             |  199 ++++
  drivers/iio/accel/st_accel_trigger.c         |   84 ++
  include/linux/iio/accel/st_accel.h           |  122 +++
  include/linux/platform_data/st_accel_pdata.h |   27 +
  9 files changed, 2122 insertions(+), 0 deletions(-)
  create mode 100644 drivers/iio/accel/st_accel_buffer.c
  create mode 100644 drivers/iio/accel/st_accel_core.c
  create mode 100644 drivers/iio/accel/st_accel_i2c.c
  create mode 100644 drivers/iio/accel/st_accel_spi.c
  create mode 100644 drivers/iio/accel/st_accel_trigger.c
  create mode 100644 include/linux/iio/accel/st_accel.h
  create mode 100644 include/linux/platform_data/st_accel_pdata.h

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index b2510c4..d65e66a 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -13,4 +13,41 @@ config HID_SENSOR_ACCEL_3D
          Say yes here to build support for the HID SENSOR
          accelerometers 3D.

+config ST_ACCEL_3AXIS
+       tristate "STMicroelectronics accelerometers 3-Axis Driver"
+       depends on (I2C || SPI) && SYSFS
+       help
+         Say yes here to build support for STMicroelectronics acceleromete=
rs:
+         LSM303DLH, LSM303DLHC, LIS3DH, LSM330D, LSM330DL, LSM330DLC, LSM3=
03D,
+         LSM9DS0, LIS331DLH, LSM303DL, LSM303DLM, LSM330.
+
+         This driver can also be built as a module. If so, the module
+         will be called st_accel.
+
+config ST_ACCEL_3AXIS_I2C
+       tristate "support I2C bus connection"
+       depends on ST_ACCEL_3AXIS && I2C
+       help
+         Say yes here to build I2C support for STMicroelectronics accelero=
meters.
+
+         To compile this driver as a module, choose M here: the
+         module will be called st_accel_i2c.
+
+config ST_ACCEL_3AXIS_SPI
+       tristate "support SPI bus connection"
+       depends on ST_ACCEL_3AXIS && SPI_MASTER
+       help
+         Say yes here to build SPI support for STMicroelectronics accelero=
meters.
+
+         To compile this driver as a module, choose M here: the
+         module will be called st_accel_spi.
+
+config ST_ACCEL_3AXIS_TRIGGERED_BUFFER
+       tristate "support triggered buffer"
+       depends on ST_ACCEL_3AXIS
+       select IIO_TRIGGERED_BUFFER
+       select IIO_BUFFER
+       help
+         Default trigger and buffer for STMicroelectronics accelerometers =
driver.
+
  endmenu
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index 5bc6855..1541236 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -3,3 +3,9 @@
  #

  obj-$(CONFIG_HID_SENSOR_ACCEL_3D) +=3D hid-sensor-accel-3d.o
+
+st_accel-y :=3D st_accel_core.o
+obj-$(CONFIG_ST_ACCEL_3AXIS_I2C) +=3D st_accel_i2c.o
+obj-$(CONFIG_ST_ACCEL_3AXIS_SPI) +=3D st_accel_spi.o
+obj-$(CONFIG_ST_ACCEL_3AXIS_TRIGGERED_BUFFER) +=3D st_accel_trigger.o
st_accel_buffer.o
+obj-$(CONFIG_ST_ACCEL_3AXIS) +=3D st_accel.o
diff --git a/drivers/iio/accel/st_accel_buffer.c
b/drivers/iio/accel/st_accel_buffer.c
new file mode 100644
index 0000000..600ecc6
--- /dev/null
+++ b/drivers/iio/accel/st_accel_buffer.c
@@ -0,0 +1,166 @@
+/*
+ * STMicroelectronics accelerometers driver
+ *
+ * Copyright 2012 STMicroelectronics Inc.
+ *
+ * Denis Ciocca <denis.ciocca@st.com>
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/stat.h>
+#include <linux/interrupt.h>
+#include <linux/byteorder/generic.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#include <linux/iio/accel/st_accel.h>
+
+#define ST_ACCEL_ENABLE_ALL_CHANNELS           0x07
+
+
+static int st_accel_read_all(struct iio_dev *indio_dev, u8 *rx_array)
+{
+       int len =3D 0, i, n =3D 0;
+       u8 reg_addr[ST_ACCEL_NUMBER_DATA_CHANNELS];
+       struct st_accel_data *adata =3D iio_priv(indio_dev);
+
+       for (i =3D 0; i < ST_ACCEL_NUMBER_DATA_CHANNELS; i++) {
+               if (test_bit(i, indio_dev->active_scan_mask)) {
+                       reg_addr[n] =3D indio_dev->channels[i].address;
+                       n++;
+               }
+       }
+       switch (n) {
+       case 1:
+               len =3D adata->read_multiple_byte(adata, reg_addr[0],
+                                       ST_ACCEL_BYTE_FOR_CHANNEL, rx_array=
);
+               break;
+       case 2:
+               if ((reg_addr[1] - reg_addr[0]) =3D=3D ST_ACCEL_BYTE_FOR_CH=
ANNEL) {
+                       len =3D adata->read_multiple_byte(adata, reg_addr[0=
],
+                                       ST_ACCEL_BYTE_FOR_CHANNEL*n,
+                                       rx_array);
+               } else {
+                       len =3D adata->read_multiple_byte(adata, reg_addr[0=
],
+                               ST_ACCEL_BYTE_FOR_CHANNEL*
+                               ST_ACCEL_NUMBER_DATA_CHANNELS,
+                               rx_array);
+                       rx_array[2] =3D rx_array[4];
+                       rx_array[3] =3D rx_array[5];
+                       len =3D ST_ACCEL_BYTE_FOR_CHANNEL*n;
+               }
+               break;
+       case 3:
+               len =3D adata->read_multiple_byte(adata, reg_addr[0],
+                       ST_ACCEL_BYTE_FOR_CHANNEL*ST_ACCEL_NUMBER_DATA_CHAN=
NELS,
+                       rx_array);
+               break;
+       default:
+               break;
+       }
+
+       return len;
+}
+
+static int st_accel_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
+{
+       int ret, i, scan_count;
+       u8 rx_array[ST_ACCEL_BYTE_FOR_CHANNEL*ST_ACCEL_NUMBER_DATA_CHANNELS=
];
+       s16 *data =3D (s16 *)buf;
+
+       ret =3D st_accel_read_all(indio_dev, rx_array);
+       if (ret < 0)
+               return ret;
+
+       scan_count =3D bitmap_weight(indio_dev->active_scan_mask,
+                                                       indio_dev->maskleng=
th);
+
+       for (i =3D 0; i < scan_count; i++)
+               data[i] =3D (s16)(((s16)(rx_array[2*i+1]) << 8) | rx_array[=
2*i]);
+
+       return i*sizeof(data[0]);
+}
+
+static irqreturn_t st_accel_trigger_handler(int irq, void *p)
+{
+       struct iio_poll_func *pf =3D p;
+       struct iio_dev *indio_dev =3D pf->indio_dev;
+       int len =3D 0;
+       char *data;
+
+       data =3D kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
+       if (data =3D=3D NULL)
+               goto done;
+       if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklengt=
h))
+               len =3D st_accel_get_buffer_element(indio_dev, data);
+       else
+               goto done;
+       if (indio_dev->scan_timestamp)
+               *(s64 *)((u8 *)data + ALIGN(len, sizeof(s64))) =3D pf->time=
stamp;
+       iio_push_to_buffer(indio_dev->buffer, data);
+       kfree(data);
+
+done:
+       iio_trigger_notify_done(indio_dev->trig);
+       return IRQ_HANDLED;
+}
+
+static int st_accel_buffer_postenable(struct iio_dev *indio_dev)
+{
+       int err, i;
+       u8 active_bit =3D 0x00;
+
+       for (i =3D 0; i < ST_ACCEL_NUMBER_DATA_CHANNELS; i++)
+               if (test_bit(i, indio_dev->active_scan_mask))
+                       active_bit |=3D (1 << i);
+
+       err =3D st_accel_set_axis_enable(indio_dev, active_bit);
+       if (err < 0)
+               goto st_accel_buffer_postenable_error;
+
+       err =3D iio_triggered_buffer_postenable(indio_dev);
+
+st_accel_buffer_postenable_error:
+       return err;
+}
+
+static int st_accel_buffer_predisable(struct iio_dev *indio_dev)
+{
+       int err;
+
+       err =3D iio_triggered_buffer_predisable(indio_dev);
+       if (err < 0)
+               goto st_accel_buffer_predisable_error;
+
+       err =3D st_accel_set_axis_enable(indio_dev, ST_ACCEL_ENABLE_ALL_CHA=
NNELS);
+
+st_accel_buffer_predisable_error:
+       return err;
+}
+
+static const struct iio_buffer_setup_ops st_accel_buffer_setup_ops =3D {
+       .preenable =3D &iio_sw_buffer_preenable,
+       .postenable =3D &st_accel_buffer_postenable,
+       .predisable =3D &st_accel_buffer_predisable,
+};
+
+int st_accel_allocate_ring(struct iio_dev *indio_dev)
+{
+       indio_dev->scan_timestamp =3D true;
+       return iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_ti=
me,
+                       &st_accel_trigger_handler, &st_accel_buffer_setup_o=
ps);
+}
+EXPORT_SYMBOL(st_accel_allocate_ring);
+
+void st_accel_deallocate_ring(struct iio_dev *indio_dev)
+{
+       iio_triggered_buffer_cleanup(indio_dev);
+}
+EXPORT_SYMBOL(st_accel_deallocate_ring);
diff --git a/drivers/iio/accel/st_accel_core.c
b/drivers/iio/accel/st_accel_core.c
new file mode 100644
index 0000000..97ea1b7
--- /dev/null
+++ b/drivers/iio/accel/st_accel_core.c
@@ -0,0 +1,1342 @@
+/*
+ * STMicroelectronics accelerometers driver
+ *
+ * Copyright 2012 STMicroelectronics Inc.
+ *
+ * Denis Ciocca <denis.ciocca@st.com>
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <linux/mutex.h>
+#include <linux/interrupt.h>
+#include <linux/i2c.h>
+#include <linux/gpio.h>
+#include <linux/irq.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/buffer.h>
+
+#include <linux/iio/accel/st_accel.h>
+#include <linux/platform_data/st_accel_pdata.h>
+
+
+#define UG_TO_MS2(x)                           (x*9800)
+#define ST_ACCEL_FULLSCALE_AVL_MAX             5
+#define ST_ACCEL_ODR_LIST_MAX                  10
+#define ST_ACCEL_ON                            1
+#define ST_ACCEL_OFF                           0
+#define ST_ACCEL_ENABLE_ALL_CHANNELS           0x07
+
+/* DEFAULT VALUE FOR SENSORS */
+#define ST_ACCEL_DEFAULT_OUT_X_L_ADDR          0x28
+#define ST_ACCEL_DEFAULT_OUT_X_H_ADDR          0x29
+#define ST_ACCEL_DEFAULT_OUT_Y_L_ADDR          0x2a
+#define ST_ACCEL_DEFAULT_OUT_Y_H_ADDR          0x2b
+#define ST_ACCEL_DEFAULT_OUT_Z_L_ADDR          0x2c
+#define ST_ACCEL_DEFAULT_OUT_Z_H_ADDR          0x2d
+#define ST_ACCEL_DEFAULT_WAI_ADDRESS           0x0f
+#define ST_ACCEL_DEFAULT_POWER_ON_VALUE                0x01
+#define ST_ACCEL_DEFAULT_POWER_OFF_VALUE       0x00
+#define ST_ACCEL_DEFAULT_12_REALBITS           12
+#define ST_ACCEL_DEFAULT_16_REALBITS           16
+#define ST_ACCEL_DEFAULT_AXIS_ADDR             0x20
+#define ST_ACCEL_DEFAULT_AXIS_MASK             0x07
+#define ST_ACCEL_DEFAULT_AXIS_N_BIT            3
+
+/* ODR */
+#define ST_ACCEL_ODR_AVL_1HZ                   1
+#define ST_ACCEL_ODR_AVL_3HZ                   3
+#define ST_ACCEL_ODR_AVL_6HZ                   6
+#define ST_ACCEL_ODR_AVL_10HZ                  10
+#define ST_ACCEL_ODR_AVL_12HZ                  12
+#define ST_ACCEL_ODR_AVL_25HZ                  25
+#define ST_ACCEL_ODR_AVL_50HZ                  50
+#define ST_ACCEL_ODR_AVL_100HZ                 100
+#define ST_ACCEL_ODR_AVL_200HZ                 200
+#define ST_ACCEL_ODR_AVL_400HZ                 400
+#define ST_ACCEL_ODR_AVL_800HZ                 800
+#define ST_ACCEL_ODR_AVL_1000HZ                        1000
+#define ST_ACCEL_ODR_AVL_1600HZ                        1600
+
+/* FULLSCALE */
+#define ST_ACCEL_FS_AVL_2G                     2
+#define ST_ACCEL_FS_AVL_4G                     4
+#define ST_ACCEL_FS_AVL_6G                     6
+#define ST_ACCEL_FS_AVL_8G                     8
+#define ST_ACCEL_FS_AVL_16G                    16
+
+/* CUSTOM VALUES FOR SENSOR 1 */
+#define ST_ACCEL_1_WAI_EXP                     0x33
+#define ST_ACCEL_1_ODR_ADDR                    0x20
+#define ST_ACCEL_1_ODR_MASK                    0xf0
+#define ST_ACCEL_1_ODR_N_BIT                   4
+#define ST_ACCEL_1_ODR_AVL_1HZ_VAL             0x01
+#define ST_ACCEL_1_ODR_AVL_10HZ_VAL            0x02
+#define ST_ACCEL_1_ODR_AVL_25HZ_VAL            0x03
+#define ST_ACCEL_1_ODR_AVL_50HZ_VAL            0x04
+#define ST_ACCEL_1_ODR_AVL_100HZ_VAL           0x05
+#define ST_ACCEL_1_ODR_AVL_200HZ_VAL           0x06
+#define ST_ACCEL_1_ODR_AVL_400HZ_VAL           0x07
+#define ST_ACCEL_1_ODR_AVL_1600HZ_VAL          0x08
+#define ST_ACCEL_1_FS_N_BIT                    2
+#define ST_ACCEL_1_FS_ADDR                     0x23
+#define ST_ACCEL_1_FS_MASK                     0x30
+#define ST_ACCEL_1_FS_AVL_2_VAL                        0x00
+#define ST_ACCEL_1_FS_AVL_4_VAL                        0x01
+#define ST_ACCEL_1_FS_AVL_8_VAL                        0x02
+#define ST_ACCEL_1_FS_AVL_16_VAL               0x03
+#define ST_ACCEL_1_FS_AVL_2_GAIN               1000
+#define ST_ACCEL_1_FS_AVL_4_GAIN               2000
+#define ST_ACCEL_1_FS_AVL_8_GAIN               4000
+#define ST_ACCEL_1_FS_AVL_16_GAIN              12000
+#define ST_ACCEL_1_BDU_ADDR                    0x23
+#define ST_ACCEL_1_BDU_MASK                    0x80
+#define ST_ACCEL_1_DRDY_IRQ_ADDR               0x22
+#define ST_ACCEL_1_DRDY_IRQ_MASK               0x10
+#define ST_ACCEL_1_MULTIREAD_BIT               true
+
+/* CUSTOM VALUES FOR SENSOR 2 */
+#define ST_ACCEL_2_WAI_EXP                     0x49
+#define ST_ACCEL_2_ODR_ADDR                    0x20
+#define ST_ACCEL_2_ODR_MASK                    0xf0
+#define ST_ACCEL_2_ODR_N_BIT                   4
+#define ST_ACCEL_2_ODR_AVL_3HZ_VAL             0x01
+#define ST_ACCEL_2_ODR_AVL_6HZ_VAL             0x02
+#define ST_ACCEL_2_ODR_AVL_12HZ_VAL            0x03
+#define ST_ACCEL_2_ODR_AVL_25HZ_VAL            0x04
+#define ST_ACCEL_2_ODR_AVL_50HZ_VAL            0x05
+#define ST_ACCEL_2_ODR_AVL_100HZ_VAL           0x06
+#define ST_ACCEL_2_ODR_AVL_200HZ_VAL           0x07
+#define ST_ACCEL_2_ODR_AVL_400HZ_VAL           0x08
+#define ST_ACCEL_2_ODR_AVL_800HZ_VAL           0x09
+#define ST_ACCEL_2_ODR_AVL_1600HZ_VAL          0x0a
+#define ST_ACCEL_2_FS_N_BIT                    3
+#define ST_ACCEL_2_FS_ADDR                     0x21
+#define ST_ACCEL_2_FS_MASK                     0x38
+#define ST_ACCEL_2_FS_AVL_2_VAL                        0X00
+#define ST_ACCEL_2_FS_AVL_4_VAL                        0X01
+#define ST_ACCEL_2_FS_AVL_6_VAL                        0x02
+#define ST_ACCEL_2_FS_AVL_8_VAL                        0x03
+#define ST_ACCEL_2_FS_AVL_16_VAL               0x04
+#define ST_ACCEL_2_FS_AVL_2_GAIN               61
+#define ST_ACCEL_2_FS_AVL_4_GAIN               122
+#define ST_ACCEL_2_FS_AVL_6_GAIN               183
+#define ST_ACCEL_2_FS_AVL_8_GAIN               244
+#define ST_ACCEL_2_FS_AVL_16_GAIN              732
+#define ST_ACCEL_2_BDU_ADDR                    0x20
+#define ST_ACCEL_2_BDU_MASK                    0x08
+#define ST_ACCEL_2_DRDY_IRQ_ADDR               0x22
+#define ST_ACCEL_2_DRDY_IRQ_MASK               0x04
+#define ST_ACCEL_2_MULTIREAD_BIT               true
+
+/* CUSTOM VALUES FOR SENSOR 3 */
+#define ST_ACCEL_3_WAI_EXP                     0x32
+#define ST_ACCEL_3_ODR_ADDR                    0x20
+#define ST_ACCEL_3_ODR_MASK                    0x18
+#define ST_ACCEL_3_ODR_N_BIT                   2
+#define ST_ACCEL_3_ODR_AVL_50HZ_VAL            0x00
+#define ST_ACCEL_3_ODR_AVL_100HZ_VAL           0x01
+#define ST_ACCEL_3_ODR_AVL_400HZ_VAL           0x02
+#define ST_ACCEL_3_ODR_AVL_1000HZ_VAL          0x03
+#define ST_ACCEL_3_PW_ADDR                     0x20
+#define ST_ACCEL_3_PW_MASK                     0xe0
+#define ST_ACCEL_3_PW_N_BIT                    3
+#define ST_ACCEL_3_PW_VALUE_ON                 0x01
+#define ST_ACCEL_3_PW_VALUE_OFF                        0x00
+#define ST_ACCEL_3_FS_N_BIT                    2
+#define ST_ACCEL_3_FS_ADDR                     0x23
+#define ST_ACCEL_3_FS_MASK                     0x30
+#define ST_ACCEL_3_FS_AVL_2_VAL                        0X00
+#define ST_ACCEL_3_FS_AVL_4_VAL                        0X01
+#define ST_ACCEL_3_FS_AVL_8_VAL                        0x03
+#define ST_ACCEL_3_FS_AVL_2_GAIN               1000
+#define ST_ACCEL_3_FS_AVL_4_GAIN               2000
+#define ST_ACCEL_3_FS_AVL_8_GAIN               3900
+#define ST_ACCEL_3_BDU_ADDR                    0x23
+#define ST_ACCEL_3_BDU_MASK                    0x80
+#define ST_ACCEL_3_DRDY_IRQ_ADDR               0x22
+#define ST_ACCEL_3_DRDY_IRQ_MASK               0x02
+#define ST_ACCEL_3_MULTIREAD_BIT               true
+
+/* CUSTOM VALUES FOR SENSOR 4 */
+#define ST_ACCEL_4_WAI_EXP                     0x40
+#define ST_ACCEL_4_ODR_ADDR                    0x20
+#define ST_ACCEL_4_ODR_MASK                    0xf0
+#define ST_ACCEL_4_ODR_N_BIT                   4
+#define ST_ACCEL_4_ODR_AVL_3HZ_VAL             0x01
+#define ST_ACCEL_4_ODR_AVL_6HZ_VAL             0x02
+#define ST_ACCEL_4_ODR_AVL_12HZ_VAL            0x03
+#define ST_ACCEL_4_ODR_AVL_25HZ_VAL            0x04
+#define ST_ACCEL_4_ODR_AVL_50HZ_VAL            0x05
+#define ST_ACCEL_4_ODR_AVL_100HZ_VAL           0x06
+#define ST_ACCEL_4_ODR_AVL_200HZ_VAL           0x07
+#define ST_ACCEL_4_ODR_AVL_400HZ_VAL           0x08
+#define ST_ACCEL_4_ODR_AVL_800HZ_VAL           0x09
+#define ST_ACCEL_4_ODR_AVL_1600HZ_VAL          0x0a
+#define ST_ACCEL_4_FS_N_BIT                    3
+#define ST_ACCEL_4_FS_ADDR                     0x24
+#define ST_ACCEL_4_FS_MASK                     0x38
+#define ST_ACCEL_4_FS_AVL_2_VAL                        0X00
+#define ST_ACCEL_4_FS_AVL_4_VAL                        0X01
+#define ST_ACCEL_4_FS_AVL_6_VAL                        0x02
+#define ST_ACCEL_4_FS_AVL_8_VAL                        0x03
+#define ST_ACCEL_4_FS_AVL_16_VAL               0x04
+#define ST_ACCEL_4_FS_AVL_2_GAIN               61
+#define ST_ACCEL_4_FS_AVL_4_GAIN               122
+#define ST_ACCEL_4_FS_AVL_6_GAIN               183
+#define ST_ACCEL_4_FS_AVL_8_GAIN               244
+#define ST_ACCEL_4_FS_AVL_16_GAIN              732
+#define ST_ACCEL_4_BDU_ADDR                    0x20
+#define ST_ACCEL_4_BDU_MASK                    0x08
+#define ST_ACCEL_4_DRDY_IRQ_ADDR               0x23
+#define ST_ACCEL_4_DRDY_IRQ_MASK               0x80
+#define ST_ACCEL_4_IG1_EN_ADDR                 0x23
+#define ST_ACCEL_4_IG1_EN_MASK                 0x08
+#define ST_ACCEL_4_MULTIREAD_BIT               false
+
+struct st_accel_odr_available {
+       unsigned int hz;
+       u8 value;
+};
+
+struct st_accel_odr {
+       u8 addr;
+       u8 mask;
+       short num_bit;
+       struct st_accel_odr_available odr_avl[ST_ACCEL_ODR_LIST_MAX];
+};
+
+struct st_accel_power {
+       u8 addr;
+       u8 mask;
+       unsigned short num_bit;
+       u8 value_off;
+       u8 value_on;
+};
+
+struct st_accel_axis {
+       u8 addr;
+       u8 mask;
+};
+
+struct st_accel_fullscale_available {
+       unsigned int num;
+       u8 value;
+       unsigned int gain;
+};
+
+struct st_accel_fullscale {
+       u8 addr;
+       u8 mask;
+       unsigned short num_bit;
+       struct st_accel_fullscale_available fs_avl[ST_ACCEL_FULLSCALE_AVL_M=
AX];
+};
+
+struct st_accel_bdu {
+       u8 addr;
+       u8 mask;
+};
+
+struct st_accel_interrupt_generator {
+       u8 en_addr;
+       u8 latch_mask_addr;
+       u8 en_mask;
+       u8 latching_mask;
+};
+
+struct st_accel_data_ready_irq {
+       u8 addr;
+       u8 mask;
+       struct st_accel_interrupt_generator ig1;
+};
+
+#define ST_ACCEL_LSM_CHANNELS(index, mod, endian, bits, addr) \
+{ \
+       .type =3D IIO_ACCEL, \
+       .modified =3D 1, \
+       .info_mask =3D IIO_CHAN_INFO_RAW_SEPARATE_BIT | \
+                                       IIO_CHAN_INFO_SCALE_SEPARATE_BIT, \
+       .scan_index =3D index, \
+       .channel2 =3D mod, \
+       .address =3D addr, \
+       .scan_type =3D { \
+               .sign =3D 's', \
+               .realbits =3D bits, \
+               .shift =3D 16 - bits, \
+               .storagebits =3D 16, \
+               .endianness =3D endian, \
+       }, \
+}
+
+static const struct iio_chan_spec st_accel_12bit_channels[] =3D {
+       ST_ACCEL_LSM_CHANNELS(ST_ACCEL_SCAN_X, IIO_MOD_X, IIO_LE,
+               ST_ACCEL_DEFAULT_12_REALBITS, ST_ACCEL_DEFAULT_OUT_X_L_ADDR=
),
+       ST_ACCEL_LSM_CHANNELS(ST_ACCEL_SCAN_Y, IIO_MOD_Y, IIO_LE,
+               ST_ACCEL_DEFAULT_12_REALBITS, ST_ACCEL_DEFAULT_OUT_Y_L_ADDR=
),
+       ST_ACCEL_LSM_CHANNELS(ST_ACCEL_SCAN_Z, IIO_MOD_Z, IIO_LE,
+               ST_ACCEL_DEFAULT_12_REALBITS, ST_ACCEL_DEFAULT_OUT_Z_L_ADDR=
),
+       IIO_CHAN_SOFT_TIMESTAMP(3)
+};
+
+static const struct iio_chan_spec st_accel_16bit_channels[] =3D {
+       ST_ACCEL_LSM_CHANNELS(ST_ACCEL_SCAN_X, IIO_MOD_X, IIO_LE,
+               ST_ACCEL_DEFAULT_16_REALBITS, ST_ACCEL_DEFAULT_OUT_X_L_ADDR=
),
+       ST_ACCEL_LSM_CHANNELS(ST_ACCEL_SCAN_Y, IIO_MOD_Y, IIO_LE,
+               ST_ACCEL_DEFAULT_16_REALBITS, ST_ACCEL_DEFAULT_OUT_Y_L_ADDR=
),
+       ST_ACCEL_LSM_CHANNELS(ST_ACCEL_SCAN_Z, IIO_MOD_Z, IIO_LE,
+               ST_ACCEL_DEFAULT_16_REALBITS, ST_ACCEL_DEFAULT_OUT_Z_L_ADDR=
),
+       IIO_CHAN_SOFT_TIMESTAMP(3)
+};
+
+static const struct st_accel_platform_data st_accel_default_pdata =3D {
+       .fullscale =3D ST_ACCEL_FS_AVL_2G,
+       .sampling_frequency =3D ST_ACCEL_ODR_AVL_100HZ,
+};
+
+/**
+ * struct st_accel_sensors - ST accel sensors list
+ * @wai: Contents of WhoAmI register.
+ * @ch: IIO channels for the sensor.
+ * @odr: Output data rate register and odr list available.
+ * @pw: Power register of the sensor.
+ * @fs: Full scale register and fs list available.
+ * @bdu: Block data update register.
+ * @drdy_irq: Data ready register of the sensor.
+ * @ multi_read_bit: Use or not particular bit for [I2C/SPI] multiread.
+ *
+ */
+
+static const struct st_accel_sensors {
+       u8 wai;
+       struct iio_chan_spec *ch;
+       struct st_accel_odr odr;
+       struct st_accel_power pw;
+       struct st_accel_axis enable_axis;
+       struct st_accel_fullscale fs;
+       struct st_accel_bdu bdu;
+       struct st_accel_data_ready_irq drdy_irq;
+       bool multi_read_bit;
+} st_accel_sensors[] =3D {
+       {
+               .wai =3D ST_ACCEL_1_WAI_EXP,
+               .ch =3D (struct iio_chan_spec *)st_accel_12bit_channels,
+               .odr =3D {
+                       .addr =3D ST_ACCEL_1_ODR_ADDR,
+                       .mask =3D ST_ACCEL_1_ODR_MASK,
+                       .num_bit =3D ST_ACCEL_1_ODR_N_BIT,
+                       .odr_avl =3D {
+                               [0] =3D {
+                                       .hz =3D ST_ACCEL_ODR_AVL_1HZ,
+                                       .value =3D ST_ACCEL_1_ODR_AVL_1HZ_V=
AL,
+                               },
+                               [1] =3D {
+                                       .hz =3D ST_ACCEL_ODR_AVL_10HZ,
+                                       .value =3D ST_ACCEL_1_ODR_AVL_10HZ_=
VAL,
+                               },
+                               [2] =3D {
+                                       .hz =3D ST_ACCEL_ODR_AVL_25HZ,
+                                       .value =3D ST_ACCEL_1_ODR_AVL_25HZ_=
VAL,
+                               },
+                               [3] =3D {
+                                       .hz =3D ST_ACCEL_ODR_AVL_50HZ,
+                                       .value =3D ST_ACCEL_1_ODR_AVL_50HZ_=
VAL,
+                               },
+                               [4] =3D {
+                                       .hz =3D ST_ACCEL_ODR_AVL_100HZ,
+                                       .value =3D ST_ACCEL_1_ODR_AVL_100HZ=
_VAL,
+                               },
+                               [5] =3D {
+                                       .hz =3D ST_ACCEL_ODR_AVL_200HZ,
+                                       .value =3D ST_ACCEL_1_ODR_AVL_200HZ=
_VAL,
+                               },
+                               [6] =3D {
+                                       .hz =3D ST_ACCEL_ODR_AVL_400HZ,
+                                       .value =3D ST_ACCEL_1_ODR_AVL_400HZ=
_VAL,
+                               },
+                               [7] =3D {
+                                       .hz =3D ST_ACCEL_ODR_AVL_1600HZ,
+                                       .value =3D ST_ACCEL_1_ODR_AVL_1600H=
Z_VAL,
+                               },
+                       },
+               },
+               .pw =3D {
+                       .addr =3D ST_ACCEL_1_ODR_ADDR,
+                       .mask =3D ST_ACCEL_1_ODR_MASK,
+                       .num_bit =3D ST_ACCEL_1_ODR_N_BIT,
+                       .value_off =3D ST_ACCEL_DEFAULT_POWER_OFF_VALUE,
+               },
+               .enable_axis =3D {
+                       .addr =3D ST_ACCEL_DEFAULT_AXIS_ADDR,
+                       .mask =3D ST_ACCEL_DEFAULT_AXIS_MASK,
+               },
+               .fs =3D {
+                       .addr =3D ST_ACCEL_1_FS_ADDR,
+                       .mask =3D ST_ACCEL_1_FS_MASK,
+                       .num_bit =3D ST_ACCEL_1_FS_N_BIT,
+                       .fs_avl =3D {
+                               [0] =3D {
+                                       .num =3D ST_ACCEL_FS_AVL_2G,
+                                       .value =3D ST_ACCEL_1_FS_AVL_2_VAL,
+                                       .gain =3D ST_ACCEL_1_FS_AVL_2_GAIN,
+                               },
+                               [1] =3D {
+                                       .num =3D ST_ACCEL_FS_AVL_4G,
+                                       .value =3D ST_ACCEL_1_FS_AVL_4_VAL,
+                                       .gain =3D ST_ACCEL_1_FS_AVL_4_GAIN,
+                               },
+                               [2] =3D {
+                                       .num =3D ST_ACCEL_FS_AVL_8G,
+                                       .value =3D ST_ACCEL_1_FS_AVL_8_VAL,
+                                       .gain =3D ST_ACCEL_1_FS_AVL_8_GAIN,
+                               },
+                               [3] =3D {
+                                       .num =3D ST_ACCEL_FS_AVL_16G,
+                                       .value =3D ST_ACCEL_1_FS_AVL_16_VAL=
,
+                                       .gain =3D ST_ACCEL_1_FS_AVL_16_GAIN=
,
+                               },
+                       },
+               },
+               .bdu =3D {
+                       .addr =3D ST_ACCEL_1_BDU_ADDR,
+                       .mask =3D ST_ACCEL_1_BDU_MASK,
+               },
+               .drdy_irq =3D {
+                       .addr =3D ST_ACCEL_1_DRDY_IRQ_ADDR,
+                       .mask =3D ST_ACCEL_1_DRDY_IRQ_MASK,
+               },
+               .multi_read_bit =3D ST_ACCEL_1_MULTIREAD_BIT,
+               },
+               {
+               .wai =3D ST_ACCEL_2_WAI_EXP,
+               .ch =3D (struct iio_chan_spec *)st_accel_16bit_channels,
+               .odr =3D {
+                       .addr =3D ST_ACCEL_2_ODR_ADDR,
+                       .mask =3D ST_ACCEL_2_ODR_MASK,
+                       .num_bit =3D ST_ACCEL_2_ODR_N_BIT,
+                       .odr_avl =3D {
+                               [0] =3D {
+                                       .hz =3D ST_ACCEL_ODR_AVL_3HZ,
+                                       .value =3D ST_ACCEL_2_ODR_AVL_3HZ_V=
AL,
+                               },
+                               [1] =3D {
+                                       .hz =3D ST_ACCEL_ODR_AVL_6HZ,
+                                       .value =3D ST_ACCEL_2_ODR_AVL_6HZ_V=
AL,
+                               },
+                               [2] =3D {
+                                       .hz =3D ST_ACCEL_ODR_AVL_12HZ,
+                                       .value =3D ST_ACCEL_2_ODR_AVL_12HZ_=
VAL,
+                               },
+                               [3] =3D {
+                                       .hz =3D ST_ACCEL_ODR_AVL_25HZ,
+                                       .value =3D ST_ACCEL_2_ODR_AVL_25HZ_=
VAL,
+                               },
+                               [4] =3D {
+                                       .hz =3D ST_ACCEL_ODR_AVL_50HZ,
+                                       .value =3D ST_ACCEL_2_ODR_AVL_50HZ_=
VAL,
+                               },
+                               [5] =3D {
+                                       .hz =3D ST_ACCEL_ODR_AVL_100HZ,
+                                       .value =3D ST_ACCEL_2_ODR_AVL_100HZ=
_VAL,
+                               },
+                               [6] =3D {
+                                       .hz =3D ST_ACCEL_ODR_AVL_200HZ,
+                                       .value =3D ST_ACCEL_2_ODR_AVL_200HZ=
_VAL,
+                               },
+                               [7] =3D {
+                                       .hz =3D ST_ACCEL_ODR_AVL_400HZ,
+                                       .value =3D ST_ACCEL_2_ODR_AVL_400HZ=
_VAL,
+                               },
+                               [8] =3D {
+                                       .hz =3D ST_ACCEL_ODR_AVL_800HZ,
+                                       .value =3D ST_ACCEL_2_ODR_AVL_800HZ=
_VAL,
+                               },
+                               [9] =3D {
+                                       .hz =3D ST_ACCEL_ODR_AVL_1600HZ,
+                                       .value =3D ST_ACCEL_2_ODR_AVL_1600H=
Z_VAL,
+                               },
+                       },
+               },
+               .pw =3D {
+                       .addr =3D ST_ACCEL_2_ODR_ADDR,
+                       .mask =3D ST_ACCEL_2_ODR_MASK,
+                       .num_bit =3D ST_ACCEL_2_ODR_N_BIT,
+                       .value_off =3D ST_ACCEL_DEFAULT_POWER_OFF_VALUE,
+               },
+               .enable_axis =3D {
+                       .addr =3D ST_ACCEL_DEFAULT_AXIS_ADDR,
+                       .mask =3D ST_ACCEL_DEFAULT_AXIS_MASK,
+               },
+               .fs =3D {
+                       .addr =3D ST_ACCEL_2_FS_ADDR,
+                       .mask =3D ST_ACCEL_2_FS_MASK,
+                       .num_bit =3D ST_ACCEL_2_FS_N_BIT,
+                       .fs_avl =3D {
+                               [0] =3D {
+                                       .num =3D ST_ACCEL_FS_AVL_2G,
+                                       .value =3D ST_ACCEL_2_FS_AVL_2_VAL,
+                                       .gain =3D ST_ACCEL_2_FS_AVL_2_GAIN,
+                               },
+                               [1] =3D {
+                                       .num =3D ST_ACCEL_FS_AVL_4G,
+                                       .value =3D ST_ACCEL_2_FS_AVL_4_VAL,
+                                       .gain =3D ST_ACCEL_2_FS_AVL_4_GAIN,
+                               },
+                               [2] =3D {
+                                       .num =3D ST_ACCEL_FS_AVL_6G,
+                                       .value =3D ST_ACCEL_2_FS_AVL_6_VAL,
+                                       .gain =3D ST_ACCEL_2_FS_AVL_6_GAIN,
+                               },
+                               [3] =3D {
+                                       .num =3D ST_ACCEL_FS_AVL_8G,
+                                       .value =3D ST_ACCEL_2_FS_AVL_8_VAL,
+                                       .gain =3D ST_ACCEL_2_FS_AVL_8_GAIN,
+                               },
+                               [4] =3D {
+                                       .num =3D ST_ACCEL_FS_AVL_16G,
+                                       .value =3D ST_ACCEL_2_FS_AVL_16_VAL=
,
+                                       .gain =3D ST_ACCEL_2_FS_AVL_16_GAIN=
,
+                               },
+                       },
+               },
+               .drdy_irq =3D {
+                       .addr =3D ST_ACCEL_2_DRDY_IRQ_ADDR,
+                       .mask =3D ST_ACCEL_2_DRDY_IRQ_MASK,
+               },
+               .bdu =3D {
+                       .addr =3D ST_ACCEL_2_BDU_ADDR,
+                       .mask =3D ST_ACCEL_2_BDU_MASK,
+               },
+               .multi_read_bit =3D ST_ACCEL_2_MULTIREAD_BIT,
+               },
+               {
+               .wai =3D ST_ACCEL_3_WAI_EXP,
+               .ch =3D (struct iio_chan_spec *)st_accel_12bit_channels,
+               .odr =3D {
+                       .addr =3D ST_ACCEL_3_ODR_ADDR,
+                       .mask =3D ST_ACCEL_3_ODR_MASK,
+                       .num_bit =3D ST_ACCEL_3_ODR_N_BIT,
+                       .odr_avl =3D {
+                               [0] =3D {
+                                       .hz =3D ST_ACCEL_ODR_AVL_50HZ,
+                                       .value =3D ST_ACCEL_3_ODR_AVL_50HZ_=
VAL,
+                               },
+                               [1] =3D {
+                                       .hz =3D ST_ACCEL_ODR_AVL_100HZ,
+                                       .value =3D ST_ACCEL_3_ODR_AVL_100HZ=
_VAL,
+                               },
+                               [2] =3D {
+                                       .hz =3D ST_ACCEL_ODR_AVL_400HZ,
+                                       .value =3D ST_ACCEL_3_ODR_AVL_400HZ=
_VAL,
+                               },
+                               [3] =3D {
+                                       .hz =3D ST_ACCEL_ODR_AVL_1000HZ,
+                                       .value =3D ST_ACCEL_3_ODR_AVL_1000H=
Z_VAL,
+                               },
+                       },
+               },
+               .pw =3D {
+                       .addr =3D ST_ACCEL_3_PW_ADDR,
+                       .mask =3D ST_ACCEL_3_PW_MASK,
+                       .num_bit =3D ST_ACCEL_3_PW_N_BIT,
+                       .value_on =3D ST_ACCEL_3_PW_VALUE_ON,
+                       .value_off =3D ST_ACCEL_3_PW_VALUE_OFF,
+               },
+               .enable_axis =3D {
+                       .addr =3D ST_ACCEL_DEFAULT_AXIS_ADDR,
+                       .mask =3D ST_ACCEL_DEFAULT_AXIS_MASK,
+               },
+               .fs =3D {
+                       .addr =3D ST_ACCEL_3_FS_ADDR,
+                       .mask =3D ST_ACCEL_3_FS_MASK,
+                       .num_bit =3D ST_ACCEL_3_FS_N_BIT,
+                       .fs_avl =3D {
+                               [0] =3D {
+                                       .num =3D ST_ACCEL_FS_AVL_2G,
+                                       .value =3D ST_ACCEL_3_FS_AVL_2_VAL,
+                                       .gain =3D ST_ACCEL_3_FS_AVL_2_GAIN,
+                               },
+                               [1] =3D {
+                                       .num =3D ST_ACCEL_FS_AVL_4G,
+                                       .value =3D ST_ACCEL_3_FS_AVL_4_VAL,
+                                       .gain =3D ST_ACCEL_3_FS_AVL_4_GAIN,
+                               },
+                               [2] =3D {
+                                       .num =3D ST_ACCEL_FS_AVL_8G,
+                                       .value =3D ST_ACCEL_3_FS_AVL_8_VAL,
+                                       .gain =3D ST_ACCEL_3_FS_AVL_8_GAIN,
+                               },
+                       },
+               },
+               .bdu =3D {
+                       .addr =3D ST_ACCEL_3_BDU_ADDR,
+                       .mask =3D ST_ACCEL_3_BDU_MASK,
+               },
+               .drdy_irq =3D {
+                       .addr =3D ST_ACCEL_3_DRDY_IRQ_ADDR,
+                       .mask =3D ST_ACCEL_3_DRDY_IRQ_MASK,
+               },
+               .multi_read_bit =3D ST_ACCEL_3_MULTIREAD_BIT,
+               },
+               {
+               .wai =3D ST_ACCEL_4_WAI_EXP,
+               .ch =3D (struct iio_chan_spec *)st_accel_16bit_channels,
+               .odr =3D {
+                       .addr =3D ST_ACCEL_4_ODR_ADDR,
+                       .mask =3D ST_ACCEL_4_ODR_MASK,
+                       .num_bit =3D ST_ACCEL_4_ODR_N_BIT,
+                       .odr_avl =3D {
+                               [0] =3D {
+                                       .hz =3D ST_ACCEL_ODR_AVL_3HZ,
+                                       .value =3D ST_ACCEL_4_ODR_AVL_3HZ_V=
AL,
+                               },
+                               [1] =3D {
+                                       .hz =3D ST_ACCEL_ODR_AVL_6HZ,
+                                       .value =3D ST_ACCEL_4_ODR_AVL_6HZ_V=
AL,
+                               },
+                               [2] =3D {
+                                       .hz =3D ST_ACCEL_ODR_AVL_12HZ,
+                                       .value =3D ST_ACCEL_4_ODR_AVL_12HZ_=
VAL,
+                               },
+                               [3] =3D {
+                                       .hz =3D ST_ACCEL_ODR_AVL_25HZ,
+                                       .value =3D ST_ACCEL_4_ODR_AVL_25HZ_=
VAL,
+                               },
+                               [4] =3D {
+                                       .hz =3D ST_ACCEL_ODR_AVL_50HZ,
+                                       .value =3D ST_ACCEL_4_ODR_AVL_50HZ_=
VAL,
+                               },
+                               [5] =3D {
+                                       .hz =3D ST_ACCEL_ODR_AVL_100HZ,
+                                       .value =3D ST_ACCEL_4_ODR_AVL_100HZ=
_VAL,
+                               },
+                               [6] =3D {
+                                       .hz =3D ST_ACCEL_ODR_AVL_200HZ,
+                                       .value =3D ST_ACCEL_4_ODR_AVL_200HZ=
_VAL,
+                               },
+                               [7] =3D {
+                                       .hz =3D ST_ACCEL_ODR_AVL_400HZ,
+                                       .value =3D ST_ACCEL_4_ODR_AVL_400HZ=
_VAL,
+                               },
+                               [8] =3D {
+                                       .hz =3D ST_ACCEL_ODR_AVL_800HZ,
+                                       .value =3D ST_ACCEL_4_ODR_AVL_800HZ=
_VAL,
+                               },
+                               [9] =3D {
+                                       .hz =3D ST_ACCEL_ODR_AVL_1600HZ,
+                                       .value =3D ST_ACCEL_4_ODR_AVL_1600H=
Z_VAL,
+                               },
+                       },
+               },
+               .pw =3D {
+                       .addr =3D ST_ACCEL_4_ODR_ADDR,
+                       .mask =3D ST_ACCEL_4_ODR_MASK,
+                       .num_bit =3D ST_ACCEL_4_ODR_N_BIT,
+                       .value_off =3D ST_ACCEL_DEFAULT_POWER_OFF_VALUE,
+               },
+               .enable_axis =3D {
+                       .addr =3D ST_ACCEL_DEFAULT_AXIS_ADDR,
+                       .mask =3D ST_ACCEL_DEFAULT_AXIS_MASK,
+               },
+               .fs =3D {
+                       .addr =3D ST_ACCEL_4_FS_ADDR,
+                       .mask =3D ST_ACCEL_4_FS_MASK,
+                       .num_bit =3D ST_ACCEL_4_FS_N_BIT,
+                       .fs_avl =3D {
+                               [0] =3D {
+                                       .num =3D ST_ACCEL_FS_AVL_2G,
+                                       .value =3D ST_ACCEL_4_FS_AVL_2_VAL,
+                                       .gain =3D ST_ACCEL_4_FS_AVL_2_GAIN,
+                               },
+                               [1] =3D {
+                                       .num =3D ST_ACCEL_FS_AVL_4G,
+                                       .value =3D ST_ACCEL_4_FS_AVL_4_VAL,
+                                       .gain =3D ST_ACCEL_4_FS_AVL_4_GAIN,
+                               },
+                               [2] =3D {
+                                       .num =3D ST_ACCEL_FS_AVL_6G,
+                                       .value =3D ST_ACCEL_4_FS_AVL_6_VAL,
+                                       .gain =3D ST_ACCEL_4_FS_AVL_6_GAIN,
+                               },
+                               [3] =3D {
+                                       .num =3D ST_ACCEL_FS_AVL_8G,
+                                       .value =3D ST_ACCEL_4_FS_AVL_8_VAL,
+                                       .gain =3D ST_ACCEL_4_FS_AVL_8_GAIN,
+                               },
+                               [4] =3D {
+                                       .num =3D ST_ACCEL_FS_AVL_16G,
+                                       .value =3D ST_ACCEL_4_FS_AVL_16_VAL=
,
+                                       .gain =3D ST_ACCEL_4_FS_AVL_16_GAIN=
,
+                               },
+                       },
+               },
+               .bdu =3D {
+                       .addr =3D ST_ACCEL_4_BDU_ADDR,
+                       .mask =3D ST_ACCEL_4_BDU_MASK,
+               },
+               .drdy_irq =3D {
+                       .addr =3D ST_ACCEL_4_DRDY_IRQ_ADDR,
+                       .mask =3D ST_ACCEL_4_DRDY_IRQ_MASK,
+                       .ig1 =3D {
+                               .en_addr =3D ST_ACCEL_4_IG1_EN_ADDR,
+                               .en_mask =3D ST_ACCEL_4_IG1_EN_MASK,
+                       },
+               },
+               .multi_read_bit =3D ST_ACCEL_4_MULTIREAD_BIT,
+               },
+};
+
+static int st_accel_write_data_with_mask(struct iio_dev *indio_dev, u8
reg_addr,
+                                               u8 mask, short num_bit, u8 =
data)
+{
+       int err, j, pos;
+       u8 prev_data;
+       u8 new_data;
+       struct st_accel_data *adata =3D iio_priv(indio_dev);
+
+       pos =3D 8 - num_bit;
+       for (j =3D 128; j >=3D 0; j =3D j/2) {
+               if (mask / j > 0)
+                       break;
+               else
+                       pos--;
+       }
+
+       err =3D adata->read_byte(adata, reg_addr, &prev_data);
+       if (err < 0)
+               goto st_accel_write_data_with_mask_error;
+
+       new_data =3D ((prev_data & (~mask)) | ((data << pos) & mask));
+       err =3D adata->write_byte(adata, reg_addr, new_data);
+
+st_accel_write_data_with_mask_error:
+       return err;
+}
+
+static int st_accel_match_odr(const struct st_accel_sensors *sensor,
+               unsigned int odr, struct st_accel_odr_available *odr_out)
+{
+       int i, ret =3D -1;
+
+       for (i =3D 0; i < ARRAY_SIZE(sensor->odr.odr_avl); i++) {
+               if (sensor->odr.odr_avl[i].hz =3D=3D odr) {
+                       odr_out->hz =3D sensor->odr.odr_avl[i].hz;
+                       odr_out->value =3D sensor->odr.odr_avl[i].value;
+                       ret =3D 0;
+                       break;
+               }
+       }
+
+       return ret;
+}
+
+static int st_accel_match_fs(const struct st_accel_sensors *sensor,
+               unsigned int fs, struct st_accel_fullscale_available *fs_ou=
t)
+{
+       int i, ret =3D -1;
+
+       for (i =3D 0; i < ARRAY_SIZE(sensor->fs.fs_avl); i++) {
+               if (sensor->fs.fs_avl[i].num =3D=3D fs) {
+                       fs_out->num =3D sensor->fs.fs_avl[i].num;
+                       fs_out->gain =3D sensor->fs.fs_avl[i].gain;
+                       fs_out->value =3D sensor->fs.fs_avl[i].value;
+                       ret =3D 0;
+                       break;
+               }
+       }
+
+       return ret;
+}
+
+int st_accel_set_dataready_irq(struct iio_dev *indio_dev, bool enable)
+{
+       int err;
+       struct st_accel_data *adata;
+
+       adata =3D iio_priv(indio_dev);
+       if (st_accel_sensors[adata->index].drdy_irq.ig1.en_addr > 0) {
+               err =3D st_accel_write_data_with_mask(indio_dev,
+                       st_accel_sensors[adata->index].drdy_irq.ig1.en_addr=
,
+                       st_accel_sensors[adata->index].drdy_irq.ig1.en_mask=
, 1,
+                       (int)enable);
+               if (err < 0)
+                       goto st_accel_set_dataready_irq_error;
+       }
+
+       if (st_accel_sensors[adata->index].drdy_irq.ig1.latch_mask_addr > 0=
) {
+               err =3D st_accel_write_data_with_mask(indio_dev,
+               st_accel_sensors[adata->index].drdy_irq.ig1.latch_mask_addr=
,
+               st_accel_sensors[adata->index].drdy_irq.ig1.latching_mask, =
1,
+                       (int)enable);
+               if (err < 0)
+                       goto st_accel_set_dataready_irq_error;
+       }
+
+       err =3D st_accel_write_data_with_mask(indio_dev,
+               st_accel_sensors[adata->index].drdy_irq.addr,
+               st_accel_sensors[adata->index].drdy_irq.mask, 1, (int)enabl=
e);
+       if (err < 0)
+               goto st_accel_set_dataready_irq_error;
+
+st_accel_set_dataready_irq_error:
+       return err;
+}
+EXPORT_SYMBOL(st_accel_set_dataready_irq);
+
+static int st_accel_set_bdu(struct iio_dev *indio_dev,
+                               const struct st_accel_bdu *bdu, u8 value)
+{
+       return st_accel_write_data_with_mask(indio_dev, bdu->addr, bdu->mas=
k,
+                                                               1, value);
+}
+
+static int st_accel_set_odr(struct iio_dev *indio_dev,
+                               struct st_accel_odr_available *odr_availabl=
e)
+{
+       int err;
+       struct st_accel_data *adata =3D iio_priv(indio_dev);
+
+       if ((st_accel_sensors[adata->index].odr.addr =3D=3D
+               st_accel_sensors[adata->index].pw.addr) &&
+                       (st_accel_sensors[adata->index].odr.mask =3D=3D
+                               st_accel_sensors[adata->index].pw.mask)) {
+               if (adata->enabled =3D=3D (bool)ST_ACCEL_ON) {
+                       err =3D st_accel_write_data_with_mask(indio_dev,
+                               st_accel_sensors[adata->index].odr.addr,
+                               st_accel_sensors[adata->index].odr.mask,
+                               st_accel_sensors[adata->index].odr.num_bit,
+                               odr_available->value);
+                       if (err < 0)
+                               goto sc_accel_set_odr_error;
+               } else {
+                       adata->odr =3D odr_available->hz;
+                       err =3D 0;
+               }
+       } else {
+               err =3D st_accel_write_data_with_mask(indio_dev,
+                               st_accel_sensors[adata->index].odr.addr,
+                               st_accel_sensors[adata->index].odr.mask,
+                               st_accel_sensors[adata->index].odr.num_bit,
+                               odr_available->value);
+               if (err < 0)
+                       goto sc_accel_set_odr_error;
+       }
+
+sc_accel_set_odr_error:
+       return err;
+}
+
+int st_accel_set_axis_enable(struct iio_dev *indio_dev, u8 axis_enable)
+{
+       int err;
+       struct st_accel_data *adata =3D iio_priv(indio_dev);
+
+       err =3D st_accel_write_data_with_mask(indio_dev,
+                       st_accel_sensors[adata->index].enable_axis.addr,
+                       st_accel_sensors[adata->index].enable_axis.mask,
+                       ST_ACCEL_DEFAULT_AXIS_N_BIT, axis_enable);
+
+       return err;
+}
+
+static int st_accel_set_enable(struct iio_dev *indio_dev, int enable)
+{
+       int err;
+       bool found;
+       u8 tmp_value;
+       struct st_accel_odr_available odr_out;
+       struct st_accel_data *adata =3D iio_priv(indio_dev);
+
+       switch (enable) {
+       case ST_ACCEL_ON:
+               found =3D false;
+               tmp_value =3D st_accel_sensors[adata->index].pw.value_on;
+               if ((st_accel_sensors[adata->index].odr.addr =3D=3D
+                               st_accel_sensors[adata->index].pw.addr) &&
+                       (st_accel_sensors[adata->index].odr.mask =3D=3D
+                               st_accel_sensors[adata->index].pw.mask)) {
+                       err =3D st_accel_match_odr(
+                               &st_accel_sensors[adata->index], adata->odr=
,
+                                       &odr_out);
+                       if (err < 0)
+                               goto set_enable_error;
+                       tmp_value =3D odr_out.value;
+                       found =3D true;
+               }
+               err =3D st_accel_write_data_with_mask(indio_dev,
+                               st_accel_sensors[adata->index].pw.addr,
+                               st_accel_sensors[adata->index].pw.mask,
+                               st_accel_sensors[adata->index].pw.num_bit,
+                               tmp_value);
+               if (err < 0)
+                       goto set_enable_error;
+               adata->enabled =3D (bool)ST_ACCEL_ON;
+               if (found)
+                       adata->odr =3D odr_out.hz;
+               break;
+       case ST_ACCEL_OFF:
+               err =3D st_accel_write_data_with_mask(indio_dev,
+                               st_accel_sensors[adata->index].pw.addr,
+                               st_accel_sensors[adata->index].pw.mask,
+                               st_accel_sensors[adata->index].pw.num_bit,
+                               st_accel_sensors[adata->index].pw.value_off=
);
+               if (err < 0)
+                       goto set_enable_error;
+               adata->enabled =3D (bool)ST_ACCEL_OFF;
+               break;
+       default:
+               err =3D -EINVAL;
+               goto set_enable_error;
+       }
+
+set_enable_error:
+       return err;
+}
+
+static int st_accel_set_fullscale(struct iio_dev *indio_dev,
+                               struct st_accel_fullscale_available *fs_avl=
)
+{
+       int err;
+       struct st_accel_data *adata =3D iio_priv(indio_dev);
+
+       err =3D st_accel_write_data_with_mask(indio_dev,
+                               st_accel_sensors[adata->index].fs.addr,
+                               st_accel_sensors[adata->index].fs.mask,
+                               st_accel_sensors[adata->index].fs.num_bit,
+                               fs_avl->value);
+       if (err < 0)
+               goto st_accel_set_fullscale_error;
+
+       adata->fullscale =3D fs_avl->num;
+       adata->gain =3D fs_avl->gain;
+       return err;
+
+st_accel_set_fullscale_error:
+       dev_err(&indio_dev->dev, "failed to set new fullscale.\n");
+       return err;
+}
+
+static int st_accel_read_raw(struct iio_dev *indio_dev,
+                       struct iio_chan_spec const *ch, int *val,
+                                                       int *val2, long mas=
k)
+{
+       int err;
+       u8 outdata[ST_ACCEL_BYTE_FOR_CHANNEL];
+       struct st_accel_data *adata =3D iio_priv(indio_dev);
+
+       switch (mask) {
+       case IIO_CHAN_INFO_RAW:
+               mutex_lock(&indio_dev->mlock);
+               if (indio_dev->currentmode =3D=3D INDIO_BUFFER_TRIGGERED) {
+                       err =3D -EBUSY;
+                       goto read_error;
+               } else {
+                       if (!adata->enabled) {
+                               err =3D -EIO;
+                               goto read_error;
+                       } else {
+                               err =3D adata->read_multiple_byte(adata,
+                                       ch->address, ST_ACCEL_BYTE_FOR_CHAN=
NEL,
+                                       outdata);
+                               if (err < 0)
+                                       goto read_error;
+
+                               *val =3D ((s16)(((s16)(outdata[1]) << 8)
+                                       | outdata[0])) >> ch->scan_type.shi=
ft;
+                       }
+               }
+               mutex_unlock(&indio_dev->mlock);
+               return IIO_VAL_INT;
+       case IIO_CHAN_INFO_SCALE:
+               *val =3D 0;
+               *val2 =3D UG_TO_MS2(adata->gain);
+               return IIO_VAL_INT_PLUS_NANO;
+       default:
+               return -EINVAL;
+       }
+
+read_error:
+       mutex_unlock(&indio_dev->mlock);
+       return err;
+}
+
+static int st_accel_check_device_list(struct iio_dev *indio_dev, u8 wai)
+{
+       int i;
+       bool found;
+       struct st_accel_data *adata =3D iio_priv(indio_dev);
+
+       found =3D false;
+       for (i =3D 0; i < ARRAY_SIZE(st_accel_sensors); i++) {
+               if (st_accel_sensors[i].wai =3D=3D wai) {
+                       found =3D true;
+                       break;
+               }
+       }
+       if (!found)
+               goto check_device_error;
+
+       adata->index =3D i;
+
+       return i;
+
+check_device_error:
+       dev_err(&indio_dev->dev, "device not supported -> wai (0x%x).\n", w=
ai);
+       return -ENODEV;
+}
+
+static int st_accel_get_wai_device(struct iio_dev *indio_dev, u8 reg_addr,
+                                                               u8 *value)
+{
+       int ret;
+       struct st_accel_data *adata =3D iio_priv(indio_dev);
+
+       ret =3D adata->read_byte(adata, reg_addr, value);
+       if (ret < 0)
+               goto read_byte_wai_error;
+
+       return 0;
+
+read_byte_wai_error:
+       dev_err(&indio_dev->dev,
+                       "failed to read WhoAmI (register 0x%x).\n", reg_add=
r);
+       return -EIO;
+}
+
+static ssize_t st_accel_sysfs_set_sampling_frequency(struct device *dev,
+               struct device_attribute *attr, const char *buf, size_t size=
)
+{
+       int err;
+       unsigned int freq;
+       struct st_accel_odr_available odr_out;
+       struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+       struct st_accel_data *adata =3D iio_priv(indio_dev);
+
+       err =3D kstrtoint(buf, 10, &freq);
+       if (err < 0)
+               goto conversion_error;
+
+       mutex_lock(&indio_dev->mlock);
+       err =3D st_accel_match_odr(&st_accel_sensors[adata->index],
+                                                               freq, &odr_=
out);
+       if (err < 0)
+               goto st_accel_sysfs_set_sampling_frequency_error;
+
+       err =3D st_accel_set_odr(indio_dev, &odr_out);
+       if (err < 0) {
+               dev_err(&indio_dev->dev,
+                       "failed to set sampling frequency to %d.\n", freq);
+               goto st_accel_sysfs_set_sampling_frequency_error;
+       }
+       adata->odr =3D odr_out.hz;
+
+st_accel_sysfs_set_sampling_frequency_error:
+       mutex_unlock(&indio_dev->mlock);
+conversion_error:
+       return size;
+}
+
+static ssize_t st_accel_sysfs_get_sampling_frequency(struct device *dev,
+                               struct device_attribute *attr, char *buf)
+{
+       struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+       struct st_accel_data *adata =3D iio_priv(indio_dev);
+
+       return sprintf(buf, "%d\n", adata->odr);
+}
+
+static ssize_t st_accel_sysfs_set_enable(struct device *dev,
+               struct device_attribute *attr, const char *buf, size_t size=
)
+{
+       int err;
+       bool en;
+       struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+
+       err =3D strtobool(buf, &en);
+       if (err < 0)
+               goto set_enable_error;
+
+       mutex_lock(&indio_dev->mlock);
+       err =3D st_accel_set_enable(indio_dev, (int)en);
+       if (err < 0)
+               dev_err(&indio_dev->dev,
+                               "failed to set enable to %d.\n", (int)en);
+       mutex_unlock(&indio_dev->mlock);
+
+set_enable_error:
+       return size;
+}
+
+static ssize_t st_accel_sysfs_get_enable(struct device *dev,
+                               struct device_attribute *attr, char *buf)
+{
+       struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+       struct st_accel_data *adata =3D iio_priv(indio_dev);
+
+       return sprintf(buf, "%d\n", (int)adata->enabled);
+}
+
+static ssize_t st_accel_sysfs_get_fullscale(struct device *dev,
+                               struct device_attribute *attr, char *buf)
+{
+       struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+       struct st_accel_data *adata =3D iio_priv(indio_dev);
+
+       return sprintf(buf, "%d\n", adata->fullscale);
+}
+
+static ssize_t st_accel_sysfs_set_fullscale(struct device *dev,
+               struct device_attribute *attr, const char *buf, size_t size=
)
+{
+       int err;
+       unsigned int fs;
+       struct st_accel_fullscale_available fs_out;
+       struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+       struct st_accel_data *adata =3D iio_priv(indio_dev);
+
+       err =3D kstrtoint(buf, 10, &fs);
+       if (err < 0)
+               goto conversion_error;
+
+       mutex_lock(&indio_dev->mlock);
+       err =3D st_accel_match_fs(&st_accel_sensors[adata->index], fs, &fs_=
out);
+       if (err < 0)
+               goto match_fullscale_error;
+
+       err =3D st_accel_set_fullscale(indio_dev, &fs_out);
+       if (err < 0) {
+               dev_err(&indio_dev->dev,
+                       "failed to set new fullscale. (errn %d).\n", err);
+       }
+
+match_fullscale_error:
+       mutex_unlock(&indio_dev->mlock);
+conversion_error:
+       return size;
+}
+
+static ssize_t st_accel_sysfs_fullscale_available(struct device *dev,
+                               struct device_attribute *attr, char *buf)
+{
+       int i, len =3D 0;
+       struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+       struct st_accel_data *adata =3D iio_priv(indio_dev);
+
+       mutex_lock(&indio_dev->mlock);
+       for (i =3D 0; i < ARRAY_SIZE(st_accel_sensors[adata->index].fs.fs_a=
vl);
+                                                                       i++=
) {
+               if (st_accel_sensors[adata->index].fs.fs_avl[i].num =3D=3D =
0)
+                       break;
+
+               len +=3D sprintf(buf+len, "%d ",
+                       st_accel_sensors[adata->index].fs.fs_avl[i].num);
+       }
+       mutex_unlock(&indio_dev->mlock);
+
+       len--;
+       len +=3D sprintf(buf+len, "\n");
+       return len;
+}
+
+static ssize_t st_accel_sysfs_sampling_frequency_available(struct
device *dev,
+                               struct device_attribute *attr, char *buf)
+{
+       int i, len =3D 0;
+       struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+       struct st_accel_data *adata =3D iio_priv(indio_dev);
+
+       mutex_lock(&indio_dev->mlock);
+       for (i =3D 0; i < ARRAY_SIZE(st_accel_sensors[adata->index].odr.odr=
_avl);
+                                                                       i++=
) {
+               if (st_accel_sensors[adata->index].odr.odr_avl[i].hz =3D=3D=
 0)
+                       break;
+
+               len +=3D sprintf(buf+len, "%d ",
+                       st_accel_sensors[adata->index].odr.odr_avl[i].hz);
+       }
+       mutex_unlock(&indio_dev->mlock);
+
+       len--;
+       len +=3D sprintf(buf+len, "\n");
+       return len;
+}
+
+/**
+ * IIO_DEVICE_ATTR - sampling_frequency_available
+ * @read: show all frequency available of the sensor.
+ *
+ */
+
+static IIO_DEVICE_ATTR(sampling_frequency_available, S_IRUGO,
+               st_accel_sysfs_sampling_frequency_available, NULL , 0);
+
+/**
+ * IIO_DEVICE_ATTR - fullscale_available
+ * @read: show all fullscale available of the sensor.
+ *
+ */
+
+static IIO_DEVICE_ATTR(fullscale_available, S_IRUGO,
+               st_accel_sysfs_fullscale_available, NULL , 0);
+
+/**
+ * IIO_DEVICE_ATTR - fullscale
+ * @read: show the current fullscale of the sensor.
+ * @write: store the current fullscale of the sensor.
+ *
+ */
+
+static IIO_DEVICE_ATTR(fullscale, S_IWUSR | S_IRUGO,
+               st_accel_sysfs_get_fullscale, st_accel_sysfs_set_fullscale =
, 0);
+
+/**
+ * IIO_DEVICE_ATTR - enable
+ * @read: show the current status of the sensor.
+ * @write: power on/off the sensor.
+ *
+ */
+
+static IIO_DEVICE_ATTR(enable, S_IWUSR | S_IRUGO,
st_accel_sysfs_get_enable,
+               st_accel_sysfs_set_enable , 0);
+
+static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
+                       st_accel_sysfs_get_sampling_frequency,
+                                       st_accel_sysfs_set_sampling_frequen=
cy);
+
+static struct attribute *st_accel_attributes[] =3D {
+       &iio_dev_attr_sampling_frequency_available.dev_attr.attr,
+       &iio_dev_attr_fullscale_available.dev_attr.attr,
+       &iio_dev_attr_fullscale.dev_attr.attr,
+       &iio_dev_attr_enable.dev_attr.attr,
+       &iio_dev_attr_sampling_frequency.dev_attr.attr,
+       NULL,
+};
+
+static const struct attribute_group st_accel_attribute_group =3D {
+       .attrs =3D st_accel_attributes,
+};
+
+static const struct iio_info acc_info =3D {
+       .driver_module =3D THIS_MODULE,
+       .attrs =3D &st_accel_attribute_group,
+       .read_raw =3D &st_accel_read_raw,
+};
+
+static int st_accel_init_sensor(struct iio_dev *indio_dev)
+{
+       int err;
+       struct st_accel_odr_available odr_out;
+       struct st_accel_fullscale_available fs_out;
+       struct st_accel_data *adata =3D iio_priv(indio_dev);
+
+       err =3D st_accel_set_enable(indio_dev, ST_ACCEL_OFF);
+       if (err < 0)
+               goto init_error;
+
+       err =3D st_accel_set_axis_enable(indio_dev, ST_ACCEL_ENABLE_ALL_CHA=
NNELS);
+       if (err < 0)
+               goto init_error;
+
+       st_accel_match_fs(&st_accel_sensors[adata->index],
+                                               adata->fullscale, &fs_out);
+       err =3D st_accel_set_fullscale(indio_dev, &fs_out);
+       if (err < 0)
+               goto init_error;
+
+       st_accel_match_odr(&st_accel_sensors[adata->index],
+                                                       adata->odr, &odr_ou=
t);
+       err =3D st_accel_set_odr(indio_dev, &odr_out);
+       if (err < 0)
+               goto init_error;
+
+       err =3D st_accel_set_bdu(indio_dev,
+                       &st_accel_sensors[adata->index].bdu, (u8)ST_ACCEL_O=
N);
+       if (err < 0)
+               goto init_error;
+
+       return 0;
+
+init_error:
+       dev_err(&indio_dev->dev, "failed to init sensor data.");
+       return -EIO;
+}
+
+int st_accel_iio_probe(struct iio_dev *indio_dev)
+{
+       int err;
+       u8 wai;
+       struct st_accel_data *adata =3D iio_priv(indio_dev);
+       struct st_accel_platform_data *pdata;
+
+       mutex_init(&adata->slock);
+       indio_dev->modes =3D INDIO_DIRECT_MODE;
+       indio_dev->info =3D &acc_info;
+
+       err =3D st_accel_get_wai_device(indio_dev,
+                                       ST_ACCEL_DEFAULT_WAI_ADDRESS, &wai)=
;
+       if (err < 0)
+               goto st_accel_iio_probe_error;
+
+       err =3D st_accel_check_device_list(indio_dev, wai);
+       if (err < 0)
+               goto st_accel_iio_probe_error;
+
+       adata->multiread_bit =3D st_accel_sensors[adata->index].multi_read_=
bit;
+       indio_dev->channels =3D st_accel_sensors[adata->index].ch;
+       indio_dev->num_channels =3D ST_ACCEL_NUMBER_ALL_CHANNELS;
+       pdata =3D adata->dev->platform_data;
+       if (pdata =3D=3D NULL) {
+               adata->fullscale =3D st_accel_default_pdata.fullscale;
+               adata->odr =3D st_accel_default_pdata.sampling_frequency;
+       } else {
+               adata->fullscale =3D pdata->fullscale;
+               adata->odr =3D pdata->sampling_frequency;
+       }
+
+       err =3D st_accel_init_sensor(indio_dev);
+       if (err < 0)
+               goto st_accel_iio_probe_error;
+
+       err =3D st_accel_allocate_ring(indio_dev);
+       if (err < 0)
+               goto st_accel_iio_probe_error;
+
+       if (*adata->irq_data_ready > 0) {
+               err =3D st_accel_probe_trigger(indio_dev);
+               if (err < 0)
+                       goto acc_probe_trigger_error;
+       }
+
+       err =3D iio_device_register(indio_dev);
+       if (err)
+               goto iio_device_register_error;
+
+       return err;
+
+iio_device_register_error:
+       st_accel_remove_trigger(indio_dev);
+acc_probe_trigger_error:
+       st_accel_deallocate_ring(indio_dev);
+st_accel_iio_probe_error:
+       return err;
+}
+EXPORT_SYMBOL(st_accel_iio_probe);
+
+void st_accel_iio_remove(struct iio_dev *indio_dev)
+{
+       iio_device_unregister(indio_dev);
+       st_accel_remove_trigger(indio_dev);
+       st_accel_deallocate_ring(indio_dev);
+       iio_device_free(indio_dev);
+}
+EXPORT_SYMBOL(st_accel_iio_remove);
+
+MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics accelerometers driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/accel/st_accel_i2c.c
b/drivers/iio/accel/st_accel_i2c.c
new file mode 100644
index 0000000..7cfeb4c
--- /dev/null
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -0,0 +1,139 @@
+/*
+ * STMicroelectronics accelerometers driver
+ *
+ * Copyright 2012 STMicroelectronics Inc.
+ *
+ * Denis Ciocca <denis.ciocca@st.com>
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+
+#include <linux/iio/accel/st_accel.h>
+
+
+#define ST_ACCEL_I2C_MULTIREAD                 0x80
+
+static int st_accel_i2c_read_byte(struct st_accel_data *adata,
+                                               u8 reg_addr, u8 *res_byte)
+{
+       int err;
+
+       err =3D i2c_smbus_read_byte_data(to_i2c_client(adata->dev), reg_add=
r);
+       if (err < 0)
+               goto st_accel_i2c_read_byte_error;
+       *res_byte =3D err & 0xff;
+       return err;
+
+st_accel_i2c_read_byte_error:
+       return -EIO;
+}
+
+static int st_accel_i2c_read_multiple_byte(struct st_accel_data *adata,
+                                               u8 reg_addr, int len, u8 *d=
ata)
+{
+       int err;
+
+       if (adata->multiread_bit =3D=3D true)
+               reg_addr |=3D ST_ACCEL_I2C_MULTIREAD;
+
+       err =3D i2c_smbus_read_i2c_block_data(to_i2c_client(adata->dev),
+                                                       reg_addr, len, data=
);
+       if (err < 0)
+               goto st_accel_i2c_read_multiple_byte_error;
+
+       return err;
+
+st_accel_i2c_read_multiple_byte_error:
+       return -EIO;
+}
+
+static int st_accel_i2c_write_byte(struct st_accel_data *adata,
+                                                       u8 reg_addr, u8 dat=
a)
+{
+       return i2c_smbus_write_byte_data(to_i2c_client(adata->dev),
+                                                               reg_addr, d=
ata);
+}
+
+static int __devinit st_accel_i2c_probe(struct i2c_client *client,
+                               const struct i2c_device_id *id)
+{
+       struct iio_dev *indio_dev;
+       struct st_accel_data *adata;
+       int err;
+
+       indio_dev =3D iio_device_alloc(sizeof(*adata));
+       if (indio_dev =3D=3D NULL) {
+               err =3D -ENOMEM;
+               goto iio_device_alloc_error;
+       }
+
+       adata =3D iio_priv(indio_dev);
+       adata->dev =3D &client->dev;
+       i2c_set_clientdata(client, indio_dev);
+
+       indio_dev->dev.parent =3D &client->dev;
+       indio_dev->name =3D client->name;
+
+       adata->read_byte =3D st_accel_i2c_read_byte;
+       adata->write_byte =3D st_accel_i2c_write_byte;
+       adata->read_multiple_byte =3D st_accel_i2c_read_multiple_byte;
+       adata->irq_data_ready =3D &client->irq;
+
+       err =3D st_accel_iio_probe(indio_dev);
+       if (err < 0)
+               goto acc_iio_default_error;
+
+       return 0;
+
+acc_iio_default_error:
+       iio_device_free(indio_dev);
+iio_device_alloc_error:
+       return err;
+}
+
+static int __devexit st_accel_i2c_remove(struct i2c_client *client)
+{
+       struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
+
+       st_accel_iio_remove(indio_dev);
+       return 0;
+}
+
+static const struct i2c_device_id st_accel_id_table[] =3D {
+       { LSM303DLH_ACCEL_DEV_NAME },
+       { LSM303DLHC_ACCEL_DEV_NAME },
+       { LIS3DH_ACCEL_DEV_NAME },
+       { LSM330D_ACCEL_DEV_NAME },
+       { LSM330DL_ACCEL_DEV_NAME },
+       { LSM330DLC_ACCEL_DEV_NAME },
+       { LSM303D_ACCEL_DEV_NAME },
+       { LSM9DS0_ACCEL_DEV_NAME },
+       { LIS331DLH_ACCEL_DEV_NAME },
+       { LSM303DL_ACCEL_DEV_NAME },
+       { LSM303DLM_ACCEL_DEV_NAME },
+       { LSM330_ACCEL_DEV_NAME },
+       {},
+};
+MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
+
+static struct i2c_driver st_accel_driver =3D {
+       .driver =3D {
+               .owner =3D THIS_MODULE,
+               .name =3D "st-accel-i2c",
+       },
+       .probe =3D st_accel_i2c_probe,
+       .remove =3D __devexit_p(st_accel_i2c_remove),
+       .id_table =3D st_accel_id_table,
+};
+module_i2c_driver(st_accel_driver);
+
+MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics accelerometers i2c driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/accel/st_accel_spi.c
b/drivers/iio/accel/st_accel_spi.c
new file mode 100644
index 0000000..40279bd
--- /dev/null
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -0,0 +1,199 @@
+/*
+ * STMicroelectronics accelerometers driver
+ *
+ * Copyright 2012 STMicroelectronics Inc.
+ *
+ * Denis Ciocca <denis.ciocca@st.com>
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+
+#include <linux/iio/accel/st_accel.h>
+
+
+#define ACC_SPI_READ           0x80;
+#define ACC_SPI_MULTIREAD      0xc0
+
+static int st_accel_spi_read_byte(struct st_accel_data *adata,
+                                               u8 reg_addr, u8 *res_byte)
+{
+       struct spi_message msg;
+       int err;
+       u8 tx;
+
+       struct spi_transfer xfers[] =3D {
+               {
+                       .tx_buf =3D &tx,
+                       .bits_per_word =3D 8,
+                       .len =3D 1,
+               },
+               {
+                       .rx_buf =3D res_byte,
+                       .bits_per_word =3D 8,
+                       .len =3D 1,
+               }
+       };
+
+       mutex_lock(&adata->slock);
+       tx =3D reg_addr | ACC_SPI_READ;
+       spi_message_init(&msg);
+       spi_message_add_tail(&xfers[0], &msg);
+       spi_message_add_tail(&xfers[1], &msg);
+       err =3D spi_sync(to_spi_device(adata->dev), &msg);
+       mutex_unlock(&adata->slock);
+       if (err)
+               goto acc_spi_read_byte_error;
+
+       return err;
+
+acc_spi_read_byte_error:
+       return -EIO;
+}
+
+static int st_accel_spi_read_multiple_byte(struct st_accel_data *adata,
+                                               u8 reg_addr, int len, u8 *d=
ata)
+{
+       struct spi_message msg;
+       int err;
+       u8 tx;
+
+       struct spi_transfer xfers[] =3D {
+               {
+                       .tx_buf =3D &tx,
+                       .bits_per_word =3D 8,
+                       .len =3D 1,
+               },
+               {
+                       .rx_buf =3D data,
+                       .bits_per_word =3D 8,
+                       .len =3D len,
+               }
+       };
+
+       mutex_lock(&adata->slock);
+       if (adata->multiread_bit =3D=3D true)
+               tx =3D reg_addr | ACC_SPI_MULTIREAD;
+       else
+               tx =3D reg_addr | ACC_SPI_READ;
+
+       spi_message_init(&msg);
+       spi_message_add_tail(&xfers[0], &msg);
+       spi_message_add_tail(&xfers[1], &msg);
+       err =3D spi_sync(to_spi_device(adata->dev), &msg);
+       mutex_unlock(&adata->slock);
+       if (err)
+               goto acc_spi_read_multiple_byte_error;
+       return len;
+
+acc_spi_read_multiple_byte_error:
+       return -EIO;
+}
+
+static int st_accel_spi_write_byte(struct st_accel_data *adata,
+                                                       u8 reg_addr, u8 dat=
a)
+{
+       struct spi_message msg;
+       int err;
+       u8 tx[2];
+
+       struct spi_transfer xfers[] =3D {
+               {
+                       .tx_buf =3D tx,
+                       .bits_per_word =3D 8,
+                       .len =3D 2,
+               }
+       };
+
+       mutex_lock(&adata->slock);
+       tx[0] =3D reg_addr;
+       tx[1] =3D data;
+       spi_message_init(&msg);
+       spi_message_add_tail(&xfers[0], &msg);
+       err =3D spi_sync(to_spi_device(adata->dev), &msg);
+       mutex_unlock(&adata->slock);
+
+       return err;
+}
+
+static int __devinit st_accel_spi_probe(struct spi_device *client)
+{
+       struct iio_dev *indio_dev;
+       struct st_accel_data *adata;
+       int err;
+
+       indio_dev =3D iio_device_alloc(sizeof(*adata));
+       if (indio_dev =3D=3D NULL) {
+               err =3D -ENOMEM;
+               goto iio_device_alloc_error;
+       }
+
+       adata =3D iio_priv(indio_dev);
+       adata->dev =3D &client->dev;
+       spi_set_drvdata(client, indio_dev);
+
+       indio_dev->dev.parent =3D &client->dev;
+       indio_dev->name =3D client->modalias;
+
+       adata->read_byte =3D st_accel_spi_read_byte;
+       adata->write_byte =3D st_accel_spi_write_byte;
+       adata->read_multiple_byte =3D st_accel_spi_read_multiple_byte;
+       adata->irq_data_ready =3D &client->irq;
+
+       err =3D st_accel_iio_probe(indio_dev);
+       if (err < 0)
+               goto acc_iio_default_error;
+
+       return 0;
+
+acc_iio_default_error:
+       iio_device_free(indio_dev);
+iio_device_alloc_error:
+       return err;
+}
+
+static int __devexit st_accel_spi_remove(struct spi_device *spi)
+{
+       struct iio_dev *indio_dev =3D spi_get_drvdata(spi);
+
+       st_accel_iio_remove(indio_dev);
+       return 0;
+}
+
+static const struct spi_device_id st_accel_id_table[] =3D {
+       { LSM303DLH_ACCEL_DEV_NAME },
+       { LSM303DLHC_ACCEL_DEV_NAME },
+       { LIS3DH_ACCEL_DEV_NAME },
+       { LSM330D_ACCEL_DEV_NAME },
+       { LSM330DL_ACCEL_DEV_NAME },
+       { LSM330DLC_ACCEL_DEV_NAME },
+       { LSM303D_ACCEL_DEV_NAME },
+       { LSM9DS0_ACCEL_DEV_NAME },
+       { LIS331DLH_ACCEL_DEV_NAME },
+       { LSM303DL_ACCEL_DEV_NAME },
+       { LSM303DLM_ACCEL_DEV_NAME },
+       { LSM330_ACCEL_DEV_NAME },
+       {},
+};
+MODULE_DEVICE_TABLE(spi, st_accel_id_table);
+
+static struct spi_driver st_accel_driver =3D {
+       .driver =3D {
+               .owner =3D THIS_MODULE,
+               .name =3D "st-accel-spi",
+       },
+       .probe =3D st_accel_spi_probe,
+       .remove =3D __devexit_p(st_accel_spi_remove),
+       .id_table =3D st_accel_id_table,
+};
+module_spi_driver(st_accel_driver);
+
+MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics accelerometers spi driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/accel/st_accel_trigger.c
b/drivers/iio/accel/st_accel_trigger.c
new file mode 100644
index 0000000..7b57b7f
--- /dev/null
+++ b/drivers/iio/accel/st_accel_trigger.c
@@ -0,0 +1,84 @@
+/*
+ * STMicroelectronics accelerometers driver
+ *
+ * Copyright 2012 STMicroelectronics Inc.
+ *
+ * Denis Ciocca <denis.ciocca@st.com>
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/stat.h>
+#include <linux/interrupt.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+
+#include <linux/iio/accel/st_accel.h>
+
+
+static int st_accel_trig_acc_set_state(struct iio_trigger *trig, bool
state)
+{
+       struct iio_dev *indio_dev =3D trig->private_data;
+       return st_accel_set_dataready_irq(indio_dev, state);
+}
+
+static const struct iio_trigger_ops st_accel_trigger_ops =3D {
+       .owner =3D THIS_MODULE,
+       .set_trigger_state =3D &st_accel_trig_acc_set_state,
+};
+
+int st_accel_probe_trigger(struct iio_dev *indio_dev)
+{
+       int err;
+       struct st_accel_data *adata =3D iio_priv(indio_dev);
+
+       adata->trig =3D iio_trigger_alloc("%s-trigger", indio_dev->name);
+       if (adata->trig =3D=3D NULL) {
+               err =3D -ENOMEM;
+               dev_err(&indio_dev->dev, "failed to allocate iio trigger.\n=
");
+               goto iio_trigger_alloc_error;
+       }
+
+       err =3D request_threaded_irq(*adata->irq_data_ready,
+                       iio_trigger_generic_data_rdy_poll,
+                       NULL,
+                       IRQF_TRIGGER_RISING,
+                       adata->trig->name,
+                       adata->trig);
+       if (err)
+               goto request_irq_error;
+
+       adata->trig->private_data =3D indio_dev;
+       adata->trig->ops =3D &st_accel_trigger_ops;
+       adata->trig->dev.parent =3D adata->dev;
+
+       err =3D iio_trigger_register(adata->trig);
+       if (err < 0) {
+               dev_err(&indio_dev->dev, "failed to register iio trigger.\n=
");
+               goto iio_trigger_register_error;
+       }
+       indio_dev->trig =3D adata->trig;
+
+       return 0;
+
+iio_trigger_register_error:
+       free_irq(*adata->irq_data_ready, adata->trig);
+request_irq_error:
+       iio_trigger_free(adata->trig);
+iio_trigger_alloc_error:
+       return err;
+}
+EXPORT_SYMBOL(st_accel_probe_trigger);
+
+void st_accel_remove_trigger(struct iio_dev *indio_dev)
+{
+       struct st_accel_data *adata =3D iio_priv(indio_dev);
+
+       iio_trigger_unregister(adata->trig);
+       free_irq(*adata->irq_data_ready, adata->trig);
+       iio_trigger_free(adata->trig);
+}
+EXPORT_SYMBOL(st_accel_remove_trigger);
diff --git a/include/linux/iio/accel/st_accel.h
b/include/linux/iio/accel/st_accel.h
new file mode 100644
index 0000000..557d8cf
--- /dev/null
+++ b/include/linux/iio/accel/st_accel.h
@@ -0,0 +1,122 @@
+/*
+ * STMicroelectronics accelerometers driver
+ *
+ * Copyright 2012 STMicroelectronics Inc.
+ *
+ * Denis Ciocca <denis.ciocca@st.com>
+ * v. 1.0.0
+ * Licensed under the GPL-2.
+ */
+
+/*
+ * Supported sensors:
+ * LSM303DLH
+ * LSM303DLHC
+ * LIS3DH
+ * LSM330D
+ * LSM330DL
+ * LSM330DLC
+ * LSM303D
+ * LSM9DS0
+ * LIS331DLH
+ * LSM303DL
+ * LSM303DLM
+ * LSM330
+ *
+ */
+
+
+#ifndef ST_ACCEL_H
+#define ST_ACCEL_H
+
+#define LSM303DLH_ACCEL_DEV_NAME       "lsm303dlh_accel"
+#define LSM303DLHC_ACCEL_DEV_NAME      "lsm303dlhc_accel"
+#define LIS3DH_ACCEL_DEV_NAME          "lis3dh"
+#define LSM330D_ACCEL_DEV_NAME         "lsm330d_accel"
+#define LSM330DL_ACCEL_DEV_NAME                "lsm330dl_accel"
+#define LSM330DLC_ACCEL_DEV_NAME       "lsm330dlc_accel"
+#define LSM303D_ACCEL_DEV_NAME         "lsm303d"
+#define LSM9DS0_ACCEL_DEV_NAME         "lsm9ds0"
+#define LIS331DLH_ACCEL_DEV_NAME       "lis331dlh"
+#define LSM303DL_ACCEL_DEV_NAME                "lsm303dl_accel"
+#define LSM303DLM_ACCEL_DEV_NAME       "lsm303dlm_accel"
+#define LSM330_ACCEL_DEV_NAME          "lsm330_accel"
+
+#define ST_ACCEL_NUMBER_ALL_CHANNELS   4
+#define ST_ACCEL_NUMBER_DATA_CHANNELS  3
+#define ST_ACCEL_BYTE_FOR_CHANNEL      2
+#define ST_ACCEL_SCAN_X                        0
+#define ST_ACCEL_SCAN_Y                        1
+#define ST_ACCEL_SCAN_Z                        2
+
+/**
+ * struct st_accel_data - ST accel device status
+ * @dev: Pointer to instance of struct device (I2C or SPI).
+ * @name: Name of the sensor in use.
+ * @enabled: Status of the sensor (0->off, 1->on).
+ * @index: Number used to point the sensor being used in the
+ *     st_accel_sensors struct.
+ * @fullscale: Maximum range of measure by the sensor.
+ * @gain: Sensitivity of the sensor [ug/LSB].
+ * @odr: Output data rate of the sensor.
+ * @multiread_bit: Use or not particular bit for [I2C/SPI] multiread.
+ * @read_byte: Function used to read one byte.
+ * @write_byte: Function used to write one byte.
+ * @read_multiple_byte: Function used to read multiple byte.
+ * @trig: The trigger in use by the core driver.
+ * @irq_data_ready: IRQ number for data ready on INT1 pin.
+ * @slock: mutex for read and write operation.
+ *
+ */
+
+struct st_accel_data {
+       struct device *dev;
+       bool enabled;
+       short index;
+
+       unsigned int fullscale;
+       unsigned int gain;
+       unsigned int odr;
+
+       bool multiread_bit;
+       int (*read_byte) (struct st_accel_data *adata, u8 reg_addr,
+                                                               u8 *res_byt=
e);
+       int (*write_byte) (struct st_accel_data *adata, u8 reg_addr, u8 dat=
a);
+       int (*read_multiple_byte) (struct st_accel_data *adata, u8 reg_addr=
,
+                                                       int len, u8 *data);
+
+       struct iio_trigger *trig;
+       int *irq_data_ready;
+       struct mutex slock;
+};
+
+int st_accel_iio_probe(struct iio_dev *indio_dev);
+void st_accel_iio_remove(struct iio_dev *indio_dev);
+int st_accel_set_dataready_irq(struct iio_dev *indio_dev, bool enable);
+int st_accel_set_axis_enable(struct iio_dev *indio_dev, u8 axis_enable);
+
+#ifdef CONFIG_IIO_BUFFER
+int st_accel_probe_trigger(struct iio_dev *indio_dev);
+void st_accel_remove_trigger(struct iio_dev *indio_dev);
+int st_accel_allocate_ring(struct iio_dev *indio_dev);
+void st_accel_deallocate_ring(struct iio_dev *indio_dev);
+#else /* CONFIG_IIO_BUFFER */
+static inline int st_accel_probe_trigger(struct iio_dev *indio_dev)
+{
+       return 0;
+}
+static inline void st_accel_remove_trigger(struct iio_dev *indio_dev)
+{
+       return;
+}
+static inline int st_accel_allocate_ring(struct iio_dev *indio_dev)
+{
+       return 0;
+}
+static inline void st_accel_deallocate_ring(struct iio_dev *indio_dev)
+{
+       return;
+}
+#endif /* CONFIG_IIO_BUFFER */
+
+#endif /* ST_ACCEL_H */
diff --git a/include/linux/platform_data/st_accel_pdata.h
b/include/linux/platform_data/st_accel_pdata.h
new file mode 100644
index 0000000..416489b
--- /dev/null
+++ b/include/linux/platform_data/st_accel_pdata.h
@@ -0,0 +1,27 @@
+/*
+ * STMicroelectronics accelerometers driver
+ *
+ * Copyright 2012 STMicroelectronics Inc.
+ *
+ * Denis Ciocca <denis.ciocca@st.com>
+ *
+ * Licensed under the GPL-2.
+ */
+
+
+#ifndef ST_ACCEL_PDATA_H
+#define ST_ACCEL_PDATA_H
+
+
+/**
+ * struct st_accel_platform_data - ST accel device platform data
+ * @fullscale: Value of fullscale used for the sensor.
+ * @sampling_frequency: Value of sampling frequency used for the sensor.
+ */
+
+struct st_accel_platform_data {
+       int fullscale;
+       int sampling_frequency;
+};
+
+#endif /* ST_ACCEL_PDATA_H */
--
1.7.0.4
