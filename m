Return-Path: <jic23@kernel.org>
Message-ID: <502D4243.1020602@kernel.org>
Date: Thu, 16 Aug 2012 19:56:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Swapnil TIWARI <swapnil.tiwari@st.com>
CC: "jic23@cam.ac.uk" <jic23@cam.ac.uk>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Staging: iio: gyro: Add STMicroelectronics L3GD20 gyroscope
 device driver for Kernel version 2.6.35.13
References: <494E38452A01E745B763C5F242AAA2CCC50EDD9B5C@SAFEX1MAIL1.st.com>
In-Reply-To: <494E38452A01E745B763C5F242AAA2CCC50EDD9B5C@SAFEX1MAIL1.st.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 08/16/2012 03:02 AM, Swapnil TIWARI wrote:
> Add STMicroelectronics L3GD20 gyroscope device driver for Kernel version 2.6.35.13
>
ah, I didn't see the comment at the bottom about moving to the latest kernel
until I'd written a mini rant saying that we would only look at it properly
once it works with the latest kernel.

Also note that it will want to go directly into drivers/iio/gyro/ now.

Interfaces etc have changed a lot in the last 2 years so I'll hold off taking
a look until you have it up to date.  Good to have this email to know that
it is a work in progress though!

Thanks

Jonathan
>
>
> Signed-off-by: Swapnil Tiwari <swapnil.tiwari@st.com>
>
>
>
> ---
>
> drivers/staging/iio/gyro/Kconfig           |    8 +
>
> drivers/staging/iio/gyro/Makefile          |    2 +
>
> drivers/staging/iio/gyro/l3gd20.h          |  155 ++++
>
> drivers/staging/iio/gyro/l3gd20_gyr_core.c | 1056 ++++++++++++++++++++++++++++
>
> 4 files changed, 1221 insertions(+), 0 deletions(-)
>
>
>
> diff --git a/drivers/staging/iio/gyro/Kconfig b/drivers/staging/iio/gyro/Kconfig
>
> index 7e0b7f1..af2e423 100644
>
> --- a/drivers/staging/iio/gyro/Kconfig
>
> +++ b/drivers/staging/iio/gyro/Kconfig
>
> @@ -12,3 +12,11 @@ config ADIS16260
>
>       Say yes here to build support for Analog Devices adis16260/5
>
>       programmable digital gyroscope sensor.
>
> +config L3GD20_GYR_IIO
>
> +       tristate "STM L3GD20 3 Axis Digital Gyroscope Sensor I2C driver (iio)"
>
> +       depends on I2C
>
> +       help
>
> +          Say yes here to build support for the STMicrolectronics L3GD20 3 Axis
>
> +          Digital .
>
> +          To compile this driver as a module, choose M here: the module
>
> +          will be called l3gd20_gyr_iio.
>
> diff --git a/drivers/staging/iio/gyro/Makefile b/drivers/staging/iio/gyro/Makefile
>
> index a3a28ed..28f530b 100644
>
> --- a/drivers/staging/iio/gyro/Makefile
>
> +++ b/drivers/staging/iio/gyro/Makefile
>
> @@ -6,3 +6,5 @@ adis16260-y             := adis16260_core.o
>
> adis16260-$(CONFIG_IIO_RING_BUFFER) += adis16260_ring.o adis16260_trigger.o
>
> obj-$(CONFIG_ADIS16260) += adis16260.o
>
> +l3gd20_gyr-y    := l3gd20_gyr_core.o
>
> +obj-$(CONFIG_L3GD20_GYR_IIO) += l3gd20_gyr.o
>
> diff --git a/drivers/staging/iio/gyro/l3gd20.h b/drivers/staging/iio/gyro/l3gd20.h
>
> index e69de29..d2a734a 100644
>
> --- a/drivers/staging/iio/gyro/l3gd20.h
>
> +++ b/drivers/staging/iio/gyro/l3gd20.h
>
> @@ -0,0 +1,155 @@
>
> +/******************** (C) COPYRIGHT 2011 STMicroelectronics ********************
>
> +*
>
> +* File Name    : l3gd20_iio.h
>
> +* Authors : MH - C&I BU - Application Team
>
> +*         : Matteo Dameno (matteo.dameno@st.com
>
> +*         : author is willing to be considered the contact
>
> +*         : and update points for the driver.
>
> +* Version : V.2.0.0
>
> +* Date         : 2011/Aug/16
>
> +* Description  : L3GD20 3 Axis Digital Gyroscope Sensor device driver iio
>
> +*         :
>
> +********************************************************************************
>
> +*
>
> +* This program is free software; you can redistribute it and/or modify
>
> +* it under the terms of the GNU General Public License version 2 as
>
> +* published by the Free Software Foundation.
>
> +*
>
> +* THE PRESENT SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES
>
> +* OR CONDITIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED, FOR THE SOLE
>
> +* PURPOSE TO SUPPORT YOUR APPLICATION DEVELOPMENT.
>
> +* AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY DIRECT,
>
> +* INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING FROM THE
>
> +* CONTENT OF SUCH SOFTWARE AND/OR THE USE MADE BY CUSTOMERS OF THE CODING
>
> +* INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
>
> +*
>
> +*******************************************************************************/
>
> +/*******************************************************************************
>
> +Version History.
>
> + Revision 2.0.0: 2012/Nov/16
>
> +  first ioo implementation;
>
> +*******************************************************************************/
>
> +
>
> +#ifndef __L3GD20_H__
>
> +#define __L3GD20_H__
>
> +
>
> +
>
> +#define L3GD20_GYR_DEV_NAME         "l3gd20_gyr_iio"
>
> +
>
> +#define L3GD20_GYR_FS_250DPS   0x00
>
> +#define L3GD20_GYR_FS_500DPS   0x10
>
> +#define L3GD20_GYR_FS_2000DPS  0x30
>
> +
>
> +#define L3GD20_GYR_ENABLED     1
>
> +#define L3GD20_GYR_DISABLED    0
>
> +
>
> +
>
> +#ifdef __KERNEL__
>
> +
>
> +/* to set gpios numb connected to gyro interrupt pins,
>
> + * the unused ones have to be set to -EINVAL
>
> + */
>
> +#define DEFAULT_INT1_GPIO      (-EINVAL)
>
> +#define DEFAULT_INT2_GPIO      (-EINVAL)
>
> +
>
> +#define SAD0L                  0x00
>
> +#define SAD0H                  0x01
>
> +#define L3GD20_GYR_I2C_SADROOT      0x35
>
> +#define L3GD20_GYR_I2C_SAD_L        ((L3GD20_GYR_I2C_SADROOT<<1)|SAD0L)
>
> +#define L3GD20_GYR_I2C_SAD_H        ((L3GD20_GYR_I2C_SADROOT<<1)|SAD0H)
>
> +
>
> +#define L3GD20_MIN_POLL_PERIOD_MS   2
>
> +
>
> +struct l3gd20_gyr_platform_data {
>
> +    int (*init)(void);
>
> +    void (*exit)(void);
>
> +    int (*power_on)(void);
>
> +    int (*power_off)(void);
>
> +    unsigned int poll_interval;
>
> +    unsigned int min_interval;
>
> +
>
> +    u8 fs_range;
>
> +    u8 sampling_frequency;
>
> +
>
> +    /* set gpio_int[1,2] either to the choosen gpio pin number or to -EINVAL
>
> +    * if leaved unconnected
>
> +    */
>
> +    int gpio_int1;
>
> +    int gpio_int2;       /* int for fifo */
>
> +
>
> +    /* axis mapping */
>
> +    u8 axis_map_x;
>
> +    u8 axis_map_y;
>
> +    u8 axis_map_z;
>
> +
>
> +    u8 negate_x;
>
> +    u8 negate_y;
>
> +    u8 negate_z;
>
> +};
>
> +
>
> +#ifdef CONFIG_IIO_RING_BUFFER
>
> +/* At the moment triggers are only used for ring buffer
>
> + * filling. This may change!
>
> + */
>
> +
>
> +enum l3gd20_gyr_scan {
>
> +    L3GD20_GYR_SCAN_GYR_X,
>
> +    L3GD20_GYR_SCAN_GYR_Y,
>
> +    L3GD20_GYR_SCAN_GYR_Z,
>
> +};
>
> +
>
> +void l3gd20_gyr_remove_trigger(struct iio_dev *indio_dev);
>
> +int l3gd20_gyr_probe_trigger(struct iio_dev *indio_dev);
>
> +
>
> +ssize_t l3gd20_gyr_read_data_from_ring(struct device *dev,
>
> +                          struct device_attribute *attr,
>
> +                          char *buf);
>
> +
>
> +
>
> +int l3gd20_gyr_configure_ring(struct iio_dev *indio_dev);
>
> +void l3gd20_gyr_unconfigure_ring(struct iio_dev *indio_dev);
>
> +
>
> +int l3gd20_gyr_initialize_ring(struct iio_ring_buffer *ring);
>
> +void l3gd20_gyr_uninitialize_ring(struct iio_ring_buffer *ring);
>
> +#else /* CONFIG_IIO_RING_BUFFER */
>
> +
>
> +static inline void l3gd20_gyr_remove_trigger(struct iio_dev *indio_dev)
>
> +{
>
> +}
>
> +
>
> +static inline int l3gd20_gyr_probe_trigger(struct iio_dev *indio_dev)
>
> +{
>
> +    return 0;
>
> +}
>
> +
>
> +static inline ssize_t
>
> +l3gd20_gyr_read_data_from_ring(struct device *dev,
>
> +                     struct device_attribute *attr,
>
> +                     char *buf)
>
> +{
>
> +    return 0;
>
> +}
>
> +
>
> +static int l3gd20_gyr_configure_ring(struct iio_dev *indio_dev)
>
> +{
>
> +    return 0;
>
> +}
>
> +
>
> +static inline void l3gd20_gyr_unconfigure_ring(struct iio_dev *indio_dev)
>
> +{
>
> +}
>
> +
>
> +static inline int l3gd20_gyr_initialize_ring(struct iio_ring_buffer *ring)
>
> +{
>
> +    return 0;
>
> +}
>
> +
>
> +static inline void l3gd20_gyr_uninitialize_ring(struct iio_ring_buffer *ring)
>
> +{
>
> +}
>
> +
>
> +#endif /* CONFIG_IIO_RING_BUFFER */
>
> +
>
> +#endif /* __KERNEL__ */
>
> +
>
> +#endif  /* __L3GD20_H__ */
>
> diff --git a/drivers/staging/iio/gyro/l3gd20_gyr_core.c b/drivers/staging/iio/gyro/l3gd20_gyr_core.c
>
> index e69de29..64871b6 100644
>
> --- a/drivers/staging/iio/gyro/l3gd20_gyr_core.c
>
> +++ b/drivers/staging/iio/gyro/l3gd20_gyr_core.c
>
> @@ -0,0 +1,1056 @@
>
> +/******************** (C) COPYRIGHT 2011 STMicroelectronics ********************
>
> +*
>
> +* File Name    : l3gd20_gyr_core_iio.c
>
> +* Authors : MSH - Motion Mems BU - Application Team
>
> +*         : Matteo Dameno (matteo.dameno@st.com)
>
> +*         : author is willing to be considered the contact
>
> +*         : and update points for the driver.*
>
> +* Version : V.2.0.0
>
> +* Date         : 2011/Nov/16
>
> +* Description  : L3GD20 3 Axis Digital Gyroscope Sensor device driver iio
>
> +*         :
>
> +********************************************************************************
>
> +*
>
> +* This program is free software; you can redistribute it and/or modify
>
> +* it under the terms of the GNU General Public License version 2 as
>
> +* published by the Free Software Foundation.
>
> +*
>
> +* THE PRESENT SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES
>
> +* OR CONDITIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED, FOR THE SOLE
>
> +* PURPOSE TO SUPPORT YOUR APPLICATION DEVELOPMENT.
>
> +* AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY DIRECT,
>
> +* INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING FROM THE
>
> +* CONTENT OF SUCH SOFTWARE AND/OR THE USE MADE BY CUSTOMERS OF THE CODING
>
> +* INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
>
> +*
>
> +********************************************************************************
>
> + Revision 2.0.0: 2012/Nov/16
>
> +  first ioo implementation;
>
> +
>
> +*******************************************************************************/
>
> +
>
> +#include <linux/err.h>
>
> +#include <linux/errno.h>
>
> +#include <linux/delay.h>
>
> +#include <linux/fs.h>
>
> +#include <linux/i2c.h>
>
> +#include <linux/mutex.h>
>
> +#include <linux/input.h>
>
> +#include <linux/uaccess.h>
>
> +#include <linux/workqueue.h>
>
> +#include <linux/irq.h>
>
> +#include <linux/gpio.h>
>
> +#include <linux/interrupt.h>
>
> +#include <linux/gpio.h>
>
> +#include <linux/slab.h>
>
> +#include <linux/device.h>
>
> +#include <linux/kernel.h>
>
> +
>
> +#include <linux/sysfs.h>
>
> +
>
> +#include <linux/moduleparam.h>
>
> +
>
> +#include "../iio.h"
>
> +#include "../sysfs.h"
>
> +#include "gyro.h"
>
> +#include "l3gd20.h"
>
> +
>
> +
>
> +#define SENSITIVITY_250DPS     "8.75"          /**  mdps/counts */
>
> +#define SENSITIVITY_500DPS     "17.50"         /**  mdps/counts */
>
> +#define SENSITIVITY_2000DPS    "70.00"         /**  mdps/counts */
>
> +
>
> +#define SCALE_250DPS      "0.000153" /**  (rad/sec)/count */
>
> +#define SCALE_500DPS      "0.000297" /**  (rad/sec)/count */
>
> +#define SCALE_2000DPS          "0.001222" /**  (rad/sec)/count */
>
> +
>
> +#define GAIN_250DPS       "6548.089087"   /**  count/(rad/sec) */
>
> +#define GAIN_500DPS       "3370.339971"   /**  count/(rad/sec) */
>
> +#define GAIN_2000DPS      "818.511136"    /**  count/(rad/sec) */
>
> +
>
> +/* l3gd20 gyroscope registers */
>
> +#define WHO_AM_I    (0x0F)
>
> +
>
> +#define CTRL_REG1   (0x20)          /* CTRL REG1 */
>
> +#define CTRL_REG2   (0x21)          /* CTRL REG2 */
>
> +#define CTRL_REG3   (0x22)          /* CTRL_REG3 */
>
> +#define CTRL_REG4   (0x23)          /* CTRL_REG4 */
>
> +#define CTRL_REG5   (0x24)          /* CTRL_REG5 */
>
> +#define   REFERENCE  (0x25)          /* REFERENCE REG */
>
> +
>
> +#define OUT_X_LSB   (0x28)          /* 1st AXIS OUT REG of 6 */
>
> +#define OUT_X_MSB   (0x29)
>
> +#define OUT_Y_LSB   (0x2A)
>
> +#define OUT_Y_MSB   (0x2B)
>
> +#define OUT_Z_LSB   (0x2C)
>
> +#define OUT_Z_MSB   (0x2D)
>
> +#define   AXISDATA_REG    OUT_X_LSB
>
> +
>
> +#define   FIFO_CTRL_REG   (0x2E)          /* FIFO CONTROL REGISTER */
>
> +#define FIFO_SRC_REG (0x2F)          /* FIFO SOURCE REGISTER */
>
> +/* */
>
> +
>
> +/* CTRL_REG1 */
>
> +#define ALL_ZEROES        (0x00)
>
> +#define PM_OFF            (0x00)
>
> +#define PM_NORMAL         (0x08)
>
> +#define ENABLE_ALL_AXES        (0x07)
>
> +#define ENABLE_NO_AXES         (0x00)
>
> +#define BW00              (0x00)
>
> +#define BW01              (0x10)
>
> +#define BW10              (0x20)
>
> +#define BW11              (0x30)
>
> +#define CTRL_REG1_BW_MASK (0x30)
>
> +#define ODR095            (0x00)  /* ODR =  95Hz */
>
> +#define ODR190            (0x40)  /* ODR = 190Hz */
>
> +#define ODR380            (0x80)  /* ODR = 380Hz */
>
> +#define ODR760            (0xC0)  /* ODR = 760Hz */
>
> +#define CTRL_REG1_ODR_MASK     (0xC0)
>
> +
>
> +
>
> +/* CTRL_REG3 bits */
>
> +#define   I2_DRDY              (0x08)
>
> +#define   I2_WTM               (0x04)
>
> +#define   I2_OVRUN        (0x02)
>
> +#define   I2_EMPTY        (0x01)
>
> +#define   I2_NONE              (0x00)
>
> +#define   I2_MASK              (0x0F)
>
> +
>
> +/* CTRL_REG4 bits */
>
> +#define   FS_MASK              (0x30)
>
> +#define   BDU_ENABLE      (0x80)
>
> +
>
> +/* CTRL_REG5 bits */
>
> +#define   FIFO_ENABLE          (0x40)
>
> +#define HPF_ENALBE        (0x11)
>
> +
>
> +/* FIFO_CTRL_REG bits */
>
> +#define   FIFO_MODE_MASK       (0xE0)
>
> +#define   FIFO_MODE_BYPASS     (0x00)
>
> +#define   FIFO_MODE_FIFO       (0x20)
>
> +#define   FIFO_MODE_STREAM     (0x40)
>
> +#define   FIFO_MODE_STR2FIFO   (0x60)
>
> +#define   FIFO_MODE_BYPASS2STR (0x80)
>
> +#define   FIFO_WATERMARK_MASK  (0x1F)
>
> +
>
> +#define FIFO_STORED_DATA_MASK  (0x1F)
>
> +
>
> +/* I2C multi read/write option*/
>
> +#define I2C_AUTO_INCREMENT     (0x80)
>
> +
>
> +/* RESUME STATE INDICES */
>
> +#define   RES_CTRL_REG1        0
>
> +#define   RES_CTRL_REG2        1
>
> +#define   RES_CTRL_REG3        2
>
> +#define   RES_CTRL_REG4        3
>
> +#define   RES_CTRL_REG5        4
>
> +#define   RES_FIFO_CTRL_REG    5
>
> +#define   RESUME_ENTRIES       6
>
> +
>
> +
>
> +/** Registers Contents */
>
> +#define WHOAMI_L3GD20     (0x00D4)   /* Expected content for WAI register*/
>
> +
>
> +
>
> +struct output_rate {
>
> +    unsigned int poll_rate_ms;
>
> +    u8 sampling_rate_setting;
>
> +    const char *hz_label;
>
> +};
>
> +
>
> +static const struct output_rate l3gd20_gyr_odr_table[] = {
>
> +
>
> +    {    2,   ODR760|BW10,    "760"},
>
> +    {    3,   ODR380|BW01,    "380"},
>
> +    {    6,   ODR190|BW00,    "190"},
>
> +    {    11,  ODR095|BW00,    "95"},
>
> +};
>
> +
>
> +static struct l3gd20_gyr_platform_data default_l3gd20_gyr_pdata = {
>
> +    .fs_range = L3GD20_GYR_FS_250DPS,
>
> +    .axis_map_x = 0,
>
> +    .axis_map_y = 1,
>
> +    .axis_map_z = 2,
>
> +    .negate_x = 0,
>
> +    .negate_y = 0,
>
> +    .negate_z = 0,
>
> +
>
> +    .gpio_int1 = DEFAULT_INT1_GPIO,
>
> +    .gpio_int2 = DEFAULT_INT2_GPIO,      /* int for fifo */
>
> +
>
> +};
>
> +
>
> +struct l3gd20_gyr_data {
>
> +
>
> +    struct work_struct              work_trigger_to_ring;
>
> +    struct iio_work_cont            work_cont_thresh;
>
> +    s64                        last_timestamp;
>
> +    struct iio_dev                  *indio_dev;
>
> +    struct iio_trigger              *trig;
>
> +
>
> +    struct i2c_client               *client;
>
> +    struct l3gd20_gyr_platform_data      *pdata;
>
> +    int                        use_smbus;
>
> +
>
> +    struct mutex                    lock;
>
> +    int                        hw_initialized;
>
> +
>
> +    atomic_t                   enabled;
>
> +
>
> +    char const                 *scale;
>
> +    char const                 *gain;
>
> +
>
> +    u8                         reg_addr;
>
> +    u8                         resume_state[RESUME_ENTRIES];
>
> +
>
> +
>
> +    int                        irq1;
>
> +    int                        irq2;
>
> +
>
> +};
>
> +
>
> +
>
> +static int l3gd20_gyr_i2c_read(struct l3gd20_gyr_data *data,
>
> +                                    u8 *buf, int len)
>
> +{
>
> +    int ret;
>
> +    u8 reg = buf[0];
>
> +    u8 cmd = reg;
>
> +
>
> +    if (len > 1)
>
> +          cmd = (I2C_AUTO_INCREMENT | reg);
>
> +    if (data->use_smbus) {
>
> +          if (len == 1) {
>
> +               ret = i2c_smbus_read_byte_data(data->client, cmd);
>
> +               buf[0] = ret & 0xff;
>
> +#ifdef DEBUG
>
> +               dev_dbg(&data->client->dev,
>
> +                    "i2c_smbus_read_byte_data: ret=0x%02x, len:%d ,"
>
> +                    "command=0x%02x, buf[0]=0x%02x\n",
>
> +                    ret, len, cmd , buf[0]);
>
> +#endif
>
> +          } else if (len > 1) {
>
> +               ret = i2c_smbus_read_i2c_block_data(data->client,
>
> +                                          cmd, len, buf);
>
> +#ifdef DEBUG
>
> +               dev_dbg(&data->client->dev,
>
> +                    "i2c_smbus_read_i2c_block_data: ret:%d len:%d, "
>
> +                    "command=0x%02x, ",
>
> +                    ret, len, cmd);
>
> +               char ii;
>
> +               for (ii = 0; ii < len; ii++)
>
> +                    printk(KERN_DEBUG "buf[%d]=0x%02x,",
>
> +                                          ii, buf[ii]);
>
> +               printk("\n");
>
> +#endif
>
> +          } else
>
> +               ret = -1;
>
> +
>
> +          if (ret < 0) {
>
> +               dev_err(&data->client->dev,
>
> +                    "read transfer error: len:%d, command=0x%02x\n",
>
> +                    len, cmd);
>
> +               return 0; /* failure */
>
> +          }
>
> +          return len; /* success */
>
> +    }
>
> +
>
> +
>
> +    ret = i2c_master_send(data->client, &cmd, sizeof(cmd));
>
> +    if (ret != sizeof(cmd))
>
> +          return ret;
>
> +
>
> +    return i2c_master_recv(data->client, buf, len);
>
> +}
>
> +
>
> +static int l3gd20_gyr_i2c_write(struct l3gd20_gyr_data *data, u8 *buf,
>
> +                                          int len)
>
> +{
>
> +    int ret;
>
> +    u8 reg, value;
>
> +
>
> +    if (len > 1)
>
> +          buf[0] = (I2C_AUTO_INCREMENT | buf[0]);
>
> +
>
> +    reg = buf[0];
>
> +    value = buf[1];
>
> +
>
> +    if (data->use_smbus) {
>
> +          if (len == 1) {
>
> +               ret = i2c_smbus_write_byte_data(data->client, reg,
>
> +                                               value);
>
> +#ifdef DEBUG
>
> +               dev_dbg(&data->client->dev,
>
> +                    "i2c_smbus_write_byte_data: ret=%d, len:%d, "
>
> +                    "command=0x%02x, value=0x%02x\n",
>
> +                    ret, len, reg , value);
>
> +#endif
>
> +               return ret;
>
> +          } else if (len > 1) {
>
> +               ret = i2c_smbus_write_i2c_block_data(data->client,
>
> +                                    reg, len, buf + 1);
>
> +#ifdef DEBUG
>
> +               dev_dbg(&data->client->dev,
>
> +                    "i2c_smbus_write_i2c_block_data: ret=%d, "
>
> +                    "len:%d, command=0x%02x, ",
>
> +                    ret, len, reg);
>
> +               char ii;
>
> +               for (ii = 0; ii < len + 1; ii++)
>
> +                    printk(KERN_DEBUG "value[%d]=0x%02x,",
>
> +                                          ii, buf[ii]);
>
> +
>
> +               printk("\n");
>
> +#endif
>
> +               return ret;
>
> +          }
>
> +    }
>
> +
>
> +    ret = i2c_master_send(data->client, buf, len+1);
>
> +    return (ret == len+1) ? 0 : ret;
>
> +}
>
> +
>
> +
>
> +static int l3gd20_gyr_register_write(struct l3gd20_gyr_data *data,
>
> +          u8 *buf, u8 reg_address, u8 new_value)
>
> +{
>
> +    int err;
>
> +
>
> +          /* Sets configuration register at reg_address
>
> +          *  NOTE: this is a straight overwrite  */
>
> +          buf[0] = reg_address;
>
> +          buf[1] = new_value;
>
> +          err = l3gd20_gyr_i2c_write(data, buf, 1);
>
> +          if (err < 0)
>
> +               return err;
>
> +
>
> +    return err;
>
> +}
>
> +
>
> +static int l3gd20_gyr_register_read(struct l3gd20_gyr_data *data,
>
> +                               u8 *buf, u8 reg_address)
>
> +{
>
> +
>
> +    int err = -1;
>
> +    buf[0] = (reg_address);
>
> +    err = l3gd20_gyr_i2c_read(data, buf, 1);
>
> +    return err;
>
> +}
>
> +
>
> +static int l3gd20_gyr_register_update(struct l3gd20_gyr_data *data,
>
> +          u8 *buf, u8 reg_address, u8 mask, u8 new_bit_values)
>
> +{
>
> +    int err = -1;
>
> +    u8 init_val;
>
> +    u8 updated_val;
>
> +    err = l3gd20_gyr_register_read(data, buf, reg_address);
>
> +    if (!(err < 0)) {
>
> +          init_val = buf[0];
>
> +          updated_val = ((mask & new_bit_values) | ((~mask) & init_val));
>
> +          err = l3gd20_gyr_register_write(data, buf, reg_address,
>
> +                    updated_val);
>
> +    }
>
> +    return err;
>
> +}
>
> +
>
> +static int l3gd20_gyr_hw_init(struct l3gd20_gyr_data *dev_data)
>
> +{
>
> +    int err;
>
> +    u8 buf[6];
>
> +
>
> +    pr_info("%s hw init\n", L3GD20_GYR_DEV_NAME);
>
> +
>
> +    buf[0] = (CTRL_REG1);
>
> +    buf[1] = dev_data->resume_state[RES_CTRL_REG1];
>
> +    buf[2] = dev_data->resume_state[RES_CTRL_REG2];
>
> +    buf[3] = dev_data->resume_state[RES_CTRL_REG3];
>
> +    buf[4] = dev_data->resume_state[RES_CTRL_REG4];
>
> +    buf[5] = dev_data->resume_state[RES_CTRL_REG5];
>
> +
>
> +    err = l3gd20_gyr_i2c_write(dev_data, buf, 5);
>
> +    if (err < 0)
>
> +          return err;
>
> +
>
> +    buf[0] = FIFO_CTRL_REG;
>
> +    buf[1] = dev_data->resume_state[RES_FIFO_CTRL_REG];
>
> +    err = l3gd20_gyr_i2c_write(dev_data, buf, 1);
>
> +    if (err < 0)
>
> +               return err;
>
> +
>
> +    dev_data->hw_initialized = 1;
>
> +
>
> +    return err;
>
> +}
>
> +
>
> +static void l3gd20_gyr_device_power_off(struct l3gd20_gyr_data *dev_data)
>
> +{
>
> +    int err;
>
> +    u8 buf[2];
>
> +
>
> +    pr_info("%s power off\n", L3GD20_GYR_DEV_NAME);
>
> +
>
> +    buf[0] = CTRL_REG1;
>
> +    buf[1] = PM_OFF;
>
> +    err = l3gd20_gyr_i2c_write(dev_data, buf, 1);
>
> +    if (err < 0)
>
> +          dev_err(&dev_data->client->dev, "soft power off failed\n");
>
> +
>
> +    if (dev_data->pdata->power_off) {
>
> +          dev_data->pdata->power_off();
>
> +          dev_data->hw_initialized = 0;
>
> +    }
>
> +
>
> +    if (dev_data->hw_initialized)
>
> +          dev_data->hw_initialized = 0;
>
> +}
>
> +
>
> +static int l3gd20_gyr_device_power_on(struct l3gd20_gyr_data *dev_data)
>
> +{
>
> +    int err;
>
> +
>
> +    if (dev_data->pdata->power_on) {
>
> +          err = dev_data->pdata->power_on();
>
> +          if (err < 0)
>
> +               return err;
>
> +    }
>
> +
>
> +
>
> +    if (!dev_data->hw_initialized) {
>
> +          err = l3gd20_gyr_hw_init(dev_data);
>
> +          if (err < 0) {
>
> +               l3gd20_gyr_device_power_off(dev_data);
>
> +               return err;
>
> +          }
>
> +    }
>
> +
>
> +    return 0;
>
> +}
>
> +
>
> +
>
> +static int l3gd20_gyr_enable(struct l3gd20_gyr_data *dev_data)
>
> +{
>
> +    int err;
>
> +
>
> +    if (!atomic_cmpxchg(&dev_data->enabled, 0, 1)) {
>
> +
>
> +          err = l3gd20_gyr_device_power_on(dev_data);
>
> +          if (err < 0) {
>
> +               atomic_set(&dev_data->enabled, 0);
>
> +               return err;
>
> +          }
>
> +
>
> +    }
>
> +
>
> +    return 0;
>
> +}
>
> +
>
> +static int l3gd20_gyr_disable(struct l3gd20_gyr_data *dev_data)
>
> +{
>
> +
>
> +    printk(KERN_DEBUG "%s: dev_data->enabled = %d\n", __func__,
>
> +          atomic_read(&dev_data->enabled));
>
> +
>
> +    if (atomic_cmpxchg(&dev_data->enabled, 1, 0))
>
> +          l3gd20_gyr_device_power_off(dev_data);
>
> +
>
> +    return 0;
>
> +}
>
> +
>
> +static int l3gd20_gyr_update_fs_range(struct l3gd20_gyr_data *dev_data,
>
> +                                    u8 new_fs_range)
>
> +{
>
> +    int res ;
>
> +    u8 buf[2];
>
> +    char const *scale;
>
> +    char const *gain;
>
> +    buf[0] = CTRL_REG4;
>
> +
>
> +    switch (new_fs_range) {
>
> +    case L3GD20_GYR_FS_250DPS:
>
> +          gain = GAIN_250DPS;
>
> +          scale = SCALE_250DPS;
>
> +          break;
>
> +
>
> +    case L3GD20_GYR_FS_500DPS:
>
> +          gain = GAIN_500DPS;
>
> +          scale = SCALE_500DPS;
>
> +          break;
>
> +
>
> +    case L3GD20_GYR_FS_2000DPS:
>
> +          gain = GAIN_2000DPS;
>
> +          scale = SCALE_2000DPS;
>
> +          break;
>
> +
>
> +    default:
>
> +          dev_err(&dev_data->client->dev,
>
> +                          "invalid fs range requested: %u\n",
>
> +                          new_fs_range);
>
> +          return -EINVAL;
>
> +    }
>
> +
>
> +    res = l3gd20_gyr_register_update(dev_data, buf, CTRL_REG4,
>
> +                                    FS_MASK, new_fs_range);
>
> +
>
> +    if (res < 0) {
>
> +          pr_err("%s : failed to update fs:0x%02x\n",
>
> +                                    __func__, new_fs_range);
>
> +          return res;
>
> +    }
>
> +    dev_data->resume_state[RES_CTRL_REG4] =
>
> +          ((FS_MASK & new_fs_range) |
>
> +          (~FS_MASK & dev_data->resume_state[RES_CTRL_REG4]));
>
> +    dev_data->gain = gain;
>
> +    dev_data->scale = scale;
>
> +    return res;
>
> +}
>
> +
>
> +static int l3gd20_gyr_update_sampling_freq(struct l3gd20_gyr_data *data,
>
> +                                    u8 freq)
>
> +{
>
> +    int res = 0;
>
> +    u8 buf[2];
>
> +    u8 new_value;
>
> +    u8 mask = (CTRL_REG1_ODR_MASK|CTRL_REG1_BW_MASK);
>
> +
>
> +
>
> +    new_value = freq;
>
> +    res = l3gd20_gyr_register_update(data, buf, CTRL_REG1,
>
> +                                    mask, new_value);
>
> +
>
> +    if (res < 0) {
>
> +          dev_err(&data->client->dev,
>
> +               "%s : failed to update sampling frequency setting\n",
>
> +                                          __func__);
>
> +          return res;
>
> +    }
>
> +    dev_dbg(&data->client->dev, "%s : new_value:0x%02x, freq:0x%02x\n",
>
> +               __func__, new_value, freq);
>
> +
>
> +    data->resume_state[RES_CTRL_REG1] =
>
> +          ((mask & new_value) |
>
> +          (~mask & data->resume_state[RES_CTRL_REG1]));
>
> +
>
> +    data->pdata->sampling_frequency = new_value;
>
> +
>
> +    return res;
>
> +}
>
> +
>
> +static ssize_t l3gd20_gyr_show_sampling_frequency(struct device *dev,
>
> +                               struct device_attribute *attr,
>
> +                               char *buf)
>
> +{
>
> +    struct iio_dev *indio_dev = dev_get_drvdata(dev);
>
> +    struct l3gd20_gyr_data *data = indio_dev->dev_data;
>
> +    u8 i;
>
> +    u8 val;
>
> +
>
> +
>
> +    mutex_lock(&data->lock);
>
> +    val = data->pdata->sampling_frequency;
>
> +    mutex_unlock(&data->lock);
>
> +    dev_dbg(dev, "getting sampling frequency: 0x%02x\n", val);
>
> +
>
> +    for (i = 0; i < ARRAY_SIZE(l3gd20_gyr_odr_table); i++)
>
> +          if (l3gd20_gyr_odr_table[i].sampling_rate_setting == val)
>
> +               break;
>
> +
>
> +    return sprintf(buf, "%s\n", l3gd20_gyr_odr_table[i].hz_label);
>
> +}
>
> +
>
> +static ssize_t l3gd20_gyr_store_sampling_frequency(struct device *dev,
>
> +                               struct device_attribute *attr,
>
> +                               const char *buf, size_t size)
>
> +{
>
> +    struct iio_dev *indio_dev = dev_get_drvdata(dev);
>
> +    struct l3gd20_gyr_data *data = indio_dev->dev_data;
>
> +    u8 found = 0;
>
> +    u8 i;
>
> +    u8 ret;
>
> +
>
> +    for (i = 0; i < ARRAY_SIZE(l3gd20_gyr_odr_table); i++) {
>
> +          if (strcmp(buf, l3gd20_gyr_odr_table[i].hz_label) == 0) {
>
> +               found = 1;
>
> +               break;
>
> +          }
>
> +    }
>
> +
>
> +    if (!found) {
>
> +          dev_err(dev, "trying to set invalid sampling frequency: %s\n"
>
> +                    "new sampling frequency not set!\n", buf);
>
> +          return  -EINVAL;
>
> +    } else {
>
> +          mutex_lock(&data->lock);
>
> +          ret = l3gd20_gyr_update_sampling_freq(data,
>
> +               l3gd20_gyr_odr_table[i].sampling_rate_setting);
>
> +          if (ret < 0)
>
> +               goto error;
>
> +          data->pdata->sampling_frequency =
>
> +               l3gd20_gyr_odr_table[i].sampling_rate_setting;
>
> +          dev_info(dev, "set new sampling frequency: %s Hz\n",
>
> +                          l3gd20_gyr_odr_table[i].hz_label);
>
> +          mutex_unlock(&data->lock);
>
> +    }
>
> +    return size;
>
> +error:
>
> +    mutex_unlock(&data->lock);
>
> +    return ret;
>
> +}
>
> +
>
> +
>
> +static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
>
> +          l3gd20_gyr_show_sampling_frequency,
>
> +          l3gd20_gyr_store_sampling_frequency);
>
> +
>
> +static ssize_t l3gd20_gyr_show_enable(struct device *dev,
>
> +                      struct device_attribute *attr, char *buf)
>
> +{
>
> +    struct iio_dev *indio_dev = dev_get_drvdata(dev);
>
> +    struct l3gd20_gyr_data *data = indio_dev->dev_data;
>
> +    int val = atomic_read(&data->enabled);
>
> +    return sprintf(buf, "%d\n", val);
>
> +}
>
> +
>
> +static ssize_t l3gd20_gyr_store_enable(struct device *dev,
>
> +                      struct device_attribute *attr,
>
> +                      const char *buf, size_t size)
>
> +{
>
> +    struct iio_dev *indio_dev = dev_get_drvdata(dev);
>
> +    struct l3gd20_gyr_data *data = indio_dev->dev_data;
>
> +    unsigned long val;
>
> +
>
> +    if (strict_strtoul(buf, 10, &val))
>
> +          return -EINVAL;
>
> +
>
> +    if (val)
>
> +          l3gd20_gyr_enable(data);
>
> +    else
>
> +          l3gd20_gyr_disable(data);
>
> +
>
> +    return size;
>
> +}
>
> +
>
> +static IIO_DEVICE_ATTR(enable_device,
>
> +               S_IWUSR | S_IRUGO,
>
> +               l3gd20_gyr_show_enable,
>
> +               l3gd20_gyr_store_enable,
>
> +               0);
>
> +
>
> +static int l3gd20_gyr_show_channel_rawdata(struct device *dev,
>
> +                    struct device_attribute *attr,
>
> +                    char *buf)
>
> +{
>
> +    struct iio_dev *indio_dev = dev_get_drvdata(dev);
>
> +    struct l3gd20_gyr_data *data = indio_dev->dev_data;
>
> +    struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>
> +    int err;
>
> +
>
> +    /* Data bytes from hardware (GxL, GxH) or (GyL, GyH) or (GzL, GzH) */
>
> +    u8 out_data[2];
>
> +    /* x,y,z hardware data */
>
> +    s16 raw_d;
>
> +
>
> +    out_data[0] = this_attr->address;
>
> +
>
> +    mutex_lock(&data->lock);
>
> +    err = l3gd20_gyr_i2c_read(data, out_data, 2);
>
> +    mutex_unlock(&data->lock);
>
> +    if (err < 0) {
>
> +          dev_err(dev, "error reading output registers\n");
>
> +          return err;
>
> +    }
>
> +
>
> +    raw_d = ((s16) ((out_data[1]) << 8) | out_data[0]);
>
> +    return sprintf(buf, "%d\n", raw_d);
>
> +
>
> +}
>
> +
>
> +static IIO_DEV_ATTR_GYRO_X(l3gd20_gyr_show_channel_rawdata, OUT_X_LSB);
>
> +static IIO_DEV_ATTR_GYRO_Y(l3gd20_gyr_show_channel_rawdata, OUT_Y_LSB);
>
> +static IIO_DEV_ATTR_GYRO_Z(l3gd20_gyr_show_channel_rawdata, OUT_Z_LSB);
>
> +
>
> +static ssize_t l3gd20_gyr_show_range(struct device *dev,
>
> +                          struct device_attribute *attr,
>
> +                          char *buf)
>
> +{
>
> +    struct iio_dev *indio_dev = dev_get_drvdata(dev);
>
> +    struct l3gd20_gyr_data *data = indio_dev->dev_data;
>
> +    int label = 0;
>
> +    u8 val;
>
> +    mutex_lock(&data->lock);
>
> +    val = data->pdata->fs_range;
>
> +    mutex_unlock(&data->lock);
>
> +
>
> +    switch (val) {
>
> +    case L3GD20_GYR_FS_250DPS:
>
> +          label = 250;
>
> +          break;
>
> +    case L3GD20_GYR_FS_500DPS:
>
> +          label = 500;
>
> +          break;
>
> +    case L3GD20_GYR_FS_2000DPS:
>
> +          label = 2000;
>
> +          break;
>
> +    }
>
> +
>
> +    return sprintf(buf, "%d dps\n", label);
>
> +}
>
> +
>
> +static ssize_t l3gd20_gyr_store_range(struct device *dev,
>
> +                            struct device_attribute *attr,
>
> +                            const char *buf,
>
> +                            size_t size)
>
> +{
>
> +    struct iio_dev *indio_dev = dev_get_drvdata(dev);
>
> +    struct l3gd20_gyr_data *data = indio_dev->dev_data;
>
> +    unsigned long val;
>
> +    u8 range;
>
> +    int err = -1;
>
> +    if (strict_strtoul(buf, 10, &val)) {
>
> +          dev_err(dev, "invalid range %lu\n. Range not changed", val);
>
> +          return -EINVAL;
>
> +    }
>
> +    switch (val) {
>
> +    case 250:
>
> +          range = L3GD20_GYR_FS_250DPS;
>
> +          break;
>
> +    case 500:
>
> +          range = L3GD20_GYR_FS_500DPS;
>
> +          break;
>
> +    case 2000:
>
> +          range = L3GD20_GYR_FS_2000DPS;
>
> +          break;
>
> +    default:
>
> +          dev_err(dev, "invalid range %lu. Range not changed\n", val);
>
> +          return -EINVAL;
>
> +    }
>
> +
>
> +    mutex_lock(&data->lock);
>
> +    data->pdata->fs_range = range;
>
> +    err = l3gd20_gyr_update_fs_range(data, range);
>
> +    mutex_unlock(&data->lock);
>
> +    if (err < 0)
>
> +          goto error;
>
> +    dev_info(dev, "set range to %lu dps\n", val);
>
> +    return size;
>
> +error:
>
> +    dev_err(dev, "error changing range\n");
>
> +    return err;
>
> +}
>
> +
>
> +
>
> +
>
> +static IIO_DEVICE_ATTR(gyro_range,
>
> +               S_IWUSR | S_IRUGO,
>
> +               l3gd20_gyr_show_range,
>
> +               l3gd20_gyr_store_range,
>
> +               0);
>
> +
>
> +
>
> +static IIO_CONST_ATTR(gyro_range_available, "250 500 2000");
>
> +
>
> +
>
> +static ssize_t l3gd20_gyr_show_gain(struct device *dev,
>
> +                               struct device_attribute *attr,
>
> +                               char *buf)
>
> +{
>
> +    struct iio_dev *indio_dev = dev_get_drvdata(dev);
>
> +    struct l3gd20_gyr_data *data = indio_dev->dev_data;
>
> +    return sprintf(buf, "%s\n", data->gain);
>
> +}
>
> +
>
> +static IIO_DEVICE_ATTR(gyro_gain, S_IRUGO,
>
> +               l3gd20_gyr_show_gain,
>
> +               NULL , 0);
>
> +
>
> +
>
> +static ssize_t l3gd20_gyr_show_scale(struct device *dev,
>
> +                          struct device_attribute *attr,
>
> +                          char *buf)
>
> +{
>
> +    struct iio_dev *indio_dev = dev_get_drvdata(dev);
>
> +    struct l3gd20_gyr_data *data = indio_dev->dev_data;
>
> +    return sprintf(buf, "%s\n", data->scale);
>
> +}
>
> +
>
> +static IIO_DEVICE_ATTR(gyro_scale, S_IRUGO,
>
> +               l3gd20_gyr_show_scale,
>
> +               NULL , 0);
>
> +
>
> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("95 190 380 760");
>
> +
>
> +static IIO_CONST_ATTR(name, L3GD20_GYR_DEV_NAME);
>
> +
>
> +
>
> +
>
> +static struct attribute *l3gd20_gyr_attributes[] = {
>
> +    &iio_const_attr_name.dev_attr.attr,
>
> +    &iio_dev_attr_enable_device.dev_attr.attr,
>
> +    &iio_const_attr_gyro_range_available.dev_attr.attr,
>
> +    &iio_dev_attr_gyro_range.dev_attr.attr,
>
> +    &iio_dev_attr_gyro_gain.dev_attr.attr,
>
> +    &iio_dev_attr_gyro_scale.dev_attr.attr,
>
> +    &iio_dev_attr_gyro_x_raw.dev_attr.attr,
>
> +    &iio_dev_attr_gyro_y_raw.dev_attr.attr,
>
> +    &iio_dev_attr_gyro_z_raw.dev_attr.attr,
>
> +    &iio_dev_attr_sampling_frequency.dev_attr.attr,
>
> +    &iio_const_attr_sampling_frequency_available.dev_attr.attr,
>
> +    NULL
>
> +};
>
> +
>
> +static const struct attribute_group l3gd20_gyr_attribute_group = {
>
> +    .attrs = l3gd20_gyr_attributes,
>
> +};
>
> +
>
> +static int l3gd20_gyr_validate_pdata(struct l3gd20_gyr_data *dev_data)
>
> +{
>
> +
>
> +    if (dev_data->pdata->axis_map_x > 2 ||
>
> +        dev_data->pdata->axis_map_y > 2 ||
>
> +        dev_data->pdata->axis_map_z > 2) {
>
> +          dev_err(&dev_data->client->dev,
>
> +               "invalid axis_map value x:%u y:%u z%u\n",
>
> +               dev_data->pdata->axis_map_x,
>
> +               dev_data->pdata->axis_map_y,
>
> +               dev_data->pdata->axis_map_z);
>
> +          return -EINVAL;
>
> +    }
>
> +
>
> +    /* Only allow 0 and 1 for negation boolean flag */
>
> +    if (dev_data->pdata->negate_x > 1 ||
>
> +        dev_data->pdata->negate_y > 1 ||
>
> +        dev_data->pdata->negate_z > 1) {
>
> +          dev_err(&dev_data->client->dev,
>
> +               "invalid negate value x:%u y:%u z:%u\n",
>
> +               dev_data->pdata->negate_x,
>
> +               dev_data->pdata->negate_y,
>
> +               dev_data->pdata->negate_z);
>
> +          return -EINVAL;
>
> +    }
>
> +
>
> +    return 0;
>
> +}
>
> +
>
> +static int l3gd20_gyr_probe(struct i2c_client *client,
>
> +          const struct i2c_device_id *id)
>
> +{
>
> +    struct l3gd20_gyr_data *data;
>
> +    int err = -1;
>
> +    data = kzalloc(sizeof(struct l3gd20_gyr_data), GFP_KERNEL);
>
> +    if (data == NULL) {
>
> +          err = -ENOMEM;
>
> +          dev_err(&client->dev,
>
> +                    "failed to allocate memory for module data: "
>
> +                          "%d\n", err);
>
> +          goto exit_check_functionality_failed;
>
> +    }
>
> +
>
> +    u32 smbus_func = I2C_FUNC_SMBUS_BYTE_DATA |
>
> +               I2C_FUNC_SMBUS_WORD_DATA | I2C_FUNC_SMBUS_I2C_BLOCK ;
>
> +
>
> +    int regdone = 0;
>
> +
>
> +    pr_info("%s: probe start.\n", L3GD20_GYR_DEV_NAME);
>
> +
>
> +
>
> +    /* Support for both I2C and SMBUS adapter interfaces. */
>
> +    if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
>
> +          dev_warn(&client->dev, "client not i2c capable\n");
>
> +          if (i2c_check_functionality(client->adapter, smbus_func)) {
>
> +               data->use_smbus = 1;
>
> +               dev_warn(&client->dev, "client using SMBUS\n");
>
> +          } else {
>
> +               err = -ENODEV;
>
> +               dev_err(&client->dev, "client nor SMBUS capable\n");
>
> +               data->use_smbus = 0;
>
> +               goto exit_check_functionality_failed;
>
> +          }
>
> +    }
>
> +
>
> +    mutex_init(&data->lock);
>
> +    mutex_lock(&data->lock);
>
> +    data->client = client;
>
> +    i2c_set_clientdata(client, data);
>
> +
>
> +    data->pdata = kmalloc(sizeof(*data->pdata), GFP_KERNEL);
>
> +    if (data->pdata == NULL) {
>
> +          err = -ENOMEM;
>
> +          dev_err(&client->dev,
>
> +                    "failed to allocate memory for pdata: %d\n",
>
> +                    err);
>
> +          goto err_mutexunlock;
>
> +    }
>
> +
>
> +    if (client->dev.platform_data == NULL) {
>
> +          memcpy(data->pdata, &default_l3gd20_gyr_pdata,
>
> +                                    sizeof(*data->pdata));
>
> +          dev_info(&client->dev, "using default platform data\n");
>
> +    } else {
>
> +          memcpy(data->pdata, client->dev.platform_data,
>
> +                                    sizeof(*data->pdata));
>
> +    }
>
> +
>
> +    err = l3gd20_gyr_validate_pdata(data);
>
> +    if (err < 0) {
>
> +          dev_err(&client->dev, "failed to validate platform data\n");
>
> +          goto exit_kfree_pdata;
>
> +    }
>
> +
>
> +
>
> +    if (data->pdata->init) {
>
> +          err = data->pdata->init();
>
> +          if (err < 0) {
>
> +               dev_err(&client->dev, "init failed: %d\n", err);
>
> +               goto err_pdata_init;
>
> +          }
>
> +    }
>
> +
>
> +    memset(data->resume_state, 0, ARRAY_SIZE(data->resume_state));
>
> +
>
> +    data->resume_state[RES_CTRL_REG1] = (ALL_ZEROES | PM_NORMAL
>
> +                                    | ENABLE_ALL_AXES);
>
> +    data->resume_state[RES_CTRL_REG2] = ALL_ZEROES;
>
> +    data->resume_state[RES_CTRL_REG3] = ALL_ZEROES;
>
> +    data->resume_state[RES_CTRL_REG4] = (ALL_ZEROES | BDU_ENABLE);
>
> +    data->resume_state[RES_CTRL_REG5] = ALL_ZEROES;
>
> +    data->resume_state[RES_FIFO_CTRL_REG] = ALL_ZEROES;
>
> +
>
> +    err = l3gd20_gyr_device_power_on(data);
>
> +    if (err < 0) {
>
> +          dev_err(&client->dev, "power on failed: %d\n", err);
>
> +          goto exit_kfree_pdata;
>
> +    }
>
> +
>
> +    atomic_set(&data->enabled, 1);
>
> +
>
> +    err = l3gd20_gyr_update_fs_range(data, data->pdata->fs_range);
>
> +    if (err < 0) {
>
> +          dev_err(&client->dev, "update_fs_range failed\n");
>
> +          goto  err_power_off;
>
> +    }
>
> +
>
> +    err = l3gd20_gyr_update_sampling_freq(data,
>
> +                          data->pdata->sampling_frequency);
>
> +    if (err < 0) {
>
> +          dev_err(&client->dev, "update sampling freq failed\n");
>
> +          goto  err_power_off;
>
> +    }
>
> +
>
> +    data->indio_dev = iio_allocate_device();
>
> +    if (!data->indio_dev) {
>
> +          err = -ENOMEM;
>
> +          dev_err(&client->dev, "error allocating iio device: %d\n", err);
>
> +          goto err_power_off;
>
> +    }
>
> +    data->indio_dev->attrs = &l3gd20_gyr_attribute_group;
>
> +    data->indio_dev->dev.parent = &client->dev;
>
> +    data->indio_dev->dev_data = (void *)(data);
>
> +    data->indio_dev->driver_module = THIS_MODULE;
>
> +    data->indio_dev->modes = INDIO_DIRECT_MODE;
>
> +
>
> +
>
> +
>
> +    l3gd20_gyr_device_power_off(data);
>
> +    /* As default, do not report information */
>
> +    atomic_set(&data->enabled, 0);
>
> +
>
> +    err = l3gd20_gyr_configure_ring(data->indio_dev);
>
> +    if (err)
>
> +          goto error_free_dev;
>
> +
>
> +    err = iio_device_register(data->indio_dev);
>
> +    if (err) {
>
> +          dev_err(&client->dev, "error registering iio dev: %d\n", err);
>
> +          goto error_unreg_ring_funcs;
>
> +    }
>
> +    regdone = 1;
>
> +
>
> +    err = l3gd20_gyr_initialize_ring(data->indio_dev->ring);
>
> +    if (err) {
>
> +          dev_err(&client->dev, "failed to initialize the ring\n");
>
> +          goto error_unreg_ring_funcs;
>
> +    }
>
> +
>
> +
>
> +    mutex_unlock(&data->lock);
>
> +    dev_info(&client->dev, "%s: probed\n", L3GD20_GYR_DEV_NAME);
>
> +    return 0;
>
> +
>
> +
>
> +
>
> +error_unreg_ring_funcs:
>
> +    l3gd20_gyr_unconfigure_ring(data->indio_dev);
>
> +error_free_dev:
>
> +    if (regdone)
>
> +          iio_device_unregister(data->indio_dev);
>
> +    else
>
> +          iio_free_device(data->indio_dev);
>
> +err_power_off:
>
> +    l3gd20_gyr_device_power_off(data);
>
> +err_pdata_init:
>
> +    if (data->pdata->exit)
>
> +          data->pdata->exit();
>
> +exit_kfree_pdata:
>
> +    kfree(data->pdata);
>
> +err_mutexunlock:
>
> +    mutex_unlock(&data->lock);
>
> +    kfree(data);
>
> +exit_check_functionality_failed:
>
> +    printk(KERN_ERR "%s: Driver Init failed\n", L3GD20_GYR_DEV_NAME);
>
> +    return err;
>
> +}
>
> +
>
> +
>
> +static int __devexit l3gd20_gyr_remove(struct i2c_client *client)
>
> +{
>
> +
>
> +    struct l3gd20_gyr_data *dev_data = i2c_get_clientdata(client);
>
> +
>
> +    l3gd20_gyr_device_power_off(dev_data);
>
> +
>
> +    l3gd20_gyr_uninitialize_ring(dev_data->indio_dev->ring);
>
> +    iio_device_unregister(dev_data->indio_dev);
>
> +    l3gd20_gyr_unconfigure_ring(dev_data->indio_dev);
>
> +
>
> +    if (dev_data->pdata->exit)
>
> +          dev_data->pdata->exit();
>
> +    kfree(dev_data->pdata);
>
> +    kfree(dev_data);
>
> +
>
> +    return 0;
>
> +}
>
> +
>
> +static const struct i2c_device_id l3gd20_gyr_id[] = {
>
> +    { L3GD20_GYR_DEV_NAME , 0 },
>
> +    {},
>
> +};
>
> +
>
> +MODULE_DEVICE_TABLE(i2c, l3gd20_gyr_id);
>
> +
>
> +static struct i2c_driver l3gd20_gyr_driver = {
>
> +    .driver = {
>
> +               .owner = THIS_MODULE,
>
> +               .name = L3GD20_GYR_DEV_NAME,
>
> +            },
>
> +    .probe = l3gd20_gyr_probe,
>
> +    .remove = __devexit_p(l3gd20_gyr_remove),
>
> +    .id_table = l3gd20_gyr_id,
>
> +};
>
> +
>
> +static int __init l3gd20_gyr_init(void)
>
> +{
>
> +    pr_info("%s: gyroscope iio driver init\n", L3GD20_GYR_DEV_NAME);
>
> +    return i2c_add_driver(&l3gd20_gyr_driver);
>
> +}
>
> +
>
> +static void __exit l3gd20_gyr_exit(void)
>
> +{
>
> +    pr_info("%s exit\n", L3GD20_GYR_DEV_NAME);
>
> +    i2c_del_driver(&l3gd20_gyr_driver);
>
> +    return;
>
> +}
>
> +
>
> +module_init(l3gd20_gyr_init);
>
> +module_exit(l3gd20_gyr_exit);
>
> +
>
> +MODULE_DESCRIPTION("STMicroelectronics l3gd20 digital gyroscope iio driver");
>
> +MODULE_AUTHOR("Matteo Dameno, STMicroelectronics");
>
> +MODULE_LICENSE("GPL v2");
>
> --
>
> 1.7.5.4
>
>
>
>
>
> P.S.: We are working on the driver to make it compatible for the latest kernel.
>
