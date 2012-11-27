Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133]:56779 "EHLO
	eu1sys200aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755788Ab2K0Pgi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 27 Nov 2012 10:36:38 -0500
From: Denis CIOCCA <denis.ciocca@st.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Denis Ciocca <denis.ciocca@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
	Pavel Machek <pavel@denx.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"burman.yan@gmail.com" <burman.yan@gmail.com>
Date: Tue, 27 Nov 2012 16:36:12 +0100
Subject: STMicroelectronics gyroscopes driver.
Message-ID: <50B4DDEC.9030903@st.com>
References: <5072F3B9.4050309@st.com> <5073260C.3010506@metafoo.de>
 <20121008195007.GA32042@elf.ucw.cz> <507338B5.60307@metafoo.de>
 <665718a4-de6b-4d09-ba80-35705fcf2595@email.android.com>
 <CAEE_umojW5OyB3yGgE54wH7_k__dBu9=Yew_0tCCf5--=C2g5g@mail.gmail.com>
 <507D9EA3.4070009@metafoo.de> <5085128C.7020507@st.com>
 <50858B44.2080006@kernel.org> <5087E2A8.4070304@st.com>
 <508A7DA6.7050505@metafoo.de> <508E4492.8080000@st.com>
 <508E48D1.3000703@metafoo.de> <508E5978.5000907@st.com>
 <508E5AD5.1040907@metafoo.de> <50914366.4090000@st.com>
 <5091546D.9000601@metafoo.de>
 <CAEE_umoKvv9ciBfUSahDqsmcbHi9W=93o5YSpE-vxUduCmqWSQ@mail.gmail.com>
 <50982F71.3060606@kernel.org> <5098F065.1090009@st.com>
 <50A12D8C.6040207@st.com> <50A14485.2060902@kernel.org>
 <50A26967.4050102@st.com> <50A8E083.1050908@kernel.org>
 <50AFA000.3040906@st.com> <50B0F495.6040409@kernel.org>
In-Reply-To: <50B0F495.6040409@kernel.org>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi guys,

based on the driver for accelerometers, I wrote the driver for all our
last mems gyroscopes.
Best regards,

Denis


 From 6634b1b6f2cb2887dbc00a802cc365fb26ce7be0 Mon Sep 17 00:00:00 2001
From: Denis Ciocca <denis.ciocca@st.com>
Date: Tue, 27 Nov 2012 16:20:40 +0100
Subject: [PATCH] iio:gyro: Add STMicroelectronics gyroscopes driver

This patch adds generic gyroscope driver for STMicroelectronics
gyroscopes, currently it supports:
L3G4200D, LSM330DL, L3GD20, L3GD20H, LSM330D, LSM330DLC, LSM9DS0,
L3G4IS, LSM330
---
  drivers/iio/gyro/Kconfig           |   37 ++
  drivers/iio/gyro/Makefile          |    6 +
  drivers/iio/gyro/st_gyro_buffer.c  |  177 +++++++
  drivers/iio/gyro/st_gyro_core.c    |  929
++++++++++++++++++++++++++++++++++++
  drivers/iio/gyro/st_gyro_i2c.c     |  125 +++++
  drivers/iio/gyro/st_gyro_spi.c     |  179 +++++++
  drivers/iio/gyro/st_gyro_trigger.c |   83 ++++
  include/linux/iio/gyro/st_gyro.h   |   99 ++++
  8 files changed, 1635 insertions(+), 0 deletions(-)
  create mode 100644 drivers/iio/gyro/st_gyro_buffer.c
  create mode 100644 drivers/iio/gyro/st_gyro_core.c
  create mode 100644 drivers/iio/gyro/st_gyro_i2c.c
  create mode 100644 drivers/iio/gyro/st_gyro_spi.c
  create mode 100644 drivers/iio/gyro/st_gyro_trigger.c
  create mode 100644 include/linux/iio/gyro/st_gyro.h

diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
index 21e27e2..d105242 100644
--- a/drivers/iio/gyro/Kconfig
+++ b/drivers/iio/gyro/Kconfig
@@ -13,4 +13,41 @@ config HID_SENSOR_GYRO_3D
          Say yes here to build support for the HID SENSOR
          Gyroscope 3D.

+config ST_GYRO_3AXIS
+       tristate "STMicroelectronics gyroscopes 3-Axis Driver"
+       depends on (I2C || SPI) && SYSFS
+       help
+         Say yes here to build support for STMicroelectronics gyroscopes:
+         L3G4200D, LSM330DL, L3GD20, L3GD20H, LSM330D, LSM330DL, LSM330DLC,
+         LSM9DS0, L3G4IS, LSM330.
+
+         This driver can also be built as a module. If so, the module
+         will be called st_gyro.
+
+config ST_GYRO_3AXIS_I2C
+       tristate "support I2C bus connection"
+       depends on ST_GYRO_3AXIS && I2C
+       help
+         Say yes here to build I2C support for STMicroelectronics gyroscopes.
+
+         To compile this driver as a module, choose M here: the
+         module will be called st_gyro_i2c.
+
+config ST_GYRO_3AXIS_SPI
+       tristate "support SPI bus connection"
+       depends on ST_GYRO_3AXIS && SPI_MASTER
+       help
+         Say yes here to build SPI support for STMicroelectronics gyroscopes.
+
+         To compile this driver as a module, choose M here: the
+         module will be called st_gyro_spi.
+
+config ST_GYRO_3AXIS_TRIGGERED_BUFFER
+       tristate "support triggered buffer"
+       depends on ST_GYRO_3AXIS
+       select IIO_TRIGGERED_BUFFER
+       select IIO_BUFFER
+       help
+         Default trigger and buffer for STMicroelectronics gyroscopes driver.
+
  endmenu
diff --git a/drivers/iio/gyro/Makefile b/drivers/iio/gyro/Makefile
index 8a895d9..d8ad80b 100644
--- a/drivers/iio/gyro/Makefile
+++ b/drivers/iio/gyro/Makefile
@@ -3,3 +3,9 @@
  #

  obj-$(CONFIG_HID_SENSOR_GYRO_3D) += hid-sensor-gyro-3d.o
+
+st_gyro-y := st_gyro_core.o
+obj-$(CONFIG_ST_GYRO_3AXIS_I2C) += st_gyro_i2c.o
+obj-$(CONFIG_ST_GYRO_3AXIS_SPI) += st_gyro_spi.o
+obj-$(CONFIG_ST_GYRO_3AXIS_TRIGGERED_BUFFER) += st_gyro_trigger.o
st_gyro_buffer.o
+obj-$(CONFIG_ST_GYRO_3AXIS) += st_gyro.o
diff --git a/drivers/iio/gyro/st_gyro_buffer.c
b/drivers/iio/gyro/st_gyro_buffer.c
new file mode 100644
index 0000000..3ae3b62
--- /dev/null
+++ b/drivers/iio/gyro/st_gyro_buffer.c
@@ -0,0 +1,177 @@
+/*
+ * STMicroelectronics gyroscopes driver
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
+#include <linux/iio/gyro/st_gyro.h>
+
+
+#define ST_GYRO_ENABLE_ALL_CHANNELS            0x07
+
+static int st_gyro_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
+{
+       int i, n, len;
+       u8 reg_addr[ST_GYRO_NUMBER_DATA_CHANNELS];
+       struct st_gyro_data *gdata = iio_priv(indio_dev);
+
+       for (i = 0; i < ST_GYRO_NUMBER_DATA_CHANNELS; i++) {
+               if (test_bit(i, indio_dev->active_scan_mask)) {
+                       reg_addr[n] = indio_dev->channels[i].address;
+                       n++;
+               }
+       }
+       switch (n) {
+       case 1:
+               len = gdata->read_multiple_byte(gdata, reg_addr[0],
+                                       ST_GYRO_BYTE_FOR_CHANNEL, buf);
+               break;
+       case 2:
+               if ((reg_addr[1] - reg_addr[0]) == ST_GYRO_BYTE_FOR_CHANNEL) {
+                       len = gdata->read_multiple_byte(gdata, reg_addr[0],
+                                       ST_GYRO_BYTE_FOR_CHANNEL*n,
+                                       buf);
+               } else {
+                       u8 rx_array[ST_GYRO_BYTE_FOR_CHANNEL*
+                               ST_GYRO_NUMBER_DATA_CHANNELS];
+                       len = gdata->read_multiple_byte(gdata, reg_addr[0],
+                               ST_GYRO_BYTE_FOR_CHANNEL*
+                               ST_GYRO_NUMBER_DATA_CHANNELS,
+                               rx_array);
+                       if (len < 0)
+                               goto read_data_channels_error;
+
+                       for (i = 0; i < n * ST_GYRO_NUMBER_DATA_CHANNELS;
+                                                                       i++) {
+                               if (i < n)
+                                       buf[i] = rx_array[i];
+                               else
+                                       buf[i] = rx_array[n + i];
+                       }
+                       len = ST_GYRO_BYTE_FOR_CHANNEL*n;
+               }
+               break;
+       case 3:
+               len = gdata->read_multiple_byte(gdata, reg_addr[0],
+                       ST_GYRO_BYTE_FOR_CHANNEL*ST_GYRO_NUMBER_DATA_CHANNELS,
+                       buf);
+               break;
+       default:
+               len = -EINVAL;
+               goto read_data_channels_error;
+       }
+       if (len != ST_GYRO_BYTE_FOR_CHANNEL*n) {
+               len = -EIO;
+               goto read_data_channels_error;
+       }
+
+read_data_channels_error:
+       return len;
+}
+
+static irqreturn_t st_gyro_trigger_handler(int irq, void *p)
+{
+       int len;
+       struct iio_poll_func *pf = p;
+       struct iio_dev *indio_dev = pf->indio_dev;
+       struct st_gyro_data *gdata = iio_priv(indio_dev);
+
+       len = st_gyro_get_buffer_element(indio_dev, gdata->buffer_data);
+       if (len < 0)
+               goto st_gyro_get_buffer_element_error;
+
+       if (indio_dev->scan_timestamp)
+               *(s64 *)((u8 *)gdata->buffer_data +
+                               ALIGN(len, sizeof(s64))) = pf->timestamp;
+
+       iio_push_to_buffer(indio_dev->buffer, gdata->buffer_data);
+
+st_gyro_get_buffer_element_error:
+       iio_trigger_notify_done(indio_dev->trig);
+
+       return IRQ_HANDLED;
+}
+
+static int st_gyro_buffer_postenable(struct iio_dev *indio_dev)
+{
+       int err, i;
+       u8 active_bit = 0x00;
+       struct st_gyro_data *gdata = iio_priv(indio_dev);
+
+       gdata->buffer_data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
+       if (gdata->buffer_data == NULL) {
+               err = -ENOMEM;
+               goto allocate_memory_error;
+       }
+
+       for (i = 0; i < ST_GYRO_NUMBER_DATA_CHANNELS; i++)
+               if (test_bit(i, indio_dev->active_scan_mask))
+                       active_bit |= (1 << i);
+
+       err = st_gyro_set_axis_enable(indio_dev, active_bit);
+       if (err < 0)
+               goto st_gyro_buffer_postenable_error;
+
+       err = iio_triggered_buffer_postenable(indio_dev);
+
+       return err;
+
+allocate_memory_error:
+       kfree(gdata->buffer_data);
+st_gyro_buffer_postenable_error:
+       return err;
+}
+
+static int st_gyro_buffer_predisable(struct iio_dev *indio_dev)
+{
+       int err;
+       struct st_gyro_data *gdata = iio_priv(indio_dev);
+
+       err = iio_triggered_buffer_predisable(indio_dev);
+       if (err < 0)
+               goto st_gyro_buffer_predisable_error;
+
+       err = st_gyro_set_axis_enable(indio_dev, ST_GYRO_ENABLE_ALL_CHANNELS);
+       if (err < 0)
+               goto st_gyro_buffer_predisable_error;
+
+       kfree(gdata->buffer_data);
+
+st_gyro_buffer_predisable_error:
+       return err;
+}
+
+static const struct iio_buffer_setup_ops st_gyro_buffer_setup_ops = {
+       .preenable = &iio_sw_buffer_preenable,
+       .postenable = &st_gyro_buffer_postenable,
+       .predisable = &st_gyro_buffer_predisable,
+};
+
+int st_gyro_allocate_ring(struct iio_dev *indio_dev)
+{
+       return iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
+                       &st_gyro_trigger_handler, &st_gyro_buffer_setup_ops);
+}
+EXPORT_SYMBOL(st_gyro_allocate_ring);
+
+void st_gyro_deallocate_ring(struct iio_dev *indio_dev)
+{
+       iio_triggered_buffer_cleanup(indio_dev);
+}
+EXPORT_SYMBOL(st_gyro_deallocate_ring);
diff --git a/drivers/iio/gyro/st_gyro_core.c
b/drivers/iio/gyro/st_gyro_core.c
new file mode 100644
index 0000000..c2215af
--- /dev/null
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -0,0 +1,929 @@
+/*
+ * STMicroelectronics gyroscopes driver
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
+#include <linux/iio/gyro/st_gyro.h>
+
+
+#define ST_GYRO_FULLSCALE_AVL_MAX              3
+#define ST_GYRO_ODR_LIST_MAX                   4
+#define ST_GYRO_ENABLE_ALL_CHANNELS            0x07
+
+/* DEFAULT VALUE FOR SENSORS */
+#define ST_GYRO_DEFAULT_OUT_X_L_ADDR           0x28
+#define ST_GYRO_DEFAULT_OUT_X_H_ADDR           0x29
+#define ST_GYRO_DEFAULT_OUT_Y_L_ADDR           0x2a
+#define ST_GYRO_DEFAULT_OUT_Y_H_ADDR           0x2b
+#define ST_GYRO_DEFAULT_OUT_Z_L_ADDR           0x2c
+#define ST_GYRO_DEFAULT_OUT_Z_H_ADDR           0x2d
+#define ST_GYRO_DEFAULT_WAI_ADDRESS            0x0f
+#define ST_GYRO_DEFAULT_POWER_ON_VALUE         0x01
+#define ST_GYRO_DEFAULT_POWER_OFF_VALUE                0x00
+#define ST_GYRO_DEFAULT_16_REALBITS            16
+#define ST_GYRO_DEFAULT_AXIS_ADDR              0x20
+#define ST_GYRO_DEFAULT_AXIS_MASK              0x07
+#define ST_GYRO_DEFAULT_AXIS_N_BIT             3
+
+/* FULLSCALE */
+#define ST_GYRO_FS_AVL_250DPS                  250
+#define ST_GYRO_FS_AVL_500DPS                  500
+#define ST_GYRO_FS_AVL_2000DPS                 2000
+
+/* CUSTOM VALUES FOR SENSOR 1 */
+#define ST_GYRO_1_WAI_EXP                      0xd3
+#define ST_GYRO_1_ODR_ADDR                     0x20
+#define ST_GYRO_1_ODR_MASK                     0xc0
+#define ST_GYRO_1_ODR_N_BIT                    2
+#define ST_GYRO_1_ODR_AVL_100HZ_VAL            0x00
+#define ST_GYRO_1_ODR_AVL_200HZ_VAL            0x01
+#define ST_GYRO_1_ODR_AVL_400HZ_VAL            0x02
+#define ST_GYRO_1_ODR_AVL_800HZ_VAL            0x03
+#define ST_GYRO_1_PW_ADDR                      0x20
+#define ST_GYRO_1_PW_MASK                      0x08
+#define ST_GYRO_1_PW_N_BIT                     1
+#define ST_GYRO_1_FS_N_BIT                     2
+#define ST_GYRO_1_FS_ADDR                      0x23
+#define ST_GYRO_1_FS_MASK                      0x30
+#define ST_GYRO_1_FS_AVL_250_VAL               0x00
+#define ST_GYRO_1_FS_AVL_500_VAL               0x01
+#define ST_GYRO_1_FS_AVL_2000_VAL              0x02
+#define ST_GYRO_1_FS_AVL_250_GAIN              IIO_DEGREE_TO_RAD(8750)
+#define ST_GYRO_1_FS_AVL_500_GAIN              IIO_DEGREE_TO_RAD(17500)
+#define ST_GYRO_1_FS_AVL_2000_GAIN             IIO_DEGREE_TO_RAD(70000)
+#define ST_GYRO_1_BDU_ADDR                     0x23
+#define ST_GYRO_1_BDU_MASK                     0x80
+#define ST_GYRO_1_DRDY_IRQ_ADDR                        0x22
+#define ST_GYRO_1_DRDY_IRQ_MASK                        0x08
+#define ST_GYRO_1_MULTIREAD_BIT                        true
+
+/* CUSTOM VALUES FOR SENSOR 2 */
+#define ST_GYRO_2_WAI_EXP                      0xd4
+#define ST_GYRO_2_ODR_ADDR                     0x20
+#define ST_GYRO_2_ODR_MASK                     0xc0
+#define ST_GYRO_2_ODR_N_BIT                    2
+#define ST_GYRO_2_ODR_AVL_95HZ_VAL             0x00
+#define ST_GYRO_2_ODR_AVL_190HZ_VAL            0x01
+#define ST_GYRO_2_ODR_AVL_380HZ_VAL            0x02
+#define ST_GYRO_2_ODR_AVL_760HZ_VAL            0x03
+#define ST_GYRO_2_PW_ADDR                      0x20
+#define ST_GYRO_2_PW_MASK                      0x08
+#define ST_GYRO_2_PW_N_BIT                     1
+#define ST_GYRO_2_FS_N_BIT                     2
+#define ST_GYRO_2_FS_ADDR                      0x23
+#define ST_GYRO_2_FS_MASK                      0x30
+#define ST_GYRO_2_FS_AVL_250_VAL               0x00
+#define ST_GYRO_2_FS_AVL_500_VAL               0x01
+#define ST_GYRO_2_FS_AVL_2000_VAL              0x02
+#define ST_GYRO_2_FS_AVL_250_GAIN              IIO_DEGREE_TO_RAD(8750)
+#define ST_GYRO_2_FS_AVL_500_GAIN              IIO_DEGREE_TO_RAD(17500)
+#define ST_GYRO_2_FS_AVL_2000_GAIN             IIO_DEGREE_TO_RAD(70000)
+#define ST_GYRO_2_BDU_ADDR                     0x23
+#define ST_GYRO_2_BDU_MASK                     0x80
+#define ST_GYRO_2_DRDY_IRQ_ADDR                        0x22
+#define ST_GYRO_2_DRDY_IRQ_MASK                        0x08
+#define ST_GYRO_2_MULTIREAD_BIT                        true
+
+struct st_gyro_odr_available {
+       unsigned int hz;
+       u8 value;
+};
+
+struct st_gyro_odr {
+       u8 addr;
+       u8 mask;
+       short num_bit;
+       struct st_gyro_odr_available odr_avl[ST_GYRO_ODR_LIST_MAX];
+};
+
+struct st_gyro_power {
+       u8 addr;
+       u8 mask;
+       unsigned short num_bit;
+       u8 value_off;
+       u8 value_on;
+};
+
+struct st_gyro_axis {
+       u8 addr;
+       u8 mask;
+};
+
+struct st_gyro_fullscale_available {
+       unsigned int num;
+       u8 value;
+       unsigned int gain;
+};
+
+struct st_gyro_fullscale {
+       u8 addr;
+       u8 mask;
+       unsigned short num_bit;
+       struct st_gyro_fullscale_available fs_avl[ST_GYRO_FULLSCALE_AVL_MAX];
+};
+
+struct st_gyro_bdu {
+       u8 addr;
+       u8 mask;
+};
+
+struct st_gyro_interrupt_generator {
+       u8 en_addr;
+       u8 latch_mask_addr;
+       u8 en_mask;
+       u8 latching_mask;
+};
+
+struct st_gyro_data_ready_irq {
+       u8 addr;
+       u8 mask;
+       struct st_gyro_interrupt_generator ig1;
+};
+
+#define ST_GYRO_LSM_CHANNELS(index, mod, endian, bits, addr) \
+{ \
+       .type = IIO_ANGL_VEL, \
+       .modified = 1, \
+       .info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT | \
+                                       IIO_CHAN_INFO_SCALE_SEPARATE_BIT, \
+       .scan_index = index, \
+       .channel2 = mod, \
+       .address = addr, \
+       .scan_type = { \
+               .sign = 's', \
+               .realbits = bits, \
+               .shift = 16 - bits, \
+               .storagebits = 16, \
+               .endianness = endian, \
+       }, \
+}
+
+static const struct iio_chan_spec st_gyro_16bit_channels[] = {
+       ST_GYRO_LSM_CHANNELS(ST_GYRO_SCAN_X, IIO_MOD_X, IIO_LE,
+               ST_GYRO_DEFAULT_16_REALBITS, ST_GYRO_DEFAULT_OUT_X_L_ADDR),
+       ST_GYRO_LSM_CHANNELS(ST_GYRO_SCAN_Y, IIO_MOD_Y, IIO_LE,
+               ST_GYRO_DEFAULT_16_REALBITS, ST_GYRO_DEFAULT_OUT_Y_L_ADDR),
+       ST_GYRO_LSM_CHANNELS(ST_GYRO_SCAN_Z, IIO_MOD_Z, IIO_LE,
+               ST_GYRO_DEFAULT_16_REALBITS, ST_GYRO_DEFAULT_OUT_Z_L_ADDR),
+       IIO_CHAN_SOFT_TIMESTAMP(3)
+};
+
+/**
+ * struct st_gyro_sensors - ST gyro sensors list
+ * @wai: Contents of WhoAmI register.
+ * @ch: IIO channels for the sensor.
+ * @odr: Output data rate register and odr list available.
+ * @pw: Power register of the sensor.
+ * @enable_axis: Enable one or more axis of the sensor.
+ * @fs: Full scale register and fs list available.
+ * @bdu: Block data update register.
+ * @drdy_irq: Data ready register of the sensor.
+ * @multi_read_bit: Use or not particular bit for [I2C/SPI] multiread.
+ */
+static const struct st_gyro_sensors {
+       u8 wai;
+       struct iio_chan_spec *ch;
+       struct st_gyro_odr odr;
+       struct st_gyro_power pw;
+       struct st_gyro_axis enable_axis;
+       struct st_gyro_fullscale fs;
+       struct st_gyro_bdu bdu;
+       struct st_gyro_data_ready_irq drdy_irq;
+       bool multi_read_bit;
+} st_gyro_sensors[] = {
+       {
+               .wai = ST_GYRO_1_WAI_EXP,
+               .ch = (struct iio_chan_spec *)st_gyro_16bit_channels,
+               .odr = {
+                       .addr = ST_GYRO_1_ODR_ADDR,
+                       .mask = ST_GYRO_1_ODR_MASK,
+                       .num_bit = ST_GYRO_1_ODR_N_BIT,
+                       .odr_avl = {
+                               { 100, ST_GYRO_1_ODR_AVL_100HZ_VAL, },
+                               { 200, ST_GYRO_1_ODR_AVL_200HZ_VAL, },
+                               { 400, ST_GYRO_1_ODR_AVL_400HZ_VAL, },
+                               { 800, ST_GYRO_1_ODR_AVL_800HZ_VAL, },
+                       },
+               },
+               .pw = {
+                       .addr = ST_GYRO_1_PW_ADDR,
+                       .mask = ST_GYRO_1_PW_MASK,
+                       .num_bit = ST_GYRO_1_PW_N_BIT,
+                       .value_on = ST_GYRO_DEFAULT_POWER_ON_VALUE,
+                       .value_off = ST_GYRO_DEFAULT_POWER_OFF_VALUE,
+               },
+               .enable_axis = {
+                       .addr = ST_GYRO_DEFAULT_AXIS_ADDR,
+                       .mask = ST_GYRO_DEFAULT_AXIS_MASK,
+               },
+               .fs = {
+                       .addr = ST_GYRO_1_FS_ADDR,
+                       .mask = ST_GYRO_1_FS_MASK,
+                       .num_bit = ST_GYRO_1_FS_N_BIT,
+                       .fs_avl = {
+                               [0] = {
+                                       .num = ST_GYRO_FS_AVL_250DPS,
+                                       .value = ST_GYRO_1_FS_AVL_250_VAL,
+                                       .gain = ST_GYRO_1_FS_AVL_250_GAIN,
+                               },
+                               [1] = {
+                                       .num = ST_GYRO_FS_AVL_500DPS,
+                                       .value = ST_GYRO_1_FS_AVL_500_VAL,
+                                       .gain = ST_GYRO_1_FS_AVL_500_GAIN,
+                               },
+                               [2] = {
+                                       .num = ST_GYRO_FS_AVL_2000DPS,
+                                       .value = ST_GYRO_1_FS_AVL_2000_VAL,
+                                       .gain = ST_GYRO_1_FS_AVL_2000_GAIN,
+                               },
+                       },
+               },
+               .bdu = {
+                       .addr = ST_GYRO_1_BDU_ADDR,
+                       .mask = ST_GYRO_1_BDU_MASK,
+               },
+               .drdy_irq = {
+                       .addr = ST_GYRO_1_DRDY_IRQ_ADDR,
+                       .mask = ST_GYRO_1_DRDY_IRQ_MASK,
+               },
+               .multi_read_bit = ST_GYRO_1_MULTIREAD_BIT,
+       },
+       {
+               .wai = ST_GYRO_2_WAI_EXP,
+               .ch = (struct iio_chan_spec *)st_gyro_16bit_channels,
+               .odr = {
+                       .addr = ST_GYRO_2_ODR_ADDR,
+                       .mask = ST_GYRO_2_ODR_MASK,
+                       .num_bit = ST_GYRO_2_ODR_N_BIT,
+                       .odr_avl = {
+                               { 95, ST_GYRO_2_ODR_AVL_95HZ_VAL, },
+                               { 190, ST_GYRO_2_ODR_AVL_190HZ_VAL, },
+                               { 380, ST_GYRO_2_ODR_AVL_380HZ_VAL, },
+                               { 760, ST_GYRO_2_ODR_AVL_760HZ_VAL, },
+                       },
+               },
+               .pw = {
+                       .addr = ST_GYRO_2_PW_ADDR,
+                       .mask = ST_GYRO_2_PW_MASK,
+                       .num_bit = ST_GYRO_2_PW_N_BIT,
+                       .value_on = ST_GYRO_DEFAULT_POWER_ON_VALUE,
+                       .value_off = ST_GYRO_DEFAULT_POWER_OFF_VALUE,
+               },
+               .enable_axis = {
+                       .addr = ST_GYRO_DEFAULT_AXIS_ADDR,
+                       .mask = ST_GYRO_DEFAULT_AXIS_MASK,
+               },
+               .fs = {
+                       .addr = ST_GYRO_2_FS_ADDR,
+                       .mask = ST_GYRO_2_FS_MASK,
+                       .num_bit = ST_GYRO_2_FS_N_BIT,
+                       .fs_avl = {
+                               [0] = {
+                                       .num = ST_GYRO_FS_AVL_250DPS,
+                                       .value = ST_GYRO_2_FS_AVL_250_VAL,
+                                       .gain = ST_GYRO_2_FS_AVL_250_GAIN,
+                               },
+                               [1] = {
+                                       .num = ST_GYRO_FS_AVL_500DPS,
+                                       .value = ST_GYRO_2_FS_AVL_500_VAL,
+                                       .gain = ST_GYRO_2_FS_AVL_500_GAIN,
+                               },
+                               [2] = {
+                                       .num = ST_GYRO_FS_AVL_2000DPS,
+                                       .value = ST_GYRO_2_FS_AVL_2000_VAL,
+                                       .gain = ST_GYRO_2_FS_AVL_2000_GAIN,
+                               },
+                       },
+               },
+               .bdu = {
+                       .addr = ST_GYRO_2_BDU_ADDR,
+                       .mask = ST_GYRO_2_BDU_MASK,
+               },
+               .drdy_irq = {
+                       .addr = ST_GYRO_2_DRDY_IRQ_ADDR,
+                       .mask = ST_GYRO_2_DRDY_IRQ_MASK,
+               },
+               .multi_read_bit = ST_GYRO_2_MULTIREAD_BIT,
+       },
+};
+
+static int st_gyro_write_data_with_mask(struct iio_dev *indio_dev, u8
reg_addr,
+                                               u8 mask, short num_bit, u8 data)
+{
+       int err;
+       u8 *prev_data;
+       u8 new_data;
+       struct st_gyro_data *gdata = iio_priv(indio_dev);
+
+       prev_data = kmalloc(sizeof(*prev_data), GFP_KERNEL);
+       if (prev_data == NULL) {
+               err = -ENOMEM;
+               goto st_gyro_write_data_with_mask_error;
+       }
+
+       err = gdata->read_byte(gdata, reg_addr, prev_data);
+       if (err < 0)
+               goto st_gyro_write_data_with_mask_error;
+
+       new_data = ((*prev_data & (~mask)) | ((data << __ffs(mask)) & mask));
+       err = gdata->write_byte(gdata, reg_addr, new_data);
+
+st_gyro_write_data_with_mask_error:
+       return err;
+}
+
+static int st_gyro_match_odr(const struct st_gyro_sensors *sensor,
+               unsigned int odr, struct st_gyro_odr_available *odr_out)
+{
+       int i, ret = -EINVAL;
+
+       for (i = 0; i < ARRAY_SIZE(sensor->odr.odr_avl); i++) {
+               if (sensor->odr.odr_avl[i].hz == odr) {
+                       odr_out->hz = sensor->odr.odr_avl[i].hz;
+                       odr_out->value = sensor->odr.odr_avl[i].value;
+                       ret = 0;
+                       break;
+               }
+       }
+
+       return ret;
+}
+
+static int st_gyro_match_fs(const struct st_gyro_sensors *sensor,
+               unsigned int fs, struct st_gyro_fullscale_available *fs_out)
+{
+       int i, ret = -EINVAL;
+
+       for (i = 0; i < ARRAY_SIZE(sensor->fs.fs_avl); i++) {
+               if (sensor->fs.fs_avl[i].num == fs) {
+                       fs_out->num = sensor->fs.fs_avl[i].num;
+                       fs_out->gain = sensor->fs.fs_avl[i].gain;
+                       fs_out->value = sensor->fs.fs_avl[i].value;
+                       ret = 0;
+                       break;
+               }
+       }
+
+       return ret;
+}
+
+static int st_gyro_match_scale(const struct st_gyro_sensors *sensor,
+                       int scale, struct st_gyro_fullscale_available *fs_out)
+{
+       int i, ret = -EINVAL;
+
+       for (i = 0; i < ARRAY_SIZE(sensor->fs.fs_avl); i++) {
+               if (sensor->fs.fs_avl[i].gain == scale) {
+                       fs_out->num = sensor->fs.fs_avl[i].num;
+                       fs_out->gain = sensor->fs.fs_avl[i].gain;
+                       fs_out->value = sensor->fs.fs_avl[i].value;
+                       ret = 0;
+                       break;
+               }
+       }
+
+       return ret;
+}
+
+int st_gyro_set_dataready_irq(struct iio_dev *indio_dev, bool enable)
+{
+       int err;
+       struct st_gyro_data *gdata;
+
+       gdata = iio_priv(indio_dev);
+       if (st_gyro_sensors[gdata->index].drdy_irq.ig1.en_addr > 0) {
+               err = st_gyro_write_data_with_mask(indio_dev,
+                       st_gyro_sensors[gdata->index].drdy_irq.ig1.en_addr,
+                       st_gyro_sensors[gdata->index].drdy_irq.ig1.en_mask, 1,
+                       (int)enable);
+               if (err < 0)
+                       goto st_gyro_set_dataready_irq_error;
+       }
+
+       if (st_gyro_sensors[gdata->index].drdy_irq.ig1.latch_mask_addr > 0) {
+               err = st_gyro_write_data_with_mask(indio_dev,
+               st_gyro_sensors[gdata->index].drdy_irq.ig1.latch_mask_addr,
+               st_gyro_sensors[gdata->index].drdy_irq.ig1.latching_mask, 1,
+                       (int)enable);
+               if (err < 0)
+                       goto st_gyro_set_dataready_irq_error;
+       }
+
+       err = st_gyro_write_data_with_mask(indio_dev,
+               st_gyro_sensors[gdata->index].drdy_irq.addr,
+               st_gyro_sensors[gdata->index].drdy_irq.mask, 1, (int)enable);
+
+st_gyro_set_dataready_irq_error:
+       return err;
+}
+EXPORT_SYMBOL(st_gyro_set_dataready_irq);
+
+static int st_gyro_set_bdu(struct iio_dev *indio_dev,
+                               const struct st_gyro_bdu *bdu, bool value)
+{
+       return st_gyro_write_data_with_mask(indio_dev, bdu->addr, bdu->mask,
+                                                               1, (u8)value);
+}
+
+static int st_gyro_set_odr(struct iio_dev *indio_dev,
+                               struct st_gyro_odr_available *odr_available)
+{
+       int err;
+       struct st_gyro_data *gdata = iio_priv(indio_dev);
+
+       if ((st_gyro_sensors[gdata->index].odr.addr ==
+               st_gyro_sensors[gdata->index].pw.addr) &&
+               (st_gyro_sensors[gdata->index].odr.mask ==
+                               st_gyro_sensors[gdata->index].pw.mask)) {
+               if (gdata->enabled == true) {
+                       err = st_gyro_write_data_with_mask(indio_dev,
+                               st_gyro_sensors[gdata->index].odr.addr,
+                               st_gyro_sensors[gdata->index].odr.mask,
+                               st_gyro_sensors[gdata->index].odr.num_bit,
+                               odr_available->value);
+               } else {
+                       gdata->odr = odr_available->hz;
+                       err = 0;
+               }
+       } else {
+               err = st_gyro_write_data_with_mask(indio_dev,
+                               st_gyro_sensors[gdata->index].odr.addr,
+                               st_gyro_sensors[gdata->index].odr.mask,
+                               st_gyro_sensors[gdata->index].odr.num_bit,
+                               odr_available->value);
+       }
+
+       return err;
+}
+
+int st_gyro_set_axis_enable(struct iio_dev *indio_dev, u8 axis_enable)
+{
+       int err;
+       struct st_gyro_data *gdata = iio_priv(indio_dev);
+
+       err = st_gyro_write_data_with_mask(indio_dev,
+                       st_gyro_sensors[gdata->index].enable_axis.addr,
+                       st_gyro_sensors[gdata->index].enable_axis.mask,
+                       ST_GYRO_DEFAULT_AXIS_N_BIT, axis_enable);
+
+       return err;
+}
+
+static int st_gyro_set_enable(struct iio_dev *indio_dev, bool enable)
+{
+       int err = -EINVAL;
+       bool found;
+       u8 tmp_value;
+       struct st_gyro_odr_available odr_out;
+       struct st_gyro_data *gdata = iio_priv(indio_dev);
+
+       if (enable) {
+               found = false;
+               tmp_value = st_gyro_sensors[gdata->index].pw.value_on;
+               if ((st_gyro_sensors[gdata->index].odr.addr ==
+                               st_gyro_sensors[gdata->index].pw.addr) &&
+                       (st_gyro_sensors[gdata->index].odr.mask ==
+                               st_gyro_sensors[gdata->index].pw.mask)) {
+                       err = st_gyro_match_odr(
+                               &st_gyro_sensors[gdata->index], gdata->odr,
+                                       &odr_out);
+                       if (err < 0)
+                               goto set_enable_error;
+                       tmp_value = odr_out.value;
+                       found = true;
+               }
+               err = st_gyro_write_data_with_mask(indio_dev,
+                               st_gyro_sensors[gdata->index].pw.addr,
+                               st_gyro_sensors[gdata->index].pw.mask,
+                               st_gyro_sensors[gdata->index].pw.num_bit,
+                               tmp_value);
+               if (err < 0)
+                       goto set_enable_error;
+               gdata->enabled = true;
+               if (found)
+                       gdata->odr = odr_out.hz;
+       } else {
+               err = st_gyro_write_data_with_mask(indio_dev,
+                               st_gyro_sensors[gdata->index].pw.addr,
+                               st_gyro_sensors[gdata->index].pw.mask,
+                               st_gyro_sensors[gdata->index].pw.num_bit,
+                               st_gyro_sensors[gdata->index].pw.value_off);
+               if (err < 0)
+                       goto set_enable_error;
+               gdata->enabled = false;
+       }
+
+set_enable_error:
+       return err;
+}
+
+static int st_gyro_set_fullscale(struct iio_dev *indio_dev,
+                               struct st_gyro_fullscale_available *fs_avl)
+{
+       int err;
+       struct st_gyro_data *gdata = iio_priv(indio_dev);
+
+       err = st_gyro_write_data_with_mask(indio_dev,
+                               st_gyro_sensors[gdata->index].fs.addr,
+                               st_gyro_sensors[gdata->index].fs.mask,
+                               st_gyro_sensors[gdata->index].fs.num_bit,
+                               fs_avl->value);
+       if (err < 0)
+               goto st_gyro_set_fullscale_error;
+
+       gdata->fullscale = fs_avl->num;
+       gdata->gain = fs_avl->gain;
+       return err;
+
+st_gyro_set_fullscale_error:
+       dev_err(&indio_dev->dev, "failed to set new fullscale.\n");
+       return err;
+}
+
+static int st_gyro_read_raw(struct iio_dev *indio_dev,
+                       struct iio_chan_spec const *ch, int *val,
+                                                       int *val2, long mask)
+{
+       int err;
+       u8 *outdata;
+       struct st_gyro_data *gdata = iio_priv(indio_dev);
+
+       switch (mask) {
+       case IIO_CHAN_INFO_RAW:
+               mutex_lock(&indio_dev->mlock);
+               if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
+                       err = -EBUSY;
+                       goto device_read_error;
+               } else {
+                       if (!gdata->enabled) {
+                               err = -EIO;
+                               goto device_read_error;
+                       } else {
+                               outdata = kmalloc(sizeof(*outdata*
+                                       ST_GYRO_BYTE_FOR_CHANNEL), GFP_KERNEL);
+                               if (outdata == NULL) {
+                                       err = -ENOMEM;
+                                       goto device_read_error;
+                               }
+
+                               err = gdata->read_multiple_byte(gdata,
+                                       ch->address, ST_GYRO_BYTE_FOR_CHANNEL,
+                                       outdata);
+                               if (err < 0)
+                                       goto read_error;
+
+                               *val = ((s16)le16_to_cpup((u16 *)outdata))
+                                                       >> ch->scan_type.shift;
+                       }
+               }
+               mutex_unlock(&indio_dev->mlock);
+               kfree(outdata);
+               return IIO_VAL_INT;
+       case IIO_CHAN_INFO_SCALE:
+               *val = 0;
+               *val2 = gdata->gain;
+               return IIO_VAL_INT_PLUS_MICRO;
+       default:
+               return -EINVAL;
+       }
+
+read_error:
+       kfree(outdata);
+device_read_error:
+       mutex_unlock(&indio_dev->mlock);
+       return err;
+}
+
+static int st_gyro_write_raw(struct iio_dev *indio_dev,
+               struct iio_chan_spec const *chan, int val, int val2, long mask)
+{
+       int err;
+       struct st_gyro_fullscale_available fs_out;
+       struct st_gyro_data *gdata = iio_priv(indio_dev);
+
+       switch (mask) {
+       case IIO_CHAN_INFO_SCALE:
+               err = st_gyro_match_scale(&st_gyro_sensors[gdata->index],
+                                                               val2, &fs_out);
+               if (err < 0)
+                       goto write_error;
+
+               err = st_gyro_set_fullscale(indio_dev, &fs_out);
+               break;
+       default:
+               err = -EINVAL;
+       }
+
+write_error:
+       return err;
+}
+
+static int st_gyro_check_device_list(struct iio_dev *indio_dev, u8 wai)
+{
+       int i;
+       struct st_gyro_data *gdata = iio_priv(indio_dev);
+
+       for (i = 0; i < ARRAY_SIZE(st_gyro_sensors); i++) {
+               if (st_gyro_sensors[i].wai == wai)
+                       break;
+       }
+       if (i == ARRAY_SIZE(st_gyro_sensors))
+               goto check_device_error;
+
+       gdata->index = i;
+
+       return i;
+
+check_device_error:
+       dev_err(&indio_dev->dev, "device not supported -> wai (0x%x).\n", wai);
+       return -ENODEV;
+}
+
+static int st_gyro_get_wai_device(struct iio_dev *indio_dev, u8 reg_addr,
+                                                               u8 *value)
+{
+       int ret;
+       struct st_gyro_data *gdata = iio_priv(indio_dev);
+
+       ret = gdata->read_byte(gdata, reg_addr, value);
+       if (ret < 0)
+               goto read_byte_wai_error;
+
+       return 0;
+
+read_byte_wai_error:
+       dev_err(&indio_dev->dev,
+                       "failed to read WhoAmI (register 0x%x).\n", reg_addr);
+       return -EIO;
+}
+
+static ssize_t st_gyro_sysfs_set_sampling_frequency(struct device *dev,
+               struct device_attribute *attr, const char *buf, size_t size)
+{
+       int err;
+       unsigned int freq;
+       struct st_gyro_odr_available odr_out;
+       struct iio_dev *indio_dev = dev_get_drvdata(dev);
+       struct st_gyro_data *gdata = iio_priv(indio_dev);
+
+       err = kstrtoint(buf, 10, &freq);
+       if (err < 0)
+               goto conversion_error;
+
+       mutex_lock(&indio_dev->mlock);
+       err = st_gyro_match_odr(&st_gyro_sensors[gdata->index],
+                                                               freq, &odr_out);
+       if (err < 0)
+               goto st_gyro_sysfs_set_sampling_frequency_error;
+
+       err = st_gyro_set_odr(indio_dev, &odr_out);
+       if (err < 0)
+               goto st_gyro_sysfs_set_sampling_frequency_error;
+
+       gdata->odr = odr_out.hz;
+
+st_gyro_sysfs_set_sampling_frequency_error:
+       mutex_unlock(&indio_dev->mlock);
+conversion_error:
+       return err < 0 ? err : size;
+}
+
+static ssize_t st_gyro_sysfs_get_sampling_frequency(struct device *dev,
+                               struct device_attribute *attr, char *buf)
+{
+       struct iio_dev *indio_dev = dev_get_drvdata(dev);
+       struct st_gyro_data *gdata = iio_priv(indio_dev);
+
+       return sprintf(buf, "%d\n", gdata->odr);
+}
+
+static ssize_t st_gyro_sysfs_set_powerdown(struct device *dev,
+               struct device_attribute *attr, const char *buf, size_t size)
+{
+       int err;
+       bool powerdown;
+       struct iio_dev *indio_dev = dev_get_drvdata(dev);
+
+       err = strtobool(buf, &powerdown);
+       if (err < 0)
+               goto set_enable_error;
+
+       mutex_lock(&indio_dev->mlock);
+       err = st_gyro_set_enable(indio_dev, !powerdown);
+       mutex_unlock(&indio_dev->mlock);
+
+set_enable_error:
+       return err < 0 ? err : size;
+}
+
+static ssize_t st_gyro_sysfs_get_powerdown(struct device *dev,
+                               struct device_attribute *attr, char *buf)
+{
+       struct iio_dev *indio_dev = dev_get_drvdata(dev);
+       struct st_gyro_data *gdata = iio_priv(indio_dev);
+
+       return sprintf(buf, "%d\n", (int)(!gdata->enabled));
+}
+
+static ssize_t st_gyro_sysfs_scale_available(struct device *dev,
+                               struct device_attribute *attr, char *buf)
+{
+       int i, len = 0;
+       struct iio_dev *indio_dev = dev_get_drvdata(dev);
+       struct st_gyro_data *gdata = iio_priv(indio_dev);
+
+       mutex_lock(&indio_dev->mlock);
+       for (i = 0; i < ARRAY_SIZE(st_gyro_sensors[gdata->index].fs.fs_avl);
+                                                                       i++) {
+               if (st_gyro_sensors[gdata->index].fs.fs_avl[i].num == 0)
+                       break;
+
+               len += sprintf(buf+len, "0.%06u ",
+                       st_gyro_sensors[gdata->index].fs.fs_avl[i].gain);
+       }
+       mutex_unlock(&indio_dev->mlock);
+       buf[len-1] = '\n';
+
+       return len;
+}
+
+static ssize_t st_gyro_sysfs_sampling_frequency_available(struct device
*dev,
+                               struct device_attribute *attr, char *buf)
+{
+       int i, len = 0;
+       struct iio_dev *indio_dev = dev_get_drvdata(dev);
+       struct st_gyro_data *gdata = iio_priv(indio_dev);
+
+       mutex_lock(&indio_dev->mlock);
+       for (i = 0; i < ARRAY_SIZE(st_gyro_sensors[gdata->index].odr.odr_avl);
+                                                                       i++) {
+               if (st_gyro_sensors[gdata->index].odr.odr_avl[i].hz == 0)
+                       break;
+
+               len += sprintf(buf + len, "%d ",
+                       st_gyro_sensors[gdata->index].odr.odr_avl[i].hz);
+       }
+       mutex_unlock(&indio_dev->mlock);
+       buf[len - 1] = '\n';
+
+       return len;
+}
+
+static IIO_DEVICE_ATTR(sampling_frequency_available, S_IRUGO,
+               st_gyro_sysfs_sampling_frequency_available, NULL , 0);
+
+static IIO_DEVICE_ATTR(in_anglvel_scale_available, S_IRUGO,
+                               st_gyro_sysfs_scale_available, NULL , 0);
+
+static IIO_DEVICE_ATTR(powerdown, S_IWUSR | S_IRUGO,
+               st_gyro_sysfs_get_powerdown, st_gyro_sysfs_set_powerdown , 0);
+
+static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
+                       st_gyro_sysfs_get_sampling_frequency,
+                                       st_gyro_sysfs_set_sampling_frequency);
+
+static struct attribute *st_gyro_attributes[] = {
+       &iio_dev_attr_sampling_frequency_available.dev_attr.attr,
+       &iio_dev_attr_in_anglvel_scale_available.dev_attr.attr,
+       &iio_dev_attr_powerdown.dev_attr.attr,
+       &iio_dev_attr_sampling_frequency.dev_attr.attr,
+       NULL,
+};
+
+static const struct attribute_group st_gyro_attribute_group = {
+       .attrs = st_gyro_attributes,
+};
+
+static const struct iio_info acc_info = {
+       .driver_module = THIS_MODULE,
+       .attrs = &st_gyro_attribute_group,
+       .read_raw = &st_gyro_read_raw,
+       .write_raw = &st_gyro_write_raw,
+};
+
+static int st_gyro_init_sensor(struct iio_dev *indio_dev)
+{
+       int err;
+       struct st_gyro_odr_available odr_out;
+       struct st_gyro_fullscale_available fs_out;
+       struct st_gyro_data *gdata = iio_priv(indio_dev);
+
+       err = st_gyro_set_enable(indio_dev, false);
+       if (err < 0)
+               goto init_error;
+
+       err = st_gyro_set_axis_enable(indio_dev, ST_GYRO_ENABLE_ALL_CHANNELS);
+       if (err < 0)
+               goto init_error;
+
+       st_gyro_match_fs(&st_gyro_sensors[gdata->index],
+                                               gdata->fullscale, &fs_out);
+       err = st_gyro_set_fullscale(indio_dev, &fs_out);
+       if (err < 0)
+               goto init_error;
+
+       st_gyro_match_odr(&st_gyro_sensors[gdata->index],
+                                                       gdata->odr, &odr_out);
+       err = st_gyro_set_odr(indio_dev, &odr_out);
+       if (err < 0)
+               goto init_error;
+
+       err = st_gyro_set_bdu(indio_dev,
+                               &st_gyro_sensors[gdata->index].bdu, true);
+
+init_error:
+       return err;
+}
+
+int st_gyro_iio_probe(struct iio_dev *indio_dev, int irq)
+{
+       int err;
+       u8 *wai;
+       struct st_gyro_data *gdata = iio_priv(indio_dev);
+
+       indio_dev->modes = INDIO_DIRECT_MODE;
+       indio_dev->info = &acc_info;
+
+       wai = kmalloc(sizeof(*wai), GFP_KERNEL);
+       if (wai == NULL) {
+               err = -ENOMEM;
+               goto st_gyro_iio_probe_error;
+       }
+
+       err = st_gyro_get_wai_device(indio_dev,
+                                       ST_GYRO_DEFAULT_WAI_ADDRESS, wai);
+       if (err < 0)
+               goto st_gyro_iio_probe_error;
+
+       err = st_gyro_check_device_list(indio_dev, *wai);
+       if (err < 0)
+               goto st_gyro_iio_probe_error;
+
+       gdata->multiread_bit = st_gyro_sensors[gdata->index].multi_read_bit;
+       indio_dev->channels = st_gyro_sensors[gdata->index].ch;
+       indio_dev->num_channels = ST_GYRO_NUMBER_ALL_CHANNELS;
+
+       gdata->fullscale = ST_GYRO_FS_AVL_2000DPS;
+       gdata->odr = 100;
+
+       err = st_gyro_init_sensor(indio_dev);
+       if (err < 0)
+               goto st_gyro_iio_probe_error;
+
+       err = st_gyro_allocate_ring(indio_dev);
+       if (err < 0)
+               goto st_gyro_iio_probe_error;
+
+       if (irq > 0) {
+               err = st_gyro_probe_trigger(indio_dev, irq);
+               if (err < 0)
+                       goto acc_probe_trigger_error;
+       }
+
+       err = iio_device_register(indio_dev);
+       if (err)
+               goto iio_device_register_error;
+
+       return err;
+
+iio_device_register_error:
+       st_gyro_remove_trigger(indio_dev, irq);
+acc_probe_trigger_error:
+       st_gyro_deallocate_ring(indio_dev);
+st_gyro_iio_probe_error:
+       return err;
+}
+EXPORT_SYMBOL(st_gyro_iio_probe);
+
+void st_gyro_iio_remove(struct iio_dev *indio_dev, int irq)
+{
+       iio_device_unregister(indio_dev);
+       st_gyro_remove_trigger(indio_dev, irq);
+       st_gyro_deallocate_ring(indio_dev);
+       iio_device_free(indio_dev);
+}
+EXPORT_SYMBOL(st_gyro_iio_remove);
+
+MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics gyroscopes driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
new file mode 100644
index 0000000..d63ab8e
--- /dev/null
+++ b/drivers/iio/gyro/st_gyro_i2c.c
@@ -0,0 +1,125 @@
+/*
+ * STMicroelectronics gyroscopes driver
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
+#include <linux/iio/gyro/st_gyro.h>
+
+#define ST_GYRO_I2C_MULTIREAD                  0x80
+
+static int st_gyro_i2c_read_byte(struct st_gyro_data *gdata,
+                                               u8 reg_addr, u8 *res_byte)
+{
+       int err;
+
+       err = i2c_smbus_read_byte_data(to_i2c_client(gdata->dev), reg_addr);
+       if (err < 0)
+               goto st_gyro_i2c_read_byte_error;
+
+       *res_byte = err & 0xff;
+
+st_gyro_i2c_read_byte_error:
+       return err < 0 ? err : 0;
+}
+
+static int st_gyro_i2c_read_multiple_byte(struct st_gyro_data *gdata,
+                                               u8 reg_addr, int len, u8 *data)
+{
+       if (gdata->multiread_bit == true)
+               reg_addr |= ST_GYRO_I2C_MULTIREAD;
+
+       return i2c_smbus_read_i2c_block_data(to_i2c_client(gdata->dev),
+                                                       reg_addr, len, data);
+}
+
+static int st_gyro_i2c_write_byte(struct st_gyro_data *gdata,
+                                                       u8 reg_addr, u8 data)
+{
+       return i2c_smbus_write_byte_data(to_i2c_client(gdata->dev),
+                                                               reg_addr, data);
+}
+
+static int __devinit st_gyro_i2c_probe(struct i2c_client *client,
+                                               const struct i2c_device_id *id)
+{
+       struct iio_dev *indio_dev;
+       struct st_gyro_data *gdata;
+       int err;
+
+       indio_dev = iio_device_alloc(sizeof(*gdata));
+       if (indio_dev == NULL) {
+               err = -ENOMEM;
+               goto iio_device_alloc_error;
+       }
+
+       gdata = iio_priv(indio_dev);
+       gdata->dev = &client->dev;
+       i2c_set_clientdata(client, indio_dev);
+
+       indio_dev->dev.parent = &client->dev;
+       indio_dev->name = client->name;
+
+       gdata->read_byte = st_gyro_i2c_read_byte;
+       gdata->write_byte = st_gyro_i2c_write_byte;
+       gdata->read_multiple_byte = st_gyro_i2c_read_multiple_byte;
+
+       err = st_gyro_iio_probe(indio_dev, client->irq);
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
+static int st_gyro_i2c_remove(struct i2c_client *client)
+{
+       struct iio_dev *indio_dev = i2c_get_clientdata(client);
+       st_gyro_iio_remove(indio_dev, client->irq);
+
+       return 0;
+}
+
+static const struct i2c_device_id st_gyro_id_table[] = {
+       { L3G4200D_GYRO_DEV_NAME },
+       { LSM330DL_GYRO_DEV_NAME },
+       { L3GD20_GYRO_DEV_NAME },
+       { L3GD20H_GYRO_DEV_NAME },
+       { LSM330D_GYRO_DEV_NAME },
+       { LSM330DLC_GYRO_DEV_NAME },
+       { LSM9DS0_GYRO_DEV_NAME },
+       { L3G4IS_GYRO_DEV_NAME },
+       { LSM330_GYRO_DEV_NAME },
+       {},
+};
+MODULE_DEVICE_TABLE(i2c, st_gyro_id_table);
+
+static struct i2c_driver st_gyro_driver = {
+       .driver = {
+               .owner = THIS_MODULE,
+               .name = "st-gyro-i2c",
+       },
+       .probe = st_gyro_i2c_probe,
+       .remove = st_gyro_i2c_remove,
+       .id_table = st_gyro_id_table,
+};
+module_i2c_driver(st_gyro_driver);
+
+MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics gyroscopes i2c driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/gyro/st_gyro_spi.c b/drivers/iio/gyro/st_gyro_spi.c
new file mode 100644
index 0000000..8823f35
--- /dev/null
+++ b/drivers/iio/gyro/st_gyro_spi.c
@@ -0,0 +1,179 @@
+/*
+ * STMicroelectronics gyroscopes driver
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
+#include <linux/iio/gyro/st_gyro.h>
+
+
+#define GYRO_SPI_READ          0x80;
+#define GYRO_SPI_MULTIREAD     0xc0
+
+static int st_gyro_spi_read(struct st_gyro_data *gdata,
+                                               u8 reg_addr, int len, u8 *data)
+{
+       struct spi_message msg;
+       int err;
+       u8 *tx;
+
+       struct spi_transfer xfers[] = {
+               {
+                       .bits_per_word = 8,
+                       .len = 1,
+               },
+               {
+                       .rx_buf = data,
+                       .bits_per_word = 8,
+                       .len = len,
+               }
+       };
+
+       tx = kmalloc(sizeof(*tx), GFP_KERNEL);
+       if (tx == NULL) {
+               err = -ENOMEM;
+               goto acc_spi_read_error;
+       }
+
+       if ((gdata->multiread_bit == true) && (len > 1))
+               *tx = reg_addr | GYRO_SPI_MULTIREAD;
+       else
+               *tx = reg_addr | GYRO_SPI_READ;
+
+       xfers[0].tx_buf = tx;
+       spi_message_init(&msg);
+       spi_message_add_tail(&xfers[0], &msg);
+       spi_message_add_tail(&xfers[1], &msg);
+       err = spi_sync(to_spi_device(gdata->dev), &msg);
+       if (err)
+               goto acc_spi_read_error;
+
+       return len;
+
+acc_spi_read_error:
+       return err;
+}
+
+static int st_gyro_spi_read_byte(struct st_gyro_data *gdata,
+                                               u8 reg_addr, u8 *res_byte)
+{
+       return st_gyro_spi_read(gdata, reg_addr, 1, res_byte);
+}
+
+static int st_gyro_spi_read_multiple_byte(struct st_gyro_data *gdata,
+                                               u8 reg_addr, int len, u8 *data)
+{
+       return st_gyro_spi_read(gdata, reg_addr, len, data);
+}
+
+static int st_gyro_spi_write_byte(struct st_gyro_data *gdata,
+                                                       u8 reg_addr, u8 data)
+{
+       struct spi_message msg;
+       int err;
+       u8 *tx;
+
+       struct spi_transfer xfers = {
+               .bits_per_word = 8,
+               .len = 2,
+       };
+
+       tx = kmalloc(sizeof(*tx)*2, GFP_KERNEL);
+       if (tx == NULL) {
+               err = -ENOMEM;
+               goto alloc_memory_error;
+       }
+
+       tx[0] = reg_addr;
+       tx[1] = data;
+       xfers.tx_buf = tx;
+       spi_message_init(&msg);
+       spi_message_add_tail(&xfers, &msg);
+       err = spi_sync(to_spi_device(gdata->dev), &msg);
+
+alloc_memory_error:
+       return err;
+}
+
+static int __devinit st_gyro_spi_probe(struct spi_device *spi)
+{
+       struct iio_dev *indio_dev;
+       struct st_gyro_data *gdata;
+       int err;
+
+       indio_dev = iio_device_alloc(sizeof(*gdata));
+       if (indio_dev == NULL) {
+               err = -ENOMEM;
+               goto iio_device_alloc_error;
+       }
+
+       gdata = iio_priv(indio_dev);
+       gdata->dev = &spi->dev;
+       spi_set_drvdata(spi, indio_dev);
+
+       indio_dev->dev.parent = &spi->dev;
+       indio_dev->name = spi->modalias;
+
+       gdata->read_byte = st_gyro_spi_read_byte;
+       gdata->write_byte = st_gyro_spi_write_byte;
+       gdata->read_multiple_byte = st_gyro_spi_read_multiple_byte;
+
+       err = st_gyro_iio_probe(indio_dev, spi->irq);
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
+static int st_gyro_spi_remove(struct spi_device *spi)
+{
+       struct iio_dev *indio_dev = spi_get_drvdata(spi);
+       st_gyro_iio_remove(indio_dev, spi->irq);
+
+       return 0;
+}
+
+static const struct spi_device_id st_gyro_id_table[] = {
+       { L3G4200D_GYRO_DEV_NAME },
+       { LSM330DL_GYRO_DEV_NAME },
+       { L3GD20_GYRO_DEV_NAME },
+       { L3GD20H_GYRO_DEV_NAME },
+       { LSM330D_GYRO_DEV_NAME },
+       { LSM330DLC_GYRO_DEV_NAME },
+       { LSM9DS0_GYRO_DEV_NAME },
+       { L3G4IS_GYRO_DEV_NAME },
+       { LSM330_GYRO_DEV_NAME },
+       {},
+};
+MODULE_DEVICE_TABLE(spi, st_gyro_id_table);
+
+static struct spi_driver st_gyro_driver = {
+       .driver = {
+               .owner = THIS_MODULE,
+               .name = "st-gyro-spi",
+       },
+       .probe = st_gyro_spi_probe,
+       .remove = st_gyro_spi_remove,
+       .id_table = st_gyro_id_table,
+};
+module_spi_driver(st_gyro_driver);
+
+MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics gyroscopes spi driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/gyro/st_gyro_trigger.c
b/drivers/iio/gyro/st_gyro_trigger.c
new file mode 100644
index 0000000..e072533
--- /dev/null
+++ b/drivers/iio/gyro/st_gyro_trigger.c
@@ -0,0 +1,83 @@
+/*
+ * STMicroelectronics gyroscopes driver
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
+#include <linux/iio/gyro/st_gyro.h>
+
+static int st_gyro_trig_acc_set_state(struct iio_trigger *trig, bool state)
+{
+       struct iio_dev *indio_dev = trig->private_data;
+       return st_gyro_set_dataready_irq(indio_dev, state);
+}
+
+static const struct iio_trigger_ops st_gyro_trigger_ops = {
+       .owner = THIS_MODULE,
+       .set_trigger_state = &st_gyro_trig_acc_set_state,
+};
+
+int st_gyro_probe_trigger(struct iio_dev *indio_dev, int irq)
+{
+       int err;
+       struct st_gyro_data *gdata = iio_priv(indio_dev);
+
+       gdata->trig = iio_trigger_alloc("%s-trigger", indio_dev->name);
+       if (gdata->trig == NULL) {
+               err = -ENOMEM;
+               dev_err(&indio_dev->dev, "failed to allocate iio trigger.\n");
+               goto iio_trigger_alloc_error;
+       }
+
+       err = request_threaded_irq(irq,
+                       iio_trigger_generic_data_rdy_poll,
+                       NULL,
+                       IRQF_TRIGGER_RISING,
+                       gdata->trig->name,
+                       gdata->trig);
+       if (err)
+               goto request_irq_error;
+
+       gdata->trig->private_data = indio_dev;
+       gdata->trig->ops = &st_gyro_trigger_ops;
+       gdata->trig->dev.parent = gdata->dev;
+
+       err = iio_trigger_register(gdata->trig);
+       if (err < 0) {
+               dev_err(&indio_dev->dev, "failed to register iio trigger.\n");
+               goto iio_trigger_register_error;
+       }
+       indio_dev->trig = gdata->trig;
+
+       return 0;
+
+iio_trigger_register_error:
+       free_irq(irq, gdata->trig);
+request_irq_error:
+       iio_trigger_free(gdata->trig);
+iio_trigger_alloc_error:
+       return err;
+}
+EXPORT_SYMBOL(st_gyro_probe_trigger);
+
+void st_gyro_remove_trigger(struct iio_dev *indio_dev, int irq)
+{
+       struct st_gyro_data *gdata = iio_priv(indio_dev);
+
+       iio_trigger_unregister(gdata->trig);
+       free_irq(irq, gdata->trig);
+       iio_trigger_free(gdata->trig);
+}
+EXPORT_SYMBOL(st_gyro_remove_trigger);
diff --git a/include/linux/iio/gyro/st_gyro.h
b/include/linux/iio/gyro/st_gyro.h
new file mode 100644
index 0000000..81dc86e
--- /dev/null
+++ b/include/linux/iio/gyro/st_gyro.h
@@ -0,0 +1,99 @@
+/*
+ * STMicroelectronics gyroscopes driver
+ *
+ * Copyright 2012 STMicroelectronics Inc.
+ *
+ * Denis Ciocca <denis.ciocca@st.com>
+ * v. 1.0.0
+ * Licensed under the GPL-2.
+ */
+
+#ifndef ST_GYRO_H
+#define ST_GYRO_H
+
+#define L3G4200D_GYRO_DEV_NAME         "l3g4200d"
+#define LSM330DL_GYRO_DEV_NAME         "lsm330dl_gyro"
+#define L3GD20_GYRO_DEV_NAME           "l3gd20"
+#define L3GD20H_GYRO_DEV_NAME          "l3gd20h"
+#define LSM330D_GYRO_DEV_NAME          "lsm330d_gyro"
+#define LSM330DLC_GYRO_DEV_NAME                "lsm330dlc_gyro"
+#define LSM9DS0_GYRO_DEV_NAME          "lsm9ds0_gyro"
+#define L3G4IS_GYRO_DEV_NAME           "l3g4is_ui"
+#define LSM330_GYRO_DEV_NAME           "lsm330_gyro"
+
+#define ST_GYRO_NUMBER_ALL_CHANNELS    4
+#define ST_GYRO_NUMBER_DATA_CHANNELS   3
+#define ST_GYRO_BYTE_FOR_CHANNEL       2
+#define ST_GYRO_SCAN_X                 0
+#define ST_GYRO_SCAN_Y                 1
+#define ST_GYRO_SCAN_Z                 2
+
+/**
+ * struct st_gyro_data - ST gyro device status
+ * @dev: Pointer to instance of struct device (I2C or SPI).
+ * @trig: The trigger in use by the core driver.
+ * @enabled: Status of the sensor (false->off, true->on).
+ * @multiread_bit: Use or not particular bit for [I2C/SPI] multiread.
+ * @index: Number used to point the sensor being used in the
+ *     st_gyro_sensors struct.
+ * @buffer_data: Data used by buffer part.
+ * @fullscale: Maximum range of measure by the sensor.
+ * @gain: Sensitivity of the sensor [m/s^2/LSB].
+ * @odr: Output data rate of the sensor [Hz].
+ * @read_byte: Function used to read one byte.
+ * @write_byte: Function used to write one byte.
+ * @read_multiple_byte: Function used to read multiple byte.
+ */
+
+struct st_gyro_data {
+       struct device *dev;
+       struct iio_trigger *trig;
+
+       bool enabled;
+       bool multiread_bit;
+
+       short index;
+
+       char *buffer_data;
+
+       unsigned int fullscale;
+       unsigned int gain;
+       unsigned int odr;
+
+       int (*read_byte) (struct st_gyro_data *gdata, u8 reg_addr,
+                                                               u8 *res_byte);
+       int (*write_byte) (struct st_gyro_data *gdata, u8 reg_addr, u8 data);
+       int (*read_multiple_byte) (struct st_gyro_data *gdata, u8 reg_addr,
+                                                       int len, u8 *data);
+};
+
+int st_gyro_iio_probe(struct iio_dev *indio_dev, int irq);
+void st_gyro_iio_remove(struct iio_dev *indio_dev, int irq);
+int st_gyro_set_dataready_irq(struct iio_dev *indio_dev, bool enable);
+int st_gyro_set_axis_enable(struct iio_dev *indio_dev, u8 axis_enable);
+
+#ifdef CONFIG_IIO_BUFFER
+int st_gyro_probe_trigger(struct iio_dev *indio_dev, int irq);
+void st_gyro_remove_trigger(struct iio_dev *indio_dev, int irq);
+int st_gyro_allocate_ring(struct iio_dev *indio_dev);
+void st_gyro_deallocate_ring(struct iio_dev *indio_dev);
+#else /* CONFIG_IIO_BUFFER */
+static inline int st_gyro_probe_trigger(struct iio_dev *indio_dev, int irq)
+{
+       return 0;
+}
+static inline void st_gyro_remove_trigger(struct iio_dev *indio_dev,
int irq)
+{
+       return;
+}
+static inline int st_gyro_allocate_ring(struct iio_dev *indio_dev)
+{
+       return 0;
+}
+static inline void st_gyro_deallocate_ring(struct iio_dev *indio_dev)
+{
+       return;
+}
+#endif /* CONFIG_IIO_BUFFER */
+
+#endif /* ST_GYRO_H */
--
1.7.0.4

