Return-Path: <swapnil.tiwari@st.com>
From: Swapnil TIWARI <swapnil.tiwari@st.com>
To: "jic23@cam.ac.uk" <jic23@cam.ac.uk>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Thu, 16 Aug 2012 04:02:28 +0200
Subject: [PATCH] Staging: iio: gyro: Add STMicroelectronics L3GD20 gyroscope
 device driver for Kernel version 2.6.35.13
Message-ID: <494E38452A01E745B763C5F242AAA2CCC50EDD9B5C@SAFEX1MAIL1.st.com>
Content-Type: multipart/alternative;
	boundary="_000_494E38452A01E745B763C5F242AAA2CCC50EDD9B5CSAFEX1MAIL1st_"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

--_000_494E38452A01E745B763C5F242AAA2CCC50EDD9B5CSAFEX1MAIL1st_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Add STMicroelectronics L3GD20 gyroscope device driver for Kernel version 2.=
6.35.13

Signed-off-by: Swapnil Tiwari <swapnil.tiwari@st.com>

---
drivers/staging/iio/gyro/Kconfig           |    8 +
drivers/staging/iio/gyro/Makefile          |    2 +
drivers/staging/iio/gyro/l3gd20.h          |  155 ++++
drivers/staging/iio/gyro/l3gd20_gyr_core.c | 1056 +++++++++++++++++++++++++=
+++
4 files changed, 1221 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/gyro/Kconfig b/drivers/staging/iio/gyro/Kc=
onfig
index 7e0b7f1..af2e423 100644
--- a/drivers/staging/iio/gyro/Kconfig
+++ b/drivers/staging/iio/gyro/Kconfig
@@ -12,3 +12,11 @@ config ADIS16260
      Say yes here to build support for Analog Devices adis16260/5
      programmable digital gyroscope sensor.
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
diff --git a/drivers/staging/iio/gyro/Makefile b/drivers/staging/iio/gyro/M=
akefile
index a3a28ed..28f530b 100644
--- a/drivers/staging/iio/gyro/Makefile
+++ b/drivers/staging/iio/gyro/Makefile
@@ -6,3 +6,5 @@ adis16260-y             :=3D adis16260_core.o
adis16260-$(CONFIG_IIO_RING_BUFFER) +=3D adis16260_ring.o adis16260_trigger=
.o
obj-$(CONFIG_ADIS16260) +=3D adis16260.o
+l3gd20_gyr-y    :=3D l3gd20_gyr_core.o
+obj-$(CONFIG_L3GD20_GYR_IIO) +=3D l3gd20_gyr.o
diff --git a/drivers/staging/iio/gyro/l3gd20.h b/drivers/staging/iio/gyro/l=
3gd20.h
index e69de29..d2a734a 100644
--- a/drivers/staging/iio/gyro/l3gd20.h
+++ b/drivers/staging/iio/gyro/l3gd20.h
@@ -0,0 +1,155 @@
+/******************** (C) COPYRIGHT 2011 STMicroelectronics **************=
******
+*
+* File Name    : l3gd20_iio.h
+* Authors : MH - C&I BU - Application Team
+*         : Matteo Dameno (matteo.dameno@st.com
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
+
+static inline int l3gd20_gyr_initialize_ring(struct iio_ring_buffer *ring)
+{
+    return 0;
+}
+
+static inline void l3gd20_gyr_uninitialize_ring(struct iio_ring_buffer *ri=
ng)
+{
+}
+
+#endif /* CONFIG_IIO_RING_BUFFER */
+
+#endif /* __KERNEL__ */
+
+#endif  /* __L3GD20_H__ */
diff --git a/drivers/staging/iio/gyro/l3gd20_gyr_core.c b/drivers/staging/i=
io/gyro/l3gd20_gyr_core.c
index e69de29..64871b6 100644
--- a/drivers/staging/iio/gyro/l3gd20_gyr_core.c
+++ b/drivers/staging/iio/gyro/l3gd20_gyr_core.c
@@ -0,0 +1,1056 @@
+/******************** (C) COPYRIGHT 2011 STMicroelectronics **************=
******
+*
+* File Name    : l3gd20_gyr_core_iio.c
+* Authors : MSH - Motion Mems BU - Application Team
+*         : Matteo Dameno (matteo.dameno@st.com)
+*         : author is willing to be considered the contact
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
+
+#include <linux/sysfs.h>
+
+#include <linux/moduleparam.h>
+
+#include "../iio.h"
+#include "../sysfs.h"
+#include "gyro.h"
+#include "l3gd20.h"
+
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
+struct l3gd20_gyr_data {
+
+    struct work_struct              work_trigger_to_ring;
+    struct iio_work_cont            work_cont_thresh;
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
+
+static int l3gd20_gyr_i2c_read(struct l3gd20_gyr_data *data,
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
+                    printk(KERN_DEBUG "buf[%d]=3D0x%02x,",
+                                          ii, buf[ii]);
+               printk("\n");
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
+static int l3gd20_gyr_i2c_write(struct l3gd20_gyr_data *data, u8 *buf,
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
+                    printk(KERN_DEBUG "value[%d]=3D0x%02x,",
+                                          ii, buf[ii]);
+
+               printk("\n");
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
+static int l3gd20_gyr_register_write(struct l3gd20_gyr_data *data,
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
+static int l3gd20_gyr_register_read(struct l3gd20_gyr_data *data,
+                               u8 *buf, u8 reg_address)
+{
+
+    int err =3D -1;
+    buf[0] =3D (reg_address);
+    err =3D l3gd20_gyr_i2c_read(data, buf, 1);
+    return err;
+}
+
+static int l3gd20_gyr_register_update(struct l3gd20_gyr_data *data,
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
+static int l3gd20_gyr_hw_init(struct l3gd20_gyr_data *dev_data)
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
+static void l3gd20_gyr_device_power_off(struct l3gd20_gyr_data *dev_data)
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
+static int l3gd20_gyr_device_power_on(struct l3gd20_gyr_data *dev_data)
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
+static int l3gd20_gyr_enable(struct l3gd20_gyr_data *dev_data)
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
+static int l3gd20_gyr_disable(struct l3gd20_gyr_data *dev_data)
+{
+
+    printk(KERN_DEBUG "%s: dev_data->enabled =3D %d\n", __func__,
+          atomic_read(&dev_data->enabled));
+
+    if (atomic_cmpxchg(&dev_data->enabled, 1, 0))
+          l3gd20_gyr_device_power_off(dev_data);
+
+    return 0;
+}
+
+static int l3gd20_gyr_update_fs_range(struct l3gd20_gyr_data *dev_data,
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
+static int l3gd20_gyr_update_sampling_freq(struct l3gd20_gyr_data *data,
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
+    struct l3gd20_gyr_data *data =3D indio_dev->dev_data;
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
+    struct l3gd20_gyr_data *data =3D indio_dev->dev_data;
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
+    struct l3gd20_gyr_data *data =3D indio_dev->dev_data;
+    int val =3D atomic_read(&data->enabled);
+    return sprintf(buf, "%d\n", val);
+}
+
+static ssize_t l3gd20_gyr_store_enable(struct device *dev,
+                      struct device_attribute *attr,
+                      const char *buf, size_t size)
+{
+    struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+    struct l3gd20_gyr_data *data =3D indio_dev->dev_data;
+    unsigned long val;
+
+    if (strict_strtoul(buf, 10, &val))
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
+static int l3gd20_gyr_show_channel_rawdata(struct device *dev,
+                    struct device_attribute *attr,
+                    char *buf)
+{
+    struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+    struct l3gd20_gyr_data *data =3D indio_dev->dev_data;
+    struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);
+    int err;
+
+    /* Data bytes from hardware (GxL, GxH) or (GyL, GyH) or (GzL, GzH) */
+    u8 out_data[2];
+    /* x,y,z hardware data */
+    s16 raw_d;
+
+    out_data[0] =3D this_attr->address;
+
+    mutex_lock(&data->lock);
+    err =3D l3gd20_gyr_i2c_read(data, out_data, 2);
+    mutex_unlock(&data->lock);
+    if (err < 0) {
+          dev_err(dev, "error reading output registers\n");
+          return err;
+    }
+
+    raw_d =3D ((s16) ((out_data[1]) << 8) | out_data[0]);
+    return sprintf(buf, "%d\n", raw_d);
+
+}
+
+static IIO_DEV_ATTR_GYRO_X(l3gd20_gyr_show_channel_rawdata, OUT_X_LSB);
+static IIO_DEV_ATTR_GYRO_Y(l3gd20_gyr_show_channel_rawdata, OUT_Y_LSB);
+static IIO_DEV_ATTR_GYRO_Z(l3gd20_gyr_show_channel_rawdata, OUT_Z_LSB);
+
+static ssize_t l3gd20_gyr_show_range(struct device *dev,
+                          struct device_attribute *attr,
+                          char *buf)
+{
+    struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+    struct l3gd20_gyr_data *data =3D indio_dev->dev_data;
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
+    struct l3gd20_gyr_data *data =3D indio_dev->dev_data;
+    unsigned long val;
+    u8 range;
+    int err =3D -1;
+    if (strict_strtoul(buf, 10, &val)) {
+          dev_err(dev, "invalid range %lu\n. Range not changed", val);
+          return -EINVAL;
+    }
+    switch (val) {
+    case 250:
+          range =3D L3GD20_GYR_FS_250DPS;
+          break;
+    case 500:
+          range =3D L3GD20_GYR_FS_500DPS;
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
+    struct l3gd20_gyr_data *data =3D indio_dev->dev_data;
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
+    struct l3gd20_gyr_data *data =3D indio_dev->dev_data;
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
+    &iio_dev_attr_gyro_x_raw.dev_attr.attr,
+    &iio_dev_attr_gyro_y_raw.dev_attr.attr,
+    &iio_dev_attr_gyro_z_raw.dev_attr.attr,
+    &iio_dev_attr_sampling_frequency.dev_attr.attr,
+    &iio_const_attr_sampling_frequency_available.dev_attr.attr,
+    NULL
+};
+
+static const struct attribute_group l3gd20_gyr_attribute_group =3D {
+    .attrs =3D l3gd20_gyr_attributes,
+};
+
+static int l3gd20_gyr_validate_pdata(struct l3gd20_gyr_data *dev_data)
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
+    struct l3gd20_gyr_data *data;
+    int err =3D -1;
+    data =3D kzalloc(sizeof(struct l3gd20_gyr_data), GFP_KERNEL);
+    if (data =3D=3D NULL) {
+          err =3D -ENOMEM;
+          dev_err(&client->dev,
+                    "failed to allocate memory for module data: "
+                          "%d\n", err);
+          goto exit_check_functionality_failed;
+    }
+
+    u32 smbus_func =3D I2C_FUNC_SMBUS_BYTE_DATA |
+               I2C_FUNC_SMBUS_WORD_DATA | I2C_FUNC_SMBUS_I2C_BLOCK ;
+
+    int regdone =3D 0;
+
+    pr_info("%s: probe start.\n", L3GD20_GYR_DEV_NAME);
+
+
+    /* Support for both I2C and SMBUS adapter interfaces. */
+    if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
+          dev_warn(&client->dev, "client not i2c capable\n");
+          if (i2c_check_functionality(client->adapter, smbus_func)) {
+               data->use_smbus =3D 1;
+               dev_warn(&client->dev, "client using SMBUS\n");
+          } else {
+               err =3D -ENODEV;
+               dev_err(&client->dev, "client nor SMBUS capable\n");
+               data->use_smbus =3D 0;
+               goto exit_check_functionality_failed;
+          }
+    }
+
+    mutex_init(&data->lock);
+    mutex_lock(&data->lock);
+    data->client =3D client;
+    i2c_set_clientdata(client, data);
+
+    data->pdata =3D kmalloc(sizeof(*data->pdata), GFP_KERNEL);
+    if (data->pdata =3D=3D NULL) {
+          err =3D -ENOMEM;
+          dev_err(&client->dev,
+                    "failed to allocate memory for pdata: %d\n",
+                    err);
+          goto err_mutexunlock;
+    }
+
+    if (client->dev.platform_data =3D=3D NULL) {
+          memcpy(data->pdata, &default_l3gd20_gyr_pdata,
+                                    sizeof(*data->pdata));
+          dev_info(&client->dev, "using default platform data\n");
+    } else {
+          memcpy(data->pdata, client->dev.platform_data,
+                                    sizeof(*data->pdata));
+    }
+
+    err =3D l3gd20_gyr_validate_pdata(data);
+    if (err < 0) {
+          dev_err(&client->dev, "failed to validate platform data\n");
+          goto exit_kfree_pdata;
+    }
+
+
+    if (data->pdata->init) {
+          err =3D data->pdata->init();
+          if (err < 0) {
+               dev_err(&client->dev, "init failed: %d\n", err);
+               goto err_pdata_init;
+          }
+    }
+
+    memset(data->resume_state, 0, ARRAY_SIZE(data->resume_state));
+
+    data->resume_state[RES_CTRL_REG1] =3D (ALL_ZEROES | PM_NORMAL
+                                    | ENABLE_ALL_AXES);
+    data->resume_state[RES_CTRL_REG2] =3D ALL_ZEROES;
+    data->resume_state[RES_CTRL_REG3] =3D ALL_ZEROES;
+    data->resume_state[RES_CTRL_REG4] =3D (ALL_ZEROES | BDU_ENABLE);
+    data->resume_state[RES_CTRL_REG5] =3D ALL_ZEROES;
+    data->resume_state[RES_FIFO_CTRL_REG] =3D ALL_ZEROES;
+
+    err =3D l3gd20_gyr_device_power_on(data);
+    if (err < 0) {
+          dev_err(&client->dev, "power on failed: %d\n", err);
+          goto exit_kfree_pdata;
+    }
+
+    atomic_set(&data->enabled, 1);
+
+    err =3D l3gd20_gyr_update_fs_range(data, data->pdata->fs_range);
+    if (err < 0) {
+          dev_err(&client->dev, "update_fs_range failed\n");
+          goto  err_power_off;
+    }
+
+    err =3D l3gd20_gyr_update_sampling_freq(data,
+                          data->pdata->sampling_frequency);
+    if (err < 0) {
+          dev_err(&client->dev, "update sampling freq failed\n");
+          goto  err_power_off;
+    }
+
+    data->indio_dev =3D iio_allocate_device();
+    if (!data->indio_dev) {
+          err =3D -ENOMEM;
+          dev_err(&client->dev, "error allocating iio device: %d\n", err);
+          goto err_power_off;
+    }
+    data->indio_dev->attrs =3D &l3gd20_gyr_attribute_group;
+    data->indio_dev->dev.parent =3D &client->dev;
+    data->indio_dev->dev_data =3D (void *)(data);
+    data->indio_dev->driver_module =3D THIS_MODULE;
+    data->indio_dev->modes =3D INDIO_DIRECT_MODE;
+
+
+
+    l3gd20_gyr_device_power_off(data);
+    /* As default, do not report information */
+    atomic_set(&data->enabled, 0);
+
+    err =3D l3gd20_gyr_configure_ring(data->indio_dev);
+    if (err)
+          goto error_free_dev;
+
+    err =3D iio_device_register(data->indio_dev);
+    if (err) {
+          dev_err(&client->dev, "error registering iio dev: %d\n", err);
+          goto error_unreg_ring_funcs;
+    }
+    regdone =3D 1;
+
+    err =3D l3gd20_gyr_initialize_ring(data->indio_dev->ring);
+    if (err) {
+          dev_err(&client->dev, "failed to initialize the ring\n");
+          goto error_unreg_ring_funcs;
+    }
+
+
+    mutex_unlock(&data->lock);
+    dev_info(&client->dev, "%s: probed\n", L3GD20_GYR_DEV_NAME);
+    return 0;
+
+
+
+error_unreg_ring_funcs:
+    l3gd20_gyr_unconfigure_ring(data->indio_dev);
+error_free_dev:
+    if (regdone)
+          iio_device_unregister(data->indio_dev);
+    else
+          iio_free_device(data->indio_dev);
+err_power_off:
+    l3gd20_gyr_device_power_off(data);
+err_pdata_init:
+    if (data->pdata->exit)
+          data->pdata->exit();
+exit_kfree_pdata:
+    kfree(data->pdata);
+err_mutexunlock:
+    mutex_unlock(&data->lock);
+    kfree(data);
+exit_check_functionality_failed:
+    printk(KERN_ERR "%s: Driver Init failed\n", L3GD20_GYR_DEV_NAME);
+    return err;
+}
+
+
+static int __devexit l3gd20_gyr_remove(struct i2c_client *client)
+{
+
+    struct l3gd20_gyr_data *dev_data =3D i2c_get_clientdata(client);
+
+    l3gd20_gyr_device_power_off(dev_data);
+
+    l3gd20_gyr_uninitialize_ring(dev_data->indio_dev->ring);
+    iio_device_unregister(dev_data->indio_dev);
+    l3gd20_gyr_unconfigure_ring(dev_data->indio_dev);
+
+    if (dev_data->pdata->exit)
+          dev_data->pdata->exit();
+    kfree(dev_data->pdata);
+    kfree(dev_data);
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
+static int __init l3gd20_gyr_init(void)
+{
+    pr_info("%s: gyroscope iio driver init\n", L3GD20_GYR_DEV_NAME);
+    return i2c_add_driver(&l3gd20_gyr_driver);
+}
+
+static void __exit l3gd20_gyr_exit(void)
+{
+    pr_info("%s exit\n", L3GD20_GYR_DEV_NAME);
+    i2c_del_driver(&l3gd20_gyr_driver);
+    return;
+}
+
+module_init(l3gd20_gyr_init);
+module_exit(l3gd20_gyr_exit);
+
+MODULE_DESCRIPTION("STMicroelectronics l3gd20 digital gyroscope iio driver=
");
+MODULE_AUTHOR("Matteo Dameno, STMicroelectronics");
+MODULE_LICENSE("GPL v2");
--
1.7.5.4


P.S.: We are working on the driver to make it compatible for the latest ker=
nel.

--_000_494E38452A01E745B763C5F242AAA2CCC50EDD9B5CSAFEX1MAIL1st_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40"><head><meta http-equiv=3DContent-Type content=
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
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
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
ics L3GD20 gyroscope device driver for Kernel version 2.6.35.13<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>S=
igned-off-by: Swapnil Tiwari &lt;swapnil.tiwari@st.com&gt;<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>---<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'> drivers/staging/iio/gyro/Kconfig&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;=
 8 +<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none=
'><span style=3D'font-family:"Courier New"'> drivers/staging/iio/gyro/Makef=
ile&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbs=
p; 2 +<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'> drivers/staging/iio/gyro/l3g=
d20.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 155 +++=
+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><=
span style=3D'font-family:"Courier New"'> drivers/staging/iio/gyro/l3gd20_g=
yr_core.c | 1056 ++++++++++++++++++++++++++++<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'> 4 files changed, 1221 insertions(+), 0 deletions(-)<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>di=
ff --git a/drivers/staging/iio/gyro/Kconfig b/drivers/staging/iio/gyro/Kcon=
fig<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>index 7e0b7f1..af2e423 100644<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>--- a/drivers/staging/iio/gyro/Kconfig=
<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><s=
pan style=3D'font-family:"Courier New"'>+++ b/drivers/staging/iio/gyro/Kcon=
fig<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>@@ -12,3 +12,11 @@ config ADIS16=
260<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'> &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;=
Say yes here to build support for Analog Devices adis16260/5<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'> &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;programmable digit=
al gyroscope sensor.<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'> <o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+config L3GD20_GYR_IIO<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tristate &quot;STM L3GD2=
0 3 Axis Digital Gyroscope Sensor I2C driver (iio)&quot;<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on I2C<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 help<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; Say yes here to build support for the STMicrolect=
ronics L3GD20 3 Axis<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Digital .<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; To c=
ompile this driver as a module, choose M here: the module<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; will be called l3gd20_gyr_iio.<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>di=
ff --git a/drivers/staging/iio/gyro/Makefile b/drivers/staging/iio/gyro/Mak=
efile<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>index a3a28ed..28f530b 100644<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>--- a/drivers/staging/iio/gyro/Makef=
ile<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+++ b/drivers/staging/iio/gyro/M=
akefile<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:n=
one'><span style=3D'font-family:"Courier New"'>@@ -6,3 +6,5 @@ adis16260-y&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :=
=3D adis16260_core.o<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'> adis16260-$(CO=
NFIG_IIO_RING_BUFFER) +=3D adis16260_ring.o adis16260_trigger.o<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'> obj-$(CONFIG_ADIS16260) +=3D adis16260.o<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'> <o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+l3gd20_gyr-y&nbsp;&nbsp;&nbsp; :=3D l3gd20_gyr_core.o<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+obj-$(CONFIG_L3GD20_GYR_IIO) +=3D l3gd20_gyr.o<o:p></o:=
p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>diff --git a/drivers/staging/iio/gyro/l3gd20=
.h b/drivers/staging/iio/gyro/l3gd20.h<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>index e69de29..d2a734a 100644<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>---=
 a/drivers/staging/iio/gyro/l3gd20.h<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+++ b/drivers/staging/iio/gyro/l3gd20.h<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>@@ -0,0 +1,155 @@<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+/***********=
********* (C) COPYRIGHT 2011 STMicroelectronics ********************<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+*<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+* File Name&nbsp;&nbsp;&nbsp; : l3gd20_iio.h<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+* Authors : MH - C&amp;I BU - Application Team<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : =
Matteo Dameno (matteo.dameno@st.com<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : author is willing to b=
e considered the contact<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+*&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : and update points for the driver.=
<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><s=
pan style=3D'font-family:"Courier New"'>+* Version : V.2.0.0<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+* Date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; : 2011/Aug/16<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+* Description&n=
bsp; : L3GD20 3 Axis Digital Gyroscope Sensor device driver iio<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; :<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+*****************************=
***************************************************<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+*<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+* This program i=
s free software; you can redistribute it and/or modify<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+* it under the terms of the GNU General Public License =
version 2 as<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+* published by the Fre=
e Software Foundation.<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+*<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+* THE PRESENT SOFTWARE IS PROVIDED ON AN &q=
uot;AS IS&quot; BASIS, WITHOUT WARRANTIES<o:p></o:p></span></p><p class=3DM=
soNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier =
New"'>+* OR CONDITIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED, FOR THE SOLE=
<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><s=
pan style=3D'font-family:"Courier New"'>+* PURPOSE TO SUPPORT YOUR APPLICAT=
ION DEVELOPMENT.<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>+* AS A RESULT, STM=
ICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY DIRECT,<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+* INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO A=
NY CLAIMS ARISING FROM THE<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+* CONTE=
NT OF SUCH SOFTWARE AND/OR THE USE MADE BY CUSTOMERS OF THE CODING<o:p></o:=
p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+* INFORMATION CONTAINED HEREIN IN CONNECTIO=
N WITH THEIR PRODUCTS.<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+*<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+*******************************************=
************************************/<o:p></o:p></span></p><p class=3DMsoNo=
rmal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"=
'>+/***********************************************************************=
********<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+Version History.<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+ Revision 2.0.0: 2012/Nov/16<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+&nbsp; first ioo implementation;<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+***************************************************=
****************************/<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+#ifndef __L3GD20_H__<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+#define __L3GD20_H__<o:p></o:p></span></p><p class=3D=
MsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier=
 New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+#define L3GD20_GYR_DEV_NAME&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &quot;l3gd20_gyr_iio&quot;<o:p></o:p></span></p><p class=3D=
MsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier=
 New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+#define L3GD20_GYR_FS_250D=
PS&nbsp;&nbsp; 0x00<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+#define L3GD20_=
GYR_FS_500DPS&nbsp;&nbsp; 0x10<o:p></o:p></span></p><p class=3DMsoNormal st=
yle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+#def=
ine L3GD20_GYR_FS_2000DPS&nbsp; 0x30<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+#define L3GD20_GYR_ENABLED&nbsp;=
&nbsp;&nbsp;&nbsp; 1<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+#define L3GD20=
_GYR_DISABLED&nbsp;&nbsp;&nbsp; 0<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+#ifdef __KERNEL__<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+/* to set gpios numb connected to gyro inte=
rrupt pins,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+ * the unused ones have=
 to be set to -EINVAL<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+ */<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+#define DEFAULT_INT1_GPIO&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; (-EINVAL)<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+#define DEFA=
ULT_INT2_GPIO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (-EINVAL)<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+#define SAD0L&n=
bsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0x00<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+#define=
 SAD0H&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x01<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+#define L3GD20_GYR_I2C_SADROOT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x35<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+#define L3GD20_GYR_I2C_SAD_L&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((L3GD20_GYR_I2C_SADROOT&lt;&lt;1)|SAD0L)<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+#define L3GD20_GYR_I2C_SAD_H&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((L3GD20_GYR_I2C_SADROOT&lt;&lt;1)|SAD0H)=
<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><s=
pan style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DM=
soNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier =
New"'>+#define L3GD20_MIN_POLL_PERIOD_MS&nbsp;&nbsp; 2<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+struct l3gd20_=
gyr_platform_data {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nb=
sp; int (*init)(void);<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;=
&nbsp; void (*exit)(void);<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp; int (*power_on)(void);<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+=
&nbsp;&nbsp;&nbsp; int (*power_off)(void);<o:p></o:p></span></p><p class=3D=
MsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier=
 New"'>+&nbsp;&nbsp;&nbsp; unsigned int poll_interval;<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+&nbsp;&nbsp;&nbsp; unsigned int min_interval;<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp; u8 fs_range;<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp=
;&nbsp;&nbsp; u8 sampling_frequency;<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; /* set gpio_i=
nt[1,2] either to the choosen gpio pin number or to -EINVAL<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;  * if leaved unconnected<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;  */<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+&nbsp;&nbsp;&nbsp; int gpio_int1;<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+&nbsp;&nbsp;&nbsp; int gpio_int2;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; /* int for fifo */<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+=
<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><s=
pan style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; /* axis mapping=
 */<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; u8 axis_map_=
x;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; u8 axis_map_y=
;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><=
span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; u8 axis_map_z;=
<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><s=
pan style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DM=
soNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp; u8 negate_x;<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+&nbsp;&nbsp;&nbsp; u8 negate_y;<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+&nbsp;&nbsp;&nbsp; u8 negate_z;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+};=
<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><s=
pan style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DM=
soNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier =
New"'>+#ifdef CONFIG_IIO_RING_BUFFER<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+/* At the moment triggers are only used for ring buffer<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+ * filling. This may change!<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+ */<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+enum l3gd20_gyr_scan {<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+&nbsp;&nbsp;&nbsp; L3GD20_GYR_SCAN_GYR_X,<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+&nbsp;&nbsp;&nbsp; L3GD20_GYR_SCAN_GYR_Y,<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; L3GD20_GYR_SCAN_GYR_Z,<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+};<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none=
'><span style=3D'font-family:"Courier New"'>+void l3gd20_gyr_remove_trigger=
(struct iio_dev *indio_dev);<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+int l3=
gd20_gyr_probe_trigger(struct iio_dev *indio_dev);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>+ssize_t l3gd20_gyr=
_read_data_from_ring(struct device *dev,<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; struct device_attribute *attr,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *=
buf);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+int l3gd20_gyr_configu=
re_ring(struct iio_dev *indio_dev);<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+void l3gd20_gyr_unconfigure_ring(struct iio_dev *indio_dev);<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+int l3g=
d20_gyr_initialize_ring(struct iio_ring_buffer *ring);<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+void l3gd20_gyr_uninitialize_ring(struct iio_ring_buffe=
r *ring);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+#else /* CONFIG_IIO_RING_=
BUFFER */<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+static inline void l3gd20_gyr_remove_trigger(struct iio_dev=
 *indio_dev)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+{<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+}<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+static inline int l3gd20_gyr_probe_trigger(stru=
ct iio_dev *indio_dev)<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+{<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+}<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+static inline ssize_t<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+l3gd20_gyr_read_data_from_ring(struct device *dev,<o:p=
></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; struct device_attribute *attr,<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *buf)<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+{<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp=
; return 0;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+}<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+static int l3gd=
20_gyr_configure_ring(struct iio_dev *indio_dev)<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+{<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; =
return 0;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+}<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+static inline voi=
d l3gd20_gyr_unconfigure_ring(struct iio_dev *indio_dev)<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+{<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+}<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+st=
atic inline int l3gd20_gyr_initialize_ring(struct iio_ring_buffer *ring)<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+{<o:p></o:p></span></p><p class=3DMso=
Normal style=3D'text-autospace:none'><span style=3D'font-family:"Courier Ne=
w"'>+&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+}=
<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><s=
pan style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DM=
soNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier =
New"'>+static inline void l3gd20_gyr_uninitialize_ring(struct iio_ring_buff=
er *ring)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+{<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+}<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+#endif /* CONFIG_IIO_RING_BUFFER */<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+#endif =
/* __KERNEL__ */<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+#endif&nbsp; /* __L3GD20_H__ */<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>diff --git a/drivers/staging/iio/gyro/l3gd20_gyr_core.c =
b/drivers/staging/iio/gyro/l3gd20_gyr_core.c<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>index e69de29..64871b6 100644<o:p></o:p></span></p><p class=3DMso=
Normal style=3D'text-autospace:none'><span style=3D'font-family:"Courier Ne=
w"'>--- a/drivers/staging/iio/gyro/l3gd20_gyr_core.c<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+++ b/drivers/staging/iio/gyro/l3gd20_gyr_core.c<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>@@ -0,0 +1,1056 @@<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+/******************** (C) COPYRIGHT 2011 STMicroelectronics =
********************<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+*<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+* File Name&nbsp;&nbsp;&nbsp; : l3gd20_gyr_core=
_iio.c<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+* Authors : MSH - Motion Mem=
s BU - Application Team<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+*&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : Matteo Dameno (matteo.dameno@st.co=
m)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; : author is willing to be considered the contact<o:p></o:=
p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; : and update points for the driver.*<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+* Version : V.2.0.0<o:p></o:p></span></p><p class=3DMsoNormal st=
yle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+* Da=
te&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 2011/Nov/16<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+* Description&nbsp; : L3GD20 3 Axis Digital=
 Gyroscope Sensor device driver iio<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+*********************************************************=
***********************<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+*<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+* This program is free software; you can re=
distribute it and/or modify<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+* it un=
der the terms of the GNU General Public License version 2 as<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+* published by the Free Software Foundation.<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+*<o:p></o:p></span></p><p class=3DMsoNo=
rmal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"=
'>+* THE PRESENT SOFTWARE IS PROVIDED ON AN &quot;AS IS&quot; BASIS, WITHOU=
T WARRANTIES<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+* OR CONDITIONS OF ANY=
 KIND, EITHER EXPRESS OR IMPLIED, FOR THE SOLE<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+* PURPOSE TO SUPPORT YOUR APPLICATION DEVELOPMENT.<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+* AS A RESULT, STMICROELECTRONICS SHALL NOT BE =
HELD LIABLE FOR ANY DIRECT,<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+* INDIR=
ECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING FROM THE<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+* CONTENT OF SUCH SOFTWARE AND/OR THE=
 USE MADE BY CUSTOMERS OF THE CODING<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+* INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.<o:p></o=
:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span styl=
e=3D'font-family:"Courier New"'>+*<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+=
***************************************************************************=
*****<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+ Revision 2.0.0: 2012/Nov/16<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+&nbsp; first ioo implementation;<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+***********************************************************************=
********/<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+#include &lt;linux/err.h&gt;<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+#include &lt;linux/errno.h&gt;<o:p></o:p></span></p><p class=3DM=
soNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier =
New"'>+#include &lt;linux/delay.h&gt;<o:p></o:p></span></p><p class=3DMsoNo=
rmal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"=
'>+#include &lt;linux/fs.h&gt;<o:p></o:p></span></p><p class=3DMsoNormal st=
yle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+#inc=
lude &lt;linux/i2c.h&gt;<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+#include &=
lt;linux/mutex.h&gt;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+#include &lt;l=
inux/input.h&gt;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>+#include &lt;linux=
/uaccess.h&gt;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+#include &lt;linux/w=
orkqueue.h&gt;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+#include &lt;linux/i=
rq.h&gt;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+#include &lt;linux/gpio.h&=
gt;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+#include &lt;linux/interrupt.h&=
gt;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+#include &lt;linux/gpio.h&gt;<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+#include &lt;linux/slab.h&gt;<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+#include &lt;linux/device.h&gt;<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+#include &lt;linux/kernel.h&gt;<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+#incl=
ude &lt;linux/sysfs.h&gt;<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+#include &lt;linux/moduleparam.h&gt;<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+#include &quot;../iio.h&quot;<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+#in=
clude &quot;../sysfs.h&quot;<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+#inclu=
de &quot;gyro.h&quot;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+#include &quo=
t;l3gd20.h&quot;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+#define SEN=
SITIVITY_250DPS&nbsp;&nbsp;&nbsp;&nbsp; &quot;8.75&quot;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**&nbsp; mdps/counts */<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+#define SENSITIVITY_500DPS&nbsp;&nbsp;&nbsp;&nbsp=
; &quot;17.50&quot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**&nbs=
p; mdps/counts */<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+#define SENSITIVI=
TY_2000DPS&nbsp;&nbsp;&nbsp; &quot;70.00&quot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /**&nbsp; mdps/counts */<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+#define SCALE_250DPS&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;0.000153&quot; /**&nbsp; (rad/sec)/count =
*/<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+#define SCALE_500DPS&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; &quot;0.000297&quot; /**&nbsp; (rad/sec)/count */<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+#define SCALE_2000DPS&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;0.001222&quot; /**&nbsp; (rad/sec)=
/count */<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+#define GAIN_250DPS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &qu=
ot;6548.089087&quot;&nbsp;&nbsp; /**&nbsp; count/(rad/sec) */<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+#define GAIN_500DPS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; &quot;3370.339971&quot;&nbsp;&nbsp; /**&nbsp; count/(rad/sec) */<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+#define GAIN_2000DPS&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; &quot;818.511136&quot;&nbsp;&nbsp;&nbsp; /**&nbsp; count/(rad=
/sec) */<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+/* l3gd20 gyroscope registers */<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+#define WHO_AM_I&nbsp;&nbsp;&nbsp; (0x0F)<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+#define CTRL_R=
EG1&nbsp;&nbsp; (0x20)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; /* CTRL REG1 */<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+#define CTRL_REG2=
&nbsp;&nbsp; (0x21)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /=
* CTRL REG2 */<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+#define CTRL_REG3&nb=
sp;&nbsp; (0x22)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* C=
TRL_REG3 */<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+#define CTRL_REG4&nbsp;=
&nbsp; (0x23)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* CTRL=
_REG4 */<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+#define CTRL_REG5&nbsp;&nb=
sp; (0x24)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* CTRL_RE=
G5 */<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; REFERENCE=
&nbsp; (0x25)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* REFE=
RENCE REG */<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+#define OUT_X_LSB&nbsp;&nbsp; (0x28)&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 1st AXIS OUT REG of 6 */<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+#define OUT_X_MSB&nbsp;&nbsp; (0x29)<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+#define OUT_Y_LSB&nbsp;&nbsp; (0x2A)<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+#define OUT_Y_MSB&nbsp;&nbsp; (0x2B)<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+#define OUT_Z_LSB&nbsp;&nbsp; (0x2C)<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+#define OUT_Z_MSB&nbsp;&nbsp; (0x2D)<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; AXISDATA_REG&nb=
sp;&nbsp;&nbsp; OUT_X_LSB<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; FIFO_CTRL_REG&nbsp;&n=
bsp; (0x2E)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* FIFO C=
ONTROL REGISTER */<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+#define FIFO_SRC=
_REG (0x2F)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* FIFO S=
OURCE REGISTER */<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+/* */<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+/* CT=
RL_REG1 */<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospac=
e:none'><span style=3D'font-family:"Courier New"'>+#define ALL_ZEROES&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x00)<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+#define PM_OFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; (0x00)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+#define PM_=
NORMAL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x08)<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+#define ENABLE_ALL_AXES&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; (0x07)<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+#define EN=
ABLE_NO_AXES&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x00)<o:p></o=
:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span styl=
e=3D'font-family:"Courier New"'>+#define BW00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x00)<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+#define BW01&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x10)<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+#define BW10&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; (0x20)<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+#=
define BW11&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; (0x30)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+#define CTRL_=
REG1_BW_MASK (0x30)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+#define ODR095&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x00)&nb=
sp; /* ODR =3D&nbsp; 95Hz */<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+#defin=
e ODR190&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
(0x40)&nbsp; /* ODR =3D 190Hz */<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+#d=
efine ODR380&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; (0x80)&nbsp; /* ODR =3D 380Hz */<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+#define ODR760&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (0xC0)&nbsp; /* ODR =3D 760Hz */<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+#define CTRL_REG1_ODR_MASK&nbsp;&nbsp;&nbsp;&nbsp; (0xC0)<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+/* CTRL_REG3 bits */<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+#define&nbsp;&nbsp; I2_DRDY&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x08)<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+#define&nbsp;&nbsp; I2_WTM&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x04)<o:p></o=
:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span styl=
e=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; I2_OVRUN&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x02)<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+#define&nbsp;&nbsp; I2_EMPTY&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x=
01)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; I2_NONE&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
(0x00)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; I2_MASK&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; (0x0F)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+/* CTRL_REG4 bits */<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+#define&nbsp;&nbsp; FS_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x30)<o:p></o:p></span></p><p class=3DMso=
Normal style=3D'text-autospace:none'><span style=3D'font-family:"Courier Ne=
w"'>+#define&nbsp;&nbsp; BDU_ENABLE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x80)<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+/* CTRL_REG5 bits */<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+#define&nb=
sp;&nbsp; FIFO_ENABLE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 (0x40)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:n=
one'><span style=3D'font-family:"Courier New"'>+#define HPF_ENALBE&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x11)<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+/* FIFO_CTRL_REG bits */<o:p=
></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; FIFO_MODE_MASK&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0xE0)<o:p></o:p></span></p><p class=3DMso=
Normal style=3D'text-autospace:none'><span style=3D'font-family:"Courier Ne=
w"'>+#define&nbsp;&nbsp; FIFO_MODE_BYPASS&nbsp;&nbsp;&nbsp;&nbsp; (0x00)<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; FIFO_MODE_FIFO&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x20)<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+#define&nbsp;&nbsp; FIFO_MODE_STREAM&nbsp;&nbsp;&nbsp;&nbsp; (0x40)<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; FIFO_MODE_STR2FI=
FO&nbsp;&nbsp; (0x60)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+#define&nbsp;=
&nbsp; FIFO_MODE_BYPASS2STR (0x80)<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+=
#define&nbsp;&nbsp; FIFO_WATERMARK_MASK&nbsp; (0x1F)<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+#define FIFO_STO=
RED_DATA_MASK&nbsp; (0x1F)<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+/* I2C multi read/write option*/<o:p></o:=
p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+#define I2C_AUTO_INCREMENT&nbsp;&nbsp;&nbsp=
;&nbsp; (0x80)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+/* RESUME STATE INDICES */<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+#define&nbsp;&nbsp; RES_CTRL_REG1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp;=
 RES_CTRL_REG2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+#define&nbsp;&nbsp; RES_CTRL_REG3&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 2<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+#define=
&nbsp;&nbsp; RES_CTRL_REG4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; RES_CTRL_REG5&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+#define&nbsp;&nbsp; RES_FIFO_CTRL_REG&nbsp;&nbsp;&nbsp; 5<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+#define&nbsp;&nbsp; RESUME_ENTRIES&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; 6<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+/*=
* Registers Contents */<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+#define WHO=
AMI_L3GD20&nbsp;&nbsp;&nbsp;&nbsp; (0x00D4)&nbsp;&nbsp; /* Expected content=
 for WAI register*/<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+struct =
output_rate {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; un=
signed int poll_rate_ms;<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbs=
p;&nbsp; u8 sampling_rate_setting;<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+=
&nbsp;&nbsp;&nbsp; const char *hz_label;<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+};<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+static const struct output_rate l3gd20_gyr_odr_table[] =3D {=
<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><s=
pan style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DM=
soNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp;&nbsp; 2,&nbsp;&nbsp; ODR760|BW10,&n=
bsp;&nbsp;&nbsp; &quot;760&quot;},<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+=
&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp;&nbsp; 3,&nbsp;&nbsp; ODR380|BW01,&nbsp;&nb=
sp;&nbsp; &quot;380&quot;},<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp; {&nbsp;&nbsp;&nbsp; 6,&nbsp;&nbsp; ODR190|BW00,&nbsp;&nbsp;&nbs=
p; &quot;190&quot;},<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&n=
bsp; {&nbsp;&nbsp;&nbsp; 11,&nbsp; ODR095|BW00,&nbsp;&nbsp;&nbsp; &quot;95&=
quot;},<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:n=
one'><span style=3D'font-family:"Courier New"'>+};<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>+static struct l3gd=
20_gyr_platform_data default_l3gd20_gyr_pdata =3D {<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+&nbsp;&nbsp;&nbsp; .fs_range =3D L3GD20_GYR_FS_250DPS,<o:p=
></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; .axis_map_x =3D 0,<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; .axis_map_y =3D =
1,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; .axis_map_z =
=3D 2,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; .negate_x=
 =3D 0,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:n=
one'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; .negate_=
y =3D 0,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; .negate=
_z =3D 0,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+&nbsp;&nbsp;&nbsp; .gpio_int1 =3D DEFAULT_INT1_GPIO,<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; .gpio_int2 =3D DEFAULT=
_INT2_GPIO,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* int for fifo */<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+};<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+struct l3gd20_gyr_data {<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; struct work_struct&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
work_trigger_to_ring;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&=
nbsp; struct iio_work_cont&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; work_cont_thresh;<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+&nbsp;&nbsp;&nbsp; s64&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; last_timestamp;<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp; struct iio_dev&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *indio_dev;<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; struct iio_trigger&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *t=
rig;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none=
'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp; struct i2c_client&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *client;<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; struct l3gd20_gyr_platfo=
rm_data&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *pdata;<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; use_smbus;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; struct mutex&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lock;<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; hw_initialized;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; atomic_t&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; enabled;<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; char const&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; *scale;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp=
;&nbsp; char const&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *gain;<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; u8&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_ad=
dr;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; u8&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; resume_state[RE=
SUME_ENTRIES];<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&=
nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ir=
q1;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; int&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; irq2;<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+};<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+static int l3gd20_gyr_i2c_read(s=
truct l3gd20_gyr_data *data,<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8 *buf, int len)<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+{<o:p></o:p></span></p><p class=3DMso=
Normal style=3D'text-autospace:none'><span style=3D'font-family:"Courier Ne=
w"'>+&nbsp;&nbsp;&nbsp; int ret;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp; u8 reg =3D buf[0];<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+&nbsp;&nbsp;&nbsp; u8 cmd =3D reg;<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><=
span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (len &gt; 1=
)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><=
span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cmd =3D (I2C_AUTO_INCREMENT | reg);<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (data-&gt;use_smbus) {<o:p></o=
:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span styl=
e=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; if (len =3D=3D 1) {<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ret =3D i2c_smbus_read_byte_data(data-&gt;client, cmd);<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf[0] =3D ret &amp; 0xff;<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
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
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pri=
ntk(KERN_DEBUG &quot;buf[%d]=3D0x%02x,&quot;,<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ii, buf[ii]);<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; printk(&quot;\n&quot;);<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+#endif<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; ret =3D -1;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; if (ret &lt; 0) {<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; dev_err(&amp;data-&gt;client-&gt;dev,<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;read transfer =
error: len:%d, command=3D0x%02x\n&quot;,<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; len, cmd);<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0; /* failure */<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 }<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; return len; /* success */<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+=
<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><s=
pan style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DM=
soNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp; ret =3D i2c_master_send(data-&gt;client, &amp;cmd=
, sizeof(cmd));<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; =
if (ret !=3D sizeof(cmd))<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp; return i2c_master_recv(data-&gt;client, buf, len);<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+}<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+static int l3gd20_gyr_i2c_write(struct =
l3gd20_gyr_data *data, u8 *buf,<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; int len)<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+{<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; int ret;<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; u8 reg, value;<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp; if (len &gt; 1)<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf[0] =3D (I2C_AUTO_INCREM=
ENT | buf[0]);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+&nbsp;&nbsp;&nbsp; reg =3D buf[0];<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+&nbsp;&nbsp;&nbsp; value =3D buf[1];<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp=
;&nbsp; if (data-&gt;use_smbus) {<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (len =3D=3D 1) {<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D i2c_smbus_write_by=
te_data(data-&gt;client, reg,<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value);<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+#ifdef DEBUG<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; dev_dbg(&amp;data-&gt;client-&gt;dev,<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;i2c_smbus_write_by=
te_data: ret=3D%d, len:%d, &quot;<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;command=3D0x%02x, value=3D0x%0=
2x\n&quot;,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; ret, len, reg , value);<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+#endif<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; return ret;<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; } else if (len &gt; 1) {<o:p></o:p></span></p><p class=3DMso=
Normal style=3D'text-autospace:none'><span style=3D'font-family:"Courier Ne=
w"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D i2c_smbus_write_i2c_block_data(data-&gt;client,<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; reg, len, buf + 1);<o:p></o:p></span></p><p class=3DM=
soNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier =
New"'>+#ifdef DEBUG<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_d=
bg(&amp;data-&gt;client-&gt;dev,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;i2c_smbus_write_i2c_block_data:=
 ret=3D%d, &quot;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; &quot;len:%d, command=3D0x%02x, &quot;,<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret, le=
n, reg);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char ii;<o:p></o=
:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span styl=
e=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (ii =3D 0; ii &lt; len + 1; =
ii++)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; printk(KERN_DEBUG &quot;value[%d]=3D0x%02x,&quot;,<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ii, buf[ii]);<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; printk(&quot;\n&quot;);<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+#endif<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; }<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+&nbsp;&nbsp;&nbsp; ret =3D i2c_master_send(data-&gt;client, buf, len+1);<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; return (ret =3D=
=3D len+1) ? 0 : ret;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+}<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+static int l3gd20_gyr_register_write(st=
ruct l3gd20_gyr_data *data,<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8 *buf, u8 reg_address, u8=
 new_value)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+{<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+&nbsp;&nbsp;&nbsp; int err;<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Sets configuration register at reg_addr=
ess<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;  *&nbsp; NOTE: this is a straight overwrite&nbsp; *=
/<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><=
span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; buf[0] =3D reg_address;<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf[1] =
=3D new_value;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D l3gd20_gyr_i2c_write(data, buf, =
1);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (err &lt; 0)<o:p></o:p></span></p><p class=3DMso=
Normal style=3D'text-autospace:none'><span style=3D'font-family:"Courier Ne=
w"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return err;<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; return err;<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+}<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+static int l3gd20_gyr_register_read=
(struct l3gd20_gyr_data *data,<o:p></o:p></span></p><p class=3DMsoNormal st=
yle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; u8 *buf, u8 reg_address)<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+{<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; int err =3D -1;<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; buf[0] =3D (reg_address);<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; err =3D l3gd20_gyr_i2=
c_read(data, buf, 1);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&=
nbsp; return err;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+}<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+static =
int l3gd20_gyr_register_update(struct l3gd20_gyr_data *data,<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; u8 *buf, u8 reg_address, u8 mask, u8 new_bit_values)<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+{<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp; int err =3D -1;<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp; u8 init_val;<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbs=
p;&nbsp; u8 updated_val;<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbs=
p;&nbsp; err =3D l3gd20_gyr_register_read(data, buf, reg_address);<o:p></o:=
p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (!(err &lt; 0)) {<o:p=
></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; init_val =3D buf[0];<o:p></o:p></span></p><p class=3DMsoNo=
rmal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"=
'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; updated_val =3D (=
(mask &amp; new_bit_values) | ((~mask) &amp; init_val));<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; err =3D l3gd20_gyr_register_write(data, buf, reg_address,<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; updated_va=
l);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; return err;<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+}<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+static int l3gd20_gyr_hw_init(struct l3=
gd20_gyr_data *dev_data)<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+{<o:p></o:=
p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; int err;<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; u8 buf[6];<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&n=
bsp; pr_info(&quot;%s hw init\n&quot;, L3GD20_GYR_DEV_NAME);<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp; buf[0] =3D (CTRL_REG1);<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+&nbsp;&nbsp;&nbsp; buf[1] =3D dev_data-&gt;resume_state[RES_CTRL_REG1];<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; buf[2] =3D dev_dat=
a-&gt;resume_state[RES_CTRL_REG2];<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+=
&nbsp;&nbsp;&nbsp; buf[3] =3D dev_data-&gt;resume_state[RES_CTRL_REG3];<o:p=
></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; buf[4] =3D dev_data=
-&gt;resume_state[RES_CTRL_REG4];<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&=
nbsp;&nbsp;&nbsp; buf[5] =3D dev_data-&gt;resume_state[RES_CTRL_REG5];<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+&nbsp;&nbsp;&nbsp; err =3D l3gd20_gyr_i2c_write(dev_data, buf, 5);<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (err &lt; 0)<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return err;<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; buf[0] =3D FIFO_CTRL_R=
EG;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; buf[1] =3D d=
ev_data-&gt;resume_state[RES_FIFO_CTRL_REG];<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp; err =3D l3gd20_gyr_i2c_write(dev_data, buf, 1=
);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (err &lt; =
0)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp; dev_data-&gt;hw_initialized =3D 1;<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp=
; return err;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+}<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+static void l=
3gd20_gyr_device_power_off(struct l3gd20_gyr_data *dev_data)<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+{<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp; int err;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&n=
bsp; u8 buf[2];<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+&nbsp;&nbsp;&nbsp; pr_info(&quot;%s power off\n&quot;=
, L3GD20_GYR_DEV_NAME);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; buf[0] =3D CTRL_REG1;<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; buf[1] =3D PM_OFF;=
<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><s=
pan style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; err =3D l3gd20_=
gyr_i2c_write(dev_data, buf, 1);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp; if (err &lt; 0)<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(&amp;dev_data-=
&gt;client-&gt;dev, &quot;soft power off failed\n&quot;);<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp=
;&nbsp; if (dev_data-&gt;pdata-&gt;power_off) {<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dat=
a-&gt;pdata-&gt;power_off();<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_data-&gt;hw_initialize=
d =3D 0;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; }<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+&nbsp;&nbsp;&nbsp; if (dev_data-&gt;hw_initialized)<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; de=
v_data-&gt;hw_initialized =3D 0;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+}<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+static int l3gd20_gyr_device_power_on(struct l3gd20_gyr_data *dev_dat=
a)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+{<o:p></o:p></span></p><p class=
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
gyr_enable(struct l3gd20_gyr_data *dev_data)<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+{<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; int=
 err;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+&nbsp;&nbsp;&nbsp; if (!atomic_cmpxchg(&amp;dev_data-&gt;enable=
d, 0, 1)) {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; er=
r =3D l3gd20_gyr_device_power_on(dev_data);<o:p></o:p></span></p><p class=
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
atic int l3gd20_gyr_disable(struct l3gd20_gyr_data *dev_data)<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+{<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; printk(KERN_DEBUG &qu=
ot;%s: dev_data-&gt;enabled =3D %d\n&quot;, __func__,<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a=
tomic_read(&amp;dev_data-&gt;enabled));<o:p></o:p></span></p><p class=3DMso=
Normal style=3D'text-autospace:none'><span style=3D'font-family:"Courier Ne=
w"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (atomic=
_cmpxchg(&amp;dev_data-&gt;enabled, 1, 0))<o:p></o:p></span></p><p class=3D=
MsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier=
 New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; l3gd20_gyr_d=
evice_power_off(dev_data);<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+}<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+static int l3gd20_gyr_update_fs_range(s=
truct l3gd20_gyr_data *dev_data,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
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
r_data *data,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8 freq)<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+{<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; =
int res =3D 0;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; u=
8 buf[2];<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; u8 new=
_value;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:n=
one'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; u8 mask =
=3D (CTRL_REG1_ODR_MASK|CTRL_REG1_BW_MASK);<o:p></o:p></span></p><p class=
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
_gyr_data *data =3D indio_dev-&gt;dev_data;<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp; u8 i;<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+&nbsp;&nbsp;&nbsp; u8 val;<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+=
&nbsp;&nbsp;&nbsp; mutex_lock(&amp;data-&gt;lock);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+&nbsp;&nbsp;&nbsp; val =3D data-&gt;pdata-&gt;sampling_freq=
uency;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; mutex_unl=
ock(&amp;data-&gt;lock);<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbs=
p;&nbsp; dev_dbg(dev, &quot;getting sampling frequency: 0x%02x\n&quot;, val=
);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; ARRAY_SIZE(l3gd20_gyr_od=
r_table); i++)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (l3gd20_gyr_odr_table[i].sampling_rat=
e_setting =3D=3D val)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bre=
ak;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp; return sprintf(buf, &quot;%s\n&quot;, l3gd20_=
gyr_odr_table[i].hz_label);<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+}<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+static ssize_t l3gd20_gyr_store_sampling_frequency(struct device *dev,<o:p=
></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct =
device_attribute *attr,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; const char *buf, size_t size)<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+{<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;=
 struct iio_dev *indio_dev =3D dev_get_drvdata(dev);<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+&nbsp;&nbsp;&nbsp; struct l3gd20_gyr_data *data =3D indio=
_dev-&gt;dev_data;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbs=
p; u8 found =3D 0;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbs=
p; u8 i;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; u8 ret;=
<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><s=
pan style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DM=
soNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; ARRAY_SIZE(l3gd20_gyr_odr_ta=
ble); i++) {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (strcmp(buf, l3gd20_gyr_odr_table[i].hz=
_label) =3D=3D 0) {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; found=
 =3D 1;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:n=
one'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; }<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+&nbsp;&nbsp;&nbsp; if (!found) {<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(dev, &qu=
ot;trying to set invalid sampling frequency: %s\n&quot;<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;new samp=
ling frequency not set!\n&quot;, buf);<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return&nbsp; -EI=
NVAL;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; } else {<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; mutex_lock(&amp;data-&gt;lock);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =
=3D l3gd20_gyr_update_sampling_freq(data,<o:p></o:p></span></p><p class=3DM=
soNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; l3gd20_gyr_odr_table[i].sampling_rate_setting);<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; if (ret &lt; 0)<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; goto error;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;pdata-&gt;sampling_frequency =
=3D<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; l3gd20_gyr_odr_table[=
i].sampling_rate_setting;<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(dev, &quot;set new=
 sampling frequency: %s Hz\n&quot;,<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; l3gd20_gyr_odr_table[i].hz_label);<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;=
data-&gt;lock);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; =
}<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><=
span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; return size;<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+error:<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;data-&gt;lock);<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+}<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+=
static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; l3gd20=
_gyr_show_sampling_frequency,<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; l3gd20_gyr_store_sampling=
_frequency);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+static ssize_t l3gd20_gyr_show_enable(struct device *dev=
,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><=
span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; struct device_attribute *attr, char *buf)<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+{<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;=
&nbsp; struct iio_dev *indio_dev =3D dev_get_drvdata(dev);<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; struct l3gd20_gyr_data *data =3D=
 indio_dev-&gt;dev_data;<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbs=
p;&nbsp; int val =3D atomic_read(&amp;data-&gt;enabled);<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+&nbsp;&nbsp;&nbsp; return sprintf(buf, &quot;%d\n&quo=
t;, val);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+}<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+static ssize_t l3=
gd20_gyr_store_enable(struct device *dev,<o:p></o:p></span></p><p class=3DM=
soNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribu=
te *attr,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; const char *buf, size_t size)<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+{<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbs=
p; struct iio_dev *indio_dev =3D dev_get_drvdata(dev);<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+&nbsp;&nbsp;&nbsp; struct l3gd20_gyr_data *data =3D ind=
io_dev-&gt;dev_data;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&n=
bsp; unsigned long val;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (strict_strtoul(buf, =
10, &amp;val))<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;=
 if (val)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; l3gd20_gyr_enable(data);<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+&nbsp;&nbsp;&nbsp; else<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; l3gd20_gy=
r_disable(data);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+&nbsp;&nbsp;&nbsp; return size;<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+}<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+static IIO_DEVICE_ATTR(enable_device,<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S_IWUSR | S_IRUGO,<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; l3gd20_gyr_show_enable,<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; l3gd20_gyr_store_enable,<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0);<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none=
'><span style=3D'font-family:"Courier New"'>+static int l3gd20_gyr_show_cha=
nnel_rawdata(struct device *dev,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c=
har *buf)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+{<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+&nbsp;&nbsp;&nbsp; struct iio_dev *indio_dev =3D dev_get_d=
rvdata(dev);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; str=
uct l3gd20_gyr_data *data =3D indio_dev-&gt;dev_data;<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+&nbsp;&nbsp;&nbsp; struct iio_dev_attr *this_attr =3D to=
_iio_dev_attr(attr);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&n=
bsp; int err;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+&nbsp;&nbsp;&nbsp; /* Data bytes from hardware (GxL, Gx=
H) or (GyL, GyH) or (GzL, GzH) */<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&=
nbsp;&nbsp;&nbsp; u8 out_data[2];<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&=
nbsp;&nbsp;&nbsp; /* x,y,z hardware data */<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp; s16 raw_d;<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; out_data[=
0] =3D this_attr-&gt;address;<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; mutex_lock(&amp;data=
-&gt;lock);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; err =
=3D l3gd20_gyr_i2c_read(data, out_data, 2);<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;data-&gt;lock);<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (err &lt; 0) {<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; dev_err(dev, &quot;error reading output registers\n&quot;);<o:p=
></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; return err;<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;=
&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+&nbsp;&nbsp;&nbsp; raw_d =3D ((s16) ((out_data[1]) &lt=
;&lt; 8) | out_data[0]);<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbs=
p;&nbsp; return sprintf(buf, &quot;%d\n&quot;, raw_d);<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+}<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+static=
 IIO_DEV_ATTR_GYRO_X(l3gd20_gyr_show_channel_rawdata, OUT_X_LSB);<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+static IIO_DEV_ATTR_GYRO_Y(l3gd20_gyr_show_=
channel_rawdata, OUT_Y_LSB);<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+static=
 IIO_DEV_ATTR_GYRO_Z(l3gd20_gyr_show_channel_rawdata, OUT_Z_LSB);<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+st=
atic ssize_t l3gd20_gyr_show_range(struct device *dev,<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;  struct device_attribute *attr,<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;  char *buf)<o:p></o:p></span></p><p class=3DMsoNormal st=
yle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+{<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; struct iio_dev *in=
dio_dev =3D dev_get_drvdata(dev);<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&=
nbsp;&nbsp;&nbsp; struct l3gd20_gyr_data *data =3D indio_dev-&gt;dev_data;<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; int label =3D 0;=
<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><s=
pan style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; u8 val;<o:p></o=
:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span styl=
e=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; mutex_lock(&amp;data-&g=
t;lock);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; val =3D=
 data-&gt;pdata-&gt;fs_range;<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp=
;&nbsp;&nbsp; mutex_unlock(&amp;data-&gt;lock);<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; sw=
itch (val) {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; cas=
e L3GD20_GYR_FS_250DPS:<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; label =3D 250;<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospac=
e:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; case =
L3GD20_GYR_FS_500DPS:<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; label =3D 500;<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; break;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; case L3=
GD20_GYR_FS_2000DPS:<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; label =3D 2000;<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; break;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; }<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+&nbsp;&nbsp;&nbsp; return sprintf(buf, &quot;%d dps\n&quot;, label);<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+}<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+static ssize_t l3gd20_gyr_store_=
range(struct device *dev,<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;=
 struct device_attribute *attr,<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &n=
bsp; const char *buf,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; size_=
t size)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:n=
one'><span style=3D'font-family:"Courier New"'>+{<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+&nbsp;&nbsp;&nbsp; struct iio_dev *indio_dev =3D dev_get_drv=
data(dev);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospac=
e:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; struc=
t l3gd20_gyr_data *data =3D indio_dev-&gt;dev_data;<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+&nbsp;&nbsp;&nbsp; unsigned long val;<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+&nbsp;&nbsp;&nbsp; u8 range;<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+&nbsp;&nbsp;&nbsp; int err =3D -1;<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+&nbsp;&nbsp;&nbsp; if (strict_strtoul(buf, 10, &amp;val)) {<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; dev_err(dev, &quot;invalid range %lu\n. Range not change=
d&quot;, val);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+&nbsp;&nbsp;&nbsp; switch (val) {<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+&nbsp;&nbsp;&nbsp; case 250:<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range =3D L3GD20_GYR_FS_2=
50DPS;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&=
nbsp;&nbsp;&nbsp; case 500:<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range =3D L3GD20_GYR_FS_500=
DPS;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none=
'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nb=
sp;&nbsp;&nbsp; case 2000:<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range =3D L3GD20_GYR_FS_200=
0DPS;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp; default:<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(dev, &quot;invalid =
range %lu. Range not changed\n&quot;, val);<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -E=
INVAL;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; }<o:p></o=
:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span styl=
e=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&=
nbsp;&nbsp;&nbsp; mutex_lock(&amp;data-&gt;lock);<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+&nbsp;&nbsp;&nbsp; data-&gt;pdata-&gt;fs_range =3D range;<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; err =3D l3gd20_gyr=
_update_fs_range(data, range);<o:p></o:p></span></p><p class=3DMsoNormal st=
yle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbs=
p;&nbsp;&nbsp; mutex_unlock(&amp;data-&gt;lock);<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+&nbsp;&nbsp;&nbsp; if (err &lt; 0)<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto e=
rror;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; dev_info(d=
ev, &quot;set range to %lu dps\n&quot;, val);<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp; return size;<o:p></o:p></span></p><p class=3D=
MsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier=
 New"'>+error:<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; d=
ev_err(dev, &quot;error changing range\n&quot;);<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+&nbsp;&nbsp;&nbsp; return err;<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+}<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+static IIO_DEVICE_ATTR(gyro_range,<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S_IWUSR | S_IRUGO,<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; l3gd20_gyr_show_range,<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; l3gd20_gyr_store_range,<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; 0);<o:p></o:p></span></p><p class=3DMsoNormal st=
yle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p=
></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNo=
rmal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"=
'>+static IIO_CONST_ATTR(gyro_range_available, &quot;250 500 2000&quot;);<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMso=
Normal style=3D'text-autospace:none'><span style=3D'font-family:"Courier Ne=
w"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+static ssize_t l3gd20_gyr_sho=
w_gain(struct device *dev,<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *buf)<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+{<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;=
&nbsp;&nbsp; struct iio_dev *indio_dev =3D dev_get_drvdata(dev);<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; struct l3gd20_gyr_data *=
data =3D indio_dev-&gt;dev_data;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp; return sprintf(buf, &quot;%s\n&quot;, data-&gt;gain);<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+}<o:p></o:p></span></p><p class=3DMsoNo=
rmal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"=
'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+static IIO_DEVICE_ATTR(gyro_gai=
n, S_IRUGO,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; l3gd20_gyr_sh=
ow_gain,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL , 0);<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><=
span style=3D'font-family:"Courier New"'>+static ssize_t l3gd20_gyr_show_sc=
ale(struct device *dev,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  struct de=
vice_attribute *attr,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  char *buf)<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+{<o:p></o:p></span></p><p class=3DM=
soNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp; struct iio_dev *indio_dev =3D dev_get_drvdata(dev=
);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; struct l3gd20=
_gyr_data *data =3D indio_dev-&gt;dev_data;<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp; return sprintf(buf, &quot;%s\n&quot;, data-&g=
t;scale);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+}<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+static IIO_DEVICE=
_ATTR(gyro_scale, S_IRUGO,<o:p></o:p></span></p><p class=3DMsoNormal style=
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
mp;iio_dev_attr_gyro_x_raw.dev_attr.attr,<o:p></o:p></span></p><p class=3DM=
soNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp; &amp;iio_dev_attr_gyro_y_raw.dev_attr.attr,<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; &amp;iio_dev_attr_gyr=
o_z_raw.dev_attr.attr,<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;=
&nbsp; &amp;iio_dev_attr_sampling_frequency.dev_attr.attr,<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; &amp;iio_const_attr_sampling_fre=
quency_available.dev_attr.attr,<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nb=
sp;&nbsp;&nbsp; NULL<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+};<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+stati=
c const struct attribute_group l3gd20_gyr_attribute_group =3D {<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; .attrs =3D l3gd20_gyr_attri=
butes,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+};<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+static int l3gd20_g=
yr_validate_pdata(struct l3gd20_gyr_data *dev_data)<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+{<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (dev_data-&gt;pdata-&gt;axis=
_map_x &gt; 2 ||<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp; dev_data-&gt;pdata-&gt;axis_map_y &gt; 2 ||<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dev_data=
-&gt;pdata-&gt;axis_map_z &gt; 2) {<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(&amp;dev_da=
ta-&gt;client-&gt;dev,<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &q=
uot;invalid axis_map value x:%u y:%u z%u\n&quot;,<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; dev_data-&gt;pdata-&gt;axis_map_x,<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_data-&gt;pdata-&gt;axis_map_y,<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_data-&gt;pdata-&gt;axis_ma=
p_z);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<o:p></o:p></span></p><p class=3DM=
soNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; /* Only allow 0 and 1 =
for negation boolean flag */<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;=
&nbsp;&nbsp; if (dev_data-&gt;pdata-&gt;negate_x &gt; 1 ||<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dev_data-&gt;=
pdata-&gt;negate_y &gt; 1 ||<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;=
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dev_data-&gt;pdata-&gt;negate_z &gt; 1) {<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; dev_err(&amp;dev_data-&gt;client-&gt;dev,<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;invalid negate value x:%u y:%u z:=
%u\n&quot;,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_data-&gt;=
pdata-&gt;negate_x,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_d=
ata-&gt;pdata-&gt;negate_y,<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; dev_data-&gt;pdata-&gt;negate_z);<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbs=
p;&nbsp; return 0;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+}<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+static =
int l3gd20_gyr_probe(struct i2c_client *client,<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const s=
truct i2c_device_id *id)<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+{<o:p></o:=
p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; struct l3gd20_gyr_data *=
data;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; int err =
=3D -1;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:n=
one'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; data =3D=
 kzalloc(sizeof(struct l3gd20_gyr_data), GFP_KERNEL);<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (data =3D=3D NULL) {<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; err =3D -ENOMEM;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(&amp;client-&gt;dev,<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; &quot;failed to allocate memory for module data: &quot;<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; &quot;%d\n&quot;, err);<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto e=
xit_check_functionality_failed;<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nb=
sp;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; u32 smbus_func =3D I2C_FUNC_SMBU=
S_BYTE_DATA |<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2C_FUNC_SM=
BUS_WORD_DATA | I2C_FUNC_SMBUS_I2C_BLOCK ;<o:p></o:p></span></p><p class=3D=
MsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier=
 New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; int reg=
done =3D 0;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+&nbsp;&nbsp;&nbsp; pr_info(&quot;%s: probe start.\n&quot;=
, L3GD20_GYR_DEV_NAME);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp; /* Support for both I2C and SMBUS adapter interfaces. */<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (!i2c_check_fu=
nctionality(client-&gt;adapter, I2C_FUNC_I2C)) {<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_wa=
rn(&amp;client-&gt;dev, &quot;client not i2c capable\n&quot;);<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (i2c_check_functionality(client-&gt;adapter, smbus_func)) {<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;use_smbus =3D 1;<o:p=
></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(&amp;client-&gt;dev=
, &quot;client using SMBUS\n&quot;);<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D -ENODEV;<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(&amp;client-&gt;dev, &quot;client=
 nor SMBUS capable\n&quot;);<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data-&gt;use_smbus =3D 0;<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; goto exit_check_functionality_failed;<o:p></o:p></span></p><p class=3D=
MsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier=
 New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbs=
p; mutex_init(&amp;data-&gt;lock);<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+=
&nbsp;&nbsp;&nbsp; mutex_lock(&amp;data-&gt;lock);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+&nbsp;&nbsp;&nbsp; data-&gt;client =3D client;<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; i2c_set_clientdata(client, d=
ata);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+&nbsp;&nbsp;&nbsp; data-&gt;pdata =3D kmalloc(sizeof(*data-&gt;=
pdata), GFP_KERNEL);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&n=
bsp; if (data-&gt;pdata =3D=3D NULL) {<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D -ENOMEM;=
<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><s=
pan style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; dev_err(&amp;client-&gt;dev,<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;failed to allo=
cate memory for pdata: %d\n&quot;,<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err);<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_=
mutexunlock;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; }<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMso=
Normal style=3D'text-autospace:none'><span style=3D'font-family:"Courier Ne=
w"'>+&nbsp;&nbsp;&nbsp; if (client-&gt;dev.platform_data =3D=3D NULL) {<o:p=
></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; memcpy(data-&gt;pdata, &amp;default_l3gd20_gyr_pdata,<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sizeof(*data-&gt;pdata));<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_inf=
o(&amp;client-&gt;dev, &quot;using default platform data\n&quot;);<o:p></o:=
p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; } else {<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; memcpy(data-&gt;pdata, client-&gt;dev.platform_data,<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; sizeof(*data-&gt;pdata));<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+=
&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; err =3D l3gd20_gyr_validate_p=
data(data);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (=
err &lt; 0) {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(&amp;client-&gt;dev, &quot;failed=
 to validate platform data\n&quot;);<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto exit_kfree_pd=
ata;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none=
'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (data-&gt;pdat=
a-&gt;init) {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D data-&gt;pdata-&gt;init();<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (err &lt; 0) {<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; dev_err(&amp;client-&gt;dev, &quot;init failed: %d\n&quot;, err);<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_pdata_init;<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; =
}<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><=
span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3D=
MsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier=
 New"'>+&nbsp;&nbsp;&nbsp; memset(data-&gt;resume_state, 0, ARRAY_SIZE(data=
-&gt;resume_state));<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; data-&gt;resume_state[RES_CTR=
L_REG1] =3D (ALL_ZEROES | PM_NORMAL<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | ENABLE_ALL_=
AXES);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; data-&gt;=
resume_state[RES_CTRL_REG2] =3D ALL_ZEROES;<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp; data-&gt;resume_state[RES_CTRL_REG3] =3D ALL_=
ZEROES;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:n=
one'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; data-&gt=
;resume_state[RES_CTRL_REG4] =3D (ALL_ZEROES | BDU_ENABLE);<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; data-&gt;resume_state[RES_CTRL_=
REG5] =3D ALL_ZEROES;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&=
nbsp; data-&gt;resume_state[RES_FIFO_CTRL_REG] =3D ALL_ZEROES;<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;=
&nbsp;&nbsp; err =3D l3gd20_gyr_device_power_on(data);<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (err &lt; 0) {<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; dev_err(&amp;client-&gt;dev, &quot;power on failed: %d\n&quot;, err);<o:p=
></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; goto exit_kfree_pdata;<o:p></o:p></span></p><p class=3DMso=
Normal style=3D'text-autospace:none'><span style=3D'font-family:"Courier Ne=
w"'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; atomic_set(&amp;data-&=
gt;enabled, 1);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+&nbsp;&nbsp;&nbsp; err =3D l3gd20_gyr_update_fs_range=
(data, data-&gt;pdata-&gt;fs_range);<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+&nbsp;&nbsp;&nbsp; if (err &lt; 0) {<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(&amp;cli=
ent-&gt;dev, &quot;update_fs_range failed\n&quot;);<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; got=
o&nbsp; err_power_off;<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;=
&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+&nbsp;&nbsp;&nbsp; err =3D l3gd20_gyr_update_sampling_freq(d=
ata,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none=
'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;pdata-&gt;sampling_f=
requency);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospac=
e:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (e=
rr &lt; 0) {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(&amp;client-&gt;dev, &quot;update =
sampling freq failed\n&quot;);<o:p></o:p></span></p><p class=3DMsoNormal st=
yle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto&nbsp; err_power_off=
;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><=
span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;=
&nbsp;&nbsp; data-&gt;indio_dev =3D iio_allocate_device();<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (!data-&gt;indio_dev) {<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; err =3D -ENOMEM;<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(&amp;client-&gt=
;dev, &quot;error allocating iio device: %d\n&quot;, err);<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; goto err_power_off;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp=
;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; data-&=
gt;indio_dev-&gt;attrs =3D &amp;l3gd20_gyr_attribute_group;<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; data-&gt;indio_dev-&gt;dev.pare=
nt =3D &amp;client-&gt;dev;<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp; data-&gt;indio_dev-&gt;dev_data =3D (void *)(data);<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; data-&gt;indio_dev-&gt;driv=
er_module =3D THIS_MODULE;<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp; data-&gt;indio_dev-&gt;modes =3D INDIO_DIRECT_MODE;<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+&nbsp;&nbsp;&nbsp; l3gd20_gyr_device_power_off(data);<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+&nbsp;&nbsp;&nbsp; /* As default, do not report inform=
ation */<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; atomic_=
set(&amp;data-&gt;enabled, 0);<o:p></o:p></span></p><p class=3DMsoNormal st=
yle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p=
></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; err =3D l3gd20_gyr_=
configure_ring(data-&gt;indio_dev);<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+&nbsp;&nbsp;&nbsp; if (err)<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_free_dev;<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+&nbsp;&nbsp;&nbsp; err =3D iio_device_register(data-&gt;indio_dev);<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (err) {<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; dev_err(&amp;client-&gt;dev, &quot;error registering iio dev: %d\n=
&quot;, err);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_unreg_ring_funcs;<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+&nbsp;&nbsp;&nbsp; regdone =3D 1;<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; er=
r =3D l3gd20_gyr_initialize_ring(data-&gt;indio_dev-&gt;ring);<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (err) {<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; dev_err(&amp;client-&gt;dev, &quot;failed to initialize the ring\n&quot;=
);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; goto error_unreg_ring_funcs;<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNo=
rmal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"=
'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;data-&gt;lock);<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; dev_info(&amp;client-&gt;de=
v, &quot;%s: probed\n&quot;, L3GD20_GYR_DEV_NAME);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+error_unreg_ring=
_funcs:<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:n=
one'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; l3gd20_g=
yr_unconfigure_ring(data-&gt;indio_dev);<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+error_free_dev:<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&=
nbsp; if (regdone)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iio_device_unregister(data-&gt;indio=
_dev);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; else<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; iio_free_device(data-&gt;indio_dev);<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+err_power_off:<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp; l3gd20_gyr_device_power_off(data);<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+err_pdata_init:<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp; if (data-&gt;pdata-&gt;exit)<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;=
pdata-&gt;exit();<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+exit_kfree_pdata:=
<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><s=
pan style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; kfree(data-&gt;=
pdata);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:n=
one'><span style=3D'font-family:"Courier New"'>+err_mutexunlock:<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;data-&=
gt;lock);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; kfree(=
data);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+exit_check_functionality_fai=
led:<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none=
'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; printk(KERN=
_ERR &quot;%s: Driver Init failed\n&quot;, L3GD20_GYR_DEV_NAME);<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; return err;<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+}<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+static int __devexit l3gd20_gyr_remove(struct i2c_client *client)<o:p></o=
:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span styl=
e=3D'font-family:"Courier New"'>+{<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+=
<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><s=
pan style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; struct l3gd20_g=
yr_data *dev_data =3D i2c_get_clientdata(client);<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; =
l3gd20_gyr_device_power_off(dev_data);<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none=
'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; l3gd20_gyr_=
uninitialize_ring(dev_data-&gt;indio_dev-&gt;ring);<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+&nbsp;&nbsp;&nbsp; iio_device_unregister(dev_data-&gt;indi=
o_dev);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:n=
one'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; l3gd20_g=
yr_unconfigure_ring(dev_data-&gt;indio_dev);<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (=
dev_data-&gt;pdata-&gt;exit)<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_data-&gt;pdata-&gt;exi=
t();<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none=
'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; kfree(dev_d=
ata-&gt;pdata);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; =
kfree(dev_data);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+}<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+static const struct i2c_device_id l3gd20_gyr_id[] =
=3D {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; { L3GD20_G=
YR_DEV_NAME , 0 },<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbs=
p; {},<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+};<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+MODULE_DEVICE_TABLE=
(i2c, l3gd20_gyr_id);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+static struct i2c_driver l3gd20_gyr_driver =3D =
{<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><=
span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; .driver =3D {<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .owner =3D THIS_MODULE,<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name =3D L3GD20_GYR_DEV_N=
AME,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none=
'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; },<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+=
&nbsp;&nbsp;&nbsp; .probe =3D l3gd20_gyr_probe,<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+&nbsp;&nbsp;&nbsp; .remove =3D __devexit_p(l3gd20_gyr_remove),=
<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><s=
pan style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; .id_table =3D l=
3gd20_gyr_id,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+};<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+static int _=
_init l3gd20_gyr_init(void)<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+{<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; pr_info(&quot;%s: gyr=
oscope iio driver init\n&quot;, L3GD20_GYR_DEV_NAME);<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+&nbsp;&nbsp;&nbsp; return i2c_add_driver(&amp;l3gd20_gyr=
_driver);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+}<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+static void __exi=
t l3gd20_gyr_exit(void)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+{<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; pr_info(&quot;%s exit\n&=
quot;, L3GD20_GYR_DEV_NAME);<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;=
&nbsp;&nbsp; i2c_del_driver(&amp;l3gd20_gyr_driver);<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+&nbsp;&nbsp;&nbsp; return;<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+}<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+module_init(l3gd20_gyr_init);<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+module_exit(l3gd20_gyr_exit);<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+MODULE_DESCRIPTION(&quo=
t;STMicroelectronics l3gd20 digital gyroscope iio driver&quot;);<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+MODULE_AUTHOR(&quot;Matteo Dameno, STMicroe=
lectronics&quot;);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+MODULE_LICENSE(&=
quot;GPL v2&quot;);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>-- <o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>1.7.5.4<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'><=
o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'><o:p>&nbsp;</o:p></span></p><p=
 class=3DMsoNormal>P.S.: We are working on the driver to make it compatible=
 for the latest kernel.<o:p></o:p></p></div></body></html>=

--_000_494E38452A01E745B763C5F242AAA2CCC50EDD9B5CSAFEX1MAIL1st_--
