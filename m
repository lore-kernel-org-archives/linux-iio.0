Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54522 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752767AbeBEObC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Feb 2018 09:31:02 -0500
Date: Mon, 05 Feb 2018 14:30:20 +0000
In-Reply-To: <CAM8-SsHtUxFt91st5j8rWTCeqn3m1Un_QYV0_4tUfWMqzdL2Nw@mail.gmail.com>
References: <20180204152303.577edb42@archlinux> <CAM8-SsHtUxFt91st5j8rWTCeqn3m1Un_QYV0_4tUfWMqzdL2Nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [TODO] Potential Staging Clean-up: accel:adis16201.
To: nizam haider <nizamhaider786@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, daniel.baluta@gmail.com,
        amsfield22@gmail.com, lars@metafoo.de
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <80FB222F-E4A2-4257-949E-2AF15C8FA12A@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 5 February 2018 12:36:07 GMT, nizam haider <nizamhaider786@gmail.com> wrote:
>Hi jonathan,
>
>I would like to clean adis 16203.

Cool. Anyone else, shout if you want a suggestion of what to tackle.

If not I will do some more of these Todo reviews as time allows.

Jonathan
>
>
>Thanks,
>Nijam Haider
>
>On Sun, 4 Feb 2018 at 20:56 Jonathan Cameron <jic23@kernel.org> wrote:
>
>> Hi All
>>
>> I was looking over what we have left in staging for any low hanging
>fruit
>> and came across the adis16201 driver.
>>
>> I was wondering if anyone would like to clean it up?
>>
>> This would make a good opportuntity for someone who is fairly new to
>> kernel development to make a useful contribution.
>>
>> To that end I've done a review as if it had been submitted as a new
>> driver.
>>
>> If you want to take this on, please reply to say so in order to avoid
>> several people looking at this one driver.  Obviously if things
>change
>> and you then can't get to it reasonably quickly then 'hand it back'
>> on the mailing list.
>>
>> I'm happy to do this for a few more drivers if there are enough
>> interested people so do ping me if someone has claimed this one and
>you
>> would like a similar starting point.
>>
>> Ideally we would find someone who actually has hardware, but for the
>simple
>> stuff in this one I think we are unlikely to break anything that
>can't be
>> picked up in review. Hence I'm not totally bothered about it if no
>one
>> comes forward!
>>
>> Alison, Daniel. Feel free to add this to the outreachy task list if
>no
>> one else grabs it before the process starts again (just let us know
>if you
>> are
>> doing that).
>>
>> Thanks,
>>
>> Jonathan
>>
>> > /*
>> >  * ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer
>> >  *
>> >  * Copyright 2010 Analog Devices Inc.
>> >  *
>> >  * Licensed under the GPL-2 or later.
>>
>> Might as well convert to SPDX format for the license if we
>> are working on the driver anyway.
>>
>> >  */
>> >
>> > #include <linux/delay.h>
>> > #include <linux/mutex.h>
>> > #include <linux/device.h>
>> > #include <linux/kernel.h>
>> > #include <linux/spi/spi.h>
>> > #include <linux/slab.h>
>> > #include <linux/sysfs.h>
>> > #include <linux/module.h>
>>
>> Slight preference for alphabetical order in headers.
>>
>> However, it is useful to keep the iio headers separate
>> as they are here.
>>
>> >
>> > #include <linux/iio/iio.h>
>> > #include <linux/iio/sysfs.h>
>> > #include <linux/iio/buffer.h>
>> > #include <linux/iio/imu/adis.h>
>> >
>> > #define ADIS16201_STARTUP_DELAY       220 /* ms */
>>
>> Why not just make this ADIS16201_STARTUP_DELAY_MS as then it will
>> be obvious what the units are throughout the driver and remove
>> the need for the comment.
>>
>> >
>> > /* Flash memory write count */
>> > #define ADIS16201_FLASH_CNT      0x00
>>
>> To my mind there is far more commenting going on here than is
>actually
>> useful.  If the name of the register doesn't make it reasonably clear
>> what it is used for then it is not a good choice of name.
>>
>> It is made more complex by the fact these are the datasheet names
>> so we need to keep 'close' to those names for ease of comparisom.
>>
>> So unless something odd is going on I would not expect to see any
>> comments in here at all.
>>
>> Formatting wise, should be using tabs rather than spaces before the
>> numbers.
>>
>> Also, we have a mixture of defines for register addresses and
>> fields with in registers.  That is fine, but I would prefer
>> the nice clear _REG postfix on the registers defines to make
>> it more obvious which is which.
>>
>> e.g. What I'd expect here is something like:
>>
>> #define ADIS16201_FLASH_CNT_REG                 0x00
>> #define ADIS16201_SUPPLY_OUT_REG                0x02
>> #define ADIS16201_XACCL_OUT_REG                 0x04
>>
>> etc.
>>
>> >
>> > /* Output, power supply */
>> > #define ADIS16201_SUPPLY_OUT     0x02
>>
>> The out naming is awkward given it doesn't mean the device is
>supplying the
>> power, but rather that this is the reading the device is outputting. 
>Still
>> can't do that much about this without breaking away from datasheet
>naming.
>>
>> >
>> > /* Output, x-axis accelerometer */
>> > #define ADIS16201_XACCL_OUT      0x04
>> >
>> > /* Output, y-axis accelerometer */
>> > #define ADIS16201_YACCL_OUT      0x06
>> >
>> > /* Output, auxiliary ADC input */
>> > #define ADIS16201_AUX_ADC        0x08
>> >
>> > /* Output, temperature */
>> > #define ADIS16201_TEMP_OUT       0x0A
>> >
>> > /* Output, x-axis inclination */
>> > #define ADIS16201_XINCL_OUT      0x0C
>> >
>> > /* Output, y-axis inclination */
>> > #define ADIS16201_YINCL_OUT      0x0E
>> >
>> > /* Calibration, x-axis acceleration offset */
>> > #define ADIS16201_XACCL_OFFS     0x10
>> >
>> > /* Calibration, y-axis acceleration offset */
>> > #define ADIS16201_YACCL_OFFS     0x12
>> >
>> > /* x-axis acceleration scale factor */
>> > #define ADIS16201_XACCL_SCALE    0x14
>> >
>> > /* y-axis acceleration scale factor */
>> > #define ADIS16201_YACCL_SCALE    0x16
>> >
>> > /* Calibration, x-axis inclination offset */
>> > #define ADIS16201_XINCL_OFFS     0x18
>> >
>> > /* Calibration, y-axis inclination offset */
>> > #define ADIS16201_YINCL_OFFS     0x1A
>> >
>> > /* x-axis inclination scale factor */
>> > #define ADIS16201_XINCL_SCALE    0x1C
>> >
>> > /* y-axis inclination scale factor */
>> > #define ADIS16201_YINCL_SCALE    0x1E
>> >
>> > /* Alarm 1 amplitude threshold */
>> > #define ADIS16201_ALM_MAG1       0x20
>> >
>> > /* Alarm 2 amplitude threshold */
>> > #define ADIS16201_ALM_MAG2       0x22
>> >
>> > /* Alarm 1, sample period */
>> > #define ADIS16201_ALM_SMPL1      0x24
>> >
>> > /* Alarm 2, sample period */
>> > #define ADIS16201_ALM_SMPL2      0x26
>> >
>> > /* Alarm control */
>> > #define ADIS16201_ALM_CTRL       0x28
>> >
>> > /* Auxiliary DAC data */
>> > #define ADIS16201_AUX_DAC        0x30
>> >
>> > /* General-purpose digital input/output control */
>> > #define ADIS16201_GPIO_CTRL      0x32
>> >
>> > /* Miscellaneous control */
>> > #define ADIS16201_MSC_CTRL       0x34
>> >
>> > /* Internal sample period (rate) control */
>> > #define ADIS16201_SMPL_PRD       0x36
>> >
>> > /* Operation, filter configuration */
>> > #define ADIS16201_AVG_CNT        0x38
>> >
>> > /* Operation, sleep mode control */
>> > #define ADIS16201_SLP_CNT        0x3A
>> >
>> > /* Diagnostics, system status register */
>> > #define ADIS16201_DIAG_STAT      0x3C
>> >
>> > /* Operation, system command register */
>> > #define ADIS16201_GLOB_CMD       0x3E
>> >
>> > /* MSC_CTRL */
>> >
>> A really nice convention that has come up in recent drivers and makes
>> all these register / register field relationships obvious is to
>> use some subtle indenting of the fields and put them next to
>> the register address.  An example is:
>>
>> #define ADIS16201_MSC_CTRL_REG                  0x34
>> #define   ADIS16201_MSC_CTRL_SELF_TEST_EN       BIT(8)
>> #define   ADIS16201_MSC_CTRL_DATA_RDY_EN        BIT(2)
>> #define   ADIS16201_MSC_CTRL_ACTIVE_HIGH        BIT(1)
>> #define   ADIS16201_MSC_CTRL_DATA_RDY_DIO1      BIT(0)
>>
>> Again the naming of the fields is sufficient and the documentation
>> doesn't add anything so I would drop it.
>>
>> > /* Self-test enable */
>> > #define ADIS16201_MSC_CTRL_SELF_TEST_EN               BIT(8)
>> >
>> > /* Data-ready enable: 1 = enabled, 0 = disabled */
>> > #define ADIS16201_MSC_CTRL_DATA_RDY_EN                BIT(2)
>> >
>> > /* Data-ready polarity: 1 = active high, 0 = active low */
>> > #define ADIS16201_MSC_CTRL_ACTIVE_HIGH                BIT(1)
>> >
>> > /* Data-ready line selection: 1 = DIO1, 0 = DIO0 */
>> > #define ADIS16201_MSC_CTRL_DATA_RDY_DIO1      BIT(0)
>> >
>> > /* DIAG_STAT */
>> >
>> > /* Alarm 2 status: 1 = alarm active, 0 = alarm inactive */
>> > #define ADIS16201_DIAG_STAT_ALARM2        BIT(9)
>> >
>> > /* Alarm 1 status: 1 = alarm active, 0 = alarm inactive */
>> > #define ADIS16201_DIAG_STAT_ALARM1        BIT(8)
>> >
>> > /* SPI communications failure */
>> > #define ADIS16201_DIAG_STAT_SPI_FAIL_BIT   3
>> >
>> > /* Flash update failure */
>> > #define ADIS16201_DIAG_STAT_FLASH_UPT_BIT  2
>> >
>> > /* Power supply above 3.625 V */
>> > #define ADIS16201_DIAG_STAT_POWER_HIGH_BIT 1
>> >
>> > /* Power supply below 3.15 V */
>> > #define ADIS16201_DIAG_STAT_POWER_LOW_BIT  0
>> >
>> > /* GLOB_CMD */
>> >
>> > #define ADIS16201_GLOB_CMD_SW_RESET   BIT(7)
>> > #define ADIS16201_GLOB_CMD_FACTORY_CAL        BIT(1)
>> >
>> > #define ADIS16201_ERROR_ACTIVE          BIT(14)
>> >
>> > enum adis16201_scan {
>> >       ADIS16201_SCAN_ACC_X,
>> >       ADIS16201_SCAN_ACC_Y,
>> >       ADIS16201_SCAN_INCLI_X,
>> >       ADIS16201_SCAN_INCLI_Y,
>> >       ADIS16201_SCAN_SUPPLY,
>> >       ADIS16201_SCAN_AUX_ADC,
>> >       ADIS16201_SCAN_TEMP,
>> > };
>> >
>> > static const u8 adis16201_addresses[] = {
>>
>> It is rather odd that this is only used for the offsets, not
>> any of the other channel specific registers (scales, or the reading
>> itself).
>>
>> >       [ADIS16201_SCAN_ACC_X] = ADIS16201_XACCL_OFFS,
>> >       [ADIS16201_SCAN_ACC_Y] = ADIS16201_YACCL_OFFS,
>> >       [ADIS16201_SCAN_INCLI_X] = ADIS16201_XINCL_OFFS,
>> >       [ADIS16201_SCAN_INCLI_Y] = ADIS16201_YINCL_OFFS,
>> > };
>> >
>> > static int adis16201_read_raw(struct iio_dev *indio_dev,
>> >                             struct iio_chan_spec const *chan,
>> >                             int *val, int *val2,
>> >                             long mask)
>> > {
>> >       struct adis *st = iio_priv(indio_dev);
>> >       int ret;
>> >       int bits;
>> >       u8 addr;
>> >       s16 val16;
>> >
>> >       switch (mask) {
>> >       case IIO_CHAN_INFO_RAW:
>> >               return adis_single_conversion(indio_dev, chan,
>> >                               ADIS16201_ERROR_ACTIVE, val);
>>
>> Indenting could I think make the parameters align with the opening
>bracket.
>>
>> >       case IIO_CHAN_INFO_SCALE:
>> >               switch (chan->type) {
>> >               case IIO_VOLTAGE:
>> >                       if (chan->channel == 0) {
>> >                               *val = 1;
>> >                               *val2 = 220000; /* 1.22 mV */
>>
>> Comments don't add a huge amount given they kind of just
>> state the value before them.
>>
>> >                       } else {
>>
>> Given there are only two relevant channels I would like to see
>> them move explicitly matched using a switch statement.
>>
>> The default case would be an error return -EINVAL;
>>
>> >                               *val = 0;
>> >                               *val2 = 610000; /* 0.610 mV */
>> >                       }
>> >                       return IIO_VAL_INT_PLUS_MICRO;
>> >               case IIO_TEMP:
>> >                       *val = -470; /* 0.47 C */
>> >                       *val2 = 0;
>> >                       return IIO_VAL_INT_PLUS_MICRO;
>> >               case IIO_ACCEL:
>> >                       *val = 0;
>> >                       *val2 = IIO_G_TO_M_S_2(462400); /* 0.4624 mg
>*/
>>
>> Not sure that comment adds anything..
>>
>> >                       return IIO_VAL_INT_PLUS_NANO;
>> >               case IIO_INCLI:
>> >                       *val = 0;
>> >                       *val2 = 100000; /* 0.1 degree */
>>
>> Or this one.
>>
>> >                       return IIO_VAL_INT_PLUS_MICRO;
>> >               default:
>> >                       return -EINVAL;
>> >               }
>> >               break;
>> >       case IIO_CHAN_INFO_OFFSET:
>> >               *val = 25000 / -470 - 1278; /* 25 C = 1278 */
>> >               return IIO_VAL_INT;
>> >       case IIO_CHAN_INFO_CALIBBIAS:
>> >               switch (chan->type) {
>> >               case IIO_ACCEL:
>> >                       bits = 12;
>> >                       break;
>> >               case IIO_INCLI:
>> >                       bits = 9;
>> >                       break;
>> >               default:
>> >                       return -EINVAL;
>> >               }
>> >               addr = adis16201_addresses[chan->scan_index];
>> >               ret = adis_read_reg_16(st, addr, &val16);
>> >               if (ret)
>> >                       return ret;
>> >               val16 &= (1 << bits) - 1;
>>
>> Given the following sign extend, I don't think this does anything
>useful.
>>
>> >               val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
>>
>> This looks like a 16bit sign extend to me.  We have functions to
>> handle this nicely. See how it is done in other driverss
>>
>> >               *val = val16;
>>
>> blank line before return always makes them more obvious and hence the
>> code slightly more readable.  Do this throughout (including 2 lines
>> below this)
>>
>> >               return IIO_VAL_INT;
>> >       }
>> >       return -EINVAL;
>> > }
>> >
>> > static int adis16201_write_raw(struct iio_dev *indio_dev,
>> >                              struct iio_chan_spec const *chan,
>> >                              int val,
>> >                              int val2,
>> >                              long mask)
>> > {
>> >       struct adis *st = iio_priv(indio_dev);
>> >       int bits;
>> >       s16 val16;
>> >       u8 addr;
>> >
>> >       switch (mask) {
>> >       case IIO_CHAN_INFO_CALIBBIAS:
>> >               switch (chan->type) {
>> >               case IIO_ACCEL:
>> >                       bits = 12;
>> >                       break;
>> >               case IIO_INCLI:
>> >                       bits = 9;
>> >                       break;
>> >               default:
>> >                       return -EINVAL;
>> >               }
>> >               val16 = val & ((1 << bits) - 1);
>>
>> Given the above bits value is used only for this, why not create
>> a mask in the switch statement instead of carrying the number of
>> bits around.
>>
>> Then you can use GENMASK to make it nice and obvious what
>> is going on.
>>
>> >               addr = adis16201_addresses[chan->scan_index];
>> >               return adis_write_reg_16(st, addr, val16);
>> >       }
>> >       return -EINVAL;
>> > }
>> >
>> > static const struct iio_chan_spec adis16201_channels[] = {
>> >       ADIS_SUPPLY_CHAN(ADIS16201_SUPPLY_OUT, ADIS16201_SCAN_SUPPLY,
>0,
>> 12),
>> >       ADIS_TEMP_CHAN(ADIS16201_TEMP_OUT, ADIS16201_SCAN_TEMP, 0,
>12),
>> >       ADIS_ACCEL_CHAN(X, ADIS16201_XACCL_OUT, ADIS16201_SCAN_ACC_X,
>> >                       BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
>> >       ADIS_ACCEL_CHAN(Y, ADIS16201_YACCL_OUT, ADIS16201_SCAN_ACC_Y,
>> >                       BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
>> >       ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC, ADIS16201_SCAN_AUX_ADC,
>0,
>> 12),
>> >       ADIS_INCLI_CHAN(X, ADIS16201_XINCL_OUT,
>ADIS16201_SCAN_INCLI_X,
>> >                       BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
>> >       ADIS_INCLI_CHAN(X, ADIS16201_YINCL_OUT,
>ADIS16201_SCAN_INCLI_Y,
>> >                       BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
>> >       IIO_CHAN_SOFT_TIMESTAMP(7)
>> > };
>> >
>> > static const struct iio_info adis16201_info = {
>> >       .read_raw = adis16201_read_raw,
>> >       .write_raw = adis16201_write_raw,
>> >       .update_scan_mode = adis_update_scan_mode,
>> > };
>> >
>> > static const char * const adis16201_status_error_msgs[] = {
>> >       [ADIS16201_DIAG_STAT_SPI_FAIL_BIT] = "SPI failure",
>> >       [ADIS16201_DIAG_STAT_FLASH_UPT_BIT] = "Flash update failed",
>> >       [ADIS16201_DIAG_STAT_POWER_HIGH_BIT] = "Power supply above
>3.625V",
>> >       [ADIS16201_DIAG_STAT_POWER_LOW_BIT] = "Power supply below
>3.15V",
>> > };
>> >
>> > static const struct adis_data adis16201_data = {
>> >       .read_delay = 20,
>> >       .msc_ctrl_reg = ADIS16201_MSC_CTRL,
>> >       .glob_cmd_reg = ADIS16201_GLOB_CMD,
>> >       .diag_stat_reg = ADIS16201_DIAG_STAT,
>> >
>> >       .self_test_mask = ADIS16201_MSC_CTRL_SELF_TEST_EN,
>> >       .self_test_no_autoclear = true,
>> >       .startup_delay = ADIS16201_STARTUP_DELAY,
>> >
>> >       .status_error_msgs = adis16201_status_error_msgs,
>> >       .status_error_mask = BIT(ADIS16201_DIAG_STAT_SPI_FAIL_BIT) |
>> >               BIT(ADIS16201_DIAG_STAT_FLASH_UPT_BIT) |
>> >               BIT(ADIS16201_DIAG_STAT_POWER_HIGH_BIT) |
>> >               BIT(ADIS16201_DIAG_STAT_POWER_LOW_BIT),
>> > };
>> >
>> > static int adis16201_probe(struct spi_device *spi)
>> > {
>> >       int ret;
>> >       struct adis *st;
>> >       struct iio_dev *indio_dev;
>> There is a convention (when nothing else is guiding ordering) of
>doing
>> things in reverse Christmas tree.
>>
>> That means longest line first and shortest last.  Very minor point
>though.
>>
>> >
>> >       /* setup the industrialio driver allocated elements */
>>
>> Comment doesn't really add anything so drop it.
>>
>> >       indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>> >       if (!indio_dev)
>> >               return -ENOMEM;
>> >
>> >       st = iio_priv(indio_dev);
>> >       /* this is only used for removal purposes */
>>
>> Again, comment isn't really that useful...
>>
>> >       spi_set_drvdata(spi, indio_dev);
>> >
>> >       indio_dev->name = spi->dev.driver->name;
>> >       indio_dev->dev.parent = &spi->dev;
>> >       indio_dev->info = &adis16201_info;
>> >
>> >       indio_dev->channels = adis16201_channels;
>> >       indio_dev->num_channels = ARRAY_SIZE(adis16201_channels);
>> >       indio_dev->modes = INDIO_DIRECT_MODE;
>> >
>> >       ret = adis_init(st, indio_dev, spi, &adis16201_data);
>> >       if (ret)
>> >               return ret;
>>
>> A blank line here would help readability by separating these two
>> unconnected operations.
>>
>> >       ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
>> >       if (ret)
>> >               return ret;
>> >
>> >       /* Get the device into a sane initial state */
>> >       ret = adis_initial_startup(st);
>> >       if (ret)
>> >               goto error_cleanup_buffer_trigger;
>> >
>> >       ret = iio_device_register(indio_dev);
>> >       if (ret < 0)
>> >               goto error_cleanup_buffer_trigger;
>>
>> Blank line here.
>>
>> >       return 0;
>> >
>> > error_cleanup_buffer_trigger:
>> >       adis_cleanup_buffer_and_trigger(st, indio_dev);
>>
>> blank line here.
>>
>> >       return ret;
>> > }
>> >
>> > static int adis16201_remove(struct spi_device *spi)
>> > {
>> >       struct iio_dev *indio_dev = spi_get_drvdata(spi);
>> >       struct adis *st = iio_priv(indio_dev);
>> >
>> >       iio_device_unregister(indio_dev);
>> >       adis_cleanup_buffer_and_trigger(st, indio_dev);
>> >
>> >       return 0;
>> > }
>> >
>> > static struct spi_driver adis16201_driver = {
>> >       .driver = {
>> >               .name = "adis16201",
>> >       },
>> >       .probe = adis16201_probe,
>> >       .remove = adis16201_remove,
>> > };
>> > module_spi_driver(adis16201_driver);
>>
>> Probably want to add devicetree bindings but not strictly necessary
>to
>> move out of staging...
>>
>> >
>> > MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
>> > MODULE_DESCRIPTION("Analog Devices ADIS16201 Dual-Axis Digital
>> Inclinometer and Accelerometer");
>> > MODULE_LICENSE("GPL v2");
>> > MODULE_ALIAS("spi:adis16201");
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio"
>in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
