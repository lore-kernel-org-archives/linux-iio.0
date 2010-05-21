Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"uclinux-dist-devel@blackfin.uclinux.org"
	<uclinux-dist-devel@blackfin.uclinux.org>
Date: Fri, 21 May 2010 15:02:35 +0100
Subject: RE: [RFC] Add support for Analog Devices: ad7991, ad7995, ad7999,
 ad7992, ad7993, ad7994, ad7997, ad7998 i2c analog to digital converters (ADC)
Message-ID: <544AC56F16B56944AEC3BD4E3D5917712E56954D2B@LIMKCMBX1.ad.analog.com>
References: <1274266285.6138.13.camel@mhenneri-D02.ad.analog.com>
 <4BF4112C.8020305@cam.ac.uk>
In-Reply-To: <4BF4112C.8020305@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2010-05-19:
> On 05/19/10 11:51, Michael Hennerich wrote:
>> [RFC] Add support for Analog Devices: ad7991, ad7995, ad7999,
>> ad7992, ad7993, ad7994, ad7997, ad7998 i2c analog to digital
>> converters (ADC)
>>
>> Comments appreciated
> Hi Michael,
>
> This currently needs some checkpatch fixes.

Hi Jonathan,

Thanks for taking a look.
Yeah - I haven't run checkpatch yet.
I'll do before I submit this a patch.

(sorry for the scrambled reply - the QuoteFix VB script I use doesn't handl=
e
patches well)

>
> I'm wondering if taking the same line as hwmon on driver file naming is
> a good idea.  They are very against wild cards in file names. This is on
> basis that manufacturers have a habit of using up random holes in their
> naming.  The only ones I'm seeing here that are left are 7990 and 7996
> so it is probably fine.  Alternative is to name the driver after a
> randomly selected supported chip.

Your right I was thinking about this as well, especially since there is a
tiny hole in the wildcard.

>
> You are a bit brave to combine chips as different as these in one
> driver. (for those who aren't familiar with the chips, some of these
> are of the single config register then a read gives whatever is next,
> some are of the read particular addresses for results type).
>
> For reference of others reading this the two groups are
>
> 1, 5, 9
>
> and
>
> 2, 3, 4, 7, 8
>
> Note that this last lot have a number of variations in interface.
> Still seems to work well enough here so I guess combining them wasn't
> such a bad idea!

I would have been easier to split this into two drivers... with lots of
duplicated code, which I liked to avoid.

>
> Anyhow, driver is pretty clean and about half the silly bits are lifted
> directly from max1363 (should review my own code from time to time!)
>
>
>
>>
>> -Michael
>>
>> ---
>>  drivers/staging/iio/adc/Kconfig       |   20 +
>>  drivers/staging/iio/adc/Makefile      |    4 +
>>  drivers/staging/iio/adc/ad799x.h      |  152 ++++++
>>  drivers/staging/iio/adc/ad799x_core.c |  924
>>  +++++++++++++++++++++++++++++++++
>>  drivers/staging/iio/adc/ad799x_ring.c |  282 ++++++++++ 5 files
>>  changed, 1382 insertions(+), 0 deletions(-)  create mode
>> 100644 drivers/staging/iio/adc/ad799x.h  create mode 100644
>> drivers/staging/iio/adc/ad799x_core.c
>>  create mode 100644 drivers/staging/iio/adc/ad799x_ring.c
>> diff --git a/drivers/staging/iio/adc/Kconfig
>> b/drivers/staging/iio/adc/Kconfig index 3989c0c..36271ff 100644
>> --- a/drivers/staging/iio/adc/Kconfig
>> +++ b/drivers/staging/iio/adc/Kconfig
>> @@ -21,3 +21,23 @@ config MAX1363_RING_BUFFER
>>      help
>>        Say yes here to include ring buffer support in the MAX1363
>>        ADC driver.
>> +
>> +config AD799X
>> +    tristate "Analog Devices AD799x ADC driver"
>> +    depends on I2C
>> +    select IIO_TRIGGER if IIO_RING_BUFFER
>> +    select AD799X_RING_BUFFER
>> +    help
>> +      Say yes here to build support for Analog Devices:
>> +      ad7991, ad7995, ad7999, ad7992, ad7993, ad7994, ad7997, ad7998
>> +      i2c analog to digital convertors (ADC). Provides direct
>> access
>> +      via sysfs.
>> +
>> +config AD799X_RING_BUFFER
>> +    bool "Analog Devices AD799x: use ring buffer"
>> +    depends on AD799X
>> +    select IIO_RING_BUFFER
>> +    select IIO_SW_RING
>> +    help
>> +      Say yes here to include ring buffer support in the AD799X
>> +      ADC driver.
>> diff --git a/drivers/staging/iio/adc/Makefile
>> b/drivers/staging/iio/adc/Makefile
>> index 08cee5c..7fb4eb4 100644
>> --- a/drivers/staging/iio/adc/Makefile
>> +++ b/drivers/staging/iio/adc/Makefile
>> @@ -5,4 +5,8 @@
>>  max1363-y :=3D max1363_core.o
>>  max1363-$(CONFIG_MAX1363_RING_BUFFER) +=3D max1363_ring.o
>> +ad799x-y :=3D ad799x_core.o
>> +ad799x-$(CONFIG_AD799X_RING_BUFFER) +=3D ad799x_ring.o
>> +
>>  obj-$(CONFIG_MAX1363) +=3D max1363.o
>> +obj-$(CONFIG_AD799X) +=3D ad799x.o
> Can we reorder this and keep it grouped by device. (looks like a
> spurious white line has confused things here).

Will do

>> diff --git a/drivers/staging/iio/adc/ad799x.h
>> b/drivers/staging/iio/adc/ad799x.h
>> new file mode 100644
>> index 0000000..2ff73d5
>> --- /dev/null
>> +++ b/drivers/staging/iio/adc/ad799x.h
>> @@ -0,0 +1,152 @@
>> +/*
>> + * Copyright (C) 2010 Michael Hennerich, Analog Devices Inc.
>> + * Copyright (C) 2008-2010 Jonathan Cameron
>> + *
>> + * This program is free software; you can redistribute it and/or
>> +modify
>> + * it under the terms of the GNU General Public License version 2
>> +as
>> + * published by the Free Software Foundation.
>> + *
>> + * ad799x.h
>> + */
>> +
>> +#ifndef _AD799X_H_
>> +#define  _AD799X_H_
>> +
> At the moment, the way these are broken up is a little tricky to match
> to the data sheet. Perhaps a comment to say this first lot make up the
> configuration register and which chips they apply to.
>> +#define AD7991_REF_SEL                              0x08
>> +#define AD7991_FLTR                         0x04
>> +#define AD7991_BIT_TRIAL_DELAY                      0x02
>> +#define AD7991_SAMPLE_DELAY                 0x01
>> +#define AD799X_CHANNEL_SHIFT                        4
>> +
>> +#define AD7997_8_READ_SINGLE                        0x80
>> +#define AD7997_8_READ_SEQUENCE                      0x70
>> +
> Naming here confuses things futher.  This clearly doesn't apply to the
> 7991 (given defs above) This is why using wild cards is frowed upon!
>
>> +#define AD799X_FLTR                         0x08
>> +#define AD799X_ALERT_EN                             0x04
>> +#define AD799X_BUSY_ALERT                   0x02
>> +#define AD799X_BUSY_ALERT_POL                       0x01
>> +
>> +#define AD799X_CONV_RES_REG                 0x0
>> +#define AD799X_ALERT_STAT_REG                       0x1
>> +#define AD799X_CONF_REG                             0x2
>> +#define AD799X_CYCLE_TMR_REG                        0x3
>> +#define AD799X_DATALOW_CH1_REG                      0x4
>> +#define AD799X_DATAHIGH_CH1_REG                     0x5
>> +#define AD799X_HYST_CH1_REG                 0x6
>> +#define AD799X_DATALOW_CH2_REG                      0x7
>> +#define AD799X_DATAHIGH_CH2_REG                     0x8
>> +#define AD799X_HYST_CH2_REG                 0x9
>> +#define AD799X_DATALOW_CH3_REG                      0xA
>> +#define AD799X_DATAHIGH_CH3_REG                     0xB
>> +#define AD799X_HYST_CH3_REG                 0xC
>> +#define AD799X_DATALOW_CH4_REG                      0xD
>> +#define AD799X_DATAHIGH_CH4_REG                     0xE
>> +#define AD799X_HYST_CH4_REG                 0xF
>> +
>> +#define AD799X_CYC_MASK                             0x7
>> +#define AD799X_CYC_DIS                              0x0
>> +#define AD799X_CYC_TCONF_32                 0x1
>> +#define AD799X_CYC_TCONF_64                 0x2
>> +#define AD799X_CYC_TCONF_128                        0x3
>> +#define AD799X_CYC_TCONF_256                        0x4
>> +#define AD799X_CYC_TCONF_512                        0x5
>> +#define AD799X_CYC_TCONF_1024                       0x6
>> +#define AD799X_CYC_TCONF_2048                       0x7
>> +
>> +#define AD799X_ALERT_STAT_CLEAR                     0xFF
>> +
>> +enum {
>> +    ad7991,
> Could be my email client wrecking things, but looks like a few
> spurious spaces here.

I'll fix this up

>> +            ad7995, +               ad7999, +       ad7992, +       ad7=
993, +       ad7994,
>> +    ad7997, +       ad7998 +}; + +struct ad799x_state; + +/** + * struc=
t
>> ad799x_chip_info - chip specifc information + * @num_inputs:         num=
ber of
>> physical inputs on chip + * @bits:           accuracy of the adc in bits=
 + *
>> @int_vref_mv:        the internal reference voltage + * @monitor_mode:  =
     whether
>> the chip supports monitor interrupts + * @default_config:    device
>> default configuration + * @dev_attrs:                pointer to the devi=
ce attribute
>> group + * @scan_attrs:               pointer to the scan element attribu=
te group + *
>> @event_attrs:        pointer to the monitor event attribute group + *
>> @ad799x_set_scan_mode: function pointer to the device specific +mode
>> function + + */ +struct ad799x_chip_info { + u8                         =
     num_inputs;
>> +    u8                              bits; + u16                        =
     int_vref_mv; +  bool                            monitor_mode;
>> +    u16                             default_config; +       struct attr=
ibute_group          *dev_attrs; +   struct
>> attribute_group              *scan_attrs; +  struct attribute_group     =
     *event_attrs;
>> +    int (*ad799x_set_scan_mode)     (struct ad799x_state *st, unsigned =
mask);
>> +}; + +struct ad799x_state { +       struct iio_dev                  *in=
dio_dev; +   struct
>> i2c_client           *client; +      const struct ad799x_chip_info   *ch=
ip_info;
>> +    struct work_struct              poll_work; +    struct work_struct =
             work_thresh;
>> +    atomic_t                        protect_ring; + struct iio_trigger =
             *trig; +        struct
>> regulator            *reg; + s64                             last_timest=
amp; +       u16                             int_vref_mv;
>> +    unsigned                        id; +   char                       =
     *name; +        u16                             config; +}; + +struct
>> ad799x_platform_data { +     u16                             vref_mv; +}=
; + +int
>> ad799x_set_scan_mode(struct ad799x_state *st, unsigned mask); + +#ifdef
>> CONFIG_AD799X_RING_BUFFER + +int ad799x_single_channel_from_ring(struct
>> ad799x_state *st, long mask); +int
>> ad799x_register_ring_funcs_and_init(struct iio_dev *indio_dev); +void
>> ad799x_ring_cleanup(struct iio_dev *indio_dev); + +int
>> ad799x_initialize_ring(struct iio_ring_buffer *ring); void
>> +ad799x_uninitialize_ring(struct iio_ring_buffer *ring); + +#else /*
>> CONFIG_AD799X_RING_BUFFER */ + +static inline void
>> ad799x_uninitialize_ring(struct iio_ring_buffer *ring) +{ +}; + +static
>> inline int ad799x_initialize_ring(struct iio_ring_buffer +*ring) {
>> +    return 0; +}; + +int ad799x_single_channel_from_ring(struct
>> ad799x_state *st, long +mask) { +    return -EINVAL; +}; + + +static
>> inline int +ad799x_register_ring_funcs_and_init(struct iio_dev
>> *indio_dev) { +      return 0; +}; + +static inline void
>> ad799x_ring_cleanup(struct iio_dev *indio_dev) {}; +#endif /*
>> CONFIG_AD799X_RING_BUFFER */ #endif /* _AD799X_H_ */ diff --git
>> a/drivers/staging/iio/adc/ad799x_core.c
>> b/drivers/staging/iio/adc/ad799x_core.c new file mode 100644 index
>> 0000000..a0a0b1f --- /dev/null +++
>> b/drivers/staging/iio/adc/ad799x_core.c @@ -0,0 +1,924 @@ + /* +  *
>> iio/adc/ad799x.c +  * Copyright (C) 2010 Michael Hennerich, Analog
>> Devices Inc. +  * +  * based on iio/adc/max1363 +  * Copyright (C)
>> 2008-2010 Jonathan Cameron +  * +  * based on
>> linux/drivers/i2c/chips/max123x +  * Copyright (C) 2002-2004 Stefan
>> Eletzhofer +  * +  * based on linux/drivers/acron/char/pcf8583.c +  *
>> Copyright (C) 2000 Russell King +  * +  * This program is free
>> software; you can redistribute it and/or modify +  * it under the terms
>> of the GNU General Public License version 2 as +  * published by the
>> Free Software Foundation. +  * +  * ad799x.c +  * +  * Support for
>> ad799x and similar chips. +  * +  */ + +#include <linux/interrupt.h>
>> +#include <linux/gpio.h>
> Don't think we have any gpio calls..
>
>> +#include <linux/workqueue.h>
>> +#include <linux/device.h>
>> +#include <linux/kernel.h>
>> +#include <linux/sysfs.h>
>> +#include <linux/list.h>
>> +#include <linux/i2c.h>
>
> umm. why rtc? Oops, they are both actually my errors in max1363 that
> have just been copied across. Please clear them out. I'll fix those in
> max1363 in my current clean up series.
>> +#include <linux/rtc.h> +#include <linux/regulator/consumer.h> #include
>> <linux/slab.h> +#include <linux/types.h> + +#include "../iio.h"
>> +#include "../sysfs.h" + +#include "../ring_generic.h" +#include
>> "adc.h" +#include "ad799x.h" + +/* + * ad799x register access by I2C +
>> */ Could return data, but perhaps this is simpler given the endianess
>> fun. +static int ad799x_i2c_read16(struct ad799x_state *st, u8 reg, u16
>> *data) +{ +  struct i2c_client *client =3D st->client; +       int ret =
=3D 0; +
>> +    ret =3D i2c_smbus_read_word_data(client, reg); +  if (ret < 0) {
>> +            dev_err(&client->dev, "I2C read error\n"); +            ret=
urn ret; +   } +
>> +    *data =3D swab16((u16)ret); + +   return 0; +} + likewise, no probl=
em
>> using return value for data. +static int ad799x_i2c_read8(struct
>> ad799x_state *st, u8 reg, u8 +*data) { +     struct i2c_client *client =
=3D
>> st->client; +        int ret =3D 0; + +        ret =3D i2c_smbus_read_wo=
rd_data(client,
>> reg); +      if (ret < 0) { +                dev_err(&client->dev, "I2C =
read error\n");
>> +            return ret; +   } + +   *data =3D ret; + +        return 0;=
 +} + +static int
>> ad799x_i2c_write16(struct ad799x_state *st, u8 reg, u16 data) +{
>> +    struct i2c_client *client =3D st->client; +       int ret =3D 0; + =
+        ret =3D
>> i2c_smbus_write_word_data(client, reg, swab16(data)); +      if (ret < 0=
)
>> +            dev_err(&client->dev, "I2C write error\n"); + + return ret;=
 +} +
>> +static int ad799x_i2c_write8(struct ad799x_state *st, u8 reg, u8
>> +data) { +   struct i2c_client *client =3D st->client; +       int ret =
=3D 0; +
>> +    ret =3D i2c_smbus_write_byte_data(client, reg, data); +   if (ret <=
 0)
>> +            dev_err(&client->dev, "I2C write error\n"); + + return ret;=
 +} +
>> +static int ad799x_scan_el_set_state(struct iio_scan_el *scan_el, +
>>       struct iio_dev *indio_dev, +                                  bool=
 state) +{ + struct
>> ad799x_state *st =3D indio_dev->dev_data; +    return
>> ad799x_set_scan_mode(st, st->indio_dev->scan_mask); } + +/* Here we
>> claim all are 16 bits. This currently does no harm and +saves + * us a
>> lot of scan element listings */ + +#define
>> AD799X_SCAN_EL(number)                                               \ +=
     IIO_SCAN_EL_C(in##number, number,
>> IIO_UNSIGNED(16), 0, ad799x_scan_el_set_state); + +static
>> AD799X_SCAN_EL(0); +static AD799X_SCAN_EL(1); +static
>> AD799X_SCAN_EL(2); +static AD799X_SCAN_EL(3); +static
>> AD799X_SCAN_EL(4); +static AD799X_SCAN_EL(5); +static
>> AD799X_SCAN_EL(6); +static AD799X_SCAN_EL(7); + +static ssize_t
>> ad799x_show_precision(struct device *dev, +                          str=
uct device_attribute
>> *attr, +                             char *buf) +{ + struct iio_dev *dev=
_info =3D
>> dev_get_drvdata(dev); +      struct ad799x_state *st =3D
>> iio_dev_get_devdata(dev_info); +     return sprintf(buf, "%d\n",
>> st->chip_info->bits); } + +static IIO_DEVICE_ATTR(in_precision,
>> S_IRUGO, ad799x_show_precision, +                   NULL, 0); + +int
>> ad7991_5_9_set_scan_mode(struct ad799x_state *st, unsigned +mask) {
>> +    return i2c_smbus_write_byte(st->client, +               st->config =
| (mask <<
>> AD799X_CHANNEL_SHIFT)); } + +int ad7992_3_4_set_scan_mode(struct
>> ad799x_state *st, unsigned +mask) { + +      return ad799x_i2c_write8(st=
,
>> AD799X_CONF_REG, +           st->config | (mask << 4)); Why not use
>> AD799X_CHANNEL_SHIFT +} + +int ad7997_8_set_scan_mode(struct
>> ad799x_state *st, unsigned mask) { + return ad799x_i2c_write16(st,
>> AD799X_CONF_REG, +           st->config | (mask << 4)); likewise on the
>> AD799X_CHANNEL_SHIFT +} + +int ad799x_set_scan_mode(struct ad799x_state
>> *st, unsigned mask) { +      int ret; + +    if
>> (st->chip_info->ad799x_set_scan_mode !=3D NULL) { +            ret =3D
>> st->chip_info->ad799x_set_scan_mode(st, mask); +             return (ret=
 > 0) ? 0
>> : ret; +     } + +   return 0; +} + +static ssize_t
>> ad799x_read_single_channel(struct device *dev, +                        =
        struct
>> device_attribute *attr, +                               char *buf) +{ + =
     struct iio_dev
>> *dev_info =3D dev_get_drvdata(dev); +  struct ad799x_state *st =3D
>> iio_dev_get_devdata(dev_info); +     struct iio_dev_attr *this_attr =3D
>> to_iio_dev_attr(attr); +     int ret =3D 0, len =3D 0; + u32 data ; +   =
 u16
>> rxbuf[1]; +  u8 cmd; +       long mask; + +  mutex_lock(&dev_info->mlock=
);
>> +    mask =3D 1 << this_attr->address; +       /* If ring buffer capture=
 is
>> occuring, query the buffer */ +      if (iio_ring_enabled(dev_info)) {
>> +            data =3D ad799x_single_channel_from_ring(st, mask); +      =
       if (data < 0) {
>> +                    ret =3D data; +                   goto error_ret; +=
               } +     } else { +              switch (st->id)
>> { +                  case ad7991: +                  case ad7995: +     =
             case ad7999: +                          cmd =3D
>> st->config | +                                       (mask << AD799X_CHA=
NNEL_SHIFT); +                               break; +                      =
  case
>> ad7992: +                    case ad7993: +                  case ad7994=
: +                          cmd =3D mask <<
>> AD799X_CHANNEL_SHIFT; +                              break; +           =
             case ad7997: +                  case ad7998:
>> +                            cmd =3D (this_attr->address << +           =
                       AD799X_CHANNEL_SHIFT) |
>> +                                    AD7997_8_READ_SINGLE; +            =
             break; +                        default: +                    =
          cmd =3D 0; +
>> +            } +             ret =3D ad799x_i2c_read16(st, cmd, rxbuf); =
+              if (ret < 0)
>> +                    goto error_ret; + +             data =3D rxbuf[0] &=
 0xFFF; +      } + +   /* Pretty
>> print the result */ +        len =3D sprintf(buf, "%u\n", data); + +erro=
r_ret:
>> +    mutex_unlock(&dev_info->mlock); +       return ret ? ret : len; +} =
+
>> +static ssize_t ad799x_read_frequency(struct device *dev, +             =
                     struct
>> device_attribute *attr, +                                    char *buf) =
+{ + struct iio_dev *dev_info
>> =3D dev_get_drvdata(dev); +    struct ad799x_state *st =3D
>> iio_dev_get_devdata(dev_info); + +   int ret, len =3D 0; +     u8 val; +=
       ret =3D
>> ad799x_i2c_read8(st, AD799X_CYCLE_TMR_REG, &val); +  if (ret) +         =
     return
>> ret; + +     val &=3D AD799X_CYC_MASK; + +     switch (val) { +        c=
ase
>> AD799X_CYC_DIS: +            len =3D sprintf(buf, "0\n"); +            b=
reak; +        case
>> AD799X_CYC_TCONF_32: +               len =3D sprintf(buf, "15625\n"); + =
               break; +        case
>> AD799X_CYC_TCONF_64: +               len =3D sprintf(buf, "7812\n"); +  =
       break; +        case
>> AD799X_CYC_TCONF_128: +              len =3D sprintf(buf, "3906\n"); +  =
       break; +        case
>> AD799X_CYC_TCONF_256: +              len =3D sprintf(buf, "1953\n"); +  =
       break; +        case
>> AD799X_CYC_TCONF_512: +              len =3D sprintf(buf, "976\n"); +   =
       break; +        case
>> AD799X_CYC_TCONF_1024: +             len =3D sprintf(buf, "488\n"); +   =
       break; +        case
>> AD799X_CYC_TCONF_2048: +             len =3D sprintf(buf, "244\n"); +   =
       break; +        }
>> +    return len; +} + +static ssize_t ad799x_write_frequency(struct devi=
ce
>> *dev, +                                       struct device_attribute *a=
ttr, +                                        const char *buf,
>> +                                     size_t len) +{ +       struct iio_=
dev *dev_info =3D
>> dev_get_drvdata(dev); +      struct ad799x_state *st =3D
>> iio_dev_get_devdata(dev_info); + +   long val; +     int ret; +      u8 =
t; + +       ret
>> =3D strict_strtol(buf, 10, &val); +    if (ret) +              return re=
t; +
>> +    mutex_lock(&dev_info->mlock); + ret =3D ad799x_i2c_read8(st,
>> AD799X_CYCLE_TMR_REG, &t); + if (ret) +              goto error_ret_mute=
x; + /*
>> Wipe the bits clean */ +     t &=3D ~AD799X_CYC_MASK; + +      switch (v=
al) {
>> +    case 15625: +           t |=3D AD799X_CYC_TCONF_32; +             b=
reak; +        case 7812: +            t
>> |=3D AD799X_CYC_TCONF_64; +            break; +        case 3906: +     =
       t |=3D
>> AD799X_CYC_TCONF_128; +              break; +        case 1953: +       =
     t |=3D
>> AD799X_CYC_TCONF_256; +              break; +        case 976: +        =
     t |=3D
>> AD799X_CYC_TCONF_512; +              break; +        case 488: +        =
     t |=3D
>> AD799X_CYC_TCONF_1024; +             break; +        case 244: +        =
     t |=3D
>> AD799X_CYC_TCONF_2048; +             break; +        case  0: +         =
     t |=3D AD799X_CYC_DIS;
>> +            break; +        default: +              ret =3D -EINVAL; + =
               goto error_ret_mutex; + }; +
>> +    ret =3D ad799x_i2c_write8(st, AD799X_CYCLE_TMR_REG, t); + +
>> +error_ret_mutex: +  mutex_unlock(&dev_info->mlock); + +     return ret =
?
>> ret : len; +} + + +static ssize_t ad799x_read_channel_config(struct
>> device *dev, +                                       struct device_attri=
bute *attr, +                                        char *buf) +{
>> +    struct iio_dev *dev_info =3D dev_get_drvdata(dev); +      struct
>> ad799x_state *st =3D iio_dev_get_devdata(dev_info); +  struct
>> iio_event_attr *this_attr =3D to_iio_event_attr(attr); + +     int ret; =
+      u16
>> val; +       ret =3D ad799x_i2c_read16(st, this_attr->mask, &val); +   i=
f (ret)
>> +            return ret; + + return sprintf(buf, "%d\n", val); +} + +sta=
tic
>> ssize_t ad799x_write_channel_config(struct device *dev, +               =
                      struct
>> device_attribute *attr, +                                     const char=
 *buf, +                                      size_t len) +{
>> +    struct iio_dev *dev_info =3D dev_get_drvdata(dev); +      struct
>> ad799x_state *st =3D iio_dev_get_devdata(dev_info); +  struct
>> iio_event_attr *this_attr =3D to_iio_event_attr(attr); + +     long val;
>> +    int ret; + +    ret =3D strict_strtol(buf, 10, &val); +   if (ret) =
+              return
>> ret; + +     mutex_lock(&dev_info->mlock); + ret =3D ad799x_i2c_write16(=
st,
>> this_attr->mask, val); +     mutex_unlock(&dev_info->mlock); + +     ret=
urn ret
>> ? ret : len; +} + +#define IIO_EVENT_CODE_AD799X_IN0_LOW
>>      (IIO_EVENT_CODE_DEVICE_SPECIFIC + 0) +#define
>> IIO_EVENT_CODE_AD799X_IN0_HIGH       (IIO_EVENT_CODE_DEVICE_SPECIFIC + 1=
)
>> +#define IIO_EVENT_CODE_AD799X_IN1_LOW       (IIO_EVENT_CODE_DEVICE_SPEC=
IFIC
>> + 2) +#define IIO_EVENT_CODE_AD799X_IN1_HIGH
>>      (IIO_EVENT_CODE_DEVICE_SPECIFIC + 3) +#define
>> IIO_EVENT_CODE_AD799X_IN2_LOW        (IIO_EVENT_CODE_DEVICE_SPECIFIC + 4=
)
>> +#define IIO_EVENT_CODE_AD799X_IN2_HIGH
>>      (IIO_EVENT_CODE_DEVICE_SPECIFIC + 5) +#define
>> IIO_EVENT_CODE_AD799X_IN3_LOW        (IIO_EVENT_CODE_DEVICE_SPECIFIC + 6=
)
>> +#define IIO_EVENT_CODE_AD799X_IN3_HIGH
>>      (IIO_EVENT_CODE_DEVICE_SPECIFIC + 7) + +static void
>> ad799x_interrupt_bh(struct work_struct *work_s) { +  struct ad799x_state
>> *st =3D container_of(work_s, +         struct ad799x_state, work_thresh)=
; +    u8
>> status; +    int i; + +      if (ad799x_i2c_read8(st, AD799X_ALERT_STAT_=
REG,
>> &status)) +          goto err_out; + +       if (!status) +          got=
o err_out; +
>> +    ad799x_i2c_write8(st, AD799X_ALERT_STAT_REG,
>> +AD799X_ALERT_STAT_CLEAR); + +       for (i =3D 0; i < 8; i++) { +      =
       if (status
>> & (1 << i)) +                        iio_push_event(st->indio_dev, 0,
>> +                            IIO_EVENT_CODE_AD799X_IN0_LOW + i, +       =
                     st->last_timestamp); +  } +
>> +err_out: +  enable_irq(st->client->irq); +} + +static int
>> ad799x_interrupt(struct iio_dev *dev_info, +         int index, +       =
     s64
>> timestamp, +         int no_test) +{ +       struct ad799x_state *st =3D
>> dev_info->dev_data; + +      st->last_timestamp =3D timestamp;
>> +    schedule_work(&st->work_thresh); +      return 0; +} +
>> +IIO_EVENT_SH(ad799x, &ad799x_interrupt); + +/* Direct read attribtues
>> */ +static IIO_DEV_ATTR_IN_RAW(0, ad799x_read_single_channel, 0);
>> +static IIO_DEV_ATTR_IN_RAW(1, ad799x_read_single_channel, 1); +static
>> IIO_DEV_ATTR_IN_RAW(2, ad799x_read_single_channel, 2); +static
>> IIO_DEV_ATTR_IN_RAW(3, ad799x_read_single_channel, 3); +static
>> IIO_DEV_ATTR_IN_RAW(4, ad799x_read_single_channel, 4); +static
>> IIO_DEV_ATTR_IN_RAW(5, ad799x_read_single_channel, 5); +static
>> IIO_DEV_ATTR_IN_RAW(6, ad799x_read_single_channel, 6); +static
>> IIO_DEV_ATTR_IN_RAW(7, ad799x_read_single_channel, 7); + +static
>> ssize_t ad799x_show_scale(struct device *dev, +                         =
     struct
>> device_attribute *attr, +                            char *buf) +{ + /* =
Driver currently only
>> support internal vref */ +   struct iio_dev *dev_info =3D
>> dev_get_drvdata(dev); +      struct ad799x_state *st =3D
>> iio_dev_get_devdata(dev_info); +     /* Corresponds to Vref / 2^(bits) *=
/ +
>> +    if ((1 << (st->chip_info->bits + 1)) +      > st->int_vref_mv)
>> +            return sprintf(buf, "0.5\n"); + else +          return spri=
ntf(buf, "%d\n",
>> +                    st->int_vref_mv >> st->chip_info->bits); } + +stati=
c
>> IIO_DEVICE_ATTR(in_scale, S_IRUGO, ad799x_show_scale, NULL, +0); +
>> +static ssize_t ad799x_show_name(struct device *dev, +                  =
              struct
>> device_attribute *attr, +                             char *buf) +{ +   =
     struct iio_dev *dev_info
>> =3D dev_get_drvdata(dev); +    struct ad799x_state *st =3D
>> iio_dev_get_devdata(dev_info); +     return sprintf(buf, "%s\n",
>> st->client->name); } + +static IIO_DEVICE_ATTR(name, S_IRUGO,
>> ad799x_show_name, NULL, 0); + + +static struct attribute
>> *ad7991_5_9_3_4_device_attrs[] =3D {
>> +    &iio_dev_attr_in0_raw.dev_attr.attr,
>> +    &iio_dev_attr_in1_raw.dev_attr.attr,
>> +    &iio_dev_attr_in2_raw.dev_attr.attr,
>> +    &iio_dev_attr_in3_raw.dev_attr.attr,
>> +    &iio_dev_attr_name.dev_attr.attr,
>> +    &iio_dev_attr_in_scale.dev_attr.attr, + NULL +}; + +static struct
>> attribute_group ad7991_5_9_3_4_dev_attr_group =3D { +  .attrs =3D
>> ad7991_5_9_3_4_device_attrs, }; + +static struct attribute
>> *ad7991_5_9_3_4_scan_el_attrs[] =3D { +        &iio_scan_el_in0.dev_attr=
.attr,
>> +    &iio_scan_el_in1.dev_attr.attr, +       &iio_scan_el_in2.dev_attr.a=
ttr,
>> +    &iio_scan_el_in3.dev_attr.attr,
>> +    &iio_dev_attr_in_precision.dev_attr.attr, +     NULL, +}; + +static
>> struct attribute_group ad7991_5_9_3_4_scan_el_group =3D { +    .name =3D
>> "scan_elements", +   .attrs =3D ad7991_5_9_3_4_scan_el_attrs, }; + +stat=
ic
>> struct attribute *ad7992_device_attrs[] =3D {
>> +    &iio_dev_attr_in0_raw.dev_attr.attr,
>> +    &iio_dev_attr_in1_raw.dev_attr.attr,
>> +    &iio_dev_attr_name.dev_attr.attr,
>> +    &iio_dev_attr_in_scale.dev_attr.attr, + NULL +}; + +static struct
>> attribute_group ad7992_dev_attr_group =3D { +  .attrs =3D
>> ad7992_device_attrs, +}; + +static struct attribute
>> *ad7992_scan_el_attrs[] =3D { +        &iio_scan_el_in0.dev_attr.attr,
>> +    &iio_scan_el_in1.dev_attr.attr,
>> +    &iio_dev_attr_in_precision.dev_attr.attr, +     NULL, +}; + +static
>> struct attribute_group ad7992_scan_el_group =3D { +    .name =3D
>> "scan_elements", +   .attrs =3D ad7992_scan_el_attrs, +}; + +static stru=
ct
>> attribute *ad7997_8_device_attrs[] =3D {
>> +    &iio_dev_attr_in0_raw.dev_attr.attr,
>> +    &iio_dev_attr_in1_raw.dev_attr.attr,
>> +    &iio_dev_attr_in2_raw.dev_attr.attr,
>> +    &iio_dev_attr_in3_raw.dev_attr.attr,
>> +    &iio_dev_attr_in4_raw.dev_attr.attr,
>> +    &iio_dev_attr_in5_raw.dev_attr.attr,
>> +    &iio_dev_attr_in6_raw.dev_attr.attr,
>> +    &iio_dev_attr_in7_raw.dev_attr.attr,
>> +    &iio_dev_attr_name.dev_attr.attr,
>> +    &iio_dev_attr_in_scale.dev_attr.attr, + NULL +}; + +static struct
>> attribute_group ad7997_8_dev_attr_group =3D { +        .attrs =3D
>> ad7997_8_device_attrs, +}; + +static struct attribute
>> *ad7997_8_scan_el_attrs[] =3D { +      &iio_scan_el_in0.dev_attr.attr,
>> +    &iio_scan_el_in1.dev_attr.attr, +       &iio_scan_el_in2.dev_attr.a=
ttr,
>> +    &iio_scan_el_in3.dev_attr.attr, +       &iio_scan_el_in4.dev_attr.a=
ttr,
>> +    &iio_scan_el_in5.dev_attr.attr, +       &iio_scan_el_in6.dev_attr.a=
ttr,
>> +    &iio_scan_el_in7.dev_attr.attr,
>> +    &iio_dev_attr_in_precision.dev_attr.attr, +     NULL, +}; + +static
>> struct attribute_group ad7997_8_scan_el_group =3D { +  .name =3D
>> "scan_elements", +   .attrs =3D ad7997_8_scan_el_attrs, +}; +
> There are some elements of the abi refering to naming of these sorts
> of things. They are of course still open to discussion, but please can
> we standardise on something.
>
> Under abi currently this would be
> in0_thresh_low_value

Sounds good to me

>> +IIO_EVENT_ATTR_SH(in0_alert_limit_low, +              iio_event_ad799x,=
 +
>> ad799x_read_channel_config, +                  ad799x_write_channel_conf=
ig, +
>> AD799X_DATALOW_CH1_REG); + in0_thresh_high_value
>> +IIO_EVENT_ATTR_SH(in0_alert_limit_high, +             iio_event_ad799x,=
 +
>> ad799x_read_channel_config, +                  ad799x_write_channel_conf=
ig, +
>> AD799X_DATAHIGH_CH1_REG); +
> Hmmm. Don't have anything for this one - time to add to the abi.
> Perhaps in0_thesh_both_hyst_raw (as it's in units of the capture)

No strong preference here -
in0_thesh_hyst would work for me too

>
>> +IIO_EVENT_ATTR_SH(in0_alert_limit_hyst, +             iio_event_ad799x,=
 +
>> ad799x_read_channel_config, +                  ad799x_write_channel_conf=
ig, +
>> AD799X_HYST_CH1_REG); + +IIO_EVENT_ATTR_SH(in1_alert_limit_low, +
>> iio_event_ad799x, +            ad799x_read_channel_config, +
>> ad799x_write_channel_config, +                 AD799X_DATALOW_CH2_REG); =
+
>> +IIO_EVENT_ATTR_SH(in1_alert_limit_high, +             iio_event_ad799x,=
 +
>> ad799x_read_channel_config, +                  ad799x_write_channel_conf=
ig, +
>> AD799X_DATAHIGH_CH2_REG); + +IIO_EVENT_ATTR_SH(in1_alert_limit_hyst,
>> +              iio_event_ad799x, +             ad799x_read_channel_confi=
g, +
>> ad799x_write_channel_config, +                 AD799X_HYST_CH2_REG); +
>> +IIO_EVENT_ATTR_SH(in2_alert_limit_low, +              iio_event_ad799x,=
 +
>> ad799x_read_channel_config, +                  ad799x_write_channel_conf=
ig, +
>> AD799X_DATALOW_CH3_REG); + +IIO_EVENT_ATTR_SH(in2_alert_limit_high, +
>>  iio_event_ad799x, +           ad799x_read_channel_config, +
>> ad799x_write_channel_config, +                 AD799X_DATAHIGH_CH3_REG);=
 +
>> +IIO_EVENT_ATTR_SH(in2_alert_limit_hyst, +             iio_event_ad799x,=
 +
>> ad799x_read_channel_config, +                  ad799x_write_channel_conf=
ig, +
>> AD799X_HYST_CH3_REG); + +IIO_EVENT_ATTR_SH(in3_alert_limit_low, +
>> iio_event_ad799x, +            ad799x_read_channel_config, +
>> ad799x_write_channel_config, +                 AD799X_DATALOW_CH4_REG); =
+
>> +IIO_EVENT_ATTR_SH(in3_alert_limit_high, +             iio_event_ad799x,=
 +
>> ad799x_read_channel_config, +                  ad799x_write_channel_conf=
ig, +
>> AD799X_DATAHIGH_CH4_REG); + +IIO_EVENT_ATTR_SH(in3_alert_limit_hyst,
>> +              iio_event_ad799x, +             ad799x_read_channel_confi=
g, +
>> ad799x_write_channel_config, +                 AD799X_HYST_CH4_REG); +
>> +IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO, +
>> ad799x_read_frequency, +                           ad799x_write_frequenc=
y);
>> +IIO_CONST_ATTR_SAMP_FREQ_AVAIL("15625 7812 3906 1953 976 488 244 0");
>> + +static struct attribute *ad7993_4_7_8_event_attributes[] =3D {
>> +    &iio_event_attr_in0_alert_limit_low.dev_attr.attr,
>> +    &iio_event_attr_in0_alert_limit_high.dev_attr.attr,
>> +    &iio_event_attr_in0_alert_limit_hyst.dev_attr.attr,
>> +    &iio_event_attr_in1_alert_limit_low.dev_attr.attr,
>> +    &iio_event_attr_in1_alert_limit_high.dev_attr.attr,
>> +    &iio_event_attr_in1_alert_limit_hyst.dev_attr.attr,
>> +    &iio_event_attr_in2_alert_limit_low.dev_attr.attr,
>> +    &iio_event_attr_in2_alert_limit_high.dev_attr.attr,
>> +    &iio_event_attr_in2_alert_limit_hyst.dev_attr.attr,
>> +    &iio_event_attr_in3_alert_limit_low.dev_attr.attr,
>> +    &iio_event_attr_in3_alert_limit_high.dev_attr.attr,
>> +    &iio_event_attr_in3_alert_limit_hyst.dev_attr.attr,
>> +    &iio_dev_attr_sampling_frequency.dev_attr.attr,
>> +    &iio_const_attr_sampling_frequency_available.dev_attr.attr, +   NUL=
L,
>> +}; + +static struct attribute_group ad7993_4_7_8_event_attrs_group =3D =
{
>> +    .attrs =3D ad7993_4_7_8_event_attributes, }; + +static struct attri=
bute
>> *ad7992_event_attributes[] =3D {
>> +    &iio_event_attr_in0_alert_limit_low.dev_attr.attr,
>> +    &iio_event_attr_in0_alert_limit_high.dev_attr.attr,
>> +    &iio_event_attr_in0_alert_limit_hyst.dev_attr.attr,
>> +    &iio_event_attr_in1_alert_limit_low.dev_attr.attr,
>> +    &iio_event_attr_in1_alert_limit_high.dev_attr.attr,
>> +    &iio_event_attr_in1_alert_limit_hyst.dev_attr.attr,
>> +    &iio_dev_attr_sampling_frequency.dev_attr.attr,
>> +    &iio_const_attr_sampling_frequency_available.dev_attr.attr, +   NUL=
L,
>> +}; + +static struct attribute_group ad7992_event_attrs_group =3D {
>> +    .attrs =3D ad7992_event_attributes, +}; + + hehe. You've tested thi=
s
>> driver with the max1368? +/* ad799x and max1368 tested - rest from data
>> sheet */ static const +struct ad799x_chip_info ad799x_chip_info_tbl[] =
=3D
>> { +  [ad7991] =3D { +          .num_inputs =3D 4, +              .bits =
=3D 12, +           .int_vref_mv =3D
>> 4096, +              .dev_attrs =3D &ad7991_5_9_3_4_dev_attr_group, +   =
       .scan_attrs =3D
>> &ad7991_5_9_3_4_scan_el_group, +             .ad799x_set_scan_mode =3D (=
void*)
>> ad7991_5_9_set_scan_mode, +  }, +    [ad7995] =3D { +          .num_inpu=
ts =3D 4,
>> +            .bits =3D 10, +           .int_vref_mv =3D 1024, +         =
 .dev_attrs =3D
>> &ad7991_5_9_3_4_dev_attr_group, +            .scan_attrs =3D
>> &ad7991_5_9_3_4_scan_el_group, +             .ad799x_set_scan_mode =3D (=
void*)
>> ad7991_5_9_set_scan_mode, +  }, +    [ad7999] =3D { +          .num_inpu=
ts =3D 4,
>> +            .bits =3D 10, +           .int_vref_mv =3D 1024, +         =
 .dev_attrs =3D
>> &ad7991_5_9_3_4_dev_attr_group, +            .scan_attrs =3D
>> &ad7991_5_9_3_4_scan_el_group, +             .ad799x_set_scan_mode =3D (=
void*)
>> ad7991_5_9_set_scan_mode, +  }, +    [ad7992] =3D { +          .num_inpu=
ts =3D 2,
>> +            .bits =3D 12, +           .int_vref_mv =3D 4096, +         =
 .monitor_mode =3D true,
>> +            .default_config =3D AD799X_ALERT_EN, +            .dev_attr=
s =3D
>> &ad7992_dev_attr_group, +            .scan_attrs =3D &ad7992_scan_el_gro=
up,
>> +            .event_attrs =3D &ad7992_event_attrs_group, +             .=
ad799x_set_scan_mode =3D
>> (void*) ad7992_3_4_set_scan_mode, +  }, +    [ad7993] =3D { +          .=
num_inputs =3D
>> 4, +         .bits =3D 10, +           .int_vref_mv =3D 1024, +         =
 .monitor_mode =3D true,
>> +            .default_config =3D AD799X_ALERT_EN, +            .dev_attr=
s =3D
>> &ad7991_5_9_3_4_dev_attr_group, +            .scan_attrs =3D
>> &ad7991_5_9_3_4_scan_el_group, +             .event_attrs =3D
>> &ad7993_4_7_8_event_attrs_group, +           .ad799x_set_scan_mode =3D (=
void*)
>> ad7992_3_4_set_scan_mode, +  }, +    [ad7994] =3D { +          .num_inpu=
ts =3D 4,
>> +            .bits =3D 12, +           .int_vref_mv =3D 4096, +         =
 .monitor_mode =3D true,
>> +            .default_config =3D AD799X_ALERT_EN, +            .dev_attr=
s =3D
>> &ad7991_5_9_3_4_dev_attr_group, +            .scan_attrs =3D
>> &ad7991_5_9_3_4_scan_el_group, +             .event_attrs =3D
>> &ad7993_4_7_8_event_attrs_group, +           .ad799x_set_scan_mode =3D (=
void*)
>> ad7992_3_4_set_scan_mode, +  }, +    [ad7997] =3D { +          .num_inpu=
ts =3D 8,
>> +            .bits =3D 10, +           .int_vref_mv =3D 1024, +         =
 .monitor_mode =3D true,
>> +            .default_config =3D AD799X_ALERT_EN, +            .dev_attr=
s =3D
>> &ad7997_8_dev_attr_group, +          .scan_attrs =3D &ad7997_8_scan_el_g=
roup,
>> +            .event_attrs =3D &ad7993_4_7_8_event_attrs_group,
>> +            .ad799x_set_scan_mode =3D (void*) ad7997_8_set_scan_mode, +=
       },
>> +    [ad7998] =3D { +          .num_inputs =3D 8, +              .bits =
=3D 12, +           .int_vref_mv =3D
>> 4096, +              .monitor_mode =3D true, +         .default_config =
=3D AD799X_ALERT_EN,
>> +            .dev_attrs =3D &ad7997_8_dev_attr_group, +                .=
scan_attrs =3D
>> &ad7997_8_scan_el_group, +           .event_attrs =3D
>> &ad7993_4_7_8_event_attrs_group, +           .ad799x_set_scan_mode =3D (=
void*)
>> ad7997_8_set_scan_mode, +    }, +}; + +static int
>> ad799x_initial_setup(struct ad799x_state *st) { +    st->config =3D
>> st->chip_info->default_config; You are doing this twice (see below). +
>> +    return ad799x_set_scan_mode(st, 0); } + +static int __devinit
>> ad799x_probe(struct i2c_client *client, +                               =
const struct
>> i2c_device_id *id) { +       int ret, regdone =3D 0; + struct
>> ad799x_platform_data *pdata =3D client->dev.platform_data; +   struct
>> ad799x_state *st =3D kzalloc(sizeof(*st), GFP_KERNEL); +       if (st =
=3D=3D NULL)
>> { +          ret =3D -ENOMEM; +                goto error_ret; +       }=
 + +   /* this is only used for
>> device removal purposes */ + i2c_set_clientdata(client, st); +
>> +    atomic_set(&st->protect_ring, 0); +     st->id =3D id->driver_data;
>> +    st->chip_info =3D &ad799x_chip_info_tbl[st->id]; +        st->confi=
g =3D
>> st->chip_info->default_config;
> This is done again in ad799x_initial_setup.
> I note at the moment there is no way of changing any of the stuff like
> filtering that is also held in config. Perhaps a todo note somewhere?
>> + +  if (pdata) +            st->int_vref_mv =3D pdata->vref_mv; +     e=
lse
>> +            st->int_vref_mv =3D st->chip_info->int_vref_mv; + +       s=
t->reg =3D
>> regulator_get(&client->dev, "vcc"); +        if (!IS_ERR(st->reg)) { +  =
             ret =3D
>> regulator_enable(st->reg); +         if (ret) +                      got=
o error_put_reg; +   }
>> +    st->client =3D client; + +        st->indio_dev =3D iio_allocate_de=
vice(); +        if
>> (st->indio_dev =3D=3D NULL) { +          ret =3D -ENOMEM; +             =
   goto error_disable_reg;
>> +    } + +   /* Estabilish that the iio_dev is a child of the i2c device=
 */
>> +    st->indio_dev->dev.parent =3D &client->dev; +     st->indio_dev->at=
trs =3D
>> st->chip_info->dev_attrs; +  st->indio_dev->scan_el_attrs =3D
>> st->chip_info->scan_attrs; + st->indio_dev->event_attrs =3D
>> st->chip_info->event_attrs; + +      st->indio_dev->dev_data =3D (void *=
)(st);
>> +    st->indio_dev->driver_module =3D THIS_MODULE; +   st->indio_dev->mo=
des =3D
>> INDIO_DIRECT_MODE; + st->indio_dev->num_interrupt_lines =3D 1; + +     r=
et =3D
>> ad799x_initial_setup(st); +  if (ret) +              goto error_free_dev=
ice; + +     ret
>> =3D ad799x_register_ring_funcs_and_init(st->indio_dev); +      if (ret)
>> +            goto error_free_device; + +     ret =3D
>> iio_device_register(st->indio_dev); +        if (ret) +              got=
o
>> error_cleanup_ring; +        regdone =3D 1; +  ret =3D
>> ad799x_initialize_ring(st->indio_dev->ring); +       if (ret) +         =
     goto
>> error_cleanup_ring; + +      if (client->irq > 0 &&
>> st->chip_info->monitor_mode) { +             INIT_WORK(&st->work_thresh,
>> ad799x_interrupt_bh); + +            ret =3D
>> iio_register_interrupt_line(client->irq, +                           st-=
>indio_dev, +                                0,
>> +                            IRQF_TRIGGER_FALLING, +                    =
     client->name); +                if (ret) +                      goto
>> error_cleanup_ring; + +              /* +             * The event handle=
r list element refer
>> to iio_event_ad799x. +                * All event attributes bind to the=
 same event
>> handler. +            * So, only register event handler once. +         =
      */
>> +            iio_add_event_to_list(&iio_event_ad799x,
>> +                            &st->indio_dev->interrupts[0]->ev_list); + =
     } + +   return 0;
>> +error_cleanup_ring: +       ad799x_ring_cleanup(st->indio_dev);
>> +error_free_device: +        if (!regdone) +         iio_free_device(st-=
>indio_dev);
>> +    else +          iio_device_unregister(st->indio_dev); +error_disabl=
e_reg:
>> +    if (!IS_ERR(st->reg)) +         regulator_disable(st->reg); +error_=
put_reg:
>> +    if (!IS_ERR(st->reg)) +         regulator_put(st->reg); +       kfr=
ee(st); +
>> +error_ret: +        return ret; +} + +static int ad799x_remove(struct
>> i2c_client *client) { +      struct ad799x_state *st =3D
>> i2c_get_clientdata(client); +        struct iio_dev *indio_dev =3D
>> st->indio_dev; + +   if (client->irq > 0 && st->chip_info->monitor_mode)
>> +            iio_unregister_interrupt_line(indio_dev, 0); +
>> +    ad799x_uninitialize_ring(indio_dev->ring);
>> +    ad799x_ring_cleanup(indio_dev); +       iio_device_unregister(indio=
_dev);
>> +    if (!IS_ERR(st->reg)) { +               regulator_disable(st->reg);
>> +            regulator_put(st->reg); +       } +     kfree(st); + +  ret=
urn 0; +} + +static
>> const struct i2c_device_id ad799x_id[] =3D { + { "ad7991", ad7991 }, + {
>> "ad7995", ad7995 }, +        { "ad7999", ad7999 }, + { "ad7992", ad7992 =
}, + {
>> "ad7993", ad7993 }, +        { "ad7994", ad7994 }, + { "ad7997", ad7997 =
}, + {
>> "ad7998", ad7998 }, +        {} +}; + +MODULE_DEVICE_TABLE(i2c, ad799x_i=
d); +
>> +static struct i2c_driver ad799x_driver =3D { +        .driver =3D { +  =
         .name =3D
>> "ad799x", +  }, +    .probe =3D ad799x_probe, +        .remove =3D ad799=
x_remove,
>> +    .id_table =3D ad799x_id, +}; + +static __init int ad799x_init(void)=
 {
>> +    return i2c_add_driver(&ad799x_driver); } + +static __exit void
>> ad799x_exit(void) { +        i2c_del_driver(&ad799x_driver); +} +
>> +MODULE_AUTHOR("Michael Hennerich +<hennerich@blackfin.uclinux.org>");
>> +MODULE_DESCRIPTION("Analog Devices AD799x ADC"); +MODULE_LICENSE("GPL
>> v2"); MODULE_ALIAS("i2c:ad7160"); + +module_init(ad799x_init);
>> +module_exit(ad799x_exit); diff --git
>> a/drivers/staging/iio/adc/ad799x_ring.c
>> b/drivers/staging/iio/adc/ad799x_ring.c new file mode 100644 index
>> 0000000..c785c9f --- /dev/null +++
>> b/drivers/staging/iio/adc/ad799x_ring.c @@ -0,0 +1,282 @@ +/* + *
>> Copyright (C) 2010 Michael Hennerich, Analog Devices Inc. + * Copyright
>> (C) 2008-2010 Jonathan Cameron + * + * This program is free software;
>> you can redistribute it and/or +modify + * it under the terms of the
>> GNU General Public License version 2 +as + * published by the Free
>> Software Foundation. + * + * ad799x_ring.c + */ + +#include
>> <linux/interrupt.h> +#include <linux/gpio.h> +#include
>> <linux/workqueue.h> +#include <linux/device.h> +#include <linux/slab.h>
>> +#include <linux/kernel.h> +#include <linux/sysfs.h> +#include
>> <linux/list.h> +#include <linux/i2c.h> +#include <linux/bitops.h> +
>> +#include "../iio.h" +#include "../ring_generic.h" +#include
>> "../ring_sw.h" +#include "../trigger.h" +#include "../sysfs.h" +
>> +#include "ad799x.h" + +int ad799x_single_channel_from_ring(struct
>> ad799x_state *st, long +mask) { +    unsigned long numvals; +        int=
 count =3D
>> 0, ret; +    u16 *ring_data; +       if (!(st->indio_dev->scan_mask & ma=
sk)) {
>> +            ret =3D -EBUSY; +         goto error_ret; +       } +     n=
umvals =3D
>> st->indio_dev->scan_count; + +       ring_data =3D kmalloc(numvals * 2,
>> GFP_KERNEL); +       if (ring_data =3D=3D NULL) { +              ret =3D=
 -ENOMEM; +                goto
>> error_ret; + } +     ret =3D
>> st->indio_dev->ring->access.read_last(st->indio_dev->ring, +            =
                             (u8
>> *) ring_data); +     if (ret) +              goto error_free_ring_data; =
+    /* Need a
>> count of channels prior to this one */ +     mask >>=3D 1; +   while (ma=
sk) {
>> +            if (mask & st->indio_dev->scan_mask) +                  cou=
nt++; +              mask >>=3D 1; +   }
>> + +  ret =3D be16_to_cpu(ring_data[count]) & 0xFFF; +
>> +error_free_ring_data: +     kfree(ring_data); +error_ret: + return ret;=
 +}
>> + +/** + * ad799x_ring_preenable() setup the parameters of the ring
>> before enabling + * + * The complex nature of the setting of the nuber
>> of bytes per + datum is due + * to this driver currently ensuring that
>> the timestamp is stored + at an 8 + * byte boundary. + **/ +static int
>> ad799x_ring_preenable(struct iio_dev *indio_dev) { + struct
>> ad799x_state *st =3D indio_dev->dev_data; +    size_t d_size; +        u=
nsigned
>> long numvals; + +    /* +     * Need to figure out the current mode base=
d
>> upon the requested +  * scan mask in iio_dev +        */ + + if (st->id =
=3D=3D
>> ad7997 || st->id =3D=3D ad7998) +                ad799x_set_scan_mode(st=
,
>> st->indio_dev->scan_mask); + +       numvals =3D st->indio_dev->scan_cou=
nt; +
>> +    if (indio_dev->ring->access.set_bpd) { +                d_size =3D =
numvals*2 +
>> sizeof(s64); +               if (d_size % 8) +                       d_s=
ize +=3D 8 - (d_size % 8);
>> +            indio_dev->ring->access.set_bpd(indio_dev->ring, d_size); +=
     } +
>> +    return 0; +} + +/** + * ad799x_ring_postenable() typical ring post
>> enable
> missing - for kernel doc (true in several places in max1363 as well,
> those are in the current cleanup patches. (don't think I've posted
> that one yet!)
>> + * + * Only not moved into the core for the hardware ring buffer cases
>> + * that are more sophisticated. + **/ +static int
>> ad799x_ring_postenable(struct iio_dev *indio_dev) { +        if
>> (indio_dev->trig =3D=3D NULL) +          return 0; +     return
>> iio_trigger_attach_poll_func(indio_dev->trig, +
>> indio_dev->pollfunc); +} + +/** + * ad799x_ring_predisable() runs just
>> prior to ring buffer being disabled + * + * Typical predisable function
>> which ensures that no trigger events + can + * occur before we disable
>> the ring buffer (and hence would have no idea + * what to do with them)
>> + **/ +static int ad799x_ring_predisable(struct iio_dev *indio_dev) {
>> +    if (indio_dev->trig) +          return
>> iio_trigger_dettach_poll_func(indio_dev->trig, +
>> indio_dev->pollfunc); +      else +          return 0; +} + +/** + *
>> ad799x_poll_func_th() th of trigger launched polling to ring +buffer +
>> * + * As sampling only occurs on i2c comms occuring, leave
>> +timestamping until + * then.  Some triggers will generate their own
>> time stamp. +Currently + * there is no way of notifying them when no
>> one cares. + **/ +static void ad799x_poll_func_th(struct iio_dev
>> *indio_dev) { +      struct ad799x_state *st =3D indio_dev->dev_data; +
>> +    schedule_work(&st->poll_work); + +      return; +} +/** + *
>> ad799x_poll_bh_to_ring() bh of trigger launched polling to ring buffer
>> + * @work_s: the work struct through which this was scheduled + * + *
>> Currently there is no option in this driver to disable the + saving of
>> + * timestamps within the ring. + * I think the one copy of this at a
>> time was to avoid problems if + the + * trigger was set far too high
>> and the reads then locked up the computer. + **/ +static void
>> ad799x_poll_bh_to_ring(struct work_struct *work_s) { +       struct
>> ad799x_state *st =3D container_of(work_s, struct ad799x_state, +
>> poll_work); +        struct iio_dev *indio_dev =3D st->indio_dev; +    s=
truct
>> iio_sw_ring_buffer *ring =3D iio_to_sw_ring(indio_dev- ring); +        s=
64
>> time_ns; +   __u8 *rxbuf; +  int b_sent; +   size_t d_size; +        u8 =
cmd; +
>> +    unsigned long numvals =3D st->indio_dev->scan_count; + +  /* Ensure=
 the
>> timestamp is 8 byte aligned */ +     d_size =3D numvals*2 + sizeof(s64);=
 +
>> +    if (d_size % sizeof(s64)) +             d_size +=3D sizeof(s64) - (=
d_size %
>> sizeof(s64)); + +    /* Ensure only one copy of this function running at=
 a
>> time */ +    if (atomic_inc_return(&st->protect_ring) > 1) +         ret=
urn; +
>> +    /* Monitor mode prevents reading. Whilst not currently implemented =
+
>> * might as well have this test in here in the meantime as it does +   *
>> no harm. +    */ +   if (numvals =3D=3D 0) +             return; + +    =
 rxbuf =3D
>> kmalloc(d_size,      GFP_KERNEL); +  if (rxbuf =3D=3D NULL) +           =
 return; + +     switch
>> (st->id) { +         case ad7991: +          case ad7995: +          cas=
e ad7999: +                  cmd =3D
>> st->config | +                               (st->indio_dev->scan_mask <=
< AD799X_CHANNEL_SHIFT);
>> +                    break; +                case ad7992: +          cas=
e ad7993: +          case ad7994: +                  cmd =3D
>> (st->indio_dev->scan_mask << +                               AD799X_CHAN=
NEL_SHIFT) |
>> AD799X_CONV_RES_REG; +                       break; +                cas=
e ad7997: +          case ad7998: +                  cmd
>> =3D AD7997_8_READ_SEQUENCE | AD799X_CONV_RES_REG; +                    b=
reak; +                default:
>> +                    cmd =3D 0; +      } + +   b_sent =3D i2c_smbus_read=
_i2c_block_data(st->client,
>> +                    cmd, numvals*2, rxbuf); +       if (b_sent < 0) +  =
             goto done; + +  time_ns
>> =3D iio_get_time_ns(); + +     memcpy(rxbuf + d_size - sizeof(s64), &tim=
e_ns,
>> sizeof(time_ns)); + +        indio_dev->ring->access.store_to(&ring->buf=
,
>> rxbuf, time_ns); +done: +    kfree(rxbuf);
>> +    atomic_dec(&st->protect_ring); +} + + +int
>> ad799x_register_ring_funcs_and_init(struct iio_dev *indio_dev) {
>> +    struct ad799x_state *st =3D indio_dev->dev_data; +        int ret =
=3D 0; +
>> +    indio_dev->ring =3D iio_sw_rb_allocate(indio_dev); +      if
>> (!indio_dev->ring) { +               ret =3D -ENOMEM; +                g=
oto error_ret; +       } +     /*
>> Effectively select the ring buffer implementation */
>> +    iio_ring_sw_register_funcs(&st->indio_dev->ring->access);
>> +    indio_dev->pollfunc =3D kzalloc(sizeof(*indio_dev->pollfunc),
>> GFP_KERNEL); +       if (indio_dev->pollfunc =3D=3D NULL) { +           =
 ret =3D -ENOMEM;
>> +            goto error_deallocate_sw_rb; +  } +     /* Configure the po=
lling function
>> called on trigger interrupts */ +    indio_dev->pollfunc->poll_func_main=
 =3D
>> &ad799x_poll_func_th; +      indio_dev->pollfunc->private_data =3D indio=
_dev;
>> + +  /* Ring buffer functions - here trigger setup related */
>> +    indio_dev->ring->postenable =3D &ad799x_ring_postenable;
>> +    indio_dev->ring->preenable =3D &ad799x_ring_preenable;
>> +    indio_dev->ring->predisable =3D &ad799x_ring_predisable;
>> +    INIT_WORK(&st->poll_work, &ad799x_poll_bh_to_ring); + + /* Flag tha=
t
>> polled ring buffering is possible */ +       indio_dev->modes |=3D
>> INDIO_RING_TRIGGERED; +      return 0; +error_deallocate_sw_rb:
>> +    iio_sw_rb_free(indio_dev->ring); +error_ret: +  return ret; +} + +v=
oid
>> ad799x_ring_cleanup(struct iio_dev *indio_dev) { +   /* ensure that the
>> trigger has been detached */ +       if (indio_dev->trig) {
>> +            iio_put_trigger(indio_dev->trig);
>> +            iio_trigger_dettach_poll_func(indio_dev->trig, +
>> indio_dev->pollfunc); +      } +     kfree(indio_dev->pollfunc);
>> +    iio_sw_rb_free(indio_dev->ring); +} + +void
>> ad799x_uninitialize_ring(struct iio_ring_buffer *ring) {
>> +    iio_ring_buffer_unregister(ring); +}; + +int
>> ad799x_initialize_ring(struct iio_ring_buffer *ring) { +     return
>> iio_ring_buffer_register(ring, 0); };

Greetings,
Michael

Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036 Geschaeft=
sfuehrer Thomas Wessel, William A. Martin, Margaret Seif
