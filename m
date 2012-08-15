Return-Path: <swapnil.tiwari@st.com>
From: Swapnil TIWARI <swapnil.tiwari@st.com>
To: "jic23@cam.ac.uk" <jic23@cam.ac.uk>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Wed, 15 Aug 2012 22:52:12 +0200
Subject: [PATCH] Staging: iio: accel: lsm303dlhc: Add lsm303dlhc device for
 kernel version 2.6.35.13
Message-ID: <494E38452A01E745B763C5F242AAA2CCC50EDD9ADB@SAFEX1MAIL1.st.com>
Content-Type: multipart/alternative;
	boundary="_000_494E38452A01E745B763C5F242AAA2CCC50EDD9ADBSAFEX1MAIL1st_"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

--_000_494E38452A01E745B763C5F242AAA2CCC50EDD9ADBSAFEX1MAIL1st_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Add STMicroelectronics LSM303DLHC accelerometer device driver for kernel ve=
rsion 2.6.35.13

Signed-off-by: Swapnil Tiwari <swapnil.tiwari@st.com<mailto:swapnil.tiwari@=
st.com>>
---
drivers/staging/iio/accel/Kconfig                  |   12 +-
drivers/staging/iio/accel/Makefile                 |    5 +-
drivers/staging/iio/accel/lsm303dlhc_acc.h         |  187 ++++
drivers/staging/iio/accel/lsm303dlhc_acc_core.c    | 1160 +++++++++++++++++=
+++
drivers/staging/iio/accel/lsm303dlhc_acc_trigger.c |  115 ++
5 files changed, 1477 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/accel/Kconfig b/drivers/staging/iio/accel/=
Kconfig
index b4e57d1..1959d9e 100644
--- a/drivers/staging/iio/accel/Kconfig
+++ b/drivers/staging/iio/accel/Kconfig
@@ -51,4 +51,14 @@ config SCA3000
        tristate "VTI SCA3000 series accelerometers"
        help
          Say yes here to build support for the VTI SCA3000 series of SPI
-    accelerometers. These devices use a hardware ring buffer.
\ No newline at end of file
+    accelerometers. These devices use a hardware ring buffer.
+
+config LSM303DLHC_ACC_IIO
+       tristate "STM LSM303DLHC Combo 6 Axis, Accelerometer section"
+       depends on I2C
+       help
+          Say yes here to build support for the STMicrolectronics LSM303DL=
HC
+          6 axix Combo, Accelerometer Section.
+          Magnetometer Section is under magnetometer branch.
+          To compile this driver as a module, choose M here: the module
+          will be called lsm303dlh_acc_iio.
diff --git a/drivers/staging/iio/accel/Makefile b/drivers/staging/iio/accel=
/Makefile
index c34b136..7edf9dc 100644
--- a/drivers/staging/iio/accel/Makefile
+++ b/drivers/staging/iio/accel/Makefile
@@ -19,4 +19,7 @@ lis3l02dq-$(CONFIG_IIO_RING_BUFFER) +=3D lis3l02dq_ring.o
obj-$(CONFIG_LIS3L02DQ)   +=3D lis3l02dq.o

 sca3000-y      :=3D sca3000_core.o sca3000_ring.o
-obj-$(CONFIG_SCA3000)     +=3D sca3000.o
\ No newline at end of file
+obj-$(CONFIG_SCA3000)     +=3D sca3000.o
+
+lsm303dlhc_acc-y        :=3D lsm303dlhc_acc_core.o lsm303dlhc_acc_trigger.=
o
+obj-$(CONFIG_LSM303DLHC_ACC_IIO) +=3D lsm303dlhc_acc.o
diff --git a/drivers/staging/iio/accel/lsm303dlhc_acc.h b/drivers/staging/i=
io/accel/lsm303dlhc_acc.h
index e69de29..c3598ba 100644
--- a/drivers/staging/iio/accel/lsm303dlhc_acc.h
+++ b/drivers/staging/iio/accel/lsm303dlhc_acc.h
@@ -0,0 +1,187 @@
+/******************** (C) COPYRIGHT 2011 STMicroelectronics **************=
******
+*
+* File Name    : lsm303dlhc_acc.h
+* Authors : MSH - Motion Mems BU - Application Team
+*         : Matteo Dameno (matteo.dameno@st.com<mailto:matteo.dameno@st.co=
m>
+*         : author is willing to be considered the contact
+*         : and update points for the driver.
+* Version : V.2.0.0
+* Date         : 2011/Aug/16
+* Description  : LSM303DLHC 6D module sensor device driver iio
+*         : accelerometer section header file
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
+#ifndef   __LSM303DLHC_H__
+#define   __LSM303DLHC_H__
+
+#define   LSM303DLHC_ACC_DEV_NAME         "lsm303dlhc_acc_iio"
+
+/*  Accelerometer section defines   */
+
+
+#ifdef    __KERNEL__
+
+#define SAD0L                  0x00
+#define SAD0H                  0x01
+#define LSM303DLHC_ACC_I2C_SADROOT  0x0C
+#define LSM303DLHC_ACC_I2C_SAD_L    ((LSM303DLHC_ACC_I2C_SADROOT<<1)|SAD0L=
)
+#define LSM303DLHC_ACC_I2C_SAD_H    ((LSM303DLHC_ACC_I2C_SADROOT<<1)|SAD0H=
)
+
+#define   LSM303DLHC_ACC_MIN_POLL_PERIOD_MS    1
+
+/* Accelerometer Sensor Full Scale */
+#define   LSM303DLHC_ACC_FS_MASK          0x30
+#define LSM303DLHC_ACC_G_2G         0x00
+#define LSM303DLHC_ACC_G_4G         0x10
+#define LSM303DLHC_ACC_G_8G         0x20
+#define LSM303DLHC_ACC_G_16G        0x30
+
+#define   LSM303DLHC_ACC_RESUME_ENTRIES   17
+
+struct lsm303dlhc_acc_data {
+
+    struct work_struct   work_trigger_to_ring;
+    struct iio_work_cont work_cont_thresh;
+    s64             last_timestamp;
+    struct iio_dev       *indio_dev;
+    struct iio_trigger   *trig;
+
+
+    struct i2c_client    *client;
+    struct lsm303dlhc_acc_platform_data  *pdata;
+    int             use_smbus;
+
+    struct mutex         lock;
+
+    int             hw_initialized;
+    int             hw_working;
+
+    atomic_t        enabled;
+
+    char const      *gain;
+    char const      *scale;
+
+    u8              reg_addr;
+    u8              resume_state[LSM303DLHC_ACC_RESUME_ENTRIES];
+
+
+    int             irq1;
+    int             irq2;
+
+};
+
+struct lsm303dlhc_acc_platform_data {
+
+    u8 g_range;
+    u8 sampling_frequency;
+
+    u8 axis_map_x;
+    u8 axis_map_y;
+    u8 axis_map_z;
+
+    u8 negate_x;
+    u8 negate_y;
+    u8 negate_z;
+
+    /* set gpio_int[1,2] either to the choosen gpio pin number or to -EINV=
AL
+    * if leaved unconnected
+    */
+    int gpio_int1;
+    int gpio_int2;
+
+    int (*init)(void);
+    void (*exit)(void);
+    int (*power_on)(void);
+    int (*power_off)(void);
+};
+
+
+#ifdef CONFIG_IIO_RING_BUFFER
+/* At the moment triggers are only used for ring buffer
+ * filling. This may change!
+ */
+
+enum lsm303dlhc_acc_scan {
+    LSM303DLHC_ACC_SCAN_ACC_X,
+    LSM303DLHC_ACC_SCAN_ACC_Y,
+    LSM303DLHC_ACC_SCAN_ACC_Z,
+};
+
+void lsm303dlhc_acc_remove_trigger(struct iio_dev *indio_dev);
+int lsm303dlhc_acc_probe_trigger(struct iio_dev *indio_dev);
+
+ssize_t lsm303dlhc_acc_read_data_from_ring(struct device *dev,
+                          struct device_attribute *attr,
+                          char *buf);
+
+
+int lsm303dlhc_acc_configure_ring(struct iio_dev *indio_dev);
+void lsm303dlhc_acc_unconfigure_ring(struct iio_dev *indio_dev);
+
+int lsm303dlhc_acc_initialize_ring(struct iio_ring_buffer *ring);
+void lsm303dlhc_acc_uninitialize_ring(struct iio_ring_buffer *ring);
+#else /* CONFIG_IIO_RING_BUFFER */
+
+static inline void lsm303dlhc_acc_remove_trigger(struct iio_dev *indio_dev=
)
+{
+}
+
+static inline int lsm303dlhc_acc_probe_trigger(struct iio_dev *indio_dev)
+{
+    return 0;
+}
+
+static inline ssize_t
+lsm303dlhc_acc_read_data_from_ring(struct device *dev,
+                     struct device_attribute *attr,
+                     char *buf)
+{
+    return 0;
+}
+
+static int lsm303dlhc_acc_configure_ring(struct iio_dev *indio_dev)
+{
+    return 0;
+}
+
+static inline void lsm303dlhc_acc_unconfigure_ring(struct iio_dev *indio_d=
ev)
+{
+}
+
+static inline int lsm303dlhc_acc_initialize_ring(struct iio_ring_buffer *r=
ing)
+{
+    return 0;
+}
+
+static inline void lsm303dlhc_acc_uninitialize_ring(struct iio_ring_buffer
+                                               *ring)
+{
+}
+
+#endif /* CONFIG_IIO_RING_BUFFER */
+
+#endif    /* __KERNEL__ */
+
+#endif    /* __LSM303DLHC_H__ */
+
+
+
diff --git a/drivers/staging/iio/accel/lsm303dlhc_acc_core.c b/drivers/stag=
ing/iio/accel/lsm303dlhc_acc_core.c
index e69de29..7d71715 100644
--- a/drivers/staging/iio/accel/lsm303dlhc_acc_core.c
+++ b/drivers/staging/iio/accel/lsm303dlhc_acc_core.c
@@ -0,0 +1,1160 @@
+/******************** (C) COPYRIGHT 2011 STMicroelectronics **************=
******
+*
+* File Name    : lsm303dlhc_acc_core_iio.c
+* Authors : MSH - Motion Mems BU - Application Team
+*         : Matteo Dameno (matteo.dameno@st.com<mailto:matteo.dameno@st.co=
m>)
+*         : author is willing to be considered the contact
+*         : and update points for the driver.*
+* Version : V.2.0.0
+* Date         : 2011/Nov/16
+* Description  : LSM303DLHC 6D module sensor device driver iio
+*         : accelerometer section
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
+#include  <linux/err.h>
+#include  <linux/errno.h>
+#include  <linux/delay.h>
+#include  <linux/fs.h>
+#include  <linux/i2c.h>
+#include  <linux/input.h>
+#include  <linux/uaccess.h>
+#include  <linux/workqueue.h>
+#include  <linux/irq.h>
+#include  <linux/gpio.h>
+#include  <linux/interrupt.h>
+#include  <linux/slab.h>
+#include  <linux/device.h>
+#include  <linux/kernel.h>
+#include  <linux/module.h>
+#include  <linux/sysfs.h>
+
+
+#include  "../iio.h"
+#include  "../sysfs.h"
+#include  "accel.h"
+#include  "lsm303dlhc_acc.h"
+
+
+
+#define SENSITIVITY_2G         1    /**  mg/counts */
+#define SENSITIVITY_4G         2    /**  mg/counts */
+#define SENSITIVITY_8G         4    /**  mg/counts */
+#define SENSITIVITY_16G        12   /**  mg/counts */
+
+/* g, standard gravity 1g =3D 9.80665 m/s^2 */
+#define SCALE_2G    "0.00981"  /**  (m/s^2)/count */
+#define SCALE_4G    "0.01961"  /**  (m/s^2)/count */
+#define SCALE_8G    "0.03923"  /**  (m/s^2)/count */
+#define SCALE_16G   "0.11768"  /**  (m/s^2)/count */
+
+#define GAIN_2G           "101.971621"    /**  count/(m/s^2) */
+#define GAIN_4G           "50.985811"     /**  count/(m/s^2) */
+#define GAIN_8G           "25.492905"     /**  count/(m/s^2) */
+#define GAIN_16G    "8.497635" /**  count/(m/s^2) */
+
+/* Accelerometer Sensor Operating Mode */
+#define LSM303DLHC_ACC_ENABLE  (0x01)
+#define LSM303DLHC_ACC_DISABLE (0x00)
+
+#define   HIGH_RESOLUTION      (0x08)
+
+#define OUT_X_LSB         (0x28)
+#define OUT_X_MSB         (0x29)
+#define OUT_Y_LSB         (0x2A)
+#define OUT_Y_MSB         (0x2B)
+#define OUT_Z_LSB         (0x2C)
+#define OUT_Z_MSB         (0x2D)
+#define   AXISDATA_REG         OUT_X_LSB
+
+#define WHOAMI_LSM303DLHC_ACC  0x33 /*   Expctd content for WAI     */
+
+/*  CONTROL REGISTERS    */
+#define WHO_AM_I          0x0F /*   WhoAmI register      */
+#define   TEMP_CFG_REG         0x1F /*   temper sens control reg    */
+/* ctrl 1: ODR3 ODR2 ODR1 ODR0 LPen Zenable Yenable Zenable */
+#define   CTRL_REG1       0x20 /*   control reg 1        */
+#define   CTRL_REG2       0x21 /*   control reg 2        */
+#define   CTRL_REG3       0x22 /*   control reg 3        */
+#define   CTRL_REG4       0x23 /*   control reg 4        */
+#define   CTRL_REG5       0x24 /*   control reg 5        */
+#define   CTRL_REG6       0x25 /*   control reg 6        */
+
+#define   FIFO_CTRL_REG        0x2E /*   FiFo control reg     */
+
+#define   INT_CFG1        0x30 /*   interrupt 1 config   */
+#define   INT_SRC1        0x31 /*   interrupt 1 source   */
+#define   INT_THS1        0x32 /*   interrupt 1 threshold */
+#define   INT_DUR1        0x33 /*   interrupt 1 duration */
+
+
+#define   TT_CFG               0x38 /*   tap config      */
+#define   TT_SRC               0x39 /*   tap source      */
+#define   TT_THS               0x3A /*   tap threshold        */
+#define   TT_LIM               0x3B /*   tap time limit       */
+#define   TT_TLAT              0x3C /*   tap time latency     */
+#define   TT_TW           0x3D /*   tap time window      */
+/*  end CONTROL REGISTRES */
+
+
+#define ENABLE_HIGH_RESOLUTION 1
+
+#define LSM303DLHC_ACC_PM_OFF       (0x00)
+#define LSM303DLHC_ACC_ENABLE_ALL_AXES    (0x07)
+
+
+#define   CTRL_REG1_PMODE_MASK (0x08)
+#define   CTRL_REG1_ODR_MASK   (0XF0)
+
+#define   LSM303DLHC_ACC_ODR1  (0x10)  /* 1Hz output data rate */
+#define   LSM303DLHC_ACC_ODR10 (0x20)  /* 10Hz output data rate */
+#define   LSM303DLHC_ACC_ODR25 (0x30)  /* 25Hz output data rate */
+#define   LSM303DLHC_ACC_ODR50 (0x40)  /* 50Hz output data rate */
+#define   LSM303DLHC_ACC_ODR100 (0x50)  /* 100Hz output data rate */
+#define   LSM303DLHC_ACC_ODR200 (0x60)  /* 200Hz output data rate */
+#define   LSM303DLHC_ACC_ODR400 (0x70)  /* 400Hz output data rate */
+#define   LSM303DLHC_ACC_ODR1350     (0x90)  /* 1350Hz output data rate */
+
+
+#define ALL_ZEROES        (0x00)
+
+
+#define   IA              (0x40)
+#define   ZH              (0x20)
+#define   ZL              (0x10)
+#define   YH              (0x08)
+#define   YL              (0x04)
+#define   XH              (0x02)
+#define   XL              (0x01)
+/* */
+/* CTRL REG 3 BITS */
+#define   CTRL_REG3_I1_AOI1    (0x40)
+
+/*  */
+#define   CTRL_REG4_BDU_ENABLE (0x80)
+#define   CTRL_REG4_BDU_MASK   (0x80)
+
+
+#define   CTRL_REG6_I2_TAPEN   0x80
+#define   CTRL_REG6_HLACTIVE   0x02
+/* */
+#define   NO_MASK              0xFF
+#define   INT1_DURATION_MASK   0x7F
+#define   INT1_THRESHOLD_MASK  0x7F
+#define   TAP_CFG_MASK         0x3F
+#define   TAP_THS_MASK         0x7F
+#define   TAP_TLIM_MASK        0x7F
+#define   TAP_TLAT_MASK        NO_MASK
+#define   TAP_TW_MASK          NO_MASK
+
+
+/* TAP_SOURCE_REG BIT */
+#define   DTAP            0x20
+#define   STAP            0x10
+#define   SIGNTAP              0x08
+#define   ZTAP            0x04
+#define   YTAP            0x02
+#define   XTAZ            0x01
+
+
+#define   FUZZ            0
+#define   FLAT            0
+#define   I2C_RETRY_DELAY      5
+#define   I2C_RETRIES          5
+#define   I2C_AUTO_INCREMENT   0x80
+
+/* RESUME STATE INDICES */
+#define   RES_CTRL_REG1        0
+#define   RES_CTRL_REG2        1
+#define   RES_CTRL_REG3        2
+#define   RES_CTRL_REG4        3
+#define   RES_CTRL_REG5        4
+#define   RES_CTRL_REG6        5
+
+#define   RES_INT_CFG1         6
+#define   RES_INT_THS1         7
+#define   RES_INT_DUR1         8
+
+#define   RES_TT_CFG      9
+#define   RES_TT_THS      10
+#define   RES_TT_LIM      11
+#define   RES_TT_TLAT          12
+#define   RES_TT_TW       13
+
+#define   RES_TEMP_CFG_REG     14
+#define   RES_REFERENCE_REG    15
+#define   RES_FIFO_CTRL_REG    16
+
+#define   RESUME_ENTRIES  LSM303DLHC_ACC_RESUME_ENTRIES
+/* end RESUME STATE INDICES */
+
+
+struct output_rate {
+    unsigned int cutoff_ms;
+    unsigned int sampling_rate_setting;
+    const char *hz_label;
+};
+
+static const struct output_rate lsm303dlhc_acc_odr_table[] =3D {
+
+          {    1, LSM303DLHC_ACC_ODR1350, "1350"},
+          {    3, LSM303DLHC_ACC_ODR400,  "400"},
+          {    5, LSM303DLHC_ACC_ODR200,  "200"},
+          {   10, LSM303DLHC_ACC_ODR100,  "100"},
+          {   20, LSM303DLHC_ACC_ODR50,   "50"},
+          {   40, LSM303DLHC_ACC_ODR25,   "25"},
+          {  100, LSM303DLHC_ACC_ODR10,   "10"},
+          { 1000, LSM303DLHC_ACC_ODR1,    "1"},
+};
+
+static const struct lsm303dlhc_acc_platform_data
+default_lsm303dlhc_acc_pdata =3D {
+    .g_range =3D LSM303DLHC_ACC_G_2G,
+    .sampling_frequency =3D LSM303DLHC_ACC_ODR10,
+    .axis_map_x =3D 0,
+    .axis_map_y =3D 1,
+    .axis_map_z =3D 2,
+    .negate_x =3D 0,
+    .negate_y =3D 0,
+    .negate_z =3D 0,
+
+    .gpio_int1 =3D -EINVAL,
+    .gpio_int2 =3D -EINVAL,
+};
+
+static int lsm303dlhc_acc_i2c_read(struct lsm303dlhc_acc_data *data,
+                                    u8 *buf, int len)
+{
+    int ret;
+    u8 reg =3D buf[0];
+    u8 cmd =3D reg;
+
+
+    if (len > 1)
+          cmd =3D (I2C_AUTO_INCREMENT | reg);
+    if (data->use_smbus) {
+          if (len =3D=3D 1) {
+               ret =3D i2c_smbus_read_byte_data(data->client, cmd);
+               buf[0] =3D ret & 0xff;
+#ifdef DEBUG
+               dev_warn(&data->client->dev,
+                    "i2c_smbus_read_byte_data: ret=3D0x%02x, len:%d ,"
+                    "command=3D0x%02x, buf[0]=3D0x%02x\n",
+                    ret, len, cmd , buf[0]);
+#endif
+          } else if (len > 1) {
+               ret =3D i2c_smbus_read_i2c_block_data(data->client,
+                                          cmd, len, buf);
+#ifdef DEBUG
+               dev_warn(&data->client->dev,
+                    "i2c_smbus_read_i2c_block_data: ret:%d len:%d, "
+                    "command=3D0x%02x, ",
+                    ret, len, cmd);
+               char ii;
+               for (ii =3D 0; ii < len; ii++)
+                    printk(KERN_DEBUG "buf[%d]=3D0x%02x,",
+                                          ii, buf[ii]);
+
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
+static int lsm303dlhc_acc_i2c_write(struct lsm303dlhc_acc_data *data, u8 *=
buf,
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
+static int lsm303dlhc_acc_register_write(struct lsm303dlhc_acc_data *data,
+          u8 *buf, u8 reg_address, u8 new_value)
+{
+    int err;
+
+          /* Sets configuration register at reg_address
+          *  NOTE: this is a straight overwrite  */
+          buf[0] =3D reg_address;
+          buf[1] =3D new_value;
+          err =3D lsm303dlhc_acc_i2c_write(data, buf, 1);
+          if (err < 0)
+               return err;
+
+    return err;
+}
+
+static int lsm303dlhc_acc_register_read(struct lsm303dlhc_acc_data *data,
+                               u8 *buf, u8 reg_address)
+{
+
+    int err =3D -1;
+    buf[0] =3D (reg_address);
+    err =3D lsm303dlhc_acc_i2c_read(data, buf, 1);
+    return err;
+}
+
+static int lsm303dlhc_acc_register_update(struct lsm303dlhc_acc_data *data=
,
+          u8 *buf, u8 reg_address, u8 mask, u8 new_bit_values)
+{
+    int err =3D -1;
+    u8 init_val;
+    u8 updated_val;
+    err =3D lsm303dlhc_acc_register_read(data, buf, reg_address);
+    if (!(err < 0)) {
+          init_val =3D buf[0];
+          updated_val =3D ((mask & new_bit_values) | ((~mask) & init_val))=
;
+          err =3D lsm303dlhc_acc_register_write(data, buf, reg_address,
+                    updated_val);
+    }
+    return err;
+}
+
+static int lsm303dlhc_acc_hw_init(struct lsm303dlhc_acc_data *data)
+{
+    int err =3D -1;
+    u8 buf[7];
+
+    printk(KERN_INFO "%s: hw init start\n", LSM303DLHC_ACC_DEV_NAME);
+
+    buf[0] =3D WHO_AM_I;
+    err =3D lsm303dlhc_acc_i2c_read(data, buf, 1);
+    if (err < 0) {
+          dev_warn(&data->client->dev, "Error reading WHO_AM_I: is device =
available/working?\n");
+          goto err_firstread;
+    } else
+          data->hw_working =3D 1;
+
+    if (buf[0] !=3D WHOAMI_LSM303DLHC_ACC) {
+          dev_err(&data->client->dev,
+               "device unknown. Expected: 0x%02x,"
+               " Replies: 0x%02x\n", WHOAMI_LSM303DLHC_ACC, buf[0]);
+          err =3D -1; /* choose the right coded error */
+          goto err_unknown_device;
+    }
+
+
+    buf[0] =3D (CTRL_REG1);
+    buf[1] =3D data->resume_state[RES_CTRL_REG1];
+    err =3D lsm303dlhc_acc_i2c_write(data, buf, 1);
+    if (err < 0)
+          goto err_resume_state;
+
+    buf[0] =3D (TEMP_CFG_REG);
+    buf[1] =3D data->resume_state[RES_TEMP_CFG_REG];
+    err =3D lsm303dlhc_acc_i2c_write(data, buf, 1);
+    if (err < 0)
+          goto err_resume_state;
+
+    buf[0] =3D (FIFO_CTRL_REG);
+    buf[1] =3D data->resume_state[RES_FIFO_CTRL_REG];
+    err =3D lsm303dlhc_acc_i2c_write(data, buf, 1);
+    if (err < 0)
+          goto err_resume_state;
+
+    buf[0] =3D (TT_THS);
+    buf[1] =3D data->resume_state[RES_TT_THS];
+    buf[2] =3D data->resume_state[RES_TT_LIM];
+    buf[3] =3D data->resume_state[RES_TT_TLAT];
+    buf[4] =3D data->resume_state[RES_TT_TW];
+    err =3D lsm303dlhc_acc_i2c_write(data, buf, 4);
+    if (err < 0)
+          goto err_resume_state;
+    buf[0] =3D (TT_CFG);
+    buf[1] =3D data->resume_state[RES_TT_CFG];
+    err =3D lsm303dlhc_acc_i2c_write(data, buf, 1);
+    if (err < 0)
+          goto err_resume_state;
+
+    buf[0] =3D (INT_THS1);
+    buf[1] =3D data->resume_state[RES_INT_THS1];
+    buf[2] =3D data->resume_state[RES_INT_DUR1];
+    err =3D lsm303dlhc_acc_i2c_write(data, buf, 2);
+    if (err < 0)
+          goto err_resume_state;
+    buf[0] =3D (INT_CFG1);
+    buf[1] =3D data->resume_state[RES_INT_CFG1];
+    err =3D lsm303dlhc_acc_i2c_write(data, buf, 1);
+    if (err < 0)
+          goto err_resume_state;
+
+
+    buf[0] =3D (CTRL_REG2);
+    buf[1] =3D data->resume_state[RES_CTRL_REG2];
+    buf[2] =3D data->resume_state[RES_CTRL_REG3];
+    buf[3] =3D data->resume_state[RES_CTRL_REG4];
+    buf[4] =3D data->resume_state[RES_CTRL_REG5];
+    buf[5] =3D data->resume_state[RES_CTRL_REG6];
+    err =3D lsm303dlhc_acc_i2c_write(data, buf, 5);
+    if (err < 0)
+          goto err_resume_state;
+
+    data->hw_initialized =3D 1;
+    printk(KERN_INFO "%s: hw init done\n", LSM303DLHC_ACC_DEV_NAME);
+    return 0;
+
+err_firstread:
+    data->hw_working =3D 0;
+err_unknown_device:
+err_resume_state:
+    data->hw_initialized =3D 0;
+    dev_err(&data->client->dev, "hw init error 0x%02x,0x%02x: %d\n", buf[0=
],
+               buf[1], err);
+    return err;
+}
+
+static void lsm303dlhc_acc_device_power_off(struct lsm303dlhc_acc_data *da=
ta)
+{
+    int err;
+    u8 buf[2] =3D { CTRL_REG1, LSM303DLHC_ACC_PM_OFF };
+
+    err =3D lsm303dlhc_acc_i2c_write(data, buf, 1);
+    if (err < 0)
+          dev_err(&data->client->dev, "soft power off failed: %d\n", err);
+
+    if (data->pdata->power_off) {
+          data->pdata->power_off();
+          data->hw_initialized =3D 0;
+    }
+
+    if (data->hw_initialized)
+          data->hw_initialized =3D 0;
+}
+
+static int lsm303dlhc_acc_device_power_on(struct lsm303dlhc_acc_data *data=
)
+{
+    int err =3D -1;
+
+    if (data->pdata->power_on) {
+          err =3D data->pdata->power_on();
+          if (err < 0) {
+               dev_err(&data->client->dev,
+                          "power_on failed: %d\n", err);
+               return err;
+          }
+
+    }
+
+
+    if (!data->hw_initialized) {
+          err =3D lsm303dlhc_acc_hw_init(data);
+          if (data->hw_working =3D=3D 1 && err < 0) {
+               lsm303dlhc_acc_device_power_off(data);
+               return err;
+          }
+    }
+
+    return 0;
+}
+
+static int lsm303dlhc_acc_enable(struct lsm303dlhc_acc_data *data)
+{
+    int err;
+
+    if (!atomic_cmpxchg(&data->enabled, 0, 1)) {
+          err =3D lsm303dlhc_acc_device_power_on(data);
+          if (err < 0) {
+               atomic_set(&data->enabled, 0);
+               return err;
+          }
+
+    }
+
+    return 0;
+}
+
+static int lsm303dlhc_acc_disable(struct lsm303dlhc_acc_data *data)
+{
+    if (atomic_cmpxchg(&data->enabled, 1, 0))
+          lsm303dlhc_acc_device_power_off(data);
+
+    return 0;
+}
+
+static int lsm303dlhc_acc_validate_pdata(struct lsm303dlhc_acc_data *dev_d=
ata)
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
+static int lsm303dlhc_acc_update_fs_range(struct lsm303dlhc_acc_data *acc,
+                                    u8 new_g_range)
+{
+    int err =3D -1;
+
+    char const *scale;
+    char const *gain;
+    u8 buf[2];
+    u8 updated_val;
+    u8 init_val;
+    u8 new_val;
+    u8 mask =3D LSM303DLHC_ACC_FS_MASK | HIGH_RESOLUTION;
+
+    switch (new_g_range) {
+    case LSM303DLHC_ACC_G_2G:
+
+          gain =3D GAIN_2G;
+          scale =3D SCALE_2G;
+          break;
+    case LSM303DLHC_ACC_G_4G:
+
+          gain =3D GAIN_4G;
+          scale =3D SCALE_4G;
+          break;
+    case LSM303DLHC_ACC_G_8G:
+
+          gain =3D GAIN_8G;
+          scale =3D SCALE_8G;
+          break;
+    case LSM303DLHC_ACC_G_16G:
+
+          gain =3D GAIN_16G;
+          scale =3D SCALE_16G;
+          break;
+    default:
+          dev_err(&acc->client->dev, "invalid g range requested: %u\n",
+                    new_g_range);
+          return -EINVAL;
+    }
+
+    /* Updates configuration register 4,
+    * which contains g range setting */
+    buf[0] =3D CTRL_REG4;
+    err =3D lsm303dlhc_acc_i2c_read(acc, buf, 1);
+    if (err < 0)
+          goto error;
+    init_val =3D buf[0];
+    acc->resume_state[RES_CTRL_REG4] =3D init_val;
+    new_val =3D new_g_range | HIGH_RESOLUTION;
+    updated_val =3D ((mask & new_val) | ((~mask) & init_val));
+    buf[1] =3D updated_val;
+    buf[0] =3D CTRL_REG4;
+    err =3D lsm303dlhc_acc_i2c_write(acc, buf, 1);
+    if (err < 0)
+          goto error;
+    acc->resume_state[RES_CTRL_REG4] =3D updated_val;
+    acc->gain =3D gain;
+    acc->scale =3D scale;
+
+
+    return err;
+error:
+    dev_err(&acc->client->dev, "update g range failed 0x%02x,0x%02x: %d\n"=
,
+               buf[0], buf[1], err);
+
+    return err;
+}
+
+static int lsm303dlhc_acc_update_sampling_freq(struct lsm303dlhc_acc_data =
*data,
+                                    u8 freq)
+{
+    int res =3D 0;
+    u8 buf[2];
+    u8 new_value;
+
+
+    new_value =3D freq;
+    res =3D lsm303dlhc_acc_register_update(data, buf, CTRL_REG1,
+                          CTRL_REG1_ODR_MASK, new_value);
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
+          ((CTRL_REG1_ODR_MASK & new_value) |
+          (~CTRL_REG1_ODR_MASK & data->resume_state[RES_CTRL_REG1]));
+
+    data->pdata->sampling_frequency =3D new_value;
+
+    return res;
+}
+
+static ssize_t lsm303dlhc_acc_show_sampling_frequency(struct device *dev,
+                               struct device_attribute *attr,
+                               char *buf)
+{
+    struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+    struct lsm303dlhc_acc_data *data =3D indio_dev->dev_data;
+    u8 i;
+    u8 val;
+
+
+    mutex_lock(&data->lock);
+    val =3D data->pdata->sampling_frequency;
+    mutex_unlock(&data->lock);
+    dev_dbg(dev, "getting sampling frequency: 0x%02x\n", val);
+
+    for (i =3D 0; i < ARRAY_SIZE(lsm303dlhc_acc_odr_table); i++)
+          if (lsm303dlhc_acc_odr_table[i].sampling_rate_setting =3D=3D val=
)
+               break;
+
+    return sprintf(buf, "%s\n", lsm303dlhc_acc_odr_table[i].hz_label);
+}
+
+static ssize_t lsm303dlhc_acc_store_sampling_frequency(struct device *dev,
+                               struct device_attribute *attr,
+                               const char *buf, size_t size)
+{
+    struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+    struct lsm303dlhc_acc_data *data =3D indio_dev->dev_data;
+    u8 found =3D 0;
+    u8 i;
+    u8 ret;
+
+    for (i =3D 0; i < ARRAY_SIZE(lsm303dlhc_acc_odr_table); i++) {
+          if (strcmp(buf, lsm303dlhc_acc_odr_table[i].hz_label) =3D=3D 0) =
{
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
+          ret =3D lsm303dlhc_acc_update_sampling_freq(data,
+               lsm303dlhc_acc_odr_table[i].sampling_rate_setting);
+          if (ret < 0)
+               goto error;
+          data->pdata->sampling_frequency =3D
+               lsm303dlhc_acc_odr_table[i].sampling_rate_setting;
+          dev_info(dev, "set new sampling frequency: %s Hz\n",
+                          lsm303dlhc_acc_odr_table[i].hz_label);
+          mutex_unlock(&data->lock);
+    }
+    return size;
+error:
+    mutex_unlock(&data->lock);
+    return ret;
+}
+
+static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
+          lsm303dlhc_acc_show_sampling_frequency,
+          lsm303dlhc_acc_store_sampling_frequency);
+
+static ssize_t lsm303dlhc_acc_show_enable(struct device *dev,
+                      struct device_attribute *attr, char *buf)
+{
+    struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+    struct lsm303dlhc_acc_data *data =3D indio_dev->dev_data;
+    int val =3D atomic_read(&data->enabled);
+    return sprintf(buf, "%d\n", val);
+}
+
+static ssize_t lsm303dlhc_acc_store_enable(struct device *dev,
+                      struct device_attribute *attr,
+                      const char *buf, size_t size)
+{
+    struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+    struct lsm303dlhc_acc_data *data =3D indio_dev->dev_data;
+    unsigned long val;
+
+    if (kstrtoul(buf, 10, &val))
+          return -EINVAL;
+
+    if (val)
+          lsm303dlhc_acc_enable(data);
+    else
+          lsm303dlhc_acc_disable(data);
+
+    return size;
+}
+
+static IIO_DEVICE_ATTR(enable_device,
+               S_IWUSR | S_IRUGO,
+               lsm303dlhc_acc_show_enable,
+               lsm303dlhc_acc_store_enable,
+               0);
+
+static int lsm303dlhc_acc_show_channel_rawdata(struct device *dev,
+                    struct device_attribute *attr,
+                    char *buf)
+{
+    struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+    struct lsm303dlhc_acc_data *data =3D indio_dev->dev_data;
+    struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);
+    int err;
+
+    /* Data bytes from hardware (AxL, AxH) or (AyL, AyH) or (AzL, AzH) */
+    u8 out_data[2];
+    /* x,y,z hardware data */
+    s16 raw_d;
+
+    out_data[0] =3D this_attr->address;
+
+    mutex_lock(&data->lock);
+    err =3D lsm303dlhc_acc_i2c_read(data, out_data, 2);
+    mutex_unlock(&data->lock);
+    if (err < 0) {
+          dev_err(dev, "error reading output registers\n");
+          return err;
+    }
+
+    raw_d =3D (((s16) ((out_data[1]) << 8) | out_data[0]) >> 4);
+    return sprintf(buf, "%d\n", raw_d);
+
+}
+
+static IIO_DEV_ATTR_ACCEL_X(lsm303dlhc_acc_show_channel_rawdata, OUT_X_LSB=
);
+static IIO_DEV_ATTR_ACCEL_Y(lsm303dlhc_acc_show_channel_rawdata, OUT_Y_LSB=
);
+static IIO_DEV_ATTR_ACCEL_Z(lsm303dlhc_acc_show_channel_rawdata, OUT_Z_LSB=
);
+
+static ssize_t lsm303dlhc_acc_show_range(struct device *dev,
+                          struct device_attribute *attr,
+                          char *buf)
+{
+    struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+    struct lsm303dlhc_acc_data *data =3D indio_dev->dev_data;
+    int label =3D 0;
+    u8 val;
+    mutex_lock(&data->lock);
+    val =3D data->pdata->g_range;
+    switch (val) {
+    case LSM303DLHC_ACC_G_2G:
+          label =3D 2;
+          break;
+    case LSM303DLHC_ACC_G_4G:
+          label =3D 4;
+          break;
+    case LSM303DLHC_ACC_G_8G:
+          label =3D 8;
+          break;
+    case LSM303DLHC_ACC_G_16G:
+          label =3D 16;
+          break;
+    }
+    mutex_unlock(&data->lock);
+    return sprintf(buf, "%d mg\n", label);
+}
+
+static ssize_t lsm303dlhc_acc_store_range(struct device *dev,
+                            struct device_attribute *attr,
+                            const char *buf,
+                            size_t size)
+{
+    struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+    struct lsm303dlhc_acc_data *data =3D indio_dev->dev_data;
+    unsigned long val;
+    u8 range;
+    int err =3D -1;
+    if (kstrtoul(buf, 10, &val)) {
+          dev_err(dev, "invalid range %lu\n. Range not changed", val);
+          return -EINVAL;
+    }
+    switch (val) {
+    case 2:
+          range =3D LSM303DLHC_ACC_G_2G;
+          break;
+    case 4:
+          range =3D LSM303DLHC_ACC_G_4G;
+          break;
+    case 8:
+          range =3D LSM303DLHC_ACC_G_8G;
+          break;
+    case 16:
+          range =3D LSM303DLHC_ACC_G_16G;
+          break;
+    default:
+          dev_err(dev, "invalid range %lu. Range not changed\n", val);
+          return -EINVAL;
+    }
+
+    mutex_lock(&data->lock);
+    data->pdata->g_range =3D range;
+    err =3D lsm303dlhc_acc_update_fs_range(data, range);
+    mutex_unlock(&data->lock);
+    if (err < 0)
+         goto error;
+    dev_info(dev, "set range to %lu mG\n", val);
+    return size;
+error:
+    dev_err(dev, "error changing range\n");
+    return err;
+}
+
+
+
+static IIO_DEVICE_ATTR(accel_range,
+               S_IWUSR | S_IRUGO,
+               lsm303dlhc_acc_show_range,
+               lsm303dlhc_acc_store_range,
+               0);
+
+
+static IIO_CONST_ATTR(accel_range_available, "2 4 8 16");
+
+
+static ssize_t lsm303dlhc_acc_show_gain(struct device *dev,
+                               struct device_attribute *attr,
+                               char *buf)
+{
+    struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+    struct lsm303dlhc_acc_data *data =3D indio_dev->dev_data;
+    return sprintf(buf, "%s\n", data->gain);
+}
+
+static IIO_DEVICE_ATTR(accel_gain, S_IRUGO,
+               lsm303dlhc_acc_show_gain,
+               NULL , 0);
+
+
+static ssize_t lsm303dlhc_acc_show_scale(struct device *dev,
+                          struct device_attribute *attr,
+                          char *buf)
+{
+    struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+    struct lsm303dlhc_acc_data *data =3D indio_dev->dev_data;
+    return sprintf(buf, "%s\n", data->scale);
+}
+
+static IIO_DEVICE_ATTR(accel_scale, S_IRUGO,
+               lsm303dlhc_acc_show_scale,
+               NULL , 0);
+
+static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("1 10 25 50 100 200 400 1350");
+
+
+static IIO_CONST_ATTR(name, LSM303DLHC_ACC_DEV_NAME);
+
+
+
+static struct attribute *lsm303dlhc_acc_attributes[] =3D {
+    &iio_const_attr_name.dev_attr.attr,
+    &iio_dev_attr_enable_device.dev_attr.attr,
+    &iio_const_attr_accel_range_available.dev_attr.attr,
+    &iio_dev_attr_accel_range.dev_attr.attr,
+    &iio_dev_attr_accel_gain.dev_attr.attr,
+    &iio_dev_attr_accel_scale.dev_attr.attr,
+    &iio_dev_attr_accel_x_raw.dev_attr.attr,
+    &iio_dev_attr_accel_y_raw.dev_attr.attr,
+    &iio_dev_attr_accel_z_raw.dev_attr.attr,
+    &iio_dev_attr_sampling_frequency.dev_attr.attr,
+    &iio_const_attr_sampling_frequency_available.dev_attr.attr,
+    NULL
+};
+
+static const struct attribute_group lsm303dlhc_acc_attribute_group =3D {
+    .attrs =3D lsm303dlhc_acc_attributes,
+};
+
+static int lsm303dlhc_acc_probe(struct i2c_client *client,
+          const struct i2c_device_id *id)
+{
+    struct lsm303dlhc_acc_data *data;
+    int err =3D -1;
+
+    data =3D kzalloc(sizeof(struct lsm303dlhc_acc_data), GFP_KERNEL);
+    if (data =3D=3D NULL) {
+          err =3D -ENOMEM;
+          dev_err(&client->dev,
+                    "failed to allocate memory for module data: "
+                          "%d\n", err);
+          goto exit_check_functionality_failed;
+    }
+
+    u32 smbus_func =3D I2C_FUNC_SMBUS_BYTE_DATA |
+                    I2C_FUNC_SMBUS_WORD_DATA | I2C_FUNC_SMBUS_I2C_BLOCK;
+    int regdone =3D 0;
+
+    pr_info("%s: probe start.\n", LSM303DLHC_ACC_DEV_NAME);
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
+          memcpy(data->pdata, &default_lsm303dlhc_acc_pdata,
+                                    sizeof(*data->pdata));
+          dev_info(&client->dev, "using default platform data\n");
+    } else {
+          memcpy(data->pdata, client->dev.platform_data,
+                                    sizeof(*data->pdata));
+    }
+
+    err =3D lsm303dlhc_acc_validate_pdata(data);
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
+    data->resume_state[RES_CTRL_REG1] =3D (ALL_ZEROES |
+                          LSM303DLHC_ACC_ENABLE_ALL_AXES);
+    data->resume_state[RES_CTRL_REG4] =3D (ALL_ZEROES | CTRL_REG4_BDU_ENAB=
LE);
+
+
+    err =3D lsm303dlhc_acc_device_power_on(data);
+    if (err < 0) {
+          dev_err(&client->dev, "power on failed: %d\n", err);
+          goto exit_kfree_pdata;
+    }
+
+    atomic_set(&data->enabled, 1);
+
+    err =3D lsm303dlhc_acc_update_fs_range(data, data->pdata->g_range);
+    if (err < 0) {
+          dev_err(&client->dev, "update_g_range failed\n");
+          goto  err_power_off;
+    }
+
+    err =3D lsm303dlhc_acc_update_sampling_freq(data,
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
+    data->indio_dev->attrs =3D &lsm303dlhc_acc_attribute_group;
+    data->indio_dev->dev.parent =3D &client->dev;
+    data->indio_dev->dev_data =3D (void *)(data);
+    data->indio_dev->driver_module =3D THIS_MODULE;
+    data->indio_dev->modes =3D INDIO_DIRECT_MODE;
+
+    lsm303dlhc_acc_device_power_off(data);
+    /* As default, do not report information */
+    atomic_set(&data->enabled, 0);
+
+    err =3D lsm303dlhc_acc_configure_ring(data->indio_dev);
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
+    err =3D lsm303dlhc_acc_initialize_ring(data->indio_dev->ring);
+    if (err) {
+          dev_err(&client->dev, "failed to initialize the ring\n");
+          goto error_unreg_ring_funcs;
+    }
+
+    mutex_unlock(&data->lock);
+    dev_info(&client->dev, "%s: probed\n", LSM303DLHC_ACC_DEV_NAME);
+    return 0;
+
+
+
+error_unreg_ring_funcs:
+    lsm303dlhc_acc_unconfigure_ring(data->indio_dev);
+error_free_dev:
+    if (regdone)
+          iio_device_unregister(data->indio_dev);
+    else
+          iio_free_device(data->indio_dev);
+err_power_off:
+    lsm303dlhc_acc_device_power_off(data);
+err_pdata_init:
+    if (data->pdata->exit)
+          data->pdata->exit();
+exit_kfree_pdata:
+    kfree(data->pdata);
+err_mutexunlock:
+    mutex_unlock(&data->lock);
+    kfree(data);
+exit_check_functionality_failed:
+    printk(KERN_ERR "%s: Driver Init failed\n", LSM303DLHC_ACC_DEV_NAME);
+    return err;
+}
+
+static int __devexit lsm303dlhc_acc_remove(struct i2c_client *client)
+{
+
+    struct lsm303dlhc_acc_data *data =3D i2c_get_clientdata(client);
+
+    lsm303dlhc_acc_device_power_off(data);
+
+    lsm303dlhc_acc_uninitialize_ring(data->indio_dev->ring);
+    iio_device_unregister(data->indio_dev);
+    lsm303dlhc_acc_unconfigure_ring(data->indio_dev);
+
+    if (data->pdata->exit)
+          data->pdata->exit();
+    kfree(data->pdata);
+    kfree(data);
+
+    return 0;
+}
+
+static const struct i2c_device_id lsm303dlhc_acc_id[]
+          =3D { { LSM303DLHC_ACC_DEV_NAME, 0 }, { }, };
+
+MODULE_DEVICE_TABLE(i2c, lsm303dlhc_acc_id);
+
+static struct i2c_driver lsm303dlhc_acc_driver =3D {
+    .driver =3D {
+               .owner =3D THIS_MODULE,
+               .name =3D LSM303DLHC_ACC_DEV_NAME,
+            },
+    .probe =3D lsm303dlhc_acc_probe,
+    .remove =3D __devexit_p(lsm303dlhc_acc_remove),
+    .id_table =3D lsm303dlhc_acc_id,
+};
+
+static int __init lsm303dlhc_acc_init(void)
+{
+    printk(KERN_INFO "%s accelerometer iio driver: init\n",
+                               LSM303DLHC_ACC_DEV_NAME);
+    return i2c_add_driver(&lsm303dlhc_acc_driver);
+}
+
+static void __exit lsm303dlhc_acc_exit(void)
+{
+    pr_info("%s exit\n", LSM303DLHC_ACC_DEV_NAME);
+    i2c_del_driver(&lsm303dlhc_acc_driver);
+    return;
+}
+
+module_init(lsm303dlhc_acc_init);
+module_exit(lsm303dlhc_acc_exit);
+
+MODULE_DESCRIPTION("STMicroelectronics lsm303dlhc iio driver for the accel=
erometer section");
+MODULE_AUTHOR("Matteo Dameno, STMicroelectronics");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/iio/accel/lsm303dlhc_acc_trigger.c b/drivers/s=
taging/iio/accel/lsm303dlhc_acc_trigger.c
index e69de29..62cb7e0 100644
--- a/drivers/staging/iio/accel/lsm303dlhc_acc_trigger.c
+++ b/drivers/staging/iio/accel/lsm303dlhc_acc_trigger.c
@@ -0,0 +1,115 @@
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/mutex.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/sysfs.h>
+#include <linux/list.h>
+#include <linux/spi/spi.h>
+
+#include "../iio.h"
+#include "../sysfs.h"
+#include "../trigger.h"
+#include "../magnetometer/lsm303dlhc.h"
+
+
+
+static int lsm303dlhc_acc_data_rdy_trig_poll(struct iio_dev *dev_info,
+                               int index,
+                               s64 timestamp,
+                               int no_test)
+{
+    struct lsm303dlhc_acc_data *data =3D iio_dev_get_devdata(dev_info);
+    struct iio_trigger *trig =3D data->trig;
+
+    trig->timestamp =3D timestamp;
+    iio_trigger_poll(trig);
+    return IRQ_HANDLED;
+}
+
+IIO_EVENT_SH(data_rdy_trig, &lsm303dlhc_acc_data_rdy_trig_poll);
+
+static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
+
+static struct attribute *lsm303dlhc_acc_trigger_attrs[] =3D {
+    &dev_attr_name.attr,
+    NULL,
+};
+
+static const struct attribute_group lsm303dlhc_acc_trigger_attr_group =3D =
{
+    .attrs =3D lsm303dlhc_acc_trigger_attrs,
+};
+
+static int lsm303dlhc_acc_data_rdy_trigger_set_state(struct iio_trigger *t=
rig,
+                                          bool state)
+{
+    struct lsm303dlhc_acc_data *data =3D trig->private_data;
+    struct iio_dev *indio_dev =3D data->indio_dev;
+    int ret =3D 0;
+
+    dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
+    ret =3D lsm303dlhc_acc_set_irq(&data->indio_dev->dev, state);
+    if (state =3D=3D false) {
+          iio_remove_event_from_list(&iio_event_data_rdy_trig,
+                             &indio_dev->interrupts[0]
+                             ->ev_list);
+          flush_scheduled_work();
+    } else {
+          iio_add_event_to_list(&iio_event_data_rdy_trig,
+                          &indio_dev->interrupts[0]->ev_list);
+    }
+    return ret;
+}
+
+static int lsm303dlhc_acc_trig_try_reen(struct iio_trigger *trig)
+{
+    struct lsm303dlhc_acc_data *data =3D trig->private_data;
+    enable_irq(data->irq1);
+    return 0;
+}
+
+int lsm303dlhc_acc_probe_trigger(struct iio_dev *indio_dev)
+{
+    int ret;
+    struct lsm303dlhc_acc_data *data =3D indio_dev->dev_data;
+
+    data->trig =3D iio_allocate_trigger();
+    data->trig->name =3D kmalloc(IIO_TRIGGER_NAME_LENGTH, GFP_KERNEL);
+    if (!data->trig->name) {
+          ret =3D -ENOMEM;
+          goto error_free_trig;
+    }
+    snprintf((char *)data->trig->name,
+          IIO_TRIGGER_NAME_LENGTH,
+          "lsm303dlhc_acc-dev%d", indio_dev->id);
+    data->trig->dev.parent =3D &st->us->dev;
+    data->trig->owner =3D THIS_MODULE;
+    data->trig->private_data =3D data;
+    data->trig->set_trigger_state =3D
+                    &lsm303dlhc_acc_data_rdy_trigger_set_state;
+    data->trig->try_reenable =3D &lsm303dlhc_acc_trig_try_reen;
+    data->trig->control_attrs =3D &lsm303dlhc_acc_trigger_attr_group;
+    ret =3D iio_trigger_register(data->trig);
+
+    /* select default trigger */
+    indio_dev->trig =3D data->trig;
+    if (ret)
+          goto error_free_trig_name;
+
+    return 0;
+
+error_free_trig_name:
+    kfree(data->trig->name);
+error_free_trig:
+    iio_free_trigger(data->trig);
+
+    return ret;
+}
+
+void lsm303dlhc_acc_remove_trigger(struct iio_dev *indio_dev)
+{
+    struct lsm303dlhc_acc_data *state =3D indio_dev->dev_data;
+    iio_trigger_unregister(state->trig);
+    kfree(state->trig->name);
+    iio_free_trigger(state->trig);
+}
--
1.7.5.4


P.S.: We are working on the driver to make it compatible for the latest mai=
nline kernel.


--_000_494E38452A01E745B763C5F242AAA2CCC50EDD9ADBSAFEX1MAIL1st_
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
ics LSM303DLHC accelerometer device driver for kernel version 2.6.35.13<o:p=
></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"Courier New"'><o:p>&nbsp;</o:p></span></p><p class=3D=
MsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier=
 New"'>Signed-off-by: Swapnil Tiwari &lt;<a href=3D"mailto:swapnil.tiwari@s=
t.com">swapnil.tiwari@st.com</a>&gt;<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>---<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none=
'><span style=3D'font-family:"Courier New"'>drivers/staging/iio/accel/Kconf=
ig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 12 +-<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>drivers/staging/iio/accel/Makefile&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbs=
p;&nbsp;&nbsp; 5 +-<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>drivers/staging/=
iio/accel/lsm303dlhc_acc.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|&nbsp; 187 ++++<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>drivers/staging/iio=
/accel/lsm303dlhc_acc_core.c&nbsp;&nbsp;&nbsp; | 1160 ++++++++++++++++++++<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>drivers/staging/iio/accel/lsm303dlhc=
_acc_trigger.c |&nbsp; 115 ++<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>5 file=
s changed, 1477 insertions(+), 2 deletions(-)<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>diff --git a/driver=
s/staging/iio/accel/Kconfig b/drivers/staging/iio/accel/Kconfig<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>index b4e57d1..1959d9e 100644<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>--- a/drivers/staging/iio/accel/Kconfig<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+++ b/drivers/staging/iio/accel/Kconfig<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>@@ -51,4 +51,14 @@ config SCA3000<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; t=
ristate &quot;VTI SCA3000 series accelerometers&quot;<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; help<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; Say yes here to build support for the VTI SCA3000 series of SPI<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>-&nbsp;&nbsp;&nbsp; accelerometers. =
These devices use a hardware ring buffer.<o:p></o:p></span></p><p class=3DM=
soNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier =
New"'>\ No newline at end of file<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&=
nbsp;&nbsp;&nbsp; accelerometers. These devices use a hardware ring buffer.=
<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><s=
pan style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DM=
soNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier =
New"'>+config LSM303DLHC_ACC_IIO<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tristate &quot;STM LSM303DLHC Combo 6 Ax=
is, Accelerometer section&quot;<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on I2C<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; help<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 Say yes here to build support for the STMicrolectronics LSM303DLHC<o:p></o=
:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span styl=
e=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 6 axix Combo, Accelerometer Section.<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Magne=
tometer Section is under magnetometer branch.<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; To compil=
e this driver as a module, choose M here: the module<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wi=
ll be called lsm303dlh_acc_iio.<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>diff=
 --git a/drivers/staging/iio/accel/Makefile b/drivers/staging/iio/accel/Mak=
efile<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>index c34b136..7edf9dc 100644<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>--- a/drivers/staging/iio/accel/Make=
file<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none=
'><span style=3D'font-family:"Courier New"'>+++ b/drivers/staging/iio/accel=
/Makefile<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>@@ -19,4 +19,7 @@ lis3l02d=
q-$(CONFIG_IIO_RING_BUFFER) +=3D lis3l02dq_ring.o<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>obj-$(CONFIG_LIS3L02DQ)&nbsp;&nbsp; +=3D lis3l02dq.o<o:p></o:=
p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNo=
rmal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"=
'>&nbsp;sca3000-y&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :=3D sca3000_core.o sca3000=
_ring.o<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:n=
one'><span style=3D'font-family:"Courier New"'>-obj-$(CONFIG_SCA3000)&nbsp;=
&nbsp;&nbsp;&nbsp; +=3D sca3000.o<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>\ =
No newline at end of file<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+obj-$(C=
ONFIG_SCA3000)&nbsp;&nbsp;&nbsp;&nbsp; +=3D sca3000.o<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+lsm303dlhc_acc-=
y&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :=3D lsm303dlhc_acc_core.o lsm3=
03dlhc_acc_trigger.o<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+obj-$(CONFIG_L=
SM303DLHC_ACC_IIO) +=3D lsm303dlhc_acc.o<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>diff --git a/drivers/staging/iio/accel/lsm303dlhc_acc.h b/drivers/stag=
ing/iio/accel/lsm303dlhc_acc.h<o:p></o:p></span></p><p class=3DMsoNormal st=
yle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>index=
 e69de29..c3598ba 100644<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>--- a/drive=
rs/staging/iio/accel/lsm303dlhc_acc.h<o:p></o:p></span></p><p class=3DMsoNo=
rmal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"=
'>+++ b/drivers/staging/iio/accel/lsm303dlhc_acc.h<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>@@ -0,0 +1,187 @@<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+/*=
******************* (C) COPYRIGHT 2011 STMicroelectronics *****************=
***<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+*<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+* File Name&nbsp;&nbsp;&nbsp; : lsm303dlhc_acc.h<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+* Authors : MSH - Motion Mems BU - Application Tea=
m<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><=
span style=3D'font-family:"Courier New"'>+*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; : Matteo Dameno (<a href=3D"mailto:matteo.dameno@st.com">m=
atteo.dameno@st.com</a><o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+*&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : author is willing to be considered=
 the contact<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+*&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; : and update points for the driver.<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+* Version : V.2.0.0<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+* Date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 2011=
/Aug/16<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:n=
one'><span style=3D'font-family:"Courier New"'>+* Description&nbsp; : LSM30=
3DLHC 6D module sensor device driver iio<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : accelerometer sec=
tion header file<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>+******************=
**************************************************************<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+*<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+* Thi=
s program is free software; you can redistribute it and/or modify<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+* it under the terms of the GNU General Pub=
lic License version 2 as<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+* publishe=
d by the Free Software Foundation.<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+=
*<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><=
span style=3D'font-family:"Courier New"'>+* THE PRESENT SOFTWARE IS PROVIDE=
D ON AN &quot;AS IS&quot; BASIS, WITHOUT WARRANTIES<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+* OR CONDITIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED, FO=
R THE SOLE<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospac=
e:none'><span style=3D'font-family:"Courier New"'>+* PURPOSE TO SUPPORT YOU=
R APPLICATION DEVELOPMENT.<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+* AS A =
RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY DIRECT,<o:p></o=
:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span styl=
e=3D'font-family:"Courier New"'>+* INDIRECT OR CONSEQUENTIAL DAMAGES WITH R=
ESPECT TO ANY CLAIMS ARISING FROM THE<o:p></o:p></span></p><p class=3DMsoNo=
rmal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"=
'>+* CONTENT OF SUCH SOFTWARE AND/OR THE USE MADE BY CUSTOMERS OF THE CODIN=
G<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><=
span style=3D'font-family:"Courier New"'>+* INFORMATION CONTAINED HEREIN IN=
 CONNECTION WITH THEIR PRODUCTS.<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+*<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+***********************************=
********************************************/<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+/***************************************************************=
****************<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>+Version History.<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+ Revision 2.0.0: 2012/Nov/16<o:p></o=
:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span styl=
e=3D'font-family:"Courier New"'>+&nbsp; first ioo implementation;<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+*******************************************=
************************************/<o:p></o:p></span></p><p class=3DMsoNo=
rmal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"=
'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+#ifndef&nbsp;&nbsp; __LSM303DLH=
C_H__<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; __LSM303D=
LHC_H__<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:n=
one'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+#define&nbsp;&nbsp; LSM303DLHC_ACC_DEV_NAME&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;lsm303dlhc_acc_iio&quot;<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+/*&nbsp=
; Accelerometer section defines&nbsp;&nbsp; */<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+#ifdef&nbsp;&nbsp;&nbsp; __KERNEL__<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+#define SAD0L&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; 0x00<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+#de=
fine SAD0H&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x01<o:p></o:p></span></p><p class=3D=
MsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier=
 New"'>+#define LSM303DLHC_ACC_I2C_SADROOT&nbsp; 0x0C<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+#define LSM303DLHC_ACC_I2C_SAD_L&nbsp;&nbsp;&nbsp; ((LSM=
303DLHC_ACC_I2C_SADROOT&lt;&lt;1)|SAD0L)<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+#define LSM303DLHC_ACC_I2C_SAD_H&nbsp;&nbsp;&nbsp; ((LSM303DLHC_ACC_I=
2C_SADROOT&lt;&lt;1)|SAD0H)<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; LSM303DLHC_ACC_MIN_PO=
LL_PERIOD_MS&nbsp;&nbsp;&nbsp; 1<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+/* Accelerometer Sensor Full Scale *=
/<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><=
span style=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; LSM303DLHC_AC=
C_FS_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x30<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+#define LSM303DLHC_ACC_G_2G&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00<o:p></o:p></span></p><p class=3DMso=
Normal style=3D'text-autospace:none'><span style=3D'font-family:"Courier Ne=
w"'>+#define LSM303DLHC_ACC_G_4G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; 0x10<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospac=
e:none'><span style=3D'font-family:"Courier New"'>+#define LSM303DLHC_ACC_G=
_8G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x20<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+#define LSM303DLHC_ACC_G_16G&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 0x30<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+#define&nbsp;&nbsp; LSM303DLHC_ACC_RESUME_ENTR=
IES&nbsp;&nbsp; 17<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+struct lsm303dlhc_acc_data {<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nb=
sp; struct work_struct&nbsp;&nbsp; work_trigger_to_ring;<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+&nbsp;&nbsp;&nbsp; struct iio_work_cont work_cont_thr=
esh;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none=
'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; s64&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last_times=
tamp;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; struct iio=
_dev&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *indio_dev;<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+&nbsp;&nbsp;&nbsp; struct iio_trigger&nbsp;&nbsp; *trig;<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; struct i2=
c_client&nbsp;&nbsp;&nbsp; *client;<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+&nbsp;&nbsp;&nbsp; struct lsm303dlhc_acc_platform_data&nbsp; *pdata;<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; use_smbus;<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; lock;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw_initialized;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw_working;<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; at=
omic_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enabled;<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp=
;&nbsp; char const&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *gain;<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+&nbsp;&nbsp;&nbsp; char const&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; *scale;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+&nbsp;&nbsp;&nbsp; u8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_addr;<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+&nbsp;&nbsp;&nbsp; u8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; resume_state[LSM303DLHC_ACC_RE=
SUME_ENTRIES];<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&=
nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; irq1;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; int=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ir=
q2;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+};<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+struct lsm303dlhc_acc_platform_data {<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp=
;&nbsp; u8 g_range;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nb=
sp; u8 sampling_frequency;<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; u8 axis_map_x;<o:p></o=
:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span styl=
e=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; u8 axis_map_y;<o:p></o:=
p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; u8 axis_map_z;<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp; u8 negate_x;<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp=
;&nbsp;&nbsp; u8 negate_y;<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp; u8 negate_z;<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; /* set gpio_int[1,2] eit=
her to the choosen gpio pin number or to -EINVAL<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+&nbsp;&nbsp;&nbsp; * if leaved unconnected<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+&nbsp;&nbsp;&nbsp; */<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp; int gpio_int1;<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp; int gpio_int2;<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; int =
(*init)(void);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; v=
oid (*exit)(void);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbs=
p; int (*power_on)(void);<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp; int (*power_off)(void);<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+};<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+#ifdef CONFIG_IIO_RING_=
BUFFER<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+/* At the moment triggers ar=
e only used for ring buffer<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+ * fill=
ing. This may change!<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+ */<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+en=
um lsm303dlhc_acc_scan {<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbs=
p;&nbsp; LSM303DLHC_ACC_SCAN_ACC_X,<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+&nbsp;&nbsp;&nbsp; LSM303DLHC_ACC_SCAN_ACC_Y,<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+&nbsp;&nbsp;&nbsp; LSM303DLHC_ACC_SCAN_ACC_Z,<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+};<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+void lsm303dlhc_acc_remove_trigger(struct=
 iio_dev *indio_dev);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+int lsm303dlh=
c_acc_probe_trigger(struct iio_dev *indio_dev);<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+ssize_t lsm303dlhc_ac=
c_read_data_from_ring(struct device *dev,<o:p></o:p></span></p><p class=3DM=
soNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; struct device_attribute *attr,<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char =
*buf);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+int lsm303dlhc_acc_co=
nfigure_ring(struct iio_dev *indio_dev);<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+void lsm303dlhc_acc_unconfigure_ring(struct iio_dev *indio_dev);<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+int lsm303dlhc_acc_initialize_ring(struct iio_ring_buffer *ring);<o:p></o=
:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span styl=
e=3D'font-family:"Courier New"'>+void lsm303dlhc_acc_uninitialize_ring(stru=
ct iio_ring_buffer *ring);<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+#else /=
* CONFIG_IIO_RING_BUFFER */<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+static inline void lsm303dlhc_acc_remove_=
trigger(struct iio_dev *indio_dev)<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+=
{<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><=
span style=3D'font-family:"Courier New"'>+}<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+static inline int lsm30=
3dlhc_acc_probe_trigger(struct iio_dev *indio_dev)<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+{<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp=
; return 0;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+}<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+static inline s=
size_t<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+lsm303dlhc_acc_read_data_fro=
m_ring(struct device *dev,<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ch=
ar *buf)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+{<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+}<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+static int lsm303dlhc_acc_configure_ring(struct iio_dev =
*indio_dev)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+{<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+}<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+static inline void lsm303dlhc_acc_unconfigure_ring(str=
uct iio_dev *indio_dev)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+{<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+}<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+static inline int lsm303dlhc_acc_in=
itialize_ring(struct iio_ring_buffer *ring)<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+{<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; ret=
urn 0;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+}<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+static inline void l=
sm303dlhc_acc_uninitialize_ring(struct iio_ring_buffer<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ri=
ng)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+{<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+}<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+#endif /* CONFIG_IIO_RING_BUFFER */<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+#endif&nbsp;&n=
bsp;&nbsp; /* __KERNEL__ */<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+#endif&nbsp;&nbsp;&nbsp; /* __LSM303DLHC_=
H__ */<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>diff --git a/drivers/staging/iio/accel/lsm303dlhc_acc_co=
re.c b/drivers/staging/iio/accel/lsm303dlhc_acc_core.c<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>index e69de29..7d71715 100644<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>--- a/drivers/staging/iio/accel/lsm303dlhc_acc_core.c<o:p></o:=
p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+++ b/drivers/staging/iio/accel/lsm303dlhc_a=
cc_core.c<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>@@ -0,0 +1,1160 @@<o:p></o=
:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span styl=
e=3D'font-family:"Courier New"'>+/******************** (C) COPYRIGHT 2011 S=
TMicroelectronics ********************<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+*<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+* File Name&nbsp;&nbsp;&nbsp;=
 : lsm303dlhc_acc_core_iio.c<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+* Auth=
ors : MSH - Motion Mems BU - Application Team<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : Matteo Damen=
o (<a href=3D"mailto:matteo.dameno@st.com">matteo.dameno@st.com</a>)<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; : author is willing to be considered the contact<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : =
and update points for the driver.*<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+=
* Version : V.2.0.0<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+* Date&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 2011/Nov/16<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+* Description&nbsp; : LSM303DLHC 6D module sensor device=
 driver iio<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+*&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; : accelerometer section<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+***********************************************************=
*********************<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+*<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+* This program is free software; you can redis=
tribute it and/or modify<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+* it under=
 the terms of the GNU General Public License version 2 as<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+* published by the Free Software Foundation.<o:p></o=
:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span styl=
e=3D'font-family:"Courier New"'>+*<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+=
* THE PRESENT SOFTWARE IS PROVIDED ON AN &quot;AS IS&quot; BASIS, WITHOUT W=
ARRANTIES<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+* OR CONDITIONS OF ANY KI=
ND, EITHER EXPRESS OR IMPLIED, FOR THE SOLE<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+* PURPOSE TO SUPPORT YOUR APPLICATION DEVELOPMENT.<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+* AS A RESULT, STMICROELECTRONICS SHALL NOT BE H=
ELD LIABLE FOR ANY DIRECT,<o:p></o:p></span></p><p class=3DMsoNormal style=
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
"Courier New"'>+#include&nbsp; &lt;linux/err.h&gt;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+#include&nbsp; &lt;linux/errno.h&gt;<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+#include&nbsp; &lt;linux/delay.h&gt;<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+#include&nbsp; &lt;linux/fs.h&gt;<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+#include&nbsp; &lt;linux/i2c.h&gt;<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+#include&nbsp; &lt;linux/input.h&gt;<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+#include&nbsp; &lt;linux/uaccess.h&gt;<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+#include&nbsp; &lt;linux/workqueue.h&gt;<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+#include&nbsp; &lt;linux/irq.h&gt;<o:p></o:=
p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+#include&nbsp; &lt;linux/gpio.h&gt;<o:p></o=
:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span styl=
e=3D'font-family:"Courier New"'>+#include&nbsp; &lt;linux/interrupt.h&gt;<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+#include&nbsp; &lt;linux/slab.h&gt;<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+#include&nbsp; &lt;linux/device.h&g=
t;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+#include&nbsp; &lt;linux/kernel.=
h&gt;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+#include&nbsp; &lt;linux/modu=
le.h&gt;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+#include&nbsp; &lt;linux/s=
ysfs.h&gt;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospac=
e:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+#include&nbsp; &q=
uot;../iio.h&quot;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+#include&nbsp; &=
quot;../sysfs.h&quot;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+#include&nbsp=
; &quot;accel.h&quot;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+#include&nbsp=
; &quot;lsm303dlhc_acc.h&quot;<o:p></o:p></span></p><p class=3DMsoNormal st=
yle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p=
></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNo=
rmal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"=
'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+#define SENSITIVITY_2G&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp; /**&nbsp; mg/co=
unts */<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:n=
one'><span style=3D'font-family:"Courier New"'>+#define SENSITIVITY_4G&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp;&nbsp;&nbsp; /**&nbsp; m=
g/counts */<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+#define SENSITIVITY_8G&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4&nbsp;&nbsp;&nbsp; /**&nbs=
p; mg/counts */<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+#define SENSITIVITY=
_16G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12&nbsp;&nbsp; /**&nbsp; mg/=
counts */<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+/* g, standard gravity 1g =3D 9.80665 m/s^2 */<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+#define SCALE_2G&nbsp;&nbsp;&nbsp; &quot;0.0098=
1&quot;&nbsp; /**&nbsp; (m/s^2)/count */<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+#define SCALE_4G&nbsp;&nbsp;&nbsp; &quot;0.01961&quot;&nbsp; /**&nbsp=
; (m/s^2)/count */<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+#define SCALE_8G=
&nbsp;&nbsp;&nbsp; &quot;0.03923&quot;&nbsp; /**&nbsp; (m/s^2)/count */<o:p=
></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"Courier New"'>+#define SCALE_16G&nbsp;&nbsp; &quot;0.=
11768&quot;&nbsp; /**&nbsp; (m/s^2)/count */<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+#define GAIN_2G&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;101.971621&quot;=
&nbsp;&nbsp;&nbsp; /**&nbsp; count/(m/s^2) */<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+#define GAIN_4G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; &quot;50.985811&quot;&nbsp;&nbsp;&nbsp;&nbsp; /**&nbsp; count/(=
m/s^2) */<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+#define GAIN_8G&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;25.492905&quot;&nb=
sp;&nbsp;&nbsp;&nbsp; /**&nbsp; count/(m/s^2) */<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+#define GAIN_16G&nbsp;&nbsp;&nbsp; &quot;8.497635&quot; /**&n=
bsp; count/(m/s^2) */<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+/* Accelerometer Sensor Operating Mode */<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+#define LSM303DLHC_ACC_ENABLE&nbsp; (0x0=
1)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+#define LSM303DLHC_ACC_DISABLE (=
0x00)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+#define&nbsp;&nbsp; HIGH_RESOLUTION&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; (0x08)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+#define OUT_X_LSB&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; (0x28)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+#define OUT_X_MSB&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x29)<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+#define OUT_Y_LSB&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (0x2A)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+#define OUT_Y_MSB&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x2B)<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+#define OUT_Z_LSB&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; (0x2C)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+#define OUT_Z_MSB&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x2D)<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+#define&nbsp;&nbsp; AXISDATA_REG&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; OUT_X_LSB<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+=
<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><s=
pan style=3D'font-family:"Courier New"'>+#define WHOAMI_LSM303DLHC_ACC&nbsp=
; 0x33 /*&nbsp;&nbsp; Expctd content for WAI&nbsp;&nbsp;&nbsp;&nbsp; */<o:p=
></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNo=
rmal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"=
'>+/*&nbsp; CONTROL REGISTERS&nbsp;&nbsp;&nbsp; */<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+#define WHO_AM_I&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; 0x0F /*&nbsp;&nbsp; WhoAmI register&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; */<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; TEMP_CFG_=
REG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1F /*&nbsp;&nbsp; tem=
per sens control reg&nbsp;&nbsp;&nbsp; */<o:p></o:p></span></p><p class=3DM=
soNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier =
New"'>+/* ctrl 1: ODR3 ODR2 ODR1 ODR0 LPen Zenable Yenable Zenable */<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; CTRL_REG1&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 0x20 /*&nbsp;&nbsp; control reg 1&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+#defi=
ne&nbsp;&nbsp; CTRL_REG2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x21 /*&nbsp;&=
nbsp; control reg 2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; CTRL_REG3&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; 0x22 /*&nbsp;&nbsp; control reg 3&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+#define=
&nbsp;&nbsp; CTRL_REG4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x23 /*&nbsp;&nb=
sp; control reg 4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+#define&nbsp;&nbsp; CTRL_REG5&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 0x24 /*&nbsp;&nbsp; control reg 5&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; */<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+#define&nbsp=
;&nbsp; CTRL_REG6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x25 /*&nbsp;&nbsp; c=
ontrol reg 6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+#define&nbs=
p;&nbsp; FIFO_CTRL_REG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x2E /*&nb=
sp;&nbsp; FiFo control reg&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+#define&nbsp;&n=
bsp; INT_CFG1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x30 /*&nbsp;&nbsp;=
 interrupt 1 config&nbsp;&nbsp; */<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+=
#define&nbsp;&nbsp; INT_SRC1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x31=
 /*&nbsp;&nbsp; interrupt 1 source&nbsp;&nbsp; */<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+#define&nbsp;&nbsp; INT_THS1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 0x32 /*&nbsp;&nbsp; interrupt 1 threshold */<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+#define&nbsp;&nbsp; INT_DUR1&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 0x33 /*&nbsp;&nbsp; interrupt 1 duration */<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; TT_CFG&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x38 =
/*&nbsp;&nbsp; tap config&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+#define&nbsp;&nbsp; TT_SRC&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x39 /*&nbsp;&n=
bsp; tap source&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+#define&nbsp;&nbsp; TT_THS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x3A /*&nbsp;&nbsp; tap t=
hreshold&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+#define&nbsp;&nbsp; TT_LIM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x3B /*&nbsp;&nbsp; =
tap time limit&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+#define&nbsp;&nbsp; TT_TLAT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x3C /*&nbsp;&nbsp; tap t=
ime latency&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+#define&nbsp;&nbsp; TT_TW&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 0x3D /*&nbsp;&nbsp; tap time window&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; */<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+/*&nbsp; end CONTROL REGIS=
TRES */<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:n=
one'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+#define ENABLE_HIGH_=
RESOLUTION 1<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+#define LSM303DLHC_ACC_PM_OFF&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; (0x00)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>+#define LSM303DLHC=
_ACC_ENABLE_ALL_AXES&nbsp;&nbsp;&nbsp; (0x07)<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+#define&nbsp;&nbsp; CTRL_REG1_PMODE_MASK (0x08)<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; CTRL_REG1_ODR_MASK&nbsp=
;&nbsp; (0XF0)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+#define&nbsp;&nbsp; LSM303DLHC_ACC_ODR1&nbsp; (0x10)&n=
bsp; /* 1Hz output data rate */<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+#de=
fine&nbsp;&nbsp; LSM303DLHC_ACC_ODR10 (0x20)&nbsp; /* 10Hz output data rate=
 */<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; LSM303DLHC_=
ACC_ODR25 (0x30)&nbsp; /* 25Hz output data rate */<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+#define&nbsp;&nbsp; LSM303DLHC_ACC_ODR50 (0x40)&nbsp; /* 50=
Hz output data rate */<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+#define&nbsp=
;&nbsp; LSM303DLHC_ACC_ODR100 (0x50)&nbsp; /* 100Hz output data rate */<o:p=
></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; LSM303DLHC_ACC_ODR=
200 (0x60)&nbsp; /* 200Hz output data rate */<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+#define&nbsp;&nbsp; LSM303DLHC_ACC_ODR400 (0x70)&nbsp; /* 400Hz =
output data rate */<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+#define&nbsp;&n=
bsp; LSM303DLHC_ACC_ODR1350&nbsp;&nbsp;&nbsp;&nbsp; (0x90)&nbsp; /* 1350Hz =
output data rate */<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+#define=
 ALL_ZEROES&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x00)<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; IA&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x40)<o:p></o:=
p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; ZH&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x20)<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; ZL&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x10)<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; YH&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x08)<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; YL&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x04)<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; XH&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x02)<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; XL&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x01)<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+/* */<o:p></o:p></span></p><p class=3DMsoNo=
rmal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"=
'>+/* CTRL REG 3 BITS */<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+#define&nb=
sp;&nbsp; CTRL_REG3_I1_AOI1&nbsp;&nbsp;&nbsp; (0x40)<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+/*&nbsp; */<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; CTRL_REG4_BDU_ENABL=
E (0x80)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; CTRL_R=
EG4_BDU_MASK&nbsp;&nbsp; (0x80)<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+#define&nbsp;&nbsp; CTRL_REG6_I2_TAPEN&nbsp;&nbsp; 0x80<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+#define&nbsp;&nbsp; CTRL_REG6_HLACTIVE&nbsp;&nbsp;=
 0x02<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+/* */<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+#define&nbsp;&nbsp; NO_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xFF<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+#define&nbsp;&nbsp; INT1_DURATION_MASK&nbsp;&nbsp; 0x7F<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; INT1_THRESHOLD_M=
ASK&nbsp; 0x7F<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; =
TAP_CFG_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x3F<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; TAP_THS_MASK&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x7F<o:p></o:p></span></p><p class=3D=
MsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier=
 New"'>+#define&nbsp;&nbsp; TAP_TLIM_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 0x7F<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; T=
AP_TLAT_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NO_MASK<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+#define&nbsp;&nbsp; TAP_TW_MASK&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NO_MASK<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+/* TAP_SOURCE_REG BIT */<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+#define&nbsp;&nbsp; DTAP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; 0x20<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+#de=
fine&nbsp;&nbsp; STAP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 0x10<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+#define&nbsp;&nbs=
p; SIGNTAP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x08<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+#define&nbsp;&nb=
sp; ZTAP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x04<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none=
'><span style=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; YTAP&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x02<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; XTAZ&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x01<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+#define&nbsp;&nbsp; FUZZ&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<o:p></o:p></span></p><p class=3D=
MsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier=
 New"'>+#define&nbsp;&nbsp; FLAT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; 0<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+#define=
&nbsp;&nbsp; I2C_RETRY_DELAY&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+#define&nbsp;&nbsp; I2C_RETRIES&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+#define&nbsp;&nbsp; I2C_AUTO_INCREMENT&nbsp;&nbsp; 0x80<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+/* RESU=
ME STATE INDICES */<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+#define&nbsp;&n=
bsp; RES_CTRL_REG1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+#define&nbsp;&nbsp; RES_CTRL_REG2&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<o:p></o:p></span></p><p class=3DMsoNormal st=
yle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+#def=
ine&nbsp;&nbsp; RES_CTRL_REG3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; RES_CTRL_REG4&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3<o:p></o:p></span></p><p class=3DM=
soNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier =
New"'>+#define&nbsp;&nbsp; RES_CTRL_REG5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 4<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; RES_C=
TRL_REG6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+#define&nbsp;&nb=
sp; RES_INT_CFG1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6<o:p></o:=
p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; RES_INT_THS1&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7<o:p></o:p></span></p><p class=3DMso=
Normal style=3D'text-autospace:none'><span style=3D'font-family:"Courier Ne=
w"'>+#define&nbsp;&nbsp; RES_INT_DUR1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 8<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+#define&nbsp;&nbsp; RES_TT_CFG&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 9<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; RES_TT_T=
HS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+#define&nbsp;&nbsp; RES_TT_LIM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 11<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; RES_TT_TLAT&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+#define&nbsp;&nbsp; RES_TT_TW&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 13<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none=
'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+#define&nbsp;&nbsp; RES_TEMP_CFG_REG&nbsp;&nbsp;&nbsp;&nbsp; 14<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; RES_REFERENCE_R=
EG&nbsp;&nbsp;&nbsp; 15<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+#define&nbs=
p;&nbsp; RES_FIFO_CTRL_REG&nbsp;&nbsp;&nbsp; 16<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+#define&nbsp;&nbsp; R=
ESUME_ENTRIES&nbsp; LSM303DLHC_ACC_RESUME_ENTRIES<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+/* end RESUME STATE INDICES */<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+struct output_rate {<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+&nbsp;&nbsp;&nbsp; unsigned int cutoff_ms;<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+&nbsp;&nbsp;&nbsp; unsigned int sampling_rate_setting;<o:p></o:=
p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; const char *hz_label;<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+};<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+static const struct output_r=
ate lsm303dlhc_acc_odr_table[] =3D {<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp;&nbsp; 1, LSM303DLHC_ACC_ODR1350, &quot=
;1350&quot;},<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp;&nbsp; 3, LSM303DLHC_ACC_ODR=
400,&nbsp; &quot;400&quot;},<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp;&nbsp; 5, LSM=
303DLHC_ACC_ODR200,&nbsp; &quot;200&quot;},<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&nbsp;&n=
bsp; 10, LSM303DLHC_ACC_ODR100,&nbsp; &quot;100&quot;},<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 {&nbsp;&nbsp; 20, LSM303DLHC_ACC_ODR50,&nbsp;&nbsp; &quot;50&quot;},<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; {&nbsp;&nbsp; 40, LSM303DLHC_ACC_ODR25,&nbsp;&nbsp; &quot;25=
&quot;},<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; {&nbsp; 100, LSM303DLHC_ACC_ODR10,&nbsp;&nbsp;=
 &quot;10&quot;},<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { 1000, LSM303DLHC_ACC_ODR1,&nbsp;&nb=
sp;&nbsp; &quot;1&quot;},<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+};<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+static const struct lsm303dlhc_acc_platform_data<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+default_lsm303dlhc_acc_pdata =3D {<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+&nbsp;&nbsp;&nbsp; .g_range =3D LSM303DLHC_ACC_G_2G,<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; .sampling_frequency =
=3D LSM303DLHC_ACC_ODR10,<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp; .axis_map_x =3D 0,<o:p></o:p></span></p><p class=3DMsoNormal st=
yle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbs=
p;&nbsp;&nbsp; .axis_map_y =3D 1,<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&=
nbsp;&nbsp;&nbsp; .axis_map_z =3D 2,<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+&nbsp;&nbsp;&nbsp; .negate_x =3D 0,<o:p></o:p></span></p><p class=3DMsoNo=
rmal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"=
'>+&nbsp;&nbsp;&nbsp; .negate_y =3D 0,<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+&nbsp;&nbsp;&nbsp; .negate_z =3D 0,<o:p></o:p></span></p><p class=3DMso=
Normal style=3D'text-autospace:none'><span style=3D'font-family:"Courier Ne=
w"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; .gpio_int1=
 =3D -EINVAL,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; .g=
pio_int2 =3D -EINVAL,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+};<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+st=
atic int lsm303dlhc_acc_i2c_read(struct lsm303dlhc_acc_data *data,<o:p></o:=
p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; u8 *buf, int len)<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+{<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; int ret;<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; u8 reg =3D buf[0];<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; u8 cmd =3D reg;<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMso=
Normal style=3D'text-autospace:none'><span style=3D'font-family:"Courier Ne=
w"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (len &g=
t; 1)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; cmd =3D (I2C_AUTO_INCREMENT | reg);<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (data-&gt;use_smbus) {<o:p=
></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; if (len =3D=3D 1) {<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; ret =3D i2c_smbus_read_byte_data(data-&gt;client, cmd);<o:p></o=
:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span styl=
e=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf[0] =3D ret &amp; 0xff;<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+#ifdef DEBUG<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; dev_warn(&amp;data-&gt;client-&gt;dev,<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;i2=
c_smbus_read_byte_data: ret=3D0x%02x, len:%d ,&quot;<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;command=3D0=
x%02x, buf[0]=3D0x%02x\n&quot;,<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret, len, cmd , buf[0]);<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+#endif<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (len &gt; 1=
) {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D i2c_smbus_rea=
d_i2c_block_data(data-&gt;client,<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; cmd, len, buf);<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+#ifdef DEBUG<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(&=
amp;data-&gt;client-&gt;dev,<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;i2c_smbus_read_i2c_block_data: ret:=
%d len:%d, &quot;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; &quot;command=3D0x%02x, &quot;,<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret, len, cmd);=
<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><s=
pan style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char ii;<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (ii =3D 0; ii &lt; len; ii++)<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p=
rintk(KERN_DEBUG &quot;buf[%d]=3D0x%02x,&quot;,<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ii, buf[ii]);<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk(&qu=
ot;\n&quot;);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+#endif<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; } else<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D -1;<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0=
) {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(&amp;data-&gt=
;client-&gt;dev,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; &quot;read transfer error: len:%d, command=3D0x%02x\n=
&quot;,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:n=
one'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; len, cmd);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r=
eturn 0; /* failure */<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return le=
n; /* success */<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;=
 }<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; ret =
=3D i2c_master_send(data-&gt;client, &amp;cmd, sizeof(cmd));<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (ret !=3D sizeof(cmd))<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return ret;<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; return i2c_master_recv=
(data-&gt;client, buf, len);<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+}<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+static int lsm303dlhc_acc_i2c_write(struct lsm303dlhc_acc_data *data, u8 =
*buf,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int len=
)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><=
span style=3D'font-family:"Courier New"'>+{<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp; int ret;<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+&nbsp;&nbsp;&nbsp; u8 reg, value;<o:p></o:p></span></p><p class=3DMsoNo=
rmal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"=
'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (len &gt;=
 1)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; buf[0] =3D (I2C_AUTO_INCREMENT | buf[0]);<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp; reg =3D buf[0];<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp; value =3D buf[1];<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+=
<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><s=
pan style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (data-&gt;us=
e_smbus) {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospac=
e:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (len =3D=3D 1) {<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D i2c_smbus_write_byte_data(data-&gt;client=
, reg,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; value);<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+#if=
def DEBUG<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(&amp;da=
ta-&gt;client-&gt;dev,<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;i2c_smbus_write_byte_data: ret=3D%d, len:=
%d, &quot;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospac=
e:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &quot;command=3D0x%02x, value=3D0x%02x\n&quot;,<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret, l=
en, reg , value);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+#endif<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }=
 else if (len &gt; 1) {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r=
et =3D i2c_smbus_write_i2c_block_data(data-&gt;client,<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; reg, len, buf + 1);<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+#ifdef =
DEBUG<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(&amp;data-&=
gt;client-&gt;dev,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; &quot;i2c_smbus_write_i2c_block_data: ret=3D%d, &qu=
ot;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; &quot;len:%d, command=3D0x%02x, &quot;,<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret, len, reg);<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char ii;<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; for (ii =3D 0; ii &lt; len + 1; ii++)<o:p></o:=
p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pri=
ntk(KERN_DEBUG &quot;value[%d]=3D0x%02x,&quot;,<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ii, buf[ii]);<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk(&qu=
ot;\n&quot;);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+#endif<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&=
nbsp; ret =3D i2c_master_send(data-&gt;client, buf, len+1);<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; return (ret =3D=3D len+1) ? 0 :=
 ret;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+}<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+static int lsm303dlhc_acc_register_write(struct lsm303d=
lhc_acc_data *data,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8 *buf, u8 reg_address, u8 new_val=
ue)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+{<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp; int err;<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none=
'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; /* Sets configuration register at reg_address<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; *&nbsp; NOTE: this is a straight overwrite&nbsp; */<o:p></o=
:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span styl=
e=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; buf[0] =3D reg_address;<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf[1] =3D new_val=
ue;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; err =3D lsm303dlhc_acc_i2c_write(data, buf, 1);<o:p=
></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; if (err &lt; 0)<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return err;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; return err;<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+}<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+static int lsm303dlhc_acc_register_read(str=
uct lsm303dlhc_acc_data *data,<o:p></o:p></span></p><p class=3DMsoNormal st=
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
yle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; err =3D lsm303dlhc_ac=
c_i2c_read(data, buf, 1);<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp; return err;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+}<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+st=
atic int lsm303dlhc_acc_register_update(struct lsm303dlhc_acc_data *data,<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; u8 *buf, u8 reg_address, u8 mask, u8 new_bit_values)<o:p=
></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"Courier New"'>+{<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+&nbsp;&nbsp;&nbsp; int err =3D -1;<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+&nbsp;&nbsp;&nbsp; u8 init_val;<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+&nbsp;&nbsp;&nbsp; u8 updated_val;<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+&nbsp;&nbsp;&nbsp; err =3D lsm303dlhc_acc_register_read(data, buf, reg_add=
ress);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (!(err=
 &lt; 0)) {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_val =3D buf[0];<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; up=
dated_val =3D ((mask &amp; new_bit_values) | ((~mask) &amp; init_val));<o:p=
></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; err =3D lsm303dlhc_acc_register_write(data, buf, reg_addre=
ss,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; updated_val);<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;=
&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; return =
err;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none=
'><span style=3D'font-family:"Courier New"'>+}<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+static int lsm303dlhc_=
acc_hw_init(struct lsm303dlhc_acc_data *data)<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+{<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; int=
 err =3D -1;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; u8 =
buf[7];<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:n=
one'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+&nbsp;&nbsp;&nbsp; printk(KERN_INFO &quot;%s: hw init start\n=
&quot;, LSM303DLHC_ACC_DEV_NAME);<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; buf[0] =3D WHO_A=
M_I;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none=
'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; err =3D lsm=
303dlhc_acc_i2c_read(data, buf, 1);<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+&nbsp;&nbsp;&nbsp; if (err &lt; 0) {<o:p></o:p></span></p><p class=3DMsoNo=
rmal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"=
'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(&amp;dat=
a-&gt;client-&gt;dev, &quot;Error reading WHO_AM_I: is device available/wor=
king?\n&quot;);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_firstread;<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+&nbsp;&nbsp;&nbsp; } else<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt=
;hw_working =3D 1;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (buf[0] !=3D WHOAMI_LSM303DL=
HC_ACC) {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(&amp;data-&gt;client-&gt;dev,<o:p></o=
:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span styl=
e=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;device unknown. Expected: =
0x%02x,&quot;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot; Repl=
ies: 0x%02x\n&quot;, WHOAMI_LSM303DLHC_ACC, buf[0]);<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; er=
r =3D -1; /* choose the right coded error */<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_=
unknown_device;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; =
}<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><=
span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3D=
MsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier=
 New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; buf[0] =
=3D (CTRL_REG1);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;=
 buf[1] =3D data-&gt;resume_state[RES_CTRL_REG1];<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+&nbsp;&nbsp;&nbsp; err =3D lsm303dlhc_acc_i2c_write(data, bu=
f, 1);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (err &=
lt; 0)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; goto err_resume_state;<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; =
buf[0] =3D (TEMP_CFG_REG);<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp; buf[1] =3D data-&gt;resume_state[RES_TEMP_CFG_REG];<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; err =3D lsm303dlhc_acc_i2c_=
write(data, buf, 1);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&n=
bsp; if (err &lt; 0)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_resume_state;<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp=
;&nbsp;&nbsp; buf[0] =3D (FIFO_CTRL_REG);<o:p></o:p></span></p><p class=3DM=
soNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp; buf[1] =3D data-&gt;resume_state[RES_FIFO_CTRL_RE=
G];<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; err =3D lsm3=
03dlhc_acc_i2c_write(data, buf, 1);<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+&nbsp;&nbsp;&nbsp; if (err &lt; 0)<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_resume_sta=
te;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp; buf[0] =3D (TT_THS);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+&nbsp;&nbsp;&nbsp; buf[1] =3D data-&gt;resume_state[RES_TT_=
THS];<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; buf[2] =3D=
 data-&gt;resume_state[RES_TT_LIM];<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+&nbsp;&nbsp;&nbsp; buf[3] =3D data-&gt;resume_state[RES_TT_TLAT];<o:p></o:=
p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; buf[4] =3D data-&gt;resu=
me_state[RES_TT_TW];<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&n=
bsp; err =3D lsm303dlhc_acc_i2c_write(data, buf, 4);<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (err &lt; 0)<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; go=
to err_resume_state;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&n=
bsp; buf[0] =3D (TT_CFG);<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp; buf[1] =3D data-&gt;resume_state[RES_TT_CFG];<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+&nbsp;&nbsp;&nbsp; err =3D lsm303dlhc_acc_i2c_write(=
data, buf, 1);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; i=
f (err &lt; 0)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_resume_state;<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp=
;&nbsp; buf[0] =3D (INT_THS1);<o:p></o:p></span></p><p class=3DMsoNormal st=
yle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbs=
p;&nbsp;&nbsp; buf[1] =3D data-&gt;resume_state[RES_INT_THS1];<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; buf[2] =3D data-&gt;resume_s=
tate[RES_INT_DUR1];<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nb=
sp; err =3D lsm303dlhc_acc_i2c_write(data, buf, 2);<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (err &lt; 0)<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; got=
o err_resume_state;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nb=
sp; buf[0] =3D (INT_CFG1);<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp; buf[1] =3D data-&gt;resume_state[RES_INT_CFG1];<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; err =3D lsm303dlhc_acc_i2c_writ=
e(data, buf, 1);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;=
 if (err &lt; 0)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_resume_state;<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; buf[0] =3D (CTRL_REG2)=
;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><=
span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; buf[1] =3D dat=
a-&gt;resume_state[RES_CTRL_REG2];<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+=
&nbsp;&nbsp;&nbsp; buf[2] =3D data-&gt;resume_state[RES_CTRL_REG3];<o:p></o=
:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span styl=
e=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; buf[3] =3D data-&gt;res=
ume_state[RES_CTRL_REG4];<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp; buf[4] =3D data-&gt;resume_state[RES_CTRL_REG5];<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; buf[5] =3D data-&gt;resume_sta=
te[RES_CTRL_REG6];<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbs=
p; err =3D lsm303dlhc_acc_i2c_write(data, buf, 5);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+&nbsp;&nbsp;&nbsp; if (err &lt; 0)<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto=
 err_resume_state;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; data-&gt;hw_initialized =3D 1;<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; printk(KERN_INFO=
 &quot;%s: hw init done\n&quot;, LSM303DLHC_ACC_DEV_NAME);<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+err_firstread:<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; data-&gt;hw_worki=
ng =3D 0;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+err_unknown_device:<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+err_resume_state:<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+&nbsp;&nbsp;&nbsp; data-&gt;hw_initialized =3D 0;<o:p></o=
:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span styl=
e=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; dev_err(&amp;data-&gt;c=
lient-&gt;dev, &quot;hw init error 0x%02x,0x%02x: %d\n&quot;, buf[0],<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf[1], err);<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; return err;<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+}<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+static void lsm303dlhc_acc_device_power_off(str=
uct lsm303dlhc_acc_data *data)<o:p></o:p></span></p><p class=3DMsoNormal st=
yle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+{<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; int err;<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; u8 buf[2] =3D { CTRL_REG=
1, LSM303DLHC_ACC_PM_OFF };<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; err =3D lsm303dlhc_acc=
_i2c_write(data, buf, 1);<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp; if (err &lt; 0)<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(&amp;data-&gt;clien=
t-&gt;dev, &quot;soft power off failed: %d\n&quot;, err);<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp=
;&nbsp; if (data-&gt;pdata-&gt;power_off) {<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;=
pdata-&gt;power_off();<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;hw_initialized =3D 0;<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp; if (data-&gt;hw_initialized)<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;hw_in=
itialized =3D 0;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>+}<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+static int=
 lsm303dlhc_acc_device_power_on(struct lsm303dlhc_acc_data *data)<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+{<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&=
nbsp;&nbsp;&nbsp; int err =3D -1;<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (data-&gt;pda=
ta-&gt;power_on) {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D data-&gt;pdata-&gt;power_on(=
);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; if (err &lt; 0) {<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; dev_err(&amp;data-&gt;client-&gt;dev,<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &quot;power_on failed: %d\n&quot;, err);<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;=
&nbsp;&nbsp; if (!data-&gt;hw_initialized) {<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D l=
sm303dlhc_acc_hw_init(data);<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;hw_working =
=3D=3D 1 &amp;&amp; err &lt; 0) {<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; lsm303dlhc_acc_device_power_off(data);<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; return err;<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3D=
MsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier=
 New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; return =
0;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+}<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+static int lsm303dlhc_a=
cc_enable(struct lsm303dlhc_acc_data *data)<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+{<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; int=
 err;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+&nbsp;&nbsp;&nbsp; if (!atomic_cmpxchg(&amp;data-&gt;enabled, 0=
, 1)) {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:n=
one'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D lsm303dlhc_acc_device_power_on(data);<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; if (err &lt; 0) {<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; atomic_set(&amp;data-&gt;enabled, 0);<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; return err;<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbs=
p;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospac=
e:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+}<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+static int lsm303dlhc_acc_disable(struct lsm303dlhc_acc_=
data *data)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+{<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (atomic_cmpxchg(&amp;data-&gt;enab=
led, 1, 0))<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lsm303dlhc_acc_device_power_off(data);<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></span></p><p class=3DMsoNormal st=
yle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+}<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+static int lsm303dlhc_acc_validate_pdata(struct lsm303dlhc_acc_data *de=
v_data)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:n=
one'><span style=3D'font-family:"Courier New"'>+{<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; =
if (dev_data-&gt;pdata-&gt;axis_map_x &gt; 2 ||<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dev_data-&gt;pdata-&gt;a=
xis_map_y &gt; 2 ||<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nb=
sp; &nbsp;&nbsp;&nbsp; dev_data-&gt;pdata-&gt;axis_map_z &gt; 2) {<o:p></o:=
p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; dev_err(&amp;dev_data-&gt;client-&gt;dev,<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;invalid axis_map value x:%u y:%u z%u\n&q=
uot;,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_data-&gt;pdata-=
&gt;axis_map_x,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_data-=
&gt;pdata-&gt;axis_map_y,<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; dev_data-&gt;pdata-&gt;axis_map_z);<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp; /* Only allow 0 and 1 for negation boolean flag */<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (dev_data-&gt;pdata-&gt;n=
egate_x &gt; 1 ||<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; dev_data-&gt;pdata-&gt;negate_y &gt; 1 ||<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dev_data-=
&gt;pdata-&gt;negate_z &gt; 1) {<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(&amp;dev_data-=
&gt;client-&gt;dev,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot=
;invalid negate value x:%u y:%u z:%u\n&quot;,<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; dev_data-&gt;pdata-&gt;negate_x,<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_data-&gt;pdata-&gt;negate_y,<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_data-&gt;pdata-&gt;negate_z);<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return -EINVAL;<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nb=
sp;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+}<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+static int lsm303dlhc_acc_update_fs_range(struct =
lsm303dlhc_acc_data *acc,<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8 new_g_range)<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+{<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+&nbsp;&nbsp;&nbsp; int err =3D -1;<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; char const *s=
cale;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; char const=
 *gain;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:n=
one'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; u8 buf[2=
];<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; u8 updated_va=
l;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; u8 init_val;<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; u8 new_val;<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; u8 mask =3D LSM303DL=
HC_ACC_FS_MASK | HIGH_RESOLUTION;<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; switch (new_g_ra=
nge) {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; case LSM3=
03DLHC_ACC_G_2G:<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; gain =3D GAIN_2G;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scale =3D SCALE_2G;<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; break;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; cas=
e LSM303DLHC_ACC_G_4G:<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; gain =3D GAIN_4G;<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scale =3D SCALE_4G;<o:p></o=
:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span styl=
e=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; break;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nb=
sp; case LSM303DLHC_ACC_G_8G:<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; gain =3D GAIN_8G;<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scale =3D SCALE_8G;<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; break;<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp; case LSM303DLHC_ACC_G_16G:<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none=
'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; gain =3D GAIN_16G;<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scale =3D=
 SCALE_16G;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+&nbsp;&nbsp;&nbsp; default:<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(&amp;acc-&gt;cl=
ient-&gt;dev, &quot;invalid g range requested: %u\n&quot;,<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new_g_range=
);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; /* Updates configuration=
 register 4,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; * w=
hich contains g range setting */<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp; buf[0] =3D CTRL_REG4;<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+&nbsp;&nbsp;&nbsp; err =3D lsm303dlhc_acc_i2c_read(acc, buf, 1);<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (err &lt; 0)<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; goto error;<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp; init_val =3D buf[0];<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp; acc-&gt;resume_state[RES_CTRL_REG4] =3D init_val;<o:p></o:=
p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; new_val =3D new_g_range =
| HIGH_RESOLUTION;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbs=
p; updated_val =3D ((mask &amp; new_val) | ((~mask) &amp; init_val));<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; buf[1] =3D updated_va=
l;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; buf[0] =3D CT=
RL_REG4;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; err =3D=
 lsm303dlhc_acc_i2c_write(acc, buf, 1);<o:p></o:p></span></p><p class=3DMso=
Normal style=3D'text-autospace:none'><span style=3D'font-family:"Courier Ne=
w"'>+&nbsp;&nbsp;&nbsp; if (err &lt; 0)<o:p></o:p></span></p><p class=3DMso=
Normal style=3D'text-autospace:none'><span style=3D'font-family:"Courier Ne=
w"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error;<o:p=
></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; acc-&gt;resume_stat=
e[RES_CTRL_REG4] =3D updated_val;<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&=
nbsp;&nbsp;&nbsp; acc-&gt;gain =3D gain;<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+&nbsp;&nbsp;&nbsp; acc-&gt;scale =3D scale;<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+&nbsp;&nbsp;&nbsp; return err;<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+error:<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbs=
p;&nbsp; dev_err(&amp;acc-&gt;client-&gt;dev, &quot;update g range failed 0=
x%02x,0x%02x: %d\n&quot;,<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; buf[0], buf[1], err);<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; return err;<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+}<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+static int lsm303dlhc_acc_update_sampli=
ng_freq(struct lsm303dlhc_acc_data *data,<o:p></o:p></span></p><p class=3DM=
soNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8 freq=
)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><=
span style=3D'font-family:"Courier New"'>+{<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp; int res =3D 0;<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp; u8 buf[2];<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+&nbsp;&nbsp;&nbsp; u8 new_value;<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none=
'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp; new_value =3D freq;<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+&nbsp;&nbsp;&nbsp; res =3D lsm303dlhc_acc_register_update(da=
ta, buf, CTRL_REG1,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CTRL_REG1_ODR_=
MASK, new_value);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (res &lt; 0) {<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; dev_err(&amp;data-&gt;client-&gt;dev,<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; &quot;%s : failed to update sampling frequency setting=
\n&quot;,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __f=
unc__);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:n=
one'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return res;<o:p></o:p></span></p><p class=3DMso=
Normal style=3D'text-autospace:none'><span style=3D'font-family:"Courier Ne=
w"'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp; dev_dbg(&amp;data-&gt;client-&gt;dev, &quot;%s : new_value:0x%0=
2x, freq:0x%02x\n&quot;,<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
__func__, new_value, freq);<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; data-&gt;resume_state[=
RES_CTRL_REG1] =3D<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((CTRL_REG1_ODR_MASK &amp; new_value=
) |<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; (~CTRL_REG1_ODR_MASK &amp; data-&gt;resume_state[RE=
S_CTRL_REG1]));<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+&nbsp;&nbsp;&nbsp; data-&gt;pdata-&gt;sampling_freque=
ncy =3D new_value;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; return res;<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+}<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+static ssize_t lsm303dlhc_acc_show_sampling_fr=
equency(struct device *dev,<o:p></o:p></span></p><p class=3DMsoNormal style=
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
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; struct lsm303dlhc_acc_da=
ta *data =3D indio_dev-&gt;dev_data;<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+&nbsp;&nbsp;&nbsp; u8 i;<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp; u8 val;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp; mutex_lock(&amp;data-&gt;lock);<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp; val =3D data-&gt;pdata-&gt;sampling_frequency=
;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><=
span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; mutex_unlock(&=
amp;data-&gt;lock);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nb=
sp; dev_dbg(dev, &quot;getting sampling frequency: 0x%02x\n&quot;, val);<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; ARRAY_SIZE(lsm303dlhc_acc_odr_t=
able); i++)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (lsm303dlhc_acc_odr_table[i].sampling_ra=
te_setting =3D=3D val)<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; br=
eak;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none=
'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp; return sprintf(buf, &quot;%s\n&quot;, lsm303d=
lhc_acc_odr_table[i].hz_label);<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+}<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMso=
Normal style=3D'text-autospace:none'><span style=3D'font-family:"Courier Ne=
w"'>+static ssize_t lsm303dlhc_acc_store_sampling_frequency(struct device *=
dev,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none=
'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 struct device_attribute *attr,<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; const char *buf, size_t size)<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+{<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbs=
p;&nbsp; struct iio_dev *indio_dev =3D dev_get_drvdata(dev);<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; struct lsm303dlhc_acc_data *da=
ta =3D indio_dev-&gt;dev_data;<o:p></o:p></span></p><p class=3DMsoNormal st=
yle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbs=
p;&nbsp;&nbsp; u8 found =3D 0;<o:p></o:p></span></p><p class=3DMsoNormal st=
yle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbs=
p;&nbsp;&nbsp; u8 i;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&n=
bsp; u8 ret;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; ARRAY_SIZE(lsm30=
3dlhc_acc_odr_table); i++) {<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (strcmp(buf, lsm303dlhc=
_acc_odr_table[i].hz_label) =3D=3D 0) {<o:p></o:p></span></p><p class=3DMso=
Normal style=3D'text-autospace:none'><span style=3D'font-family:"Courier Ne=
w"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; found =3D 1;<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; break;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nb=
sp;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (!found) {<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; dev_err(dev, &quot;trying to set invalid sampling frequency: %s\n&quot;<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; &quot;new sampling frequency not set!\n&quot;, buf);<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; return&nbsp; -EINVAL;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp=
;&nbsp; } else {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;data-&gt;lock);<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; ret =3D lsm303dlhc_acc_update_sampling_freq(data,<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lsm303dlhc_acc_odr_table[i].sampling=
_rate_setting);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; goto error;<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;pdata-&=
gt;sampling_frequency =3D<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; lsm303dlhc_acc_odr_table[i].sampling_rate_setting;<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d=
ev_info(dev, &quot;set new sampling frequency: %s Hz\n&quot;,<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; lsm303dlhc_acc_odr_table[i].hz_label);<o:p></o:=
p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; mutex_unlock(&amp;data-&gt;lock);<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nb=
sp;&nbsp;&nbsp; return size;<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+error:=
<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><s=
pan style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; mutex_unlock(&a=
mp;data-&gt;lock);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbs=
p; return ret;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+}<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+static IIO_D=
EV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lsm303dlhc_acc_sho=
w_sampling_frequency,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lsm303dlhc_acc_store_sampling_fre=
quency);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+static ssize_t lsm303dlhc_acc_show_enable(struct device *dev=
,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><=
span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; struct device_attribute *attr, char *buf)<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+{<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;=
&nbsp; struct iio_dev *indio_dev =3D dev_get_drvdata(dev);<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; struct lsm303dlhc_acc_data *data=
 =3D indio_dev-&gt;dev_data;<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;=
&nbsp;&nbsp; int val =3D atomic_read(&amp;data-&gt;enabled);<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; return sprintf(buf, &quot;%d\n=
&quot;, val);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+}<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+static ssize_=
t lsm303dlhc_acc_store_enable(struct device *dev,<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device=
_attribute *attr,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *buf, size_t size)<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+{<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp; struct iio_dev *indio_dev =3D dev_get_drvdata(dev);<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; struct lsm303dlhc_acc_data =
*data =3D indio_dev-&gt;dev_data;<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&=
nbsp;&nbsp;&nbsp; unsigned long val;<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (kstrtoul(=
buf, 10, &amp;val))<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&=
nbsp; if (val)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lsm303dlhc_acc_enable(data);<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; else<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ls=
m303dlhc_acc_disable(data);<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; return size;<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+}<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+static IIO_DEVICE_ATTR(enable_devic=
e,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S_IWUSR | S_IRUGO,<o:p=
></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lsm303dlhc_acc_show_enable,<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lsm303dlhc_acc_store_enab=
le,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0);<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+static int =
lsm303dlhc_acc_show_channel_rawdata(struct device *dev,<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_=
attribute *attr,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; char *buf)<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+{<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; struct iio_dev *=
indio_dev =3D dev_get_drvdata(dev);<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+&nbsp;&nbsp;&nbsp; struct lsm303dlhc_acc_data *data =3D indio_dev-&gt;dev_=
data;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; struct iio=
_dev_attr *this_attr =3D to_iio_dev_attr(attr);<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+&nbsp;&nbsp;&nbsp; int err;<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; /* Data b=
ytes from hardware (AxL, AxH) or (AyL, AyH) or (AzL, AzH) */<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; u8 out_data[2];<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; /* x,y,z hardware data */<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; s16 raw_d;<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp; out_data[0] =3D this_attr-&gt;address;<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&=
nbsp; mutex_lock(&amp;data-&gt;lock);<o:p></o:p></span></p><p class=3DMsoNo=
rmal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"=
'>+&nbsp;&nbsp;&nbsp; err =3D lsm303dlhc_acc_i2c_read(data, out_data, 2);<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; mutex_unlock(&amp=
;data-&gt;lock);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;=
 if (err &lt; 0) {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(dev, &quot;error reading out=
put registers\n&quot;);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DM=
soNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier =
New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:n=
one'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; raw_d =
=3D (((s16) ((out_data[1]) &lt;&lt; 8) | out_data[0]) &gt;&gt; 4);<o:p></o:=
p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; return sprintf(buf, &quo=
t;%d\n&quot;, raw_d);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+}<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+static IIO_DEV_ATTR_ACCEL_X(lsm303dlhc_=
acc_show_channel_rawdata, OUT_X_LSB);<o:p></o:p></span></p><p class=3DMsoNo=
rmal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"=
'>+static IIO_DEV_ATTR_ACCEL_Y(lsm303dlhc_acc_show_channel_rawdata, OUT_Y_L=
SB);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none=
'><span style=3D'font-family:"Courier New"'>+static IIO_DEV_ATTR_ACCEL_Z(ls=
m303dlhc_acc_show_channel_rawdata, OUT_Z_LSB);<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+static ssize_t lsm303d=
lhc_acc_show_range(struct device *dev,<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; struct device_attribute *attr,<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; char *buf)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+{<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+&nbsp;&nbsp;&nbsp; struct iio_dev *indio_dev =3D dev_ge=
t_drvdata(dev);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; =
struct lsm303dlhc_acc_data *data =3D indio_dev-&gt;dev_data;<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; int label =3D 0;<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; u8 val;<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+&nbsp;&nbsp;&nbsp; mutex_lock(&amp;data-&gt;lock);<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; val =3D data-&gt;pdat=
a-&gt;g_range;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; s=
witch (val) {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; ca=
se LSM303DLHC_ACC_G_2G:<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; label =3D 2;<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; break;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; case LS=
M303DLHC_ACC_G_4G:<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; label =3D 4;<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bre=
ak;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; case LSM303D=
LHC_ACC_G_8G:<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; label =3D 8;<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; case LSM303DLHC_A=
CC_G_16G:<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; label =3D 16;<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;data-&gt;lock)=
;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><=
span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; return sprintf=
(buf, &quot;%d mg\n&quot;, label);<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+=
}<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><=
span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3D=
MsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier=
 New"'>+static ssize_t lsm303dlhc_acc_store_range(struct device *dev,<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; struct device_attribute *attr,<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; const char *buf,<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; size_t size)<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+{<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;=
 struct iio_dev *indio_dev =3D dev_get_drvdata(dev);<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+&nbsp;&nbsp;&nbsp; struct lsm303dlhc_acc_data *data =3D i=
ndio_dev-&gt;dev_data;<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;=
&nbsp; unsigned long val;<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp; u8 range;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&=
nbsp; int err =3D -1;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&=
nbsp; if (kstrtoul(buf, 10, &amp;val)) {<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(dev, &=
quot;invalid range %lu\n. Range not changed&quot;, val);<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; return -EINVAL;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp=
; }<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; switch (val)=
 {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; case 2:<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; range =3D LSM303DLHC_ACC_G_2G;<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; case 4:<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; range =3D LSM303DLHC_ACC_G_4G;<o:p></o:p></span></p><p class=3D=
MsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier=
 New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; case 8:<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; range =3D LSM303DLHC_ACC_G_8G;<o:p></o:p></span></p><p class=3DMsoNo=
rmal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"=
'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; case 16:<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; range =3D LSM303DLHC_ACC_G_16G;<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; default:<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; dev_err(dev, &quot;invalid range %lu. Range not changed\n&quot;, val);<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return -EINVAL;<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&=
nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; mutex_lock(&amp;data-&gt;lock)=
;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><=
span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; data-&gt;pdata=
-&gt;g_range =3D range;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp=
;&nbsp; err =3D lsm303dlhc_acc_update_fs_range(data, range);<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;data-&gt;loc=
k);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (err &lt;=
 0)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;=
&nbsp;&nbsp; goto error;<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbs=
p;&nbsp; dev_info(dev, &quot;set range to %lu mG\n&quot;, val);<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; return size;<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+error:<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp; dev_err(dev, &quot;error changing range\n&quot;);<o:p></o:=
p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; return err;<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+}<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+static IIO_DEVICE_ATTR(accel_ran=
ge,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S_IWUSR | S_IRUGO,<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lsm303dlhc_acc_show_range,<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lsm303dlhc_acc_store_rang=
e,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0);<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+static IIO_CONST_ATTR(accel_range_available, &=
quot;2 4 8 16&quot;);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+static=
 ssize_t lsm303dlhc_acc_show_gain(struct device *dev,<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute *=
attr,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; char *buf)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+{<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+&nbsp;&nbsp;&nbsp; struct iio_dev *indio_dev =3D dev_ge=
t_drvdata(dev);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; =
struct lsm303dlhc_acc_data *data =3D indio_dev-&gt;dev_data;<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; return sprintf(buf, &quot;%s\n=
&quot;, data-&gt;gain);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+}<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+st=
atic IIO_DEVICE_ATTR(accel_gain, S_IRUGO,<o:p></o:p></span></p><p class=3DM=
soNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; lsm303dlhc_acc_show_gain,<o:p></o:p></span></p><p class=3D=
MsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier=
 New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; NULL , 0);<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+static ssize_t lsm303dlhc_acc_show_scale(struct device *dev,<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; char *buf)<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+{<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; struct iio_de=
v *indio_dev =3D dev_get_drvdata(dev);<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+&nbsp;&nbsp;&nbsp; struct lsm303dlhc_acc_data *data =3D indio_dev-&gt;d=
ev_data;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; return =
sprintf(buf, &quot;%s\n&quot;, data-&gt;scale);<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+}<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+static IIO_DEVICE_ATTR(accel_scale, S_IRUGO,<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lsm303dlhc_acc_show_scale,<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL , 0);<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+static IIO_CON=
ST_ATTR_SAMP_FREQ_AVAIL(&quot;1 10 25 50 100 200 400 1350&quot;);<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+static IIO_CONST_ATTR(name, LSM303DL=
HC_ACC_DEV_NAME);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+static struct attribute *lsm303dlhc_acc_att=
ributes[] =3D {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; =
&amp;iio_const_attr_name.dev_attr.attr,<o:p></o:p></span></p><p class=3DMso=
Normal style=3D'text-autospace:none'><span style=3D'font-family:"Courier Ne=
w"'>+&nbsp;&nbsp;&nbsp; &amp;iio_dev_attr_enable_device.dev_attr.attr,<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; &amp;iio_const_attr_=
accel_range_available.dev_attr.attr,<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+&nbsp;&nbsp;&nbsp; &amp;iio_dev_attr_accel_range.dev_attr.attr,<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; &amp;iio_dev_attr_accel_=
gain.dev_attr.attr,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nb=
sp; &amp;iio_dev_attr_accel_scale.dev_attr.attr,<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+&nbsp;&nbsp;&nbsp; &amp;iio_dev_attr_accel_x_raw.dev_attr.att=
r,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; &amp;iio_dev_=
attr_accel_y_raw.dev_attr.attr,<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nb=
sp;&nbsp;&nbsp; &amp;iio_dev_attr_accel_z_raw.dev_attr.attr,<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; &amp;iio_dev_attr_sampling_fre=
quency.dev_attr.attr,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&=
nbsp; &amp;iio_const_attr_sampling_frequency_available.dev_attr.attr,<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; NULL<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+};<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+static const struct attribute_group lsm30=
3dlhc_acc_attribute_group =3D {<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nb=
sp;&nbsp;&nbsp; .attrs =3D lsm303dlhc_acc_attributes,<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+};<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+static int lsm303dlhc_acc_probe(struct i2c_clie=
nt *client,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct i2c_device_id *id)<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+{<o:p></o:p></span></p><p class=3DMsoNormal st=
yle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbs=
p;&nbsp;&nbsp; struct lsm303dlhc_acc_data *data;<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+&nbsp;&nbsp;&nbsp; int err =3D -1;<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; d=
ata =3D kzalloc(sizeof(struct lsm303dlhc_acc_data), GFP_KERNEL);<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (data =3D=3D NULL) {<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; err =3D -ENOMEM;<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(&amp;clien=
t-&gt;dev,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospac=
e:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &quot;failed to allocate memory for module data: &quot;<o:p=
></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%d\n&quot;, err);<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; goto exit_check_functionality_failed;<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; u32 smbus_func =3D=
 I2C_FUNC_SMBUS_BYTE_DATA |<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2C_FUNC_SMBUS_WORD_DATA | I2C_FUNC_SMBUS_=
I2C_BLOCK;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospac=
e:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; int r=
egdone =3D 0;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+&nbsp;&nbsp;&nbsp; pr_info(&quot;%s: probe start.\n&quo=
t;, LSM303DLHC_ACC_DEV_NAME);<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+&nbsp;&nbsp;&nbsp; /* Support for both I2C and SMBUS adapter interfaces. =
*/<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (!i2c_chec=
k_functionality(client-&gt;adapter, I2C_FUNC_I2C)) {<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; de=
v_warn(&amp;client-&gt;dev, &quot;client not i2c capable\n&quot;);<o:p></o:=
p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; if (i2c_check_functionality(client-&gt;adapter, smbus_func)) {<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;use_smbus =3D 1;=
<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><s=
pan style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(&amp;client-&gt=
;dev, &quot;client using SMBUS\n&quot;);<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<o:p><=
/o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span st=
yle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D -ENODEV;<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(&amp;client-&gt;dev, &quot;cli=
ent nor SMBUS capable\n&quot;);<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; data-&gt;use_smbus =3D 0;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; goto exit_check_functionality_failed;<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o=
:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span styl=
e=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nb=
sp; mutex_init(&amp;data-&gt;lock);<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+&nbsp;&nbsp;&nbsp; mutex_lock(&amp;data-&gt;lock);<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+&nbsp;&nbsp;&nbsp; data-&gt;client =3D client;<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; i2c_set_clientdata(client, =
data);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+&nbsp;&nbsp;&nbsp; data-&gt;pdata =3D kmalloc(sizeof(*data-&gt=
;pdata), GFP_KERNEL);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&=
nbsp; if (data-&gt;pdata =3D=3D NULL) {<o:p></o:p></span></p><p class=3DMso=
Normal style=3D'text-autospace:none'><span style=3D'font-family:"Courier Ne=
w"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D -ENOMEM=
;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><=
span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_err(&amp;client-&gt;dev,<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;failed to all=
ocate memory for pdata: %d\n&quot;,<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err);<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err=
_mutexunlock;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; }<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+&nbsp;&nbsp;&nbsp; if (client-&gt;dev.platform_data =3D=3D NULL) {<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; memcpy(data-&gt;pdata, &amp;default_lsm303dlhc_acc_pdata,=
<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><s=
pan style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(*data-&gt;pdata));<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; de=
v_info(&amp;client-&gt;dev, &quot;using default platform data\n&quot;);<o:p=
></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; } else {<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; memcpy(data-&gt;pdata, client-&gt;dev.platform_data,<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; sizeof(*data-&gt;pdata));<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; err =3D lsm303dlhc=
_acc_validate_pdata(data);<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp; if (err &lt; 0) {<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(&amp;client-&gt;d=
ev, &quot;failed to validate platform data\n&quot;);<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; go=
to exit_kfree_pdata;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&n=
bsp; }<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if=
 (data-&gt;pdata-&gt;init) {<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D data-&gt;pdata-&gt=
;init();<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err &lt; 0) {<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_err(&amp;client-&gt;dev, &quot;init failed: %d\n&=
quot;, err);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_pda=
ta_init;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal st=
yle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbs=
p;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+&nbsp;&nbsp;&nbsp; memset(data-&gt;resume_state, 0, =
ARRAY_SIZE(data-&gt;resume_state));<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><=
span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; data-&gt;resum=
e_state[RES_CTRL_REG1] =3D (ALL_ZEROES |<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; LSM303DLHC_ACC_ENABLE_ALL_AXES);<o:p></o:p></span></p><p class=3DMso=
Normal style=3D'text-autospace:none'><span style=3D'font-family:"Courier Ne=
w"'>+&nbsp;&nbsp;&nbsp; data-&gt;resume_state[RES_CTRL_REG4] =3D (ALL_ZEROE=
S | CTRL_REG4_BDU_ENABLE);<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+=
&nbsp;&nbsp;&nbsp; err =3D lsm303dlhc_acc_device_power_on(data);<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (err &lt; 0) {<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; dev_err(&amp;client-&gt;dev, &quot;power on failed: %d\n&quot=
;, err);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:=
none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; goto exit_kfree_pdata;<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNo=
rmal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"=
'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; atomic_set(&=
amp;data-&gt;enabled, 1);<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; err =3D lsm303dlhc_acc=
_update_fs_range(data, data-&gt;pdata-&gt;g_range);<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (err &lt; 0) {<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d=
ev_err(&amp;client-&gt;dev, &quot;update_g_range failed\n&quot;);<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; goto&nbsp; err_power_off;<o:p></o:p></span></p><p class=3DMsoNo=
rmal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"=
'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; err =3D lsm303dlhc_acc_u=
pdate_sampling_freq(data,<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&=
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
:"Courier New"'>+&nbsp;&nbsp;&nbsp; data-&gt;indio_dev =3D iio_allocate_dev=
ice();<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (!data=
-&gt;indio_dev) {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D -ENOMEM;<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
dev_err(&amp;client-&gt;dev, &quot;error allocating iio device: %d\n&quot;,=
 err);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; goto err_power_off;<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp; data-&gt;indio_dev-&gt;attrs =3D &amp;lsm303dlhc_acc_attri=
bute_group;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; data=
-&gt;indio_dev-&gt;dev.parent =3D &amp;client-&gt;dev;<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+&nbsp;&nbsp;&nbsp; data-&gt;indio_dev-&gt;dev_data =3D =
(void *)(data);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; =
data-&gt;indio_dev-&gt;driver_module =3D THIS_MODULE;<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+&nbsp;&nbsp;&nbsp; data-&gt;indio_dev-&gt;modes =3D INDI=
O_DIRECT_MODE;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+&nbsp;&nbsp;&nbsp; lsm303dlhc_acc_device_power_off(dat=
a);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; /* As defaul=
t, do not report information */<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nb=
sp;&nbsp;&nbsp; atomic_set(&amp;data-&gt;enabled, 0);<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nb=
sp; err =3D lsm303dlhc_acc_configure_ring(data-&gt;indio_dev);<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (err)<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 goto error_free_dev;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; err =3D iio_device_register(=
data-&gt;indio_dev);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&n=
bsp; if (err) {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(&amp;client-&gt;dev, &quot;erro=
r registering iio dev: %d\n&quot;, err);<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_unr=
eg_ring_funcs;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; }=
<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><s=
pan style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; regdone =3D 1;<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+&nbsp;&nbsp;&nbsp; err =3D lsm303dlhc_acc_initialize_ring(data-&gt;in=
dio_dev-&gt;ring);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbs=
p; if (err) {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autos=
pace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(&amp;client-&gt;dev, &quot;failed=
 to initialize the ring\n&quot;);<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_unreg_ring=
_funcs;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:n=
one'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; }<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+=
&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;data-&gt;lock);<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+&nbsp;&nbsp;&nbsp; dev_info(&amp;client-&gt;dev, &quot;%s=
: probed\n&quot;, LSM303DLHC_ACC_DEV_NAME);<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></span></p><p class=3DMso=
Normal style=3D'text-autospace:none'><span style=3D'font-family:"Courier Ne=
w"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+error_unreg_ring_funcs=
:<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><=
span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; lsm303dlhc_acc=
_unconfigure_ring(data-&gt;indio_dev);<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+error_free_dev:<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nb=
sp; if (regdone)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iio_device_unregister(data-&gt;indio_d=
ev);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none=
'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; else<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; iio_free_device(data-&gt;indio_dev);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+err_power_off:<o:p></o:p></span></p><p class=3DMsoNormal st=
yle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbs=
p;&nbsp;&nbsp; lsm303dlhc_acc_device_power_off(data);<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+err_pdata_init:<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+=
&nbsp;&nbsp;&nbsp; if (data-&gt;pdata-&gt;exit)<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&g=
t;pdata-&gt;exit();<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+exit_kfree_pdat=
a:<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; kfree(data-&g=
t;pdata);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+err_mutexunlock:<o:p></o:=
p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;data-&=
gt;lock);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; kfree(=
data);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+exit_check_functionality_fai=
led:<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none=
'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; printk(KERN=
_ERR &quot;%s: Driver Init failed\n&quot;, LSM303DLHC_ACC_DEV_NAME);<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; return err;<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+}<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+static int __devexit lsm303dlhc_acc=
_remove(struct i2c_client *client)<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+=
{<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><=
span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3D=
MsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier=
 New"'>+&nbsp;&nbsp;&nbsp; struct lsm303dlhc_acc_data *data =3D i2c_get_cli=
entdata(client);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-au=
tospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+&nbsp;&nbsp;&nbsp; lsm303dlhc_acc_device_power_off(d=
ata);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+&nbsp;&nbsp;&nbsp; lsm303dlhc_acc_uninitialize_ring(data-&gt;in=
dio_dev-&gt;ring);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbs=
p; iio_device_unregister(data-&gt;indio_dev);<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp; lsm303dlhc_acc_unconfigure_ring(data-&gt;indi=
o_dev);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:n=
one'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+&nbsp;&nbsp;&nbsp; if (data-&gt;pdata-&gt;exit)<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; data-&gt;pdata-&gt;exit();<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&=
nbsp;&nbsp;&nbsp; kfree(data-&gt;pdata);<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+&nbsp;&nbsp;&nbsp; kfree(data);<o:p></o:p></span></p><p class=3DMsoNo=
rmal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"=
'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; return 0;<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+}<o:p></o:p></span></p><p class=3DMso=
Normal style=3D'text-autospace:none'><span style=3D'font-family:"Courier Ne=
w"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+static const struct i2c_devic=
e_id lsm303dlhc_acc_id[]<o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D { { LSM303DLHC_ACC_DEV_NAM=
E, 0 }, { }, };<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+MODULE_DEVICE_TABLE(i2c, lsm303dlhc_acc_id);<o:p></o:=
p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+st=
atic struct i2c_driver lsm303dlhc_acc_driver =3D {<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+&nbsp;&nbsp;&nbsp; .driver =3D {<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; .owner =3D THIS_MODULE,<o:p></o:p></span></p><p cla=
ss=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Co=
urier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; .name =3D LSM303DLHC_ACC_DEV_NAME,<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; &nbsp; },<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; .pr=
obe =3D lsm303dlhc_acc_probe,<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp=
;&nbsp;&nbsp; .remove =3D __devexit_p(lsm303dlhc_acc_remove),<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; .id_table =3D lsm303dlhc_acc_=
id,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+};<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+static int __init lsm3=
03dlhc_acc_init(void)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+{<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; printk(KERN_INFO &quot;%s a=
ccelerometer iio driver: init\n&quot;,<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LSM303DLHC_ACC_DEV_NAME);<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; return i2c_add_driver(&amp;lsm=
303dlhc_acc_driver);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+}<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+static=
 void __exit lsm303dlhc_acc_exit(void)<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+{<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; pr_info(&q=
uot;%s exit\n&quot;, LSM303DLHC_ACC_DEV_NAME);<o:p></o:p></span></p><p clas=
s=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cou=
rier New"'>+&nbsp;&nbsp;&nbsp; i2c_del_driver(&amp;lsm303dlhc_acc_driver);<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; return;<o:p></o:=
p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+}<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+module_init(lsm303dlhc_acc_init);<o=
:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><spa=
n style=3D'font-family:"Courier New"'>+module_exit(lsm303dlhc_acc_exit);<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+MODULE_DESCRIPTION(&quot;STMicroelectronics lsm303dlhc iio driver for t=
he accelerometer section&quot;);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+MO=
DULE_AUTHOR(&quot;Matteo Dameno, STMicroelectronics&quot;);<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+MODULE_LICENSE(&quot;GPL v2&quot;);<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>diff --git a/drivers/staging/iio/accel/lsm303dlhc_=
acc_trigger.c b/drivers/staging/iio/accel/lsm303dlhc_acc_trigger.c<o:p></o:=
p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>index e69de29..62cb7e0 100644<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>--- a/drivers/staging/iio/accel/lsm303dlhc_acc_tri=
gger.c<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+++ b/drivers/staging/iio/acc=
el/lsm303dlhc_acc_trigger.c<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>@@ -0,0 =
+1,115 @@<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+#include &lt;linux/interr=
upt.h&gt;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace=
:none'><span style=3D'font-family:"Courier New"'>+#include &lt;linux/irq.h&=
gt;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+#include &lt;linux/mutex.h&gt;<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+#include &lt;linux/device.h&gt;<o:p=
></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"Courier New"'>+#include &lt;linux/kernel.h&gt;<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+#include &lt;linux/sysfs.h&gt;<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+#include &lt;linux/list.h&gt;<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+#include &lt;linux/spi/spi.h&gt;<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+#includ=
e &quot;../iio.h&quot;<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+#include &qu=
ot;../sysfs.h&quot;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+#include &quot;=
../trigger.h&quot;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+#include &quot;.=
./magnetometer/lsm303dlhc.h&quot;<o:p></o:p></span></p><p class=3DMsoNormal=
 style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:no=
ne'><span style=3D'font-family:"Courier New"'>+static int lsm303dlhc_acc_da=
ta_rdy_trig_poll(struct iio_dev *dev_info,<o:p></o:p></span></p><p class=3D=
MsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier=
 New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; int index,<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; s64 timestamp,<o:p></o:p></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family=
:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; int no_test)<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+{<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;=
&nbsp; struct lsm303dlhc_acc_data *data =3D iio_dev_get_devdata(dev_info);<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; struct iio_trigg=
er *trig =3D data-&gt;trig;<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span sty=
le=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; trig-&gt;timestamp =3D=
 timestamp;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospa=
ce:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; iio_=
trigger_poll(trig);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nb=
sp; return IRQ_HANDLED;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+}<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+II=
O_EVENT_SH(data_rdy_trig, &amp;lsm303dlhc_acc_data_rdy_trig_poll);<o:p></o:=
p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+st=
atic DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=
=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+static =
struct attribute *lsm303dlhc_acc_trigger_attrs[] =3D {<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+&nbsp;&nbsp;&nbsp; &amp;dev_attr_name.attr,<o:p></o:p><=
/span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D=
'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; NULL,<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+};<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+static const struct attribute_group lsm303dlhc_=
acc_trigger_attr_group =3D {<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;=
&nbsp;&nbsp; .attrs =3D lsm303dlhc_acc_trigger_attrs,<o:p></o:p></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fami=
ly:"Courier New"'>+};<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'=
font-family:"Courier New"'>+static int lsm303dlhc_acc_data_rdy_trigger_set_=
state(struct iio_trigger *trig,<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; bool state)<o:p></o:p></span></p><p class=3DMsoNormal st=
yle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+{<o:=
p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span=
 style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; struct lsm303dlhc_=
acc_data *data =3D trig-&gt;private_data;<o:p></o:p></span></p><p class=3DM=
soNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier =
New"'>+&nbsp;&nbsp;&nbsp; struct iio_dev *indio_dev =3D data-&gt;indio_dev;=
<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><s=
pan style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; int ret =3D 0;<=
o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><sp=
an style=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+&nbsp;&nbsp;&nbsp; dev_dbg(&amp;indio_dev-&gt;dev, &quot;%s (%d)\n&qu=
ot;, __func__, state);<o:p></o:p></span></p><p class=3DMsoNormal style=3D't=
ext-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;=
&nbsp; ret =3D lsm303dlhc_acc_set_irq(&amp;data-&gt;indio_dev-&gt;dev, stat=
e);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (state =
=3D=3D false) {<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iio_remove_event_from_list(&amp;iio_eve=
nt_data_rdy_trig,<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &am=
p;indio_dev-&gt;interrupts[0]<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbs=
p;&nbsp; -&gt;ev_list);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flush_scheduled_work();<o:p></o=
:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span styl=
e=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; } else {<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; iio_add_event_to_list(&amp;iio_event_data_rdy_trig,<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-=
family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; &amp;indio_dev-&gt;interrupts[0]-&gt;ev_list);<o:p></o:p=
></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></span></p><p cl=
ass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"C=
ourier New"'>+}<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+static int lsm303dlhc_acc_trig_try_reen(struct iio_tr=
igger *trig)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autosp=
ace:none'><span style=3D'font-family:"Courier New"'>+{<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+&nbsp;&nbsp;&nbsp; struct lsm303dlhc_acc_data *data =3D=
 trig-&gt;private_data;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp=
;&nbsp; enable_irq(data-&gt;irq1);<o:p></o:p></span></p><p class=3DMsoNorma=
l style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+=
&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+}<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNor=
mal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'=
>+int lsm303dlhc_acc_probe_trigger(struct iio_dev *indio_dev)<o:p></o:p></s=
pan></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'f=
ont-family:"Courier New"'>+{<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;=
&nbsp;&nbsp; int ret;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'te=
xt-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&=
nbsp; struct lsm303dlhc_acc_data *data =3D indio_dev-&gt;dev_data;<o:p></o:=
p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&n=
bsp;&nbsp;&nbsp; data-&gt;trig =3D iio_allocate_trigger();<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; data-&gt;trig-&gt;name =3D kmall=
oc(IIO_TRIGGER_NAME_LENGTH, GFP_KERNEL);<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+&nbsp;&nbsp;&nbsp; if (!data-&gt;trig-&gt;name) {<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 ret =3D -ENOMEM;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_free_trig;<o:p></o:p></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fon=
t-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp; snprintf((char *)data-&gt;trig-&gt;name,<o:p>=
</o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span s=
tyle=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; IIO_TRIGGER_NAME_LENGTH,<o:p></o:p></span></p><p class=3DMs=
oNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier N=
ew"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;lsm303dl=
hc_acc-dev%d&quot;, indio_dev-&gt;id);<o:p></o:p></span></p><p class=3DMsoN=
ormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier New=
"'>+&nbsp;&nbsp;&nbsp; data-&gt;trig-&gt;dev.parent =3D &amp;st-&gt;us-&gt;=
dev;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none=
'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; data-&gt;tr=
ig-&gt;owner =3D THIS_MODULE;<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp=
;&nbsp;&nbsp; data-&gt;trig-&gt;private_data =3D data;<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fam=
ily:"Courier New"'>+&nbsp;&nbsp;&nbsp; data-&gt;trig-&gt;set_trigger_state =
=3D<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'=
><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; &amp;lsm303dlhc_acc_data_rdy_trigger_set_state;<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+&nbsp;&nbsp;&nbsp; data-&gt;trig-&gt;try_reenable =3D=
 &amp;lsm303dlhc_acc_trig_try_reen;<o:p></o:p></span></p><p class=3DMsoNorm=
al style=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>=
+&nbsp;&nbsp;&nbsp; data-&gt;trig-&gt;control_attrs =3D &amp;lsm303dlhc_acc=
_trigger_attr_group;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&n=
bsp; ret =3D iio_trigger_register(data-&gt;trig);<o:p></o:p></span></p><p c=
lass=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"=
Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-aut=
ospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; =
/* select default trigger */<o:p></o:p></span></p><p class=3DMsoNormal styl=
e=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nbsp;=
&nbsp;&nbsp; indio_dev-&gt;trig =3D data-&gt;trig;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:=
"Courier New"'>+&nbsp;&nbsp;&nbsp; if (ret)<o:p></o:p></span></p><p class=
=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Cour=
ier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto erro=
r_free_trig_name;<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-a=
utospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font=
-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-famil=
y:"Courier New"'>+<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+error_free_trig_=
name:<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:non=
e'><span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; kfree(data=
-&gt;trig-&gt;name);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'tex=
t-autospace:none'><span style=3D'font-family:"Courier New"'>+error_free_tri=
g:<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'>=
<span style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; iio_free_trig=
ger(data-&gt;trig);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text=
-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>+}<o:p></o:p></span></p><p class=3DMsoNormal style=3D'=
text-autospace:none'><span style=3D'font-family:"Courier New"'>+<o:p></o:p>=
</span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=
=3D'font-family:"Courier New"'>+void lsm303dlhc_acc_remove_trigger(struct i=
io_dev *indio_dev)<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-=
autospace:none'><span style=3D'font-family:"Courier New"'>+{<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'fo=
nt-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; struct lsm303dlhc_acc_data *st=
ate =3D indio_dev-&gt;dev_data;<o:p></o:p></span></p><p class=3DMsoNormal s=
tyle=3D'text-autospace:none'><span style=3D'font-family:"Courier New"'>+&nb=
sp;&nbsp;&nbsp; iio_trigger_unregister(state-&gt;trig);<o:p></o:p></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-fa=
mily:"Courier New"'>+&nbsp;&nbsp;&nbsp; kfree(state-&gt;trig-&gt;name);<o:p=
></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; iio_free_trigger(st=
ate-&gt;trig);<o:p></o:p></span></p><p class=3DMsoNormal style=3D'text-auto=
space:none'><span style=3D'font-family:"Courier New"'>+}<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-f=
amily:"Courier New"'>-- <o:p></o:p></span></p><p class=3DMsoNormal style=3D=
'text-autospace:none'><span style=3D'font-family:"Courier New"'>1.7.5.4<o:p=
></o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"Courier New"'><o:p>&nbsp;</o:p></span></p><p class=3D=
MsoNormal style=3D'text-autospace:none'><span style=3D'font-family:"Courier=
 New"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal>P.S.:<span style=3D=
'color:#1F497D'> </span>We are working on the driver to make it compatible =
for the latest mainline kernel. <span style=3D'color:#1F497D'><o:p></o:p></=
span></p><p class=3DMsoNormal><span style=3D'color:#1F497D'>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 </span><span style=3D'color:#1F497D'><o:p></o:p></span></p></div></body></=
html>=

--_000_494E38452A01E745B763C5F242AAA2CCC50EDD9ADBSAFEX1MAIL1st_--
