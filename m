Return-Path: <SRS0=5Drc=X5=gmail.com=lorenzo.bianconi83@kernel.org>
MIME-Version: 1.0
In-Reply-To: <0d54130e-70d2-e396-877d-f7747afd4245@kernel.org>
References: <20161130200559.29910-1-lorenzo.bianconi@st.com>
 <20161130200559.29910-2-lorenzo.bianconi@st.com> <da517c57-ee07-c776-cfa0-e0a6afa64e64@kernel.org>
 <CAA2SeN+qhMrd8TLD1=5AWS84mvRoKvmRvYHEw+sqt5nLJxdNBA@mail.gmail.com> <0d54130e-70d2-e396-877d-f7747afd4245@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Date: Wed, 14 Dec 2016 22:06:13 +0100
Message-ID: <CAA2SeN+FTtPyk3H_eZNxB3uMmtQfNPCzaGSOJMXnV0+6PqKbuQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: imu: add support to lsm6dsx driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lorenzo BIANCONI <lorenzo.bianconi@st.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

> On 09/12/16 14:35, Lorenzo Bianconi wrote:
>>> On 30/11/16 20:05, Lorenzo Bianconi wrote:
>>>> Add support to STM LSM6DS3-LSM6DSM 6-axis (acc + gyro) Mems sensor
>>>>
>>>> http://www.st.com/resource/en/datasheet/lsm6ds3.pdf
>>>> http://www.st.com/resource/en/datasheet/lsm6dsm.pdf
>>>>
>>>> - continuous mode support
>>>> - i2c support
>>>> - spi support
>>>> - sw fifo mode support
>>>> - supported devices: lsm6ds3, lsm6dsm
>>>>
>>>> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
>>> Hi Lorenzo,
>>
>> Hi Jonathan,
>>
>> Thanks for the review :)
>>
>>>
>>> I'm actually pretty happy with this.  Most of the comments inline
>>> are requests for more documentation.  There are some non obvious corners
>>> so please make reviewers and anyone reading this in the future's life
>>> easier by explaining them.
>>>
>>> We are also just at the start of the new cycle, so have plenty of time.
>>> I'd like this one to sit on the list for a few weeks after we are happy
>>> with it to see if anyone else would like to comment on it. It's a bit
>>> complex for me to feel totally confortable on taking it based only on
>>> my own review!
>>
>> Sounds good to me, in the mean time I added more documentation.
>> Just few questions inline.
> Answers inline.
>>
>> Regards,
>> Lorenzo
>>
>>>
>>> Jonathan
>>>> ---
>>>>  drivers/iio/imu/Kconfig                      |   1 +
>>>>  drivers/iio/imu/Makefile                     |   2 +
>>>>  drivers/iio/imu/st_lsm6dsx/Kconfig           |  23 +
>>>>  drivers/iio/imu/st_lsm6dsx/Makefile          |   6 +
>>>>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      | 107 ++++
>>>>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 696 +++++++++++++++++++++++++++
>>>>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c  | 111 +++++
>>>>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_ring.c | 401 +++++++++++++++
>>>>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c  | 129 +++++
>>>>  9 files changed, 1476 insertions(+)
>>>>  create mode 100644 drivers/iio/imu/st_lsm6dsx/Kconfig
>>>>  create mode 100644 drivers/iio/imu/st_lsm6dsx/Makefile
>>>>  create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
>>>>  create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>>>>  create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
>>>>  create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_ring.c
>>>>  create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
>>>>
>>>> diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
>>>> index 1f1ad41..156630a 100644
>>>> --- a/drivers/iio/imu/Kconfig
>>>> +++ b/drivers/iio/imu/Kconfig
>>>> @@ -39,6 +39,7 @@ config KMX61
>>>>         be called kmx61.
>>>>
>>>>  source "drivers/iio/imu/inv_mpu6050/Kconfig"
>>>> +source "drivers/iio/imu/st_lsm6dsx/Kconfig"
>>>>
>>>>  endmenu
>>>>
>>>> diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
>>>> index c71bcd3..8b563c3 100644
>>>> --- a/drivers/iio/imu/Makefile
>>>> +++ b/drivers/iio/imu/Makefile
>>>> @@ -17,3 +17,5 @@ obj-y += bmi160/
>>>>  obj-y += inv_mpu6050/
>>>>
>>>>  obj-$(CONFIG_KMX61) += kmx61.o
>>>> +
>>>> +obj-y += st_lsm6dsx/
>>>> diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6dsx/Kconfig
>>>> new file mode 100644
>>>> index 0000000..9a0781b
>>>> --- /dev/null
>>>> +++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
>>>> @@ -0,0 +1,23 @@
>>>> +
>>>> +config IIO_ST_LSM6DSX
>>>> +     tristate "ST_LSM6DSx driver for STM 6-axis imu Mems sensors"
>>>> +     depends on (I2C || SPI)
>>>> +     select IIO_BUFFER
>>>> +     select IIO_KFIFO_BUF
>>>> +     select IIO_ST_LSM6DSX_I2C if (I2C)
>>>> +     select IIO_ST_LSM6DSX_SPI if (SPI_MASTER)
>>>> +     help
>>>> +       Say yes here to build support for STMicroelectronics LSM6DSx imu
>>>> +       sensor. Supported devices: lsm6ds3, lsm6dsm
>>>> +
>>>> +       To compile this driver as a module, choose M here: the module
>>>> +       will be called st_lsm6dsx.
>>>> +
>>>> +config IIO_ST_LSM6DSX_I2C
>>>> +     tristate
>>>> +     depends on IIO_ST_LSM6DSX
>>>> +
>>>> +config IIO_ST_LSM6DSX_SPI
>>>> +     tristate
>>>> +     depends on IIO_ST_LSM6DSX
>>>> +
>>>> diff --git a/drivers/iio/imu/st_lsm6dsx/Makefile b/drivers/iio/imu/st_lsm6dsx/Makefile
>>>> new file mode 100644
>>>> index 0000000..812d655
>>>> --- /dev/null
>>>> +++ b/drivers/iio/imu/st_lsm6dsx/Makefile
>>>> @@ -0,0 +1,6 @@
>>>> +st_lsm6dsx-y := st_lsm6dsx_core.o \
>>>> +             st_lsm6dsx_ring.o
>>>> +
>>>> +obj-$(CONFIG_IIO_ST_LSM6DSX) += st_lsm6dsx.o
>>>> +obj-$(CONFIG_IIO_ST_LSM6DSX_I2C) += st_lsm6dsx_i2c.o
>>>> +obj-$(CONFIG_IIO_ST_LSM6DSX_SPI) += st_lsm6dsx_spi.o
>>>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
>>>> new file mode 100644
>>>> index 0000000..a43beab
>>>> --- /dev/null
>>>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
>>>> @@ -0,0 +1,107 @@
>>>> +/*
>>>> + * STMicroelectronics st_lsm6dsx sensor driver
>>>> + *
>>>> + * Copyright 2016 STMicroelectronics Inc.
>>>> + *
>>>> + * Lorenzo Bianconi <lorenzo.bianconi@st.com>
>>>> + * Denis Ciocca <denis.ciocca@st.com>
>>>> + *
>>>> + * Licensed under the GPL-2.
>>>> + */
>>>> +
>>>> +#ifndef ST_LSM6DSX_H
>>>> +#define ST_LSM6DSX_H
>>>> +
>>>> +#include <linux/device.h>
>>>> +
>>>> +#define ST_LSM6DS3_DEV_NAME  "lsm6ds3"
>>>> +#define ST_LSM6DSM_DEV_NAME  "lsm6dsm"
>>>> +
>>>> +#define ST_LSM6DSX_CHAN_SIZE         2
>>>> +#define ST_LSM6DSX_SAMPLE_SIZE               6
>>>> +#define ST_LSM6DSX_SAMPLE_DEPTH              (ST_LSM6DSX_SAMPLE_SIZE / \
>>>> +                                      ST_LSM6DSX_CHAN_SIZE)
>>>> +
>>>> +#if defined(CONFIG_SPI_MASTER)
>>>> +#define ST_LSM6DSX_RX_MAX_LENGTH     256
>>>> +#define ST_LSM6DSX_TX_MAX_LENGTH     8
>>>> +
>>>> +struct st_lsm6dsx_transfer_buffer {
>>>> +     u8 rx_buf[ST_LSM6DSX_RX_MAX_LENGTH];
>>>> +     u8 tx_buf[ST_LSM6DSX_TX_MAX_LENGTH] ____cacheline_aligned;
>>>> +};
>>>> +#endif /* CONFIG_SPI_MASTER */
>>>> +
>>>> +struct st_lsm6dsx_transfer_function {
>>>> +     int (*read)(struct device *dev, u8 addr, int len, u8 *data);
>>>> +     int (*write)(struct device *dev, u8 addr, int len, u8 *data);
>>>> +};
>>>> +
>>>> +struct st_lsm6dsx_reg {
>>>> +     u8 addr;
>>>> +     u8 mask;
>>>> +};
>>>> +
>>>> +struct st_lsm6dsx_settings {
>>>> +     u8 wai;
>>>> +     u16 max_fifo_size;
>>>> +};
>>>> +
>>>> +enum st_lsm6dsx_sensor_id {
>>>> +     ST_LSM6DSX_ID_ACC,
>>>> +     ST_LSM6DSX_ID_GYRO,
>>>> +     ST_LSM6DSX_ID_MAX,
>>>> +};
>>>> +
>>>> +enum st_lsm6dsx_fifo_mode {
>>>> +     ST_LSM6DSX_FIFO_BYPASS = 0x0,
>>>> +     ST_LSM6DSX_FIFO_CONT = 0x6,
>>>> +};
>>>> +
>>>> +struct st_lsm6dsx_sensor {
>>>> +     enum st_lsm6dsx_sensor_id id;
>>>> +     struct st_lsm6dsx_hw *hw;
>>>> +
>>>> +     u32 gain;
>>>> +     u16 odr;
>>>> +
>>>> +     u16 watermark;
>>> Please document this structure.  I've no immediate idea of what sip is.
>>>> +     u8 sip;
>>>> +     u8 decimator;
>>>> +     u8 decimator_mask;
>>>> +
>>>> +     s64 delta_ts;
>>>> +     s64 ts;
>>>> +};
>>>> +
>>> Document this one as well please.  Kernel doc ideally.
>>>> +struct st_lsm6dsx_hw {
>>>> +     const char *name;
>>>> +     struct device *dev;
>>>> +     int irq;
>>>> +     struct mutex lock;
>>>> +
>>>> +     enum st_lsm6dsx_fifo_mode fifo_mode;
>>>> +     u8 enable_mask;
>>>> +     u8 sip;
>>>> +
>>>> +     struct iio_dev *iio_devs[ST_LSM6DSX_ID_MAX];
>>>> +
>>>> +     const struct st_lsm6dsx_settings *settings;
>>>> +
>>>> +     const struct st_lsm6dsx_transfer_function *tf;
>>>> +#if defined(CONFIG_SPI_MASTER)
>>>> +     struct st_lsm6dsx_transfer_buffer tb;
>>>> +#endif /* CONFIG_SPI_MASTER */
>>>> +};
>>>> +
>>>> +int st_lsm6dsx_probe(struct st_lsm6dsx_hw *hw);
>>>> +int st_lsm6dsx_sensor_enable(struct st_lsm6dsx_sensor *sensor);
>>>> +int st_lsm6dsx_sensor_disable(struct st_lsm6dsx_sensor *sensor);
>>>> +int st_lsm6dsx_allocate_rings(struct st_lsm6dsx_hw *hw);
>>>> +int st_lsm6dsx_write_with_mask(struct st_lsm6dsx_hw *hw, u8 addr, u8 mask,
>>>> +                            u8 val);
>>>> +int st_lsm6dsx_update_watermark(struct st_lsm6dsx_sensor *sensor,
>>>> +                             u16 watermark);
>>>> +
>>>> +#endif /* ST_LSM6DSX_H */
>>>> +
>>>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>>>> new file mode 100644
>>>> index 0000000..ae4cf30
>>>> --- /dev/null
>>>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>>>> @@ -0,0 +1,696 @@
>>>> +/*
>>>> + * STMicroelectronics st_lsm6dsx sensor driver
>>> Perhaps a little more detail on the device in here?
>>>> + *
>>>> + * Copyright 2016 STMicroelectronics Inc.
>>>> + *
>>>> + * Lorenzo Bianconi <lorenzo.bianconi@st.com>
>>>> + * Denis Ciocca <denis.ciocca@st.com>
>>>> + *
>>>> + * Licensed under the GPL-2.
>>>> + */
>>>> +
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/delay.h>
>>>> +#include <linux/iio/iio.h>
>>>> +#include <linux/iio/sysfs.h>
>>>> +#include <asm/unaligned.h>
>>>> +
>>>> +#include "st_lsm6dsx.h"
>>>> +
>>>> +#define ST_LSM6DSX_REG_ACC_DEC_MASK          0x07
>>>> +#define ST_LSM6DSX_REG_GYRO_DEC_MASK         0x38
>>>> +#define ST_LSM6DSX_REG_INT1_ADDR             0x0d
>>>> +#define ST_LSM6DSX_REG_FIFO_FTH_IRQ_MASK     0x08
>>>> +#define ST_LSM6DSX_REG_WHOAMI_ADDR           0x0f
>>>> +#define ST_LSM6DSX_REG_RESET_ADDR            0x12
>>>> +#define ST_LSM6DSX_REG_RESET_MASK            0x01
>>>> +#define ST_LSM6DSX_REG_BDU_ADDR                      0x12
>>>> +#define ST_LSM6DSX_REG_BDU_MASK                      0x40
>>>> +#define ST_LSM6DSX_REG_INT2_ON_INT1_ADDR     0x13
>>>> +#define ST_LSM6DSX_REG_INT2_ON_INT1_MASK     0x20
>>>> +#define ST_LSM6DSX_REG_ROUNDING_ADDR         0x16
>>>> +#define ST_LSM6DSX_REG_ROUNDING_MASK         0x04
>>>> +#define ST_LSM6DSX_REG_LIR_ADDR                      0x58
>>>> +#define ST_LSM6DSX_REG_LIR_MASK                      0x01
>>>> +
>>>> +#define ST_LSM6DSX_REG_ACC_ODR_ADDR          0x10
>>>> +#define ST_LSM6DSX_REG_ACC_ODR_MASK          0xf0
>>>> +#define ST_LSM6DSX_REG_ACC_FS_ADDR           0x10
>>>> +#define ST_LSM6DSX_REG_ACC_FS_MASK           0x0c
>>>> +#define ST_LSM6DSX_REG_ACC_OUT_X_L_ADDR              0x28
>>>> +#define ST_LSM6DSX_REG_ACC_OUT_Y_L_ADDR              0x2a
>>>> +#define ST_LSM6DSX_REG_ACC_OUT_Z_L_ADDR              0x2c
>>>> +
>>>> +#define ST_LSM6DSX_REG_GYRO_ODR_ADDR         0x11
>>>> +#define ST_LSM6DSX_REG_GYRO_ODR_MASK         0xf0
>>>> +#define ST_LSM6DSX_REG_GYRO_FS_ADDR          0x11
>>>> +#define ST_LSM6DSX_REG_GYRO_FS_MASK          0x0c
>>>> +#define ST_LSM6DSX_REG_GYRO_OUT_X_L_ADDR     0x22
>>>> +#define ST_LSM6DSX_REG_GYRO_OUT_Y_L_ADDR     0x24
>>>> +#define ST_LSM6DSX_REG_GYRO_OUT_Z_L_ADDR     0x26
>>>> +
>>>> +#define ST_LSM6DS3_WHOAMI                    0x69
>>>> +#define ST_LSM6DSM_WHOAMI                    0x6a
>>>> +
>>>> +#define ST_LSM6DS3_MAX_FIFO_SIZE             8192
>>>> +#define ST_LSM6DSM_MAX_FIFO_SIZE             4096
>>>> +
>>>> +#define ST_LSM6DSX_ACC_FS_2G_GAIN            IIO_G_TO_M_S_2(61)
>>>> +#define ST_LSM6DSX_ACC_FS_4G_GAIN            IIO_G_TO_M_S_2(122)
>>>> +#define ST_LSM6DSX_ACC_FS_8G_GAIN            IIO_G_TO_M_S_2(244)
>>>> +#define ST_LSM6DSX_ACC_FS_16G_GAIN           IIO_G_TO_M_S_2(488)
>>>> +
>>>> +#define ST_LSM6DSX_GYRO_FS_245_GAIN          IIO_DEGREE_TO_RAD(4375)
>>>> +#define ST_LSM6DSX_GYRO_FS_500_GAIN          IIO_DEGREE_TO_RAD(8750)
>>>> +#define ST_LSM6DSX_GYRO_FS_1000_GAIN         IIO_DEGREE_TO_RAD(17500)
>>>> +#define ST_LSM6DSX_GYRO_FS_2000_GAIN         IIO_DEGREE_TO_RAD(70000)
>>>> +
>>>> +struct st_lsm6dsx_odr {
>>>> +     u16 hz;
>>>> +     u8 val;
>>>> +};
>>>> +
>>>> +#define ST_LSM6DSX_ODR_LIST_SIZE     6
>>>> +struct st_lsm6dsx_odr_table_entry {
>>>> +     struct st_lsm6dsx_reg reg;
>>>> +     struct st_lsm6dsx_odr odr_avl[ST_LSM6DSX_ODR_LIST_SIZE];
>>>> +};
>>>> +
>>>> +static const struct st_lsm6dsx_odr_table_entry st_lsm6dsx_odr_table[] = {
>>>> +     [ST_LSM6DSX_ID_ACC] = {
>>>> +             .reg = {
>>>> +                     .addr = ST_LSM6DSX_REG_ACC_ODR_ADDR,
>>>> +                     .mask = ST_LSM6DSX_REG_ACC_ODR_MASK,
>>>> +             },
>>>> +             .odr_avl[0] = {  13, 0x01 },
>>>> +             .odr_avl[1] = {  26, 0x02 },
>>>> +             .odr_avl[2] = {  52, 0x03 },
>>>> +             .odr_avl[3] = { 104, 0x04 },
>>>> +             .odr_avl[4] = { 208, 0x05 },
>>>> +             .odr_avl[5] = { 416, 0x06 },
>>>> +     },
>>>> +     [ST_LSM6DSX_ID_GYRO] = {
>>>> +             .reg = {
>>>> +                     .addr = ST_LSM6DSX_REG_GYRO_ODR_ADDR,
>>>> +                     .mask = ST_LSM6DSX_REG_GYRO_ODR_MASK,
>>>> +             },
>>>> +             .odr_avl[0] = {  13, 0x01 },
>>>> +             .odr_avl[1] = {  26, 0x02 },
>>>> +             .odr_avl[2] = {  52, 0x03 },
>>>> +             .odr_avl[3] = { 104, 0x04 },
>>>> +             .odr_avl[4] = { 208, 0x05 },
>>>> +             .odr_avl[5] = { 416, 0x06 },
>>>> +     }
>>>> +};
>>>> +
>>>> +struct st_lsm6dsx_fs {
>>>> +     u32 gain;
>>>> +     u8 val;
>>>> +};
>>>> +
>>>> +#define ST_LSM6DSX_FS_LIST_SIZE              4
>>>> +struct st_lsm6dsx_fs_table_entry {
>>>> +     struct st_lsm6dsx_reg reg;
>>>> +     struct st_lsm6dsx_fs fs_avl[ST_LSM6DSX_FS_LIST_SIZE];
>>>> +};
>>>> +
>>>> +static const struct st_lsm6dsx_fs_table_entry st_lsm6dsx_fs_table[] = {
>>>> +     [ST_LSM6DSX_ID_ACC] = {
>>>> +             .reg = {
>>>> +                     .addr = ST_LSM6DSX_REG_ACC_FS_ADDR,
>>>> +                     .mask = ST_LSM6DSX_REG_ACC_FS_MASK,
>>>> +             },
>>>> +             .fs_avl[0] = {  ST_LSM6DSX_ACC_FS_2G_GAIN, 0x0 },
>>>> +             .fs_avl[1] = {  ST_LSM6DSX_ACC_FS_4G_GAIN, 0x2 },
>>>> +             .fs_avl[2] = {  ST_LSM6DSX_ACC_FS_8G_GAIN, 0x3 },
>>>> +             .fs_avl[3] = { ST_LSM6DSX_ACC_FS_16G_GAIN, 0x1 },
>>>> +     },
>>>> +     [ST_LSM6DSX_ID_GYRO] = {
>>>> +             .reg = {
>>>> +                     .addr = ST_LSM6DSX_REG_GYRO_FS_ADDR,
>>>> +                     .mask = ST_LSM6DSX_REG_GYRO_FS_MASK,
>>>> +             },
>>>> +             .fs_avl[0] = {  ST_LSM6DSX_GYRO_FS_245_GAIN, 0x0 },
>>>> +             .fs_avl[1] = {  ST_LSM6DSX_GYRO_FS_500_GAIN, 0x1 },
>>>> +             .fs_avl[2] = { ST_LSM6DSX_GYRO_FS_1000_GAIN, 0x2 },
>>>> +             .fs_avl[3] = { ST_LSM6DSX_GYRO_FS_2000_GAIN, 0x3 },
>>>> +     }
>>>> +};
>>>> +
>>>> +static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>>>> +     {
>>>> +             .wai = ST_LSM6DS3_WHOAMI,
>>>> +             .max_fifo_size = ST_LSM6DS3_MAX_FIFO_SIZE,
>>>> +     },
>>>> +     {
>>>> +             .wai = ST_LSM6DSM_WHOAMI,
>>>> +             .max_fifo_size = ST_LSM6DSM_MAX_FIFO_SIZE,
>>>> +     },
>>>> +};
>>>> +
>>>> +static const struct iio_chan_spec st_lsm6dsx_acc_channels[] = {
>>>> +     {
>>>> +             .type = IIO_ACCEL,
>>>> +             .address = ST_LSM6DSX_REG_ACC_OUT_X_L_ADDR,
>>>> +             .modified = 1,
>>>> +             .channel2 = IIO_MOD_X,
>>>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>>>> +                                   BIT(IIO_CHAN_INFO_SCALE),
>>>> +             .info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>>>> +             .scan_index = 0,
>>>> +             .scan_type = {
>>>> +                     .sign = 's',
>>>> +                     .realbits = 16,
>>>> +                     .storagebits = 16,
>>>> +                     .endianness = IIO_LE,
>>>> +             },
>>>> +     },
>>>> +     {
>>>> +             .type = IIO_ACCEL,
>>>> +             .address = ST_LSM6DSX_REG_ACC_OUT_Y_L_ADDR,
>>>> +             .modified = 1,
>>>> +             .channel2 = IIO_MOD_Y,
>>>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>>>> +                                   BIT(IIO_CHAN_INFO_SCALE),
>>>> +             .info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>>>> +             .scan_index = 1,
>>>> +             .scan_type = {
>>>> +                     .sign = 's',
>>>> +                     .realbits = 16,
>>>> +                     .storagebits = 16,
>>>> +                     .endianness = IIO_LE,
>>>> +             },
>>>> +     },
>>>> +     {
>>>> +             .type = IIO_ACCEL,
>>>> +             .address = ST_LSM6DSX_REG_ACC_OUT_Z_L_ADDR,
>>>> +             .modified = 1,
>>>> +             .channel2 = IIO_MOD_Z,
>>>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>>>> +                                   BIT(IIO_CHAN_INFO_SCALE),
>>>> +             .info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>>>> +             .scan_index = 2,
>>>> +             .scan_type = {
>>>> +                     .sign = 's',
>>>> +                     .realbits = 16,
>>>> +                     .storagebits = 16,
>>>> +                     .endianness = IIO_LE,
>>>> +             },
>>>> +     },
>>>> +     IIO_CHAN_SOFT_TIMESTAMP(3),
>>>> +};
>>>> +
>>>> +static const struct iio_chan_spec st_lsm6dsx_gyro_channels[] = {
>>>> +     {
>>>> +             .type = IIO_ANGL_VEL,
>>>> +             .address = ST_LSM6DSX_REG_GYRO_OUT_X_L_ADDR,
>>>> +             .modified = 1,
>>>> +             .channel2 = IIO_MOD_X,
>>>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>>>> +                                   BIT(IIO_CHAN_INFO_SCALE),
>>>> +             .info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>>>> +             .scan_index = 0,
>>>> +             .scan_type = {
>>>> +                     .sign = 's',
>>>> +                     .realbits = 16,
>>>> +                     .storagebits = 16,
>>>> +                     .endianness = IIO_LE,
>>>> +             },
>>>> +     },
>>>> +     {
>>>> +             .type = IIO_ANGL_VEL,
>>>> +             .address = ST_LSM6DSX_REG_GYRO_OUT_Y_L_ADDR,
>>>> +             .modified = 1,
>>>> +             .channel2 = IIO_MOD_Y,
>>>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>>>> +                                   BIT(IIO_CHAN_INFO_SCALE),
>>>> +             .info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>>>> +             .scan_index = 1,
>>>> +             .scan_type = {
>>>> +                     .sign = 's',
>>>> +                     .realbits = 16,
>>>> +                     .storagebits = 16,
>>>> +                     .endianness = IIO_LE,
>>>> +             },
>>>> +     },
>>>> +     {
>>>> +             .type = IIO_ANGL_VEL,
>>>> +             .address = ST_LSM6DSX_REG_GYRO_OUT_Z_L_ADDR,
>>>> +             .modified = 1,
>>>> +             .channel2 = IIO_MOD_Z,
>>>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>>>> +                                   BIT(IIO_CHAN_INFO_SCALE),
>>>> +             .info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>>>> +             .scan_index = 2,
>>>> +             .scan_type = {
>>>> +                     .sign = 's',
>>>> +                     .realbits = 16,
>>>> +                     .storagebits = 16,
>>>> +                     .endianness = IIO_LE,
>>>> +             },
>>>> +     },
>>>> +     IIO_CHAN_SOFT_TIMESTAMP(3),
>>>> +};
>>>> +
>>>> +int st_lsm6dsx_write_with_mask(struct st_lsm6dsx_hw *hw, u8 addr, u8 mask,
>>>> +                            u8 val)
>>>> +{
>>>> +     u8 data;
>>>> +     int err;
>>>> +
>>>> +     mutex_lock(&hw->lock);
>>>> +
>>>> +     err = hw->tf->read(hw->dev, addr, sizeof(data), &data);
>>>> +     if (err < 0) {
>>>> +             dev_err(hw->dev, "failed to read %02x register\n", addr);
>>>> +             goto out;
>>>> +     }
>>>> +
>>>> +     data = (data & ~mask) | ((val << __ffs(mask)) & mask);
>>>> +
>>>> +     err = hw->tf->write(hw->dev, addr, sizeof(data), &data);
>>>> +     if (err < 0)
>>>> +             dev_err(hw->dev, "failed to write %02x register\n", addr);
>>>> +
>>>> +out:
>>>> +     mutex_unlock(&hw->lock);
>>>> +
>>>> +     return err;
>>>> +}
>>>> +
>>>> +static int st_lsm6dsx_check_whoami(struct st_lsm6dsx_hw *hw)
>>>> +{
>>>> +     int err, i;
>>>> +     u8 data;
>>>> +
>>>> +     err = hw->tf->read(hw->dev, ST_LSM6DSX_REG_WHOAMI_ADDR, sizeof(data),
>>>> +                        &data);
>>>> +     if (err < 0) {
>>>> +             dev_err(hw->dev, "failed to read whoami register\n");
>>>> +             return err;
>>>> +     }
>>>> +
>>>> +     for (i = 0; i < ARRAY_SIZE(st_lsm6dsx_sensor_settings); i++) {
>>>> +             if (data == st_lsm6dsx_sensor_settings[i].wai) {
>>>> +                     hw->settings = &st_lsm6dsx_sensor_settings[i];
>>>> +                     break;
>>>> +             }
>>>> +     }
>>>> +
>>>> +     if (i == ARRAY_SIZE(st_lsm6dsx_sensor_settings)) {
>>>> +             dev_err(hw->dev, "unsupported whoami [%02x]\n", data);
>>>> +             return -ENODEV;
>>>> +     }
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static int st_lsm6dsx_set_fs(struct st_lsm6dsx_sensor *sensor, u32 gain)
>>> full_scale?  Better to let the naming make it obvious rather than making
>>> reviewers think about it ;)  Same for other abreviations - particularly
>>> in function names.
>>>> +{
>>>> +     enum st_lsm6dsx_sensor_id id = sensor->id;
>>>> +     int i, err;
>>>> +     u8 val;
>>>> +
>>>> +     for (i = 0; i < ST_LSM6DSX_FS_LIST_SIZE; i++)
>>>> +             if (st_lsm6dsx_fs_table[id].fs_avl[i].gain == gain)
>>>> +                     break;
>>>> +
>>>> +     if (i == ST_LSM6DSX_FS_LIST_SIZE)
>>>> +             return -EINVAL;
>>>> +
>>>> +     val = st_lsm6dsx_fs_table[id].fs_avl[i].val;
>>>> +     err = st_lsm6dsx_write_with_mask(sensor->hw,
>>>> +                                      st_lsm6dsx_fs_table[id].reg.addr,
>>>> +                                      st_lsm6dsx_fs_table[id].reg.mask,
>>>> +                                      val);
>>>> +     if (err < 0)
>>>> +             return err;
>>>> +
>>>> +     sensor->gain = gain;
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static int st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sensor, u16 odr)
>>>> +{
>>>> +     enum st_lsm6dsx_sensor_id id = sensor->id;
>>>> +     int i, err, val;
>>>> +
>>>> +     for (i = 0; i < ST_LSM6DSX_ODR_LIST_SIZE; i++)
>>>> +             if (st_lsm6dsx_odr_table[id].odr_avl[i].hz == odr)
>>>> +                     break;
>>>> +
>>>> +     if (i == ST_LSM6DSX_ODR_LIST_SIZE)
>>>> +             return -EINVAL;
>>>> +
>>>> +     val = st_lsm6dsx_odr_table[id].odr_avl[i].val;
>>>> +     err = st_lsm6dsx_write_with_mask(sensor->hw,
>>>> +                                      st_lsm6dsx_odr_table[id].reg.addr,
>>>> +                                      st_lsm6dsx_odr_table[id].reg.mask,
>>>> +                                      val);
>>>> +     if (err < 0)
>>>> +             return err;
>>>> +
>>>> +     sensor->odr = odr;
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +int st_lsm6dsx_sensor_enable(struct st_lsm6dsx_sensor *sensor)
>>>> +{
>>>> +     int err;
>>>> +
>>>> +     err = st_lsm6dsx_set_odr(sensor, sensor->odr);
>>>> +     if (err < 0)
>>>> +             return err;
>>>> +
>>>> +     sensor->hw->enable_mask |= BIT(sensor->id);
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +int st_lsm6dsx_sensor_disable(struct st_lsm6dsx_sensor *sensor)
>>>> +{
>>>> +     enum st_lsm6dsx_sensor_id id = sensor->id;
>>>> +     int err;
>>>> +
>>>> +     err = st_lsm6dsx_write_with_mask(sensor->hw,
>>>> +                                      st_lsm6dsx_odr_table[id].reg.addr,
>>>> +                                      st_lsm6dsx_odr_table[id].reg.mask, 0);
>>>> +     if (err < 0)
>>>> +             return err;
>>>> +
>>>> +     sensor->hw->enable_mask &= ~BIT(id);
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static int st_lsm6dsx_read_oneshot(struct st_lsm6dsx_sensor *sensor,
>>>> +                                u8 addr, int *val)
>>>> +{
>>>> +     int err, delay;
>>>> +     u8 data[2];
>>>> +
>>>> +     err = st_lsm6dsx_sensor_enable(sensor);
>>>> +     if (err < 0)
>>>> +             return err;
>>>> +
>>>> +     delay = 1000000 / sensor->odr;
>>>> +     usleep_range(delay, 2 * delay);
>>>> +
>>>> +     err = sensor->hw->tf->read(sensor->hw->dev, addr, sizeof(data), data);
>>>> +     if (err < 0)
>>>> +             return err;
>>>> +
>>>> +     st_lsm6dsx_sensor_disable(sensor);
>>>> +
>>>> +     *val = (s16)get_unaligned_le16(data);
>>>> +
>>>> +     return IIO_VAL_INT;
>>>> +}
>>>> +
>>>> +static int st_lsm6dsx_read_raw(struct iio_dev *iio_dev,
>>>> +                            struct iio_chan_spec const *ch,
>>>> +                            int *val, int *val2, long mask)
>>>> +{
>>>> +     struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
>>>> +     int ret;
>>>> +
>>>> +     ret = iio_device_claim_direct_mode(iio_dev);
>>>> +     if (ret)
>>>> +             return ret;
>>>> +
>>>> +     switch (mask) {
>>>> +     case IIO_CHAN_INFO_RAW:
>>>> +             ret = st_lsm6dsx_read_oneshot(sensor, ch->address, val);
>>>> +             break;
>>>> +     case IIO_CHAN_INFO_SAMP_FREQ:
>>>> +             *val = sensor->odr;
>>>> +             ret = IIO_VAL_INT;
>>>> +             break;
>>>> +     case IIO_CHAN_INFO_SCALE:
>>>> +             *val = 0;
>>>> +             *val2 = sensor->gain;
>>>> +             ret = IIO_VAL_INT_PLUS_MICRO;
>>>> +             break;
>>>> +     default:
>>>> +             ret = -EINVAL;
>>>> +             break;
>>>> +     }
>>>> +
>>>> +     iio_device_release_direct_mode(iio_dev);
>>>> +
>>>> +     return ret;
>>>> +}
>>>> +
>>>> +static int st_lsm6dsx_write_raw(struct iio_dev *iio_dev,
>>>> +                             struct iio_chan_spec const *chan,
>>>> +                             int val, int val2, long mask)
>>>> +{
>>>> +     struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
>>>> +     int err;
>>>> +
>>>> +     err = iio_device_claim_direct_mode(iio_dev);
>>>> +     if (err)
>>>> +             return err;
>>>> +
>>>> +     switch (mask) {
>>>> +     case IIO_CHAN_INFO_SCALE:
>>>> +             err = st_lsm6dsx_set_fs(sensor, val2);
>>>> +             break;
>>>> +     case IIO_CHAN_INFO_SAMP_FREQ:
>>>> +             err = st_lsm6dsx_set_odr(sensor, val);
>>>> +             break;
>>>> +     default:
>>>> +             err = -EINVAL;
>>>> +             break;
>>>> +     }
>>>> +
>>>> +     iio_device_release_direct_mode(iio_dev);
>>>> +
>>>> +     return err;
>>>> +}
>>>> +
>>>> +static int st_lsm6dsx_set_watermark(struct iio_dev *iio_dev, unsigned int val)
>>>> +{
>>>> +     struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
>>>> +     struct st_lsm6dsx_hw *hw = sensor->hw;
>>>> +     int err, max_fifo_len;
>>>> +
>>>> +     max_fifo_len = hw->settings->max_fifo_size / ST_LSM6DSX_SAMPLE_SIZE;
>>>> +     if (val < 1 || val > max_fifo_len)
>>>> +             return -EINVAL;
>>>> +
>>>> +     err = st_lsm6dsx_update_watermark(sensor, val);
>>>> +     if (err < 0)
>>>> +             return err;
>>>> +
>>>> +     sensor->watermark = val;
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>> You could port these over to the new available infrastructure
>>> (see new callbacks in iio_info) but fine if you'd prefer not to for
>>> now as that is very new.
>>>> +static ssize_t
>>>> +st_lsm6dsx_sysfs_sampling_frequency_avl(struct device *dev,
>>>> +                                     struct device_attribute *attr,
>>>> +                                     char *buf)
>>>> +{
>>>> +     struct st_lsm6dsx_sensor *sensor = iio_priv(dev_get_drvdata(dev));
>>>> +     enum st_lsm6dsx_sensor_id id = sensor->id;
>>>> +     int i, len = 0;
>>>> +
>>>> +     for (i = 0; i < ST_LSM6DSX_ODR_LIST_SIZE; i++)
>>>> +             len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
>>>> +                              st_lsm6dsx_odr_table[id].odr_avl[i].hz);
>>>> +     buf[len - 1] = '\n';
>>>> +
>>>> +     return len;
>>>> +}
>>>> +
>>>> +static ssize_t st_lsm6dsx_sysfs_scale_avail(struct device *dev,
>>>> +                                         struct device_attribute *attr,
>>>> +                                         char *buf)
>>>> +{
>>>> +     struct st_lsm6dsx_sensor *sensor = iio_priv(dev_get_drvdata(dev));
>>>> +     enum st_lsm6dsx_sensor_id id = sensor->id;
>>>> +     int i, len = 0;
>>>> +
>>>> +     for (i = 0; i < ST_LSM6DSX_FS_LIST_SIZE; i++)
>>>> +             len += scnprintf(buf + len, PAGE_SIZE - len, "0.%06u ",
>>>> +                              st_lsm6dsx_fs_table[id].fs_avl[i].gain);
>>>> +     buf[len - 1] = '\n';
>>>> +
>>>> +     return len;
>>>> +}
>>>> +
>>>> +static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(st_lsm6dsx_sysfs_sampling_frequency_avl);
>>>> +static IIO_DEVICE_ATTR(in_accel_scale_available, 0444,
>>>> +                    st_lsm6dsx_sysfs_scale_avail, NULL, 0);
>>>> +static IIO_DEVICE_ATTR(in_anglvel_scale_available, 0444,
>>>> +                    st_lsm6dsx_sysfs_scale_avail, NULL, 0);
>>>> +
>>>> +static struct attribute *st_lsm6dsx_acc_attributes[] = {
>>>> +     &iio_dev_attr_sampling_frequency_available.dev_attr.attr,
>>>> +     &iio_dev_attr_in_accel_scale_available.dev_attr.attr,
>>>> +     NULL,
>>>> +};
>>>> +
>>>> +static const struct attribute_group st_lsm6dsx_acc_attribute_group = {
>>>> +     .attrs = st_lsm6dsx_acc_attributes,
>>>> +};
>>>> +
>>>> +static const struct iio_info st_lsm6dsx_acc_info = {
>>>> +     .driver_module = THIS_MODULE,
>>>> +     .attrs = &st_lsm6dsx_acc_attribute_group,
>>>> +     .read_raw = st_lsm6dsx_read_raw,
>>>> +     .write_raw = st_lsm6dsx_write_raw,
>>>> +     .hwfifo_set_watermark = st_lsm6dsx_set_watermark,
>>>> +};
>>>> +
>>>> +static struct attribute *st_lsm6dsx_gyro_attributes[] = {
>>>> +     &iio_dev_attr_sampling_frequency_available.dev_attr.attr,
>>>> +     &iio_dev_attr_in_anglvel_scale_available.dev_attr.attr,
>>>> +     NULL,
>>>> +};
>>>> +
>>>> +static const struct attribute_group st_lsm6dsx_gyro_attribute_group = {
>>>> +     .attrs = st_lsm6dsx_gyro_attributes,
>>>> +};
>>>> +
>>>> +static const struct iio_info st_lsm6dsx_gyro_info = {
>>>> +     .driver_module = THIS_MODULE,
>>>> +     .attrs = &st_lsm6dsx_gyro_attribute_group,
>>>> +     .read_raw = st_lsm6dsx_read_raw,
>>>> +     .write_raw = st_lsm6dsx_write_raw,
>>>> +     .hwfifo_set_watermark = st_lsm6dsx_set_watermark,
>>>> +};
>>>> +
>>>> +static const unsigned long st_lsm6dsx_available_scan_masks[] = {0x7, 0x0};
>>>> +
>>>> +static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
>>>> +{
>>>> +     int err;
>>>> +     u8 data;
>>>> +
>>>> +     data = ST_LSM6DSX_REG_RESET_MASK;
>>>> +     err = hw->tf->write(hw->dev, ST_LSM6DSX_REG_RESET_ADDR, sizeof(data),
>>>> +                         &data);
>>>> +     if (err < 0)
>>>> +             return err;
>>>> +
>>>> +     msleep(200);
>>>> +
>>>> +     /* latch interrupts */
>>>> +     err = st_lsm6dsx_write_with_mask(hw, ST_LSM6DSX_REG_LIR_ADDR,
>>>> +                                      ST_LSM6DSX_REG_LIR_MASK, 1);
>>>> +     if (err < 0)
>>>> +             return err;
>>>> +
>>>> +     /* enable BDU */
>>> Expand BDU rather than using the acronym.
>>>> +     err = st_lsm6dsx_write_with_mask(hw, ST_LSM6DSX_REG_BDU_ADDR,
>>>> +                                      ST_LSM6DSX_REG_BDU_MASK, 1);
>>>> +     if (err < 0)
>>>> +             return err;
>>>> +
>>>> +     err = st_lsm6dsx_write_with_mask(hw, ST_LSM6DSX_REG_ROUNDING_ADDR,
>>>> +                                      ST_LSM6DSX_REG_ROUNDING_MASK, 1);
>>>> +     if (err < 0)
>>>> +             return err;
>>>> +
>>>> +     /* enable FIFO watermak interrupt */
>>>> +     err = st_lsm6dsx_write_with_mask(hw, ST_LSM6DSX_REG_INT1_ADDR,
>>>> +                                      ST_LSM6DSX_REG_FIFO_FTH_IRQ_MASK, 1);
>>>> +     if (err < 0)
>>>> +             return err;
>>>> +
>>>> +     /* redirect INT2 on INT1 */
>>>> +     return st_lsm6dsx_write_with_mask(hw, ST_LSM6DSX_REG_INT2_ON_INT1_ADDR,
>>>> +                                       ST_LSM6DSX_REG_INT2_ON_INT1_MASK, 1);
>>>> +}
>>>> +
>>>> +static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
>>>> +                                            enum st_lsm6dsx_sensor_id id)
>>>> +{
>>>> +     struct st_lsm6dsx_sensor *sensor;
>>>> +     struct iio_dev *iio_dev;
>>>> +
>>>> +     iio_dev = devm_iio_device_alloc(hw->dev, sizeof(*sensor));
>>>> +     if (!iio_dev)
>>>> +             return NULL;
>>>> +
>>>> +     iio_dev->modes = INDIO_DIRECT_MODE;
>>>> +     iio_dev->dev.parent = hw->dev;
>>>> +     iio_dev->available_scan_masks = st_lsm6dsx_available_scan_masks;
>>>> +
>>>> +     sensor = iio_priv(iio_dev);
>>>> +     sensor->id = id;
>>>> +     sensor->hw = hw;
>>>> +     sensor->odr = st_lsm6dsx_odr_table[id].odr_avl[0].hz;
>>>> +     sensor->gain = st_lsm6dsx_fs_table[id].fs_avl[0].gain;
>>>> +     sensor->watermark = 1;
>>>> +
>>>> +     switch (id) {
>>>> +     case ST_LSM6DSX_ID_ACC:
>>>> +             iio_dev->channels = st_lsm6dsx_acc_channels;
>>>> +             iio_dev->num_channels = ARRAY_SIZE(st_lsm6dsx_acc_channels);
>>>> +             iio_dev->name = "lsm6dsx_accel";
>>>> +             iio_dev->info = &st_lsm6dsx_acc_info;
>>>> +
>>>> +             sensor->decimator_mask = ST_LSM6DSX_REG_ACC_DEC_MASK;
>>>> +             break;
>>>> +     case ST_LSM6DSX_ID_GYRO:
>>>> +             iio_dev->channels = st_lsm6dsx_gyro_channels;
>>>> +             iio_dev->num_channels = ARRAY_SIZE(st_lsm6dsx_gyro_channels);
>>>> +             iio_dev->name = "lsm6dsx_gyro";
>>>> +             iio_dev->info = &st_lsm6dsx_gyro_info;
>>>> +
>>>> +             sensor->decimator_mask = ST_LSM6DSX_REG_GYRO_DEC_MASK;
>>>> +             break;
>>>> +     default:
>>>> +             return NULL;
>>>> +     }
>>>> +
>>>> +     return iio_dev;
>>>> +}
>>>> +
>>>> +int st_lsm6dsx_probe(struct st_lsm6dsx_hw *hw)
>>>> +{
>>>> +     int i, err;
>>>> +
>>>> +     mutex_init(&hw->lock);
>>>> +
>>>> +     err = st_lsm6dsx_check_whoami(hw);
>>>> +     if (err < 0)
>>>> +             return err;
>>>> +
>>>> +     for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
>>>> +             hw->iio_devs[i] = st_lsm6dsx_alloc_iiodev(hw, i);
>>>> +             if (!hw->iio_devs[i])
>>>> +                     return -ENOMEM;
>>>> +     }
>>>> +
>>>> +     err = st_lsm6dsx_init_device(hw);
>>>> +     if (err < 0)
>>>> +             return err;
>>>> +
>>>> +     if (hw->irq > 0) {
>>>> +             err = st_lsm6dsx_allocate_rings(hw);
>>>> +             if (err < 0)
>>>> +                     return err;
>>>> +     }
>>>> +
>>>> +     for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
>>>> +             err = devm_iio_device_register(hw->dev, hw->iio_devs[i]);
>>>> +             if (err)
>>>> +                     return err;
>>>> +     }
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +EXPORT_SYMBOL(st_lsm6dsx_probe);
>>>> +
>>>> +MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
>>>> +MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
>>>> +MODULE_DESCRIPTION("STMicroelectronics st_lsm6dsx driver");
>>>> +MODULE_LICENSE("GPL v2");
>>>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
>>>> new file mode 100644
>>>> index 0000000..c80e624
>>>> --- /dev/null
>>>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
>>>> @@ -0,0 +1,111 @@
>>>> +/*
>>>> + * STMicroelectronics st_lsm6dsx i2c driver
>>>> + *
>>>> + * Copyright 2016 STMicroelectronics Inc.
>>>> + *
>>>> + * Lorenzo Bianconi <lorenzo.bianconi@st.com>
>>>> + * Denis Ciocca <denis.ciocca@st.com>
>>>> + *
>>>> + * Licensed under the GPL-2.
>>>> + */
>>>> +
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/i2c.h>
>>>> +#include <linux/slab.h>
>>>> +#include <linux/of.h>
>>>> +
>>>> +#include "st_lsm6dsx.h"
>>>> +
>>>> +static int st_lsm6dsx_i2c_read(struct device *dev, u8 addr, int len, u8 *data)
>>>> +{
>>>> +     struct i2c_client *client = to_i2c_client(dev);
>>>> +     struct i2c_msg msg[2];
>>>> +
>>>> +     msg[0].addr = client->addr;
>>>> +     msg[0].flags = client->flags;
>>>> +     msg[0].len = 1;
>>>> +     msg[0].buf = &addr;
>>>> +
>>>> +     msg[1].addr = client->addr;
>>>> +     msg[1].flags = client->flags | I2C_M_RD;
>>>> +     msg[1].len = len;
>>>> +     msg[1].buf = data;
>>>> +
>>>> +     return i2c_transfer(client->adapter, msg, 2);
>>>> +}
>>>> +
>>>> +static int st_lsm6dsx_i2c_write(struct device *dev, u8 addr, int len, u8 *data)
>>>> +{
>>>> +     struct i2c_client *client = to_i2c_client(dev);
>>>> +     struct i2c_msg msg;
>>>> +     u8 send[len + 1];
>>>> +
>>>> +     send[0] = addr;
>>>> +     memcpy(&send[1], data, len * sizeof(u8));
>>>> +
>>>> +     msg.addr = client->addr;
>>>> +     msg.flags = client->flags;
>>>> +     msg.len = len + 1;
>>>> +     msg.buf = send;
>>>> +
>>>> +     return i2c_transfer(client->adapter, &msg, 1);
>>> Could (I think) do this with the smbus_write_block_data command as long as
>>> we never use more than 32 bytes.  However, probably not worth it as the
>>> reads break those rules anyway so we'll need a fully fledged i2c controller
>>> whatever.
>>
>> We can modify read_fifo routine in order to read sample by sample and
>> not a whole pattern. In this way read size will be limited to 6B and
>> can use i2c_smbus_read_i2c_block_data()/i2c_smbus_write_i2c_block_data().
>> Do you agree?
> If we are limited in this way then perhaps it's best to leave it as is.
> I've no idea if we will hit limitations on individual i2c controllers though.
> They tend not to be as designed for streaming as spi ones are..

Ack. I will send out v4 with fledged I2C support. Sorry for the noise.

>>
>>>> +}
>>>> +
>>>> +static const struct st_lsm6dsx_transfer_function st_lsm6dsx_transfer_fn = {
>>>> +     .read = st_lsm6dsx_i2c_read,
>>>> +     .write = st_lsm6dsx_i2c_write,
>>>> +};
>>>> +
>>>> +static int st_lsm6dsx_i2c_probe(struct i2c_client *client,
>>>> +                             const struct i2c_device_id *id)
>>>> +{
>>>> +     struct st_lsm6dsx_hw *hw;
>>>> +
>>>> +     hw = devm_kzalloc(&client->dev, sizeof(*hw), GFP_KERNEL);
>>>> +     if (!hw)
>>>> +             return -ENOMEM;
>>>> +
>>>> +     i2c_set_clientdata(client, hw);
>>>> +     hw->name = client->name;
>>>> +     hw->dev = &client->dev;
>>>> +     hw->irq = client->irq;
>>>> +     hw->tf = &st_lsm6dsx_transfer_fn;
>>>> +
>>>> +     return st_lsm6dsx_probe(hw);
>>>> +}
>>>> +
>>>> +static const struct of_device_id st_lsm6dsx_i2c_of_match[] = {
>>>> +     {
>>>> +             .compatible = "st,lsm6ds3",
>>>> +             .data = ST_LSM6DS3_DEV_NAME,
>>>> +     },
>>>> +     {
>>>> +             .compatible = "st,lsm6dsm",
>>>> +             .data = ST_LSM6DSM_DEV_NAME,
>>>> +     },
>>>> +     {},
>>>> +};
>>>> +MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
>>>> +
>>>> +static const struct i2c_device_id st_lsm6dsx_i2c_id_table[] = {
>>>> +     { ST_LSM6DS3_DEV_NAME },
>>>> +     { ST_LSM6DSM_DEV_NAME },
>>>> +     {},
>>>> +};
>>>> +MODULE_DEVICE_TABLE(i2c, st_lsm6dsx_i2c_id_table);
>>>> +
>>>> +static struct i2c_driver st_lsm6dsx_driver = {
>>>> +     .driver = {
>>>> +             .name = "st_lsm6dsx_i2c",
>>>> +             .of_match_table = of_match_ptr(st_lsm6dsx_i2c_of_match),
>>>> +     },
>>>> +     .probe = st_lsm6dsx_i2c_probe,
>>>> +     .id_table = st_lsm6dsx_i2c_id_table,
>>>> +};
>>>> +module_i2c_driver(st_lsm6dsx_driver);
>>>> +
>>>> +MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
>>>> +MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
>>>> +MODULE_DESCRIPTION("STMicroelectronics st_lsm6dsx i2c driver");
>>>> +MODULE_LICENSE("GPL v2");
>>>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_ring.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_ring.c
>>>> new file mode 100644
>>>> index 0000000..9a8c503
>>>> --- /dev/null
>>>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_ring.c
>>>> @@ -0,0 +1,401 @@
>>>> +/*
>>>> + * STMicroelectronics st_lsm6dsx sensor driver
>>> Whilst it's part of the driver, a quick description of what this bit does
>>> would be good.
>>>> + *
>>>> + * Copyright 2016 STMicroelectronics Inc.
>>>> + *
>>>> + * Lorenzo Bianconi <lorenzo.bianconi@st.com>
>>>> + * Denis Ciocca <denis.ciocca@st.com>
>>>> + *
>>>> + * Licensed under the GPL-2.
>>>> + */
>>>> +#include <linux/module.h>
>>>> +#include <linux/interrupt.h>
>>>> +#include <linux/irq.h>
>>>> +#include <linux/iio/kfifo_buf.h>
>>>> +#include <asm/unaligned.h>
>>>> +
>>>> +#include "st_lsm6dsx.h"
>>>> +
>>>> +#define ST_LSM6DSX_REG_FIFO_THL_ADDR         0x06
>>>> +#define ST_LSM6DSX_REG_FIFO_THH_ADDR         0x07
>>>> +#define ST_LSM6DSX_FIFO_TH_MASK                      0x0fff
>>>> +#define ST_LSM6DSX_REG_FIFO_DEC_GXL_ADDR     0x08
>>>> +#define ST_LSM6DSX_REG_FIFO_MODE_ADDR                0x0a
>>>> +#define ST_LSM6DSX_FIFO_MODE_MASK            0x07
>>>> +#define ST_LSM6DSX_FIFO_ODR_MASK             0x78
>>>> +#define ST_LSM6DSX_REG_FIFO_DIFFL_ADDR               0x3a
>>>> +#define ST_LSM6DSX_FIFO_DIFF_MASK            0x0f
>>>> +#define ST_LSM6DSX_FIFO_EMPTY_MASK           0x10
>>>> +#define ST_LSM6DSX_REG_FIFO_OUTL_ADDR                0x3e
>>>> +
>>>> +struct st_lsm6dsx_dec_entry {
>>>> +     u8 decimator;
>>>> +     u8 val;
>>>> +};
>>>> +
>>>> +static const struct st_lsm6dsx_dec_entry st_lsm6dsx_dec_table[] = {
>>>> +     {  0, 0x0 },
>>>> +     {  1, 0x1 },
>>>> +     {  2, 0x2 },
>>>> +     {  3, 0x3 },
>>>> +     {  4, 0x4 },
>>>> +     {  8, 0x5 },
>>>> +     { 16, 0x6 },
>>>> +     { 32, 0x7 },
>>>> +};
>>>> +
>>>> +static int st_lsm6dsx_get_decimator_val(u8 val)
>>>> +{
>>>> +     int i, max_size = ARRAY_SIZE(st_lsm6dsx_dec_table);
>>>> +
>>>> +     for (i = 0; i < max_size; i++)
>>>> +             if (st_lsm6dsx_dec_table[i].decimator == val)
>>>> +                     break;
>>>> +
>>>> +     return i == max_size ? 0 : st_lsm6dsx_dec_table[i].val;
>>>> +}
>>>> +
>>>> +static void st_lsm6dsx_get_max_min_odr(struct st_lsm6dsx_hw *hw,
>>>> +                                    u16 *max_odr, u16 *min_odr)
>>>> +{
>>>> +     struct st_lsm6dsx_sensor *sensor;
>>>> +     int i;
>>>> +
>>>> +     *max_odr = 0, *min_odr = ~0;
>>>> +     for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
>>>> +             sensor = iio_priv(hw->iio_devs[i]);
>>>> +
>>>> +             if (!(hw->enable_mask & BIT(sensor->id)))
>>>> +                     continue;
>>>> +
>>>> +             *max_odr = max_t(u16, *max_odr, sensor->odr);
>>>> +             *min_odr = min_t(u16, *min_odr, sensor->odr);
>>>> +     }
>>>> +}
>>>> +
>>>> +static int st_lsm6dsx_update_decimators(struct st_lsm6dsx_hw *hw)
>>>> +{
>>>> +     struct st_lsm6dsx_sensor *sensor;
>>>> +     u16 max_odr, min_odr, sip = 0;
>>>> +     int err, i;
>>>> +     u8 data;
>>>> +
>>>> +     st_lsm6dsx_get_max_min_odr(hw, &max_odr, &min_odr);
>>>> +
>>>> +     for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
>>>> +             sensor = iio_priv(hw->iio_devs[i]);
>>>> +
>>>> +             /* update fifo decimators and sample in pattern */
>>>> +             if (hw->enable_mask & BIT(sensor->id)) {
>>>> +                     sensor->sip = sensor->odr / min_odr;
>>>> +                     sensor->decimator = max_odr / sensor->odr;
>>>> +                     data = st_lsm6dsx_get_decimator_val(sensor->decimator);
>>>> +             } else {
>>>> +                     sensor->sip = 0;
>>>> +                     sensor->decimator = 0;
>>>> +                     data = 0;
>>>> +             }
>>>> +
>>>> +             err = st_lsm6dsx_write_with_mask(hw,
>>>> +                                     ST_LSM6DSX_REG_FIFO_DEC_GXL_ADDR,
>>>> +                                     sensor->decimator_mask, data);
>>>> +             if (err < 0)
>>>> +                     return err;
>>>> +
>>>> +             sip += sensor->sip;
>>>> +     }
>>>> +     hw->sip = sip;
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
>>>> +                                 enum st_lsm6dsx_fifo_mode fifo_mode)
>>>> +{
>>>> +     u8 data;
>>>> +     int err;
>>>> +
>>>> +     switch (fifo_mode) {
>>>> +     case ST_LSM6DSX_FIFO_BYPASS:
>>>> +             data = fifo_mode;
>>>> +             break;
>>>> +     case ST_LSM6DSX_FIFO_CONT:
>>> use a define for that magic number.
>>>> +             data = fifo_mode | 0x40;
>>>> +             break;
>>>> +     default:
>>>> +             return -EINVAL;
>>>> +     }
>>>> +
>>>> +     err = hw->tf->write(hw->dev, ST_LSM6DSX_REG_FIFO_MODE_ADDR,
>>>> +                         sizeof(data), &data);
>>>> +     if (err < 0)
>>>> +             return err;
>>>> +
>>>> +     hw->fifo_mode = fifo_mode;
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +int st_lsm6dsx_update_watermark(struct st_lsm6dsx_sensor *sensor, u16 watermark)
>>>> +{
>>>> +     u16 fifo_watermark = ~0, cur_watermark, sip = 0;
>>>> +     struct st_lsm6dsx_hw *hw = sensor->hw;
>>>> +     struct st_lsm6dsx_sensor *cur_sensor;
>>>> +     int i, err;
>>>> +     u8 data;
>>>> +
>>>> +     for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
>>>> +             cur_sensor = iio_priv(hw->iio_devs[i]);
>>>> +
>>>> +             if (!(hw->enable_mask & BIT(cur_sensor->id)))
>>>> +                     continue;
>>>> +
>>>> +             cur_watermark = (cur_sensor == sensor) ? watermark
>>>> +                                                    : cur_sensor->watermark;
>>>> +
>>>> +             fifo_watermark = min_t(u16, fifo_watermark, cur_watermark);
>>>> +             sip += cur_sensor->sip;
>>>> +     }
>>>> +
>>>> +     if (!sip)
>>>> +             return 0;
>>>> +
>>>> +     fifo_watermark = max_t(u16, fifo_watermark, sip);
>>>> +     fifo_watermark = (fifo_watermark / sip) * sip;
>>>> +     fifo_watermark = fifo_watermark * ST_LSM6DSX_SAMPLE_DEPTH;
>>>> +
>>>> +     mutex_lock(&hw->lock);
>>>> +
>>>> +     err = hw->tf->read(hw->dev, ST_LSM6DSX_REG_FIFO_THH_ADDR,
>>>> +                        sizeof(data), &data);
>>>> +     if (err < 0)
>>>> +             goto out;
>>>> +
>>>> +     fifo_watermark = ((data & ~ST_LSM6DSX_FIFO_TH_MASK) << 8) |
>>>> +                       (fifo_watermark & ST_LSM6DSX_FIFO_TH_MASK);
>>>> +
>>>> +     err = hw->tf->write(hw->dev, ST_LSM6DSX_REG_FIFO_THL_ADDR,
>>>> +                         sizeof(fifo_watermark), (u8 *)&fifo_watermark);
>>>> +out:
>>>> +     mutex_unlock(&hw->lock);
>>>> +
>>>> +     return err < 0 ? err : 0;
>>>> +}
>>>> +
>>> I'd like a bit of documentation on this.  Wasn't immediately obvious to
>>> me what it returns which lead me to confusion around the return in the
>>> ring_handler_thread.
>>>
>>>> +static int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
>>>> +{
>>>> +     u16 fifo_len, pattern_len = hw->sip * ST_LSM6DSX_SAMPLE_SIZE;
>>>> +     int err, acc_sip, gyro_sip, read_len, offset, samples;
>>>> +     struct st_lsm6dsx_sensor *acc_sensor, *gyro_sensor;
>>>> +     s64 acc_ts, acc_delta_ts, gyro_ts, gyro_delta_ts;
>>>> +     u8 iio_buf[ALIGN(ST_LSM6DSX_SAMPLE_SIZE, sizeof(s64)) + sizeof(s64)];
>>>> +     u8 fifo_status[2], buf[pattern_len];
>>>> +
>>>> +     err = hw->tf->read(hw->dev, ST_LSM6DSX_REG_FIFO_DIFFL_ADDR,
>>>> +                        sizeof(fifo_status), fifo_status);
>>>> +     if (err < 0)
>>>> +             return err;
>>>> +
>>>> +     if (fifo_status[1] & ST_LSM6DSX_FIFO_EMPTY_MASK)
>>>> +             return 0;
>>>> +
>>>> +     fifo_status[1] &= ST_LSM6DSX_FIFO_DIFF_MASK;
>>>> +     fifo_len = (u16)get_unaligned_le16(fifo_status) * ST_LSM6DSX_CHAN_SIZE;
>>>> +     samples = fifo_len / ST_LSM6DSX_SAMPLE_SIZE;
>>>> +     fifo_len = (fifo_len / pattern_len) * pattern_len;
>>>> +     /*
>>>> +      * leave one complete pattern in FIFO to guarantee
>>>> +      * proper alignment
>>> That needs more info! I have no idea what you mean by a pattern for starters.
>>>> +      */
>>>> +     fifo_len -= pattern_len;
>>>> +
>>>> +     /* compute delta timestamp */
>>> I want some more info in here on why we deal with delta timestamps.
>>>> +     acc_sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
>>>> +     acc_ts = acc_sensor->ts - acc_sensor->delta_ts;
>>>> +     acc_delta_ts = div_s64(acc_sensor->delta_ts * acc_sensor->decimator,
>>>> +                            samples);
>>>> +
>>>> +     gyro_sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_GYRO]);
>>>> +     gyro_ts = gyro_sensor->ts - gyro_sensor->delta_ts;
>>>> +     gyro_delta_ts = div_s64(gyro_sensor->delta_ts * gyro_sensor->decimator,
>>>> +                             samples);
>>>> +
>>>> +     for (read_len = 0; read_len < fifo_len; read_len += pattern_len) {
>>>> +             err = hw->tf->read(hw->dev, ST_LSM6DSX_REG_FIFO_OUTL_ADDR,
>>>> +                                sizeof(buf), buf);
>>>> +             if (err < 0)
>>>> +                     return err;
>>>> +
>>>> +             gyro_sip = gyro_sensor->sip;
>>>> +             acc_sip = acc_sensor->sip;
>>>> +             offset = 0;
>>>> +
>>> Could you add a brief description here of the data layout as it would make
>>> it easier to verify this code makes sense.
>>>> +             while (acc_sip > 0 || gyro_sip > 0) {
>>>> +                     if (gyro_sip-- > 0) {
>>>> +                             memcpy(iio_buf, &buf[offset],
>>>> +                                    ST_LSM6DSX_SAMPLE_SIZE);
>>>> +                             iio_push_to_buffers_with_timestamp(
>>>> +                                     hw->iio_devs[ST_LSM6DSX_ID_GYRO],
>>>> +                                     iio_buf, gyro_ts);
>>>> +                             offset += ST_LSM6DSX_SAMPLE_SIZE;
>>>> +                             gyro_ts += gyro_delta_ts;
>>>> +                     }
>>>> +
>>>> +                     if (acc_sip-- > 0) {
>>>> +                             memcpy(iio_buf, &buf[offset],
>>>> +                                    ST_LSM6DSX_SAMPLE_SIZE);
>>>> +                             iio_push_to_buffers_with_timestamp(
>>>> +                                     hw->iio_devs[ST_LSM6DSX_ID_ACC],
>>>> +                                     iio_buf, acc_ts);
>>>> +                             offset += ST_LSM6DSX_SAMPLE_SIZE;
>>>> +                             acc_ts += acc_delta_ts;
>>>> +                     }
>>>> +             }
>>>> +     }
>>>> +
>>>> +     return read_len;
>>>> +}
>>>> +
>>>> +static int st_lsm6dsx_flush_fifo(struct st_lsm6dsx_hw *hw)
>>>> +{
>>>> +     int err;
>>>> +
>>>> +     disable_irq(hw->irq);
>>> Comment on why this is needed rather than simply locking to prevent
>>> concurrent access.
>>>> +
>>>> +     st_lsm6dsx_read_fifo(hw);
>>>> +     err = st_lsm6dsx_set_fifo_mode(hw, ST_LSM6DSX_FIFO_BYPASS);
>>>> +
>>>> +     enable_irq(hw->irq);
>>>> +
>>>> +     return err;
>>>> +}
>>>> +
>>>> +static int st_lsm6dsx_update_fifo(struct iio_dev *iio_dev, bool enable)
>>>> +{
>>>> +     struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
>>>> +     struct st_lsm6dsx_hw *hw = sensor->hw;
>>>> +     int err;
>>>> +
>>>> +     if (hw->fifo_mode != ST_LSM6DSX_FIFO_BYPASS) {
>>>> +             err = st_lsm6dsx_flush_fifo(hw);
>>>> +             if (err < 0)
>>>> +                     return err;
>>>> +     }
>>>> +
>>>> +     err = enable ? st_lsm6dsx_sensor_enable(sensor)
>>>> +                  : st_lsm6dsx_sensor_disable(sensor);
>>> I'd just do this with an if statement as it's marginally confusing to read.
>>> Trinary operators have a lot to answer for in readability!
>>>> +     if (err < 0)
>>>> +             return err;
>>>> +
>>>> +     err = st_lsm6dsx_update_decimators(hw);
>>>> +     if (err < 0)
>>>> +             return err;
>>>> +
>>>> +     err = st_lsm6dsx_update_watermark(sensor, sensor->watermark);
>>>> +     if (err < 0)
>>>> +             return err;
>>>> +
>>>> +     if (hw->enable_mask) {
>>>> +             err = st_lsm6dsx_set_fifo_mode(hw, ST_LSM6DSX_FIFO_CONT);
>>>> +             if (err < 0)
>>>> +                     return err;
>>>> +
>>> Comment here on why we should be grabbing a timestmap whilst enabling the
>>> buffer.
>>
>> it will be used as reference to compute delta_timestamp for the first
>> interrupt. Maybe not worth it
>>
>>>> +             sensor->ts = iio_get_time_ns(iio_dev);
>>>> +     }
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static irqreturn_t st_lsm6dsx_ring_handler_irq(int irq, void *private)
>>>> +{
>>>> +     struct st_lsm6dsx_hw *hw = (struct st_lsm6dsx_hw *)private;
>>>> +     struct st_lsm6dsx_sensor *sensor;
>>>> +     int i;
>>>> +
>>>> +     if (!hw->sip)
>>>> +             return IRQ_NONE;
>>>> +
>>>> +     for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
>>>> +             sensor = iio_priv(hw->iio_devs[i]);
>>>> +
>>>> +             if (sensor->sip > 0) {
>>>> +                     s64 timestamp;
>>>> +
>>>> +                     timestamp = iio_get_time_ns(hw->iio_devs[i]);
>>>> +                     sensor->delta_ts = timestamp - sensor->ts;
>>>> +                     sensor->ts = timestamp;
>>>> +             }
>>>> +     }
>>>> +
>>>> +     return IRQ_WAKE_THREAD;
>>>> +}
>>>> +
>>>> +static irqreturn_t st_lsm6dsx_ring_handler_thread(int irq, void *private)
>>>> +{
>>>> +     struct st_lsm6dsx_hw *hw = (struct st_lsm6dsx_hw *)private;
>>>> +     int count;
>>>> +
>>>> +     count = st_lsm6dsx_read_fifo(hw);
>>>> +
>>>> +     return !count ? IRQ_NONE : IRQ_HANDLED;
>>>
>>>> +}
>>>> +
>>>> +static int st_lsm6dsx_buffer_preenable(struct iio_dev *iio_dev)
>>>> +{
>>>> +     return st_lsm6dsx_update_fifo(iio_dev, true);
>>>> +}
>>>> +
>>>> +static int st_lsm6dsx_buffer_postdisable(struct iio_dev *iio_dev)
>>>> +{
>>>> +     return st_lsm6dsx_update_fifo(iio_dev, false);
>>>> +}
>>>> +
>>>> +static const struct iio_buffer_setup_ops st_lsm6dsx_buffer_ops = {
>>>> +     .preenable = st_lsm6dsx_buffer_preenable,
>>>> +     .postdisable = st_lsm6dsx_buffer_postdisable,
>>>> +};
>>>> +
>>>> +int st_lsm6dsx_allocate_rings(struct st_lsm6dsx_hw *hw)
>>>> +{
>>>> +     struct iio_buffer *buffer;
>>>> +     unsigned long irq_type;
>>>> +     int i, err;
>>>> +
>>>> +     irq_type = irqd_get_trigger_type(irq_get_irq_data(hw->irq));
>>>> +
>>>> +     switch (irq_type) {
>>>> +     case IRQF_TRIGGER_HIGH:
>>>> +     case IRQF_TRIGGER_RISING:
>>>> +             break;
>>>> +     default:
>>>> +             dev_info(hw->dev,
>>>> +                      "mode %lx unsupported, using IRQF_TRIGGER_HIGH\n",
>>>> +                      irq_type);
>>> I'd argue that if the type is 'miss specified' we should be dumping out.
>>> Obviously good to have a default for if it isn't specified at all though.
>>> Is it easy to make this distinction?
>>
>> something like if irq_type is set to IRQF_TRIGGER_NONE, overwrite it
>> with default value, whereas if is set to IRQF_TRIGGER_LOW or
>> IRQF_TRIGGER_FALLING, return -EINVAL?
> Yes - along those lines anyway.
>>
>>>> +             irq_type = IRQF_TRIGGER_HIGH;
>>>> +             break;
>>>> +     }
>>>> +
>>>> +     err = devm_request_threaded_irq(hw->dev, hw->irq,
>>>> +                                     st_lsm6dsx_ring_handler_irq,
>>>> +                                     st_lsm6dsx_ring_handler_thread,
>>>> +                                     irq_type | IRQF_ONESHOT,
>>>> +                                     hw->name, hw);
>>>> +     if (err) {
>>>> +             dev_err(hw->dev, "failed to request trigger irq %d\n",
>>>> +                     hw->irq);
>>>> +             return err;
>>>> +     }
>>>> +
>>>> +     for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
>>>> +             buffer = devm_iio_kfifo_allocate(hw->dev);
>>> Kfifo isn't a ring ;)  Probably want to rename this appropriately to reflect
>>> this.  The ring naming in various IIO drivers predates the presence of kfifo
>>> in the kernel when we had a hideous hand rolled ring buffer.
>>>> +             if (!buffer)
>>>> +                     return -ENOMEM;
>>>> +
>>>> +             iio_device_attach_buffer(hw->iio_devs[i], buffer);
>>>> +             hw->iio_devs[i]->modes |= INDIO_BUFFER_SOFTWARE;
>>>> +             hw->iio_devs[i]->setup_ops = &st_lsm6dsx_buffer_ops;
>>>> +     }
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
>>>> new file mode 100644
>>>> index 0000000..262eae6
>>>> --- /dev/null
>>>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
>>>> @@ -0,0 +1,129 @@
>>>> +/*
>>>> + * STMicroelectronics st_lsm6dsx spi driver
>>>> + *
>>>> + * Copyright 2016 STMicroelectronics Inc.
>>>> + *
>>>> + * Lorenzo Bianconi <lorenzo.bianconi@st.com>
>>>> + * Denis Ciocca <denis.ciocca@st.com>
>>>> + *
>>>> + * Licensed under the GPL-2.
>>>> + */
>>>> +
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/spi/spi.h>
>>>> +#include <linux/slab.h>
>>>> +#include <linux/of.h>
>>>> +
>>>> +#include "st_lsm6dsx.h"
>>>> +
>>>> +#define SENSORS_SPI_READ     0x80
>>>> +
>>>> +static int st_lsm6dsx_spi_read(struct device *dev, u8 addr, int len,
>>>> +                            u8 *data)
>>>> +{
>>>> +     struct spi_device *spi = to_spi_device(dev);
>>>> +     struct st_lsm6dsx_hw *hw = spi_get_drvdata(spi);
>>>> +     int err;
>>>> +
>>>> +     struct spi_transfer xfers[] = {
>>>> +             {
>>>> +                     .tx_buf = hw->tb.tx_buf,
>>>> +                     .bits_per_word = 8,
>>>> +                     .len = 1,
>>>> +             },
>>>> +             {
>>>> +                     .rx_buf = hw->tb.rx_buf,
>>>> +                     .bits_per_word = 8,
>>>> +                     .len = len,
>>>> +             }
>>>> +     };
>>>> +
>>>> +     hw->tb.tx_buf[0] = addr | SENSORS_SPI_READ;
>>>> +
>>>> +     err = spi_sync_transfer(spi, xfers,  ARRAY_SIZE(xfers));
>>>> +     if (err < 0)
>>>> +             return err;
>>>> +
>>>> +     memcpy(data, hw->tb.rx_buf, len * sizeof(u8));
>>>> +
>>>> +     return len;
>>>> +}
>>>> +
>>>> +static int st_lsm6dsx_spi_write(struct device *dev, u8 addr, int len,
>>>> +                             u8 *data)
>>>> +{
>>>> +     struct spi_device *spi = to_spi_device(dev);
>>>> +     struct st_lsm6dsx_hw *hw = spi_get_drvdata(spi);
>>>> +
>>>> +     struct spi_transfer xfers = {
>>>> +             .tx_buf = hw->tb.tx_buf,
>>>> +             .bits_per_word = 8,
>>>> +             .len = len + 1,
>>>> +     };
>>>> +
>>>> +     if (len >= ST_LSM6DSX_TX_MAX_LENGTH)
>>>> +             return -ENOMEM;
>>>> +
>>>> +     hw->tb.tx_buf[0] = addr;
>>>> +     memcpy(&hw->tb.tx_buf[1], data, len);
>>>> +
>>>> +     return spi_sync_transfer(spi, &xfers, 1);
>>> Why not spi_write?  Would be a little simpler.. Maybe not worth it, just to
>>> keep things similar between the write and read.
>>>> +}
>>>> +
>>>> +static const struct st_lsm6dsx_transfer_function st_lsm6dsx_transfer_fn = {
>>>> +     .read = st_lsm6dsx_spi_read,
>>>> +     .write = st_lsm6dsx_spi_write,
>>>> +};
>>>> +
>>>> +static int st_lsm6dsx_spi_probe(struct spi_device *spi)
>>>> +{
>>>> +     struct st_lsm6dsx_hw *hw;
>>>> +
>>>> +     hw = devm_kzalloc(&spi->dev, sizeof(*hw), GFP_KERNEL);
>>>> +     if (!hw)
>>>> +             return -ENOMEM;
>>>> +
>>>> +     spi_set_drvdata(spi, hw);
>>>> +     hw->name = spi->modalias;
>>>> +     hw->dev = &spi->dev;
>>>> +     hw->irq = spi->irq;
>>>> +     hw->tf = &st_lsm6dsx_transfer_fn;
>>>> +
>>>> +     return st_lsm6dsx_probe(hw);
>>>> +}
>>>> +
>>>> +static const struct of_device_id st_lsm6dsx_spi_of_match[] = {
>>>> +     {
>>>> +             .compatible = "st,lsm6ds3",
>>>> +             .data = ST_LSM6DS3_DEV_NAME,
>>>> +     },
>>>> +     {
>>>> +             .compatible = "st,lsm6dsm",
>>>> +             .data = ST_LSM6DSM_DEV_NAME,
>>>> +     },
>>>> +     {},
>>>> +};
>>>> +MODULE_DEVICE_TABLE(of, st_lsm6dsx_spi_of_match);
>>>> +
>>>> +static const struct spi_device_id st_lsm6dsx_spi_id_table[] = {
>>>> +     { ST_LSM6DS3_DEV_NAME },
>>>> +     { ST_LSM6DSM_DEV_NAME },
>>>> +     {},
>>>> +};
>>>> +MODULE_DEVICE_TABLE(spi, st_lsm6dsx_spi_id_table);
>>>> +
>>>> +static struct spi_driver st_lsm6dsx_driver = {
>>>> +     .driver = {
>>>> +             .name = "st_lsm6dsx_spi",
>>>> +             .of_match_table = of_match_ptr(st_lsm6dsx_spi_of_match),
>>>> +     },
>>>> +     .probe = st_lsm6dsx_spi_probe,
>>>> +     .id_table = st_lsm6dsx_spi_id_table,
>>>> +};
>>>> +module_spi_driver(st_lsm6dsx_driver);
>>>> +
>>>> +MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
>>>> +MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
>>>> +MODULE_DESCRIPTION("STMicroelectronics st_lsm6dsx spi driver");
>>>> +MODULE_LICENSE("GPL v2");
>>>>
>>>
>>
>>
>>
>

Regards,
Lorenzo

-- 
UNIX is Sexy: who | grep -i blonde | talk; cd ~; wine; talk; touch;
unzip; touch; strip; gasp; finger; gasp; mount; fsck; more; yes; gasp;
umount; make clean; sleep
