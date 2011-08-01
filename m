Return-Path: <Michael.Hennerich@analog.com>
Message-ID: <4E366A57.1050808@analog.com>
Date: Mon, 1 Aug 2011 10:56:55 +0200
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>, Drivers <Drivers@analog.com>
Subject: Re: [PATCH] iio: impedance-analyzer: New driver for AD5933/4 Impedance
 Converter, Network Analyzer
References: <1311852772-17988-1-git-send-email-michael.hennerich@analog.com> <4E316C4C.5080008@cam.ac.uk> <4E317DEF.5000104@analog.com> <4E31862D.2060802@cam.ac.uk>
In-Reply-To: <4E31862D.2060802@cam.ac.uk>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 07/28/2011 05:54 PM, Jonathan Cameron wrote:
> On 07/28/11 16:19, Michael Hennerich wrote:
>> On 07/28/2011 04:03 PM, Jonathan Cameron wrote:
>>> On 07/28/11 12:32, michael.hennerich@analog.com wrote:
>>>> From: Michael Hennerich<michael.hennerich@analog.com>
>>>>
>>>> The AD5933 is a high precision impedance converter system solution
>>>> that combines an on-board frequency generator with a 12-bit, 1 MSPS,
>>>> analog-to-digital converter (ADC). The frequency generator allows an
>>>> external complex impedance to be excited with a known frequency.
>>>>
>>>> The response signal from the impedance is sampled by the on-board ADC
>>>> and a discrete Fourier transform (DFT) is processed by an on-chip DSP engine.
>>>> The DFT algorithm returns a real (R) and imaginary (I) data-word at each
>>>> output frequency.
>>>>
>>> Mostly looks good. Couple of nitpicks / queries in line.  I'm particularly
>>> bothered about the SCALE info elements in chan_spec that aren't matched
>>> in the read_raw (or a write_raw if relevant).
>> in0_real_raw and in0_imag_raw only exist as scan elements.
>> They aren't present in indio_dev->channels. I therefore couldn't use
>> scale info elements from channel spec.
> Ah. I hadn't noticed that (obviously).  Why is this the case?  Does it just
> not make sense to read them directly?
Hi Jonathan,

It typically doesn't make sense. One use case I could think of is the
single-point gain factor calculation/calibration.
we could add in0_(real|imag) however it still doesn't help us for the 
out0_scale.

>    If so, set their channel number to -1
> and they won't appear.  Hmm.  Perhaps we need to make that test a little
> more refined to make this work.  iio_device_add_channel_sysfs drops the channel
> immediately if it's number is negative.   Maybe move the magic value into channel2?
>
> That way the only uggliness will come if we have a differential channel that only exists
> for scans.  Or use a negative index (rather than just -1).  That's probably the cleanest
> option, but will require a few abs() insertions in the code and some testing
> to make sure we got them all.
>
This should do the trick - I'll have a try.
Regarding adding _available to channel spec.
We probably need to do it for each and every item listed in 
iio_chan_info_enum.
The question is do we want to return a string?

> Something like:
>
> diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
> index b49db92..aeeb5e6 100644
> --- a/drivers/staging/iio/industrialio-core.c
> +++ b/drivers/staging/iio/industrialio-core.c
> @@ -480,7 +480,7 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
>                          = kasprintf(GFP_KERNEL, "%s_%s%d_%s",
>                                      iio_direction[chan->output],
>                                      iio_chan_type_name_spec_shared[chan->type],
> -                                   chan->channel,
> +                                   (int)abs(chan->channel),
>                                      full_postfix);
>
>          if (name_format == NULL) {
> @@ -489,7 +489,7 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
>          }
>          dev_attr->attr.name = kasprintf(GFP_KERNEL,
>                                          name_format,
> -                                       chan->channel,
> +                                       (int)abs(chan->channel),
>                                          chan->channel2);
>          if (dev_attr->attr.name == NULL) {
>                  ret = -ENOMEM;
> @@ -585,27 +585,27 @@ static int iio_device_add_channel_sysfs(struct iio_dev *dev_info,
>   {
>          int ret, i;
>
> -       if (chan->channel<  0)
> -               return 0;
> -       if (chan->processed_val)
> -               ret = __iio_add_chan_devattr("input", NULL, chan,
> -&iio_read_channel_info,
> -                                            NULL,
> -                                            0,
> -                                            0,
> -&dev_info->dev,
> -&dev_info->channel_attr_list);
> -       else
> -               ret = __iio_add_chan_devattr("raw", NULL, chan,
> -&iio_read_channel_info,
> -                                            (chan->output ?
> -&iio_write_channel_info : NULL),
> -                                            0,
> -                                            0,
> -&dev_info->dev,
> -&dev_info->channel_attr_list);
> -       if (ret)
> -               goto error_ret;
> +       if (chan->channel>= 0) {
> +               if (chan->processed_val)
> +                       ret = __iio_add_chan_devattr("input", NULL, chan,
> +&iio_read_channel_info,
> +                                                    NULL,
> +                                                    0,
> +                                                    0,
> +&dev_info->dev,
> +&dev_info->channel_attr_list);
> +               else
> +                       ret = __iio_add_chan_devattr("raw", NULL, chan,
> +&iio_read_channel_info,
> +                                                    (chan->output ?
> +&iio_write_channel_info : NULL),
> +                                                    0,
> +                                                    0,
> +&dev_info->dev,
> +&dev_info->channel_attr_list);
> +               if (ret)
> +                       goto error_ret;
> +       }
>
>          for_each_set_bit(i,&chan->info_mask, sizeof(long)*8) {
>                  ret = __iio_add_chan_devattr(iio_chan_info_postfix[i/2],
>
>>> Jonathan
>>>> Signed-off-by: Michael Hennerich<michael.hennerich@analog.com>
>>>> ---
>>>>    .../sysfs-bus-iio-impedance-analyzer-ad5933        |   30 +
>>>>    drivers/staging/iio/Kconfig                        |    1 +
>>>>    drivers/staging/iio/Makefile                       |    1 +
>>>>    drivers/staging/iio/impedance-analyzer/Kconfig     |   16 +
>>>>    drivers/staging/iio/impedance-analyzer/Makefile    |    5 +
>>>>    drivers/staging/iio/impedance-analyzer/ad5933.c    |  815 ++++++++++++++++++++
>>>>    drivers/staging/iio/impedance-analyzer/ad5933.h    |   28 +
>>>>    7 files changed, 896 insertions(+), 0 deletions(-)
>>>>    create mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-impedance-analyzer-ad5933
>>>>    create mode 100644 drivers/staging/iio/impedance-analyzer/Kconfig
>>>>    create mode 100644 drivers/staging/iio/impedance-analyzer/Makefile
>>>>    create mode 100644 drivers/staging/iio/impedance-analyzer/ad5933.c
>>>>    create mode 100644 drivers/staging/iio/impedance-analyzer/ad5933.h
>>>>
>>>> diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio-impedance-analyzer-ad5933 b/drivers/staging/iio/Documentation/sysfs-bus-iio-impedance-analyzer-ad5933
>>>> new file mode 100644
>>>> index 0000000..798029a
>>>> --- /dev/null
>>>> +++ b/drivers/staging/iio/Documentation/sysfs-bus-iio-impedance-analyzer-ad5933
>>> Maybe keep in mind to move these to a general impedance-analyzer file the
>>> moment we get a second one. + we can add these to chan spec masks if we get a few
>>> users.
>>>
>>>> @@ -0,0 +1,30 @@
>>>> +What:                /sys/bus/iio/devices/iio:deviceX/outY_freq_start
>>>> +KernelVersion:       3.0.1
>>>> +Contact:     linux-iio@vger.kernel.org
>>>> +Description:
>>>> +             Frequency sweep start frequency in Hz.
>>>> +
>>>> +What:                /sys/bus/iio/devices/iio:deviceX/outY_freq_increment
>>>> +KernelVersion:       3.0.1
>>>> +Contact:     linux-iio@vger.kernel.org
>>>> +Description:
>>>> +             Frequency increment in Hz (step size) between consecutive
>>>> +             frequency points along the sweep.
>>>> +
>>>> +What:                /sys/bus/iio/devices/iio:deviceX/outY_freq_points
>>>> +KernelVersion:       3.0.1
>>>> +Contact:     linux-iio@vger.kernel.org
>>>> +Description:
>>>> +             Number of frequency points (steps) in the frequency sweep.
>>>> +             This value, in conjunction with the outY_freq_start and the
>>>> +             outY_freq_increment, determines the frequency sweep range
>>>> +             for the sweep operation.
>>>> +
>>>> +What:                /sys/bus/iio/devices/iio:deviceX/outY_settling_cycles
>>>> +KernelVersion:       3.0.1
>>>> +Contact:     linux-iio@vger.kernel.org
>>>> +Description:
>>>> +             Number of output excitation cycles (settling time cycles)
>>>> +             that are allowed to pass through the unknown impedance,
>>>> +             after each frequency increment, and before the ADC is triggered
>>>> +             to perform a conversion sequence of the response signal.
>>>> diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
>>>> index d329635..7526567 100644
>>>> --- a/drivers/staging/iio/Kconfig
>>>> +++ b/drivers/staging/iio/Kconfig
>>>> @@ -62,6 +62,7 @@ source "drivers/staging/iio/addac/Kconfig"
>>>>    source "drivers/staging/iio/dac/Kconfig"
>>>>    source "drivers/staging/iio/dds/Kconfig"
>>>>    source "drivers/staging/iio/gyro/Kconfig"
>>>> +source "drivers/staging/iio/impedance-analyzer/Kconfig"
>>>>    source "drivers/staging/iio/imu/Kconfig"
>>>>    source "drivers/staging/iio/light/Kconfig"
>>>>    source "drivers/staging/iio/magnetometer/Kconfig"
>>>> diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
>>>> index bb5c95c..eaff649 100644
>>>> --- a/drivers/staging/iio/Makefile
>>>> +++ b/drivers/staging/iio/Makefile
>>>> @@ -16,6 +16,7 @@ obj-y += addac/
>>>>    obj-y += dac/
>>>>    obj-y += dds/
>>>>    obj-y += gyro/
>>>> +obj-y += impedance-analyzer/
>>>>    obj-y += imu/
>>>>    obj-y += light/
>>>>    obj-y += magnetometer/
>>>> diff --git a/drivers/staging/iio/impedance-analyzer/Kconfig b/drivers/staging/iio/impedance-analyzer/Kconfig
>>>> new file mode 100644
>>>> index 0000000..9e91a9b
>>>> --- /dev/null
>>>> +++ b/drivers/staging/iio/impedance-analyzer/Kconfig
>>>> @@ -0,0 +1,16 @@
>>>> +#
>>>> +# Impedance Converter, Network Analyzer drivers
>>>> +#
>>>> +comment "Network Analyzer, Impedance Converters"
>>>> +
>>>> +config AD5933
>>>> +     tristate "Analog Devices AD5933, AD5934 driver"
>>>> +     depends on I2C
>>>> +     select IIO_RING_BUFFER
>>>> +     select IIO_SW_RING
>>>> +     help
>>>> +       Say yes here to build support for Analog Devices Impedance Converter,
>>>> +       Network Analyzer, AD5933/4, provides direct access via sysfs.
>>>> +
>>>> +       To compile this driver as a module, choose M here: the
>>>> +       module will be called ad5933.
>>>> diff --git a/drivers/staging/iio/impedance-analyzer/Makefile b/drivers/staging/iio/impedance-analyzer/Makefile
>>>> new file mode 100644
>>>> index 0000000..7604d78
>>>> --- /dev/null
>>>> +++ b/drivers/staging/iio/impedance-analyzer/Makefile
>>>> @@ -0,0 +1,5 @@
>>>> +#
>>>> +# Makefile for Impedance Converter, Network Analyzer drivers
>>>> +#
>>>> +
>>>> +obj-$(CONFIG_AD5933) += ad5933.o
>>>> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
>>>> new file mode 100644
>>>> index 0000000..d43161b
>>>> --- /dev/null
>>>> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
>>>> @@ -0,0 +1,815 @@
>>>> +/*
>>>> + * AD5933 AD5934 Impedance Converter, Network Analyzer
>>>> + *
>>>> + * Copyright 2011 Analog Devices Inc.
>>>> + *
>>>> + * Licensed under the GPL-2.
>>>> + */
>>>> +
>>>> +#include<linux/interrupt.h>
>>>> +#include<linux/device.h>
>>>> +#include<linux/kernel.h>
>>>> +#include<linux/sysfs.h>
>>>> +#include<linux/i2c.h>
>>>> +#include<linux/regulator/consumer.h>
>>>> +#include<linux/slab.h>
>>>> +#include<linux/types.h>
>>>> +#include<linux/err.h>
>>>> +#include<linux/delay.h>
>>>> +#include<asm/div64.h>
>>>> +
>>>> +#include "../iio.h"
>>>> +#include "../sysfs.h"
>>>> +#include "../ring_generic.h"
>>>> +#include "../ring_sw.h"
>>>> +
>>>> +#include "ad5933.h"
>>>> +
>>>> +/* AD5933/AD5934 Registers */
>>>> +#define AD5933_REG_CONTROL_HB                0x80    /* R/W, 2 bytes */
>>>> +#define AD5933_REG_CONTROL_LB                0x81    /* R/W, 2 bytes */
>>>> +#define AD5933_REG_FREQ_START                0x82    /* R/W, 3 bytes */
>>>> +#define AD5933_REG_FREQ_INC          0x85    /* R/W, 3 bytes */
>>>> +#define AD5933_REG_INC_NUM           0x88    /* R/W, 2 bytes, 9 bit */
>>>> +#define AD5933_REG_SETTLING_CYCLES   0x8A    /* R/W, 2 bytes */
>>>> +#define AD5933_REG_STATUS            0x8F    /* R, 1 byte */
>>>> +#define AD5933_REG_TEMP_DATA         0x92    /* R, 2 bytes*/
>>>> +#define AD5933_REG_REAL_DATA         0x94    /* R, 2 bytes*/
>>>> +#define AD5933_REG_IMAG_DATA         0x96    /* R, 2 bytes*/
>>>> +
>>>> +/* AD5933_REG_CONTROL_HB Bits */
>>>> +#define AD5933_CTRL_INIT_START_FREQ  (0x1<<   4)
>>>> +#define AD5933_CTRL_START_SWEEP              (0x2<<   4)
>>>> +#define AD5933_CTRL_INC_FREQ         (0x3<<   4)
>>>> +#define AD5933_CTRL_REPEAT_FREQ              (0x4<<   4)
>>>> +#define AD5933_CTRL_MEASURE_TEMP     (0x9<<   4)
>>>> +#define AD5933_CTRL_POWER_DOWN               (0xA<<   4)
>>>> +#define AD5933_CTRL_STANDBY          (0xB<<   4)
>>>> +
>>>> +#define AD5933_CTRL_RANGE_2000mVpp   (0x0<<   1)
>>>> +#define AD5933_CTRL_RANGE_200mVpp    (0x1<<   1)
>>>> +#define AD5933_CTRL_RANGE_400mVpp    (0x2<<   1)
>>>> +#define AD5933_CTRL_RANGE_1000mVpp   (0x3<<   1)
>>>> +#define AD5933_CTRL_RANGE(x)         ((x)<<   1)
>>>> +
>>>> +#define AD5933_CTRL_PGA_GAIN_1               (0x1<<   0)
>>>> +#define AD5933_CTRL_PGA_GAIN_5               (0x0<<   0)
>>>> +
>>>> +/* AD5933_REG_CONTROL_LB Bits */
>>>> +#define AD5933_CTRL_RESET            (0x1<<   4)
>>>> +#define AD5933_CTRL_INT_SYSCLK               (0x0<<   3)
>>>> +#define AD5933_CTRL_EXT_SYSCLK               (0x1<<   3)
>>>> +
>>>> +/* AD5933_REG_STATUS Bits */
>>>> +#define AD5933_STAT_TEMP_VALID               (0x1<<   0)
>>>> +#define AD5933_STAT_DATA_VALID               (0x1<<   1)
>>>> +#define AD5933_STAT_SWEEP_DONE               (0x1<<   2)
>>>> +
>>>> +/* I2C Commands */
>>> What are these?
>> Those are special I2C block commands, but they didn't work
>> as detailed in the datasheet. I therefore switched to
>> single byte transfers. I can remove these defines.
> Cool.  Or leave them and state they don't work. Might save
> someone else some time in the future ;)
>>>> +#define AD5933_I2C_BLOCK_WRITE               0xA0
>>>> +#define AD5933_I2C_BLOCK_READ                0xA1
>>>> +#define AD5933_I2C_ADDR_POINTER              0xB0
>>>> +
>>>> +/* Device Specs */
>>>> +#define AD5933_INT_OSC_FREQ_Hz               16776000
>>>> +#define AD5933_MAX_OUTPUT_FREQ_Hz    100000
>>>> +#define AD5933_MAX_RETRIES           100
>>>> +
>>>> +#define AD5933_OUT_RANGE             1
>>>> +#define AD5933_OUT_RANGE_AVAIL               2
>>>> +#define AD5933_OUT_SETTLING_CYCLES   3
>>>> +#define AD5933_IN_PGA_GAIN           4
>>>> +#define AD5933_IN_PGA_GAIN_AVAIL     5
>>>> +#define AD5933_FREQ_POINTS           6
>>>> +
>>>> +#define AD5933_POLL_TIME_ms          10
>>>> +#define AD5933_INIT_EXCITATION_TIME_ms       100
>>>> +
>>>> +struct ad5933_state {
>>>> +     struct i2c_client               *client;
>>>> +     struct regulator                *reg;
>>>> +     struct ad5933_platform_data     *pdata;
>>>> +     struct delayed_work             work;
>>>> +     unsigned long                   mclk_hz;
>>>> +     unsigned char                   ctrl_hb;
>>>> +     unsigned char                   ctrl_lb;
>>>> +     unsigned                        range_avail[4];
>>>> +     unsigned short                  vref_mv;
>>>> +     unsigned short                  settling_cycles;
>>>> +     unsigned short                  freq_points;
>>>> +     unsigned                        freq_start;
>>>> +     unsigned                        freq_inc;
>>>> +     unsigned                        state;
>>>> +     unsigned                        poll_time_jiffies;
>>>> +};
>>>> +
>>>> +struct ad5933_platform_data ad5933_default_pdata  = {
>>>> +     .vref_mv = 3300,
>>>> +};
>>>> +
>>>> +static struct iio_chan_spec ad5933_channels[] = {
>>>> +     IIO_CHAN(IIO_TEMP, 0, 1, 1, NULL, 0, 0, 0,
>>>> +              0, AD5933_REG_TEMP_DATA, IIO_ST('s', 14, 16, 0), 0),
>>>> +     /* Ring Channels */
>>>> +     IIO_CHAN(IIO_IN, 0, 1, 0, "real_raw", 0, 0,
>>>> +              (1<<   IIO_CHAN_INFO_SCALE_SEPARATE),
>>>> +              AD5933_REG_REAL_DATA, 0, IIO_ST('s', 16, 16, 0), 0),
>>>> +     IIO_CHAN(IIO_IN, 0, 1, 0, "imag_raw", 0, 0,
>>>> +              (1<<   IIO_CHAN_INFO_SCALE_SEPARATE),
>>>> +              AD5933_REG_IMAG_DATA, 1, IIO_ST('s', 16, 16, 0), 0),
>>>> +};
>>> If those SCALE_SEPARATE elements aren't causing files to be created
>>> and reads into the read_raw function then something nasty is going wrong...
>>       indio_dev->channels = ad5933_channels;
>>       indio_dev->num_channels = 1;
>>
>> :-)
> Nasty.  Please add a comment here so people don't have to notice that!
>>
>>>> +
>>>> +static int ad5933_i2c_write(struct i2c_client *client,
>>>> +                           u8 reg, u8 len, u8 *data)
>>>> +{
>>>> +     int ret;
>>>> +
>>>> +     while (len--) {
>>>> +             ret = i2c_smbus_write_byte_data(client, reg++, *data++);
>>>> +             if (ret<   0) {
>>>> +                     dev_err(&client->dev, "I2C write error\n");
>>>> +                     return ret;
>>>> +             }
>>>> +     }
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static int ad5933_i2c_read(struct i2c_client *client,
>>>> +                           u8 reg, u8 len, u8 *data)
>>>> +{
>>>> +     int ret;
>>>> +
>>>> +     while (len--) {
>>>> +             ret = i2c_smbus_read_byte_data(client, reg++);
>>>> +             if (ret<   0) {
>>>> +                     dev_err(&client->dev, "I2C read error\n");
>>>> +                     return ret;
>>>> +             }
>>>> +             *data++ = ret;
>>>> +     }
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static int ad5933_cmd(struct ad5933_state *st, unsigned char cmd)
>>>> +{
>>>> +     unsigned char dat = st->ctrl_hb | cmd;
>>>> +
>>>> +     return ad5933_i2c_write(st->client,
>>>> +                     AD5933_REG_CONTROL_HB, 1,&dat);
>>>> +}
>>>> +
>>>> +static int ad5933_reset(struct ad5933_state *st)
>>>> +{
>>>> +     unsigned char dat = st->ctrl_lb | AD5933_CTRL_RESET;
>>>> +     return ad5933_i2c_write(st->client,
>>>> +                     AD5933_REG_CONTROL_LB, 1,&dat);
>>>> +}
>>>> +
>>>> +static int ad5933_wait_busy(struct ad5933_state *st, unsigned char event)
>>>> +{
>>>> +     unsigned char val, timeout = AD5933_MAX_RETRIES;
>>>> +     int ret;
>>>> +
>>>> +     while (timeout--) {
>>>> +             ret =  ad5933_i2c_read(st->client, AD5933_REG_STATUS, 1,&val);
>>>> +             if (ret<   0)
>>>> +                     return ret;
>>>> +             if (val&   event)
>>>> +                     return val;
>>>> +             cpu_relax();
>>>> +             mdelay(1);
>>>> +     }
>>>> +
>>>> +     return -EAGAIN;
>>>> +}
>>>> +
>>>> +static int ad5933_set_freq(struct ad5933_state *st,
>>>> +                        unsigned reg, unsigned long freq)
>>>> +{
>>>> +     unsigned long long freqreg;
>>>> +     u8 dat[3];
>>>> +
>>>> +     freqreg = (u64) freq * (u64) (1<<   27);
>>>> +     do_div(freqreg, st->mclk_hz / 4);
>>>> +
>>>> +     switch (reg) {
>>>> +     case AD5933_REG_FREQ_START:
>>>> +             st->freq_start = freq;
>>>> +             break;
>>>> +     case AD5933_REG_FREQ_INC:
>>>> +             st->freq_inc = freq;
>>>> +             break;
>>>> +     default:
>>>> +             return -EINVAL;
>>>> +     }
>>>> +
>>>> +     dat[0] = freqreg>>   16;
>>>> +     dat[1] = freqreg>>   8;
>>>> +     dat[2] = freqreg&   0xFF;
>>>> +
>>>> +     return ad5933_i2c_write(st->client, reg, 3, dat);
>>>> +}
>>>> +
>>>> +static int ad5933_setup(struct ad5933_state *st)
>>>> +{
>>>> +     u8 dat[2];
>>>> +     int ret;
>>>> +
>>>> +     ret = ad5933_reset(st);
>>>> +     if (ret<   0)
>>>> +             return ret;
>>>> +
>>>> +     ret = ad5933_set_freq(st, AD5933_REG_FREQ_START, 10000);
>>>> +     if (ret<   0)
>>>> +             return ret;
>>>> +
>>>> +     ret = ad5933_set_freq(st, AD5933_REG_FREQ_INC, 200);
>>>> +     if (ret<   0)
>>>> +             return ret;
>>>> +
>>>> +     st->settling_cycles = 10;
>>>> +     dat[0] = st->settling_cycles>>   8;
>>>> +     dat[1] = st->settling_cycles;
>>>> +
>>>> +     ret = ad5933_i2c_write(st->client,
>>>> +                     AD5933_REG_SETTLING_CYCLES, 2, dat);
>>>> +     if (ret<   0)
>>>> +             return ret;
>>>> +
>>>> +     st->freq_points = 100;
>>>> +     dat[0] = st->freq_points>>   8;
>>>> +     dat[1] = st->freq_points;
>>>> +
>>>> +     return ad5933_i2c_write(st->client, AD5933_REG_INC_NUM, 2, dat);
>>>> +}
>>>> +
>>>> +static void ad5933_calc_out_ranges(struct ad5933_state *st)
>>>> +{
>>>> +     int i;
>>>> +     unsigned normalized_3v3[4] = {1980, 198, 383, 970};
>>>> +
>>>> +     for (i = 0; i<   4; i++)
>>>> +             st->range_avail[i] = normalized_3v3[i] * st->vref_mv / 3300;
>>>> +
>>>> +}
>>>> +
>>>> +/*
>>>> + * handles: AD5933_REG_FREQ_START and AD5933_REG_FREQ_INC
>>>> + */
>>>> +
>>>> +static ssize_t ad5933_show_frequency(struct device *dev,
>>>> +                                     struct device_attribute *attr,
>>>> +                                     char *buf)
>>>> +{
>>>> +     struct iio_dev *dev_info = dev_get_drvdata(dev);
>>>> +     struct ad5933_state *st = iio_priv(dev_info);
>>>> +     struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>>>> +     int ret;
>>>> +     unsigned long long freqreg;
>>>> +     u8 dat[3];
>>>> +
>>>> +     mutex_lock(&dev_info->mlock);
>>>> +     ret = ad5933_i2c_read(st->client, this_attr->address, 3, dat);
>>>> +     mutex_unlock(&dev_info->mlock);
>>>> +     if (ret<   0)
>>>> +             return ret;
>>>> +
>>>> +     freqreg = dat[0]<<   16 | dat[1]<<   8 | dat[2];
>>>> +
>>>> +     freqreg = (u64) freqreg * (u64) (st->mclk_hz / 4);
>>>> +     do_div(freqreg, 1<<   27);
>>>> +
>>>> +     return sprintf(buf, "%d\n", (int) freqreg);
>>>> +}
>>>> +
>>>> +static ssize_t ad5933_store_frequency(struct device *dev,
>>>> +                                      struct device_attribute *attr,
>>>> +                                      const char *buf,
>>>> +                                      size_t len)
>>>> +{
>>>> +     struct iio_dev *dev_info = dev_get_drvdata(dev);
>>>> +     struct ad5933_state *st = iio_priv(dev_info);
>>>> +     struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>>>> +     long val;
>>>> +     int ret;
>>>> +
>>>> +     ret = strict_strtoul(buf, 10,&val);
>>>> +     if (ret)
>>>> +             return ret;
>>>> +
>>>> +     if (val>   AD5933_MAX_OUTPUT_FREQ_Hz)
>>>> +             return -EINVAL;
>>>> +
>>>> +     mutex_lock(&dev_info->mlock);
>>>> +     ret = ad5933_set_freq(st, this_attr->address, val);
>>>> +     mutex_unlock(&dev_info->mlock);
>>>> +
>>>> +     return ret ? ret : len;
>>>> +}
>>>> +
>>>> +static IIO_DEVICE_ATTR(out0_freq_start, S_IRUGO | S_IWUSR,
>>>> +                     ad5933_show_frequency,
>>>> +                     ad5933_store_frequency,
>>>> +                     AD5933_REG_FREQ_START);
>>>> +
>>>> +static IIO_DEVICE_ATTR(out0_freq_increment, S_IRUGO | S_IWUSR,
>>>> +                     ad5933_show_frequency,
>>>> +                     ad5933_store_frequency,
>>>> +                     AD5933_REG_FREQ_INC);
>>>> +
>>>> +static ssize_t ad5933_show(struct device *dev,
>>>> +                                     struct device_attribute *attr,
>>>> +                                     char *buf)
>>>> +{
>>>> +     struct iio_dev *dev_info = dev_get_drvdata(dev);
>>>> +     struct ad5933_state *st = iio_priv(dev_info);
>>>> +     struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>>>> +     int ret = 0, len = 0;
>>>> +
>>>> +     mutex_lock(&dev_info->mlock);
>>>> +     switch (this_attr->address) {
>>>> +     case AD5933_OUT_RANGE:
>>>> +             len = sprintf(buf, "%d\n",
>>>> +                           st->range_avail[(st->ctrl_hb>>   1)&   0x3]);
>>>> +             break;
>>>> +     case AD5933_OUT_RANGE_AVAIL:
>>>> +             len = sprintf(buf, "%d %d %d %d\n", st->range_avail[0],
>>>> +                           st->range_avail[3], st->range_avail[2],
>>>> +                           st->range_avail[1]);
>>>> +             break;
>>>> +     case AD5933_OUT_SETTLING_CYCLES:
>>>> +             len = sprintf(buf, "%d\n", st->settling_cycles);
>>>> +             break;
>>>> +     case AD5933_IN_PGA_GAIN:
>>>> +             len = sprintf(buf, "%s\n",
>>>> +                           (st->ctrl_hb&   AD5933_CTRL_PGA_GAIN_1) ?
>>>> +                           "1" : "0.2");
>>>> +             break;
>>>> +     case AD5933_IN_PGA_GAIN_AVAIL:
>>>> +             len = sprintf(buf, "1 0.2\n");
>>>> +             break;
>>>> +     case AD5933_FREQ_POINTS:
>>>> +             len = sprintf(buf, "%d\n", st->freq_points);
>>>> +             break;
>>>> +     default:
>>>> +             ret = -EINVAL;
>>>> +     }
>>>> +
>>>> +     mutex_unlock(&dev_info->mlock);
>>>> +     return ret ? ret : len;
>>>> +}
>>>> +
>>>> +static ssize_t ad5933_store(struct device *dev,
>>>> +                                      struct device_attribute *attr,
>>>> +                                      const char *buf,
>>>> +                                      size_t len)
>>>> +{
>>>> +     struct iio_dev *dev_info = dev_get_drvdata(dev);
>>>> +     struct ad5933_state *st = iio_priv(dev_info);
>>>> +     struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>>>> +     long val;
>>>> +     int i, ret = 0;
>>>> +     unsigned char dat[2];
>>>> +
>>>> +     if (this_attr->address != AD5933_IN_PGA_GAIN) {
>>>> +             ret = strict_strtol(buf, 10,&val);
>>>> +             if (ret)
>>>> +                     return ret;
>>>> +     }
>>>> +
>>>> +     mutex_lock(&dev_info->mlock);
>>>> +     switch (this_attr->address) {
>>>> +     case AD5933_OUT_RANGE:
>>>> +             for (i = 0; i<   4; i++)
>>>> +                     if (val == st->range_avail[i]) {
>>>> +                             st->ctrl_hb&= ~AD5933_CTRL_RANGE(0x3);
>>>> +                             st->ctrl_hb |= AD5933_CTRL_RANGE(i);
>>>> +                             ret = ad5933_cmd(st, 0);
>>>> +                             break;
>>>> +                     }
>>>> +             ret = -EINVAL;
>>>> +             break;
>>>> +     case AD5933_IN_PGA_GAIN:
>>>> +             if (sysfs_streq(buf, "1")) {
>>>> +                     st->ctrl_hb |= AD5933_CTRL_PGA_GAIN_1;
>>>> +             } else if (sysfs_streq(buf, "0.2")) {
>>>> +                     st->ctrl_hb&= ~AD5933_CTRL_PGA_GAIN_1;
>>>> +             } else {
>>>> +                     ret = -EINVAL;
>>>> +                     break;
>>>> +             }
>>>> +             ret = ad5933_cmd(st, 0);
>>>> +             break;
>>>> +     case AD5933_OUT_SETTLING_CYCLES:
>>>> +             val = clamp(val, 0L, 0x7FFL);
>>>> +             st->settling_cycles = val;
>>>> +
>>>> +             /* 2x, 4x handling, see datasheet */
>>>> +             if (val>   511)
>>>> +                     val = (val>>   1) | (1<<   9);
>>>> +             else if (val>   1022)
>>>> +                     val = (val>>   2) | (3<<   9);
>>>> +
>>>> +             dat[0] = val>>   8;
>>>> +             dat[1] = val;
>>>> +
>>>> +             ret = ad5933_i2c_write(st->client,
>>>> +                             AD5933_REG_SETTLING_CYCLES, 2, dat);
>>>> +             break;
>>>> +     case AD5933_FREQ_POINTS:
>>>> +             val = clamp(val, 0L, 511L);
>>>> +             st->freq_points = val;
>>>> +
>>> Looks like an endian conversion to me.  Can we do this any slicker?
>> Sure
>>>> +             dat[0] = val>>   8;
>>>> +             dat[1] = val;
>>>> +
>>>> +             ret = ad5933_i2c_write(st->client, AD5933_REG_INC_NUM, 2, dat);
>>>> +             break;
>>>> +     default:
>>>> +             ret = -EINVAL;
>>>> +     }
>>>> +
>>>> +     mutex_unlock(&dev_info->mlock);
>>>> +     return ret ? ret : len;
>>>> +}
>>>> +
>>>> +static IIO_DEVICE_ATTR(out0_scale, S_IRUGO | S_IWUSR,
>>>> +                     ad5933_show,
>>>> +                     ad5933_store,
>>>> +                     AD5933_OUT_RANGE);
>>>> +
>>>> +static IIO_DEVICE_ATTR(out0_scale_available, S_IRUGO,
>>>> +                     ad5933_show,
>>>> +                     NULL,
>>>> +                     AD5933_OUT_RANGE_AVAIL);
>>>> +
>>>> +static IIO_DEVICE_ATTR(in0_scale, S_IRUGO | S_IWUSR,
>>>> +                     ad5933_show,
>>>> +                     ad5933_store,
>>>> +                     AD5933_IN_PGA_GAIN);
>>>> +
>>>> +static IIO_DEVICE_ATTR(in0_scale_available, S_IRUGO,
>>>> +                     ad5933_show,
>>>> +                     NULL,
>>>> +                     AD5933_IN_PGA_GAIN_AVAIL);
>>>> +
>>>> +static IIO_DEVICE_ATTR(out0_freq_points, S_IRUGO | S_IWUSR,
>>>> +                     ad5933_show,
>>>> +                     ad5933_store,
>>>> +                     AD5933_FREQ_POINTS);
>>>> +
>>>> +static IIO_DEVICE_ATTR(out0_settling_cycles, S_IRUGO | S_IWUSR,
>>>> +                     ad5933_show,
>>>> +                     ad5933_store,
>>>> +                     AD5933_OUT_SETTLING_CYCLES);
>>>> +
>>>> +static struct attribute *ad5933_attributes[] = {
>>>> +&iio_dev_attr_out0_scale.dev_attr.attr,
>>>> +&iio_dev_attr_out0_scale_available.dev_attr.attr,
>>>> +&iio_dev_attr_out0_freq_start.dev_attr.attr,
>>>> +&iio_dev_attr_out0_freq_increment.dev_attr.attr,
>>>> +&iio_dev_attr_out0_freq_points.dev_attr.attr,
>>>> +&iio_dev_attr_out0_settling_cycles.dev_attr.attr,
>>>> +&iio_dev_attr_in0_scale.dev_attr.attr,
>>> Should be able to do the scale attributes via the chan_spec. Could also
>>> add scale_available to that given it's pretty common.  The others
>>> are one offs for now so probably best to leave them here.  Depends if you
>>> have lots more of these drivers queued up!
>>>> +&iio_dev_attr_in0_scale_available.dev_attr.attr,
>>>> +     NULL
>>>> +};
>>>> +
>>>> +static const struct attribute_group ad5933_attribute_group = {
>>>> +     .attrs = ad5933_attributes,
>>>> +};
>>>> +
>>>> +static int ad5933_read_raw(struct iio_dev *dev_info,
>>>> +                        struct iio_chan_spec const *chan,
>>>> +                        int *val,
>>>> +                        int *val2,
>>>> +                        long m)
>>>> +{
>>>> +     struct ad5933_state *st = iio_priv(dev_info);
>>>> +     unsigned char dat[2];
>>>> +     int ret = -EINVAL;
>>>> +
>>>> +     mutex_lock(&dev_info->mlock);
>>>> +     switch (m) {
>>>> +     case 0:
>>>> +             if (iio_ring_enabled(dev_info)) {
>>>> +                     ret = -EBUSY;
>>>> +                     goto out;
>>>> +             }
>>>> +             ret = ad5933_cmd(st, AD5933_CTRL_MEASURE_TEMP);
>>>> +             if (ret<   0)
>>>> +                     goto out;
>>>> +             ret = ad5933_wait_busy(st, AD5933_STAT_TEMP_VALID);
>>>> +             if (ret<   0)
>>>> +                     goto out;
>>>> +
>>>> +             ret = ad5933_i2c_read(st->client,
>>>> +                             AD5933_REG_TEMP_DATA, 2,
>>>> +                             dat);
>>>> +             if (ret<   0)
>>>> +                     goto out;
>>>> +             mutex_unlock(&dev_info->mlock);
>>>> +
>>>> +             ret = dat[0]<<   8 | dat[1];
>>>> +             /* Temp in Milli degrees Celsius */
>>>> +             if (ret<   8192)
>>>> +                     *val = ret * 1000 / 32;
>>>> +             else
>>>> +                     *val = (ret - 16384) * 1000 / 32;
>>>> +
>>>> +             return IIO_VAL_INT;
>>>> +     }
>>>> +
>>>> +out:
>>>> +     mutex_unlock(&dev_info->mlock);
>>>> +     return ret;
>>>> +}
>>>> +
>>>> +static const struct iio_info ad5933_info = {
>>>> +     .read_raw =&ad5933_read_raw,
>>>> +     .attrs =&ad5933_attribute_group,
>>>> +     .driver_module = THIS_MODULE,
>>>> +};
>>>> +
>>>> +static int ad5933_ring_preenable(struct iio_dev *indio_dev)
>>>> +{
>>>> +     struct ad5933_state *st = iio_priv(indio_dev);
>>>> +     struct iio_ring_buffer *ring = indio_dev->ring;
>>>> +     size_t d_size;
>>>> +     int ret;
>>>> +
>>>> +     if (!ring->scan_count)
>>>> +             return -EINVAL;
>>>> +
>>>> +     d_size = ring->scan_count *
>>>> +              ad5933_channels[1].scan_type.storagebits / 8;
>>>> +
>>>> +     if (indio_dev->ring->access->set_bytes_per_datum)
>>>> +             indio_dev->ring->access->set_bytes_per_datum(indio_dev->ring,
>>>> +                                                          d_size);
>>>> +
>>>> +     ret = ad5933_reset(st);
>>>> +     if (ret<   0)
>>>> +             return ret;
>>>> +
>>>> +     ret = ad5933_cmd(st, AD5933_CTRL_STANDBY);
>>>> +     if (ret<   0)
>>>> +             return ret;
>>>> +
>>>> +     ret = ad5933_cmd(st, AD5933_CTRL_INIT_START_FREQ);
>>>> +     if (ret<   0)
>>>> +             return ret;
>>>> +
>>>> +     st->state = AD5933_CTRL_INIT_START_FREQ;
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static int ad5933_ring_postenable(struct iio_dev *indio_dev)
>>>> +{
>>>> +     struct ad5933_state *st = iio_priv(indio_dev);
>>>> +
>>>> +     /* AD5933_CTRL_INIT_START_FREQ:
>>>> +      * High Q complex circuits require a long time to reach steady state.
>>>> +      * To facilitate the measurement of such impedances, this mode allows
>>>> +      * the user full control of the settling time requirement before
>>>> +      * entering start frequency sweep mode where the impedance measurement
>>>> +      * takes place. In this mode the impedance is excited with the
>>>> +      * programmed start frequency (ad5933_ring_preenable),
>>>> +      * but no measurement takes place.
>>>> +      */
>>>> +
>>>> +     schedule_delayed_work(&st->work,
>>>> +                           msecs_to_jiffies(AD5933_INIT_EXCITATION_TIME_ms));
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static int ad5933_ring_postdisable(struct iio_dev *indio_dev)
>>>> +{
>>>> +     struct ad5933_state *st = iio_priv(indio_dev);
>>>> +
>>>> +     cancel_delayed_work_sync(&st->work);
>>>> +     return ad5933_cmd(st, AD5933_CTRL_POWER_DOWN);
>>>> +}
>>>> +
>>>> +static const struct iio_ring_setup_ops ad5933_ring_setup_ops = {
>>>> +     .preenable =&ad5933_ring_preenable,
>>>> +     .postenable =&ad5933_ring_postenable,
>>>> +     .postdisable =&ad5933_ring_postdisable,
>>>> +};
>>>> +
>>>> +static int ad5933_register_ring_funcs_and_init(struct iio_dev *indio_dev)
>>>> +{
>>>> +     indio_dev->ring = iio_sw_rb_allocate(indio_dev);
>>>> +     if (!indio_dev->ring)
>>>> +             return -ENOMEM;
>>>> +
>>>> +     /* Effectively select the ring buffer implementation */
>>>> +     indio_dev->ring->access =&ring_sw_access_funcs;
>>>> +
>>>> +     /* Ring buffer functions - here trigger setup related */
>>>> +     indio_dev->ring->setup_ops =&ad5933_ring_setup_ops;
>>>> +
>>>> +     indio_dev->modes |= INDIO_RING_HARDWARE_BUFFER;
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static void ad5933_work(struct work_struct *work)
>>>> +{
>>>> +     struct ad5933_state *st = container_of(work,
>>>> +             struct ad5933_state, work.work);
>>>> +     struct iio_dev *indio_dev = i2c_get_clientdata(st->client);
>>>> +     struct iio_ring_buffer *ring = indio_dev->ring;
>>>> +     signed short buf[2];
>>>> +     unsigned char status;
>>>> +
>>>> +     mutex_lock(&indio_dev->mlock);
>>>> +     if (st->state == AD5933_CTRL_INIT_START_FREQ) {
>>>> +             /* start sweep */
>>>> +             ad5933_cmd(st, AD5933_CTRL_START_SWEEP);
>>>> +             st->state = AD5933_CTRL_START_SWEEP;
>>>> +             schedule_delayed_work(&st->work, st->poll_time_jiffies);
>>>> +             mutex_unlock(&indio_dev->mlock);
>>>> +             return;
>>>> +     }
>>>> +
>>>> +     ad5933_i2c_read(st->client, AD5933_REG_STATUS, 1,&status);
>>>> +
>>>> +     if (status&   AD5933_STAT_DATA_VALID) {
>>>> +             ad5933_i2c_read(st->client,
>>> This will fall foul of the change to bitmap for these, but I'll fix that
>>> up if this goes in first.
>>>
>>>> +                             (ring->scan_mask&   (1<<   0)) ?
>>>> +                             AD5933_REG_REAL_DATA : AD5933_REG_IMAG_DATA,
>>>> +                             ring->scan_count * 2, (u8 *)buf);
>>>> +
>>>> +             if (ring->scan_count == 2) {
>>>> +                     buf[0] = be16_to_cpu(buf[0]);
>>>> +                     buf[1] = be16_to_cpu(buf[1]);
>>>> +             } else {
>>>> +                     buf[0] = be16_to_cpu(buf[0]);
>>>> +             }
>>>> +             /* save datum to the ring */
>>>> +             ring->access->store_to(ring, (u8 *)buf, iio_get_time_ns());
>>>> +     } else {
>>>> +             /* no data available - try again later */
>>>> +             schedule_delayed_work(&st->work, st->poll_time_jiffies);
>>>> +             mutex_unlock(&indio_dev->mlock);
>>>> +             return;
>>>> +     }
>>>> +
>>>> +     if (status&   AD5933_STAT_SWEEP_DONE) {
>>>> +             /* last sample received - power down do nothing until
>>>> +              * the ring enable is toggled */
>>>> +             ad5933_cmd(st, AD5933_CTRL_POWER_DOWN);
>>>> +     } else {
>>>> +             /* we just received a valid datum, move on to the next */
>>>> +             ad5933_cmd(st, AD5933_CTRL_INC_FREQ);
>>> Use st->poll_time_jiffies?  If not, please comment why not.
>> Good catch.
>>>> +             schedule_delayed_work(&st->work, msecs_to_jiffies(10));
>>>> +     }
>>>> +
>>>> +     mutex_unlock(&indio_dev->mlock);
>>>> +}
>>>> +
>>>> +static int __devinit ad5933_probe(struct i2c_client *client,
>>>> +                                const struct i2c_device_id *id)
>>>> +{
>>>> +     int ret, regdone = 0, voltage_uv = 0;
>>>> +     struct ad5933_platform_data *pdata = client->dev.platform_data;
>>>> +     struct ad5933_state *st;
>>>> +     struct iio_dev *indio_dev = iio_allocate_device(sizeof(*st));
>>>> +     if (indio_dev == NULL)
>>>> +             return -ENOMEM;
>>>> +
>>>> +     st = iio_priv(indio_dev);
>>>> +     i2c_set_clientdata(client, indio_dev);
>>>> +     st->client = client;
>>>> +
>>>> +     if (!pdata)
>>>> +             st->pdata =&ad5933_default_pdata;
>>>> +     else
>>>> +             st->pdata = pdata;
>>>> +
>>>> +     st->reg = regulator_get(&client->dev, "vcc");
>>>> +     if (!IS_ERR(st->reg)) {
>>>> +             ret = regulator_enable(st->reg);
>>>> +             if (ret)
>>>> +                     goto error_put_reg;
>>>> +             voltage_uv = regulator_get_voltage(st->reg);
>>>> +     }
>>>> +
>>>> +     if (voltage_uv)
>>>> +             st->vref_mv = voltage_uv / 1000;
>>>> +     else
>>>> +             st->vref_mv = st->pdata->vref_mv;
>>>> +
>>>> +     if (st->pdata->ext_clk_Hz) {
>>>> +             st->mclk_hz = st->pdata->ext_clk_Hz;
>>>> +             st->ctrl_lb = AD5933_CTRL_EXT_SYSCLK;
>>>> +     } else {
>>>> +             st->mclk_hz = AD5933_INT_OSC_FREQ_Hz;
>>>> +             st->ctrl_lb = AD5933_CTRL_INT_SYSCLK;
>>>> +     }
>>>> +
>>>> +     ad5933_calc_out_ranges(st);
>>>> +     INIT_DELAYED_WORK(&st->work, ad5933_work);
>>>> +     st->poll_time_jiffies = msecs_to_jiffies(AD5933_POLL_TIME_ms);
>>>> +
>>>> +     indio_dev->dev.parent =&client->dev;
>>>> +     indio_dev->info =&ad5933_info;
>>>> +     indio_dev->name = id->name;
>>>> +     indio_dev->modes = INDIO_DIRECT_MODE;
>>>> +     indio_dev->channels = ad5933_channels;
>>>> +     indio_dev->num_channels = 1;
>>>> +
>>>> +     ret = ad5933_register_ring_funcs_and_init(indio_dev);
>>>> +     if (ret)
>>>> +             goto error_disable_reg;
>>>> +
>>>> +     ret = iio_device_register(indio_dev);
>>>> +     if (ret)
>>>> +             goto error_unreg_ring;
>>>> +     regdone = 1;
>>>> +
>>>> +     ret = iio_ring_buffer_register_ex(indio_dev->ring, 0,
>>>> +&ad5933_channels[1],
>>>> +                                       2);
>>>> +     if (ret)
>>>> +             goto error_unreg_ring;
>>>> +
>>>> +     /* enable both REAL and IMAG channels by default */
>>>> +     iio_scan_mask_set(indio_dev->ring, 0);
>>>> +     iio_scan_mask_set(indio_dev->ring, 1);
>>>> +
>>>> +     ret = ad5933_setup(st);
>>>> +     if (ret)
>>>> +             goto error_uninitialize_ring;
>>>> +
>>>> +     return 0;
>>>> +
>>>> +error_uninitialize_ring:
>>>> +     iio_ring_buffer_unregister(indio_dev->ring);
>>>> +error_unreg_ring:
>>>> +     iio_sw_rb_free(indio_dev->ring);
>>>> +error_disable_reg:
>>>> +     if (!IS_ERR(st->reg))
>>>> +             regulator_disable(st->reg);
>>>> +error_put_reg:
>>>> +     if (!IS_ERR(st->reg))
>>>> +             regulator_put(st->reg);
>>>> +
>>>> +     if (regdone)
>>>> +             iio_device_unregister(indio_dev);
>>>> +     else
>>>> +             iio_free_device(indio_dev);
>>>> +
>>>> +     return ret;
>>>> +}
>>>> +
>>>> +static __devexit int ad5933_remove(struct i2c_client *client)
>>>> +{
>>>> +     struct iio_dev *indio_dev = i2c_get_clientdata(client);
>>>> +     struct ad5933_state *st = iio_priv(indio_dev);
>>>> +
>>>> +     iio_ring_buffer_unregister(indio_dev->ring);
>>>> +     iio_sw_rb_free(indio_dev->ring);
>>>> +     if (!IS_ERR(st->reg)) {
>>>> +             regulator_disable(st->reg);
>>>> +             regulator_put(st->reg);
>>>> +     }
>>>> +     iio_device_unregister(indio_dev);
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static const struct i2c_device_id ad5933_id[] = {
>>>> +     { "ad5933", 0 },
>>>> +     { "ad5934", 0 },
>>>> +     {}
>>>> +};
>>>> +
>>>> +MODULE_DEVICE_TABLE(i2c, ad5933_id);
>>>> +
>>>> +static struct i2c_driver ad5933_driver = {
>>>> +     .driver = {
>>>> +             .name = "ad5933",
>>>> +     },
>>>> +     .probe = ad5933_probe,
>>>> +     .remove = __devexit_p(ad5933_remove),
>>>> +     .id_table = ad5933_id,
>>>> +};
>>>> +
>>>> +static __init int ad5933_init(void)
>>>> +{
>>>> +     return i2c_add_driver(&ad5933_driver);
>>>> +}
>>>> +module_init(ad5933_init);
>>>> +
>>>> +static __exit void ad5933_exit(void)
>>>> +{
>>>> +     i2c_del_driver(&ad5933_driver);
>>>> +}
>>>> +module_exit(ad5933_exit);
>>>> +
>>>> +MODULE_AUTHOR("Michael Hennerich<hennerich@blackfin.uclinux.org>");
>>>> +MODULE_DESCRIPTION("Analog Devices AD5933 Impedance Conv. Network Analyzer");
>>>> +MODULE_LICENSE("GPL v2");
>>>> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.h b/drivers/staging/iio/impedance-analyzer/ad5933.h
>>>> new file mode 100644
>>>> index 0000000..b140e42
>>>> --- /dev/null
>>>> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.h
>>>> @@ -0,0 +1,28 @@
>>>> +/*
>>>> + * AD5933 AD5934 Impedance Converter, Network Analyzer
>>>> + *
>>>> + * Copyright 2011 Analog Devices Inc.
>>>> + *
>>>> + * Licensed under the GPL-2.
>>>> + */
>>>> +
>>>> +#ifndef IIO_ADC_AD5933_H_
>>>> +#define IIO_ADC_AD5933_H_
>>>> +
>>>> +/*
>>>> + * TODO: struct ad5933_platform_data needs to go into include/linux/iio
>>>> + */
>>>> +
>>>> +/**
>>>> + * struct ad5933_platform_data - platform specific data
>>>> + * @ext_clk_Hz:              the external clock frequency in Hz, if not set
>>>> + *                   the driver uses the internal clock (16.776 MHz)
>>>> + * @vref_mv:         the external reference voltage in millivolt
>>>> + */
>>>> +
>>>> +struct ad5933_platform_data {
>>>> +     unsigned long                   ext_clk_Hz;
>>>> +     unsigned short                  vref_mv;
>>>> +};
>>>> +
>>>> +#endif /* IIO_ADC_AD5933_H_ */
>>
>


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
