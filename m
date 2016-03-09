Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:9362 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753536AbcCINAr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 Mar 2016 08:00:47 -0500
From: "Breana, Tiberiu A" <tiberiu.a.breana@intel.com>
To: Denis CIOCCA <denis.ciocca@st.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Armando VISCONTI <armando.visconti@st.com>,
	Giuseppe BARBA <giuseppe.barba@st.com>,
	"Marco BIANCO" <marco.bianco@st.com>
Subject: RE: [PATCH] iio: accel: Add support for the h3lis331dl accelerometer
Date: Wed, 9 Mar 2016 12:59:29 +0000
Message-ID: <4586F61A4A291F4DA44D32824E7C0F4023567BE5@IRSMSX109.ger.corp.intel.com>
References: <1457525174-19532-1-git-send-email-tiberiu.a.breana@intel.com>
 <1E815185-257A-46BF-888D-A79226703E58@st.com>
In-Reply-To: <1E815185-257A-46BF-888D-A79226703E58@st.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Yes Denis, I've tested it with the changes and the output values look fine.
Thanks for your review.

Tiberiu

> -----Original Message-----
> From: Denis CIOCCA [mailto:denis.ciocca@st.com]
> Sent: Wednesday, March 9, 2016 2:47 PM
> To: Breana, Tiberiu A <tiberiu.a.breana@intel.com>
> Cc: linux-iio@vger.kernel.org; Armando VISCONTI
> <armando.visconti@st.com>; Giuseppe BARBA <giuseppe.barba@st.com>;
> Marco BIANCO <marco.bianco@st.com>
> Subject: Re: [PATCH] iio: accel: Add support for the h3lis331dl accelerometer
> 
> Hi Tiberiu,
> 
> Since at the beginning u found some issue, did u finally try with my
> comments and it works fine?
> 
> If so,
> 
> Reviewed-by: Denis Ciocca <denis.ciocca@st.com>
> Acked-by: Denis Ciocca <denis.ciocca@st.com>
> 
> 
> Thanks for ur job.
> 
> Denis
> 
> 
> 
> 
> > On Mar 9, 2016, at 20:06, Tiberiu Breana <tiberiu.a.breana@intel.com>
> wrote:
> >
> > This commit adds support for STMicroelectronics h3lis331dl high-g
> > accelerometer. The datasheet for this device can be found here:
> >
> > http://www.st.com/web/en/resource/technical/document/
> > datasheet/DM00053090.pdf
> >
> > Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
> > ---
> > .../devicetree/bindings/iio/st-sensors.txt         |  1 +
> > drivers/iio/accel/Kconfig                          |  2 +-
> > drivers/iio/accel/st_accel.h                       |  1 +
> > drivers/iio/accel/st_accel_core.c                  | 92 ++++++++++++++++++++++
> > drivers/iio/accel/st_accel_i2c.c                   |  4 +
> > 5 files changed, 99 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt
> > b/Documentation/devicetree/bindings/iio/st-sensors.txt
> > index d4b87cc..71b7bdf 100644
> > --- a/Documentation/devicetree/bindings/iio/st-sensors.txt
> > +++ b/Documentation/devicetree/bindings/iio/st-sensors.txt
> > @@ -37,6 +37,7 @@ Accelerometers:
> > - st,lsm330-accel
> > - st,lsm303agr-accel
> > - st,lis2dh12-accel
> > +- st,h3lis331dl-accel
> >
> > Gyroscopes:
> > - st,l3g4200d-gyro
> > diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> > index b0d3ecf..7636eec 100644
> > --- a/drivers/iio/accel/Kconfig
> > +++ b/drivers/iio/accel/Kconfig
> > @@ -64,7 +64,7 @@ config IIO_ST_ACCEL_3AXIS
> >    help
> >      Say yes here to build support for STMicroelectronics accelerometers:
> >      LSM303DLH, LSM303DLHC, LIS3DH, LSM330D, LSM330DL, LSM330DLC,
> > -      LIS331DLH, LSM303DL, LSM303DLM, LSM330, LIS2DH12.
> > +      LIS331DLH, LSM303DL, LSM303DLM, LSM330, LIS2DH12, H3LIS331DL.
> >
> >      This driver can also be built as a module. If so, these modules
> >      will be created:
> > diff --git a/drivers/iio/accel/st_accel.h
> > b/drivers/iio/accel/st_accel.h index 5d4a189..57f83a6 100644
> > --- a/drivers/iio/accel/st_accel.h
> > +++ b/drivers/iio/accel/st_accel.h
> > @@ -14,6 +14,7 @@
> > #include <linux/types.h>
> > #include <linux/iio/common/st_sensors.h>
> >
> > +#define H3LIS331DL_DRIVER_NAME        "h3lis331dl_accel"
> > #define LIS3LV02DL_ACCEL_DEV_NAME    "lis3lv02dl_accel"
> > #define LSM303DLHC_ACCEL_DEV_NAME    "lsm303dlhc_accel"
> > #define LIS3DH_ACCEL_DEV_NAME        "lis3dh"
> > diff --git a/drivers/iio/accel/st_accel_core.c
> > b/drivers/iio/accel/st_accel_core.c
> > index a03a141..fee32e3 100644
> > --- a/drivers/iio/accel/st_accel_core.c
> > +++ b/drivers/iio/accel/st_accel_core.c
> > @@ -39,6 +39,9 @@
> > #define ST_ACCEL_FS_AVL_6G            6
> > #define ST_ACCEL_FS_AVL_8G            8
> > #define ST_ACCEL_FS_AVL_16G            16
> > +#define ST_ACCEL_FS_AVL_100G            100
> > +#define ST_ACCEL_FS_AVL_200G            200
> > +#define ST_ACCEL_FS_AVL_400G            400
> >
> > /* CUSTOM VALUES FOR SENSOR 1 */
> > #define ST_ACCEL_1_WAI_EXP            0x33
> > @@ -181,6 +184,33 @@
> > #define ST_ACCEL_5_IG1_EN_MASK            0x08
> > #define ST_ACCEL_5_MULTIREAD_BIT        false
> >
> > +/* CUSTOM VALUES FOR SENSOR 6 */
> > +#define ST_ACCEL_6_WAI_EXP            0x32
> > +#define ST_ACCEL_6_ODR_ADDR            0x20
> > +#define ST_ACCEL_6_ODR_MASK            0x18
> > +#define ST_ACCEL_6_ODR_AVL_50HZ_VAL        0x00
> > +#define ST_ACCEL_6_ODR_AVL_100HZ_VAL        0x01
> > +#define ST_ACCEL_6_ODR_AVL_400HZ_VAL        0x02
> > +#define ST_ACCEL_6_ODR_AVL_1000HZ_VAL        0x03
> > +#define ST_ACCEL_6_PW_ADDR            0x20
> > +#define ST_ACCEL_6_PW_MASK            0x20
> > +#define ST_ACCEL_6_FS_ADDR            0x23
> > +#define ST_ACCEL_6_FS_MASK            0x30
> > +#define ST_ACCEL_6_FS_AVL_100_VAL        0x00
> > +#define ST_ACCEL_6_FS_AVL_200_VAL        0x01
> > +#define ST_ACCEL_6_FS_AVL_400_VAL        0x03
> > +#define ST_ACCEL_6_FS_AVL_100_GAIN        IIO_G_TO_M_S_2(49000)
> > +#define ST_ACCEL_6_FS_AVL_200_GAIN        IIO_G_TO_M_S_2(98000)
> > +#define ST_ACCEL_6_FS_AVL_400_GAIN        IIO_G_TO_M_S_2(195000)
> > +#define ST_ACCEL_6_BDU_ADDR            0x23
> > +#define ST_ACCEL_6_BDU_MASK            0x80
> > +#define ST_ACCEL_6_DRDY_IRQ_ADDR        0x22
> > +#define ST_ACCEL_6_DRDY_IRQ_INT1_MASK        0x02
> > +#define ST_ACCEL_6_DRDY_IRQ_INT2_MASK        0x10
> > +#define ST_ACCEL_6_IHL_IRQ_ADDR            0x22
> > +#define ST_ACCEL_6_IHL_IRQ_MASK            0x80
> > +#define ST_ACCEL_6_MULTIREAD_BIT        true
> > +
> > static const struct iio_chan_spec st_accel_8bit_channels[] = {
> >    ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
> >            BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE), @@
> > -557,6 +587,68 @@ static const struct st_sensor_settings
> st_accel_sensors_settings[] = {
> >        .multi_read_bit = ST_ACCEL_5_MULTIREAD_BIT,
> >        .bootime = 2, /* guess */
> >    },
> > +    {
> > +        .wai = ST_ACCEL_6_WAI_EXP,
> > +        .wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
> > +        .sensors_supported = {
> > +            [0] = H3LIS331DL_DRIVER_NAME,
> > +        },
> > +        .ch = (struct iio_chan_spec *)st_accel_12bit_channels,
> > +        .odr = {
> > +            .addr = ST_ACCEL_6_ODR_ADDR,
> > +            .mask = ST_ACCEL_6_ODR_MASK,
> > +            .odr_avl = {
> > +                { 50, ST_ACCEL_6_ODR_AVL_50HZ_VAL },
> > +                { 100, ST_ACCEL_6_ODR_AVL_100HZ_VAL, },
> > +                { 400, ST_ACCEL_6_ODR_AVL_400HZ_VAL, },
> > +                { 1000, ST_ACCEL_6_ODR_AVL_1000HZ_VAL, },
> > +            },
> > +        },
> > +        .pw = {
> > +            .addr = ST_ACCEL_6_PW_ADDR,
> > +            .mask = ST_ACCEL_6_PW_MASK,
> > +            .value_on = ST_SENSORS_DEFAULT_POWER_ON_VALUE,
> > +            .value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
> > +        },
> > +        .enable_axis = {
> > +            .addr = ST_SENSORS_DEFAULT_AXIS_ADDR,
> > +            .mask = ST_SENSORS_DEFAULT_AXIS_MASK,
> > +        },
> > +        .fs = {
> > +            .addr = ST_ACCEL_6_FS_ADDR,
> > +            .mask = ST_ACCEL_6_FS_MASK,
> > +            .fs_avl = {
> > +                [0] = {
> > +                    .num = ST_ACCEL_FS_AVL_100G,
> > +                    .value = ST_ACCEL_6_FS_AVL_100_VAL,
> > +                    .gain = ST_ACCEL_6_FS_AVL_100_GAIN,
> > +                },
> > +                [1] = {
> > +                    .num = ST_ACCEL_FS_AVL_200G,
> > +                    .value = ST_ACCEL_6_FS_AVL_200_VAL,
> > +                    .gain = ST_ACCEL_6_FS_AVL_200_GAIN,
> > +                },
> > +                [2] = {
> > +                    .num = ST_ACCEL_FS_AVL_400G,
> > +                    .value = ST_ACCEL_6_FS_AVL_400_VAL,
> > +                    .gain = ST_ACCEL_6_FS_AVL_400_GAIN,
> > +                },
> > +            },
> > +        },
> > +        .bdu = {
> > +            .addr = ST_ACCEL_6_BDU_ADDR,
> > +            .mask = ST_ACCEL_6_BDU_MASK,
> > +        },
> > +        .drdy_irq = {
> > +            .addr = ST_ACCEL_6_DRDY_IRQ_ADDR,
> > +            .mask_int1 = ST_ACCEL_6_DRDY_IRQ_INT1_MASK,
> > +            .mask_int2 = ST_ACCEL_6_DRDY_IRQ_INT2_MASK,
> > +            .addr_ihl = ST_ACCEL_6_IHL_IRQ_ADDR,
> > +            .mask_ihl = ST_ACCEL_6_IHL_IRQ_MASK,
> > +        },
> > +        .multi_read_bit = ST_ACCEL_6_MULTIREAD_BIT,
> > +        .bootime = 2,
> > +    },
> > };
> >
> > static int st_accel_read_raw(struct iio_dev *indio_dev, diff --git
> > a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
> > index 294a32f..7333ee9 100644
> > --- a/drivers/iio/accel/st_accel_i2c.c
> > +++ b/drivers/iio/accel/st_accel_i2c.c
> > @@ -76,6 +76,10 @@ static const struct of_device_id st_accel_of_match[]
> = {
> >        .compatible = "st,lis2dh12-accel",
> >        .data = LIS2DH12_ACCEL_DEV_NAME,
> >    },
> > +    {
> > +        .compatible = "st,h3lis331dl-accel",
> > +        .data = H3LIS331DL_DRIVER_NAME,
> > +    },
> >    {},
> > };
> > MODULE_DEVICE_TABLE(of, st_accel_of_match);
> > --
> > 1.9.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-iio"
> > in the body of a message to majordomo@vger.kernel.org More
> majordomo
> > info at  http://vger.kernel.org/majordomo-info.html
