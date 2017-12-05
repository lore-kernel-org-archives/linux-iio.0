Return-Path: <SRS0=IX/W=DB=huawei.com=jonathan.cameron@kernel.org>
Date: Tue, 5 Dec 2017 11:23:37 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Crt Mori <cmo@melexis.com>
CC: Jonathan Cameron <jic23@kernel.org>, Linux Iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: temperature: Adding support for MLX90632
Message-ID: <20171205112337.00005dca@huawei.com>
In-Reply-To: <CAKv63usL=m73Ar5yduxHpWAMY9ztwrhYJXFdDo08mRNeuo+XyA@mail.gmail.com>
References: <20171129220749.11301-1-cmo@melexis.com>
	<20171202143315.0fb1506f@archlinux>
	<CAKv63usL=m73Ar5yduxHpWAMY9ztwrhYJXFdDo08mRNeuo+XyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-ID: <linux-iio@vger.kernel.org>

On Sat, 2 Dec 2017 21:30:54 +0100
Crt Mori <cmo@melexis.com> wrote:

> Hi Jonathan,
> Definitely did not think there will be so many comments inside, but I
> expected few of them indeed.
> 
> See my replies inside.
> 
> On 2 December 2017 at 15:33, Jonathan Cameron <jic23@kernel.org> wrote:
> > On Wed, 29 Nov 2017 23:07:49 +0100
> > Crt Mori <cmo@melexis.com> wrote:
> >  
> >> Melexis has just released Infra Red temperature sensor MLX90632 used
> >> for contact-less temperature measurement. Driver provides basic
> >> functionality for reporting object (and ambient) temperature with
> >> support for object emissivity.
> >>
> >> Signed-off-by: Crt Mori <cmo@melexis.com>  
> >
> > Various comments inline.
> >  
> >> ---
> >>  MAINTAINERS                        |   7 +
> >>  drivers/iio/temperature/Kconfig    |  12 +
> >>  drivers/iio/temperature/Makefile   |   1 +
> >>  drivers/iio/temperature/mlx90632.c | 802 +++++++++++++++++++++++++++++++++++++
> >>  4 files changed, 822 insertions(+)
> >>  create mode 100644 drivers/iio/temperature/mlx90632.c
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 2d3d750b19c0..81aec02b08b8 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -8690,6 +8690,13 @@ W:     http://www.melexis.com
> >>  S:   Supported
> >>  F:   drivers/iio/temperature/mlx90614.c
> >>
> >> +MELEXIS MLX90632 DRIVER
> >> +M:   Crt Mori <cmo@melexis.com>
> >> +L:   linux-iio@vger.kernel.org
> >> +W:   http://www.melexis.com
> >> +S:   Supported
> >> +F:   drivers/iio/temperature/mlx90632.c
> >> +
> >>  MELFAS MIP4 TOUCHSCREEN DRIVER
> >>  M:   Sangwon Jee <jeesw@melfas.com>
> >>  W:   http://www.melfas.com
> >> diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
> >> index 5378976d6d27..82e4a62745e2 100644
> >> --- a/drivers/iio/temperature/Kconfig
> >> +++ b/drivers/iio/temperature/Kconfig
> >> @@ -43,6 +43,18 @@ config MLX90614
> >>         This driver can also be built as a module. If so, the module will
> >>         be called mlx90614.
> >>
> >> +config MLX90632
> >> +     tristate "MLX90632 contact-less infrared sensor with medical accuracy"
> >> +     depends on I2C
> >> +     select REGMAP_I2C
> >> +     help
> >> +       If you say yes here you get support for the Melexis
> >> +       MLX90632 contact-less infrared sensor with medical accuracy
> >> +       connected with I2C.
> >> +
> >> +       This driver can also be built as a module. If so, the module will
> >> +       be called mlx90632.
> >> +
> >>  config TMP006
> >>       tristate "TMP006 infrared thermopile sensor"
> >>       depends on I2C
> >> diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
> >> index ad1d668de546..44644fe01bc9 100644
> >> --- a/drivers/iio/temperature/Makefile
> >> +++ b/drivers/iio/temperature/Makefile
> >> @@ -5,6 +5,7 @@
> >>  obj-$(CONFIG_HID_SENSOR_TEMP) += hid-sensor-temperature.o
> >>  obj-$(CONFIG_MAXIM_THERMOCOUPLE) += maxim_thermocouple.o
> >>  obj-$(CONFIG_MLX90614) += mlx90614.o
> >> +obj-$(CONFIG_MLX90632) += mlx90632.o
> >>  obj-$(CONFIG_TMP006) += tmp006.o
> >>  obj-$(CONFIG_TMP007) += tmp007.o
> >>  obj-$(CONFIG_TSYS01) += tsys01.o
> >> diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> >> new file mode 100644
> >> index 000000000000..05c7d943e504
> >> --- /dev/null
> >> +++ b/drivers/iio/temperature/mlx90632.c
> >> @@ -0,0 +1,802 @@
> >> +/*
> >> + * mlx90632.c - Melexis MLX90632 contactless IR temperature sensor
> >> + *
> >> + * Copyright (c) 2017 Melexis <cmo@melexis.com>
> >> + *
> >> + * This file is subject to the terms and conditions of version 2 of
> >> + * the GNU General Public License.  See the file COPYING in the main
> >> + * directory of this archive for more details.
> >> + *
> >> + * Driver for the Melexis MLX90632 I2C 16-bit IR thermopile sensor
> >> + */
> >> +#include <asm/byteorder.h>  
> > Don't think this should ever be included in a driver.
> > What do you need it for?
> >  
> >> +#include <linux/delay.h>
> >> +#include <linux/err.h>
> >> +#include <linux/gpio/consumer.h>
> >> +#include <linux/i2c.h>
> >> +#include <linux/kernel.h>
> >> +#include <linux/module.h>
> >> +#include <linux/math64.h>
> >> +#include <linux/of.h>
> >> +#include <linux/pm_runtime.h>
> >> +#include <linux/regmap.h>
> >> +#include <linux/unaligned/be_byteshift.h>  
> > why?
> >  
> >> +
> >> +#include <linux/iio/iio.h>
> >> +#include <linux/iio/sysfs.h>
> >> +
> >> +/* Memory sections addresses */
> >> +#define MLX90632_ADDR_RAM    0x4000 /* Start address of ram */
> >> +#define MLX90632_ADDR_EEPROM 0x2480 /* Start address of user eeprom */
> >> +
> >> +/* EEPROM addresses - used at startup */
> >> +#define MLX90632_EE_CTRL     0x24d4 /* Control register initial value */
> >> +#define MLX90632_EE_I2C_ADDR 0x24d5 /* I2C address register initial value */
> >> +#define MLX90632_EE_VERSION  0x240b /* EEPROM version reg address */
> >> +#define MLX90632_EE_P_R              0x240c /* P_R calibration register 32bit */
> >> +#define MLX90632_EE_P_G              0x240e /* P_G calibration register 32bit */
> >> +#define MLX90632_EE_P_T              0x2410 /* P_T calibration register 32bit */
> >> +#define MLX90632_EE_P_O              0x2412 /* P_O calibration register 32bit */
> >> +#define MLX90632_EE_Aa               0x2414 /* Aa calibration register 32bit */
> >> +#define MLX90632_EE_Ab               0x2416 /* Ab calibration register 32bit */
> >> +#define MLX90632_EE_Ba               0x2418 /* Ba calibration register 32bit */
> >> +#define MLX90632_EE_Bb               0x241a /* Bb calibration register 32bit */
> >> +#define MLX90632_EE_Ca               0x241c /* Ca calibration register 32bit */
> >> +#define MLX90632_EE_Cb               0x241e /* Cb calibration register 32bit */
> >> +#define MLX90632_EE_Da               0x2420 /* Da calibration register 32bit */
> >> +#define MLX90632_EE_Db               0x2422 /* Db calibration register 32bit */
> >> +#define MLX90632_EE_Ea               0x2424 /* Ea calibration register 32bit */
> >> +#define MLX90632_EE_Eb               0x2426 /* Eb calibration register 32bit */
> >> +#define MLX90632_EE_Fa               0x2428 /* Fa calibration register 32bit */
> >> +#define MLX90632_EE_Fb               0x242a /* Fb calibration register 32bit */
> >> +#define MLX90632_EE_Ga               0x242c /* Ga calibration register 32bit */
> >> +
> >> +#define MLX90632_EE_Gb               0x242e /* Gb calibration register 16bit */
> >> +#define MLX90632_EE_Ka               0x242f /* Ka calibration register 16bit */
> >> +
> >> +#define MLX90632_EE_Ha               0x2481 /* Ha customer calib value reg 16bit */
> >> +#define MLX90632_EE_Hb               0x2482 /* Hb customer calib value reg 16bit */
> >> +
> >> +/* Register addresses - volatile */
> >> +#define MLX90632_REG_I2C_ADDR        0x3000 /* Chip I2C address register */
> >> +
> >> +/* Control register address - volatile */
> >> +#define MLX90632_REG_CONTROL 0x3001 /* Control Register address */
> >> +#define   MLX90632_CFG_PWR_MASK              GENMASK(2, 1) /* PowerMode Mask */
> >> +/* PowerModes statuses */
> >> +#define MLX90632_PWR_STATUS(ctrl_val) (ctrl_val << 1)
> >> +#define MLX90632_PWR_STATUS_HALT MLX90632_PWR_STATUS(0) /* hold */
> >> +#define MLX90632_PWR_STATUS_SLEEP_STEP MLX90632_PWR_STATUS(1) /* sleep step*/
> >> +#define MLX90632_PWR_STATUS_STEP MLX90632_PWR_STATUS(2) /* step */
> >> +#define MLX90632_PWR_STATUS_CONTINUOUS MLX90632_PWR_STATUS(3) /* continuous*/
> >> +
> >> +/* Device status register - volatile */
> >> +#define MLX90632_REG_STATUS  0x3fff /* Device status register */
> >> +#define   MLX90632_STAT_BUSY         BIT(10) /* Device busy indicator */
> >> +#define   MLX90632_STAT_EE_BUSY              BIT(9) /* EEPROM busy indicator */
> >> +#define   MLX90632_STAT_BRST         BIT(8) /* Brown out reset indicator */
> >> +#define   MLX90632_STAT_CYCLE_POS    GENMASK(6, 2) /* Data position */
> >> +#define   MLX90632_STAT_DATA_RDY     BIT(0) /* Data ready indicator */
> >> +
> >> +/* RAM_MEAS address-es for each channel */
> >> +#define MLX90632_RAM_1(meas_num)     (MLX90632_ADDR_RAM + 3 * meas_num)
> >> +#define MLX90632_RAM_2(meas_num)     (MLX90632_ADDR_RAM + 3 * meas_num + 1)
> >> +#define MLX90632_RAM_3(meas_num)     (MLX90632_ADDR_RAM + 3 * meas_num + 2)
> >> +
> >> +/* Magic constants */
> >> +#define MLX90632_EEPROM_VERSION      0xff05 /* EEPROM DSP version for constants */
> >> +#define MLX90632_ID_MEDICAL  0x01ff /* EEPROM Medical device id */
> >> +#define MLX90632_ID_CONSUMER 0x02ff /* EEPROM Consumer device id */
> >> +#define MLX90632_EEPROM_WRITE_KEY 0x554C /* EEPROM write key 0x55 and 0x4c */
> >> +#define MLX90632_RESET_CMD   0x0006 /* Reset sensor (address or global) */
> >> +#define MLX90632_REF_12              12LL /**< ResCtrlRef value of Ch 1 or Ch 2 */
> >> +#define MLX90632_REF_3               12LL /**< ResCtrlRef value of Channel 3 */
> >> +
> >> +#define TENTO3                       1000LL
> >> +#define TENTO4                       10000LL
> >> +#define TENTO5                       100000LL
> >> +#define TENTO6                       1000000LL
> >> +#define TENTO7                       10000000LL
> >> +#define TENTO10                      10000000000LL
> >> +#define TENTO12                      1000000000000LL  
> > Umm. The numbers describe the constants rather better than the defines ;)
> > Just use the numbers if you need them!
> >  
> 
> This is way shorter (line length) and more readable in my opinion.
> Also writing 12 times 0 is error prone :D

Needs care but I really don't like these constants.

> 
> >> +
> >> +struct mlx90632_data {
> >> +     struct i2c_client *client;
> >> +     struct mutex lock; /* Multiple reads for single measurement */
> >> +     struct regmap *regmap;
> >> +     u16 emissivity;
> >> +};
> >> +
> >> +static const struct regmap_range mlx90632_volatile_reg_range[] = {
> >> +     regmap_reg_range(MLX90632_REG_CONTROL, MLX90632_REG_I2C_ADDR),
> >> +     regmap_reg_range(MLX90632_REG_STATUS, MLX90632_REG_STATUS),
> >> +     regmap_reg_range(MLX90632_RAM_1(0),
> >> +                      MLX90632_RAM_3(MLX90632_MAX_MEAS_NUM)),
> >> +};
> >> +
> >> +static const struct regmap_access_table mlx90632_volatile_regs_tbl = {
> >> +     .yes_ranges = mlx90632_volatile_reg_range,
> >> +     .n_yes_ranges = ARRAY_SIZE(mlx90632_volatile_reg_range),
> >> +};
> >> +
> >> +static const struct regmap_range mlx90632_read_reg_range[] = {
> >> +     regmap_reg_range(MLX90632_EE_VERSION, MLX90632_EE_Ka),
> >> +     regmap_reg_range(MLX90632_EE_CTRL, MLX90632_EE_I2C_ADDR),
> >> +     regmap_reg_range(MLX90632_EE_Ha, MLX90632_EE_Hb),
> >> +     regmap_reg_range(MLX90632_REG_CONTROL, MLX90632_REG_I2C_ADDR),
> >> +     regmap_reg_range(MLX90632_REG_STATUS, MLX90632_REG_STATUS),
> >> +     regmap_reg_range(MLX90632_RAM_1(0),
> >> +                      MLX90632_RAM_3(MLX90632_MAX_MEAS_NUM)),
> >> +};
> >> +
> >> +static const struct regmap_access_table mlx90632_readable_regs_tbl = {
> >> +     .yes_ranges = mlx90632_read_reg_range,
> >> +     .n_yes_ranges = ARRAY_SIZE(mlx90632_read_reg_range),
> >> +};
> >> +
> >> +static const struct regmap_range mlx90632_no_write_reg_range[] = {
> >> +     regmap_reg_range(MLX90632_EE_VERSION, MLX90632_EE_Ka),
> >> +     regmap_reg_range(MLX90632_RAM_1(0),
> >> +                      MLX90632_RAM_3(MLX90632_MAX_MEAS_NUM)),
> >> +};
> >> +
> >> +static const struct regmap_access_table mlx90632_writeable_regs_tbl = {
> >> +     .no_ranges = mlx90632_no_write_reg_range,
> >> +     .n_no_ranges = ARRAY_SIZE(mlx90632_no_write_reg_range),
> >> +};
> >> +
> >> +static const struct regmap_config mlx90632_regmap = {
> >> +     .reg_bits = 16,
> >> +     .val_bits = 16,
> >> +
> >> +     .volatile_table = &mlx90632_volatile_regs_tbl,
> >> +     .rd_table = &mlx90632_readable_regs_tbl,
> >> +     .wr_table = &mlx90632_writeable_regs_tbl,
> >> +
> >> +     .use_single_rw = true,
> >> +     .reg_format_endian = REGMAP_ENDIAN_BIG,
> >> +     .val_format_endian = REGMAP_ENDIAN_BIG,
> >> +     .cache_type = REGCACHE_RBTREE,
> >> +};
> >> +
> >> +static u64 mlx90632_int_sqrt(u64 x)
> >> +{
> >> +     u64 b, m, y = 0;
> >> +
> >> +     if (BITS_PER_LONG != 32)
> >> +             return int_sqrt(x);  
> >
> > needs a comment on why...
> > Ideally propose a standard 64 bit routine if one is needed for
> > 32 bit machines.
> >  
> 
> Problem is that int_sqrt is not strongly typed. That means 64 bit
> number gets truncated to 32bit on 32bit machine as you mentioned
> and that caused quite many headaches in my testing (worked on
> mobile phone, but not on beaglebone black).  This solution is just
> stronger typing of int_sqrt function.
> 
> If you think I should put it onto math.h as a patch I can try it.

Sure, let's see if that goes anywhere.  Seems the right approach to me.

> 
> >> +
> >> +     if (x <= 1)
> >> +             return x;
> >> +
> >> +     m = 1ULL << (64 - 2);
> >> +     while (m != 0) {
> >> +             b = y + m;
> >> +             y >>= 1;
> >> +
> >> +             if (x >= b) {
> >> +                     x -= b;
> >> +                     y += m;
> >> +             }
> >> +             m >>= 2;
> >> +     }
> >> +     return y;
> >> +}
> >> +
> >> +static s32 mlx90632_pwr_set_sleep_step(struct regmap *regmap)
> >> +{
> >> +     return regmap_update_bits(regmap, MLX90632_REG_CONTROL,
> >> +                               MLX90632_CFG_PWR_MASK,
> >> +                               MLX90632_PWR_STATUS_SLEEP_STEP);
> >> +}
> >> +
> >> +static s32 mlx90632_pwr_set_step(struct regmap *regmap)
> >> +{
> >> +     return regmap_update_bits(regmap, MLX90632_REG_CONTROL,
> >> +                               MLX90632_CFG_PWR_MASK,
> >> +                               MLX90632_PWR_STATUS_STEP);
> >> +}
> >> +
> >> +static s32 mlx90632_pwr_continuous(struct regmap *regmap)
> >> +{
> >> +     return regmap_update_bits(regmap, MLX90632_REG_CONTROL,
> >> +                               MLX90632_CFG_PWR_MASK,
> >> +                               MLX90632_PWR_STATUS_CONTINUOUS);
> >> +}
> >> +
> >> +static int mlx90632_start_measurement(struct mlx90632_data *data)  
> >
> > Looks superficially to me like this is actually waiting for a reading
> > to complete rather than just starting it?  If so change the name
> > to reflect that.
> >  
> 
> ok
> 
> >> +{
> >> +     int ret, tries = 100;
> >> +     unsigned int reg_status;
> >> +
> >> +     ret = regmap_update_bits(data->regmap, MLX90632_REG_STATUS,
> >> +                              MLX90632_STAT_DATA_RDY, 0);
> >> +     if (ret < 0)
> >> +             return ret;
> >> +
> >> +     while (tries-- > 0) {
> >> +             ret = regmap_read(data->regmap, MLX90632_REG_STATUS,
> >> +                               &reg_status);
> >> +             if (ret < 0)
> >> +                     return ret;
> >> +             if (reg_status & MLX90632_STAT_DATA_RDY)
> >> +                     break;
> >> +             usleep_range(10000, 11000);
> >> +     }
> >> +
> >> +     if (tries < 0) {
> >> +             dev_err(&data->client->dev, "data not ready");
> >> +             return -ETIMEDOUT;
> >> +     }
> >> +
> >> +     return (reg_status & MLX90632_STAT_CYCLE_POS) >> 2;  
> >
> > This is a non obvious return value so I would suggest adding
> > some documentation to say what is going on here..
> >  
> 
> Yes, it is indeed.
> 
> >> +}
> >> +
> >> +static int mlx9032_channel_new_select(int ret, uint8_t *channel_new,
> >> +                                   uint8_t *channel_old)  
> >
> > don't use ret as a name for a variable being passed in.  Rather
> > confusing!
> >  
> 
> OK. I think I should just copy setting of channel_old and new in the
> only spot it is used.
> 
> >> +{
> >> +     if (ret == 1) {
> >> +             *channel_new = 1;
> >> +             *channel_old = 2;
> >> +     } else if (ret == 2) {
> >> +             *channel_new = 2;
> >> +             *channel_old = 1;
> >> +     } else {
> >> +             return ret;
> >> +     }
> >> +     return 0;  
> > Can't get here...
> >  
> 
> Not true. You get here in every example other than else where channel_new
> and channel_old are successfully set. but I agree there is a bug in case ret=0
> when it will return 0, but it will not set channels.

Ah good point, I missed that. I would do it as a switch with direct returns.

> 
> >> +}
> >> +
> >> +static int mlx90632_read_ambient_raw(struct regmap *regmap,
> >> +                                  s16 *ambient_new_raw, s16 *ambient_old_raw)
> >> +{
> >> +     int ret;
> >> +     unsigned int read_tmp;
> >> +
> >> +     ret = regmap_read(regmap, MLX90632_RAM_3(1), &read_tmp);
> >> +     if (ret < 0)
> >> +             return ret;
> >> +     *ambient_new_raw = (s16)read_tmp;
> >> +
> >> +     ret = regmap_read(regmap, MLX90632_RAM_3(2), &read_tmp);
> >> +     if (ret < 0)
> >> +             return ret;
> >> +     *ambient_old_raw = (s16)read_tmp;
> >> +
> >> +     return ret;
> >> +}
> >> +
> >> +static int mlx90632_read_object_raw(struct regmap *regmap,
> >> +                                 int start_measurement_ret,
> >> +                                 s16 *object_new_raw, s16 *object_old_raw)
> >> +{
> >> +     int ret;
> >> +     unsigned int read_tmp;
> >> +     s16 read;
> >> +     u8 channel = 0;
> >> +     u8 channel_old = 0;
> >> +
> >> +     ret = mlx90632_channel_new_select(start_measurement_ret, &channel,
> >> +                                       &channel_old);
> >> +     if (ret != 0)
> >> +             return ret;
> >> +
> >> +     ret = regmap_read(regmap, MLX90632_RAM_2(channel), &read_tmp);
> >> +     if (ret < 0)
> >> +             return ret;
> >> +
> >> +     read = (s16)read_tmp;
> >> +
> >> +     ret = regmap_read(regmap, MLX90632_RAM_1(channel), &read_tmp);
> >> +     if (ret < 0)
> >> +             return ret;
> >> +     *object_new_raw = (read + (s16)read_tmp) / 2;
> >> +
> >> +     ret = regmap_read(regmap, MLX90632_RAM_2(channel_old), &read_tmp);
> >> +     if (ret < 0)
> >> +             return ret;
> >> +     read = (s16)read_tmp;
> >> +
> >> +     ret = regmap_read(regmap, MLX90632_RAM_1(channel_old), &read_tmp);
> >> +     if (ret < 0)
> >> +             return ret;
> >> +     *object_old_raw = (read + (s16)read_tmp) / 2;
> >> +
> >> +     return ret;
> >> +}
> >> +
> >> +static int mlx90632_read_all_channel(struct mlx90632_data *data,
> >> +                                  s16 *ambient_new_raw, s16 *ambient_old_raw,
> >> +                                  s16 *object_new_raw, s16 *object_old_raw)
> >> +{
> >> +     s32 ret, tm_ret;
> >> +
> >> +     mutex_lock(&data->lock);
> >> +     tm_ret = mlx90632_start_measurement(data);
> >> +     if (tm_ret >= 0) {
> >> +             ret = mlx90632_read_ambient_raw(data->regmap, ambient_new_raw,
> >> +                                             ambient_old_raw);
> >> +             if (ret >= 0) {
> >> +                     ret = mlx90632_read_object_raw(data->regmap, tm_ret,
> >> +                                                    object_new_raw,
> >> +                                                    object_old_raw);
> >> +             }
> >> +     } else {
> >> +             ret = tm_ret;
> >> +     }  
> > Use something cleaner like
> >         mutex_lock(&data->lock);
> >         ret = mlx90632_start_measurement(data);
> >         if (ret < 0)
> >                 goto unlock;
> >         ret = mlx90632_read_ambient_raw(data->regmap, ambient_new_raw,
> >                                         ambient_old_raw);
> >         if (ret < 0)
> >                 goto unlock;
> >
> >         ret = mlx90632_read_object_raw(data->regmap, tm_ret,
> >                                        object_new_raw,
> >                                        object_old_raw);
> > unlock:  
> 
> Ok sorry, professional deformation (goto).
> 
> >> +     mutex_unlock(&data->lock);
> >> +     return ret;
> >> +}
> >> +
> >> +static int mlx90632_read_ee_register(struct regmap *regmap, u16 reg_lsb,
> >> +                                  s32 *reg_value)
> >> +{
> >> +     s32 ret;
> >> +     unsigned int read;
> >> +     __le32 value;
> >> +
> >> +     ret = regmap_read(regmap, reg_lsb, &read);
> >> +     if (ret < 0)
> >> +             return ret;
> >> +
> >> +     value = cpu_to_le32(read);  
> >
> > Why would you be converting to le32 to then do
> > calculations in here using it at cpu endianness?
> > (guessing you want le32_to_cpu..)
> >
> > hmm isn't any relevant endian conversion wrapped up in regmap
> > anyway?
> >  
> 
> Regmap reads 16 bit values, but some values are 32 bit. To avoid CPU
> endianess affecting this, I am putting it to known time and shift values.
> This way I ensured it is working on any CPU. le32_to_cpu is in return value.
>

I'm far from convinced this is a good idea. I would ensure all values
are in cpu endianness before combining them based on the read order
(which is endian independant)
 
> >> +
> >> +     ret = regmap_read(regmap, reg_lsb + 1, &read);
> >> +     if (ret < 0)
> >> +             return ret;
> >> +
> >> +     value = (cpu_to_le32(read) << 16) | (value & 0xffff);
> >> +
> >> +     *reg_value = le32_to_cpu(value);
> >> +     return 0;
> >> +}
> >> +
> >> +static s64 mlx90632_preprocess_temp_amb(s16 ambient_new_raw,
> >> +                                     s16 ambient_old_raw, s16 Gb)
> >> +{
> >> +     s64 VR_Ta, kGb, tmp;
> >> +
> >> +     kGb = ((s64)Gb * TENTO3) >> 10ULL;
> >> +     VR_Ta = (s64)ambient_old_raw * TENTO6 +
> >> +             kGb * div64_s64(((s64)ambient_new_raw * TENTO3),
> >> +                     (MLX90632_REF_3));
> >> +     tmp = div64_s64(
> >> +                      div64_s64(((s64)ambient_new_raw * TENTO12),
> >> +                                (MLX90632_REF_3)), VR_Ta);
> >> +     return div64_s64(tmp << 19ULL, TENTO3);
> >> +}
> >> +
> >> +static s64 mlx90632_preprocess_temp_obj(s16 object_new_raw, s16 object_old_raw,
> >> +                                     s16 ambient_new_raw,
> >> +                                     s16 ambient_old_raw, s16 Ka)
> >> +{
> >> +     s64 VR_IR, kKa, tmp;
> >> +
> >> +     kKa = ((s64)Ka * TENTO3) >> 10ULL;
> >> +     VR_IR = (s64)ambient_old_raw * TENTO6 +
> >> +             kKa * div64_s64(((s64)ambient_new_raw * TENTO3),
> >> +                     (MLX90632_REF_3));
> >> +     tmp = div64_s64(
> >> +                     div64_s64(((s64)((object_new_raw + object_old_raw) / 2)
> >> +                                * TENTO12), (MLX90632_REF_12)), VR_IR);
> >> +     return div64_s64(tmp << 19ULL), TENTO3);
> >> +}
> >> +
> >> +static s32 mlx90632_calc_temp_ambient(s16 ambient_new_raw, s16 ambient_old_raw,
> >> +                                   s32 P_T, s32 P_R, s32 P_G, s32 P_O,
> >> +                                   s16 Gb)
> >> +{
> >> +     s64 Asub, Bsub, Ablock, Bblock, Cblock, AMB, sum;
> >> +
> >> +     AMB = mlx90632_preprocess_temp_amb(ambient_new_raw, ambient_old_raw,
> >> +                                        Gb);
> >> +     Asub = ((s64)P_T * TENTO10) >> 44ULL;
> >> +     Bsub = AMB - (((s64)P_R * TENTO3) >> 8ULL);
> >> +     Ablock = Asub * (Bsub * Bsub);
> >> +     Bblock = (div64_s64(Bsub * TENTO7, P_G)) << 20ULL;
> >> +     Cblock = ((s64)P_O * TENTO10) >> 8ULL;
> >> +
> >> +     sum = div64_s64(Ablock, TENTO6) + Bblock + Cblock;
> >> +
> >> +     return div64_s64(sum, TENTO7);
> >> +}
> >> +
> >> +static s32 mlx90632_calc_temp_object_iteration(s32 prev_object_temp, s64 object,
> >> +                                            s64 TAdut, s32 Fa, s32 Fb,
> >> +                                            s32 Ga, s16 Ha, s16 Hb,
> >> +                                            u16 emissivity)
> >> +{
> >> +     s64 calcedKsTO, calcedKsTA, ir_Alpha, TAdut4, Alpha_corr;
> >> +     s64 Ha_customer, Hb_customer;
> >> +
> >> +     Ha_customer = ((s64)Ha * TENTO6) >> 14ULL;
> >> +     Hb_customer = ((s64)Hb * 100) >> 10ULL;
> >> +
> >> +     calcedKsTO = ((s64)((s64)Ga * (prev_object_temp - 25 * TENTO3)
> >> +                          * TENTO3)) >> 36LL;
> >> +     calcedKsTA = ((s64)(Fb * (TAdut - 25 * TENTO6))) >> 36LL;
> >> +     Alpha_corr = div64_s64((((s64)(Fa * TENTO10) >> 46LL) * Ha_customer),
> >> +                            TENTO3);
> >> +     Alpha_corr *= ((s64)(1 * TENTO6 + calcedKsTO + calcedKsTA));
> >> +     Alpha_corr = emissivity * div64_s64(Alpha_corr, TENTO5);
> >> +     Alpha_corr = div64_s64(Alpha_corr, TENTO3);
> >> +     ir_Alpha = div64_s64((s64)object * TENTO7, Alpha_corr);
> >> +     TAdut4 = (div64_s64(TAdut, TENTO4) + 27315) *
> >> +             (div64_s64(TAdut, TENTO4) + 27315) *
> >> +             (div64_s64(TAdut, TENTO4)  + 27315) *
> >> +             (div64_s64(TAdut, TENTO4) + 27315);
> >> +
> >> +     return (mlx90632_int_sqrt(
> >> +                      mlx90632_int_sqrt(ir_Alpha * TENTO12 + TAdut4)
> >> +                     ) - 27315 - Hb_customer) * 10;
> >> +}
> >> +
> >> +static s32 mlx90632_calc_temp_object(s64 object, s64 ambient, s32 Ea, s32 Eb,
> >> +                                  s32 Fa, s32 Fb, s32 Ga, s16 Ha, s16 Hb,
> >> +                                  u16 tmp_emi)
> >> +{
> >> +     s64 kTA, kTA0, TAdut;
> >> +     s64 temp = 25000;
> >> +     s8 i;
> >> +
> >> +     kTA = (Ea * TENTO3) >> 16LL;
> >> +     kTA0 = (Eb * TENTO3) >> 8LL;
> >> +     TAdut = div64_s64(((ambient - kTA0) * TENTO6), kTA) + 25 * TENTO6;
> >> +
> >> +     for (i = 0; i < 5; ++i) {  
> > comment on why iterations are needed would be good here.  
> 
> This is described in datasheet (the whole calculation). Will add
> explanatory comment.
> 
> >> +             temp = mlx90632_calc_temp_object_iteration(temp, object, TAdut,
> >> +                                                        Fa, Fb, Ga, Ha, Hb,
> >> +                                                        tmp_emi);
> >> +     }
> >> +     return temp;
> >> +}
> >> +
> >> +static int mlx90632_calc_object_dsp105(struct mlx90632_data *data, int *val)
> >> +{
> >> +     s32 ret;
> >> +     s32 Ea, Eb, Fa, Fb, Ga;
> >> +     unsigned int read_tmp;
> >> +     s16 Ha, Hb, Gb, Ka;
> >> +     s16 ambient_new_raw, ambient_old_raw, object_new_raw, object_old_raw;
> >> +     s64 object, ambient;
> >> +
> >> +     ret = mlx90632_read_ee_register(data->regmap, MLX90632_EE_Ea, &Ea);
> >> +     if (ret < 0)
> >> +             return ret;
> >> +     ret = mlx90632_read_ee_register(data->regmap, MLX90632_EE_Eb, &Eb);
> >> +     if (ret < 0)
> >> +             return ret;
> >> +     ret = mlx90632_read_ee_register(data->regmap, MLX90632_EE_Fa, &Fa);
> >> +     if (ret < 0)
> >> +             return ret;
> >> +     ret = mlx90632_read_ee_register(data->regmap, MLX90632_EE_Fb, &Fb);
> >> +     if (ret < 0)
> >> +             return ret;
> >> +     ret = mlx90632_read_ee_register(data->regmap, MLX90632_EE_Ga, &Ga);
> >> +     if (ret < 0)
> >> +             return ret;
> >> +     ret = regmap_read(data->regmap, MLX90632_EE_Ha, &read_tmp);
> >> +     if (ret < 0)
> >> +             return ret;
> >> +     Ha = (s16)read_tmp;
> >> +     ret = regmap_read(data->regmap, MLX90632_EE_Hb, &read_tmp);
> >> +     if (ret < 0)
> >> +             return ret;
> >> +     Hb = (s16)read_tmp;
> >> +     ret = regmap_read(data->regmap, MLX90632_EE_Gb, &read_tmp);
> >> +     if (ret < 0)
> >> +             return ret;
> >> +     Gb = (s16)read_tmp;
> >> +     ret = regmap_read(data->regmap, MLX90632_EE_Ka, &read_tmp);
> >> +     if (ret < 0)
> >> +             return ret;
> >> +     Ka = (s16)read_tmp;
> >> +
> >> +     ret = mlx90632_read_all_channel(data,
> >> +                                     &ambient_new_raw, &ambient_old_raw,
> >> +                                     &object_new_raw, &object_old_raw);
> >> +     if (ret < 0)
> >> +             return ret;
> >> +
> >> +     ambient = mlx90632_preprocess_temp_amb(ambient_new_raw,
> >> +                                            ambient_old_raw, Gb);
> >> +     object = mlx90632_preprocess_temp_obj(object_new_raw,
> >> +                                           object_old_raw,
> >> +                                           ambient_new_raw,
> >> +                                           ambient_old_raw, Ka);
> >> +
> >> +     *val = mlx90632_calc_temp_object(object, ambient, Ea, Eb, Fa, Fb, Ga,
> >> +                                      Ha, Hb, data->emissivity);
> >> +     return 0;
> >> +}
> >> +
> >> +static int mlx90632_calc_ambient_dsp105(struct mlx90632_data *data, int *val)
> >> +{
> >> +     s32 ret;
> >> +     unsigned int read_tmp;
> >> +     s32 PT, PR, PG, PO;
> >> +     s16 Gb;
> >> +     s16 ambient_new_raw, ambient_old_raw;
> >> +
> >> +     ret = mlx90632_read_ee_register(data->regmap, MLX90632_EE_P_R, &PR);
> >> +     if (ret < 0)
> >> +             return ret;
> >> +     ret = mlx90632_read_ee_register(data->regmap, MLX90632_EE_P_G, &PG);
> >> +     if (ret < 0)
> >> +             return ret;
> >> +     ret = mlx90632_read_ee_register(data->regmap, MLX90632_EE_P_T, &PT);
> >> +     if (ret < 0)
> >> +             return ret;
> >> +     ret = mlx90632_read_ee_register(data->regmap, MLX90632_EE_P_O, &PO);
> >> +     if (ret < 0)
> >> +             return ret;
> >> +     ret = regmap_read(data->regmap, MLX90632_EE_Gb, &read_tmp);
> >> +     if (ret < 0)
> >> +             return ret;
> >> +     Gb = (s16)read_tmp;
> >> +
> >> +     ret = mlx90632_read_ambient_raw(data->regmap, &ambient_new_raw,
> >> +                                     &ambient_old_raw);
> >> +     *val = mlx90632_calc_temp_ambient(ambient_new_raw, ambient_old_raw,
> >> +                                       PT, PR, PG, PO, Gb);
> >> +     return ret;
> >> +}
> >> +
> >> +static int mlx90632_read_raw(struct iio_dev *indio_dev,
> >> +                          struct iio_chan_spec const *channel, int *val,
> >> +                          int *val2, long mask)
> >> +{
> >> +     struct mlx90632_data *data = iio_priv(indio_dev);
> >> +     int ret;
> >> +
> >> +     switch (mask) {
> >> +     case IIO_CHAN_INFO_PROCESSED:
> >> +             switch (channel->channel2) {
> >> +             case IIO_MOD_TEMP_AMBIENT:
> >> +                     ret = mlx90632_calc_ambient_dsp105(data, val);
> >> +                     if (ret < 0)
> >> +                             return ret;
> >> +                     return IIO_VAL_INT;
> >> +             case IIO_MOD_TEMP_OBJECT:
> >> +                     ret = mlx90632_calc_object_dsp105(data, val);
> >> +                     if (ret < 0)
> >> +                             return ret;
> >> +                     return IIO_VAL_INT;
> >> +             default:
> >> +                     return -EINVAL;
> >> +             }
> >> +     case IIO_CHAN_INFO_CALIBEMISSIVITY:
> >> +             if (data->emissivity == 1000) {
> >> +                     *val = 1;
> >> +                     *val2 = 0;
> >> +             } else {
> >> +                     *val = 0;
> >> +                     *val2 = data->emissivity;  
> > Odd given you are reporting as int + nano
> > this goes from 1.0 to 0.000000999 in one step?
> > Seems unlikely..  If it is true then a comment
> > is needed.
> >
> > The write is int + micro but this would still be wrong
> > without a factor of 1000.
> >  
> 
> In input (write) below I am adding factor of 1000. I do not know
> if resolution like that is needed, but you never know what they
> come up with in real life so I rather left some of the breating
> space.
The above still doesn't make much sense unless your range
is disjoint 0-0.000000999, 1.0 which would be surprising and
also doesn't correspond to the write.

> 
> >> +             }
> >> +             return IIO_VAL_INT_PLUS_NANO;
> >> +
> >> +     default:
> >> +             return -EINVAL;
> >> +     }
> >> +}
> >> +
> >> +static int mlx90632_write_raw(struct iio_dev *indio_dev,
> >> +                           struct iio_chan_spec const *channel, int val,
> >> +                           int val2, long mask)
> >> +{
> >> +     struct mlx90632_data *data = iio_priv(indio_dev);
> >> +
> >> +     switch (mask) {
> >> +     case IIO_CHAN_INFO_CALIBEMISSIVITY:
> >> +             if (val < 0 || val2 < 0 || val > 1 ||
> >> +                 (val == 1 && val2 != 0))  
> >
> > I'd add a comment describing what this is doing.  I think it
> > is checking for 0-1.0 inclusive?
> >  
> 
> Yes, exactly. In case you set emissivity outside of range it should
> not change it and return EINVAL.
> 
> >> +                     return -EINVAL;
> >> +             data->emissivity = val * 1000 + val2 / 1000;
> >> +             return 0;
> >> +     default:
> >> +             return -EINVAL;
> >> +     }
> >> +}
> >> +
> >> +static const struct iio_chan_spec mlx90632_channels[] = {
> >> +     {
> >> +             .type = IIO_TEMP,
> >> +             .modified = 1,
> >> +             .channel2 = IIO_MOD_TEMP_AMBIENT,
> >> +             .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> >> +     },
> >> +     {
> >> +             .type = IIO_TEMP,
> >> +             .modified = 1,
> >> +             .channel2 = IIO_MOD_TEMP_OBJECT,
> >> +             .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> >> +                     BIT(IIO_CHAN_INFO_CALIBEMISSIVITY),
> >> +     },
> >> +};
> >> +
> >> +static const struct iio_info mlx90632_info = {
> >> +     .read_raw = mlx90632_read_raw,
> >> +     .write_raw = mlx90632_write_raw,
> >> +};
> >> +
> >> +#ifdef CONFIG_PM
> >> +static int mlx90632_sleep(struct mlx90632_data *data)
> >> +{
> >> +     dev_dbg(&data->client->dev, "Requesting sleep");
> >> +     return mlx90632_pwr_set_sleep_step(data->regmap);
> >> +}
> >> +
> >> +static int mlx90632_wakeup(struct mlx90632_data *data)
> >> +{
> >> +     dev_dbg(&data->client->dev, "Requesting wake-up");
> >> +     return mlx90632_pwr_continuous(data->regmap);
> >> +}
> >> +#endif
> >> +
> >> +static int mlx90632_probe(struct i2c_client *client,
> >> +                       const struct i2c_device_id *id)
> >> +{
> >> +     struct iio_dev *indio_dev;
> >> +     struct mlx90632_data *mlx90632;
> >> +     struct regmap *regmap;
> >> +     int ret;
> >> +     unsigned int read;
> >> +
> >> +     indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*mlx90632));
> >> +     if (!indio_dev) {
> >> +             dev_err(&client->dev, "Failed to allocate device");
> >> +             return -ENOMEM;
> >> +     }
> >> +
> >> +     regmap = devm_regmap_init_i2c(client, &mlx90632_regmap);
> >> +     if (IS_ERR(regmap)) {
> >> +             ret = PTR_ERR(regmap);
> >> +             dev_err(&client->dev, "Failed to allocate regmap: %d\n", ret);
> >> +             return ret;
> >> +     }
> >> +
> >> +     mlx90632 = iio_priv(indio_dev);
> >> +     i2c_set_clientdata(client, indio_dev);
> >> +     mlx90632->client = client;
> >> +     mlx90632->regmap = regmap;
> >> +
> >> +     mutex_init(&mlx90632->lock);
> >> +     mlx90632_wakeup(mlx90632);
> >> +
> >> +     indio_dev->dev.parent = &client->dev;
> >> +     indio_dev->name = id->name;
> >> +     indio_dev->modes = INDIO_DIRECT_MODE;
> >> +     indio_dev->info = &mlx90632_info;
> >> +     indio_dev->channels = mlx90632_channels;
> >> +     indio_dev->num_channels = ARRAY_SIZE(mlx90632_channels);
> >> +
> >> +     ret = regmap_read(mlx90632->regmap, MLX90632_EE_VERSION, &read);
> >> +     if (ret < 0) {
> >> +             dev_err(&client->dev, "read of version failed: %d\n", ret);
> >> +             return ret;
> >> +     }
> >> +     if (read == (MLX90632_EEPROM_VERSION & MLX90632_ID_MEDICAL)) {  
> >
> > This is odd.  Why the bitwise and of what look to be two different things entirely?
> >  
> 
> If you look at how they are set (high vs low bits) you will see they
> are complimentary and
> prepared exactly for bitwise check. ID_MEDICAL might not be best name, but
> EEPROM_ID_MEDICAL was just too long. You read 16 bits and that is why
> lower 8 bits
> are in fact EEPROM_VERSION while higher 8 are ID of calibration. Since
> calculations
> are currently dependent on lower 8 bits, I left some of the wiggle
> space for future.
> In case we add another one in future, but I would rather have a strict
> check for this to
> avoid any kind of confusion what is supported.

Surely should be | then?

read == (0xff05 & 0x01ff)

read == (0x105)
So only 3 bits of overlap?

Definitely needs a comment to explain this int the code.

> 
> >> +             dev_dbg(&client->dev,
> >> +                     "Detected Medical EEPROM calibration %x", read);
> >> +     } else if (read == (MLX90632_EEPROM_VERSION & MLX90632_ID_CONSUMER)) {
> >> +             dev_dbg(&client->dev,
> >> +                     "Detected Consumer EEPROM calibration %x", read);
> >> +     } else {
> >> +             dev_err(&client->dev,
> >> +                     "Chip EEPROM version mismatch %x (expected %x)",
> >> +                     read, MLX90632_EEPROM_VERSION);
> >> +             return -EPROTONOSUPPORT;
> >> +     }
> >> +
> >> +     mlx90632->emissivity = 1000;
> >> +
> >> +     return devm_iio_device_register(&client->dev, indio_dev);  
> >
> > Don't use devm version.  You are (correctly) manually unwinding
> > this in the remove (as you have pm to deal with after removing the
> > interfaces).  This will result in a double free I think...
> > return iio_device_register is the way to go.
> >
> > I'm a bit confused that you don't seem to set up runtime pm anywhere...
> > I would assume we would be looking at autosuspend for a device
> > like this but it isn't enabled..
> >  
> 
> OK, will check how to use iio_device_register instead.
> 
> I did not do much of PM on device, so I can't really say. That is
> why autosuspend is not enabled.

If you are dropping the PM for now, then devm_iio_device_register is
fine, just drop the remove function entirely as it won't need to do
anything.
> 
> >> +}
> >> +
> >> +static int mlx90632_remove(struct i2c_client *client)
> >> +{
> >> +     struct iio_dev *indio_dev = i2c_get_clientdata(client);
> >> +     struct mlx90632_data *data = iio_priv(indio_dev);
> >> +
> >> +     iio_device_unregister(indio_dev);
> >> +
> >> +     pm_runtime_disable(&client->dev);
> >> +     if (!pm_runtime_status_suspended(&client->dev))
> >> +             mlx90632_sleep(data);
> >> +     pm_runtime_set_suspended(&client->dev);
> >> +
> >> +     return 0;
> >> +}
> >> +
> >> +static const struct i2c_device_id mlx90632_id[] = {
> >> +     { "mlx90632", 0 },
> >> +     { }
> >> +};
> >> +MODULE_DEVICE_TABLE(i2c, mlx90632_id);
> >> +
> >> +static const struct of_device_id mlx90632_of_match[] = {
> >> +     { .compatible = "melexis,mlx90632" },
> >> +     { }
> >> +};
> >> +MODULE_DEVICE_TABLE(of, mlx90632_of_match);
> >> +
> >> +#ifdef CONFIG_PM_SLEEP
> >> +static int mlx90632_pm_suspend(struct device *dev)
> >> +{
> >> +     struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> >> +     struct mlx90632_data *data = iio_priv(indio_dev);
> >> +
> >> +     if (pm_runtime_active(dev))
> >> +             return mlx90632_sleep(data);  
> >
> > I'm a little confused as to why, if the device is powered
> > up fully and a suspend comes in we have to do less than we do
> > in runtime pm case.
> >
> > Am I missing something?
> >  
> 
> I think I have mostly tested runtime pm case, so this might have
> been missed. I did get wrong results if I did not mark regcache as dirty.
> 
> I will just remove the whole PM thing to start with and add it up later, OK?

Makes sense.

> 
> >> +
> >> +     return 0;
> >> +}
> >> +
> >> +static int mlx90632_pm_resume(struct device *dev)
> >> +{
> >> +     struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> >> +     struct mlx90632_data *data = iio_priv(indio_dev);
> >> +     int err;
> >> +
> >> +     err = mlx90632_wakeup(data);
> >> +     if (err < 0)
> >> +             return err;
> >> +
> >> +     pm_runtime_disable(dev);
> >> +     pm_runtime_set_active(dev);
> >> +     pm_runtime_enable(dev);
> >> +
> >> +     return 0;
> >> +}
> >> +#endif
> >> +
> >> +#ifdef CONFIG_PM
> >> +static int mlx90632_pm_runtime_suspend(struct device *dev)
> >> +{
> >> +     struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> >> +     struct mlx90632_data *mlx90632 = iio_priv(indio_dev);
> >> +
> >> +     regcache_sync(mlx90632->regmap);
> >> +
> >> +     return mlx90632_sleep(mlx90632);
> >> +}
> >> +
> >> +static int mlx90632_pm_runtime_resume(struct device *dev)
> >> +{
> >> +     s32 ret;
> >> +     struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> >> +     struct mlx90632_data *mlx90632 = iio_priv(indio_dev);
> >> +
> >> +     regcache_mark_dirty(mlx90632->regmap);
> >> +     regcache_cache_only(mlx90632->regmap, false);
> >> +     ret = regcache_sync(mlx90632->regmap);
> >> +     if (ret < 0) {
> >> +             dev_err(dev, "Failed to sync regmap registers: %d\n", ret);
> >> +             return ret;
> >> +     }
> >> +
> >> +     return mlx90632_wakeup(mlx90632);
> >> +}
> >> +#endif
> >> +
> >> +static const struct dev_pm_ops mlx90632_pm_ops = {
> >> +     SET_SYSTEM_SLEEP_PM_OPS(mlx90632_pm_suspend, mlx90632_pm_resume)
> >> +     SET_RUNTIME_PM_OPS(mlx90632_pm_runtime_suspend,
> >> +                        mlx90632_pm_runtime_resume, NULL)
> >> +};
> >> +
> >> +static struct i2c_driver mlx90632_driver = {
> >> +     .driver = {
> >> +             .name   = "mlx90632",
> >> +             .of_match_table = mlx90632_of_match,
> >> +             .pm     = &mlx90632_pm_ops,
> >> +     },
> >> +     .probe = mlx90632_probe,
> >> +     .remove = mlx90632_remove,
> >> +     .id_table = mlx90632_id,
> >> +};
> >> +module_i2c_driver(mlx90632_driver);
> >> +
> >> +MODULE_AUTHOR("Crt Mori <cmo@melexis.com>");
> >> +MODULE_DESCRIPTION("Melexis MLX90632 contactless Infra Red temperature sensor driver");
> >> +MODULE_LICENSE("GPL v2");  
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
