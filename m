Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>, Drivers <Drivers@analog.com>
Date: Mon, 1 Aug 2011 20:03:29 +0100
Subject: RE: [PATCH] iio: impedance-analyzer: New driver for AD5933/4
 Impedance Converter, Network Analyzer
Message-ID: <544AC56F16B56944AEC3BD4E3D59177143003C5515@LIMKCMBX1.ad.analog.com>
References: <1312212513-2824-1-git-send-email-michael.hennerich@analog.com>
 <4E36D31A.6090807@cam.ac.uk>
In-Reply-To: <4E36D31A.6090807@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-08-01:
> On 08/01/11 16:28, michael.hennerich@analog.com wrote:
>> From: Michael Hennerich <michael.hennerich@analog.com>
>>
>> The AD5933 is a high precision impedance converter system solution
>> that combines an on-board frequency generator with a 12-bit, 1 MSPS,
>> analog-to-digital converter (ADC). The frequency generator allows an
>> external complex impedance to be excited with a known frequency.
>>
>> The response signal from the impedance is sampled by the on-board ADC
>> and a discrete Fourier transform (DFT) is processed by an on-chip DSP
>> engine. The DFT algorithm returns a real (R) and imaginary (I)
>> data-word at each output frequency.
>>
>> Changes since V1:
>>
>> Apply list review feedback:
>> Consistently use poll_time_jiffies.
>> Use be|le cpu endian helpers where applicable.
>> Add various comments.
>>
> I think next kernel is intended to be 3.1 not 3.0.1?
Ups...
>
> Please do some more build tests... Missing semicolons on 414, 422.
> ad5933_default_pdata should be static. Data undefined at 209.
> All trivial stuff though so not to worry from review point of view.

Stupid kate build plug-in - that's the state before my initial build test.
I fixed all these. If you click on an error/warning in the build output it =
automatically
jumps to the line - which is great, however it opens up a new file instance=
 and tab.
If you happen to fix these issues on one instance, and by accident also sav=
e the other one.
You basically revert everything you have done. This recently cost me a day =
of work.

Thanks for the detailed review!

> Will pull fixed version into iio-blue when you send it to Greg (below
> everything else).
>
>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>> Reviewed-by: Jonathan Cameron <jic23@cam.ac.uk> Acked-by: Jonathan
>> Cameron <jic23@cam.ac.uk>
>>
>> ---
>>  .../sysfs-bus-iio-impedance-analyzer-ad5933        |   30 +
>>  drivers/staging/iio/Kconfig                        |    1 +
>>  drivers/staging/iio/Makefile                       |    1 +
>>  drivers/staging/iio/impedance-analyzer/Kconfig     |   16 +
>>  drivers/staging/iio/impedance-analyzer/Makefile    |    5 +
>>  drivers/staging/iio/impedance-analyzer/ad5933.c    |  818
>>  ++++++++++++++++++++ drivers/staging/iio/impedance-analyzer/ad5933.h
>>   |   28 + 7 files changed, 899 insertions(+), 0 deletions(-)  create
>>  mode
>> 100644
>> drivers/staging/iio/Documentation/sysfs-bus-iio-impedance-analyzer- ad5
>> 933  create mode 100644 drivers/staging/iio/impedance-
> analyzer/Kconfig
>>  create mode 100644 drivers/staging/iio/impedance-analyzer/Makefile
>>  create mode 100644 drivers/staging/iio/impedance-analyzer/ad5933.c
>>  create mode 100644 drivers/staging/iio/impedance-analyzer/ad5933.h
>> diff --git
>> a/drivers/staging/iio/Documentation/sysfs-bus-iio-impedance-analyzer -
>> a d5933
>> b/drivers/staging/iio/Documentation/sysfs-bus-iio-impedance-analyzer -
>> a d5933 new file mode 100644 index 0000000..798029a --- /dev/null +++
>> b/drivers/staging/iio/Documentation/sysfs-bus-iio-impedance- analyz +++
>> er-ad5933 @@ -0,0 +1,30 @@
>> +What:               /sys/bus/iio/devices/iio:deviceX/outY_freq_start Is=
n't next
>> kernel going to be 3.1? +KernelVersion:      3.0.1
>> +Contact:    linux-iio@vger.kernel.org +Description: +               Fre=
quency sweep
>> start frequency in Hz. +
>> +What:               /sys/bus/iio/devices/iio:deviceX/outY_freq_incremen=
t
>> +KernelVersion:      3.0.1 +Contact: linux-iio@vger.kernel.org +Descript=
ion:
>> +            Frequency increment in Hz (step size) between consecutive
>> +            frequency points along the sweep. +
>> +What:               /sys/bus/iio/devices/iio:deviceX/outY_freq_points
>> +KernelVersion:      3.0.1 +Contact: linux-iio@vger.kernel.org +Descript=
ion:
>> +            Number of frequency points (steps) in the frequency sweep. =
+            This
>> value, in conjunction with the outY_freq_start and the
>> +            outY_freq_increment, determines the frequency sweep range +=
             for the
>> sweep operation. +
>> +What:               /sys/bus/iio/devices/iio:deviceX/outY_settling_cycl=
es
>> +KernelVersion:      3.0.1 +Contact: linux-iio@vger.kernel.org +Descript=
ion:
>> +            Number of output excitation cycles (settling time cycles) +=
             that
>> are allowed to pass through the unknown impedance, +         after each
>> frequency increment, and before the ADC is triggered +               to =
perform a
>> conversion sequence of the response signal. diff --git
>> a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig index
>> d329635..7526567 100644 --- a/drivers/staging/iio/Kconfig +++
>> b/drivers/staging/iio/Kconfig @@ -62,6 +62,7 @@ source
>> "drivers/staging/iio/addac/Kconfig"
>>  source "drivers/staging/iio/dac/Kconfig" source
>>  "drivers/staging/iio/dds/Kconfig" source
>>  "drivers/staging/iio/gyro/Kconfig" +source
>>  "drivers/staging/iio/impedance-analyzer/Kconfig" source
>>  "drivers/staging/iio/imu/Kconfig" source
>>  "drivers/staging/iio/light/Kconfig" source
>>  "drivers/staging/iio/magnetometer/Kconfig"
>> diff --git a/drivers/staging/iio/Makefile
>> b/drivers/staging/iio/Makefile index bb5c95c..eaff649 100644
>> --- a/drivers/staging/iio/Makefile
>> +++ b/drivers/staging/iio/Makefile
>> @@ -16,6 +16,7 @@ obj-y +=3D addac/
>>  obj-y +=3D dac/ obj-y +=3D dds/ obj-y +=3D gyro/ +obj-y +=3D
>>  impedance-analyzer/ obj-y +=3D imu/ obj-y +=3D light/ obj-y +=3D
>>  magnetometer/
>> diff --git a/drivers/staging/iio/impedance-analyzer/Kconfig
>> b/drivers/staging/iio/impedance-analyzer/Kconfig new file mode 100644
>> index 0000000..9e91a9b --- /dev/null +++
>> b/drivers/staging/iio/impedance-analyzer/Kconfig @@ -0,0 +1,16 @@ +# +#
>> Impedance Converter, Network Analyzer drivers # comment "Network
>> +Analyzer, Impedance Converters" Analyzer->Analyzers (for consistency).
>> + +config AD5933 +   tristate "Analog Devices AD5933, AD5934 driver"
>> +    depends on I2C +        select IIO_RING_BUFFER +        select IIO_=
SW_RING +    help
>> +      Say yes here to build support for Analog Devices Impedance
>> Converter, +   Network Analyzer, AD5933/4, provides direct access via
>> sysfs. + +     To compile this driver as a module, choose M here: the +
>> module will be called ad5933. diff --git
>> a/drivers/staging/iio/impedance-analyzer/Makefile
>> b/drivers/staging/iio/impedance-analyzer/Makefile new file mode 100644
>> index 0000000..7604d78 --- /dev/null +++
>> b/drivers/staging/iio/impedance-analyzer/Makefile @@ -0,0 +1,5 @@ +# +#
>> Makefile for Impedance Converter, Network Analyzer drivers # +
>> +obj-$(CONFIG_AD5933) +=3D ad5933.o diff --git
>> a/drivers/staging/iio/impedance-analyzer/ad5933.c
>> b/drivers/staging/iio/impedance-analyzer/ad5933.c new file mode 100644
>> index 0000000..0df5653 --- /dev/null +++
>> b/drivers/staging/iio/impedance-analyzer/ad5933.c @@ -0,0 +1,818 @@ +/*
>> + * AD5933 AD5934 Impedance Converter, Network Analyzer + * + *
>> Copyright 2011 Analog Devices Inc. + * + * Licensed under the GPL-2. +
>> */ + +#include <linux/interrupt.h> +#include <linux/device.h> +#include
>> <linux/kernel.h> +#include <linux/sysfs.h> +#include <linux/i2c.h>
>> +#include <linux/regulator/consumer.h> #include <linux/slab.h>
>> +#include <linux/types.h> #include <linux/err.h> #include
>> +<linux/delay.h> #include <asm/div64.h> + +#include "../iio.h"
>> +#include "../sysfs.h" +#include "../ring_generic.h" +#include
>> "../ring_sw.h" + +#include "ad5933.h" + +/* AD5933/AD5934 Registers */
>> +#define AD5933_REG_CONTROL_HB               0x80    /* R/W, 2 bytes */ =
+#define
>> AD5933_REG_CONTROL_LB                0x81    /* R/W, 2 bytes */ +#define
>> AD5933_REG_FREQ_START                0x82    /* R/W, 3 bytes */ +#define
>> AD5933_REG_FREQ_INC          0x85    /* R/W, 3 bytes */ +#define
>> AD5933_REG_INC_NUM           0x88    /* R/W, 2 bytes, 9 bit */ +#define
>> AD5933_REG_SETTLING_CYCLES   0x8A    /* R/W, 2 bytes */ +#define
>> AD5933_REG_STATUS            0x8F    /* R, 1 byte */ +#define
>> AD5933_REG_TEMP_DATA         0x92    /* R, 2 bytes*/ +#define
>> AD5933_REG_REAL_DATA         0x94    /* R, 2 bytes*/ +#define
>> AD5933_REG_IMAG_DATA         0x96    /* R, 2 bytes*/ + +/* AD5933_REG_CO=
NTROL_HB
>> Bits */ +#define AD5933_CTRL_INIT_START_FREQ (0x1 << 4) +#define
>> AD5933_CTRL_START_SWEEP              (0x2 << 4) +#define AD5933_CTRL_INC=
_FREQ                (0x3
>> << 4) +#define AD5933_CTRL_REPEAT_FREQ               (0x4 << 4) +#define
>> AD5933_CTRL_MEASURE_TEMP     (0x9 << 4) +#define
>> AD5933_CTRL_POWER_DOWN               (0xA << 4) +#define AD5933_CTRL_STA=
NDBY         (0xB
>> << 4) + +#define AD5933_CTRL_RANGE_2000mVpp  (0x0 << 1) +#define
>> AD5933_CTRL_RANGE_200mVpp    (0x1 << 1) +#define
>> AD5933_CTRL_RANGE_400mVpp    (0x2 << 1) +#define
>> AD5933_CTRL_RANGE_1000mVpp   (0x3 << 1) +#define
>> AD5933_CTRL_RANGE(x)         ((x) << 1) + +#define
>> AD5933_CTRL_PGA_GAIN_1               (0x1 << 0) +#define
>> AD5933_CTRL_PGA_GAIN_5               (0x0 << 0) + +/* AD5933_REG_CONTROL=
_LB Bits */
>> +#define AD5933_CTRL_RESET           (0x1 << 4) +#define
>> AD5933_CTRL_INT_SYSCLK               (0x0 << 3) +#define
>> AD5933_CTRL_EXT_SYSCLK               (0x1 << 3) + +/* AD5933_REG_STATUS =
Bits */
>> +#define AD5933_STAT_TEMP_VALID              (0x1 << 0) +#define
>> AD5933_STAT_DATA_VALID               (0x1 << 1) +#define
>> AD5933_STAT_SWEEP_DONE               (0x1 << 2) + +/* I2C Block Commands=
 */ +#define
>> AD5933_I2C_BLOCK_WRITE               0xA0 +#define AD5933_I2C_BLOCK_READ=
             0xA1
>> +#define AD5933_I2C_ADDR_POINTER             0xB0 + +/* Device Specs */ =
+#define
>> AD5933_INT_OSC_FREQ_Hz               16776000 +#define
>> AD5933_MAX_OUTPUT_FREQ_Hz    100000 +#define AD5933_MAX_RETRIES         =
     100 +
>> +#define AD5933_OUT_RANGE            1 +#define AD5933_OUT_RANGE_AVAIL  =
             2
>> +#define AD5933_OUT_SETTLING_CYCLES  3 +#define AD5933_IN_PGA_GAIN      =
     4
>> +#define AD5933_IN_PGA_GAIN_AVAIL    5 +#define AD5933_FREQ_POINTS      =
     6 +
>> +#define AD5933_POLL_TIME_ms         10 +#define
>> AD5933_INIT_EXCITATION_TIME_ms       100 + +struct ad5933_state { +  str=
uct
>> i2c_client           *client; +      struct regulator                *re=
g; + struct
>> ad5933_platform_data *pdata; +       struct delayed_work             wor=
k; + unsigned
>> long                 mclk_hz; +      unsigned char                   ctr=
l_hb; +      unsigned char                   ctrl_lb;
>> +    unsigned                        range_avail[4]; +       unsigned sh=
ort                  vref_mv; +      unsigned
>> short                        settling_cycles; +      unsigned short     =
             freq_points;
>> +    unsigned                        freq_start; +   unsigned           =
             freq_inc; +     unsigned                        state;
>> +    unsigned                        poll_time_jiffies; +}; + +struct ad=
5933_platform_data
>> ad5933_default_pdata  =3D { +  .vref_mv =3D 3300, +}; + +static struct
>> iio_chan_spec ad5933_channels[] =3D { +        IIO_CHAN(IIO_TEMP, 0, 1, =
1, NULL,
>> 0, 0, 0, +            0, AD5933_REG_TEMP_DATA, IIO_ST('s', 14, 16, 0), 0=
), + /*
>> Ring Channels */ +   IIO_CHAN(IIO_IN, 0, 1, 0, "real_raw", 0, 0, +      =
      (1
>> << IIO_CHAN_INFO_SCALE_SEPARATE), +           AD5933_REG_REAL_DATA, 0,
>> IIO_ST('s', 16, 16, 0), 0), +        IIO_CHAN(IIO_IN, 0, 1, 0, "imag_raw=
", 0,
>> 0, +          (1 << IIO_CHAN_INFO_SCALE_SEPARATE), +          AD5933_REG=
_IMAG_DATA,
>> 1, IIO_ST('s', 16, 16, 0), 0), }; + +static int ad5933_i2c_write(struct
>> i2c_client *client, +                              u8 reg, u8 len, u8 *d=
ata) +{ +    int ret; +
>> +    while (len--) { +               ret =3D i2c_smbus_write_byte_data(c=
lient, reg++,
>> *data++); +          if (ret < 0) { +                        dev_err(&cl=
ient->dev, "I2C write
>> error\n"); +                 return ret; +           } +     } +     ret=
urn 0; +} + +static int
>> ad5933_i2c_read(struct i2c_client *client, +                       u8 re=
g, u8 len, u8
>> *data) +{ +  int ret; + +    while (len--) { +               ret =3D
>> i2c_smbus_read_byte_data(client, reg++); +           if (ret < 0) {
>> +                    dev_err(&client->dev, "I2C read error\n"); +       =
             return ret; +           }
>> +            *data++ =3D ret; +        } +     return 0; +} + +static in=
t ad5933_cmd(struct
>> ad5933_state *st, unsigned char cmd) { +     unsigned char dat =3D
>> st->ctrl_hb | cmd; + +       return ad5933_i2c_write(st->client,
>> +                    AD5933_REG_CONTROL_HB, 1, &dat); } + +static int
>> ad5933_reset(struct ad5933_state *st) { +    unsigned char dat =3D
>> st->ctrl_lb | AD5933_CTRL_RESET; +   return ad5933_i2c_write(st->client,
>> +                    AD5933_REG_CONTROL_LB, 1, &dat); } + +static int
>> ad5933_wait_busy(struct ad5933_state *st, unsigned char +event) {
>> +    unsigned char val, timeout =3D AD5933_MAX_RETRIES; +      int ret; =
+ +    while
>> (timeout--) { +              ret =3D  ad5933_i2c_read(st->client, AD5933=
_REG_STATUS,
>> 1, &val); +          if (ret < 0) +                  return ret; +      =
     if (val & event)
>> +                    return val; +           cpu_relax(); +          mde=
lay(1); +    } + +   return -EAGAIN;
>> +} + +static int ad5933_set_freq(struct ad5933_state *st, +
>> unsigned reg, unsigned long freq) { +        unsigned long long freqreg;
>> +    union { +               u32 d32; +              u8 d8[4]; +     } d=
at; + +      freqreg =3D (u64) freq *
>> (u64) (1 << 27); +   do_div(freqreg, st->mclk_hz / 4); + +   switch (reg=
) {
>> +    case AD5933_REG_FREQ_START: +           st->freq_start =3D freq; + =
               break;
>> +    case AD5933_REG_FREQ_INC: +             st->freq_inc =3D freq; +   =
       break;
>> +    default: +              return -EINVAL; +       } + +   data.d32 =
=3D cpu_to_be32(freqreg);
>> +    return ad5933_i2c_write(st->client, reg, 3, &dat.d8[1]); } + +stati=
c
>> int ad5933_setup(struct ad5933_state *st) { +        unsigned short dat;=
 +   int
>> ret; + +     ret =3D ad5933_reset(st); +       if (ret < 0) +          r=
eturn ret; + + ret
>> =3D ad5933_set_freq(st, AD5933_REG_FREQ_START, 10000); +       if (ret <=
 0)
>> +            return ret; + + ret =3D ad5933_set_freq(st, AD5933_REG_FREQ=
_INC, 200);
>> +    if (ret < 0) +          return ret; + + st->settling_cycles =3D 10;=
 +     dat =3D
>> cpu_to_be16(st->settling_cycles); + +        ret =3D
>> ad5933_i2c_write(st->client, +                       AD5933_REG_SETTLING=
_CYCLES, 2, (u8
>> *)&dat); +   if (ret < 0) +          return ret; + + st->freq_points =3D=
 100; +        dat
>> =3D cpu_to_be16(st->freq_points); + +  return ad5933_i2c_write(st->clien=
t,
>> AD5933_REG_INC_NUM, 2, (u8 +*)&dat); } + +static void
>> ad5933_calc_out_ranges(struct ad5933_state *st) { +  int i; +        uns=
igned
>> normalized_3v3[4] =3D {1980, 198, 383, 970}; + +       for (i =3D 0; i <=
 4; i++)
>> +            st->range_avail[i] =3D normalized_3v3[i] * st->vref_mv / 33=
00; + +} +
>> +/* + * handles: AD5933_REG_FREQ_START and AD5933_REG_FREQ_INC  */ +
>> +static ssize_t ad5933_show_frequency(struct device *dev, +             =
                     struct
>> device_attribute *attr, +                                    char *buf) =
+{ + struct iio_dev *dev_info
>> =3D dev_get_drvdata(dev); +    struct ad5933_state *st =3D iio_priv(dev_=
info);
>> +    struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr); +       i=
nt ret;
>> +    unsigned long long freqreg; +   union { +               u32 d32; + =
             u8 d8[4]; +     }
>> dat; + +     mutex_lock(&dev_info->mlock); + ret =3D
>> ad5933_i2c_read(st->client, this_attr->address, 3, &dat.d8[1]);
>> +    mutex_unlock(&dev_info->mlock); +       if (ret < 0) +          ret=
urn ret; +
>> +    freqreg =3D be32_to_cpu(dat.d32) & 0xFFFFFF; + +  freqreg =3D (u64)
>> freqreg * (u64) (st->mclk_hz / 4); + do_div(freqreg, 1 << 27); +
>> +    return sprintf(buf, "%d\n", (int) freqreg); } + +static ssize_t
>> ad5933_store_frequency(struct device *dev, +                            =
      struct
>> device_attribute *attr, +                                     const char=
 *buf, +                                      size_t len) +{
>> +    struct iio_dev *dev_info =3D dev_get_drvdata(dev); +      struct
>> ad5933_state *st =3D iio_priv(dev_info); +     struct iio_dev_attr *this=
_attr
>> =3D to_iio_dev_attr(attr); +   long val; +     int ret; + +    ret =3D
>> strict_strtoul(buf, 10, &val); +     if (ret) +              return ret;=
 + + if (val >
>> AD5933_MAX_OUTPUT_FREQ_Hz) +         return -EINVAL; +
>> +    mutex_lock(&dev_info->mlock); + ret =3D ad5933_set_freq(st,
>> this_attr->address, val); +  mutex_unlock(&dev_info->mlock); + +     ret=
urn
>> ret ? ret : len; +} + +static IIO_DEVICE_ATTR(out0_freq_start, S_IRUGO
>> | S_IWUSR, +                 ad5933_show_frequency, +                   =
     ad5933_store_frequency,
>> +                    AD5933_REG_FREQ_START); + +static
>> IIO_DEVICE_ATTR(out0_freq_increment, S_IRUGO | S_IWUSR,
>> +                    ad5933_show_frequency, +                        ad5=
933_store_frequency,
>> +                    AD5933_REG_FREQ_INC); + +static ssize_t ad5933_show=
(struct device
>> *dev, +                                      struct device_attribute *at=
tr, +                                        char *buf) +{ + struct
>> iio_dev *dev_info =3D dev_get_drvdata(dev); +  struct ad5933_state *st =
=3D
>> iio_priv(dev_info); +        struct iio_dev_attr *this_attr =3D
>> to_iio_dev_attr(attr); +     int ret =3D 0, len =3D 0; +
>> +    mutex_lock(&dev_info->mlock); + switch (this_attr->address) { + cas=
e
>> AD5933_OUT_RANGE: +          len =3D sprintf(buf, "%d\n", +
>> st->range_avail[(st->ctrl_hb >> 1) & 0x3]); +                break; +   =
     case
>> AD5933_OUT_RANGE_AVAIL: +            len =3D sprintf(buf, "%d %d %d %d\n=
",
>> st->range_avail[0], +                              st->range_avail[3], s=
t->range_avail[2],
>> +                          st->range_avail[1]); +            break; +   =
     case
>> AD5933_OUT_SETTLING_CYCLES: +                len =3D sprintf(buf, "%d\n"=
,
>> st->settling_cycles); +              break; +        case AD5933_IN_PGA_=
GAIN: +              len =3D
>> sprintf(buf, "%s\n", +                             (st->ctrl_hb & AD5933=
_CTRL_PGA_GAIN_1) ?
>> +                          "1" : "0.2"); +           break; +        cas=
e AD5933_IN_PGA_GAIN_AVAIL:
>> +            len =3D sprintf(buf, "1 0.2\n"); +                break; + =
       case AD5933_FREQ_POINTS:
>> +            len =3D sprintf(buf, "%d\n", st->freq_points); +          b=
reak; +        default:
>> +            ret =3D -EINVAL; +        } + +   mutex_unlock(&dev_info->m=
lock); +       return ret
>> ? ret : len; +} + +static ssize_t ad5933_store(struct device *dev,
>> +                                     struct device_attribute *attr, +  =
                                      const char *buf, +
>> size_t len) +{ +     struct iio_dev *dev_info =3D dev_get_drvdata(dev);
>> +    struct ad5933_state *st =3D iio_priv(dev_info); + struct iio_dev_at=
tr
>> *this_attr =3D to_iio_dev_attr(attr); +        long val; +     int i, re=
t =3D 0;
>> +    unsigned short dat; + + if (this_attr->address !=3D AD5933_IN_PGA_G=
AIN)
>> { +          ret =3D strict_strtol(buf, 10, &val); +           if (ret) =
+                      return ret;
>> +    } + +   mutex_lock(&dev_info->mlock); + switch (this_attr->address)=
 {
>> +    case AD5933_OUT_RANGE: +                for (i =3D 0; i < 4; i++) +=
                       if (val =3D=3D
>> st->range_avail[i]) { +                              st->ctrl_hb &=3D ~A=
D5933_CTRL_RANGE(0x3);
>> +                            st->ctrl_hb |=3D AD5933_CTRL_RANGE(i); +   =
                       ret =3D ad5933_cmd(st, 0);
>> +                            break; +                        } +        =
     ret =3D -EINVAL; +                break; +        case
>> AD5933_IN_PGA_GAIN: +                if (sysfs_streq(buf, "1")) { +     =
             st->ctrl_hb |=3D
>> AD5933_CTRL_PGA_GAIN_1; +            } else if (sysfs_streq(buf, "0.2"))=
 {
>> +                    st->ctrl_hb &=3D ~AD5933_CTRL_PGA_GAIN_1; +        =
       } else { +                      ret =3D
>> -EINVAL; +                   break; +                } +             ret=
 =3D ad5933_cmd(st, 0); +              break; +        case
>> AD5933_OUT_SETTLING_CYCLES: +                val =3D clamp(val, 0L, 0x7F=
FL);
>> +            st->settling_cycles =3D val; + +          /* 2x, 4x handlin=
g, see datasheet */
>> +            if (val > 511) +                        val =3D (val >> 1) =
| (1 << 9); +          else if (val >
>> 1022) +                      val =3D (val >> 2) | (3 << 9); + +         =
       dat =3D cpu_to_be16(val)
>> +            ret =3D ad5933_i2c_write(st->client, +                     =
       AD5933_REG_SETTLING_CYCLES,
>> 2, (u8 *)&dat); +            break; +        case AD5933_FREQ_POINTS: + =
             val =3D
>> clamp(val, 0L, 511L); +              st->freq_points =3D val; + +       =
       dat =3D
>> cpu_to_be16(val) +           ret =3D ad5933_i2c_write(st->client,
>> AD5933_REG_INC_NUM, 2, +                                    (u8 *)&dat);=
 +           break; +        default:
>> +            ret =3D -EINVAL; +        } + +   mutex_unlock(&dev_info->m=
lock); +       return ret
>> ? ret : len; +} + +static IIO_DEVICE_ATTR(out0_scale, S_IRUGO |
>> S_IWUSR, +                   ad5933_show, +                  ad5933_stor=
e, +                 AD5933_OUT_RANGE); +
>> +static IIO_DEVICE_ATTR(out0_scale_available, S_IRUGO, +                =
     ad5933_show,
>> +                    NULL, +                 AD5933_OUT_RANGE_AVAIL); + =
+static
>> IIO_DEVICE_ATTR(in0_scale, S_IRUGO | S_IWUSR, +                      ad5=
933_show,
>> +                    ad5933_store, +                 AD5933_IN_PGA_GAIN)=
; + +static
>> IIO_DEVICE_ATTR(in0_scale_available, S_IRUGO, +                      ad5=
933_show,
>> +                    NULL, +                 AD5933_IN_PGA_GAIN_AVAIL); =
+ +static
>> IIO_DEVICE_ATTR(out0_freq_points, S_IRUGO | S_IWUSR, +                  =
     ad5933_show,
>> +                    ad5933_store, +                 AD5933_FREQ_POINTS)=
; + +static
>> IIO_DEVICE_ATTR(out0_settling_cycles, S_IRUGO | S_IWUSR,
>> +                    ad5933_show, +                  ad5933_store, +    =
             AD5933_OUT_SETTLING_CYCLES); +
>> +/* note: + * ideally we would handle the scale attributes via the
>> iio_info + * (read|write)_raw methods, however this part is a untypical
>> since +we + * don't create dedicated sysfs channel attributes for out0
>> and in0. + */ +static struct attribute *ad5933_attributes[] =3D {
>> +    &iio_dev_attr_out0_scale.dev_attr.attr,
>> +    &iio_dev_attr_out0_scale_available.dev_attr.attr,
>> +    &iio_dev_attr_out0_freq_start.dev_attr.attr,
>> +    &iio_dev_attr_out0_freq_increment.dev_attr.attr,
>> +    &iio_dev_attr_out0_freq_points.dev_attr.attr,
>> +    &iio_dev_attr_out0_settling_cycles.dev_attr.attr,
>> +    &iio_dev_attr_in0_scale.dev_attr.attr,
>> +    &iio_dev_attr_in0_scale_available.dev_attr.attr, +      NULL +}; + =
+static
>> const struct attribute_group ad5933_attribute_group =3D { +    .attrs =
=3D
>> ad5933_attributes, +}; + +static int ad5933_read_raw(struct iio_dev
>> *dev_info, +                    struct iio_chan_spec const *chan, +     =
                int *val,
>> +                       int *val2, +                    long m) +{ + str=
uct ad5933_state *st =3D
>> iio_priv(dev_info); +        unsigned short dat; +   int ret =3D -EINVAL=
; +
>> +    mutex_lock(&dev_info->mlock); + switch (m) { +  case 0: +          =
     if
>> (iio_ring_enabled(dev_info)) { +                     ret =3D -EBUSY; +  =
               goto out; +             }
>> +            ret =3D ad5933_cmd(st, AD5933_CTRL_MEASURE_TEMP); +        =
       if (ret < 0)
>> +                    goto out; +             ret =3D ad5933_wait_busy(st=
, AD5933_STAT_TEMP_VALID);
>> +            if (ret < 0) +                  goto out; + +           ret=
 =3D ad5933_i2c_read(st->client,
>> +                            AD5933_REG_TEMP_DATA, 2, +                 =
             (u8 *)&dat); +          if (ret < 0)
>> +                    goto out; +             mutex_unlock(&dev_info->mlo=
ck); +               ret =3D
>> be16_to_cpu(dat); +          /* Temp in Milli degrees Celsius */ +      =
     if (ret <
>> 8192) +                      *val =3D ret * 1000 / 32; +               e=
lse +                  *val =3D (ret - 16384) *
>> 1000 / 32; + +               return IIO_VAL_INT; +   } + +out:
>> +    mutex_unlock(&dev_info->mlock); +       return ret; +} + +static co=
nst
>> struct iio_info ad5933_info =3D { +    .read_raw =3D &ad5933_read_raw,
>> +    .attrs =3D &ad5933_attribute_group, +     .driver_module =3D THIS_M=
ODULE, +};
>> + +static int ad5933_ring_preenable(struct iio_dev *indio_dev) {
>> +    struct ad5933_state *st =3D iio_priv(indio_dev); +        struct
>> iio_ring_buffer *ring =3D indio_dev->ring; +   size_t d_size; +        i=
nt ret; +
>> +    if (!ring->scan_count) +                return -EINVAL; + +     d_s=
ize =3D
>> ring->scan_count * +          ad5933_channels[1].scan_type.storagebits /=
 8; +
>> +    if (indio_dev->ring->access->set_bytes_per_datum)
>> +            indio_dev->ring->access->set_bytes_per_datum(indio_dev- rin=
g,
>> +                                                         d_size); + +  =
     ret =3D ad5933_reset(st); +       if (ret < 0)
>> +            return ret; + + ret =3D ad5933_cmd(st, AD5933_CTRL_STANDBY)=
; +    if (ret
>> < 0) +               return ret; + + ret =3D ad5933_cmd(st,
>> AD5933_CTRL_INIT_START_FREQ); +      if (ret < 0) +          return ret;=
 +
>> +    st->state =3D AD5933_CTRL_INIT_START_FREQ; + +    return 0; +} + +s=
tatic
>> int ad5933_ring_postenable(struct iio_dev *indio_dev) { +    struct
>> ad5933_state *st =3D iio_priv(indio_dev); + +  /*
>> AD5933_CTRL_INIT_START_FREQ: +        * High Q complex circuits require =
a
>> long time to reach steady state. +    * To facilitate the measurement of
>> such impedances, this mode allows +   * the user full control of the
>> settling time requirement before +    * entering start frequency sweep
>> mode where the impedance measurement +        * takes place. In this mod=
e the
>> impedance is excited with the +       * programmed start frequency
>> (ad5933_ring_preenable), +    * but no measurement takes place. +     */=
 +
>> +    schedule_delayed_work(&st->work, +
>> msecs_to_jiffies(AD5933_INIT_EXCITATION_TIME_ms)); + return 0; +} +
>> +static int ad5933_ring_postdisable(struct iio_dev *indio_dev) {
>> +    struct ad5933_state *st =3D iio_priv(indio_dev); +
>> +    cancel_delayed_work_sync(&st->work); +  return ad5933_cmd(st,
>> AD5933_CTRL_POWER_DOWN); } + +static const struct iio_ring_setup_ops
>> ad5933_ring_setup_ops =3D { +  .preenable =3D &ad5933_ring_preenable,
>> +    .postenable =3D &ad5933_ring_postenable, +        .postdisable =3D
>> &ad5933_ring_postdisable, }; + +static int
>> ad5933_register_ring_funcs_and_init(struct iio_dev +*indio_dev) {
>> +    indio_dev->ring =3D iio_sw_rb_allocate(indio_dev); +      if
>> (!indio_dev->ring) +         return -ENOMEM; + +     /* Effectively sele=
ct the
>> ring buffer implementation */ +      indio_dev->ring->access =3D
>> &ring_sw_access_funcs; + +   /* Ring buffer functions - here trigger
>> setup related */ +   indio_dev->ring->setup_ops =3D &ad5933_ring_setup_o=
ps;
>> + +  indio_dev->modes |=3D INDIO_RING_HARDWARE_BUFFER; + +     return 0;=
 +} +
>> +static void ad5933_work(struct work_struct *work) { +       struct
>> ad5933_state *st =3D container_of(work, +              struct ad5933_sta=
te,
>> work.work); +        struct iio_dev *indio_dev =3D
>> i2c_get_clientdata(st->client); +    struct iio_ring_buffer *ring =3D
>> indio_dev->ring; +   signed short buf[2]; +  unsigned char status; +
>> +    mutex_lock(&indio_dev->mlock); +        if (st->state =3D=3D
>> AD5933_CTRL_INIT_START_FREQ) { +             /* start sweep */ +        =
     ad5933_cmd(st,
>> AD5933_CTRL_START_SWEEP); +          st->state =3D AD5933_CTRL_START_SWE=
EP;
>> +            schedule_delayed_work(&st->work, st->poll_time_jiffies);
>> +            mutex_unlock(&indio_dev->mlock); +              return; +  =
     } +
>> +    ad5933_i2c_read(st->client, AD5933_REG_STATUS, 1, &status); + + if
>> (status & AD5933_STAT_DATA_VALID) { +                ad5933_i2c_read(st-=
>client,
>> +                            (ring->scan_mask & (1 << 0)) ? +           =
                     AD5933_REG_REAL_DATA :
>> AD5933_REG_IMAG_DATA, +                              ring->scan_count * =
2, (u8 *)buf); + +           if
>> (ring->scan_count =3D=3D 2) { +                  buf[0] =3D be16_to_cpu(=
buf[0]); +                 buf[1]
>> =3D be16_to_cpu(buf[1]); +             } else { +                      b=
uf[0] =3D be16_to_cpu(buf[0]);
>> +            } +             /* save datum to the ring */ +          rin=
g->access->store_to(ring,
>> (u8 *)buf, iio_get_time_ns()); +     } else { +              /* no data =
available - try
>> again later */ +             schedule_delayed_work(&st->work,
>> st->poll_time_jiffies); +            mutex_unlock(&indio_dev->mlock); + =
             return;
>> +    } + +   if (status & AD5933_STAT_SWEEP_DONE) { +                /* =
last sample
>> received - power down do nothing until +              * the ring enable =
is toggled
>> */ +         ad5933_cmd(st, AD5933_CTRL_POWER_DOWN); +       } else { + =
             /* we just
>> received a valid datum, move on to the next */ +             ad5933_cmd(=
st,
>> AD5933_CTRL_INC_FREQ); +             schedule_delayed_work(&st->work,
>> st->poll_time_jiffies); +    } + +   mutex_unlock(&indio_dev->mlock); +}=
 +
>> +static int __devinit ad5933_probe(struct i2c_client *client, +
>> const struct i2c_device_id *id) { +  int ret, regdone =3D 0, voltage_uv =
=3D
>> 0; + struct ad5933_platform_data *pdata =3D client->dev.platform_data;
>> +    struct ad5933_state *st; +      struct iio_dev *indio_dev =3D
>> iio_allocate_device(sizeof(*st)); +  if (indio_dev =3D=3D NULL) +       =
         return
>> -ENOMEM; + + st =3D iio_priv(indio_dev); +     i2c_set_clientdata(client=
,
>> indio_dev); +        st->client =3D client; + +        if (!pdata) +    =
       st->pdata =3D
>> &ad5933_default_pdata; +     else +          st->pdata =3D pdata; + +  s=
t->reg =3D
>> regulator_get(&client->dev, "vcc"); +        if (!IS_ERR(st->reg)) { +  =
             ret =3D
>> regulator_enable(st->reg); +         if (ret) +                      got=
o error_put_reg;
>> +            voltage_uv =3D regulator_get_voltage(st->reg); +  } + +   i=
f (voltage_uv)
>> +            st->vref_mv =3D voltage_uv / 1000; +      else +          s=
t->vref_mv =3D
>> st->pdata->vref_mv; + +      if (st->pdata->ext_clk_Hz) { +          st-=
>mclk_hz =3D
>> st->pdata->ext_clk_Hz; +             st->ctrl_lb =3D AD5933_CTRL_EXT_SYS=
CLK; + }
>> else { +             st->mclk_hz =3D AD5933_INT_OSC_FREQ_Hz; +         s=
t->ctrl_lb =3D
>> AD5933_CTRL_INT_SYSCLK; +    } + +   ad5933_calc_out_ranges(st);
>> +    INIT_DELAYED_WORK(&st->work, ad5933_work); +    st->poll_time_jiffi=
es =3D
>> msecs_to_jiffies(AD5933_POLL_TIME_ms); + +   indio_dev->dev.parent =3D
>> &client->dev; +      indio_dev->info =3D &ad5933_info; +       indio_dev=
->name =3D
>> id->name; +  indio_dev->modes =3D INDIO_DIRECT_MODE; + indio_dev->channe=
ls
>> =3D ad5933_channels; + indio_dev->num_channels =3D 1; /* only register
>> temp0_input */ + +   ret =3D
>> ad5933_register_ring_funcs_and_init(indio_dev); +    if (ret) +         =
     goto
>> error_disable_reg; + +       ret =3D iio_device_register(indio_dev); + i=
f (ret)
>> +            goto error_unreg_ring; +        regdone =3D 1; + +        /=
* skip temp0_input,
>> register in0_(real|imag)_raw */ +    ret =3D
>> iio_ring_buffer_register_ex(indio_dev->ring, 0, +
>> &ad5933_channels[1], +                                         2); + if =
(ret) +              goto error_unreg_ring; +
>> +    /* enable both REAL and IMAG channels by default */
>> +    iio_scan_mask_set(indio_dev->ring, 0);
>> +    iio_scan_mask_set(indio_dev->ring, 1); + +      ret =3D ad5933_setu=
p(st);
>> +    if (ret) +              goto error_uninitialize_ring; + +       ret=
urn 0; +
>> +error_uninitialize_ring:
>> +    iio_ring_buffer_unregister(indio_dev->ring); +error_unreg_ring:
>> +    iio_sw_rb_free(indio_dev->ring); +error_disable_reg: +  if
>> (!IS_ERR(st->reg)) +         regulator_disable(st->reg); +error_put_reg:=
 +   if
>> (!IS_ERR(st->reg)) +         regulator_put(st->reg); + +     if (regdone=
)
>> +            iio_device_unregister(indio_dev); +     else
>> +            iio_free_device(indio_dev); + + return ret; +} + +static __=
devexit
>> int ad5933_remove(struct i2c_client *client) { +     struct iio_dev
>> *indio_dev =3D i2c_get_clientdata(client); +   struct ad5933_state *st =
=3D
>> iio_priv(indio_dev); + +     iio_ring_buffer_unregister(indio_dev->ring)=
;
>> +    iio_sw_rb_free(indio_dev->ring); +      if (!IS_ERR(st->reg)) {
>> +            regulator_disable(st->reg); +           regulator_put(st->r=
eg); +       }
>> +    iio_device_unregister(indio_dev); + +   return 0; +} + +static cons=
t
>> struct i2c_device_id ad5933_id[] =3D { +       { "ad5933", 0 }, +      {=
 "ad5934", 0
>> }, + {} +}; + +MODULE_DEVICE_TABLE(i2c, ad5933_id); + +static struct
>> i2c_driver ad5933_driver =3D { +       .driver =3D { +           .name =
=3D "ad5933", +     },
>> +    .probe =3D ad5933_probe, +        .remove =3D __devexit_p(ad5933_re=
move),
>> +    .id_table =3D ad5933_id, +}; + +static __init int ad5933_init(void)=
 {
>> +    return i2c_add_driver(&ad5933_driver); } module_init(ad5933_init); =
+
>> +static __exit void ad5933_exit(void) {
>> +    i2c_del_driver(&ad5933_driver); +} +module_exit(ad5933_exit); +
>> +MODULE_AUTHOR("Michael Hennerich +<hennerich@blackfin.uclinux.org>");
>> +MODULE_DESCRIPTION("Analog Devices AD5933 Impedance Conv. Network
>> +Analyzer"); MODULE_LICENSE("GPL v2"); diff --git
>> a/drivers/staging/iio/impedance-analyzer/ad5933.h
>> b/drivers/staging/iio/impedance-analyzer/ad5933.h new file mode 100644
>> index 0000000..b140e42 --- /dev/null +++
>> b/drivers/staging/iio/impedance-analyzer/ad5933.h @@ -0,0 +1,28 @@ +/*
>> + * AD5933 AD5934 Impedance Converter, Network Analyzer + * + *
>> Copyright 2011 Analog Devices Inc. + * + * Licensed under the GPL-2. +
>> */ + +#ifndef IIO_ADC_AD5933_H_ +#define IIO_ADC_AD5933_H_ + +/* + *
>> TODO: struct ad5933_platform_data needs to go into +include/linux/iio
>> */ + +/** + * struct ad5933_platform_data - platform specific data + *
>> @ext_clk_Hz:         the external clock frequency in Hz, if not set + * =
                     the
>> driver uses the internal clock (16.776 MHz) + * @vref_mv:            the=
 external
>> reference voltage in millivolt + */ + +struct ad5933_platform_data {
>> +    unsigned long                   ext_clk_Hz; +   unsigned short     =
             vref_mv; +}; + +#endif
>> /* IIO_ADC_AD5933_H_ */ -- 1.7.0.4
>>
>>
>>
>

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Gesch=
aeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret=
 Seif
