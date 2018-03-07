Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754333AbeCGVCv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 7 Mar 2018 16:02:51 -0500
Date: Wed, 7 Mar 2018 21:02:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: Himanshu Jha <himanshujha199640@gmail.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        daniel.baluta@gmail.com
Subject: Re: [PATCH v3 1/4] Staging: iio: adis16209: Remove and add some
 comments and group the definitions
Message-ID: <20180307210246.235456d9@archlinux>
In-Reply-To: <1520168824.8495.2.camel@gmail.com>
References: <cover.1520164945.git.shreeya.patel23498@gmail.com>
        <982742b1bb71d4d97c2f5edc6f95b85129d8667b.1520164945.git.shreeya.patel23498@gmail.com>
        <20180304125604.GA7613@himanshu-Vostro-3559>
        <1520168824.8495.2.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 04 Mar 2018 18:37:04 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> On Sun, 2018-03-04 at 18:26 +0530, Himanshu Jha wrote:
> > Hi Shreeya,
> > 
> > On Sun, Mar 04, 2018 at 06:06:22PM +0530, Shreeya Patel wrote:  
> > > 
> > > Remove some unnecessay comments and group the control
> > > register and register field macros together.
> > > Some of the register names does not make it's puporse
> > > very clear and hence, add some comments for more
> > > information.
> > > Also there are certain unit based comments which are not
> > > providing sufficient information, so expand those comments.
> > > 
> > > Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> > > ---
> > > 
> > > Changes in v3
> > >   -This patch is the combination of two patches from the
> > > previous series. Also add some more comments.
> > > 
> > > 
> > >  drivers/staging/iio/accel/adis16209.c | 132 ++++++++++----------
> > > --------------
> > >  1 file changed, 39 insertions(+), 93 deletions(-)
> > > 
> > > diff --git a/drivers/staging/iio/accel/adis16209.c
> > > b/drivers/staging/iio/accel/adis16209.c
> > > index 151120f..d8aef9c 100644
> > > --- a/drivers/staging/iio/accel/adis16209.c
> > > +++ b/drivers/staging/iio/accel/adis16209.c
> > > @@ -21,135 +21,70 @@
> > >  #include <linux/iio/imu/adis.h>
> > >  
> > >  #define ADIS16209_STARTUP_DELAY_MS	220
> > > -
> > > -/* Flash memory write count */
> > >  #define ADIS16209_FLASH_CNT_REG		0x00
> > >  
> > > -/* Output, power supply */
> > > +/* Data Output Register Definitions */
> > >  #define ADIS16209_SUPPLY_OUT_REG	0x02
> > > -
> > > -/* Output, x-axis accelerometer */
> > >  #define ADIS16209_XACCL_OUT_REG		0x04
> > > -
> > > -/* Output, y-axis accelerometer */
> > >  #define ADIS16209_YACCL_OUT_REG		0x06
> > > -
> > >  /* Output, auxiliary ADC input */
> > >  #define ADIS16209_AUX_ADC_REG		0x08
> > > -
> > >  /* Output, temperature */
> > >  #define ADIS16209_TEMP_OUT_REG		0x0A
> > > -
> > > -/* Output, x-axis inclination */
> > > +/* Output, +/- 90 degrees X-axis inclination */
> > >  #define ADIS16209_XINCL_OUT_REG		0x0C
> > > -
> > > -/* Output, y-axis inclination */
> > >  #define ADIS16209_YINCL_OUT_REG		0x0E
> > > -
> > >  /* Output, +/-180 vertical rotational position */
> > >  #define ADIS16209_ROT_OUT_REG		0x10
> > >  
> > > -/* Calibration, x-axis acceleration offset null */
> > > +/*
> > > + * Calibration Register Definitions.
> > > + * Acceleration, inclination or rotation offset null.
> > > + */
> > >  #define ADIS16209_XACCL_NULL_REG	0x12
> > > -
> > > -/* Calibration, y-axis acceleration offset null */
> > >  #define ADIS16209_YACCL_NULL_REG	0x14
> > > -
> > > -/* Calibration, x-axis inclination offset null */
> > >  #define ADIS16209_XINCL_NULL_REG	0x16
> > > -
> > > -/* Calibration, y-axis inclination offset null */
> > >  #define ADIS16209_YINCL_NULL_REG	0x18
> > > -
> > > -/* Calibration, vertical rotation offset null */
> > >  #define ADIS16209_ROT_NULL_REG		0x1A
> > >  
> > > -/* Alarm 1 amplitude threshold */
> > > +/* Alarm Register Definitions */
> > >  #define ADIS16209_ALM_MAG1_REG		0x20
> > > -
> > > -/* Alarm 2 amplitude threshold */
> > >  #define ADIS16209_ALM_MAG2_REG		0x22
> > > -
> > > -/* Alarm 1, sample period */
> > >  #define ADIS16209_ALM_SMPL1_REG		0x24
> > > -
> > > -/* Alarm 2, sample period */
> > >  #define ADIS16209_ALM_SMPL2_REG		0x26
> > > -
> > > -/* Alarm control */
> > >  #define ADIS16209_ALM_CTRL_REG		0x28
> > >  
> > > -/* Auxiliary DAC data */
> > >  #define ADIS16209_AUX_DAC_REG		0x30
> > > -
> > > -/* General-purpose digital input/output control */
> > >  #define ADIS16209_GPIO_CTRL_REG		0x32
> > > -
> > > -/* Miscellaneous control */
> > > -#define ADIS16209_MSC_CTRL_REG		0x34
> > > -
> > > -/* Internal sample period (rate) control */
> > >  #define ADIS16209_SMPL_PRD_REG		0x36
> > > -
> > > -/* Operation, filter configuration */
> > >  #define ADIS16209_AVG_CNT_REG		0x38
> > > -
> > > -/* Operation, sleep mode control */
> > >  #define ADIS16209_SLP_CNT_REG		0x3A
> > >  
> > > -/* Diagnostics, system status register */
> > > -#define ADIS16209_DIAG_STAT_REG		0x3C
> > > -
> > > -/* Operation, system command register */
> > > -#define ADIS16209_GLOB_CMD_REG		0x3E
> > > -
> > > -/* MSC_CTRL */
> > > -
> > > -/* Self-test at power-on: 1 = disabled, 0 = enabled */
> > > -#define ADIS16209_MSC_CTRL_PWRUP_SELF_TEST	BIT(10)
> > > -
> > > -/* Self-test enable */
> > > -#define ADIS16209_MSC_CTRL_SELF_TEST_EN	        BIT(8)
> > > -
> > > -/* Data-ready enable: 1 = enabled, 0 = disabled */
> > > -#define ADIS16209_MSC_CTRL_DATA_RDY_EN	        BIT(2)
> > > -
> > > +#define ADIS16209_MSC_CTRL_REG			0x34
> > > +#define  ADIS16209_MSC_CTRL_PWRUP_SELF_TEST	BIT(10)
> > > +#define  ADIS16209_MSC_CTRL_SELF_TEST_EN	BIT(8)
> > > +#define  ADIS16209_MSC_CTRL_DATA_RDY_EN		BIT(2)
> > >  /* Data-ready polarity: 1 = active high, 0 = active low */
> > > -#define ADIS16209_MSC_CTRL_ACTIVE_HIGH	        BIT(1)
> > > +#define  ADIS16209_MSC_CTRL_ACTIVE_HIGH		BIT(1)
> > > +#define  ADIS16209_MSC_CTRL_DATA_RDY_DIO2	BIT(0)
> > >  
> > > -/* Data-ready line selection: 1 = DIO2, 0 = DIO1 */
> > > -#define ADIS16209_MSC_CTRL_DATA_RDY_DIO2	BIT(0)
> > > -
> > > -/* DIAG_STAT */
> > > -
> > > -/* Alarm 2 status: 1 = alarm active, 0 = alarm inactive */
> > > -#define ADIS16209_DIAG_STAT_ALARM2        BIT(9)
> > > -
> > > -/* Alarm 1 status: 1 = alarm active, 0 = alarm inactive */
> > > -#define ADIS16209_DIAG_STAT_ALARM1        BIT(8)
> > > -
> > > -/* Self-test diagnostic error flag: 1 = error condition, 0 =
> > > normal operation */
> > > +#define ADIS16209_DIAG_STAT_REG			0x3C
> > > +#define  ADIS16209_DIAG_STAT_ALARM2		BIT(9)
> > > +#define  ADIS16209_DIAG_STAT_ALARM1		BIT(8)
> > >  #define ADIS16209_DIAG_STAT_SELFTEST_FAIL_BIT	5
> > > -
> > > -/* SPI communications failure */
> > >  #define ADIS16209_DIAG_STAT_SPI_FAIL_BIT	3
> > > -
> > > -/* Flash update failure */
> > >  #define ADIS16209_DIAG_STAT_FLASH_UPT_BIT	2
> > > -
> > >  /* Power supply above 3.625 V */
> > >  #define ADIS16209_DIAG_STAT_POWER_HIGH_BIT	1
> > > -
> > >  /* Power supply below 3.15 V */
> > >  #define ADIS16209_DIAG_STAT_POWER_LOW_BIT	0
> > >  
> > > -/* GLOB_CMD */
> > > -
> > > -#define ADIS16209_GLOB_CMD_SW_RESET	BIT(7)
> > > -#define ADIS16209_GLOB_CMD_CLEAR_STAT	BIT(4)
> > > -#define ADIS16209_GLOB_CMD_FACTORY_CAL	BIT(1)
> > > +#define ADIS16209_GLOB_CMD_REG			0x3E
> > > +#define  ADIS16209_GLOB_CMD_SW_RESET		BIT(7)
> > > +#define  ADIS16209_GLOB_CMD_CLEAR_STAT		BIT(4)
> > > +#define  ADIS16209_GLOB_CMD_FACTORY_CAL		BIT(1)
> > >  
> > > -#define ADIS16209_ERROR_ACTIVE          BIT(14)
> > > +#define ADIS16209_ERROR_ACTIVE			BIT(14)
> > >  
> > >  enum adis16209_scan {
> > >  	ADIS16209_SCAN_SUPPLY,
> > > @@ -226,24 +161,38 @@ static int adis16209_read_raw(struct iio_dev
> > > *indio_dev,
> > >  				*val2 = 610500; /* 0.6105 mV */
> > >  			return IIO_VAL_INT_PLUS_MICRO;
> > >  		case IIO_TEMP:
> > > -			*val = -470; /* -0.47 C */
> > > +			*val = -470;
> > >  			*val2 = 0;
> > >  			return IIO_VAL_INT_PLUS_MICRO;
> > >  		case IIO_ACCEL:
> > > +			/*
> > > +			 * IIO base unit for sensitivity of
> > > accelerometer
> > > +			 * is milli g.
> > > +			 * 1 LSB represents 0.244 mg.
> > > +			 */
> > >  			*val = 0;
> > > -			*val2 = IIO_G_TO_M_S_2(244140); /*
> > > 0.244140 mg */
> > > +			*val2 = IIO_G_TO_M_S_2(244140);
> > >  			return IIO_VAL_INT_PLUS_NANO;
> > >  		case IIO_INCLI:
> > >  		case IIO_ROT:
> > > +			/*
> > > +			 * IIO base units for rotation are
> > > degrees.
> > > +			 * 1 LSB represents 0.025 milli degrees.
> > > +			 */
> > >  			*val = 0;
> > > -			*val2 = 25000; /* 0.025 degree */
> > > +			*val2 = 25000;
> > >  			return IIO_VAL_INT_PLUS_MICRO;
> > >  		default:
> > >  			return -EINVAL;
> > >  		}
> > >  		break;
> > >  	case IIO_CHAN_INFO_OFFSET:
> > > -		*val = 25000 / -470 - 0x4FE; /* 25 C = 0x4FE */
> > > +		/*
> > > +		 * The raw ADC value is 0x4FE when the temperature
> > > +		 * is 45 degrees and the scale factor per milli
> > > +		 * degree celcius is -470.  
> > Are you sure it is *45 degrees* and not *25 degrees* instead ?
> > 
> > As I can clearly see from the datasheet :
> > 
> > "sensitivity = −0.47°/LSB, 25°C = 1278 LSB = 0x04FE"
> > 
> > Please check it :)
> > 
> > I found this because I'm also doing a similar cleanup for adis16201.  
> 
> Hi Himanshu,
> 
> Thanks for pointing this out :)
> Yes it is 25 degrees.
> 
> I'll make the change after Jonathan's reviews on the other changes
Good catch - I would probably have missed that.

Anyhow the rest of the patch looked good to me so I've applied it to
the togreg branch of iio.git (fixed up) and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> 
> Thank you
> 
> >   

