Return-Path: <navin.patidar@gmail.com>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1607260946460.6854@pmeerw.net>
References: <1469488695-32050-1-git-send-email-navin.patidar@gmail.com> <alpine.DEB.2.02.1607260946460.6854@pmeerw.net>
From: navin patidar <navin.patidar@gmail.com>
Date: Tue, 26 Jul 2016 11:39:02 -0700
Message-ID: <CAPV97yfCHWp=+-QT1snUTJKD9rs-uhQTiQs1cwvhhdR2qOkwZA@mail.gmail.com>
Subject: Re: [PATCH] iio: orientation: Add BNO055 9-axis Absolute Orientation
 Sensor driver
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
	lars@metafoo.de, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary=94eb2c05415c01ca2705388e37c6
List-ID: <linux-iio@vger.kernel.org>

--94eb2c05415c01ca2705388e37c6
Content-Type: text/plain; charset=UTF-8

Hi Peter,

Thanks for reviewing the patch. I will send the updated patch.

regards,
--navin-patidar

On Tue, Jul 26, 2016 at 1:07 AM, Peter Meerwald-Stadler <pmeerw@pmeerw.net>
wrote:

>
> > BNO055 provides the following motion sensors data:
> >
> >  * Gyroscope
> >  * Accelerometer
> >  * Magnetometer
> >  * Absolute Orientation (Quaternion)
>
> comments below
>
> > Signed-off-by: navin patidar <navin.patidar@gmail.com>
> > ---
> >  drivers/iio/orientation/Kconfig  |  10 +
> >  drivers/iio/orientation/Makefile |   1 +
> >  drivers/iio/orientation/bno055.c | 422
> +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 433 insertions(+)
> >  create mode 100644 drivers/iio/orientation/bno055.c
> >
> > diff --git a/drivers/iio/orientation/Kconfig
> b/drivers/iio/orientation/Kconfig
> > index e3aa1e5..9ac21ee 100644
> > --- a/drivers/iio/orientation/Kconfig
> > +++ b/drivers/iio/orientation/Kconfig
> > @@ -28,4 +28,14 @@ config HID_SENSOR_DEVICE_ROTATION
> >         device rotation. The output of a device rotation sensor
> >         is presented using quaternion format.
> >
> > +config BNO055
> > +     tristate "BOSCH BNO055 Absolute Orientation"
> > +     depends on I2C
> > +     select REGMAP_I2C
> > +     help
> > +       Say yes here to build support for BOSCH BNO55 9-axis absolute
> orientation sensor
> > +       driver connected via I2C.
> > +       This driver can also be built as a module. If so, the module
> > +       will be called bno055.
> > +
> >  endmenu
> > diff --git a/drivers/iio/orientation/Makefile
> b/drivers/iio/orientation/Makefile
> > index 4734dab..7d00037 100644
> > --- a/drivers/iio/orientation/Makefile
> > +++ b/drivers/iio/orientation/Makefile
> > @@ -5,3 +5,4 @@
> >  # When adding new entries keep the list in alphabetical order
> >  obj-$(CONFIG_HID_SENSOR_INCLINOMETER_3D) += hid-sensor-incl-3d.o
> >  obj-$(CONFIG_HID_SENSOR_DEVICE_ROTATION) += hid-sensor-rotation.o
> > +obj-$(CONFIG_BNO055) += bno055.o
> > diff --git a/drivers/iio/orientation/bno055.c
> b/drivers/iio/orientation/bno055.c
> > new file mode 100644
> > index 0000000..48b9e93
> > --- /dev/null
> > +++ b/drivers/iio/orientation/bno055.c
> > @@ -0,0 +1,422 @@
> > +/*
> > + * Copyright (c) 2016 Intel Corporation
> > + *
> > + * Driver for Bosch Sensortec BNO055 digital motion sensor.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
>
> I find it useful to state the 7-bit i2c chip address here
>
> > + */
> > +
> > +#define pr_fmt(fmt) "bno055: " fmt
> > +
> > +#include <linux/module.h>
> > +#include <linux/i2c.h>
> > +#include <linux/acpi.h>
> > +#include <linux/regmap.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +
>
> drop one newline
>
> > +
> > +#define BNO055_CHIP_ID               0xA0
> > +#define REG_MAG_RADIUS_MSB   0x6A
>
> please consistently prefix with BNO055_
>
> > +
> > +/* BNO055 configuration registers */
> > +#define REG_PWR_MODE         0x3E
> > +#define REG_OPR_MODE         0x3D
> > +#define REG_UNIT_SEL         0x3B
> > +#define REG_AXIS_MAP_SIGN    0x42
> > +#define REG_AXIS_MAP_CONFIG  0x41
> > +#define REG_UNIT_SEL         0x3B
> > +#define REG_SYS_TRIGGER              0x3F
> > +#define BNO055_REG_PAGE_ID   0x07
> > +#define BNO055_REG_ID                0x00
> > +
> > +/* BNO055 status registers */
> > +#define SYS_STATUS           0x39
> > +#define INT_STATUS           0x37
> > +#define CALIB_STATUS 0x35
> > +
> > +/* BNO055 data registers */
>
> drop newline
>
> > +
> > +#define GRV_DATA_Z_MSB 0x33
> > +#define GRV_DATA_Z_LSB 0x32
> > +#define GRV_DATA_Y_MSB 0x31
> > +#define GRV_DATA_Y_LSB 0x30
> > +#define GRV_DATA_X_MSB 0x2F
> > +#define GRV_DATA_X_LSB 0x2E
>
> do we really need all those register #defines?
> they are not used and noone wants to read just the LSB...
>
> > +
> > +#define LIA_DATA_Z_MSB 0x2D
> > +#define LIA_DATA_Z_LSB 0x2C
> > +#define LIA_DATA_Y_MSB 0x2B
> > +#define LIA_DATA_Y_LSB 0x2A
> > +#define LIA_DATA_X_MSB 0x29
> > +#define LIA_DATA_X_LSB 0x28
> > +
> > +#define QUA_DATA_Z_MSB 0x27
> > +#define QUA_DATA_Z_LSB 0x26
> > +#define QUA_DATA_Y_MSB 0x25
> > +#define QUA_DATA_Y_LSB 0x24
> > +#define QUA_DATA_X_MSB 0x23
> > +#define QUA_DATA_X_LSB 0x22
> > +#define QUA_DATA_W_MSB 0x21
> > +#define QUA_DATA_W_LSB 0x20
> > +
> > +#define EUL_PITCH_MSB 0x1F
> > +#define EUL_PITCH_LSB 0x1E
> > +#define EUL_ROLL_MSB 0x1D
> > +#define EUL_ROLL_LSB 0x1C
> > +#define EUL_HEADING_MSB 0x1B
> > +#define EUL_HEADING_LSB 0x1A
> > +
> > +#define GYR_DATA_Z_MSB 0x19
> > +#define GYR_DATA_Z_LSB 0x18
> > +#define GYR_DATA_Y_MSB 0x17
> > +#define GYR_DATA_Y_LSB 0x16
> > +#define GYR_DATA_X_MSB 0x15
> > +#define GYR_DATA_X_LSB 0x14
> > +
> > +#define MAG_DATA_Z_MSB 0x13
> > +#define MAG_DATA_Z_LSB 0x12
> > +#define MAG_DATA_Y_MSB 0x11
> > +#define MAG_DATA_Y_LSB 0x10
> > +#define MAG_DATA_X_MSB 0x0F
> > +#define MAG_DATA_X_LSB 0x0E
> > +
> > +#define ACC_DATA_Z_MSB 0x0D
> > +#define ACC_DATA_Z_LSB 0x0C
> > +#define ACC_DATA_Y_MSB 0x0B
> > +#define ACC_DATA_Y_LSB 0x0A
> > +#define ACC_DATA_X_MSB 0x09
> > +#define ACC_DATA_X_LSB 0x08
> > +
> > +/* operation modes */
> > +#define FUSION_NDOF_MODE 0x0C
> > +
> > +/* power modes */
> > +#define NORMAL_MODE 0x00
> > +#define LOW_POWER_MODE BIT(0)
> > +#define SUSPEND_MODE BIT(1)
> > +
> > +#define PROPER_CALIBRATION 0xFF
> > +
> > +#define BASE_REG  0x08
> > +#define SENSOR_AXIS_TO_REG(sensor,axis)      (BASE_REG + (sensor * 6) +
> (axis * 2))
> > +
> > +#define BNO055_CHANNEL(_type, _axis) {
>      \
> > +     .type = IIO_##_type,                                            \
> > +     .modified = 1,                                                  \
> > +     .channel2 = IIO_MOD_##_axis,                                    \
> > +     .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),                   \
>
> in what unit is the data returned; please check with IIO ABI documentation
> I think you will likely need _SCALE for some channels
>
> > +     .scan_index = AXIS_##_axis,                                     \
>
> .scan_index is a continuous counter over ALL channels, not just for one
> channel type
>
> the driver does not support buffered reads, so not scan_type/scan_index is
> needed anyway
>
> > +     .scan_type = {                                                  \
> > +             .sign = 's',                                            \
> > +             .realbits = 16,                                 \
> > +             .storagebits = 16,                                      \
> > +             .endianness = IIO_LE,                                   \
> > +     },                                                              \
> > +}
> > +
> > +struct bno055_data {
> > +     struct i2c_client *client;
> > +     struct mutex lock;
> > +     struct regmap *regmap;
> > +};
> > +
> > +enum bno055_axis {
> > +     AXIS_X,
> > +     AXIS_Y,
> > +     AXIS_Z,
> > +};
> > +
> > +enum {ACC=0, MAG=1, GYR=2, EUL=3, QUA=4};
>
> prefix!
>
> > +
> > +static const struct iio_chan_spec bno055_channels[] = {
> > +     BNO055_CHANNEL(ANGL_VEL, X),
> > +     BNO055_CHANNEL(ANGL_VEL, Y),
> > +     BNO055_CHANNEL(ANGL_VEL, Z),
> > +     BNO055_CHANNEL(MAGN, X),
> > +     BNO055_CHANNEL(MAGN, Y),
> > +     BNO055_CHANNEL(MAGN, Z),
> > +     BNO055_CHANNEL(ACCEL, X),
> > +     BNO055_CHANNEL(ACCEL, Y),
> > +     BNO055_CHANNEL(ACCEL, Z),
> > +     {
> > +             .type = IIO_ROT,
> > +             .modified = 1,
> > +             .channel2 = IIO_MOD_QUATERNION,
> > +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > +     }
> > +};
> > +
> > +static bool bno055_is_writeable_reg(struct device *dev, unsigned int
> reg)
> > +{
> > +     switch (reg) {
> > +     case REG_PWR_MODE:
> > +     case REG_OPR_MODE:
> > +     case REG_UNIT_SEL:
> > +     case REG_AXIS_MAP_SIGN:
> > +     case REG_AXIS_MAP_CONFIG:
> > +     case REG_SYS_TRIGGER:
> > +             return true;
> > +     default:
> > +             return false;
> > +     };
> > +}
> > +
> > +static bool bno055_is_volatile_reg(struct device *dev, unsigned int reg)
> > +{
> > +     if ((reg >= ACC_DATA_X_LSB) && (reg <= QUA_DATA_Z_MSB))
> > +             return true;
> > +     else
> > +             return false;
> > +}
> > +
> > +static const struct regmap_config bno055_regmap_config = {
> > +     .reg_bits = 8,
> > +     .val_bits = 8,
> > +
> > +     .max_register = REG_MAG_RADIUS_MSB,
> > +     .cache_type = REGCACHE_RBTREE,
> > +
> > +     .writeable_reg = bno055_is_writeable_reg,
> > +     .volatile_reg = bno055_is_volatile_reg,
> > +};
> > +
>
> drop newline
>
> > +
> > +static int read_bno055(struct bno055_data *data, int sensor, int axis,
> int *val)
>
> bno055 prefix please
>
> > +{
> > +     int ret;
> > +     __le16 raw_val;
> > +     int reg;
> > +
> > +     reg = SENSOR_AXIS_TO_REG(sensor, axis);
>
> you can use .address in channel spec for that
>
> > +
> > +     ret = regmap_bulk_read(data->regmap, reg, &raw_val,
> > +                            sizeof(raw_val));
> > +     if (ret < 0) {
> > +             dev_err(&data->client->dev, "Error reading axis %d\n",
> axis);
> > +             return ret;
> > +     }
> > +
> > +     *val = sign_extend32(le16_to_cpu(raw_val), 15);
> > +     return IIO_VAL_INT;
> > +}
> > +
> > +/* Read raw quaternion values W,X,Y and Z.
> > + * Raw values needs to be divied by the 16384 to get the exact
> quaternion values.
> > + */
> > +
> > +static int read_rot(struct bno055_data *data, int *vals, int *val_len)
> > +{
> > +     int ret, i;
> > +     __le16 raw_val[4];
> > +
> > +     ret = regmap_bulk_read(data->regmap, QUA_DATA_W_LSB, &raw_val,
> > +                            sizeof(raw_val));
> > +     if (ret < 0) {
> > +             dev_err(&data->client->dev, "Error reading Orientation
> \n");
>
> lowercase orientation
> delete space before \n
>
> > +             return ret;
> > +     }
> > +
> > +     for (i = 0; i < 4; ++i)
> > +             vals[i] = sign_extend32(le16_to_cpu(raw_val[i]), 15);
> > +
> > +     *val_len =  4;
> > +     return IIO_VAL_INT_MULTIPLE;
> > +}
> > +
> > +static int bno055_read_raw_multi(struct iio_dev *indio_dev,
> > +                        struct iio_chan_spec const *chan, int size,
> > +                        int *val, int *val2, long mask)
> > +{
> > +     int ret = -EINVAL;
> > +     struct bno055_data *data = iio_priv(indio_dev);
> > +
> > +     mutex_lock(&data->lock);
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_RAW:
> > +             switch (chan->type) {
> > +             case IIO_ROT:
> > +                     ret = read_rot(data, val, val2);
> > +                     break;
> > +             case IIO_ANGL_VEL:
> > +                     /* Gyroscope unit degrees per second */
> > +                     /* Raw value needs to be divied by the 16 to get
> the exact value.*/
>
> comment style, not a proper multi-line comment
> use _SCALE, it is not about 'exact' but correct scaling/unit
> typo: divided
> wording: divided by 16
>
> > +                     ret = read_bno055(data, GYR, chan->scan_index,
> val);
> > +                     break;
> > +             case IIO_ACCEL:
> > +                     /* Accelerometer Unit m/s2 */
> > +                     /* Raw value needs to be divied by the 100 to get
> the exact value.*/
> > +                     ret = read_bno055(data, ACC, chan->scan_index,
> val);
> > +                     break;
> > +             case IIO_MAGN:
> > +                     /* Magnetometer Unit microTesla */
> > +                     /* Raw value needs to be divied by the 16 to get
> the exact value. */
> > +                     ret = read_bno055(data, MAG, chan->scan_index,
> val);
> > +                     break;
> > +             default:
> > +                     ret = -EINVAL;
> > +                     break;
> > +             }
> > +             break;
> > +
> > +     default:
> > +             ret = -EINVAL;
> > +             break;
> > +     }
> > +
> > +     mutex_unlock(&data->lock);
> > +
> > +     return ret;
> > +}
> > +
> > +static const struct iio_info bno055_info = {
> > +     .driver_module = THIS_MODULE,
> > +     .read_raw_multi = &bno055_read_raw_multi,
> > +};
> > +
>
> drop newline
>
> > +
> > +static int bno055_chip_init(struct bno055_data *data)
> > +{
> > +     int ret;
> > +
> > +     ret = regmap_write(data->regmap, REG_PWR_MODE,
> > +                              NORMAL_MODE);
> > +     if (ret < 0) {
> > +             dev_err(&data->client->dev,
> > +                     "failed to write power mode register\n");
> > +             return ret;
> > +     }
> > +
> > +     ret = regmap_write(data->regmap, REG_OPR_MODE,
> > +                              FUSION_NDOF_MODE);
> > +     if (ret < 0)
> > +             dev_err(&data->client->dev,
> > +                     "failed to write operation mode register\n");
> > +
> > +     return ret;
> > +}
> > +
> > +static ssize_t show_calibration_status(struct device *dev, struct
> device_attribute *attr,
> > +                char *buf){
>
> this is private API which needs to be documented
>
> > +     struct bno055_data *data;
> > +     int ret;
> > +     unsigned int calib_stat;
> > +
> > +     data = dev->driver_data;
> > +
> > +     ret = regmap_read(data->regmap, CALIB_STATUS, &calib_stat);
> > +
> > +     if (ret){
>
> space before {
>
> > +             dev_err(dev, "Failed to read calibration status.\n");
> > +             return ret;
> > +     }
> > +
> > +     if (calib_stat != PROPER_CALIBRATION)
> > +             dev_info(dev, "bad calibration.  expected %x got %x\n",
>
> two spaces before 'expected'
>
> > +                     PROPER_CALIBRATION, calib_stat);
> > +
> > +     return scnprintf(buf, PAGE_SIZE, "0x%x\n", calib_stat);
> > +}
> > +
> > +static DEVICE_ATTR(calib_status, 0444, show_calibration_status, NULL);
> > +
> > +static int bno055_probe(struct i2c_client *client,
> > +                     const struct i2c_device_id *id)
> > +{
> > +     int ret;
> > +     struct iio_dev *indio_dev;
> > +     struct bno055_data *data;
> > +     unsigned int chip_id;
> > +
> > +     indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> > +     if (!indio_dev)
> > +             return -ENOMEM;
> > +
> > +     data = iio_priv(indio_dev);
> > +     mutex_init(&data->lock);
> > +     data->client = client;
> > +
> > +     indio_dev->dev.parent = &client->dev;
> > +     indio_dev->name = id->name;
> > +     indio_dev->channels = bno055_channels;
> > +     indio_dev->num_channels = ARRAY_SIZE(bno055_channels);
> > +     indio_dev->info = &bno055_info;
> > +     indio_dev->modes = INDIO_DIRECT_MODE;
> > +
> > +     data->regmap = devm_regmap_init_i2c(client, &bno055_regmap_config);
> > +     if (IS_ERR(data->regmap)) {
> > +             dev_err(&client->dev, "Failed to allocate register
> map.\n");
> > +             return PTR_ERR(data->regmap);
> > +     }
> > +
> > +     indio_dev->dev.driver_data = data;
> > +     i2c_set_clientdata(client, indio_dev);
> > +
> > +     ret = regmap_read(data->regmap, BNO055_REG_ID, &chip_id);
> > +     if (ret < 0)
> > +             return ret;
> > +     if (chip_id != BNO055_CHIP_ID) {
> > +             dev_err(&client->dev, "bad chip id.  expected %x got %x\n",
> > +                     BNO055_CHIP_ID, chip_id);
> > +             return -EINVAL;
> > +     }
> > +
> > +     ret = bno055_chip_init(data);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret = devm_iio_device_register(&client->dev, indio_dev);
> > +     if (ret){
>
> space before {
>
> > +             dev_err(&client->dev, "failed to register IIO device.\n");
> > +             return ret;
> > +     }
> > +
> > +     ret = device_create_file(&indio_dev->dev, &dev_attr_calib_status);
>
> needs to be done BEFORE devm_iio_device_register()
> IIO has specific mechanisms to create custom sysfs entries...
>
> > +     if (ret){
>
> space before {
>
> > +             dev_err(&client->dev, "failed to create sysfs entry.\n");
> > +             devm_iio_device_unregister(&client->dev, indio_dev);
>
> no need to call devm_iio_device_unregister
>
> > +             return ret;
> > +     }
> > +
> > +   return ret;
> > +}
> > +
> > +static int bno055_remove(struct i2c_client *client)
> > +{
> > +     struct iio_dev *indio_dev = i2c_get_clientdata(client);
> > +
> > +     device_remove_file(&indio_dev->dev, &dev_attr_calib_status);
> > +     devm_iio_device_unregister(&client->dev, indio_dev);
> > +     return 0;
> > +}
> > +
> > +static const struct acpi_device_id bno055_acpi_match[] = {
> > +     {"bno055", 0},
> > +     { },
> > +};
> > +MODULE_DEVICE_TABLE(acpi, bno055_acpi_match);
> > +
> > +static const struct i2c_device_id bno055_id[] = {
> > +     {"bno055", 0},
> > +     { },
> > +};
> > +MODULE_DEVICE_TABLE(i2c, bno055_id);
> > +
> > +static struct i2c_driver bno055_driver = {
> > +     .driver = {
> > +             .name   = "bno055",
> > +             .acpi_match_table = ACPI_PTR(bno055_acpi_match),
> > +     },
> > +     .probe          = bno055_probe,
> > +     .remove         = bno055_remove,
> > +     .id_table       = bno055_id,
> > +};
> > +module_i2c_driver(bno055_driver);
> > +
> > +MODULE_AUTHOR("navin patidar <navin.patidar@gmail.com>");
> > +MODULE_DESCRIPTION("Driver for Bosch Sensortec BNO055 orientation
> sensor");
> > +MODULE_LICENSE("GPL v2");
> >
>
> --
>
> Peter Meerwald-Stadler
> +43-664-2444418 (mobile)
>

--94eb2c05415c01ca2705388e37c6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Peter,<div><br></div><div>Thanks for reviewing the patc=
h. I will send the updated patch.</div><div><br></div><div>regards,</div><d=
iv>--navin-patidar</div></div><div class=3D"gmail_extra"><br><div class=3D"=
gmail_quote">On Tue, Jul 26, 2016 at 1:07 AM, Peter Meerwald-Stadler <span =
dir=3D"ltr">&lt;<a href=3D"mailto:pmeerw@pmeerw.net" target=3D"_blank">pmee=
rw@pmeerw.net</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span=
 class=3D""><br>
&gt; BNO055 provides the following motion sensors data:<br>
&gt;<br>
&gt;=C2=A0 * Gyroscope<br>
&gt;=C2=A0 * Accelerometer<br>
&gt;=C2=A0 * Magnetometer<br>
&gt;=C2=A0 * Absolute Orientation (Quaternion)<br>
<br>
</span>comments below<br>
<div><div class=3D"h5"><br>
&gt; Signed-off-by: navin patidar &lt;<a href=3D"mailto:navin.patidar@gmail=
.com">navin.patidar@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/iio/orientation/Kconfig=C2=A0 |=C2=A0 10 +<br>
&gt;=C2=A0 drivers/iio/orientation/Makefile |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 drivers/iio/orientation/bno055.c | 422 +++++++++++++++++++++++++=
++++++++++++++<br>
&gt;=C2=A0 3 files changed, 433 insertions(+)<br>
&gt;=C2=A0 create mode 100644 drivers/iio/orientation/bno055.c<br>
&gt;<br>
&gt; diff --git a/drivers/iio/orientation/Kconfig b/drivers/iio/orientation=
/Kconfig<br>
&gt; index e3aa1e5..9ac21ee 100644<br>
&gt; --- a/drivers/iio/orientation/Kconfig<br>
&gt; +++ b/drivers/iio/orientation/Kconfig<br>
&gt; @@ -28,4 +28,14 @@ config HID_SENSOR_DEVICE_ROTATION<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0device rotation. The output of a devi=
ce rotation sensor<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0is presented using quaternion format.=
<br>
&gt;<br>
&gt; +config BNO055<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tristate &quot;BOSCH BNO055 Absolute Orientation&=
quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0depends on I2C<br>
&gt; +=C2=A0 =C2=A0 =C2=A0select REGMAP_I2C<br>
&gt; +=C2=A0 =C2=A0 =C2=A0help<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0Say yes here to build support for BOSCH BN=
O55 9-axis absolute orientation sensor<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0driver connected via I2C.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0This driver can also be built as a module.=
 If so, the module<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0will be called bno055.<br>
&gt; +<br>
&gt;=C2=A0 endmenu<br>
&gt; diff --git a/drivers/iio/orientation/Makefile b/drivers/iio/orientatio=
n/Makefile<br>
&gt; index 4734dab..7d00037 100644<br>
&gt; --- a/drivers/iio/orientation/Makefile<br>
&gt; +++ b/drivers/iio/orientation/Makefile<br>
&gt; @@ -5,3 +5,4 @@<br>
&gt;=C2=A0 # When adding new entries keep the list in alphabetical order<br=
>
&gt;=C2=A0 obj-$(CONFIG_HID_SENSOR_INCLINOMETER_3D) +=3D hid-sensor-incl-3d=
.o<br>
&gt;=C2=A0 obj-$(CONFIG_HID_SENSOR_DEVICE_ROTATION) +=3D hid-sensor-rotatio=
n.o<br>
&gt; +obj-$(CONFIG_BNO055) +=3D bno055.o<br>
&gt; diff --git a/drivers/iio/orientation/bno055.c b/drivers/iio/orientatio=
n/bno055.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..48b9e93<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/iio/orientation/bno055.c<br>
&gt; @@ -0,0 +1,422 @@<br>
&gt; +/*<br>
&gt; + * Copyright (c) 2016 Intel Corporation<br>
&gt; + *<br>
&gt; + * Driver for Bosch Sensortec BNO055 digital motion sensor.<br>
&gt; + *<br>
&gt; + * This program is free software; you can redistribute it and/or modi=
fy<br>
&gt; + * it under the terms of the GNU General Public License version 2 as<=
br>
&gt; + * published by the Free Software Foundation.<br>
&gt; + *<br>
<br>
</div></div>I find it useful to state the 7-bit i2c chip address here<br>
<span class=3D""><br>
&gt; + */<br>
&gt; +<br>
&gt; +#define pr_fmt(fmt) &quot;bno055: &quot; fmt<br>
&gt; +<br>
&gt; +#include &lt;linux/module.h&gt;<br>
&gt; +#include &lt;linux/i2c.h&gt;<br>
&gt; +#include &lt;linux/acpi.h&gt;<br>
&gt; +#include &lt;linux/regmap.h&gt;<br>
&gt; +#include &lt;linux/iio/iio.h&gt;<br>
&gt; +#include &lt;linux/iio/sysfs.h&gt;<br>
&gt; +<br>
<br>
</span>drop one newline<br>
<span class=3D""><br>
&gt; +<br>
&gt; +#define BNO055_CHIP_ID=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A00xA0<br>
&gt; +#define REG_MAG_RADIUS_MSB=C2=A0 =C2=A00x6A<br>
<br>
</span>please consistently prefix with BNO055_<br>
<span class=3D""><br>
&gt; +<br>
&gt; +/* BNO055 configuration registers */<br>
&gt; +#define REG_PWR_MODE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x3E<br>
&gt; +#define REG_OPR_MODE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x3D<br>
&gt; +#define REG_UNIT_SEL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x3B<br>
&gt; +#define REG_AXIS_MAP_SIGN=C2=A0 =C2=A0 0x42<br>
&gt; +#define REG_AXIS_MAP_CONFIG=C2=A0 0x41<br>
&gt; +#define REG_UNIT_SEL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x3B<br>
&gt; +#define REG_SYS_TRIGGER=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0x3F<br>
&gt; +#define BNO055_REG_PAGE_ID=C2=A0 =C2=A00x07<br>
&gt; +#define BNO055_REG_ID=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 0x00<br>
&gt; +<br>
&gt; +/* BNO055 status registers */<br>
&gt; +#define SYS_STATUS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x39<br>
&gt; +#define INT_STATUS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x37<br>
&gt; +#define CALIB_STATUS 0x35<br>
&gt; +<br>
&gt; +/* BNO055 data registers */<br>
<br>
</span>drop newline<br>
<span class=3D""><br>
&gt; +<br>
&gt; +#define GRV_DATA_Z_MSB 0x33<br>
&gt; +#define GRV_DATA_Z_LSB 0x32<br>
&gt; +#define GRV_DATA_Y_MSB 0x31<br>
&gt; +#define GRV_DATA_Y_LSB 0x30<br>
&gt; +#define GRV_DATA_X_MSB 0x2F<br>
&gt; +#define GRV_DATA_X_LSB 0x2E<br>
<br>
</span>do we really need all those register #defines?<br>
they are not used and noone wants to read just the LSB...<br>
<div><div class=3D"h5"><br>
&gt; +<br>
&gt; +#define LIA_DATA_Z_MSB 0x2D<br>
&gt; +#define LIA_DATA_Z_LSB 0x2C<br>
&gt; +#define LIA_DATA_Y_MSB 0x2B<br>
&gt; +#define LIA_DATA_Y_LSB 0x2A<br>
&gt; +#define LIA_DATA_X_MSB 0x29<br>
&gt; +#define LIA_DATA_X_LSB 0x28<br>
&gt; +<br>
&gt; +#define QUA_DATA_Z_MSB 0x27<br>
&gt; +#define QUA_DATA_Z_LSB 0x26<br>
&gt; +#define QUA_DATA_Y_MSB 0x25<br>
&gt; +#define QUA_DATA_Y_LSB 0x24<br>
&gt; +#define QUA_DATA_X_MSB 0x23<br>
&gt; +#define QUA_DATA_X_LSB 0x22<br>
&gt; +#define QUA_DATA_W_MSB 0x21<br>
&gt; +#define QUA_DATA_W_LSB 0x20<br>
&gt; +<br>
&gt; +#define EUL_PITCH_MSB 0x1F<br>
&gt; +#define EUL_PITCH_LSB 0x1E<br>
&gt; +#define EUL_ROLL_MSB 0x1D<br>
&gt; +#define EUL_ROLL_LSB 0x1C<br>
&gt; +#define EUL_HEADING_MSB 0x1B<br>
&gt; +#define EUL_HEADING_LSB 0x1A<br>
&gt; +<br>
&gt; +#define GYR_DATA_Z_MSB 0x19<br>
&gt; +#define GYR_DATA_Z_LSB 0x18<br>
&gt; +#define GYR_DATA_Y_MSB 0x17<br>
&gt; +#define GYR_DATA_Y_LSB 0x16<br>
&gt; +#define GYR_DATA_X_MSB 0x15<br>
&gt; +#define GYR_DATA_X_LSB 0x14<br>
&gt; +<br>
&gt; +#define MAG_DATA_Z_MSB 0x13<br>
&gt; +#define MAG_DATA_Z_LSB 0x12<br>
&gt; +#define MAG_DATA_Y_MSB 0x11<br>
&gt; +#define MAG_DATA_Y_LSB 0x10<br>
&gt; +#define MAG_DATA_X_MSB 0x0F<br>
&gt; +#define MAG_DATA_X_LSB 0x0E<br>
&gt; +<br>
&gt; +#define ACC_DATA_Z_MSB 0x0D<br>
&gt; +#define ACC_DATA_Z_LSB 0x0C<br>
&gt; +#define ACC_DATA_Y_MSB 0x0B<br>
&gt; +#define ACC_DATA_Y_LSB 0x0A<br>
&gt; +#define ACC_DATA_X_MSB 0x09<br>
&gt; +#define ACC_DATA_X_LSB 0x08<br>
&gt; +<br>
&gt; +/* operation modes */<br>
&gt; +#define FUSION_NDOF_MODE 0x0C<br>
&gt; +<br>
&gt; +/* power modes */<br>
&gt; +#define NORMAL_MODE 0x00<br>
&gt; +#define LOW_POWER_MODE BIT(0)<br>
&gt; +#define SUSPEND_MODE BIT(1)<br>
&gt; +<br>
&gt; +#define PROPER_CALIBRATION 0xFF<br>
&gt; +<br>
&gt; +#define BASE_REG=C2=A0 0x08<br>
&gt; +#define SENSOR_AXIS_TO_REG(sensor,axis)=C2=A0 =C2=A0 =C2=A0 (BASE_REG=
 + (sensor * 6) + (axis * 2))<br>
&gt; +<br>
&gt; +#define BNO055_CHANNEL(_type, _axis) {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.type =3D IIO_##_type,=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.modified =3D 1,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.channel2 =3D IIO_MOD_##_axis,=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
<br>
</div></div>in what unit is the data returned; please check with IIO ABI do=
cumentation<br>
I think you will likely need _SCALE for some channels<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.scan_index =3D AXIS_##_axis,=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
<br>
.scan_index is a continuous counter over ALL channels, not just for one<br>
channel type<br>
<br>
the driver does not support buffered reads, so not scan_type/scan_index is<=
br>
needed anyway<br>
<span class=3D""><br>
&gt; +=C2=A0 =C2=A0 =C2=A0.scan_type =3D {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.sign =3D &#39;s&#39;=
,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.realbits =3D 16,=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.storagebits =3D 16,=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.endianness =3D IIO_L=
E,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 =C2=A0},=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +}<br>
&gt; +<br>
&gt; +struct bno055_data {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct i2c_client *client;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct mutex lock;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct regmap *regmap;<br>
&gt; +};<br>
&gt; +<br>
&gt; +enum bno055_axis {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0AXIS_X,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0AXIS_Y,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0AXIS_Z,<br>
&gt; +};<br>
&gt; +<br>
&gt; +enum {ACC=3D0, MAG=3D1, GYR=3D2, EUL=3D3, QUA=3D4};<br>
<br>
</span>prefix!<br>
<div><div class=3D"h5"><br>
&gt; +<br>
&gt; +static const struct iio_chan_spec bno055_channels[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0BNO055_CHANNEL(ANGL_VEL, X),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0BNO055_CHANNEL(ANGL_VEL, Y),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0BNO055_CHANNEL(ANGL_VEL, Z),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0BNO055_CHANNEL(MAGN, X),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0BNO055_CHANNEL(MAGN, Y),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0BNO055_CHANNEL(MAGN, Z),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0BNO055_CHANNEL(ACCEL, X),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0BNO055_CHANNEL(ACCEL, Y),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0BNO055_CHANNEL(ACCEL, Z),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.type =3D IIO_ROT,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.modified =3D 1,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.channel2 =3D IIO_MOD=
_QUATERNION,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.info_mask_separate =
=3D BIT(IIO_CHAN_INFO_RAW),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +};<br>
&gt; +<br>
&gt; +static bool bno055_is_writeable_reg(struct device *dev, unsigned int =
reg)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0switch (reg) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case REG_PWR_MODE:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case REG_OPR_MODE:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case REG_UNIT_SEL:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case REG_AXIS_MAP_SIGN:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case REG_AXIS_MAP_CONFIG:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case REG_SYS_TRIGGER:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0};<br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool bno055_is_volatile_reg(struct device *dev, unsigned int r=
eg)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if ((reg &gt;=3D ACC_DATA_X_LSB) &amp;&amp; (reg =
&lt;=3D QUA_DATA_Z_MSB))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct regmap_config bno055_regmap_config =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.reg_bits =3D 8,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.val_bits =3D 8,<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.max_register =3D REG_MAG_RADIUS_MSB,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.cache_type =3D REGCACHE_RBTREE,<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.writeable_reg =3D bno055_is_writeable_reg,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.volatile_reg =3D bno055_is_volatile_reg,<br>
&gt; +};<br>
&gt; +<br>
<br>
</div></div>drop newline<br>
<span class=3D""><br>
&gt; +<br>
&gt; +static int read_bno055(struct bno055_data *data, int sensor, int axis=
, int *val)<br>
<br>
</span>bno055 prefix please<br>
<span class=3D""><br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0__le16 raw_val;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int reg;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0reg =3D SENSOR_AXIS_TO_REG(sensor, axis);<br>
<br>
</span>you can use .address in channel spec for that<br>
<div><div class=3D"h5"><br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D regmap_bulk_read(data-&gt;regmap, reg, &a=
mp;raw_val,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(raw_val));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;data-&gt=
;client-&gt;dev, &quot;Error reading axis %d\n&quot;, axis);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*val =3D sign_extend32(le16_to_cpu(raw_val), 15);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return IIO_VAL_INT;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* Read raw quaternion values W,X,Y and Z.<br>
&gt; + * Raw values needs to be divied by the 16384 to get the exact quater=
nion values.<br>
&gt; + */<br>
&gt; +<br>
&gt; +static int read_rot(struct bno055_data *data, int *vals, int *val_len=
)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret, i;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0__le16 raw_val[4];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D regmap_bulk_read(data-&gt;regmap, QUA_DAT=
A_W_LSB, &amp;raw_val,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(raw_val));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;data-&gt=
;client-&gt;dev, &quot;Error reading Orientation \n&quot;);<br>
<br>
</div></div>lowercase orientation<br>
delete space before \n<br>
<div><div class=3D"h5"><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; 4; ++i)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vals[i] =3D sign_exte=
nd32(le16_to_cpu(raw_val[i]), 15);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*val_len =3D=C2=A0 4;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return IIO_VAL_INT_MULTIPLE;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int bno055_read_raw_multi(struct iio_dev *indio_dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 struct iio_chan_spec const *chan, int size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 int *val, int *val2, long mask)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret =3D -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct bno055_data *data =3D iio_priv(indio_dev);=
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;data-&gt;lock);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0switch (mask) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case IIO_CHAN_INFO_RAW:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (chan-&gt;type=
) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IIO_ROT:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ret =3D read_rot(data, val, val2);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IIO_ANGL_VEL:<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0/* Gyroscope unit degrees per second */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0/* Raw value needs to be divied by the 16 to get the exact value.*/<=
br>
<br>
</div></div>comment style, not a proper multi-line comment<br>
use _SCALE, it is not about &#39;exact&#39; but correct scaling/unit<br>
typo: divided<br>
wording: divided by 16<br>
<div><div class=3D"h5"><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ret =3D read_bno055(data, GYR, chan-&gt;scan_index, val);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IIO_ACCEL:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0/* Accelerometer Unit m/s2 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0/* Raw value needs to be divied by the 100 to get the exact value.*/=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ret =3D read_bno055(data, ACC, chan-&gt;scan_index, val);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IIO_MAGN:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0/* Magnetometer Unit microTesla */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0/* Raw value needs to be divied by the 16 to get the exact value. */=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ret =3D read_bno055(data, MAG, chan-&gt;scan_index, val);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ret =3D -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;data-&gt;lock);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct iio_info bno055_info =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.driver_module =3D THIS_MODULE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.read_raw_multi =3D &amp;bno055_read_raw_multi,<b=
r>
&gt; +};<br>
&gt; +<br>
<br>
</div></div>drop newline<br>
<span class=3D""><br>
&gt; +<br>
&gt; +static int bno055_chip_init(struct bno055_data *data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D regmap_write(data-&gt;regmap, REG_PWR_MOD=
E,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NORMAL_MODE);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;data-&gt=
;client-&gt;dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&quot;failed to write power mode register\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D regmap_write(data-&gt;regmap, REG_OPR_MOD=
E,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FUSION_NDOF_MODE);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;data-&gt=
;client-&gt;dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&quot;failed to write operation mode register\n&quot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static ssize_t show_calibration_status(struct device *dev, struct dev=
ice_attribute *attr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *buf){<b=
r>
<br>
</span>this is private API which needs to be documented<br>
<span class=3D""><br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct bno055_data *data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int calib_stat;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0data =3D dev-&gt;driver_data;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D regmap_read(data-&gt;regmap, CALIB_STATUS=
, &amp;calib_stat);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret){<br>
<br>
</span>space before {<br>
<span class=3D""><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev, &quot;Fa=
iled to read calibration status.\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (calib_stat !=3D PROPER_CALIBRATION)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_info(dev, &quot;b=
ad calibration.=C2=A0 expected %x got %x\n&quot;,<br>
<br>
</span>two spaces before &#39;expected&#39;<br>
<div><div class=3D"h5"><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0PROPER_CALIBRATION, calib_stat);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return scnprintf(buf, PAGE_SIZE, &quot;0x%x\n&quo=
t;, calib_stat);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static DEVICE_ATTR(calib_status, 0444, show_calibration_status, NULL)=
;<br>
&gt; +<br>
&gt; +static int bno055_probe(struct i2c_client *client,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0const struct i2c_device_id *id)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct iio_dev *indio_dev;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct bno055_data *data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int chip_id;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0indio_dev =3D devm_iio_device_alloc(&amp;client-&=
gt;dev, sizeof(*data));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!indio_dev)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0data =3D iio_priv(indio_dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mutex_init(&amp;data-&gt;lock);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0data-&gt;client =3D client;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0indio_dev-&gt;dev.parent =3D &amp;client-&gt;dev;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0indio_dev-&gt;name =3D id-&gt;name;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0indio_dev-&gt;channels =3D bno055_channels;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0indio_dev-&gt;num_channels =3D ARRAY_SIZE(bno055_=
channels);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0indio_dev-&gt;info =3D &amp;bno055_info;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0indio_dev-&gt;modes =3D INDIO_DIRECT_MODE;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0data-&gt;regmap =3D devm_regmap_init_i2c(client, =
&amp;bno055_regmap_config);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (IS_ERR(data-&gt;regmap)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;client-&=
gt;dev, &quot;Failed to allocate register map.\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_ERR(data-&=
gt;regmap);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0indio_dev-&gt;dev.driver_data =3D data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0i2c_set_clientdata(client, indio_dev);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D regmap_read(data-&gt;regmap, BNO055_REG_I=
D, &amp;chip_id);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (chip_id !=3D BNO055_CHIP_ID) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;client-&=
gt;dev, &quot;bad chip id.=C2=A0 expected %x got %x\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0BNO055_CHIP_ID, chip_id);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D bno055_chip_init(data);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D devm_iio_device_register(&amp;client-&gt;=
dev, indio_dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret){<br>
<br>
</div></div>space before {<br>
<span class=3D""><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;client-&=
gt;dev, &quot;failed to register IIO device.\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D device_create_file(&amp;indio_dev-&gt;dev=
, &amp;dev_attr_calib_status);<br>
<br>
</span>needs to be done BEFORE devm_iio_device_register()<br>
IIO has specific mechanisms to create custom sysfs entries...<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret){<br>
<br>
space before {<br>
<span class=3D""><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;client-&=
gt;dev, &quot;failed to create sysfs entry.\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0devm_iio_device_unreg=
ister(&amp;client-&gt;dev, indio_dev);<br>
<br>
</span>no need to call devm_iio_device_unregister<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int bno055_remove(struct i2c_client *client)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct iio_dev *indio_dev =3D i2c_get_clientdata(=
client);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0device_remove_file(&amp;indio_dev-&gt;dev, &amp;d=
ev_attr_calib_status);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0devm_iio_device_unregister(&amp;client-&gt;dev, i=
ndio_dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct acpi_device_id bno055_acpi_match[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{&quot;bno055&quot;, 0},<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ },<br>
&gt; +};<br>
&gt; +MODULE_DEVICE_TABLE(acpi, bno055_acpi_match);<br>
&gt; +<br>
&gt; +static const struct i2c_device_id bno055_id[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{&quot;bno055&quot;, 0},<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ },<br>
&gt; +};<br>
&gt; +MODULE_DEVICE_TABLE(i2c, bno055_id);<br>
&gt; +<br>
&gt; +static struct i2c_driver bno055_driver =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.driver =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0=3D=
 &quot;bno055&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.acpi_match_table =3D=
 ACPI_PTR(bno055_acpi_match),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0},<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.probe=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D bno0=
55_probe,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.remove=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D bno0=
55_remove,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.id_table=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D bno055_id=
,<br>
&gt; +};<br>
&gt; +module_i2c_driver(bno055_driver);<br>
&gt; +<br>
&gt; +MODULE_AUTHOR(&quot;navin patidar &lt;<a href=3D"mailto:navin.patidar=
@gmail.com">navin.patidar@gmail.com</a>&gt;&quot;);<br>
&gt; +MODULE_DESCRIPTION(&quot;Driver for Bosch Sensortec BNO055 orientatio=
n sensor&quot;);<br>
&gt; +MODULE_LICENSE(&quot;GPL v2&quot;);<br>
&gt;<br>
<br>
--<br>
<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">Peter Meerwald-S=
tadler<br>
<a href=3D"tel:%2B43-664-2444418" value=3D"+436642444418">+43-664-2444418</=
a>=C2=A0(mobile)<br>
</font></span></blockquote></div><br></div>

--94eb2c05415c01ca2705388e37c6--
