Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751292AbeBRMol (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Feb 2018 07:44:41 -0500
Date: Sun, 18 Feb 2018 12:44:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, daniel.baluta@nxp.com
Subject: Re: [PATCH 2/3] Staging: iio: adis16209: Remove unnecessary
 comments and add suitable suffix
Message-ID: <20180218124436.2f3d7f05@archlinux>
In-Reply-To: <2c828998b5f3d0b8722c052cadb332862f2304fb.1518883035.git.shreeya.patel23498@gmail.com>
References: <cover.1518883035.git.shreeya.patel23498@gmail.com>
        <2c828998b5f3d0b8722c052cadb332862f2304fb.1518883035.git.shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 17 Feb 2018 21:37:37 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> Remove some unnecessary comments and therefore, add _REG suffix
> for registers. Group the control register and register field
> macros together.
> Also, align function arguments to match open parentheses using
> tabs.

Lots of different changes in here - one patch per change type please.
(so probably 3 here)

A few comments inline.

Jonathan


> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> ---
>  drivers/staging/iio/accel/adis16209.c | 209 +++++++++++-----------------------
>  1 file changed, 69 insertions(+), 140 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
> index e3d9f80..6101212 100644
> --- a/drivers/staging/iio/accel/adis16209.c
> +++ b/drivers/staging/iio/accel/adis16209.c
> @@ -19,136 +19,67 @@
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/imu/adis.h>
>  
> -#define ADIS16209_STARTUP_DELAY	220 /* ms */
> -
> -/* Flash memory write count */
> -#define ADIS16209_FLASH_CNT      0x00
> -
> -/* Output, power supply */
> -#define ADIS16209_SUPPLY_OUT     0x02
> -
> -/* Output, x-axis accelerometer */
> -#define ADIS16209_XACCL_OUT      0x04
> -
> -/* Output, y-axis accelerometer */
> -#define ADIS16209_YACCL_OUT      0x06
> -
> -/* Output, auxiliary ADC input */
> -#define ADIS16209_AUX_ADC        0x08
> -
> -/* Output, temperature */
> -#define ADIS16209_TEMP_OUT       0x0A
> -
> -/* Output, x-axis inclination */
> -#define ADIS16209_XINCL_OUT      0x0C
> -
> -/* Output, y-axis inclination */
> -#define ADIS16209_YINCL_OUT      0x0E
> -
> -/* Output, +/-180 vertical rotational position */
> -#define ADIS16209_ROT_OUT        0x10
> -
> -/* Calibration, x-axis acceleration offset null */
> -#define ADIS16209_XACCL_NULL     0x12
> -
> -/* Calibration, y-axis acceleration offset null */
> -#define ADIS16209_YACCL_NULL     0x14
> -
> -/* Calibration, x-axis inclination offset null */
> -#define ADIS16209_XINCL_NULL     0x16
> -
> -/* Calibration, y-axis inclination offset null */
> -#define ADIS16209_YINCL_NULL     0x18
> -
> -/* Calibration, vertical rotation offset null */
> -#define ADIS16209_ROT_NULL       0x1A
> -
> -/* Alarm 1 amplitude threshold */
> -#define ADIS16209_ALM_MAG1       0x20
> -
> -/* Alarm 2 amplitude threshold */
> -#define ADIS16209_ALM_MAG2       0x22
> -
> -/* Alarm 1, sample period */
> -#define ADIS16209_ALM_SMPL1      0x24
> -
> -/* Alarm 2, sample period */
> -#define ADIS16209_ALM_SMPL2      0x26
> -
> -/* Alarm control */
> -#define ADIS16209_ALM_CTRL       0x28
> -
> -/* Auxiliary DAC data */
> -#define ADIS16209_AUX_DAC        0x30
> -
> -/* General-purpose digital input/output control */
> -#define ADIS16209_GPIO_CTRL      0x32
> -
> -/* Miscellaneous control */
> -#define ADIS16209_MSC_CTRL       0x34
> -
> -/* Internal sample period (rate) control */
> -#define ADIS16209_SMPL_PRD       0x36
> -
> -/* Operation, filter configuration */
> -#define ADIS16209_AVG_CNT        0x38
> -
> -/* Operation, sleep mode control */
> -#define ADIS16209_SLP_CNT        0x3A
> -
> -/* Diagnostics, system status register */
> -#define ADIS16209_DIAG_STAT      0x3C
> -
> -/* Operation, system command register */
> -#define ADIS16209_GLOB_CMD       0x3E
> +#define ADIS16209_STARTUP_DELAY_MS	220
This one is a different type of change to the others,
I would break it out in another patch. 

> +#define ADIS16209_FLASH_CNT_REG		0x00
> +
> +/* Data Output Register Definitions */
> +#define ADIS16209_SUPPLY_OUT_REG	0x02
> +#define ADIS16209_XACCL_OUT_REG		0x04
> +#define ADIS16209_YACCL_OUT_REG		0x06
> +#define ADIS16209_AUX_ADC_REG		0x08
> +#define ADIS16209_TEMP_OUT_REG		0x0A
> +#define ADIS16209_XINCL_OUT_REG		0x0C

For these last 3 I'm not sure that it is obvious what they are - I had
to look at the datasheet.  Perhaps a comment block explaining how
these relate to the orientation of the device would be a useful addition.
This may be a little 'controversial' so would be good to have
this clearly laid out.

> +#define ADIS16209_YINCL_OUT_REG		0x0E
> +#define ADIS16209_ROT_OUT_REG		0x10
> +
> +/* Calibration Register Definitions */
> +#define ADIS16209_XACCL_NULL_REG	0x12
> +#define ADIS16209_YACCL_NULL_REG	0x14
> +#define ADIS16209_XINCL_NULL_REG	0x16
> +#define ADIS16209_YINCL_NULL_REG	0x18
> +#define ADIS16209_ROT_NULL_REG		0x1A
This group are not necessarily clear in meaning.  I would explain
in the comment what is meant by NULL in this case.

> +
> +/* Alarm Register Definitions */
> +#define ADIS16209_ALM_MAG1_REG		0x20
> +#define ADIS16209_ALM_MAG2_REG		0x22
> +#define ADIS16209_ALM_SMPL1_REG		0x24
> +#define ADIS16209_ALM_SMPL2_REG		0x26
> +#define ADIS16209_ALM_CTRL_REG		0x28
Hmm. This is an interesting trade off.  There isn't actually enough defined
here to allow implementation of the ALM functionality (and I wouldn't suggest
trying to do so without hardware access) - so does having this set of defines
provide any useful information?  I'm not sure I care either way!

> +
> +#define ADIS16209_AUX_DAC_REG		0x30
> +#define ADIS16209_GPIO_CTRL_REG		0x32
> +#define ADIS16209_SMPL_PRD_REG		0x36
> +#define ADIS16209_AVG_CNT_REG		0x38
> +#define ADIS16209_SLP_CNT_REG		0x3A
>  
>  /* MSC_CTRL */
This one is obvious given the register name.
>  
> -/* Self-test at power-on: 1 = disabled, 0 = enabled */
> +#define ADIS16209_MSC_CTRL_REG			0x34
>  #define ADIS16209_MSC_CTRL_PWRUP_SELF_TEST	BIT(10)
> -
> -/* Self-test enable */
> -#define ADIS16209_MSC_CTRL_SELF_TEST_EN	        BIT(8)
> -
> -/* Data-ready enable: 1 = enabled, 0 = disabled */
> -#define ADIS16209_MSC_CTRL_DATA_RDY_EN	        BIT(2)
> -
> -/* Data-ready polarity: 1 = active high, 0 = active low */
> -#define ADIS16209_MSC_CTRL_ACTIVE_HIGH	        BIT(1)
> -
> -/* Data-ready line selection: 1 = DIO2, 0 = DIO1 */
> -#define ADIS16209_MSC_CTRL_DATA_RDY_DIO2	BIT(0)
> +#define ADIS16209_MSC_CTRL_SELF_TEST_EN		BIT(8)
One comment trick that I think improves readability is to
slightly indent the field definitions to make them clearly
different from the register addresses.
#define ADIS16209_MSC_CTRL_REG			0x34
#define   ADIS16209_MSC_CTRL_PWRUP_SELF_TEST	BIT(10)
#define   ADIS16209_MSC_CTRL_SELF_TEST_EN ...

There are other ways of doing this but I think this one is subtle
but effective.

> +#define ADIS16209_MSC_CTRL_DATA_RDY_EN		BIT(2)
> +#define ADIS16209_MSC_CTRL_ACTIVE_HIGH		BIT(1)
> +#define ADIS16209_MSC_CTRL_DATA_RDY_DIO1	BIT(0)
>  
>  /* DIAG_STAT */

Again, the register name makes this clear so no need for the comment.
Just use a blank line to separate this block from previous.

>  
> -/* Alarm 2 status: 1 = alarm active, 0 = alarm inactive */
> -#define ADIS16209_DIAG_STAT_ALARM2        BIT(9)
> -
> -/* Alarm 1 status: 1 = alarm active, 0 = alarm inactive */
> -#define ADIS16209_DIAG_STAT_ALARM1        BIT(8)
> -
> -/* Self-test diagnostic error flag: 1 = error condition, 0 = normal operation */
> +#define ADIS16209_DIAG_STAT_REG			0x3C
> +#define ADIS16209_DIAG_STAT_ALARM2		BIT(9)
> +#define ADIS16209_DIAG_STAT_ALARM1		BIT(8)
>  #define ADIS16209_DIAG_STAT_SELFTEST_FAIL_BIT	5
> -
> -/* SPI communications failure */
>  #define ADIS16209_DIAG_STAT_SPI_FAIL_BIT	3
> -
> -/* Flash update failure */
>  #define ADIS16209_DIAG_STAT_FLASH_UPT_BIT	2
> -
> -/* Power supply above 3.625 V */
>  #define ADIS16209_DIAG_STAT_POWER_HIGH_BIT	1
> -
> -/* Power supply below 3.15 V */
>  #define ADIS16209_DIAG_STAT_POWER_LOW_BIT	0
>  
>  /* GLOB_CMD */
Again, the register name makes this clear. It's not
'special' compared to the other registers so doesn't need
an additional comment.
>  
> -#define ADIS16209_GLOB_CMD_SW_RESET	BIT(7)
> -#define ADIS16209_GLOB_CMD_CLEAR_STAT	BIT(4)
> -#define ADIS16209_GLOB_CMD_FACTORY_CAL	BIT(1)
> +#define ADIS16209_GLOB_CMD_REG			0x3E
> +#define ADIS16209_GLOB_CMD_SW_RESET		BIT(7)
> +#define ADIS16209_GLOB_CMD_CLEAR_STAT		BIT(4)
> +#define ADIS16209_GLOB_CMD_FACTORY_CAL		BIT(1)
>  
> -#define ADIS16209_ERROR_ACTIVE          BIT(14)
> +#define ADIS16209_ERROR_ACTIVE			BIT(14)
>  
>  enum adis16209_scan {
>  	ADIS16209_SCAN_SUPPLY,
> @@ -164,10 +95,10 @@ enum adis16209_scan {
>  static const u8 adis16209_addresses[8][1] = {
>  	[ADIS16209_SCAN_SUPPLY] = { },
>  	[ADIS16209_SCAN_AUX_ADC] = { },
> -	[ADIS16209_SCAN_ACC_X] = { ADIS16209_XACCL_NULL },
> -	[ADIS16209_SCAN_ACC_Y] = { ADIS16209_YACCL_NULL },
> -	[ADIS16209_SCAN_INCLI_X] = { ADIS16209_XINCL_NULL },
> -	[ADIS16209_SCAN_INCLI_Y] = { ADIS16209_YINCL_NULL },
> +	[ADIS16209_SCAN_ACC_X] = { ADIS16209_XACCL_NULL_REG },
> +	[ADIS16209_SCAN_ACC_Y] = { ADIS16209_YACCL_NULL_REG },
> +	[ADIS16209_SCAN_INCLI_X] = { ADIS16209_XINCL_NULL_REG },
> +	[ADIS16209_SCAN_INCLI_Y] = { ADIS16209_YINCL_NULL_REG },
>  	[ADIS16209_SCAN_ROT] = { },
>  	[ADIS16209_SCAN_TEMP] = { },
>  };
> @@ -214,35 +145,35 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  		return adis_single_conversion(indio_dev, chan,
> -			ADIS16209_ERROR_ACTIVE, val);
> +					      ADIS16209_ERROR_ACTIVE, val);
This is a different type of change.  Should be in a different patch.

>  	case IIO_CHAN_INFO_SCALE:
>  		switch (chan->type) {
>  		case IIO_VOLTAGE:
>  			*val = 0;
>  			if (chan->channel == 0)
> -				*val2 = 305180; /* 0.30518 mV */
Again, I think Dan was right in his earlier review in that these
do provide some value, but I think it can be improved by
adding fuller comments.
> +				*val2 = 305180;
>  			else
> -				*val2 = 610500; /* 0.6105 mV */
> +				*val2 = 610500;
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		case IIO_TEMP:
> -			*val = -470; /* -0.47 C */
> +			*val = -470;
>  			*val2 = 0;
This one is interesting...

>  			return IIO_VAL_INT_PLUS_MICRO;
>  		case IIO_ACCEL:
>  			*val = 0;
> -			*val2 = IIO_G_TO_M_S_2(244140); /* 0.244140 mg */
> +			*val2 = IIO_G_TO_M_S_2(244140);

As below, perhaps what we really want is a useful comment rather than
no comment.

>  			return IIO_VAL_INT_PLUS_NANO;
>  		case IIO_INCLI:
>  		case IIO_ROT:
>  			*val = 0;
> -			*val2 = 25000; /* 0.025 degree */
Dan commented on these and I think he is correct in that it
is useful to have some description here of what is going on.

However, I'd like something more along the lines of:
/*
 * IIO base units for rotation are degrees.
 * 1 LSB represents 0.025 milli degrees.
 */
Or more interestingly does it given that I just checked
our ABI docs
Documentation/ABI/testing/sysfs-bus-iio and
rot_raw is not defined?

Would be great to:
1) Check what the various drivers with rotation channels
are actually using.
2) Document it properly.

> +			*val2 = 25000;
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		default:
>  			return -EINVAL;
>  		}
>  		break;
>  	case IIO_CHAN_INFO_OFFSET:
> -		*val = 25000 / -470 - 0x4FE; /* 25 C = 0x4FE */
> +		*val = 25000 / -470 - 0x4FE;

On this one I think it is sufficiently non obvious that we want
to go the other way and explain 'why' the offset is as described.
The comment is not that much help as it stands.
It is all very well knowing it should be 0x45e at 25 degrees but
where did that scale factor of -470 come from?

>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_CALIBBIAS:
>  		switch (chan->type) {
> @@ -265,18 +196,19 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
>  }
>  
>  static const struct iio_chan_spec adis16209_channels[] = {
> -	ADIS_SUPPLY_CHAN(ADIS16209_SUPPLY_OUT, ADIS16209_SCAN_SUPPLY, 0, 14),
> -	ADIS_TEMP_CHAN(ADIS16209_TEMP_OUT, ADIS16209_SCAN_TEMP, 0, 12),
> -	ADIS_ACCEL_CHAN(X, ADIS16209_XACCL_OUT, ADIS16209_SCAN_ACC_X,
> +	ADIS_SUPPLY_CHAN(ADIS16209_SUPPLY_OUT_REG, ADIS16209_SCAN_SUPPLY,
> +			 0, 14),
> +	ADIS_TEMP_CHAN(ADIS16209_TEMP_OUT_REG, ADIS16209_SCAN_TEMP, 0, 12),
> +	ADIS_ACCEL_CHAN(X, ADIS16209_XACCL_OUT_REG, ADIS16209_SCAN_ACC_X,
>  			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> -	ADIS_ACCEL_CHAN(Y, ADIS16209_YACCL_OUT, ADIS16209_SCAN_ACC_Y,
> +	ADIS_ACCEL_CHAN(Y, ADIS16209_YACCL_OUT_REG, ADIS16209_SCAN_ACC_Y,
>  			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> -	ADIS_AUX_ADC_CHAN(ADIS16209_AUX_ADC, ADIS16209_SCAN_AUX_ADC, 0, 12),
> -	ADIS_INCLI_CHAN(X, ADIS16209_XINCL_OUT, ADIS16209_SCAN_INCLI_X,
> +	ADIS_AUX_ADC_CHAN(ADIS16209_AUX_ADC_REG, ADIS16209_SCAN_AUX_ADC, 0, 12),
> +	ADIS_INCLI_CHAN(X, ADIS16209_XINCL_OUT_REG, ADIS16209_SCAN_INCLI_X,
>  			0, 0, 14),
> -	ADIS_INCLI_CHAN(Y, ADIS16209_YINCL_OUT, ADIS16209_SCAN_INCLI_Y,
> +	ADIS_INCLI_CHAN(Y, ADIS16209_YINCL_OUT_REG, ADIS16209_SCAN_INCLI_Y,
>  			0, 0, 14),
> -	ADIS_ROT_CHAN(X, ADIS16209_ROT_OUT, ADIS16209_SCAN_ROT, 0, 0, 14),
> +	ADIS_ROT_CHAN(X, ADIS16209_ROT_OUT_REG, ADIS16209_SCAN_ROT, 0, 0, 14),
>  	IIO_CHAN_SOFT_TIMESTAMP(8)
>  };
>  
> @@ -296,13 +228,13 @@ static const char * const adis16209_status_error_msgs[] = {
>  
>  static const struct adis_data adis16209_data = {
>  	.read_delay = 30,
> -	.msc_ctrl_reg = ADIS16209_MSC_CTRL,
> -	.glob_cmd_reg = ADIS16209_GLOB_CMD,
> -	.diag_stat_reg = ADIS16209_DIAG_STAT,
> +	.msc_ctrl_reg = ADIS16209_MSC_CTRL_REG,
> +	.glob_cmd_reg = ADIS16209_GLOB_CMD_REG,
> +	.diag_stat_reg = ADIS16209_DIAG_STAT_REG,
>  
>  	.self_test_mask = ADIS16209_MSC_CTRL_SELF_TEST_EN,
>  	.self_test_no_autoclear = true,
> -	.startup_delay = ADIS16209_STARTUP_DELAY,
> +	.startup_delay = ADIS16209_STARTUP_DELAY_MS,
>  
>  	.status_error_msgs = adis16209_status_error_msgs,
>  	.status_error_mask = BIT(ADIS16209_DIAG_STAT_SELFTEST_FAIL_BIT) |
> @@ -318,12 +250,10 @@ static int adis16209_probe(struct spi_device *spi)
>  	struct adis *st;
>  	struct iio_dev *indio_dev;
>  
> -	/* setup the industrialio driver allocated elements */
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  	st = iio_priv(indio_dev);
> -	/* this is only used for removal purposes */
>  	spi_set_drvdata(spi, indio_dev);
>  
>  	indio_dev->name = spi->dev.driver->name;
> @@ -340,7 +270,6 @@ static int adis16209_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> -	/* Get the device into a sane initial state */
>  	ret = adis_initial_startup(st);
>  	if (ret)
>  		goto error_cleanup_buffer_trigger;

