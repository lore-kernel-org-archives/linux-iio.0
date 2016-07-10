Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39285 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757170AbcGJPRP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 10 Jul 2016 11:17:15 -0400
Subject: Re: Some advice required for IIO driver (cm3218)
To: Leigh Brown <leigh@solinno.co.uk>,
	Linux Iio <linux-iio@vger.kernel.org>,
	Kevin Tsai <ktsai@capellamicro.com>
References: <dc764217a7c6265d30a588e966f4b133@doppler.thel33t.co.uk>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c0d19ba9-4c6f-5728-7528-75c27f2f8047@kernel.org>
Date: Sun, 10 Jul 2016 16:17:09 +0100
MIME-Version: 1.0
In-Reply-To: <dc764217a7c6265d30a588e966f4b133@doppler.thel33t.co.uk>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/07/16 22:23, Leigh Brown wrote:
> Hi Guys,
> 
> I just bought an Asus T100 transformer which has a cm3218 ALS and I'm keen to get it working.
Cool.
> I've seen two drivers hanging around:
> 
> 1. https://github.com/jfwells/linux-asus-t100ta/blob/master/cm3218_ambient_light_sensor_driver/cm3218.c
> 
> 2. http://marc.info/?l=linux-iio&m=146038141909068&w=2
Would be interesting if you could provide a few details on where these two drivers are
less than ideal.  Useful info to have when considering a 3rd option ;)

Also, ideally talk to Kevin to find out what the status of updates to the above so you
can both avoid duplicating effort.
> 
> Neither worked really well so in the spirit of things I've created a third driver which I'm
> hoping to get into a state worth submitting (famous last words).  It's not ready for review
> yet (I've pasted it below for anyone who is interested) but I have a couple of questions  and
> I would be really grateful if someone could assist.
> 
> Q1. What do IIO_CHAN_INFO_SCALE and IIO_CHAN_INFO_CALIBSCALE mean?
> 
> This is slightly embarrassing, but I can't really figure out what they mean. I'd appreciate it
> if someone could supply a simple definition in relation to this driver.
IIO_CHAN_INFO_SCALE is a scaling factor that is applied to IIO_CHAN_INFO_RAW
output data in userspace as a linear scaling.  Basic rule of thumb is that if
we can describe the conversion from raw data to our 'base units', here illuminance
we leave it up to userspace to do the maths rather than doing it in kernel.
If writable it is controlling the scaling of data coming of the ADC. Clearly
we have no way of knowing if this is due to changes in say the ADC reference
or due to analog front end changes.

IIO_CHAN_INFO_CALIBSCALE is a scaling typically applied as an electrical gain
inside the device as a form of 'trim'. It's about calibrating out part to
part variation.

The key thing is that it needs to look like this is hardware trim to userspace,
but it isn't necessarily an actual hardware applied gain.  In the
case of light sensors, the conversion from the raw ADC value to illuminance in lux
is often non linear (and can involve several input sensors).  Thus we often have
to provide an IIO_CHAN_INFO_PROCESSED output where the maths has already been done
(it's too complex to sensibly describe to userspace).  In this circumstance if
the device has registers to tell the software what it's calibration gain is
(from factory calibration) but that is not applied in hardware
IIO_CHAN_INFO_CALIBSCALE may be used to control a scaling value
which might as well be implemented in hardware as it is always applied before
userspace sees it.

So as you may have noticed there is sometimes a bit of a gray area when the
calibscale is being used for things that aren't actually controlling hardware
amplifiers.

> 
> Q2. What's the best unit to return the processed ambient light sensor value?
> 
> My first choice would be in milliLux,
lux as per Documentation/ABI/testing/sysfs-bus-iio
is where you need to end up, but it is up to you whether you output in 
millilux as IIO_CHAN_INFO_RAW and provide a scale of 0.001 or output
as IIO_CHAN_INFO_PROCESSED directly in lux.

> my second would be in Lux using IIO_VAL_INT_PLUS_MICRO.
> The first requires less calculation in the driver, but I'm easy either way, as long as the
> value returned has all the significant bits in it.
> 
> Q3. The device has a high sensitivity mode (either x1 or x2 sensitivity).  I'd like to expose
> that feature in sysfs.  What would be the best description of it?
> 
> I would suggest something on the lines of IIO_CHAN_INFO_SENSITIVITY.  If so, would the best
> thing to do be to submit a patch adding that to include/linux/iio/iio.h ?
What does it really correspond to?  I'm guessing integration time...  There
are various ways of getting sensitivity and they have direct effects on
the noise characteristics, so we really want to know what is going on.

(looking below I see there is a separate integration time control, so we
are talking either an electrical gain (amplifier) or something more
closely related to the diode itself.) 
Could do it via scale.

> 
> Q4. Similarly, the device has the ability to specify how many samples are outside of the
> configured threshold before raising an interrupt.  What would be the best description of
> this?
> 
> I'm thinking something on the lines of IIO_EV_INFO_CYCLE_DELAY or some such?  I'm not sure.

period.  See the ABI docs.  You'll need to provide it in seconds however rather
than samples.
> 
> Q5. The device is very simple and will continue to raise an interrupt every sample that is
> outside of the threshold.  To deal with this I have written code to change the range to not
> interrupt until the reading returns to within the defined threshold.  I was thinking of
> adding a hysteresis value to this.  What would be the preferred unit of this?  MilliLux/Lux
> or percent or something else?
Match units with the channel.  Also we already have hysteresis defined for
events so use that.

Sometimes it gets fiddlier on light sensors (though I don't think so here). Events can
be based on the outputs of one of the multiple diodes whose values are combined to
calculate an illuminance value.  In those cases we have the unitless 'intensity'
channel types so that the underlying ADC values can be exposed + the events that operate
on them.  It's a pain for userspace to interpret this but we haven't yet come
up with a better way to describe it.


> 
> Apologies for the dumb questions, but if someone can point me in the right direction I'll
> try and get the driver into a good shape over the next week or so.
> 
> Regards,
> 
> Leigh.
> 

> *
>  * Copyright (C) 2014 Capella Microsystems Inc.
>  * Copyright (C) 2016 Leigh Brown <leigh@solinno.co.uk>
>  *
>  * This program is free software; you can redistribute it and/or modify it
>  * under the terms of the GNU General Public License version 2, as published
>  * by the Free Software Foundation.
>  *
>  * Special thanks Srinivas Pandruvada <srinivas.psndruvada@linux.intel.com>
>  * help to add ACPI support.
>  */
> 
> /**************************************************************************
>  ** Leigh's TODO list
>  ** =================
>  ** 1. Review locking requirements and add locks as required
>  ** 2. Review ACPI code
>  ** 3. Decide best way to expose sensitivity configuration
>  ** 4. Add software hysteresis and decide on units (%age? lux?)
>  ** 5. Decide best way to expose "persistence protect" functionality
>  ** 6. More testing
>  ** 7. Merge with cm32181 driver (they are very similar)
>  **
>  
> *************************************************************************/
> 
> #include <linux/delay.h>
> #include <linux/err.h>
> #include <linux/i2c.h>
> #include <linux/regmap.h>
> #include <linux/mutex.h>
> #include <linux/module.h>
> #include <linux/interrupt.h>
> #include <linux/regulator/consumer.h>
> #include <linux/iio/iio.h>
> #include <linux/iio/sysfs.h>
> #include <linux/iio/events.h>
> #include <linux/init.h>
> #include <linux/acpi.h>
> 
> /* I2C Address */
> #define CM3218_I2C_ADDR        0x48
> #define CM3218_ARA_ADDR        0x0C
> 
> /* CM3218 Registers
>  *
>  * Register    Field       Bit     Description
>  * --------    ----       ---     -----------
>  * 00 CMD(W)    Reserved   15:12 Set 0000b
>  *        ALS_HS       11     Sensitivity. 0=normal (x1), 1=high (x2)
>  *        Reserved   10:8  Set 000b
>  *        ALS_IT       7:6     Integration time
>                  (00=100ms, 01=200ms, 10=400ms, 11=800ms)
>  *        ALS_PERS   5:4     Persistence protect
>                  (00=1cycle, 01=2cycle, 10=4cycle, 11=8 cycle)
>  *        Reserved   3     Set 0b
>  *        ALS_TW       2     Threshold window 0=Disabled, 1=Enabled
>  *        ALS_INT_EN 1     Interrupt enable 0=Disabled, 1=Enabled
>  *        ALS_SD       0     Shutdown:0=Powered on, 1=Shut down
>  * 01 WH(W)    ALS_WH       15:0  High threshold window
>  * 02 WL(W)    ALS_WL       15:0  Low threshold window
>  * 03        Reserved   15:0  Set 0000 0000 0000 0000b
>  * 04 ALS(R)    ALS       15:0  ALS Sensor data
>  * 05        Reserved   15:0
>  * 06        Reserved   15:0
>  * 07 ID(R)    Reserved   15:8
>  *        ID       7:0     Chip ID (0001 1000b)
>  */
> 
> #define CM3218_REG_CMD        0x00
> #define CM3218_REG_WH        0x01
> #define CM3218_REG_WL        0x02
> #define CM3218_REG_ALS        0x04
> #define CM3218_REG_ID        0x07
> 
> #define CM3218_CHIP_ID        0x18
> #define CM3218_REG_ID_MASK    0x00FF
> 
> /* Number of configurable (writable) registers */
> #define CM3218_CONF_REG_NUM        3
> 
> /* CMD register */
> #define CM3218_ALS_SD_SHIFT        0
> #define CM3218_ALS_SD_MASK        BIT(0)
> #define CM3218_ALS_SD_DEFAULT        (0b0 << CM3218_ALS_SD_SHIFT)
> 
> #define CM3218_ALS_INT_EN_SHIFT        1
> #define CM3218_ALS_INT_EN_MASK        BIT(1)
> #define CM3218_ALS_INT_EN_DEFAULT    (0b0 << CM3218_ALS_INT_EN_SHIFT)
> 
> #define CM3218_ALS_TW_SHIFT        2
> #define CM3218_ALS_TW_MASK        BIT(2)
> #define CM3218_ALS_TW_DEFAULT        (0b1 << CM3218_ALS_TW_SHIFT)
> 
> #define    CM3218_ALS_PERS_SHIFT        4
> #define    CM3218_ALS_PERS_MASK        (BIT(4) | BIT(5))
> #define    CM3218_ALS_PERS_DEFAULT        (0b00 << CM3218_ALS_PERS_SHIFT)
> 
> #define CM3218_ALS_IT_SHIFT        6
> #define CM3218_ALS_IT_MASK        (BIT(6) | BIT(7))
> #define CM3218_ALS_IT_DEFAULT        (0b00 << CM3218_ALS_IT_SHIFT)
> 
> #define CM3218_ALS_HS_SHIFT        11
> #define CM3218_ALS_HS_MASK        BIT(11)
> #define CM3218_ALS_HS_DEFAULT        (0b0 << CM3218_ALS_HS_SHIFT)
> 
> #define CM3218_CMD_DEFAULT        (CM3218_ALS_SD_DEFAULT     |\
>                      CM3218_ALS_INT_EN_DEFAULT |\
>                      CM3218_ALS_TW_DEFAULT     |\
>                      CM3218_ALS_PERS_DEFAULT   |\
>                      CM3218_ALS_IT_DEFAULT     |\
>                      CM3218_ALS_HS_DEFAULT)
> 
> #define CM3218_MLUX_PER_BIT_DEFAULT    1428
> #define CM3218_THRESH_LOW_DEFAULT_MLUX    0
> #define CM3218_THRESH_HIGH_DEFAULT_MLUX    999999999
> 
> #define MLUX_MIN            0
> #define MLUX_MAX            999999999
> 
> static const struct {
>     int val;
>     int val2;
> } cm3218_als_it_scales[] = {
>     { 0, 100000 },    /* 100ms */
>     { 0, 200000 },    /* 200ms */
>     { 0, 400000 },    /* 400ms */
>     { 0, 800000 },    /* 800ms */
> };
> 
> struct cm3218_chip {
>     struct i2c_client *client;
>     struct i2c_client *ara_client;
>     struct i2c_client *als_client;
>     struct mutex lock;
>     struct regmap *regmap;
>     unsigned int als_shift;
>     int mlux_per_bit;
>     unsigned int thresh_high;
>     unsigned int thresh_low;
>     unsigned int thesh_hyst;
>     bool thresh_en;
> };
> 
> struct cm3218_i2c_addrs {
>     int count;
>     u16 primary;
>     u16 secondary;
> };
> 
> static unsigned int mlux_to_raw(unsigned int mlux, unsigned int scale,
>                 unsigned int shift)
> {
>     return (mlux << shift) / scale & 0xFFFF;
> }
> 
> static unsigned int raw_to_mlux(unsigned int raw, unsigned int scale,
>                 unsigned int shift)
> {
>     return raw * scale >> shift;
> }
> 
> /**
>  * cm3218_acpi_get_cpm_info() - Get CPM object from ACPI
>  * @client    pointer of struct i2c_client.
>  * @obj_name    pointer of ACPI object name.
>  * @count    maximum size of return array.
>  * @vals    pointer of array for return elements.
>  *
>  * Convert ACPI CPM table to array. Special thanks to Srinivas Pandruvada
>  * for his help implementing this routine.
>  *
>  * Return: -ENODEV for fail.  Otherwise is number of elements.
>  */
> static int cm3218_acpi_get_cpm_info(struct i2c_client *client, char *obj_name,
>                             int count, u64 *vals)
> {
>     acpi_handle handle;
>     struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
>     int i;
>     acpi_status status;
>     union acpi_object *cpm = NULL;
> 
>     handle = ACPI_HANDLE(&client->dev);
>     if (!handle)
>         return -ENODEV;
> 
>     status = acpi_evaluate_object(handle, obj_name, NULL, &buffer);
>     if (ACPI_FAILURE(status)) {
>         dev_err(&client->dev, "object %s not found\n", obj_name);
>         return -ENODEV;
>     }
> 
>     cpm = buffer.pointer;
>     for (i = 0; i < cpm->package.count && i < count; ++i) {
>         union acpi_object *elem;
> 
>         elem = &(cpm->package.elements[i]);
>         vals[i] = elem->integer.value;
>     }
> 
>     kfree(buffer.pointer);
> 
>     return i;
> }
> 
> static int cm3218_read_ara(struct cm3218_chip *chip)
> {
>     int status;
> 
>     status = i2c_smbus_read_byte(chip->ara_client);
>     return status < 0 ? -ENODEV : status;
> }
> 
> /**
>  * cm3218_chip_init() - Initialize CM3218 registers
>  * @cm3218:    pointer of struct cm3218.
>  *
>  * Initialize CM3218 ambient light sensor register to default values.
>  *
>   Return: 0 for success; otherwise for error code.
>  */
> static int cm3218_chip_init(struct cm3218_chip *chip)
> {
>     int i;
>     s32 ret;
>     unsigned int id;
> 
>     /* Check the device id before initialising */
>     for (i = 0; i < 2; ++i) {
>         ret = regmap_read(chip->regmap, CM3218_REG_ID, &id);
>         if (ret < 0 && i == 0) {
>             cm3218_read_ara(chip);
>             continue;
>         }
>     }
>     if (ret < 0) {
>         dev_err(&chip->client->dev,
>             "Error %d reading chip identifier (%d attempts)\n", ret, i);
>         return ret;
>     }
>     if ((id & CM3218_REG_ID_MASK) != CM3218_CHIP_ID)
>         dev_warn(&chip->client->dev, "Wrong id, got %x, expected %x\n",
>              id, CM3218_CHIP_ID);
> 
>     regmap_write(chip->regmap, CM3218_REG_CMD, CM3218_CMD_DEFAULT);
>     if (ret < 0) {
>         dev_err(&chip->client->dev, "regmap_write returned %d\n", ret);
>         return ret;
>     }
> 
>     return 0;
> }
> 
> static int cm3218_write_thresh_high(struct cm3218_chip *chip)
> {
>     return regmap_write(chip->regmap, CM3218_REG_WH,
>                 mlux_to_raw(chip->thresh_high, chip->mlux_per_bit,
>                     chip->als_shift));
> }
> 
> static int cm3218_write_thresh_low(struct cm3218_chip *chip)
> {
>     return regmap_write(chip->regmap, CM3218_REG_WL,
>                 mlux_to_raw(chip->thresh_low, chip->mlux_per_bit,
>                     chip->als_shift));
> }
> 
> static int cm3218_set_interrupt(struct cm3218_chip *chip, bool enabled)
> {
>     int val = enabled ? 1 : 0;
> 
>     return regmap_update_bits(chip->regmap, CM3218_REG_CMD,
>                   CM3218_ALS_INT_EN_MASK,
>                   val << CM3218_ALS_INT_EN_SHIFT);
> }
> 
> static int cm3218_set_thresholds(struct cm3218_chip *chip,
>                  unsigned int thresh_low,
>                  unsigned int thresh_high)
> {
>     int ret;
>     unsigned int wl, wh;
> 
>     wl = mlux_to_raw(thresh_low,  chip->mlux_per_bit, chip->als_shift);
>     wh = mlux_to_raw(thresh_high, chip->mlux_per_bit, chip->als_shift);
> 
>     ret = regmap_write(chip->regmap, CM3218_REG_WL, wl);
>     if (ret < 0)
>         return ret;
> 
>     ret = regmap_write(chip->regmap, CM3218_REG_WH, wh);
>     return ret;
> }
> 
> static int cm3218_pre_scale_change(struct cm3218_chip *chip)
> {
>     if (chip->thresh_en)
>         return cm3218_set_interrupt(chip, false);
> 
>     return 0;
> }
> 
> static int cm3218_post_scale_change(struct cm3218_chip *chip)
> {
>     int ret;
>     unsigned int cmd;
> 
>     /* Calculate the shift from the integration time and sensitivity */
>     ret = regmap_read(chip->regmap, CM3218_REG_CMD, &cmd);
>     if (ret < 0)
>         return ret;
> 
>     chip->als_shift = ((cmd & CM3218_ALS_IT_MASK) >> CM3218_ALS_IT_SHIFT) +
>               ((cmd & CM3218_ALS_HS_MASK) >> CM3218_ALS_HS_SHIFT);
> 
>     if (chip->thresh_en) {
>         ret = cm3218_write_thresh_high(chip);
>         if (ret < 0)
>             return ret;
> 
>         ret = cm3218_write_thresh_low(chip);
>         if (ret < 0)
>             return ret;
> 
>         ret = cm3218_set_interrupt(chip, true);
>         if (ret < 0)
>             return ret;
>     }
> 
>     return 0;
> }
> 
> static int cm3218_read_raw(struct iio_dev *indio_dev,
>                struct iio_chan_spec const *chan,
>                int *val, int *val2, long mask)
> {
>     struct cm3218_chip *chip = iio_priv(indio_dev);
>     int ret;
>     unsigned int raw, cmd;
> 
>     switch (mask) {
>     case IIO_CHAN_INFO_RAW:
>         ret = regmap_read(chip->regmap, CM3218_REG_ALS, val);
>         return ret < 0 ? ret : IIO_VAL_INT;
> 
>     case IIO_CHAN_INFO_PROCESSED:
>         ret = regmap_read(chip->regmap, CM3218_REG_ALS, &raw);
>         if (ret < 0)
>             return ret;
> 
>         *val = raw_to_mlux(raw, chip->mlux_per_bit, chip->als_shift);
>         return IIO_VAL_INT;
> 
>     case IIO_CHAN_INFO_SCALE:
>         ret = regmap_read(chip->regmap, CM3218_REG_CMD, &cmd);
>         if (ret < 0)
>             return ret;
> 
>         *val = cmd & CM3218_ALS_HS_MASK ? 2 : 1;
>         return IIO_VAL_INT;
> 
>     case IIO_CHAN_INFO_CALIBSCALE:
>         *val = chip->mlux_per_bit;
>         return IIO_VAL_INT;
> 
>     case IIO_CHAN_INFO_INT_TIME:
>         ret = regmap_read(chip->regmap, CM3218_REG_CMD, &cmd);
>         if (ret < 0)
>             return ret;
> 
>         cmd  &= CM3218_ALS_IT_MASK;
>         cmd >>= CM3218_ALS_IT_SHIFT;
> 
>         *val  = cm3218_als_it_scales[cmd].val;
>         *val2 = cm3218_als_it_scales[cmd].val2;
>         return IIO_VAL_INT_PLUS_MICRO;
>     }
> 
>     return -EINVAL;
> }
> 
> static int cm3218_write_raw(struct iio_dev *indio_dev,
>                 struct iio_chan_spec const *chan,
>                 int val, int val2, long mask)
> {
>     struct cm3218_chip *chip = iio_priv(indio_dev);
>     int ret;
>     unsigned int reg_val, reg_mask, i;
> 
>     /* Validate */
>     switch (mask) {
>     case IIO_CHAN_INFO_SCALE:
>         if (val != 1 && val != 2)
>             return -EINVAL;
>         reg_val  = (val - 1) << CM3218_ALS_HS_SHIFT;
>         reg_mask = CM3218_ALS_HS_MASK;
>         break;
> 
>     case IIO_CHAN_INFO_CALIBSCALE:
>         if (val < 1 || val > 32767)
>             return -EINVAL;
>         break;
> 
>     case IIO_CHAN_INFO_INT_TIME:
>         /* TODO Put this into it's own function */
>         reg_val = UINT_MAX;
>         for (i = 0; i < ARRAY_SIZE(cm3218_als_it_scales); i++)
>             if (val  == cm3218_als_it_scales[i].val &&
>                 val2 == cm3218_als_it_scales[i].val2) {
>                 reg_val = i;
>                 break;
>             }
> 
>         if (reg_val == UINT_MAX)
>             return -EINVAL;
> 
>         reg_val <<= CM3218_ALS_IT_SHIFT;
>         reg_mask  = CM3218_ALS_IT_MASK;
>         break;
> 
>     default:
>         return -EINVAL;
>     }
> 
>     /* Prepare for scale change */
>     ret = cm3218_pre_scale_change(chip);
>     if (ret < 0)
>         return ret;
> 
>     /* Make the change */
>     if (mask == IIO_CHAN_INFO_CALIBSCALE)
>         chip->mlux_per_bit = val;
>     else {
>         ret = regmap_update_bits(chip->regmap, CM3218_REG_CMD,
>                                reg_mask, reg_val);
>         if (ret < 0)
>             return ret;
>     }
> 
>     /* Reset thresholds if required */
>     return cm3218_post_scale_change(chip);
> }
> 
> static int cm3218_read_event(struct iio_dev *indio_dev,
>                  const struct iio_chan_spec *chan,
>                  enum iio_event_type type,
>                  enum iio_event_direction dir,
>                  enum iio_event_info info,
>                  int *val, int *val2)
> {
>     struct cm3218_chip *chip = iio_priv(indio_dev);
> 
>     if (chan->type == IIO_LIGHT         &&
>         type       == IIO_EV_TYPE_THRESH) {
>         switch (info) {
>         case IIO_EV_INFO_VALUE:
>             switch (dir) {
>             case IIO_EV_DIR_RISING:
>                 *val = chip->thresh_high;
>                 return IIO_VAL_INT;
>             case IIO_EV_DIR_FALLING:
>                 *val = chip->thresh_low;
>                 return IIO_VAL_INT;
>             default:
>                 ;
>             }
>             break;
> /* TODO        case IIO_EV_INFO_HYSTERESIS:
>             if (dir == IIO_EV_DIR_EITHER) {
>                 *val = 1;
>                 return IIO_VAL_INT;
>             }
>             break; */
>         default:
>             break;
>         }
>     }
> 
>     dev_err(&indio_dev->dev, "error chan->type=%d,type=%d,dir=%d,info=%d\n",
>                 chan->type, type, dir, info);
>     return -EINVAL;
> }
> 
> static int cm3218_write_event(struct iio_dev *indio_dev,
>                  const struct iio_chan_spec *chan,
>                  enum iio_event_type type,
>                  enum iio_event_direction dir,
>                  enum iio_event_info info,
>                  int val, int val2)
> {
>     struct cm3218_chip *chip = iio_priv(indio_dev);
> 
>     if (val < 0 || val > 999999)
>         return -EINVAL;
> 
>     if (chan->type == IIO_LIGHT && type == IIO_EV_TYPE_THRESH) {
>         switch (info) {
>         case IIO_EV_INFO_VALUE:
>             switch (dir) {
>             case IIO_EV_DIR_RISING:
>                 chip->thresh_high = val;
>                 if (chip->thresh_en)
>                     return cm3218_write_thresh_high(chip);
>                 return 0;
>             case IIO_EV_DIR_FALLING:
>                 chip->thresh_low = val;
>                 if (chip->thresh_en)
>                     return cm3218_write_thresh_low(chip);
>                 return 0;
>             default:
>                 ;
>             }
> /* TODO        case IIO_EV_INFO_HYSTERESIS:
>             if (dir == IIO_EV_DIR_EITHER)
>                 return 0;
>             break; */
>         default:
>             break;
>         }
>     }
> 
>     dev_err(&indio_dev->dev, "error chan->type=%d,type=%d,dir=%d,info=%d\n",
>                 chan->type, type, dir, info);
>     return -EINVAL;
> }
> 
> static int cm3218_threshold_disable(struct cm3218_chip *chip)
> {
>     int ret;
> 
>     ret = cm3218_set_interrupt(chip, false);
>     if (ret < 0)
>         return ret;
> 
>     chip->thresh_en = false;
>     return 0;
> }
> 
> static int cm3218_threshold_enable(struct cm3218_chip *chip)
> {
>     int ret;
> 
>     ret = cm3218_write_thresh_high(chip);
>     if (ret < 0)
>         return ret;
> 
>     ret = cm3218_write_thresh_low(chip);
>     if (ret < 0)
>         return ret;
> 
>     ret = cm3218_set_interrupt(chip, true);
>     if (ret < 0)
>         return ret;
> 
>     chip->thresh_en = true;
>     return 0;
> }
> 
> 
> /**
>  * cm3218_read_event_config() - return status of cm3218 threshold reporting
>  * @indio_dev:    iio device
>  * @chan:    iio channel
>  * type:    iio event type
>  * dir:        iio event direction
>  *
>  * Convert sensor raw data to lux.  It depends on integration time and
>  * sensitivity.
>  *
>  * Return: 0 if disable, 1 if enabled, -errno if error
>  */
> static int cm3218_read_event_config(struct iio_dev *indio_dev,
>                     const struct iio_chan_spec *chan,
>                     enum iio_event_type type,
>                     enum iio_event_direction dir)
> {
>     struct cm3218_chip *chip = iio_priv(indio_dev);
> 
>     if (chan->type == IIO_LIGHT         &&
>           type == IIO_EV_TYPE_THRESH &&
>            dir == IIO_EV_DIR_EITHER)
>         return chip->thresh_en ? 1 : 0;
> 
>     dev_err(&indio_dev->dev, "error chan->type=%d,type=%d,dir=%d\n",
>                  chan->type, type, dir);
>     return -EINVAL;
> }
> 
> static int cm3218_write_event_config(struct iio_dev *indio_dev,
>                      const struct iio_chan_spec *chan,
>                      enum iio_event_type type,
>                      enum iio_event_direction dir, int state)
> {
>     struct cm3218_chip *chip = iio_priv(indio_dev);
> 
>     if (chan->type == IIO_LIGHT         &&
>           type == IIO_EV_TYPE_THRESH &&
>            dir == IIO_EV_DIR_EITHER)
>         switch (state) {
>         case 0:
>             return cm3218_threshold_disable(chip);
>         case 1:
>             return cm3218_threshold_enable(chip);
>             break;
>         default:
>             ;
>     }
> 
>     dev_err(&indio_dev->dev,
>         "error chan->type=%d,type=%d,dir=%d,state=%d\n",
>         chan->type, type, dir, state);
>     return -EINVAL;
> }
> 
> static bool cm3218_readable_reg(struct device *dev, unsigned int reg)
> {
>     switch (reg) {
>     case CM3218_REG_ALS:
>     case CM3218_REG_ID:
>         return true;
>     default:
>         return false;
>     }
> }
> 
> static bool cm3218_writeable_reg(struct device *dev, unsigned int reg)
> {
>     switch (reg) {
>     case CM3218_REG_CMD:
>     case CM3218_REG_WH:
>     case CM3218_REG_WL:
>         return true;
>     default:
>         return false;
>     }
> }
> 
> static bool cm3218_volatile_reg(struct device *dev, unsigned int reg)
> {
>     switch (reg) {
>     case CM3218_REG_ALS:
>         return true;
>     default:
>         return false;
>     }
> }
> 
> static const struct regmap_config cm3218_regmap_config = {
>     .reg_bits = 8,
>     .val_bits = 16,
> 
>     .max_register  = CM3218_REG_ID,
>     .readable_reg  = cm3218_readable_reg,
>     .writeable_reg = cm3218_writeable_reg,
>     .volatile_reg  = cm3218_volatile_reg,
> 
>     .use_single_rw       = 1,
>     .cache_type       = REGCACHE_FLAT,
>     .val_format_endian = REGMAP_ENDIAN_LITTLE,
> };
> 
> /**
>  * cm3218_get_it_available() - Get available ALS IT value
>  * @dev:    pointer of struct device.
>  * @attr:    pointer of struct device_attribute.
>  * @buf:    pointer of return string buffer.
>  *
>  * Display the available integration time values by millisecond.
>  *
>  * Return: string length.
>  */
> /* XXX Keep this around for now until we confirm we don't need it
> static ssize_t cm3218_get_it_available(struct device *dev,
>             struct device_attribute *attr, char *buf)
> {
>     int i, len;
> 
>     for (i = 0, len = 0; i < ARRAY_SIZE(cm3218_als_it_scales); i++)
>         len += scnprintf(buf + len, PAGE_SIZE - len, "%u.%06u ",
>             cm3218_als_it_scales[i].val,
>             cm3218_als_it_scales[i].val2);
>     return len + scnprintf(buf + len, PAGE_SIZE - len, "\n");
> }
> */
> 
> static irqreturn_t cm3218_event_handler(int irq, void *private)
> {
>     struct iio_dev *dev_info = private;
>     struct cm3218_chip *chip = iio_priv(dev_info);
>     int ret, ara;
>     unsigned int raw, reading, new_low, new_high;
>     u64 event;
> 
>     if (!chip)
>         return IRQ_NONE;
> 
>     mutex_lock(&chip->lock);
> 
>     ara = cm3218_read_ara(chip);
> 
>     /* Disable interrupts */
>     ret = cm3218_set_interrupt(chip, false);
>     if (ret < 0)
>         goto unlock_and_exit;
> 
>     ret = regmap_read(chip->regmap, CM3218_REG_ALS, &raw);
>     if (ret < 0) {
>         dev_err(&dev_info->dev, "irq read als reg failed\n");
>         goto unlock_and_exit;
>     }
> 
>     reading = raw_to_mlux(raw, chip->mlux_per_bit, chip->als_shift);
>     event   = 0;
>     if (reading < chip->thresh_low) {
>         event = IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0, IIO_EV_TYPE_THRESH,
>                                IIO_EV_DIR_FALLING);
>         new_low  = MLUX_MIN;
>         new_high = chip->thresh_low;
>     }
>     else if (reading > chip->thresh_high) {
>         event = IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0, IIO_EV_TYPE_THRESH,
>                                IIO_EV_DIR_RISING);
>         new_low  = chip->thresh_high;
>         new_high = MLUX_MAX;
>     }
>     else {
>         new_low  = chip->thresh_low;
>         new_high = chip->thresh_high;
>     }
> 
>     if (event)
>         iio_push_event(dev_info, event, iio_get_time_ns());
> 
>     ret = cm3218_set_thresholds(chip, new_low, new_high);
>     if (ret < 0)
>         goto unlock_and_exit;
> 
>     /* Emable interrupts */
>     ret = cm3218_set_interrupt(chip, true);
> 
> unlock_and_exit:
>     mutex_unlock(&chip->lock);
>     return IRQ_HANDLED;
> }
> 
> static int acpi_i2c_check_resource(struct acpi_resource *ares, void *data)
> {
>     if (ares->type == ACPI_RESOURCE_TYPE_SERIAL_BUS) {
>         struct acpi_resource_i2c_serialbus *sb;
> 
>         sb = &ares->data.i2c_serial_bus;
>         if (sb->type == ACPI_RESOURCE_SERIAL_TYPE_I2C) {
>             struct cm3218_i2c_addrs *i2c_addrs = data;
> 
>             if (i2c_addrs->count++ == 2)
>                 return -1;
> 
>             if (sb->slave_address == CM3218_ARA_ADDR)
>                 i2c_addrs->secondary = sb->slave_address;
>             else
>                 i2c_addrs->primary = sb->slave_address;
>         }
>     }
> 
>     /* Success */
>     return 1;
> }
> 
> static int cm3218_acpi_config(struct i2c_client *client,
>                   u16 *primary_addr, u16 *secondary_addr)
> {
>     const struct acpi_device_id *id;
>     struct acpi_device *adev;
>     struct cm3218_i2c_addrs i2c_addrs;
>     LIST_HEAD(resources);
>     int ret;
> 
>     id = acpi_match_device(client->dev.driver->acpi_match_table,
>                    &client->dev);
>     if (!id)
>         return -ENODEV;
> 
>     adev = ACPI_COMPANION(&client->dev);
>     if (!adev)
>         return -ENODEV;
> 
>     i2c_addrs.count = 0;
>     ret = acpi_dev_get_resources(adev, &resources,
>                      acpi_i2c_check_resource, &i2c_addrs);
>     if (ret < 0)
>         return ret;
> 
>     acpi_dev_free_resource_list(&resources);
> 
>     if (i2c_addrs.count != 2)
>         return -ENODEV;
>     if (i2c_addrs.secondary != CM3218_ARA_ADDR)
>         return -ENODEV;
> 
>     *primary_addr = i2c_addrs.primary;
>     *secondary_addr = i2c_addrs.secondary;
> 
>     return 0;
> }
> 
> static const struct iio_event_spec cm3218_events[] = {
>     {
>         .type = IIO_EV_TYPE_THRESH,
>         .dir  = IIO_EV_DIR_FALLING,
>         .mask_separate        = BIT(IIO_EV_INFO_VALUE),
>     }, {
>         .type = IIO_EV_TYPE_THRESH,
>         .dir  = IIO_EV_DIR_RISING,
>         .mask_separate        = BIT(IIO_EV_INFO_VALUE),
>     }, {
>         .type = IIO_EV_TYPE_THRESH,
>         .dir  = IIO_EV_DIR_EITHER,
>         .mask_separate = BIT(IIO_EV_INFO_ENABLE), /* |
>                  BIT(IIO_EV_INFO_HYSTERESIS), */
>     }
> };
> 
> static const struct iio_chan_spec cm3218_channels[] = {
>     {
>         .type = IIO_LIGHT,
>         .info_mask_separate =
>             BIT(IIO_CHAN_INFO_PROCESSED) |
>             BIT(IIO_CHAN_INFO_CALIBSCALE) |
>             BIT(IIO_CHAN_INFO_INT_TIME) |
>             BIT(IIO_CHAN_INFO_RAW),
>         .event_spec = cm3218_events,
>         .num_event_specs = ARRAY_SIZE(cm3218_events),
>     }
> };
> 
> static IIO_CONST_ATTR(illuminance_scale_available, "1 2");
> static IIO_CONST_ATTR(illuminance_integration_time_available, "0.1 0.2 0.4 0.8");
> 
> static struct attribute *cm3218_attributes[] = {
>     &iio_const_attr_illuminance_scale_available.dev_attr.attr,
>     &iio_const_attr_illuminance_integration_time_available.dev_attr.attr,
>     NULL,
> };
> 
> static const struct attribute_group cm3218_attribute_group = {
>     .attrs = cm3218_attributes
> };
> 
> static const struct iio_info cm3218_info = {
>     .driver_module        = THIS_MODULE,
>     .read_raw        = &cm3218_read_raw,
>     .write_raw        = &cm3218_write_raw,
>     .attrs            = &cm3218_attribute_group,
>     .read_event_config    = &cm3218_read_event_config,
>     .write_event_config    = &cm3218_write_event_config,
>     .read_event_value    = &cm3218_read_event,
>     .write_event_value    = &cm3218_write_event,
> };
> 
> static int cm3218_probe(struct i2c_client *client,
>             const struct i2c_device_id *id)
> {
>     struct cm3218_chip *chip;
>     struct iio_dev *indio_dev;
>     struct regmap *regmap;
>     int ret;
>     unsigned short primary_addr, secondary_addr;
>     int cpm_elem_count;
>     u64 cpm_elems[20];
> 
>     indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
>     if (!indio_dev) {
>         dev_err(&client->dev, "devm_iio_device_alloc failed\n");
>         return -ENOMEM;
>     }
> 
>     chip = iio_priv(indio_dev);
>     i2c_set_clientdata(client, indio_dev);
>     chip->client = client;
> 
>     mutex_init(&chip->lock);
>     indio_dev->dev.parent   = &client->dev;
>     indio_dev->info         = &cm3218_info;
>     indio_dev->channels     = cm3218_channels;
>     indio_dev->num_channels = ARRAY_SIZE(cm3218_channels);
>     indio_dev->modes        = INDIO_DIRECT_MODE;
>     if (id && id->name)
>         indio_dev->name = id->name;
>     else
>         indio_dev->name = (char *)dev_name(&client->dev);
> 
>     primary_addr   = CM3218_I2C_ADDR;
>     secondary_addr = CM3218_ARA_ADDR;
>     cm3218_acpi_config(client, &primary_addr, &secondary_addr);
> 
>     if (client->addr == primary_addr)
>         chip->als_client = client;
>     else
>         chip->als_client = i2c_new_dummy(client->adapter,
>                         primary_addr);
>     if (!chip->als_client)
>         return -ENODEV;
> 
>     if (client->addr == secondary_addr)
>         chip->ara_client = client;
>     else
>         chip->ara_client = i2c_new_dummy(client->adapter,
>                         secondary_addr);
>     if (!chip->ara_client)
>         return -ENODEV;
> 
>     regmap = devm_regmap_init_i2c(chip->als_client, &cm3218_regmap_config);
>     if (IS_ERR(regmap)) {
>         dev_err(&client->dev, "regmap initialisation failed\n");
>         return PTR_ERR(regmap);
>     }
>     chip->regmap = regmap;
> 
>     chip->mlux_per_bit = CM3218_MLUX_PER_BIT_DEFAULT;
>     chip->als_shift    = 1;
>     chip->thresh_low   = 0;
>     chip->thresh_en    = CM3218_THRESH_LOW_DEFAULT_MLUX;
>     chip->thresh_high  = CM3218_THRESH_HIGH_DEFAULT_MLUX;
> 
>     if (ACPI_HANDLE(&client->dev)) {
>         cpm_elem_count = cm3218_acpi_get_cpm_info(client, "CPM1",
>                             ARRAY_SIZE(cpm_elems),
>                             cpm_elems);
>         if (cpm_elem_count > 0) {
>             chip->mlux_per_bit = (int)cpm_elems[0];
>         }
>     }
> 
>     ret = cm3218_chip_init(chip);
>     if (ret) {
>         dev_err(&client->dev, "%s: register init failed\n", __func__);
>         return ret;
>     }
> 
>     if (client->irq) {
>         ret = request_threaded_irq(client->irq, NULL,
>                        cm3218_event_handler,
>                        IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>                        "cm3218_event", indio_dev);
>         if (ret < 0) {
>             dev_err(&client->dev, "irq request error %d\n", -ret);
>             return ret;
>         }
>     }
> 
>     ret = iio_device_register(indio_dev);
>     if (ret < 0) {
>         dev_err(&client->dev, "%s: register device failed\n", __func__);
>         return ret;
>     }
> 
>     return 0;
> }
> 
> static int cm3218_remove(struct i2c_client *client)
> {
>     struct iio_dev *indio_dev = i2c_get_clientdata(client);
>     struct cm3218_chip *chip = iio_priv(indio_dev);
> 
>     /* Disable interrupts and power off */
>     dev_info(&client->dev, "%s: shutting down cm3218", __func__);
>     (void)regmap_update_bits(chip->regmap, CM3218_REG_CMD,
>                  CM3218_ALS_INT_EN_MASK | CM3218_ALS_SD_MASK,
>                  0 << CM3218_ALS_INT_EN_SHIFT |
>                  1 << CM3218_ALS_SD_SHIFT);
> 
>     if (client->irq)
>         free_irq(client->irq, indio_dev);
> 
>     iio_device_unregister(indio_dev);
This unregister is responsible for removing the userspace and in
kernel access to the device.  You really want to do that before
leaving it in an inoperable state by freeing it's irqs etc.

Rule of thumb, keep your remove in exact reverse order of the
steps in probe.  It doesn't always matter as such, but it makes
the code much easier to get right / review!
> 
>     if (client != chip->ara_client)
>         i2c_unregister_device(chip->ara_client);
> 
>     if (client != chip->als_client)
>         i2c_unregister_device(chip->als_client);
> 
>     return 0;
> }
> 
> #ifdef CONFIG_PM_SLEEP
> static int cm3218_suspend(struct device *dev)
> {
>     int ret;
>     struct cm3218_chip *chip = iio_priv(dev_get_drvdata(dev));
> 
>     ret = cm3218_set_interrupt(chip, false);
>     if (ret < 0)
>         return ret;
> 
>     return regmap_update_bits(chip->regmap, CM3218_REG_CMD,
>                   CM3218_ALS_INT_EN_MASK | CM3218_ALS_SD_MASK,
>                   0 << CM3218_ALS_INT_EN_SHIFT |
>                   1 << CM3218_ALS_SD_SHIFT);
> }
> 
> static int cm3218_resume(struct device *dev)
> {
>     int ret;
>     struct cm3218_chip *chip = iio_priv(dev_get_drvdata(dev));
> 
>     ret = regmap_update_bits(chip->regmap, CM3218_REG_CMD,
>                  CM3218_ALS_SD_MASK, 0 << CM3218_ALS_SD_SHIFT);
>     if (ret < 0)
>         return ret;
> 
>     if (chip->thresh_en)
>         return cm3218_set_interrupt(chip, true);
> 
>     return 0;
> }
> 
> static SIMPLE_DEV_PM_OPS(cm3218_pm_ops, cm3218_suspend, cm3218_resume);
> #define CM3218_PM_OPS (&cm3218_pm_ops)
> #else
> #define CM3218_PM_OPS NULL
> #endif
> 
> static const struct i2c_device_id cm3218_id[] = {
>     { "cm3218", 0},
>     { }
> };
> 
> MODULE_DEVICE_TABLE(i2c, cm3218_id);
> 
> #ifdef CONFIG_OF
> static const struct of_device_id cm3218_of_match[] = {
>     { .compatible = "capella,cm3218" },
>     { }
> };
> #endif
> 
> #if CONFIG_ACPI
> static const struct acpi_device_id cm3218_acpi_match[] = {
>     { "CPLM3218", 0},
>     {},
> };
> #endif
> 
> MODULE_DEVICE_TABLE(acpi, cm3218_acpi_match);
> 
> static struct i2c_driver cm3218_driver = {
>     .driver = {
>         .name    = "cm3218",
>         .acpi_match_table = ACPI_PTR(cm3218_acpi_match),
>         .of_match_table = of_match_ptr(cm3218_of_match),
>         .owner    = THIS_MODULE,
>     },
>     .id_table    = cm3218_id,
>     .probe        = cm3218_probe,
>     .remove        = cm3218_remove,
> };
> 
> module_i2c_driver(cm3218_driver);
> 
> MODULE_AUTHOR("Kevin Tsai <ktsai@capellamicro.com>");
> MODULE_DESCRIPTION("CM3218 ambient light sensor driver");
> MODULE_LICENSE("GPL"); 

