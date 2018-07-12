Return-Path: <SRS0=bvs1=J4=huawei.com=jonathan.cameron@kernel.org>
Date: Thu, 12 Jul 2018 14:28:53 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Matt Ranostay <matt.ranostay@konsulko.com>
CC: Himanshu Jha <himanshujha199640@gmail.com>, Jonathan Cameron
	<jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen
	<lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	<linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>, Daniel Baluta
	<daniel.baluta@gmail.com>
Subject: Re: [PATCH v3] iio: chemical: Add support for Bosch BME680 sensor
Message-ID: <20180712142853.00005f64@huawei.com>
In-Reply-To: <CAJCx=g=ud98YWOAhepZOV_D_s8pfNx_PnyXis=WjX1O_XkzRvQ@mail.gmail.com>
References: <1531311229-3586-1-git-send-email-himanshujha199640@gmail.com>
	<CAJCx=g=ud98YWOAhepZOV_D_s8pfNx_PnyXis=WjX1O_XkzRvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-ID: <linux-iio@vger.kernel.org>

On Wed, 11 Jul 2018 17:40:07 -0700
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> On Wed, Jul 11, 2018 at 5:13 AM, Himanshu Jha
> <himanshujha199640@gmail.com> wrote:
> > Bosch BME680 is a 4-in-1 sensor with temperature, pressure, humidity
> > and gas sensing capability. It supports both I2C and SPI communication
> > protocol for effective data communication.
> >
> > The device supports two modes:
> >
> > 1. Sleep mode
> > 2. Forced mode
> >
> > The measurements only takes place when forced mode is triggered and a
> > single TPHG cycle is performed by the sensor. The sensor automatically
> > goes to sleep after afterwards.
> >
> > The device has various calibration constants/parameters programmed into
> > devices' non-volatile memory(NVM) during production and can't be altered
> > by the user. These constants are used in the compensation functions to
> > get the required compensated readings along with the raw data. The
> > compensation functions/algorithms are provided by Bosch Sensortec GmbH
> > via their API[1]. As these don't change during the measurement cycle,
> > therefore we read and store them at the probe. The default configs
> > supplied by Bosch are also set at probe.
> >
> > 0-day tested with build success.
> >
> > GSoC-2018: https://summerofcode.withgoogle.com/projects/#6691473790074880
> > Mentor: Daniel Baluta
> > [1] https://github.com/BoschSensortec/BME680_driver
> > Datasheet:
> > https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BME680-DS001-00.pdf
> >
> > Cc: Daniel Baluta <daniel.baluta@gmail.com>
> > Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> > ---
> >
> > v3:
> >    -moved files to chemical directory instead of a dedicated directory.
> >    -read calibration parameters serially with endian conversions.
> >    -drop some return ret.
> >    -removed few unnecessary casts safely.
> >    -added 'u' suffix to explicitly specify unsigned for large values
> >     and thereby fixing comiler warning.
> >    -left aligned all comments.
> >    -added a comment explaining heater stability failure.
> >
> > v2:
> >    -Used devm_add_action() to add a generic remove method for
> >     both I2C & SPI driver.
> >    -Introduction of compensation functions.
> >    -chip initialisation routines moved to respective I2C and SPI
> >     driver.
> >    -Introduction of gas sensing rountines.
> >    -Simplified Kconfig to reduce various options.
> >
> >  drivers/iio/chemical/Kconfig       |  25 +
> >  drivers/iio/chemical/Makefile      |   3 +
> >  drivers/iio/chemical/bme680.h      |  99 ++++
> >  drivers/iio/chemical/bme680_core.c | 946 +++++++++++++++++++++++++++++++++++++
> >  drivers/iio/chemical/bme680_i2c.c  |  83 ++++
> >  drivers/iio/chemical/bme680_spi.c  | 123 +++++
> >  6 files changed, 1279 insertions(+)
> >  create mode 100644 drivers/iio/chemical/bme680.h
> >  create mode 100644 drivers/iio/chemical/bme680_core.c
> >  create mode 100644 drivers/iio/chemical/bme680_i2c.c
> >  create mode 100644 drivers/iio/chemical/bme680_spi.c
> >
> > diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
> > index 5cb5be7..24790a8 100644
> > --- a/drivers/iio/chemical/Kconfig
> > +++ b/drivers/iio/chemical/Kconfig
> > @@ -21,6 +21,31 @@ config ATLAS_PH_SENSOR
> >          To compile this driver as module, choose M here: the
> >          module will be called atlas-ph-sensor.
> >
> > +config BME680
> > +       tristate "Bosch Sensortec BME680 sensor driver"
> > +       depends on (I2C || SPI)
> > +       select REGMAP
> > +       select BME680_I2C if (I2C)
> > +       select BME680_SPI if (SPI)  
> 
> Don't think you actually need parentheses around any of these, but of
> course then again doesn't hurt

Nice to tidy this one up, though if it is all there is I can do that whilst
applying.  So don't bother sending a v4 for this until other reviews are in.

> 
> > +       help
> > +         Say yes here to build support for Bosch Sensortec BME680 sensor with
> > +         temperature, pressure, humidity and gas sensing capability.
> > +
> > +         This driver can also be built as a module. If so, the module for I2C
> > +         would be called bme680_i2c and bme680_spi for SPI support.
> > +
> > +config BME680_I2C
> > +       tristate
> > +       depends on BME680
> > +       depends on I2C  
> 
> Wouldn't  "depends on I2C && BME680"  be cleaner?  Maybe someone else
> here can tell me if I'm too nit-picky :)

You said it ;)  Can't say I care either way on these.

> 
> > +       select REGMAP_I2C
> > +
> > +config BME680_SPI
> > +       tristate
> > +       depends on BME680
> > +       depends on SPI  
> 
> Same only with SPI
> 
> > +       select REGMAP_SPI
> > +
> >  config CCS811
> >         tristate "AMS CCS811 VOC sensor"
> >         depends on I2C
...

Matt, please give us indication if you don't have anything else to say :)
Saves on a lot of scrolling and wondering if we missed something (which
of course I might have done!)
