Return-Path: <m.othacehe@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20180707180008.14db129a@archlinux>
References: <1530521967-10152-1-git-send-email-m.othacehe@gmail.com>
 <1530521967-10152-3-git-send-email-m.othacehe@gmail.com> <20180707180008.14db129a@archlinux>
From: Mathieu Othacehe <m.othacehe@gmail.com>
Date: Fri, 20 Jul 2018 19:31:56 +0200
Message-ID: <CANVeeZzEOA7i-gqSET1iKGfTUt3BB0+3+fohVk6ncms=mG4taQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] iio: light: isl29501: Add support for the ISL29501
 ToF sensor.
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: linux-iio@vger.kernel.org, jonathan.cameron@huawei.com,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Pierre-Moana Levesque <pierre-moana.levesque@parrot.com>
Content-Type: multipart/alternative; boundary="00000000000026736b057171ac51"
List-ID: <linux-iio@vger.kernel.org>

--00000000000026736b057171ac51
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

Sorry for the late reply. I'll send a v6 with your suggestions and all the
stuff related to floating registers as a separate, wip patch (3/3), that
will be used as a basis when the IIO floating ABI we discussed we'll be
ready.

Thanks,

Mathieu


2018-07-07 19:00 GMT+02:00 Jonathan Cameron <jic23@jic23.retrosnub.co.uk>:

> On Mon,  2 Jul 2018 10:59:27 +0200
> Mathieu Othacehe <m.othacehe@gmail.com> wrote:
>
> > This patch adds support for the ISL29501 Time of Flight sensor.
> >
> > Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
>
> Hi Mathieu,
>
> I'd like to not stall the driver on us getting a solution in place
> for the values that we think need to be presented as floating point.
>
> However, I also don't want to present userspace ABI that doesn't work
> in the meantime.  I fully understand why you have left those blocks in
> there (to ensure we keep them in mind) but please could I have a version
> with that code separated out (either not there or as a follow up patch
> that I won't apply - for now).
>
> I nearly just did it myself, but there are enough corners I might mess
> it up, so would prefer if you did this separation for me!
>
> Thanks and looking forward to applying a 'partial' version in V6.
>
> If you have time, I'd like to see what those floating point patches
> are going to look like.  Its much easier to get comments with at least
> a proof of concept in place!
>
> Thanks
>
> Jonathan
>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio-isl29501   |   47 +
> >  .../devicetree/bindings/iio/light/isl29501.txt     |   13 +
> >  drivers/iio/light/Kconfig                          |   13 +
> >  drivers/iio/light/Makefile                         |    1 +
> >  drivers/iio/light/isl29501.c                       | 1125
> ++++++++++++++++++++
> >  5 files changed, 1199 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-isl29501
> >  create mode 100644 Documentation/devicetree/
> bindings/iio/light/isl29501.txt
> >  create mode 100644 drivers/iio/light/isl29501.c
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-isl29501
> b/Documentation/ABI/testing/sysfs-bus-iio-isl29501
> > new file mode 100644
> > index 0000000..d009cfb
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio-isl29501
> > @@ -0,0 +1,47 @@
> > +What:                /sys/bus/iio/devices/iio:
> deviceX/in_proximity0_agc_gain
> > +What:                /sys/bus/iio/devices/iio:
> deviceX/in_proximity0_agc_gain_bias
> > +KernelVersion:       4.18
> > +Contact:     linux-iio@vger.kernel.org
> > +Description:
> > +             This sensor has an automatic gain control (agc) loop
> > +             which sets the analog signal levels at an optimum
> > +             level by controlling programmable gain amplifiers. The
> > +             criteria for optimal gain is determined by the sensor.
> > +
> > +             Return the actual gain value as an integer in [0; 65536]
> > +             range when read from.
> > +
> > +             The agc gain read when measuring crosstalk shall be
> > +             written into in_proximity0_agc_gain_bias.
> > +
> > +What:                /sys/bus/iio/devices/iio:
> deviceX/in_proximity0_calib_phase_temp_a
> > +What:                /sys/bus/iio/devices/iio:
> deviceX/in_proximity0_calib_phase_temp_b
> > +What:                /sys/bus/iio/devices/iio:
> deviceX/in_proximity0_calib_phase_light_a
> > +What:                /sys/bus/iio/devices/iio:
> deviceX/in_proximity0_calib_phase_light_b
> > +KernelVersion:       4.18
> > +Contact:     linux-iio@vger.kernel.org
> > +Description:
> > +             The sensor is able to perform correction of distance
> > +             measurements due to changing temperature and ambient
> > +             light conditions. It can be programmed to correct for
> > +             a second order error polynomial.
> > +
> > +             Phase data has to be collected when temperature and
> > +             ambient light are modulated independently.
> > +
> > +             Then a least squares curve fit to a second order
> > +             polynomial has to be generated from the data. The
> > +             resultant curves have the form ax^2 + bx + c.
> > +
> > +             From those two curves, a and b coefficients shall be
> > +             stored in in_proximity0_calib_phase_temp_a and
> > +             in_proximity0_calib_phase_temp_b for temperature and
> > +             in in_proximity0_calib_phase_light_a and
> > +             in_proximity0_calib_phase_light_b for ambient light.
> > +
> > +             Those values must be integer in [0; 8355840] range.
> > +
> > +             Finally, the c constant is set by the sensor
> > +             internally.
> > +
> > +             The value stored in sensor is displayed when read from.
> > diff --git a/Documentation/devicetree/bindings/iio/light/isl29501.txt
> b/Documentation/devicetree/bindings/iio/light/isl29501.txt
> > new file mode 100644
> > index 0000000..4695799
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/light/isl29501.txt
> > @@ -0,0 +1,13 @@
> > +* ISL29501 Time-of-flight sensor.
> > +
> > +Required properties:
> > +
> > +  - compatible : should be "renesas,isl29501"
> > +  - reg : the I2C address of the sensor
> > +
> > +Example:
> > +
> > +isl29501@57 {
> > +     compatible =3D "renesas,isl29501";
> > +     reg =3D <0x57>;
> > +};
> > diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> > index c7ef8d1..3882bdc 100644
> > --- a/drivers/iio/light/Kconfig
> > +++ b/drivers/iio/light/Kconfig
> > @@ -194,6 +194,19 @@ config ISL29125
> >         To compile this driver as a module, choose M here: the module
> will be
> >         called isl29125.
> >
> > +config ISL29501
> > +     tristate "Intersil ISL29501 Time Of Flight sensor"
> > +     depends on I2C
> > +     select IIO_BUFFER
> > +     select IIO_TRIGGERED_BUFFER
> > +     select IIO_KFIFO_BUF
> > +     help
> > +       Say Y here if you want to build a driver for the Intersil
> ISL29501
> > +       Time of Flight sensor.
> > +
> > +       To compile this driver as a module, choose M here: the module
> will be
> > +       called isl29501.
> > +
> >  config HID_SENSOR_ALS
> >       depends on HID_SENSOR_HUB
> >       select IIO_BUFFER
> > diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> > index 80943af..81c0631 100644
> > --- a/drivers/iio/light/Makefile
> > +++ b/drivers/iio/light/Makefile
> > @@ -23,6 +23,7 @@ obj-$(CONFIG_HID_SENSOR_PROX)       +=3D
> hid-sensor-prox.o
> >  obj-$(CONFIG_SENSORS_ISL29018)       +=3D isl29018.o
> >  obj-$(CONFIG_SENSORS_ISL29028)       +=3D isl29028.o
> >  obj-$(CONFIG_ISL29125)               +=3D isl29125.o
> > +obj-$(CONFIG_ISL29501)               +=3D isl29501.o
> >  obj-$(CONFIG_JSA1212)                +=3D jsa1212.o
> >  obj-$(CONFIG_SENSORS_LM3533) +=3D lm3533-als.o
> >  obj-$(CONFIG_LTR501)         +=3D ltr501.o
> > diff --git a/drivers/iio/light/isl29501.c b/drivers/iio/light/isl29501.=
c
> > new file mode 100644
> > index 0000000..e9145d3
> > --- /dev/null
> > +++ b/drivers/iio/light/isl29501.c
> > @@ -0,0 +1,1125 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * isl29501.c: ISL29501 Time of Flight sensor driver.
> > + *
> > + * Copyright (C) 2018
> > + * Author: Mathieu Othacehe <m.othacehe@gmail.com>
> > + *
> > + * 7-bit I2C slave address: 0x57
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/i2c.h>
> > +#include <linux/err.h>
> > +#include <linux/of_device.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +
> > +#include <linux/iio/trigger_consumer.h>
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +
> > +/* Control, setting and status registers */
> > +#define ISL29501_DEVICE_ID                   0x00
> > +#define ISL29501_ID                          0x0A
> > +
> > +/* Sampling control registers */
> > +#define ISL29501_INTEGRATION_PERIOD          0x10
> > +#define ISL29501_SAMPLE_PERIOD                       0x11
> > +
> > +/* Closed loop calibration registers */
> > +#define ISL29501_CROSSTALK_I_MSB             0x24
> > +#define ISL29501_CROSSTALK_I_LSB             0x25
> > +#define ISL29501_CROSSTALK_I_EXPONENT                0x26
> > +#define ISL29501_CROSSTALK_Q_MSB             0x27
> > +#define ISL29501_CROSSTALK_Q_LSB             0x28
> > +#define ISL29501_CROSSTALK_Q_EXPONENT                0x29
> > +#define ISL29501_CROSSTALK_GAIN_MSB          0x2A
> > +#define ISL29501_CROSSTALK_GAIN_LSB          0x2B
> > +#define ISL29501_MAGNITUDE_REF_EXP           0x2C
> > +#define ISL29501_MAGNITUDE_REF_MSB           0x2D
> > +#define ISL29501_MAGNITUDE_REF_LSB           0x2E
> > +#define ISL29501_PHASE_OFFSET_MSB            0x2F
> > +#define ISL29501_PHASE_OFFSET_LSB            0x30
> > +
> > +/* Analog control registers */
> > +#define ISL29501_DRIVER_RANGE                        0x90
> > +#define ISL29501_EMITTER_DAC                 0x91
> > +
> > +#define ISL29501_COMMAND_REGISTER            0xB0
> > +
> > +/* Commands */
> > +#define ISL29501_EMUL_SAMPLE_START_PIN               0x49
> > +#define ISL29501_RESET_ALL_REGISTERS         0xD7
> > +#define ISL29501_RESET_INT_SM                        0xD1
> > +
> > +/* Ambiant light and temperature corrections */
> > +#define ISL29501_TEMP_REFERENCE                      0x31
> > +#define ISL29501_PHASE_EXPONENT                      0x33
> > +#define ISL29501_TEMP_COEFF_A                        0x34
> > +#define ISL29501_TEMP_COEFF_B                        0x39
> > +#define ISL29501_AMBIANT_COEFF_A             0x36
> > +#define ISL29501_AMBIANT_COEFF_B             0x3B
> > +
> > +/* Data output registers */
> > +#define ISL29501_DISTANCE_MSB_DATA           0xD1
> > +#define ISL29501_DISTANCE_LSB_DATA           0xD2
> > +#define ISL29501_PRECISION_MSB                       0xD3
> > +#define ISL29501_PRECISION_LSB                       0xD4
> > +#define ISL29501_MAGNITUDE_EXPONENT          0xD5
> > +#define ISL29501_MAGNITUDE_MSB                       0xD6
> > +#define ISL29501_MAGNITUDE_LSB                       0xD7
> > +#define ISL29501_PHASE_MSB                   0xD8
> > +#define ISL29501_PHASE_LSB                   0xD9
> > +#define ISL29501_I_RAW_EXPONENT                      0xDA
> > +#define ISL29501_I_RAW_MSB                   0xDB
> > +#define ISL29501_I_RAW_LSB                   0xDC
> > +#define ISL29501_Q_RAW_EXPONENT                      0xDD
> > +#define ISL29501_Q_RAW_MSB                   0xDE
> > +#define ISL29501_Q_RAW_LSB                   0xDF
> > +#define ISL29501_DIE_TEMPERATURE             0xE2
> > +#define ISL29501_AMBIENT_LIGHT                       0xE3
> > +#define ISL29501_GAIN_MSB                    0xE6
> > +#define ISL29501_GAIN_LSB                    0xE7
> > +
> > +#define ISL29501_MAX_EXP_VAL 15
> > +
> > +#define ISL29501_INT_TIME_AVAILABLE \
> > +     "0.00007 0.00014 0.00028 0.00057 0.00114 " \
> > +     "0.00228 0.00455 0.00910 0.01820 0.03640 " \
> > +     "0.07281 0.14561"
> > +
> > +#define ISL29501_CURRENT_SCALE_AVAILABLE \
> > +     "0.0039 0.0078 0.0118 0.0157 0.0196 " \
> > +     "0.0235 0.0275 0.0314 0.0352 0.0392 " \
> > +     "0.0431 0.0471 0.0510 0.0549 0.0588"
> > +
> > +enum isl29501_correction_coeff {
> > +     COEFF_TEMP_A,
> > +     COEFF_TEMP_B,
> > +     COEFF_LIGHT_A,
> > +     COEFF_LIGHT_B,
> > +     COEFF_MAX,
> > +};
> > +
> > +struct isl29501_private {
> > +     struct i2c_client *client;
> > +     struct mutex lock;
> > +     /* Exact representation of correction coefficients. */
> > +     unsigned int shadow_coeffs[COEFF_MAX];
> > +};
> > +
> > +enum isl29501_register_name {
> > +     REG_DISTANCE,
> > +     REG_AMPLITUDE,
> > +     REG_PHASE,
> > +     REG_I_RAW,
> > +     REG_Q_RAW,
> > +     REG_TEMPERATURE,
> > +     REG_AMBIENT_LIGHT,
> > +     REG_GAIN,
> > +     REG_I_BIAS,
> > +     REG_Q_BIAS,
> > +     REG_GAIN_BIAS,
> > +     REG_AMPL_BIAS,
> > +     REG_PHASE_EXP,
> > +     REG_CALIB_PHASE_TEMP_A,
> > +     REG_CALIB_PHASE_TEMP_B,
> > +     REG_CALIB_PHASE_LIGHT_A,
> > +     REG_CALIB_PHASE_LIGHT_B,
> > +     REG_DISTANCE_BIAS,
> > +     REG_TEMPERATURE_BIAS,
> > +     REG_INT_TIME,
> > +     REG_SAMPLE_TIME,
> > +     REG_DRIVER_RANGE,
> > +     REG_EMITTER_DAC,
> > +};
> > +
> > +struct isl29501_register_desc {
> > +     u8 msb;
> > +     u8 lsb;
> > +     u8 exp;
> > +};
> > +
> > +static const struct isl29501_register_desc isl29501_registers[] =3D {
> > +     [REG_DISTANCE] =3D {
> > +             .msb =3D ISL29501_DISTANCE_MSB_DATA,
> > +             .lsb =3D ISL29501_DISTANCE_LSB_DATA,
> > +     },
> > +     [REG_AMPLITUDE] =3D {
> > +             .msb =3D ISL29501_MAGNITUDE_MSB,
> > +             .lsb =3D ISL29501_MAGNITUDE_LSB,
> > +             .exp =3D ISL29501_MAGNITUDE_EXPONENT,
> > +     },
> > +     [REG_PHASE] =3D {
> > +             .msb =3D ISL29501_PHASE_MSB,
> > +             .lsb =3D ISL29501_PHASE_LSB,
> > +     },
> > +     [REG_I_RAW] =3D {
> > +             .msb =3D ISL29501_I_RAW_MSB,
> > +             .lsb =3D ISL29501_I_RAW_LSB,
> > +             .exp =3D ISL29501_I_RAW_EXPONENT,
> > +     },
> > +     [REG_Q_RAW] =3D {
> > +             .msb =3D ISL29501_Q_RAW_MSB,
> > +             .lsb =3D ISL29501_Q_RAW_LSB,
> > +             .exp =3D ISL29501_Q_RAW_EXPONENT,
> > +     },
> > +     [REG_TEMPERATURE] =3D {
> > +             .lsb =3D ISL29501_DIE_TEMPERATURE,
> > +     },
> > +     [REG_AMBIENT_LIGHT] =3D {
> > +             .lsb =3D ISL29501_AMBIENT_LIGHT,
> > +     },
> > +     [REG_GAIN] =3D {
> > +             .msb =3D ISL29501_GAIN_MSB,
> > +             .lsb =3D ISL29501_GAIN_LSB,
> > +     },
> > +     [REG_I_BIAS] =3D {
> > +             .msb =3D ISL29501_CROSSTALK_I_MSB,
> > +             .lsb =3D ISL29501_CROSSTALK_I_LSB,
> > +             .exp =3D ISL29501_CROSSTALK_I_EXPONENT,
> > +     },
> > +     [REG_Q_BIAS] =3D {
> > +             .msb =3D ISL29501_CROSSTALK_Q_MSB,
> > +             .lsb =3D ISL29501_CROSSTALK_Q_LSB,
> > +             .exp =3D ISL29501_CROSSTALK_Q_EXPONENT,
> > +     },
> > +     [REG_GAIN_BIAS] =3D {
> > +             .msb =3D ISL29501_CROSSTALK_GAIN_MSB,
> > +             .lsb =3D ISL29501_CROSSTALK_GAIN_LSB,
> > +     },
> > +     [REG_AMPL_BIAS] =3D {
> > +             .msb =3D ISL29501_MAGNITUDE_REF_MSB,
> > +             .lsb =3D ISL29501_MAGNITUDE_REF_LSB,
> > +             .exp =3D ISL29501_MAGNITUDE_REF_EXP,
> > +     },
> > +     [REG_PHASE_EXP] =3D {
> > +             .lsb =3D ISL29501_PHASE_EXPONENT,
> > +     },
> > +     [REG_CALIB_PHASE_TEMP_A] =3D {
> > +             .lsb =3D ISL29501_TEMP_COEFF_A,
> > +     },
> > +     [REG_CALIB_PHASE_TEMP_B] =3D {
> > +             .lsb =3D ISL29501_TEMP_COEFF_B,
> > +     },
> > +     [REG_CALIB_PHASE_LIGHT_A] =3D {
> > +             .lsb =3D ISL29501_AMBIANT_COEFF_A,
> > +     },
> > +     [REG_CALIB_PHASE_LIGHT_B] =3D {
> > +             .lsb =3D ISL29501_AMBIANT_COEFF_B,
> > +     },
> > +     [REG_DISTANCE_BIAS] =3D {
> > +             .msb =3D ISL29501_PHASE_OFFSET_MSB,
> > +             .lsb =3D ISL29501_PHASE_OFFSET_LSB,
> > +     },
> > +     [REG_TEMPERATURE_BIAS] =3D {
> > +             .lsb =3D ISL29501_TEMP_REFERENCE,
> > +     },
> > +     [REG_INT_TIME] =3D {
> > +             .lsb =3D ISL29501_INTEGRATION_PERIOD,
> > +     },
> > +     [REG_SAMPLE_TIME] =3D {
> > +             .lsb =3D ISL29501_SAMPLE_PERIOD,
> > +     },
> > +     [REG_DRIVER_RANGE] =3D {
> > +             .lsb =3D ISL29501_DRIVER_RANGE,
> > +     },
> > +     [REG_EMITTER_DAC] =3D {
> > +             .lsb =3D ISL29501_EMITTER_DAC,
> > +     },
> > +};
> > +
> > +static int isl29501_register_read(struct isl29501_private *isl29501,
> > +                               enum isl29501_register_name name,
> > +                               u32 *val)
> > +{
> > +     const struct isl29501_register_desc *reg =3D
> &isl29501_registers[name];
> > +     u8 msb =3D 0, lsb =3D 0, exp =3D 0;
> > +     s32 ret;
> > +
> > +     mutex_lock(&isl29501->lock);
> > +     if (reg->msb) {
> > +             ret =3D i2c_smbus_read_byte_data(isl29501->client,
> reg->msb);
> > +             if (ret < 0)
> > +                     goto err;
> > +             msb =3D ret;
> > +     }
> > +
> > +     if (reg->lsb) {
> > +             ret =3D i2c_smbus_read_byte_data(isl29501->client,
> reg->lsb);
> > +             if (ret < 0)
> > +                     goto err;
> > +             lsb =3D ret;
> > +     }
> > +
> > +     if (reg->exp) {
> > +             ret =3D i2c_smbus_read_byte_data(isl29501->client,
> reg->exp);
> > +             if (ret < 0)
> > +                     goto err;
> > +             exp =3D ret;
> > +     }
> > +     mutex_unlock(&isl29501->lock);
> > +
> > +     *val =3D ((msb << 8) + lsb) << exp;
> > +
> > +     return 0;
> > +err:
> > +     mutex_unlock(&isl29501->lock);
> > +     return ret;
> > +}
> > +
> > +static u32 isl29501_register_write(struct isl29501_private *isl29501,
> > +                                enum isl29501_register_name name,
> > +                                u32 value)
> > +{
> > +     const struct isl29501_register_desc *reg =3D
> &isl29501_registers[name];
> > +     u8 msb, lsb;
> > +     int ret;
> > +
> > +     if (!reg->msb && value > U8_MAX)
> > +             return -ERANGE;
> > +
> > +     if (!reg->exp && value > U16_MAX)
> > +             return -ERANGE;
> > +
> > +     if (reg->exp) {
>
> Please drop the code that leads to this 'for now'.
> We'll bring it back in once we have support for the floating point stuff.
>
> > +             /* TODO: Implement float write */
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (!reg->msb) {
> > +             lsb =3D value & 0xFF;
> > +     } else {
> > +             msb =3D (value >> 8) & 0xFF;
> > +             lsb =3D value & 0xFF;
> > +     }
> > +
> > +     mutex_lock(&isl29501->lock);
> > +     if (reg->msb) {
> > +             ret =3D i2c_smbus_write_byte_data(isl29501->client,
> > +                                             reg->msb, msb);
> > +             if (ret < 0)
> > +                     goto err;
> > +     }
> > +
> > +     ret =3D i2c_smbus_write_byte_data(isl29501->client, reg->lsb, lsb=
);
> > +
> > +err:
> > +     mutex_unlock(&isl29501->lock);
>
> Nitpick : Blank line here would be nice.
>
> > +     return ret;
> > +}
> > +
> > +static ssize_t isl29501_read_ext(struct iio_dev *indio_dev,
> > +                              uintptr_t private,
> > +                              const struct iio_chan_spec *chan,
> > +                              char *buf)
> > +{
> > +     struct isl29501_private *isl29501 =3D iio_priv(indio_dev);
> > +     enum isl29501_register_name reg =3D private;
> > +     int ret;
> > +     u32 value, gain, coeff, exp;
> > +
> > +     switch (reg) {
> > +     case REG_GAIN:
> > +     case REG_GAIN_BIAS:
> > +             ret =3D isl29501_register_read(isl29501, reg, &gain);
> > +             if (ret < 0)
> > +                     return ret;
> > +
> > +             value =3D gain;
> > +             break;
> > +     case REG_CALIB_PHASE_TEMP_A:
> > +     case REG_CALIB_PHASE_TEMP_B:
> > +     case REG_CALIB_PHASE_LIGHT_A:
> > +     case REG_CALIB_PHASE_LIGHT_B:
> > +             ret =3D isl29501_register_read(isl29501, REG_PHASE_EXP,
> &exp);
> > +             if (ret < 0)
> > +                     return ret;
> > +
> > +             ret =3D isl29501_register_read(isl29501, reg, &coeff);
> > +             if (ret < 0)
> > +                     return ret;
> > +
> > +             value =3D coeff << exp;
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     return sprintf(buf, "%u\n", value);
> > +}
> > +
> > +static int isl29501_set_shadow_coeff(struct isl29501_private *isl29501=
,
> > +                                  enum isl29501_register_name reg,
> > +                                  unsigned int val)
> > +{
> > +     enum isl29501_correction_coeff coeff;
> > +
> > +     switch (reg) {
> > +     case REG_CALIB_PHASE_TEMP_A:
> > +             coeff =3D COEFF_TEMP_A;
> > +             break;
> > +     case REG_CALIB_PHASE_TEMP_B:
> > +             coeff =3D COEFF_TEMP_B;
> > +             break;
> > +     case REG_CALIB_PHASE_LIGHT_A:
> > +             coeff =3D COEFF_LIGHT_A;
> > +             break;
> > +     case REG_CALIB_PHASE_LIGHT_B:
> > +             coeff =3D COEFF_LIGHT_B;
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +     isl29501->shadow_coeffs[coeff] =3D val;
> > +
> > +     return 0;
> > +}
> > +
> > +static int isl29501_write_coeff(struct isl29501_private *isl29501,
> > +                             enum isl29501_correction_coeff coeff,
> > +                             int val)
> > +{
> > +     enum isl29501_register_name reg;
> > +
> > +     switch (coeff) {
> > +     case COEFF_TEMP_A:
> > +             reg =3D REG_CALIB_PHASE_TEMP_A;
> > +             break;
> > +     case COEFF_TEMP_B:
> > +             reg =3D REG_CALIB_PHASE_TEMP_B;
> > +             break;
> > +     case COEFF_LIGHT_A:
> > +             reg =3D REG_CALIB_PHASE_LIGHT_A;
> > +             break;
> > +     case COEFF_LIGHT_B:
> > +             reg =3D REG_CALIB_PHASE_LIGHT_B;
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     return isl29501_register_write(isl29501, reg, val);
> > +}
> > +
> > +static unsigned int isl29501_find_corr_exp(unsigned int val,
> > +                                        unsigned int max_exp,
> > +                                        unsigned int max_mantissa)
> > +{
> > +     unsigned int exp =3D 1;
> > +
> > +     /*
> > +      * Correction coefficients are represented under
> > +      * mantissa * 2^exponent form, where mantissa and exponent
> > +      * are stored in two separate registers of the sensor.
> > +      *
> > +      * Compute and return the lowest exponent such as:
> > +      *           mantissa =3D value / 2^exponent
> > +      *
> > +      *  where mantissa < max_mantissa.
> > +      */
> > +     if (val <=3D max_mantissa)
> > +             return 0;
> > +
> > +     while ((val >> exp) > max_mantissa) {
> > +             exp++;
> > +
> > +             if (exp > max_exp)
> > +                     return max_exp;
> > +     }
> > +
> > +     return exp;
> > +}
> > +
> > +static ssize_t isl29501_write_ext(struct iio_dev *indio_dev,
> > +                               uintptr_t private,
> > +                               const struct iio_chan_spec *chan,
> > +                               const char *buf, size_t len)
> > +{
> > +     struct isl29501_private *isl29501 =3D iio_priv(indio_dev);
> > +     enum isl29501_register_name reg =3D private;
> > +     unsigned int val;
> > +     int max_exp =3D 0;
> > +     int ret;
> > +     int i;
> > +
> > +     ret =3D kstrtouint(buf, 10, &val);
> > +     if (ret)
> > +             return ret;
> > +
> > +     switch (reg) {
> > +     case REG_GAIN_BIAS:
> > +             if (val > U16_MAX)
> > +                     return -ERANGE;
> > +
> > +             ret =3D isl29501_register_write(isl29501, reg, val);
> > +             if (ret < 0)
> > +                     return ret;
> > +
> > +             break;
> > +     case REG_CALIB_PHASE_TEMP_A:
> > +     case REG_CALIB_PHASE_TEMP_B:
> > +     case REG_CALIB_PHASE_LIGHT_A:
> > +     case REG_CALIB_PHASE_LIGHT_B:
> > +
> > +             if (val > (U8_MAX << ISL29501_MAX_EXP_VAL))
> > +                     return -ERANGE;
> > +
> > +             /* Store the correction coefficient under its exact form.
> */
> > +             ret =3D isl29501_set_shadow_coeff(isl29501, reg, val);
> > +             if (ret < 0)
> > +                     return ret;
> > +
> > +             /*
> > +              * Find the highest exponent needed to represent
> > +              * correction coefficients.
> > +              */
> > +             for (i =3D 0; i < COEFF_MAX; i++) {
> > +                     int corr;
> > +                     int corr_exp;
> > +
> > +                     corr =3D isl29501->shadow_coeffs[i];
> > +                     corr_exp =3D isl29501_find_corr_exp(corr,
> > +
>  ISL29501_MAX_EXP_VAL,
> > +                                                       U8_MAX / 2);
> > +                     dev_dbg(&isl29501->client->dev,
> > +                             "found exp of corr(%d) =3D %d\n", corr,
> corr_exp);
> > +
> > +                     max_exp =3D max(max_exp, corr_exp);
> > +             }
> > +
> > +             /*
> > +              * Represent every correction coefficient under
> > +              * mantissa * 2^max_exponent form and force the
> > +              * writing of those coefficients on the sensor.
> > +              */
> > +             for (i =3D 0; i < COEFF_MAX; i++) {
> > +                     int corr;
> > +                     int mantissa;
> > +
> > +                     corr =3D isl29501->shadow_coeffs[i];
> > +                     if (!corr)
> > +                             continue;
> > +
> > +                     mantissa =3D corr >> max_exp;
> > +
> > +                     ret =3D isl29501_write_coeff(isl29501, i, mantiss=
a);
> > +                     if (ret < 0)
> > +                             return ret;
> > +             }
> > +
> > +             ret =3D isl29501_register_write(isl29501, REG_PHASE_EXP,
> max_exp);
> > +             if (ret < 0)
> > +                     return ret;
> > +
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     return len;
> > +}
> > +
> > +#define _ISL29501_EXT_INFO(_name, _ident) { \
> > +     .name =3D _name, \
> > +     .read =3D isl29501_read_ext, \
> > +     .write =3D isl29501_write_ext, \
> > +     .private =3D _ident, \
> > +     .shared =3D IIO_SEPARATE, \
> > +}
> > +
> > +static const struct iio_chan_spec_ext_info isl29501_ext_info[] =3D {
> > +     _ISL29501_EXT_INFO("agc_gain", REG_GAIN),
> > +     _ISL29501_EXT_INFO("agc_gain_bias", REG_GAIN_BIAS),
> > +     _ISL29501_EXT_INFO("calib_phase_temp_a", REG_CALIB_PHASE_TEMP_A),
> > +     _ISL29501_EXT_INFO("calib_phase_temp_b", REG_CALIB_PHASE_TEMP_B),
> > +     _ISL29501_EXT_INFO("calib_phase_light_a",
> REG_CALIB_PHASE_LIGHT_A),
> > +     _ISL29501_EXT_INFO("calib_phase_light_b",
> REG_CALIB_PHASE_LIGHT_B),
> > +     { },
> > +};
> > +
> > +#define ISL29501_DISTANCE_SCAN_INDEX 0
> > +#define ISL29501_TIMESTAMP_SCAN_INDEX 1
> > +
> > +static const struct iio_chan_spec isl29501_channels[] =3D {
> > +     {
> > +             .type =3D IIO_PROXIMITY,
> > +             .scan_index =3D ISL29501_DISTANCE_SCAN_INDEX,
> > +             .info_mask_separate =3D
> > +                     BIT(IIO_CHAN_INFO_RAW)   |
> > +                     BIT(IIO_CHAN_INFO_SCALE) |
> > +                     BIT(IIO_CHAN_INFO_CALIBBIAS),
> > +             .scan_type =3D {
> > +                     .sign =3D 'u',
> > +                     .realbits =3D 16,
> > +                     .storagebits =3D 16,
> > +                     .endianness =3D IIO_CPU,
> > +             },
> > +             .info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_INT_TIME) =
|
> > +                             BIT(IIO_CHAN_INFO_SAMP_FREQ),
> > +             .ext_info =3D isl29501_ext_info,
> > +     },
> > +     {
> > +             .type =3D IIO_PHASE,
> > +             .scan_index =3D -1,
> > +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > +                             BIT(IIO_CHAN_INFO_SCALE),
> > +     },
> > +     {
> > +             .type =3D IIO_INTENSITY,
> > +             .scan_index =3D -1,
> > +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > +                             BIT(IIO_CHAN_INFO_CALIBBIAS),
> > +     },
> > +     {
> > +             .type =3D IIO_INTENSITY,
> > +             .scan_index =3D -1,
> > +             .modified =3D 1,
> > +             .channel2 =3D IIO_MOD_I,
> > +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > +                             BIT(IIO_CHAN_INFO_CALIBBIAS),
> > +     },
> > +     {
> > +             .type =3D IIO_INTENSITY,
> > +             .scan_index =3D -1,
> > +             .modified =3D 1,
> > +             .channel2 =3D IIO_MOD_Q,
> > +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > +                             BIT(IIO_CHAN_INFO_CALIBBIAS),
> > +     },
> > +     {
> > +             .type =3D IIO_CURRENT,
> > +             .scan_index =3D -1,
> > +             .output =3D 1,
> > +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > +                             BIT(IIO_CHAN_INFO_SCALE),
> > +     },
> > +     {
> > +             .type =3D IIO_TEMP,
> > +             .scan_index =3D -1,
> > +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > +                             BIT(IIO_CHAN_INFO_SCALE)     |
> > +                             BIT(IIO_CHAN_INFO_CALIBBIAS),
> > +     },
> > +     {
> > +             .type =3D IIO_INTENSITY,
> > +             .scan_index =3D -1,
> > +             .modified =3D 1,
> > +             .channel2 =3D IIO_MOD_LIGHT_CLEAR,
> > +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > +                             BIT(IIO_CHAN_INFO_SCALE),
> > +     },
> > +     IIO_CHAN_SOFT_TIMESTAMP(ISL29501_TIMESTAMP_SCAN_INDEX),
> > +};
> > +
> > +static int isl29501_reset_registers(struct isl29501_private *isl29501)
> > +{
> > +     int ret;
> > +
> > +     ret =3D i2c_smbus_write_byte_data(isl29501->client,
> > +                                     ISL29501_COMMAND_REGISTER,
> > +                                     ISL29501_RESET_ALL_REGISTERS);
> > +     if (ret < 0) {
> > +             dev_err(&isl29501->client->dev,
> > +                     "cannot reset registers %d\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     ret =3D i2c_smbus_write_byte_data(isl29501->client,
> > +                                     ISL29501_COMMAND_REGISTER,
> > +                                     ISL29501_RESET_INT_SM);
> > +     if (ret < 0) {
> > +             dev_err(&isl29501->client->dev,
> > +                     "cannot reset state machine %d\n", ret);
> > +             return ret;
>
> As below.
>
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int isl29501_begin_acquisition(struct isl29501_private
> *isl29501)
> > +{
> > +     int ret;
> > +
> > +     ret =3D i2c_smbus_write_byte_data(isl29501->client,
> > +                                     ISL29501_COMMAND_REGISTER,
> > +                                     ISL29501_EMUL_SAMPLE_START_PIN);
> > +     if (ret < 0) {
> > +             dev_err(&isl29501->client->dev,
> > +                     "cannot begin acquisition %d\n", ret);
> > +             return ret;
>
> Nitpick: IIRC i2c_smbus_write_byte_data never returns positive, so
> ret will be 0 if we aren't in here.
>
> Hence
>
>         if (ret < 0)
>                 dev_err(&isl29501->client->dev,
>                         "...");
>
>         return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static IIO_CONST_ATTR_INT_TIME_AVAIL(ISL29501_INT_TIME_AVAILABLE);
> > +static IIO_CONST_ATTR(out_current_scale_available,
> > +                   ISL29501_CURRENT_SCALE_AVAILABLE);
> > +
> > +static struct attribute *isl29501_attributes[] =3D {
> > +     &iio_const_attr_integration_time_available.dev_attr.attr,
> > +     &iio_const_attr_out_current_scale_available.dev_attr.attr,
> > +     NULL
> > +};
> > +
> > +static const struct attribute_group isl29501_attribute_group =3D {
> > +     .attrs =3D isl29501_attributes,
> > +};
> > +
> > +static const int isl29501_current_scale_table[][2] =3D {
> > +     {0, 3900}, {0, 7800}, {0, 11800}, {0, 15700},
> > +     {0, 19600}, {0, 23500}, {0, 27500}, {0, 31400},
> > +     {0, 35200}, {0, 39200}, {0, 43100}, {0, 47100},
> > +     {0, 51000}, {0, 54900}, {0, 58800},
> > +};
> > +
> > +static const int isl29501_int_time[][2] =3D {
> > +     {0, 70},    /* 0.07 ms */
> > +     {0, 140},   /* 0.14 ms */
> > +     {0, 280},   /* 0.28 ms */
> > +     {0, 570},   /* 0.57 ms */
> > +     {0, 1140},  /* 1.14 ms */
> > +     {0, 2280},  /* 2.28 ms */
> > +     {0, 4550},  /* 4.55 ms */
> > +     {0, 9100},  /* 9.11 ms */
> > +     {0, 18200}, /* 18.2 ms */
> > +     {0, 36400}, /* 36.4 ms */
> > +     {0, 72810}, /* 72.81 ms */
> > +     {0, 145610} /* 145.28 ms */
> > +};
> > +
> > +static int isl29501_get_raw(struct isl29501_private *isl29501,
> > +                         const struct iio_chan_spec *chan,
> > +                         int *raw)
> > +{
> > +     int ret;
> > +
> > +     switch (chan->type) {
> > +     case IIO_PROXIMITY:
> > +             ret =3D isl29501_register_read(isl29501, REG_DISTANCE, ra=
w);
> > +             if (ret < 0)
> > +                     return ret;
> > +
> > +             return IIO_VAL_INT;
> > +     case IIO_INTENSITY:
> > +             switch (chan->channel2) {
> > +             case IIO_NO_MOD:
> > +             case IIO_MOD_I:
> > +             case IIO_MOD_Q:
> > +                     /* TODO: implement float read */
> Another block we need to drop for now.
> > +                     return -EINVAL;
> > +             case IIO_MOD_LIGHT_CLEAR:
> > +                     ret =3D isl29501_register_read(isl29501,
> > +                                                  REG_AMBIENT_LIGHT,
> > +                                                  raw);
> > +                     if (ret < 0)
> > +                             return ret;
> > +
> > +                     return IIO_VAL_INT;
> > +             default:
> > +                     return -EINVAL;
> > +             }
> > +     case IIO_PHASE:
> > +             ret =3D isl29501_register_read(isl29501, REG_PHASE, raw);
> > +             if (ret < 0)
> > +                     return ret;
> > +
> > +             return IIO_VAL_INT;
> > +     case IIO_CURRENT:
> > +             ret =3D isl29501_register_read(isl29501, REG_EMITTER_DAC,
> raw);
> > +             if (ret < 0)
> > +                     return ret;
> > +
> > +             return IIO_VAL_INT;
> > +     case IIO_TEMP:
> > +             ret =3D isl29501_register_read(isl29501, REG_TEMPERATURE,
> raw);
> > +             if (ret < 0)
> > +                     return ret;
> > +
> > +             return IIO_VAL_INT;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static int isl29501_get_scale(struct isl29501_private *isl29501,
> > +                           const struct iio_chan_spec *chan,
> > +                           int *val, int *val2)
> > +{
> > +     int ret;
> > +     u32 current_scale;
> > +
> > +     switch (chan->type) {
> > +     case IIO_PROXIMITY:
> > +             /* distance =3D raw_distance * 33.31 / 65536 (m) */
> > +             *val =3D 3331;
> > +             *val2 =3D 6553600;
> > +
> > +             return IIO_VAL_FRACTIONAL;
> > +     case IIO_PHASE:
> > +             /* phase =3D raw_phase * 2pi / 65536 (rad) */
> > +             *val =3D 0;
> > +             *val2 =3D 95874;
> > +
> > +             return IIO_VAL_INT_PLUS_NANO;
> > +     case IIO_INTENSITY:
> > +             if (chan->channel2 !=3D IIO_MOD_LIGHT_CLEAR)
> > +                     return -EINVAL;
> > +             /* light =3D raw_light * 35 / 10000 (mA) */
> > +             *val =3D 35;
> > +             *val2 =3D 10000;
> > +
> > +             return IIO_VAL_FRACTIONAL;
> > +     case IIO_CURRENT:
> > +             ret =3D isl29501_register_read(isl29501,
> > +                                          REG_DRIVER_RANGE,
> > +                                          &current_scale);
> > +             if (ret < 0)
> > +                     return ret;
> > +
> > +             if (current_scale > ARRAY_SIZE(isl29501_current_
> scale_table))
> > +                     return -EINVAL;
> > +
> > +             if (!current_scale) {
> > +                     *val =3D 0;
> > +                     *val2 =3D 0;
> > +                     return IIO_VAL_INT;
> > +             }
> > +
> > +             *val =3D isl29501_current_scale_table[current_scale - 1][=
0];
> > +             *val2 =3D isl29501_current_scale_table[current_scale -
> 1][1];
> > +
> > +             return IIO_VAL_INT_PLUS_MICRO;
> > +     case IIO_TEMP:
> > +             /* temperature =3D raw_temperature * 125 / 100000 (milli =
=C2=B0C)
> */
> > +             *val =3D 125;
> > +             *val2 =3D 100000;
> > +
> > +             return IIO_VAL_FRACTIONAL;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static int isl29501_get_calibbias(struct isl29501_private *isl29501,
> > +                               const struct iio_chan_spec *chan,
> > +                               int *bias)
> > +{
> > +     switch (chan->type) {
> > +     case IIO_PROXIMITY:
> > +             return isl29501_register_read(isl29501,
> > +                                           REG_DISTANCE_BIAS,
> > +                                           bias);
> > +     case IIO_INTENSITY:
> > +             switch (chan->channel2) {
> > +             case IIO_NO_MOD:
> > +             case IIO_MOD_I:
> > +             case IIO_MOD_Q:
> > +                     /* TODO: Implement float read */
> > +                     return -EINVAL;
> > +             default:
> > +                     return -EINVAL;
>
> As below, this needs to go for now.
>
> > +             }
> > +     case IIO_TEMP:
> > +             return isl29501_register_read(isl29501,
> > +                                           REG_TEMPERATURE_BIAS,
> > +                                           bias);
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static int isl29501_get_inttime(struct isl29501_private *isl29501,
> > +                             int *val, int *val2)
> > +{
> > +     int ret;
> > +     u32 inttime;
> > +
> > +     ret =3D isl29501_register_read(isl29501, REG_INT_TIME, &inttime);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     if (inttime >=3D ARRAY_SIZE(isl29501_int_time))
> > +             return -EINVAL;
> > +
> > +     *val =3D isl29501_int_time[inttime][0];
> > +     *val2 =3D isl29501_int_time[inttime][1];
> > +
> > +     return IIO_VAL_INT_PLUS_MICRO;
> > +}
> > +
> > +static int isl29501_get_freq(struct isl29501_private *isl29501,
> > +                          int *val, int *val2)
> > +{
> > +     int ret;
> > +     int sample_time;
> > +     unsigned long long freq;
> > +
> > +     ret =3D isl29501_register_read(isl29501, REG_SAMPLE_TIME,
> &sample_time);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     /* freq =3D 1 / (0.000450 * (sample_time + 1) * 10^-6) */
> > +     freq =3D 1000000ULL * 1000000ULL / (450ULL * (sample_time + 1ULL)=
);
> > +
> > +     *val =3D freq / 1000000;
> > +     *val2 =3D freq % 1000000;
> > +
> > +     return IIO_VAL_INT_PLUS_MICRO;
> > +}
> > +
> > +static int isl29501_read_raw(struct iio_dev *indio_dev,
> > +                          struct iio_chan_spec const *chan, int *val,
> > +                          int *val2, long mask)
> > +{
> > +     struct isl29501_private *isl29501 =3D iio_priv(indio_dev);
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_RAW:
> > +             return isl29501_get_raw(isl29501, chan, val);
> > +     case IIO_CHAN_INFO_SCALE:
> > +             return isl29501_get_scale(isl29501, chan, val, val2);
> > +     case IIO_CHAN_INFO_INT_TIME:
> > +             return isl29501_get_inttime(isl29501, val, val2);
> > +     case IIO_CHAN_INFO_SAMP_FREQ:
> > +             return isl29501_get_freq(isl29501, val, val2);
> > +     case IIO_CHAN_INFO_CALIBBIAS:
> > +             return isl29501_get_calibbias(isl29501, chan, val);
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static int isl29501_set_raw(struct isl29501_private *isl29501,
> > +                         const struct iio_chan_spec *chan,
> > +                         int raw)
> > +{
> > +     switch (chan->type) {
> > +     case IIO_CURRENT:
> > +             return isl29501_register_write(isl29501, REG_EMITTER_DAC,
> raw);
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static int isl29501_set_inttime(struct isl29501_private *isl29501,
> > +                             int val, int val2)
> > +{
> > +     int i;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(isl29501_int_time); i++) {
> > +             if (isl29501_int_time[i][0] =3D=3D val &&
> > +                 isl29501_int_time[i][1] =3D=3D val2) {
> > +                     return isl29501_register_write(isl29501,
> > +                                                    REG_INT_TIME,
> > +                                                    i);
> > +             }
> > +     }
> > +
> > +     return -EINVAL;
> > +}
> > +
> > +static int isl29501_set_scale(struct isl29501_private *isl29501,
> > +                           const struct iio_chan_spec *chan,
> > +                           int val, int val2)
> > +{
> > +     int i;
> > +
> > +     if (chan->type !=3D IIO_CURRENT)
> > +             return -EINVAL;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(isl29501_current_scale_table); i++) =
{
> > +             if (isl29501_current_scale_table[i][0] =3D=3D val &&
> > +                 isl29501_current_scale_table[i][1] =3D=3D val2) {
> > +                     return isl29501_register_write(isl29501,
> > +                                                    REG_DRIVER_RANGE,
> > +                                                    i + 1);
> > +             }
> > +     }
> > +
> > +     return -EINVAL;
> > +}
> > +
> > +static int isl29501_set_calibbias(struct isl29501_private *isl29501,
> > +                               const struct iio_chan_spec *chan,
> > +                               int bias)
> > +{
> > +     switch (chan->type) {
> > +     case IIO_PROXIMITY:
> > +             return isl29501_register_write(isl29501,
> > +                                           REG_DISTANCE_BIAS,
> > +                                           bias);
> > +     case IIO_INTENSITY:
>
> Hmm. I appreciate why you have left this here (so we don't
> forget about it) but it's going to result in us presenting
> some really odd ABI. I'd rather take it out for now and bring
> it back in when we have the floating point stuff agreed and in
> place.
>
> > +             switch (chan->channel2) {
> > +             case IIO_NO_MOD:
> > +             case IIO_MOD_I:
> > +             case IIO_MOD_Q:
> > +                     /* TODO: Implement float read */
> > +                     return -EINVAL;
> > +             default:
> > +                     return -EINVAL;
> > +             }
> > +     case IIO_TEMP:
> > +             return isl29501_register_write(isl29501,
> > +                                            REG_TEMPERATURE_BIAS,
> > +                                            bias);
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static int isl29501_set_freq(struct isl29501_private *isl29501,
> > +                          int val, int val2)
> > +{
> > +     int freq;
> > +     unsigned long long sample_time;
> > +
> > +     /* sample_freq =3D 1 / (0.000450 * (sample_time + 1) * 10^-6) */
> > +     freq =3D val * 1000000 + val2 % 1000000;
> > +     sample_time =3D (2222ULL * 1000000ULL / freq) - 1ULL;
> > +
> > +     if (sample_time > 255)
> > +             return -ERANGE;
> > +
> > +     return isl29501_register_write(isl29501, REG_SAMPLE_TIME,
> sample_time);
> > +}
> > +
> > +static int isl29501_write_raw(struct iio_dev *indio_dev,
> > +                           struct iio_chan_spec const *chan,
> > +                           int val, int val2, long mask)
> > +{
> > +     struct isl29501_private *isl29501 =3D iio_priv(indio_dev);
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_RAW:
> > +             return isl29501_set_raw(isl29501, chan, val);
> > +     case IIO_CHAN_INFO_INT_TIME:
> > +             return isl29501_set_inttime(isl29501, val, val2);
> > +     case IIO_CHAN_INFO_SAMP_FREQ:
> > +             return isl29501_set_freq(isl29501, val, val2);
> > +     case IIO_CHAN_INFO_SCALE:
> > +             return isl29501_set_scale(isl29501, chan, val, val2);
> > +     case IIO_CHAN_INFO_CALIBBIAS:
> > +             return isl29501_set_calibbias(isl29501, chan, val);
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static const struct iio_info isl29501_info =3D {
> > +     .read_raw =3D &isl29501_read_raw,
> > +     .write_raw =3D &isl29501_write_raw,
> > +     .attrs =3D &isl29501_attribute_group,
> > +};
> > +
> > +static int isl29501_init_chip(struct isl29501_private *isl29501)
> > +{
> > +     int ret;
> > +
> > +     ret =3D i2c_smbus_read_byte_data(isl29501->client,
> ISL29501_DEVICE_ID);
> > +     if (ret < 0) {
> > +             dev_err(&isl29501->client->dev, "Error reading device
> id\n");
> > +             return ret;
> > +     }
> > +
> > +     if (ret !=3D ISL29501_ID) {
> > +             dev_err(&isl29501->client->dev,
> > +                     "Wrong chip id, got %x expected %x\n",
> > +                     ret, ISL29501_DEVICE_ID);
> > +             return -ENODEV;
> > +     }
> > +
> > +     ret =3D isl29501_reset_registers(isl29501);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return isl29501_begin_acquisition(isl29501);
> > +}
> > +
> > +static irqreturn_t isl29501_trigger_handler(int irq, void *p)
> > +{
> > +     struct iio_poll_func *pf =3D p;
> > +     struct iio_dev *indio_dev =3D pf->indio_dev;
> > +     struct isl29501_private *isl29501 =3D iio_priv(indio_dev);
> > +     const unsigned long *active_mask =3D indio_dev->active_scan_mask;
> > +     u32 buffer[4] =3D {}; /* 1x16-bit + ts */
> > +
> > +     if (test_bit(ISL29501_DISTANCE_SCAN_INDEX, active_mask))
> > +             isl29501_register_read(isl29501, REG_DISTANCE, buffer);
> > +
> > +     iio_push_to_buffers_with_timestamp(indio_dev, buffer,
> pf->timestamp);
> > +     iio_trigger_notify_done(indio_dev->trig);
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static int isl29501_probe(struct i2c_client *client,
> > +                       const struct i2c_device_id *id)
> > +{
> > +     struct iio_dev *indio_dev;
> > +     struct isl29501_private *isl29501;
> > +     int ret;
> > +
> > +     indio_dev =3D devm_iio_device_alloc(&client->dev,
> sizeof(*isl29501));
> > +     if (!indio_dev)
> > +             return -ENOMEM;
> > +
> > +     isl29501 =3D iio_priv(indio_dev);
> > +
> > +     i2c_set_clientdata(client, indio_dev);
> > +     isl29501->client =3D client;
> > +
> > +     mutex_init(&isl29501->lock);
> > +
> > +     ret =3D isl29501_init_chip(isl29501);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +     indio_dev->dev.parent =3D &client->dev;
> > +     indio_dev->channels =3D isl29501_channels;
> > +     indio_dev->num_channels =3D ARRAY_SIZE(isl29501_channels);
> > +     indio_dev->name =3D client->name;
> > +     indio_dev->info =3D &isl29501_info;
> > +
> > +     ret =3D devm_iio_triggered_buffer_setup(&client->dev, indio_dev,
> > +                                           iio_pollfunc_store_time,
> > +                                           isl29501_trigger_handler,
> > +                                           NULL);
> > +     if (ret < 0) {
> > +             dev_err(&client->dev, "unable to setup iio triggered
> buffer\n");
> > +             return ret;
> > +     }
>
> Nitpick, a blank line here would be a 'tiny' bit nicer.
>
> > +     return devm_iio_device_register(&client->dev, indio_dev);
> > +}
> > +
> > +static const struct i2c_device_id isl29501_id[] =3D {
> > +     {"isl29501", 0},
> > +     {}
> > +};
> > +
> > +MODULE_DEVICE_TABLE(i2c, isl29501_id);
> > +
> > +#if defined(CONFIG_OF)
> > +static const struct of_device_id isl29501_i2c_matches[] =3D {
> > +     { .compatible =3D "renesas,isl29501" },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(of, isl29501_i2c_matches);
> > +#endif
> > +
> > +static struct i2c_driver isl29501_driver =3D {
> > +     .driver =3D {
> > +             .name   =3D "isl29501",
> > +     },
> > +     .id_table       =3D isl29501_id,
> > +     .probe          =3D isl29501_probe,
> > +};
> > +module_i2c_driver(isl29501_driver);
> > +
> > +MODULE_AUTHOR("Mathieu Othacehe <m.othacehe@gmail.com>");
> > +MODULE_DESCRIPTION("ISL29501 Time of Flight sensor driver");
> > +MODULE_LICENSE("GPL v2");
>
>

--00000000000026736b057171ac51
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBKb25hdGhhbiw8YnI+PGJyPjwvZGl2PlNvcnJ5IGZvciB0
aGUgbGF0ZSByZXBseS4gSSYjMzk7bGwgc2VuZCBhIHY2IA0Kd2l0aCB5b3VyIHN1Z2dlc3Rpb25z
IGFuZCBhbGwgdGhlIHN0dWZmIHJlbGF0ZWQgdG8gZmxvYXRpbmcgcmVnaXN0ZXJzIGFzDQogYSBz
ZXBhcmF0ZSwgd2lwIHBhdGNoICgzLzMpLCB0aGF0IHdpbGwgYmUgdXNlZCBhcyBhIGJhc2lzIHdo
ZW4gdGhlIElJTyANCmZsb2F0aW5nIEFCSSB3ZSBkaXNjdXNzZWQgd2UmIzM5O2xsIGJlIHJlYWR5
Ljxicj48ZGl2Pjxicj48L2Rpdj48ZGl2PlRoYW5rcyw8YnI+PGJyPjwvZGl2PjxkaXY+TWF0aGll
dTwvZGl2Pjxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+PGJyPjxkaXYgY2xhc3M9
ImdtYWlsX3F1b3RlIj4yMDE4LTA3LTA3IDE5OjAwIEdNVCswMjowMCBKb25hdGhhbiBDYW1lcm9u
IDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOmppYzIzQGppYzIzLnJldHJvc251
Yi5jby51ayIgdGFyZ2V0PSJfYmxhbmsiPmppYzIzQGppYzIzLnJldHJvc251Yi5jby51azwvYT4m
Z3Q7PC9zcGFuPjo8YnI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFy
Z2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFl
eCI+PHNwYW4gY2xhc3M9IiI+T24gTW9uLMKgIDIgSnVsIDIwMTggMTA6NTk6MjcgKzAyMDA8YnI+
DQpNYXRoaWV1IE90aGFjZWhlICZsdDs8YSBocmVmPSJtYWlsdG86bS5vdGhhY2VoZUBnbWFpbC5j
b20iPm0ub3RoYWNlaGVAZ21haWwuY29tPC9hPiZndDsgd3JvdGU6PGJyPg0KPGJyPg0KJmd0OyBU
aGlzIHBhdGNoIGFkZHMgc3VwcG9ydCBmb3IgdGhlIElTTDI5NTAxIFRpbWUgb2YgRmxpZ2h0IHNl
bnNvci48YnI+DQomZ3Q7IDxicj4NCiZndDsgU2lnbmVkLW9mZi1ieTogTWF0aGlldSBPdGhhY2Vo
ZSAmbHQ7PGEgaHJlZj0ibWFpbHRvOm0ub3RoYWNlaGVAZ21haWwuY29tIj5tLm90aGFjZWhlQGdt
YWlsLmNvbTwvYT4mZ3Q7PGJyPg0KPGJyPg0KPC9zcGFuPkhpIE1hdGhpZXUsPGJyPg0KPGJyPg0K
SSYjMzk7ZCBsaWtlIHRvIG5vdCBzdGFsbCB0aGUgZHJpdmVyIG9uIHVzIGdldHRpbmcgYSBzb2x1
dGlvbiBpbiBwbGFjZTxicj4NCmZvciB0aGUgdmFsdWVzIHRoYXQgd2UgdGhpbmsgbmVlZCB0byBi
ZSBwcmVzZW50ZWQgYXMgZmxvYXRpbmcgcG9pbnQuPGJyPg0KPGJyPg0KSG93ZXZlciwgSSBhbHNv
IGRvbiYjMzk7dCB3YW50IHRvIHByZXNlbnQgdXNlcnNwYWNlIEFCSSB0aGF0IGRvZXNuJiMzOTt0
IHdvcms8YnI+DQppbiB0aGUgbWVhbnRpbWUuwqAgSSBmdWxseSB1bmRlcnN0YW5kIHdoeSB5b3Ug
aGF2ZSBsZWZ0IHRob3NlIGJsb2NrcyBpbjxicj4NCnRoZXJlICh0byBlbnN1cmUgd2Uga2VlcCB0
aGVtIGluIG1pbmQpIGJ1dCBwbGVhc2UgY291bGQgSSBoYXZlIGEgdmVyc2lvbjxicj4NCndpdGgg
dGhhdCBjb2RlIHNlcGFyYXRlZCBvdXQgKGVpdGhlciBub3QgdGhlcmUgb3IgYXMgYSBmb2xsb3cg
dXAgcGF0Y2g8YnI+DQp0aGF0IEkgd29uJiMzOTt0IGFwcGx5IC0gZm9yIG5vdykuPGJyPg0KPGJy
Pg0KSSBuZWFybHkganVzdCBkaWQgaXQgbXlzZWxmLCBidXQgdGhlcmUgYXJlIGVub3VnaCBjb3Ju
ZXJzIEkgbWlnaHQgbWVzczxicj4NCml0IHVwLCBzbyB3b3VsZCBwcmVmZXIgaWYgeW91IGRpZCB0
aGlzIHNlcGFyYXRpb24gZm9yIG1lITxicj4NCjxicj4NClRoYW5rcyBhbmQgbG9va2luZyBmb3J3
YXJkIHRvIGFwcGx5aW5nIGEgJiMzOTtwYXJ0aWFsJiMzOTsgdmVyc2lvbiBpbiBWNi48YnI+DQo8
YnI+DQpJZiB5b3UgaGF2ZSB0aW1lLCBJJiMzOTtkIGxpa2UgdG8gc2VlIHdoYXQgdGhvc2UgZmxv
YXRpbmcgcG9pbnQgcGF0Y2hlczxicj4NCmFyZSBnb2luZyB0byBsb29rIGxpa2UuwqAgSXRzIG11
Y2ggZWFzaWVyIHRvIGdldCBjb21tZW50cyB3aXRoIGF0IGxlYXN0PGJyPg0KYSBwcm9vZiBvZiBj
b25jZXB0IGluIHBsYWNlITxicj4NCjxicj4NClRoYW5rczxicj4NCjxicj4NCkpvbmF0aGFuPGJy
Pg0KPGRpdj48ZGl2IGNsYXNzPSJoNSI+PGJyPg0KJmd0OyAtLS08YnI+DQomZ3Q7wqAgRG9jdW1l
bnRhdGlvbi9BQkkvdGVzdGluZy88d2JyPnN5c2ZzLWJ1cy1paW8taXNsMjk1MDHCoCDCoHzCoCDC
oDQ3ICs8YnI+DQomZ3Q7wqAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvLzx3YnI+bGlnaHQv
aXNsMjk1MDEudHh0wqAgwqAgwqB8wqAgwqAxMyArPGJyPg0KJmd0O8KgIGRyaXZlcnMvaWlvL2xp
Z2h0L0tjb25maWfCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgwqAx
MyArPGJyPg0KJmd0O8KgIGRyaXZlcnMvaWlvL2xpZ2h0L01ha2VmaWxlwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgwqAgMSArPGJyPg0KJmd0O8KgIGRyaXZlcnMvaWlv
L2xpZ2h0L2lzbDI5NTAxLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHwgMTEy
NSArKysrKysrKysrKysrKysrKysrKzxicj4NCiZndDvCoCA1IGZpbGVzIGNoYW5nZWQsIDExOTkg
aW5zZXJ0aW9ucygrKTxicj4NCiZndDvCoCBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlv
bi9BQkkvdGVzdGluZy88d2JyPnN5c2ZzLWJ1cy1paW8taXNsMjk1MDE8YnI+DQomZ3Q7wqAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS88d2JyPmJpbmRpbmdzL2lp
by9saWdodC9pc2wyOTUwMS48d2JyPnR4dDxicj4NCiZndDvCoCBjcmVhdGUgbW9kZSAxMDA2NDQg
ZHJpdmVycy9paW8vbGlnaHQvaXNsMjk1MDEuYzxicj4NCiZndDsgPGJyPg0KJmd0OyBkaWZmIC0t
Z2l0IGEvRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy88d2JyPnN5c2ZzLWJ1cy1paW8taXNsMjk1
MDEgYi9Eb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nLzx3YnI+c3lzZnMtYnVzLWlpby1pc2wyOTUw
MTxicj4NCiZndDsgbmV3IGZpbGUgbW9kZSAxMDA2NDQ8YnI+DQomZ3Q7IGluZGV4IDAwMDAwMDAu
LmQwMDljZmI8YnI+DQomZ3Q7IC0tLSAvZGV2L251bGw8YnI+DQomZ3Q7ICsrKyBiL0RvY3VtZW50
YXRpb24vQUJJL3Rlc3RpbmcvPHdicj5zeXNmcy1idXMtaWlvLWlzbDI5NTAxPGJyPg0KJmd0OyBA
QCAtMCwwICsxLDQ3IEBAPGJyPg0KJmd0OyArV2hhdDrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAv
c3lzL2J1cy9paW8vZGV2aWNlcy9paW86PHdicj5kZXZpY2VYL2luX3Byb3hpbWl0eTBfYWdjX2dh
aW48YnI+DQomZ3Q7ICtXaGF0OsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC9zeXMvYnVzL2lpby9k
ZXZpY2VzL2lpbzo8d2JyPmRldmljZVgvaW5fcHJveGltaXR5MF9hZ2NfPHdicj5nYWluX2JpYXM8
YnI+DQomZ3Q7ICtLZXJuZWxWZXJzaW9uOsKgIMKgIMKgIMKgNC4xODxicj4NCiZndDsgK0NvbnRh
Y3Q6wqAgwqAgwqA8YSBocmVmPSJtYWlsdG86bGludXgtaWlvQHZnZXIua2VybmVsLm9yZyI+bGlu
dXgtaWlvQHZnZXIua2VybmVsLm9yZzwvYT48YnI+DQomZ3Q7ICtEZXNjcmlwdGlvbjo8YnI+DQom
Z3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoFRoaXMgc2Vuc29yIGhhcyBhbiBhdXRvbWF0aWMgZ2Fp
biBjb250cm9sIChhZ2MpIGxvb3A8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoHdoaWNo
IHNldHMgdGhlIGFuYWxvZyBzaWduYWwgbGV2ZWxzIGF0IGFuIG9wdGltdW08YnI+DQomZ3Q7ICvC
oCDCoCDCoCDCoCDCoCDCoCDCoGxldmVsIGJ5IGNvbnRyb2xsaW5nIHByb2dyYW1tYWJsZSBnYWlu
IGFtcGxpZmllcnMuIFRoZTxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgY3JpdGVyaWEg
Zm9yIG9wdGltYWwgZ2FpbiBpcyBkZXRlcm1pbmVkIGJ5IHRoZSBzZW5zb3IuPGJyPg0KJmd0OyAr
PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBSZXR1cm4gdGhlIGFjdHVhbCBnYWluIHZh
bHVlIGFzIGFuIGludGVnZXIgaW4gWzA7IDY1NTM2XTxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKg
IMKgIMKgcmFuZ2Ugd2hlbiByZWFkIGZyb20uPGJyPg0KJmd0OyArPGJyPg0KJmd0OyArwqAgwqAg
wqAgwqAgwqAgwqAgwqBUaGUgYWdjIGdhaW4gcmVhZCB3aGVuIG1lYXN1cmluZyBjcm9zc3RhbGsg
c2hhbGwgYmU8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoHdyaXR0ZW4gaW50byBpbl9w
cm94aW1pdHkwX2FnY19nYWluX2JpYXMuPGJyPg0KJmd0OyArPGJyPg0KJmd0OyArV2hhdDrCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCAvc3lzL2J1cy9paW8vZGV2aWNlcy9paW86PHdicj5kZXZpY2VY
L2luX3Byb3hpbWl0eTBfY2FsaWJfPHdicj5waGFzZV90ZW1wX2E8YnI+DQomZ3Q7ICtXaGF0OsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIC9zeXMvYnVzL2lpby9kZXZpY2VzL2lpbzo8d2JyPmRldmlj
ZVgvaW5fcHJveGltaXR5MF9jYWxpYl88d2JyPnBoYXNlX3RlbXBfYjxicj4NCiZndDsgK1doYXQ6
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgL3N5cy9idXMvaWlvL2RldmljZXMvaWlvOjx3YnI+ZGV2
aWNlWC9pbl9wcm94aW1pdHkwX2NhbGliXzx3YnI+cGhhc2VfbGlnaHRfYTxicj4NCiZndDsgK1do
YXQ6wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgL3N5cy9idXMvaWlvL2RldmljZXMvaWlvOjx3YnI+
ZGV2aWNlWC9pbl9wcm94aW1pdHkwX2NhbGliXzx3YnI+cGhhc2VfbGlnaHRfYjxicj4NCiZndDsg
K0tlcm5lbFZlcnNpb246wqAgwqAgwqAgwqA0LjE4PGJyPg0KJmd0OyArQ29udGFjdDrCoCDCoCDC
oDxhIGhyZWY9Im1haWx0bzpsaW51eC1paW9Admdlci5rZXJuZWwub3JnIj5saW51eC1paW9Admdl
ci5rZXJuZWwub3JnPC9hPjxicj4NCiZndDsgK0Rlc2NyaXB0aW9uOjxicj4NCiZndDsgK8KgIMKg
IMKgIMKgIMKgIMKgIMKgVGhlIHNlbnNvciBpcyBhYmxlIHRvIHBlcmZvcm0gY29ycmVjdGlvbiBv
ZiBkaXN0YW5jZTxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgbWVhc3VyZW1lbnRzIGR1
ZSB0byBjaGFuZ2luZyB0ZW1wZXJhdHVyZSBhbmQgYW1iaWVudDxicj4NCiZndDsgK8KgIMKgIMKg
IMKgIMKgIMKgIMKgbGlnaHQgY29uZGl0aW9ucy4gSXQgY2FuIGJlIHByb2dyYW1tZWQgdG8gY29y
cmVjdCBmb3I8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoGEgc2Vjb25kIG9yZGVyIGVy
cm9yIHBvbHlub21pYWwuPGJyPg0KJmd0OyArPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAg
wqBQaGFzZSBkYXRhIGhhcyB0byBiZSBjb2xsZWN0ZWQgd2hlbiB0ZW1wZXJhdHVyZSBhbmQ8YnI+
DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoGFtYmllbnQgbGlnaHQgYXJlIG1vZHVsYXRlZCBp
bmRlcGVuZGVudGx5Ljxicj4NCiZndDsgKzxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKg
VGhlbiBhIGxlYXN0IHNxdWFyZXMgY3VydmUgZml0IHRvIGEgc2Vjb25kIG9yZGVyPGJyPg0KJmd0
OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBwb2x5bm9taWFsIGhhcyB0byBiZSBnZW5lcmF0ZWQgZnJv
bSB0aGUgZGF0YS4gVGhlPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqByZXN1bHRhbnQg
Y3VydmVzIGhhdmUgdGhlIGZvcm0gYXheMiArIGJ4ICsgYy48YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7
ICvCoCDCoCDCoCDCoCDCoCDCoCDCoEZyb20gdGhvc2UgdHdvIGN1cnZlcywgYSBhbmQgYiBjb2Vm
ZmljaWVudHMgc2hhbGwgYmU8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoHN0b3JlZCBp
biBpbl9wcm94aW1pdHkwX2NhbGliX3BoYXNlXzx3YnI+dGVtcF9hIGFuZDxicj4NCiZndDsgK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgaW5fcHJveGltaXR5MF9jYWxpYl9waGFzZV88d2JyPnRlbXBfYiBm
b3IgdGVtcGVyYXR1cmUgYW5kPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBpbiBpbl9w
cm94aW1pdHkwX2NhbGliX3BoYXNlXzx3YnI+bGlnaHRfYSBhbmQ8YnI+DQomZ3Q7ICvCoCDCoCDC
oCDCoCDCoCDCoCDCoGluX3Byb3hpbWl0eTBfY2FsaWJfcGhhc2VfPHdicj5saWdodF9iIGZvciBh
bWJpZW50IGxpZ2h0Ljxicj4NCiZndDsgKzxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKg
VGhvc2UgdmFsdWVzIG11c3QgYmUgaW50ZWdlciBpbiBbMDsgODM1NTg0MF0gcmFuZ2UuPGJyPg0K
Jmd0OyArPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBGaW5hbGx5LCB0aGUgYyBjb25z
dGFudCBpcyBzZXQgYnkgdGhlIHNlbnNvcjxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKg
aW50ZXJuYWxseS48YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoFRo
ZSB2YWx1ZSBzdG9yZWQgaW4gc2Vuc29yIGlzIGRpc3BsYXllZCB3aGVuIHJlYWQgZnJvbS48YnI+
DQomZ3Q7IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvPHdicj5iaW5kaW5n
cy9paW8vbGlnaHQvaXNsMjk1MDEuPHdicj50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
PHdicj5iaW5kaW5ncy9paW8vbGlnaHQvaXNsMjk1MDEuPHdicj50eHQ8YnI+DQomZ3Q7IG5ldyBm
aWxlIG1vZGUgMTAwNjQ0PGJyPg0KJmd0OyBpbmRleCAwMDAwMDAwLi40Njk1Nzk5PGJyPg0KJmd0
OyAtLS0gL2Rldi9udWxsPGJyPg0KJmd0OyArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
PHdicj5iaW5kaW5ncy9paW8vbGlnaHQvaXNsMjk1MDEuPHdicj50eHQ8YnI+DQomZ3Q7IEBAIC0w
LDAgKzEsMTMgQEA8YnI+DQomZ3Q7ICsqIElTTDI5NTAxIFRpbWUtb2YtZmxpZ2h0IHNlbnNvci48
YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICtSZXF1aXJlZCBwcm9wZXJ0aWVzOjxicj4NCiZndDsgKzxi
cj4NCiZndDsgK8KgIC0gY29tcGF0aWJsZSA6IHNob3VsZCBiZSAmcXVvdDtyZW5lc2FzLGlzbDI5
NTAxJnF1b3Q7PGJyPg0KJmd0OyArwqAgLSByZWcgOiB0aGUgSTJDIGFkZHJlc3Mgb2YgdGhlIHNl
bnNvcjxicj4NCiZndDsgKzxicj4NCiZndDsgK0V4YW1wbGU6PGJyPg0KJmd0OyArPGJyPg0KJmd0
OyAraXNsMjk1MDFANTcgezxicj4NCiZndDsgK8KgIMKgIMKgY29tcGF0aWJsZSA9ICZxdW90O3Jl
bmVzYXMsaXNsMjk1MDEmcXVvdDs7PGJyPg0KJmd0OyArwqAgwqAgwqByZWcgPSAmbHQ7MHg1NyZn
dDs7PGJyPg0KJmd0OyArfTs8YnI+DQomZ3Q7IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9saWdo
dC9LY29uZmlnIGIvZHJpdmVycy9paW8vbGlnaHQvS2NvbmZpZzxicj4NCiZndDsgaW5kZXggYzdl
ZjhkMS4uMzg4MmJkYyAxMDA2NDQ8YnI+DQomZ3Q7IC0tLSBhL2RyaXZlcnMvaWlvL2xpZ2h0L0tj
b25maWc8YnI+DQomZ3Q7ICsrKyBiL2RyaXZlcnMvaWlvL2xpZ2h0L0tjb25maWc8YnI+DQomZ3Q7
IEBAIC0xOTQsNiArMTk0LDE5IEBAIGNvbmZpZyBJU0wyOTEyNTxicj4NCiZndDvCoCDCoCDCoCDC
oCDCoFRvIGNvbXBpbGUgdGhpcyBkcml2ZXIgYXMgYSBtb2R1bGUsIGNob29zZSBNIGhlcmU6IHRo
ZSBtb2R1bGUgd2lsbCBiZTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoGNhbGxlZCBpc2wyOTEyNS48
YnI+DQomZ3Q7wqAgPGJyPg0KJmd0OyArY29uZmlnIElTTDI5NTAxPGJyPg0KJmd0OyArwqAgwqAg
wqB0cmlzdGF0ZSAmcXVvdDtJbnRlcnNpbCBJU0wyOTUwMSBUaW1lIE9mIEZsaWdodCBzZW5zb3Im
cXVvdDs8YnI+DQomZ3Q7ICvCoCDCoCDCoGRlcGVuZHMgb24gSTJDPGJyPg0KJmd0OyArwqAgwqAg
wqBzZWxlY3QgSUlPX0JVRkZFUjxicj4NCiZndDsgK8KgIMKgIMKgc2VsZWN0IElJT19UUklHR0VS
RURfQlVGRkVSPGJyPg0KJmd0OyArwqAgwqAgwqBzZWxlY3QgSUlPX0tGSUZPX0JVRjxicj4NCiZn
dDsgK8KgIMKgIMKgaGVscDxicj4NCiZndDsgK8KgIMKgIMKgIMKgU2F5IFkgaGVyZSBpZiB5b3Ug
d2FudCB0byBidWlsZCBhIGRyaXZlciBmb3IgdGhlIEludGVyc2lsIElTTDI5NTAxPGJyPg0KJmd0
OyArwqAgwqAgwqAgwqBUaW1lIG9mIEZsaWdodCBzZW5zb3IuPGJyPg0KJmd0OyArPGJyPg0KJmd0
OyArwqAgwqAgwqAgwqBUbyBjb21waWxlIHRoaXMgZHJpdmVyIGFzIGEgbW9kdWxlLCBjaG9vc2Ug
TSBoZXJlOiB0aGUgbW9kdWxlIHdpbGwgYmU8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoGNhbGxlZCBp
c2wyOTUwMS48YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7wqAgY29uZmlnIEhJRF9TRU5TT1JfQUxTPGJy
Pg0KJmd0O8KgIMKgIMKgIMKgZGVwZW5kcyBvbiBISURfU0VOU09SX0hVQjxicj4NCiZndDvCoCDC
oCDCoCDCoHNlbGVjdCBJSU9fQlVGRkVSPGJyPg0KJmd0OyBkaWZmIC0tZ2l0IGEvZHJpdmVycy9p
aW8vbGlnaHQvTWFrZWZpbGUgYi9kcml2ZXJzL2lpby9saWdodC9NYWtlZmlsZTxicj4NCiZndDsg
aW5kZXggODA5NDNhZi4uODFjMDYzMSAxMDA2NDQ8YnI+DQomZ3Q7IC0tLSBhL2RyaXZlcnMvaWlv
L2xpZ2h0L01ha2VmaWxlPGJyPg0KJmd0OyArKysgYi9kcml2ZXJzL2lpby9saWdodC9NYWtlZmls
ZTxicj4NCiZndDsgQEAgLTIzLDYgKzIzLDcgQEAgb2JqLSQoQ09ORklHX0hJRF9TRU5TT1JfUFJP
WCnCoCDCoCDCoCDCoCs9IGhpZC1zZW5zb3ItcHJveC5vPGJyPg0KJmd0O8KgIG9iai0kKENPTkZJ
R19TRU5TT1JTX0lTTDI5MDE4KcKgIMKgIMKgIMKgKz0gaXNsMjkwMTgubzxicj4NCiZndDvCoCBv
YmotJChDT05GSUdfU0VOU09SU19JU0wyOTAyOCnCoCDCoCDCoCDCoCs9IGlzbDI5MDI4Lm88YnI+
DQomZ3Q7wqAgb2JqLSQoQ09ORklHX0lTTDI5MTI1KcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKz0g
aXNsMjkxMjUubzxicj4NCiZndDsgK29iai0kKENPTkZJR19JU0wyOTUwMSnCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCs9IGlzbDI5NTAxLm88YnI+DQomZ3Q7wqAgb2JqLSQoQ09ORklHX0pTQTEyMTIp
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKz0ganNhMTIxMi5vPGJyPg0KJmd0O8KgIG9iai0kKENP
TkZJR19TRU5TT1JTX0xNMzUzMykgKz0gbG0zNTMzLWFscy5vPGJyPg0KJmd0O8KgIG9iai0kKENP
TkZJR19MVFI1MDEpwqAgwqAgwqAgwqAgwqArPSBsdHI1MDEubzxicj4NCiZndDsgZGlmZiAtLWdp
dCBhL2RyaXZlcnMvaWlvL2xpZ2h0L2lzbDI5NTAxLmMgYi9kcml2ZXJzL2lpby9saWdodC9pc2wy
OTUwMS5jPGJyPg0KJmd0OyBuZXcgZmlsZSBtb2RlIDEwMDY0NDxicj4NCiZndDsgaW5kZXggMDAw
MDAwMC4uZTkxNDVkMzxicj4NCiZndDsgLS0tIC9kZXYvbnVsbDxicj4NCiZndDsgKysrIGIvZHJp
dmVycy9paW8vbGlnaHQvaXNsMjk1MDEuYzxicj4NCiZndDsgQEAgLTAsMCArMSwxMTI1IEBAPGJy
Pg0KJmd0OyArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjA8YnI+DQomZ3Q7ICsv
Kjxicj4NCiZndDsgKyAqIGlzbDI5NTAxLmM6IElTTDI5NTAxIFRpbWUgb2YgRmxpZ2h0IHNlbnNv
ciBkcml2ZXIuPGJyPg0KJmd0OyArICo8YnI+DQomZ3Q7ICsgKiBDb3B5cmlnaHQgKEMpIDIwMTg8
YnI+DQomZ3Q7ICsgKiBBdXRob3I6IE1hdGhpZXUgT3RoYWNlaGUgJmx0OzxhIGhyZWY9Im1haWx0
bzptLm90aGFjZWhlQGdtYWlsLmNvbSI+bS5vdGhhY2VoZUBnbWFpbC5jb208L2E+Jmd0Ozxicj4N
CiZndDsgKyAqPGJyPg0KJmd0OyArICogNy1iaXQgSTJDIHNsYXZlIGFkZHJlc3M6IDB4NTc8YnI+
DQomZ3Q7ICsgKi88YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICsjaW5jbHVkZSAmbHQ7bGludXgva2Vy
bmVsLmgmZ3Q7PGJyPg0KJmd0OyArI2luY2x1ZGUgJmx0O2xpbnV4L21vZHVsZS5oJmd0Ozxicj4N
CiZndDsgKyNpbmNsdWRlICZsdDtsaW51eC9pMmMuaCZndDs8YnI+DQomZ3Q7ICsjaW5jbHVkZSAm
bHQ7bGludXgvZXJyLmgmZ3Q7PGJyPg0KJmd0OyArI2luY2x1ZGUgJmx0O2xpbnV4L29mX2Rldmlj
ZS5oJmd0Ozxicj4NCiZndDsgKyNpbmNsdWRlICZsdDtsaW51eC9paW8vaWlvLmgmZ3Q7PGJyPg0K
Jmd0OyArI2luY2x1ZGUgJmx0O2xpbnV4L2lpby9zeXNmcy5oJmd0Ozxicj4NCiZndDsgKzxicj4N
CiZndDsgKyNpbmNsdWRlICZsdDtsaW51eC9paW8vdHJpZ2dlcl9jb25zdW1lci5oJmd0Ozxicj4N
CiZndDsgKyNpbmNsdWRlICZsdDtsaW51eC9paW8vYnVmZmVyLmgmZ3Q7PGJyPg0KJmd0OyArI2lu
Y2x1ZGUgJmx0O2xpbnV4L2lpby90cmlnZ2VyZWRfYnVmZmVyLmgmZ3Q7PGJyPg0KJmd0OyArPGJy
Pg0KJmd0OyArLyogQ29udHJvbCwgc2V0dGluZyBhbmQgc3RhdHVzIHJlZ2lzdGVycyAqLzxicj4N
CiZndDsgKyNkZWZpbmUgSVNMMjk1MDFfREVWSUNFX0lEwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAweDAwPGJyPg0KJmd0OyArI2RlZmluZSBJU0wyOTUwMV9JRMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIDB4MEE8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICsvKiBTYW1w
bGluZyBjb250cm9sIHJlZ2lzdGVycyAqLzxicj4NCiZndDsgKyNkZWZpbmUgSVNMMjk1MDFfSU5U
RUdSQVRJT05fUEVSSU9EwqAgwqAgwqAgwqAgwqAgMHgxMDxicj4NCiZndDsgKyNkZWZpbmUgSVNM
Mjk1MDFfU0FNUExFX1BFUklPRMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgMHgx
MTxicj4NCiZndDsgKzxicj4NCiZndDsgKy8qIENsb3NlZCBsb29wIGNhbGlicmF0aW9uIHJlZ2lz
dGVycyAqLzxicj4NCiZndDsgKyNkZWZpbmUgSVNMMjk1MDFfQ1JPU1NUQUxLX0lfTVNCwqAgwqAg
wqAgwqAgwqAgwqAgwqAweDI0PGJyPg0KJmd0OyArI2RlZmluZSBJU0wyOTUwMV9DUk9TU1RBTEtf
SV9MU0LCoCDCoCDCoCDCoCDCoCDCoCDCoDB4MjU8YnI+DQomZ3Q7ICsjZGVmaW5lIElTTDI5NTAx
X0NST1NTVEFMS19JX0VYUE9ORU5UwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgMHgyNjxicj4NCiZn
dDsgKyNkZWZpbmUgSVNMMjk1MDFfQ1JPU1NUQUxLX1FfTVNCwqAgwqAgwqAgwqAgwqAgwqAgwqAw
eDI3PGJyPg0KJmd0OyArI2RlZmluZSBJU0wyOTUwMV9DUk9TU1RBTEtfUV9MU0LCoCDCoCDCoCDC
oCDCoCDCoCDCoDB4Mjg8YnI+DQomZ3Q7ICsjZGVmaW5lIElTTDI5NTAxX0NST1NTVEFMS19RX0VY
UE9ORU5UwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgMHgyOTxicj4NCiZndDsgKyNkZWZpbmUgSVNM
Mjk1MDFfQ1JPU1NUQUxLX0dBSU5fTVNCwqAgwqAgwqAgwqAgwqAgMHgyQTxicj4NCiZndDsgKyNk
ZWZpbmUgSVNMMjk1MDFfQ1JPU1NUQUxLX0dBSU5fTFNCwqAgwqAgwqAgwqAgwqAgMHgyQjxicj4N
CiZndDsgKyNkZWZpbmUgSVNMMjk1MDFfTUFHTklUVURFX1JFRl9FWFDCoCDCoCDCoCDCoCDCoCDC
oDB4MkM8YnI+DQomZ3Q7ICsjZGVmaW5lIElTTDI5NTAxX01BR05JVFVERV9SRUZfTVNCwqAgwqAg
wqAgwqAgwqAgwqAweDJEPGJyPg0KJmd0OyArI2RlZmluZSBJU0wyOTUwMV9NQUdOSVRVREVfUkVG
X0xTQsKgIMKgIMKgIMKgIMKgIMKgMHgyRTxicj4NCiZndDsgKyNkZWZpbmUgSVNMMjk1MDFfUEhB
U0VfT0ZGU0VUX01TQsKgIMKgIMKgIMKgIMKgIMKgIDB4MkY8YnI+DQomZ3Q7ICsjZGVmaW5lIElT
TDI5NTAxX1BIQVNFX09GRlNFVF9MU0LCoCDCoCDCoCDCoCDCoCDCoCAweDMwPGJyPg0KJmd0OyAr
PGJyPg0KJmd0OyArLyogQW5hbG9nIGNvbnRyb2wgcmVnaXN0ZXJzICovPGJyPg0KJmd0OyArI2Rl
ZmluZSBJU0wyOTUwMV9EUklWRVJfUkFOR0XCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCAweDkwPGJyPg0KJmd0OyArI2RlZmluZSBJU0wyOTUwMV9FTUlUVEVSX0RBQ8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgMHg5MTxicj4NCiZndDsgKzxicj4NCiZndDsgKyNkZWZpbmUgSVNM
Mjk1MDFfQ09NTUFORF9SRUdJU1RFUsKgIMKgIMKgIMKgIMKgIMKgIDB4QjA8YnI+DQomZ3Q7ICs8
YnI+DQomZ3Q7ICsvKiBDb21tYW5kcyAqLzxicj4NCiZndDsgKyNkZWZpbmUgSVNMMjk1MDFfRU1V
TF9TQU1QTEVfU1RBUlRfUElOwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAweDQ5PGJyPg0KJmd0OyAr
I2RlZmluZSBJU0wyOTUwMV9SRVNFVF9BTExfUkVHSVNURVJTwqAgwqAgwqAgwqAgwqAweEQ3PGJy
Pg0KJmd0OyArI2RlZmluZSBJU0wyOTUwMV9SRVNFVF9JTlRfU03CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCAweEQxPGJyPg0KJmd0OyArPGJyPg0KJmd0OyArLyogQW1iaWFudCBs
aWdodCBhbmQgdGVtcGVyYXR1cmUgY29ycmVjdGlvbnMgKi88YnI+DQomZ3Q7ICsjZGVmaW5lIElT
TDI5NTAxX1RFTVBfUkVGRVJFTkNFwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgMHgz
MTxicj4NCiZndDsgKyNkZWZpbmUgSVNMMjk1MDFfUEhBU0VfRVhQT05FTlTCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCAweDMzPGJyPg0KJmd0OyArI2RlZmluZSBJU0wyOTUwMV9URU1Q
X0NPRUZGX0HCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAweDM0PGJyPg0KJmd0
OyArI2RlZmluZSBJU0wyOTUwMV9URU1QX0NPRUZGX0LCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCAweDM5PGJyPg0KJmd0OyArI2RlZmluZSBJU0wyOTUwMV9BTUJJQU5UX0NPRUZG
X0HCoCDCoCDCoCDCoCDCoCDCoCDCoDB4MzY8YnI+DQomZ3Q7ICsjZGVmaW5lIElTTDI5NTAxX0FN
QklBTlRfQ09FRkZfQsKgIMKgIMKgIMKgIMKgIMKgIMKgMHgzQjxicj4NCiZndDsgKzxicj4NCiZn
dDsgKy8qIERhdGEgb3V0cHV0IHJlZ2lzdGVycyAqLzxicj4NCiZndDsgKyNkZWZpbmUgSVNMMjk1
MDFfRElTVEFOQ0VfTVNCX0RBVEHCoCDCoCDCoCDCoCDCoCDCoDB4RDE8YnI+DQomZ3Q7ICsjZGVm
aW5lIElTTDI5NTAxX0RJU1RBTkNFX0xTQl9EQVRBwqAgwqAgwqAgwqAgwqAgwqAweEQyPGJyPg0K
Jmd0OyArI2RlZmluZSBJU0wyOTUwMV9QUkVDSVNJT05fTVNCwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAweEQzPGJyPg0KJmd0OyArI2RlZmluZSBJU0wyOTUwMV9QUkVDSVNJT05f
TFNCwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAweEQ0PGJyPg0KJmd0OyArI2Rl
ZmluZSBJU0wyOTUwMV9NQUdOSVRVREVfRVhQT05FTlTCoCDCoCDCoCDCoCDCoCAweEQ1PGJyPg0K
Jmd0OyArI2RlZmluZSBJU0wyOTUwMV9NQUdOSVRVREVfTVNCwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAweEQ2PGJyPg0KJmd0OyArI2RlZmluZSBJU0wyOTUwMV9NQUdOSVRVREVf
TFNCwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAweEQ3PGJyPg0KJmd0OyArI2Rl
ZmluZSBJU0wyOTUwMV9QSEFTRV9NU0LCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDB4RDg8
YnI+DQomZ3Q7ICsjZGVmaW5lIElTTDI5NTAxX1BIQVNFX0xTQsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgMHhEOTxicj4NCiZndDsgKyNkZWZpbmUgSVNMMjk1MDFfSV9SQVdfRVhQT05FTlTC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAweERBPGJyPg0KJmd0OyArI2RlZmluZSBJ
U0wyOTUwMV9JX1JBV19NU0LCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDB4REI8YnI+DQom
Z3Q7ICsjZGVmaW5lIElTTDI5NTAxX0lfUkFXX0xTQsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgMHhEQzxicj4NCiZndDsgKyNkZWZpbmUgSVNMMjk1MDFfUV9SQVdfRVhQT05FTlTCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAweEREPGJyPg0KJmd0OyArI2RlZmluZSBJU0wyOTUw
MV9RX1JBV19NU0LCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDB4REU8YnI+DQomZ3Q7ICsj
ZGVmaW5lIElTTDI5NTAxX1FfUkFXX0xTQsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgMHhE
Rjxicj4NCiZndDsgKyNkZWZpbmUgSVNMMjk1MDFfRElFX1RFTVBFUkFUVVJFwqAgwqAgwqAgwqAg
wqAgwqAgwqAweEUyPGJyPg0KJmd0OyArI2RlZmluZSBJU0wyOTUwMV9BTUJJRU5UX0xJR0hUwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAweEUzPGJyPg0KJmd0OyArI2RlZmluZSBJ
U0wyOTUwMV9HQUlOX01TQsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDB4RTY8YnI+DQom
Z3Q7ICsjZGVmaW5lIElTTDI5NTAxX0dBSU5fTFNCwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgMHhFNzxicj4NCiZndDsgKzxicj4NCiZndDsgKyNkZWZpbmUgSVNMMjk1MDFfTUFYX0VYUF9W
QUwgMTU8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICsjZGVmaW5lIElTTDI5NTAxX0lOVF9USU1FX0FW
QUlMQUJMRSBcPGJyPg0KJmd0OyArwqAgwqAgwqAmcXVvdDswLjAwMDA3IDAuMDAwMTQgMC4wMDAy
OCAwLjAwMDU3IDAuMDAxMTQgJnF1b3Q7IFw8YnI+DQomZ3Q7ICvCoCDCoCDCoCZxdW90OzAuMDAy
MjggMC4wMDQ1NSAwLjAwOTEwIDAuMDE4MjAgMC4wMzY0MCAmcXVvdDsgXDxicj4NCiZndDsgK8Kg
IMKgIMKgJnF1b3Q7MC4wNzI4MSAwLjE0NTYxJnF1b3Q7PGJyPg0KJmd0OyArPGJyPg0KJmd0OyAr
I2RlZmluZSBJU0wyOTUwMV9DVVJSRU5UX1NDQUxFXzx3YnI+QVZBSUxBQkxFIFw8YnI+DQomZ3Q7
ICvCoCDCoCDCoCZxdW90OzAuMDAzOSAwLjAwNzggMC4wMTE4IDAuMDE1NyAwLjAxOTYgJnF1b3Q7
IFw8YnI+DQomZ3Q7ICvCoCDCoCDCoCZxdW90OzAuMDIzNSAwLjAyNzUgMC4wMzE0IDAuMDM1MiAw
LjAzOTIgJnF1b3Q7IFw8YnI+DQomZ3Q7ICvCoCDCoCDCoCZxdW90OzAuMDQzMSAwLjA0NzEgMC4w
NTEwIDAuMDU0OSAwLjA1ODgmcXVvdDs8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICtlbnVtIGlzbDI5
NTAxX2NvcnJlY3Rpb25fY29lZmYgezxicj4NCiZndDsgK8KgIMKgIMKgQ09FRkZfVEVNUF9BLDxi
cj4NCiZndDsgK8KgIMKgIMKgQ09FRkZfVEVNUF9CLDxicj4NCiZndDsgK8KgIMKgIMKgQ09FRkZf
TElHSFRfQSw8YnI+DQomZ3Q7ICvCoCDCoCDCoENPRUZGX0xJR0hUX0IsPGJyPg0KJmd0OyArwqAg
wqAgwqBDT0VGRl9NQVgsPGJyPg0KJmd0OyArfTs8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICtzdHJ1
Y3QgaXNsMjk1MDFfcHJpdmF0ZSB7PGJyPg0KJmd0OyArwqAgwqAgwqBzdHJ1Y3QgaTJjX2NsaWVu
dCAqY2xpZW50Ozxicj4NCiZndDsgK8KgIMKgIMKgc3RydWN0IG11dGV4IGxvY2s7PGJyPg0KJmd0
OyArwqAgwqAgwqAvKiBFeGFjdCByZXByZXNlbnRhdGlvbiBvZiBjb3JyZWN0aW9uIGNvZWZmaWNp
ZW50cy4gKi88YnI+DQomZ3Q7ICvCoCDCoCDCoHVuc2lnbmVkIGludCBzaGFkb3dfY29lZmZzW0NP
RUZGX01BWF07PGJyPg0KJmd0OyArfTs8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICtlbnVtIGlzbDI5
NTAxX3JlZ2lzdGVyX25hbWUgezxicj4NCiZndDsgK8KgIMKgIMKgUkVHX0RJU1RBTkNFLDxicj4N
CiZndDsgK8KgIMKgIMKgUkVHX0FNUExJVFVERSw8YnI+DQomZ3Q7ICvCoCDCoCDCoFJFR19QSEFT
RSw8YnI+DQomZ3Q7ICvCoCDCoCDCoFJFR19JX1JBVyw8YnI+DQomZ3Q7ICvCoCDCoCDCoFJFR19R
X1JBVyw8YnI+DQomZ3Q7ICvCoCDCoCDCoFJFR19URU1QRVJBVFVSRSw8YnI+DQomZ3Q7ICvCoCDC
oCDCoFJFR19BTUJJRU5UX0xJR0hULDxicj4NCiZndDsgK8KgIMKgIMKgUkVHX0dBSU4sPGJyPg0K
Jmd0OyArwqAgwqAgwqBSRUdfSV9CSUFTLDxicj4NCiZndDsgK8KgIMKgIMKgUkVHX1FfQklBUyw8
YnI+DQomZ3Q7ICvCoCDCoCDCoFJFR19HQUlOX0JJQVMsPGJyPg0KJmd0OyArwqAgwqAgwqBSRUdf
QU1QTF9CSUFTLDxicj4NCiZndDsgK8KgIMKgIMKgUkVHX1BIQVNFX0VYUCw8YnI+DQomZ3Q7ICvC
oCDCoCDCoFJFR19DQUxJQl9QSEFTRV9URU1QX0EsPGJyPg0KJmd0OyArwqAgwqAgwqBSRUdfQ0FM
SUJfUEhBU0VfVEVNUF9CLDxicj4NCiZndDsgK8KgIMKgIMKgUkVHX0NBTElCX1BIQVNFX0xJR0hU
X0EsPGJyPg0KJmd0OyArwqAgwqAgwqBSRUdfQ0FMSUJfUEhBU0VfTElHSFRfQiw8YnI+DQomZ3Q7
ICvCoCDCoCDCoFJFR19ESVNUQU5DRV9CSUFTLDxicj4NCiZndDsgK8KgIMKgIMKgUkVHX1RFTVBF
UkFUVVJFX0JJQVMsPGJyPg0KJmd0OyArwqAgwqAgwqBSRUdfSU5UX1RJTUUsPGJyPg0KJmd0OyAr
wqAgwqAgwqBSRUdfU0FNUExFX1RJTUUsPGJyPg0KJmd0OyArwqAgwqAgwqBSRUdfRFJJVkVSX1JB
TkdFLDxicj4NCiZndDsgK8KgIMKgIMKgUkVHX0VNSVRURVJfREFDLDxicj4NCiZndDsgK307PGJy
Pg0KJmd0OyArPGJyPg0KJmd0OyArc3RydWN0IGlzbDI5NTAxX3JlZ2lzdGVyX2Rlc2Mgezxicj4N
CiZndDsgK8KgIMKgIMKgdTggbXNiOzxicj4NCiZndDsgK8KgIMKgIMKgdTggbHNiOzxicj4NCiZn
dDsgK8KgIMKgIMKgdTggZXhwOzxicj4NCiZndDsgK307PGJyPg0KJmd0OyArPGJyPg0KJmd0OyAr
c3RhdGljIGNvbnN0IHN0cnVjdCBpc2wyOTUwMV9yZWdpc3Rlcl9kZXNjIGlzbDI5NTAxX3JlZ2lz
dGVyc1tdID0gezxicj4NCiZndDsgK8KgIMKgIMKgW1JFR19ESVNUQU5DRV0gPSB7PGJyPg0KJmd0
OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAubXNiID0gSVNMMjk1MDFfRElTVEFOQ0VfTVNCX0RBVEEs
PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAubHNiID0gSVNMMjk1MDFfRElTVEFOQ0Vf
TFNCX0RBVEEsPGJyPg0KJmd0OyArwqAgwqAgwqB9LDxicj4NCiZndDsgK8KgIMKgIMKgW1JFR19B
TVBMSVRVREVdID0gezxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgLm1zYiA9IElTTDI5
NTAxX01BR05JVFVERV9NU0IsPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAubHNiID0g
SVNMMjk1MDFfTUFHTklUVURFX0xTQiw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoC5l
eHAgPSBJU0wyOTUwMV9NQUdOSVRVREVfRVhQT05FTlQsPGJyPg0KJmd0OyArwqAgwqAgwqB9LDxi
cj4NCiZndDsgK8KgIMKgIMKgW1JFR19QSEFTRV0gPSB7PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAg
wqAgwqAgwqAubXNiID0gSVNMMjk1MDFfUEhBU0VfTVNCLDxicj4NCiZndDsgK8KgIMKgIMKgIMKg
IMKgIMKgIMKgLmxzYiA9IElTTDI5NTAxX1BIQVNFX0xTQiw8YnI+DQomZ3Q7ICvCoCDCoCDCoH0s
PGJyPg0KJmd0OyArwqAgwqAgwqBbUkVHX0lfUkFXXSA9IHs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDC
oCDCoCDCoCDCoC5tc2IgPSBJU0wyOTUwMV9JX1JBV19NU0IsPGJyPg0KJmd0OyArwqAgwqAgwqAg
wqAgwqAgwqAgwqAubHNiID0gSVNMMjk1MDFfSV9SQVdfTFNCLDxicj4NCiZndDsgK8KgIMKgIMKg
IMKgIMKgIMKgIMKgLmV4cCA9IElTTDI5NTAxX0lfUkFXX0VYUE9ORU5ULDxicj4NCiZndDsgK8Kg
IMKgIMKgfSw8YnI+DQomZ3Q7ICvCoCDCoCDCoFtSRUdfUV9SQVddID0gezxicj4NCiZndDsgK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgLm1zYiA9IElTTDI5NTAxX1FfUkFXX01TQiw8YnI+DQomZ3Q7ICvC
oCDCoCDCoCDCoCDCoCDCoCDCoC5sc2IgPSBJU0wyOTUwMV9RX1JBV19MU0IsPGJyPg0KJmd0OyAr
wqAgwqAgwqAgwqAgwqAgwqAgwqAuZXhwID0gSVNMMjk1MDFfUV9SQVdfRVhQT05FTlQsPGJyPg0K
Jmd0OyArwqAgwqAgwqB9LDxicj4NCiZndDsgK8KgIMKgIMKgW1JFR19URU1QRVJBVFVSRV0gPSB7
PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAubHNiID0gSVNMMjk1MDFfRElFX1RFTVBF
UkFUVVJFLDxicj4NCiZndDsgK8KgIMKgIMKgfSw8YnI+DQomZ3Q7ICvCoCDCoCDCoFtSRUdfQU1C
SUVOVF9MSUdIVF0gPSB7PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAubHNiID0gSVNM
Mjk1MDFfQU1CSUVOVF9MSUdIVCw8YnI+DQomZ3Q7ICvCoCDCoCDCoH0sPGJyPg0KJmd0OyArwqAg
wqAgwqBbUkVHX0dBSU5dID0gezxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgLm1zYiA9
IElTTDI5NTAxX0dBSU5fTVNCLDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgLmxzYiA9
IElTTDI5NTAxX0dBSU5fTFNCLDxicj4NCiZndDsgK8KgIMKgIMKgfSw8YnI+DQomZ3Q7ICvCoCDC
oCDCoFtSRUdfSV9CSUFTXSA9IHs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoC5tc2Ig
PSBJU0wyOTUwMV9DUk9TU1RBTEtfSV9NU0IsPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAg
wqAubHNiID0gSVNMMjk1MDFfQ1JPU1NUQUxLX0lfTFNCLDxicj4NCiZndDsgK8KgIMKgIMKgIMKg
IMKgIMKgIMKgLmV4cCA9IElTTDI5NTAxX0NST1NTVEFMS19JX0VYUE9ORU5ULDxicj4NCiZndDsg
K8KgIMKgIMKgfSw8YnI+DQomZ3Q7ICvCoCDCoCDCoFtSRUdfUV9CSUFTXSA9IHs8YnI+DQomZ3Q7
ICvCoCDCoCDCoCDCoCDCoCDCoCDCoC5tc2IgPSBJU0wyOTUwMV9DUk9TU1RBTEtfUV9NU0IsPGJy
Pg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAubHNiID0gSVNMMjk1MDFfQ1JPU1NUQUxLX1Ff
TFNCLDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgLmV4cCA9IElTTDI5NTAxX0NST1NT
VEFMS19RX0VYUE9ORU5ULDxicj4NCiZndDsgK8KgIMKgIMKgfSw8YnI+DQomZ3Q7ICvCoCDCoCDC
oFtSRUdfR0FJTl9CSUFTXSA9IHs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoC5tc2Ig
PSBJU0wyOTUwMV9DUk9TU1RBTEtfR0FJTl9NU0IsPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAg
wqAgwqAubHNiID0gSVNMMjk1MDFfQ1JPU1NUQUxLX0dBSU5fTFNCLDxicj4NCiZndDsgK8KgIMKg
IMKgfSw8YnI+DQomZ3Q7ICvCoCDCoCDCoFtSRUdfQU1QTF9CSUFTXSA9IHs8YnI+DQomZ3Q7ICvC
oCDCoCDCoCDCoCDCoCDCoCDCoC5tc2IgPSBJU0wyOTUwMV9NQUdOSVRVREVfUkVGX01TQiw8YnI+
DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoC5sc2IgPSBJU0wyOTUwMV9NQUdOSVRVREVfUkVG
X0xTQiw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoC5leHAgPSBJU0wyOTUwMV9NQUdO
SVRVREVfUkVGX0VYUCw8YnI+DQomZ3Q7ICvCoCDCoCDCoH0sPGJyPg0KJmd0OyArwqAgwqAgwqBb
UkVHX1BIQVNFX0VYUF0gPSB7PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAubHNiID0g
SVNMMjk1MDFfUEhBU0VfRVhQT05FTlQsPGJyPg0KJmd0OyArwqAgwqAgwqB9LDxicj4NCiZndDsg
K8KgIMKgIMKgW1JFR19DQUxJQl9QSEFTRV9URU1QX0FdID0gezxicj4NCiZndDsgK8KgIMKgIMKg
IMKgIMKgIMKgIMKgLmxzYiA9IElTTDI5NTAxX1RFTVBfQ09FRkZfQSw8YnI+DQomZ3Q7ICvCoCDC
oCDCoH0sPGJyPg0KJmd0OyArwqAgwqAgwqBbUkVHX0NBTElCX1BIQVNFX1RFTVBfQl0gPSB7PGJy
Pg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAubHNiID0gSVNMMjk1MDFfVEVNUF9DT0VGRl9C
LDxicj4NCiZndDsgK8KgIMKgIMKgfSw8YnI+DQomZ3Q7ICvCoCDCoCDCoFtSRUdfQ0FMSUJfUEhB
U0VfTElHSFRfQV0gPSB7PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAubHNiID0gSVNM
Mjk1MDFfQU1CSUFOVF9DT0VGRl9BLDxicj4NCiZndDsgK8KgIMKgIMKgfSw8YnI+DQomZ3Q7ICvC
oCDCoCDCoFtSRUdfQ0FMSUJfUEhBU0VfTElHSFRfQl0gPSB7PGJyPg0KJmd0OyArwqAgwqAgwqAg
wqAgwqAgwqAgwqAubHNiID0gSVNMMjk1MDFfQU1CSUFOVF9DT0VGRl9CLDxicj4NCiZndDsgK8Kg
IMKgIMKgfSw8YnI+DQomZ3Q7ICvCoCDCoCDCoFtSRUdfRElTVEFOQ0VfQklBU10gPSB7PGJyPg0K
Jmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAubXNiID0gSVNMMjk1MDFfUEhBU0VfT0ZGU0VUX01T
Qiw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoC5sc2IgPSBJU0wyOTUwMV9QSEFTRV9P
RkZTRVRfTFNCLDxicj4NCiZndDsgK8KgIMKgIMKgfSw8YnI+DQomZ3Q7ICvCoCDCoCDCoFtSRUdf
VEVNUEVSQVRVUkVfQklBU10gPSB7PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAubHNi
ID0gSVNMMjk1MDFfVEVNUF9SRUZFUkVOQ0UsPGJyPg0KJmd0OyArwqAgwqAgwqB9LDxicj4NCiZn
dDsgK8KgIMKgIMKgW1JFR19JTlRfVElNRV0gPSB7PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAg
wqAgwqAubHNiID0gSVNMMjk1MDFfSU5URUdSQVRJT05fUEVSSU9ELDxicj4NCiZndDsgK8KgIMKg
IMKgfSw8YnI+DQomZ3Q7ICvCoCDCoCDCoFtSRUdfU0FNUExFX1RJTUVdID0gezxicj4NCiZndDsg
K8KgIMKgIMKgIMKgIMKgIMKgIMKgLmxzYiA9IElTTDI5NTAxX1NBTVBMRV9QRVJJT0QsPGJyPg0K
Jmd0OyArwqAgwqAgwqB9LDxicj4NCiZndDsgK8KgIMKgIMKgW1JFR19EUklWRVJfUkFOR0VdID0g
ezxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgLmxzYiA9IElTTDI5NTAxX0RSSVZFUl9S
QU5HRSw8YnI+DQomZ3Q7ICvCoCDCoCDCoH0sPGJyPg0KJmd0OyArwqAgwqAgwqBbUkVHX0VNSVRU
RVJfREFDXSA9IHs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoC5sc2IgPSBJU0wyOTUw
MV9FTUlUVEVSX0RBQyw8YnI+DQomZ3Q7ICvCoCDCoCDCoH0sPGJyPg0KJmd0OyArfTs8YnI+DQom
Z3Q7ICs8YnI+DQomZ3Q7ICtzdGF0aWMgaW50IGlzbDI5NTAxX3JlZ2lzdGVyX3JlYWQoc3RydWN0
IGlzbDI5NTAxX3ByaXZhdGUgKmlzbDI5NTAxLDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZW51bSBpc2wyOTUwMV9yZWdpc3Rlcl9uYW1l
IG5hbWUsPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqB1MzIgKnZhbCk8YnI+DQomZ3Q7ICt7PGJyPg0KJmd0OyArwqAgwqAgwqBjb25zdCBz
dHJ1Y3QgaXNsMjk1MDFfcmVnaXN0ZXJfZGVzYyAqcmVnID0gJmFtcDtpc2wyOTUwMV9yZWdpc3Rl
cnNbbmFtZV07PGJyPg0KJmd0OyArwqAgwqAgwqB1OCBtc2IgPSAwLCBsc2IgPSAwLCBleHAgPSAw
Ozxicj4NCiZndDsgK8KgIMKgIMKgczMyIHJldDs8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICvCoCDC
oCDCoG11dGV4X2xvY2soJmFtcDtpc2wyOTUwMS0mZ3Q7bG9jayk7PGJyPg0KJmd0OyArwqAgwqAg
wqBpZiAocmVnLSZndDttc2IpIHs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoHJldCA9
IGkyY19zbWJ1c19yZWFkX2J5dGVfZGF0YSg8d2JyPmlzbDI5NTAxLSZndDtjbGllbnQsIHJlZy0m
Z3Q7bXNiKTs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChyZXQgJmx0OyAwKTxi
cj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ290byBlcnI7PGJyPg0K
Jmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBtc2IgPSByZXQ7PGJyPg0KJmd0OyArwqAgwqAgwqB9
PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArwqAgwqAgwqBpZiAocmVnLSZndDtsc2IpIHs8YnI+DQom
Z3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoHJldCA9IGkyY19zbWJ1c19yZWFkX2J5dGVfZGF0YSg8
d2JyPmlzbDI5NTAxLSZndDtjbGllbnQsIHJlZy0mZ3Q7bHNiKTs8YnI+DQomZ3Q7ICvCoCDCoCDC
oCDCoCDCoCDCoCDCoGlmIChyZXQgJmx0OyAwKTxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgZ290byBlcnI7PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBs
c2IgPSByZXQ7PGJyPg0KJmd0OyArwqAgwqAgwqB9PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArwqAg
wqAgwqBpZiAocmVnLSZndDtleHApIHs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoHJl
dCA9IGkyY19zbWJ1c19yZWFkX2J5dGVfZGF0YSg8d2JyPmlzbDI5NTAxLSZndDtjbGllbnQsIHJl
Zy0mZ3Q7ZXhwKTs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChyZXQgJmx0OyAw
KTxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ290byBlcnI7PGJy
Pg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBleHAgPSByZXQ7PGJyPg0KJmd0OyArwqAgwqAg
wqB9PGJyPg0KJmd0OyArwqAgwqAgwqBtdXRleF91bmxvY2soJmFtcDtpc2wyOTUwMS0mZ3Q7bG9j
ayk7PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArwqAgwqAgwqAqdmFsID0gKChtc2IgJmx0OyZsdDsg
OCkgKyBsc2IpICZsdDsmbHQ7IGV4cDs8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICvCoCDCoCDCoHJl
dHVybiAwOzxicj4NCiZndDsgK2Vycjo8YnI+DQomZ3Q7ICvCoCDCoCDCoG11dGV4X3VubG9jaygm
YW1wO2lzbDI5NTAxLSZndDtsb2NrKTs8YnI+DQomZ3Q7ICvCoCDCoCDCoHJldHVybiByZXQ7PGJy
Pg0KJmd0OyArfTxicj4NCiZndDsgKzxicj4NCiZndDsgK3N0YXRpYyB1MzIgaXNsMjk1MDFfcmVn
aXN0ZXJfd3JpdGUoc3RydWN0IGlzbDI5NTAxX3ByaXZhdGUgKmlzbDI5NTAxLDxicj4NCiZndDsg
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGVudW0gaXNs
Mjk1MDFfcmVnaXN0ZXJfbmFtZSBuYW1lLDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHUzMiB2YWx1ZSk8YnI+DQomZ3Q7ICt7PGJyPg0K
Jmd0OyArwqAgwqAgwqBjb25zdCBzdHJ1Y3QgaXNsMjk1MDFfcmVnaXN0ZXJfZGVzYyAqcmVnID0g
JmFtcDtpc2wyOTUwMV9yZWdpc3RlcnNbbmFtZV07PGJyPg0KJmd0OyArwqAgwqAgwqB1OCBtc2Is
IGxzYjs8YnI+DQomZ3Q7ICvCoCDCoCDCoGludCByZXQ7PGJyPg0KJmd0OyArPGJyPg0KJmd0OyAr
wqAgwqAgwqBpZiAoIXJlZy0mZ3Q7bXNiICZhbXA7JmFtcDsgdmFsdWUgJmd0OyBVOF9NQVgpPGJy
Pg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gLUVSQU5HRTs8YnI+DQomZ3Q7ICs8
YnI+DQomZ3Q7ICvCoCDCoCDCoGlmICghcmVnLSZndDtleHAgJmFtcDsmYW1wOyB2YWx1ZSAmZ3Q7
IFUxNl9NQVgpPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gLUVSQU5HRTs8
YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICvCoCDCoCDCoGlmIChyZWctJmd0O2V4cCkgezxicj4NCjxi
cj4NCjwvZGl2PjwvZGl2PlBsZWFzZSBkcm9wIHRoZSBjb2RlIHRoYXQgbGVhZHMgdG8gdGhpcyAm
IzM5O2ZvciBub3cmIzM5Oy48YnI+DQpXZSYjMzk7bGwgYnJpbmcgaXQgYmFjayBpbiBvbmNlIHdl
IGhhdmUgc3VwcG9ydCBmb3IgdGhlIGZsb2F0aW5nIHBvaW50IHN0dWZmLjxicj4NCjxzcGFuIGNs
YXNzPSIiPjxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgLyogVE9ETzogSW1wbGVtZW50
IGZsb2F0IHdyaXRlICovPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gLUVJ
TlZBTDs8YnI+DQomZ3Q7ICvCoCDCoCDCoH08YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICvCoCDCoCDC
oGlmICghcmVnLSZndDttc2IpIHs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoGxzYiA9
IHZhbHVlICZhbXA7IDB4RkY7PGJyPg0KJmd0OyArwqAgwqAgwqB9IGVsc2Ugezxicj4NCiZndDsg
K8KgIMKgIMKgIMKgIMKgIMKgIMKgbXNiID0gKHZhbHVlICZndDsmZ3Q7IDgpICZhbXA7IDB4RkY7
PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBsc2IgPSB2YWx1ZSAmYW1wOyAweEZGOzxi
cj4NCiZndDsgK8KgIMKgIMKgfTxicj4NCiZndDsgKzxicj4NCiZndDsgK8KgIMKgIMKgbXV0ZXhf
bG9jaygmYW1wO2lzbDI5NTAxLSZndDtsb2NrKTs8YnI+DQomZ3Q7ICvCoCDCoCDCoGlmIChyZWct
Jmd0O21zYikgezxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgcmV0ID0gaTJjX3NtYnVz
X3dyaXRlX2J5dGVfZGF0YSg8d2JyPmlzbDI5NTAxLSZndDtjbGllbnQsPGJyPg0KJmd0OyArwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqByZWctJmd0O21zYiwgbXNiKTs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDC
oGlmIChyZXQgJmx0OyAwKTxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgZ290byBlcnI7PGJyPg0KJmd0OyArwqAgwqAgwqB9PGJyPg0KJmd0OyArPGJyPg0KJmd0OyAr
wqAgwqAgwqByZXQgPSBpMmNfc21idXNfd3JpdGVfYnl0ZV9kYXRhKDx3YnI+aXNsMjk1MDEtJmd0
O2NsaWVudCwgcmVnLSZndDtsc2IsIGxzYik7PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArZXJyOjxi
cj4NCiZndDsgK8KgIMKgIMKgbXV0ZXhfdW5sb2NrKCZhbXA7aXNsMjk1MDEtJmd0O2xvY2spOzxi
cj4NCjxicj4NCjwvc3Bhbj5OaXRwaWNrIDogQmxhbmsgbGluZSBoZXJlIHdvdWxkIGJlIG5pY2Uu
PGJyPg0KPGRpdj48ZGl2IGNsYXNzPSJoNSI+PGJyPg0KJmd0OyArwqAgwqAgwqByZXR1cm4gcmV0
Ozxicj4NCiZndDsgK308YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICtzdGF0aWMgc3NpemVfdCBpc2wy
OTUwMV9yZWFkX2V4dChzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2LDxicj4NCiZndDsgK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHVpbnRwdHJfdCBwcml2YXRl
LDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IGNvbnN0IHN0cnVjdCBpaW9fY2hhbl9zcGVjICpjaGFuLDxicj4NCiZndDsgK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNoYXIgKmJ1Zik8YnI+DQomZ3Q7ICt7
PGJyPg0KJmd0OyArwqAgwqAgwqBzdHJ1Y3QgaXNsMjk1MDFfcHJpdmF0ZSAqaXNsMjk1MDEgPSBp
aW9fcHJpdihpbmRpb19kZXYpOzxicj4NCiZndDsgK8KgIMKgIMKgZW51bSBpc2wyOTUwMV9yZWdp
c3Rlcl9uYW1lIHJlZyA9IHByaXZhdGU7PGJyPg0KJmd0OyArwqAgwqAgwqBpbnQgcmV0Ozxicj4N
CiZndDsgK8KgIMKgIMKgdTMyIHZhbHVlLCBnYWluLCBjb2VmZiwgZXhwOzxicj4NCiZndDsgKzxi
cj4NCiZndDsgK8KgIMKgIMKgc3dpdGNoIChyZWcpIHs8YnI+DQomZ3Q7ICvCoCDCoCDCoGNhc2Ug
UkVHX0dBSU46PGJyPg0KJmd0OyArwqAgwqAgwqBjYXNlIFJFR19HQUlOX0JJQVM6PGJyPg0KJmd0
OyArwqAgwqAgwqAgwqAgwqAgwqAgwqByZXQgPSBpc2wyOTUwMV9yZWdpc3Rlcl9yZWFkKDx3YnI+
aXNsMjk1MDEsIHJlZywgJmFtcDtnYWluKTs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDC
oGlmIChyZXQgJmx0OyAwKTxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgcmV0dXJuIHJldDs8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDC
oHZhbHVlID0gZ2Fpbjs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4N
CiZndDsgK8KgIMKgIMKgY2FzZSBSRUdfQ0FMSUJfUEhBU0VfVEVNUF9BOjxicj4NCiZndDsgK8Kg
IMKgIMKgY2FzZSBSRUdfQ0FMSUJfUEhBU0VfVEVNUF9COjxicj4NCiZndDsgK8KgIMKgIMKgY2Fz
ZSBSRUdfQ0FMSUJfUEhBU0VfTElHSFRfQTo8YnI+DQomZ3Q7ICvCoCDCoCDCoGNhc2UgUkVHX0NB
TElCX1BIQVNFX0xJR0hUX0I6PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqByZXQgPSBp
c2wyOTUwMV9yZWdpc3Rlcl9yZWFkKDx3YnI+aXNsMjk1MDEsIFJFR19QSEFTRV9FWFAsICZhbXA7
ZXhwKTs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChyZXQgJmx0OyAwKTxicj4N
CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIHJldDs8YnI+DQom
Z3Q7ICs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoHJldCA9IGlzbDI5NTAxX3JlZ2lz
dGVyX3JlYWQoPHdicj5pc2wyOTUwMSwgcmVnLCAmYW1wO2NvZWZmKTs8YnI+DQomZ3Q7ICvCoCDC
oCDCoCDCoCDCoCDCoCDCoGlmIChyZXQgJmx0OyAwKTxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIHJldDs8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICvCoCDC
oCDCoCDCoCDCoCDCoCDCoHZhbHVlID0gY29lZmYgJmx0OyZsdDsgZXhwOzxicj4NCiZndDsgK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KJmd0OyArwqAgwqAgwqBkZWZhdWx0Ojxicj4N
CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIC1FSU5WQUw7PGJyPg0KJmd0OyArwqAg
wqAgwqB9PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArwqAgwqAgwqByZXR1cm4gc3ByaW50ZihidWYs
ICZxdW90OyV1XG4mcXVvdDssIHZhbHVlKTs8YnI+DQomZ3Q7ICt9PGJyPg0KJmd0OyArPGJyPg0K
Jmd0OyArc3RhdGljIGludCBpc2wyOTUwMV9zZXRfc2hhZG93X2NvZWZmKDx3YnI+c3RydWN0IGlz
bDI5NTAxX3ByaXZhdGUgKmlzbDI5NTAxLDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGVudW0gaXNsMjk1MDFfcmVnaXN0ZXJfbmFt
ZSByZWcsPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgdW5zaWduZWQgaW50IHZhbCk8YnI+DQomZ3Q7ICt7PGJyPg0KJmd0OyArwqAg
wqAgwqBlbnVtIGlzbDI5NTAxX2NvcnJlY3Rpb25fY29lZmYgY29lZmY7PGJyPg0KJmd0OyArPGJy
Pg0KJmd0OyArwqAgwqAgwqBzd2l0Y2ggKHJlZykgezxicj4NCiZndDsgK8KgIMKgIMKgY2FzZSBS
RUdfQ0FMSUJfUEhBU0VfVEVNUF9BOjxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgY29l
ZmYgPSBDT0VGRl9URU1QX0E7PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8
YnI+DQomZ3Q7ICvCoCDCoCDCoGNhc2UgUkVHX0NBTElCX1BIQVNFX1RFTVBfQjo8YnI+DQomZ3Q7
ICvCoCDCoCDCoCDCoCDCoCDCoCDCoGNvZWZmID0gQ09FRkZfVEVNUF9COzxicj4NCiZndDsgK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KJmd0OyArwqAgwqAgwqBjYXNlIFJFR19DQUxJ
Ql9QSEFTRV9MSUdIVF9BOjxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgY29lZmYgPSBD
T0VGRl9MSUdIVF9BOzxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0K
Jmd0OyArwqAgwqAgwqBjYXNlIFJFR19DQUxJQl9QSEFTRV9MSUdIVF9COjxicj4NCiZndDsgK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgY29lZmYgPSBDT0VGRl9MSUdIVF9COzxicj4NCiZndDsgK8KgIMKg
IMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KJmd0OyArwqAgwqAgwqBkZWZhdWx0Ojxicj4NCiZn
dDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIC1FSU5WQUw7PGJyPg0KJmd0OyArwqAgwqAg
wqB9PGJyPg0KJmd0OyArwqAgwqAgwqBpc2wyOTUwMS0mZ3Q7c2hhZG93X2NvZWZmc1tjb2VmZl0g
PSB2YWw7PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArwqAgwqAgwqByZXR1cm4gMDs8YnI+DQomZ3Q7
ICt9PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArc3RhdGljIGludCBpc2wyOTUwMV93cml0ZV9jb2Vm
ZihzdHJ1Y3QgaXNsMjk1MDFfcHJpdmF0ZSAqaXNsMjk1MDEsPGJyPg0KJmd0OyArwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBlbnVtIGlzbDI5NTAxX2NvcnJlY3Rp
b25fY29lZmYgY29lZmYsPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBpbnQgdmFsKTxicj4NCiZndDsgK3s8YnI+DQomZ3Q7ICvCoCDCoCDCoGVu
dW0gaXNsMjk1MDFfcmVnaXN0ZXJfbmFtZSByZWc7PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArwqAg
wqAgwqBzd2l0Y2ggKGNvZWZmKSB7PGJyPg0KJmd0OyArwqAgwqAgwqBjYXNlIENPRUZGX1RFTVBf
QTo8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoHJlZyA9IFJFR19DQUxJQl9QSEFTRV9U
RU1QX0E7PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQomZ3Q7ICvC
oCDCoCDCoGNhc2UgQ09FRkZfVEVNUF9COjxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKg
cmVnID0gUkVHX0NBTElCX1BIQVNFX1RFTVBfQjs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDC
oCDCoGJyZWFrOzxicj4NCiZndDsgK8KgIMKgIMKgY2FzZSBDT0VGRl9MSUdIVF9BOjxicj4NCiZn
dDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgcmVnID0gUkVHX0NBTElCX1BIQVNFX0xJR0hUX0E7PGJy
Pg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQomZ3Q7ICvCoCDCoCDCoGNh
c2UgQ09FRkZfTElHSFRfQjo8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoHJlZyA9IFJF
R19DQUxJQl9QSEFTRV9MSUdIVF9COzxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgYnJl
YWs7PGJyPg0KJmd0OyArwqAgwqAgwqBkZWZhdWx0Ojxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKg
IMKgIMKgcmV0dXJuIC1FSU5WQUw7PGJyPg0KJmd0OyArwqAgwqAgwqB9PGJyPg0KJmd0OyArPGJy
Pg0KJmd0OyArwqAgwqAgwqByZXR1cm4gaXNsMjk1MDFfcmVnaXN0ZXJfd3JpdGUoPHdicj5pc2wy
OTUwMSwgcmVnLCB2YWwpOzxicj4NCiZndDsgK308YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICtzdGF0
aWMgdW5zaWduZWQgaW50IGlzbDI5NTAxX2ZpbmRfY29ycl9leHAoPHdicj51bnNpZ25lZCBpbnQg
dmFsLDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIHVuc2lnbmVkIGludCBtYXhfZXhwLDxicj4NCiZndDsgK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHVu
c2lnbmVkIGludCBtYXhfbWFudGlzc2EpPGJyPg0KJmd0OyArezxicj4NCiZndDsgK8KgIMKgIMKg
dW5zaWduZWQgaW50IGV4cCA9IDE7PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArwqAgwqAgwqAvKjxi
cj4NCiZndDsgK8KgIMKgIMKgICogQ29ycmVjdGlvbiBjb2VmZmljaWVudHMgYXJlIHJlcHJlc2Vu
dGVkIHVuZGVyPGJyPg0KJmd0OyArwqAgwqAgwqAgKiBtYW50aXNzYSAqIDJeZXhwb25lbnQgZm9y
bSwgd2hlcmUgbWFudGlzc2EgYW5kIGV4cG9uZW50PGJyPg0KJmd0OyArwqAgwqAgwqAgKiBhcmUg
c3RvcmVkIGluIHR3byBzZXBhcmF0ZSByZWdpc3RlcnMgb2YgdGhlIHNlbnNvci48YnI+DQomZ3Q7
ICvCoCDCoCDCoCAqPGJyPg0KJmd0OyArwqAgwqAgwqAgKiBDb21wdXRlIGFuZCByZXR1cm4gdGhl
IGxvd2VzdCBleHBvbmVudCBzdWNoIGFzOjxicj4NCiZndDsgK8KgIMKgIMKgICrCoCDCoCDCoCDC
oCDCoCDCoG1hbnRpc3NhID0gdmFsdWUgLyAyXmV4cG9uZW50PGJyPg0KJmd0OyArwqAgwqAgwqAg
Kjxicj4NCiZndDsgK8KgIMKgIMKgICrCoCB3aGVyZSBtYW50aXNzYSAmbHQ7IG1heF9tYW50aXNz
YS48YnI+DQomZ3Q7ICvCoCDCoCDCoCAqLzxicj4NCiZndDsgK8KgIMKgIMKgaWYgKHZhbCAmbHQ7
PSBtYXhfbWFudGlzc2EpPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gMDs8
YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICvCoCDCoCDCoHdoaWxlICgodmFsICZndDsmZ3Q7IGV4cCkg
Jmd0OyBtYXhfbWFudGlzc2EpIHs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoGV4cCsr
Ozxicj4NCiZndDsgKzxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGV4cCAmZ3Q7
IG1heF9leHApPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1
cm4gbWF4X2V4cDs8YnI+DQomZ3Q7ICvCoCDCoCDCoH08YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICvC
oCDCoCDCoHJldHVybiBleHA7PGJyPg0KJmd0OyArfTxicj4NCiZndDsgKzxicj4NCiZndDsgK3N0
YXRpYyBzc2l6ZV90IGlzbDI5NTAxX3dyaXRlX2V4dChzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2
LDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgdWludHB0cl90IHByaXZhdGUsPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjb25zdCBzdHJ1Y3QgaWlvX2NoYW5fc3BlYyAqY2hhbiw8
YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGNvbnN0IGNoYXIgKmJ1Ziwgc2l6ZV90IGxlbik8YnI+DQomZ3Q7ICt7PGJyPg0KJmd0OyArwqAg
wqAgwqBzdHJ1Y3QgaXNsMjk1MDFfcHJpdmF0ZSAqaXNsMjk1MDEgPSBpaW9fcHJpdihpbmRpb19k
ZXYpOzxicj4NCiZndDsgK8KgIMKgIMKgZW51bSBpc2wyOTUwMV9yZWdpc3Rlcl9uYW1lIHJlZyA9
IHByaXZhdGU7PGJyPg0KJmd0OyArwqAgwqAgwqB1bnNpZ25lZCBpbnQgdmFsOzxicj4NCiZndDsg
K8KgIMKgIMKgaW50IG1heF9leHAgPSAwOzxicj4NCiZndDsgK8KgIMKgIMKgaW50IHJldDs8YnI+
DQomZ3Q7ICvCoCDCoCDCoGludCBpOzxicj4NCiZndDsgKzxicj4NCiZndDsgK8KgIMKgIMKgcmV0
ID0ga3N0cnRvdWludChidWYsIDEwLCAmYW1wO3ZhbCk7PGJyPg0KJmd0OyArwqAgwqAgwqBpZiAo
cmV0KTxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIHJldDs8YnI+DQomZ3Q7
ICs8YnI+DQomZ3Q7ICvCoCDCoCDCoHN3aXRjaCAocmVnKSB7PGJyPg0KJmd0OyArwqAgwqAgwqBj
YXNlIFJFR19HQUlOX0JJQVM6PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAodmFs
ICZndDsgVTE2X01BWCk8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHJldHVybiAtRVJBTkdFOzxicj4NCiZndDsgKzxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKg
IMKgcmV0ID0gaXNsMjk1MDFfcmVnaXN0ZXJfd3JpdGUoPHdicj5pc2wyOTUwMSwgcmVnLCB2YWwp
Ozxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHJldCAmbHQ7IDApPGJyPg0KJmd0
OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gcmV0Ozxicj4NCiZndDsg
Kzxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KJmd0OyArwqAgwqAg
wqBjYXNlIFJFR19DQUxJQl9QSEFTRV9URU1QX0E6PGJyPg0KJmd0OyArwqAgwqAgwqBjYXNlIFJF
R19DQUxJQl9QSEFTRV9URU1QX0I6PGJyPg0KJmd0OyArwqAgwqAgwqBjYXNlIFJFR19DQUxJQl9Q
SEFTRV9MSUdIVF9BOjxicj4NCiZndDsgK8KgIMKgIMKgY2FzZSBSRUdfQ0FMSUJfUEhBU0VfTElH
SFRfQjo8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoGlmICh2YWwg
Jmd0OyAoVThfTUFYICZsdDsmbHQ7IElTTDI5NTAxX01BWF9FWFBfVkFMKSk8YnI+DQomZ3Q7ICvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiAtRVJBTkdFOzxicj4NCiZndDsg
Kzxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgLyogU3RvcmUgdGhlIGNvcnJlY3Rpb24g
Y29lZmZpY2llbnQgdW5kZXIgaXRzIGV4YWN0IGZvcm0uICovPGJyPg0KJmd0OyArwqAgwqAgwqAg
wqAgwqAgwqAgwqByZXQgPSBpc2wyOTUwMV9zZXRfc2hhZG93X2NvZWZmKDx3YnI+aXNsMjk1MDEs
IHJlZywgdmFsKTs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChyZXQgJmx0OyAw
KTxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIHJldDs8
YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoC8qPGJyPg0KJmd0OyAr
wqAgwqAgwqAgwqAgwqAgwqAgwqAgKiBGaW5kIHRoZSBoaWdoZXN0IGV4cG9uZW50IG5lZWRlZCB0
byByZXByZXNlbnQ8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCAqIGNvcnJlY3Rpb24g
Y29lZmZpY2llbnRzLjxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgICovPGJyPg0KJmd0
OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBmb3IgKGkgPSAwOyBpICZsdDsgQ09FRkZfTUFYOyBpKysp
IHs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGludCBjb3JyOzxi
cj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaW50IGNvcnJfZXhwOzxi
cj4NCiZndDsgKzxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY29y
ciA9IGlzbDI5NTAxLSZndDtzaGFkb3dfY29lZmZzW2ldOzxicj4NCiZndDsgK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgY29ycl9leHAgPSBpc2wyOTUwMV9maW5kX2NvcnJfZXhwKGNv
cnIsPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBJU0wyOTUwMV9NQVhfRVhQ
X1ZBTCw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFU4X01BWCAvIDIpOzxi
cj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZGV2X2RiZygmYW1wO2lz
bDI5NTAxLSZndDtjbGllbnQtJmd0Ozx3YnI+ZGV2LDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7Zm91bmQgZXhwIG9mIGNvcnIoJWQp
ID0gJWRcbiZxdW90OywgY29yciwgY29ycl9leHApOzxicj4NCiZndDsgKzxicj4NCiZndDsgK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbWF4X2V4cCA9IG1heChtYXhfZXhwLCBjb3Jy
X2V4cCk7PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KJmd0OyArPGJyPg0K
Jmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAvKjxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKg
IMKgICogUmVwcmVzZW50IGV2ZXJ5IGNvcnJlY3Rpb24gY29lZmZpY2llbnQgdW5kZXI8YnI+DQom
Z3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCAqIG1hbnRpc3NhICogMl5tYXhfZXhwb25lbnQgZm9y
bSBhbmQgZm9yY2UgdGhlPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgKiB3cml0aW5n
IG9mIHRob3NlIGNvZWZmaWNpZW50cyBvbiB0aGUgc2Vuc29yLjxicj4NCiZndDsgK8KgIMKgIMKg
IMKgIMKgIMKgIMKgICovPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBmb3IgKGkgPSAw
OyBpICZsdDsgQ09FRkZfTUFYOyBpKyspIHs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGludCBjb3JyOzxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgaW50IG1hbnRpc3NhOzxicj4NCiZndDsgKzxicj4NCiZndDsgK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgY29yciA9IGlzbDI5NTAxLSZndDtzaGFkb3dfY29lZmZzW2ld
Ozxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKCFjb3JyKTxi
cj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY29u
dGludWU7PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBtYW50aXNzYSA9IGNvcnIgJmd0OyZndDsgbWF4X2V4cDs8YnI+DQomZ3Q7ICs8YnI+DQom
Z3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldCA9IGlzbDI5NTAxX3dyaXRl
X2NvZWZmKGlzbDI5NTAxLCBpLCBtYW50aXNzYSk7PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBpZiAocmV0ICZsdDsgMCk8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiByZXQ7PGJyPg0KJmd0OyArwqAg
wqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAg
wqAgwqByZXQgPSBpc2wyOTUwMV9yZWdpc3Rlcl93cml0ZSg8d2JyPmlzbDI5NTAxLCBSRUdfUEhB
U0VfRVhQLCBtYXhfZXhwKTs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChyZXQg
Jmx0OyAwKTxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJu
IHJldDs8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxi
cj4NCiZndDsgK8KgIMKgIMKgZGVmYXVsdDo8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDC
oHJldHVybiAtRUlOVkFMOzxicj4NCiZndDsgK8KgIMKgIMKgfTxicj4NCiZndDsgKzxicj4NCiZn
dDsgK8KgIMKgIMKgcmV0dXJuIGxlbjs8YnI+DQomZ3Q7ICt9PGJyPg0KJmd0OyArPGJyPg0KJmd0
OyArI2RlZmluZSBfSVNMMjk1MDFfRVhUX0lORk8oX25hbWUsIF9pZGVudCkgeyBcPGJyPg0KJmd0
OyArwqAgwqAgwqAubmFtZSA9IF9uYW1lLCBcPGJyPg0KJmd0OyArwqAgwqAgwqAucmVhZCA9IGlz
bDI5NTAxX3JlYWRfZXh0LCBcPGJyPg0KJmd0OyArwqAgwqAgwqAud3JpdGUgPSBpc2wyOTUwMV93
cml0ZV9leHQsIFw8YnI+DQomZ3Q7ICvCoCDCoCDCoC5wcml2YXRlID0gX2lkZW50LCBcPGJyPg0K
Jmd0OyArwqAgwqAgwqAuc2hhcmVkID0gSUlPX1NFUEFSQVRFLCBcPGJyPg0KJmd0OyArfTxicj4N
CiZndDsgKzxicj4NCiZndDsgK3N0YXRpYyBjb25zdCBzdHJ1Y3QgaWlvX2NoYW5fc3BlY19leHRf
aW5mbyBpc2wyOTUwMV9leHRfaW5mb1tdID0gezxicj4NCiZndDsgK8KgIMKgIMKgX0lTTDI5NTAx
X0VYVF9JTkZPKCZxdW90O2FnY19nYWluJnF1b3Q7LCBSRUdfR0FJTiksPGJyPg0KJmd0OyArwqAg
wqAgwqBfSVNMMjk1MDFfRVhUX0lORk8oJnF1b3Q7YWdjX2dhaW5fPHdicj5iaWFzJnF1b3Q7LCBS
RUdfR0FJTl9CSUFTKSw8YnI+DQomZ3Q7ICvCoCDCoCDCoF9JU0wyOTUwMV9FWFRfSU5GTygmcXVv
dDtjYWxpYl88d2JyPnBoYXNlX3RlbXBfYSZxdW90OywgUkVHX0NBTElCX1BIQVNFX1RFTVBfQSks
PGJyPg0KJmd0OyArwqAgwqAgwqBfSVNMMjk1MDFfRVhUX0lORk8oJnF1b3Q7Y2FsaWJfPHdicj5w
aGFzZV90ZW1wX2ImcXVvdDssIFJFR19DQUxJQl9QSEFTRV9URU1QX0IpLDxicj4NCiZndDsgK8Kg
IMKgIMKgX0lTTDI5NTAxX0VYVF9JTkZPKCZxdW90O2NhbGliXzx3YnI+cGhhc2VfbGlnaHRfYSZx
dW90OywgUkVHX0NBTElCX1BIQVNFX0xJR0hUX0EpLDxicj4NCiZndDsgK8KgIMKgIMKgX0lTTDI5
NTAxX0VYVF9JTkZPKCZxdW90O2NhbGliXzx3YnI+cGhhc2VfbGlnaHRfYiZxdW90OywgUkVHX0NB
TElCX1BIQVNFX0xJR0hUX0IpLDxicj4NCiZndDsgK8KgIMKgIMKgeyB9LDxicj4NCiZndDsgK307
PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArI2RlZmluZSBJU0wyOTUwMV9ESVNUQU5DRV9TQ0FOX0lO
REVYIDA8YnI+DQomZ3Q7ICsjZGVmaW5lIElTTDI5NTAxX1RJTUVTVEFNUF9TQ0FOX0lOREVYIDE8
YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICtzdGF0aWMgY29uc3Qgc3RydWN0IGlpb19jaGFuX3NwZWMg
aXNsMjk1MDFfY2hhbm5lbHNbXSA9IHs8YnI+DQomZ3Q7ICvCoCDCoCDCoHs8YnI+DQomZ3Q7ICvC
oCDCoCDCoCDCoCDCoCDCoCDCoC50eXBlID0gSUlPX1BST1hJTUlUWSw8YnI+DQomZ3Q7ICvCoCDC
oCDCoCDCoCDCoCDCoCDCoC5zY2FuX2luZGV4ID0gSVNMMjk1MDFfRElTVEFOQ0VfU0NBTl9JTkRF
WCw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoC5pbmZvX21hc2tfc2VwYXJhdGUgPTxi
cj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgQklUKElJT19DSEFOX0lO
Rk9fUkFXKcKgIMKgfDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
QklUKElJT19DSEFOX0lORk9fU0NBTEUpIHw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoEJJVChJSU9fQ0hBTl9JTkZPX0NBTElCQklBUyksPGJyPg0KJmd0OyArwqAg
wqAgwqAgwqAgwqAgwqAgwqAuc2Nhbl90eXBlID0gezxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgLnNpZ24gPSAmIzM5O3UmIzM5Oyw8YnI+DQomZ3Q7ICvCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5yZWFsYml0cyA9IDE2LDxicj4NCiZndDsgK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLnN0b3JhZ2ViaXRzID0gMTYsPGJyPg0KJmd0OyAr
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAuZW5kaWFubmVzcyA9IElJT19DUFUsPGJy
Pg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqB9LDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKg
IMKgIMKgLmluZm9fbWFza19zaGFyZWRfYnlfYWxsID0gQklUKElJT19DSEFOX0lORk9fSU5UX1RJ
TUUpIHw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoEJJVChJSU9fQ0hBTl9JTkZPX1NBTVBfRlJFUSksPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAg
wqAgwqAgwqAuZXh0X2luZm8gPSBpc2wyOTUwMV9leHRfaW5mbyw8YnI+DQomZ3Q7ICvCoCDCoCDC
oH0sPGJyPg0KJmd0OyArwqAgwqAgwqB7PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAu
dHlwZSA9IElJT19QSEFTRSw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoC5zY2FuX2lu
ZGV4ID0gLTEsPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAuaW5mb19tYXNrX3NlcGFy
YXRlID0gQklUKElJT19DSEFOX0lORk9fUkFXKSB8PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBCSVQoSUlPX0NIQU5fSU5GT19TQ0FMRSksPGJy
Pg0KJmd0OyArwqAgwqAgwqB9LDxicj4NCiZndDsgK8KgIMKgIMKgezxicj4NCiZndDsgK8KgIMKg
IMKgIMKgIMKgIMKgIMKgLnR5cGUgPSBJSU9fSU5URU5TSVRZLDxicj4NCiZndDsgK8KgIMKgIMKg
IMKgIMKgIMKgIMKgLnNjYW5faW5kZXggPSAtMSw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDC
oCDCoC5pbmZvX21hc2tfc2VwYXJhdGUgPSBCSVQoSUlPX0NIQU5fSU5GT19SQVcpIHw8YnI+DQom
Z3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoEJJVChJSU9f
Q0hBTl9JTkZPX0NBTElCQklBUyksPGJyPg0KJmd0OyArwqAgwqAgwqB9LDxicj4NCiZndDsgK8Kg
IMKgIMKgezxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgLnR5cGUgPSBJSU9fSU5URU5T
SVRZLDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgLnNjYW5faW5kZXggPSAtMSw8YnI+
DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoC5tb2RpZmllZCA9IDEsPGJyPg0KJmd0OyArwqAg
wqAgwqAgwqAgwqAgwqAgwqAuY2hhbm5lbDIgPSBJSU9fTU9EX0ksPGJyPg0KJmd0OyArwqAgwqAg
wqAgwqAgwqAgwqAgwqAuaW5mb19tYXNrX3NlcGFyYXRlID0gQklUKElJT19DSEFOX0lORk9fUkFX
KSB8PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBCSVQoSUlPX0NIQU5fSU5GT19DQUxJQkJJQVMpLDxicj4NCiZndDsgK8KgIMKgIMKgfSw8YnI+
DQomZ3Q7ICvCoCDCoCDCoHs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoC50eXBlID0g
SUlPX0lOVEVOU0lUWSw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoC5zY2FuX2luZGV4
ID0gLTEsPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAubW9kaWZpZWQgPSAxLDxicj4N
CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgLmNoYW5uZWwyID0gSUlPX01PRF9RLDxicj4NCiZn
dDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgLmluZm9fbWFza19zZXBhcmF0ZSA9IEJJVChJSU9fQ0hB
Tl9JTkZPX1JBVykgfDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgQklUKElJT19DSEFOX0lORk9fQ0FMSUJCSUFTKSw8YnI+DQomZ3Q7ICvCoCDC
oCDCoH0sPGJyPg0KJmd0OyArwqAgwqAgwqB7PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAg
wqAudHlwZSA9IElJT19DVVJSRU5ULDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgLnNj
YW5faW5kZXggPSAtMSw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoC5vdXRwdXQgPSAx
LDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgLmluZm9fbWFza19zZXBhcmF0ZSA9IEJJ
VChJSU9fQ0hBTl9JTkZPX1JBVykgfDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgQklUKElJT19DSEFOX0lORk9fU0NBTEUpLDxicj4NCiZndDsg
K8KgIMKgIMKgfSw8YnI+DQomZ3Q7ICvCoCDCoCDCoHs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDC
oCDCoCDCoC50eXBlID0gSUlPX1RFTVAsPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAu
c2Nhbl9pbmRleCA9IC0xLDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgLmluZm9fbWFz
a19zZXBhcmF0ZSA9IEJJVChJSU9fQ0hBTl9JTkZPX1JBVykgfDxicj4NCiZndDsgK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgQklUKElJT19DSEFOX0lORk9fU0NB
TEUpwqAgwqAgwqB8PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBCSVQoSUlPX0NIQU5fSU5GT19DQUxJQkJJQVMpLDxicj4NCiZndDsgK8KgIMKg
IMKgfSw8YnI+DQomZ3Q7ICvCoCDCoCDCoHs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDC
oC50eXBlID0gSUlPX0lOVEVOU0lUWSw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoC5z
Y2FuX2luZGV4ID0gLTEsPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAubW9kaWZpZWQg
PSAxLDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgLmNoYW5uZWwyID0gSUlPX01PRF9M
SUdIVF9DTEVBUiw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoC5pbmZvX21hc2tfc2Vw
YXJhdGUgPSBCSVQoSUlPX0NIQU5fSU5GT19SQVcpIHw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoEJJVChJSU9fQ0hBTl9JTkZPX1NDQUxFKSw8
YnI+DQomZ3Q7ICvCoCDCoCDCoH0sPGJyPg0KJmd0OyArwqAgwqAgwqBJSU9fQ0hBTl9TT0ZUX1RJ
TUVTVEFNUCg8d2JyPklTTDI5NTAxX1RJTUVTVEFNUF9TQ0FOX0lOREVYKTx3YnI+LDxicj4NCiZn
dDsgK307PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArc3RhdGljIGludCBpc2wyOTUwMV9yZXNldF9y
ZWdpc3RlcnMoPHdicj5zdHJ1Y3QgaXNsMjk1MDFfcHJpdmF0ZSAqaXNsMjk1MDEpPGJyPg0KJmd0
OyArezxicj4NCiZndDsgK8KgIMKgIMKgaW50IHJldDs8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICvC
oCDCoCDCoHJldCA9IGkyY19zbWJ1c193cml0ZV9ieXRlX2RhdGEoPHdicj5pc2wyOTUwMS0mZ3Q7
Y2xpZW50LDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgSVNMMjk1MDFfQ09NTUFORF9SRUdJU1RFUiw8YnI+DQomZ3Q7ICvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoElT
TDI5NTAxX1JFU0VUX0FMTF9SRUdJU1RFUlMpOzxicj4NCiZndDsgK8KgIMKgIMKgaWYgKHJldCAm
bHQ7IDApIHs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoGRldl9lcnIoJmFtcDtpc2wy
OTUwMS0mZ3Q7Y2xpZW50LSZndDs8d2JyPmRldiw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCZxdW90O2Nhbm5vdCByZXNldCByZWdpc3RlcnMgJWRcbiZxdW90Oywg
cmV0KTs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiByZXQ7PGJyPg0KJmd0
OyArwqAgwqAgwqB9PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArwqAgwqAgwqByZXQgPSBpMmNfc21i
dXNfd3JpdGVfYnl0ZV9kYXRhKDx3YnI+aXNsMjk1MDEtJmd0O2NsaWVudCw8YnI+DQomZ3Q7ICvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoElT
TDI5NTAxX0NPTU1BTkRfUkVHSVNURVIsPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBJU0wyOTUwMV9SRVNFVF9JTlRfU00p
Ozxicj4NCiZndDsgK8KgIMKgIMKgaWYgKHJldCAmbHQ7IDApIHs8YnI+DQomZ3Q7ICvCoCDCoCDC
oCDCoCDCoCDCoCDCoGRldl9lcnIoJmFtcDtpc2wyOTUwMS0mZ3Q7Y2xpZW50LSZndDs8d2JyPmRl
diw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZxdW90O2Nhbm5v
dCByZXNldCBzdGF0ZSBtYWNoaW5lICVkXG4mcXVvdDssIHJldCk7PGJyPg0KJmd0OyArwqAgwqAg
wqAgwqAgwqAgwqAgwqByZXR1cm4gcmV0Ozxicj4NCjxicj4NCjwvZGl2PjwvZGl2PkFzIGJlbG93
Ljxicj4NCjxzcGFuIGNsYXNzPSIiPjxicj4NCiZndDsgK8KgIMKgIMKgfTxicj4NCiZndDsgKzxi
cj4NCiZndDsgK8KgIMKgIMKgcmV0dXJuIDA7PGJyPg0KJmd0OyArfTxicj4NCiZndDsgKzxicj4N
CiZndDsgK3N0YXRpYyBpbnQgaXNsMjk1MDFfYmVnaW5fYWNxdWlzaXRpb24oPHdicj5zdHJ1Y3Qg
aXNsMjk1MDFfcHJpdmF0ZSAqaXNsMjk1MDEpPGJyPg0KJmd0OyArezxicj4NCiZndDsgK8KgIMKg
IMKgaW50IHJldDs8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICvCoCDCoCDCoHJldCA9IGkyY19zbWJ1
c193cml0ZV9ieXRlX2RhdGEoPHdicj5pc2wyOTUwMS0mZ3Q7Y2xpZW50LDxicj4NCiZndDsgK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgSVNM
Mjk1MDFfQ09NTUFORF9SRUdJU1RFUiw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoElTTDI5NTAxX0VNVUxfU0FNUExFX1NU
QVJUXzx3YnI+UElOKTs8YnI+DQomZ3Q7ICvCoCDCoCDCoGlmIChyZXQgJmx0OyAwKSB7PGJyPg0K
Jmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBkZXZfZXJyKCZhbXA7aXNsMjk1MDEtJmd0O2NsaWVu
dC0mZ3Q7PHdicj5kZXYsPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAmcXVvdDtjYW5ub3QgYmVnaW4gYWNxdWlzaXRpb24gJWRcbiZxdW90OywgcmV0KTs8YnI+DQom
Z3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiByZXQ7PGJyPg0KPGJyPg0KPC9zcGFuPk5p
dHBpY2s6IElJUkMgaTJjX3NtYnVzX3dyaXRlX2J5dGVfZGF0YSBuZXZlciByZXR1cm5zIHBvc2l0
aXZlLCBzbzxicj4NCnJldCB3aWxsIGJlIDAgaWYgd2UgYXJlbiYjMzk7dCBpbiBoZXJlLjxicj4N
Cjxicj4NCkhlbmNlPGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgaWYgKHJldCAmbHQ7IDApPGJyPg0K
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZGV2X2VycigmYW1wO2lzbDI5NTAxLSZndDtjbGllbnQt
Jmd0Ozx3YnI+ZGV2LDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZx
dW90Oy4uLiZxdW90Oyk7PGJyPg0KPGRpdj48ZGl2IGNsYXNzPSJoNSI+PGJyPg0KwqAgwqAgwqAg
wqAgcmV0dXJuIHJldDs8YnI+DQomZ3Q7ICvCoCDCoCDCoH08YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7
ICvCoCDCoCDCoHJldHVybiAwOzxicj4NCiZndDsgK308YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICtz
dGF0aWMgSUlPX0NPTlNUX0FUVFJfSU5UX1RJTUVfQVZBSUwoPHdicj5JU0wyOTUwMV9JTlRfVElN
RV9BVkFJTEFCTEUpOzxicj4NCiZndDsgK3N0YXRpYyBJSU9fQ09OU1RfQVRUUihvdXRfY3VycmVu
dF88d2JyPnNjYWxlX2F2YWlsYWJsZSw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoElTTDI5NTAxX0NVUlJFTlRfU0NBTEVfPHdicj5BVkFJTEFCTEUpOzxicj4NCiZndDsg
Kzxicj4NCiZndDsgK3N0YXRpYyBzdHJ1Y3QgYXR0cmlidXRlICppc2wyOTUwMV9hdHRyaWJ1dGVz
W10gPSB7PGJyPg0KJmd0OyArwqAgwqAgwqAmYW1wO2lpb19jb25zdF9hdHRyX2ludGVncmF0aW9u
Xzx3YnI+dGltZV9hdmFpbGFibGUuZGV2X2F0dHIuYXR0ciw8YnI+DQomZ3Q7ICvCoCDCoCDCoCZh
bXA7aWlvX2NvbnN0X2F0dHJfb3V0X2N1cnJlbnRfPHdicj5zY2FsZV9hdmFpbGFibGUuZGV2X2F0
dHIuYXR0ciw8YnI+DQomZ3Q7ICvCoCDCoCDCoE5VTEw8YnI+DQomZ3Q7ICt9Ozxicj4NCiZndDsg
Kzxicj4NCiZndDsgK3N0YXRpYyBjb25zdCBzdHJ1Y3QgYXR0cmlidXRlX2dyb3VwIGlzbDI5NTAx
X2F0dHJpYnV0ZV9ncm91cCA9IHs8YnI+DQomZ3Q7ICvCoCDCoCDCoC5hdHRycyA9IGlzbDI5NTAx
X2F0dHJpYnV0ZXMsPGJyPg0KJmd0OyArfTs8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICtzdGF0aWMg
Y29uc3QgaW50IGlzbDI5NTAxX2N1cnJlbnRfc2NhbGVfdGFibGVbXTx3YnI+WzJdID0gezxicj4N
CiZndDsgK8KgIMKgIMKgezAsIDM5MDB9LCB7MCwgNzgwMH0sIHswLCAxMTgwMH0sIHswLCAxNTcw
MH0sPGJyPg0KJmd0OyArwqAgwqAgwqB7MCwgMTk2MDB9LCB7MCwgMjM1MDB9LCB7MCwgMjc1MDB9
LCB7MCwgMzE0MDB9LDxicj4NCiZndDsgK8KgIMKgIMKgezAsIDM1MjAwfSwgezAsIDM5MjAwfSwg
ezAsIDQzMTAwfSwgezAsIDQ3MTAwfSw8YnI+DQomZ3Q7ICvCoCDCoCDCoHswLCA1MTAwMH0sIHsw
LCA1NDkwMH0sIHswLCA1ODgwMH0sPGJyPg0KJmd0OyArfTs8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7
ICtzdGF0aWMgY29uc3QgaW50IGlzbDI5NTAxX2ludF90aW1lW11bMl0gPSB7PGJyPg0KJmd0OyAr
wqAgwqAgwqB7MCwgNzB9LMKgIMKgIC8qIDAuMDcgbXMgKi88YnI+DQomZ3Q7ICvCoCDCoCDCoHsw
LCAxNDB9LMKgIMKgLyogMC4xNCBtcyAqLzxicj4NCiZndDsgK8KgIMKgIMKgezAsIDI4MH0swqAg
wqAvKiAwLjI4IG1zICovPGJyPg0KJmd0OyArwqAgwqAgwqB7MCwgNTcwfSzCoCDCoC8qIDAuNTcg
bXMgKi88YnI+DQomZ3Q7ICvCoCDCoCDCoHswLCAxMTQwfSzCoCAvKiAxLjE0IG1zICovPGJyPg0K
Jmd0OyArwqAgwqAgwqB7MCwgMjI4MH0swqAgLyogMi4yOCBtcyAqLzxicj4NCiZndDsgK8KgIMKg
IMKgezAsIDQ1NTB9LMKgIC8qIDQuNTUgbXMgKi88YnI+DQomZ3Q7ICvCoCDCoCDCoHswLCA5MTAw
fSzCoCAvKiA5LjExIG1zICovPGJyPg0KJmd0OyArwqAgwqAgwqB7MCwgMTgyMDB9LCAvKiAxOC4y
IG1zICovPGJyPg0KJmd0OyArwqAgwqAgwqB7MCwgMzY0MDB9LCAvKiAzNi40IG1zICovPGJyPg0K
Jmd0OyArwqAgwqAgwqB7MCwgNzI4MTB9LCAvKiA3Mi44MSBtcyAqLzxicj4NCiZndDsgK8KgIMKg
IMKgezAsIDE0NTYxMH0gLyogMTQ1LjI4IG1zICovPGJyPg0KJmd0OyArfTs8YnI+DQomZ3Q7ICs8
YnI+DQomZ3Q7ICtzdGF0aWMgaW50IGlzbDI5NTAxX2dldF9yYXcoc3RydWN0IGlzbDI5NTAxX3By
aXZhdGUgKmlzbDI5NTAxLDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgY29uc3Qgc3RydWN0IGlpb19jaGFuX3NwZWMgKmNoYW4sPGJyPg0KJmd0OyArwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpbnQgKnJhdyk8YnI+DQomZ3Q7ICt7
PGJyPg0KJmd0OyArwqAgwqAgwqBpbnQgcmV0Ozxicj4NCiZndDsgKzxicj4NCiZndDsgK8KgIMKg
IMKgc3dpdGNoIChjaGFuLSZndDt0eXBlKSB7PGJyPg0KJmd0OyArwqAgwqAgwqBjYXNlIElJT19Q
Uk9YSU1JVFk6PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqByZXQgPSBpc2wyOTUwMV9y
ZWdpc3Rlcl9yZWFkKDx3YnI+aXNsMjk1MDEsIFJFR19ESVNUQU5DRSwgcmF3KTs8YnI+DQomZ3Q7
ICvCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChyZXQgJmx0OyAwKTxicj4NCiZndDsgK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIHJldDs8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7
ICvCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBJSU9fVkFMX0lOVDs8YnI+DQomZ3Q7ICvCoCDC
oCDCoGNhc2UgSUlPX0lOVEVOU0lUWTo8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoHN3
aXRjaCAoY2hhbi0mZ3Q7Y2hhbm5lbDIpIHs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDC
oGNhc2UgSUlPX05PX01PRDo8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgSUlP
X01PRF9JOjxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgY2FzZSBJSU9fTU9EX1E6PGJy
Pg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvKiBUT0RPOiBpbXBsZW1l
bnQgZmxvYXQgcmVhZCAqLzxicj4NCjwvZGl2PjwvZGl2PkFub3RoZXIgYmxvY2sgd2UgbmVlZCB0
byBkcm9wIGZvciBub3cuPGJyPg0KPGRpdj48ZGl2IGNsYXNzPSJoNSI+Jmd0OyArwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gLUVJTlZBTDs8YnI+DQomZ3Q7ICvCoCDCoCDC
oCDCoCDCoCDCoCDCoGNhc2UgSUlPX01PRF9MSUdIVF9DTEVBUjo8YnI+DQomZ3Q7ICvCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldCA9IGlzbDI5NTAxX3JlZ2lzdGVyX3JlYWQoPHdi
cj5pc2wyOTUwMSw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBSRUdfQU1CSUVOVF9MSUdI
VCw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByYXcpOzxicj4NCiZndDsgK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHJldCAmbHQ7IDApPGJyPg0KJmd0OyArwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gcmV0Ozxicj4NCiZn
dDsgKzxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIElJ
T19WQUxfSU5UOzxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgZGVmYXVsdDo8YnI+DQom
Z3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiAtRUlOVkFMOzxicj4N
CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCiZndDsgK8KgIMKgIMKgY2FzZSBJSU9f
UEhBU0U6PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqByZXQgPSBpc2wyOTUwMV9yZWdp
c3Rlcl9yZWFkKDx3YnI+aXNsMjk1MDEsIFJFR19QSEFTRSwgcmF3KTs8YnI+DQomZ3Q7ICvCoCDC
oCDCoCDCoCDCoCDCoCDCoGlmIChyZXQgJmx0OyAwKTxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIHJldDs8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICvCoCDC
oCDCoCDCoCDCoCDCoCDCoHJldHVybiBJSU9fVkFMX0lOVDs8YnI+DQomZ3Q7ICvCoCDCoCDCoGNh
c2UgSUlPX0NVUlJFTlQ6PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqByZXQgPSBpc2wy
OTUwMV9yZWdpc3Rlcl9yZWFkKDx3YnI+aXNsMjk1MDEsIFJFR19FTUlUVEVSX0RBQywgcmF3KTs8
YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChyZXQgJmx0OyAwKTxicj4NCiZndDsg
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIHJldDs8YnI+DQomZ3Q7ICs8
YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBJSU9fVkFMX0lOVDs8YnI+DQom
Z3Q7ICvCoCDCoCDCoGNhc2UgSUlPX1RFTVA6PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAg
wqByZXQgPSBpc2wyOTUwMV9yZWdpc3Rlcl9yZWFkKDx3YnI+aXNsMjk1MDEsIFJFR19URU1QRVJB
VFVSRSwgcmF3KTs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChyZXQgJmx0OyAw
KTxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIHJldDs8
YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBJSU9fVkFM
X0lOVDs8YnI+DQomZ3Q7ICvCoCDCoCDCoGRlZmF1bHQ6PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAg
wqAgwqAgwqByZXR1cm4gLUVJTlZBTDs8YnI+DQomZ3Q7ICvCoCDCoCDCoH08YnI+DQomZ3Q7ICt9
PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArc3RhdGljIGludCBpc2wyOTUwMV9nZXRfc2NhbGUoc3Ry
dWN0IGlzbDI5NTAxX3ByaXZhdGUgKmlzbDI5NTAxLDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY29uc3Qgc3RydWN0IGlpb19jaGFuX3NwZWMgKmNo
YW4sPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBp
bnQgKnZhbCwgaW50ICp2YWwyKTxicj4NCiZndDsgK3s8YnI+DQomZ3Q7ICvCoCDCoCDCoGludCBy
ZXQ7PGJyPg0KJmd0OyArwqAgwqAgwqB1MzIgY3VycmVudF9zY2FsZTs8YnI+DQomZ3Q7ICs8YnI+
DQomZ3Q7ICvCoCDCoCDCoHN3aXRjaCAoY2hhbi0mZ3Q7dHlwZSkgezxicj4NCiZndDsgK8KgIMKg
IMKgY2FzZSBJSU9fUFJPWElNSVRZOjxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgLyog
ZGlzdGFuY2UgPSByYXdfZGlzdGFuY2UgKiAzMy4zMSAvIDY1NTM2IChtKSAqLzxicj4NCiZndDsg
K8KgIMKgIMKgIMKgIMKgIMKgIMKgKnZhbCA9IDMzMzE7PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAg
wqAgwqAgwqAqdmFsMiA9IDY1NTM2MDA7PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArwqAgwqAgwqAg
wqAgwqAgwqAgwqByZXR1cm4gSUlPX1ZBTF9GUkFDVElPTkFMOzxicj4NCiZndDsgK8KgIMKgIMKg
Y2FzZSBJSU9fUEhBU0U6PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAvKiBwaGFzZSA9
IHJhd19waGFzZSAqIDJwaSAvIDY1NTM2IChyYWQpICovPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAg
wqAgwqAgwqAqdmFsID0gMDs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCp2YWwyID0g
OTU4NzQ7PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4g
SUlPX1ZBTF9JTlRfUExVU19OQU5POzxicj4NCiZndDsgK8KgIMKgIMKgY2FzZSBJSU9fSU5URU5T
SVRZOjxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGNoYW4tJmd0O2NoYW5uZWwy
ICE9IElJT19NT0RfTElHSFRfQ0xFQVIpPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqByZXR1cm4gLUVJTlZBTDs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDC
oC8qIGxpZ2h0ID0gcmF3X2xpZ2h0ICogMzUgLyAxMDAwMCAobUEpICovPGJyPg0KJmd0OyArwqAg
wqAgwqAgwqAgwqAgwqAgwqAqdmFsID0gMzU7PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAg
wqAqdmFsMiA9IDEwMDAwOzxicj4NCiZndDsgKzxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKg
IMKgcmV0dXJuIElJT19WQUxfRlJBQ1RJT05BTDs8YnI+DQomZ3Q7ICvCoCDCoCDCoGNhc2UgSUlP
X0NVUlJFTlQ6PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqByZXQgPSBpc2wyOTUwMV9y
ZWdpc3Rlcl9yZWFkKDx3YnI+aXNsMjk1MDEsPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUkVHX0RSSVZFUl9S
QU5HRSw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmYW1wO2N1cnJlbnRfc2NhbGUpOzxicj4NCiZndDsgK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgaWYgKHJldCAmbHQ7IDApPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gcmV0Ozxicj4NCiZndDsgKzxicj4NCiZndDsgK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgaWYgKGN1cnJlbnRfc2NhbGUgJmd0OyBBUlJBWV9TSVpFKGlzbDI5
NTAxX2N1cnJlbnRfPHdicj5zY2FsZV90YWJsZSkpPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gLUVJTlZBTDs8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICvC
oCDCoCDCoCDCoCDCoCDCoCDCoGlmICghY3VycmVudF9zY2FsZSkgezxicj4NCiZndDsgK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKnZhbCA9IDA7PGJyPg0KJmd0OyArwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAqdmFsMiA9IDA7PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gSUlPX1ZBTF9JTlQ7PGJyPg0KJmd0OyArwqAgwqAg
wqAgwqAgwqAgwqAgwqB9PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAg
wqAqdmFsID0gaXNsMjk1MDFfY3VycmVudF9zY2FsZV90YWJsZVs8d2JyPmN1cnJlbnRfc2NhbGUg
LSAxXVswXTs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCp2YWwyID0gaXNsMjk1MDFf
Y3VycmVudF9zY2FsZV90YWJsZVs8d2JyPmN1cnJlbnRfc2NhbGUgLSAxXVsxXTs8YnI+DQomZ3Q7
ICs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBJSU9fVkFMX0lOVF9QTFVT
X01JQ1JPOzxicj4NCiZndDsgK8KgIMKgIMKgY2FzZSBJSU9fVEVNUDo8YnI+DQomZ3Q7ICvCoCDC
oCDCoCDCoCDCoCDCoCDCoC8qIHRlbXBlcmF0dXJlID0gcmF3X3RlbXBlcmF0dXJlICogMTI1IC8g
MTAwMDAwIChtaWxsaSDCsEMpICovPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAqdmFs
ID0gMTI1Ozxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgKnZhbDIgPSAxMDAwMDA7PGJy
Pg0KJmd0OyArPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gSUlPX1ZBTF9G
UkFDVElPTkFMOzxicj4NCiZndDsgK8KgIMKgIMKgZGVmYXVsdDo8YnI+DQomZ3Q7ICvCoCDCoCDC
oCDCoCDCoCDCoCDCoHJldHVybiAtRUlOVkFMOzxicj4NCiZndDsgK8KgIMKgIMKgfTxicj4NCiZn
dDsgK308YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICtzdGF0aWMgaW50IGlzbDI5NTAxX2dldF9jYWxp
YmJpYXMoc3RydWN0IGlzbDI5NTAxX3ByaXZhdGUgKmlzbDI5NTAxLDxicj4NCiZndDsgK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY29uc3Qgc3RydWN0IGlp
b19jaGFuX3NwZWMgKmNoYW4sPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBpbnQgKmJpYXMpPGJyPg0KJmd0OyArezxicj4NCiZndDsgK8Kg
IMKgIMKgc3dpdGNoIChjaGFuLSZndDt0eXBlKSB7PGJyPg0KJmd0OyArwqAgwqAgwqBjYXNlIElJ
T19QUk9YSU1JVFk6PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gaXNsMjk1
MDFfcmVnaXN0ZXJfcmVhZCg8d2JyPmlzbDI5NTAxLDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgUkVHX0RJ
U1RBTkNFX0JJQVMsPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBiaWFzKTs8YnI+DQomZ3Q7ICvCoCDCoCDC
oGNhc2UgSUlPX0lOVEVOU0lUWTo8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoHN3aXRj
aCAoY2hhbi0mZ3Q7Y2hhbm5lbDIpIHs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoGNh
c2UgSUlPX05PX01PRDo8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgSUlPX01P
RF9JOjxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgY2FzZSBJSU9fTU9EX1E6PGJyPg0K
Jmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvKiBUT0RPOiBJbXBsZW1lbnQg
ZmxvYXQgcmVhZCAqLzxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
cmV0dXJuIC1FSU5WQUw7PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBkZWZhdWx0Ojxi
cj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIC1FSU5WQUw7
PGJyPg0KPGJyPg0KPC9kaXY+PC9kaXY+QXMgYmVsb3csIHRoaXMgbmVlZHMgdG8gZ28gZm9yIG5v
dy4gPGJyPg0KPGRpdj48ZGl2IGNsYXNzPSJoNSI+PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAg
wqAgwqB9PGJyPg0KJmd0OyArwqAgwqAgwqBjYXNlIElJT19URU1QOjxicj4NCiZndDsgK8KgIMKg
IMKgIMKgIMKgIMKgIMKgcmV0dXJuIGlzbDI5NTAxX3JlZ2lzdGVyX3JlYWQoPHdicj5pc2wyOTUw
MSw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoFJFR19URU1QRVJBVFVSRV9CSUFTLDxicj4NCiZndDsgK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgYmlhcyk7PGJyPg0KJmd0OyArwqAgwqAgwqBkZWZhdWx0Ojxicj4NCiZndDsgK8KgIMKg
IMKgIMKgIMKgIMKgIMKgcmV0dXJuIC1FSU5WQUw7PGJyPg0KJmd0OyArwqAgwqAgwqB9PGJyPg0K
Jmd0OyArfTxicj4NCiZndDsgKzxicj4NCiZndDsgK3N0YXRpYyBpbnQgaXNsMjk1MDFfZ2V0X2lu
dHRpbWUoc3RydWN0IGlzbDI5NTAxX3ByaXZhdGUgKmlzbDI5NTAxLDxicj4NCiZndDsgK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaW50ICp2YWwsIGludCAqdmFs
Mik8YnI+DQomZ3Q7ICt7PGJyPg0KJmd0OyArwqAgwqAgwqBpbnQgcmV0Ozxicj4NCiZndDsgK8Kg
IMKgIMKgdTMyIGludHRpbWU7PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArwqAgwqAgwqByZXQgPSBp
c2wyOTUwMV9yZWdpc3Rlcl9yZWFkKDx3YnI+aXNsMjk1MDEsIFJFR19JTlRfVElNRSwgJmFtcDtp
bnR0aW1lKTs8YnI+DQomZ3Q7ICvCoCDCoCDCoGlmIChyZXQgJmx0OyAwKTxicj4NCiZndDsgK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIHJldDs8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICvCoCDC
oCDCoGlmIChpbnR0aW1lICZndDs9IEFSUkFZX1NJWkUoaXNsMjk1MDFfaW50X3RpbWUpKTxicj4N
CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIC1FSU5WQUw7PGJyPg0KJmd0OyArPGJy
Pg0KJmd0OyArwqAgwqAgwqAqdmFsID0gaXNsMjk1MDFfaW50X3RpbWVbaW50dGltZV1bMF07PGJy
Pg0KJmd0OyArwqAgwqAgwqAqdmFsMiA9IGlzbDI5NTAxX2ludF90aW1lW2ludHRpbWVdWzFdOzxi
cj4NCiZndDsgKzxicj4NCiZndDsgK8KgIMKgIMKgcmV0dXJuIElJT19WQUxfSU5UX1BMVVNfTUlD
Uk87PGJyPg0KJmd0OyArfTxicj4NCiZndDsgKzxicj4NCiZndDsgK3N0YXRpYyBpbnQgaXNsMjk1
MDFfZ2V0X2ZyZXEoc3RydWN0IGlzbDI5NTAxX3ByaXZhdGUgKmlzbDI5NTAxLDxicj4NCiZndDsg
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGludCAqdmFsLCBpbnQgKnZh
bDIpPGJyPg0KJmd0OyArezxicj4NCiZndDsgK8KgIMKgIMKgaW50IHJldDs8YnI+DQomZ3Q7ICvC
oCDCoCDCoGludCBzYW1wbGVfdGltZTs8YnI+DQomZ3Q7ICvCoCDCoCDCoHVuc2lnbmVkIGxvbmcg
bG9uZyBmcmVxOzxicj4NCiZndDsgKzxicj4NCiZndDsgK8KgIMKgIMKgcmV0ID0gaXNsMjk1MDFf
cmVnaXN0ZXJfcmVhZCg8d2JyPmlzbDI5NTAxLCBSRUdfU0FNUExFX1RJTUUsICZhbXA7c2FtcGxl
X3RpbWUpOzxicj4NCiZndDsgK8KgIMKgIMKgaWYgKHJldCAmbHQ7IDApPGJyPg0KJmd0OyArwqAg
wqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gcmV0Ozxicj4NCiZndDsgKzxicj4NCiZndDsgK8KgIMKg
IMKgLyogZnJlcSA9IDEgLyAoMC4wMDA0NTAgKiAoc2FtcGxlX3RpbWUgKyAxKSAqIDEwXi02KSAq
Lzxicj4NCiZndDsgK8KgIMKgIMKgZnJlcSA9IDEwMDAwMDBVTEwgKiAxMDAwMDAwVUxMIC8gKDQ1
MFVMTCAqIChzYW1wbGVfdGltZSArIDFVTEwpKTs8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICvCoCDC
oCDCoCp2YWwgPSBmcmVxIC8gMTAwMDAwMDs8YnI+DQomZ3Q7ICvCoCDCoCDCoCp2YWwyID0gZnJl
cSAlIDEwMDAwMDA7PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArwqAgwqAgwqByZXR1cm4gSUlPX1ZB
TF9JTlRfUExVU19NSUNSTzs8YnI+DQomZ3Q7ICt9PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArc3Rh
dGljIGludCBpc2wyOTUwMV9yZWFkX3JhdyhzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2LDxicj4N
CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN0cnVjdCBpaW9f
Y2hhbl9zcGVjIGNvbnN0ICpjaGFuLCBpbnQgKnZhbCw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpbnQgKnZhbDIsIGxvbmcgbWFzayk8YnI+DQomZ3Q7
ICt7PGJyPg0KJmd0OyArwqAgwqAgwqBzdHJ1Y3QgaXNsMjk1MDFfcHJpdmF0ZSAqaXNsMjk1MDEg
PSBpaW9fcHJpdihpbmRpb19kZXYpOzxicj4NCiZndDsgKzxicj4NCiZndDsgK8KgIMKgIMKgc3dp
dGNoIChtYXNrKSB7PGJyPg0KJmd0OyArwqAgwqAgwqBjYXNlIElJT19DSEFOX0lORk9fUkFXOjxi
cj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIGlzbDI5NTAxX2dldF9yYXcoaXNs
Mjk1MDEsIGNoYW4sIHZhbCk7PGJyPg0KJmd0OyArwqAgwqAgwqBjYXNlIElJT19DSEFOX0lORk9f
U0NBTEU6PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gaXNsMjk1MDFfZ2V0
X3NjYWxlKGlzbDI5NTAxLCBjaGFuLCB2YWwsIHZhbDIpOzxicj4NCiZndDsgK8KgIMKgIMKgY2Fz
ZSBJSU9fQ0hBTl9JTkZPX0lOVF9USU1FOjxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKg
cmV0dXJuIGlzbDI5NTAxX2dldF9pbnR0aW1lKGlzbDI5NTAxLCB2YWwsIHZhbDIpOzxicj4NCiZn
dDsgK8KgIMKgIMKgY2FzZSBJSU9fQ0hBTl9JTkZPX1NBTVBfRlJFUTo8YnI+DQomZ3Q7ICvCoCDC
oCDCoCDCoCDCoCDCoCDCoHJldHVybiBpc2wyOTUwMV9nZXRfZnJlcShpc2wyOTUwMSwgdmFsLCB2
YWwyKTs8YnI+DQomZ3Q7ICvCoCDCoCDCoGNhc2UgSUlPX0NIQU5fSU5GT19DQUxJQkJJQVM6PGJy
Pg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gaXNsMjk1MDFfZ2V0X2NhbGliYmlh
cyg8d2JyPmlzbDI5NTAxLCBjaGFuLCB2YWwpOzxicj4NCiZndDsgK8KgIMKgIMKgZGVmYXVsdDo8
YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiAtRUlOVkFMOzxicj4NCiZndDsg
K8KgIMKgIMKgfTxicj4NCiZndDsgK308YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICtzdGF0aWMgaW50
IGlzbDI5NTAxX3NldF9yYXcoc3RydWN0IGlzbDI5NTAxX3ByaXZhdGUgKmlzbDI5NTAxLDxicj4N
CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY29uc3Qgc3RydWN0
IGlpb19jaGFuX3NwZWMgKmNoYW4sPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBpbnQgcmF3KTxicj4NCiZndDsgK3s8YnI+DQomZ3Q7ICvCoCDCoCDCoHN3
aXRjaCAoY2hhbi0mZ3Q7dHlwZSkgezxicj4NCiZndDsgK8KgIMKgIMKgY2FzZSBJSU9fQ1VSUkVO
VDo8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBpc2wyOTUwMV9yZWdpc3Rl
cl93cml0ZSg8d2JyPmlzbDI5NTAxLCBSRUdfRU1JVFRFUl9EQUMsIHJhdyk7PGJyPg0KJmd0OyAr
wqAgwqAgwqBkZWZhdWx0Ojxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIC1F
SU5WQUw7PGJyPg0KJmd0OyArwqAgwqAgwqB9PGJyPg0KJmd0OyArfTxicj4NCiZndDsgKzxicj4N
CiZndDsgK3N0YXRpYyBpbnQgaXNsMjk1MDFfc2V0X2ludHRpbWUoc3RydWN0IGlzbDI5NTAxX3By
aXZhdGUgKmlzbDI5NTAxLDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgaW50IHZhbCwgaW50IHZhbDIpPGJyPg0KJmd0OyArezxicj4NCiZndDsg
K8KgIMKgIMKgaW50IGk7PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArwqAgwqAgwqBmb3IgKGkgPSAw
OyBpICZsdDsgQVJSQVlfU0laRShpc2wyOTUwMV9pbnRfdGltZSk7IGkrKykgezxicj4NCiZndDsg
K8KgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGlzbDI5NTAxX2ludF90aW1lW2ldWzBdID09IHZhbCAm
YW1wOyZhbXA7PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpc2wyOTUwMV9p
bnRfdGltZVtpXVsxXSA9PSB2YWwyKSB7PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqByZXR1cm4gaXNsMjk1MDFfcmVnaXN0ZXJfd3JpdGUoPHdicj5pc2wyOTUwMSw8
YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBSRUdfSU5UX1RJTUUsPGJyPg0KJmd0OyAr
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgaSk7PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqB9
PGJyPg0KJmd0OyArwqAgwqAgwqB9PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArwqAgwqAgwqByZXR1
cm4gLUVJTlZBTDs8YnI+DQomZ3Q7ICt9PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArc3RhdGljIGlu
dCBpc2wyOTUwMV9zZXRfc2NhbGUoc3RydWN0IGlzbDI5NTAxX3ByaXZhdGUgKmlzbDI5NTAxLDxi
cj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY29uc3Qg
c3RydWN0IGlpb19jaGFuX3NwZWMgKmNoYW4sPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpbnQgdmFsLCBpbnQgdmFsMik8YnI+DQomZ3Q7ICt7PGJy
Pg0KJmd0OyArwqAgwqAgwqBpbnQgaTs8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICvCoCDCoCDCoGlm
IChjaGFuLSZndDt0eXBlICE9IElJT19DVVJSRU5UKTxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKg
IMKgIMKgcmV0dXJuIC1FSU5WQUw7PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArwqAgwqAgwqBmb3Ig
KGkgPSAwOyBpICZsdDsgQVJSQVlfU0laRShpc2wyOTUwMV9jdXJyZW50Xzx3YnI+c2NhbGVfdGFi
bGUpOyBpKyspIHs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChpc2wyOTUwMV9j
dXJyZW50X3NjYWxlX3RhYmxlWzx3YnI+aV1bMF0gPT0gdmFsICZhbXA7JmFtcDs8YnI+DQomZ3Q7
ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlzbDI5NTAxX2N1cnJlbnRfc2NhbGVfdGFibGVb
PHdicj5pXVsxXSA9PSB2YWwyKSB7PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqByZXR1cm4gaXNsMjk1MDFfcmVnaXN0ZXJfd3JpdGUoPHdicj5pc2wyOTUwMSw8YnI+
DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBSRUdfRFJJVkVSX1JBTkdFLDxicj4NCiZndDsg
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIGkgKyAxKTs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDC
oCDCoH08YnI+DQomZ3Q7ICvCoCDCoCDCoH08YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICvCoCDCoCDC
oHJldHVybiAtRUlOVkFMOzxicj4NCiZndDsgK308YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICtzdGF0
aWMgaW50IGlzbDI5NTAxX3NldF9jYWxpYmJpYXMoc3RydWN0IGlzbDI5NTAxX3ByaXZhdGUgKmlz
bDI5NTAxLDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgY29uc3Qgc3RydWN0IGlpb19jaGFuX3NwZWMgKmNoYW4sPGJyPg0KJmd0OyArwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpbnQgYmlhcyk8YnI+
DQomZ3Q7ICt7PGJyPg0KJmd0OyArwqAgwqAgwqBzd2l0Y2ggKGNoYW4tJmd0O3R5cGUpIHs8YnI+
DQomZ3Q7ICvCoCDCoCDCoGNhc2UgSUlPX1BST1hJTUlUWTo8YnI+DQomZ3Q7ICvCoCDCoCDCoCDC
oCDCoCDCoCDCoHJldHVybiBpc2wyOTUwMV9yZWdpc3Rlcl93cml0ZSg8d2JyPmlzbDI5NTAxLDxi
cj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgUkVHX0RJU1RBTkNFX0JJQVMsPGJyPg0KJmd0OyArwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBi
aWFzKTs8YnI+DQomZ3Q7ICvCoCDCoCDCoGNhc2UgSUlPX0lOVEVOU0lUWTo8YnI+DQo8YnI+DQo8
L2Rpdj48L2Rpdj5IbW0uIEkgYXBwcmVjaWF0ZSB3aHkgeW91IGhhdmUgbGVmdCB0aGlzIGhlcmUg
KHNvIHdlIGRvbiYjMzk7dDxicj4NCmZvcmdldCBhYm91dCBpdCkgYnV0IGl0JiMzOTtzIGdvaW5n
IHRvIHJlc3VsdCBpbiB1cyBwcmVzZW50aW5nPGJyPg0Kc29tZSByZWFsbHkgb2RkIEFCSS4gSSYj
Mzk7ZCByYXRoZXIgdGFrZSBpdCBvdXQgZm9yIG5vdyBhbmQgYnJpbmc8YnI+DQppdCBiYWNrIGlu
IHdoZW4gd2UgaGF2ZSB0aGUgZmxvYXRpbmcgcG9pbnQgc3R1ZmYgYWdyZWVkIGFuZCBpbjxicj4N
CnBsYWNlLjxicj4NCjxkaXY+PGRpdiBjbGFzcz0iaDUiPjxicj4NCiZndDsgK8KgIMKgIMKgIMKg
IMKgIMKgIMKgc3dpdGNoIChjaGFuLSZndDtjaGFubmVsMikgezxicj4NCiZndDsgK8KgIMKgIMKg
IMKgIMKgIMKgIMKgY2FzZSBJSU9fTk9fTU9EOjxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKg
IMKgY2FzZSBJSU9fTU9EX0k6PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBjYXNlIElJ
T19NT0RfUTo8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC8qIFRP
RE86IEltcGxlbWVudCBmbG9hdCByZWFkICovPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqByZXR1cm4gLUVJTlZBTDs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDC
oCDCoGRlZmF1bHQ6PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBy
ZXR1cm4gLUVJTlZBTDs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQomZ3Q7
ICvCoCDCoCDCoGNhc2UgSUlPX1RFTVA6PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBy
ZXR1cm4gaXNsMjk1MDFfcmVnaXN0ZXJfd3JpdGUoPHdicj5pc2wyOTUwMSw8YnI+DQomZ3Q7ICvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBSRUdfVEVNUEVSQVRVUkVfQklBUyw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBiaWFzKTs8
YnI+DQomZ3Q7ICvCoCDCoCDCoGRlZmF1bHQ6PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAg
wqByZXR1cm4gLUVJTlZBTDs8YnI+DQomZ3Q7ICvCoCDCoCDCoH08YnI+DQomZ3Q7ICt9PGJyPg0K
Jmd0OyArPGJyPg0KJmd0OyArc3RhdGljIGludCBpc2wyOTUwMV9zZXRfZnJlcShzdHJ1Y3QgaXNs
Mjk1MDFfcHJpdmF0ZSAqaXNsMjk1MDEsPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgaW50IHZhbCwgaW50IHZhbDIpPGJyPg0KJmd0OyArezxicj4NCiZn
dDsgK8KgIMKgIMKgaW50IGZyZXE7PGJyPg0KJmd0OyArwqAgwqAgwqB1bnNpZ25lZCBsb25nIGxv
bmcgc2FtcGxlX3RpbWU7PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArwqAgwqAgwqAvKiBzYW1wbGVf
ZnJlcSA9IDEgLyAoMC4wMDA0NTAgKiAoc2FtcGxlX3RpbWUgKyAxKSAqIDEwXi02KSAqLzxicj4N
CiZndDsgK8KgIMKgIMKgZnJlcSA9IHZhbCAqIDEwMDAwMDAgKyB2YWwyICUgMTAwMDAwMDs8YnI+
DQomZ3Q7ICvCoCDCoCDCoHNhbXBsZV90aW1lID0gKDIyMjJVTEwgKiAxMDAwMDAwVUxMIC8gZnJl
cSkgLSAxVUxMOzxicj4NCiZndDsgKzxicj4NCiZndDsgK8KgIMKgIMKgaWYgKHNhbXBsZV90aW1l
ICZndDsgMjU1KTxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIC1FUkFOR0U7
PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArwqAgwqAgwqByZXR1cm4gaXNsMjk1MDFfcmVnaXN0ZXJf
d3JpdGUoPHdicj5pc2wyOTUwMSwgUkVHX1NBTVBMRV9USU1FLCBzYW1wbGVfdGltZSk7PGJyPg0K
Jmd0OyArfTxicj4NCiZndDsgKzxicj4NCiZndDsgK3N0YXRpYyBpbnQgaXNsMjk1MDFfd3JpdGVf
cmF3KHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYsPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdHJ1Y3QgaWlvX2NoYW5fc3BlYyBjb25zdCAqY2hh
biw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlu
dCB2YWwsIGludCB2YWwyLCBsb25nIG1hc2spPGJyPg0KJmd0OyArezxicj4NCiZndDsgK8KgIMKg
IMKgc3RydWN0IGlzbDI5NTAxX3ByaXZhdGUgKmlzbDI5NTAxID0gaWlvX3ByaXYoaW5kaW9fZGV2
KTs8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICvCoCDCoCDCoHN3aXRjaCAobWFzaykgezxicj4NCiZn
dDsgK8KgIMKgIMKgY2FzZSBJSU9fQ0hBTl9JTkZPX1JBVzo8YnI+DQomZ3Q7ICvCoCDCoCDCoCDC
oCDCoCDCoCDCoHJldHVybiBpc2wyOTUwMV9zZXRfcmF3KGlzbDI5NTAxLCBjaGFuLCB2YWwpOzxi
cj4NCiZndDsgK8KgIMKgIMKgY2FzZSBJSU9fQ0hBTl9JTkZPX0lOVF9USU1FOjxicj4NCiZndDsg
K8KgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIGlzbDI5NTAxX3NldF9pbnR0aW1lKGlzbDI5NTAx
LCB2YWwsIHZhbDIpOzxicj4NCiZndDsgK8KgIMKgIMKgY2FzZSBJSU9fQ0hBTl9JTkZPX1NBTVBf
RlJFUTo8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBpc2wyOTUwMV9zZXRf
ZnJlcShpc2wyOTUwMSwgdmFsLCB2YWwyKTs8YnI+DQomZ3Q7ICvCoCDCoCDCoGNhc2UgSUlPX0NI
QU5fSU5GT19TQ0FMRTo8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBpc2wy
OTUwMV9zZXRfc2NhbGUoaXNsMjk1MDEsIGNoYW4sIHZhbCwgdmFsMik7PGJyPg0KJmd0OyArwqAg
wqAgwqBjYXNlIElJT19DSEFOX0lORk9fQ0FMSUJCSUFTOjxicj4NCiZndDsgK8KgIMKgIMKgIMKg
IMKgIMKgIMKgcmV0dXJuIGlzbDI5NTAxX3NldF9jYWxpYmJpYXMoPHdicj5pc2wyOTUwMSwgY2hh
biwgdmFsKTs8YnI+DQomZ3Q7ICvCoCDCoCDCoGRlZmF1bHQ6PGJyPg0KJmd0OyArwqAgwqAgwqAg
wqAgwqAgwqAgwqByZXR1cm4gLUVJTlZBTDs8YnI+DQomZ3Q7ICvCoCDCoCDCoH08YnI+DQomZ3Q7
ICt9PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArc3RhdGljIGNvbnN0IHN0cnVjdCBpaW9faW5mbyBp
c2wyOTUwMV9pbmZvID0gezxicj4NCiZndDsgK8KgIMKgIMKgLnJlYWRfcmF3ID0gJmFtcDtpc2wy
OTUwMV9yZWFkX3Jhdyw8YnI+DQomZ3Q7ICvCoCDCoCDCoC53cml0ZV9yYXcgPSAmYW1wO2lzbDI5
NTAxX3dyaXRlX3Jhdyw8YnI+DQomZ3Q7ICvCoCDCoCDCoC5hdHRycyA9ICZhbXA7aXNsMjk1MDFf
YXR0cmlidXRlX2dyb3VwLDxicj4NCiZndDsgK307PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArc3Rh
dGljIGludCBpc2wyOTUwMV9pbml0X2NoaXAoc3RydWN0IGlzbDI5NTAxX3ByaXZhdGUgKmlzbDI5
NTAxKTxicj4NCiZndDsgK3s8YnI+DQomZ3Q7ICvCoCDCoCDCoGludCByZXQ7PGJyPg0KJmd0OyAr
PGJyPg0KJmd0OyArwqAgwqAgwqByZXQgPSBpMmNfc21idXNfcmVhZF9ieXRlX2RhdGEoPHdicj5p
c2wyOTUwMS0mZ3Q7Y2xpZW50LCBJU0wyOTUwMV9ERVZJQ0VfSUQpOzxicj4NCiZndDsgK8KgIMKg
IMKgaWYgKHJldCAmbHQ7IDApIHs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoGRldl9l
cnIoJmFtcDtpc2wyOTUwMS0mZ3Q7Y2xpZW50LSZndDs8d2JyPmRldiwgJnF1b3Q7RXJyb3IgcmVh
ZGluZyBkZXZpY2UgaWRcbiZxdW90Oyk7PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBy
ZXR1cm4gcmV0Ozxicj4NCiZndDsgK8KgIMKgIMKgfTxicj4NCiZndDsgKzxicj4NCiZndDsgK8Kg
IMKgIMKgaWYgKHJldCAhPSBJU0wyOTUwMV9JRCkgezxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKg
IMKgIMKgZGV2X2VycigmYW1wO2lzbDI5NTAxLSZndDtjbGllbnQtJmd0Ozx3YnI+ZGV2LDxicj4N
CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7V3JvbmcgY2hpcCBp
ZCwgZ290ICV4IGV4cGVjdGVkICV4XG4mcXVvdDssPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqByZXQsIElTTDI5NTAxX0RFVklDRV9JRCk7PGJyPg0KJmd0OyArwqAg
wqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gLUVOT0RFVjs8YnI+DQomZ3Q7ICvCoCDCoCDCoH08YnI+
DQomZ3Q7ICs8YnI+DQomZ3Q7ICvCoCDCoCDCoHJldCA9IGlzbDI5NTAxX3Jlc2V0X3JlZ2lzdGVy
cyg8d2JyPmlzbDI5NTAxKTs8YnI+DQomZ3Q7ICvCoCDCoCDCoGlmIChyZXQgJmx0OyAwKTxicj4N
CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIHJldDs8YnI+DQomZ3Q7ICs8YnI+DQom
Z3Q7ICvCoCDCoCDCoHJldHVybiBpc2wyOTUwMV9iZWdpbl9hY3F1aXNpdGlvbig8d2JyPmlzbDI5
NTAxKTs8YnI+DQomZ3Q7ICt9PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArc3RhdGljIGlycXJldHVy
bl90IGlzbDI5NTAxX3RyaWdnZXJfaGFuZGxlcihpbnQgaXJxLCB2b2lkICpwKTxicj4NCiZndDsg
K3s8YnI+DQomZ3Q7ICvCoCDCoCDCoHN0cnVjdCBpaW9fcG9sbF9mdW5jICpwZiA9IHA7PGJyPg0K
Jmd0OyArwqAgwqAgwqBzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2ID0gcGYtJmd0O2luZGlvX2Rl
djs8YnI+DQomZ3Q7ICvCoCDCoCDCoHN0cnVjdCBpc2wyOTUwMV9wcml2YXRlICppc2wyOTUwMSA9
IGlpb19wcml2KGluZGlvX2Rldik7PGJyPg0KJmd0OyArwqAgwqAgwqBjb25zdCB1bnNpZ25lZCBs
b25nICphY3RpdmVfbWFzayA9IGluZGlvX2Rldi0mZ3Q7YWN0aXZlX3NjYW5fbWFzazs8YnI+DQom
Z3Q7ICvCoCDCoCDCoHUzMiBidWZmZXJbNF0gPSB7fTsgLyogMXgxNi1iaXQgKyB0cyAqLzxicj4N
CiZndDsgKzxicj4NCiZndDsgK8KgIMKgIMKgaWYgKHRlc3RfYml0KElTTDI5NTAxX0RJU1RBTkNF
Xzx3YnI+U0NBTl9JTkRFWCwgYWN0aXZlX21hc2spKTxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKg
IMKgIMKgaXNsMjk1MDFfcmVnaXN0ZXJfcmVhZCg8d2JyPmlzbDI5NTAxLCBSRUdfRElTVEFOQ0Us
IGJ1ZmZlcik7PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArwqAgwqAgwqBpaW9fcHVzaF90b19idWZm
ZXJzX3dpdGhfPHdicj50aW1lc3RhbXAoaW5kaW9fZGV2LCBidWZmZXIsIHBmLSZndDt0aW1lc3Rh
bXApOzxicj4NCiZndDsgK8KgIMKgIMKgaWlvX3RyaWdnZXJfbm90aWZ5X2RvbmUoaW5kaW9fPHdi
cj5kZXYtJmd0O3RyaWcpOzxicj4NCiZndDsgKzxicj4NCiZndDsgK8KgIMKgIMKgcmV0dXJuIElS
UV9IQU5ETEVEOzxicj4NCiZndDsgK308YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICtzdGF0aWMgaW50
IGlzbDI5NTAxX3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQsPGJyPg0KJmd0OyArwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjb25zdCBzdHJ1Y3QgaTJjX2RldmljZV9p
ZCAqaWQpPGJyPg0KJmd0OyArezxicj4NCiZndDsgK8KgIMKgIMKgc3RydWN0IGlpb19kZXYgKmlu
ZGlvX2Rldjs8YnI+DQomZ3Q7ICvCoCDCoCDCoHN0cnVjdCBpc2wyOTUwMV9wcml2YXRlICppc2wy
OTUwMTs8YnI+DQomZ3Q7ICvCoCDCoCDCoGludCByZXQ7PGJyPg0KJmd0OyArPGJyPg0KJmd0OyAr
wqAgwqAgwqBpbmRpb19kZXYgPSBkZXZtX2lpb19kZXZpY2VfYWxsb2MoJmFtcDtjbGllbnQtPHdi
cj4mZ3Q7ZGV2LCBzaXplb2YoKmlzbDI5NTAxKSk7PGJyPg0KJmd0OyArwqAgwqAgwqBpZiAoIWlu
ZGlvX2Rldik8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiAtRU5PTUVNOzxi
cj4NCiZndDsgKzxicj4NCiZndDsgK8KgIMKgIMKgaXNsMjk1MDEgPSBpaW9fcHJpdihpbmRpb19k
ZXYpOzxicj4NCiZndDsgKzxicj4NCiZndDsgK8KgIMKgIMKgaTJjX3NldF9jbGllbnRkYXRhKGNs
aWVudCwgaW5kaW9fZGV2KTs8YnI+DQomZ3Q7ICvCoCDCoCDCoGlzbDI5NTAxLSZndDtjbGllbnQg
PSBjbGllbnQ7PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArwqAgwqAgwqBtdXRleF9pbml0KCZhbXA7
aXNsMjk1MDEtJmd0O2xvY2spOzxicj4NCiZndDsgKzxicj4NCiZndDsgK8KgIMKgIMKgcmV0ID0g
aXNsMjk1MDFfaW5pdF9jaGlwKGlzbDI5NTAxKTs8YnI+DQomZ3Q7ICvCoCDCoCDCoGlmIChyZXQg
Jmx0OyAwKTxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIHJldDs8YnI+DQom
Z3Q7ICs8YnI+DQomZ3Q7ICvCoCDCoCDCoGluZGlvX2Rldi0mZ3Q7bW9kZXMgPSBJTkRJT19ESVJF
Q1RfTU9ERTs8YnI+DQomZ3Q7ICvCoCDCoCDCoGluZGlvX2Rldi0mZ3Q7ZGV2LnBhcmVudCA9ICZh
bXA7Y2xpZW50LSZndDtkZXY7PGJyPg0KJmd0OyArwqAgwqAgwqBpbmRpb19kZXYtJmd0O2NoYW5u
ZWxzID0gaXNsMjk1MDFfY2hhbm5lbHM7PGJyPg0KJmd0OyArwqAgwqAgwqBpbmRpb19kZXYtJmd0
O251bV9jaGFubmVscyA9IEFSUkFZX1NJWkUoaXNsMjk1MDFfY2hhbm5lbHMpOzxicj4NCiZndDsg
K8KgIMKgIMKgaW5kaW9fZGV2LSZndDtuYW1lID0gY2xpZW50LSZndDtuYW1lOzxicj4NCiZndDsg
K8KgIMKgIMKgaW5kaW9fZGV2LSZndDtpbmZvID0gJmFtcDtpc2wyOTUwMV9pbmZvOzxicj4NCiZn
dDsgKzxicj4NCiZndDsgK8KgIMKgIMKgcmV0ID0gZGV2bV9paW9fdHJpZ2dlcmVkX2J1ZmZlcl88
d2JyPnNldHVwKCZhbXA7Y2xpZW50LSZndDtkZXYsIGluZGlvX2Rldiw8YnI+DQomZ3Q7ICvCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGlpb19wb2xsZnVuY19zdG9yZV90aW1lLDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaXNsMjk1MDFf
dHJpZ2dlcl9oYW5kbGVyLDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgTlVMTCk7PGJyPg0KJmd0OyArwqAg
wqAgwqBpZiAocmV0ICZsdDsgMCkgezxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgZGV2
X2VycigmYW1wO2NsaWVudC0mZ3Q7ZGV2LCAmcXVvdDt1bmFibGUgdG8gc2V0dXAgaWlvIHRyaWdn
ZXJlZCBidWZmZXJcbiZxdW90Oyk7PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1
cm4gcmV0Ozxicj4NCiZndDsgK8KgIMKgIMKgfTxicj4NCjxicj4NCjwvZGl2PjwvZGl2Pk5pdHBp
Y2ssIGEgYmxhbmsgbGluZSBoZXJlIHdvdWxkIGJlIGEgJiMzOTt0aW55JiMzOTsgYml0IG5pY2Vy
Ljxicj4NCjxkaXYgY2xhc3M9IkhPRW5aYiI+PGRpdiBjbGFzcz0iaDUiPjxicj4NCiZndDsgK8Kg
IMKgIMKgcmV0dXJuIGRldm1faWlvX2RldmljZV9yZWdpc3RlcigmYW1wOzx3YnI+Y2xpZW50LSZn
dDtkZXYsIGluZGlvX2Rldik7PGJyPg0KJmd0OyArfTxicj4NCiZndDsgKzxicj4NCiZndDsgK3N0
YXRpYyBjb25zdCBzdHJ1Y3QgaTJjX2RldmljZV9pZCBpc2wyOTUwMV9pZFtdID0gezxicj4NCiZn
dDsgK8KgIMKgIMKgeyZxdW90O2lzbDI5NTAxJnF1b3Q7LCAwfSw8YnI+DQomZ3Q7ICvCoCDCoCDC
oHt9PGJyPg0KJmd0OyArfTs8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICtNT0RVTEVfREVWSUNFX1RB
QkxFKGkyYywgaXNsMjk1MDFfaWQpOzxicj4NCiZndDsgKzxicj4NCiZndDsgKyNpZiBkZWZpbmVk
KENPTkZJR19PRik8YnI+DQomZ3Q7ICtzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBp
c2wyOTUwMV9pMmNfbWF0Y2hlc1tdID0gezxicj4NCiZndDsgK8KgIMKgIMKgeyAuY29tcGF0aWJs
ZSA9ICZxdW90O3JlbmVzYXMsaXNsMjk1MDEmcXVvdDsgfSw8YnI+DQomZ3Q7ICvCoCDCoCDCoHsg
fTxicj4NCiZndDsgK307PGJyPg0KJmd0OyArTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgaXNsMjk1
MDFfaTJjX21hdGNoZXMpOzxicj4NCiZndDsgKyNlbmRpZjxicj4NCiZndDsgKzxicj4NCiZndDsg
K3N0YXRpYyBzdHJ1Y3QgaTJjX2RyaXZlciBpc2wyOTUwMV9kcml2ZXIgPSB7PGJyPg0KJmd0OyAr
wqAgwqAgwqAuZHJpdmVyID0gezxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgLm5hbWXC
oCDCoD0gJnF1b3Q7aXNsMjk1MDEmcXVvdDssPGJyPg0KJmd0OyArwqAgwqAgwqB9LDxicj4NCiZn
dDsgK8KgIMKgIMKgLmlkX3RhYmxlwqAgwqAgwqAgwqA9IGlzbDI5NTAxX2lkLDxicj4NCiZndDsg
K8KgIMKgIMKgLnByb2JlwqAgwqAgwqAgwqAgwqAgPSBpc2wyOTUwMV9wcm9iZSw8YnI+DQomZ3Q7
ICt9Ozxicj4NCiZndDsgK21vZHVsZV9pMmNfZHJpdmVyKGlzbDI5NTAxXzx3YnI+ZHJpdmVyKTs8
YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICtNT0RVTEVfQVVUSE9SKCZxdW90O01hdGhpZXUgT3RoYWNl
aGUgJmx0OzxhIGhyZWY9Im1haWx0bzptLm90aGFjZWhlQGdtYWlsLmNvbSI+bS5vdGhhY2VoZUBn
bWFpbC5jb208L2E+Jmd0OyZxdW90Oyk7PGJyPg0KJmd0OyArTU9EVUxFX0RFU0NSSVBUSU9OKCZx
dW90O0lTTDI5NTAxIFRpbWUgb2YgRmxpZ2h0IHNlbnNvciBkcml2ZXImcXVvdDspOzxicj4NCiZn
dDsgK01PRFVMRV9MSUNFTlNFKCZxdW90O0dQTCB2MiZxdW90Oyk7PGJyPg0KPGJyPg0KPC9kaXY+
PC9kaXY+PC9ibG9ja3F1b3RlPjwvZGl2Pjxicj48L2Rpdj4NCg==
--00000000000026736b057171ac51--
