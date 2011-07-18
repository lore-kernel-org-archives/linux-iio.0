Return-Path: <Michael.Hennerich@analog.com>
Message-ID: <4E242BA8.8020006@analog.com>
Date: Mon, 18 Jul 2011 14:48:40 +0200
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>, Drivers <Drivers@analog.com>
Subject: Re: [PATCH 2/2] iio: adc: New driver for AD7280A Lithium Ion Battery
 Monitoring System
References: <1310734743-2623-1-git-send-email-michael.hennerich@analog.com> <1310734743-2623-2-git-send-email-michael.hennerich@analog.com> <4E241C45.5090902@cam.ac.uk>
In-Reply-To: <4E241C45.5090902@cam.ac.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 07/18/2011 01:43 PM, Jonathan Cameron wrote:
> On 07/15/11 13:59, michael.hennerich@analog.com wrote:
>> From: Michael Hennerich<michael.hennerich@analog.com>
> Hi Michael, although anyone reading the datasheets will quickly
> discover that this isn't a simple laptop style battery monitor,
> it's probably worth making that clear in the patch title or
> at very least here.
>
> Driver is pretty clear. Couple of nitpicks / queries inline.
>
> Thanks
>
> Jonathan
>>
>> Signed-off-by: Michael Hennerich<michael.hennerich@analog.com>
>> ---
>>   .../iio/Documentation/sysfs-bus-iio-adc-ad7280a    |   21 +
>>   drivers/staging/iio/adc/Kconfig                    |   10 +
>>   drivers/staging/iio/adc/Makefile                   |    1 +
>>   drivers/staging/iio/adc/ad7280a.c                  |  939 ++++++++++=
++++++++++
>>   drivers/staging/iio/adc/ad7280a.h                  |   38 +
>>   5 files changed, 1009 insertions(+), 0 deletions(-)
>>   create mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-a=
dc-ad7280a
>>   create mode 100644 drivers/staging/iio/adc/ad7280a.c
>>   create mode 100644 drivers/staging/iio/adc/ad7280a.h
>>
>> diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio-adc-ad728=
0a b/drivers/staging/iio/Documentation/sysfs-bus-iio-adc-ad7280a
>> new file mode 100644
>> index 0000000..fe90bd9
>> --- /dev/null
>> +++ b/drivers/staging/iio/Documentation/sysfs-bus-iio-adc-ad7280a
>> @@ -0,0 +1,21 @@
>> +What:                /sys/bus/iio/devices/deviceX/inY_balance_switch_=
en
>> +KernelVersion:       3.0.0
>> +Contact:     linux-iio@vger.kernel.org
>> +Description:
>> +             Writing 1 enables the cell balance output switch corresp=
onding
>> +             to input Y. Writing 0 disables it. If the inY_balance_ti=
mer is
>> +             set to a none zero value, the corresponding switch will =
enable
>> +             for the programmed amount of time, before it automatical=
ly
>> +             disables.
>> +
>> +What:                /sys/bus/iio/devices/deviceX/inY_balance_timer
>> +KernelVersion:       3.0.0
>> +Contact:     linux-iio@vger.kernel.org
>> +Description:
>> +             The inY_balance_timer file allows the user to program in=
dividual
>> +             times for each cell balance output. The AD7280A allows t=
he user
>> +             to set the timer to a value from 0 minutes to 36.9 minut=
es.
>> +             The resolution of the timer is 71.5 sec. Corresponding t=
o a
>> +             valid range of 0..31. When the timer value is set 0,
>> +             the timer is disabled. The cell balance outputs are cont=
rolled
>> +             only by inY_balance_switch_en.
> I'd prefer to see that in SI units and do the conversion to the interna=
l units
> in the driver.
ok
>> diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc=
/Kconfig
>> index b39f2e1..60de7d7 100644
>> --- a/drivers/staging/iio/adc/Kconfig
>> +++ b/drivers/staging/iio/adc/Kconfig
>> @@ -182,6 +182,16 @@ config ADT7410
>>          Say yes here to build support for Analog Devices ADT7410
>>          temperature sensors.
>>
>> +config AD7280
>> +     tristate "Analog Devices AD7280A Lithium Ion Battery Monitoring =
System"
>> +     depends on SPI
>> +     help
>> +       Say yes here to build support for Analog Devices AD7280A
>> +       Lithium Ion Battery Monitoring System.
>> +
>> +       To compile this driver as a module, choose M here: the
>> +       module will be called ad7280a
>> +
>>   config MAX1363
>>        tristate "Maxim max1363 ADC driver"
>>        depends on I2C
>> diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/ad=
c/Makefile
>> index f020351..634a55f 100644
>> --- a/drivers/staging/iio/adc/Makefile
>> +++ b/drivers/staging/iio/adc/Makefile
>> @@ -40,3 +40,4 @@ obj-$(CONFIG_AD7816) +=3D ad7816.o
>>   obj-$(CONFIG_ADT75) +=3D adt75.o
>>   obj-$(CONFIG_ADT7310) +=3D adt7310.o
>>   obj-$(CONFIG_ADT7410) +=3D adt7410.o
>> +obj-$(CONFIG_AD7280) +=3D ad7280a.o
>> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/a=
dc/ad7280a.c
>> new file mode 100644
>> index 0000000..0efef55
>> --- /dev/null
>> +++ b/drivers/staging/iio/adc/ad7280a.c
>> @@ -0,0 +1,939 @@
>> +/*
>> + * AD7280A Lithium Ion Battery Monitoring System
>> + *
>> + * Copyright 2011 Analog Devices Inc.
>> + *
>> + * Licensed under the GPL-2.
>> + */
>> +
>> +#include<linux/device.h>
>> +#include<linux/kernel.h>
>> +#include<linux/slab.h>
>> +#include<linux/sysfs.h>
>> +#include<linux/spi/spi.h>
>> +#include<linux/err.h>
>> +#include<linux/delay.h>
>> +#include<linux/interrupt.h>
>> +
>> +#include "../iio.h"
>> +#include "../sysfs.h"
>> +#include "adc.h"
>> +
>> +#include "ad7280a.h"
>> +
>> +/* Registers */
>> +#define AD7280A_CELL_VOLTAGE_1               0x0  /* D11 to D0, Read =
only */
>> +#define AD7280A_CELL_VOLTAGE_2               0x1  /* D11 to D0, Read =
only */
>> +#define AD7280A_CELL_VOLTAGE_3               0x2  /* D11 to D0, Read =
only */
>> +#define AD7280A_CELL_VOLTAGE_4               0x3  /* D11 to D0, Read =
only */
>> +#define AD7280A_CELL_VOLTAGE_5               0x4  /* D11 to D0, Read =
only */
>> +#define AD7280A_CELL_VOLTAGE_6               0x5  /* D11 to D0, Read =
only */
>> +#define AD7280A_AUX_ADC_1            0x6  /* D11 to D0, Read only */
>> +#define AD7280A_AUX_ADC_2            0x7  /* D11 to D0, Read only */
>> +#define AD7280A_AUX_ADC_3            0x8  /* D11 to D0, Read only */
>> +#define AD7280A_AUX_ADC_4            0x9  /* D11 to D0, Read only */
>> +#define AD7280A_AUX_ADC_5            0xA  /* D11 to D0, Read only */
>> +#define AD7280A_AUX_ADC_6            0xB  /* D11 to D0, Read only */
>> +#define AD7280A_SELF_TEST            0xC  /* D11 to D0, Read only */
>> +#define AD7280A_CONTROL_HB           0xD  /* D15 to D8, Read/write */
>> +#define AD7280A_CONTROL_LB           0xE  /* D7 to D0, Read/write */
>> +#define AD7280A_CELL_OVERVOLTAGE     0xF  /* D7 to D0, Read/write */
>> +#define AD7280A_CELL_UNDERVOLTAGE    0x10 /* D7 to D0, Read/write */
>> +#define AD7280A_AUX_ADC_OVERVOLTAGE  0x11 /* D7 to D0, Read/write */
>> +#define AD7280A_AUX_ADC_UNDERVOLTAGE 0x12 /* D7 to D0, Read/write */
>> +#define AD7280A_ALERT                        0x13 /* D7 to D0, Read/w=
rite */
>> +#define AD7280A_CELL_BALANCE         0x14 /* D7 to D0, Read/write */
>> +#define AD7280A_CB1_TIMER            0x15 /* D7 to D0, Read/write */
>> +#define AD7280A_CB2_TIMER            0x16 /* D7 to D0, Read/write */
>> +#define AD7280A_CB3_TIMER            0x17 /* D7 to D0, Read/write */
>> +#define AD7280A_CB4_TIMER            0x18 /* D7 to D0, Read/write */
>> +#define AD7280A_CB5_TIMER            0x19 /* D7 to D0, Read/write */
>> +#define AD7280A_CB6_TIMER            0x1A /* D7 to D0, Read/write */
>> +#define AD7280A_PD_TIMER             0x1B /* D7 to D0, Read/write */
>> +#define AD7280A_READ                 0x1C /* D7 to D0, Read/write */
>> +#define AD7280A_CNVST_CONTROL                0x1D /* D7 to D0, Read/w=
rite */
>> +
>> +/* Bits and Masks */
>> +#define AD7280A_CTRL_HB_CONV_INPUT_ALL                       (0<<  6)
>> +#define AD7280A_CTRL_HB_CONV_INPUT_6CELL_AUX1_3_4    (1<<  6)
>> +#define AD7280A_CTRL_HB_CONV_INPUT_6CELL             (2<<  6)
>> +#define AD7280A_CTRL_HB_CONV_INPUT_SELF_TEST         (3<<  6)
>> +#define AD7280A_CTRL_HB_CONV_RES_READ_ALL            (0<<  4)
>> +#define AD7280A_CTRL_HB_CONV_RES_READ_6CELL_AUX1_3_4 (1<<  4)
>> +#define AD7280A_CTRL_HB_CONV_RES_READ_6CELL          (2<<  4)
>> +#define AD7280A_CTRL_HB_CONV_RES_READ_NO             (3<<  4)
>> +#define AD7280A_CTRL_HB_CONV_START_CNVST             (0<<  3)
>> +#define AD7280A_CTRL_HB_CONV_START_CS                        (1<<  3)
>> +#define AD7280A_CTRL_HB_CONV_AVG_DIS                 (0<<  1)
>> +#define AD7280A_CTRL_HB_CONV_AVG_2                   (1<<  1)
>> +#define AD7280A_CTRL_HB_CONV_AVG_4                   (2<<  1)
>> +#define AD7280A_CTRL_HB_CONV_AVG_8                   (3<<  1)
>> +#define AD7280A_CTRL_HB_CONV_AVG(x)                  ((x)<<  1)
>> +#define AD7280A_CTRL_HB_PWRDN_SW                     (1<<  0)
>> +
>> +#define AD7280A_CTRL_LB_SWRST                                (1<<  7)
>> +#define AD7280A_CTRL_LB_ACQ_TIME_400ns                       (0<<  5)
>> +#define AD7280A_CTRL_LB_ACQ_TIME_800ns                       (1<<  5)
>> +#define AD7280A_CTRL_LB_ACQ_TIME_1200ns                      (2<<  5)
>> +#define AD7280A_CTRL_LB_ACQ_TIME_1600ns                      (3<<  5)
>> +#define AD7280A_CTRL_LB_ACQ_TIME(x)                  ((x)<<  5)
>> +#define AD7280A_CTRL_LB_MUST_SET                     (1<<  4)
>> +#define AD7280A_CTRL_LB_THERMISTOR_EN                        (1<<  3)
>> +#define AD7280A_CTRL_LB_LOCK_DEV_ADDR                        (1<<  2)
>> +#define AD7280A_CTRL_LB_INC_DEV_ADDR                 (1<<  1)
>> +#define AD7280A_CTRL_LB_DAISY_CHAIN_RB_EN            (1<<  0)
>> +
>> +#define AD7280A_ALERT_GEN_STATIC_HIGH                        (1<<  6)
>> +#define AD7280A_ALERT_RELAY_SIG_CHAIN_DOWN           (3<<  6)
>> +
>> +#define RES_MASK(bits)                       ((1<<  (bits)) - 1)
>> +#define AD7280A_MAX_SPI_CLK_Hz               700000 /*<  1MHz */
>> +#define AD7280A_MAX_CHAIN            8
>> +#define AD7280A_CELLS_PER_DEV                6
>> +#define AD7280A_BITS                 12
>> +#define AD7280A_NUM_CH                       (AD7280A_AUX_ADC_6 - \
>> +                                     AD7280A_CELL_VOLTAGE_1 + 1)
>> +
>> +#define AD7280A_DEVADDR_MASTER               0
>> +#define AD7280A_DEVADDR_ALL          0x1F
>> +/* 5-bit device address is sent LSB first */
>> +#define AD7280A_DEVADDR(addr)        (((addr&  0x1)<<  4) | ((addr&  =
0x2)<<  3) | \
>> +                             (addr&  0x4) | ((addr&  0x8)>>  3) | \
>> +                             ((addr&  0x10)>>  4))
>> +
> Probably squish this into the one user for clarity.
ok
>> +#define AD7280A_WRITE(DEVADDR, REGADDR, REGDATA, ADDRALL) \
>> +                   ((DEVADDR)<<  27 | (REGADDR)<<  21 | \
>> +                   ((REGDATA)&  0xFF)<<  13 | ADDRALL<<  12)
>> +
> Same with this one.
ok
>> +#define AD7280A_APPEND_CRC(VAL, CRC) ((VAL) | (CRC)<<  3 | 0x2)
>> +
>> +/*
>> + * AD7280 CRC
>> + *
>> + * P(x) =3D x^8 + x^5 + x^3 + x^2 + x^1 + x^0 =3D 0b100101111 =3D>  0=
x2F
>> + */
>> +#define POLYNOM              0x2F
>> +#define POLYNOM_ORDER        8
>> +#define HIGHBIT              1<<  (POLYNOM_ORDER - 1);
>> +
>> +struct ad7280_state {
>> +     struct spi_device               *spi;
>> +     struct iio_chan_spec            *channels;
>> +     struct iio_dev_attr             *iio_attr;
>> +     int                             slave_num;
>> +     int                             scan_cnt;
>> +     int                             readback_delay_us;
>> +     unsigned char                   crc_tab[256];
>> +     unsigned char                   ctrl_hb;
>> +     unsigned char                   ctrl_lb;
>> +     unsigned char                   cell_threshhigh;
>> +     unsigned char                   cell_threshlow;
>> +     unsigned char                   aux_threshhigh;
>> +     unsigned char                   aux_threshlow;
>> +     unsigned char                   cb_mask[AD7280A_MAX_CHAIN];
>> +};
>> +
>> +static void ad7280_crc8_build_table(unsigned char *crc_tab)
>> +{
>> +     unsigned char bit, crc;
>> +     int cnt, i;
>> +
>> +     for (cnt =3D 0; cnt<  256; cnt++) {
>> +             crc =3D cnt;
>> +             for (i =3D 0; i<  8; i++) {
>> +                     bit =3D crc&  HIGHBIT;
>> +                     crc<<=3D 1;
>> +                     if (bit)
>> +                             crc ^=3D POLYNOM;
>> +             }
>> +             crc_tab[cnt] =3D crc;
>> +     }
>> +}
>> +
>> +static unsigned char ad7280_calc_crc8(unsigned char *crc_tab, unsigne=
d val)
>> +{
>> +     unsigned char crc;
>> +
>> +     crc =3D crc_tab[val>>  16&  0xFF];
>> +     crc =3D crc_tab[crc ^ (val>>  8&  0xFF)];
>> +
>> +     return  crc ^ (val&  0xFF);
>> +}
>> +
>> +static int ad7280_check_crc(struct ad7280_state *st, unsigned val)
>> +{
>> +     unsigned char crc =3D ad7280_calc_crc8(st->crc_tab, val>>  10);
>> +
>> +     if (crc !=3D ((val>>  2)&  0xFF))
>> +             return -EIO;
>> +
>> +     return 0;
>> +}
>> +
> Any real reason for this tiny wrapper?  I'd squash into the call
> site given there is only one of them.
Well for consistency - there is a __read why not having also a __write
which does endianess conversion and calling the bus method.

But right you are - there is only one user.
I'll squash it.

>> +static int __ad7280_write32(struct spi_device *spi, unsigned val)
>> +{
>> +     u32 data =3D cpu_to_be32(val);
>> +
>> +     return spi_write(spi,&data, 4);
>> +}
>> +
> This needs an explanatory comment.
ok
>> +static void ad7280_delay(struct ad7280_state *st)
>> +{
>> +     if (st->readback_delay_us<  50)
>> +             udelay(st->readback_delay_us);
>> +     else
>> +             msleep(1);
>> +}
>> +
>> +static int __ad7280_read32(struct spi_device *spi, unsigned *val)
>> +{
> Please explain the magic constant.
it's always the same, so calculating a CRC doesn't make much sense.
I'll add a comment.

>> +     unsigned rx_buf, tx_buf =3D cpu_to_be32(0xF800030A);
>> +     int ret;
>> +
>> +     struct spi_transfer t =3D {
>> +             .tx_buf =3D&tx_buf,
>> +             .rx_buf =3D&rx_buf,
>> +             .len =3D 4,
>> +     };
>> +     struct spi_message m;
>> +
>> +     spi_message_init(&m);
>> +     spi_message_add_tail(&t,&m);
>> +
>> +     ret =3D spi_sync(spi,&m);
>> +     if (ret)
>> +             return ret;
>> +
>> +     *val =3D be32_to_cpu(rx_buf);
>> +
>> +     return 0;
>> +}
>> +
>> +static int ad7280_write(struct ad7280_state *st, unsigned devaddr,
>> +                     unsigned addr, bool all, unsigned val)
>> +{
>> +
>> +     unsigned reg =3D AD7280A_WRITE(devaddr, addr, val, all);
>> +
>> +     reg =3D AD7280A_APPEND_CRC(reg,
>> +             ad7280_calc_crc8(st->crc_tab, reg>>  11));
>> +
>> +     return __ad7280_write32(st->spi, reg);
>> +}
>> +
>> +static int ad7280_read(struct ad7280_state *st, unsigned devaddr,
>> +                     unsigned addr)
>> +{
>> +     int ret;
>> +     unsigned tmp;
> This would benefit form a few explanatory comments.
ok
>> +
>> +     ret =3D ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CONTROL=
_HB, 1,
>> +                     AD7280A_CTRL_HB_CONV_INPUT_ALL |
>> +                     AD7280A_CTRL_HB_CONV_RES_READ_NO |
>> +                     st->ctrl_hb);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret =3D ad7280_write(st, devaddr, AD7280A_CONTROL_HB, 0,
>> +                     AD7280A_CTRL_HB_CONV_INPUT_ALL |
>> +                     AD7280A_CTRL_HB_CONV_RES_READ_ALL |
>> +                     st->ctrl_hb);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret =3D ad7280_write(st, devaddr, AD7280A_READ, 0, addr<<  2);
>> +     if (ret)
>> +             return ret;
>> +
>> +     __ad7280_read32(st->spi,&tmp);
>> +
>> +     if (ad7280_check_crc(st, tmp))
>> +             return -EIO;
>> +
>> +     if (((tmp>>  27) !=3D devaddr) || (((tmp>>  21)&  0x3F) !=3D add=
r))
>> +             return -EFAULT;
>> +
>> +     return (tmp>>  13)&  0xFF;
>> +}
>> +
>> +static int ad7280_read_channel(struct ad7280_state *st, unsigned deva=
ddr,
>> +                            unsigned addr)
>> +{
>> +     int ret;
>> +     unsigned tmp;
>> +
>> +     ret =3D ad7280_write(st, devaddr, AD7280A_READ, 0, addr<<  2);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret =3D ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CONTROL=
_HB, 1,
>> +                     AD7280A_CTRL_HB_CONV_INPUT_ALL |
>> +                     AD7280A_CTRL_HB_CONV_RES_READ_NO |
>> +                     st->ctrl_hb);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret =3D ad7280_write(st, devaddr, AD7280A_CONTROL_HB, 0,
>> +                     AD7280A_CTRL_HB_CONV_INPUT_ALL |
>> +                     AD7280A_CTRL_HB_CONV_RES_READ_ALL |
>> +                     AD7280A_CTRL_HB_CONV_START_CS |
>> +                     st->ctrl_hb);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ad7280_delay(st);
>> +
>> +     __ad7280_read32(st->spi,&tmp);
>> +
>> +     if (ad7280_check_crc(st, tmp))
>> +             return -EIO;
>> +
>> +     if (((tmp>>  27) !=3D devaddr) || (((tmp>>  23)&  0xF) !=3D addr=
))
>> +             return -EFAULT;
>> +
>> +     return (tmp>>  11)&  0xFFF;
>> +}
>> +
>> +static int ad7280_read_all_channels(struct ad7280_state *st, unsigned=
 cnt,
>> +                          unsigned *array)
>> +{
>> +     int i, ret;
>> +     unsigned tmp, sum =3D 0;
>> +
>> +     ret =3D ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_READ, 1=
,
>> +                        AD7280A_CELL_VOLTAGE_1<<  2);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret =3D ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CONTROL=
_HB, 1,
>> +                     AD7280A_CTRL_HB_CONV_INPUT_ALL |
>> +                     AD7280A_CTRL_HB_CONV_RES_READ_ALL |
>> +                     AD7280A_CTRL_HB_CONV_START_CS |
>> +                     st->ctrl_hb);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ad7280_delay(st);
>> +
>> +     for (i =3D 0; i<  cnt; i++) {
>> +             __ad7280_read32(st->spi,&tmp);
>> +
>> +             if (ad7280_check_crc(st, tmp))
>> +                     return -EIO;
>> +
>> +             if (array)
>> +                     array[i] =3D tmp;
>> +             /* only sum cell voltages */
>> +             if (((tmp>>  23)&  0xF)<=3D AD7280A_CELL_VOLTAGE_6)
>> +                     sum +=3D ((tmp>>  11)&  0xFFF);
>> +     }
>> +
>> +     return sum;
>> +}
>> +
>> +static int ad7280_chain_setup(struct ad7280_state *st)
>> +{
>> +     unsigned val, n;
>> +     int ret;
>> +
>> +     ret =3D ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CONTROL=
_LB, 1,
>> +                     AD7280A_CTRL_LB_DAISY_CHAIN_RB_EN |
>> +                     AD7280A_CTRL_LB_LOCK_DEV_ADDR |
>> +                     AD7280A_CTRL_LB_MUST_SET |
>> +                     AD7280A_CTRL_LB_SWRST |
>> +                     st->ctrl_lb);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret =3D ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CONTROL=
_LB, 1,
>> +                     AD7280A_CTRL_LB_DAISY_CHAIN_RB_EN |
>> +                     AD7280A_CTRL_LB_LOCK_DEV_ADDR |
>> +                     AD7280A_CTRL_LB_MUST_SET |
>> +                     st->ctrl_lb);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret =3D ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_READ, 1=
,
>> +                     AD7280A_CONTROL_LB<<  2);
>> +     if (ret)
>> +             return ret;
>> +
>> +     for (n =3D 0; n<=3D AD7280A_MAX_CHAIN; n++) {
>> +             __ad7280_read32(st->spi,&val);
>> +             if (val =3D=3D 0)
>> +                     return n - 1;
>> +
>> +             if (ad7280_check_crc(st, val))
>> +                     return -EIO;
>> +
>> +             if (n !=3D AD7280A_DEVADDR(val>>  27))
>> +                     return -EIO;
>> +     }
>> +
>> +     return -EFAULT;
>> +}
>> +
>> +static ssize_t ad7280_show_balance_sw(struct device *dev,
>> +                                     struct device_attribute *attr,
>> +                                     char *buf)
>> +{
>> +     struct iio_dev *dev_info =3D dev_get_drvdata(dev);
>> +     struct ad7280_state *st =3D iio_priv(dev_info);
>> +     struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);
>> +
>> +     return sprintf(buf, "%d\n",
>> +                    !!(st->cb_mask[this_attr->address>>  8]&
>> +                    (1<<  ((this_attr->address&  0xFF) + 2))));
>> +}
>> +
>> +static ssize_t ad7280_store_balance_sw(struct device *dev,
>> +                                      struct device_attribute *attr,
>> +                                      const char *buf,
>> +                                      size_t len)
>> +{
>> +     struct iio_dev *dev_info =3D dev_get_drvdata(dev);
>> +     struct ad7280_state *st =3D iio_priv(dev_info);
>> +     struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);
>> +     bool readin;
>> +     int ret;
>> +     unsigned devaddr, ch;
>> +
>> +     ret =3D strtobool(buf,&readin);
>> +     if (ret)
>> +             return ret;
>> +
>> +     devaddr =3D this_attr->address>>  8;
>> +     ch =3D this_attr->address&  0xFF;
>> +
>> +     mutex_lock(&dev_info->mlock);
>> +     if (readin)
>> +             st->cb_mask[devaddr] |=3D 1<<  (ch + 2);
>> +     else
>> +             st->cb_mask[devaddr]&=3D ~(1<<  (ch + 2));
>> +
>> +     ret =3D ad7280_write(st, devaddr, AD7280A_CELL_BALANCE,
>> +                        0, st->cb_mask[devaddr]);
>> +     mutex_unlock(&dev_info->mlock);
>> +
>> +     return ret ? ret : len;
>> +}
>> +
>> +static ssize_t ad7280_show_balance_timer(struct device *dev,
>> +                                     struct device_attribute *attr,
>> +                                     char *buf)
>> +{
>> +     struct iio_dev *dev_info =3D dev_get_drvdata(dev);
>> +     struct ad7280_state *st =3D iio_priv(dev_info);
>> +     struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);
>> +     int ret;
>> +
>> +     mutex_lock(&dev_info->mlock);
>> +     ret =3D ad7280_read(st, this_attr->address>>  8,
>> +                     this_attr->address&  0xFF);
>> +     mutex_unlock(&dev_info->mlock);
>> +
>> +     if (ret<  0)
>> +             return ret;
>> +
>> +     return sprintf(buf, "%d\n", ret>>  3);
>> +}
>> +
>> +static ssize_t ad7280_store_balance_timer(struct device *dev,
>> +                                      struct device_attribute *attr,
>> +                                      const char *buf,
>> +                                      size_t len)
>> +{
>> +     struct iio_dev *dev_info =3D dev_get_drvdata(dev);
>> +     struct ad7280_state *st =3D iio_priv(dev_info);
>> +     struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);
>> +     long val;
>> +     int ret;
>> +
>> +     ret =3D strict_strtol(buf, 10,&val);
>> +     if (ret)
>> +             return ret;
>> +
>> +     mutex_lock(&dev_info->mlock);
>> +     ret =3D ad7280_write(st, this_attr->address>>  8,
>> +                        this_attr->address&  0xFF,
>> +                        0, (val&  0x1F)<<  3);
>> +     mutex_unlock(&dev_info->mlock);
>> +
>> +     return ret ? ret : len;
>> +}
>> +
>> +static struct attribute *ad7280_attributes[AD7280A_MAX_CHAIN *
>> +                                        AD7280A_CELLS_PER_DEV * 2 + 1=
];
>> +
>> +static struct attribute_group ad7280_attrs_group =3D {
>> +     .attrs =3D ad7280_attributes,
>> +};
>> +
>> +static int ad7280_channel_init(struct ad7280_state *st)
>> +{
>> +     int dev, ch, cnt;
>> +
>> +     st->channels =3D kzalloc(sizeof(*st->channels) *
>> +                             ((st->slave_num + 1) * 12 + 2), GFP_KERN=
EL);
>> +     if (st->channels =3D=3D NULL)
>> +             return -ENOMEM;
>> +
>> +     for (dev =3D 0, cnt =3D 0; dev<=3D st->slave_num; dev++)
>> +             for (ch =3D AD7280A_CELL_VOLTAGE_1; ch<=3D AD7280A_AUX_A=
DC_6; ch++,
>> +                     cnt++) {
>> +                     if (ch<  AD7280A_AUX_ADC_1) {
>> +                             st->channels[cnt].type =3D IIO_IN;
>> +                             st->channels[cnt].channel =3D (dev * 6) =
+ ch;
>> +                     } else {
>> +                             st->channels[cnt].type =3D IIO_TEMP;
>> +                             st->channels[cnt].channel =3D (dev * 6) =
+ ch - 6;
>> +                     }
>> +                     st->channels[cnt].indexed =3D 1;
>> +                     st->channels[cnt].extend_name =3D NULL;
> Don't bother setting it then. You kzalloc'd the array.
ok
>> +                     st->channels[cnt].info_mask =3D
>> +
>> +                             (1<<  IIO_CHAN_INFO_SCALE_SHARED);
> Something strange in spacing above.
>> +                     st->channels[cnt].address =3D
>> +                             AD7280A_DEVADDR(dev)<<  8 | ch;
>> +                     st->channels[cnt].scan_index =3D cnt;
>> +                     st->channels[cnt].scan_type.sign =3D 'u';
>> +                     st->channels[cnt].scan_type.realbits =3D 12;
>> +                     st->channels[cnt].scan_type.storagebits =3D 32;
>> +                     st->channels[cnt].scan_type.shift =3D 0;
>> +             }
>> +
> I'm a little confused here. So we have 6 voltage and 6 temp channels fr=
om
> each part in the chain. What is this last one?
Thats the voltage across all cells in the stack.
>> +     st->channels[cnt].type =3D IIO_IN_DIFF;
>> +     st->channels[cnt].channel =3D 0;
>> +     st->channels[cnt].channel2 =3D dev * 6 - 1;
>> +     st->channels[cnt].address =3D AD7280A_DEVADDR(dev)<<  8 |
>> +             AD7280A_CELL_VOLTAGE_1;
>> +     st->channels[cnt].indexed =3D 1;
> Don't bother setting to NULL.
>> +     st->channels[cnt].extend_name =3D NULL;
>> +     st->channels[cnt].info_mask =3D (1<<  IIO_CHAN_INFO_SCALE_SHARED=
);
>> +     st->channels[cnt].scan_index =3D cnt;
>> +     st->channels[cnt].scan_type.sign =3D 'u';
>> +     st->channels[cnt].scan_type.realbits =3D 32;
>> +     st->channels[cnt].scan_type.storagebits =3D 32;
>> +     st->channels[cnt].scan_type.shift =3D 0;
>> +     cnt++;
>> +     st->channels[cnt].type =3D IIO_TIMESTAMP;
>> +     st->channels[cnt].channel =3D -1;
>> +     st->channels[cnt].scan_index =3D cnt;
>> +     st->channels[cnt].scan_type.sign =3D 's';
>> +     st->channels[cnt].scan_type.realbits =3D 64;
>> +     st->channels[cnt].scan_type.storagebits =3D 64;
>> +     st->channels[cnt].scan_type.shift =3D 0;
>> +
>> +     return cnt + 1;
>> +}
>> +
>> +static int ad7280_attr_init(struct ad7280_state *st)
>> +{
>> +     int dev, ch, cnt;
>> +
>> +     st->iio_attr =3D kzalloc(sizeof(*st->iio_attr) * (st->slave_num =
+ 1) *
>> +                             AD7280A_CELLS_PER_DEV * 2, GFP_KERNEL);
>> +     if (st->iio_attr =3D=3D NULL)
>> +             return -ENOMEM;
>> +
>> +     for (dev =3D 0, cnt =3D 0; dev<=3D st->slave_num; dev++)
>> +             for (ch =3D AD7280A_CELL_VOLTAGE_1; ch<=3D AD7280A_CELL_=
VOLTAGE_6;
>> +                     ch++, cnt++) {
>> +                     st->iio_attr[cnt].address =3D
>> +                             AD7280A_DEVADDR(dev)<<  8 | ch;
>> +                     st->iio_attr[cnt].dev_attr.attr.mode =3D
>> +                             S_IWUSR | S_IRUGO;
>> +                     st->iio_attr[cnt].dev_attr.show =3D
>> +                             ad7280_show_balance_sw;
>> +                     st->iio_attr[cnt].dev_attr.store =3D
>> +                             ad7280_store_balance_sw;
>> +                     st->iio_attr[cnt].dev_attr.attr.name =3D
>> +                             kasprintf(GFP_KERNEL, "in%d_balance_swit=
ch_en",
>> +                                       (dev * AD7280A_CELLS_PER_DEV) =
+ ch);
>> +                     ad7280_attributes[cnt] =3D
>> +&st->iio_attr[cnt].dev_attr.attr;
>> +                     cnt++;
>> +                     st->iio_attr[cnt].address =3D
>> +                             AD7280A_DEVADDR(dev)<<  8 |
>> +                             (AD7280A_CB1_TIMER + ch);
>> +                     st->iio_attr[cnt].dev_attr.attr.mode =3D
>> +                             S_IWUSR | S_IRUGO;
>> +                     st->iio_attr[cnt].dev_attr.show =3D
>> +                             ad7280_show_balance_timer;
>> +                     st->iio_attr[cnt].dev_attr.store =3D
>> +                             ad7280_store_balance_timer;
>> +                     st->iio_attr[cnt].dev_attr.attr.name =3D
>> +                             kasprintf(GFP_KERNEL, "in%d_balance_time=
r",
>> +                                       (dev * AD7280A_CELLS_PER_DEV) =
+ ch);
>> +                     ad7280_attributes[cnt] =3D
>> +&st->iio_attr[cnt].dev_attr.attr;
>> +             }
>> +
>> +     ad7280_attributes[cnt] =3D NULL;
>> +
>> +     return 0;
>> +}
>> +
>> +static ssize_t ad7280_read_channel_config(struct device *dev,
>> +                                     struct device_attribute *attr,
>> +                                     char *buf)
>> +{
>> +     struct iio_dev *dev_info =3D dev_get_drvdata(dev);
>> +     struct ad7280_state *st =3D iio_priv(dev_info);
>> +     struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);
>> +     unsigned val;
>> +
>> +     switch (this_attr->address) {
>> +     case AD7280A_CELL_OVERVOLTAGE:
>> +             val =3D 1000 + (st->cell_threshhigh * 1568) / 100;
>> +             break;
>> +     case AD7280A_CELL_UNDERVOLTAGE:
>> +             val =3D 1000 + (st->cell_threshlow * 1568) / 100;
>> +             break;
>> +     case AD7280A_AUX_ADC_OVERVOLTAGE:
>> +             val =3D (st->aux_threshhigh * 196) / 10;
>> +             break;
>> +     case AD7280A_AUX_ADC_UNDERVOLTAGE:
>> +             val =3D (st->aux_threshlow * 196) / 10;
>> +             break;
>> +     default:
>> +             return -EINVAL;
>> +     }
>> +
>> +     return sprintf(buf, "%d\n", val);
>> +}
>> +
>> +static ssize_t ad7280_write_channel_config(struct device *dev,
>> +                                      struct device_attribute *attr,
>> +                                      const char *buf,
>> +                                      size_t len)
>> +{
>> +     struct iio_dev *dev_info =3D dev_get_drvdata(dev);
>> +     struct ad7280_state *st =3D iio_priv(dev_info);
>> +     struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);
>> +
>> +     long val;
>> +     int ret;
>> +
>> +     ret =3D strict_strtol(buf, 10,&val);
>> +     if (ret)
>> +             return ret;
>> +
>> +     switch (this_attr->address) {
>> +     case AD7280A_CELL_OVERVOLTAGE:
>> +     case AD7280A_CELL_UNDERVOLTAGE:
>> +             val =3D ((val - 1000) * 100) / 1568; /* LSB 15.68mV */
>> +             break;
>> +     case AD7280A_AUX_ADC_OVERVOLTAGE:
>> +     case AD7280A_AUX_ADC_UNDERVOLTAGE:
>> +             val =3D (val * 10) / 196; /* LSB 19.6mV */
>> +             break;
>> +     default:
>> +             return -EFAULT;
>> +     }
>> +
>> +     val =3D clamp(val, 0L, 0xFFL);
>> +
>> +     mutex_lock(&dev_info->mlock);
>> +     switch (this_attr->address) {
>> +     case AD7280A_CELL_OVERVOLTAGE:
>> +             st->cell_threshhigh =3D val;
>> +             break;
>> +     case AD7280A_CELL_UNDERVOLTAGE:
>> +             st->cell_threshlow =3D val;
>> +             break;
>> +     case AD7280A_AUX_ADC_OVERVOLTAGE:
>> +             st->aux_threshhigh =3D val;
>> +             break;
>> +     case AD7280A_AUX_ADC_UNDERVOLTAGE:
>> +             st->aux_threshlow =3D val;
>> +             break;
>> +     }
>> +
>> +     ret =3D ad7280_write(st, AD7280A_DEVADDR_MASTER,
>> +                        this_attr->address, 1, val);
>> +
>> +     mutex_unlock(&dev_info->mlock);
>> +
>> +     return ret ? ret : len;
>> +}
>> +
>> +static irqreturn_t ad7280_event_handler(int irq, void *private)
>> +{
>> +     struct iio_dev *dev_info =3D private;
>> +
>> +     iio_push_event(dev_info, 0,
>> +                    IIO_UNMOD_EVENT_CODE(IIO_IN,
>> +                                         0,
>> +                                         IIO_EV_TYPE_THRESH,
>> +                                         IIO_EV_DIR_EITHER),
>> +                    iio_get_time_ns());
> You have thresholds for temp and voltage below, but only voltage
> event. I wonder if the right thing here is to issue two events
> (subject to what is enabled).  If everything is turned on, there
> doesn't seem to be anyway to tell what happened.  If the event
> is consistent, I guess you could write a strobe function that would
> enable events up the chain and see when it kicked in. That would
> tell you where it came from.  No idea if one ever wants to know though.
Alternatively I could read all channels in the stack and compare
against the set thresholds. I think that would make the most sense here.

>
>> +
>> +     return IRQ_HANDLED;
>> +}
>> +
>> +static IIO_DEVICE_ATTR(in_thresh_low_value,
>> +                    S_IRUGO | S_IWUSR,
>> +                    ad7280_read_channel_config,
>> +                    ad7280_write_channel_config,
>> +                    AD7280A_CELL_UNDERVOLTAGE);
>> +
>> +static IIO_DEVICE_ATTR(in_thresh_high_value,
>> +                    S_IRUGO | S_IWUSR,
>> +                    ad7280_read_channel_config,
>> +                    ad7280_write_channel_config,
>> +                    AD7280A_CELL_OVERVOLTAGE);
>> +
>> +static IIO_DEVICE_ATTR(temp_thresh_low_value,
>> +                    S_IRUGO | S_IWUSR,
>> +                    ad7280_read_channel_config,
>> +                    ad7280_write_channel_config,
>> +                    AD7280A_AUX_ADC_UNDERVOLTAGE);
>> +
>> +static IIO_DEVICE_ATTR(temp_thresh_high_value,
>> +                    S_IRUGO | S_IWUSR,
>> +                    ad7280_read_channel_config,
>> +                    ad7280_write_channel_config,
>> +                    AD7280A_AUX_ADC_OVERVOLTAGE);
> These are shared over all channels?  Hmm. That's not a case
> I'd considered when writing the chan spec stuff for events,
> perhaps we need to allow for 'shared' events.  Technically
> the only abi meeting approach right now is to have these
> for every channel.  So write one channels threshold value
> then a read would tell you they have all changed.
Technically I could have different thresholds for any single
device in the chain, each featuring 6 cell and 6 temp/aux channels.

But in practice, you would set them to all being the same.
What prevents us from having the shared event thresholds?

>> +
>> +
>> +static struct attribute *ad7280_event_attributes[] =3D {
>> +&iio_dev_attr_in_thresh_low_value.dev_attr.attr,
>> +&iio_dev_attr_in_thresh_high_value.dev_attr.attr,
>> +&iio_dev_attr_temp_thresh_low_value.dev_attr.attr,
>> +&iio_dev_attr_temp_thresh_high_value.dev_attr.attr,
>> +     NULL,
>> +};
>> +
>> +static struct attribute_group ad7280_event_attrs_group =3D {
>> +     .attrs =3D ad7280_event_attributes,
>> +};
>> +
>> +static int ad7280_read_raw(struct iio_dev *dev_info,
>> +                        struct iio_chan_spec const *chan,
>> +                        int *val,
>> +                        int *val2,
>> +                        long m)
>> +{
>> +     struct ad7280_state *st =3D iio_priv(dev_info);
>> +     unsigned int scale_uv;
>> +     int ret;
>> +
>> +     switch (m) {
>> +     case 0:
>> +             mutex_lock(&dev_info->mlock);
>> +             switch (chan->type) {
>> +             case IIO_IN:
>> +                     ret =3D ad7280_read_channel(st, chan->address>> =
 8,
>> +                                               chan->address&  0xFF);
>> +                     break;
>> +             case IIO_IN_DIFF:
>> +                     ret =3D ad7280_read_all_channels(st, st->scan_cn=
t, NULL);
> Err... Really need some explanation for what this channel is!
Voltage across all cells.

>> +                     break;
>> +             default:
>> +                     ret =3D -EINVAL;
>> +             }
>> +             mutex_unlock(&dev_info->mlock);
>> +
>> +             if (ret<  0)
>> +                     return ret;
>> +
>> +             *val =3D ret;
>> +
>> +             return IIO_VAL_INT;
>> +     case (1<<  IIO_CHAN_INFO_SCALE_SHARED):
>> +             if ((chan->address&  0xFF)<=3D AD7280A_CELL_VOLTAGE_6)
>> +                     scale_uv =3D (4000 * 1000)>>  AD7280A_BITS;
>> +             else
>> +                     scale_uv =3D (5000 * 1000)>>  AD7280A_BITS;
>> +
>> +             *val =3D  scale_uv / 1000;
>> +             *val2 =3D (scale_uv % 1000) * 1000;
>> +             return IIO_VAL_INT_PLUS_MICRO;
>> +     }
>> +     return -EINVAL;
>> +}
>> +
>> +static const struct iio_info ad7280_info =3D {
>> +     .read_raw =3D&ad7280_read_raw,
>> +     .num_interrupt_lines =3D 1,
>> +     .event_attrs =3D&ad7280_event_attrs_group,
>> +     .attrs =3D&ad7280_attrs_group,
>> +     .driver_module =3D THIS_MODULE,
>> +};
>> +
>> +static struct ad7280_platform_data ad7793_default_pdata =3D {
>> +     .acquisition_time =3D AD7280A_ACQ_TIME_400ns,
>> +     .conversion_averaging =3D AD7280A_CONV_AVG_DIS,
>> +     .thermistor_term_en =3D true,
>> +};
> const?
ok
>> +
>> +static int __devinit ad7280_probe(struct spi_device *spi)
>> +{
>> +     struct ad7280_platform_data *pdata =3D spi->dev.platform_data;
>> +     struct ad7280_state *st;
>> +     int ret, regdone =3D 0;
>> +     const unsigned short tACQ_ns[4] =3D {465, 1010, 1460, 1890};
>> +     const unsigned short nAVG[4] =3D {1, 2, 4, 8};
>> +     struct iio_dev *indio_dev =3D iio_allocate_device(sizeof(*st));
>> +
>> +     if (indio_dev =3D=3D NULL)
>> +             return -ENOMEM;
>> +
>> +     st =3D iio_priv(indio_dev);
>> +     spi_set_drvdata(spi, indio_dev);
>> +     st->spi =3D spi;
>> +
>> +     if (!pdata)
>> +             pdata =3D&ad7793_default_pdata;
>> +
>> +     ad7280_crc8_build_table(st->crc_tab);
>> +
>> +     st->spi->max_speed_hz =3D AD7280A_MAX_SPI_CLK_Hz;
>> +     st->spi->mode =3D SPI_MODE_1;
>> +     spi_setup(st->spi);
>> +
>> +     st->ctrl_lb =3D AD7280A_CTRL_LB_ACQ_TIME(pdata->acquisition_time=
&  0x3);
>> +     st->ctrl_hb =3D AD7280A_CTRL_HB_CONV_AVG(pdata->conversion_avera=
ging
>> +&  0x3) | (pdata->thermistor_term_en ?
>> +                     AD7280A_CTRL_LB_THERMISTOR_EN : 0);
>> +
>> +     ret =3D ad7280_chain_setup(st);
>> +     if (ret<  0)
>> +             goto error_free_device;
>> +
>> +     st->slave_num =3D ret;
>> +     st->scan_cnt =3D (st->slave_num + 1) * AD7280A_NUM_CH;
>> +     st->cell_threshhigh =3D 0xFF;
>> +     st->aux_threshhigh =3D 0xFF;
>> +
>> +     /*
>> +      * Total Conversion Time =3D ((tACQ + tCONV) *
>> +      *                         (Number of Conversions per Part)) =E2=
=88=92
>> +      *                         tACQ + ((N - 1) * tDELAY)
>> +      *
>> +      * Readback Delay =3D Total Conversion Time + tWAIT
>> +      */
>> +
>> +     st->readback_delay_us =3D
>> +             ((tACQ_ns[pdata->acquisition_time&  0x3] + 695) *
>> +             (AD7280A_NUM_CH * nAVG[pdata->conversion_averaging&  0x3=
]))
>> +             - tACQ_ns[pdata->acquisition_time&  0x3] +
>> +             st->slave_num * 250;
>> +
>> +     /* Convert to usecs */
>> +     st->readback_delay_us =3D DIV_ROUND_UP(st->readback_delay_us, 10=
00);
>> +     st->readback_delay_us +=3D 5; /* Add tWAIT */
>> +
>> +     indio_dev->name =3D spi_get_device_id(spi)->name;
>> +     indio_dev->dev.parent =3D&spi->dev;
>> +     indio_dev->modes =3D INDIO_DIRECT_MODE;
>> +
>> +     ret =3D ad7280_channel_init(st);
>> +     if (ret<  0)
>> +             goto error_free_device;
>> +
>> +     indio_dev->num_channels =3D ret;
>> +     indio_dev->channels =3D st->channels;
>> +     indio_dev->info =3D&ad7280_info;
>> +
>> +     ret =3D ad7280_attr_init(st);
>> +     if (ret<  0)
>> +             goto error_free_channels;
>> +
>> +     ret =3D iio_device_register(indio_dev);
>> +     if (ret)
>> +             goto error_free_attr;
>> +     regdone =3D 1;
>> +
>> +     if (spi->irq>  0) {
>> +             ret =3D ad7280_write(st, AD7280A_DEVADDR_MASTER,
>> +                                AD7280A_ALERT, 1,
>> +                                AD7280A_ALERT_RELAY_SIG_CHAIN_DOWN);
>> +             if (ret)
>> +                     goto error_free_attr;
>> +
>> +             ret =3D ad7280_write(st, AD7280A_DEVADDR(st->slave_num),
>> +                                AD7280A_ALERT, 0,
>> +                                AD7280A_ALERT_GEN_STATIC_HIGH |
>> +                                (pdata->chain_last_alert_ignore&  0xF=
));
>> +             if (ret)
>> +                     goto error_free_attr;
>> +
>> +             ret =3D request_threaded_irq(spi->irq,
>> +                                        NULL,
>> +                                        ad7280_event_handler,
>> +                                        IRQF_TRIGGER_FALLING |
>> +                                        IRQF_ONESHOT,
>> +                                        indio_dev->name,
>> +                                        indio_dev);
>> +             if (ret)
>> +                     goto error_free_attr;
>> +     }
>> +
>> +     return 0;
>> +
>> +error_free_attr:
>> +     kfree(st->iio_attr);
>> +
>> +error_free_channels:
>> +     kfree(st->channels);
>> +
>> +error_free_device:
>> +     if (regdone)
>> +             iio_device_unregister(indio_dev);
>> +     else
>> +             iio_free_device(indio_dev);
>> +
>> +     return ret;
>> +}
>> +
>> +static int __devexit ad7280_remove(struct spi_device *spi)
>> +{
>> +     struct iio_dev *indio_dev =3D spi_get_drvdata(spi);
>> +     struct ad7280_state *st =3D iio_priv(indio_dev);
>> +
>> +     if (spi->irq>  0)
>> +             free_irq(spi->irq, indio_dev);
>> +
>> +     ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CONTROL_HB, 1,
>> +                     AD7280A_CTRL_HB_PWRDN_SW | st->ctrl_hb);
>> +
>> +     kfree(st->channels);
>> +     kfree(st->iio_attr);
>> +     iio_device_unregister(indio_dev);
>> +
>> +     return 0;
>> +}
>> +
>> +static const struct spi_device_id ad7280_id[] =3D {
>> +     {"ad7280a", 0},
>> +     {}
>> +};
>> +
>> +static struct spi_driver ad7280_driver =3D {
>> +     .driver =3D {
>> +             .name   =3D "ad7280",
>> +             .bus    =3D&spi_bus_type,
>> +             .owner  =3D THIS_MODULE,
>> +     },
>> +     .probe          =3D ad7280_probe,
>> +     .remove         =3D __devexit_p(ad7280_remove),
>> +     .id_table       =3D ad7280_id,
>> +};
>> +
>> +static int __init ad7280_init(void)
>> +{
>> +     return spi_register_driver(&ad7280_driver);
>> +}
>> +module_init(ad7280_init);
>> +
>> +static void __exit ad7280_exit(void)
>> +{
>> +     spi_unregister_driver(&ad7280_driver);
>> +}
>> +module_exit(ad7280_exit);
>> +
>> +MODULE_AUTHOR("Michael Hennerich<hennerich@blackfin.uclinux.org>");
>> +MODULE_DESCRIPTION("Analog Devices AD7280A");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/staging/iio/adc/ad7280a.h b/drivers/staging/iio/a=
dc/ad7280a.h
>> new file mode 100644
>> index 0000000..20400b0
>> --- /dev/null
>> +++ b/drivers/staging/iio/adc/ad7280a.h
>> @@ -0,0 +1,38 @@
>> +/*
>> + * AD7280A Lithium Ion Battery Monitoring System
>> + *
>> + * Copyright 2011 Analog Devices Inc.
>> + *
>> + * Licensed under the GPL-2.
>> + */
>> +
>> +#ifndef IIO_ADC_AD7280_H_
>> +#define IIO_ADC_AD7280_H_
>> +
>> +/*
>> + * TODO: struct ad7280_platform_data needs to go into include/linux/i=
io
>> + */
>> +
>> +#define AD7280A_ACQ_TIME_400ns                       0
>> +#define AD7280A_ACQ_TIME_800ns                       1
>> +#define AD7280A_ACQ_TIME_1200ns                      2
>> +#define AD7280A_ACQ_TIME_1600ns                      3
>> +
>> +#define AD7280A_CONV_AVG_DIS                 0
>> +#define AD7280A_CONV_AVG_2                   1
>> +#define AD7280A_CONV_AVG_4                   2
>> +#define AD7280A_CONV_AVG_8                   3
>> +
>> +#define AD7280A_ALERT_REMOVE_VIN5            (1<<  2)
>> +#define AD7280A_ALERT_REMOVE_VIN4_VIN5               (2<<  2)
>> +#define AD7280A_ALERT_REMOVE_AUX5            (1<<  0)
>> +#define AD7280A_ALERT_REMOVE_AUX4_AUX5               (2<<  0)
>> +
>> +struct ad7280_platform_data {
>> +     unsigned acquisition_time;
>> +     unsigned conversion_averaging;
>> +     unsigned chain_last_alert_ignore;
>> +     bool thermistor_term_en;
>> +};
>> +
>> +#endif /* IIO_ADC_AD7280_H_ */
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Thanks for the review.

--=20
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
