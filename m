Return-Path: <Michael.Hennerich@analog.com>
Message-ID: <4DF21D1A.8010703@analog.com>
Date: Fri, 10 Jun 2011 15:33:14 +0200
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>, Drivers <Drivers@analog.com>
Subject: Re: [PATCH 2/2] iio: dac: New driver for AD5686R, AD5685R, AD5684R
 Digital to analog converters
References: <1307706541-4750-1-git-send-email-michael.hennerich@analog.com> <1307706541-4750-2-git-send-email-michael.hennerich@analog.com> <4DF218F1.3090602@cam.ac.uk>
In-Reply-To: <4DF218F1.3090602@cam.ac.uk>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 06/10/2011 03:15 PM, Jonathan Cameron wrote:
> On 06/10/11 12:49, michael.hennerich@analog.com wrote:
>> From: Michael Hennerich<michael.hennerich@analog.com>
>>
>> New driver for AD5686R, AD5685R, AD5684R Quad channel digital to analog converters
> Nice driver.  Comments inline. All trivial and none particularly bother me, so feel
> free to do what ever subset you like and then add the Ack below.  The reordering
> is pretty obvious, so I'd advise doing and testing that one before someone else
> proposes it as a fix.
>
> I don't think this  driver depends on anything in the updates I have queued,
> so feel free to send to Greg when ever you like.
>> Signed-off-by: Michael Hennerich<michael.hennerich@analog.com>
> Acked-by: Jonathan Cameron<jic23@cam.ac.uk>
>> ---
>>   drivers/staging/iio/dac/Kconfig  |   11 +
>>   drivers/staging/iio/dac/Makefile |    1 +
>>   drivers/staging/iio/dac/ad5686.c |  419 ++++++++++++++++++++++++++++++++++++++
>>   drivers/staging/iio/dac/ad5686.h |   88 ++++++++
>>   4 files changed, 519 insertions(+), 0 deletions(-)
>>   create mode 100644 drivers/staging/iio/dac/ad5686.c
>>   create mode 100644 drivers/staging/iio/dac/ad5686.h
>>
>> diff --git a/drivers/staging/iio/dac/Kconfig b/drivers/staging/iio/dac/Kconfig
>> index d5a5556..7ddae35 100644
>> --- a/drivers/staging/iio/dac/Kconfig
>> +++ b/drivers/staging/iio/dac/Kconfig
>> @@ -42,6 +42,17 @@ config AD5791
>>          To compile this driver as a module, choose M here: the
>>          module will be called ad5791.
>>
>> +config AD5686
>> +     tristate "Analog Devices AD5686R/AD5685R/AD5684R DAC SPI driver"
>> +     depends on SPI
>> +     help
>> +       Say yes here to build support for Analog Devices AD5686R, AD5685R,
>> +       AD5684R, AD5791 Voltage Output Digital to
>> +       Analog Converter.
>> +
>> +       To compile this driver as a module, choose M here: the
>> +       module will be called ad5686.
>> +
>>   config MAX517
>>        tristate "Maxim MAX517/518/519 DAC driver"
>>        depends on I2C&&  EXPERIMENTAL
>> diff --git a/drivers/staging/iio/dac/Makefile b/drivers/staging/iio/dac/Makefile
>> index 83196de..7f4f2ed 100644
>> --- a/drivers/staging/iio/dac/Makefile
>> +++ b/drivers/staging/iio/dac/Makefile
>> @@ -6,4 +6,5 @@ obj-$(CONFIG_AD5624R_SPI) += ad5624r_spi.o
>>   obj-$(CONFIG_AD5504) += ad5504.o
>>   obj-$(CONFIG_AD5446) += ad5446.o
>>   obj-$(CONFIG_AD5791) += ad5791.o
>> +obj-$(CONFIG_AD5686) += ad5686.o
>>   obj-$(CONFIG_MAX517) += max517.o
>> diff --git a/drivers/staging/iio/dac/ad5686.c b/drivers/staging/iio/dac/ad5686.c
>> new file mode 100644
>> index 0000000..f155ba2
>> --- /dev/null
>> +++ b/drivers/staging/iio/dac/ad5686.c
>> @@ -0,0 +1,419 @@
>> +/*
>> + * AD5686R, AD5685R, AD5684R Digital to analog converters  driver
>> + *
>> + * Copyright 2011 Analog Devices Inc.
>> + *
>> + * Licensed under the GPL-2.
>> + */
>> +
>> +#include<linux/interrupt.h>
>> +#include<linux/gpio.h>
>> +#include<linux/fs.h>
>> +#include<linux/device.h>
>> +#include<linux/kernel.h>
>> +#include<linux/spi/spi.h>
>> +#include<linux/slab.h>
>> +#include<linux/sysfs.h>
>> +#include<linux/regulator/consumer.h>
>> +
>> +#include "../iio.h"
>> +#include "../sysfs.h"
>> +#include "dac.h"
>> +#include "ad5686.h"
>> +
>> +static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
>> +     [ID_AD5684] = {
>> +             .channel[0] = IIO_CHAN(IIO_OUT, 0, 1, 0, NULL, 0, 0,
>> +                                 (1<<  IIO_CHAN_INFO_SCALE_SHARED),
>> +                                 AD5686_ADDR_DAC0,
>> +                                 0, IIO_ST('u', 12, 16, 4), 0),
>> +             .channel[1] = IIO_CHAN(IIO_OUT, 0, 1, 0, NULL, 1, 0,
>> +                                 (1<<  IIO_CHAN_INFO_SCALE_SHARED),
>> +                                 AD5686_ADDR_DAC1,
>> +                                 1, IIO_ST('u', 12, 16, 4), 0),
>> +             .channel[2] = IIO_CHAN(IIO_OUT, 0, 1, 0, NULL, 2, 0,
>> +                                 (1<<  IIO_CHAN_INFO_SCALE_SHARED),
>> +                                 AD5686_ADDR_DAC2,
>> +                                 2, IIO_ST('u', 12, 16, 4), 0),
>> +             .channel[3] = IIO_CHAN(IIO_OUT, 0, 1, 0, NULL, 3, 0,
>> +                                 (1<<  IIO_CHAN_INFO_SCALE_SHARED),
>> +                                 AD5686_ADDR_DAC3,
>> +                                 3, IIO_ST('u', 12, 16, 4), 0),
>> +             .int_vref_mv = 2500,
>> +     },
>> +     [ID_AD5685] = {
>> +             .channel[0] = IIO_CHAN(IIO_OUT, 0, 1, 0, NULL, 0, 0,
>> +                                 (1<<  IIO_CHAN_INFO_SCALE_SHARED),
>> +                                 AD5686_ADDR_DAC0,
>> +                                 0, IIO_ST('u', 14, 16, 2), 0),
>> +             .channel[1] = IIO_CHAN(IIO_OUT, 0, 1, 0, NULL, 1, 0,
>> +                                 (1<<  IIO_CHAN_INFO_SCALE_SHARED),
>> +                                 AD5686_ADDR_DAC1,
>> +                                 1, IIO_ST('u', 14, 16, 2), 0),
>> +             .channel[2] = IIO_CHAN(IIO_OUT, 0, 1, 0, NULL, 2, 0,
>> +                                 (1<<  IIO_CHAN_INFO_SCALE_SHARED),
>> +                                 AD5686_ADDR_DAC2,
>> +                                 2, IIO_ST('u', 14, 16, 2), 0),
>> +             .channel[3] = IIO_CHAN(IIO_OUT, 0, 1, 0, NULL, 3, 0,
>> +                                 (1<<  IIO_CHAN_INFO_SCALE_SHARED),
>> +                                 AD5686_ADDR_DAC3,
>> +                                 3, IIO_ST('u', 14, 16, 2), 0),
>> +             .int_vref_mv = 2500,
>> +     },
>> +     [ID_AD5686] = {
>> +             .channel[0] = IIO_CHAN(IIO_OUT, 0, 1, 0, NULL, 0, 0,
>> +                                 (1<<  IIO_CHAN_INFO_SCALE_SHARED),
>> +                                 AD5686_ADDR_DAC0,
>> +                                 0, IIO_ST('u', 16, 16, 0), 0),
>> +             .channel[1] = IIO_CHAN(IIO_OUT, 0, 1, 0, NULL, 1, 0,
>> +                                 (1<<  IIO_CHAN_INFO_SCALE_SHARED),
>> +                                 AD5686_ADDR_DAC1,
>> +                                 1, IIO_ST('u', 16, 16, 0), 0),
>> +             .channel[2] = IIO_CHAN(IIO_OUT, 0, 1, 0, NULL, 2, 0,
>> +                                 (1<<  IIO_CHAN_INFO_SCALE_SHARED),
>> +                                 AD5686_ADDR_DAC2,
>> +                                 2, IIO_ST('u', 16, 16, 0), 0),
>> +             .channel[3] = IIO_CHAN(IIO_OUT, 0, 1, 0, NULL, 3, 0,
>> +                                 (1<<  IIO_CHAN_INFO_SCALE_SHARED),
>> +                                 AD5686_ADDR_DAC3,
>> +                                 3, IIO_ST('u', 16, 16, 0), 0),
>> +             .int_vref_mv = 2500,
>> +     },
>> +};
>> +
>> +static int ad5686_spi_write(struct ad5686_state *st,
>> +                          u8 cmd, u8 addr, u16 val, u8 shift)
>> +{
>> +     val<<= shift;
>> +
>> +     st->data[0].d32 = cpu_to_be32(AD5686_CMD(cmd) |
>> +                           AD5686_ADDR(addr) |
>> +                           val);
>> +
>> +     return spi_write(st->spi,&st->data[0].d8[1], 3);
>> +}
>> +
>> +static int ad5686_spi_read(struct ad5686_state *st, u8 addr)
>> +{
>> +     struct spi_transfer t[] = {
>> +             {
>> +                     .tx_buf =&st->data[0].d8[1],
>> +                     .len = 3,
>> +                     .cs_change = 1,
>> +             }, {
>> +                     .tx_buf =&st->data[1].d8[1],
>> +                     .rx_buf =&st->data[2].d8[1],
>> +                     .len = 3,
>> +             },
>> +     };
>> +     struct spi_message m;
>> +     int ret;
>> +
>> +     spi_message_init(&m);
>> +     spi_message_add_tail(&t[0],&m);
>> +     spi_message_add_tail(&t[1],&m);
>> +
>> +     st->data[0].d32 = cpu_to_be32(AD5686_CMD(AD5686_CMD_READBACK_ENABLE) |
>> +                           AD5686_ADDR(addr));
>> +     st->data[1].d32 = cpu_to_be32(AD5686_CMD(AD5686_CMD_NOOP));
>> +
>> +     ret = spi_sync(st->spi,&m);
>> +     if (ret<  0)
>> +             return ret;
>> +
>> +     return be32_to_cpu(st->data[2].d32);
>> +}
>> +
>> +static ssize_t ad5686_read_powerdown_mode(struct device *dev,
>> +                                   struct device_attribute *attr, char *buf)
>> +{
>> +     struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +     struct ad5686_state *st = iio_priv(indio_dev);
>> +     struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>> +
>> +     char mode[][15] = {"", "1kohm_to_gnd", "100kohm_to_gnd", "three_state"};
>> +
>> +     return sprintf(buf, "%s\n", mode[(st->pwr_down_mode>>
>> +                                      (this_attr->address * 2))&  0x3]);
>> +}
>> +
>> +static ssize_t ad5686_write_powerdown_mode(struct device *dev,
>> +                                    struct device_attribute *attr,
>> +                                    const char *buf, size_t len)
>> +{
>> +     struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +     struct ad5686_state *st = iio_priv(indio_dev);
>> +     struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>> +     unsigned mode;
>> +
>> +     if (sysfs_streq(buf, "1kohm_to_gnd"))
>> +             mode = AD5686_LDAC_PWRDN_1K;
>> +     else if (sysfs_streq(buf, "100kohm_to_gnd"))
>> +             mode = AD5686_LDAC_PWRDN_100K;
>> +     else if (sysfs_streq(buf, "three_state"))
>> +             mode = AD5686_LDAC_PWRDN_3STATE;
>> +     else
>> +             return  -EINVAL;
>> +
>> +     st->pwr_down_mode&= ~(0x3<<  (this_attr->address * 2));
>> +     st->pwr_down_mode |= (mode<<  (this_attr->address * 2));
>> +
>> +     return len;
>> +}
>> +
>> +static ssize_t ad5686_read_dac_powerdown(struct device *dev,
>> +                                        struct device_attribute *attr,
>> +                                        char *buf)
>> +{
>> +     struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +     struct ad5686_state *st = iio_priv(indio_dev);
>> +     struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>> +
>> +     return sprintf(buf, "%d\n", !!(st->pwr_down_mask&
>> +                     (0x3<<  (this_attr->address * 2))));
>> +}
>> +
>> +static ssize_t ad5686_write_dac_powerdown(struct device *dev,
>> +                                         struct device_attribute *attr,
>> +                                         const char *buf, size_t len)
>> +{
>> +     long readin;
>> +     int ret;
>> +     struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +     struct ad5686_state *st = iio_priv(indio_dev);
>> +     struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>> +
> strtobool perhaps? Seems reasonable to write Y to power down the device as well
> for example.
That must be a new function. I never saw it before.
Good match here.

>> +     ret = strict_strtol(buf, 10,&readin);
>> +     if (ret)
>> +             return ret;
>> +
>> +     if (readin == 1)
>> +             st->pwr_down_mask |= (0x3<<  (this_attr->address * 2));
>> +     else if (!readin)
>> +             st->pwr_down_mask&= ~(0x3<<  (this_attr->address * 2));
>> +     else
>> +             ret = -EINVAL;
>> +
>> +     ret = ad5686_spi_write(st, AD5686_CMD_POWERDOWN_DAC, 0,
>> +                            st->pwr_down_mask&  st->pwr_down_mode, 0);
>> +
>> +     return ret ? ret : len;
>> +}
>> +
>> +static IIO_CONST_ATTR(out_powerdown_mode_available,
>> +                     "1kohm_to_gnd 100kohm_to_gnd three_state");
>> +
>> +#define IIO_DEV_ATTR_DAC_POWERDOWN_MODE(_num, _addr) \
>> +     IIO_DEVICE_ATTR(out##_num##_powerdown_mode, S_IRUGO | S_IWUSR,  \
>> +                     ad5686_read_powerdown_mode,                     \
>> +                     ad5686_write_powerdown_mode, _addr)
>> +
> I hate to point out the obvious, but why give it two parameters if they
> are always the same?  Might be a clarity arguement I suppose, but I'm
> not convinced.
Well _num and  _addr doesn't need to be the same. Originally I used
the AD5686 addresses which actually differ, but later decided to use the 
number for both.
I'll fix it up.

>> +static IIO_DEV_ATTR_DAC_POWERDOWN_MODE(0, 0);
>> +static IIO_DEV_ATTR_DAC_POWERDOWN_MODE(1, 1);
>> +static IIO_DEV_ATTR_DAC_POWERDOWN_MODE(2, 2);
>> +static IIO_DEV_ATTR_DAC_POWERDOWN_MODE(3, 3);
>> +
> same here...
>> +#define IIO_DEV_ATTR_DAC_POWERDOWN(_num, _addr)      \
>> +     IIO_DEVICE_ATTR(out##_num##_powerdown, S_IRUGO | S_IWUSR,       \
>> +                     ad5686_read_dac_powerdown,                      \
>> +                     ad5686_write_dac_powerdown, _addr)
>> +
>> +static IIO_DEV_ATTR_DAC_POWERDOWN(0, 0);
>> +static IIO_DEV_ATTR_DAC_POWERDOWN(1, 1);
>> +static IIO_DEV_ATTR_DAC_POWERDOWN(2, 2);
>> +static IIO_DEV_ATTR_DAC_POWERDOWN(3, 3);
>> +
>> +static struct attribute *ad5686_attributes[] = {
>> +&iio_dev_attr_out0_powerdown.dev_attr.attr,
>> +&iio_dev_attr_out1_powerdown.dev_attr.attr,
>> +&iio_dev_attr_out2_powerdown.dev_attr.attr,
>> +&iio_dev_attr_out3_powerdown.dev_attr.attr,
>> +&iio_dev_attr_out0_powerdown_mode.dev_attr.attr,
>> +&iio_dev_attr_out1_powerdown_mode.dev_attr.attr,
>> +&iio_dev_attr_out2_powerdown_mode.dev_attr.attr,
>> +&iio_dev_attr_out3_powerdown_mode.dev_attr.attr,
>> +&iio_const_attr_out_powerdown_mode_available.dev_attr.attr,
>> +     NULL,
>> +};
>> +
>> +static const struct attribute_group ad5686_attribute_group = {
>> +     .attrs = ad5686_attributes,
>> +};
>> +
>> +static int ad5686_read_raw(struct iio_dev *indio_dev,
>> +                        struct iio_chan_spec const *chan,
>> +                        int *val,
>> +                        int *val2,
>> +                        long m)
>> +{
>> +     struct ad5686_state *st = iio_priv(indio_dev);
>> +     unsigned long scale_uv;
>> +     int ret;
>> +
>> +     switch (m) {
>> +     case 0:
>> +             mutex_lock(&indio_dev->mlock);
>> +             ret = ad5686_spi_read(st, chan->address);
>> +             mutex_unlock(&indio_dev->mlock);
>> +             if (ret<  0)
>> +                     return ret;
>> +             *val = ret;
>> +             return IIO_VAL_INT;
>> +             break;
>> +     case (1<<  IIO_CHAN_INFO_SCALE_SHARED):
>> +             scale_uv = (st->vref_mv * 100000)
>> +>>  (chan->scan_type.realbits);
>> +             *val =  scale_uv / 100000;
>> +             *val2 = (scale_uv % 100000) * 10;
>> +             return IIO_VAL_INT_PLUS_MICRO;
>> +
>> +     }
>> +     return -EINVAL;
>> +}
>> +
>> +static int ad5686_write_raw(struct iio_dev *indio_dev,
>> +                            struct iio_chan_spec const *chan,
>> +                            int val,
>> +                            int val2,
>> +                            long mask)
>> +{
>> +     struct ad5686_state *st = iio_priv(indio_dev);
>> +     int ret;
>> +
>> +     switch (mask) {
>> +     case 0:
>> +             if (val>  (1<<  chan->scan_type.realbits))
>> +                     return -EINVAL;
>> +
>> +             mutex_lock(&indio_dev->mlock);
>> +             ret = ad5686_spi_write(st,
>> +                              AD5686_CMD_WRITE_INPUT_N_UPDATE_N,
>> +                              chan->address,
>> +                              val,
>> +                              chan->scan_type.shift);
>> +             mutex_unlock(&indio_dev->mlock);
>> +             break;
>> +     default:
>> +             ret = -EINVAL;
>> +     }
>> +
>> +     return ret;
>> +}
>> +
>> +static const struct iio_info ad5686_info = {
>> +     .read_raw = ad5686_read_raw,
>> +     .write_raw = ad5686_write_raw,
>> +     .attrs =&ad5686_attribute_group,
>> +     .driver_module = THIS_MODULE,
>> +};
>> +
>> +static int __devinit ad5686_probe(struct spi_device *spi)
>> +{
>> +     struct ad5686_state *st;
>> +     struct iio_dev *indio_dev;
>> +     struct regulator *reg;
>> +     int ret, voltage_uv = 0;
>> +
> Here I'd argue you might as well reorder this to
> get the reg after the allocation. That cleans up
> both this and removal a bit. I didn't want to
> do it on old drivers so as to keep the code changes
> minimal, but in a new driver like this I can't see
> any reason not to.
>
ok
>> +     reg = regulator_get(&spi->dev, "vcc");
>> +     if (!IS_ERR(reg)) {
>> +             ret = regulator_enable(reg);
>> +             if (ret)
>> +                     goto error_put_reg;
>> +
>> +             voltage_uv = regulator_get_voltage(reg);
>> +     }
>> +     indio_dev = iio_allocate_device(sizeof(*st));
>> +     if (indio_dev == NULL) {
>> +             ret = -ENOMEM;
>> +             goto error_disable_reg;
>> +     }
>> +     st = iio_priv(indio_dev);
>> +     st->reg = reg;
>> +     spi_set_drvdata(spi, indio_dev);
>> +     st->chip_info =
>> +&ad5686_chip_info_tbl[spi_get_device_id(spi)->driver_data];
>> +
>> +     if (voltage_uv)
>> +             st->vref_mv = voltage_uv / 1000;
>> +     else
>> +             st->vref_mv = st->chip_info->int_vref_mv;
>> +
>> +     st->spi = spi;
>> +
>> +     indio_dev->dev.parent =&spi->dev;
>> +     indio_dev->name = spi_get_device_id(spi)->name;
>> +     indio_dev->info =&ad5686_info;
>> +     indio_dev->modes = INDIO_DIRECT_MODE;
>> +     indio_dev->channels = st->chip_info->channel;
>> +     indio_dev->num_channels = AD5686_DAC_CHANNELS;
>> +
>> +     ret = iio_device_register(indio_dev);
>> +     if (ret)
>> +             goto error_free_dev;
>> +
>> +     ret = ad5686_spi_write(st, AD5686_CMD_INTERNAL_REFER_SETUP, 0,
>> +                             !!voltage_uv, 0);
>> +     if (ret)
>> +             goto error_free_dev;
>> +
>> +     return 0;
>> +
>> +error_free_dev:
>> +     iio_free_device(indio_dev);
>> +error_disable_reg:
>> +     if (!IS_ERR(reg))
>> +             regulator_disable(st->reg);
>> +error_put_reg:
>> +     if (!IS_ERR(reg))
>> +             regulator_put(reg);
>> +
>> +     return ret;
>> +}
>> +
>> +static int __devexit ad5686_remove(struct spi_device *spi)
>> +{
>> +     struct iio_dev *indio_dev = spi_get_drvdata(spi);
>> +     struct ad5686_state *st = iio_priv(indio_dev);
>> +     struct regulator *reg = st->reg;
>> +
>> +     iio_device_unregister(indio_dev);
>> +     if (!IS_ERR(reg)) {
>> +             regulator_disable(reg);
>> +             regulator_put(reg);
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static const struct spi_device_id ad5686_id[] = {
>> +     {"ad5684", ID_AD5684},
>> +     {"ad5685", ID_AD5685},
>> +     {"ad5686", ID_AD5686},
>> +     {}
>> +};
>> +
>> +static struct spi_driver ad5686_driver = {
>> +     .driver = {
>> +                .name = "ad5686",
>> +                .owner = THIS_MODULE,
>> +                },
>> +     .probe = ad5686_probe,
>> +     .remove = __devexit_p(ad5686_remove),
>> +     .id_table = ad5686_id,
>> +};
>> +
>> +static __init int ad5686_spi_init(void)
>> +{
>> +     return spi_register_driver(&ad5686_driver);
>> +}
>> +module_init(ad5686_spi_init);
>> +
>> +static __exit void ad5686_spi_exit(void)
>> +{
>> +     spi_unregister_driver(&ad5686_driver);
>> +}
>> +module_exit(ad5686_spi_exit);
>> +
>> +MODULE_AUTHOR("Michael Hennerich<hennerich@blackfin.uclinux.org>");
>> +MODULE_DESCRIPTION("Analog Devices AD5686/85/84 DAC");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/staging/iio/dac/ad5686.h b/drivers/staging/iio/dac/ad5686.h
>> new file mode 100644
>> index 0000000..a22acee
>> --- /dev/null
>> +++ b/drivers/staging/iio/dac/ad5686.h
>> @@ -0,0 +1,88 @@
>> +/*
>> + * AD5686R, AD5685R, AD56684R Digital to analog convertors spi driver
>> + *
>> + * Copyright 2011 Analog Devices Inc.
>> + *
>> + * Licensed under the GPL-2.
>> + */
>> +#ifndef SPI_AD5684_H_
>> +#define SPI_AD5684_H_
> Hmm.. I wonder if it's worth having this header at all.  Could just
> push it down into the c file instead which would be neater.
ok
>> +
>> +#define AD5686_DAC_CHANNELS                  4
>> +
>> +#define AD5686_ADDR(x)                               ((x)<<  16)
>> +#define AD5686_CMD(x)                                ((x)<<  20)
>> +
>> +#define AD5686_ADDR_DAC0                     0x1
>> +#define AD5686_ADDR_DAC1                     0x2
>> +#define AD5686_ADDR_DAC2                     0x4
>> +#define AD5686_ADDR_DAC3                     0x8
>> +#define AD5686_ADDR_ALL_DAC                  0xF
>> +
>> +#define AD5686_CMD_NOOP                              0x0
>> +#define AD5686_CMD_WRITE_INPUT_N             0x1
>> +#define AD5686_CMD_UPDATE_DAC_N                      0x2
>> +#define AD5686_CMD_WRITE_INPUT_N_UPDATE_N    0x3
>> +#define AD5686_CMD_POWERDOWN_DAC             0x4
>> +#define AD5686_CMD_LDAC_MASK                 0x5
>> +#define AD5686_CMD_RESET                     0x6
>> +#define AD5686_CMD_INTERNAL_REFER_SETUP              0x7
>> +#define AD5686_CMD_DAISY_CHAIN_ENABLE                0x8
>> +#define AD5686_CMD_READBACK_ENABLE           0x9
>> +
>> +#define AD5686_LDAC_PWRDN_NONE                       0x0
>> +#define AD5686_LDAC_PWRDN_1K                 0x1
>> +#define AD5686_LDAC_PWRDN_100K                       0x2
>> +#define AD5686_LDAC_PWRDN_3STATE             0x3
>> +
>> +/**
>> + * struct ad5686_chip_info - chip specific information
>> + * @int_vref_mv:     AD5620/40/60: the internal reference voltage
> silly question, but do you have chips to add where this actually varies?
There might be ones in future.

>> + * @channel:         channel specification
>> +*/
>> +
>> +struct ad5686_chip_info {
>> +     u16                             int_vref_mv;
>> +     struct iio_chan_spec            channel[AD5686_DAC_CHANNELS];
>> +};
>> +
>> +/**
>> + * struct ad5446_state - driver instance specific data
>> + * @spi:             spi_device
>> + * @chip_info:               chip model specific constants, available modes etc
>> + * @reg:             supply regulator
>> + * @vref_mv:         actual reference voltage used
>> + * @pwr_down_mask:   power down mask
>> + * @pwr_down_mode:   current power down mode
>> + * @data:            spi transfer buffers
>> + */
>> +
>> +struct ad5686_state {
>> +     struct spi_device               *spi;
>> +     const struct ad5686_chip_info   *chip_info;
>> +     struct regulator                *reg;
>> +     unsigned short                  vref_mv;
>> +     unsigned                        pwr_down_mask;
>> +     unsigned                        pwr_down_mode;
>> +     /*
>> +      * DMA (thus cache coherency maintenance) requires the
>> +      * transfer buffers to live in their own cache lines.
>> +      */
>> +
>> +     union {
>> +             u32 d32;
>> +             u8 d8[4];
>> +     } data[3] ____cacheline_aligned;
>> +};
>> +
>> +/**
>> + * ad5686_supported_device_ids:
>> + */
>> +
>> +enum ad5686_supported_device_ids {
>> +     ID_AD5684,
>> +     ID_AD5685,
>> +     ID_AD5686,
>> +};
>> +
>> +#endif /* SPI_AD5684_H_ */
Thanks for the review!
Best regards,
Michael

> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
