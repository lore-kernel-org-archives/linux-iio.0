Return-Path: <o.v.kravchenko@globallogic.com>
MIME-Version: 1.0
In-Reply-To: <51F97F2E.7040006@kernel.org>
References: <1375109893-7917-1-git-send-email-x0199363@ti.com>
	<1375109893-7917-2-git-send-email-x0199363@ti.com>
	<alpine.DEB.2.01.1307291704440.20459@pmeerw.net>
	<51F97F2E.7040006@kernel.org>
Date: Fri, 2 Aug 2013 17:42:24 +0300
Message-ID: <CAGH3drqTizqo55=LfmtS-krmqnuFnu8hxvMTaZ1dk7eAc6eVJA@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: add Bosch BMA180 acceleration sensor driver
From: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Peter Meerwald <pmeerw@pmeerw.net>, Oleksandr Kravchenko <x0199363@ti.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>,
	Rob Landley <rob@landley.net>, jic23@cam.ac.uk, holler@ahsoftware.de,
	srinivas.pandruvada@intel.com, devicetree-discuss@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=089e0111bcfa8392e404e2f7f76e
List-ID: <linux-iio@vger.kernel.org>

--089e0111bcfa8392e404e2f7f76e
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2013 at 12:18 AM, Jonathan Cameron <jic23@kernel.org> wrote:

> On 07/29/13 16:15, Peter Meerwald wrote:
> >
> > kicking out drivers fast :)
> > few comments below; the driver exposes only minimal iio features and
> > integrates input subsystem, this doesn't seem right
> >
> Only taken a very quick look but Peter is quite right.  Either
> this is very much an input directed driver in which case rip out the
> IIO stuff and submit it as an input driver, or it is a multipurpose part
> in which case the 'right' way to do it is that bridge driver I keep
> failing to bring up to date (anyone else fancy taking it on? I'll probabl=
y
> get to it, but right now all my available time goes on review so new
> features in my hands will take a while!)
>
> There are some other corners that still need doing, but having large
> quantities of input calls within an IIO driver is not going anywhere
> as it just makes for a maintenance mess.
>
> Actually this driver doesn't support what we would call events in IIO
> so the current feature set of that bridge would probably be fine.  Note
> to use it you'd need full trigger and buffer support under IIO.
>
I can't completely understand how to use IIO buffer and trigger in my
driver.
Please advice me which driver can I use as reference.

>
> Anyhow, up to you whether you want to pitch this to linux-input with
> IIO removed or go the IIO  and input bridge route (last version
> 'might' be http://marc.info/?l=3Dlinux-iio&m=3D135167944813803&w=3D2 .
>
> >>
> >> diff --git a/Documentation/devicetree/bindings/iio/accel/bma180.txt
> b/Documentation/devicetree/bindings/iio/accel/bma180.txt
> >> new file mode 100644
> >> index 0000000..7c13c84
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/iio/accel/bma180.txt
> >> @@ -0,0 +1,53 @@
> >> +* Bosch BMA180 triaxial acceleration sensor
> >> +
> >> +http://omapworld.com/BMA180_111_1002839.pdf
> >> +
> >> +Required properties:
> >> +
> >> +  - compatible : should be "bosch,bma180"
> >> +  - reg : the I2C address of the sensor
> >> +
> >> +Optional properties:
> >> +
> >> +  - interrupt-parent : should be the phandle for the interrupt
> controller
> >> +
> >> +  - interrupts : interrupt mapping for GPIO IRQ, it shuld by
> configured with
> >> +            flags IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_EDGE_RISING
> >> +
> >> +  - range : select the full scale acceleration range
> >> +            0 : -1g..+1g
> >> +            1 : -1.5g..+1.5g
> >> +            2 : -2g..+2g
> >> +            3 : -3g..+3g
> >> +            4 : -4g..+4g
> >> +            5 : -8g..+8g
> >> +            6 : -16g..+16g
> >> +
> >> +  - bw : select bandwidth bandwidth
> >> +            0 : 10Hz
> >> +            1 : 20Hz
> >> +            2 : 40Hz
> >> +            3 : 75Hz
> >> +            4 : 150Hz
> >> +            5 : 300Hz
> Surely magic numbers should be as unacceptible in device tree files
> as anywhere else?  It's hardly difficult to use the actual values
> for this.
>
> >> +            Don't use bandwidth frequency more than 300Hz couse it
> >
> > because
> >
> >> +            influences the frequency of generating new data interrupt=
s
> >> +            and i2c reading phase can be longer than pheriod of
> interrupt
> >
> > period
> >
> >> +            generation.
> >> +
> >> +  - mode_config : 0 - select low noise mode, 1 - select low power mod=
e
> >> +
> >> +  - fuzz : specifies fuzz value that is used to filter noise from the
> event stream
> >> +
> >> +Example:
> >> +
> >> +bma180@40 {
> >> +    compatible =3D "bosch,bma180";
> >> +    reg =3D <0x40>;
> >> +    interrupt-parent =3D <&gpio6>;
> >> +    interrupts =3D <18 (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_EDGE_RISING)>;
> >> +    range =3D <2>;
> >> +    bw =3D <0>;
> >> +    mode_config =3D <1>;
> >> +    fuzz =3D <555>;
> >> +};
> >> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> >> index 719d83f..61fd29f 100644
> >> --- a/drivers/iio/accel/Kconfig
> >> +++ b/drivers/iio/accel/Kconfig
> >> @@ -3,6 +3,16 @@
> >>  #
> >>  menu "Accelerometers"
> >>
> >> +config BMA180
> >> +    tristate "Bosch BMA180 3-Axis Accelerometer Driver"
> >> +    depends on I2C
> >> +    help
> >> +      Say Y here if you want to build a driver for the Bosch BMA180
> >> +      triaxial acceleration sensor.
> >> +
> >> +      To compile this driver as a module, choose M here: the
> >> +      module will be called bma180.
> >> +
> >>  config HID_SENSOR_ACCEL_3D
> >>      depends on HID_SENSOR_HUB
> >>      select IIO_BUFFER
> >> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> >> index 87d8fa2..31a36fa 100644
> >> --- a/drivers/iio/accel/Makefile
> >> +++ b/drivers/iio/accel/Makefile
> >> @@ -12,3 +12,5 @@ obj-$(CONFIG_IIO_ST_ACCEL_I2C_3AXIS) +=3D st_accel_i=
2c.o
> >>  obj-$(CONFIG_IIO_ST_ACCEL_SPI_3AXIS) +=3D st_accel_spi.o
> >>
> >>  obj-$(CONFIG_KXSD9) +=3D kxsd9.o
> >> +
> >> +obj-$(CONFIG_BMA180)        +=3D bma180.o
> >
> > alphabetic order
> >
> >> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> >> new file mode 100644
> >> index 0000000..9f5341f
> >> --- /dev/null
> >> +++ b/drivers/iio/accel/bma180.c
> >> @@ -0,0 +1,462 @@
> >> +/*
> >> + * bma180.c - IIO driver for Bosch BMA180 triaxial acceleration senso=
r
> >> + *
> >> + * Copyright 2013 Oleksandr Kravchenko <x0199363@ti.com>
> >> + *
> >> + * This file is subject to the terms and conditions of version 2 of
> >> + * the GNU General Public License.  See the file COPYING in the main
> >> + * directory of this archive for more details.
> >> + */
> >> +
> >> +#include <linux/module.h>
> >> +#include <linux/i2c.h>
> >> +#include <linux/interrupt.h>
> >> +#include <linux/delay.h>
> >> +#include <linux/input.h>
> >> +#include <linux/of.h>
> >> +#include <linux/bitops.h>
> >> +#include <linux/iio/iio.h>
> >> +#include <linux/iio/sysfs.h>
> >> +#include <linux/iio/events.h>
> >> +
> >> +#define BMA180_DRV_NAME "bma180"
> >> +#define BMA180_IRQ_NAME "bma180_event"
> >> +
> >> +/* Register set */
> >> +#define BMA180_CHIP_ID              0x00 /* Need to distinguish BMA18=
0
> from other */
> >> +#define BMA180_ACC_X_LSB    0x02 /* First of 6 registers of accel dat=
a
> */
> >> +#define BMA180_CTRL_REG0    0x0d
> >> +#define BMA180_RESET                0x10
> >> +#define BMA180_BW_TCS               0x20
> >> +#define BMA180_CTRL_REG3    0x21
> >> +#define BMA180_TCO_Z                0x30
> >> +#define BMA180_OFFSET_LSB1  0x35
> >> +
> >> +/* Control bits */
> >> +#define BMA180_SLEEP                BIT(1) /* 1 - chip will sleep */
> >> +#define BMA180_DIS_WAKE_UP  BIT(0) /* Disable wake up mode */
> >> +#define BMA180_EE_W         BIT(4) /* Unlock writing to addr. from
> 0x20 */
> >> +#define BMA180_NEW_DATA_INT BIT(1) /* Intr every new accel data is
> ready */
> >> +#define BMA180_SMP_SKIP             BIT(0) /* Sample skipping mode */
> >
> > maybe say which bits belong to which CTRL reg?
> >
> >> +
> >> +/* Bit masks fo registerts bit fields */
> >
> > typos: fo, registerts
> >
> >> +#define BMA180_RANGE                0x0e /* Range of accel measurment
> */
> >> +#define BMA180_BW           0xf0 /* Accel measurmend bandwidth */
> >
> > typo: measurmend
> >
> >> +#define BMA180_MODE_CONFIG  0x03 /* Config operation modes */
> >> +
> >> +/* We have write this value in reset register to do soft reset */
> >
> > have 'to' write
> >
> >> +#define BMA180_RESET_VAL    0xb6
> >> +
> >> +/* Chip operation modes */
> >> +#define BMA180_LOW_NOISE    0x00
> >> +#define BMA180_LOW_POWER    0x03
> >> +
> >> +struct bma180_data {
> >> +    struct i2c_client *client;
> >> +    struct input_dev *input_dev;
> >> +    struct mutex mutex;
> >> +    int sleep_state;
> >> +    int range;
> >> +    int bw;
> >> +    int mode;
> >> +    int fuzz;
> >> +    int acc_reg[3];
> >> +};
> >> +
> >> +enum bma180_axis {
> >> +    AXIS_X,
> >> +    AXIS_Y,
> >> +    AXIS_Z,
> >> +};
> >> +
> >> +struct bma180_range {
> >> +    int g_range;
> >> +    int ratio;
> >> +};
> >> +
> >> +static struct bma180_range bma180_range_table[7] =3D {
> >> +    { 1000, 130 },
> >> +    { 1500, 190 },
> >> +    { 2000, 250 },
> >> +    { 3000, 380 },
> >> +    { 4000, 500 },
> >> +    { 8000, 990 },
> >> +    { 16000, 1980 },
> >> +};
> >> +
> >> +static int bma180_get_acc_reg(struct bma180_data *data, enum
> bma180_axis axis)
> >> +{
> >> +    u8 reg =3D BMA180_ACC_X_LSB + axis * 2;
> >> +    int ret;
> >> +
> >> +    if (data->sleep_state)
> >> +            return -EBUSY;
> >> +
> >> +    ret =3D i2c_smbus_read_word_data(data->client, reg);
> >> +    if (ret < 0)
> >> +            dev_err(&data->client->dev,
> >> +                    "failed to read accel_%c registers\n", 'x' + axis=
);
> >
> > just one register, not registers?
> >
> >> +
> >> +    return ret;
> >> +}
> >> +
> >> +static int bma180_set_bits(struct bma180_data *data, u8 reg, u8 mask,
> u8 val)
> >> +{
> >> +    int ret =3D i2c_smbus_read_byte_data(data->client, reg);
> >> +    u8 reg_val =3D (ret & ~mask) | (val << (ffs(mask) - 1));
> >> +
> >> +    if (ret < 0)
> >> +            return ret;
> >> +
> >> +    return i2c_smbus_write_byte_data(data->client, reg, reg_val);
> >> +}
> >> +
> >> +static int bma180_set_new_data_intr_state(struct bma180_data *data,
> int state)
> >> +{
> >> +    u8 reg_val =3D state ? BMA180_NEW_DATA_INT : 0x00;
> >> +    int ret =3D i2c_smbus_write_byte_data(data->client, BMA180_CTRL_R=
EG3,
> >> +                    reg_val);
> >> +
> >> +    if (ret)
> >> +            dev_err(&data->client->dev,
> >> +                    "failed to set new data interrupt state %d\n",
> state);
> >> +
> >> +    return ret;
> >> +}
> >> +
> >> +static int bma180_set_sleep_state(struct bma180_data *data, int state=
)
> >> +{
> >> +    int ret =3D bma180_set_bits(data, BMA180_CTRL_REG0, BMA180_SLEEP,
> state);
> >> +
> >> +    if (ret) {
> >> +            dev_err(&data->client->dev,
> >> +                    "failed to set sleep state %d\n", state);
> >> +            return ret;
> >> +    }
> >> +    data->sleep_state =3D state;
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +static int bma180_set_ee_writing_state(struct bma180_data *data, int
> state)
> >> +{
> >> +    int ret =3D bma180_set_bits(data, BMA180_CTRL_REG0, BMA180_EE_W,
> state);
> >> +
> >> +    if (ret)
> >> +            dev_err(&data->client->dev,
> >> +                    "failed to set ee writing state %d\n", state);
> >> +
> >> +    return ret;
> >> +}
> >> +
> >> +static int bma180_soft_reset(struct bma180_data *data)
> >> +{
> >> +    int ret =3D i2c_smbus_write_byte_data(data->client,
> >> +                    BMA180_RESET, BMA180_RESET_VAL);
> >> +
> >> +    if (ret)
> >> +            dev_err(&data->client->dev, "failed to reset the chip\n")=
;
> >> +
> >> +    return ret;
> >> +}
> >> +
> >> +static int bma180_chip_init(struct bma180_data *data)
> >> +{
> >> +    /* Try to read chip_id register. It must return 0x03. */
> >> +    int ret =3D i2c_smbus_read_byte_data(data->client, BMA180_CHIP_ID=
);
> >> +
> >> +    if (ret < 0)
> >> +            goto err;
> >> +    if (ret !=3D 0x03) {
> >> +            ret =3D -ENODEV;
> >> +            goto err;
> >> +    }
> >> +
> >> +    ret =3D bma180_soft_reset(data);
> >> +    if (ret)
> >> +            goto err;
> >> +    /*
> >> +     * No serial transaction should occur within minimum 10 =ECs
> >> +     * after soft_reset command
> >> +     */
> >> +    msleep(20);
> >> +
> >> +    ret =3D bma180_set_bits(data, BMA180_CTRL_REG0, BMA180_DIS_WAKE_U=
P,
> 1);
> >> +    if (ret)
> >> +            goto err;
> >> +    ret =3D bma180_set_ee_writing_state(data, 1);
> >> +    if (ret)
> >> +            goto err;
> >> +    ret =3D bma180_set_new_data_intr_state(data, 0);
> >> +    if (ret)
> >> +            goto err;
> >> +    ret =3D bma180_set_bits(data, BMA180_BW_TCS, BMA180_BW, data->bw)=
;
> >> +    if (ret)
> >> +            goto err;
> >> +    ret =3D bma180_set_bits(data,
> >> +                    BMA180_OFFSET_LSB1, BMA180_RANGE, data->range);
> >> +    if (ret)
> >> +            goto err;
> >> +    ret =3D bma180_set_bits(data, BMA180_TCO_Z, BMA180_MODE_CONFIG,
> >> +                    data->mode ? BMA180_LOW_POWER : BMA180_LOW_NOISE)=
;
> >> +    if (ret)
> >> +            goto err;
> >> +    ret =3D bma180_set_bits(data, BMA180_OFFSET_LSB1, BMA180_SMP_SKIP=
,
> 1);
> >> +    if (ret)
> >> +            goto err;
> >> +    ret =3D bma180_set_new_data_intr_state(data, 1);
> >> +    if (ret)
> >> +            goto err;
> >> +    ret =3D bma180_set_ee_writing_state(data, 0);
> >> +    if (ret)
> >> +            goto err;
> >> +
> >> +    return 0;
> >> +
> >> +err:
> >> +    dev_err(&data->client->dev, "failed to init the chip\n");
> >> +    return ret;
> >> +}
> >> +
> >> +static void bma180_chip_disable(struct bma180_data *data)
> >> +{
> >> +    if (bma180_set_ee_writing_state(data, 1))
> >> +            goto err;
> >> +    if (bma180_set_new_data_intr_state(data, 0))
> >> +            goto err;
> >> +    if (bma180_set_ee_writing_state(data, 0))
> >> +            goto err;
> >> +    if (bma180_set_sleep_state(data, 1))
> >> +            goto err;
> >> +
> >> +    return;
> >> +
> >> +err:
> >> +    dev_err(&data->client->dev, "failed to disable the chip\n");
> >> +}
> >> +
> >> +static int bma180_read_raw(struct iio_dev *indio_dev,
> >> +            struct iio_chan_spec const *chan, int *val, int *val2,
> >> +            long mask)
> >> +{
> >> +    struct bma180_data *data =3D iio_priv(indio_dev);
> >> +    long tmp =3D ((s16)data->acc_reg[chan->channel] >> 2)
> >> +            * bma180_range_table[data->range].ratio;
> >> +
> >> +    if (data->acc_reg[chan->channel] < 0)
> >> +            return data->acc_reg[chan->channel];
> >> +
> >> +    *val =3D tmp / 1000000;
> >> +    *val2 =3D (tmp % 1000000);
> >> +
> >> +    return IIO_VAL_INT_PLUS_MICRO;
> >> +}
> >> +
> >> +static const struct iio_info bma180_info =3D {
> >> +    .driver_module  =3D THIS_MODULE,
> >> +    .read_raw       =3D &bma180_read_raw,
> >> +};
> >> +
> >> +static const struct iio_chan_spec bma180_channels[] =3D {
> >> +    {
> >> +            .type =3D IIO_ACCEL,
> >> +            .channel =3D AXIS_X,
> >> +            .channel2 =3D IIO_MOD_X,
> >> +            .indexed =3D true,
> >
> > do the channels need to be indexed?
> >
> >> +            .info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED),
> >> +    }, {
> >> +            .type =3D IIO_ACCEL,
> >> +            .channel =3D AXIS_Y,
> >> +            .channel2 =3D IIO_MOD_Y,
> >> +            .indexed =3D true,
> >> +            .info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED),
> >> +    }, {
> >> +            .type =3D IIO_ACCEL,
> >> +            .channel =3D AXIS_Z,
> >> +            .channel2 =3D IIO_MOD_Z,
> >> +            .indexed =3D true,
> >> +            .info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED),
> >> +    },
> >> +};
> >> +
> >> +static irqreturn_t bma180_interrupt_handler(int irq, void *private)
> >> +{
> >> +    struct iio_dev *dev_info =3D private;
> >> +    struct bma180_data *data =3D iio_priv(dev_info);
> >> +    int i;
> >> +
> >> +    mutex_lock(&data->mutex);
> >> +    for (i =3D AXIS_X; i <=3D AXIS_Z; ++i)
> >> +            data->acc_reg[i] =3D bma180_get_acc_reg(data, i);
> >> +    mutex_unlock(&data->mutex);
> >> +
> >> +    input_report_abs(data->input_dev, ABS_X, data->acc_reg[AXIS_X]);
> >> +    input_report_abs(data->input_dev, ABS_Y, data->acc_reg[AXIS_Y]);
> >> +    input_report_abs(data->input_dev, ABS_Z, data->acc_reg[AXIS_Z]);
> >
> > input subsystem stuff within IIO?
> > uhoh...
> >
> > the driver should probably support more iio features: trigger, scan_mod=
e,
> > buffer
> >
> >> +    input_sync(data->input_dev);
> >> +
> >> +    return IRQ_HANDLED;
> >> +}
> >> +
> >> +static int bma180_probe(struct i2c_client *client,
> >> +            const struct i2c_device_id *id)
> >> +{
> >> +    struct input_dev *input_dev;
> >> +    struct bma180_data *data;
> >> +    struct iio_dev *indio_dev;
> >> +    struct device_node *np =3D client->dev.of_node;
> >> +    int i, ret;
> >> +
> >> +    if (!client->irq) {
> >> +            dev_err(&client->dev, "this driver cann't work without
> IRQ\n");
> >
> > can't
> >
> >> +            return -ENODEV;
> >> +    }
> >> +
> >> +    indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data));
> >> +    if (!indio_dev)
> >> +            return -ENOMEM;
> >> +
> >> +    input_dev =3D input_allocate_device();
> >> +    if (!input_dev)
> >> +            return -ENOMEM;
> >> +
> >> +    data =3D iio_priv(indio_dev);
> >> +    i2c_set_clientdata(client, indio_dev);
> >> +    data->client =3D client;
> >> +
> >> +    of_property_read_u32(np, "bw", &data->bw);
> >> +    of_property_read_u32(np, "range", &data->range);
> >> +    of_property_read_u32(np, "mode", &data->mode);
> >> +    of_property_read_u32(np, "fuzz", &data->fuzz);
> >> +
> >> +    ret =3D bma180_chip_init(data);
> >> +    if (ret < 0)
> >> +            goto err_1;
> >> +
> >> +    mutex_init(&data->mutex);
> >> +
> >> +    indio_dev->dev.parent =3D &client->dev;
> >> +    indio_dev->channels =3D bma180_channels;
> >> +    indio_dev->num_channels =3D ARRAY_SIZE(bma180_channels);
> >> +    indio_dev->name =3D BMA180_DRV_NAME;
> >> +    indio_dev->modes =3D INDIO_DIRECT_MODE;
> >> +    indio_dev->info =3D &bma180_info;
> >> +
> >> +    input_dev->name =3D BMA180_DRV_NAME;
> >> +    input_dev->id.bustype =3D BUS_I2C;
> >> +    __set_bit(EV_ABS, input_dev->evbit);
> >> +    for (i =3D ABS_X; i <=3D ABS_Z; ++i)
> >> +            input_set_abs_params(input_dev, i,
> >> +
> -bma180_range_table[data->range].g_range,
> >> +
> bma180_range_table[data->range].g_range,
> >> +                                 data->fuzz, 0);
> >> +    input_dev->dev.parent =3D &client->dev;
> >> +    input_set_drvdata(input_dev, data);
> >> +
> >> +    data->input_dev =3D input_dev;
> >> +
> >> +    ret =3D devm_request_threaded_irq(&client->dev, client->irq,
> >> +                    NULL, bma180_interrupt_handler, IRQF_ONESHOT,
> >> +                    BMA180_IRQ_NAME, indio_dev);
> >> +    if (ret < 0) {
> >> +            dev_err(&client->dev, "irq request error %d\n", -ret);
> >> +            goto err_1;
> >> +    }
> >> +
> >> +    ret =3D input_register_device(input_dev);
> >> +    if (ret) {
> >> +            dev_err(&client->dev, "unable to register input device\n"=
);
> >> +            goto err_1;
> >> +    }
> >> +
> >> +
> >
> > extra newline
> >
> >> +    ret =3D iio_device_register(indio_dev);
> >> +    if (ret < 0) {
> >> +            dev_err(&client->dev, "unable to register iio device\n");
> >> +            goto err_2;
> >> +    }
> >> +
> >> +    return 0;
> >> +
> >> +err_2:
> >> +    input_unregister_device(input_dev);
> >> +err_1:
> >> +    input_free_device(input_dev);
> >> +
> >> +    bma180_chip_disable(data);
> >> +
> >> +    return ret;
> >> +}
> >> +
> >> +static int bma180_remove(struct i2c_client *client)
> >> +{
> >> +    struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
> >> +    struct bma180_data *data =3D iio_priv(indio_dev);
> >> +
> >> +    iio_device_unregister(indio_dev);
> >> +    input_unregister_device(data->input_dev);
> >> +
> >> +    mutex_lock(&data->mutex);
> >> +    bma180_chip_disable(data);
> >> +    mutex_unlock(&data->mutex);
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +#ifdef CONFIG_PM_SLEEP
> >> +static int bma180_suspend(struct device *dev)
> >> +{
> >> +    struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_client(de=
v));
> >> +    struct bma180_data *data =3D iio_priv(indio_dev);
> >> +    int ret;
> >> +
> >> +    mutex_lock(&data->mutex);
> >> +    ret =3D bma180_set_sleep_state(data, 1);
> >> +    mutex_unlock(&data->mutex);
> >> +
> >> +    return ret;
> >> +}
> >> +
> >> +static int bma180_resume(struct device *dev)
> >> +{
> >> +    struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_client(de=
v));
> >> +    struct bma180_data *data =3D iio_priv(indio_dev);
> >> +    int ret;
> >> +
> >> +    mutex_lock(&data->mutex);
> >> +    ret =3D bma180_set_sleep_state(data, 0);
> >> +    mutex_unlock(&data->mutex);
> >> +
> >> +    return ret;
> >> +}
> >> +
> >> +static SIMPLE_DEV_PM_OPS(bma180_pm_ops, bma180_suspend, bma180_resume=
);
> >> +#define BMA180_PM_OPS (&bma180_pm_ops)
> >> +#else
> >> +#define BMA180_PM_OPS NULL
> >> +#endif
> >> +
> >> +static struct i2c_device_id bma180_id[] =3D {
> >> +    { BMA180_DRV_NAME, 0 },
> >> +    { }
> >> +};
> >> +
> >> +MODULE_DEVICE_TABLE(i2c, bma180_id);
> >> +
> >> +static struct i2c_driver bma180_driver =3D {
> >> +    .driver =3D {
> >> +            .name   =3D BMA180_DRV_NAME,
> >> +            .owner  =3D THIS_MODULE,
> >> +            .pm     =3D BMA180_PM_OPS,
> >> +    },
> >> +    .probe          =3D bma180_probe,
> >> +    .remove         =3D bma180_remove,
> >> +    .id_table       =3D bma180_id,
> >> +};
> >> +
> >> +module_i2c_driver(bma180_driver);
> >> +
> >> +MODULE_AUTHOR("Kravchenko Oleksandr <x0199363@ti.com>");
> >> +MODULE_AUTHOR("Texas Instruments, Inc.");
> >> +MODULE_DESCRIPTION("Bosch BMA180 triaxial acceleration sensor");
> >> +MODULE_LICENSE("GPL");
> >>
> >
>



--=20
Oleksandr Kravchenko
GlobalLogic
P +380633213187
P +380994930248
www.globallogic.com
<http://www.globallogic.com/>
http://www.globallogic.com/email_disclaimer.txt

--089e0111bcfa8392e404e2f7f76e
Content-Type: text/html; charset=ISO-8859-7
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On T=
hu, Aug 1, 2013 at 12:18 AM, Jonathan Cameron <span dir=3D"ltr">&lt;<a href=
=3D"mailto:jic23@kernel.org" target=3D"_blank">jic23@kernel.org</a>&gt;</sp=
an> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><div class=3D"im">On 07/2=
9/13 16:15, Peter Meerwald wrote:<br>
&gt;<br>
&gt; kicking out drivers fast :)<br>
&gt; few comments below; the driver exposes only minimal iio features and<b=
r>
&gt; integrates input subsystem, this doesn&#39;t seem right<br>
&gt;<br>
</div>Only taken a very quick look but Peter is quite right. =A0Either<br>
this is very much an input directed driver in which case rip out the<br>
IIO stuff and submit it as an input driver, or it is a multipurpose part<br=
>
in which case the &#39;right&#39; way to do it is that bridge driver I keep=
<br>
failing to bring up to date (anyone else fancy taking it on? I&#39;ll proba=
bly<br>
get to it, but right now all my available time goes on review so new<br>
features in my hands will take a while!)<br>
<br>
There are some other corners that still need doing, but having large<br>
quantities of input calls within an IIO driver is not going anywhere<br>
as it just makes for a maintenance mess.<br>
<br>
Actually this driver doesn&#39;t support what we would call events in IIO<b=
r>
so the current feature set of that bridge would probably be fine. =A0Note<b=
r>
to use it you&#39;d need full trigger and buffer support under IIO.<br></bl=
ockquote><div>I can&#39;t completely understand how to use IIO buffer and t=
rigger in my driver.<br>Please advice me which driver can I use as referenc=
e.<br>
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Anyhow, up to you whether you want to pitch this to linux-input with<br>
IIO removed or go the IIO =A0and input bridge route (last version<br>
&#39;might&#39; be <a href=3D"http://marc.info/?l=3Dlinux-iio&amp;m=3D13516=
7944813803&amp;w=3D2" target=3D"_blank">http://marc.info/?l=3Dlinux-iio&amp=
;m=3D135167944813803&amp;w=3D2</a> .<br>
<div><div class=3D"h5"><br>
&gt;&gt;<br>
&gt;&gt; diff --git a/Documentation/devicetree/bindings/iio/accel/bma180.tx=
t b/Documentation/devicetree/bindings/iio/accel/bma180.txt<br>
&gt;&gt; new file mode 100644<br>
&gt;&gt; index 0000000..7c13c84<br>
&gt;&gt; --- /dev/null<br>
&gt;&gt; +++ b/Documentation/devicetree/bindings/iio/accel/bma180.txt<br>
&gt;&gt; @@ -0,0 +1,53 @@<br>
&gt;&gt; +* Bosch BMA180 triaxial acceleration sensor<br>
&gt;&gt; +<br>
&gt;&gt; +<a href=3D"http://omapworld.com/BMA180_111_1002839.pdf" target=3D=
"_blank">http://omapworld.com/BMA180_111_1002839.pdf</a><br>
&gt;&gt; +<br>
&gt;&gt; +Required properties:<br>
&gt;&gt; +<br>
&gt;&gt; + =A0- compatible : should be &quot;bosch,bma180&quot;<br>
&gt;&gt; + =A0- reg : the I2C address of the sensor<br>
&gt;&gt; +<br>
&gt;&gt; +Optional properties:<br>
&gt;&gt; +<br>
&gt;&gt; + =A0- interrupt-parent : should be the phandle for the interrupt =
controller<br>
&gt;&gt; +<br>
&gt;&gt; + =A0- interrupts : interrupt mapping for GPIO IRQ, it shuld by co=
nfigured with<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0flags IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_EDGE=
_RISING<br>
&gt;&gt; +<br>
&gt;&gt; + =A0- range : select the full scale acceleration range<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A00 : -1g..+1g<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A01 : -1.5g..+1.5g<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A02 : -2g..+2g<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A03 : -3g..+3g<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A04 : -4g..+4g<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A05 : -8g..+8g<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A06 : -16g..+16g<br>
&gt;&gt; +<br>
&gt;&gt; + =A0- bw : select bandwidth bandwidth<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A00 : 10Hz<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A01 : 20Hz<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A02 : 40Hz<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A03 : 75Hz<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A04 : 150Hz<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A05 : 300Hz<br>
</div></div>Surely magic numbers should be as unacceptible in device tree f=
iles<br>
as anywhere else? =A0It&#39;s hardly difficult to use the actual values<br>
for this.<br>
<div class=3D""><div class=3D"h5"><br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0Don&#39;t use bandwidth frequency more th=
an 300Hz couse it<br>
&gt;<br>
&gt; because<br>
&gt;<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0influences the frequency of generating ne=
w data interrupts<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0and i2c reading phase can be longer than =
pheriod of interrupt<br>
&gt;<br>
&gt; period<br>
&gt;<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0generation.<br>
&gt;&gt; +<br>
&gt;&gt; + =A0- mode_config : 0 - select low noise mode, 1 - select low pow=
er mode<br>
&gt;&gt; +<br>
&gt;&gt; + =A0- fuzz : specifies fuzz value that is used to filter noise fr=
om the event stream<br>
&gt;&gt; +<br>
&gt;&gt; +Example:<br>
&gt;&gt; +<br>
&gt;&gt; +bma180@40 {<br>
&gt;&gt; + =A0 =A0compatible =3D &quot;bosch,bma180&quot;;<br>
&gt;&gt; + =A0 =A0reg =3D &lt;0x40&gt;;<br>
&gt;&gt; + =A0 =A0interrupt-parent =3D &lt;&amp;gpio6&gt;;<br>
&gt;&gt; + =A0 =A0interrupts =3D &lt;18 (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_EDG=
E_RISING)&gt;;<br>
&gt;&gt; + =A0 =A0range =3D &lt;2&gt;;<br>
&gt;&gt; + =A0 =A0bw =3D &lt;0&gt;;<br>
&gt;&gt; + =A0 =A0mode_config =3D &lt;1&gt;;<br>
&gt;&gt; + =A0 =A0fuzz =3D &lt;555&gt;;<br>
&gt;&gt; +};<br>
&gt;&gt; diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig=
<br>
&gt;&gt; index 719d83f..61fd29f 100644<br>
&gt;&gt; --- a/drivers/iio/accel/Kconfig<br>
&gt;&gt; +++ b/drivers/iio/accel/Kconfig<br>
&gt;&gt; @@ -3,6 +3,16 @@<br>
&gt;&gt; =A0#<br>
&gt;&gt; =A0menu &quot;Accelerometers&quot;<br>
&gt;&gt;<br>
&gt;&gt; +config BMA180<br>
&gt;&gt; + =A0 =A0tristate &quot;Bosch BMA180 3-Axis Accelerometer Driver&q=
uot;<br>
&gt;&gt; + =A0 =A0depends on I2C<br>
&gt;&gt; + =A0 =A0help<br>
&gt;&gt; + =A0 =A0 =A0Say Y here if you want to build a driver for the Bosc=
h BMA180<br>
&gt;&gt; + =A0 =A0 =A0triaxial acceleration sensor.<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0To compile this driver as a module, choose M here: th=
e<br>
&gt;&gt; + =A0 =A0 =A0module will be called bma180.<br>
&gt;&gt; +<br>
&gt;&gt; =A0config HID_SENSOR_ACCEL_3D<br>
&gt;&gt; =A0 =A0 =A0depends on HID_SENSOR_HUB<br>
&gt;&gt; =A0 =A0 =A0select IIO_BUFFER<br>
&gt;&gt; diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefi=
le<br>
&gt;&gt; index 87d8fa2..31a36fa 100644<br>
&gt;&gt; --- a/drivers/iio/accel/Makefile<br>
&gt;&gt; +++ b/drivers/iio/accel/Makefile<br>
&gt;&gt; @@ -12,3 +12,5 @@ obj-$(CONFIG_IIO_ST_ACCEL_I2C_3AXIS) +=3D st_acc=
el_i2c.o<br>
&gt;&gt; =A0obj-$(CONFIG_IIO_ST_ACCEL_SPI_3AXIS) +=3D st_accel_spi.o<br>
&gt;&gt;<br>
&gt;&gt; =A0obj-$(CONFIG_KXSD9) +=3D kxsd9.o<br>
&gt;&gt; +<br>
&gt;&gt; +obj-$(CONFIG_BMA180) =A0 =A0 =A0 =A0+=3D bma180.o<br>
&gt;<br>
&gt; alphabetic order<br>
&gt;<br>
&gt;&gt; diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180=
.c<br>
&gt;&gt; new file mode 100644<br>
&gt;&gt; index 0000000..9f5341f<br>
&gt;&gt; --- /dev/null<br>
&gt;&gt; +++ b/drivers/iio/accel/bma180.c<br>
&gt;&gt; @@ -0,0 +1,462 @@<br>
&gt;&gt; +/*<br>
&gt;&gt; + * bma180.c - IIO driver for Bosch BMA180 triaxial acceleration s=
ensor<br>
&gt;&gt; + *<br>
&gt;&gt; + * Copyright 2013 Oleksandr Kravchenko &lt;<a href=3D"mailto:x019=
9363@ti.com">x0199363@ti.com</a>&gt;<br>
&gt;&gt; + *<br>
&gt;&gt; + * This file is subject to the terms and conditions of version 2 =
of<br>
&gt;&gt; + * the GNU General Public License. =A0See the file COPYING in the=
 main<br>
&gt;&gt; + * directory of this archive for more details.<br>
&gt;&gt; + */<br>
&gt;&gt; +<br>
&gt;&gt; +#include &lt;linux/module.h&gt;<br>
&gt;&gt; +#include &lt;linux/i2c.h&gt;<br>
&gt;&gt; +#include &lt;linux/interrupt.h&gt;<br>
&gt;&gt; +#include &lt;linux/delay.h&gt;<br>
&gt;&gt; +#include &lt;linux/input.h&gt;<br>
&gt;&gt; +#include &lt;linux/of.h&gt;<br>
&gt;&gt; +#include &lt;linux/bitops.h&gt;<br>
&gt;&gt; +#include &lt;linux/iio/iio.h&gt;<br>
&gt;&gt; +#include &lt;linux/iio/sysfs.h&gt;<br>
&gt;&gt; +#include &lt;linux/iio/events.h&gt;<br>
&gt;&gt; +<br>
&gt;&gt; +#define BMA180_DRV_NAME &quot;bma180&quot;<br>
&gt;&gt; +#define BMA180_IRQ_NAME &quot;bma180_event&quot;<br>
&gt;&gt; +<br>
&gt;&gt; +/* Register set */<br>
&gt;&gt; +#define BMA180_CHIP_ID =A0 =A0 =A0 =A0 =A0 =A0 =A00x00 /* Need to=
 distinguish BMA180 from other */<br>
&gt;&gt; +#define BMA180_ACC_X_LSB =A0 =A00x02 /* First of 6 registers of a=
ccel data */<br>
&gt;&gt; +#define BMA180_CTRL_REG0 =A0 =A00x0d<br>
&gt;&gt; +#define BMA180_RESET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x10<br>
&gt;&gt; +#define BMA180_BW_TCS =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x20<br>
&gt;&gt; +#define BMA180_CTRL_REG3 =A0 =A00x21<br>
&gt;&gt; +#define BMA180_TCO_Z =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x30<br>
&gt;&gt; +#define BMA180_OFFSET_LSB1 =A00x35<br>
&gt;&gt; +<br>
&gt;&gt; +/* Control bits */<br>
&gt;&gt; +#define BMA180_SLEEP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(1) /* 1 -=
 chip will sleep */<br>
&gt;&gt; +#define BMA180_DIS_WAKE_UP =A0BIT(0) /* Disable wake up mode */<b=
r>
&gt;&gt; +#define BMA180_EE_W =A0 =A0 =A0 =A0 BIT(4) /* Unlock writing to a=
ddr. from 0x20 */<br>
&gt;&gt; +#define BMA180_NEW_DATA_INT BIT(1) /* Intr every new accel data i=
s ready */<br>
&gt;&gt; +#define BMA180_SMP_SKIP =A0 =A0 =A0 =A0 =A0 =A0 BIT(0) /* Sample =
skipping mode */<br>
&gt;<br>
&gt; maybe say which bits belong to which CTRL reg?<br>
&gt;<br>
&gt;&gt; +<br>
&gt;&gt; +/* Bit masks fo registerts bit fields */<br>
&gt;<br>
&gt; typos: fo, registerts<br>
&gt;<br>
&gt;&gt; +#define BMA180_RANGE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0e /* Range=
 of accel measurment */<br>
&gt;&gt; +#define BMA180_BW =A0 =A0 =A0 =A0 =A0 0xf0 /* Accel measurmend ba=
ndwidth */<br>
&gt;<br>
&gt; typo: measurmend<br>
&gt;<br>
&gt;&gt; +#define BMA180_MODE_CONFIG =A00x03 /* Config operation modes */<b=
r>
&gt;&gt; +<br>
&gt;&gt; +/* We have write this value in reset register to do soft reset */=
<br>
&gt;<br>
&gt; have &#39;to&#39; write<br>
&gt;<br>
&gt;&gt; +#define BMA180_RESET_VAL =A0 =A00xb6<br>
&gt;&gt; +<br>
&gt;&gt; +/* Chip operation modes */<br>
&gt;&gt; +#define BMA180_LOW_NOISE =A0 =A00x00<br>
&gt;&gt; +#define BMA180_LOW_POWER =A0 =A00x03<br>
&gt;&gt; +<br>
&gt;&gt; +struct bma180_data {<br>
&gt;&gt; + =A0 =A0struct i2c_client *client;<br>
&gt;&gt; + =A0 =A0struct input_dev *input_dev;<br>
&gt;&gt; + =A0 =A0struct mutex mutex;<br>
&gt;&gt; + =A0 =A0int sleep_state;<br>
&gt;&gt; + =A0 =A0int range;<br>
&gt;&gt; + =A0 =A0int bw;<br>
&gt;&gt; + =A0 =A0int mode;<br>
&gt;&gt; + =A0 =A0int fuzz;<br>
&gt;&gt; + =A0 =A0int acc_reg[3];<br>
&gt;&gt; +};<br>
&gt;&gt; +<br>
&gt;&gt; +enum bma180_axis {<br>
&gt;&gt; + =A0 =A0AXIS_X,<br>
&gt;&gt; + =A0 =A0AXIS_Y,<br>
&gt;&gt; + =A0 =A0AXIS_Z,<br>
&gt;&gt; +};<br>
&gt;&gt; +<br>
&gt;&gt; +struct bma180_range {<br>
&gt;&gt; + =A0 =A0int g_range;<br>
&gt;&gt; + =A0 =A0int ratio;<br>
&gt;&gt; +};<br>
&gt;&gt; +<br>
&gt;&gt; +static struct bma180_range bma180_range_table[7] =3D {<br>
&gt;&gt; + =A0 =A0{ 1000, 130 },<br>
&gt;&gt; + =A0 =A0{ 1500, 190 },<br>
&gt;&gt; + =A0 =A0{ 2000, 250 },<br>
&gt;&gt; + =A0 =A0{ 3000, 380 },<br>
&gt;&gt; + =A0 =A0{ 4000, 500 },<br>
&gt;&gt; + =A0 =A0{ 8000, 990 },<br>
&gt;&gt; + =A0 =A0{ 16000, 1980 },<br>
&gt;&gt; +};<br>
&gt;&gt; +<br>
&gt;&gt; +static int bma180_get_acc_reg(struct bma180_data *data, enum bma1=
80_axis axis)<br>
&gt;&gt; +{<br>
&gt;&gt; + =A0 =A0u8 reg =3D BMA180_ACC_X_LSB + axis * 2;<br>
&gt;&gt; + =A0 =A0int ret;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0if (data-&gt;sleep_state)<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0return -EBUSY;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0ret =3D i2c_smbus_read_word_data(data-&gt;client, reg);<b=
r>
&gt;&gt; + =A0 =A0if (ret &lt; 0)<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0dev_err(&amp;data-&gt;client-&gt;dev,<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&quot;failed to read acce=
l_%c registers\n&quot;, &#39;x&#39; + axis);<br>
&gt;<br>
&gt; just one register, not registers?<br>
&gt;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0return ret;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +static int bma180_set_bits(struct bma180_data *data, u8 reg, u8 m=
ask, u8 val)<br>
&gt;&gt; +{<br>
&gt;&gt; + =A0 =A0int ret =3D i2c_smbus_read_byte_data(data-&gt;client, reg=
);<br>
&gt;&gt; + =A0 =A0u8 reg_val =3D (ret &amp; ~mask) | (val &lt;&lt; (ffs(mas=
k) - 1));<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0if (ret &lt; 0)<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0return ret;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0return i2c_smbus_write_byte_data(data-&gt;client, reg, re=
g_val);<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +static int bma180_set_new_data_intr_state(struct bma180_data *dat=
a, int state)<br>
&gt;&gt; +{<br>
&gt;&gt; + =A0 =A0u8 reg_val =3D state ? BMA180_NEW_DATA_INT : 0x00;<br>
&gt;&gt; + =A0 =A0int ret =3D i2c_smbus_write_byte_data(data-&gt;client, BM=
A180_CTRL_REG3,<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg_val);<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0if (ret)<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0dev_err(&amp;data-&gt;client-&gt;dev,<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&quot;failed to set new d=
ata interrupt state %d\n&quot;, state);<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0return ret;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +static int bma180_set_sleep_state(struct bma180_data *data, int s=
tate)<br>
&gt;&gt; +{<br>
&gt;&gt; + =A0 =A0int ret =3D bma180_set_bits(data, BMA180_CTRL_REG0, BMA18=
0_SLEEP, state);<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0if (ret) {<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0dev_err(&amp;data-&gt;client-&gt;dev,<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&quot;failed to set sleep=
 state %d\n&quot;, state);<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0return ret;<br>
&gt;&gt; + =A0 =A0}<br>
&gt;&gt; + =A0 =A0data-&gt;sleep_state =3D state;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0return 0;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +static int bma180_set_ee_writing_state(struct bma180_data *data, =
int state)<br>
&gt;&gt; +{<br>
&gt;&gt; + =A0 =A0int ret =3D bma180_set_bits(data, BMA180_CTRL_REG0, BMA18=
0_EE_W, state);<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0if (ret)<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0dev_err(&amp;data-&gt;client-&gt;dev,<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&quot;failed to set ee wr=
iting state %d\n&quot;, state);<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0return ret;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +static int bma180_soft_reset(struct bma180_data *data)<br>
&gt;&gt; +{<br>
&gt;&gt; + =A0 =A0int ret =3D i2c_smbus_write_byte_data(data-&gt;client,<br=
>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BMA180_RESET, BMA180_RESE=
T_VAL);<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0if (ret)<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0dev_err(&amp;data-&gt;client-&gt;dev, &qu=
ot;failed to reset the chip\n&quot;);<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0return ret;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +static int bma180_chip_init(struct bma180_data *data)<br>
&gt;&gt; +{<br>
&gt;&gt; + =A0 =A0/* Try to read chip_id register. It must return 0x03. */<=
br>
&gt;&gt; + =A0 =A0int ret =3D i2c_smbus_read_byte_data(data-&gt;client, BMA=
180_CHIP_ID);<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0if (ret &lt; 0)<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0goto err;<br>
&gt;&gt; + =A0 =A0if (ret !=3D 0x03) {<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0ret =3D -ENODEV;<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0goto err;<br>
&gt;&gt; + =A0 =A0}<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0ret =3D bma180_soft_reset(data);<br>
&gt;&gt; + =A0 =A0if (ret)<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0goto err;<br>
&gt;&gt; + =A0 =A0/*<br>
&gt;&gt; + =A0 =A0 * No serial transaction should occur within minimum 10 =
=ECs<br>
&gt;&gt; + =A0 =A0 * after soft_reset command<br>
&gt;&gt; + =A0 =A0 */<br>
&gt;&gt; + =A0 =A0msleep(20);<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0ret =3D bma180_set_bits(data, BMA180_CTRL_REG0, BMA180_DI=
S_WAKE_UP, 1);<br>
&gt;&gt; + =A0 =A0if (ret)<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0goto err;<br>
&gt;&gt; + =A0 =A0ret =3D bma180_set_ee_writing_state(data, 1);<br>
&gt;&gt; + =A0 =A0if (ret)<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0goto err;<br>
&gt;&gt; + =A0 =A0ret =3D bma180_set_new_data_intr_state(data, 0);<br>
&gt;&gt; + =A0 =A0if (ret)<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0goto err;<br>
&gt;&gt; + =A0 =A0ret =3D bma180_set_bits(data, BMA180_BW_TCS, BMA180_BW, d=
ata-&gt;bw);<br>
&gt;&gt; + =A0 =A0if (ret)<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0goto err;<br>
&gt;&gt; + =A0 =A0ret =3D bma180_set_bits(data,<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BMA180_OFFSET_LSB1, BMA18=
0_RANGE, data-&gt;range);<br>
&gt;&gt; + =A0 =A0if (ret)<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0goto err;<br>
&gt;&gt; + =A0 =A0ret =3D bma180_set_bits(data, BMA180_TCO_Z, BMA180_MODE_C=
ONFIG,<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data-&gt;mode ? BMA180_LO=
W_POWER : BMA180_LOW_NOISE);<br>
&gt;&gt; + =A0 =A0if (ret)<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0goto err;<br>
&gt;&gt; + =A0 =A0ret =3D bma180_set_bits(data, BMA180_OFFSET_LSB1, BMA180_=
SMP_SKIP, 1);<br>
&gt;&gt; + =A0 =A0if (ret)<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0goto err;<br>
&gt;&gt; + =A0 =A0ret =3D bma180_set_new_data_intr_state(data, 1);<br>
&gt;&gt; + =A0 =A0if (ret)<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0goto err;<br>
&gt;&gt; + =A0 =A0ret =3D bma180_set_ee_writing_state(data, 0);<br>
&gt;&gt; + =A0 =A0if (ret)<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0goto err;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0return 0;<br>
&gt;&gt; +<br>
&gt;&gt; +err:<br>
&gt;&gt; + =A0 =A0dev_err(&amp;data-&gt;client-&gt;dev, &quot;failed to ini=
t the chip\n&quot;);<br>
&gt;&gt; + =A0 =A0return ret;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +static void bma180_chip_disable(struct bma180_data *data)<br>
&gt;&gt; +{<br>
&gt;&gt; + =A0 =A0if (bma180_set_ee_writing_state(data, 1))<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0goto err;<br>
&gt;&gt; + =A0 =A0if (bma180_set_new_data_intr_state(data, 0))<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0goto err;<br>
&gt;&gt; + =A0 =A0if (bma180_set_ee_writing_state(data, 0))<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0goto err;<br>
&gt;&gt; + =A0 =A0if (bma180_set_sleep_state(data, 1))<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0goto err;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0return;<br>
&gt;&gt; +<br>
&gt;&gt; +err:<br>
&gt;&gt; + =A0 =A0dev_err(&amp;data-&gt;client-&gt;dev, &quot;failed to dis=
able the chip\n&quot;);<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +static int bma180_read_raw(struct iio_dev *indio_dev,<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0struct iio_chan_spec const *chan, int *va=
l, int *val2,<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0long mask)<br>
&gt;&gt; +{<br>
&gt;&gt; + =A0 =A0struct bma180_data *data =3D iio_priv(indio_dev);<br>
&gt;&gt; + =A0 =A0long tmp =3D ((s16)data-&gt;acc_reg[chan-&gt;channel] &gt=
;&gt; 2)<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0* bma180_range_table[data-&gt;range].rati=
o;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0if (data-&gt;acc_reg[chan-&gt;channel] &lt; 0)<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0return data-&gt;acc_reg[chan-&gt;channel]=
;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0*val =3D tmp / 1000000;<br>
&gt;&gt; + =A0 =A0*val2 =3D (tmp % 1000000);<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0return IIO_VAL_INT_PLUS_MICRO;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +static const struct iio_info bma180_info =3D {<br>
&gt;&gt; + =A0 =A0.driver_module =A0=3D THIS_MODULE,<br>
&gt;&gt; + =A0 =A0.read_raw =A0 =A0 =A0 =3D &amp;bma180_read_raw,<br>
&gt;&gt; +};<br>
&gt;&gt; +<br>
&gt;&gt; +static const struct iio_chan_spec bma180_channels[] =3D {<br>
&gt;&gt; + =A0 =A0{<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0.type =3D IIO_ACCEL,<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0.channel =3D AXIS_X,<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0.channel2 =3D IIO_MOD_X,<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0.indexed =3D true,<br>
&gt;<br>
&gt; do the channels need to be indexed?<br>
&gt;<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0.info_mask_separate =3D BIT(IIO_CHAN_INFO=
_PROCESSED),<br>
&gt;&gt; + =A0 =A0}, {<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0.type =3D IIO_ACCEL,<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0.channel =3D AXIS_Y,<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0.channel2 =3D IIO_MOD_Y,<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0.indexed =3D true,<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0.info_mask_separate =3D BIT(IIO_CHAN_INFO=
_PROCESSED),<br>
&gt;&gt; + =A0 =A0}, {<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0.type =3D IIO_ACCEL,<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0.channel =3D AXIS_Z,<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0.channel2 =3D IIO_MOD_Z,<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0.indexed =3D true,<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0.info_mask_separate =3D BIT(IIO_CHAN_INFO=
_PROCESSED),<br>
&gt;&gt; + =A0 =A0},<br>
&gt;&gt; +};<br>
&gt;&gt; +<br>
&gt;&gt; +static irqreturn_t bma180_interrupt_handler(int irq, void *privat=
e)<br>
&gt;&gt; +{<br>
&gt;&gt; + =A0 =A0struct iio_dev *dev_info =3D private;<br>
&gt;&gt; + =A0 =A0struct bma180_data *data =3D iio_priv(dev_info);<br>
&gt;&gt; + =A0 =A0int i;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0mutex_lock(&amp;data-&gt;mutex);<br>
&gt;&gt; + =A0 =A0for (i =3D AXIS_X; i &lt;=3D AXIS_Z; ++i)<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0data-&gt;acc_reg[i] =3D bma180_get_acc_re=
g(data, i);<br>
&gt;&gt; + =A0 =A0mutex_unlock(&amp;data-&gt;mutex);<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0input_report_abs(data-&gt;input_dev, ABS_X, data-&gt;acc_=
reg[AXIS_X]);<br>
&gt;&gt; + =A0 =A0input_report_abs(data-&gt;input_dev, ABS_Y, data-&gt;acc_=
reg[AXIS_Y]);<br>
&gt;&gt; + =A0 =A0input_report_abs(data-&gt;input_dev, ABS_Z, data-&gt;acc_=
reg[AXIS_Z]);<br>
&gt;<br>
&gt; input subsystem stuff within IIO?<br>
&gt; uhoh...<br>
&gt;<br>
&gt; the driver should probably support more iio features: trigger, scan_mo=
de,<br>
&gt; buffer<br>
&gt;<br>
&gt;&gt; + =A0 =A0input_sync(data-&gt;input_dev);<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0return IRQ_HANDLED;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +static int bma180_probe(struct i2c_client *client,<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0const struct i2c_device_id *id)<br>
&gt;&gt; +{<br>
&gt;&gt; + =A0 =A0struct input_dev *input_dev;<br>
&gt;&gt; + =A0 =A0struct bma180_data *data;<br>
&gt;&gt; + =A0 =A0struct iio_dev *indio_dev;<br>
&gt;&gt; + =A0 =A0struct device_node *np =3D client-&gt;dev.of_node;<br>
&gt;&gt; + =A0 =A0int i, ret;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0if (!client-&gt;irq) {<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0dev_err(&amp;client-&gt;dev, &quot;this d=
river cann&#39;t work without IRQ\n&quot;);<br>
&gt;<br>
&gt; can&#39;t<br>
&gt;<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;<br>
&gt;&gt; + =A0 =A0}<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0indio_dev =3D devm_iio_device_alloc(&amp;client-&gt;dev, =
sizeof(*data));<br>
&gt;&gt; + =A0 =A0if (!indio_dev)<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0input_dev =3D input_allocate_device();<br>
&gt;&gt; + =A0 =A0if (!input_dev)<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0data =3D iio_priv(indio_dev);<br>
&gt;&gt; + =A0 =A0i2c_set_clientdata(client, indio_dev);<br>
&gt;&gt; + =A0 =A0data-&gt;client =3D client;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0of_property_read_u32(np, &quot;bw&quot;, &amp;data-&gt;bw=
);<br>
&gt;&gt; + =A0 =A0of_property_read_u32(np, &quot;range&quot;, &amp;data-&gt=
;range);<br>
&gt;&gt; + =A0 =A0of_property_read_u32(np, &quot;mode&quot;, &amp;data-&gt;=
mode);<br>
&gt;&gt; + =A0 =A0of_property_read_u32(np, &quot;fuzz&quot;, &amp;data-&gt;=
fuzz);<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0ret =3D bma180_chip_init(data);<br>
&gt;&gt; + =A0 =A0if (ret &lt; 0)<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0goto err_1;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0mutex_init(&amp;data-&gt;mutex);<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0indio_dev-&gt;dev.parent =3D &amp;client-&gt;dev;<br>
&gt;&gt; + =A0 =A0indio_dev-&gt;channels =3D bma180_channels;<br>
&gt;&gt; + =A0 =A0indio_dev-&gt;num_channels =3D ARRAY_SIZE(bma180_channels=
);<br>
&gt;&gt; + =A0 =A0indio_dev-&gt;name =3D BMA180_DRV_NAME;<br>
&gt;&gt; + =A0 =A0indio_dev-&gt;modes =3D INDIO_DIRECT_MODE;<br>
&gt;&gt; + =A0 =A0indio_dev-&gt;info =3D &amp;bma180_info;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0input_dev-&gt;name =3D BMA180_DRV_NAME;<br>
&gt;&gt; + =A0 =A0input_dev-&gt;id.bustype =3D BUS_I2C;<br>
&gt;&gt; + =A0 =A0__set_bit(EV_ABS, input_dev-&gt;evbit);<br>
&gt;&gt; + =A0 =A0for (i =3D ABS_X; i &lt;=3D ABS_Z; ++i)<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0input_set_abs_params(input_dev, i,<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
-bma180_range_table[data-&gt;range].g_range,<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
bma180_range_table[data-&gt;range].g_range,<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
data-&gt;fuzz, 0);<br>
&gt;&gt; + =A0 =A0input_dev-&gt;dev.parent =3D &amp;client-&gt;dev;<br>
&gt;&gt; + =A0 =A0input_set_drvdata(input_dev, data);<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0data-&gt;input_dev =3D input_dev;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0ret =3D devm_request_threaded_irq(&amp;client-&gt;dev, cl=
ient-&gt;irq,<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0NULL, bma180_interrupt_ha=
ndler, IRQF_ONESHOT,<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BMA180_IRQ_NAME, indio_de=
v);<br>
&gt;&gt; + =A0 =A0if (ret &lt; 0) {<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0dev_err(&amp;client-&gt;dev, &quot;irq re=
quest error %d\n&quot;, -ret);<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0goto err_1;<br>
&gt;&gt; + =A0 =A0}<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0ret =3D input_register_device(input_dev);<br>
&gt;&gt; + =A0 =A0if (ret) {<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0dev_err(&amp;client-&gt;dev, &quot;unable=
 to register input device\n&quot;);<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0goto err_1;<br>
&gt;&gt; + =A0 =A0}<br>
&gt;&gt; +<br>
&gt;&gt; +<br>
&gt;<br>
&gt; extra newline<br>
&gt;<br>
&gt;&gt; + =A0 =A0ret =3D iio_device_register(indio_dev);<br>
&gt;&gt; + =A0 =A0if (ret &lt; 0) {<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0dev_err(&amp;client-&gt;dev, &quot;unable=
 to register iio device\n&quot;);<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0goto err_2;<br>
&gt;&gt; + =A0 =A0}<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0return 0;<br>
&gt;&gt; +<br>
&gt;&gt; +err_2:<br>
&gt;&gt; + =A0 =A0input_unregister_device(input_dev);<br>
&gt;&gt; +err_1:<br>
&gt;&gt; + =A0 =A0input_free_device(input_dev);<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0bma180_chip_disable(data);<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0return ret;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +static int bma180_remove(struct i2c_client *client)<br>
&gt;&gt; +{<br>
&gt;&gt; + =A0 =A0struct iio_dev *indio_dev =3D i2c_get_clientdata(client);=
<br>
&gt;&gt; + =A0 =A0struct bma180_data *data =3D iio_priv(indio_dev);<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0iio_device_unregister(indio_dev);<br>
&gt;&gt; + =A0 =A0input_unregister_device(data-&gt;input_dev);<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0mutex_lock(&amp;data-&gt;mutex);<br>
&gt;&gt; + =A0 =A0bma180_chip_disable(data);<br>
&gt;&gt; + =A0 =A0mutex_unlock(&amp;data-&gt;mutex);<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0return 0;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +#ifdef CONFIG_PM_SLEEP<br>
&gt;&gt; +static int bma180_suspend(struct device *dev)<br>
&gt;&gt; +{<br>
&gt;&gt; + =A0 =A0struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_c=
lient(dev));<br>
&gt;&gt; + =A0 =A0struct bma180_data *data =3D iio_priv(indio_dev);<br>
&gt;&gt; + =A0 =A0int ret;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0mutex_lock(&amp;data-&gt;mutex);<br>
&gt;&gt; + =A0 =A0ret =3D bma180_set_sleep_state(data, 1);<br>
&gt;&gt; + =A0 =A0mutex_unlock(&amp;data-&gt;mutex);<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0return ret;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +static int bma180_resume(struct device *dev)<br>
&gt;&gt; +{<br>
&gt;&gt; + =A0 =A0struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_c=
lient(dev));<br>
&gt;&gt; + =A0 =A0struct bma180_data *data =3D iio_priv(indio_dev);<br>
&gt;&gt; + =A0 =A0int ret;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0mutex_lock(&amp;data-&gt;mutex);<br>
&gt;&gt; + =A0 =A0ret =3D bma180_set_sleep_state(data, 0);<br>
&gt;&gt; + =A0 =A0mutex_unlock(&amp;data-&gt;mutex);<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0return ret;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +static SIMPLE_DEV_PM_OPS(bma180_pm_ops, bma180_suspend, bma180_re=
sume);<br>
&gt;&gt; +#define BMA180_PM_OPS (&amp;bma180_pm_ops)<br>
&gt;&gt; +#else<br>
&gt;&gt; +#define BMA180_PM_OPS NULL<br>
&gt;&gt; +#endif<br>
&gt;&gt; +<br>
&gt;&gt; +static struct i2c_device_id bma180_id[] =3D {<br>
&gt;&gt; + =A0 =A0{ BMA180_DRV_NAME, 0 },<br>
&gt;&gt; + =A0 =A0{ }<br>
&gt;&gt; +};<br>
&gt;&gt; +<br>
&gt;&gt; +MODULE_DEVICE_TABLE(i2c, bma180_id);<br>
&gt;&gt; +<br>
&gt;&gt; +static struct i2c_driver bma180_driver =3D {<br>
&gt;&gt; + =A0 =A0.driver =3D {<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D BMA180_DRV_NAME,<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0.owner =A0=3D THIS_MODULE,<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0.pm =A0 =A0 =3D BMA180_PM_OPS,<br>
&gt;&gt; + =A0 =A0},<br>
&gt;&gt; + =A0 =A0.probe =A0 =A0 =A0 =A0 =A0=3D bma180_probe,<br>
&gt;&gt; + =A0 =A0.remove =A0 =A0 =A0 =A0 =3D bma180_remove,<br>
&gt;&gt; + =A0 =A0.id_table =A0 =A0 =A0 =3D bma180_id,<br>
&gt;&gt; +};<br>
&gt;&gt; +<br>
&gt;&gt; +module_i2c_driver(bma180_driver);<br>
&gt;&gt; +<br>
&gt;&gt; +MODULE_AUTHOR(&quot;Kravchenko Oleksandr &lt;<a href=3D"mailto:x0=
199363@ti.com">x0199363@ti.com</a>&gt;&quot;);<br>
&gt;&gt; +MODULE_AUTHOR(&quot;Texas Instruments, Inc.&quot;);<br>
&gt;&gt; +MODULE_DESCRIPTION(&quot;Bosch BMA180 triaxial acceleration senso=
r&quot;);<br>
&gt;&gt; +MODULE_LICENSE(&quot;GPL&quot;);<br>
&gt;&gt;<br>
&gt;<br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br><div dir=3D=
"ltr"><font size=3D"-1"><font size=3D"-1">Oleksandr Kravchenko</font><br><s=
pan style=3D"vertical-align:baseline;font-variant:normal;font-style:normal;=
font-size:12px;background-color:transparent;text-decoration:none;font-famil=
y:Arial;font-weight:normal">GlobalLogic</span><br>
<span style=3D"vertical-align:baseline;font-variant:normal;font-style:norma=
l;font-size:12px;background-color:transparent;text-decoration:none;font-fam=
ily:Arial;font-weight:normal">P +380633213187</span></font><br><font size=
=3D"-1"><font size=3D"-1"><span style=3D"vertical-align:baseline;font-varia=
nt:normal;font-style:normal;font-size:12px;background-color:transparent;tex=
t-decoration:none;font-family:Arial;font-weight:normal"><font size=3D"-1"><=
span style=3D"vertical-align:baseline;font-variant:normal;font-style:normal=
;font-size:12px;background-color:transparent;text-decoration:none;font-fami=
ly:Arial;font-weight:normal">P +380994930248</span></font><font size=3D"-1"=
><font size=3D"-1"><span style=3D"vertical-align:baseline;font-variant:norm=
al;font-style:normal;font-size:12px;background-color:transparent;text-decor=
ation:none;font-family:Arial;font-weight:normal"><br>
</span></font></font></span></font><a href=3D"http://www.globallogic.com/" =
target=3D"_blank"><span style=3D"font-size:12px;font-family:Arial;color:rgb=
(17,85,204);background-color:transparent;font-weight:normal;font-style:norm=
al;font-variant:normal;text-decoration:underline;vertical-align:baseline">w=
ww.globallogic.com</span></a><span style=3D"vertical-align:baseline;font-va=
riant:normal;font-style:normal;font-size:12px;background-color:transparent;=
text-decoration:none;font-family:Arial;font-weight:normal"></span><br>
<a href=3D"http://www.globallogic.com/" target=3D"_blank"><span style=3D"fo=
nt-size:12px;font-family:Arial;color:rgb(17,85,204);background-color:transp=
arent;font-weight:normal;font-style:normal;font-variant:normal;text-decorat=
ion:underline;vertical-align:baseline"></span></a><br>
<a href=3D"http://www.globallogic.com/email_disclaimer.txt" target=3D"_blan=
k"><span style=3D"font-size:11px;font-family:Arial;color:rgb(17,85,204);bac=
kground-color:transparent;font-weight:normal;font-style:normal;font-variant=
:normal;text-decoration:underline;vertical-align:baseline">http://www.globa=
llogic.com/email_disclaimer.txt</span></a><span style=3D"vertical-align:bas=
eline;font-variant:normal;font-style:normal;font-size:11px;background-color=
:transparent;text-decoration:none;font-family:Arial;font-weight:normal"></s=
pan></font></div>

</div></div>

--089e0111bcfa8392e404e2f7f76e--
