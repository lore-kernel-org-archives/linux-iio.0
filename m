Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>, Mike Frysinger <vapier@gentoo.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>, "Zhang, Sonic"
	<Sonic.Zhang@analog.com>
Date: Mon, 25 Oct 2010 14:40:54 +0100
Subject: RE: BUILD ISSUE: Re: [PATCH 07/36] staging: iio: adc: new driver
 for AD7291 devices
Message-ID: <544AC56F16B56944AEC3BD4E3D59177130945B1C0A@LIMKCMBX1.ad.analog.com>
References: <1287955358-3153-1-git-send-email-vapier@gentoo.org>
 <1287955358-3153-8-git-send-email-vapier@gentoo.org>
 <4CC58904.9010401@cam.ac.uk>
In-Reply-To: <4CC58904.9010401@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2010-10-25:
> On 10/24/10 22:22, Mike Frysinger wrote:
>> From: Sonic Zhang <sonic.zhang@analog.com>
> Build test results (cross compiled for arm) on top of staging-next
>
> drivers/staging/iio/adc/ad7291.c: In function 'ad7291_probe':
> drivers/staging/iio/adc/ad7291.c:951: error: 'struct i2c_client' has
> no member named 'irq_flags'
> drivers/staging/iio/adc/ad7291.c:966: error: 'struct i2c_client' has
> no member named 'irq_flags'
>
> Google tells me you guys have posted a patch adding this a couple of
> weeks back.  Doesn't
> look like Jean liked it...   If it is merging you need to tell Greg
> that there is a dependency
> on it when you send him the merge request. Otherwise just remove the
> usage and rely on it happening in board setup code. Personally I agree
> with what the patch was trying to do, but if it isn't merging we don't
> want to hold this driver up waiting for it.

Ok - I remove it for now.

Actually we've added irq_flags to both i2c and spi board info.
There were a few people who commented positively on both patches.
Feel free to send your cents as well.

-Michael

>>
>> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
>> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
>> ---
>>  drivers/staging/iio/adc/Kconfig  |    7 +
>>  drivers/staging/iio/adc/Makefile |    1 +
>>  drivers/staging/iio/adc/ad7291.c | 1039
>>  ++++++++++++++++++++++++++++++++++++++ 3 files changed, 1047
>>  insertions(+), 0 deletions(-)  create mode
>> 100644 drivers/staging/iio/adc/ad7291.c
>>
>> diff --git a/drivers/staging/iio/adc/Kconfig
>> b/drivers/staging/iio/adc/Kconfig index 7f03571..fa78413 100644
>> --- a/drivers/staging/iio/adc/Kconfig
>> +++ b/drivers/staging/iio/adc/Kconfig
>> @@ -41,6 +41,13 @@ config AD7152
>>        Say yes here to build support for Analog Devices capacitive
>>  sensors.      (ad7152, ad7153) Provides direct access via sysfs.
>> +config AD7291
>> +    tristate "Analog Devices AD7291 temperature sensor driver"
>> +    depends on I2C
>> +    help
>> +      Say yes here to build support for Analog Devices AD7291
>> +      temperature sensors.
>> +
>>  config AD799X
>>      tristate "Analog Devices AD799x ADC driver"
>>      depends on I2C
>> diff --git a/drivers/staging/iio/adc/Makefile
>> b/drivers/staging/iio/adc/Makefile
>> index a134754..5e99a86 100644
>> --- a/drivers/staging/iio/adc/Makefile
>> +++ b/drivers/staging/iio/adc/Makefile
>> @@ -17,3 +17,4 @@ obj-$(CONFIG_AD7476) +=3D ad7476.o
>>
>>  obj-$(CONFIG_AD7150) +=3D ad7150.o
>>  obj-$(CONFIG_AD7152) +=3D ad7152.o
>> +obj-$(CONFIG_AD7291) +=3D ad7291.o diff --git
>> a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
>> new file mode 100644 index 0000000..a9d3756 --- /dev/null +++
>> b/drivers/staging/iio/adc/ad7291.c @@ -0,0 +1,1039 @@ +/* + * AD7291
>> digital temperature sensor driver supporting AD7291 + * + * Copyright
>> 2010 Analog Devices Inc. + * + * Licensed under the GPL-2 or later. +
>> */ + +#include <linux/interrupt.h> +#include <linux/gpio.h> +#include
>> <linux/workqueue.h> +#include <linux/device.h> +#include
>> <linux/kernel.h> +#include <linux/slab.h> +#include <linux/sysfs.h>
>> +#include <linux/list.h> +#include <linux/i2c.h> +#include
>> <linux/rtc.h> + +#include "../iio.h" +#include "../sysfs.h" + +/* + *
>> AD7291 registers definition + */ +#define AD7291_COMMAND                =
     0 +#define
>> AD7291_VOLTAGE                       1 +#define AD7291_T_SENSE          =
             2 +#define
>> AD7291_T_AVERAGE             3 +#define AD7291_VOLTAGE_LIMIT_BASE    4 +=
#define
>> AD7291_VOLTAGE_LIMIT_COUNT   8 +#define AD7291_T_SENSE_HIGH          0x1=
c
>> +#define AD7291_T_SENSE_LOW          0x1d +#define AD7291_T_SENSE_HYST  =
             0x1e
>> +#define AD7291_VOLTAGE_ALERT_STATUS 0x1f +#define
>> AD7291_T_ALERT_STATUS                0x20 + +/* + * AD7291 command + */ =
+#define
>> AD7291_AUTOCYCLE             0x1 +#define AD7291_RESET                  =
     0x2 +#define
>> AD7291_ALART_CLEAR           0x4 +#define AD7291_ALART_POLARITY         =
     0x8 +#define
>> AD7291_EXT_REF                       0x10 +#define AD7291_NOISE_DELAY   =
             0x20 +#define
>> AD7291_T_SENSE_MASK          0x40 +#define AD7291_VOLTAGE_MASK          =
     0xff00 +#define
>> AD7291_VOLTAGE_OFFSET                0x8 + +/* + * AD7291 value masks + =
*/ +#define
>> AD7291_CHANNEL_MASK          0xf000 +#define AD7291_VALUE_MASK          =
     0xfff +#define
>> AD7291_T_VALUE_SIGN          0x400 +#define AD7291_T_VALUE_FLOAT_OFFSET =
     2
>> +#define AD7291_T_VALUE_FLOAT_MASK   0x2 + +/* + * struct
>> ad7291_chip_info - chip specifc information  */ + +struct
>> ad7291_chip_info { + const char *name; +     struct i2c_client *client;
>> +    struct iio_dev *indio_dev; +    struct work_struct thresh_work; +  =
     s64
>> last_timestamp; +    u16 command; +  u8  channels;   /* Active voltage
>> channels */ +}; + +/* + * struct ad7291_chip_info - chip specifc
>> information  */ + +struct ad7291_limit_regs { +      u16     data_high;
>> +    u16     data_low; +     u16     hysteresis; +}; + +/* + * ad7291 re=
gister access
>> by I2C + */ +static int ad7291_i2c_read(struct ad7291_chip_info *chip,
>> u8 reg, u16 +*data) { +      struct i2c_client *client =3D chip->client;=
 +     int
>> ret =3D 0; + + ret =3D i2c_smbus_read_word_data(client, reg); +  if (ret=
 <
>> 0) { +               dev_err(&client->dev, "I2C read error\n"); +       =
     return ret; +   } +
>> +    *data =3D swab16((u16)ret); + +   return 0; +} + +static int
>> ad7291_i2c_write(struct ad7291_chip_info *chip, u8 reg, +u16 data) {
>> +    struct i2c_client *client =3D chip->client; +     int ret =3D 0; + =
+        ret =3D
>> i2c_smbus_write_word_data(client, reg, swab16(data)); +      if (ret < 0=
)
>> +            dev_err(&client->dev, "I2C write error\n"); + + return ret;=
 +} + +/*
>> Returns negative errno, or else the number of words read. */ +static
>> int ad7291_i2c_read_data(struct ad7291_chip_info *chip, u8 +reg, u16
>> *data) { +   struct i2c_client *client =3D chip->client; +     u8 comman=
ds[4];
>> +    int ret =3D 0; +  int i, count; + +       if (reg =3D=3D AD7291_T_S=
ENSE || reg =3D=3D
>> AD7291_T_AVERAGE) +          count =3D 2; +    else if (reg =3D=3D AD729=
1_VOLTAGE) {
>> +            if (!chip->channels) { +                        dev_err(&cl=
ient->dev, "No voltage channel
>> is selected.\n"); +                  return -EINVAL; +               } +=
             count =3D 2 +
>> chip->channels * 2; +        } else { +              dev_err(&client->de=
v, "I2C wrong data
>> register\n"); +              return -EINVAL; +       } + +   commands[0]=
 =3D 0; +      commands[1]
>> =3D (chip->command >> 8) & 0xff; +     commands[2] =3D chip->command & 0=
xff;
>> +    commands[3] =3D reg; + +  ret =3D i2c_master_send(client, commands,=
 4);
>> +    if (ret < 0) { +                dev_err(&client->dev, "I2C master s=
end error\n");
>> +            return ret; +   } + +   ret =3D i2c_master_recv(client, (u8=
 *)data,
>> count); +    if (ret < 0) { +                dev_err(&client->dev, "I2C =
master receive
>> error\n"); +         return ret; +   } +     ret >>=3D 2; + +  for (i =
=3D 0; i < ret;
>> i++) +               data[i] =3D swab16(data[i]); + +  return ret; +} + =
+static ssize_t
>> ad7291_show_mode(struct device *dev, +               struct device_attri=
bute *attr,
>> +            char *buf) +{ + struct iio_dev *dev_info =3D dev_get_drvdat=
a(dev);
>> +    struct ad7291_chip_info *chip =3D dev_info->dev_data; + + if
>> (chip->command & AD7291_AUTOCYCLE) +         return sprintf(buf,
>> "autocycle\n"); +    else +          return sprintf(buf, "command\n"); }=
 + +static
>> ssize_t ad7291_store_mode(struct device *dev, +              struct
>> device_attribute *attr, +            const char *buf, +              siz=
e_t len) +{ +        struct
>> iio_dev *dev_info =3D dev_get_drvdata(dev); +  struct ad7291_chip_info
>> *chip =3D dev_info->dev_data; +        u16 command; +  int ret; + +    c=
ommand =3D
>> chip->command & (~AD7291_AUTOCYCLE); +       if (strcmp(buf, "autocycle"=
))
>> +            command |=3D AD7291_AUTOCYCLE; + +        ret =3D ad7291_i2=
c_write(chip,
>> AD7291_COMMAND, command); +  if (ret) +              return -EIO; + +   =
     chip->command
>> =3D command; + +       return ret; +} + +static IIO_DEVICE_ATTR(mode, S_=
IRUGO |
>> S_IWUSR, +           ad7291_show_mode, +             ad7291_store_mode, =
+            0); + +static
>> ssize_t ad7291_show_available_modes(struct device *dev, +            str=
uct
>> device_attribute *attr, +            char *buf) +{ + return sprintf(buf,
>> "command\nautocycle\n"); } + +static IIO_DEVICE_ATTR(available_modes,
>> S_IRUGO, +ad7291_show_available_modes, NULL, 0); + +static ssize_t
>> ad7291_store_reset(struct device *dev, +             struct device_attri=
bute
>> *attr, +             const char *buf, +              size_t len) +{ +   =
     struct iio_dev *dev_info
>> =3D dev_get_drvdata(dev); +    struct ad7291_chip_info *chip =3D
>> dev_info->dev_data; +        u16 command; +  int ret; + +    command =3D
>> chip->command | AD7291_RESET; + +    ret =3D ad7291_i2c_write(chip,
>> AD7291_COMMAND, command); +  if (ret) +              return -EIO; + +   =
     return ret; +}
>> + +static IIO_DEVICE_ATTR(reset, S_IWUSR, +          NULL,
>> +            ad7291_store_reset, +           0); + +static ssize_t
>> ad7291_show_ext_ref(struct device *dev, +            struct device_attri=
bute
>> *attr, +             char *buf) +{ + struct iio_dev *dev_info =3D
>> dev_get_drvdata(dev); +      struct ad7291_chip_info *chip =3D
>> dev_info->dev_data; + +      return sprintf(buf, "%d\n", !!(chip->comman=
d &
>> AD7291_EXT_REF)); } + +static ssize_t ad7291_store_ext_ref(struct
>> device *dev, +               struct device_attribute *attr, +           =
     const char *buf,
>> +            size_t len) +{ +        struct iio_dev *dev_info =3D dev_ge=
t_drvdata(dev);
>> +    struct ad7291_chip_info *chip =3D dev_info->dev_data; +   u16 comma=
nd;
>> +    int ret; + +    command =3D chip->command & (~AD7291_EXT_REF); +  i=
f
>> (strcmp(buf, "1")) +         command |=3D AD7291_EXT_REF; + +  ret =3D
>> ad7291_i2c_write(chip, AD7291_COMMAND, command); +   if (ret) +         =
     return
>> -EIO; + +    chip->command =3D command; + +    return ret; +} + +static
>> IIO_DEVICE_ATTR(ext_ref, S_IRUGO | S_IWUSR, +                ad7291_show=
_ext_ref,
>> +            ad7291_store_ext_ref, +         0); + +static ssize_t
>> ad7291_show_noise_delay(struct device *dev, +                struct devi=
ce_attribute
>> *attr, +             char *buf) +{ + struct iio_dev *dev_info =3D
>> dev_get_drvdata(dev); +      struct ad7291_chip_info *chip =3D
>> dev_info->dev_data; + +      return sprintf(buf, "%d\n", !!(chip->comman=
d &
>> AD7291_NOISE_DELAY)); +} + +static ssize_t
>> ad7291_store_noise_delay(struct device *dev, +               struct devi=
ce_attribute
>> *attr, +             const char *buf, +              size_t len) +{ +   =
     struct iio_dev *dev_info
>> =3D dev_get_drvdata(dev); +    struct ad7291_chip_info *chip =3D
>> dev_info->dev_data; +        u16 command; +  int ret; + +    command =3D
>> chip->command & (~AD7291_NOISE_DELAY); +     if (strcmp(buf, "1"))
>> +            command |=3D AD7291_NOISE_DELAY; + +      ret =3D ad7291_i2=
c_write(chip,
>> AD7291_COMMAND, command); +  if (ret) +              return -EIO; + +   =
     chip->command
>> =3D command; + +       return ret; +} + +static IIO_DEVICE_ATTR(noise_de=
lay,
>> S_IRUGO | S_IWUSR, +         ad7291_show_noise_delay,
>> +            ad7291_store_noise_delay, +             0); + +static ssize=
_t
>> ad7291_show_t_sense(struct device *dev, +            struct device_attri=
bute
>> *attr, +             char *buf) +{ + struct iio_dev *dev_info =3D
>> dev_get_drvdata(dev); +      struct ad7291_chip_info *chip =3D
>> dev_info->dev_data; +        u16 data; +     char sign =3D ' '; +      i=
nt ret; + +    ret =3D
>> ad7291_i2c_read_data(chip, AD7291_T_SENSE, &data); + if (ret) +         =
     return
>> -EIO; + +    if (data & AD7291_T_VALUE_SIGN) { +             /* convert =
supplement to
>> positive value */ +          data =3D (AD7291_T_VALUE_SIGN << 1) - data;=
 +             sign
>> =3D '-'; +     } + +   return sprintf(buf, "%c%d.%.2d\n", sign, +       =
       (data >>
>> AD7291_T_VALUE_FLOAT_OFFSET), +              (data & AD7291_T_VALUE_FLOA=
T_MASK) *
>> 25); } + +static IIO_DEVICE_ATTR(t_sense, S_IRUGO, ad7291_show_t_sense,
>> NULL, +0); + +static ssize_t ad7291_show_t_average(struct device *dev,
>> +            struct device_attribute *attr, +                char *buf) =
+{ + struct iio_dev
>> *dev_info =3D dev_get_drvdata(dev); +  struct ad7291_chip_info *chip =3D
>> dev_info->dev_data; +        u16 data; +     char sign =3D ' '; +      i=
nt ret; + +    ret =3D
>> ad7291_i2c_read_data(chip, AD7291_T_AVERAGE, &data); +       if (ret)
>> +            return -EIO; + +        if (data & AD7291_T_VALUE_SIGN) { +=
             /* convert
>> supplement to positive value */ +            data =3D (AD7291_T_VALUE_SI=
GN << 1) -
>> data; +              sign =3D '-'; +   } + +   return sprintf(buf, "%c%d=
.%.2d\n", sign,
>> +            (data >> AD7291_T_VALUE_FLOAT_OFFSET), +                (da=
ta &
>> AD7291_T_VALUE_FLOAT_MASK) * 25); } + +static
>> IIO_DEVICE_ATTR(t_average, S_IRUGO, ad7291_show_t_average, +NULL, 0); +
>> +static ssize_t ad7291_show_voltage(struct device *dev, +            str=
uct
>> device_attribute *attr, +            char *buf) +{ + struct iio_dev *dev=
_info =3D
>> dev_get_drvdata(dev); +      struct ad7291_chip_info *chip =3D
>> dev_info->dev_data; +        u16 data[AD7291_VOLTAGE_LIMIT_COUNT]; + int=
 i,
>> size, ret; + +       ret =3D ad7291_i2c_read_data(chip, AD7291_VOLTAGE, =
data);
>> +    if (ret) +              return -EIO; + +        for (i =3D 0; i <
>> AD7291_VOLTAGE_LIMIT_COUNT; i++) { +         if (chip->command &
>> (AD7291_T_SENSE_MASK << i)) { +                      ret =3D sprintf(buf=
,
>> "channel[%d]=3D%d\n", i, +                                     data[i] &=
 AD7291_VALUE_MASK); +                 if (ret
>> < 0) +                               break; +                        buf=
 +=3D ret; +                   size +=3D ret; +          } +     } + +   re=
turn
>> size; +} + +static IIO_DEVICE_ATTR(voltage, S_IRUGO,
>> ad7291_show_voltage, NULL, +0); + +static ssize_t
>> ad7291_show_channel_mask(struct device *dev, +               struct devi=
ce_attribute
>> *attr, +             char *buf) +{ + struct iio_dev *dev_info =3D
>> dev_get_drvdata(dev); +      struct ad7291_chip_info *chip =3D
>> dev_info->dev_data; + +      return sprintf(buf, "0x%x\n", (chip->comman=
d &
>> AD7291_VOLTAGE_MASK) >> +                    AD7291_VOLTAGE_OFFSET); +} =
+ +static
>> ssize_t ad7291_store_channel_mask(struct device *dev, +              str=
uct
>> device_attribute *attr, +            const char *buf, +              siz=
e_t len) +{ +        struct
>> iio_dev *dev_info =3D dev_get_drvdata(dev); +  struct ad7291_chip_info
>> *chip =3D dev_info->dev_data; +        u16 command; +  unsigned long dat=
a; +   int
>> i, ret; + +  ret =3D strict_strtoul(buf, 16, &data); + if (ret || data >
>> 0xff) +              return -EINVAL; + +     command =3D chip->command &
>> (~AD7291_VOLTAGE_MASK); +    command |=3D data << AD7291_VOLTAGE_OFFSET;=
 +
>> +    ret =3D ad7291_i2c_write(chip, AD7291_COMMAND, command); +        i=
f (ret)
>> +            return -EIO; + +        chip->command =3D command; + +    f=
or (i =3D 0,
>> chip->channels =3D 0; i < AD7291_VOLTAGE_LIMIT_COUNT; i++) { +         i=
f
>> (chip->command & (AD7291_T_SENSE_MASK << i)) +                       chi=
p->channels++; +     }
>> + +  return ret; +} + +static IIO_DEVICE_ATTR(channel_mask, S_IRUGO |
>> S_IWUSR, +           ad7291_show_channel_mask, +             ad7291_stor=
e_channel_mask,
>> +            0); + +static ssize_t ad7291_show_name(struct device *dev, =
+            struct
>> device_attribute *attr, +            char *buf) +{ + struct iio_dev *dev=
_info =3D
>> dev_get_drvdata(dev); +      struct ad7291_chip_info *chip =3D
>> dev_info->dev_data; +        return sprintf(buf, "%s\n", chip->name); } =
+
>> +static IIO_DEVICE_ATTR(name, S_IRUGO, ad7291_show_name, NULL, 0); +
>> +static struct attribute *ad7291_attributes[] =3D {
>> +    &iio_dev_attr_available_modes.dev_attr.attr,
>> +    &iio_dev_attr_mode.dev_attr.attr,
>> +    &iio_dev_attr_reset.dev_attr.attr,
>> +    &iio_dev_attr_ext_ref.dev_attr.attr,
>> +    &iio_dev_attr_noise_delay.dev_attr.attr,
>> +    &iio_dev_attr_t_sense.dev_attr.attr,
>> +    &iio_dev_attr_t_average.dev_attr.attr,
>> +    &iio_dev_attr_voltage.dev_attr.attr,
>> +    &iio_dev_attr_channel_mask.dev_attr.attr,
>> +    &iio_dev_attr_name.dev_attr.attr, +     NULL, +}; + +static const s=
truct
>> attribute_group ad7291_attribute_group =3D { + .attrs =3D
>> ad7291_attributes, +}; + +/* + * temperature bound events + */ +
>> +#define IIO_EVENT_CODE_AD7291_T_SENSE_HIGH  IIO_BUFFER_EVENT_CODE(0)
>> +#define IIO_EVENT_CODE_AD7291_T_SENSE_LOW   IIO_BUFFER_EVENT_CODE(1)
>> +#define IIO_EVENT_CODE_AD7291_T_AVG_HIGH    IIO_BUFFER_EVENT_CODE(2)
>> +#define IIO_EVENT_CODE_AD7291_T_AVG_LOW     IIO_BUFFER_EVENT_CODE(3)
>> +#define IIO_EVENT_CODE_AD7291_VOLTAGE_BASE +IIO_BUFFER_EVENT_CODE(4) +
>> +static void ad7291_interrupt_bh(struct work_struct *work_s) { +     str=
uct
>> ad7291_chip_info *chip =3D +           container_of(work_s, struct
>> ad7291_chip_info, thresh_work); +    u16 t_status, v_status; +       u16
>> command; +   int i; + +      if (ad7291_i2c_read(chip, AD7291_T_ALERT_ST=
ATUS,
>> &t_status)) +                return; + +     if (ad7291_i2c_read(chip,
>> AD7291_VOLTAGE_ALERT_STATUS, &v_status)) +           return; + +     if =
(!(t_status
>> || v_status)) +              return; + +     command =3D chip->command |
>> AD7291_ALART_CLEAR; +        ad7291_i2c_write(chip, AD7291_COMMAND, comm=
and);
>> + +  command =3D chip->command & ~AD7291_ALART_CLEAR;
>> +    ad7291_i2c_write(chip, AD7291_COMMAND, command); +
>> +    enable_irq(chip->client->irq); + +      for (i =3D 0; i < 4; i++) {=
 +             if
>> (t_status & (1 << i)) +                      iio_push_event(chip->indio_=
dev, 0,
>> +                            IIO_EVENT_CODE_AD7291_T_SENSE_HIGH + i,
>> +                            chip->last_timestamp); +        } + +   for=
 (i =3D 0; i <
>> AD7291_VOLTAGE_LIMIT_COUNT*2; i++) { +               if (v_status & (1 <=
< i))
>> +                    iio_push_event(chip->indio_dev, 0,
>> +                            IIO_EVENT_CODE_AD7291_VOLTAGE_BASE + i,
>> +                            chip->last_timestamp); +        } +} + +sta=
tic int
>> ad7291_interrupt(struct iio_dev *dev_info, +         int index, +       =
     s64
>> timestamp, +         int no_test) +{ +       struct ad7291_chip_info *ch=
ip =3D
>> dev_info->dev_data; + +      chip->last_timestamp =3D timestamp;
>> +    schedule_work(&chip->thresh_work); + +  return 0; +} +
>> +IIO_EVENT_SH(ad7291, &ad7291_interrupt); + +static inline ssize_t
>> ad7291_show_t_bound(struct device *dev, +            struct device_attri=
bute
>> *attr, +             u8 bound_reg, +         char *buf) +{ + struct iio_=
dev *dev_info =3D
>> dev_get_drvdata(dev); +      struct ad7291_chip_info *chip =3D
>> dev_info->dev_data; +        u16 data; +     char sign =3D ' '; +      i=
nt ret; + +    ret =3D
>> ad7291_i2c_read(chip, bound_reg, &data); +   if (ret) +              ret=
urn -EIO; +
>> +    data &=3D AD7291_VALUE_MASK; +    if (data & AD7291_T_VALUE_SIGN) {=
 +             /*
>> convert supplement to positive value */ +            data =3D (AD7291_T_=
VALUE_SIGN
>> << 1) - data; +              sign =3D '-'; +   } + +   return sprintf(bu=
f, "%c%d.%.2d\n",
>> sign, +                      data >> AD7291_T_VALUE_FLOAT_OFFSET, +     =
             (data &
>> AD7291_T_VALUE_FLOAT_MASK) * 25); } + +static inline ssize_t
>> ad7291_set_t_bound(struct device *dev, +             struct device_attri=
bute
>> *attr, +             u8 bound_reg, +         const char *buf, +         =
     size_t len) +{ +        struct
>> iio_dev *dev_info =3D dev_get_drvdata(dev); +  struct ad7291_chip_info
>> *chip =3D dev_info->dev_data; +        long tmp1, tmp2; +      u16 data;=
 +     char *pos;
>> +    int ret; + +    pos =3D strchr(buf, '.'); + +     ret =3D strict_st=
rtol(buf, 10,
>> &tmp1); + +  if (ret || tmp1 > 127 || tmp1 < -128) +         return -EIN=
VAL; +
>> +    if (pos) { +            len =3D strlen(pos); +            if (len >
>> AD7291_T_VALUE_FLOAT_OFFSET) +                       len =3D AD7291_T_VA=
LUE_FLOAT_OFFSET;
>> +            pos[len] =3D 0; +         ret =3D strict_strtol(pos, 10, &t=
mp2); + +                if (!ret)
>> +                    tmp2 =3D (tmp2 / 25) * 25; +      } + +   if (tmp1 =
< 0) +         data =3D
>> (u16)(-tmp1); +      else +          data =3D (u16)tmp1; +     data =3D =
(data <<
>> AD7291_T_VALUE_FLOAT_OFFSET) | +             (tmp2 & AD7291_T_VALUE_FLOA=
T_MASK);
>> +    if (tmp1 < 0) +         /* convert positive value to supplyment */ =
+            data =3D
>> (AD7291_T_VALUE_SIGN << 1) - data; + +       ret =3D ad7291_i2c_write(ch=
ip,
>> bound_reg, data); +  if (ret) +              return -EIO; + +        ret=
urn ret; +} +
>> +static ssize_t ad7291_show_t_sense_high(struct device *dev, +          =
     struct
>> device_attribute *attr, +            char *buf) +{ + return
>> ad7291_show_t_bound(dev, attr, +                     AD7291_T_SENSE_HIGH=
, buf); +} +
>> +static inline ssize_t ad7291_set_t_sense_high(struct device *dev,
>> +            struct device_attribute *attr, +                const char =
*buf, +              size_t len) +{
>> +    return ad7291_set_t_bound(dev, attr, +                  AD7291_T_SE=
NSE_HIGH, buf,
>> len); +} + +static ssize_t ad7291_show_t_sense_low(struct device *dev,
>> +            struct device_attribute *attr, +                char *buf) =
+{ + return
>> ad7291_show_t_bound(dev, attr, +                     AD7291_T_SENSE_LOW,=
 buf); +} +
>> +static inline ssize_t ad7291_set_t_sense_low(struct device *dev,
>> +            struct device_attribute *attr, +                const char =
*buf, +              size_t len) +{
>> +    return ad7291_set_t_bound(dev, attr, +                  AD7291_T_SE=
NSE_LOW, buf,
>> len); +} + +static ssize_t ad7291_show_t_sense_hyst(struct device *dev,
>> +            struct device_attribute *attr, +                char *buf) =
+{ + return
>> ad7291_show_t_bound(dev, attr, +                     AD7291_T_SENSE_HYST=
, buf); +} +
>> +static inline ssize_t ad7291_set_t_sense_hyst(struct device *dev,
>> +            struct device_attribute *attr, +                const char =
*buf, +              size_t len) +{
>> +    return ad7291_set_t_bound(dev, attr, +                  AD7291_T_SE=
NSE_HYST, buf,
>> len); +} + +static inline ssize_t ad7291_show_v_bound(struct device
>> *dev, +              struct device_attribute *attr, +                u8 =
bound_reg, +         char *buf)
>> +{ + struct iio_dev *dev_info =3D dev_get_drvdata(dev); +      struct
>> ad7291_chip_info *chip =3D dev_info->dev_data; +       u16 data; +     i=
nt ret; +
>> +    if (bound_reg < AD7291_VOLTAGE_LIMIT_BASE || +          bound_reg >=
=3D
>> AD7291_VOLTAGE_LIMIT_BASE + +                AD7291_VOLTAGE_LIMIT_COUNT)=
 +           return
>> -EINVAL; + + ret =3D ad7291_i2c_read(chip, bound_reg, &data); +        i=
f (ret)
>> +            return -EIO; + +        data &=3D AD7291_VALUE_MASK; + +  r=
eturn sprintf(buf,
>> "%d\n", data); } + +static inline ssize_t ad7291_set_v_bound(struct
>> device *dev, +               struct device_attribute *attr, +           =
     u8 bound_reg,
>> +            const char *buf, +              size_t len) +{ +        str=
uct iio_dev *dev_info =3D
>> dev_get_drvdata(dev); +      struct ad7291_chip_info *chip =3D
>> dev_info->dev_data; +        unsigned long value; +  u16 data; +     int=
 ret; +
>> +    if (bound_reg < AD7291_VOLTAGE_LIMIT_BASE || +          bound_reg >=
=3D
>> AD7291_VOLTAGE_LIMIT_BASE + +                AD7291_VOLTAGE_LIMIT_COUNT)=
 +           return
>> -EINVAL; + + ret =3D strict_strtoul(buf, 10, &value); + +      if (ret |=
|
>> value >=3D 4096) +             return -EINVAL; + +     data =3D (u16)val=
ue; +    ret =3D
>> ad7291_i2c_write(chip, bound_reg, data); +   if (ret) +              ret=
urn -EIO; +
>> +    return ret; +} + +static int ad7291_get_voltage_limit_regs(const ch=
ar
>> *channel) { +        int index; + +  if (strlen(channel) < 3 && channel[=
0] !=3D
>> 'v') +               return -EINVAL; + +     index =3D channel[1] - '0';=
 +     if (index >=3D
>> AD7291_VOLTAGE_LIMIT_COUNT) +                return -EINVAL; + +     ret=
urn index; +} +
>> +static ssize_t ad7291_show_voltage_high(struct device *dev, +          =
     struct
>> device_attribute *attr, +            char *buf) +{ + int regs; + +   reg=
s =3D
>> ad7291_get_voltage_limit_regs(attr->attr.name); + +  if (regs < 0)
>> +            return regs; + +        return ad7291_show_t_bound(dev, att=
r, regs, buf); }
>> + +static inline ssize_t ad7291_set_voltage_high(struct device *dev,
>> +            struct device_attribute *attr, +                const char =
*buf, +              size_t len) +{
>> +    int regs; + +   regs =3D ad7291_get_voltage_limit_regs(attr->attr.n=
ame);
>> + +  if (regs < 0) +         return regs; + +        return ad7291_set_t=
_bound(dev,
>> attr, regs, buf, len); } + +static ssize_t
>> ad7291_show_voltage_low(struct device *dev, +                struct devi=
ce_attribute
>> *attr, +             char *buf) +{ + int regs; + +   regs =3D
>> ad7291_get_voltage_limit_regs(attr->attr.name); + +  if (regs < 0)
>> +            return regs; + +        return ad7291_show_t_bound(dev, att=
r, regs+1, buf);
>> } + +static inline ssize_t ad7291_set_voltage_low(struct device *dev,
>> +            struct device_attribute *attr, +                const char =
*buf, +              size_t len) +{
>> +    int regs; + +   regs =3D ad7291_get_voltage_limit_regs(attr->attr.n=
ame);
>> + +  if (regs < 0) +         return regs; + +        return ad7291_set_t=
_bound(dev,
>> attr, regs+1, buf, len); } + +static ssize_t
>> ad7291_show_voltage_hyst(struct device *dev, +               struct devi=
ce_attribute
>> *attr, +             char *buf) +{ + int regs; + +   regs =3D
>> ad7291_get_voltage_limit_regs(attr->attr.name); + +  if (regs < 0)
>> +            return regs; + +        return ad7291_show_t_bound(dev, att=
r, regs+2, buf);
>> } + +static inline ssize_t ad7291_set_voltage_hyst(struct device *dev,
>> +            struct device_attribute *attr, +                const char =
*buf, +              size_t len) +{
>> +    int regs; + +   regs =3D ad7291_get_voltage_limit_regs(attr->attr.n=
ame);
>> + +  if (regs < 0) +         return regs; + +        return ad7291_set_t=
_bound(dev,
>> attr, regs+2, buf, len); } + +IIO_EVENT_ATTR_SH(t_sense_high,
>> iio_event_ad7291, +          ad7291_show_t_sense_high, ad7291_set_t_sens=
e_high,
>> 0); +IIO_EVENT_ATTR_SH(t_sense_low, iio_event_ad7291,
>> +            ad7291_show_t_sense_low, ad7291_set_t_sense_low, 0);
>> +IIO_EVENT_ATTR_SH(t_sense_hyst, iio_event_ad7291,
>> +            ad7291_show_t_sense_hyst, ad7291_set_t_sense_hyst, 0); +
>> +IIO_EVENT_ATTR_SH(v0_high, iio_event_ad7291,
>> +            ad7291_show_voltage_high, ad7291_set_voltage_high, 0);
>> +IIO_EVENT_ATTR_SH(v0_low, iio_event_ad7291,
>> +            ad7291_show_voltage_low, ad7291_set_voltage_low, 0);
>> +IIO_EVENT_ATTR_SH(v0_hyst, iio_event_ad7291,
>> +            ad7291_show_voltage_hyst, ad7291_set_voltage_hyst, 0);
>> +IIO_EVENT_ATTR_SH(v1_high, iio_event_ad7291,
>> +            ad7291_show_voltage_high, ad7291_set_voltage_high, 0);
>> +IIO_EVENT_ATTR_SH(v1_low, iio_event_ad7291,
>> +            ad7291_show_voltage_low, ad7291_set_voltage_low, 0);
>> +IIO_EVENT_ATTR_SH(v1_hyst, iio_event_ad7291,
>> +            ad7291_show_voltage_hyst, ad7291_set_voltage_hyst, 0);
>> +IIO_EVENT_ATTR_SH(v2_high, iio_event_ad7291,
>> +            ad7291_show_voltage_high, ad7291_set_voltage_high, 0);
>> +IIO_EVENT_ATTR_SH(v2_low, iio_event_ad7291,
>> +            ad7291_show_voltage_low, ad7291_set_voltage_low, 0);
>> +IIO_EVENT_ATTR_SH(v2_hyst, iio_event_ad7291,
>> +            ad7291_show_voltage_hyst, ad7291_set_voltage_hyst, 0);
>> +IIO_EVENT_ATTR_SH(v3_high, iio_event_ad7291,
>> +            ad7291_show_voltage_high, ad7291_set_voltage_high, 0);
>> +IIO_EVENT_ATTR_SH(v3_low, iio_event_ad7291,
>> +            ad7291_show_voltage_low, ad7291_set_voltage_low, 0);
>> +IIO_EVENT_ATTR_SH(v3_hyst, iio_event_ad7291,
>> +            ad7291_show_voltage_hyst, ad7291_set_voltage_hyst, 0);
>> +IIO_EVENT_ATTR_SH(v4_high, iio_event_ad7291,
>> +            ad7291_show_voltage_high, ad7291_set_voltage_high, 0);
>> +IIO_EVENT_ATTR_SH(v4_low, iio_event_ad7291,
>> +            ad7291_show_voltage_low, ad7291_set_voltage_low, 0);
>> +IIO_EVENT_ATTR_SH(v4_hyst, iio_event_ad7291,
>> +            ad7291_show_voltage_hyst, ad7291_set_voltage_hyst, 0);
>> +IIO_EVENT_ATTR_SH(v5_high, iio_event_ad7291,
>> +            ad7291_show_voltage_high, ad7291_set_voltage_high, 0);
>> +IIO_EVENT_ATTR_SH(v5_low, iio_event_ad7291,
>> +            ad7291_show_voltage_low, ad7291_set_voltage_low, 0);
>> +IIO_EVENT_ATTR_SH(v5_hyst, iio_event_ad7291,
>> +            ad7291_show_voltage_hyst, ad7291_set_voltage_hyst, 0);
>> +IIO_EVENT_ATTR_SH(v6_high, iio_event_ad7291,
>> +            ad7291_show_voltage_high, ad7291_set_voltage_high, 0);
>> +IIO_EVENT_ATTR_SH(v6_low, iio_event_ad7291,
>> +            ad7291_show_voltage_low, ad7291_set_voltage_low, 0);
>> +IIO_EVENT_ATTR_SH(v6_hyst, iio_event_ad7291,
>> +            ad7291_show_voltage_hyst, ad7291_set_voltage_hyst, 0);
>> +IIO_EVENT_ATTR_SH(v7_high, iio_event_ad7291,
>> +            ad7291_show_voltage_high, ad7291_set_voltage_high, 0);
>> +IIO_EVENT_ATTR_SH(v7_low, iio_event_ad7291,
>> +            ad7291_show_voltage_low, ad7291_set_voltage_low, 0);
>> +IIO_EVENT_ATTR_SH(v7_hyst, iio_event_ad7291,
>> +            ad7291_show_voltage_hyst, ad7291_set_voltage_hyst, 0); + +s=
tatic
>> struct attribute *ad7291_event_attributes[] =3D {
>> +    &iio_event_attr_t_sense_high.dev_attr.attr,
>> +    &iio_event_attr_t_sense_low.dev_attr.attr,
>> +    &iio_event_attr_t_sense_hyst.dev_attr.attr,
>> +    &iio_event_attr_v0_high.dev_attr.attr,
>> +    &iio_event_attr_v0_low.dev_attr.attr,
>> +    &iio_event_attr_v0_hyst.dev_attr.attr,
>> +    &iio_event_attr_v1_high.dev_attr.attr,
>> +    &iio_event_attr_v1_low.dev_attr.attr,
>> +    &iio_event_attr_v1_hyst.dev_attr.attr,
>> +    &iio_event_attr_v2_high.dev_attr.attr,
>> +    &iio_event_attr_v2_low.dev_attr.attr,
>> +    &iio_event_attr_v2_hyst.dev_attr.attr,
>> +    &iio_event_attr_v3_high.dev_attr.attr,
>> +    &iio_event_attr_v3_low.dev_attr.attr,
>> +    &iio_event_attr_v3_hyst.dev_attr.attr,
>> +    &iio_event_attr_v4_high.dev_attr.attr,
>> +    &iio_event_attr_v4_low.dev_attr.attr,
>> +    &iio_event_attr_v4_hyst.dev_attr.attr,
>> +    &iio_event_attr_v5_high.dev_attr.attr,
>> +    &iio_event_attr_v5_low.dev_attr.attr,
>> +    &iio_event_attr_v5_hyst.dev_attr.attr,
>> +    &iio_event_attr_v6_high.dev_attr.attr,
>> +    &iio_event_attr_v6_low.dev_attr.attr,
>> +    &iio_event_attr_v6_hyst.dev_attr.attr,
>> +    &iio_event_attr_v7_high.dev_attr.attr,
>> +    &iio_event_attr_v7_low.dev_attr.attr,
>> +    &iio_event_attr_v7_hyst.dev_attr.attr, +        NULL, +}; + +static=
 struct
>> attribute_group ad7291_event_attribute_group =3D { +   .attrs =3D
>> ad7291_event_attributes, +}; + +/* + * device probe and remove + */ +
>> +static int __devinit ad7291_probe(struct i2c_client *client, +         =
     const
>> struct i2c_device_id *id) +{ +       struct ad7291_chip_info *chip; +   =
     int ret
>> =3D 0; + +     chip =3D kzalloc(sizeof(struct ad7291_chip_info), GFP_KER=
NEL); +
>> +    if (chip =3D=3D NULL) +             return -ENOMEM; + +     /* this=
 is only used for
>> device removal purposes */ + i2c_set_clientdata(client, chip); +
>> +    chip->client =3D client; +        chip->name =3D id->name; +       =
 chip->command =3D
>> AD7291_NOISE_DELAY | AD7291_T_SENSE_MASK; + +        chip->indio_dev =3D
>> iio_allocate_device(); +     if (chip->indio_dev =3D=3D NULL) { +       =
         ret =3D
>> -ENOMEM; +           goto error_free_chip; + } + +   chip->indio_dev->de=
v.parent =3D
>> &client->dev; +      chip->indio_dev->attrs =3D &ad7291_attribute_group;
>> +    chip->indio_dev->event_attrs =3D &ad7291_event_attribute_group;
>> +    chip->indio_dev->dev_data =3D (void *)chip;
>> +    chip->indio_dev->driver_module =3D THIS_MODULE;
>> +    chip->indio_dev->num_interrupt_lines =3D 1; +     chip->indio_dev->=
modes =3D
>> INDIO_DIRECT_MODE; + +       ret =3D iio_device_register(chip->indio_dev=
); +   if
>> (ret) +              goto error_free_dev; + +        if (client->irq > 0=
) { +                ret =3D
>> iio_register_interrupt_line(client->irq, +                           chi=
p->indio_dev, +                              0,
>> +                            client->irq_flags, +                       =
     chip->name); +          if (ret) +                      goto
>> error_unreg_dev; + +         /* +             * The event handler list e=
lement refer to
>> iio_event_ad7291. +           * All event attributes bind to the same ev=
ent
>> handler. +            * So, only register event handler once. +         =
      */
>> +            iio_add_event_to_list(&iio_event_ad7291,
>> +                            &chip->indio_dev->interrupts[0]->ev_list); =
+
>> +            INIT_WORK(&chip->thresh_work, ad7291_interrupt_bh); + +    =
     if
>> (client->irq_flags & IRQF_TRIGGER_LOW) +                     chip->comma=
nd |=3D
>> AD7291_ALART_POLARITY; +     } + +   ret =3D ad7291_i2c_write(chip,
>> AD7291_COMMAND, chip->command); +    if (ret) { +            ret =3D -EI=
O; +           goto
>> error_unreg_irq; +   } + +   dev_info(&client->dev, "%s temperature sens=
or
>> registered.\n", +                     id->name); + + return 0; + +error_=
unreg_irq:
>> +    iio_unregister_interrupt_line(chip->indio_dev, 0); +error_unreg_dev=
:
>> +    iio_device_unregister(chip->indio_dev); +error_free_dev:
>> +    iio_free_device(chip->indio_dev); +error_free_chip: +   kfree(chip)=
; +
>> +    return ret; +} + +static int __devexit ad7291_remove(struct
>> i2c_client *client) { +      struct ad7291_chip_info *chip =3D
>> i2c_get_clientdata(client); +        struct iio_dev *indio_dev =3D
>> chip->indio_dev; + + if (client->irq)
>> +            iio_unregister_interrupt_line(indio_dev, 0);
>> +    iio_device_unregister(indio_dev); +     iio_free_device(chip->indio=
_dev);
>> +    kfree(chip); + +        return 0; +} + +static const struct i2c_dev=
ice_id
>> ad7291_id[] =3D { +    { "ad7291", 0 }, +      {} +}; + +MODULE_DEVICE_T=
ABLE(i2c,
>> ad7291_id); + +static struct i2c_driver ad7291_driver =3D { +  .driver =
=3D {
>> +            .name =3D "ad7291", +     }, +    .probe =3D ad7291_probe, =
+        .remove =3D
>> __devexit_p(ad7291_remove), +        .id_table =3D ad7291_id, +}; + +sta=
tic
>> __init int ad7291_init(void) { +     return i2c_add_driver(&ad7291_drive=
r);
>> } + +static __exit void ad7291_exit(void) {
>> +    i2c_del_driver(&ad7291_driver); +} + +MODULE_AUTHOR("Sonic Zhang
>> <sonic.zhang@analog.com>"); +MODULE_DESCRIPTION("Analog Devices AD7291
>> digital" +                   " temperature sensor driver"); +MODULE_LICE=
NSE("GPL v2");
>> + +module_init(ad7291_init); +module_exit(ad7291_exit);
>

Greetings,
Michael

Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036 Geschaeft=
sfuehrer Thomas Wessel, William A. Martin, Margaret Seif
