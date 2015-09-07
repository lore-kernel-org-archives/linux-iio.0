Return-Path: <george.mccollister@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1441593547-10896-5-git-send-email-mranostay@gmail.com>
References: <1441593547-10896-1-git-send-email-mranostay@gmail.com>
	<1441593547-10896-5-git-send-email-mranostay@gmail.com>
Date: Sun, 6 Sep 2015 22:13:09 -0500
Message-ID: <CAFSKS=NvhBvwknAXs-Pfd-bJ4U6zrXD3zBZT0GaC+w5JUg24ig@mail.gmail.com>
Subject: Re: [RFC v2 4/4] iio: chemical: add SGX VZ89x VOC sensor support
From: George McCollister <george.mccollister@gmail.com>
To: Matt Ranostay <mranostay@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"open list:IIO SUBSYSTEM AND..." <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>
Content-Type: multipart/alternative; boundary=001a113ed8e20db0aa051f1fa1a9
List-ID: <linux-iio@vger.kernel.org>

--001a113ed8e20db0aa051f1fa1a9
Content-Type: text/plain; charset=UTF-8

On Sun, Sep 6, 2015 at 9:39 PM, Matt Ranostay <mranostay@gmail.com> wrote:

> Add support for VZ89X sensors VOC and CO2 reporting channels in
> percentage which can be converted to part per million.
>
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
> ---
>  .../ABI/testing/sysfs-bus-iio-chemical-vz89x       |  30 +++
>  .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
>  drivers/iio/Kconfig                                |   1 +
>  drivers/iio/Makefile                               |   1 +
>  drivers/iio/chemical/Makefile                      |   6 +
>  drivers/iio/chemical/vz89x.c                       | 236
> +++++++++++++++++++++
>  6 files changed, 275 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-chemical-vz89x
>  create mode 100644 drivers/iio/chemical/Makefile
>  create mode 100644 drivers/iio/chemical/vz89x.c
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-chemical-vz89x
> b/Documentation/ABI/testing/sysfs-bus-iio-chemical-vz89x
> new file mode 100644
> index 0000000..74f2a35
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-chemical-vz89x
> @@ -0,0 +1,30 @@
> +What:          /sys/bus/iio/devices/iio:deviceX/in_concentration_CO2_raw
> +Date:          September 2015
> +KernelVersion: 4.3
> +Contact:       Matt Ranostay <mranostay@gmail.com>
> +Description:
> +               Get the unscaled, and no offset applied CO2 gas percentage
> +               value.
> +
> +What:
> /sys/bus/iio/devices/iio:deviceX/in_concentration_VOC_short_raw
> +Date:          September 2015
> +KernelVersion: 4.3
> +Contact:       Matt Ranostay <mranostay@gmail.com>
> +Description:
> +               Get the raw calibration VOC value from the sensor.
> +               This value has little application outside of calibration.
> +
> +What:          /sys/bus/iio/devices/iio:deviceX/in_concentration_tVOC_raw
> +Date:          September 2015
> +KernelVersion: 4.3
> +Contact:       Matt Ranostay <mranostay@gmail.com>
> +Description:
> +               Get the unscaled, and no offset applied total VOC gas
> +               percentage value.
> +
> +What:          /sys/bus/iio/devices/iio:deviceX/in_resistance_raw
> +Date:          September 2015
> +KernelVersion: 4.3
> +Contact:       Matt Ranostay <mranostay@gmail.com>
> +Description:
> +               Get the unscaled sensor resistance value.
> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> index d77d412..a550216 100644
> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> @@ -88,6 +88,7 @@ ricoh,rs5c372b                I2C bus SERIAL INTERFACE
> REAL-TIME CLOCK IC
>  ricoh,rv5c386          I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
>  ricoh,rv5c387a         I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
>  samsung,24ad0xd1       S524AD0XF1 (128K/256K-bit Serial EEPROM for Low
> Power)
> +sgx,vz89x              SGX Sensortech VZ89X Sensors
>  sii,s35390a            2-wire CMOS real-time clock
>  skyworks,sky81452      Skyworks SKY81452: Six-Channel White LED Driver
> with Touch Panel Bias Supply
>  st-micro,24c256                i2c serial eeprom  (24cxx)
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index 4011eff..9664e9c 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -61,6 +61,7 @@ config IIO_CONSUMERS_PER_TRIGGER
>  source "drivers/iio/accel/Kconfig"
>  source "drivers/iio/adc/Kconfig"
>  source "drivers/iio/amplifiers/Kconfig"
> +source "drivers/iio/chemical/Kconfig"
>  source "drivers/iio/common/Kconfig"
>  source "drivers/iio/dac/Kconfig"
>  source "drivers/iio/frequency/Kconfig"
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index 698afc2..2288684 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_IIO_KFIFO_BUF) += kfifo_buf.o
>  obj-y += accel/
>  obj-y += adc/
>  obj-y += amplifiers/
> +obj-y += chemical/
>  obj-y += common/
>  obj-y += dac/
>  obj-y += gyro/
> diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
> new file mode 100644
> index 0000000..7292f2d
> --- /dev/null
> +++ b/drivers/iio/chemical/Makefile
> @@ -0,0 +1,6 @@
> +#
> +# Makefile for IIO chemical sensors
> +#
> +
> +# When adding new entries keep the list in alphabetical order
> +obj-$(CONFIG_VZ89X)            += vz89x.o
> diff --git a/drivers/iio/chemical/vz89x.c b/drivers/iio/chemical/vz89x.c
> new file mode 100644
> index 0000000..ac381cc
> --- /dev/null
> +++ b/drivers/iio/chemical/vz89x.c
> @@ -0,0 +1,236 @@
> +/*
> + * vz89x.c - Support for SGX Sensortech MiCS VZ89X VOC sensors
> + *
> + * Copyright (C) 2015 Matt Ranostay <mranostay@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/init.h>
> +#include <linux/i2c.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +#define VZ89X_REG_MEASUREMENT          0x09
> +#define VZ89X_REG_MEASUREMENT_SIZE     6
> +
> +#define VZ89X_VOC_CO2_IDX              0
> +#define VZ89X_VOC_SHORT_IDX            1
> +#define VZ89X_VOC_TVOC_IDX             2
> +#define VZ89X_VOC_RESISTANCE_IDX       3
> +
> +struct vz89x_data {
> +       struct i2c_client *client;
> +       struct mutex lock;
> +       unsigned long last_update;
> +
> +       u8 buffer[VZ89X_REG_MEASUREMENT_SIZE];
> +};
> +
> +static const struct iio_chan_spec vz89x_channels[] = {
> +       {
> +               .type = IIO_CONCENTRATION,
> +               .info_mask_separate = BIT(IIO_CHAN_INFO_OFFSET) |
> +                       BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +               .address = VZ89X_VOC_CO2_IDX,
> +               .extend_name = "CO2",
> +       },
> +       {
> +               .type = IIO_CONCENTRATION,
> +               .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +               .address = VZ89X_VOC_SHORT_IDX,
> +               .extend_name = "VOC_short",
> +       },
> +       {
> +               .type = IIO_CONCENTRATION,
> +               .info_mask_separate =
> +                       BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +               .address = VZ89X_VOC_TVOC_IDX,
> +               .extend_name = "tVOC",
> +       },
> +       {
> +               .type = IIO_RESISTANCE,
> +               .info_mask_separate =
> +                       BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +               .address = VZ89X_VOC_RESISTANCE_IDX,
> +       },
> +};
> +
> +static int vz89x_get_measurement(struct vz89x_data *data)
> +{
> +       int ret;
> +       int i;
> +
> +       /* sensor can only be polled once a second max per datasheet */
> +       if (!time_after(jiffies, data->last_update + HZ))
> +               return 0;
> +
> +       ret = i2c_smbus_write_word_data(data->client,
> +                                       VZ89X_REG_MEASUREMENT, 0);
> +       if (ret < 0)
> +               return ret;
> +
> +       for (i = 0; i < VZ89X_REG_MEASUREMENT_SIZE; i++) {
> +               ret = i2c_smbus_read_byte(data->client);
> +               if (ret < 0)
> +                       return ret;
> +               data->buffer[i] = ret;
> +       }
> +
> +       data->last_update = jiffies;
> +
> +       return 0;
> +}
> +
> +static int vz89x_get_resistance_reading(struct vz89x_data *data)
> +{
> +       u8 *buf = &data->buffer[VZ89X_VOC_TVOC_IDX];
> +
> +       return buf[0] | ((u16)buf[1] << 8) | ((u32)buf[2] << 16);
> +}
> +
> +static int vz89x_get_channel_scale(struct iio_chan_spec const *chan,
> +                                  int *val, int *val2)
> +{
> +       switch (chan->address) {
> +       case VZ89X_VOC_CO2_IDX:
> +               *val = 1600;
> +               *val2 = 229;
> +               return IIO_VAL_FRACTIONAL;
> +       case VZ89X_VOC_TVOC_IDX:
> +               *val = 1000;
> +               *val2 = 229;
> +               return IIO_VAL_FRACTIONAL;
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +static int vz89x_read_raw(struct iio_dev *indio_dev,
> +                         struct iio_chan_spec const *chan, int *val,
> +                         int *val2, long mask)
> +{
> +       struct vz89x_data *data = iio_priv(indio_dev);
> +       int ret = -EINVAL;
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_RAW:
> +               mutex_lock(&data->lock);
> +               ret = vz89x_get_measurement(data);
> +               mutex_unlock(&data->lock);
> +
> +               if (ret)
> +                       return ret;
> +
> +               switch (chan->address) {
> +               case VZ89X_VOC_CO2_IDX:
> +                       *val = 0;
> +                       *val2 = data->buffer[chan->address] - 13;
>
Magic numbers are unlucky.


> +                       return IIO_VAL_INT_PLUS_MICRO;
> +               case VZ89X_VOC_SHORT_IDX:
> +                       *val = data->buffer[chan->address] - 13;
> +                       return IIO_VAL_INT;
> +               case VZ89X_VOC_TVOC_IDX:
> +                       *val = 0;
> +                       *val2 = data->buffer[chan->address] - 13;
> +                       return IIO_VAL_INT_PLUS_NANO;
> +               case VZ89X_VOC_RESISTANCE_IDX:
> +                       *val = vz89x_get_resistance_reading(data);
> +                       return IIO_VAL_INT;
> +               default:
> +                       return -EINVAL;
> +               }
> +               break;
> +       case IIO_CHAN_INFO_SCALE:
> +               switch (chan->type) {
> +               case IIO_RESISTANCE:
> +                       *val = 10;
> +                       return IIO_VAL_INT;
> +               case IIO_CONCENTRATION:
> +                       return vz89x_get_channel_scale(chan, val, val2);
> +               default:
> +                       return -EINVAL;
> +               }
> +               break;
> +       case IIO_CHAN_INFO_OFFSET:
> +               *val = 0;
> +               *val2 = 400;
> +               return IIO_VAL_INT_PLUS_MICRO;
> +       }
> +
> +       return ret;
> +}
> +
> +static const struct iio_info vz89x_info = {
> +       .driver_module  = THIS_MODULE,
> +       .read_raw       = vz89x_read_raw,
> +};
> +
> +static int vz89x_probe(struct i2c_client *client,
> +                      const struct i2c_device_id *id)
> +{
> +       struct iio_dev *indio_dev;
> +       struct vz89x_data *data;
> +
> +       if (!i2c_check_functionality(client->adapter,
> I2C_FUNC_SMBUS_WORD_DATA |
> +                                    I2C_FUNC_SMBUS_BYTE))
> +               return -ENODEV;
> +
> +       indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +       if (!indio_dev)
> +               return -ENOMEM;
> +
> +       data = iio_priv(indio_dev);
> +       i2c_set_clientdata(client, indio_dev);
> +       data->client = client;
> +       data->last_update = jiffies - HZ;
> +       mutex_init(&data->lock);
> +
> +       indio_dev->dev.parent = &client->dev;
> +       indio_dev->info = &vz89x_info,
> +       indio_dev->name = dev_name(&client->dev);
> +       indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +       indio_dev->channels = vz89x_channels;
> +       indio_dev->num_channels = ARRAY_SIZE(vz89x_channels);
> +
> +       return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +
> +static const struct i2c_device_id vz89x_id[] = {
> +       { "vz89x", 0 },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(i2c, vz89x_id);
> +
> +static const struct of_device_id vz89x_dt_ids[] = {
> +       { .compatible = "sgx,vz89x" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, vz89x_dt_ids);
> +
> +static struct i2c_driver vz89x_driver = {
> +       .driver = {
> +               .name   = "vz89x",
> +               .of_match_table = of_match_ptr(vz89x_dt_ids),
> +       },
> +       .probe = vz89x_probe,
> +       .id_table = vz89x_id,
> +};
> +module_i2c_driver(vz89x_driver);
> +
> +MODULE_AUTHOR("Matt Ranostay <mranostay@gmail.com>");
> +MODULE_DESCRIPTION("SGX Sensortech MiCS VZ89X VOC sensors");
> +MODULE_LICENSE("GPL v2");
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--001a113ed8e20db0aa051f1fa1a9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Sun, Sep 6, 2015 at 9:39 PM, Matt Ranostay <span dir=3D"ltr">&lt;<a =
href=3D"mailto:mranostay@gmail.com" target=3D"_blank">mranostay@gmail.com</=
a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Add support for VZ89=
X sensors VOC and CO2 reporting channels in<br>
percentage which can be converted to part per million.<br>
<br>
Signed-off-by: Matt Ranostay &lt;<a href=3D"mailto:mranostay@gmail.com">mra=
nostay@gmail.com</a>&gt;<br>
---<br>
=C2=A0.../ABI/testing/sysfs-bus-iio-chemical-vz89x=C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 30 +++<br>
=C2=A0.../devicetree/bindings/i2c/trivial-devices.txt=C2=A0 =C2=A0 |=C2=A0 =
=C2=A01 +<br>
=C2=A0drivers/iio/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A01 +<br>
=C2=A0drivers/iio/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A01 +<br>
=C2=A0drivers/iio/chemical/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A06 +<br>
=C2=A0drivers/iio/chemical/vz89x.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 236 +++++++++++++++++++++<br>
=C2=A06 files changed, 275 insertions(+)<br>
=C2=A0create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-chemical-v=
z89x<br>
=C2=A0create mode 100644 drivers/iio/chemical/Makefile<br>
=C2=A0create mode 100644 drivers/iio/chemical/vz89x.c<br>
<br>
diff --git a/Documentation/ABI/testing/sysfs-bus-iio-chemical-vz89x b/Docum=
entation/ABI/testing/sysfs-bus-iio-chemical-vz89x<br>
new file mode 100644<br>
index 0000000..74f2a35<br>
--- /dev/null<br>
+++ b/Documentation/ABI/testing/sysfs-bus-iio-chemical-vz89x<br>
@@ -0,0 +1,30 @@<br>
+What:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /sys/bus/iio/devices/iio:deviceX/i=
n_concentration_CO2_raw<br>
+Date:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 September 2015<br>
+KernelVersion: 4.3<br>
+Contact:=C2=A0 =C2=A0 =C2=A0 =C2=A0Matt Ranostay &lt;<a href=3D"mailto:mra=
nostay@gmail.com">mranostay@gmail.com</a>&gt;<br>
+Description:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Get the unscaled, a=
nd no offset applied CO2 gas percentage<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value.<br>
+<br>
+What:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /sys/bus/iio/devices/iio:deviceX/i=
n_concentration_VOC_short_raw<br>
+Date:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 September 2015<br>
+KernelVersion: 4.3<br>
+Contact:=C2=A0 =C2=A0 =C2=A0 =C2=A0Matt Ranostay &lt;<a href=3D"mailto:mra=
nostay@gmail.com">mranostay@gmail.com</a>&gt;<br>
+Description:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Get the raw calibra=
tion VOC value from the sensor.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This value has litt=
le application outside of calibration.<br>
+<br>
+What:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /sys/bus/iio/devices/iio:deviceX/i=
n_concentration_tVOC_raw<br>
+Date:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 September 2015<br>
+KernelVersion: 4.3<br>
+Contact:=C2=A0 =C2=A0 =C2=A0 =C2=A0Matt Ranostay &lt;<a href=3D"mailto:mra=
nostay@gmail.com">mranostay@gmail.com</a>&gt;<br>
+Description:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Get the unscaled, a=
nd no offset applied total VOC gas<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0percentage value.<b=
r>
+<br>
+What:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /sys/bus/iio/devices/iio:deviceX/i=
n_resistance_raw<br>
+Date:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 September 2015<br>
+KernelVersion: 4.3<br>
+Contact:=C2=A0 =C2=A0 =C2=A0 =C2=A0Matt Ranostay &lt;<a href=3D"mailto:mra=
nostay@gmail.com">mranostay@gmail.com</a>&gt;<br>
+Description:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Get the unscaled se=
nsor resistance value.<br>
diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Do=
cumentation/devicetree/bindings/i2c/trivial-devices.txt<br>
index d77d412..a550216 100644<br>
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt<br>
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt<br>
@@ -88,6 +88,7 @@ ricoh,rs5c372b=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC<br>
=C2=A0ricoh,rv5c386=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 I2C bus SERIAL INTERF=
ACE REAL-TIME CLOCK IC<br>
=C2=A0ricoh,rv5c387a=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0I2C bus SERIAL INTERF=
ACE REAL-TIME CLOCK IC<br>
=C2=A0samsung,24ad0xd1=C2=A0 =C2=A0 =C2=A0 =C2=A0S524AD0XF1 (128K/256K-bit =
Serial EEPROM for Low Power)<br>
+sgx,vz89x=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SGX Sensortech V=
Z89X Sensors<br>
=C2=A0sii,s35390a=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2-wire CMOS real=
-time clock<br>
=C2=A0skyworks,sky81452=C2=A0 =C2=A0 =C2=A0 Skyworks SKY81452: Six-Channel =
White LED Driver with Touch Panel Bias Supply<br>
=C2=A0st-micro,24c256=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 i2c serial eeprom=C2=A0 (24cxx)<br>
diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig<br>
index 4011eff..9664e9c 100644<br>
--- a/drivers/iio/Kconfig<br>
+++ b/drivers/iio/Kconfig<br>
@@ -61,6 +61,7 @@ config IIO_CONSUMERS_PER_TRIGGER<br>
=C2=A0source &quot;drivers/iio/accel/Kconfig&quot;<br>
=C2=A0source &quot;drivers/iio/adc/Kconfig&quot;<br>
=C2=A0source &quot;drivers/iio/amplifiers/Kconfig&quot;<br>
+source &quot;drivers/iio/chemical/Kconfig&quot;<br>
=C2=A0source &quot;drivers/iio/common/Kconfig&quot;<br>
=C2=A0source &quot;drivers/iio/dac/Kconfig&quot;<br>
=C2=A0source &quot;drivers/iio/frequency/Kconfig&quot;<br>
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile<br>
index 698afc2..2288684 100644<br>
--- a/drivers/iio/Makefile<br>
+++ b/drivers/iio/Makefile<br>
@@ -14,6 +14,7 @@ obj-$(CONFIG_IIO_KFIFO_BUF) +=3D kfifo_buf.o<br>
=C2=A0obj-y +=3D accel/<br>
=C2=A0obj-y +=3D adc/<br>
=C2=A0obj-y +=3D amplifiers/<br>
+obj-y +=3D chemical/<br>
=C2=A0obj-y +=3D common/<br>
=C2=A0obj-y +=3D dac/<br>
=C2=A0obj-y +=3D gyro/<br>
diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile<=
br>
new file mode 100644<br>
index 0000000..7292f2d<br>
--- /dev/null<br>
+++ b/drivers/iio/chemical/Makefile<br>
@@ -0,0 +1,6 @@<br>
+#<br>
+# Makefile for IIO chemical sensors<br>
+#<br>
+<br>
+# When adding new entries keep the list in alphabetical order<br>
+obj-$(CONFIG_VZ89X)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +=3D vz89x.o<=
br>
diff --git a/drivers/iio/chemical/vz89x.c b/drivers/iio/chemical/vz89x.c<br=
>
new file mode 100644<br>
index 0000000..ac381cc<br>
--- /dev/null<br>
+++ b/drivers/iio/chemical/vz89x.c<br>
@@ -0,0 +1,236 @@<br>
+/*<br>
+ * vz89x.c - Support for SGX Sensortech MiCS VZ89X VOC sensors<br>
+ *<br>
+ * Copyright (C) 2015 Matt Ranostay &lt;<a href=3D"mailto:mranostay@gmail.=
com">mranostay@gmail.com</a>&gt;<br>
+ *<br>
+ * This program is free software; you can redistribute it and/or modify<br=
>
+ * it under the terms of the GNU General Public License as published by<br=
>
+ * the Free Software Foundation; either version 2 of the License, or<br>
+ * (at your option) any later version.<br>
+ *<br>
+ * This program is distributed in the hope that it will be useful,<br>
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the<br>
+ * GNU General Public License for more details.<br>
+ *<br>
+ */<br>
+<br>
+#include &lt;linux/module.h&gt;<br>
+#include &lt;linux/mutex.h&gt;<br>
+#include &lt;linux/init.h&gt;<br>
+#include &lt;linux/i2c.h&gt;<br>
+<br>
+#include &lt;linux/iio/iio.h&gt;<br>
+#include &lt;linux/iio/sysfs.h&gt;<br>
+<br>
+#define VZ89X_REG_MEASUREMENT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x09<br>
+#define VZ89X_REG_MEASUREMENT_SIZE=C2=A0 =C2=A0 =C2=A06<br>
+<br>
+#define VZ89X_VOC_CO2_IDX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
0<br>
+#define VZ89X_VOC_SHORT_IDX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1<br>
+#define VZ89X_VOC_TVOC_IDX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
2<br>
+#define VZ89X_VOC_RESISTANCE_IDX=C2=A0 =C2=A0 =C2=A0 =C2=A03<br>
+<br>
+struct vz89x_data {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct i2c_client *client;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct mutex lock;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long last_update;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u8 buffer[VZ89X_REG_MEASUREMENT_SIZE];<br>
+};<br>
+<br>
+static const struct iio_chan_spec vz89x_channels[] =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.type =3D IIO_CONCE=
NTRATION,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.info_mask_separate=
 =3D BIT(IIO_CHAN_INFO_OFFSET) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.address =3D VZ89X_=
VOC_CO2_IDX,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.extend_name =3D &q=
uot;CO2&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.type =3D IIO_CONCE=
NTRATION,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.info_mask_separate=
 =3D BIT(IIO_CHAN_INFO_RAW),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.address =3D VZ89X_=
VOC_SHORT_IDX,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.extend_name =3D &q=
uot;VOC_short&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.type =3D IIO_CONCE=
NTRATION,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.info_mask_separate=
 =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.address =3D VZ89X_=
VOC_TVOC_IDX,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.extend_name =3D &q=
uot;tVOC&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.type =3D IIO_RESIS=
TANCE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.info_mask_separate=
 =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.address =3D VZ89X_=
VOC_RESISTANCE_IDX,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
+};<br>
+<br>
+static int vz89x_get_measurement(struct vz89x_data *data)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* sensor can only be polled once a second max =
per datasheet */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!time_after(jiffies, data-&gt;last_update +=
 HZ))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D i2c_smbus_write_word_data(data-&gt;clie=
nt,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VZ89X_REG=
_MEASUREMENT, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; VZ89X_REG_MEASUREMENT_SIZE=
; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D i2c_smbus_r=
ead_byte(data-&gt;client);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;buffer[i] =
=3D ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;last_update =3D jiffies;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+static int vz89x_get_resistance_reading(struct vz89x_data *data)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u8 *buf =3D &amp;data-&gt;buffer[VZ89X_VOC_TVOC=
_IDX];<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return buf[0] | ((u16)buf[1] &lt;&lt; 8) | ((u3=
2)buf[2] &lt;&lt; 16);<br>
+}<br>
+<br>
+static int vz89x_get_channel_scale(struct iio_chan_spec const *chan,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int *val, int *val2)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0switch (chan-&gt;address) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case VZ89X_VOC_CO2_IDX:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val =3D 1600;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val2 =3D 229;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return IIO_VAL_FRAC=
TIONAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case VZ89X_VOC_TVOC_IDX:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val =3D 1000;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val2 =3D 229;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return IIO_VAL_FRAC=
TIONAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+}<br>
+<br>
+static int vz89x_read_raw(struct iio_dev *indio_dev,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0struct iio_chan_spec const *chan, int *val,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0int *val2, long mask)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct vz89x_data *data =3D iio_priv(indio_dev)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D -EINVAL;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0switch (mask) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case IIO_CHAN_INFO_RAW:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;dat=
a-&gt;lock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D vz89x_get_m=
easurement(data);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;d=
ata-&gt;lock);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return ret;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (chan-&gt;ad=
dress) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case VZ89X_VOC_CO2_=
IDX:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0*val =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0*val2 =3D data-&gt;buffer[chan-&gt;address] - 13;<br></blockquote=
><div>Magic numbers are unlucky.</div><div>=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return IIO_VAL_INT_PLUS_MICRO;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case VZ89X_VOC_SHOR=
T_IDX:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0*val =3D data-&gt;buffer[chan-&gt;address] - 13;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return IIO_VAL_INT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case VZ89X_VOC_TVOC=
_IDX:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0*val =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0*val2 =3D data-&gt;buffer[chan-&gt;address] - 13;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return IIO_VAL_INT_PLUS_NANO;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case VZ89X_VOC_RESI=
STANCE_IDX:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0*val =3D vz89x_get_resistance_reading(data);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return IIO_VAL_INT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case IIO_CHAN_INFO_SCALE:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (chan-&gt;ty=
pe) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IIO_RESISTANCE=
:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0*val =3D 10;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return IIO_VAL_INT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IIO_CONCENTRAT=
ION:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return vz89x_get_channel_scale(chan, val, val2);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case IIO_CHAN_INFO_OFFSET:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val2 =3D 400;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return IIO_VAL_INT_=
PLUS_MICRO;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+}<br>
+<br>
+static const struct iio_info vz89x_info =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.driver_module=C2=A0 =3D THIS_MODULE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.read_raw=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D vz89x_r=
ead_raw,<br>
+};<br>
+<br>
+static int vz89x_probe(struct i2c_client *client,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 const struct i2c_device_id *id)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct iio_dev *indio_dev;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct vz89x_data *data;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!i2c_check_functionality(client-&gt;adapter=
, I2C_FUNC_SMBUS_WORD_DATA |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 I2C_FUNC_SMBUS_BYTE))<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev =3D devm_iio_device_alloc(&amp;client=
-&gt;dev, sizeof(*data));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!indio_dev)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0data =3D iio_priv(indio_dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_set_clientdata(client, indio_dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;client =3D client;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;last_update =3D jiffies - HZ;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_init(&amp;data-&gt;lock);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev-&gt;dev.parent =3D &amp;client-&gt;de=
v;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev-&gt;info =3D &amp;vz89x_info,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev-&gt;name =3D dev_name(&amp;client-&gt=
;dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev-&gt;modes =3D INDIO_DIRECT_MODE;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev-&gt;channels =3D vz89x_channels;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev-&gt;num_channels =3D ARRAY_SIZE(vz89x=
_channels);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return devm_iio_device_register(&amp;client-&gt=
;dev, indio_dev);<br>
+}<br>
+<br>
+static const struct i2c_device_id vz89x_id[] =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;vz89x&quot;, 0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{ }<br>
+};<br>
+MODULE_DEVICE_TABLE(i2c, vz89x_id);<br>
+<br>
+static const struct of_device_id vz89x_dt_ids[] =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{ .compatible =3D &quot;sgx,vz89x&quot; },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{ }<br>
+};<br>
+MODULE_DEVICE_TABLE(of, vz89x_dt_ids);<br>
+<br>
+static struct i2c_driver vz89x_driver =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.driver =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0=
=3D &quot;vz89x&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.of_match_table =3D=
 of_match_ptr(vz89x_dt_ids),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.probe =3D vz89x_probe,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.id_table =3D vz89x_id,<br>
+};<br>
+module_i2c_driver(vz89x_driver);<br>
+<br>
+MODULE_AUTHOR(&quot;Matt Ranostay &lt;<a href=3D"mailto:mranostay@gmail.co=
m">mranostay@gmail.com</a>&gt;&quot;);<br>
+MODULE_DESCRIPTION(&quot;SGX Sensortech MiCS VZ89X VOC sensors&quot;);<br>
+MODULE_LICENSE(&quot;GPL v2&quot;);<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.9.1<br>
<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe devicetree&q=
uot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">major=
domo@vger.kernel.org</a><br>
More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" rel=3D"noreferrer" target=3D"_blank">http://vger.kernel.org/majord=
omo-info.html</a><br>
</font></span></blockquote></div><br></div></div>

--001a113ed8e20db0aa051f1fa1a9--
