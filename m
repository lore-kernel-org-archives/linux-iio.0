Return-Path: <SRS0=jE2t=M3=rockwellcollins.com=paresh.chaudhary@kernel.org>
MIME-Version: 1.0
References: <1539275890-38141-1-git-send-email-matthew.weber@rockwellcollins.com>
 <20181013145143.16530539@archlinux>
In-Reply-To: <20181013145143.16530539@archlinux>
From: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
Date: Mon, 15 Oct 2018 17:27:19 -0500
Message-ID: <CAGSBOwasb2jd2TEy9h5=PsB9OKZY_t_LO-JcvQB+_i1K+MCB9g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio:temperature: Add MAX31856 thermocouple support
To: jic23@kernel.org
Cc: Matthew Weber <matthew.weber@rockwellcollins.com>, linux-iio@vger.kernel.org,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Content-Type: multipart/alternative; boundary="0000000000006c006b05784bf1ad"
List-ID: <linux-iio@vger.kernel.org>

--0000000000006c006b05784bf1ad
Content-Type: text/plain; charset="UTF-8"

Hi Jonatha,

This does not look to me like something that should be controlled in devicetree.
Normally we'd switch between oneshot and continuous modes based on some sort
of rule such as whether we are doing buffered reads vs polled ones, or perhaps
switch to oneshot if there hasn't been a reading taken for a 'while'.
(a form of runtime power management).

-> As of now, a Current driver does not have support to switch
conversion mode on runtime. I totally agree with you about runtime
power management concern.




On Sat, Oct 13, 2018 at 8:51 AM Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 11 Oct 2018 11:38:09 -0500
> Matt Weber <matthew.weber@rockwellcollins.com> wrote:
>
> > From: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
> >
> > This patch adds support for Maxim MAX31856 thermocouple
> > temperature sensor support.
> >
> > More information can be found in:
> > https://www.maximintegrated.com/en/ds/MAX31856.pdf
> >
> > NOTE: Driver support only Comparator Mode.
> >
> > Signed-off-by: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
> > Signed-off-by: Matt Weber <matthew.weber@rockwellcollins.com>
>
> Hi Matt,
>
> As others have commented, looking pretty nice.  A few minor
> comments and suggestions inline.
>
> Thanks,
>
> Jonathan
> > ---
> > Changes v1 -> v2
> > [Peter
> >       1. Fixed all space & 'return' related comments
> >       2. Removed 'sysfs_create_group' api  because
> >          iio_device_register function is handling sysfs entry
> >       3. Return -EIO if there is any fault
> >       4. Added check for 'read_size' before spi read call
> >       5. Removed license text from the source file
> >       6. Added .o file in alphabetic order
> >       7. Used #defines instead of magic bits
> >
> > ---
> >  MAINTAINERS                        |   5 +
> >  drivers/iio/temperature/Kconfig    |  10 +
> >  drivers/iio/temperature/Makefile   |   1 +
> >  drivers/iio/temperature/max31856.c | 372
> +++++++++++++++++++++++++++++++++++++
> >  4 files changed, 388 insertions(+)
> >  create mode 100644 drivers/iio/temperature/max31856.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index f642044..dd9a83d 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -7157,6 +7157,11 @@ F:     drivers/staging/iio/
> >  F:   include/linux/iio/
> >  F:   tools/iio/
> >
> > +MAX31856 IIO DRIVER
> > +M:   Matthew Weber <matthew.weber@rockwellcollins.com>
> > +S:   Maintained
> > +F:   drivers/iio/temperature/max31856.c
> > +
> >  IIO UNIT CONVERTER
> >  M:   Peter Rosin <peda@axentia.se>
> >  L:   linux-iio@vger.kernel.org
> > diff --git a/drivers/iio/temperature/Kconfig
> b/drivers/iio/temperature/Kconfig
> > index 82e4a62..c66eeb2 100644
> > --- a/drivers/iio/temperature/Kconfig
> > +++ b/drivers/iio/temperature/Kconfig
> > @@ -97,4 +97,14 @@ config TSYS02D
> >         This driver can also be built as a module. If so, the module will
> >         be called tsys02d.
> >
> > +config MAX31856
> > +     tristate "MAX31856 thermocouple sensor"
> > +     depends on SPI
> > +     help
> > +       If you say yes here you get support for MAX31856
> > +       thermocouple sensor chip connected via SPI.
> > +
> > +       This driver can also be built as a module.  If so, the module
> > +       will be called max31856.
> > +
> >  endmenu
> > diff --git a/drivers/iio/temperature/Makefile
> b/drivers/iio/temperature/Makefile
> > index 34a31db..baca477 100644
> > --- a/drivers/iio/temperature/Makefile
> > +++ b/drivers/iio/temperature/Makefile
> > @@ -5,6 +5,7 @@
> >
> >  obj-$(CONFIG_HID_SENSOR_TEMP) += hid-sensor-temperature.o
> >  obj-$(CONFIG_MAXIM_THERMOCOUPLE) += maxim_thermocouple.o
> > +obj-$(CONFIG_MAX31856) += max31856.o
> >  obj-$(CONFIG_MLX90614) += mlx90614.o
> >  obj-$(CONFIG_MLX90632) += mlx90632.o
> >  obj-$(CONFIG_TMP006) += tmp006.o
> > diff --git a/drivers/iio/temperature/max31856.c
> b/drivers/iio/temperature/max31856.c
> > new file mode 100644
> > index 0000000..b66ddb0
> > --- /dev/null
> > +++ b/drivers/iio/temperature/max31856.c
> > @@ -0,0 +1,372 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* max31856.c
> > + *
> > + * Maxim MAX31856 thermocouple sensor driver
> > + *
> > + * Copyright (C) 2018 Rockwell Collins
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/err.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +
> > +#define MAX31856_READ_MODE      0x7F
> > +#define MAX31856_WRITE_MODE     0x80
> > +#define MAX31856_CR0_AUTOCONVERT   0x80
> > +#define MAX31856_CR0_1SHOT         0x40
> > +#define MAX31856_CR0_OCFAULT1      0x20
> > +#define MAX31856_CR0_OCFAULT0      0x10
> > +#define MAX31856_FAULT_OVUV        0x02
> > +#define MAX31856_FAULT_OPEN        0x01
> > +
> > +/* The MAX31856 registers */
> > +#define MAX31856_CR0_REG           0x00
> > +#define MAX31856_CR1_REG           0x01
> > +#define MAX31856_MASK_REG          0x02
> > +#define MAX31856_CJHF_REG          0x03
> > +#define MAX31856_CJLF_REG          0x04
> > +#define MAX31856_LTHFTH_REG        0x05
> > +#define MAX31856_LTHFTL_REG        0x06
> > +#define MAX31856_LTLFTH_REG        0x07
> > +#define MAX31856_LTLFTL_REG        0x08
> > +#define MAX31856_CJTO_REG          0x09
> > +#define MAX31856_CJTH_REG          0x0A
> > +#define MAX31856_CJTL_REG          0x0B
> > +#define MAX31856_LTCBH_REG         0x0C
> > +#define MAX31856_LTCBM_REG         0x0D
> > +#define MAX31856_LTCBL_REG         0x0E
> > +#define MAX31856_SR_REG            0x0F
> > +
> > +static const struct iio_chan_spec max31856_channels[] = {
> > +     {       /* Thermocouple Temperature */
> > +             .type = IIO_TEMP,
> > +             .address = 2,
> > +             .info_mask_separate =
> > +                     BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> > +     },
> > +     {       /* Cold Junction Temperature */
> > +             .type = IIO_TEMP,
> > +             .channel2 = IIO_MOD_TEMP_AMBIENT,
> > +             .address = 0,
> > +             .modified = 1,
> > +             .info_mask_separate =
> > +                     BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> > +     },
> > +};
> > +
> > +struct max31856_data {
> > +     struct spi_device *spi;
> > +     bool one_shot;
> > +     u32 thermocouple_type;
> > +     int fault_ovuv;
> Mentioned below but these should be booleans to make it implicit that they
> are only true or false.
> > +     int fault_oc;
> > +     u8 buf[3] ____cacheline_aligned;
> > +};
> > +
> > +static int max31856_read(struct max31856_data *data, unsigned int reg,
> > +                      s32 *val, int read_size)
>
> I think we would be better off having this function deal with val
> as a byte array (so a set of register values) and move the endian
> conversion that is in here to the calling locations.  I think that would
> be somewhat less confusing than doing in here.
>
> I don't think you do any 2 byte reads for example yet we support
> in here as it would look odd otherwise.  Move that to the calling locations
> and there will only be support if it is needed in future.
>
> > +{
> > +     int ret;
> > +     u8 *buf = data->buf;
> > +
> > +     /* Make sure top bit is not set,
> /*
>  * Make...
>
> > +      * The MSB(A7) of this byte determines whether the following byte
> will
> > +      * be written or read. If A7 is 0, one or more byte reads will
> follow
> > +      * the address byte
> > +      */
> > +
> > +     reg &= MAX31856_READ_MODE;
> This feels a little to paranoid as the only way that top bit can be set is
> (I think) a bug.
>
> > +
> > +     buf[0] = reg;
> > +     buf[1] = 0x00;
> > +     buf[2] = 0x00;
> > +
> > +     if (read_size > 3) {
> > +             pr_err("error: Unsupported read_size = %d by %s\n",
> > +                     read_size,  __func__);
> > +             return -EINVAL;
> > +     }
> > +
> > +     ret = spi_write_then_read(data->spi, buf, 1, buf, read_size);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     switch (read_size) {
> > +     case 1:
> > +             *val = buf[0];
> > +             return 0;
> > +     case 2:
> > +             *val = (buf[0] << 8) | buf[1];
> > +             return 0;
> Endian conversion function preferred (sometimes there is nothing to do!)
>
> > +     case 3:
> > +             *val = (buf[0] << 16) | (buf[1] << 8) | buf[2];
> > +             return 0;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static int max31856_write(struct max31856_data *data, unsigned int reg,
> > +                       unsigned int val)
> > +{
> > +     u8 *buf = data->buf;
> > +
> > +     /* Make sure top bit is set,
> > +      * The MSB(A7) of this byte determines whether the following byte
> will
> > +      * be written or read. If A7 is 1, one or more byte writes will
> follow
> > +      * the address byte
> > +      */
> > +
> > +     reg |= MAX31856_WRITE_MODE;
> > +
> > +     buf[0] = reg;
> I would roll the two lines above into one.  Separating them doesn't add
> anything
> to readability to my mind.
>
> > +     buf[1] = val;
> > +
> > +     return spi_write(data->spi, buf, 2);
> > +}
> > +
> > +static int max31856_init(struct max31856_data *data)
> > +{
> > +     int ret = 0;
> Already commented on by others I think... no need to assign.
> > +     s32 reg_val;
> > +
> > +     /* Enable Open circuit fault detection [01]
> > +      * Read datasheet for more information: Table 4.
> > +      * BITS [5:4]    | Fault Test
> > +      * ---------------------------
> > +      *      00    | Disabled
> > +      * ---------------------------
> > +      *      01    | Enabled (Once every 16 seconds)
> > +      * ---------------------------
> > +      *      10    | Enabled (Once every 16 seconds)
> > +      * ---------------------------
> > +      *      11    | Enabled (Once every 16 seconds)
> > +      */
> > +     ret = max31856_read(data, MAX31856_CR0_REG, &reg_val, 1);
> > +     if (ret)
> > +             return ret;
> > +     reg_val &= ~MAX31856_CR0_OCFAULT1;
> > +     reg_val |= MAX31856_CR0_OCFAULT0;
> This is perhaps not the clearest way of doing this.
>
> I would mask and then set to the two bit value.
>
> > +     ret = max31856_write(data, MAX31856_CR0_REG, reg_val);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* Set thermocouple type based on dts property */
> > +     ret = max31856_read(data, MAX31856_CR1_REG, &reg_val, 1);
> > +     if (ret)
> > +             return ret;
> > +
> > +     reg_val &= 0x00F0;
> Preferred if masks etc are handled via a define.  Also use GENMASK
> to make it easy to read which bits are being masked.  I think
> this is also an 8 bit value.  Better to handle it as such and
> treat that mask as a negated form of the the mask for the bit
> we are setting rather than being the 'other bits'.
>
> > +     reg_val |= (data->thermocouple_type & 0x0F);
> Can we get here with a value that needs masking?  Doing this made
> me wonder whether it was a straight forward bit of code so I'd
> rather not see the mask if it's not needed.
>
> > +     ret = max31856_write(data, MAX31856_CR1_REG, reg_val);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* Set Conversion Mode (Auto or Oneshot) based on dts property */
> > +     ret = max31856_read(data, MAX31856_CR0_REG, &reg_val, 1);
> > +     if (ret)
> > +             return ret;
> > +     if (data->one_shot) {
> > +             reg_val &= ~MAX31856_CR0_AUTOCONVERT;
> > +             reg_val |= MAX31856_CR0_1SHOT;
> > +     } else {
> > +             reg_val |= MAX31856_CR0_AUTOCONVERT;
> > +             reg_val &= ~MAX31856_CR0_1SHOT;
>
> I mention below that I don't understand why this is coming from dt.
> (or for that matter why you pick one option over the other).
> > +     }
> > +
> > +     return max31856_write(data, MAX31856_CR0_REG, reg_val);
> > +}
> > +
> > +static int max31856_thermocouple_read(struct max31856_data *data,
> > +                                   struct iio_chan_spec const *chan,
> > +                                   int *val)
> > +{
> > +     int ret = 0, temp, offset_cjto;
> > +
> > +     switch (chan->channel2) {
> > +     case IIO_MOD_TEMP_AMBIENT:
> > +             /* Read register from 0x09-0x0B */
> This comment is probably not needed.  The nice use of defines provide
> all the info we need.
> > +             ret = max31856_read(data, MAX31856_CJTO_REG, val, 3);
> I would use a local variable here, perhaps even a simple byte array
> given we are really looking at 3 separate registers.  I'm fairly
> sure we are not handling endianess correctly here.
>
> > +             /* Get Cold Junction Temp. offset register value */
> > +             offset_cjto = *val >> 16;
> > +             /* Mask last 2 bytes to get CJTH and CJTL reg. value */
> > +             *val &= 0x0000FFFF;
> > +             temp = *val;
> > +             /* last 2 bits unused in CJTL reg*/
> > +             *val >>= 2;
>
> Would have been slightly nicer to mask these out as we are shifting them
> away.
>
> > +             /* As per datasheet add offset into CJTH and CJTL */
> > +             *val += offset_cjto;
> > +             /* Check 15th bit for sign */
> > +             if (temp & 0x8000)
> > +                     *val -= 0x4000;
> > +             break;
> > +     default:
> This looks like a specific other channel. I'd rather see it labeled
> as such with the relevant case entries.
> > +             ret = max31856_read(data, MAX31856_LTCBH_REG, val, 3);
> > +             temp = *val;
> > +             *val >>= 5;
> > +             /* Check 23th bit for sign */
> > +             if (temp & 0x800000)
> > +                     *val -= 0x80000;
> > +     }
> > +
> > +     ret = max31856_read(data, MAX31856_SR_REG, &temp, 1);
> > +     /* Check for over voltage/under voltage fault */
> > +     data->fault_ovuv = (temp & MAX31856_FAULT_OVUV) ? 1 : 0;
> These should be stored in booleans as that is what they are used
> for.
>
> > +     /* Check for open circuit fault */
> > +     data->fault_oc = (temp & MAX31856_FAULT_OPEN) ? 1 : 0;
> > +     if (data->fault_oc || data->fault_ovuv)
> > +             return -EIO;
> > +
> > +     return ret;
> > +}
> > +
> > +static int max31856_read_raw(struct iio_dev *indio_dev,
> > +                          struct iio_chan_spec const *chan,
> > +                          int *val, int *val2, long mask)
> > +{
> > +     struct max31856_data *data = iio_priv(indio_dev);
> > +     int ret;
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_RAW:
> > +             ret = max31856_thermocouple_read(data, chan, val);
> > +             if (ret)
> > +                     return ret;
> > +             return IIO_VAL_INT;
> > +     case IIO_CHAN_INFO_SCALE:
> > +             switch (chan->channel2) {
> > +             case IIO_MOD_TEMP_AMBIENT:
> > +                     /* Cold junction Temp. Data resolution is 0.015625
> */
> > +                     *val = 15;
> > +                     *val2 = 625000; /* 1000 * 0.015625 */
> > +                     ret = IIO_VAL_INT_PLUS_MICRO;
> > +                     break;
> > +             default:
> > +                     /* Thermocouple Temp. Data resolution is 0.0078125
> */
> > +                     *val = 7;
> > +                     *val2 = 812500; /* 1000 * 0.0078125) */
> > +                     return IIO_VAL_INT_PLUS_MICRO;
> > +             }
> > +             break;
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +static ssize_t show_fault_ovuv(struct device *dev,
> > +                            struct device_attribute *attr,
> > +                            char *buf)
> > +{
> > +     struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +     struct max31856_data *data = iio_priv(indio_dev);
> > +
> > +     return sprintf(buf, "%d\n", data->fault_ovuv);
> > +}
> > +
> > +static ssize_t show_fault_oc(struct device *dev,
> > +                          struct device_attribute *attr,
> > +                          char *buf)
> > +{
> > +     struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +     struct max31856_data *data = iio_priv(indio_dev);
> > +
> > +     return sprintf(buf, "%d\n", data->fault_oc);
> > +}
> > +
> > +static IIO_DEVICE_ATTR(fault_ovuv, 0444, show_fault_ovuv, NULL, 0);
> > +static IIO_DEVICE_ATTR(fault_oc, 0444, show_fault_oc, NULL, 0);
>
> Please provide documentation for this new ABI (at least I don't remember
> seeing it before!)
>
> Documentaiton/ABI/testing/sysfs-bus-iio-*
>
> We'll be back to the usual issue that embedded platforms tend not to
> do any unified sort of RAS and there isn't a good way to report a wiring
> failure..
>
> So these are nasty device specific interfaces, but they may be the best
> we can do :(
>
> > +
> > +static struct attribute *max31856_attributes[] = {
> > +     &iio_dev_attr_fault_ovuv.dev_attr.attr,
> > +     &iio_dev_attr_fault_oc.dev_attr.attr,
> > +     NULL,
> > +};
> > +
> > +static const struct attribute_group max31856_group = {
> > +     .attrs = max31856_attributes,
> > +};
> > +
> > +static const struct iio_info max31856_info = {
> > +     .driver_module = THIS_MODULE,
> > +     .read_raw = max31856_read_raw,
> > +     .attrs = &max31856_group,
> > +};
> > +
> > +static int max31856_probe(struct spi_device *spi)
> > +{
> > +     const struct spi_device_id *id = spi_get_device_id(spi);
> > +     struct iio_dev *indio_dev;
> > +     struct max31856_data *data;
> > +     int ret;
> > +
> > +     indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*data));
> > +     if (!indio_dev)
> > +             return -ENOMEM;
> > +
> > +     data = iio_priv(indio_dev);
> > +     data->spi = spi;
> > +
> > +     spi_set_drvdata(spi, indio_dev);
> > +
> > +     indio_dev->info = &max31856_info;
> > +     indio_dev->name = id->name;
> > +     indio_dev->modes = INDIO_DIRECT_MODE;
> > +     indio_dev->channels = max31856_channels;
> > +     indio_dev->num_channels = ARRAY_SIZE(max31856_channels);
> > +
> > +     data->one_shot = of_property_read_bool(spi->dev.of_node,
> "one-shot");
>
> This does not look to me like something that should be controlled in
> devicetree.
> Normally we'd switch between oneshot and continuous modes based on some
> sort
> of rule such as whether we are doing buffered reads vs polled ones, or
> perhaps
> switch to oneshot if there hasn't been a reading taken for a 'while'.
> (a form of runtime power management).
>
> > +
> > +     ret = of_property_read_u32(spi->dev.of_node, "type",
> > +                                &data->thermocouple_type);
> > +
> > +     if (ret) {
> > +             pr_info("Could not read thermocouple type DT property,
> Configuring as a K-Type\n");
> > +             data->thermocouple_type = 0x03; /* K-Type */
> > +     }
> > +
> > +     ret = max31856_init(data);
> > +     if (ret) {
> > +             pr_err("error: Failed to configure max31856\n");
> > +             return ret;
> > +     }
> > +
> > +     ret = iio_device_register(indio_dev);
> > +
> > +     data->fault_ovuv = 0;
> > +     data->fault_oc = 0;
> This is interesting.   The call to iio_device_register
> is the point at which the device is exposed to userspace and
> any in kernel consumers.  Having anything set 'after' that
> point is almost always a race condition.
>
> Is there a strong reason these can't be done before the
> iio_device_register?
> If there is, we should definitely be seeing a comment saying why.
>
> > +
> > +     return ret;
> > +}
> > +
> > +static int max31856_remove(struct spi_device *spi)
> > +{
> > +     struct iio_dev *indio_dev = spi_get_drvdata(spi);
> > +
>
> > +     iio_device_unregister(indio_dev);
> If this is the only thing we need to do in remove, then
> we should be safe to call
> devm_iio_device_register and let the managed unwinding
> deal with it.  That will let us drop the remove function
> entirely.
>
>
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct spi_device_id max31856_id[] = {
> > +     { "max31856", 0 },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(spi, max31856_id);
> > +
> > +static struct spi_driver max31856_driver = {
> > +     .driver = {
> > +             .name = "max31856",
> > +             .owner = THIS_MODULE,
> > +     },
> > +     .probe = max31856_probe,
> > +     .remove = max31856_remove,
> > +     .id_table = max31856_id,
> > +};
> > +module_spi_driver(max31856_driver);
> > +
> > +MODULE_AUTHOR("Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com
> >");
> > +MODULE_DESCRIPTION("Maxim MAX31856 thermocouple sensor driver");
> > +MODULE_LICENSE("GPL");
>
>

--0000000000006c006b05784bf1ad
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Jonatha,<div><br></div><div><pre class=3D"gmail-content=
" style=3D"box-sizing:border-box;overflow:auto;font-family:Menlo,Monaco,Con=
solas,&quot;Courier New&quot;,monospace;font-size:13px;padding:9.5px;margin=
-top:0px;margin-bottom:10px;line-height:14.3px;color:rgb(51,51,51);word-bre=
ak:break-all;border:0px;border-radius:0px">This does not look to me like so=
mething that should be controlled in devicetree.
Normally we&#39;d switch between oneshot and continuous modes based on some=
 sort
of rule such as whether we are doing buffered reads vs polled ones, or perh=
aps
switch to oneshot if there hasn&#39;t been a reading taken for a &#39;while=
&#39;.
(a form of runtime power management).</pre><pre class=3D"gmail-content" sty=
le=3D"box-sizing:border-box;overflow:auto;font-family:Menlo,Monaco,Consolas=
,&quot;Courier New&quot;,monospace;font-size:13px;padding:9.5px;margin-top:=
0px;margin-bottom:10px;line-height:14.3px;color:rgb(51,51,51);word-break:br=
eak-all;border:0px;border-radius:0px">-&gt; As of now, a Current driver doe=
s not have support to switch conversion mode on runtime. I totally agree wi=
th you about runtime power management concern.</pre><pre class=3D"gmail-con=
tent" style=3D"box-sizing:border-box;overflow:auto;font-family:Menlo,Monaco=
,Consolas,&quot;Courier New&quot;,monospace;font-size:13px;padding:9.5px;ma=
rgin-top:0px;margin-bottom:10px;line-height:14.3px;color:rgb(51,51,51);word=
-break:break-all;border:0px;border-radius:0px"><br></pre><pre class=3D"gmai=
l-content" style=3D"box-sizing:border-box;overflow:auto;font-family:Menlo,M=
onaco,Consolas,&quot;Courier New&quot;,monospace;font-size:13px;padding:9.5=
px;margin-top:0px;margin-bottom:10px;line-height:14.3px;color:rgb(51,51,51)=
;word-break:break-all;border:0px;border-radius:0px">  </pre><pre class=3D"g=
mail-content" style=3D"box-sizing:border-box;overflow:auto;font-family:Menl=
o,Monaco,Consolas,&quot;Courier New&quot;,monospace;font-size:13px;padding:=
9.5px;margin-top:0px;margin-bottom:10px;line-height:14.3px;color:rgb(51,51,=
51);word-break:break-all;border:0px;border-radius:0px">      </pre><pre cla=
ss=3D"gmail-content" style=3D"box-sizing:border-box;overflow:auto;font-fami=
ly:Menlo,Monaco,Consolas,&quot;Courier New&quot;,monospace;font-size:13px;p=
adding:9.5px;margin-top:0px;margin-bottom:10px;line-height:14.3px;color:rgb=
(51,51,51);word-break:break-all;border:0px;border-radius:0px"><br></pre><br=
><div class=3D"gmail_quote"><div dir=3D"ltr">On Sat, Oct 13, 2018 at 8:51 A=
M Jonathan Cameron &lt;<a href=3D"mailto:jic23@kernel.org">jic23@kernel.org=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Thu, 11 Oct 2018=
 11:38:09 -0500<br>
Matt Weber &lt;<a href=3D"mailto:matthew.weber@rockwellcollins.com" target=
=3D"_blank">matthew.weber@rockwellcollins.com</a>&gt; wrote:<br>
<br>
&gt; From: Paresh Chaudhary &lt;<a href=3D"mailto:paresh.chaudhary@rockwell=
collins.com" target=3D"_blank">paresh.chaudhary@rockwellcollins.com</a>&gt;=
<br>
&gt; <br>
&gt; This patch adds support for Maxim MAX31856 thermocouple<br>
&gt; temperature sensor support.<br>
&gt; <br>
&gt; More information can be found in:<br>
&gt; <a href=3D"https://www.maximintegrated.com/en/ds/MAX31856.pdf" rel=3D"=
noreferrer" target=3D"_blank">https://www.maximintegrated.com/en/ds/MAX3185=
6.pdf</a><br>
&gt; <br>
&gt; NOTE: Driver support only Comparator Mode.<br>
&gt; <br>
&gt; Signed-off-by: Paresh Chaudhary &lt;<a href=3D"mailto:paresh.chaudhary=
@rockwellcollins.com" target=3D"_blank">paresh.chaudhary@rockwellcollins.co=
m</a>&gt;<br>
&gt; Signed-off-by: Matt Weber &lt;<a href=3D"mailto:matthew.weber@rockwell=
collins.com" target=3D"_blank">matthew.weber@rockwellcollins.com</a>&gt;<br=
>
<br>
Hi Matt,<br>
<br>
As others have commented, looking pretty nice.=C2=A0 A few minor<br>
comments and suggestions inline.<br>
<br>
Thanks,<br>
<br>
Jonathan<br>
&gt; ---<br>
&gt; Changes v1 -&gt; v2<br>
&gt; [Peter<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A01. Fixed all space &amp; &#39;return&#39; re=
lated comments<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A02. Removed &#39;sysfs_create_group&#39; api=
=C2=A0 because<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iio_device_register function is hand=
ling sysfs entry<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A03. Return -EIO if there is any fault<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A04. Added check for &#39;read_size&#39; befor=
e spi read call<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A05. Removed license text from the source file=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A06. Added .o file in alphabetic order<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A07. Used #defines instead of magic bits<br>
&gt; <br>
&gt; ---<br>
&gt;=C2=A0 MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A05 +<br>
&gt;=C2=A0 drivers/iio/temperature/Kconfig=C2=A0 =C2=A0 |=C2=A0 10 +<br>
&gt;=C2=A0 drivers/iio/temperature/Makefile=C2=A0 =C2=A0|=C2=A0 =C2=A01 +<b=
r>
&gt;=C2=A0 drivers/iio/temperature/max31856.c | 372 +++++++++++++++++++++++=
++++++++++++++<br>
&gt;=C2=A0 4 files changed, 388 insertions(+)<br>
&gt;=C2=A0 create mode 100644 drivers/iio/temperature/max31856.c<br>
&gt; <br>
&gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>
&gt; index f642044..dd9a83d 100644<br>
&gt; --- a/MAINTAINERS<br>
&gt; +++ b/MAINTAINERS<br>
&gt; @@ -7157,6 +7157,11 @@ F:=C2=A0 =C2=A0 =C2=A0drivers/staging/iio/<br>
&gt;=C2=A0 F:=C2=A0 =C2=A0include/linux/iio/<br>
&gt;=C2=A0 F:=C2=A0 =C2=A0tools/iio/<br>
&gt;=C2=A0 <br>
&gt; +MAX31856 IIO DRIVER<br>
&gt; +M:=C2=A0 =C2=A0Matthew Weber &lt;<a href=3D"mailto:matthew.weber@rock=
wellcollins.com" target=3D"_blank">matthew.weber@rockwellcollins.com</a>&gt=
;<br>
&gt; +S:=C2=A0 =C2=A0Maintained<br>
&gt; +F:=C2=A0 =C2=A0drivers/iio/temperature/max31856.c<br>
&gt; +<br>
&gt;=C2=A0 IIO UNIT CONVERTER<br>
&gt;=C2=A0 M:=C2=A0 =C2=A0Peter Rosin &lt;<a href=3D"mailto:peda@axentia.se=
" target=3D"_blank">peda@axentia.se</a>&gt;<br>
&gt;=C2=A0 L:=C2=A0 =C2=A0<a href=3D"mailto:linux-iio@vger.kernel.org" targ=
et=3D"_blank">linux-iio@vger.kernel.org</a><br>
&gt; diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature=
/Kconfig<br>
&gt; index 82e4a62..c66eeb2 100644<br>
&gt; --- a/drivers/iio/temperature/Kconfig<br>
&gt; +++ b/drivers/iio/temperature/Kconfig<br>
&gt; @@ -97,4 +97,14 @@ config TSYS02D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This driver can also be built as a mo=
dule. If so, the module will<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0be called tsys02d.<br>
&gt;=C2=A0 <br>
&gt; +config MAX31856<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tristate &quot;MAX31856 thermocouple sensor&quot;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0depends on SPI<br>
&gt; +=C2=A0 =C2=A0 =C2=A0help<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0If you say yes here you get support for MA=
X31856<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0thermocouple sensor chip connected via SPI=
.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0This driver can also be built as a module.=
=C2=A0 If so, the module<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0will be called max31856.<br>
&gt; +<br>
&gt;=C2=A0 endmenu<br>
&gt; diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperatur=
e/Makefile<br>
&gt; index 34a31db..baca477 100644<br>
&gt; --- a/drivers/iio/temperature/Makefile<br>
&gt; +++ b/drivers/iio/temperature/Makefile<br>
&gt; @@ -5,6 +5,7 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 obj-$(CONFIG_HID_SENSOR_TEMP) +=3D hid-sensor-temperature.o<br>
&gt;=C2=A0 obj-$(CONFIG_MAXIM_THERMOCOUPLE) +=3D maxim_thermocouple.o<br>
&gt; +obj-$(CONFIG_MAX31856) +=3D max31856.o<br>
&gt;=C2=A0 obj-$(CONFIG_MLX90614) +=3D mlx90614.o<br>
&gt;=C2=A0 obj-$(CONFIG_MLX90632) +=3D mlx90632.o<br>
&gt;=C2=A0 obj-$(CONFIG_TMP006) +=3D tmp006.o<br>
&gt; diff --git a/drivers/iio/temperature/max31856.c b/drivers/iio/temperat=
ure/max31856.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..b66ddb0<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/iio/temperature/max31856.c<br>
&gt; @@ -0,0 +1,372 @@<br>
&gt; +// SPDX-License-Identifier: GPL-2.0<br>
&gt; +/* max31856.c<br>
&gt; + *<br>
&gt; + * Maxim MAX31856 thermocouple sensor driver<br>
&gt; + *<br>
&gt; + * Copyright (C) 2018 Rockwell Collins<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &lt;linux/module.h&gt;<br>
&gt; +#include &lt;linux/init.h&gt;<br>
&gt; +#include &lt;linux/err.h&gt;<br>
&gt; +#include &lt;linux/spi/spi.h&gt;<br>
&gt; +#include &lt;linux/iio/iio.h&gt;<br>
&gt; +#include &lt;linux/iio/sysfs.h&gt;<br>
&gt; +<br>
&gt; +#define MAX31856_READ_MODE=C2=A0 =C2=A0 =C2=A0 0x7F<br>
&gt; +#define MAX31856_WRITE_MODE=C2=A0 =C2=A0 =C2=A00x80<br>
&gt; +#define MAX31856_CR0_AUTOCONVERT=C2=A0 =C2=A00x80<br>
&gt; +#define MAX31856_CR0_1SHOT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x40<br>
&gt; +#define MAX31856_CR0_OCFAULT1=C2=A0 =C2=A0 =C2=A0 0x20<br>
&gt; +#define MAX31856_CR0_OCFAULT0=C2=A0 =C2=A0 =C2=A0 0x10<br>
&gt; +#define MAX31856_FAULT_OVUV=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x02<br>
&gt; +#define MAX31856_FAULT_OPEN=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x01<br>
&gt; +<br>
&gt; +/* The MAX31856 registers */<br>
&gt; +#define MAX31856_CR0_REG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x00=
<br>
&gt; +#define MAX31856_CR1_REG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x01=
<br>
&gt; +#define MAX31856_MASK_REG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x02<br>
&gt; +#define MAX31856_CJHF_REG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x03<br>
&gt; +#define MAX31856_CJLF_REG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x04<br>
&gt; +#define MAX31856_LTHFTH_REG=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x05<br>
&gt; +#define MAX31856_LTHFTL_REG=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x06<br>
&gt; +#define MAX31856_LTLFTH_REG=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x07<br>
&gt; +#define MAX31856_LTLFTL_REG=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x08<br>
&gt; +#define MAX31856_CJTO_REG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x09<br>
&gt; +#define MAX31856_CJTH_REG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0A<br>
&gt; +#define MAX31856_CJTL_REG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0B<br>
&gt; +#define MAX31856_LTCBH_REG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0C<br>
&gt; +#define MAX31856_LTCBM_REG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0D<br>
&gt; +#define MAX31856_LTCBL_REG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0E<br>
&gt; +#define MAX31856_SR_REG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0F=
<br>
&gt; +<br>
&gt; +static const struct iio_chan_spec max31856_channels[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Thermocouple Tempe=
rature */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.type =3D IIO_TEMP,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.address =3D 2,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.info_mask_separate =
=3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0},<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Cold Junction Temp=
erature */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.type =3D IIO_TEMP,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.channel2 =3D IIO_MOD=
_TEMP_AMBIENT,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.address =3D 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.modified =3D 1,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.info_mask_separate =
=3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0},<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct max31856_data {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct spi_device *spi;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bool one_shot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 thermocouple_type;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int fault_ovuv;<br>
Mentioned below but these should be booleans to make it implicit that they<=
br>
are only true or false.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int fault_oc;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u8 buf[3] ____cacheline_aligned;<br>
&gt; +};<br>
&gt; +<br>
&gt; +static int max31856_read(struct max31856_data *data, unsigned int reg=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 s32 *val, int read_size)<br>
<br>
I think we would be better off having this function deal with val<br>
as a byte array (so a set of register values) and move the endian<br>
conversion that is in here to the calling locations.=C2=A0 I think that wou=
ld<br>
be somewhat less confusing than doing in here.<br>
<br>
I don&#39;t think you do any 2 byte reads for example yet we support<br>
in here as it would look odd otherwise.=C2=A0 Move that to the calling loca=
tions<br>
and there will only be support if it is needed in future.<br>
<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u8 *buf =3D data-&gt;buf;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Make sure top bit is not set,<br>
/*<br>
=C2=A0* Make...<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * The MSB(A7) of this byte determines whether th=
e following byte will<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * be written or read. If A7 is 0, one or more by=
te reads will follow<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * the address byte<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0reg &amp;=3D MAX31856_READ_MODE;<br>
This feels a little to paranoid as the only way that top bit can be set is<=
br>
(I think) a bug.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0buf[0] =3D reg;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0buf[1] =3D 0x00;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0buf[2] =3D 0x00;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (read_size &gt; 3) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_err(&quot;error: U=
nsupported read_size =3D %d by %s\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0read_size,=C2=A0 __func__);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D spi_write_then_read(data-&gt;spi, buf, 1,=
 buf, read_size);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0switch (read_size) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case 1:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val =3D buf[0];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case 2:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val =3D (buf[0] &lt;=
&lt; 8) | buf[1];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
Endian conversion function preferred (sometimes there is nothing to do!)<br=
>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case 3:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val =3D (buf[0] &lt;=
&lt; 16) | (buf[1] &lt;&lt; 8) | buf[2];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int max31856_write(struct max31856_data *data, unsigned int re=
g,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0unsigned int val)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u8 *buf =3D data-&gt;buf;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Make sure top bit is set,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * The MSB(A7) of this byte determines whether th=
e following byte will<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * be written or read. If A7 is 1, one or more by=
te writes will follow<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * the address byte<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0reg |=3D MAX31856_WRITE_MODE;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0buf[0] =3D reg;<br>
I would roll the two lines above into one.=C2=A0 Separating them doesn&#39;=
t add anything<br>
to readability to my mind.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0buf[1] =3D val;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return spi_write(data-&gt;spi, buf, 2);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int max31856_init(struct max31856_data *data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret =3D 0;<br>
Already commented on by others I think... no need to assign.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0s32 reg_val;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Enable Open circuit fault detection [01]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * Read datasheet for more information: Table 4.<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * BITS [5:4]=C2=A0 =C2=A0 | Fault Test<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * ---------------------------<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 =C2=A0 00=C2=A0 =C2=A0 | Disabled=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * ---------------------------<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 =C2=A0 01=C2=A0 =C2=A0 | Enabled =
(Once every 16 seconds)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * ---------------------------<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 =C2=A0 10=C2=A0 =C2=A0 | Enabled =
(Once every 16 seconds)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * ---------------------------<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 =C2=A0 11=C2=A0 =C2=A0 | Enabled =
(Once every 16 seconds)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D max31856_read(data, MAX31856_CR0_REG, &am=
p;reg_val, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0reg_val &amp;=3D ~MAX31856_CR0_OCFAULT1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0reg_val |=3D MAX31856_CR0_OCFAULT0;<br>
This is perhaps not the clearest way of doing this.<br>
<br>
I would mask and then set to the two bit value.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D max31856_write(data, MAX31856_CR0_REG, re=
g_val);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Set thermocouple type based on dts property */=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D max31856_read(data, MAX31856_CR1_REG, &am=
p;reg_val, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0reg_val &amp;=3D 0x00F0;<br>
Preferred if masks etc are handled via a define.=C2=A0 Also use GENMASK<br>
to make it easy to read which bits are being masked.=C2=A0 I think<br>
this is also an 8 bit value.=C2=A0 Better to handle it as such and<br>
treat that mask as a negated form of the the mask for the bit<br>
we are setting rather than being the &#39;other bits&#39;.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0reg_val |=3D (data-&gt;thermocouple_type &amp; 0x=
0F);<br>
Can we get here with a value that needs masking?=C2=A0 Doing this made<br>
me wonder whether it was a straight forward bit of code so I&#39;d<br>
rather not see the mask if it&#39;s not needed.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D max31856_write(data, MAX31856_CR1_REG, re=
g_val);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Set Conversion Mode (Auto or Oneshot) based on=
 dts property */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D max31856_read(data, MAX31856_CR0_REG, &am=
p;reg_val, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (data-&gt;one_shot) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg_val &amp;=3D ~MAX=
31856_CR0_AUTOCONVERT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg_val |=3D MAX31856=
_CR0_1SHOT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg_val |=3D MAX31856=
_CR0_AUTOCONVERT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg_val &amp;=3D ~MAX=
31856_CR0_1SHOT;<br>
<br>
I mention below that I don&#39;t understand why this is coming from dt.<br>
(or for that matter why you pick one option over the other).<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return max31856_write(data, MAX31856_CR0_REG, reg=
_val);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int max31856_thermocouple_read(struct max31856_data *data,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct iio_chan_spe=
c const *chan,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int *val)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret =3D 0, temp, offset_cjto;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0switch (chan-&gt;channel2) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case IIO_MOD_TEMP_AMBIENT:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Read register from=
 0x09-0x0B */<br>
This comment is probably not needed.=C2=A0 The nice use of defines provide<=
br>
all the info we need.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D max31856_read=
(data, MAX31856_CJTO_REG, val, 3);<br>
I would use a local variable here, perhaps even a simple byte array<br>
given we are really looking at 3 separate registers.=C2=A0 I&#39;m fairly<b=
r>
sure we are not handling endianess correctly here.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Get Cold Junction =
Temp. offset register value */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0offset_cjto =3D *val =
&gt;&gt; 16;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Mask last 2 bytes =
to get CJTH and CJTL reg. value */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val &amp;=3D 0x0000F=
FFF;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0temp =3D *val;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* last 2 bits unused=
 in CJTL reg*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val &gt;&gt;=3D 2;<b=
r>
<br>
Would have been slightly nicer to mask these out as we are shifting them aw=
ay.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* As per datasheet a=
dd offset into CJTH and CJTL */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val +=3D offset_cjto=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Check 15th bit for=
 sign */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (temp &amp; 0x8000=
)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0*val -=3D 0x4000;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0default:<br>
This looks like a specific other channel. I&#39;d rather see it labeled<br>
as such with the relevant case entries.=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D max31856_read=
(data, MAX31856_LTCBH_REG, val, 3);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0temp =3D *val;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val &gt;&gt;=3D 5;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Check 23th bit for=
 sign */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (temp &amp; 0x8000=
00)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0*val -=3D 0x80000;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D max31856_read(data, MAX31856_SR_REG, &amp=
;temp, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Check for over voltage/under voltage fault */<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0data-&gt;fault_ovuv =3D (temp &amp; MAX31856_FAUL=
T_OVUV) ? 1 : 0;<br>
These should be stored in booleans as that is what they are used<br>
for.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Check for open circuit fault */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0data-&gt;fault_oc =3D (temp &amp; MAX31856_FAULT_=
OPEN) ? 1 : 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (data-&gt;fault_oc || data-&gt;fault_ovuv)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EIO;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int max31856_read_raw(struct iio_dev *indio_dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 struct iio_chan_spec const *chan,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 int *val, int *val2, long mask)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct max31856_data *data =3D iio_priv(indio_dev=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0switch (mask) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case IIO_CHAN_INFO_RAW:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D max31856_ther=
mocouple_read(data, chan, val);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return IIO_VAL_INT;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0case IIO_CHAN_INFO_SCALE:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (chan-&gt;chan=
nel2) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IIO_MOD_TEMP_AMB=
IENT:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0/* Cold junction Temp. Data resolution is 0.015625 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0*val =3D 15;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0*val2 =3D 625000; /* 1000 * 0.015625 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ret =3D IIO_VAL_INT_PLUS_MICRO;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0/* Thermocouple Temp. Data resolution is 0.0078125 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0*val =3D 7;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0*val2 =3D 812500; /* 1000 * 0.0078125) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return IIO_VAL_INT_PLUS_MICRO;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static ssize_t show_fault_ovuv(struct device *dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct device_attribute *attr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *buf)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct iio_dev *indio_dev =3D dev_to_iio_dev(dev)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct max31856_data *data =3D iio_priv(indio_dev=
);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return sprintf(buf, &quot;%d\n&quot;, data-&gt;fa=
ult_ovuv);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static ssize_t show_fault_oc(struct device *dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 struct device_attribute *attr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 char *buf)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct iio_dev *indio_dev =3D dev_to_iio_dev(dev)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct max31856_data *data =3D iio_priv(indio_dev=
);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return sprintf(buf, &quot;%d\n&quot;, data-&gt;fa=
ult_oc);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static IIO_DEVICE_ATTR(fault_ovuv, 0444, show_fault_ovuv, NULL, 0);<b=
r>
&gt; +static IIO_DEVICE_ATTR(fault_oc, 0444, show_fault_oc, NULL, 0);<br>
<br>
Please provide documentation for this new ABI (at least I don&#39;t remembe=
r<br>
seeing it before!)<br>
<br>
Documentaiton/ABI/testing/sysfs-bus-iio-*<br>
<br>
We&#39;ll be back to the usual issue that embedded platforms tend not to<br=
>
do any unified sort of RAS and there isn&#39;t a good way to report a wirin=
g<br>
failure..<br>
<br>
So these are nasty device specific interfaces, but they may be the best<br>
we can do :(<br>
<br>
&gt; +<br>
&gt; +static struct attribute *max31856_attributes[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&amp;iio_dev_attr_fault_ovuv.dev_attr.attr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&amp;iio_dev_attr_fault_oc.dev_attr.attr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0NULL,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct attribute_group max31856_group =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.attrs =3D max31856_attributes,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct iio_info max31856_info =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.driver_module =3D THIS_MODULE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.read_raw =3D max31856_read_raw,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.attrs =3D &amp;max31856_group,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static int max31856_probe(struct spi_device *spi)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0const struct spi_device_id *id =3D spi_get_device=
_id(spi);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct iio_dev *indio_dev;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct max31856_data *data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0indio_dev =3D devm_iio_device_alloc(&amp;spi-&gt;=
dev, sizeof(*data));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!indio_dev)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0data =3D iio_priv(indio_dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0data-&gt;spi =3D spi;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0spi_set_drvdata(spi, indio_dev);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0indio_dev-&gt;info =3D &amp;max31856_info;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0indio_dev-&gt;name =3D id-&gt;name;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0indio_dev-&gt;modes =3D INDIO_DIRECT_MODE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0indio_dev-&gt;channels =3D max31856_channels;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0indio_dev-&gt;num_channels =3D ARRAY_SIZE(max3185=
6_channels);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0data-&gt;one_shot =3D of_property_read_bool(spi-&=
gt;dev.of_node, &quot;one-shot&quot;);<br>
<br>
This does not look to me like something that should be controlled in device=
tree.<br>
Normally we&#39;d switch between oneshot and continuous modes based on some=
 sort<br>
of rule such as whether we are doing buffered reads vs polled ones, or perh=
aps<br>
switch to oneshot if there hasn&#39;t been a reading taken for a &#39;while=
&#39;.<br>
(a form of runtime power management).<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D of_property_read_u32(spi-&gt;dev.of_node,=
 &quot;type&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;data-&gt;thermocouple_type)=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_info(&quot;Could n=
ot read thermocouple type DT property, Configuring as a K-Type\n&quot;);<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;thermocouple=
_type =3D 0x03; /* K-Type */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D max31856_init(data);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_err(&quot;error: F=
ailed to configure max31856\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D iio_device_register(indio_dev);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0data-&gt;fault_ovuv =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0data-&gt;fault_oc =3D 0;<br>
This is interesting.=C2=A0 =C2=A0The call to iio_device_register<br>
is the point at which the device is exposed to userspace and<br>
any in kernel consumers.=C2=A0 Having anything set &#39;after&#39; that<br>
point is almost always a race condition.<br>
<br>
Is there a strong reason these can&#39;t be done before the iio_device_regi=
ster?<br>
If there is, we should definitely be seeing a comment saying why.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int max31856_remove(struct spi_device *spi)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct iio_dev *indio_dev =3D spi_get_drvdata(spi=
);<br>
&gt; +<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0iio_device_unregister(indio_dev);<br>
If this is the only thing we need to do in remove, then<br>
we should be safe to call<br>
devm_iio_device_register and let the managed unwinding<br>
deal with it.=C2=A0 That will let us drop the remove function<br>
entirely.<br>
<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct spi_device_id max31856_id[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ &quot;max31856&quot;, 0 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ }<br>
&gt; +};<br>
&gt; +MODULE_DEVICE_TABLE(spi, max31856_id);<br>
&gt; +<br>
&gt; +static struct spi_driver max31856_driver =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.driver =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =3D &quot;max31=
856&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.owner =3D THIS_MODUL=
E,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0},<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.probe =3D max31856_probe,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.remove =3D max31856_remove,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.id_table =3D max31856_id,<br>
&gt; +};<br>
&gt; +module_spi_driver(max31856_driver);<br>
&gt; +<br>
&gt; +MODULE_AUTHOR(&quot;Paresh Chaudhary &lt;<a href=3D"mailto:paresh.cha=
udhary@rockwellcollins.com" target=3D"_blank">paresh.chaudhary@rockwellcoll=
ins.com</a>&gt;&quot;);<br>
&gt; +MODULE_DESCRIPTION(&quot;Maxim MAX31856 thermocouple sensor driver&qu=
ot;);<br>
&gt; +MODULE_LICENSE(&quot;GPL&quot;);<br>
<br>
</blockquote></div></div></div>

--0000000000006c006b05784bf1ad--
