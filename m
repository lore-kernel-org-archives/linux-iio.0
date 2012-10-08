Return-Path: <denis.ciocca@st.com>
From: Denis CIOCCA <denis.ciocca@st.com>
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"burman.yan@gmail.com" <burman.yan@gmail.com>,
	"pavel@ucw.cz" <pavel@ucw.cz>
Date: Mon, 8 Oct 2012 17:39:37 +0200
Subject: STMicroelectronics accelerometers driver.
Message-ID: <5072F3B9.4050309@st.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi everybody,

I submit to you my linux device driver to support the latest ST
accelerometers. I want do submission to the linux community and I ask
you suggestions and proposals.
Thanks

Denis


 From c965b7f522d858a48e3bbcc723cb2ff4c00397f4 Mon Sep 17 00:00:00 2001
From: Denis Ciocca <denis.ciocca@st.com>
Date: Mon, 8 Oct 2012 17:04:32 +0200
Subject: [PATCH 1/2] add driver

---
  .../STMicroelectronics_accelerometers_iio_buffer.c |  155 ++
  .../STMicroelectronics_accelerometers_iio_core.c   | 1495
++++++++++++++++++++
  .../STMicroelectronics_accelerometers_iio_i2c.c    |  124 ++
  .../STMicroelectronics_accelerometers_iio_spi.c    |  209 +++
  ...STMicroelectronics_accelerometers_iio_trigger.c |   96 ++
  5 files changed, 2079 insertions(+), 0 deletions(-)
  create mode 100644
drivers/iio/accel/STMicroelectronics_accelerometers_iio_buffer.c
  create mode 100644
drivers/iio/accel/STMicroelectronics_accelerometers_iio_core.c
  create mode 100644
drivers/iio/accel/STMicroelectronics_accelerometers_iio_i2c.c
  create mode 100644
drivers/iio/accel/STMicroelectronics_accelerometers_iio_spi.c
  create mode 100644
drivers/iio/accel/STMicroelectronics_accelerometers_iio_trigger.c

diff --git
a/drivers/iio/accel/STMicroelectronics_accelerometers_iio_buffer.c
b/drivers/iio/accel/STMicroelectronics_accelerometers_iio_buffer.c
new file mode 100644
index 0000000..44e3f3d
--- /dev/null
+++ b/drivers/iio/accel/STMicroelectronics_accelerometers_iio_buffer.c
@@ -0,0 +1,155 @@
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
+#include <linux/byteorder/generic.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/kfifo_buf.h>
+#include <linux/iio/trigger_consumer.h>
+
+#include <linux/iio/acc/STMicroelectronics_accelerometers_iio.h>
+
+
+static int acc_read_all(struct iio_dev *indio_dev, u8 *rx_array)
+{
+       int len;
+       struct acc_data *adata =3D iio_priv(indio_dev);
+
+       len =3D adata->read_multiple_byte(adata,
+               indio_dev->channels[ACC_SCAN_X].address,
+               ACC_BYTE_FOR_CHANNEL*ACC_NUMBER_DATA_CHANNELS, rx_array);
+       if (len < 0)
+               goto read_error;
+
+       return len;
+
+read_error:
+       return -EIO;
+}
+
+static int acc_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
+{
+       int ret, i, n =3D 0;
+       u8 *rx_array;
+       u8 mask =3D 0x01;
+       s16 *data =3D (s16 *)buf;
+
+       rx_array =3D kzalloc(ACC_BYTE_FOR_CHANNEL*ACC_NUMBER_DATA_CHANNELS,
+                                                               GFP_KERNEL)=
;
+       if (rx_array =3D=3D NULL)
+               return -ENOMEM;
+       ret =3D acc_read_all(indio_dev, rx_array);
+       if (ret < 0)
+               return ret;
+       for (i =3D 0; i < ACC_NUMBER_DATA_CHANNELS; i++) {
+               if ((*indio_dev->active_scan_mask & mask) > 0) {
+                       if (indio_dev->channels[i].scan_type.endianness =3D=
=3D
+                                                               IIO_LE) {
+                               data[n] =3D (s16)(cpu_to_le16(le16_to_cpu((
+                               (__le16 *)rx_array)[i]))) >>
+                               indio_dev->channels[i].scan_type.shift;
+                               n++;
+                       } else {
+                               data[n] =3D (s16)(cpu_to_le16(be16_to_cpu((
+                               (__be16 *)rx_array)[i]))) >>
+                               indio_dev->channels[i].scan_type.shift;
+                               n++;
+                       }
+               }
+               mask =3D mask << 1;
+       }
+       kfree(rx_array);
+       return i*sizeof(data[0]);
+}
+
+static irqreturn_t acc_trigger_handler(int irq, void *p)
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
+               len =3D acc_get_buffer_element(indio_dev, data);
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
+static const struct iio_buffer_setup_ops acc_buf_setup_ops =3D {
+       .preenable =3D &iio_sw_buffer_preenable,
+       .postenable =3D &iio_triggered_buffer_postenable,
+       .predisable =3D &iio_triggered_buffer_predisable,
+};
+
+int acc_allocate_ring(struct iio_dev *indio_dev)
+{
+       int ret;
+       struct iio_buffer *buffer;
+       struct acc_data *adata =3D iio_priv(indio_dev);
+
+       buffer =3D iio_kfifo_allocate(indio_dev);
+       if (buffer =3D=3D NULL) {
+               ret =3D -ENOMEM;
+               goto acc_configure_ring_error;
+       }
+       indio_dev->buffer =3D buffer;
+       indio_dev->scan_timestamp =3D true;
+       indio_dev->buffer->scan_timestamp =3D true;
+       indio_dev->setup_ops =3D &acc_buf_setup_ops;
+       indio_dev->pollfunc =3D iio_alloc_pollfunc(
+                                               &iio_pollfunc_store_time,
+                                               &acc_trigger_handler,
+                                               IRQF_ONESHOT,
+                                               indio_dev,
+                                               "%s_consumer%d",
+                                               indio_dev->name,
+                                               indio_dev->id);
+       if (indio_dev->pollfunc =3D=3D NULL) {
+               ret =3D -ENOMEM;
+               goto iio_alloc_pollfunc_error;
+       }
+       indio_dev->modes |=3D INDIO_BUFFER_TRIGGERED;
+       ret =3D iio_buffer_register(indio_dev, indio_dev->channels,
+                                               ACC_NUMBER_ALL_CHANNELS);
+       if (ret < 0) {
+               pr_err("%s: iio_buffer_register failed.\n", adata->name);
+               goto iio_buffer_register_error;
+       }
+       pr_info("%s: allocate buffer -> done.\n", adata->name);
+       return 0;
+
+iio_buffer_register_error:
+iio_alloc_pollfunc_error:
+       iio_kfifo_free(buffer);
+acc_configure_ring_error:
+       return ret;
+}
+
+void acc_deallocate_ring(struct iio_dev *indio_dev)
+{
+       iio_dealloc_pollfunc(indio_dev->pollfunc);
+       iio_kfifo_free(indio_dev->buffer);
+       iio_buffer_unregister(indio_dev);
+}
diff --git
a/drivers/iio/accel/STMicroelectronics_accelerometers_iio_core.c
b/drivers/iio/accel/STMicroelectronics_accelerometers_iio_core.c
new file mode 100644
index 0000000..f9ccbf6
--- /dev/null
+++ b/drivers/iio/accel/STMicroelectronics_accelerometers_iio_core.c
@@ -0,0 +1,1495 @@
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
+#include <linux/iio/acc/STMicroelectronics_accelerometers_iio.h>
+
+
+#define FULLSCALE_AVAILABLE_MAX_NUMBER 5
+#define ODR_LIST_MAX_NUMBER            10
+#define X_AXIS                         0
+#define Y_AXIS                         1
+#define Z_AXIS                         2
+#define TIMESTAMP_AXIS                 3
+#define DATA_HIGH                      1
+#define DATA_LOW                       0
+#define POWER_ON                       1
+#define POWER_OFF                      0
+#define UG_TO_MS2                      9800
+#define OFFSET_1                       0x01
+
+/* DEFAULT VALUE FOR SENSORS */
+#define DEFAULT_WAI_ADDRESS            0x0f
+#define DEFAULT_ODR_ADDR               0x20
+#define DEFAULT_ODR_MASK               0xf0
+#define DEFAULT_ODR_N_BIT              4
+#define DEFAULT_ODR_AVL_1HZ            1
+#define DEFAULT_ODR_AVL_1HZ_VALUE      0x01
+#define DEFAULT_ODR_AVL_10HZ           10
+#define DEFAULT_ODR_AVL_10HZ_VALUE     0x02
+#define DEFAULT_ODR_AVL_25HZ           25
+#define DEFAULT_ODR_AVL_25HZ_VALUE     0x03
+#define DEFAULT_ODR_AVL_50HZ           50
+#define DEFAULT_ODR_AVL_50HZ_VALUE     0x04
+#define DEFAULT_ODR_AVL_100HZ          100
+#define DEFAULT_ODR_AVL_100HZ_VALUE    0x05
+#define DEFAULT_ODR_AVL_200HZ          200
+#define DEFAULT_ODR_AVL_200HZ_VALUE    0x06
+#define DEFAULT_ODR_AVL_400HZ          400
+#define DEFAULT_ODR_AVL_400HZ_VALUE    0x07
+#define DEFAULT_ODR_AVL_1600HZ         1600
+#define DEFAULT_ODR_AVL_1600HZ_VALUE   0x08
+#define DEFAULT_POWER_N_BIT            4
+#define DEFAULT_POWER_ADDR             DEFAULT_ODR_ADDR
+#define DEFAULT_POWER_MASK             DEFAULT_ODR_MASK
+#define DEFAULT_POWER_ON_VALUE         0x01
+#define DEFAULT_POWER_OFF_VALUE                0x00
+#define DEFAULT_FS_N_BIT               2
+#define DEFAULT_FS_ADDR                        0x23
+#define DEFAULT_FS_MASK                        0x30
+#define DEFAULT_FS_AVL_2_NUM           2
+#define DEFAULT_FS_AVL_2_VALUE         0x00
+#define DEFAULT_FS_AVL_2_GAIN          1000
+#define DEFAULT_FS_AVL_4_NUM           4
+#define DEFAULT_FS_AVL_4_VALUE         0x01
+#define DEFAULT_FS_AVL_4_GAIN          2000
+#define DEFAULT_FS_AVL_8_NUM           8
+#define DEFAULT_FS_AVL_8_VALUE         0x02
+#define DEFAULT_FS_AVL_8_GAIN          4000
+#define DEFAULT_FS_AVL_16_NUM          16
+#define DEFAULT_FS_AVL_16_VALUE                0x03
+#define DEFAULT_FS_AVL_16_GAIN         12000
+#define DEFAULT_OUT_X_H                        0x29
+#define DEFAULT_OUT_X_L                        0x28
+#define DEFAULT_OUT_Y_H                        0x2b
+#define DEFAULT_OUT_Y_L                        0x2a
+#define DEFAULT_OUT_Z_H                        0x2d
+#define DEFAULT_OUT_Z_L                        0x2c
+#define DEFAULT_REALBITS               12
+#define DEFAULT_DRDY_IRQ_ADDR          0x22
+#define DEFAULT_DRDY_IRQ_MASK          0x10
+#define DEFAULT_BDU_ADDR               0x23
+#define DEFAULT_BDU_MASK               0x80
+#define DEFAULT_MULTIREAD_BIT          1
+#define DEFAULT_IG1_EN_ADDR            0x22
+#define DEFAULT_IG1_EN_MASK            0x10
+#define DEFAULT_IG1_LATCHING_MASK_ADDR 0x24
+#define DEFAULT_IG1_LATCHING_MASK      0x08
+
+/* CUSTOM VALUES FOR SENSOR 1 */
+#define S1_WAI_EXP                     0x33
+
+/* CUSTOM VALUES FOR SENSOR 2 */
+#define S2_WAI_EXP                     0x49
+#define S2_ODR_AVL_3HZ                 3
+#define S2_ODR_AVL_3HZ_VALUE           0x01
+#define S2_ODR_AVL_6HZ                 6
+#define S2_ODR_AVL_6HZ_VALUE           0x02
+#define S2_ODR_AVL_12HZ                        12
+#define S2_ODR_AVL_12HZ_VALUE          0x03
+#define S2_ODR_AVL_800HZ               800
+#define S2_ODR_AVL_800HZ_VALUE         0x09
+#define S2_FS_N_BIT                    3
+#define S2_FS_ADDR                     0x21
+#define S2_FS_MASK                     0x38
+#define S2_FS_AVL_2_GAIN               61
+#define S2_FS_AVL_4_GAIN               122
+#define S2_FS_AVL_8_GAIN               244
+#define S2_FS_AVL_16_GAIN              732
+#define S2_FS_AVL_6_NUM                        6
+#define S2_FS_AVL_6_VALUE              0x02
+#define S2_FS_AVL_6_GAIN               183
+#define S2_REALBITS                    16
+#define S2_DRDY_IRQ_MASK               0x04
+#define S2_BDU_ADDR                    0x20
+#define S2_BDU_MASK                    0x08
+
+
+/* CUSTOM VALUES FOR SENSOR 3 */
+#define S3_WAI_EXP                     0x3a
+#define S3_ODR_MASK                    0x03
+#define S3_ODR_N_BIT                   2
+#define S3_ODR_AVL_40HZ                        40
+#define S3_ODR_AVL_40HZ_VALUE          0x00
+#define S3_ODR_AVL_160HZ               166
+#define S3_ODR_AVL_160HZ_VALUE         0x01
+#define S3_ODR_AVL_640HZ               640
+#define S3_ODR_AVL_640HZ_VALUE         0x02
+#define S3_ODR_AVL_2560HZ              2560
+#define S3_ODR_AVL_2560HZ_VALUE                0x30
+#define S3_POWER_N_BIT                 2
+#define S3_POWER_ADDR                  DEFAULT_ODR_ADDR
+#define S3_POWER_MASK                  0XC0
+#define S3_POWER_ON_VALUE              0x03
+#define S3_POWER_OFF_VALUE             0x00
+#define S3_FS_N_BIT                    1
+#define S3_FS_ADDR                     0x21
+#define S3_FS_MASK                     0x80
+#define S3_FS_AVL_2_NUM                        2
+#define S3_FS_AVL_2_VALUE              0x00
+#define S3_FS_AVL_2_GAIN               976
+#define S3_FS_AVL_6_NUM                        6
+#define S3_FS_AVL_6_VALUE              0x01
+#define S3_FS_AVL_6_GAIN               2941
+#define S3_DRDY_IRQ_ADDR               0x21
+#define S3_DRDY_IRQ_MASK               0x04
+#define S3_BDU_ADDR                    0x21
+#define S3_BDU_MASK                    0x40
+
+/* CUSTOM VALUES FOR SENSOR 4 */
+#define S4_WAI_EXP                     0x3c
+#define S4_ODR_MASK                    0x18
+#define S4_ODR_N_BIT                   2
+#define S4_ODR_AVL_50HZ_VALUE          0x01
+#define S4_ODR_AVL_100HZ_VALUE         0x02
+#define S4_ODR_AVL_400HZ_VALUE         0x03
+#define S4_ODR_AVL_1000HZ              1000
+#define S4_ODR_AVL_1000HZ_VALUE                0x03
+#define S4_POWER_N_BIT                 3
+#define S4_POWER_MASK                  0xe0
+#define S4_FS_AVL_2_NUM                        2
+#define S4_FS_AVL_2_VALUE              0x00
+#define S4_FS_AVL_2_GAIN               1000
+#define S4_FS_AVL_4_NUM                        4
+#define S4_FS_AVL_4_VALUE              0x01
+#define S4_FS_AVL_4_GAIN               2000
+#define S4_FS_AVL_8_NUM                        8
+#define S4_FS_AVL_8_VALUE              0x03
+#define S4_FS_AVL_8_GAIN               3900
+
+/* CUSTOM VALUES FOR SENSOR 5 */
+#define S5_WAI_EXP                     0x40
+#define S5_ODR_AVL_3HZ                 3
+#define S5_ODR_AVL_3HZ_VALUE           0x01
+#define S5_ODR_AVL_6HZ                 6
+#define S5_ODR_AVL_6HZ_VALUE           0x02
+#define S5_ODR_AVL_12HZ                        12
+#define S5_ODR_AVL_12HZ_VALUE          0x03
+#define S5_ODR_AVL_800HZ               800
+#define S5_ODR_AVL_800HZ_VALUE         0x09
+#define S5_FS_N_BIT                    3
+#define S5_FS_ADDR                     0x24
+#define S5_FS_MASK                     0x38
+#define S5_FS_AVL_2_GAIN               61
+#define S5_FS_AVL_4_GAIN               122
+#define S5_FS_AVL_6_NUM                        6
+#define S5_FS_AVL_6_VALUE              0x02
+#define S5_FS_AVL_6_GAIN               183
+#define S5_FS_AVL_8_GAIN               244
+#define S5_FS_AVL_16_GAIN              732
+#define S5_REALBITS                    16
+#define S5_DRDY_IRQ_ADDR               0x23
+#define S5_DRDY_IRQ_MASK               0x80
+#define S5_BDU_ADDR                    0x20
+#define S5_BDU_MASK                    0x08
+#define S5_MULTIREAD_BIT               0
+#define S5_IG1_EN_ADDR                 0x23
+#define S5_IG1_EN_MASK                 0x08
+#define S5_IG1_LATCHING_MASK_ADDR      0x23
+#define S5_IG1_LATCHING_MASK           0x20
+
+
+struct odr_available {
+       int hz;
+       u8 value;
+};
+
+struct odr {
+       u8 addr;
+       u8 mask;
+       short num_bit;
+       struct odr_available odr_avl[ODR_LIST_MAX_NUMBER];
+};
+
+struct power {
+       u8 addr;
+       u8 mask;
+       short num_bit;
+       u8 value_off;
+       u8 value_on;
+};
+
+struct fullscale_available {
+       int num;
+       u8 value;
+       int gain;
+};
+
+struct fullscale {
+       u8 addr;
+       u8 mask;
+       short num_bit;
+       struct fullscale_available fs_avl[FULLSCALE_AVAILABLE_MAX_NUMBER];
+};
+
+struct bdu {
+       u8 addr;
+       u8 mask;
+};
+
+struct data_out {
+       u8 addr[ACC_NUMBER_DATA_CHANNELS][2];
+       u8 bit;
+       struct bdu bdu;
+};
+
+struct interrupt_generator {
+       u8 en_addr;
+       u8 latching_mask_addr;
+       u8 en_mask;
+       u8 latching_mask;
+};
+
+struct data_ready_irq {
+       u8 addr;
+       u8 mask;
+       struct interrupt_generator ig1;
+};
+
+#define LSM_CHANNELS(index, mod, endian, bits, addr) \
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
+static const struct iio_chan_spec default_channels[] =3D {
+       LSM_CHANNELS(ACC_SCAN_X, IIO_MOD_X, IIO_LE,
+                                       DEFAULT_REALBITS, DEFAULT_OUT_X_L),
+       LSM_CHANNELS(ACC_SCAN_Y, IIO_MOD_Y, IIO_LE,
+                                       DEFAULT_REALBITS, DEFAULT_OUT_Y_L),
+       LSM_CHANNELS(ACC_SCAN_Z, IIO_MOD_Z, IIO_LE,
+                                       DEFAULT_REALBITS, DEFAULT_OUT_Z_L),
+       IIO_CHAN_SOFT_TIMESTAMP(3)
+};
+static const struct iio_chan_spec s2_channels[] =3D {
+       LSM_CHANNELS(ACC_SCAN_X, IIO_MOD_X, IIO_LE,
+                                       S2_REALBITS, DEFAULT_OUT_X_L),
+       LSM_CHANNELS(ACC_SCAN_Y, IIO_MOD_Y, IIO_LE,
+                                       S2_REALBITS, DEFAULT_OUT_Y_L),
+       LSM_CHANNELS(ACC_SCAN_Z, IIO_MOD_Z, IIO_LE,
+                                       S2_REALBITS, DEFAULT_OUT_Z_L),
+       IIO_CHAN_SOFT_TIMESTAMP(3)
+};
+static const struct iio_chan_spec s5_channels[] =3D {
+       LSM_CHANNELS(ACC_SCAN_X, IIO_MOD_X, IIO_LE,
+                                       S5_REALBITS, DEFAULT_OUT_X_L),
+       LSM_CHANNELS(ACC_SCAN_Y, IIO_MOD_Y, IIO_LE,
+                                       S5_REALBITS, DEFAULT_OUT_Y_L),
+       LSM_CHANNELS(ACC_SCAN_Z, IIO_MOD_Z, IIO_LE,
+                                       S5_REALBITS, DEFAULT_OUT_Z_L),
+       IIO_CHAN_SOFT_TIMESTAMP(3)
+};
+
+static struct sensor {
+       u8 wai;
+       struct odr odr;
+       struct power pw;
+       struct fullscale fs;
+       struct data_out data;
+       struct data_ready_irq drdy_irq;
+       struct iio_chan_spec *ch;
+} sensor[] =3D {
+       {
+       .wai =3D S1_WAI_EXP,
+       .ch =3D (struct iio_chan_spec *)default_channels,
+       },
+       {
+       .wai =3D S2_WAI_EXP,
+       .ch =3D (struct iio_chan_spec *)s2_channels,
+       .odr =3D {
+               .odr_avl[0] =3D {
+                       .hz =3D S2_ODR_AVL_3HZ,
+                       .value =3D S2_ODR_AVL_3HZ_VALUE,
+               },
+               .odr_avl[1] =3D {
+                       .hz =3D S2_ODR_AVL_6HZ,
+                       .value =3D S2_ODR_AVL_6HZ_VALUE,
+               },
+               .odr_avl[2] =3D {
+                       .hz =3D S2_ODR_AVL_12HZ,
+                       .value =3D S2_ODR_AVL_12HZ_VALUE,
+               },
+               .odr_avl[3] =3D {
+                       .hz =3D DEFAULT_ODR_AVL_25HZ,
+                       .value =3D DEFAULT_ODR_AVL_25HZ_VALUE + OFFSET_1,
+               },
+               .odr_avl[4] =3D {
+                       .hz =3D DEFAULT_ODR_AVL_50HZ,
+                       .value =3D DEFAULT_ODR_AVL_50HZ_VALUE + OFFSET_1,
+               },
+               .odr_avl[5] =3D {
+                       .hz =3D DEFAULT_ODR_AVL_100HZ,
+                       .value =3D DEFAULT_ODR_AVL_100HZ_VALUE + OFFSET_1,
+               },
+               .odr_avl[6] =3D {
+                       .hz =3D DEFAULT_ODR_AVL_200HZ,
+                       .value =3D DEFAULT_ODR_AVL_200HZ_VALUE + OFFSET_1,
+               },
+               .odr_avl[7] =3D {
+                       .hz =3D DEFAULT_ODR_AVL_400HZ,
+                       .value =3D DEFAULT_ODR_AVL_400HZ_VALUE + OFFSET_1,
+               },
+               .odr_avl[8] =3D {
+                       .hz =3D S2_ODR_AVL_800HZ,
+                       .value =3D S2_ODR_AVL_800HZ_VALUE,
+               },
+               .odr_avl[9] =3D {
+                       .hz =3D DEFAULT_ODR_AVL_1600HZ,
+                       .value =3D DEFAULT_ODR_AVL_1600HZ_VALUE + 2*OFFSET_=
1,
+               },
+       },
+       .fs =3D {
+               .addr =3D S3_FS_ADDR,
+               .mask =3D S3_FS_MASK,
+               .num_bit =3D S3_FS_N_BIT,
+               .fs_avl[0] =3D {
+                       .num =3D DEFAULT_FS_AVL_2_NUM,
+                       .value =3D DEFAULT_FS_AVL_2_VALUE,
+                       .gain =3D S2_FS_AVL_2_GAIN,
+               },
+               .fs_avl[1] =3D {
+                       .num =3D DEFAULT_FS_AVL_4_NUM,
+                       .value =3D DEFAULT_FS_AVL_4_VALUE,
+                       .gain =3D S2_FS_AVL_4_GAIN,
+               },
+               .fs_avl[2] =3D {
+                       .num =3D S2_FS_AVL_6_NUM,
+                       .value =3D S2_FS_AVL_6_VALUE,
+                       .gain =3D S2_FS_AVL_6_GAIN,
+               },
+               .fs_avl[3] =3D {
+                       .num =3D DEFAULT_FS_AVL_8_NUM,
+                       .value =3D DEFAULT_FS_AVL_8_VALUE + OFFSET_1,
+                       .gain =3D S2_FS_AVL_8_GAIN,
+               },
+               .fs_avl[4] =3D {
+                       .num =3D DEFAULT_FS_AVL_16_NUM,
+                       .value =3D DEFAULT_FS_AVL_16_VALUE + OFFSET_1,
+                       .gain =3D S2_FS_AVL_16_GAIN,
+               },
+       },
+       .drdy_irq =3D {
+               .mask =3D S2_DRDY_IRQ_MASK,
+       },
+       .data =3D {
+               .bdu =3D {
+                       .addr =3D S2_BDU_ADDR,
+                       .mask =3D S2_BDU_MASK,
+               },
+       },
+       },
+       {
+       .wai =3D S3_WAI_EXP,
+       .ch =3D (struct iio_chan_spec *)default_channels,
+       .odr =3D {
+               .mask =3D S3_ODR_MASK,
+               .num_bit =3D S3_ODR_N_BIT,
+               .odr_avl[0] =3D {
+                       .hz =3D S3_ODR_AVL_40HZ,
+                       .value =3D S3_ODR_AVL_40HZ_VALUE,
+               },
+               .odr_avl[1] =3D {
+                       .hz =3D S3_ODR_AVL_160HZ,
+                       .value =3D S3_ODR_AVL_160HZ_VALUE,
+               },
+               .odr_avl[2] =3D {
+                       .hz =3D S3_ODR_AVL_640HZ,
+                       .value =3D S3_ODR_AVL_640HZ_VALUE,
+               },
+               .odr_avl[3] =3D {
+                       .hz =3D S3_ODR_AVL_2560HZ,
+                       .value =3D S3_ODR_AVL_2560HZ_VALUE,
+               },
+       },
+       .pw =3D {
+               .addr =3D S3_POWER_ADDR,
+               .mask =3D S3_POWER_MASK,
+               .num_bit =3D S3_POWER_N_BIT,
+               .value_on =3D S3_POWER_ON_VALUE,
+               .value_off =3D S3_POWER_OFF_VALUE,
+       },
+       .fs =3D {
+               .addr =3D S2_FS_ADDR,
+               .mask =3D S2_FS_MASK,
+               .num_bit =3D S2_FS_N_BIT,
+               .fs_avl[0] =3D {
+                       .num =3D S3_FS_AVL_2_NUM,
+                       .value =3D S3_FS_AVL_2_VALUE,
+                       .gain =3D S3_FS_AVL_2_GAIN,
+               },
+               .fs_avl[1] =3D {
+                       .num =3D S3_FS_AVL_6_NUM,
+                       .value =3D S3_FS_AVL_6_VALUE,
+                       .gain =3D S3_FS_AVL_6_GAIN,
+               },
+       },
+       .drdy_irq =3D {
+               .addr =3D S3_DRDY_IRQ_ADDR,
+               .mask =3D S3_DRDY_IRQ_MASK,
+       },
+       .data =3D {
+               .bdu =3D {
+                       .addr =3D S3_BDU_ADDR,
+                       .mask =3D S3_BDU_MASK,
+               },
+       },
+       },
+       {
+       .wai =3D S4_WAI_EXP,
+       .ch =3D (struct iio_chan_spec *)default_channels,
+       .odr =3D {
+               .mask =3D S4_ODR_MASK,
+               .num_bit =3D S4_ODR_N_BIT,
+               .odr_avl[0] =3D {
+                       .hz =3D DEFAULT_ODR_AVL_50HZ,
+                       .value =3D S4_ODR_AVL_50HZ_VALUE,
+               },
+               .odr_avl[1] =3D {
+                       .hz =3D DEFAULT_ODR_AVL_100HZ,
+                       .value =3D S4_ODR_AVL_100HZ_VALUE,
+               },
+               .odr_avl[2] =3D {
+                       .hz =3D DEFAULT_ODR_AVL_400HZ,
+                       .value =3D S4_ODR_AVL_400HZ_VALUE,
+               },
+               .odr_avl[3] =3D {
+                       .hz =3D S4_ODR_AVL_1000HZ,
+                       .value =3D S4_ODR_AVL_1000HZ_VALUE,
+               },
+       },
+       .pw =3D {
+               .mask =3D S4_POWER_MASK,
+               .num_bit =3D S4_POWER_N_BIT,
+       },
+       .fs =3D {
+               .fs_avl[0] =3D {
+                       .num =3D S4_FS_AVL_2_NUM,
+                       .value =3D S4_FS_AVL_2_VALUE,
+                       .gain =3D S4_FS_AVL_2_GAIN,
+               },
+               .fs_avl[1] =3D {
+                       .num =3D S4_FS_AVL_4_NUM,
+                       .value =3D S4_FS_AVL_4_VALUE,
+                       .gain =3D S4_FS_AVL_4_GAIN,
+               },
+               .fs_avl[1] =3D {
+                       .num =3D S4_FS_AVL_8_NUM,
+                       .value =3D S4_FS_AVL_8_VALUE,
+                       .gain =3D S4_FS_AVL_8_GAIN,
+               },
+       },
+       },
+       {
+       .wai =3D S5_WAI_EXP,
+       .ch =3D (struct iio_chan_spec *)s5_channels,
+       .odr =3D {
+               .odr_avl[0] =3D {
+                       .hz =3D S5_ODR_AVL_3HZ,
+                       .value =3D S5_ODR_AVL_3HZ_VALUE,
+               },
+               .odr_avl[1] =3D {
+                       .hz =3D S5_ODR_AVL_6HZ,
+                       .value =3D S5_ODR_AVL_6HZ_VALUE,
+               },
+               .odr_avl[2] =3D {
+                       .hz =3D S5_ODR_AVL_12HZ,
+                       .value =3D S5_ODR_AVL_12HZ_VALUE,
+               },
+               .odr_avl[3] =3D {
+                       .hz =3D DEFAULT_ODR_AVL_25HZ,
+                       .value =3D DEFAULT_ODR_AVL_25HZ_VALUE + OFFSET_1,
+               },
+               .odr_avl[4] =3D {
+                       .hz =3D DEFAULT_ODR_AVL_50HZ,
+                       .value =3D DEFAULT_ODR_AVL_50HZ_VALUE + OFFSET_1,
+               },
+               .odr_avl[5] =3D {
+                       .hz =3D DEFAULT_ODR_AVL_100HZ,
+                       .value =3D DEFAULT_ODR_AVL_100HZ_VALUE + OFFSET_1,
+               },
+               .odr_avl[6] =3D {
+                       .hz =3D DEFAULT_ODR_AVL_400HZ,
+                       .value =3D DEFAULT_ODR_AVL_400HZ_VALUE,
+               },
+               .odr_avl[7] =3D {
+                       .hz =3D S5_ODR_AVL_800HZ,
+                       .value =3D S5_ODR_AVL_800HZ_VALUE - OFFSET_1,
+               },
+               .odr_avl[8] =3D {
+                       .hz =3D DEFAULT_ODR_AVL_1600HZ,
+                       .value =3D DEFAULT_ODR_AVL_1600HZ_VALUE + OFFSET_1,
+               },
+       },
+       .fs =3D {
+               .addr =3D S5_FS_ADDR,
+               .mask =3D S5_FS_MASK,
+               .num_bit =3D S5_FS_N_BIT,
+               .fs_avl[0] =3D {
+                       .num =3D DEFAULT_FS_AVL_2_NUM,
+                       .value =3D DEFAULT_FS_AVL_2_VALUE,
+                       .gain =3D S5_FS_AVL_2_GAIN,
+               },
+               .fs_avl[1] =3D {
+                       .num =3D DEFAULT_FS_AVL_4_NUM,
+                       .value =3D DEFAULT_FS_AVL_4_VALUE,
+                       .gain =3D S5_FS_AVL_4_GAIN,
+               },
+               .fs_avl[2] =3D {
+                       .num =3D S5_FS_AVL_6_NUM,
+                       .value =3D S5_FS_AVL_6_VALUE,
+                       .gain =3D S5_FS_AVL_6_GAIN,
+               },
+               .fs_avl[3] =3D {
+                       .num =3D DEFAULT_FS_AVL_8_NUM,
+                       .value =3D DEFAULT_FS_AVL_8_VALUE + OFFSET_1,
+                       .gain =3D S5_FS_AVL_8_GAIN,
+               },
+               .fs_avl[4] =3D {
+                       .num =3D DEFAULT_FS_AVL_16_NUM,
+                       .value =3D DEFAULT_FS_AVL_16_VALUE + OFFSET_1,
+                       .gain =3D S5_FS_AVL_16_GAIN,
+               },
+       },
+       .drdy_irq =3D {
+               .addr =3D S5_DRDY_IRQ_ADDR,
+               .mask =3D S5_DRDY_IRQ_MASK,
+               .ig1 =3D {
+                       .en_addr =3D S5_IG1_EN_ADDR,
+                       .en_mask =3D S5_IG1_EN_MASK,
+                       .latching_mask_addr =3D S5_IG1_LATCHING_MASK_ADDR,
+                       .latching_mask =3D S5_IG1_LATCHING_MASK,
+               },
+       },
+       .data =3D {
+               .bdu =3D {
+                       .addr =3D S5_BDU_ADDR,
+                       .mask =3D S5_BDU_MASK,
+               },
+       },
+       }
+};
+
+static struct acc_platform_data acc_default_pdata =3D {
+       .fullscale =3D DEFAULT_FS_AVL_2_NUM,
+       .sampling_frequency =3D DEFAULT_ODR_AVL_100HZ,
+};
+
+static int acc_write_data_with_mask(struct iio_dev *indio_dev, u8 reg_addr=
,
+                                               u8 mask, short num_bit, u8 =
data)
+{
+       int err, j, pos;
+       u8 prev_data;
+       u8 new_data;
+       struct acc_data *adata =3D iio_priv(indio_dev);
+
+       pos =3D 7;
+       for (j =3D 128; j >=3D 0; j =3D j/2) {
+               if (mask/j > 0)
+                       break;
+               else
+                       pos--;
+       }
+
+       prev_data =3D adata->read_byte(adata, reg_addr);
+       if (prev_data < 0)
+               goto i2c_write_data_with_mask_error;
+       prev_data &=3D 0xff;
+       new_data =3D ((prev_data & (~mask)) | ((data << (pos-num_bit+1)) & =
mask));
+       err =3D adata->write_byte(adata, reg_addr, new_data);
+       if (err)
+               goto i2c_write_data_with_mask_error;
+
+i2c_write_data_with_mask_error:
+       return err;
+}
+
+static int match_odr(struct sensor *sensor, int odr,
+                                               struct odr_available *odr_o=
ut)
+{
+       int n, i, ret =3D -1;
+
+       n =3D ARRAY_SIZE(sensor->odr.odr_avl);
+       for (i =3D 0; i < n; i++)
+               if (sensor->odr.odr_avl[i].hz =3D=3D odr) {
+                       odr_out->hz =3D sensor->odr.odr_avl[i].hz;
+                       odr_out->value =3D sensor->odr.odr_avl[i].value;
+                       ret =3D 0;
+                       break;
+               }
+
+       return ret;
+}
+
+static int match_fs(struct sensor *sensor, int fs,
+                                       struct fullscale_available *fs_out)
+{
+       int n, i, ret =3D -1;
+
+       n =3D ARRAY_SIZE(sensor->fs.fs_avl);
+       for (i =3D 0; i < n; i++)
+               if (sensor->fs.fs_avl[i].num =3D=3D fs) {
+                       fs_out->num =3D sensor->fs.fs_avl[i].num;
+                       fs_out->gain =3D sensor->fs.fs_avl[i].gain;
+                       fs_out->value =3D sensor->fs.fs_avl[i].value;
+                       ret =3D 0;
+                       break;
+               }
+
+       return ret;
+}
+
+int acc_set_dataready_irq(struct iio_dev *indio_dev, bool enable)
+{
+       int err;
+       struct acc_data *adata;
+
+       adata =3D iio_priv(indio_dev);
+       if (sensor[adata->index].drdy_irq.ig1.en_addr > 0) {
+               err =3D acc_write_data_with_mask(indio_dev,
+                       sensor[adata->index].drdy_irq.ig1.en_addr,
+                       sensor[adata->index].drdy_irq.ig1.en_mask, 1,
+                       (int)enable);
+               if (err < 0)
+                       goto acc_set_dataready_irq_error;
+       }
+
+       if (sensor[adata->index].drdy_irq.ig1.latching_mask_addr > 0) {
+               err =3D acc_write_data_with_mask(indio_dev,
+                       sensor[adata->index].drdy_irq.ig1.latching_mask_add=
r,
+                       sensor[adata->index].drdy_irq.ig1.latching_mask, 1,
+                       (int)enable);
+               if (err < 0)
+                       goto acc_set_dataready_irq_error;
+       }
+
+       err =3D acc_write_data_with_mask(indio_dev,
+                       sensor[adata->index].drdy_irq.addr,
+                       sensor[adata->index].drdy_irq.mask, 1, (int)enable)=
;
+       if (err < 0)
+               goto acc_set_dataready_irq_error;
+
+       return 0;
+
+acc_set_dataready_irq_error:
+       return -EIO;
+}
+
+static int set_bdu(struct iio_dev *indio_dev, struct bdu *bdu, u8 value)
+{
+       int err;
+
+       err =3D acc_write_data_with_mask(indio_dev,
+                                       bdu->addr,
+                                       bdu->mask,
+                                       1,
+                                       value);
+
+       return err;
+}
+
+static int set_odr(struct iio_dev *indio_dev,
+                                       struct odr_available *odr_available=
)
+{
+       int err;
+       struct acc_data *adata =3D iio_priv(indio_dev);
+
+       if ((sensor[adata->index].odr.addr =3D=3D sensor[adata->index].pw.a=
ddr) &&
+                       (sensor[adata->index].odr.mask =3D=3D
+                               sensor[adata->index].pw.mask)) {
+               if (atomic_read(&adata->enabled) =3D=3D POWER_ON) {
+                       err =3D acc_write_data_with_mask(indio_dev,
+                                       sensor[adata->index].odr.addr,
+                                       sensor[adata->index].odr.mask,
+                                       sensor[adata->index].odr.num_bit,
+                                       odr_available->value);
+                       if (err < 0)
+                               goto set_odr_error;
+               } else {
+                       adata->odr =3D odr_available->hz;
+                       err =3D 0;
+               }
+       } else {
+               err =3D acc_write_data_with_mask(indio_dev,
+                               sensor[adata->index].odr.addr,
+                               sensor[adata->index].odr.mask,
+                               sensor[adata->index].odr.num_bit,
+                               odr_available->value);
+               if (err < 0)
+                       goto set_odr_error;
+       }
+
+set_odr_error:
+       return err;
+}
+
+static int set_enable(struct iio_dev *indio_dev, int enable)
+{
+       int found, err;
+       u8 tmp_value;
+       struct odr_available *odr_out;
+       struct acc_data *adata =3D iio_priv(indio_dev);
+
+       odr_out =3D kzalloc(sizeof(*odr_out), GFP_KERNEL);
+       if (odr_out =3D=3D NULL) {
+               err =3D -ENOMEM;
+               goto odr_out_allocate_memory_error;
+       }
+
+       switch (enable) {
+       case POWER_ON:
+               found =3D 0;
+               tmp_value =3D sensor[adata->index].pw.value_on;
+               if ((sensor[adata->index].odr.addr =3D=3D
+                               sensor[adata->index].pw.addr) &&
+                       (sensor[adata->index].odr.mask =3D=3D
+                                       sensor[adata->index].pw.mask)) {
+                       err =3D match_odr(&sensor[adata->index],
+                                                       adata->odr, odr_out=
);
+                       if (err < 0)
+                               goto set_enable_error;
+                       tmp_value =3D odr_out->value;
+                       found =3D 1;
+               }
+               err =3D acc_write_data_with_mask(indio_dev,
+                               sensor[adata->index].pw.addr,
+                               sensor[adata->index].pw.mask,
+                               sensor[adata->index].pw.num_bit,
+                               tmp_value);
+               if (err < 0)
+                       goto set_enable_error;
+               atomic_set(&adata->enabled, POWER_ON);
+               if (found =3D=3D 1)
+                       adata->odr =3D odr_out->hz;
+               break;
+       case POWER_OFF:
+               err =3D acc_write_data_with_mask(indio_dev,
+                               sensor[adata->index].pw.addr,
+                               sensor[adata->index].pw.mask,
+                               sensor[adata->index].pw.num_bit,
+                               sensor[adata->index].pw.value_off);
+               if (err < 0)
+                       goto set_enable_error;
+               atomic_set(&adata->enabled, POWER_OFF);
+               break;
+       default:
+               err =3D -1;
+               goto set_enable_error;
+       }
+
+set_enable_error:
+       kfree(odr_out);
+odr_out_allocate_memory_error:
+       return err;
+}
+
+static int set_fullscale(struct iio_dev *indio_dev,
+                                       struct fullscale_available *fs_avl)
+{
+       int err;
+       struct acc_data *adata =3D iio_priv(indio_dev);
+
+       err =3D acc_write_data_with_mask(indio_dev,
+                               sensor[adata->index].fs.addr,
+                               sensor[adata->index].fs.mask,
+                               sensor[adata->index].fs.num_bit,
+                               fs_avl->value);
+       if (err < 0)
+               goto set_fullscale_error;
+       adata->fullscale =3D fs_avl->num;
+       adata->gain =3D fs_avl->gain;
+       return err;
+
+set_fullscale_error:
+       pr_err("%s: failed to set new fullscale.\n", adata->name);
+       return err;
+}
+
+static int acc_read_raw(struct iio_dev *indio_dev,
+                       struct iio_chan_spec const *ch, int *val,
+                                                       int *val2, long mas=
k)
+{
+       int err;
+       int data_tmp;
+       u8 outdata[ACC_BYTE_FOR_CHANNEL];
+       struct acc_data *adata =3D iio_priv(indio_dev);
+
+       switch (mask) {
+       case IIO_CHAN_INFO_RAW:
+               if (indio_dev->currentmode =3D=3D INDIO_BUFFER_TRIGGERED) {
+                       err =3D -EBUSY;
+               } else {
+                       err =3D atomic_read(&adata->enabled);
+                       if (!err) {
+                               err =3D -EHOSTDOWN;
+                       } else {
+                               err =3D adata->read_multiple_byte(adata,
+                                       ch->address, ACC_BYTE_FOR_CHANNEL,
+                                       outdata);
+                               if (err < 0)
+                                       goto read_error;
+
+                               if (ch->scan_type.endianness =3D=3D IIO_LE)
+                                       *val =3D (s32)(s16)(cpu_to_le16(
+                                       le16_to_cpu(((__le16 *)outdata)[0])=
))
+                                       >> ch->scan_type.shift;
+                               else
+                                       *val =3D (s32)(s16)(cpu_to_le16(
+                                       be16_to_cpu(((__be16 *)outdata)[0])=
))
+                                       >> ch->scan_type.shift;
+                       }
+               }
+               return IIO_VAL_INT;
+       case IIO_CHAN_INFO_SCALE:
+               data_tmp =3D adata->gain*UG_TO_MS2;
+               *val =3D 0;
+               *val2 =3D data_tmp;
+               return IIO_VAL_INT_PLUS_NANO;
+       default:
+               return -EINVAL;
+       }
+
+read_error:
+       pr_err("%s: failed to read i2c raw data!\n", adata->name);
+       return err;
+}
+
+static int acc_check_irq(struct iio_dev *indio_dev)
+{
+       int err;
+       struct acc_data *adata =3D iio_priv(indio_dev);
+
+       if (adata->irq_data_ready <=3D 0)
+               err =3D -EINVAL;
+       else
+               err =3D 0;
+
+       return err;
+}
+
+static void register_channels(struct iio_dev *indio_dev)
+{
+       struct acc_data *adata =3D iio_priv(indio_dev);
+
+       indio_dev->channels =3D sensor[adata->index].ch;
+       indio_dev->num_channels =3D ACC_NUMBER_ALL_CHANNELS;
+}
+
+static int validate_platform_data(struct iio_dev *indio_dev)
+{
+       int err;
+       struct odr_available *odr_out;
+       struct fullscale_available *fs_out;
+       struct acc_data *adata =3D iio_priv(indio_dev);
+
+       odr_out =3D kzalloc(sizeof(*odr_out), GFP_KERNEL);
+       if (odr_out =3D=3D NULL) {
+               err =3D -ENOMEM;
+               goto odr_out_allocate_memory_error;
+       }
+       fs_out =3D kzalloc(sizeof(*fs_out), GFP_KERNEL);
+       if (fs_out =3D=3D NULL) {
+               err =3D -ENOMEM;
+               goto fs_out_allocate_memory_error;
+       }
+       err =3D match_fs(&sensor[adata->index], adata->pdata->fullscale, fs=
_out);
+       if (err < 0) {
+               pr_err("%s: validate fullscale pdata failed!\n", adata->nam=
e);
+               goto validate_fullscale_error;
+       }
+       err =3D match_odr(&sensor[adata->index],
+                               adata->pdata->sampling_frequency, odr_out);
+       if (err < 0) {
+               pr_err("%s: validate sampling frequency pdata failed!\n",
+                                                               adata->name=
);
+               goto validate_sampling_error;
+       }
+       return err;
+
+validate_sampling_error:
+validate_fullscale_error:
+       kfree(fs_out);
+fs_out_allocate_memory_error:
+       kfree(odr_out);
+odr_out_allocate_memory_error:
+       return err;
+}
+
+static int set_platform_data(struct iio_dev *indio_dev)
+{
+       int err;
+       struct acc_data *adata;
+
+       adata =3D iio_priv(indio_dev);
+       adata->pdata =3D kmalloc(sizeof(struct acc_platform_data), GFP_KERN=
EL);
+       if (adata->pdata =3D=3D NULL) {
+               pr_err("%s: failed to allocate memory for pdata.\n",
+                                                               adata->name=
);
+               err =3D -ENOMEM;
+               goto pdata_malloc_error;
+       }
+       if (adata->client =3D=3D NULL) {
+               if (adata->spi->dev.platform_data !=3D NULL) {
+                       memcpy(adata->pdata, adata->spi->dev.platform_data,
+                                       sizeof(struct acc_platform_data));
+               } else {
+                       memcpy(adata->pdata, &acc_default_pdata,
+                                       sizeof(struct acc_platform_data));
+               }
+       } else if (adata->spi =3D=3D NULL) {
+               if (adata->client->dev.platform_data !=3D NULL) {
+                       memcpy(adata->pdata, adata->client->dev.platform_da=
ta,
+                                       sizeof(struct acc_platform_data));
+               } else {
+                       memcpy(adata->pdata, &acc_default_pdata,
+                                       sizeof(struct acc_platform_data));
+               }
+       }
+       return 0;
+
+pdata_malloc_error:
+       return err;
+}
+
+static void set_sensor_parameters(struct iio_dev *indio_dev)
+{
+       struct acc_data *adata;
+
+       adata =3D iio_priv(indio_dev);
+       if (!sensor[adata->index].odr.addr)
+               sensor[adata->index].odr.addr =3D DEFAULT_ODR_ADDR;
+       if (!sensor[adata->index].odr.mask)
+               sensor[adata->index].odr.mask =3D DEFAULT_ODR_MASK;
+       if (!sensor[adata->index].odr.num_bit)
+                       sensor[adata->index].odr.num_bit =3D DEFAULT_ODR_N_=
BIT;
+       if (!sensor[adata->index].pw.addr)
+               sensor[adata->index].pw.addr =3D DEFAULT_POWER_ADDR;
+       if (!sensor[adata->index].pw.mask)
+               sensor[adata->index].pw.mask =3D DEFAULT_POWER_MASK;
+       if (!sensor[adata->index].pw.num_bit)
+                       sensor[adata->index].pw.num_bit =3D DEFAULT_POWER_N=
_BIT;
+       if (!sensor[adata->index].pw.value_off)
+               sensor[adata->index].pw.value_off =3D DEFAULT_POWER_OFF_VAL=
UE;
+       if (!sensor[adata->index].pw.value_on)
+               sensor[adata->index].pw.value_on =3D DEFAULT_POWER_ON_VALUE=
;
+       if (!sensor[adata->index].odr.odr_avl[0].hz) {
+               sensor[adata->index].odr.odr_avl[0].hz =3D DEFAULT_ODR_AVL_=
1HZ;
+               sensor[adata->index].odr.odr_avl[0].value =3D
+                                               DEFAULT_ODR_AVL_1HZ_VALUE;
+               sensor[adata->index].odr.odr_avl[1].hz =3D DEFAULT_ODR_AVL_=
10HZ;
+               sensor[adata->index].odr.odr_avl[1].value =3D
+                                               DEFAULT_ODR_AVL_10HZ_VALUE;
+               sensor[adata->index].odr.odr_avl[2].hz =3D DEFAULT_ODR_AVL_=
25HZ;
+               sensor[adata->index].odr.odr_avl[2].value =3D
+                                               DEFAULT_ODR_AVL_25HZ_VALUE;
+               sensor[adata->index].odr.odr_avl[3].hz =3D DEFAULT_ODR_AVL_=
50HZ;
+               sensor[adata->index].odr.odr_avl[3].value =3D
+                                               DEFAULT_ODR_AVL_50HZ_VALUE;
+               sensor[adata->index].odr.odr_avl[4].hz =3D
+                                               DEFAULT_ODR_AVL_100HZ;
+               sensor[adata->index].odr.odr_avl[4].value =3D
+                                               DEFAULT_ODR_AVL_100HZ_VALUE=
;
+               sensor[adata->index].odr.odr_avl[5].hz =3D
+                                               DEFAULT_ODR_AVL_200HZ;
+               sensor[adata->index].odr.odr_avl[5].value =3D
+                                               DEFAULT_ODR_AVL_200HZ_VALUE=
;
+               sensor[adata->index].odr.odr_avl[6].hz =3D
+                                               DEFAULT_ODR_AVL_400HZ;
+               sensor[adata->index].odr.odr_avl[6].value =3D
+                                               DEFAULT_ODR_AVL_400HZ_VALUE=
;
+               sensor[adata->index].odr.odr_avl[7].hz =3D
+                                               DEFAULT_ODR_AVL_1600HZ;
+               sensor[adata->index].odr.odr_avl[7].value =3D
+                                               DEFAULT_ODR_AVL_1600HZ_VALU=
E;
+       }
+       if (!sensor[adata->index].fs.addr)
+               sensor[adata->index].fs.addr =3D DEFAULT_FS_ADDR;
+       if (!sensor[adata->index].fs.mask)
+               sensor[adata->index].fs.mask =3D DEFAULT_FS_MASK;
+       if (!sensor[adata->index].fs.num_bit)
+               sensor[adata->index].fs.num_bit =3D DEFAULT_FS_N_BIT;
+       if (!sensor[adata->index].fs.fs_avl[0].num) {
+               sensor[adata->index].fs.fs_avl[0].num =3D DEFAULT_FS_AVL_2_=
NUM;
+               sensor[adata->index].fs.fs_avl[0].value =3D
+                                               DEFAULT_FS_AVL_2_VALUE;
+               sensor[adata->index].fs.fs_avl[0].gain =3D
+                                               DEFAULT_FS_AVL_2_GAIN;
+               sensor[adata->index].fs.fs_avl[1].num =3D DEFAULT_FS_AVL_4_=
NUM;
+               sensor[adata->index].fs.fs_avl[1].value =3D
+                                               DEFAULT_FS_AVL_4_VALUE;
+               sensor[adata->index].fs.fs_avl[1].gain =3D
+                                               DEFAULT_FS_AVL_4_GAIN;
+               sensor[adata->index].fs.fs_avl[2].num =3D DEFAULT_FS_AVL_8_=
NUM;
+               sensor[adata->index].fs.fs_avl[2].value =3D
+                                               DEFAULT_FS_AVL_8_VALUE;
+               sensor[adata->index].fs.fs_avl[2].gain =3D
+                                               DEFAULT_FS_AVL_8_GAIN;
+               sensor[adata->index].fs.fs_avl[3].num =3D DEFAULT_FS_AVL_16=
_NUM;
+               sensor[adata->index].fs.fs_avl[3].value =3D
+                                               DEFAULT_FS_AVL_16_VALUE;
+               sensor[adata->index].fs.fs_avl[3].gain =3D
+                                               DEFAULT_FS_AVL_16_GAIN;
+       }
+       if (!sensor[adata->index].data.addr[X_AXIS][DATA_LOW])
+               sensor[adata->index].data.addr[X_AXIS][DATA_LOW] =3D
+                                                       (DEFAULT_OUT_X_L);
+       if (!sensor[adata->index].data.addr[X_AXIS][DATA_HIGH])
+               sensor[adata->index].data.addr[X_AXIS][DATA_HIGH] =3D
+                                                       DEFAULT_OUT_X_H;
+       if (!sensor[adata->index].data.addr[Y_AXIS][DATA_LOW])
+               sensor[adata->index].data.addr[Y_AXIS][DATA_LOW] =3D
+                                                       (DEFAULT_OUT_Y_L);
+       if (!sensor[adata->index].data.addr[Y_AXIS][DATA_HIGH])
+               sensor[adata->index].data.addr[Y_AXIS][DATA_HIGH] =3D
+                                                       DEFAULT_OUT_Y_H;
+       if (!sensor[adata->index].data.addr[Z_AXIS][DATA_LOW])
+               sensor[adata->index].data.addr[Z_AXIS][DATA_LOW] =3D
+                                                       (DEFAULT_OUT_Z_L);
+       if (!sensor[adata->index].data.addr[Z_AXIS][DATA_HIGH])
+               sensor[adata->index].data.addr[Z_AXIS][DATA_HIGH] =3D
+                                                       DEFAULT_OUT_Z_H;
+       if (!sensor[adata->index].drdy_irq.addr)
+               sensor[adata->index].drdy_irq.addr =3D DEFAULT_DRDY_IRQ_ADD=
R;
+       if (!sensor[adata->index].drdy_irq.mask)
+               sensor[adata->index].drdy_irq.mask =3D DEFAULT_DRDY_IRQ_MAS=
K;
+       if (!sensor[adata->index].data.bdu.addr)
+               sensor[adata->index].data.bdu.addr =3D DEFAULT_BDU_ADDR;
+       if (!sensor[adata->index].data.bdu.mask)
+               sensor[adata->index].data.bdu.mask =3D DEFAULT_BDU_MASK;
+       if (!sensor[adata->index].drdy_irq.ig1.en_addr)
+               sensor[adata->index].drdy_irq.ig1.en_addr =3D DEFAULT_IG1_E=
N_ADDR;
+       if (!sensor[adata->index].drdy_irq.ig1.en_mask)
+               sensor[adata->index].drdy_irq.ig1.en_mask =3D DEFAULT_IG1_E=
N_MASK;
+       if (!sensor[adata->index].drdy_irq.ig1.latching_mask_addr)
+               sensor[adata->index].drdy_irq.ig1.latching_mask_addr =3D
+                                               DEFAULT_IG1_LATCHING_MASK_A=
DDR;
+       if (!sensor[adata->index].drdy_irq.ig1.latching_mask)
+               sensor[adata->index].drdy_irq.ig1.latching_mask =3D
+                                               DEFAULT_IG1_LATCHING_MASK;
+}
+
+static int check_device_list(struct iio_dev *indio_dev, u8 wai)
+{
+       int i, sensor_length, found;
+       struct acc_data *adata;
+
+       adata =3D iio_priv(indio_dev);
+       found =3D 0;
+       sensor_length =3D ARRAY_SIZE(sensor);
+       for (i =3D 0; i < sensor_length; i++) {
+               if (sensor[i].wai =3D=3D wai) {
+                       found =3D 1;
+                       break;
+               }
+       }
+       if (found !=3D 1)
+               goto check_device_error;
+       adata->index =3D i;
+       return i;
+
+check_device_error:
+       pr_err("%s: device not supported -> wai (0x%x).\n", adata->name, wa=
i);
+       return -ENODEV;
+}
+
+static int get_wai_device(struct iio_dev *indio_dev, u8 reg_addr, u8
*value)
+{
+       int ret;
+       u8 buf;
+       struct acc_data *adata;
+
+       adata =3D iio_priv(indio_dev);
+       buf =3D reg_addr;
+       ret =3D adata->read_byte(adata, reg_addr);
+       if (ret < 0)
+               goto read_byte_wai_error;
+       *value =3D ret;
+       return (int)ret;
+
+read_byte_wai_error:
+       pr_err("%s: failed to read wai register (0x%x).\n",
+                                                       adata->name, reg_ad=
dr);
+       return -1;
+}
+
+static ssize_t sysfs_set_sampling_frequency(struct device *dev,
+               struct device_attribute *attr, const char *buf, size_t size=
)
+{
+       int err;
+       unsigned long freq;
+       struct odr_available *odr_out;
+       struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+       struct acc_data *adata =3D iio_priv(indio_dev);
+
+       err =3D kstrtoul(buf, 10, &freq);
+       if (err) {
+               pr_err("%s: input is not a number! (errn %d).\n",
+                                                       adata->name, err);
+               goto sysfs_set_sampling_frequency_error;
+       }
+
+       mutex_lock(&indio_dev->mlock);
+       odr_out =3D kzalloc(sizeof(*odr_out), GFP_KERNEL);
+       if (odr_out =3D=3D NULL)
+               goto odr_out_allocate_memory_error;
+
+       err =3D match_odr(&sensor[adata->index], (int)freq, odr_out);
+       if (err < 0)
+               goto sysfs_set_sampling_frequency_error;
+       err =3D set_odr(indio_dev, odr_out);
+       if (err < 0) {
+               pr_err("%s: failed to set sampling frequency to %d.\n",
+                                                       adata->name, (int)f=
req);
+               goto sysfs_set_sampling_frequency_error;
+       }
+       adata->odr =3D odr_out->hz;
+       kfree(odr_out);
+
+odr_out_allocate_memory_error:
+       mutex_unlock(&indio_dev->mlock);
+sysfs_set_sampling_frequency_error:
+       return size;
+}
+
+static ssize_t sysfs_get_sampling_frequency(struct device *dev,
+                               struct device_attribute *attr, char *buf)
+{
+       ssize_t ret;
+       struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+       struct acc_data *adata =3D iio_priv(indio_dev);
+
+       ret =3D sprintf(buf, "%d\n", adata->odr);
+
+       return ret;
+}
+
+static ssize_t sysfs_set_enable(struct device *dev,
+               struct device_attribute *attr, const char *buf, size_t size=
)
+{
+       int err;
+       unsigned long en;
+       struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+       struct acc_data *adata =3D iio_priv(indio_dev);
+
+       err =3D kstrtoul(buf, 10, &en);
+       if (err) {
+               pr_err("%s: input is not a number! (errn %d).\n",
+                                                       adata->name, err);
+               goto set_enable_error;
+       }
+
+       mutex_lock(&indio_dev->mlock);
+       err =3D set_enable(indio_dev, (int)en);
+       if (err < 0)
+               pr_err("%s: failed to set enable to %d.\n",
+                                                       adata->name, (int)e=
n);
+       mutex_unlock(&indio_dev->mlock);
+
+set_enable_error:
+       return size;
+}
+
+static ssize_t sysfs_get_enable(struct device *dev,
+                               struct device_attribute *attr, char *buf)
+{
+       ssize_t ret;
+       int status;
+       struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+       struct acc_data *adata =3D iio_priv(indio_dev);
+
+       status =3D atomic_read(&adata->enabled);
+       ret =3D sprintf(buf, "%d\n", status);
+
+       return ret;
+}
+
+static ssize_t sysfs_get_fullscale(struct device *dev,
+                               struct device_attribute *attr, char *buf)
+{
+       ssize_t ret;
+       struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+       struct acc_data *adata =3D iio_priv(indio_dev);
+
+       ret =3D sprintf(buf, "%d\n", adata->fullscale);
+
+       return ret;
+}
+
+static ssize_t sysfs_set_fullscale(struct device *dev,
+               struct device_attribute *attr, const char *buf, size_t size=
)
+{
+       int err;
+       unsigned long fs;
+       struct fullscale_available *fs_out;
+       struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+       struct acc_data *adata =3D iio_priv(indio_dev);
+
+       err =3D kstrtoul(buf, 10, &fs);
+       if (err) {
+               pr_err("%s: input is not a number! (errn %d).\n",
+                                                       adata->name, err);
+               goto set_fullscale_error;
+       }
+
+       mutex_lock(&indio_dev->mlock);
+       fs_out =3D kzalloc(sizeof(*fs_out), GFP_KERNEL);
+       if (fs_out =3D=3D NULL)
+               goto fs_out_allocate_memory_error;
+
+       err =3D match_fs(&sensor[adata->index], fs, fs_out);
+       if (err < 0) {
+               pr_err("%s: input is not a valid fullscale! (errn %d).\n",
+                                                       adata->name, err);
+               goto match_fullscale_error;
+       }
+       err =3D set_fullscale(indio_dev, fs_out);
+       if (err < 0) {
+               pr_err("%s: failed to set new fullscale. (errn %d).\n",
+                                                       adata->name, err);
+       }
+
+match_fullscale_error:
+       kfree(fs_out);
+fs_out_allocate_memory_error:
+       mutex_unlock(&indio_dev->mlock);
+set_fullscale_error:
+       return size;
+}
+
+static ssize_t sysfs_fullscale_available(struct device *dev,
+                               struct device_attribute *attr, char *buf)
+{
+       int i, n, len;
+       char tmp[4];
+       char fullscale[30] =3D "";
+       struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+       struct acc_data *adata =3D iio_priv(indio_dev);
+
+       mutex_lock(&indio_dev->mlock);
+       n =3D ARRAY_SIZE(sensor[adata->index].fs.fs_avl);
+       for (i =3D 0; i < n; i++) {
+               if (sensor[adata->index].fs.fs_avl[i].num !=3D 0) {
+                       len =3D strlen(&fullscale[0]);
+                       sprintf(tmp, "%d ",
+                               sensor[adata->index].fs.fs_avl[i].num);
+                       strcpy(&fullscale[len], tmp);
+               } else
+                       break;
+       }
+       mutex_unlock(&indio_dev->mlock);
+
+       return sprintf(buf, "%s\n", fullscale);
+}
+
+static ssize_t sysfs_sampling_frequency_available(struct device *dev,
+                               struct device_attribute *attr, char *buf)
+{
+       int i, n, len;
+       char tmp[4];
+       char sampling_frequency[30] =3D "";
+       struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+       struct acc_data *adata =3D iio_priv(indio_dev);
+
+       mutex_lock(&indio_dev->mlock);
+       n =3D ARRAY_SIZE(sensor[adata->index].odr.odr_avl);
+       for (i =3D 0; i < n; i++) {
+               if (sensor[adata->index].odr.odr_avl[i].hz !=3D 0) {
+                       len =3D strlen(&sampling_frequency[0]);
+                       sprintf(tmp, "%d ",
+                               sensor[adata->index].odr.odr_avl[i].hz);
+                       strcpy(&sampling_frequency[len], tmp);
+               } else
+                       break;
+       }
+       mutex_unlock(&indio_dev->mlock);
+
+       return sprintf(buf, "%s\n", sampling_frequency);
+}
+
+static IIO_DEVICE_ATTR(sampling_frequency_available, S_IRUGO,
+                               sysfs_sampling_frequency_available, NULL , =
0);
+static IIO_DEVICE_ATTR(fullscale_available, S_IRUGO,
+                               sysfs_fullscale_available, NULL , 0);
+static IIO_DEVICE_ATTR(fullscale, S_IWUSR | S_IRUGO, sysfs_get_fullscale,
+                               sysfs_set_fullscale , 0);
+static IIO_DEVICE_ATTR(enable, S_IWUSR | S_IRUGO, sysfs_get_enable,
+                                               sysfs_set_enable , 0);
+static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
sysfs_get_sampling_frequency,
+                               sysfs_set_sampling_frequency);
+
+static struct attribute *acc_attributes[] =3D {
+       &iio_dev_attr_sampling_frequency_available.dev_attr.attr,
+       &iio_dev_attr_fullscale_available.dev_attr.attr,
+       &iio_dev_attr_fullscale.dev_attr.attr,
+       &iio_dev_attr_enable.dev_attr.attr,
+       &iio_dev_attr_sampling_frequency.dev_attr.attr,
+       NULL,
+};
+
+static const struct attribute_group acc_attribute_group =3D {
+       .attrs =3D acc_attributes,
+};
+
+static const struct iio_info acc_info =3D {
+       .driver_module =3D THIS_MODULE,
+       .attrs =3D &acc_attribute_group,
+       .read_raw =3D &acc_read_raw,
+};
+
+static int init_sensor(struct iio_dev *indio_dev)
+{
+       int err;
+       struct odr_available *odr_out;
+       struct fullscale_available *fs_out;
+       struct acc_data *adata =3D iio_priv(indio_dev);
+
+       odr_out =3D kzalloc(sizeof(*odr_out), GFP_KERNEL);
+       if (odr_out =3D=3D NULL)
+               goto odr_out_allocate_memory_error;
+       fs_out =3D kzalloc(sizeof(*fs_out), GFP_KERNEL);
+       if (fs_out =3D=3D NULL)
+               goto fs_out_allocate_memory_error;
+
+       adata->fullscale =3D adata->pdata->fullscale;
+       adata->odr =3D adata->pdata->sampling_frequency;
+       set_enable(indio_dev, POWER_OFF);
+       match_fs(&sensor[adata->index], adata->fullscale, fs_out);
+       err =3D set_fullscale(indio_dev, fs_out);
+       if (err < 0)
+               goto init_error;
+       match_odr(&sensor[adata->index], adata->odr, odr_out);
+       err =3D set_odr(indio_dev, odr_out);
+       if (err < 0)
+               goto init_error;
+       err =3D set_bdu(indio_dev, &sensor[adata->index].data.bdu,
+                                               (u8)DEFAULT_POWER_ON_VALUE)=
;
+       if (err < 0)
+               goto init_error;
+       kfree(odr_out);
+       kfree(fs_out);
+
+       return 0;
+
+init_error:
+       kfree(fs_out);
+fs_out_allocate_memory_error:
+       kfree(odr_out);
+odr_out_allocate_memory_error:
+       return -EIO;
+}
+
+int acc_iio_default(struct iio_dev *indio_dev)
+{
+       int err;
+       u8 wai;
+       struct acc_data *adata =3D iio_priv(indio_dev);
+
+       mutex_init(&adata->slock);
+       indio_dev->modes =3D INDIO_DIRECT_MODE;
+       indio_dev->info =3D &acc_info;
+
+       err =3D get_wai_device(indio_dev, DEFAULT_WAI_ADDRESS, &wai);
+       if (err < 0)
+               goto get_wai_error;
+       err =3D check_device_list(indio_dev, wai);
+       if (err < 0)
+               goto check_device_list_error;
+       set_sensor_parameters(indio_dev);
+       err =3D set_platform_data(indio_dev);
+       if (err < 0)
+               goto set_platform_data_error;
+       err =3D validate_platform_data(indio_dev);
+       if (err < 0)
+               goto validate_platform_data_error;
+       register_channels(indio_dev);
+
+       err =3D init_sensor(indio_dev);
+       if (err < 0)
+               goto init_sensor_error;
+
+       if (sensor[adata->index].wai =3D=3D S5_WAI_EXP)
+               adata->multiread_bit =3D 0;
+       else
+               adata->multiread_bit =3D 1;
+
+       err =3D acc_check_irq(indio_dev);
+       if (err < 0)
+               goto gpio_check_error;
+       err =3D acc_allocate_ring(indio_dev);
+       if (err < 0)
+               goto acc_allocate_ring_error;
+
+       err =3D acc_probe_trigger(indio_dev);
+       if (err < 0)
+               goto acc_probe_trigger_error;
+
+       err =3D iio_device_register(indio_dev);
+       if (err)
+               goto iio_device_register_error;
+
+       pr_info("%s: probe end correctly.\n", adata->name);
+
+       return err;
+
+iio_device_register_error:
+       acc_remove_trigger(indio_dev);
+acc_probe_trigger_error:
+       acc_deallocate_ring(indio_dev);
+acc_allocate_ring_error:
+gpio_check_error:
+init_sensor_error:
+validate_platform_data_error:
+       kfree(adata->pdata);
+set_platform_data_error:
+check_device_list_error:
+get_wai_error:
+       return err;
+}
+
+int acc_iio_remove(struct iio_dev *indio_dev)
+{
+       struct acc_data *adata =3D iio_priv(indio_dev);
+
+       acc_remove_trigger(indio_dev);
+       acc_deallocate_ring(indio_dev);
+       kfree(adata->pdata);
+       iio_device_unregister(indio_dev);
+
+       return 0;
+}
+
+MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics accelerometers driver");
+MODULE_LICENSE("GPL v2");
diff --git
a/drivers/iio/accel/STMicroelectronics_accelerometers_iio_i2c.c
b/drivers/iio/accel/STMicroelectronics_accelerometers_iio_i2c.c
new file mode 100644
index 0000000..f443e52
--- /dev/null
+++ b/drivers/iio/accel/STMicroelectronics_accelerometers_iio_i2c.c
@@ -0,0 +1,124 @@
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
+
+#include <linux/iio/acc/STMicroelectronics_accelerometers_iio.h>
+
+
+#define        ACC_I2C_MULTIREAD       0x80
+
+
+static inline s32 acc_i2c_read_byte(struct acc_data *adata, u8 reg_addr)
+{
+       return i2c_smbus_read_byte_data(adata->client, reg_addr);
+}
+
+static inline s32 acc_i2c_read_multiple_byte(struct acc_data *adata,
+                                               u8 reg_addr, int len, u8 *d=
ata)
+{
+       if (adata->multiread_bit !=3D 0)
+               reg_addr |=3D ACC_I2C_MULTIREAD;
+       return i2c_smbus_read_i2c_block_data(adata->client,
+                                                       reg_addr, len, data=
);
+}
+
+static inline s32 acc_i2c_write_byte(struct acc_data *adata,
+                                                       u8 reg_addr, u8 dat=
a)
+{
+       return i2c_smbus_write_byte_data(adata->client, reg_addr, data);
+}
+
+static int __devinit acc_i2c_probe(struct i2c_client *client,
+                               const struct i2c_device_id *id)
+{
+       struct iio_dev *indio_dev;
+       struct acc_data *adata;
+       int err;
+
+       pr_info("%s: probe start.\n", client->name);
+       indio_dev =3D iio_device_alloc(sizeof(*adata));
+       if (indio_dev =3D=3D NULL) {
+               err =3D -ENOMEM;
+               goto iio_device_alloc_error;
+       }
+
+       adata =3D iio_priv(indio_dev);
+       adata->client =3D client;
+       i2c_set_clientdata(client, indio_dev);
+
+       indio_dev->dev.parent =3D &client->dev;
+       indio_dev->name =3D client->name;
+
+       adata->read_byte =3D acc_i2c_read_byte;
+       adata->write_byte =3D acc_i2c_write_byte;
+       adata->read_multiple_byte =3D acc_i2c_read_multiple_byte;
+       adata->name =3D &client->name[0];
+       adata->irq_data_ready =3D &client->irq;
+
+       err =3D acc_iio_default(indio_dev);
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
+static int __devexit acc_i2c_remove(struct i2c_client *client)
+{
+       int err;
+       struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
+
+       err =3D acc_iio_remove(indio_dev);
+       iio_device_free(indio_dev);
+       return err;
+}
+
+static const struct i2c_device_id acc_id_table[] =3D {
+       { LSM303DLH_ACC_IIO_DEV_NAME, 0 },
+       { LSM303DLHC_ACC_IIO_DEV_NAME, 0 },
+       { LIS3DH_ACC_IIO_DEV_NAME, 0 },
+       { LSM330D_ACC_IIO_DEV_NAME, 0 },
+       { LSM330DL_ACC_IIO_DEV_NAME, 0 },
+       { LSM330DLC_ACC_IIO_DEV_NAME, 0 },
+       { LSM303D_ACC_IIO_DEV_NAME, 0 },
+       { LSM9DS0_ACC_IIO_DEV_NAME, 0 },
+       { LIS3LV02DL_ACC_IIO_DEV_NAME, 0 },
+       { LSM303DL_ACC_IIO_DEV_NAME, 0 },
+       { LSM303DLM_ACC_IIO_DEV_NAME, 0 },
+       { LSM330_ACC_IIO_DEV_NAME, 0 },
+       {},
+};
+
+MODULE_DEVICE_TABLE(i2c, acc_id_table);
+
+static struct i2c_driver acc_driver =3D {
+       .driver =3D {
+               .owner =3D THIS_MODULE,
+               .name =3D "STMicroelectronics i2c accelerometers",
+       },
+       .probe =3D acc_i2c_probe,
+       .remove =3D __devexit_p(acc_i2c_remove),
+       .id_table =3D acc_id_table,
+};
+
+module_i2c_driver(acc_driver);
+
+MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics accelerometers i2c driver");
+MODULE_LICENSE("GPL v2");
diff --git
a/drivers/iio/accel/STMicroelectronics_accelerometers_iio_spi.c
b/drivers/iio/accel/STMicroelectronics_accelerometers_iio_spi.c
new file mode 100644
index 0000000..f1ac211
--- /dev/null
+++ b/drivers/iio/accel/STMicroelectronics_accelerometers_iio_spi.c
@@ -0,0 +1,209 @@
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
+
+#include <linux/iio/acc/STMicroelectronics_accelerometers_iio.h>
+
+
+#define ACC_SPI_READ           0x80;
+#define ACC_SPI_MULTIREAD      0xc0
+
+
+static inline s32 acc_spi_read_byte(struct acc_data *adata, u8 reg_addr)
+{
+       struct spi_message msg;
+       int err;
+       u8 res;
+       u8 tx;
+
+       struct spi_transfer xfers[] =3D {
+               {
+                       .tx_buf =3D &tx,
+                       .bits_per_word =3D 8,
+                       .len =3D 1,
+                       .cs_change =3D 0,
+                       .delay_usecs =3D 10,
+               },
+               {
+                       .rx_buf =3D &res,
+                       .bits_per_word =3D 8,
+                       .len =3D 1,
+                       .delay_usecs =3D 10,
+               }
+       };
+
+       mutex_lock(&adata->slock);
+       tx =3D reg_addr | ACC_SPI_READ;
+       spi_message_init(&msg);
+       spi_message_add_tail(&xfers[0], &msg);
+       spi_message_add_tail(&xfers[1], &msg);
+       err =3D spi_sync(adata->spi, &msg);
+       mutex_unlock(&adata->slock);
+
+       return err;
+}
+
+static inline s32 acc_spi_read_multiple_byte(struct acc_data *adata,
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
+                       .cs_change =3D 0,
+                       .delay_usecs =3D 10,
+               },
+               {
+                       .rx_buf =3D data,
+                       .bits_per_word =3D 8,
+                       .len =3D len,
+                       .cs_change =3D 0,
+                       .delay_usecs =3D 10,
+               }
+       };
+
+       mutex_lock(&adata->slock);
+       if (adata->multiread_bit !=3D 0)
+               tx =3D reg_addr | ACC_SPI_MULTIREAD;
+       else
+               tx =3D reg_addr | ACC_SPI_READ;
+
+       spi_message_init(&msg);
+       spi_message_add_tail(&xfers[0], &msg);
+       spi_message_add_tail(&xfers[1], &msg);
+       err =3D spi_sync(adata->spi, &msg);
+       mutex_unlock(&adata->slock);
+
+       return err;
+}
+
+static inline s32 acc_spi_write_byte(struct acc_data *adata,
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
+                       .cs_change =3D 0,
+                       .delay_usecs =3D 10,
+               }
+       };
+
+       mutex_lock(&adata->slock);
+       tx[0] =3D reg_addr;
+       tx[1] =3D data;
+       spi_message_init(&msg);
+       spi_message_add_tail(&xfers[0], &msg);
+       err =3D spi_sync(adata->spi, &msg);
+       mutex_unlock(&adata->slock);
+
+       return err;
+}
+
+static int __devinit acc_spi_probe(struct spi_device *client)
+{
+       struct iio_dev *indio_dev;
+       struct acc_data *adata;
+       int err;
+
+       pr_info("%s: probe start.\n", client->modalias);
+       indio_dev =3D iio_device_alloc(sizeof(*adata));
+       if (indio_dev =3D=3D NULL) {
+               err =3D -ENOMEM;
+               goto iio_device_alloc_error;
+       }
+
+       adata =3D iio_priv(indio_dev);
+       adata->spi =3D client;
+       spi_set_drvdata(client, indio_dev);
+
+       indio_dev->dev.parent =3D &client->dev;
+       indio_dev->name =3D client->modalias;
+
+       adata->read_byte =3D acc_spi_read_byte;
+       adata->write_byte =3D acc_spi_write_byte;
+       adata->read_multiple_byte =3D acc_spi_read_multiple_byte;
+       adata->name =3D &client->modalias[0];
+       adata->irq_data_ready =3D &client->irq;
+
+       /* dummy read */
+       adata->read_byte(adata, 0x0f);
+
+       err =3D acc_iio_default(indio_dev);
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
+static int __devexit acc_spi_remove(struct spi_device *spi)
+{
+       int err;
+       struct iio_dev *indio_dev =3D spi_get_drvdata(spi);
+
+       err =3D acc_iio_remove(indio_dev);
+       iio_device_free(indio_dev);
+
+       return 0;
+}
+
+static const struct spi_device_id acc_id_table[] =3D {
+       { LSM303DLH_ACC_IIO_DEV_NAME, 0 },
+       { LSM303DLHC_ACC_IIO_DEV_NAME, 0 },
+       { LIS3DH_ACC_IIO_DEV_NAME, 0 },
+       { LSM330D_ACC_IIO_DEV_NAME, 0 },
+       { LSM330DL_ACC_IIO_DEV_NAME, 0 },
+       { LSM330DLC_ACC_IIO_DEV_NAME, 0 },
+       { LSM303D_ACC_IIO_DEV_NAME, 0 },
+       { LSM9DS0_ACC_IIO_DEV_NAME, 0 },
+       { LIS3LV02DL_ACC_IIO_DEV_NAME, 0 },
+       { LSM303DL_ACC_IIO_DEV_NAME, 0 },
+       { LSM303DLM_ACC_IIO_DEV_NAME, 0 },
+       { LSM330_ACC_IIO_DEV_NAME, 0 },
+       {},
+};
+
+MODULE_DEVICE_TABLE(spi, acc_id_table);
+
+static struct spi_driver acc_driver =3D {
+       .driver =3D {
+               .owner =3D THIS_MODULE,
+               .name =3D "STMicroelectronics spi accelerometers",
+       },
+       .probe =3D acc_spi_probe,
+       .remove =3D __devexit_p(acc_spi_remove),
+       .id_table =3D acc_id_table,
+};
+
+module_spi_driver(acc_driver);
+
+MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics accelerometers spi driver");
+MODULE_LICENSE("GPL v2");
diff --git
a/drivers/iio/accel/STMicroelectronics_accelerometers_iio_trigger.c
b/drivers/iio/accel/STMicroelectronics_accelerometers_iio_trigger.c
new file mode 100644
index 0000000..843af4c
--- /dev/null
+++ b/drivers/iio/accel/STMicroelectronics_accelerometers_iio_trigger.c
@@ -0,0 +1,96 @@
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
+#include <linux/interrupt.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+
+#include <linux/iio/acc/STMicroelectronics_accelerometers_iio.h>
+
+
+static irqreturn_t acc_data_ready_trig_poll(int irq, void *trig)
+{
+       iio_trigger_poll(trig, iio_get_time_ns());
+       return IRQ_HANDLED;
+}
+
+static int iio_trig_acc_set_state(struct iio_trigger *trig, bool state)
+{
+       struct iio_dev *indio_dev =3D trig->private_data;
+       return acc_set_dataready_irq(indio_dev, state);
+}
+
+static const struct iio_trigger_ops iio_acc_trigger_ops =3D {
+       .owner =3D THIS_MODULE,
+       .set_trigger_state =3D &iio_trig_acc_set_state,
+};
+
+int acc_probe_trigger(struct iio_dev *indio_dev)
+{
+       int err;
+       struct acc_data *adata =3D iio_priv(indio_dev);
+
+       adata->trig =3D iio_trigger_alloc("%s-trigger", indio_dev->name);
+       if (adata->trig =3D=3D NULL) {
+               err =3D -ENOMEM;
+               pr_err("%s: failed to allocate iio trigger.\n", adata->name=
);
+               goto iio_trigger_alloc_error;
+       }
+
+       err =3D request_threaded_irq(*adata->irq_data_ready,
+                       acc_data_ready_trig_poll,
+                       NULL,
+                       IRQF_TRIGGER_RISING,
+                       "IRQ_data_ready",
+                       adata->trig);
+       if (err) {
+               pr_err("%s: failed to request threaded irq [%d].\n",
+                                       adata->name, *adata->irq_data_ready=
);
+               goto request_irq_error;
+       }
+       adata->trig->private_data =3D indio_dev;
+       adata->trig->ops =3D &iio_acc_trigger_ops;
+
+       if (adata->client !=3D NULL)
+               adata->trig->dev.parent =3D &adata->client->dev;
+       else
+               adata->trig->dev.parent =3D &adata->spi->dev;
+
+       err =3D iio_trigger_register(adata->trig);
+       if (err < 0) {
+               pr_err("%s: failed to register iio trigger.\n", adata->name=
);
+               goto iio_trigger_register_error;
+       }
+       indio_dev->trig =3D adata->trig;
+       pr_info("%s: using [%s] trigger.\n", adata->name,
+                                                       adata->trig->name);
+       return 0;
+
+iio_trigger_register_error:
+       free_irq(*adata->irq_data_ready, adata->trig);
+request_irq_error:
+       iio_trigger_free(adata->trig);
+iio_trigger_alloc_error:
+       return err;
+}
+
+int acc_remove_trigger(struct iio_dev *indio_dev)
+{
+       struct acc_data *adata =3D iio_priv(indio_dev);
+
+       iio_trigger_unregister(adata->trig);
+       free_irq(*adata->irq_data_ready, adata->trig);
+       iio_trigger_free(adata->trig);
+
+       return 0;
+}
--
1.7.0.4


 From 1fe8b75e0ec1197781c559935de23e116773c441 Mon Sep 17 00:00:00 2001
From: Denis Ciocca <denis.ciocca@st.com>
Date: Mon, 8 Oct 2012 17:08:43 +0200
Subject: [PATCH 2/2] add header file

---
  .../acc/STMicroelectronics_accelerometers_iio.h    |  116
++++++++++++++++++++
  1 files changed, 116 insertions(+), 0 deletions(-)
  create mode 100644
include/linux/iio/acc/STMicroelectronics_accelerometers_iio.h

diff --git
a/include/linux/iio/acc/STMicroelectronics_accelerometers_iio.h
b/include/linux/iio/acc/STMicroelectronics_accelerometers_iio.h
new file mode 100644
index 0000000..e6f18ad
--- /dev/null
+++ b/include/linux/iio/acc/STMicroelectronics_accelerometers_iio.h
@@ -0,0 +1,116 @@
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
+ * LIS3LV02DL
+ * LIS331DLH
+ * LSM303DL
+ * LSM303DLM
+ * LSM330
+ */
+
+#include <linux/spi/spi.h>
+
+#ifndef ST_ACCELEROMETERS_IIO_ACC_H
+#define ST_ACCELEROMETERS_IIO_ACC_H
+
+#define LSM303DLH_ACC_IIO_DEV_NAME     "lsm303dlh_acc_iio"
+#define LSM303DLHC_ACC_IIO_DEV_NAME    "lsm303dlhc_acc_iio"
+#define LIS3DH_ACC_IIO_DEV_NAME                "lis3dh_acc_iio"
+#define LSM330D_ACC_IIO_DEV_NAME       "lsm330d_acc_iio"
+#define LSM330DL_ACC_IIO_DEV_NAME      "lsm330dl_acc_iio"
+#define LSM330DLC_ACC_IIO_DEV_NAME     "lsm330dlc_acc_iio"
+#define LSM303D_ACC_IIO_DEV_NAME       "lsm303d_acc_iio"
+#define LSM9DS0_ACC_IIO_DEV_NAME       "lsm9ds0_acc_iio"
+#define LIS3LV02DL_ACC_IIO_DEV_NAME    "lis3lv02dl_acc_iio"
+#define LSM303DL_ACC_IIO_DEV_NAME      "lsm303dl_acc_iio"
+#define LSM303DLM_ACC_IIO_DEV_NAME     "lsm303dlm_acc_iio"
+#define LSM330_ACC_IIO_DEV_NAME                "lsm330_acc_iio"
+
+#define ACC_NUMBER_ALL_CHANNELS                4
+#define ACC_NUMBER_DATA_CHANNELS       3
+#define ACC_SCAN_X                     0
+#define ACC_SCAN_Y                     1
+#define ACC_SCAN_Z                     2
+#define ACC_SCAN_TIMESTAMP             3
+#define ACC_BYTE_FOR_CHANNEL           2
+
+
+struct acc_platform_data {
+       int fullscale;
+       int sampling_frequency;
+};
+
+struct acc_data {
+       struct i2c_client *client;
+       struct spi_device *spi;
+       struct acc_platform_data *pdata;
+       char *name;
+
+       short index;
+
+       atomic_t enabled;
+       int fullscale;
+       int gain;
+       int odr;
+
+       int multiread_bit;
+       int (*read_byte) (struct acc_data *adata, u8 reg_addr);
+       int (*write_byte) (struct acc_data *adata, u8 reg_addr, u8 data);
+       int (*read_multiple_byte) (struct acc_data *adata, u8 reg_addr,
+                                                       int len, u8 *data);
+
+#ifdef CONFIG_STMICROELECTRONICS_ACCELEROMETERS_BUF_KFIFO
+       struct iio_trigger *trig;
+#endif /* CONFIG_STMICROELECTRONICS_ACCELEROMETERS_BUF_KFIFO */
+
+       int *irq_data_ready;
+       struct mutex slock;
+
+};
+
+int acc_iio_default(struct iio_dev *indio_dev);
+int acc_iio_remove(struct iio_dev *indio_dev);
+
+#ifdef CONFIG_STMICROELECTRONICS_ACCELEROMETERS_BUF_KFIFO
+int acc_probe_trigger(struct iio_dev *indio_dev);
+int acc_remove_trigger(struct iio_dev *indio_dev);
+int acc_allocate_ring(struct iio_dev *indio_dev);
+void acc_deallocate_ring(struct iio_dev *indio_dev);
+int acc_set_dataready_irq(struct iio_dev *indio_dev, bool enable);
+#else
+static inline int acc_probe_trigger(struct iio_dev *indio_dev)
+{
+       return 0;
+}
+static inline int acc_remove_trigger(struct iio_dev *indio_dev)
+{
+       return 0;
+}
+static inline int acc_allocate_ring(struct iio_dev *indio_dev)
+{
+       return 0;
+}
+static inline void acc_deallocate_ring(struct iio_dev *indio_dev)
+{
+       return;
+}
+#endif /* CONFIG_STMICROELECTRONICS_ACCELEROMETERS_BUF_KFIFO */
+
+#endif /* ST_ACCELEROMETERS_IIO_ACC_H */
--
1.7.0.4
