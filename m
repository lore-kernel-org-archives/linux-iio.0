Return-Path: <swapnil.tiwari@st.com>
From: Swapnil TIWARI <swapnil.tiwari@st.com>
To: "jic23@cam.ac.uk" <jic23@cam.ac.uk>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Tue, 18 Sep 2012 21:19:39 +0200
Subject: [PATCH] Staging: iio: gyro: Add STMicroelectronics L3GD20 gyroscope
 device driver
Message-ID: <494E38452A01E745B763C5F242AAA2CCC5111C8FD9@SAFEX1MAIL1.st.com>
Content-Type: multipart/alternative;
	boundary="_000_494E38452A01E745B763C5F242AAA2CCC5111C8FD9SAFEX1MAIL1st_"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

--_000_494E38452A01E745B763C5F242AAA2CCC5111C8FD9SAFEX1MAIL1st_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Add STMicroelectronics L3GD20 gyroscope device driver

Signed-off-by: Swapnil Tiwari <swapnil.tiwari@st.com<mailto:swapnil.tiwari@=
st.com>>
---
drivers/staging/iio/gyro/Kconfig           |    9 +
drivers/staging/iio/gyro/Makefile          |    3 +
drivers/staging/iio/gyro/l3gd20.h          |  155 +++++
drivers/staging/iio/gyro/l3gd20_gyr_core.c | 1030 +++++++++++++++++++++++++=
+++
4 files changed, 1197 insertions(+), 0 deletions(-)
create mode 100644 drivers/staging/iio/gyro/l3gd20.h
create mode 100644 drivers/staging/iio/gyro/l3gd20_gyr_core.c

diff --git a/drivers/staging/iio/gyro/Kconfig b/drivers/staging/iio/gyro/Kc=
onfig
index ea295b2..47698cb 100644
--- a/drivers/staging/iio/gyro/Kconfig
+++ b/drivers/staging/iio/gyro/Kconfig
@@ -46,4 +46,13 @@ config ADXRS450
      This driver can also be built as a module.  If so, the module
      will be called adxrs450.

+config L3GD20_GYR_IIO
+       tristate "STM L3GD20 3 Axis Digital Gyroscope Sensor I2C driver (ii=
o)"
+       depends on I2C
+       help
+          Say yes here to build support for the STMicrolectronics L3GD20 3=
 Axis
+          Digital .
+          To compile this driver as a module, choose M here: the module
+          will be called l3gd20_gyr_iio.
+
endmenu
diff --git a/drivers/staging/iio/gyro/Makefile b/drivers/staging/iio/gyro/M=
akefile
index 9ba5ec1..c5d2879 100644
--- a/drivers/staging/iio/gyro/Makefile
+++ b/drivers/staging/iio/gyro/Makefile
@@ -20,3 +20,6 @@ obj-$(CONFIG_ADIS16251) +=3D adis16251.o

 adxrs450-y             :=3D adxrs450_core.o
obj-$(CONFIG_ADXRS450) +=3D adxrs450.o
+
+l3gd20_gyr-y    :=3D l3gd20_gyr_core.o
+obj-$(CONFIG_L3GD20_GYR_IIO) +=3D l3gd20_gyr.o
diff --git a/drivers/staging/iio/gyro/l3gd20.h b/drivers/staging/iio/gyro/l=
3gd20.h
new file mode 100644
index 0000000..c7abb3d
--- /dev/null
+++ b/drivers/staging/iio/gyro/l3gd20.h
@@ -0,0 +1,155 @@
+/******************** (C) COPYRIGHT 2011 STMicroelectronics **************=
******
+*
+* File Name    : l3gd20_iio.h
+* Authors : MH - C&I BU - Application Team
+*         : Matteo Dameno (matteo.dameno@st.com<mailto:matteo.dameno@st.co=
m>
+*         : author is willing to be considered the contact
+*         : and update points for the driver.
+* Version : V.2.0.0
+* Date         : 2011/Aug/16
+* Description  : L3GD20 3 Axis Digital Gyroscope Sensor device driver iio
+*         :
+**************************************************************************=
******
+*
+* This program is free software; you can redistribute it and/or modify
+* it under the terms of the GNU General Public License version 2 as
+* published by the Free Software Foundation.
+*
+* THE PRESENT SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES
+* OR CONDITIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED, FOR THE SOLE
+* PURPOSE TO SUPPORT YOUR APPLICATION DEVELOPMENT.
+* AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY DIRECT,
+* INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING FRO=
M THE
+* CONTENT OF SUCH SOFTWARE AND/OR THE USE MADE BY CUSTOMERS OF THE CODING
+* INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
+*
+**************************************************************************=
*****/
+/*************************************************************************=
******
+Version History.
+ Revision 2.0.0: 2012/Nov/16
+  first ioo implementation;
+**************************************************************************=
*****/
+
+#ifndef __L3GD20_H__
+#define __L3GD20_H__
+
+
+#define L3GD20_GYR_DEV_NAME         "l3gd20_gyr_iio"
+
+#define L3GD20_GYR_FS_250DPS   0x00
+#define L3GD20_GYR_FS_500DPS   0x10
+#define L3GD20_GYR_FS_2000DPS  0x30
+
+#define L3GD20_GYR_ENABLED     1
+#define L3GD20_GYR_DISABLED    0
+
+
+#ifdef __KERNEL__
+
+/* to set gpios numb connected to gyro interrupt pins,
+ * the unused ones have to be set to -EINVAL
+ */
+#define DEFAULT_INT1_GPIO      (-EINVAL)
+#define DEFAULT_INT2_GPIO      (-EINVAL)
+
+#define SAD0L                  0x00
+#define SAD0H                  0x01
+#define L3GD20_GYR_I2C_SADROOT      0x35
+#define L3GD20_GYR_I2C_SAD_L        ((L3GD20_GYR_I2C_SADROOT<<1)|SAD0L)
+#define L3GD20_GYR_I2C_SAD_H        ((L3GD20_GYR_I2C_SADROOT<<1)|SAD0H)
+
+#define L3GD20_MIN_POLL_PERIOD_MS   2
+
+struct l3gd20_gyr_platform_data {
+    int (*init)(void);
+    void (*exit)(void);
+    int (*power_on)(void);
+    int (*power_off)(void);
+    unsigned int poll_interval;
+    unsigned int min_interval;
+
+    u8 fs_range;
+    u8 sampling_frequency;
+
+    /* set gpio_int[1,2] either to the choosen gpio pin number or to -EINV=
AL
+    * if leaved unconnected
+    */
+    int gpio_int1;
+    int gpio_int2;       /* int for fifo */
+
+    /* axis mapping */
+    u8 axis_map_x;
+    u8 axis_map_y;
+    u8 axis_map_z;
+
+    u8 negate_x;
+    u8 negate_y;
+    u8 negate_z;
+};
+
+#ifdef CONFIG_IIO_RING_BUFFER
+/* At the moment triggers are only used for ring buffer
+ * filling. This may change!
+ */
+
+enum l3gd20_gyr_scan {
+    L3GD20_GYR_SCAN_GYR_X,
+    L3GD20_GYR_SCAN_GYR_Y,
+    L3GD20_GYR_SCAN_GYR_Z,
+};
+
+void l3gd20_gyr_remove_trigger(struct iio_dev *indio_dev);
+int l3gd20_gyr_probe_trigger(struct iio_dev *indio_dev);
+
+ssize_t l3gd20_gyr_read_data_from_ring(struct device *dev,
+                          struct device_attribute *attr,
+                          char *buf);
+
+
+int l3gd20_gyr_configure_ring(struct iio_dev *indio_dev);
+void l3gd20_gyr_unconfigure_ring(struct iio_dev *indio_dev);
+
+int l3gd20_gyr_initialize_ring(struct iio_ring_buffer *ring);
+void l3gd20_gyr_uninitialize_ring(struct iio_ring_buffer *ring);
+#else /* CONFIG_IIO_RING_BUFFER */
+
+static inline void l3gd20_gyr_remove_trigger(struct iio_dev *indio_dev)
+{
+}
+
+static inline int l3gd20_gyr_probe_trigger(struct iio_dev *indio_dev)
+{
+    return 0;
+}
+
+static inline ssize_t
+l3gd20_gyr_read_data_from_ring(struct device *dev,
+                     struct device_attribute *attr,
+                     char *buf)
+{
+    return 0;
+}
+
+static int l3gd20_gyr_configure_ring(struct iio_dev *indio_dev)
+{
+    return 0;
+}
+
+static inline void l3gd20_gyr_unconfigure_ring(struct iio_dev *indio_dev)
+{
+}
+/*
+static inline int l3gd20_gyr_initialize_ring(struct iio_ring_buffer *ring)
+{
+    return 0;
+}
+
+static inline void l3gd20_gyr_uninitialize_ring(struct iio_ring_buffer *ri=
ng)
+{
+}
+*/
+#endif /* CONFIG_IIO_RING_BUFFER */
+
+#endif /* __KERNEL__ */
+
+#endif  /* __L3GD20_H__ */
diff --git a/drivers/staging/iio/gyro/l3gd20_gyr_core.c b/drivers/staging/i=
io/gyro/l3gd20_gyr_core.c
new file mode 100644
index 0000000..5bb888c
--- /dev/null
+++ b/drivers/staging/iio/gyro/l3gd20_gyr_core.c
@@ -0,0 +1,1030 @@
+/******************** (C) COPYRIGHT 2011 STMicroelectronics **************=
******
+*
+* File Name    : l3gd20_gyr_core_iio.c
+* Authors : MSH - Motion Mems BU - Application Team
+*         : Matteo Dameno (matteo.dameno@st.com<mailto:matteo.dameno@st.co=
m>)
+*         : Swapnil Tiwari (swapnil.tiwari@st.com<mailto:swapnil.tiwari@st=
.com>)
+*         : Author is willing to be considered the contact
+*         : and update points for the driver.*
+* Version : V.2.0.0
+* Date         : 2011/Nov/16
+* Description  : L3GD20 3 Axis Digital Gyroscope Sensor device driver iio
+*         :
+**************************************************************************=
******
+*
+* This program is free software; you can redistribute it and/or modify
+* it under the terms of the GNU General Public License version 2 as
+* published by the Free Software Foundation.
+*
+* THE PRESENT SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES
+* OR CONDITIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED, FOR THE SOLE
+* PURPOSE TO SUPPORT YOUR APPLICATION DEVELOPMENT.
+* AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY DIRECT,
+* INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING FRO=
M THE
+* CONTENT OF SUCH SOFTWARE AND/OR THE USE MADE BY CUSTOMERS OF THE CODING
+* INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
+*
+**************************************************************************=
******
+ Revision 2.0.0: 2012/Nov/16
+  first ioo implementation;
+
+**************************************************************************=
*****/
+
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/fs.h>
+#include <linux/i2c.h>
+#include <linux/mutex.h>
+#include <linux/input.h>
+#include <linux/uaccess.h>
+#include <linux/workqueue.h>
+#include <linux/irq.h>
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/gpio.h>
+#include <linux/slab.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/sysfs.h>
+#include <linux/moduleparam.h>
+#include "linux/iio/iio.h"
+#include "linux/iio/sysfs.h"
+#include "l3gd20.h"
+
+#define SENSITIVITY_250DPS     "8.75"          /**  mdps/counts */
+#define SENSITIVITY_500DPS     "17.50"         /**  mdps/counts */
+#define SENSITIVITY_2000DPS    "70.00"         /**  mdps/counts */
+
+#define SCALE_250DPS      "0.000153" /**  (rad/sec)/count */
+#define SCALE_500DPS      "0.000297" /**  (rad/sec)/count */
+#define SCALE_2000DPS          "0.001222" /**  (rad/sec)/count */
+
+#define GAIN_250DPS       "6548.089087"   /**  count/(rad/sec) */
+#define GAIN_500DPS       "3370.339971"   /**  count/(rad/sec) */
+#define GAIN_2000DPS      "818.511136"    /**  count/(rad/sec) */
+
+/* l3gd20 gyroscope registers */
+#define WHO_AM_I    (0x0F)
+
+#define CTRL_REG1   (0x20)          /* CTRL REG1 */
+#define CTRL_REG2   (0x21)          /* CTRL REG2 */
+#define CTRL_REG3   (0x22)          /* CTRL_REG3 */
+#define CTRL_REG4   (0x23)          /* CTRL_REG4 */
+#define CTRL_REG5   (0x24)          /* CTRL_REG5 */
+#define   REFERENCE  (0x25)          /* REFERENCE REG */
+
+#define OUT_X_LSB   (0x28)          /* 1st AXIS OUT REG of 6 */
+#define OUT_X_MSB   (0x29)
+#define OUT_Y_LSB   (0x2A)
+#define OUT_Y_MSB   (0x2B)
+#define OUT_Z_LSB   (0x2C)
+#define OUT_Z_MSB   (0x2D)
+#define   AXISDATA_REG    OUT_X_LSB
+
+#define   FIFO_CTRL_REG   (0x2E)          /* FIFO CONTROL REGISTER */
+#define FIFO_SRC_REG (0x2F)          /* FIFO SOURCE REGISTER */
+/* */
+
+/* CTRL_REG1 */
+#define ALL_ZEROES        (0x00)
+#define PM_OFF            (0x00)
+#define PM_NORMAL         (0x08)
+#define ENABLE_ALL_AXES        (0x07)
+#define ENABLE_NO_AXES         (0x00)
+#define BW00              (0x00)
+#define BW01              (0x10)
+#define BW10              (0x20)
+#define BW11              (0x30)
+#define CTRL_REG1_BW_MASK (0x30)
+#define ODR095            (0x00)  /* ODR =3D  95Hz */
+#define ODR190            (0x40)  /* ODR =3D 190Hz */
+#define ODR380            (0x80)  /* ODR =3D 380Hz */
+#define ODR760            (0xC0)  /* ODR =3D 760Hz */
+#define CTRL_REG1_ODR_MASK     (0xC0)
+
+
+/* CTRL_REG3 bits */
+#define   I2_DRDY              (0x08)
+#define   I2_WTM               (0x04)
+#define   I2_OVRUN        (0x02)
+#define   I2_EMPTY        (0x01)
+#define   I2_NONE              (0x00)
+#define   I2_MASK              (0x0F)
+
+/* CTRL_REG4 bits */
+#define   FS_MASK              (0x30)
+#define   BDU_ENABLE      (0x80)
+
+/* CTRL_REG5 bits */
+#define   FIFO_ENABLE          (0x40)
+#define HPF_ENALBE        (0x11)
+
+/* FIFO_CTRL_REG bits */
+#define   FIFO_MODE_MASK       (0xE0)
+#define   FIFO_MODE_BYPASS     (0x00)
+#define   FIFO_MODE_FIFO       (0x20)
+#define   FIFO_MODE_STREAM     (0x40)
+#define   FIFO_MODE_STR2FIFO   (0x60)
+#define   FIFO_MODE_BYPASS2STR (0x80)
+#define   FIFO_WATERMARK_MASK  (0x1F)
+
+#define FIFO_STORED_DATA_MASK  (0x1F)
+
+/* I2C multi read/write option*/
+#define I2C_AUTO_INCREMENT     (0x80)
+
+/* RESUME STATE INDICES */
+#define   RES_CTRL_REG1        0
+#define   RES_CTRL_REG2        1
+#define   RES_CTRL_REG3        2
+#define   RES_CTRL_REG4        3
+#define   RES_CTRL_REG5        4
+#define   RES_FIFO_CTRL_REG    5
+#define   RESUME_ENTRIES       6
+
+
+/** Registers Contents */
+#define WHOAMI_L3GD20     (0x00D4)   /* Expected content for WAI register*=
/
+
+
+struct output_rate {
+    unsigned int poll_rate_ms;
+    u8 sampling_rate_setting;
+    const char *hz_label;
+};
+
+static const struct output_rate l3gd20_gyr_odr_table[] =3D {
+
+    {    2,   ODR760|BW10,    "760"},
+    {    3,   ODR380|BW01,    "380"},
+    {    6,   ODR190|BW00,    "190"},
+    {    11,  ODR095|BW00,    "95"},
+};
+
+static struct l3gd20_gyr_platform_data default_l3gd20_gyr_pdata =3D {
+    .fs_range =3D L3GD20_GYR_FS_250DPS,
+    .axis_map_x =3D 0,
+    .axis_map_y =3D 1,
+    .axis_map_z =3D 2,
+    .negate_x =3D 0,
+    .negate_y =3D 0,
+    .negate_z =3D 0,
+
+    .gpio_int1 =3D DEFAULT_INT1_GPIO,
+    .gpio_int2 =3D DEFAULT_INT2_GPIO,      /* int for fifo */
+
+};
+
+struct l3gd20_gyr_status {
+
+    struct work_struct              work_trigger_to_ring;
+    s64                        last_timestamp;
+    struct iio_dev                  *indio_dev;
+    struct iio_trigger              *trig;
+
+    struct i2c_client               *client;
+    struct l3gd20_gyr_platform_data      *pdata;
+    int                        use_smbus;
+
+    struct mutex                    lock;
+    int                        hw_initialized;
+
+    atomic_t                   enabled;
+
+    char const                 *scale;
+    char const                 *gain;
+
+    u8                         reg_addr;
+    u8                         resume_state[RESUME_ENTRIES];
+
+
+    int                        irq1;
+    int                        irq2;
+
+};
+
+static int l3gd20_gyr_i2c_read(struct l3gd20_gyr_status *data,
+                                    u8 *buf, int len)
+{
+    int ret;
+    u8 reg =3D buf[0];
+    u8 cmd =3D reg;
+
+    if (len > 1)
+          cmd =3D (I2C_AUTO_INCREMENT | reg);
+    if (data->use_smbus) {
+          if (len =3D=3D 1) {
+               ret =3D i2c_smbus_read_byte_data(data->client, cmd);
+               buf[0] =3D ret & 0xff;
+#ifdef DEBUG
+               dev_dbg(&data->client->dev,
+                    "i2c_smbus_read_byte_data: ret=3D0x%02x, len:%d ,"
+                    "command=3D0x%02x, buf[0]=3D0x%02x\n",
+                    ret, len, cmd , buf[0]);
+#endif
+          } else if (len > 1) {
+               ret =3D i2c_smbus_read_i2c_block_data(data->client,
+                                          cmd, len, buf);
+#ifdef DEBUG
+               dev_dbg(&data->client->dev,
+                    "i2c_smbus_read_i2c_block_data: ret:%d len:%d, "
+                    "command=3D0x%02x, ",
+                    ret, len, cmd);
+               char ii;
+               for (ii =3D 0; ii < len; ii++)
+                    pr_debug("buf[%d]=3D0x%02x,\n", ii, buf[ii]);
+#endif
+          } else
+               ret =3D -1;
+
+          if (ret < 0) {
+               dev_err(&data->client->dev,
+                    "read transfer error: len:%d, command=3D0x%02x\n",
+                    len, cmd);
+               return 0; /* failure */
+          }
+          return len; /* success */
+    }
+
+
+    ret =3D i2c_master_send(data->client, &cmd, sizeof(cmd));
+    if (ret !=3D sizeof(cmd))
+          return ret;
+
+    return i2c_master_recv(data->client, buf, len);
+}
+
+static int l3gd20_gyr_i2c_write(struct l3gd20_gyr_status *data, u8 *buf,
+                                          int len)
+{
+    int ret;
+    u8 reg, value;
+
+    if (len > 1)
+          buf[0] =3D (I2C_AUTO_INCREMENT | buf[0]);
+
+    reg =3D buf[0];
+    value =3D buf[1];
+
+    if (data->use_smbus) {
+          if (len =3D=3D 1) {
+               ret =3D i2c_smbus_write_byte_data(data->client, reg,
+                                               value);
+#ifdef DEBUG
+               dev_dbg(&data->client->dev,
+                    "i2c_smbus_write_byte_data: ret=3D%d, len:%d, "
+                    "command=3D0x%02x, value=3D0x%02x\n",
+                    ret, len, reg , value);
+#endif
+               return ret;
+          } else if (len > 1) {
+               ret =3D i2c_smbus_write_i2c_block_data(data->client,
+                                    reg, len, buf + 1);
+#ifdef DEBUG
+               dev_dbg(&data->client->dev,
+                    "i2c_smbus_write_i2c_block_data: ret=3D%d, "
+                    "len:%d, command=3D0x%02x, ",
+                    ret, len, reg);
+               char ii;
+               for (ii =3D 0; ii < len + 1; ii++)
+                    pr_debug("value[%d]=3D0x%02x,\n", ii, buf[ii]);
+#endif
+               return ret;
+          }
+    }
+
+    ret =3D i2c_master_send(data->client, buf, len+1);
+    return (ret =3D=3D len+1) ? 0 : ret;
+}
+
+
+static int l3gd20_gyr_register_write(struct l3gd20_gyr_status *data,
+          u8 *buf, u8 reg_address, u8 new_value)
+{
+    int err;
+
+          /* Sets configuration register at reg_address
+          *  NOTE: this is a straight overwrite  */
+          buf[0] =3D reg_address;
+          buf[1] =3D new_value;
+          err =3D l3gd20_gyr_i2c_write(data, buf, 1);
+          if (err < 0)
+               return err;
+
+    return err;
+}
+
+static int l3gd20_gyr_register_read(struct l3gd20_gyr_status *data,
+                               u8 *buf, u8 reg_address)
+{
+
+    int err =3D -1;
+    buf[0] =3D (reg_address);
+    err =3D l3gd20_gyr_i2c_read(data, buf, 1);
+    return err;
+}
+
+#define L3GD20_INFO_MASK IIO_CHAN_INFO_RAW_SEPARATE_BIT
+
+#define L3GD20_CHAN(addr, mod)                      \
+    {                                    \
+          .type =3D IIO_ANGL_VEL,                \
+          .modified =3D 1,                       \
+          .channel2 =3D mod,                     \
+          .info_mask =3D L3GD20_INFO_MASK,             \
+          .address =3D addr,                     \
+          .scan_type =3D {                       \
+               .sign =3D 's',                    \
+               .realbits =3D 16,                 \
+               .storagebits =3D 16,              \
+               .shift =3D 0,                     \
+          },                              \
+    }
+
+static struct iio_chan_spec l3gd20_channels[] =3D {
+    L3GD20_CHAN(OUT_X_LSB, IIO_MOD_X),
+    L3GD20_CHAN(OUT_Y_LSB, IIO_MOD_Y),
+    L3GD20_CHAN(OUT_Z_LSB, IIO_MOD_Z),
+};
+
+
+static int l3gd20_gyr_read_raw(struct iio_dev *indio_dev,
+                    struct iio_chan_spec const *chan,
+                    int *val,
+                    int *val2,
+                    long mask)
+{
+    struct l3gd20_gyr_status *data =3D iio_priv(indio_dev);
+    int err;
+    u8 out_data[2];
+    s16 val16;
+    out_data[0] =3D chan->address;
+    switch  (mask) {
+    case IIO_CHAN_INFO_RAW:
+          mutex_lock(&data->lock);
+          err =3D l3gd20_gyr_i2c_read(data, out_data, 2);
+          mutex_unlock(&data->lock);
+          if (err < 0)
+               return err;
+          val16 =3D ((s16) ((out_data[1]) << 8) | out_data[0]);
+          *val =3D val16;
+          return IIO_VAL_INT;
+    default:
+          return -EINVAL;
+    }
+}
+
+static int l3gd20_gyr_register_update(struct l3gd20_gyr_status *data,
+          u8 *buf, u8 reg_address, u8 mask, u8 new_bit_values)
+{
+    int err =3D -1;
+    u8 init_val;
+    u8 updated_val;
+    err =3D l3gd20_gyr_register_read(data, buf, reg_address);
+    if (!(err < 0)) {
+          init_val =3D buf[0];
+          updated_val =3D ((mask & new_bit_values) | ((~mask) & init_val))=
;
+          err =3D l3gd20_gyr_register_write(data, buf, reg_address,
+                    updated_val);
+    }
+    return err;
+}
+
+static int l3gd20_gyr_hw_init(struct l3gd20_gyr_status *dev_data)
+{
+    int err;
+    u8 buf[6];
+
+    pr_info("%s hw init\n", L3GD20_GYR_DEV_NAME);
+
+    buf[0] =3D (CTRL_REG1);
+    buf[1] =3D dev_data->resume_state[RES_CTRL_REG1];
+    buf[2] =3D dev_data->resume_state[RES_CTRL_REG2];
+    buf[3] =3D dev_data->resume_state[RES_CTRL_REG3];
+    buf[4] =3D dev_data->resume_state[RES_CTRL_REG4];
+    buf[5] =3D dev_data->resume_state[RES_CTRL_REG5];
+
+    err =3D l3gd20_gyr_i2c_write(dev_data, buf, 5);
+    if (err < 0)
+          return err;
+
+    buf[0] =3D FIFO_CTRL_REG;
+    buf[1] =3D dev_data->resume_state[RES_FIFO_CTRL_REG];
+    err =3D l3gd20_gyr_i2c_write(dev_data, buf, 1);
+    if (err < 0)
+               return err;
+
+    dev_data->hw_initialized =3D 1;
+
+    return err;
+}
+
+static void l3gd20_gyr_device_power_off(struct l3gd20_gyr_status *dev_data=
)
+{
+    int err;
+    u8 buf[2];
+
+    pr_info("%s power off\n", L3GD20_GYR_DEV_NAME);
+
+    buf[0] =3D CTRL_REG1;
+    buf[1] =3D PM_OFF;
+    err =3D l3gd20_gyr_i2c_write(dev_data, buf, 1);
+    if (err < 0)
+          dev_err(&dev_data->client->dev, "soft power off failed\n");
+
+    if (dev_data->pdata->power_off) {
+          dev_data->pdata->power_off();
+          dev_data->hw_initialized =3D 0;
+    }
+
+    if (dev_data->hw_initialized)
+          dev_data->hw_initialized =3D 0;
+}
+
+static int l3gd20_gyr_device_power_on(struct l3gd20_gyr_status *dev_data)
+{
+    int err;
+
+    if (dev_data->pdata->power_on) {
+          err =3D dev_data->pdata->power_on();
+          if (err < 0)
+               return err;
+    }
+
+
+    if (!dev_data->hw_initialized) {
+          err =3D l3gd20_gyr_hw_init(dev_data);
+          if (err < 0) {
+               l3gd20_gyr_device_power_off(dev_data);
+               return err;
+          }
+    }
+
+    return 0;
+}
+
+
+static int l3gd20_gyr_enable(struct l3gd20_gyr_status *dev_data)
+{
+    int err;
+
+    if (!atomic_cmpxchg(&dev_data->enabled, 0, 1)) {
+
+          err =3D l3gd20_gyr_device_power_on(dev_data);
+          if (err < 0) {
+               atomic_set(&dev_data->enabled, 0);
+               return err;
+          }
+
+    }
+
+    return 0;
+}
+
+static int l3gd20_gyr_disable(struct l3gd20_gyr_status *dev_data)
+{
+
+    pr_debug("%s: dev_data->enabled =3D %d\n", __func__,
+          atomic_read(&dev_data->enabled));
+
+    if (atomic_cmpxchg(&dev_data->enabled, 1, 0))
+          l3gd20_gyr_device_power_off(dev_data);
+
+    return 0;
+}
+
+static int l3gd20_gyr_update_fs_range(struct l3gd20_gyr_status *dev_data,
+                                    u8 new_fs_range)
+{
+    int res ;
+    u8 buf[2];
+    char const *scale;
+    char const *gain;
+    buf[0] =3D CTRL_REG4;
+
+    switch (new_fs_range) {
+    case L3GD20_GYR_FS_250DPS:
+          gain =3D GAIN_250DPS;
+          scale =3D SCALE_250DPS;
+          break;
+
+    case L3GD20_GYR_FS_500DPS:
+          gain =3D GAIN_500DPS;
+          scale =3D SCALE_500DPS;
+          break;
+
+    case L3GD20_GYR_FS_2000DPS:
+          gain =3D GAIN_2000DPS;
+          scale =3D SCALE_2000DPS;
+          break;
+
+    default:
+          dev_err(&dev_data->client->dev,
+                          "invalid fs range requested: %u\n",
+                          new_fs_range);
+          return -EINVAL;
+    }
+
+    res =3D l3gd20_gyr_register_update(dev_data, buf, CTRL_REG4,
+                                    FS_MASK, new_fs_range);
+
+    if (res < 0) {
+          pr_err("%s : failed to update fs:0x%02x\n",
+                                    __func__, new_fs_range);
+          return res;
+    }
+    dev_data->resume_state[RES_CTRL_REG4] =3D
+          ((FS_MASK & new_fs_range) |
+          (~FS_MASK & dev_data->resume_state[RES_CTRL_REG4]));
+    dev_data->gain =3D gain;
+    dev_data->scale =3D scale;
+    return res;
+}
+
+static int l3gd20_gyr_update_sampling_freq(struct l3gd20_gyr_status *data,
+                                    u8 freq)
+{
+    int res =3D 0;
+    u8 buf[2];
+    u8 new_value;
+    u8 mask =3D (CTRL_REG1_ODR_MASK|CTRL_REG1_BW_MASK);
+
+
+    new_value =3D freq;
+    res =3D l3gd20_gyr_register_update(data, buf, CTRL_REG1,
+                                    mask, new_value);
+
+    if (res < 0) {
+          dev_err(&data->client->dev,
+               "%s : failed to update sampling frequency setting\n",
+                                          __func__);
+          return res;
+    }
+    dev_dbg(&data->client->dev, "%s : new_value:0x%02x, freq:0x%02x\n",
+               __func__, new_value, freq);
+
+    data->resume_state[RES_CTRL_REG1] =3D
+          ((mask & new_value) |
+          (~mask & data->resume_state[RES_CTRL_REG1]));
+
+    data->pdata->sampling_frequency =3D new_value;
+
+    return res;
+}
+
+static ssize_t l3gd20_gyr_show_sampling_frequency(struct device *dev,
+                               struct device_attribute *attr,
+                               char *buf)
+{
+    struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+    struct l3gd20_gyr_status *data =3D iio_priv(indio_dev);
+    u8 i;
+    u8 val;
+
+
+    mutex_lock(&data->lock);
+    val =3D data->pdata->sampling_frequency;
+    mutex_unlock(&data->lock);
+    dev_dbg(dev, "getting sampling frequency: 0x%02x\n", val);
+
+    for (i =3D 0; i < ARRAY_SIZE(l3gd20_gyr_odr_table); i++)
+          if (l3gd20_gyr_odr_table[i].sampling_rate_setting =3D=3D val)
+               break;
+
+    return sprintf(buf, "%s\n", l3gd20_gyr_odr_table[i].hz_label);
+}
+
+static ssize_t l3gd20_gyr_store_sampling_frequency(struct device *dev,
+                               struct device_attribute *attr,
+                               const char *buf, size_t size)
+{
+    struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+    struct l3gd20_gyr_status *data =3D iio_priv(indio_dev);
+    u8 found =3D 0;
+    u8 i;
+    u8 ret;
+
+    for (i =3D 0; i < ARRAY_SIZE(l3gd20_gyr_odr_table); i++) {
+          if (strcmp(buf, l3gd20_gyr_odr_table[i].hz_label) =3D=3D 0) {
+               found =3D 1;
+               break;
+          }
+    }
+
+    if (!found) {
+          dev_err(dev, "trying to set invalid sampling frequency: %s\n"
+                    "new sampling frequency not set!\n", buf);
+          return  -EINVAL;
+    } else {
+          mutex_lock(&data->lock);
+          ret =3D l3gd20_gyr_update_sampling_freq(data,
+               l3gd20_gyr_odr_table[i].sampling_rate_setting);
+          if (ret < 0)
+               goto error;
+          data->pdata->sampling_frequency =3D
+               l3gd20_gyr_odr_table[i].sampling_rate_setting;
+          dev_info(dev, "set new sampling frequency: %s Hz\n",
+                          l3gd20_gyr_odr_table[i].hz_label);
+          mutex_unlock(&data->lock);
+    }
+    return size;
+error:
+    mutex_unlock(&data->lock);
+    return ret;
+}
+
+
+static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
+          l3gd20_gyr_show_sampling_frequency,
+          l3gd20_gyr_store_sampling_frequency);
+
+static ssize_t l3gd20_gyr_show_enable(struct device *dev,
+                      struct device_attribute *attr, char *buf)
+{
+    struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+    struct l3gd20_gyr_status *data =3D iio_priv(indio_dev);
+    int val =3D atomic_read(&data->enabled);
+    return sprintf(buf, "%d\n", val);
+}
+
+static ssize_t l3gd20_gyr_store_enable(struct device *dev,
+                      struct device_attribute *attr,
+                      const char *buf, size_t size)
+{
+    struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+    struct l3gd20_gyr_status *data =3D iio_priv(indio_dev);
+    unsigned long val;
+
+    if (kstrtoul(buf, 10, &val))
+          return -EINVAL;
+
+    if (val)
+          l3gd20_gyr_enable(data);
+    else
+          l3gd20_gyr_disable(data);
+
+    return size;
+}
+
+static IIO_DEVICE_ATTR(enable_device,
+               S_IWUSR | S_IRUGO,
+               l3gd20_gyr_show_enable,
+               l3gd20_gyr_store_enable,
+               0);
+
+static ssize_t l3gd20_gyr_show_range(struct device *dev,
+                          struct device_attribute *attr,
+                          char *buf)
+{
+    struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+    struct l3gd20_gyr_status *data =3D iio_priv(indio_dev);
+    int label =3D 0;
+    u8 val;
+    mutex_lock(&data->lock);
+    val =3D data->pdata->fs_range;
+    mutex_unlock(&data->lock);
+
+    switch (val) {
+    case L3GD20_GYR_FS_250DPS:
+          label =3D 250;
+          break;
+    case L3GD20_GYR_FS_500DPS:
+          label =3D 500;
+          break;
+    case L3GD20_GYR_FS_2000DPS:
+          label =3D 2000;
+          break;
+    }
+
+    return sprintf(buf, "%d dps\n", label);
+}
+
+static ssize_t l3gd20_gyr_store_range(struct device *dev,
+                            struct device_attribute *attr,
+                            const char *buf,
+                            size_t size)
+{
+    struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+    struct l3gd20_gyr_status *data =3D iio_priv(indio_dev);
+    unsigned long val;
+    u8 range;
+    int err =3D -1;
+    if (kstrtoul(buf, 10, &val)) {
+          dev_err(dev, "invalid range %lu\n. Range not changed", val);
+          return -EINVAL;
+    }
+    switch (val) {
+    case 250:
+          range =3D L3GD20_GYR_FS_250DPS;
+          break;
+    case 500:
+         range =3D L3GD20_GYR_FS_500DPS;
+          break;
+    case 2000:
+          range =3D L3GD20_GYR_FS_2000DPS;
+          break;
+    default:
+          dev_err(dev, "invalid range %lu. Range not changed\n", val);
+          return -EINVAL;
+    }
+
+    mutex_lock(&data->lock);
+    data->pdata->fs_range =3D range;
+    err =3D l3gd20_gyr_update_fs_range(data, range);
+    mutex_unlock(&data->lock);
+    if (err < 0)
+          goto error;
+    dev_info(dev, "set range to %lu dps\n", val);
+    return size;
+error:
+    dev_err(dev, "error changing range\n");
+    return err;
+}
+
+
+
+static IIO_DEVICE_ATTR(gyro_range,
+               S_IWUSR | S_IRUGO,
+               l3gd20_gyr_show_range,
+               l3gd20_gyr_store_range,
+               0);
+
+
+static IIO_CONST_ATTR(gyro_range_available, "250 500 2000");
+
+
+static ssize_t l3gd20_gyr_show_gain(struct device *dev,
+                               struct device_attribute *attr,
+                               char *buf)
+{
+    struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+    struct l3gd20_gyr_status *data =3D iio_priv(indio_dev);
+    return sprintf(buf, "%s\n", data->gain);
+}
+
+static IIO_DEVICE_ATTR(gyro_gain, S_IRUGO,
+               l3gd20_gyr_show_gain,
+               NULL , 0);
+
+
+static ssize_t l3gd20_gyr_show_scale(struct device *dev,
+                          struct device_attribute *attr,
+                          char *buf)
+{
+    struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+    struct l3gd20_gyr_status *data =3D iio_priv(indio_dev);
+    return sprintf(buf, "%s\n", data->scale);
+}
+
+static IIO_DEVICE_ATTR(gyro_scale, S_IRUGO,
+               l3gd20_gyr_show_scale,
+               NULL , 0);
+
+static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("95 190 380 760");
+
+static IIO_CONST_ATTR(name, L3GD20_GYR_DEV_NAME);
+
+
+
+static struct attribute *l3gd20_gyr_attributes[] =3D {
+    &iio_const_attr_name.dev_attr.attr,
+    &iio_dev_attr_enable_device.dev_attr.attr,
+    &iio_const_attr_gyro_range_available.dev_attr.attr,
+    &iio_dev_attr_gyro_range.dev_attr.attr,
+    &iio_dev_attr_gyro_gain.dev_attr.attr,
+    &iio_dev_attr_gyro_scale.dev_attr.attr,
+    &iio_dev_attr_sampling_frequency.dev_attr.attr,
+    &iio_const_attr_sampling_frequency_available.dev_attr.attr,
+    NULL
+};
+
+static const struct attribute_group l3gd20_gyr_attribute_group =3D {
+    .attrs =3D l3gd20_gyr_attributes,
+};
+
+static const struct iio_info l3gd20_gyr_info =3D {
+    .attrs =3D &l3gd20_gyr_attribute_group,
+    .read_raw =3D &l3gd20_gyr_read_raw,
+    .driver_module =3D THIS_MODULE,
+};
+
+static int l3gd20_gyr_validate_pdata(struct l3gd20_gyr_status *dev_data)
+{
+
+    if (dev_data->pdata->axis_map_x > 2 ||
+        dev_data->pdata->axis_map_y > 2 ||
+        dev_data->pdata->axis_map_z > 2) {
+          dev_err(&dev_data->client->dev,
+               "invalid axis_map value x:%u y:%u z%u\n",
+               dev_data->pdata->axis_map_x,
+               dev_data->pdata->axis_map_y,
+               dev_data->pdata->axis_map_z);
+          return -EINVAL;
+    }
+
+    /* Only allow 0 and 1 for negation boolean flag */
+    if (dev_data->pdata->negate_x > 1 ||
+        dev_data->pdata->negate_y > 1 ||
+        dev_data->pdata->negate_z > 1) {
+          dev_err(&dev_data->client->dev,
+               "invalid negate value x:%u y:%u z:%u\n",
+               dev_data->pdata->negate_x,
+               dev_data->pdata->negate_y,
+               dev_data->pdata->negate_z);
+          return -EINVAL;
+    }
+
+    return 0;
+}
+
+static int l3gd20_gyr_probe(struct i2c_client *client,
+          const struct i2c_device_id *id)
+{
+    struct l3gd20_gyr_status *stat;
+    struct iio_dev *indio_dev;
+    int err =3D -1;
+    u32 smbus_func;
+    int regdone =3D 0;
+    indio_dev =3D iio_device_alloc(sizeof(*stat));
+    if (indio_dev =3D=3D NULL) {
+          err =3D -ENOMEM;
+          dev_err(&client->dev,
+                    "failed to allocate memory for module stat: "
+                          "%d\n", err);
+          goto exit_check_functionality_failed;
+    }
+
+    stat =3D iio_priv(indio_dev);
+    smbus_func =3D I2C_FUNC_SMBUS_BYTE_DATA |
+               I2C_FUNC_SMBUS_WORD_DATA | I2C_FUNC_SMBUS_I2C_BLOCK;
+    pr_info("%s: probe start.\n", L3GD20_GYR_DEV_NAME);
+
+    /* Support for both I2C and SMBUS adapter interfaces. */
+    if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
+          dev_warn(&client->dev, "client not i2c capable\n");
+          if (i2c_check_functionality(client->adapter, smbus_func)) {
+               stat->use_smbus =3D 1;
+               dev_warn(&client->dev, "client using SMBUS\n");
+          } else {
+               err =3D -ENODEV;
+               dev_err(&client->dev, "client nor SMBUS capable\n");
+               stat->use_smbus =3D 0;
+               goto exit_check_functionality_failed;
+          }
+    }
+
+    mutex_init(&stat->lock);
+    mutex_lock(&stat->lock);
+    stat->client =3D client;
+    i2c_set_clientdata(client, indio_dev);
+    stat->pdata =3D kmalloc(sizeof(*stat->pdata), GFP_KERNEL);
+    if (stat->pdata =3D=3D NULL) {
+          err =3D -ENOMEM;
+          dev_err(&client->dev,
+                    "failed to allocate memory for pdata: %d\n",
+                    err);
+          goto err_mutexunlock;
+    }
+
+    if (client->dev.platform_data =3D=3D NULL) {
+          memcpy(stat->pdata, &default_l3gd20_gyr_pdata,
+                                    sizeof(*stat->pdata));
+          dev_info(&client->dev, "using default platform data\n");
+    } else {
+          memcpy(stat->pdata, client->dev.platform_data,
+                                    sizeof(*stat->pdata));
+    }
+
+    err =3D l3gd20_gyr_validate_pdata(stat);
+    if (err < 0) {
+          dev_err(&client->dev, "failed to validate platform data\n");
+          goto exit_kfree_pdata;
+    }
+
+
+    if (stat->pdata->init) {
+          err =3D stat->pdata->init();
+          if (err < 0) {
+               dev_err(&client->dev, "init failed: %d\n", err);
+               goto err_pdata_init;
+          }
+    }
+
+    memset(stat->resume_state, 0, ARRAY_SIZE(stat->resume_state));
+
+    stat->resume_state[RES_CTRL_REG1] =3D (ALL_ZEROES | PM_NORMAL
+                                    | ENABLE_ALL_AXES);
+    stat->resume_state[RES_CTRL_REG2] =3D ALL_ZEROES;
+    stat->resume_state[RES_CTRL_REG3] =3D ALL_ZEROES;
+    stat->resume_state[RES_CTRL_REG4] =3D (ALL_ZEROES | BDU_ENABLE);
+    stat->resume_state[RES_CTRL_REG5] =3D ALL_ZEROES;
+    stat->resume_state[RES_FIFO_CTRL_REG] =3D ALL_ZEROES;
+
+    err =3D l3gd20_gyr_device_power_on(stat);
+    if (err < 0) {
+          dev_err(&client->dev, "power on failed: %d\n", err);
+          goto exit_kfree_pdata;
+    }
+
+    atomic_set(&stat->enabled, 1);
+
+    err =3D l3gd20_gyr_update_fs_range(stat, stat->pdata->fs_range);
+    if (err < 0) {
+          dev_err(&client->dev, "update_fs_range failed\n");
+          goto  err_power_off;
+    }
+
+    err =3D l3gd20_gyr_update_sampling_freq(stat,
+                          stat->pdata->sampling_frequency);
+    if (err < 0) {
+          dev_err(&client->dev, "update sampling freq failed\n");
+          goto  err_power_off;
+    }
+
+    indio_dev->dev.parent =3D &client->dev;
+    indio_dev->modes =3D INDIO_DIRECT_MODE;
+    indio_dev->info =3D &l3gd20_gyr_info;
+    indio_dev->channels =3D l3gd20_channels;
+    indio_dev->num_channels =3D ARRAY_SIZE(l3gd20_channels);
+
+    l3gd20_gyr_device_power_off(stat);
+
+    /* As default, do not report information */
+    atomic_set(&stat->enabled, 0);
+    err =3D l3gd20_gyr_configure_ring(indio_dev);
+    if (err)
+          goto error_free_dev;
+
+    err =3D iio_device_register(indio_dev);
+    if (err) {
+          dev_err(&client->dev, "error registering iio dev: %d\n", err);
+          goto error_unreg_ring_funcs;
+    }
+    regdone =3D 1;
+
+    mutex_unlock(&stat->lock);
+    dev_info(&client->dev, "%s: probed\n", L3GD20_GYR_DEV_NAME);
+    return 0;
+
+
+
+error_unreg_ring_funcs:
+    l3gd20_gyr_unconfigure_ring(stat->indio_dev);
+error_free_dev:
+    if (regdone)
+          iio_device_unregister(indio_dev);
+    else
+          iio_device_free(indio_dev);
+err_power_off:
+    l3gd20_gyr_device_power_off(stat);
+err_pdata_init:
+    if (stat->pdata->exit)
+          stat->pdata->exit();
+exit_kfree_pdata:
+    kfree(stat->pdata);
+err_mutexunlock:
+    mutex_unlock(&stat->lock);
+exit_check_functionality_failed:
+    pr_err("%s: Driver Init failed\n", L3GD20_GYR_DEV_NAME);
+    return err;
+}
+
+
+static int __devexit l3gd20_gyr_remove(struct i2c_client *client)
+{
+    struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
+    struct l3gd20_gyr_status *dev_data =3D iio_priv(indio_dev);
+
+    iio_device_unregister(indio_dev);
+    l3gd20_gyr_device_power_off(dev_data);
+
+    l3gd20_gyr_unconfigure_ring(indio_dev);
+    iio_device_free(indio_dev);
+
+    return 0;
+}
+
+static const struct i2c_device_id l3gd20_gyr_id[] =3D {
+    { L3GD20_GYR_DEV_NAME , 0 },
+    {},
+};
+
+MODULE_DEVICE_TABLE(i2c, l3gd20_gyr_id);
+
+static struct i2c_driver l3gd20_gyr_driver =3D {
+    .driver =3D {
+               .owner =3D THIS_MODULE,
+               .name =3D L3GD20_GYR_DEV_NAME,
+            },
+    .probe =3D l3gd20_gyr_probe,
+    .remove =3D __devexit_p(l3gd20_gyr_remove),
+    .id_table =3D l3gd20_gyr_id,
+};
+
+module_i2c_driver(l3gd20_gyr_driver);
+
+MODULE_DESCRIPTION("STMicroelectronics l3gd20 digital gyroscope iio driver=
");
+MODULE_AUTHOR("Matteo Dameno, Swapnil Tiwari, STMicroelectronics");
+MODULE_LICENSE("GPL v2");
--
1.7.5.4

Jon,
The driver is in the staging area since all the other gyro drivers haven't =
moved. It doesn't have any relative paths for headers so it can be easily m=
oved in future without modification.

P.S.: The driver has been tested successfully on Pandaboard-ES with OMAP446=
0 processor with latest kernel.


Thanks and Regards,
Swapnil Tiwari

STMicroelectronics, Inc

+1-408-919-8606 (desk) ; 1168606 (TINA)
+1-949-981-8194 (mobile)


--_000_494E38452A01E745B763C5F242AAA2CCC5111C8FD9SAFEX1MAIL1st_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40"><head><META HTTP-EQUIV=3D"Content-Type" CONTENT=
=3D"text/html; charset=3Dus-ascii"><meta name=3DGenerator content=3D"Micros=
oft Word 14 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3Dblue vli=
nk=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>Add STMicroelectron=
ics L3GD20 gyroscope device driver<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'><=
o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>Signed-off-by: Swapnil Tiwari =
&lt;<a href=3D"mailto:swapnil.tiwari@st.com">swapnil.tiwari@st.com</a>&gt;<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>---<o:p></o:p></span></p><p class=3D=
MsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier=
 New"'>drivers/staging/iio/gyro/Kconfig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 9 +<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>drivers/staging/iio/gyro/Makefile&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 3 +<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>drivers/staging/iio/gyro/l3gd20.h&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 155 +++++<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>drivers/staging/iio/gyro/l3gd20_gyr_core.c | 1030 +++++++++++++++=
+++++++++++++<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>4 files changed, 1197 =
insertions(+), 0 deletions(-)<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>create=
 mode 100644 drivers/staging/iio/gyro/l3gd20.h<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>create mode 100644 drivers/staging/iio/gyro/l3gd20_gyr_core.c<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'><o:p>&nbsp;</o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>diff --git a/drivers/staging/iio/gyro/Kconfig b/drivers/staging/i=
io/gyro/Kconfig<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>index ea295b2..47698=
cb 100644<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>--- a/drivers/staging/iio/=
gyro/Kconfig<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+++ b/drivers/staging/i=
io/gyro/Kconfig<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>@@ -46,4 +46,13 @@ c=
onfig ADXRS450<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>&nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;This driver can also be built as a module.&nbsp; If so, the modul=
e<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><=
span style=3D'font-family:"Courier New"'>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;wil=
l be called adxrs450.<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'><o:p>&nbsp;</o=
:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span styl=
e=3D'font-family:"Courier New"'>+config L3GD20_GYR_IIO<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tristate &quot;STM=
 L3GD20 3 Axis Digital Gyroscope Sensor I2C driver (iio)&quot;<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on=
 I2C<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none=
'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; help<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Say yes here to build support for the STMic=
rolectronics L3GD20 3 Axis<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Digital .<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; To compile this driver as a module, choose M here: the module<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; will be called l3gd20_gyr_iio.<o:p></o:p></span></p><p class=3D=
MsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier=
 New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>endmenu<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>diff --git a/drivers/staging/iio/gyro/Makefile b/driver=
s/staging/iio/gyro/Makefile<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>index 9b=
a5ec1..c5d2879 100644<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>--- a/drivers/=
staging/iio/gyro/Makefile<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+++ b/dr=
ivers/staging/iio/gyro/Makefile<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>@@ -=
20,3 +20,6 @@ obj-$(CONFIG_ADIS16251) +=3D adis16251.o<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>&nbsp;ad=
xrs450-y&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; :=3D adxrs450_core.o<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>obj-$(CO=
NFIG_ADXRS450) +=3D adxrs450.o<o:p></o:p></span></p><p class=3DMsoNormal st=
yle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p=
></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"Courier New"'>+l3gd20_gyr-y&nbsp;&nbsp;&nbsp; :=3D l3=
gd20_gyr_core.o<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+obj-$(CONFIG_L3GD20=
_GYR_IIO) +=3D l3gd20_gyr.o<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>diff --g=
it a/drivers/staging/iio/gyro/l3gd20.h b/drivers/staging/iio/gyro/l3gd20.h<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>new file mode 100644<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>index 0000000..c7abb3d<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>--- /dev/null<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+++ b/drive=
rs/staging/iio/gyro/l3gd20.h<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>@@ -0,0=
 +1,155 @@<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospac=
e:none'><span style=3D'font-family:"Courier New"'>+/******************** (C=
) COPYRIGHT 2011 STMicroelectronics ********************<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+*<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+* File Name=
&nbsp;&nbsp;&nbsp; : l3gd20_iio.h<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+*=
 Authors : MH - C&amp;I BU - Application Team<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : Matteo Damen=
o (<a href=3D"mailto:matteo.dameno@st.com">matteo.dameno@st.com</a><o:p></o=
:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span styl=
e=3D'font-family:"Courier New"'>+*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; : author is willing to be considered the contact<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : a=
nd update points for the driver.<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+* =
Version : V.2.0.0<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+* Date&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 2011/Aug/16<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+* Description&nbsp; : L3GD20 3 Axis Digital Gyroscope Sens=
or device driver iio<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+*&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :<o:p></o:p></span></p><p class=3DMsoNo=
rmal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"=
'>+************************************************************************=
********<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+*<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+* This program is free software; you can redistribute it an=
d/or modify<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+* it under the terms of=
 the GNU General Public License version 2 as<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+* published by the Free Software Foundation.<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+*<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+* THE PRESEN=
T SOFTWARE IS PROVIDED ON AN &quot;AS IS&quot; BASIS, WITHOUT WARRANTIES<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+* OR CONDITIONS OF ANY KIND, EITHER E=
XPRESS OR IMPLIED, FOR THE SOLE<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+* P=
URPOSE TO SUPPORT YOUR APPLICATION DEVELOPMENT.<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+* AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR=
 ANY DIRECT,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+* INDIRECT OR CONSEQUE=
NTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING FROM THE<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+* CONTENT OF SUCH SOFTWARE AND/OR THE USE MADE BY CU=
STOMERS OF THE CODING<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+* INFORMATION=
 CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+*<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+***************=
****************************************************************/<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+/******************************************=
*************************************<o:p></o:p></span></p><p class=3DMsoNo=
rmal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"=
'>+Version History.<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+ Revision 2.0.0=
: 2012/Nov/16<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+&nbsp; first ioo impl=
ementation;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+***********************=
********************************************************/<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+#ifndef __L=
3GD20_H__<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+#define __L3GD20_H__<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+#define L3GD20_GYR_DEV_NAME&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;l3gd20_gyr_iio&quot;<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+#define L3GD20_GYR_FS_250DPS&nbsp;&nbsp; 0x00<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+#define L3GD20_GYR_FS_500DPS&nbsp;&nbsp; 0x10<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+#define L3GD20_GYR_FS_2000DPS&nbsp; 0x30<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+#d=
efine L3GD20_GYR_ENABLED&nbsp;&nbsp;&nbsp;&nbsp; 1<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+#define L3GD20_GYR_DISABLED&nbsp;&nbsp;&nbsp; 0<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+#ifdef __KERNEL__<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+/* to set gpios=
 numb connected to gyro interrupt pins,<o:p></o:p></span></p><p class=3DMso=
Normal style=3D'text-autospace:none'><span style=3D'font-family:"Courier Ne=
w"'>+ * the unused ones have to be set to -EINVAL<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+ */<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+#define DEFAULT_=
INT1_GPIO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (-EINVAL)<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+#define DEFAULT_INT2_GPIO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (-EI=
NVAL)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+#define SAD0L&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+#define SAD0H&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x01<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+#define L3GD20_GYR_I2C_SADROOT&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 0x35<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+#define L3=
GD20_GYR_I2C_SAD_L&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((L3GD20_GYR_I=
2C_SADROOT&lt;&lt;1)|SAD0L)<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+#define=
 L3GD20_GYR_I2C_SAD_H&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((L3GD20_GY=
R_I2C_SADROOT&lt;&lt;1)|SAD0H)<o:p></o:p></span></p><p class=3DMsoNormal st=
yle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p=
></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"Courier New"'>+#define L3GD20_MIN_POLL_PERIOD_MS&nbsp=
;&nbsp; 2<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+struct l3gd20_gyr_platform_data {<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+&nbsp;&nbsp;&nbsp; int (*init)(void);<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+&nbsp;&nbsp;&nbsp; void (*exit)(void);<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+&nbsp;&nbsp;&nbsp; int (*power_on)(void);<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; int (*power_off)(void);<o:p=
></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; unsigned int poll_i=
nterval;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; unsigne=
d int min_interval;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; u8 fs_range;<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+&nbsp;&nbsp;&nbsp; u8 sampling_frequency;<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp; /* set gpio_int[1,2] either to the choosen gpio pin number=
 or to -EINVAL<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; *=
 if leaved unconnected<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;=
&nbsp; */<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; int gp=
io_int1;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; int gpi=
o_int2;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* int for fifo */<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;=
&nbsp;&nbsp; /* axis mapping */<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nb=
sp;&nbsp;&nbsp; u8 axis_map_x;<o:p></o:p></span></p><p class=3DMsoNormal st=
yle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbs=
p;&nbsp;&nbsp; u8 axis_map_y;<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp=
;&nbsp;&nbsp; u8 axis_map_z;<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; u8 negate_x;<o:p></o:=
p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; u8 negate_y;<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; u8 negate_z;<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+};<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+#ifdef CONFIG_IIO_RING_BUFFER<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+/* At the moment triggers are only used for=
 ring buffer<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+ * filling. This may c=
hange!<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+ */<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>+enum l3gd20_gyr_sc=
an {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none=
'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; L3GD20_GYR_=
SCAN_GYR_X,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; L3GD=
20_GYR_SCAN_GYR_Y,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbs=
p; L3GD20_GYR_SCAN_GYR_Z,<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+};<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+void l3gd20_gyr_remove_trigger(struct iio_dev *indio_dev);<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+int l3gd20_gyr_probe_trigger(struct iio_dev *indi=
o_dev);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:n=
one'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+ssize_t l3gd20_gyr_read_data_from_ring(struct device *dev,<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; char *buf);<o:p></o:p></span></p><p class=3DMso=
Normal style=3D'text-autospace:none'><span style=3D'font-family:"Courier Ne=
w"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+int l3gd20_gyr_configure_ring(struct iio_dev *indio_dev);<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+void l3gd20_gyr_unconfigure_ring(struct =
iio_dev *indio_dev);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+int l3gd20_gyr_initialize_ring(struct iio_ring_b=
uffer *ring);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+void l3gd20_gyr_unini=
tialize_ring(struct iio_ring_buffer *ring);<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+#else /* CONFIG_IIO_RING_BUFFER */<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+static inline void l3gd=
20_gyr_remove_trigger(struct iio_dev *indio_dev)<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+{<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+}<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+static inli=
ne int l3gd20_gyr_probe_trigger(struct iio_dev *indio_dev)<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+{<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp; return 0;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+}<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+stati=
c inline ssize_t<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>+l3gd20_gyr_read_da=
ta_from_ring(struct device *dev,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 char *buf)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+{<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+}<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+static int l3gd20_gyr_configure_ring(struct iio_dev *i=
ndio_dev)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+{<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+}<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+static inline void l3gd20_gyr_unconfigure_ring(struct ii=
o_dev *indio_dev)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+{<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+}<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+/*<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+static inline int l3gd20_gyr_initialize=
_ring(struct iio_ring_buffer *ring)<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+{<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; return 0;<o:p=
></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"Courier New"'>+}<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none=
'><span style=3D'font-family:"Courier New"'>+static inline void l3gd20_gyr_=
uninitialize_ring(struct iio_ring_buffer *ring)<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+{<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+}<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+*/<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+#endif /* =
CONFIG_IIO_RING_BUFFER */<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+#endif /* __KERNEL__ */<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+#endif&nbsp=
; /* __L3GD20_H__ */<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>diff --git a/dr=
ivers/staging/iio/gyro/l3gd20_gyr_core.c b/drivers/staging/iio/gyro/l3gd20_=
gyr_core.c<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospac=
e:none'><span style=3D'font-family:"Courier New"'>new file mode 100644<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>index 0000000..5bb888c<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>--- /dev/null<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+++ b/drivers/staging/iio/gyro/l3gd20_gyr_core.c<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>@@ -0,0 +1,1030 @@<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+/**=
****************** (C) COPYRIGHT 2011 STMicroelectronics ******************=
**<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+*<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+* File Name&nbsp;&nbsp;&nbsp; : l3gd20_gyr_core_iio.c<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+* Authors : MSH - Motion Mems BU - Applicat=
ion Team<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+*&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; : Matteo Dameno (<a href=3D"mailto:matteo.dameno@st=
.com">matteo.dameno@st.com</a>)<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+*&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : Swapnil Tiwari (<a href=3D=
"mailto:swapnil.tiwari@st.com">swapnil.tiwari@st.com</a>)<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : =
Author is willing to be considered the contact<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : and update =
points for the driver.*<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+* Version :=
 V.2.0.0<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+* Date&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; : 2011/Nov/16<o:p></o:p></span></p><p class=3D=
MsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier=
 New"'>+* Description&nbsp; : L3GD20 3 Axis Digital Gyroscope Sensor device=
 driver iio<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+*&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; :<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+******=
**************************************************************************<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+*<o:p></o:p></span></p><p class=3DM=
soNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier =
New"'>+* This program is free software; you can redistribute it and/or modi=
fy<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+* it under the terms of the GNU =
General Public License version 2 as<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+* published by the Free Software Foundation.<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+*<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+* THE PRESENT SOFTWARE=
 IS PROVIDED ON AN &quot;AS IS&quot; BASIS, WITHOUT WARRANTIES<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+* OR CONDITIONS OF ANY KIND, EITHER EXPRESS OR =
IMPLIED, FOR THE SOLE<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+* PURPOSE TO =
SUPPORT YOUR APPLICATION DEVELOPMENT.<o:p></o:p></span></p><p class=3DMsoNo=
rmal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"=
'>+* AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY DIREC=
T,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+* INDIRECT OR CONSEQUENTIAL DAMA=
GES WITH RESPECT TO ANY CLAIMS ARISING FROM THE<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+* CONTENT OF SUCH SOFTWARE AND/OR THE USE MADE BY CUSTOMERS OF=
 THE CODING<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+* INFORMATION CONTAINED=
 HEREIN IN CONNECTION WITH THEIR PRODUCTS.<o:p></o:p></span></p><p class=3D=
MsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier=
 New"'>+*<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+*************************=
*******************************************************<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+ Revision 2.0.0: 2012/Nov/16<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+&nbsp; first ioo implementation;<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+*********************=
**********************************************************/<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+#includ=
e &lt;linux/err.h&gt;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+#include &lt;=
linux/errno.h&gt;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+#include &lt;linu=
x/delay.h&gt;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+#include &lt;linux/fs=
.h&gt;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+#include &lt;linux/i2c.h&gt;=
<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><s=
pan style=3D'font-family:"Courier New"'>+#include &lt;linux/mutex.h&gt;<o:p=
></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"Courier New"'>+#include &lt;linux/input.h&gt;<o:p></o=
:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span styl=
e=3D'font-family:"Courier New"'>+#include &lt;linux/uaccess.h&gt;<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+#include &lt;linux/workqueue.h&gt;<o:p></o:=
p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+#include &lt;linux/irq.h&gt;<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+#include &lt;linux/gpio.h&gt;<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+#include &lt;linux/interrupt.h&gt;<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+#include &lt;linux/gpio.h&gt;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+#include &lt;linux/slab.h&gt;<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+#include &lt;linux/device.h&gt;<o:p></o:p></span></p><p class=3D=
MsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier=
 New"'>+#include &lt;linux/kernel.h&gt;<o:p></o:p></span></p><p class=3DMso=
Normal style=3D'text-autospace:none'><span style=3D'font-family:"Courier Ne=
w"'>+#include &lt;linux/module.h&gt;<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+#include &lt;linux/sysfs.h&gt;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+#i=
nclude &lt;linux/moduleparam.h&gt;<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+=
#include &quot;linux/iio/iio.h&quot;<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+#include &quot;linux/iio/sysfs.h&quot;<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+#include &quot;l3gd20.h&quot;<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><=
span style=3D'font-family:"Courier New"'>+#define SENSITIVITY_250DPS&nbsp;&=
nbsp;&nbsp;&nbsp; &quot;8.75&quot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; /**&nbsp; mdps/counts */<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+#define SENSITIVITY_500DPS&nbsp;&nbsp;&nbsp;&nbsp; &quot;17.50&quot;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**&nbsp; mdps/counts */<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+#define SENSITIVITY_2000DPS&nbsp;&nbsp;=
&nbsp; &quot;70.00&quot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*=
*&nbsp; mdps/counts */<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+#define SCALE_250DPS&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &quot;0.000153&quot; /**&nbsp; (rad/sec)/count */<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+#define SCALE_500DPS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quo=
t;0.000297&quot; /**&nbsp; (rad/sec)/count */<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+#define SCALE_2000DPS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; &quot;0.001222&quot; /**&nbsp; (rad/sec)/count */<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+#define=
 GAIN_250DPS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;6548.089087&quot;&nb=
sp;&nbsp; /**&nbsp; count/(rad/sec) */<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+#define GAIN_500DPS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;3370.3399=
71&quot;&nbsp;&nbsp; /**&nbsp; count/(rad/sec) */<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+#define GAIN_2000DPS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;818=
.511136&quot;&nbsp;&nbsp;&nbsp; /**&nbsp; count/(rad/sec) */<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+/* l3gd=
20 gyroscope registers */<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+#define=
 WHO_AM_I&nbsp;&nbsp;&nbsp; (0x0F)<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+=
<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><s=
pan style=3D'font-family:"Courier New"'>+#define CTRL_REG1&nbsp;&nbsp; (0x2=
0)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* CTRL REG1 */<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+#define CTRL_REG2&nbsp;&nbsp; (0x21)&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* CTRL REG2 */<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+#define CTRL_REG3&nbsp;&nbsp; (0x22)&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* CTRL_REG3 */<o:p></o:=
p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+#define CTRL_REG4&nbsp;&nbsp; (0x23)&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* CTRL_REG4 */<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+#define CTRL_REG5&nbsp;&nbsp; (0x24)&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* CTRL_REG5 */<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+#define&nbsp;&nbsp; REFERENCE&nbsp; (0x25)&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* REFERENCE REG */<o:p></o=
:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span styl=
e=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+#=
define OUT_X_LSB&nbsp;&nbsp; (0x28)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* 1st AXIS OUT REG of 6 */<o:p></o:p></span></p><p class=3D=
MsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier=
 New"'>+#define OUT_X_MSB&nbsp;&nbsp; (0x29)<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+#define OUT_Y_LSB&nbsp;&nbsp; (0x2A)<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+#define OUT_Y_MSB&nbsp;&nbsp; (0x2B)<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+#define OUT_Z_LSB&nbsp;&nbsp; (0x2C)<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+#define OUT_Z_MSB&nbsp;&nbsp; (0x2D)<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+#define&nbsp;&nbsp; AXISDATA_REG&nbsp;&nbsp;&nbsp; OUT_X=
_LSB<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none=
'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+#define&nbsp;&nbsp; FIFO_CTRL_REG&nbsp;&nbsp; (0x2E)&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* FIFO CONTROL REGISTER */<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+#define FIFO_SRC_REG (0x2F)&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* FIFO SOURCE REGISTER */<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+/* */<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+/* CTRL_REG1 */<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+#define ALL_ZEROES&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; (0x00)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+#define PM_OFF=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x00)<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+#define PM_NORMAL&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x08)<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+#define ENABLE_ALL_AXES&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x07)<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+#define ENABLE_NO_AXES&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x00)<o:p></o:p></span></p><p class=3D=
MsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier=
 New"'>+#define BW00&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; (0x00)<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+#define=
 BW01&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; (0x10)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+#define BW10&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x=
20)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+#define BW11&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x30)<o:p></o:=
p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+#define CTRL_REG1_BW_MASK (0x30)<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+#define ODR095&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x00)&nbsp; /* ODR =3D&nbsp; 95Hz */=
<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><s=
pan style=3D'font-family:"Courier New"'>+#define ODR190&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x40)&nbsp; /* ODR =3D 190H=
z */<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none=
'><span style=3D'font-family:"Courier New"'>+#define ODR380&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x80)&nbsp; /* ODR =3D =
380Hz */<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+#define ODR760&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0xC0)&nbsp; /* ODR =
=3D 760Hz */<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+#define CTRL_REG1_ODR_=
MASK&nbsp;&nbsp;&nbsp;&nbsp; (0xC0)<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><=
span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3D=
MsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier=
 New"'>+/* CTRL_REG3 bits */<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+#defin=
e&nbsp;&nbsp; I2_DRDY&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; (0x08)<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+#de=
fine&nbsp;&nbsp; I2_WTM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x04)<o:p></o:p></span></p><p class=3DMso=
Normal style=3D'text-autospace:none'><span style=3D'font-family:"Courier Ne=
w"'>+#define&nbsp;&nbsp; I2_OVRUN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 (0x02)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:n=
one'><span style=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; I2_EMPT=
Y&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x01)<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+#define&nbsp;&nbsp; I2_NONE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x00)<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+#define&nbsp;&nbsp; I2_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x0F)<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+/* CTRL_REG4=
 bits */<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; FS_MAS=
K&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (0x30)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; BDU=
_ENABLE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x80)<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+/* CTRL_REG5 bits */<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; FIFO_ENABLE&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x40)<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+#define HPF_ENALBE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; (0x11)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+/* FIFO_CTRL_REG bits */<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+#define&nbsp;&nbsp; FIFO_MODE_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; (0xE0)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; F=
IFO_MODE_BYPASS&nbsp;&nbsp;&nbsp;&nbsp; (0x00)<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+#define&nbsp;&nbsp; FIFO_MODE_FIFO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (0x20)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; =
FIFO_MODE_STREAM&nbsp;&nbsp;&nbsp;&nbsp; (0x40)<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+#define&nbsp;&nbsp; FIFO_MODE_STR2FIFO&nbsp;&nbsp; (0x60)<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; FIFO_MODE_BYPASS2ST=
R (0x80)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; FIFO_W=
ATERMARK_MASK&nbsp; (0x1F)<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+#define FIFO_STORED_DATA_MASK&nbsp; (0x1F=
)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><=
span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3D=
MsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier=
 New"'>+/* I2C multi read/write option*/<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+#define I2C_AUTO_INCREMENT&nbsp;&nbsp;&nbsp;&nbsp; (0x80)<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+/* RE=
SUME STATE INDICES */<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+#define&nbsp;=
&nbsp; RES_CTRL_REG1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; RES_CTRL_REG2&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+=
#define&nbsp;&nbsp; RES_CTRL_REG3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 2<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; RES_CTRL_REG=
4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+#define&nbsp;&nbsp; RES_CTRL_REG5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; 4<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; R=
ES_FIFO_CTRL_REG&nbsp;&nbsp;&nbsp; 5<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+#define&nbsp;&nbsp; RESUME_ENTRIES&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+/** Registers Contents */<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+#define WHOAMI_L3GD20&nbsp;&nbsp;&nbs=
p;&nbsp; (0x00D4)&nbsp;&nbsp; /* Expected content for WAI register*/<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+=
<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><s=
pan style=3D'font-family:"Courier New"'>+struct output_rate {<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; unsigned int poll_rate_ms;<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; u8 sampling_rate_s=
etting;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:n=
one'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; const ch=
ar *hz_label;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+};<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+static const=
 struct output_rate l3gd20_gyr_odr_table[] =3D {<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; {=
&nbsp;&nbsp;&nbsp; 2,&nbsp;&nbsp; ODR760|BW10,&nbsp;&nbsp;&nbsp; &quot;760&=
quot;},<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:n=
one'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; {&nbsp;&=
nbsp;&nbsp; 3,&nbsp;&nbsp; ODR380|BW01,&nbsp;&nbsp;&nbsp; &quot;380&quot;},=
<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><s=
pan style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp;&n=
bsp; 6,&nbsp;&nbsp; ODR190|BW00,&nbsp;&nbsp;&nbsp; &quot;190&quot;},<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp;&nbsp; 11=
,&nbsp; ODR095|BW00,&nbsp;&nbsp;&nbsp; &quot;95&quot;},<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+};<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+static struct l3gd20_gyr_platform_data defa=
ult_l3gd20_gyr_pdata =3D {<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp; .fs_range =3D L3GD20_GYR_FS_250DPS,<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+&nbsp;&nbsp;&nbsp; .axis_map_x =3D 0,<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+&nbsp;&nbsp;&nbsp; .axis_map_y =3D 1,<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+&nbsp;&nbsp;&nbsp; .axis_map_z =3D 2,<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+&nbsp;&nbsp;&nbsp; .negate_x =3D 0,<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+&nbsp;&nbsp;&nbsp; .negate_y =3D 0,<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; .negate_z =3D 0,<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp; .gpio_int1 =3D DEFAULT_INT1_GPIO,<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp; .gpio_int2 =3D DEFAULT_INT2_GPIO,&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; /* int for fifo */<o:p></o:p></span></p><p class=3DMsoNo=
rmal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"=
'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+};<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+struct l3gd20_gyr_stat=
us {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none=
'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp; struct work_struct&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; work_trigger_to_ring;<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; s64&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last_timestamp;<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; struct iio_dev&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; *indio_dev;<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp=
;&nbsp;&nbsp; struct iio_trigger&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *trig;<o:p></o:p></span></p><p class=3D=
MsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier=
 New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; struct =
i2c_client&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; *client;<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;=
&nbsp;&nbsp; struct l3gd20_gyr_platform_data&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*pdata;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:n=
one'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; int&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; use_smbus;<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; loc=
k;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; int&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw_initialized;<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+&nbsp;&nbsp;&nbsp; atomic_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enabled;<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+&nbsp;&nbsp;&nbsp; char const&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *scale;<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; char const&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; *gain;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+&nbsp;&nbsp;&nbsp; u8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_addr;<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+&nbsp;&nbsp;&nbsp; u8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; resume_state[RESUME_ENTRIES];<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; irq1;<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; irq2;<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+};<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+static int l3gd20_gyr_i2c_read(struct=
 l3gd20_gyr_status *data,<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8 *buf, int len)<o:p=
></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"Courier New"'>+{<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+&nbsp;&nbsp;&nbsp; int ret;<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nb=
sp;&nbsp;&nbsp; u8 reg =3D buf[0];<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+=
&nbsp;&nbsp;&nbsp; u8 cmd =3D reg;<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+=
<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><s=
pan style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (len &gt; 1)=
<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><s=
pan style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; cmd =3D (I2C_AUTO_INCREMENT | reg);<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (data-&gt;use_smbus) {<o:p></o:=
p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; if (len =3D=3D 1) {<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; ret =3D i2c_smbus_read_byte_data(data-&gt;client, cmd);<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf[0] =3D ret &amp; 0xff;<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+#ifdef DEBUG<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; dev_dbg(&amp;data-&gt;client-&gt;dev,<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;i2c_s=
mbus_read_byte_data: ret=3D0x%02x, len:%d ,&quot;<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;command=3D0x%0=
2x, buf[0]=3D0x%02x\n&quot;,<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret, len, cmd , buf[0]);<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+#endif<o:p></o:p></span></p><p class=3DMsoNormal st=
yle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (len &gt; 1) {=
<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><s=
pan style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D i2c_smbus_read_i=
2c_block_data(data-&gt;client,<o:p></o:p></span></p><p class=3DMsoNormal st=
yle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; cmd, len, buf);<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+#=
ifdef DEBUG<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(&amp;=
data-&gt;client-&gt;dev,<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;i2c_smbus_read_i2c_block_data: ret:%d l=
en:%d, &quot;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; &quot;command=3D0x%02x, &quot;,<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret, len, cmd);<o:p=
></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char ii;<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (ii =3D 0; ii &lt; len; ii++)<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_=
debug(&quot;buf[%d]=3D0x%02x,\n&quot;, ii, buf[ii]);<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+#endif<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D -1;<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none=
'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0) {<o:p></o:p></span></p><p class=3D=
MsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier=
 New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; dev_err(&amp;data-&gt;client-&gt;dev,<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;read tra=
nsfer error: len:%d, command=3D0x%02x\n&quot;,<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; len, cmd);<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0; /* failure */<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; return len; /* success */<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+&nbsp;&nbsp;&nbsp; ret =3D i2c_master_send(data-&gt;client, &a=
mp;cmd, sizeof(cmd));<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&=
nbsp; if (ret !=3D sizeof(cmd))<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp=
;&nbsp;&nbsp; return i2c_master_recv(data-&gt;client, buf, len);<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+}<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+static int l3gd20_gyr_i2c_write(str=
uct l3gd20_gyr_status *data, u8 *buf,<o:p></o:p></span></p><p class=3DMsoNo=
rmal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"=
'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; int len)<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+{=
<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><s=
pan style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; int ret;<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; u8 reg, value;<o:p></o=
:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span styl=
e=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&=
nbsp;&nbsp;&nbsp; if (len &gt; 1)<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf[0] =3D (I2C_AUTO_=
INCREMENT | buf[0]);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; reg =3D buf[0];<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; value =3D buf[1];<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp=
;&nbsp;&nbsp; if (data-&gt;use_smbus) {<o:p></o:p></span></p><p class=3DMso=
Normal style=3D'text-autospace:none'><span style=3D'font-family:"Courier Ne=
w"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (len =3D=3D =
1) {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none=
'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D i2c_smbus_wr=
ite_byte_data(data-&gt;client, reg,<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value);<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+#ifdef DEBUG<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; dev_dbg(&amp;data-&gt;client-&gt;dev,<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;i2c_smbus_wr=
ite_byte_data: ret=3D%d, len:%d, &quot;<o:p></o:p></span></p><p class=3DMso=
Normal style=3D'text-autospace:none'><span style=3D'font-family:"Courier Ne=
w"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;command=3D0x%02x, value=
=3D0x%02x\n&quot;,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; ret, len, reg , value);<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+#endif<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; } else if (len &gt; 1) {<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D i2c_smbus_write_i2c_block_data(data-&gt;=
client,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:n=
one'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg, len, buf + 1);<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+#ifdef DEBUG<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; dev_dbg(&amp;data-&gt;client-&gt;dev,<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;i2c_smbus_write_i2=
c_block_data: ret=3D%d, &quot;<o:p></o:p></span></p><p class=3DMsoNormal st=
yle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;len:%d, command=3D0x%02x, &quot;,=
<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><s=
pan style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; ret, len, reg);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cha=
r ii;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (ii =3D 0; ii &=
lt; len + 1; ii++)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;value[%d]=3D0x%02x,\n&quot;, ii, buf=
[ii]);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+#endif<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; ret =
=3D i2c_master_send(data-&gt;client, buf, len+1);<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+&nbsp;&nbsp;&nbsp; return (ret =3D=3D len+1) ? 0 : ret;<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+}<o:p></o:p></span></p><p class=3DMsoNo=
rmal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"=
'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+static int l3gd20_gyr_register_write(struct l3gd20_gyr_status *d=
ata,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none=
'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; u8 *buf, u8 reg_address, u8 new_value)<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+{<o:p></o:p></span></p><p class=3DMsoNormal st=
yle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbs=
p;&nbsp;&nbsp; int err;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Sets configuration register at reg_address<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; *&nbsp; NOTE: this is a straight overwrite&nbsp; */<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
buf[0] =3D reg_address;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf[1] =3D new_value;<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; err =3D l3gd20_gyr_i2c_write(data, buf, 1);<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 if (err &lt; 0)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return e=
rr;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp; return err;<o:p></o:p></span></p><p class=3DM=
soNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier =
New"'>+}<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+static int l3gd20_gyr_register_read(struct l3gd20_gyr_status=
 *data,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:n=
one'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; u8 *buf, u8 reg_address)<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+{<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+&nbsp;&nbsp;&nbsp; int err =3D -1;<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+&nbsp;&nbsp;&nbsp; buf[0] =3D (reg_address);<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+&nbsp;&nbsp;&nbsp; err =3D l3gd20_gyr_i2c_read(data, buf, 1);<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; return err;<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+}<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+#define L3GD20_INFO_MASK IIO_CHA=
N_INFO_RAW_SEPARATE_BIT<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+#define L3GD20_CHAN(addr, mod)&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; \<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .type =3D IIO_ANGL_VEL,&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; .modified =3D 1,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; \<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .channel2 =3D mod,&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .info_mask =3D L3GD20_I=
NFO_MASK,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; \<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; .address =3D addr,&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; \<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .scan_type =3D {&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; .sign =3D 's',&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<o:p=
></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .realbits =3D 16,&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; \<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .storagebits=
 =3D 16,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; \<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .shift =3D =
0,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; \<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp=
;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+static struct iio_chan_spec l3gd20_channels[] =3D {<o:p></o=
:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span styl=
e=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; L3GD20_CHAN(OUT_X_LSB, =
IIO_MOD_X),<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; L3GD=
20_CHAN(OUT_Y_LSB, IIO_MOD_Y),<o:p></o:p></span></p><p class=3DMsoNormal st=
yle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbs=
p;&nbsp;&nbsp; L3GD20_CHAN(OUT_Z_LSB, IIO_MOD_Z),<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+};<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+static int=
 l3gd20_gyr_read_raw(struct iio_dev *indio_dev,<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct iio_chan_spec c=
onst *chan,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; int *val,<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int *val2,<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; long mask)<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+{<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;=
&nbsp;&nbsp; struct l3gd20_gyr_status *data =3D iio_priv(indio_dev);<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; int err;<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; u8 out_data[2];<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; s16 val16;<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+&nbsp;&nbsp;&nbsp; out_data[0] =3D chan-&gt;address;<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; switch&nbsp; (ma=
sk) {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; case IIO_C=
HAN_INFO_RAW:<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;data-&gt;lock);<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; err =3D l3gd20_gyr_i2c_read(data, out_data, 2);<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; mutex_unlock(&amp;data-&gt;lock);<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err &lt; 0)<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; val16 =3D ((s16) ((out_data[1]) &lt;&lt; 8) | out_data[0]);<o:p></o:=
p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; *val =3D val16;<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return IIO_VAL_INT;<o:p></o=
:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span styl=
e=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; default:<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; return -EINVAL;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&=
nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:n=
one'><span style=3D'font-family:"Courier New"'>+}<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+static int l3gd20_g=
yr_register_update(struct l3gd20_gyr_status *data,<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8 *=
buf, u8 reg_address, u8 mask, u8 new_bit_values)<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+{<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; =
int err =3D -1;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; =
u8 init_val;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; u8 =
updated_val;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; err=
 =3D l3gd20_gyr_register_read(data, buf, reg_address);<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (!(err &lt; 0)) {<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; init_val =3D buf[0];<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; updated_val =3D ((mask &amp=
; new_bit_values) | ((~mask) &amp; init_val));<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D =
l3gd20_gyr_register_write(data, buf, reg_address,<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; updated_val);<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+&nbsp;&nbsp;&nbsp; return err;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+}<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+static int l3gd20_gyr_hw_init(struct l3gd20_gyr_sta=
tus *dev_data)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+{<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+&nbsp;&nbsp;&nbsp; int err;<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+&nbsp;&nbsp;&nbsp; u8 buf[6];<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; pr_i=
nfo(&quot;%s hw init\n&quot;, L3GD20_GYR_DEV_NAME);<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp=
; buf[0] =3D (CTRL_REG1);<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp; buf[1] =3D dev_data-&gt;resume_state[RES_CTRL_REG1];<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; buf[2] =3D dev_data-&gt;=
resume_state[RES_CTRL_REG2];<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;=
&nbsp;&nbsp; buf[3] =3D dev_data-&gt;resume_state[RES_CTRL_REG3];<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; buf[4] =3D dev_data-&gt;=
resume_state[RES_CTRL_REG4];<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;=
&nbsp;&nbsp; buf[5] =3D dev_data-&gt;resume_state[RES_CTRL_REG5];<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp; err =3D l3gd20_gyr_i2c_write(dev_data, buf, 5);<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (err &lt; 0)<o:p></o:=
p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; return err;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; buf[0] =3D FIFO_CTRL_REG=
;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><=
span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; buf[1] =3D dev=
_data-&gt;resume_state[RES_FIFO_CTRL_REG];<o:p></o:p></span></p><p class=3D=
MsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier=
 New"'>+&nbsp;&nbsp;&nbsp; err =3D l3gd20_gyr_i2c_write(dev_data, buf, 1);<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (err &lt; 0)<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp; dev_data-&gt;hw_initialized =3D 1;<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; ret=
urn err;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+}<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>+static void l3gd20=
_gyr_device_power_off(struct l3gd20_gyr_status *dev_data)<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+{<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbs=
p;&nbsp; int err;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp=
; u8 buf[2];<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+&nbsp;&nbsp;&nbsp; pr_info(&quot;%s power off\n&quot;, L=
3GD20_GYR_DEV_NAME);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; buf[0] =3D CTRL_REG1;<o:p></o=
:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span styl=
e=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; buf[1] =3D PM_OFF;<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; err =3D l3gd20_gyr_i=
2c_write(dev_data, buf, 1);<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp; if (err &lt; 0)<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(&amp;dev_data-&gt;c=
lient-&gt;dev, &quot;soft power off failed\n&quot;);<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbs=
p; if (dev_data-&gt;pdata-&gt;power_off) {<o:p></o:p></span></p><p class=3D=
MsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier=
 New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_data-&gt=
;pdata-&gt;power_off();<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_data-&gt;hw_initialized =3D=
 0;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp; if (dev_data-&gt;hw_initialized)<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_d=
ata-&gt;hw_initialized =3D 0;<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+}<o:p=
></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNo=
rmal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"=
'>+static int l3gd20_gyr_device_power_on(struct l3gd20_gyr_status *dev_data=
)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><=
span style=3D'font-family:"Courier New"'>+{<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp; int err;<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none=
'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (dev_dat=
a-&gt;pdata-&gt;power_on) {<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D dev_data-&gt;pdata-=
&gt;power_on();<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err &lt; 0)<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; return err;<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp; if (!dev_data-&gt;hw_initialized) {<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; er=
r =3D l3gd20_gyr_hw_init(dev_data);<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err &lt; 0) {<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; l3gd20_gyr_device_power_of=
f(dev_data);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&=
nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:n=
one'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></span></p><p class=3D=
MsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier=
 New"'>+}<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>+static int l3gd20_=
gyr_enable(struct l3gd20_gyr_status *dev_data)<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+{<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; in=
t err;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+&nbsp;&nbsp;&nbsp; if (!atomic_cmpxchg(&amp;dev_data-&gt;enabl=
ed, 0, 1)) {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; e=
rr =3D l3gd20_gyr_device_power_on(dev_data);<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err &=
lt; 0) {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;=
dev_data-&gt;enabled, 0);<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; return err;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp=
;&nbsp;&nbsp; return 0;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+}<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+st=
atic int l3gd20_gyr_disable(struct l3gd20_gyr_status *dev_data)<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+{<o:p></o:p></span></p><p class=3DMsoNormal st=
yle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p=
></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; pr_debug(&quot;%s: =
dev_data-&gt;enabled =3D %d\n&quot;, __func__,<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_r=
ead(&amp;dev_data-&gt;enabled));<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (atomic_cmpxch=
g(&amp;dev_data-&gt;enabled, 1, 0))<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; l3gd20_gyr_device_p=
ower_off(dev_data);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+}<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+static int l3gd20_gyr_update_fs_range(struct l3=
gd20_gyr_status *dev_data,<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8 new_fs_range)<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+{<o:p></o:p></span></p><p class=3DMsoNo=
rmal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"=
'>+&nbsp;&nbsp;&nbsp; int res ;<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nb=
sp;&nbsp;&nbsp; u8 buf[2];<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp; char const *scale;<o:p></o:p></span></p><p class=3DMsoNormal st=
yle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbs=
p;&nbsp;&nbsp; char const *gain;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp; buf[0] =3D CTRL_REG4;<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none=
'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; switch (new=
_fs_range) {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; cas=
e L3GD20_GYR_FS_250DPS:<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gain =3D GAIN_250DPS;<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; scale =3D SCALE_250DPS;<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;=
&nbsp;&nbsp; case L3GD20_GYR_FS_500DPS:<o:p></o:p></span></p><p class=3DMso=
Normal style=3D'text-autospace:none'><span style=3D'font-family:"Courier Ne=
w"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gain =3D GAIN_5=
00DPS;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; scale =3D SCALE_500DPS;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; brea=
k;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp; case L3GD20_GYR_FS_2000DPS:<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; gain =3D GAIN_2000DPS;<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scale =3D SCALE_2000DPS;<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; break;<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; default:<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; dev_err(&amp;dev_data-&gt;client-&gt;dev,<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; &quot;invalid fs range requested: %u\n&quot;,<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; new_fs_range);<o:p></o:p></span></p><p class=3DMso=
Normal style=3D'text-autospace:none'><span style=3D'font-family:"Courier Ne=
w"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;=
<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><s=
pan style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp; res =3D l3gd20_gyr_register_update(dev_data, buf, CTRL_REG4,<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; FS_MASK, new_fs_range);<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if=
 (res &lt; 0) {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;%s : failed to update fs:0=
x%02x\n&quot;,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __func__, new_fs_range);<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; return res;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp=
;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; dev_da=
ta-&gt;resume_state[RES_CTRL_REG4] =3D<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((FS_MASK &amp; =
new_fs_range) |<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (~FS_MASK &amp; dev_data-&gt;resume_sta=
te[RES_CTRL_REG4]));<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&n=
bsp; dev_data-&gt;gain =3D gain;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp; dev_data-&gt;scale =3D scale;<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+&nbsp;&nbsp;&nbsp; return res;<o:p></o:p></span></p><p class=3D=
MsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier=
 New"'>+}<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+static int l3gd20_gyr_update_sampling_freq(struct l3gd20_gy=
r_status *data,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8 freq)<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+{<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp=
; int res =3D 0;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;=
 u8 buf[2];<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; u8 n=
ew_value;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; u8 mas=
k =3D (CTRL_REG1_ODR_MASK|CTRL_REG1_BW_MASK);<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+&nbsp;&nbsp;&nbsp; new_value =3D freq;<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+&nbsp;&nbsp;&nbsp; res =3D l3gd20_gyr_register_update=
(data, buf, CTRL_REG1,<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mask, new_value);<o:p></o:=
p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp; if (res &lt; 0) {<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(&amp;data-&g=
t;client-&gt;dev,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%=
s : failed to update sampling frequency setting\n&quot;,<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __func__);<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return res;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; }<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; dev_dbg(&amp;data-=
&gt;client-&gt;dev, &quot;%s : new_value:0x%02x, freq:0x%02x\n&quot;,<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __func__, new_value, freq);<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+&nbsp;&nbsp;&nbsp; data-&gt;resume_state[RES_CTRL_REG1] =3D<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; ((mask &amp; new_value) |<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (~mask &amp; data-&g=
t;resume_state[RES_CTRL_REG1]));<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; data-&gt;pdata-&g=
t;sampling_frequency =3D new_value;<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><=
span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; return res;<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+}<o:p></o:p></span></p><p class=3DMso=
Normal style=3D'text-autospace:none'><span style=3D'font-family:"Courier Ne=
w"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+static ssize_t l3gd20_gyr_sho=
w_sampling_frequency(struct device *dev,<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<o:p></o=
:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span styl=
e=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *buf)<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+{<o:p></o:p></span></p><p class=3DM=
soNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp; struct iio_dev *indio_dev =3D dev_get_drvdata(dev=
);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; struct l3gd20=
_gyr_status *data =3D iio_priv(indio_dev);<o:p></o:p></span></p><p class=3D=
MsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier=
 New"'>+&nbsp;&nbsp;&nbsp; u8 i;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp; u8 val;<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp; mutex_lock(&amp;data-&gt;lock);<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+&nbsp;&nbsp;&nbsp; val =3D data-&gt;pdata-&gt;sampling_freque=
ncy;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none=
'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; mutex_unloc=
k(&amp;data-&gt;lock);<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;=
&nbsp; dev_dbg(dev, &quot;getting sampling frequency: 0x%02x\n&quot;, val);=
<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><s=
pan style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DM=
soNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; ARRAY_SIZE(l3gd20_gyr_odr_ta=
ble); i++)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospac=
e:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (l3gd20_gyr_odr_table[i].sampling_rate_se=
tting =3D=3D val)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+&nbsp;&nbsp;&nbsp; return sprintf(buf, &quot;%s\n&quot;, l3gd20_gyr_o=
dr_table[i].hz_label);<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+}<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+st=
atic ssize_t l3gd20_gyr_store_sampling_frequency(struct device *dev,<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dev=
ice_attribute *attr,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; const char *buf, size_t size)<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+{<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; st=
ruct iio_dev *indio_dev =3D dev_get_drvdata(dev);<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+&nbsp;&nbsp;&nbsp; struct l3gd20_gyr_status *data =3D iio_pr=
iv(indio_dev);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; u=
8 found =3D 0;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; u=
8 i;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none=
'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; u8 ret;<o:p=
></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNo=
rmal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"=
'>+&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; ARRAY_SIZE(l3gd20_gyr_odr_table)=
; i++) {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; if (strcmp(buf, l3gd20_gyr_odr_table[i].hz_lab=
el) =3D=3D 0) {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; found =3D=
 1;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:n=
one'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; }<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+=
&nbsp;&nbsp;&nbsp; if (!found) {<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(dev, &quot;try=
ing to set invalid sampling frequency: %s\n&quot;<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;new sampling f=
requency not set!\n&quot;, buf);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return&nbsp; -EINVAL;<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; } else {<o:p></o=
:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span styl=
e=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; mutex_lock(&amp;data-&gt;lock);<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D l=
3gd20_gyr_update_sampling_freq(data,<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; l3gd20_gyr_odr_table[i].sampling_rate_setting);<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; if (ret &lt; 0)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto=
 error;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:n=
one'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;pdata-&gt;sampling_frequency =3D<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; l3gd20_gyr_odr_table[i].sampli=
ng_rate_setting;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(dev, &quot;set new sampling f=
requency: %s Hz\n&quot;,<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; l3gd20_gy=
r_odr_table[i].hz_label);<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;data-&gt;=
lock);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; }<o:p></o=
:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span styl=
e=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; return size;<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+error:<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;data-&gt;lock);<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+}<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+static =
IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,<o:p></o:p></span></p><p class=3DM=
soNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; l3gd20_gyr_sh=
ow_sampling_frequency,<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; l3gd20_gyr_store_sampling_freque=
ncy);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+static ssize_t l3gd20_gyr_show_enable(struct device *dev,<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; struct device_attribute *attr, char *buf)<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+{<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; =
struct iio_dev *indio_dev =3D dev_get_drvdata(dev);<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+&nbsp;&nbsp;&nbsp; struct l3gd20_gyr_status *data =3D iio_=
priv(indio_dev);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;=
 int val =3D atomic_read(&amp;data-&gt;enabled);<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+&nbsp;&nbsp;&nbsp; return sprintf(buf, &quot;%d\n&quot;, val)=
;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><=
span style=3D'font-family:"Courier New"'>+}<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+static ssize_t l3gd20_g=
yr_store_enable(struct device *dev,<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute *at=
tr,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; const char *buf, size_t size)<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+{<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; str=
uct iio_dev *indio_dev =3D dev_get_drvdata(dev);<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+&nbsp;&nbsp;&nbsp; struct l3gd20_gyr_status *data =3D iio_pri=
v(indio_dev);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; un=
signed long val;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (kstrtoul(buf, 10, &amp;val))<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -EINVAL;<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><=
span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (val)<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; l3gd20_gyr_enable(data);<o:p></o:p></span></p><p class=3DMso=
Normal style=3D'text-autospace:none'><span style=3D'font-family:"Courier Ne=
w"'>+&nbsp;&nbsp;&nbsp; else<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; l3gd20_gyr_disable(data);<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+&nbsp;&nbsp;&nbsp; return size;<o:p></o:p></span></p><p class=3DMsoNo=
rmal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"=
'>+}<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none=
'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+static IIO_DEVICE_ATTR(enable_device,<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; S_IWUSR | S_IRUGO,<o:p></o:p></span></p><p class=3D=
MsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier=
 New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; l3gd20_gyr_show_enable,<o:p></o:p></span></p><p class=3DM=
soNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; l3gd20_gyr_store_enable,<o:p></o:p></span></p><p class=3DM=
soNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 0);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+static ssize_t l3gd20_gyr_show_range(struct devi=
ce *dev,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute *=
attr,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *buf)<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+{<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbs=
p;&nbsp; struct iio_dev *indio_dev =3D dev_get_drvdata(dev);<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; struct l3gd20_gyr_status *data=
 =3D iio_priv(indio_dev);<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp; int label =3D 0;<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;=
&nbsp;&nbsp; u8 val;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&n=
bsp; mutex_lock(&amp;data-&gt;lock);<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+&nbsp;&nbsp;&nbsp; val =3D data-&gt;pdata-&gt;fs_range;<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;data-&gt;lock);=
<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><s=
pan style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DM=
soNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp; switch (val) {<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+&nbsp;&nbsp;&nbsp; case L3GD20_GYR_FS_250DPS:<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lab=
el =3D 250;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+&nbsp;&nbsp;&nbsp; case L3GD20_GYR_FS_500DPS:<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; label=
 =3D 500;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+&nbsp;&nbsp;&nbsp; case L3GD20_GYR_FS_2000DPS:<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; label =
=3D 2000;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; return sprintf(buf, &quot;%=
d dps\n&quot;, label);<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+}<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+st=
atic ssize_t l3gd20_gyr_store_range(struct device *dev,<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; &nbsp; struct device_attribute *attr,<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; const char *buf,<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &nbsp; size_t size)<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+{<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; struct iio_de=
v *indio_dev =3D dev_get_drvdata(dev);<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+&nbsp;&nbsp;&nbsp; struct l3gd20_gyr_status *data =3D iio_priv(indio_de=
v);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; unsigned lon=
g val;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; u8 range;=
<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><s=
pan style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; int err =3D -1;=
<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><s=
pan style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (kstrtoul(bu=
f, 10, &amp;val)) {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(dev, &quot;invalid range %l=
u\n. Range not changed&quot;, val);<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<o:p=
></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+&nbsp;&nbsp;&nbsp; switch (val) {<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+&nbsp;&nbsp;&nbsp; case 250:<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rang=
e =3D L3GD20_GYR_FS_250DPS;<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+&nbsp;&nbsp;&nbsp; case 500:<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; range =3D L3GD20_=
GYR_FS_500DPS;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></span></p><p class=3DM=
soNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp; case 2000:<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range =3D L3GD20_G=
YR_FS_2000DPS;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></span></p><p class=3DM=
soNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp; default:<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(dev, &quot;i=
nvalid range %lu. Range not changed\n&quot;, val);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retu=
rn -EINVAL;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; }<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+&nbsp;&nbsp;&nbsp; mutex_lock(&amp;data-&gt;lock);<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+&nbsp;&nbsp;&nbsp; data-&gt;pdata-&gt;fs_range =3D rang=
e;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; err =3D l3gd2=
0_gyr_update_fs_range(data, range);<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;data-&gt;lock);<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (err &lt; 0)<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g=
oto error;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospac=
e:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; dev_i=
nfo(dev, &quot;set range to %lu dps\n&quot;, val);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+&nbsp;&nbsp;&nbsp; return size;<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+error:<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nb=
sp; dev_err(dev, &quot;error changing range\n&quot;);<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+&nbsp;&nbsp;&nbsp; return err;<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+}<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+static IIO_DEVICE_ATTR(gyro_range,<o:p></o:=
p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S_IWUSR | S_IRUGO,<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; l3gd20_gyr_show_range,<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; l3gd20_gyr_store_range,<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0);<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+static IIO_CONST_ATTR(gyro_range_available, &quot;250 500 2000&q=
uot;);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+static ssize_t l3gd20=
_gyr_show_gain(struct device *dev,<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *buf)<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+{<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+&nbsp;&nbsp;&nbsp; struct iio_dev *indio_dev =3D dev_get_drvdata(dev);<o:p=
></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; struct l3gd20_gyr_s=
tatus *data =3D iio_priv(indio_dev);<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+&nbsp;&nbsp;&nbsp; return sprintf(buf, &quot;%s\n&quot;, data-&gt;gain);<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+}<o:p></o:p></span></p><p class=3DM=
soNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier =
New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:n=
one'><span style=3D'font-family:"Courier New"'>+static IIO_DEVICE_ATTR(gyro=
_gain, S_IRUGO,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; l3gd20_gy=
r_show_gain,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL , 0);<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMso=
Normal style=3D'text-autospace:none'><span style=3D'font-family:"Courier Ne=
w"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+static ssize_t l3gd20_gyr_sho=
w_scale(struct device *dev,<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct=
 device_attribute *attr,<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *buf=
)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><=
span style=3D'font-family:"Courier New"'>+{<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp; struct iio_dev *indio_dev =3D dev_get_drvdata=
(dev);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; struct l3=
gd20_gyr_status *data =3D iio_priv(indio_dev);<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+&nbsp;&nbsp;&nbsp; return sprintf(buf, &quot;%s\n&quot;, data-&=
gt;scale);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospac=
e:none'><span style=3D'font-family:"Courier New"'>+}<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+static IIO_DEVIC=
E_ATTR(gyro_scale, S_IRUGO,<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; l3gd20_gyr_show_scale,<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; NULL , 0);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(&quot;95 190 380 =
760&quot;);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+static IIO_CONST_ATTR(name, L3GD20_GYR_DEV_NAME);<o:p></o=
:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span styl=
e=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+static struct attribute *l3gd20_gyr_attributes[] =3D {<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; &amp;iio_const_attr_name.dev_a=
ttr.attr,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; &amp;i=
io_dev_attr_enable_device.dev_attr.attr,<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+&nbsp;&nbsp;&nbsp; &amp;iio_const_attr_gyro_range_available.dev_attr.=
attr,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; &amp;iio_d=
ev_attr_gyro_range.dev_attr.attr,<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&=
nbsp;&nbsp;&nbsp; &amp;iio_dev_attr_gyro_gain.dev_attr.attr,<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; &amp;iio_dev_attr_gyro_scale.d=
ev_attr.attr,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; &a=
mp;iio_dev_attr_sampling_frequency.dev_attr.attr,<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+&nbsp;&nbsp;&nbsp; &amp;iio_const_attr_sampling_frequency_av=
ailable.dev_attr.attr,<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;=
&nbsp; NULL<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+};<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+static const s=
truct attribute_group l3gd20_gyr_attribute_group =3D {<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+&nbsp;&nbsp;&nbsp; .attrs =3D l3gd20_gyr_attributes,<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+};<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+static const struct iio_info=
 l3gd20_gyr_info =3D {<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;=
&nbsp; .attrs =3D &amp;l3gd20_gyr_attribute_group,<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+&nbsp;&nbsp;&nbsp; .read_raw =3D &amp;l3gd20_gyr_read_raw,<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; .driver_module =
=3D THIS_MODULE,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>+};<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+static =
int l3gd20_gyr_validate_pdata(struct l3gd20_gyr_status *dev_data)<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+{<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (dev_data-&gt=
;pdata-&gt;axis_map_x &gt; 2 ||<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nb=
sp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dev_data-&gt;pdata-&gt;axis_map_y &gt; 2=
 ||<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;=
&nbsp; dev_data-&gt;pdata-&gt;axis_map_z &gt; 2) {<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_=
err(&amp;dev_data-&gt;client-&gt;dev,<o:p></o:p></span></p><p class=3DMsoNo=
rmal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"=
'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; &quot;invalid axis_map value x:%u y:%u z%u\n&quot;,<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_data-&gt;pdata-&gt;axis_map_x=
,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><=
span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_data-&gt;pdata-&gt;=
axis_map_y,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_data-&gt;=
pdata-&gt;axis_map_z);<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; /* O=
nly allow 0 and 1 for negation boolean flag */<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+&nbsp;&nbsp;&nbsp; if (dev_data-&gt;pdata-&gt;negate_x &gt; 1 |=
|<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><=
span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp; dev_data-&gt;pdata-&gt;negate_y &gt; 1 ||<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dev_data-&gt;pdata-&gt;ne=
gate_z &gt; 1) {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(&amp;dev_data-&gt;client-&gt;d=
ev,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;invalid negate =
value x:%u y:%u z:%u\n&quot;,<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; dev_data-&gt;pdata-&gt;negate_x,<o:p></o:p></span></p><p class=3DMsoNo=
rmal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"=
'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; dev_data-&gt;pdata-&gt;negate_y,<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; dev_data-&gt;pdata-&gt;negate_z);<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return -EINVAL;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; =
}<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><=
span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3D=
MsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier=
 New"'>+&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+}<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+static int l3gd20_gyr_probe(struct i2c_client *client,<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; const struct i2c_device_id *id)<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+{<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; str=
uct l3gd20_gyr_status *stat;<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;=
&nbsp;&nbsp; struct iio_dev *indio_dev;<o:p></o:p></span></p><p class=3DMso=
Normal style=3D'text-autospace:none'><span style=3D'font-family:"Courier Ne=
w"'>+&nbsp;&nbsp;&nbsp; int err =3D -1;<o:p></o:p></span></p><p class=3DMso=
Normal style=3D'text-autospace:none'><span style=3D'font-family:"Courier Ne=
w"'>+&nbsp;&nbsp;&nbsp; u32 smbus_func;<o:p></o:p></span></p><p class=3DMso=
Normal style=3D'text-autospace:none'><span style=3D'font-family:"Courier Ne=
w"'>+&nbsp;&nbsp;&nbsp; int regdone =3D 0;<o:p></o:p></span></p><p class=3D=
MsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier=
 New"'>+&nbsp;&nbsp;&nbsp; indio_dev =3D iio_device_alloc(sizeof(*stat));<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (indio_dev =3D=
=3D NULL) {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D -ENOMEM;<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_er=
r(&amp;client-&gt;dev,<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;failed to allocate memory for module stat=
: &quot;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%d\n&quot;, err);<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; goto exit_check_functionality_failed;<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3D=
MsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier=
 New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; stat =
=3D iio_priv(indio_dev);<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbs=
p;&nbsp; smbus_func =3D I2C_FUNC_SMBUS_BYTE_DATA |<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; I2C_FUNC_SMBUS_WORD_DATA | I2C_FUNC_SMBUS_I2C_BLO=
CK;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; pr_info(&quo=
t;%s: probe start.\n&quot;, L3GD20_GYR_DEV_NAME);<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; =
/* Support for both I2C and SMBUS adapter interfaces. */<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (!i2c_check_functionality(clien=
t-&gt;adapter, I2C_FUNC_I2C)) {<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(&amp;client-&g=
t;dev, &quot;client not i2c capable\n&quot;);<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (i2c_c=
heck_functionality(client-&gt;adapter, smbus_func)) {<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; stat-&gt;use_smbus =3D 1;<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(&amp;client-&gt;dev, &quot;client us=
ing SMBUS\n&quot;);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; err =3D -ENODEV;<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; dev_err(&amp;client-&gt;dev, &quot;client nor SMBUS capable=
\n&quot;);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospac=
e:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stat-&gt;use_s=
mbus =3D 0;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto exit_che=
ck_functionality_failed;<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; mutex_init(&amp;s=
tat-&gt;lock);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; m=
utex_lock(&amp;stat-&gt;lock);<o:p></o:p></span></p><p class=3DMsoNormal st=
yle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbs=
p;&nbsp;&nbsp; stat-&gt;client =3D client;<o:p></o:p></span></p><p class=3D=
MsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier=
 New"'>+&nbsp;&nbsp;&nbsp; i2c_set_clientdata(client, indio_dev);<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; stat-&gt;pdata =3D kmall=
oc(sizeof(*stat-&gt;pdata), GFP_KERNEL);<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+&nbsp;&nbsp;&nbsp; if (stat-&gt;pdata =3D=3D NULL) {<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; err =3D -ENOMEM;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(&amp;client-&gt;dev,<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&quot;failed to allocate memory for pdata: %d\n&quot;,<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err);<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; goto err_mutexunlock;<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&=
nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (client-&gt;dev.platform_da=
ta =3D=3D NULL) {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(stat-&gt;pdata, &amp;default_l=
3gd20_gyr_pdata,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(*stat-&gt;pdata));<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; dev_info(&amp;client-&gt;dev, &quot;using default platform da=
ta\n&quot;);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; } e=
lse {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(stat-&gt;pdata, client-&gt;dev.platform_da=
ta,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(*stat-&gt;pdata));<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DM=
soNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier =
New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:n=
one'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; err =3D =
l3gd20_gyr_validate_pdata(stat);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp; if (err &lt; 0) {<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(&amp;client-=
&gt;dev, &quot;failed to validate platform data\n&quot;);<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; goto exit_kfree_pdata;<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&n=
bsp; if (stat-&gt;pdata-&gt;init) {<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D stat-&gt;pd=
ata-&gt;init();<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err &lt; 0) {<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(&amp;client-&gt;dev, &quot;init failed=
: %d\n&quot;, err);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto =
err_pdata_init;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNo=
rmal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"=
'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; memset(stat-&gt;resume_s=
tate, 0, ARRAY_SIZE(stat-&gt;resume_state));<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; stat=
-&gt;resume_state[RES_CTRL_REG1] =3D (ALL_ZEROES | PM_NORMAL<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; | ENABLE_ALL_AXES);<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nb=
sp;&nbsp;&nbsp; stat-&gt;resume_state[RES_CTRL_REG2] =3D ALL_ZEROES;<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; stat-&gt;resume_state[=
RES_CTRL_REG3] =3D ALL_ZEROES;<o:p></o:p></span></p><p class=3DMsoNormal st=
yle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbs=
p;&nbsp;&nbsp; stat-&gt;resume_state[RES_CTRL_REG4] =3D (ALL_ZEROES | BDU_E=
NABLE);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:n=
one'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; stat-&gt=
;resume_state[RES_CTRL_REG5] =3D ALL_ZEROES;<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp; stat-&gt;resume_state[RES_FIFO_CTRL_REG] =3D =
ALL_ZEROES;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+&nbsp;&nbsp;&nbsp; err =3D l3gd20_gyr_device_power_on(sta=
t);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (err &lt;=
 0) {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(&amp;client-&gt;dev, &quot;power on faile=
d: %d\n&quot;, err);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto exit_kfree_pdata;<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; =
atomic_set(&amp;stat-&gt;enabled, 1);<o:p></o:p></span></p><p class=3DMsoNo=
rmal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"=
'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; err =3D l3gd=
20_gyr_update_fs_range(stat, stat-&gt;pdata-&gt;fs_range);<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (err &lt; 0) {<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; dev_err(&amp;client-&gt;dev, &quot;update_fs_range failed\n&quot;);<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; goto&nbsp; err_power_off;<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; err =3D l3gd20_gyr=
_update_sampling_freq(stat,<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stat-&=
gt;pdata-&gt;sampling_frequency);<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&=
nbsp;&nbsp;&nbsp; if (err &lt; 0) {<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(&amp;client=
-&gt;dev, &quot;update sampling freq failed\n&quot;);<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g=
oto&nbsp; err_power_off;<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbs=
p;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospac=
e:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+&nbsp;&nbsp;&nbsp; indio_dev-&gt;dev.parent =3D &amp;clien=
t-&gt;dev;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospac=
e:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; indio=
_dev-&gt;modes =3D INDIO_DIRECT_MODE;<o:p></o:p></span></p><p class=3DMsoNo=
rmal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"=
'>+&nbsp;&nbsp;&nbsp; indio_dev-&gt;info =3D &amp;l3gd20_gyr_info;<o:p></o:=
p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; indio_dev-&gt;channels =
=3D l3gd20_channels;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&n=
bsp; indio_dev-&gt;num_channels =3D ARRAY_SIZE(l3gd20_channels);<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp; l3gd20_gyr_device_power_off(stat);<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp=
; /* As default, do not report information */<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp; atomic_set(&amp;stat-&gt;enabled, 0);<o:p></o=
:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span styl=
e=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; err =3D l3gd20_gyr_conf=
igure_ring(indio_dev);<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;=
&nbsp; if (err)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_free_dev;<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;=
&nbsp; err =3D iio_device_register(indio_dev);<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+&nbsp;&nbsp;&nbsp; if (err) {<o:p></o:p></span></p><p class=3DM=
soNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(&amp;=
client-&gt;dev, &quot;error registering iio dev: %d\n&quot;, err);<o:p></o:=
p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; goto error_unreg_ring_funcs;<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp; regdone =3D 1;<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;stat=
-&gt;lock);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; dev_=
info(&amp;client-&gt;dev, &quot;%s: probed\n&quot;, L3GD20_GYR_DEV_NAME);<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; return 0;<o:p></o=
:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span styl=
e=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+error_unreg_ring_funcs:<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp=
;&nbsp;&nbsp; l3gd20_gyr_unconfigure_ring(stat-&gt;indio_dev);<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+error_free_dev:<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp; if (regdone)<o:p></o:p></span></p><p class=3D=
MsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier=
 New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iio_device_u=
nregister(indio_dev);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&=
nbsp; else<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospac=
e:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iio_device_free(indio_dev);<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+err_power_off:<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+&nbsp;&nbsp;&nbsp; l3gd20_gyr_device_power_off(stat);<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+err_pdata_init:<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+&nbsp;&nbsp;&nbsp; if (stat-&gt;pdata-&gt;exit)<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sta=
t-&gt;pdata-&gt;exit();<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+exit_kfree_=
pdata:<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; kfree(sta=
t-&gt;pdata);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+err_mutexunlock:<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;st=
at-&gt;lock);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+exit_check_functional=
ity_failed:<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; pr_e=
rr(&quot;%s: Driver Init failed\n&quot;, L3GD20_GYR_DEV_NAME);<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; return err;<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+}<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+=
static int __devexit l3gd20_gyr_remove(struct i2c_client *client)<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+{<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&=
nbsp;&nbsp;&nbsp; struct iio_dev *indio_dev =3D i2c_get_clientdata(client);=
<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><s=
pan style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; struct l3gd20_g=
yr_status *dev_data =3D iio_priv(indio_dev);<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; iio_=
device_unregister(indio_dev);<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp=
;&nbsp;&nbsp; l3gd20_gyr_device_power_off(dev_data);<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbs=
p; l3gd20_gyr_unconfigure_ring(indio_dev);<o:p></o:p></span></p><p class=3D=
MsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier=
 New"'>+&nbsp;&nbsp;&nbsp; iio_device_free(indio_dev);<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&n=
bsp; return 0;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+}<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+static const=
 struct i2c_device_id l3gd20_gyr_id[] =3D {<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp; { L3GD20_GYR_DEV_NAME , 0 },<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; {},<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+};<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+MODULE_DEVICE_TABLE(i2c, l3gd20_gyr_id);<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+static =
struct i2c_driver l3gd20_gyr_driver =3D {<o:p></o:p></span></p><p class=3DM=
soNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp; .driver =3D {<o:p></o:p></span></p><p class=3DMso=
Normal style=3D'text-autospace:none'><span style=3D'font-family:"Courier Ne=
w"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; .owner =3D THIS_MODULE,<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; .name =3D L3GD20_GYR_DEV_NAME,<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; },=
<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><s=
pan style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; .probe =3D l3gd=
20_gyr_probe,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; .r=
emove =3D __devexit_p(l3gd20_gyr_remove),<o:p></o:p></span></p><p class=3DM=
soNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp; .id_table =3D l3gd20_gyr_id,<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+};<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+module_i2c_driver(l3gd20_gyr_driver);<o:p></o:=
p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+MO=
DULE_DESCRIPTION(&quot;STMicroelectronics l3gd20 digital gyroscope iio driv=
er&quot;);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospac=
e:none'><span style=3D'font-family:"Courier New"'>+MODULE_AUTHOR(&quot;Matt=
eo Dameno, Swapnil Tiwari, STMicroelectronics&quot;);<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+MODULE_LICENSE(&quot;GPL v2&quot;);<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>-- <o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>1.7.5.4<span =
style=3D'color:#1F497D'><o:p></o:p></span></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'color:#1F497D'><o:p>&nbsp;</o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>Jon,<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
The driver is in the staging area since all the other gyro drivers haven&#8=
217;t moved. It doesn&#8217;t have any relative paths for headers so it can=
 be easily moved in future without modification.<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'color:#1F497D'=
><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:n=
one'><span style=3D'font-family:"Courier New"'>P.S.: The driver has been te=
sted successfully on Pandaboard-ES with OMAP4460 processor with latest kern=
el.<o:p></o:p></span></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=
=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Thanks and Regards,<=
o:p></o:p></p><p class=3DMsoNormal>Swapnil Tiwari<o:p></o:p></p><p class=3D=
MsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>STMicroelectronics, Inc=
<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNorm=
al>+1-408-919-8606 (desk) ; 1168606 (TINA)<o:p></o:p></p><p class=3DMsoNorm=
al>+1-949-981-8194 (mobile)<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;<=
/o:p></p></div></body></html>=

--_000_494E38452A01E745B763C5F242AAA2CCC5111C8FD9SAFEX1MAIL1st_--
