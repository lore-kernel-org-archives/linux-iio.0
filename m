Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: "Lars-Peter Clausen" <lars@metafoo.de>
Subject: Re: [PATCH V5] iio: acpi: Add ACPI0008 ALS driver
Date: Mon, 30 Sep 2013 01:41:32 +0200
Cc: linux-iio@vger.kernel.org,
 Martin Liska <marxin.liska@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>
References: <1374364717-10040-1-git-send-email-marex@denx.de> <5228D834.4060505@metafoo.de>
In-Reply-To: <5228D834.4060505@metafoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201309300141.32606.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

Dear Lars-Peter Clausen,

> On 07/21/2013 01:58 AM, Marek Vasut wrote:
> > From: Martin Liska <marxin.liska@gmail.com>
> > 
> > Add basic implementation of the ACPI0008 Ambient Light Sensor driver.
> > This driver currently supports only the ALI property, yet is ready to
> > be easily extended to handle ALC, ALT, ALP ones as well.
> > 
> > Signed-off-by: Martin Liska <marxin.liska@gmail.com>
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > ---
> > 
> >   drivers/staging/iio/light/Kconfig    |   10 ++
> >   drivers/staging/iio/light/Makefile   |    1 +
> >   drivers/staging/iio/light/acpi-als.c |  326
> >   ++++++++++++++++++++++++++++++++++
> 
> New IIO drivers should go to drivers/iio not drivers/staging/iio
> 
> >   3 files changed, 337 insertions(+)
> >   create mode 100644 drivers/staging/iio/light/acpi-als.c
> > 
> > V2: Fix the channel mask, so it's really reading RAW data.
> > V3: Put scan timestamp into the buffer only when enabled,
> > 
> >      Set the light sensor ID to 0 instead of 1
> > 
> > V4: Select IIO_TRIGGERED_BUFFER as we need it here
> > V5: Use irq_work to trigger the buffer
> > 
> >      Use module_acpi_driver()
> > 
> > diff --git a/drivers/staging/iio/light/Kconfig
> > b/drivers/staging/iio/light/Kconfig index ca8d6e6..0238a7f 100644
> > --- a/drivers/staging/iio/light/Kconfig
> > +++ b/drivers/staging/iio/light/Kconfig
> > @@ -3,6 +3,16 @@
> > 
> >   #
> >   menu "Light sensors"
> > 
> > +config ACPI_ALS
> > +	tristate "ACPI Ambient Light Sensor"
> > +	depends on ACPI
> > +	select IIO_TRIGGERED_BUFFER
> > +	help
> > +	 Support for the ACPI0008 Ambient Light Sensor.
> > +
> > +	 This driver can also be built as a module.  If so, the module
> > +	 will be called acpi-als.
> > +
> > 
> >   config SENSORS_ISL29018
> >   
> >   	tristate "ISL 29018 light and proximity sensor"
> >   	depends on I2C
> > 
> > diff --git a/drivers/staging/iio/light/Makefile
> > b/drivers/staging/iio/light/Makefile index 9960fdf..a3f68bc 100644
> > --- a/drivers/staging/iio/light/Makefile
> > +++ b/drivers/staging/iio/light/Makefile
> > @@ -2,6 +2,7 @@
> > 
> >   # Makefile for industrial I/O Light sensors
> >   #
> > 
> > +obj-$(CONFIG_ACPI_ALS)	+= acpi-als.o
> > 
> >   obj-$(CONFIG_SENSORS_ISL29018)	+= isl29018.o
> >   obj-$(CONFIG_SENSORS_ISL29028)	+= isl29028.o
> >   obj-$(CONFIG_TSL2583)	+= tsl2583.o
> > 
> > diff --git a/drivers/staging/iio/light/acpi-als.c
> > b/drivers/staging/iio/light/acpi-als.c new file mode 100644
> > index 0000000..f63427c
> > --- /dev/null
> > +++ b/drivers/staging/iio/light/acpi-als.c
> > @@ -0,0 +1,326 @@
> 
> [...]
> 
> > +static void acpi_als_notify(struct acpi_device *device, u32 event)
> > +{
> > +	struct iio_dev *iio = acpi_driver_data(device);
> > +	struct acpi_als *als = iio_priv(iio);
> > +	s64 time_ns = iio_get_time_ns();
> > +
> > +	mutex_lock(&als->lock);
> 
> Hm, so you lock the mutex here and unlock the mutex
> acpi_als_trigger_handler. This really needs some explanation. You also
> need to implement validate_trigger and validate_device callbacks to make
> sure that this trigger is only used with this device and vice versa.

This is true. I trigger the IRQ handler below here, which in turn calls 
iio_trigger_poll() . This starts the trigger handler and upon it's completion, 
the mutex is unlocked.

The problem I just noticed here is that if the iio buffer is disabled, this will 
deadlock. Nice :-/

> > +
> > +	if (iio_buffer_enabled(iio)) {
> > +		als->evt_time = time_ns;
> > +		als->evt_event = event;
> > +		irq_work_queue(&als->work);
> > +	}
> > +}
> > +
> > +static int acpi_als_read_raw(struct iio_dev *iio,
> > +			struct iio_chan_spec const *chan, int *val,
> > +			int *val2, long mask)
> > +{
> > +	struct acpi_als *als = iio_priv(iio);
> > +
> > +	if (mask != IIO_CHAN_INFO_RAW)
> > +		return -EINVAL;
> > +
> > +	/* we support only illumination (_ALI) so far. */
> > +	if (chan->type != IIO_LIGHT)
> > +		return -EINVAL;
> 
> Since you only registered a IIO_LIGHT channel with a RAW property this
> function will never be called with anything else, so strictly speaking the
> checks above are unnecessary.

The plan is to implement all of the ACPI 0008 spec , so the check will hopefully 
later morph to switch() {} statement for all the channels.

> > +
> > +	*val = als_read_value(als, ACPI_ALS_ILLUMINANCE);
> > +	return IIO_VAL_INT;
> > +}
> 
> [..]
> 
> > +static int acpi_als_add(struct acpi_device *device)
> > +{
> > +	struct acpi_als *als;
> > +	struct iio_dev *iio;
> > +	struct device *dev = &device->dev;
> > +	int ret;
> > +
> > +	/*
> > +	 * The event buffer contains timestamp and all the data from
> > +	 * the ACPI0008 block. There are multiple, but so far we only
> > +	 * support _ALI (illuminance). Yes, we're ready for more!
> > +	 */
> > +	uint16_t *evt_buffer;
> > +	const unsigned int evt_sources = 1;
> > +	const unsigned int evt_buffer_size = sizeof(int64_t) +
> > +				(sizeof(uint16_t) * evt_sources);
> > +
> > +	evt_buffer = devm_kzalloc(dev, evt_buffer_size, GFP_KERNEL);
> > +	if (!evt_buffer)
> > +		return -ENOMEM;
> > +
> > +	iio = iio_device_alloc(sizeof(*als));
> 
> devm_...
> 
> [...]

devm_iio_device_alloc()? I don't see this stuff in next/master anywhere. Where 
is this supposed to be?
