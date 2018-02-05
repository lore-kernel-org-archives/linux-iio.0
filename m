Return-Path: <SRS0=F5wl=E7=gmail.com=nizamhaider786@kernel.org>
MIME-Version: 1.0
References: <20180204152303.577edb42@archlinux>
In-Reply-To: <20180204152303.577edb42@archlinux>
From: nizam haider <nizamhaider786@gmail.com>
Date: Mon, 05 Feb 2018 12:36:07 +0000
Message-ID: <CAM8-SsHtUxFt91st5j8rWTCeqn3m1Un_QYV0_4tUfWMqzdL2Nw@mail.gmail.com>
Subject: Re: [TODO] Potential Staging Clean-up: accel:adis16201.
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, daniel.baluta@gmail.com, amsfield22@gmail.com,
	lars@metafoo.de
Content-Type: multipart/alternative; boundary="001a113d2e72fe55440564764eb2"
List-ID: <linux-iio@vger.kernel.org>

--001a113d2e72fe55440564764eb2
Content-Type: text/plain; charset="UTF-8"

Hi jonathan,

I would like to clean adis 16203.


Thanks,
Nijam Haider

On Sun, 4 Feb 2018 at 20:56 Jonathan Cameron <jic23@kernel.org> wrote:

> Hi All
>
> I was looking over what we have left in staging for any low hanging fruit
> and came across the adis16201 driver.
>
> I was wondering if anyone would like to clean it up?
>
> This would make a good opportuntity for someone who is fairly new to
> kernel development to make a useful contribution.
>
> To that end I've done a review as if it had been submitted as a new
> driver.
>
> If you want to take this on, please reply to say so in order to avoid
> several people looking at this one driver.  Obviously if things change
> and you then can't get to it reasonably quickly then 'hand it back'
> on the mailing list.
>
> I'm happy to do this for a few more drivers if there are enough
> interested people so do ping me if someone has claimed this one and you
> would like a similar starting point.
>
> Ideally we would find someone who actually has hardware, but for the simple
> stuff in this one I think we are unlikely to break anything that can't be
> picked up in review. Hence I'm not totally bothered about it if no one
> comes forward!
>
> Alison, Daniel. Feel free to add this to the outreachy task list if no
> one else grabs it before the process starts again (just let us know if you
> are
> doing that).
>
> Thanks,
>
> Jonathan
>
> > /*
> >  * ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer
> >  *
> >  * Copyright 2010 Analog Devices Inc.
> >  *
> >  * Licensed under the GPL-2 or later.
>
> Might as well convert to SPDX format for the license if we
> are working on the driver anyway.
>
> >  */
> >
> > #include <linux/delay.h>
> > #include <linux/mutex.h>
> > #include <linux/device.h>
> > #include <linux/kernel.h>
> > #include <linux/spi/spi.h>
> > #include <linux/slab.h>
> > #include <linux/sysfs.h>
> > #include <linux/module.h>
>
> Slight preference for alphabetical order in headers.
>
> However, it is useful to keep the iio headers separate
> as they are here.
>
> >
> > #include <linux/iio/iio.h>
> > #include <linux/iio/sysfs.h>
> > #include <linux/iio/buffer.h>
> > #include <linux/iio/imu/adis.h>
> >
> > #define ADIS16201_STARTUP_DELAY       220 /* ms */
>
> Why not just make this ADIS16201_STARTUP_DELAY_MS as then it will
> be obvious what the units are throughout the driver and remove
> the need for the comment.
>
> >
> > /* Flash memory write count */
> > #define ADIS16201_FLASH_CNT      0x00
>
> To my mind there is far more commenting going on here than is actually
> useful.  If the name of the register doesn't make it reasonably clear
> what it is used for then it is not a good choice of name.
>
> It is made more complex by the fact these are the datasheet names
> so we need to keep 'close' to those names for ease of comparisom.
>
> So unless something odd is going on I would not expect to see any
> comments in here at all.
>
> Formatting wise, should be using tabs rather than spaces before the
> numbers.
>
> Also, we have a mixture of defines for register addresses and
> fields with in registers.  That is fine, but I would prefer
> the nice clear _REG postfix on the registers defines to make
> it more obvious which is which.
>
> e.g. What I'd expect here is something like:
>
> #define ADIS16201_FLASH_CNT_REG                 0x00
> #define ADIS16201_SUPPLY_OUT_REG                0x02
> #define ADIS16201_XACCL_OUT_REG                 0x04
>
> etc.
>
> >
> > /* Output, power supply */
> > #define ADIS16201_SUPPLY_OUT     0x02
>
> The out naming is awkward given it doesn't mean the device is supplying the
> power, but rather that this is the reading the device is outputting.  Still
> can't do that much about this without breaking away from datasheet naming.
>
> >
> > /* Output, x-axis accelerometer */
> > #define ADIS16201_XACCL_OUT      0x04
> >
> > /* Output, y-axis accelerometer */
> > #define ADIS16201_YACCL_OUT      0x06
> >
> > /* Output, auxiliary ADC input */
> > #define ADIS16201_AUX_ADC        0x08
> >
> > /* Output, temperature */
> > #define ADIS16201_TEMP_OUT       0x0A
> >
> > /* Output, x-axis inclination */
> > #define ADIS16201_XINCL_OUT      0x0C
> >
> > /* Output, y-axis inclination */
> > #define ADIS16201_YINCL_OUT      0x0E
> >
> > /* Calibration, x-axis acceleration offset */
> > #define ADIS16201_XACCL_OFFS     0x10
> >
> > /* Calibration, y-axis acceleration offset */
> > #define ADIS16201_YACCL_OFFS     0x12
> >
> > /* x-axis acceleration scale factor */
> > #define ADIS16201_XACCL_SCALE    0x14
> >
> > /* y-axis acceleration scale factor */
> > #define ADIS16201_YACCL_SCALE    0x16
> >
> > /* Calibration, x-axis inclination offset */
> > #define ADIS16201_XINCL_OFFS     0x18
> >
> > /* Calibration, y-axis inclination offset */
> > #define ADIS16201_YINCL_OFFS     0x1A
> >
> > /* x-axis inclination scale factor */
> > #define ADIS16201_XINCL_SCALE    0x1C
> >
> > /* y-axis inclination scale factor */
> > #define ADIS16201_YINCL_SCALE    0x1E
> >
> > /* Alarm 1 amplitude threshold */
> > #define ADIS16201_ALM_MAG1       0x20
> >
> > /* Alarm 2 amplitude threshold */
> > #define ADIS16201_ALM_MAG2       0x22
> >
> > /* Alarm 1, sample period */
> > #define ADIS16201_ALM_SMPL1      0x24
> >
> > /* Alarm 2, sample period */
> > #define ADIS16201_ALM_SMPL2      0x26
> >
> > /* Alarm control */
> > #define ADIS16201_ALM_CTRL       0x28
> >
> > /* Auxiliary DAC data */
> > #define ADIS16201_AUX_DAC        0x30
> >
> > /* General-purpose digital input/output control */
> > #define ADIS16201_GPIO_CTRL      0x32
> >
> > /* Miscellaneous control */
> > #define ADIS16201_MSC_CTRL       0x34
> >
> > /* Internal sample period (rate) control */
> > #define ADIS16201_SMPL_PRD       0x36
> >
> > /* Operation, filter configuration */
> > #define ADIS16201_AVG_CNT        0x38
> >
> > /* Operation, sleep mode control */
> > #define ADIS16201_SLP_CNT        0x3A
> >
> > /* Diagnostics, system status register */
> > #define ADIS16201_DIAG_STAT      0x3C
> >
> > /* Operation, system command register */
> > #define ADIS16201_GLOB_CMD       0x3E
> >
> > /* MSC_CTRL */
> >
> A really nice convention that has come up in recent drivers and makes
> all these register / register field relationships obvious is to
> use some subtle indenting of the fields and put them next to
> the register address.  An example is:
>
> #define ADIS16201_MSC_CTRL_REG                  0x34
> #define   ADIS16201_MSC_CTRL_SELF_TEST_EN       BIT(8)
> #define   ADIS16201_MSC_CTRL_DATA_RDY_EN        BIT(2)
> #define   ADIS16201_MSC_CTRL_ACTIVE_HIGH        BIT(1)
> #define   ADIS16201_MSC_CTRL_DATA_RDY_DIO1      BIT(0)
>
> Again the naming of the fields is sufficient and the documentation
> doesn't add anything so I would drop it.
>
> > /* Self-test enable */
> > #define ADIS16201_MSC_CTRL_SELF_TEST_EN               BIT(8)
> >
> > /* Data-ready enable: 1 = enabled, 0 = disabled */
> > #define ADIS16201_MSC_CTRL_DATA_RDY_EN                BIT(2)
> >
> > /* Data-ready polarity: 1 = active high, 0 = active low */
> > #define ADIS16201_MSC_CTRL_ACTIVE_HIGH                BIT(1)
> >
> > /* Data-ready line selection: 1 = DIO1, 0 = DIO0 */
> > #define ADIS16201_MSC_CTRL_DATA_RDY_DIO1      BIT(0)
> >
> > /* DIAG_STAT */
> >
> > /* Alarm 2 status: 1 = alarm active, 0 = alarm inactive */
> > #define ADIS16201_DIAG_STAT_ALARM2        BIT(9)
> >
> > /* Alarm 1 status: 1 = alarm active, 0 = alarm inactive */
> > #define ADIS16201_DIAG_STAT_ALARM1        BIT(8)
> >
> > /* SPI communications failure */
> > #define ADIS16201_DIAG_STAT_SPI_FAIL_BIT   3
> >
> > /* Flash update failure */
> > #define ADIS16201_DIAG_STAT_FLASH_UPT_BIT  2
> >
> > /* Power supply above 3.625 V */
> > #define ADIS16201_DIAG_STAT_POWER_HIGH_BIT 1
> >
> > /* Power supply below 3.15 V */
> > #define ADIS16201_DIAG_STAT_POWER_LOW_BIT  0
> >
> > /* GLOB_CMD */
> >
> > #define ADIS16201_GLOB_CMD_SW_RESET   BIT(7)
> > #define ADIS16201_GLOB_CMD_FACTORY_CAL        BIT(1)
> >
> > #define ADIS16201_ERROR_ACTIVE          BIT(14)
> >
> > enum adis16201_scan {
> >       ADIS16201_SCAN_ACC_X,
> >       ADIS16201_SCAN_ACC_Y,
> >       ADIS16201_SCAN_INCLI_X,
> >       ADIS16201_SCAN_INCLI_Y,
> >       ADIS16201_SCAN_SUPPLY,
> >       ADIS16201_SCAN_AUX_ADC,
> >       ADIS16201_SCAN_TEMP,
> > };
> >
> > static const u8 adis16201_addresses[] = {
>
> It is rather odd that this is only used for the offsets, not
> any of the other channel specific registers (scales, or the reading
> itself).
>
> >       [ADIS16201_SCAN_ACC_X] = ADIS16201_XACCL_OFFS,
> >       [ADIS16201_SCAN_ACC_Y] = ADIS16201_YACCL_OFFS,
> >       [ADIS16201_SCAN_INCLI_X] = ADIS16201_XINCL_OFFS,
> >       [ADIS16201_SCAN_INCLI_Y] = ADIS16201_YINCL_OFFS,
> > };
> >
> > static int adis16201_read_raw(struct iio_dev *indio_dev,
> >                             struct iio_chan_spec const *chan,
> >                             int *val, int *val2,
> >                             long mask)
> > {
> >       struct adis *st = iio_priv(indio_dev);
> >       int ret;
> >       int bits;
> >       u8 addr;
> >       s16 val16;
> >
> >       switch (mask) {
> >       case IIO_CHAN_INFO_RAW:
> >               return adis_single_conversion(indio_dev, chan,
> >                               ADIS16201_ERROR_ACTIVE, val);
>
> Indenting could I think make the parameters align with the opening bracket.
>
> >       case IIO_CHAN_INFO_SCALE:
> >               switch (chan->type) {
> >               case IIO_VOLTAGE:
> >                       if (chan->channel == 0) {
> >                               *val = 1;
> >                               *val2 = 220000; /* 1.22 mV */
>
> Comments don't add a huge amount given they kind of just
> state the value before them.
>
> >                       } else {
>
> Given there are only two relevant channels I would like to see
> them move explicitly matched using a switch statement.
>
> The default case would be an error return -EINVAL;
>
> >                               *val = 0;
> >                               *val2 = 610000; /* 0.610 mV */
> >                       }
> >                       return IIO_VAL_INT_PLUS_MICRO;
> >               case IIO_TEMP:
> >                       *val = -470; /* 0.47 C */
> >                       *val2 = 0;
> >                       return IIO_VAL_INT_PLUS_MICRO;
> >               case IIO_ACCEL:
> >                       *val = 0;
> >                       *val2 = IIO_G_TO_M_S_2(462400); /* 0.4624 mg */
>
> Not sure that comment adds anything..
>
> >                       return IIO_VAL_INT_PLUS_NANO;
> >               case IIO_INCLI:
> >                       *val = 0;
> >                       *val2 = 100000; /* 0.1 degree */
>
> Or this one.
>
> >                       return IIO_VAL_INT_PLUS_MICRO;
> >               default:
> >                       return -EINVAL;
> >               }
> >               break;
> >       case IIO_CHAN_INFO_OFFSET:
> >               *val = 25000 / -470 - 1278; /* 25 C = 1278 */
> >               return IIO_VAL_INT;
> >       case IIO_CHAN_INFO_CALIBBIAS:
> >               switch (chan->type) {
> >               case IIO_ACCEL:
> >                       bits = 12;
> >                       break;
> >               case IIO_INCLI:
> >                       bits = 9;
> >                       break;
> >               default:
> >                       return -EINVAL;
> >               }
> >               addr = adis16201_addresses[chan->scan_index];
> >               ret = adis_read_reg_16(st, addr, &val16);
> >               if (ret)
> >                       return ret;
> >               val16 &= (1 << bits) - 1;
>
> Given the following sign extend, I don't think this does anything useful.
>
> >               val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
>
> This looks like a 16bit sign extend to me.  We have functions to
> handle this nicely. See how it is done in other driverss
>
> >               *val = val16;
>
> blank line before return always makes them more obvious and hence the
> code slightly more readable.  Do this throughout (including 2 lines
> below this)
>
> >               return IIO_VAL_INT;
> >       }
> >       return -EINVAL;
> > }
> >
> > static int adis16201_write_raw(struct iio_dev *indio_dev,
> >                              struct iio_chan_spec const *chan,
> >                              int val,
> >                              int val2,
> >                              long mask)
> > {
> >       struct adis *st = iio_priv(indio_dev);
> >       int bits;
> >       s16 val16;
> >       u8 addr;
> >
> >       switch (mask) {
> >       case IIO_CHAN_INFO_CALIBBIAS:
> >               switch (chan->type) {
> >               case IIO_ACCEL:
> >                       bits = 12;
> >                       break;
> >               case IIO_INCLI:
> >                       bits = 9;
> >                       break;
> >               default:
> >                       return -EINVAL;
> >               }
> >               val16 = val & ((1 << bits) - 1);
>
> Given the above bits value is used only for this, why not create
> a mask in the switch statement instead of carrying the number of
> bits around.
>
> Then you can use GENMASK to make it nice and obvious what
> is going on.
>
> >               addr = adis16201_addresses[chan->scan_index];
> >               return adis_write_reg_16(st, addr, val16);
> >       }
> >       return -EINVAL;
> > }
> >
> > static const struct iio_chan_spec adis16201_channels[] = {
> >       ADIS_SUPPLY_CHAN(ADIS16201_SUPPLY_OUT, ADIS16201_SCAN_SUPPLY, 0,
> 12),
> >       ADIS_TEMP_CHAN(ADIS16201_TEMP_OUT, ADIS16201_SCAN_TEMP, 0, 12),
> >       ADIS_ACCEL_CHAN(X, ADIS16201_XACCL_OUT, ADIS16201_SCAN_ACC_X,
> >                       BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> >       ADIS_ACCEL_CHAN(Y, ADIS16201_YACCL_OUT, ADIS16201_SCAN_ACC_Y,
> >                       BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> >       ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC, ADIS16201_SCAN_AUX_ADC, 0,
> 12),
> >       ADIS_INCLI_CHAN(X, ADIS16201_XINCL_OUT, ADIS16201_SCAN_INCLI_X,
> >                       BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> >       ADIS_INCLI_CHAN(X, ADIS16201_YINCL_OUT, ADIS16201_SCAN_INCLI_Y,
> >                       BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> >       IIO_CHAN_SOFT_TIMESTAMP(7)
> > };
> >
> > static const struct iio_info adis16201_info = {
> >       .read_raw = adis16201_read_raw,
> >       .write_raw = adis16201_write_raw,
> >       .update_scan_mode = adis_update_scan_mode,
> > };
> >
> > static const char * const adis16201_status_error_msgs[] = {
> >       [ADIS16201_DIAG_STAT_SPI_FAIL_BIT] = "SPI failure",
> >       [ADIS16201_DIAG_STAT_FLASH_UPT_BIT] = "Flash update failed",
> >       [ADIS16201_DIAG_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
> >       [ADIS16201_DIAG_STAT_POWER_LOW_BIT] = "Power supply below 3.15V",
> > };
> >
> > static const struct adis_data adis16201_data = {
> >       .read_delay = 20,
> >       .msc_ctrl_reg = ADIS16201_MSC_CTRL,
> >       .glob_cmd_reg = ADIS16201_GLOB_CMD,
> >       .diag_stat_reg = ADIS16201_DIAG_STAT,
> >
> >       .self_test_mask = ADIS16201_MSC_CTRL_SELF_TEST_EN,
> >       .self_test_no_autoclear = true,
> >       .startup_delay = ADIS16201_STARTUP_DELAY,
> >
> >       .status_error_msgs = adis16201_status_error_msgs,
> >       .status_error_mask = BIT(ADIS16201_DIAG_STAT_SPI_FAIL_BIT) |
> >               BIT(ADIS16201_DIAG_STAT_FLASH_UPT_BIT) |
> >               BIT(ADIS16201_DIAG_STAT_POWER_HIGH_BIT) |
> >               BIT(ADIS16201_DIAG_STAT_POWER_LOW_BIT),
> > };
> >
> > static int adis16201_probe(struct spi_device *spi)
> > {
> >       int ret;
> >       struct adis *st;
> >       struct iio_dev *indio_dev;
> There is a convention (when nothing else is guiding ordering) of doing
> things in reverse Christmas tree.
>
> That means longest line first and shortest last.  Very minor point though.
>
> >
> >       /* setup the industrialio driver allocated elements */
>
> Comment doesn't really add anything so drop it.
>
> >       indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> >       if (!indio_dev)
> >               return -ENOMEM;
> >
> >       st = iio_priv(indio_dev);
> >       /* this is only used for removal purposes */
>
> Again, comment isn't really that useful...
>
> >       spi_set_drvdata(spi, indio_dev);
> >
> >       indio_dev->name = spi->dev.driver->name;
> >       indio_dev->dev.parent = &spi->dev;
> >       indio_dev->info = &adis16201_info;
> >
> >       indio_dev->channels = adis16201_channels;
> >       indio_dev->num_channels = ARRAY_SIZE(adis16201_channels);
> >       indio_dev->modes = INDIO_DIRECT_MODE;
> >
> >       ret = adis_init(st, indio_dev, spi, &adis16201_data);
> >       if (ret)
> >               return ret;
>
> A blank line here would help readability by separating these two
> unconnected operations.
>
> >       ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
> >       if (ret)
> >               return ret;
> >
> >       /* Get the device into a sane initial state */
> >       ret = adis_initial_startup(st);
> >       if (ret)
> >               goto error_cleanup_buffer_trigger;
> >
> >       ret = iio_device_register(indio_dev);
> >       if (ret < 0)
> >               goto error_cleanup_buffer_trigger;
>
> Blank line here.
>
> >       return 0;
> >
> > error_cleanup_buffer_trigger:
> >       adis_cleanup_buffer_and_trigger(st, indio_dev);
>
> blank line here.
>
> >       return ret;
> > }
> >
> > static int adis16201_remove(struct spi_device *spi)
> > {
> >       struct iio_dev *indio_dev = spi_get_drvdata(spi);
> >       struct adis *st = iio_priv(indio_dev);
> >
> >       iio_device_unregister(indio_dev);
> >       adis_cleanup_buffer_and_trigger(st, indio_dev);
> >
> >       return 0;
> > }
> >
> > static struct spi_driver adis16201_driver = {
> >       .driver = {
> >               .name = "adis16201",
> >       },
> >       .probe = adis16201_probe,
> >       .remove = adis16201_remove,
> > };
> > module_spi_driver(adis16201_driver);
>
> Probably want to add devicetree bindings but not strictly necessary to
> move out of staging...
>
> >
> > MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> > MODULE_DESCRIPTION("Analog Devices ADIS16201 Dual-Axis Digital
> Inclinometer and Accelerometer");
> > MODULE_LICENSE("GPL v2");
> > MODULE_ALIAS("spi:adis16201");
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--001a113d2e72fe55440564764eb2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi jonathan,<div><br></div><div>I would like to clean adis=
 16203.</div><div><br></div><div><br></div><div>Thanks,</div><div>Nijam Hai=
der</div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Sun, 4 Feb=
 2018 at 20:56 Jonathan Cameron &lt;<a href=3D"mailto:jic23@kernel.org">jic=
23@kernel.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi All=
<br>
<br>
I was looking over what we have left in staging for any low hanging fruit<b=
r>
and came across the adis16201 driver.<br>
<br>
I was wondering if anyone would like to clean it up?<br>
<br>
This would make a good opportuntity for someone who is fairly new to<br>
kernel development to make a useful contribution.<br>
<br>
To that end I&#39;ve done a review as if it had been submitted as a new<br>
driver.<br>
<br>
If you want to take this on, please reply to say so in order to avoid<br>
several people looking at this one driver.=C2=A0 Obviously if things change=
<br>
and you then can&#39;t get to it reasonably quickly then &#39;hand it back&=
#39;<br>
on the mailing list.<br>
<br>
I&#39;m happy to do this for a few more drivers if there are enough<br>
interested people so do ping me if someone has claimed this one and you<br>
would like a similar starting point.<br>
<br>
Ideally we would find someone who actually has hardware, but for the simple=
<br>
stuff in this one I think we are unlikely to break anything that can&#39;t =
be<br>
picked up in review. Hence I&#39;m not totally bothered about it if no one<=
br>
comes forward!<br>
<br>
Alison, Daniel. Feel free to add this to the outreachy task list if no<br>
one else grabs it before the process starts again (just let us know if you =
are<br>
doing that).<br>
<br>
Thanks,<br>
<br>
Jonathan<br>
<br>
&gt; /*<br>
&gt;=C2=A0 * ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer<br>
&gt;=C2=A0 *<br>
&gt;=C2=A0 * Copyright 2010 Analog Devices Inc.<br>
&gt;=C2=A0 *<br>
&gt;=C2=A0 * Licensed under the GPL-2 or later.<br>
<br>
Might as well convert to SPDX format for the license if we<br>
are working on the driver anyway.<br>
<br>
&gt;=C2=A0 */<br>
&gt;<br>
&gt; #include &lt;linux/delay.h&gt;<br>
&gt; #include &lt;linux/mutex.h&gt;<br>
&gt; #include &lt;linux/device.h&gt;<br>
&gt; #include &lt;linux/kernel.h&gt;<br>
&gt; #include &lt;linux/spi/spi.h&gt;<br>
&gt; #include &lt;linux/slab.h&gt;<br>
&gt; #include &lt;linux/sysfs.h&gt;<br>
&gt; #include &lt;linux/module.h&gt;<br>
<br>
Slight preference for alphabetical order in headers.<br>
<br>
However, it is useful to keep the iio headers separate<br>
as they are here.<br>
<br>
&gt;<br>
&gt; #include &lt;linux/iio/iio.h&gt;<br>
&gt; #include &lt;linux/iio/sysfs.h&gt;<br>
&gt; #include &lt;linux/iio/buffer.h&gt;<br>
&gt; #include &lt;linux/iio/imu/adis.h&gt;<br>
&gt;<br>
&gt; #define ADIS16201_STARTUP_DELAY=C2=A0 =C2=A0 =C2=A0 =C2=A0220 /* ms */=
<br>
<br>
Why not just make this ADIS16201_STARTUP_DELAY_MS as then it will<br>
be obvious what the units are throughout the driver and remove<br>
the need for the comment.<br>
<br>
&gt;<br>
&gt; /* Flash memory write count */<br>
&gt; #define ADIS16201_FLASH_CNT=C2=A0 =C2=A0 =C2=A0 0x00<br>
<br>
To my mind there is far more commenting going on here than is actually<br>
useful.=C2=A0 If the name of the register doesn&#39;t make it reasonably cl=
ear<br>
what it is used for then it is not a good choice of name.<br>
<br>
It is made more complex by the fact these are the datasheet names<br>
so we need to keep &#39;close&#39; to those names for ease of comparisom.<b=
r>
<br>
So unless something odd is going on I would not expect to see any<br>
comments in here at all.<br>
<br>
Formatting wise, should be using tabs rather than spaces before the<br>
numbers.<br>
<br>
Also, we have a mixture of defines for register addresses and<br>
fields with in registers.=C2=A0 That is fine, but I would prefer<br>
the nice clear _REG postfix on the registers defines to make<br>
it more obvious which is which.<br>
<br>
e.g. What I&#39;d expect here is something like:<br>
<br>
#define ADIS16201_FLASH_CNT_REG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A00x00<br>
#define ADIS16201_SUPPLY_OUT_REG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 0x02<br>
#define ADIS16201_XACCL_OUT_REG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A00x04<br>
<br>
etc.<br>
<br>
&gt;<br>
&gt; /* Output, power supply */<br>
&gt; #define ADIS16201_SUPPLY_OUT=C2=A0 =C2=A0 =C2=A00x02<br>
<br>
The out naming is awkward given it doesn&#39;t mean the device is supplying=
 the<br>
power, but rather that this is the reading the device is outputting.=C2=A0 =
Still<br>
can&#39;t do that much about this without breaking away from datasheet nami=
ng.<br>
<br>
&gt;<br>
&gt; /* Output, x-axis accelerometer */<br>
&gt; #define ADIS16201_XACCL_OUT=C2=A0 =C2=A0 =C2=A0 0x04<br>
&gt;<br>
&gt; /* Output, y-axis accelerometer */<br>
&gt; #define ADIS16201_YACCL_OUT=C2=A0 =C2=A0 =C2=A0 0x06<br>
&gt;<br>
&gt; /* Output, auxiliary ADC input */<br>
&gt; #define ADIS16201_AUX_ADC=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x08<br>
&gt;<br>
&gt; /* Output, temperature */<br>
&gt; #define ADIS16201_TEMP_OUT=C2=A0 =C2=A0 =C2=A0 =C2=A00x0A<br>
&gt;<br>
&gt; /* Output, x-axis inclination */<br>
&gt; #define ADIS16201_XINCL_OUT=C2=A0 =C2=A0 =C2=A0 0x0C<br>
&gt;<br>
&gt; /* Output, y-axis inclination */<br>
&gt; #define ADIS16201_YINCL_OUT=C2=A0 =C2=A0 =C2=A0 0x0E<br>
&gt;<br>
&gt; /* Calibration, x-axis acceleration offset */<br>
&gt; #define ADIS16201_XACCL_OFFS=C2=A0 =C2=A0 =C2=A00x10<br>
&gt;<br>
&gt; /* Calibration, y-axis acceleration offset */<br>
&gt; #define ADIS16201_YACCL_OFFS=C2=A0 =C2=A0 =C2=A00x12<br>
&gt;<br>
&gt; /* x-axis acceleration scale factor */<br>
&gt; #define ADIS16201_XACCL_SCALE=C2=A0 =C2=A0 0x14<br>
&gt;<br>
&gt; /* y-axis acceleration scale factor */<br>
&gt; #define ADIS16201_YACCL_SCALE=C2=A0 =C2=A0 0x16<br>
&gt;<br>
&gt; /* Calibration, x-axis inclination offset */<br>
&gt; #define ADIS16201_XINCL_OFFS=C2=A0 =C2=A0 =C2=A00x18<br>
&gt;<br>
&gt; /* Calibration, y-axis inclination offset */<br>
&gt; #define ADIS16201_YINCL_OFFS=C2=A0 =C2=A0 =C2=A00x1A<br>
&gt;<br>
&gt; /* x-axis inclination scale factor */<br>
&gt; #define ADIS16201_XINCL_SCALE=C2=A0 =C2=A0 0x1C<br>
&gt;<br>
&gt; /* y-axis inclination scale factor */<br>
&gt; #define ADIS16201_YINCL_SCALE=C2=A0 =C2=A0 0x1E<br>
&gt;<br>
&gt; /* Alarm 1 amplitude threshold */<br>
&gt; #define ADIS16201_ALM_MAG1=C2=A0 =C2=A0 =C2=A0 =C2=A00x20<br>
&gt;<br>
&gt; /* Alarm 2 amplitude threshold */<br>
&gt; #define ADIS16201_ALM_MAG2=C2=A0 =C2=A0 =C2=A0 =C2=A00x22<br>
&gt;<br>
&gt; /* Alarm 1, sample period */<br>
&gt; #define ADIS16201_ALM_SMPL1=C2=A0 =C2=A0 =C2=A0 0x24<br>
&gt;<br>
&gt; /* Alarm 2, sample period */<br>
&gt; #define ADIS16201_ALM_SMPL2=C2=A0 =C2=A0 =C2=A0 0x26<br>
&gt;<br>
&gt; /* Alarm control */<br>
&gt; #define ADIS16201_ALM_CTRL=C2=A0 =C2=A0 =C2=A0 =C2=A00x28<br>
&gt;<br>
&gt; /* Auxiliary DAC data */<br>
&gt; #define ADIS16201_AUX_DAC=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x30<br>
&gt;<br>
&gt; /* General-purpose digital input/output control */<br>
&gt; #define ADIS16201_GPIO_CTRL=C2=A0 =C2=A0 =C2=A0 0x32<br>
&gt;<br>
&gt; /* Miscellaneous control */<br>
&gt; #define ADIS16201_MSC_CTRL=C2=A0 =C2=A0 =C2=A0 =C2=A00x34<br>
&gt;<br>
&gt; /* Internal sample period (rate) control */<br>
&gt; #define ADIS16201_SMPL_PRD=C2=A0 =C2=A0 =C2=A0 =C2=A00x36<br>
&gt;<br>
&gt; /* Operation, filter configuration */<br>
&gt; #define ADIS16201_AVG_CNT=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x38<br>
&gt;<br>
&gt; /* Operation, sleep mode control */<br>
&gt; #define ADIS16201_SLP_CNT=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x3A<br>
&gt;<br>
&gt; /* Diagnostics, system status register */<br>
&gt; #define ADIS16201_DIAG_STAT=C2=A0 =C2=A0 =C2=A0 0x3C<br>
&gt;<br>
&gt; /* Operation, system command register */<br>
&gt; #define ADIS16201_GLOB_CMD=C2=A0 =C2=A0 =C2=A0 =C2=A00x3E<br>
&gt;<br>
&gt; /* MSC_CTRL */<br>
&gt;<br>
A really nice convention that has come up in recent drivers and makes<br>
all these register / register field relationships obvious is to<br>
use some subtle indenting of the fields and put them next to<br>
the register address.=C2=A0 An example is:<br>
<br>
#define ADIS16201_MSC_CTRL_REG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 0x34<br>
#define=C2=A0 =C2=A0ADIS16201_MSC_CTRL_SELF_TEST_EN=C2=A0 =C2=A0 =C2=A0 =C2=
=A0BIT(8)<br>
#define=C2=A0 =C2=A0ADIS16201_MSC_CTRL_DATA_RDY_EN=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 BIT(2)<br>
#define=C2=A0 =C2=A0ADIS16201_MSC_CTRL_ACTIVE_HIGH=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 BIT(1)<br>
#define=C2=A0 =C2=A0ADIS16201_MSC_CTRL_DATA_RDY_DIO1=C2=A0 =C2=A0 =C2=A0 BI=
T(0)<br>
<br>
Again the naming of the fields is sufficient and the documentation<br>
doesn&#39;t add anything so I would drop it.<br>
<br>
&gt; /* Self-test enable */<br>
&gt; #define ADIS16201_MSC_CTRL_SELF_TEST_EN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0BIT(8)<br>
&gt;<br>
&gt; /* Data-ready enable: 1 =3D enabled, 0 =3D disabled */<br>
&gt; #define ADIS16201_MSC_CTRL_DATA_RDY_EN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 BIT(2)<br>
&gt;<br>
&gt; /* Data-ready polarity: 1 =3D active high, 0 =3D active low */<br>
&gt; #define ADIS16201_MSC_CTRL_ACTIVE_HIGH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 BIT(1)<br>
&gt;<br>
&gt; /* Data-ready line selection: 1 =3D DIO1, 0 =3D DIO0 */<br>
&gt; #define ADIS16201_MSC_CTRL_DATA_RDY_DIO1=C2=A0 =C2=A0 =C2=A0 BIT(0)<br=
>
&gt;<br>
&gt; /* DIAG_STAT */<br>
&gt;<br>
&gt; /* Alarm 2 status: 1 =3D alarm active, 0 =3D alarm inactive */<br>
&gt; #define ADIS16201_DIAG_STAT_ALARM2=C2=A0 =C2=A0 =C2=A0 =C2=A0 BIT(9)<b=
r>
&gt;<br>
&gt; /* Alarm 1 status: 1 =3D alarm active, 0 =3D alarm inactive */<br>
&gt; #define ADIS16201_DIAG_STAT_ALARM1=C2=A0 =C2=A0 =C2=A0 =C2=A0 BIT(8)<b=
r>
&gt;<br>
&gt; /* SPI communications failure */<br>
&gt; #define ADIS16201_DIAG_STAT_SPI_FAIL_BIT=C2=A0 =C2=A03<br>
&gt;<br>
&gt; /* Flash update failure */<br>
&gt; #define ADIS16201_DIAG_STAT_FLASH_UPT_BIT=C2=A0 2<br>
&gt;<br>
&gt; /* Power supply above 3.625 V */<br>
&gt; #define ADIS16201_DIAG_STAT_POWER_HIGH_BIT 1<br>
&gt;<br>
&gt; /* Power supply below 3.15 V */<br>
&gt; #define ADIS16201_DIAG_STAT_POWER_LOW_BIT=C2=A0 0<br>
&gt;<br>
&gt; /* GLOB_CMD */<br>
&gt;<br>
&gt; #define ADIS16201_GLOB_CMD_SW_RESET=C2=A0 =C2=A0BIT(7)<br>
&gt; #define ADIS16201_GLOB_CMD_FACTORY_CAL=C2=A0 =C2=A0 =C2=A0 =C2=A0 BIT(=
1)<br>
&gt;<br>
&gt; #define ADIS16201_ERROR_ACTIVE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BIT(1=
4)<br>
&gt;<br>
&gt; enum adis16201_scan {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ADIS16201_SCAN_ACC_X,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ADIS16201_SCAN_ACC_Y,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ADIS16201_SCAN_INCLI_X,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ADIS16201_SCAN_INCLI_Y,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ADIS16201_SCAN_SUPPLY,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ADIS16201_SCAN_AUX_ADC,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ADIS16201_SCAN_TEMP,<br>
&gt; };<br>
&gt;<br>
&gt; static const u8 adis16201_addresses[] =3D {<br>
<br>
It is rather odd that this is only used for the offsets, not<br>
any of the other channel specific registers (scales, or the reading itself)=
.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[ADIS16201_SCAN_ACC_X] =3D ADIS16201_XACCL_O=
FFS,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[ADIS16201_SCAN_ACC_Y] =3D ADIS16201_YACCL_O=
FFS,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[ADIS16201_SCAN_INCLI_X] =3D ADIS16201_XINCL=
_OFFS,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[ADIS16201_SCAN_INCLI_Y] =3D ADIS16201_YINCL=
_OFFS,<br>
&gt; };<br>
&gt;<br>
&gt; static int adis16201_read_raw(struct iio_dev *indio_dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct iio_chan_spec const *chan,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int *val, int *val2,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0long mask)<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct adis *st =3D iio_priv(indio_dev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int bits;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0u8 addr;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0s16 val16;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0switch (mask) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case IIO_CHAN_INFO_RAW:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return adis_sing=
le_conversion(indio_dev, chan,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ADIS16201_ERROR_ACTIVE, val);<br>
<br>
Indenting could I think make the parameters align with the opening bracket.=
<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case IIO_CHAN_INFO_SCALE:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (chan-&gt=
;type) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IIO_VOLTAGE=
:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (chan-&gt;channel =3D=3D 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val =3D 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val2 =3D 220000; /* 1.22 mV */<br=
>
<br>
Comments don&#39;t add a huge amount given they kind of just<br>
state the value before them.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0} else {<br>
<br>
Given there are only two relevant channels I would like to see<br>
them move explicitly matched using a switch statement.<br>
<br>
The default case would be an error return -EINVAL;<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val2 =3D 610000; /* 0.610 mV */<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return IIO_VAL_INT_PLUS_MICRO;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IIO_TEMP:<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0*val =3D -470; /* 0.47 C */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0*val2 =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return IIO_VAL_INT_PLUS_MICRO;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IIO_ACCEL:<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0*val =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0*val2 =3D IIO_G_TO_M_S_2(462400); /* 0.4624 mg */<br>
<br>
Not sure that comment adds anything..<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return IIO_VAL_INT_PLUS_NANO;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IIO_INCLI:<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0*val =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0*val2 =3D 100000; /* 0.1 degree */<br>
<br>
Or this one.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return IIO_VAL_INT_PLUS_MICRO;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return -EINVAL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case IIO_CHAN_INFO_OFFSET:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val =3D 25000 /=
 -470 - 1278; /* 25 C =3D 1278 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return IIO_VAL_I=
NT;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case IIO_CHAN_INFO_CALIBBIAS:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (chan-&gt=
;type) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IIO_ACCEL:<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0bits =3D 12;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IIO_INCLI:<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0bits =3D 9;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return -EINVAL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr =3D adis162=
01_addresses[chan-&gt;scan_index];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D adis_rea=
d_reg_16(st, addr, &amp;val16);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val16 &amp;=3D (=
1 &lt;&lt; bits) - 1;<br>
<br>
Given the following sign extend, I don&#39;t think this does anything usefu=
l.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val16 =3D (s16)(=
val16 &lt;&lt; (16 - bits)) &gt;&gt; (16 - bits);<br>
<br>
This looks like a 16bit sign extend to me.=C2=A0 We have functions to<br>
handle this nicely. See how it is done in other driverss<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val =3D val16;<=
br>
<br>
blank line before return always makes them more obvious and hence the<br>
code slightly more readable.=C2=A0 Do this throughout (including 2 lines<br=
>
below this)<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return IIO_VAL_I=
NT;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; }<br>
&gt;<br>
&gt; static int adis16201_write_raw(struct iio_dev *indio_dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct iio_chan_spec const *chan,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int val,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int val2,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 long mask)<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct adis *st =3D iio_priv(indio_dev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int bits;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0s16 val16;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0u8 addr;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0switch (mask) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case IIO_CHAN_INFO_CALIBBIAS:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (chan-&gt=
;type) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IIO_ACCEL:<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0bits =3D 12;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IIO_INCLI:<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0bits =3D 9;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return -EINVAL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val16 =3D val &a=
mp; ((1 &lt;&lt; bits) - 1);<br>
<br>
Given the above bits value is used only for this, why not create<br>
a mask in the switch statement instead of carrying the number of<br>
bits around.<br>
<br>
Then you can use GENMASK to make it nice and obvious what<br>
is going on.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr =3D adis162=
01_addresses[chan-&gt;scan_index];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return adis_writ=
e_reg_16(st, addr, val16);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; }<br>
&gt;<br>
&gt; static const struct iio_chan_spec adis16201_channels[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ADIS_SUPPLY_CHAN(ADIS16201_SUPPLY_OUT, ADIS1=
6201_SCAN_SUPPLY, 0, 12),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ADIS_TEMP_CHAN(ADIS16201_TEMP_OUT, ADIS16201=
_SCAN_TEMP, 0, 12),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ADIS_ACCEL_CHAN(X, ADIS16201_XACCL_OUT, ADIS=
16201_SCAN_ACC_X,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ADIS_ACCEL_CHAN(Y, ADIS16201_YACCL_OUT, ADIS=
16201_SCAN_ACC_Y,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC, ADIS162=
01_SCAN_AUX_ADC, 0, 12),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ADIS_INCLI_CHAN(X, ADIS16201_XINCL_OUT, ADIS=
16201_SCAN_INCLI_X,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ADIS_INCLI_CHAN(X, ADIS16201_YINCL_OUT, ADIS=
16201_SCAN_INCLI_Y,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0IIO_CHAN_SOFT_TIMESTAMP(7)<br>
&gt; };<br>
&gt;<br>
&gt; static const struct iio_info adis16201_info =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.read_raw =3D adis16201_read_raw,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.write_raw =3D adis16201_write_raw,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.update_scan_mode =3D adis_update_scan_mode,=
<br>
&gt; };<br>
&gt;<br>
&gt; static const char * const adis16201_status_error_msgs[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[ADIS16201_DIAG_STAT_SPI_FAIL_BIT] =3D &quot=
;SPI failure&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[ADIS16201_DIAG_STAT_FLASH_UPT_BIT] =3D &quo=
t;Flash update failed&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[ADIS16201_DIAG_STAT_POWER_HIGH_BIT] =3D &qu=
ot;Power supply above 3.625V&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[ADIS16201_DIAG_STAT_POWER_LOW_BIT] =3D &quo=
t;Power supply below 3.15V&quot;,<br>
&gt; };<br>
&gt;<br>
&gt; static const struct adis_data adis16201_data =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.read_delay =3D 20,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.msc_ctrl_reg =3D ADIS16201_MSC_CTRL,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.glob_cmd_reg =3D ADIS16201_GLOB_CMD,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.diag_stat_reg =3D ADIS16201_DIAG_STAT,<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.self_test_mask =3D ADIS16201_MSC_CTRL_SELF_=
TEST_EN,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.self_test_no_autoclear =3D true,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.startup_delay =3D ADIS16201_STARTUP_DELAY,<=
br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.status_error_msgs =3D adis16201_status_erro=
r_msgs,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.status_error_mask =3D BIT(ADIS16201_DIAG_ST=
AT_SPI_FAIL_BIT) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(ADIS16201_DI=
AG_STAT_FLASH_UPT_BIT) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(ADIS16201_DI=
AG_STAT_POWER_HIGH_BIT) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(ADIS16201_DI=
AG_STAT_POWER_LOW_BIT),<br>
&gt; };<br>
&gt;<br>
&gt; static int adis16201_probe(struct spi_device *spi)<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct adis *st;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct iio_dev *indio_dev;<br>
There is a convention (when nothing else is guiding ordering) of doing<br>
things in reverse Christmas tree.<br>
<br>
That means longest line first and shortest last.=C2=A0 Very minor point tho=
ugh.<br>
<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* setup the industrialio driver allocated e=
lements */<br>
<br>
Comment doesn&#39;t really add anything so drop it.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev =3D devm_iio_device_alloc(&amp;spi=
-&gt;dev, sizeof(*st));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!indio_dev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<=
br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0st =3D iio_priv(indio_dev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* this is only used for removal purposes */=
<br>
<br>
Again, comment isn&#39;t really that useful...<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0spi_set_drvdata(spi, indio_dev);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev-&gt;name =3D spi-&gt;dev.driver-&g=
t;name;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev-&gt;dev.parent =3D &amp;spi-&gt;de=
v;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev-&gt;info =3D &amp;adis16201_info;<=
br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev-&gt;channels =3D adis16201_channel=
s;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev-&gt;num_channels =3D ARRAY_SIZE(ad=
is16201_channels);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev-&gt;modes =3D INDIO_DIRECT_MODE;<b=
r>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D adis_init(st, indio_dev, spi, &amp;a=
dis16201_data);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
<br>
A blank line here would help readability by separating these two<br>
unconnected operations.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D adis_setup_buffer_and_trigger(st, in=
dio_dev, NULL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Get the device into a sane initial state =
*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D adis_initial_startup(st);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error_clean=
up_buffer_trigger;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D iio_device_register(indio_dev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error_clean=
up_buffer_trigger;<br>
<br>
Blank line here.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;<br>
&gt; error_cleanup_buffer_trigger:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0adis_cleanup_buffer_and_trigger(st, indio_de=
v);<br>
<br>
blank line here.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; }<br>
&gt;<br>
&gt; static int adis16201_remove(struct spi_device *spi)<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct iio_dev *indio_dev =3D spi_get_drvdat=
a(spi);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct adis *st =3D iio_priv(indio_dev);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0iio_device_unregister(indio_dev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0adis_cleanup_buffer_and_trigger(st, indio_de=
v);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; }<br>
&gt;<br>
&gt; static struct spi_driver adis16201_driver =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.driver =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =3D &quot;=
adis16201&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.probe =3D adis16201_probe,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.remove =3D adis16201_remove,<br>
&gt; };<br>
&gt; module_spi_driver(adis16201_driver);<br>
<br>
Probably want to add devicetree bindings but not strictly necessary to<br>
move out of staging...<br>
<br>
&gt;<br>
&gt; MODULE_AUTHOR(&quot;Barry Song &lt;<a href=3D"mailto:21cnbao@gmail.com=
" target=3D"_blank">21cnbao@gmail.com</a>&gt;&quot;);<br>
&gt; MODULE_DESCRIPTION(&quot;Analog Devices ADIS16201 Dual-Axis Digital In=
clinometer and Accelerometer&quot;);<br>
&gt; MODULE_LICENSE(&quot;GPL v2&quot;);<br>
&gt; MODULE_ALIAS(&quot;spi:adis16201&quot;);<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-iio&qu=
ot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org" targe=
t=3D"_blank">majordomo@vger.kernel.org</a><br>
More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" rel=3D"noreferrer" target=3D"_blank">http://vger.kernel.org/majord=
omo-info.html</a><br>
</blockquote></div></div></div>

--001a113d2e72fe55440564764eb2--
