Return-Path: <denis.ciocca@st.com>
Date: Mon, 18 Apr 2016 14:07:42 +0800
From: Denis Ciocca <denis.ciocca@st.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Crestez Dan Leonard <leonard.crestez@intel.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Giuseppe BARBA
	<giuseppe.barba@st.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter
 Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Daniel
 Baluta <daniel.baluta@intel.com>,
        Peter Rosin <peda@lysator.liu.se>, Wolfram
 Sang <wsa@the-dreams.de>
Subject: Re: [RFC] iio: st: Add lsm9ds0 support for gyro accel and magny
Message-ID: <20160418060742.GA2981@beicxl1122>
References: <2bcce23e64d53f542a9436b11509b107d63cb8dc.1460573498.git.leonard.crestez@intel.com>
 <57137732.40507@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <57137732.40507@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

Hi Leonard and Jonathan,

basically the patch can not work.
Current ST infrastructure needs to use one i2c slave per driver (accel or magn or gyro).
All sensors currently supported (including lsm303agr) have one i2c address per sensor type (for example in lsm303agr, accel has one i2c address, magn has another one).

What you are doing now it is not possible with current implementation. You can't have two drivers that manage one singol i2c device.
A possible solution is to use MDF device that let IIO drivers probe, the only driver that really manage i2c is MDF (check HID implementation), But I'm not sure it is ok because in combo device (two sensors sharing same i2c address) maybe you have some constrains you should verify (for example one odr is related to the other one, ...), you can't basically try to use those as totally separated.

I've started months ago to modify ST infrastructure in order to manage combo device but so far it is still work in progess...


BR,
Denis


On |17 Apr 16 @ 13:44|, Jonathan Cameron wrote:
> On 13/04/16 20:01, Crestez Dan Leonard wrote:
> > Device is an integrated gyro/accel/magn and temperature sensor. The
> > device has two i2c/spi interfaces: one for the gyro and one for the
> > accel/magn/temp sensor.
> >
> > Datasheet: http://www2.st.com/resource/en/datasheet/lsm9ds0.pdf
> >
> > The patch uses existing iio st_sensor infrastructure and just adds a
> > bunch of new device IDs and the new register mappings.
> >
> > Temperature support is not included.
> >
> > Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
> This looks fine to me.  Needs acks from Denis though.
> Also, clearly your questions need addressing.
> > ---
> >
> > I tested basic reading of values using software triggers and i2c and the values
> > seems plausible.
> >
> > I tested lsm9ds0-accel and lsm9ds0-magn separately because I don't know how to
> > instantiate two iio drivers for the same I2C device using devicetree. Can you
> > provide a sample of this or is this not currently supported?
> >
> > It seems to me that the LSM303AGR device has the same problem: it's an
> > accel+magn combo behind a single I2C address. How is that supposed to be
> > instantiated? Other supported combo devices seem to have multiple I2C
> > addresses.
> Excellent question. I'd not picked up on this before.
> It could be done with a 'dummy mux' I guess though that's messy.
> Guiseppe how are you doing it for the lsm303agr?
> 
> Cc'd Peter Rosin who has kindly walked into maintainer I2C mux
> support recently ;) An Wolfram for obvious reasons..
> To bring you two up to date, we have effectively two separate devices
> (very nearly) sat behind a single i2c address.  They have non overlapping
> register maps.
> We have a big overarching st_sensors driver framework which contains numerous
> examples of parts with just a magnetometer or just an accelerometer but in this
> case they have combined these two.  It would be nice to reuse the infrastructure
> without having to have a separate version for the two cases that exist so far.
> I suppose such a separate handling wouldn't be too terrible if we have to do it
> though - just a new device implementation of magnaccel for the st-sensors.
> >
> > It's also not clear how to properly deal with bits shared between the accel and
> > magn part like "block data update" or "interrupt polarity".
> 
> Perhaps just document that it's not allowed to have different choices for them
> in the bindings?
> Jonathan
> >
> >  .../devicetree/bindings/iio/st-sensors.txt         |   3 +
> >  drivers/iio/accel/st_accel.h                       |   1 +
> >  drivers/iio/accel/st_accel_core.c                  | 122 ++++++++++++++++++++
> >  drivers/iio/accel/st_accel_i2c.c                   |   5 +
> >  drivers/iio/accel/st_accel_spi.c                   |   1 +
> >  drivers/iio/gyro/st_gyro.h                         |   1 +
> >  drivers/iio/gyro/st_gyro_core.c                    |   1 +
> >  drivers/iio/gyro/st_gyro_i2c.c                     |   5 +
> >  drivers/iio/gyro/st_gyro_spi.c                     |   1 +
> >  drivers/iio/magnetometer/st_magn.h                 |   1 +
> >  drivers/iio/magnetometer/st_magn_core.c            | 123 +++++++++++++++++++++
> >  drivers/iio/magnetometer/st_magn_i2c.c             |   5 +
> >  drivers/iio/magnetometer/st_magn_spi.c             |   1 +
> >  13 files changed, 270 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt b/Documentation/devicetree/bindings/iio/st-sensors.txt
> > index 71b7bdf..65339ef 100644
> > --- a/Documentation/devicetree/bindings/iio/st-sensors.txt
> > +++ b/Documentation/devicetree/bindings/iio/st-sensors.txt
> > @@ -38,6 +38,7 @@ Accelerometers:
> >  - st,lsm303agr-accel
> >  - st,lis2dh12-accel
> >  - st,h3lis331dl-accel
> > +- st,lsm9ds0-accel
> >
> >  Gyroscopes:
> >  - st,l3g4200d-gyro
> > @@ -47,6 +48,7 @@ Gyroscopes:
> >  - st,l3gd20-gyro
> >  - st,l3g4is-gyro
> >  - st,lsm330-gyro
> > +- st,lsm9ds0-gyro
> >
> >  Magnetometers:
> >  - st,lsm303agr-magn
> > @@ -54,6 +56,7 @@ Magnetometers:
> >  - st,lsm303dlhc-magn
> >  - st,lsm303dlm-magn
> >  - st,lis3mdl-magn
> > +- st,lsm9ds0-magn
> >
> >  Pressure sensors:
> >  - st,lps001wp-press
> > diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
> > index 57f83a6..e90cd6a 100644
> > --- a/drivers/iio/accel/st_accel.h
> > +++ b/drivers/iio/accel/st_accel.h
> > @@ -29,6 +29,7 @@
> >  #define LSM330_ACCEL_DEV_NAME                "lsm330_accel"
> >  #define LSM303AGR_ACCEL_DEV_NAME     "lsm303agr_accel"
> >  #define LIS2DH12_ACCEL_DEV_NAME              "lis2dh12_accel"
> > +#define LSM9DS0_ACCEL_DEV_NAME               "lsm9ds0_accel"
> >
> >  /**
> >  * struct st_sensors_platform_data - default accel platform data
> > diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> > index fee32e3..0941b46 100644
> > --- a/drivers/iio/accel/st_accel_core.c
> > +++ b/drivers/iio/accel/st_accel_core.c
> > @@ -211,6 +211,50 @@
> >  #define ST_ACCEL_6_IHL_IRQ_MASK                      0x80
> >  #define ST_ACCEL_6_MULTIREAD_BIT             true
> >
> > +/* CUSTOM VALUES FOR SENSOR 7 */
> > +#define ST_ACCEL_7_WAI_EXP                   0x49
> > +#define ST_ACCEL_7_ODR_ADDR                  0x20
> > +#define ST_ACCEL_7_ODR_MASK                  0xf0
> > +#define ST_ACCEL_7_ODR_AVL_3HZ_VAL           0x01
> > +#define ST_ACCEL_7_ODR_AVL_6HZ_VAL           0x02
> > +#define ST_ACCEL_7_ODR_AVL_12HZ_VAL          0x03
> > +#define ST_ACCEL_7_ODR_AVL_25HZ_VAL          0x04
> > +#define ST_ACCEL_7_ODR_AVL_50HZ_VAL          0x05
> > +#define ST_ACCEL_7_ODR_AVL_100HZ_VAL         0x06
> > +#define ST_ACCEL_7_ODR_AVL_200HZ_VAL         0x07
> > +#define ST_ACCEL_7_ODR_AVL_400HZ_VAL         0x08
> > +#define ST_ACCEL_7_ODR_AVL_800HZ_VAL         0x09
> > +#define ST_ACCEL_7_ODR_AVL_1600HZ_VAL                0x0a
> > +#define ST_ACCEL_7_FS_ADDR                   0x21
> > +#define ST_ACCEL_7_FS_MASK                   0x38
> > +#define ST_ACCEL_7_FS_AVL_2_VAL                      0x00
> > +#define ST_ACCEL_7_FS_AVL_4_VAL                      0x01
> > +#define ST_ACCEL_7_FS_AVL_6_VAL                      0x02
> > +#define ST_ACCEL_7_FS_AVL_8_VAL                      0x03
> > +#define ST_ACCEL_7_FS_AVL_16_VAL             0x04
> > +#define ST_ACCEL_7_FS_AVL_2_GAIN             IIO_G_TO_M_S_2(61)
> > +#define ST_ACCEL_7_FS_AVL_4_GAIN             IIO_G_TO_M_S_2(122)
> > +#define ST_ACCEL_7_FS_AVL_6_GAIN             IIO_G_TO_M_S_2(183)
> > +#define ST_ACCEL_7_FS_AVL_8_GAIN             IIO_G_TO_M_S_2(244)
> > +#define ST_ACCEL_7_FS_AVL_16_GAIN            IIO_G_TO_M_S_2(732)
> > +#define ST_ACCEL_7_BDU_ADDR                  0x20
> > +#define ST_ACCEL_7_BDU_MASK                  0x08
> > +#define ST_ACCEL_7_DRDY_IRQ_ADDR             0x22
> > +#define ST_ACCEL_7_DRDY_IRQ_INT1_MASK                0x04
> > +/* INT2 is actually at another address. Not supported by driver */
> > +/*
> > +#define ST_ACCEL_7_DRDY_IRQ_INT2_ADDR                0x23
> > +#define ST_ACCEL_7_DRDY_IRQ_INT2_MASK                0x08
> > + */
> > +/* Common to magnetometer so not supported */
> > +/*
> > +#define ST_ACCEL_7_IHL_IRQ_ADDR                      0x12
> > +#define ST_ACCEL_7_IHL_IRQ_MASK                      0x80
> > + */
> > +#define ST_ACCEL_7_IG1_EN_ADDR                       0x22
> > +#define ST_ACCEL_7_IG1_EN_MASK                       0x20
> > +#define ST_ACCEL_7_MULTIREAD_BIT             true
> > +
> >  static const struct iio_chan_spec st_accel_8bit_channels[] = {
> >       ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
> >                       BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> > @@ -649,6 +693,84 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
> >               .multi_read_bit = ST_ACCEL_6_MULTIREAD_BIT,
> >               .bootime = 2,
> >       },
> > +     {
> > +             .wai = ST_ACCEL_7_WAI_EXP,
> > +             .wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
> > +             .sensors_supported = {
> > +                     [0] = LSM9DS0_ACCEL_DEV_NAME,
> > +             },
> > +             .ch = (struct iio_chan_spec *)st_accel_16bit_channels,
> > +             .odr = {
> > +                     .addr = ST_ACCEL_7_ODR_ADDR,
> > +                     .mask = ST_ACCEL_7_ODR_MASK,
> > +                     .odr_avl = {
> > +                             { 3, ST_ACCEL_7_ODR_AVL_3HZ_VAL },
> > +                             { 6, ST_ACCEL_7_ODR_AVL_6HZ_VAL, },
> > +                             { 12, ST_ACCEL_7_ODR_AVL_12HZ_VAL, },
> > +                             { 25, ST_ACCEL_7_ODR_AVL_25HZ_VAL, },
> > +                             { 50, ST_ACCEL_7_ODR_AVL_50HZ_VAL, },
> > +                             { 100, ST_ACCEL_7_ODR_AVL_100HZ_VAL, },
> > +                             { 200, ST_ACCEL_7_ODR_AVL_200HZ_VAL, },
> > +                             { 400, ST_ACCEL_7_ODR_AVL_400HZ_VAL, },
> > +                             { 800, ST_ACCEL_7_ODR_AVL_800HZ_VAL, },
> > +                             { 1600, ST_ACCEL_7_ODR_AVL_1600HZ_VAL, },
> > +                     },
> > +             },
> > +             .pw = {
> > +                     .addr = ST_ACCEL_7_ODR_ADDR,
> > +                     .mask = ST_ACCEL_7_ODR_MASK,
> > +                     .value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
> > +             },
> > +             .enable_axis = {
> > +                     .addr = ST_SENSORS_DEFAULT_AXIS_ADDR,
> > +                     .mask = ST_SENSORS_DEFAULT_AXIS_MASK,
> > +             },
> > +             .fs = {
> > +                     .addr = ST_ACCEL_7_FS_ADDR,
> > +                     .mask = ST_ACCEL_7_FS_MASK,
> > +                     .fs_avl = {
> > +                             [0] = {
> > +                                     .num = ST_ACCEL_FS_AVL_2G,
> > +                                     .value = ST_ACCEL_7_FS_AVL_2_VAL,
> > +                                     .gain = ST_ACCEL_7_FS_AVL_2_GAIN,
> > +                             },
> > +                             [1] = {
> > +                                     .num = ST_ACCEL_FS_AVL_4G,
> > +                                     .value = ST_ACCEL_7_FS_AVL_4_VAL,
> > +                                     .gain = ST_ACCEL_7_FS_AVL_4_GAIN,
> > +                             },
> > +                             [2] = {
> > +                                     .num = ST_ACCEL_FS_AVL_6G,
> > +                                     .value = ST_ACCEL_7_FS_AVL_6_VAL,
> > +                                     .gain = ST_ACCEL_7_FS_AVL_6_GAIN,
> > +                             },
> > +                             [3] = {
> > +                                     .num = ST_ACCEL_FS_AVL_8G,
> > +                                     .value = ST_ACCEL_7_FS_AVL_8_VAL,
> > +                                     .gain = ST_ACCEL_7_FS_AVL_8_GAIN,
> > +                             },
> > +                             [4] = {
> > +                                     .num = ST_ACCEL_FS_AVL_16G,
> > +                                     .value = ST_ACCEL_7_FS_AVL_16_VAL,
> > +                                     .gain = ST_ACCEL_7_FS_AVL_16_GAIN,
> > +                             },
> > +                     },
> > +             },
> > +             .bdu = {
> > +                     .addr = ST_ACCEL_7_BDU_ADDR,
> > +                     .mask = ST_ACCEL_7_BDU_MASK,
> > +             },
> > +             .drdy_irq = {
> > +                     .addr = ST_ACCEL_7_DRDY_IRQ_ADDR,
> > +                     .mask_int1 = ST_ACCEL_7_DRDY_IRQ_INT1_MASK,
> > +                     .ig1 = {
> > +                             .en_addr = ST_ACCEL_7_IG1_EN_ADDR,
> > +                             .en_mask = ST_ACCEL_7_IG1_EN_MASK,
> > +                     },
> > +             },
> > +             .multi_read_bit = ST_ACCEL_7_MULTIREAD_BIT,
> > +             .bootime = 2,
> > +     },
> >  };
> >
> >  static int st_accel_read_raw(struct iio_dev *indio_dev,
> > diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
> > index 7333ee9..7a2a3ab 100644
> > --- a/drivers/iio/accel/st_accel_i2c.c
> > +++ b/drivers/iio/accel/st_accel_i2c.c
> > @@ -80,6 +80,10 @@ static const struct of_device_id st_accel_of_match[] = {
> >               .compatible = "st,h3lis331dl-accel",
> >               .data = H3LIS331DL_DRIVER_NAME,
> >       },
> > +     {
> > +             .compatible = "st,lsm9ds0-accel",
> > +             .data = LSM9DS0_ACCEL_DEV_NAME,
> > +     },
> >       {},
> >  };
> >  MODULE_DEVICE_TABLE(of, st_accel_of_match);
> > @@ -130,6 +134,7 @@ static const struct i2c_device_id st_accel_id_table[] = {
> >       { LSM330_ACCEL_DEV_NAME },
> >       { LSM303AGR_ACCEL_DEV_NAME },
> >       { LIS2DH12_ACCEL_DEV_NAME },
> > +     { LSM9DS0_ACCEL_DEV_NAME },
> >       {},
> >  };
> >  MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
> > diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
> > index fcd5847..2fc32c92f 100644
> > --- a/drivers/iio/accel/st_accel_spi.c
> > +++ b/drivers/iio/accel/st_accel_spi.c
> > @@ -59,6 +59,7 @@ static const struct spi_device_id st_accel_id_table[] = {
> >       { LSM330_ACCEL_DEV_NAME },
> >       { LSM303AGR_ACCEL_DEV_NAME },
> >       { LIS2DH12_ACCEL_DEV_NAME },
> > +     { LSM9DS0_ACCEL_DEV_NAME },
> >       {},
> >  };
> >  MODULE_DEVICE_TABLE(spi, st_accel_id_table);
> > diff --git a/drivers/iio/gyro/st_gyro.h b/drivers/iio/gyro/st_gyro.h
> > index 5353d63..a5c5c4e 100644
> > --- a/drivers/iio/gyro/st_gyro.h
> > +++ b/drivers/iio/gyro/st_gyro.h
> > @@ -21,6 +21,7 @@
> >  #define L3GD20_GYRO_DEV_NAME         "l3gd20"
> >  #define L3G4IS_GYRO_DEV_NAME         "l3g4is_ui"
> >  #define LSM330_GYRO_DEV_NAME         "lsm330_gyro"
> > +#define LSM9DS0_GYRO_DEV_NAME                "lsm9ds0_gyro"
> >
> >  /**
> >   * struct st_sensors_platform_data - gyro platform data
> > diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
> > index 110f95b..9589ba9 100644
> > --- a/drivers/iio/gyro/st_gyro_core.c
> > +++ b/drivers/iio/gyro/st_gyro_core.c
> > @@ -203,6 +203,7 @@ static const struct st_sensor_settings st_gyro_sensors_settings[] = {
> >                       [2] = LSM330DLC_GYRO_DEV_NAME,
> >                       [3] = L3G4IS_GYRO_DEV_NAME,
> >                       [4] = LSM330_GYRO_DEV_NAME,
> > +                     [5] = LSM9DS0_GYRO_DEV_NAME,
> >               },
> >               .ch = (struct iio_chan_spec *)st_gyro_16bit_channels,
> >               .odr = {
> > diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
> > index 6848451..40056b8 100644
> > --- a/drivers/iio/gyro/st_gyro_i2c.c
> > +++ b/drivers/iio/gyro/st_gyro_i2c.c
> > @@ -48,6 +48,10 @@ static const struct of_device_id st_gyro_of_match[] = {
> >               .compatible = "st,lsm330-gyro",
> >               .data = LSM330_GYRO_DEV_NAME,
> >       },
> > +     {
> > +             .compatible = "st,lsm9ds0-gyro",
> > +             .data = LSM9DS0_GYRO_DEV_NAME,
> > +     },
> >       {},
> >  };
> >  MODULE_DEVICE_TABLE(of, st_gyro_of_match);
> > @@ -93,6 +97,7 @@ static const struct i2c_device_id st_gyro_id_table[] = {
> >       { L3GD20_GYRO_DEV_NAME },
> >       { L3G4IS_GYRO_DEV_NAME },
> >       { LSM330_GYRO_DEV_NAME },
> > +     { LSM9DS0_GYRO_DEV_NAME },
> >       {},
> >  };
> >  MODULE_DEVICE_TABLE(i2c, st_gyro_id_table);
> > diff --git a/drivers/iio/gyro/st_gyro_spi.c b/drivers/iio/gyro/st_gyro_spi.c
> > index d2b7a5f..fbf2fae 100644
> > --- a/drivers/iio/gyro/st_gyro_spi.c
> > +++ b/drivers/iio/gyro/st_gyro_spi.c
> > @@ -54,6 +54,7 @@ static const struct spi_device_id st_gyro_id_table[] = {
> >       { L3GD20_GYRO_DEV_NAME },
> >       { L3G4IS_GYRO_DEV_NAME },
> >       { LSM330_GYRO_DEV_NAME },
> > +     { LSM9DS0_GYRO_DEV_NAME },
> >       {},
> >  };
> >  MODULE_DEVICE_TABLE(spi, st_gyro_id_table);
> > diff --git a/drivers/iio/magnetometer/st_magn.h b/drivers/iio/magnetometer/st_magn.h
> > index 06a4d9c..2176064 100644
> > --- a/drivers/iio/magnetometer/st_magn.h
> > +++ b/drivers/iio/magnetometer/st_magn.h
> > @@ -19,6 +19,7 @@
> >  #define LSM303DLM_MAGN_DEV_NAME              "lsm303dlm_magn"
> >  #define LIS3MDL_MAGN_DEV_NAME                "lis3mdl"
> >  #define LSM303AGR_MAGN_DEV_NAME              "lsm303agr_magn"
> > +#define LSM9DS0_MAGN_DEV_NAME                "lsm9ds0_magn"
> >
> >  int st_magn_common_probe(struct iio_dev *indio_dev);
> >  void st_magn_common_remove(struct iio_dev *indio_dev);
> > diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
> > index 501f858..da3f29a 100644
> > --- a/drivers/iio/magnetometer/st_magn_core.c
> > +++ b/drivers/iio/magnetometer/st_magn_core.c
> > @@ -36,6 +36,7 @@
> >  /* FULLSCALE */
> >  #define ST_MAGN_FS_AVL_1300MG                        1300
> >  #define ST_MAGN_FS_AVL_1900MG                        1900
> > +#define ST_MAGN_FS_AVL_2000MG                        2000
> >  #define ST_MAGN_FS_AVL_2500MG                        2500
> >  #define ST_MAGN_FS_AVL_4000MG                        4000
> >  #define ST_MAGN_FS_AVL_4700MG                        4700
> > @@ -183,6 +184,50 @@
> >  #define ST_MAGN_3_OUT_Y_L_ADDR                       0x6a
> >  #define ST_MAGN_3_OUT_Z_L_ADDR                       0x6c
> >
> > +/* CUSTOM VALUES FOR SENSOR 4 */
> > +#define ST_MAGN_4_WAI_EXP                    0x49
> > +#define ST_MAGN_4_ODR_ADDR                   0x24
> > +#define ST_MAGN_4_ODR_MASK                   0x1c
> > +#define ST_MAGN_4_ODR_AVL_3HZ_VAL            0x00
> > +#define ST_MAGN_4_ODR_AVL_6HZ_VAL            0x01
> > +#define ST_MAGN_4_ODR_AVL_12HZ_VAL           0x02
> > +#define ST_MAGN_4_ODR_AVL_25HZ_VAL           0x03
> > +#define ST_MAGN_4_ODR_AVL_50HZ_VAL           0x04
> > +#define ST_MAGN_4_ODR_AVL_100HZ_VAL          0x05
> > +#define ST_MAGN_4_PW_ADDR                    0x26
> > +#define ST_MAGN_4_PW_MASK                    0x03
> > +#define ST_MAGN_4_PW_ON                              0x00
> > +#define ST_MAGN_4_PW_OFF                     0x03
> > +#define ST_MAGN_4_FS_ADDR                    0x25
> > +#define ST_MAGN_4_FS_MASK                    0x60
> > +#define ST_MAGN_4_FS_AVL_2000_VAL            0x00
> > +#define ST_MAGN_4_FS_AVL_4000_VAL            0x01
> > +#define ST_MAGN_4_FS_AVL_8000_VAL            0x02
> > +#define ST_MAGN_4_FS_AVL_12000_VAL           0x03
> > +#define ST_MAGN_4_FS_AVL_2000_GAIN           73
> > +#define ST_MAGN_4_FS_AVL_4000_GAIN           146
> > +#define ST_MAGN_4_FS_AVL_8000_GAIN           292
> > +#define ST_MAGN_4_FS_AVL_12000_GAIN          438
> > +/* Shared with accelerometer */
> > +#define ST_MAGN_4_BDU_ADDR                   0x20
> > +#define ST_MAGN_4_BDU_MASK                   0x08
> > +#define ST_MAGN_4_DRDY_IRQ_ADDR                      0x22
> > +#define ST_MAGN_4_DRDY_INT_MASK                      0x01
> > +/* INT2 is actually at another address. Not supported by driver */
> > +/*
> > +#define ST_MAGN_4_DRDY_IRQ_INT2_ADDR         0x23
> > +#define ST_MAGN_4_DRDY_IRQ_INT2_MASK         0x04
> > + */
> > +/* Common to accelerometer so not supported */
> > +/*
> > +#define ST_MAGN_4_IHL_IRQ_ADDR                       0x12
> > +#define ST_MAGN_4_IHL_IRQ_MASK                       0x80
> > + */
> > +#define ST_MAGN_4_MULTIREAD_BIT                      true
> > +#define ST_MAGN_4_OUT_X_L_ADDR                       0x08
> > +#define ST_MAGN_4_OUT_Y_L_ADDR                       0x0a
> > +#define ST_MAGN_4_OUT_Z_L_ADDR                       0x0c
> > +
> >  static const struct iio_chan_spec st_magn_16bit_channels[] = {
> >       ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
> >                       BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> > @@ -231,6 +276,22 @@ static const struct iio_chan_spec st_magn_3_16bit_channels[] = {
> >       IIO_CHAN_SOFT_TIMESTAMP(3)
> >  };
> >
> > +static const struct iio_chan_spec st_magn_4_16bit_channels[] = {
> > +     ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
> > +                     BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> > +                     ST_SENSORS_SCAN_X, 1, IIO_MOD_X, 's', IIO_LE, 16, 16,
> > +                     ST_MAGN_4_OUT_X_L_ADDR),
> > +     ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
> > +                     BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> > +                     ST_SENSORS_SCAN_Y, 1, IIO_MOD_Y, 's', IIO_LE, 16, 16,
> > +                     ST_MAGN_4_OUT_Y_L_ADDR),
> > +     ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
> > +                     BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> > +                     ST_SENSORS_SCAN_Z, 1, IIO_MOD_Z, 's', IIO_LE, 16, 16,
> > +                     ST_MAGN_4_OUT_Z_L_ADDR),
> > +     IIO_CHAN_SOFT_TIMESTAMP(3)
> > +};
> > +
> >  static const struct st_sensor_settings st_magn_sensors_settings[] = {
> >       {
> >               .wai = 0, /* This sensor has no valid WhoAmI report 0 */
> > @@ -488,6 +549,68 @@ static const struct st_sensor_settings st_magn_sensors_settings[] = {
> >               .multi_read_bit = ST_MAGN_3_MULTIREAD_BIT,
> >               .bootime = 2,
> >       },
> > +     {
> > +             .wai = ST_MAGN_4_WAI_EXP,
> > +             .wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
> > +             .sensors_supported = {
> > +                     [0] = LSM9DS0_MAGN_DEV_NAME,
> > +             },
> > +             .ch = (struct iio_chan_spec *)st_magn_4_16bit_channels,
> > +             .odr = {
> > +                     .addr = ST_MAGN_4_ODR_ADDR,
> > +                     .mask = ST_MAGN_4_ODR_MASK,
> > +                     .odr_avl = {
> > +                             { 3, ST_MAGN_4_ODR_AVL_3HZ_VAL, },
> > +                             { 6, ST_MAGN_4_ODR_AVL_6HZ_VAL, },
> > +                             { 12, ST_MAGN_4_ODR_AVL_12HZ_VAL, },
> > +                             { 25, ST_MAGN_4_ODR_AVL_25HZ_VAL, },
> > +                             { 50, ST_MAGN_4_ODR_AVL_50HZ_VAL, },
> > +                             { 100, ST_MAGN_4_ODR_AVL_100HZ_VAL, },
> > +                     },
> > +             },
> > +             .pw = {
> > +                     .addr = ST_MAGN_4_PW_ADDR,
> > +                     .mask = ST_MAGN_4_PW_MASK,
> > +                     .value_on = ST_MAGN_4_PW_ON,
> > +                     .value_off = ST_MAGN_4_PW_OFF,
> > +             },
> > +             .fs = {
> > +                     .addr = ST_MAGN_4_FS_ADDR,
> > +                     .mask = ST_MAGN_4_FS_MASK,
> > +                     .fs_avl = {
> > +                             [0] = {
> > +                                     .num = ST_MAGN_FS_AVL_2000MG,
> > +                                     .value = ST_MAGN_4_FS_AVL_2000_VAL,
> > +                                     .gain = ST_MAGN_4_FS_AVL_2000_GAIN,
> > +                             },
> > +                             [1] = {
> > +                                     .num = ST_MAGN_FS_AVL_4000MG,
> > +                                     .value = ST_MAGN_4_FS_AVL_4000_VAL,
> > +                                     .gain = ST_MAGN_4_FS_AVL_4000_GAIN,
> > +                             },
> > +                             [2] = {
> > +                                     .num = ST_MAGN_FS_AVL_8000MG,
> > +                                     .value = ST_MAGN_4_FS_AVL_8000_VAL,
> > +                                     .gain = ST_MAGN_4_FS_AVL_8000_GAIN,
> > +                             },
> > +                             [3] = {
> > +                                     .num = ST_MAGN_FS_AVL_12000MG,
> > +                                     .value = ST_MAGN_4_FS_AVL_12000_VAL,
> > +                                     .gain = ST_MAGN_4_FS_AVL_12000_GAIN,
> > +                             },
> > +                     },
> > +             },
> > +             .bdu = {
> > +                     .addr = ST_MAGN_4_BDU_ADDR,
> > +                     .mask = ST_MAGN_4_BDU_MASK,
> > +             },
> > +             .drdy_irq = {
> > +                     .addr = ST_MAGN_4_DRDY_IRQ_ADDR,
> > +                     .mask_int1 = ST_MAGN_4_DRDY_INT_MASK,
> > +             },
> > +             .multi_read_bit = ST_MAGN_4_MULTIREAD_BIT,
> > +             .bootime = 2,
> > +     },
> >  };
> >
> >  static int st_magn_read_raw(struct iio_dev *indio_dev,
> > diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
> > index 8aa37af..1c7c487 100644
> > --- a/drivers/iio/magnetometer/st_magn_i2c.c
> > +++ b/drivers/iio/magnetometer/st_magn_i2c.c
> > @@ -40,6 +40,10 @@ static const struct of_device_id st_magn_of_match[] = {
> >               .compatible = "st,lsm303agr-magn",
> >               .data = LSM303AGR_MAGN_DEV_NAME,
> >       },
> > +     {
> > +             .compatible = "st,lsm9ds0-magn",
> > +             .data = LSM9DS0_MAGN_DEV_NAME,
> > +     },
> >       {},
> >  };
> >  MODULE_DEVICE_TABLE(of, st_magn_of_match);
> > @@ -84,6 +88,7 @@ static const struct i2c_device_id st_magn_id_table[] = {
> >       { LSM303DLM_MAGN_DEV_NAME },
> >       { LIS3MDL_MAGN_DEV_NAME },
> >       { LSM303AGR_MAGN_DEV_NAME },
> > +     { LSM9DS0_MAGN_DEV_NAME },
> >       {},
> >  };
> >  MODULE_DEVICE_TABLE(i2c, st_magn_id_table);
> > diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
> > index 6325e7d..8c4e1d6 100644
> > --- a/drivers/iio/magnetometer/st_magn_spi.c
> > +++ b/drivers/iio/magnetometer/st_magn_spi.c
> > @@ -52,6 +52,7 @@ static const struct spi_device_id st_magn_id_table[] = {
> >       { LSM303DLM_MAGN_DEV_NAME },
> >       { LIS3MDL_MAGN_DEV_NAME },
> >       { LSM303AGR_MAGN_DEV_NAME },
> > +     { LSM9DS0_MAGN_DEV_NAME },
> >       {},
> >  };
> >  MODULE_DEVICE_TABLE(spi, st_magn_id_table);
> >
> 
