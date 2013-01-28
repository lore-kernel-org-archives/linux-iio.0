Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:44743 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143Ab3A1STc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 Jan 2013 13:19:32 -0500
From: Marek Vasut <marex@denx.de>
To: "Lars-Peter Clausen" <lars@metafoo.de>
Subject: Re: [PATCH V4] iio: acpi: Add ACPI0008 ALS driver
Date: Mon, 28 Jan 2013 19:19:22 +0100
Cc: linux-iio@vger.kernel.org, Martin Liska <marxin.liska@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>
References: <1359250167-782-1-git-send-email-marex@denx.de> <510686E7.3050605@metafoo.de>
In-Reply-To: <510686E7.3050605@metafoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201301281919.22795.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear Lars-Peter Clausen,

> On 01/27/2013 02:29 AM, Marek Vasut wrote:
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
> 
> Hi,
> 
> Looks good, except for the trigger/buffer support.

I'm not quite firm on that one either.

> Which for one can't be
> enabled since you didn't set the INDIO_BUFFER_TRIGGERED mode flag. But also
> the implementation itself seems to have a few rough edges.

Good catch.

> > ---
> > 
> >  drivers/staging/iio/light/Kconfig    |   10 ++
> >  drivers/staging/iio/light/Makefile   |    1 +
> >  drivers/staging/iio/light/acpi-als.c |  320
> >  ++++++++++++++++++++++++++++++++++ 3 files changed, 331 insertions(+)
> >  create mode 100644 drivers/staging/iio/light/acpi-als.c
> > 
> > V2: Fix the channel mask, so it's really reading RAW data.
> > V3: Put scan timestamp into the buffer only when enabled,
> > 
> >     Set the light sensor ID to 0 instead of 1
> > 
> > V4: Select IIO_TRIGGERED_BUFFER as we need it here
> > 
> > diff --git a/drivers/staging/iio/light/Kconfig
> > b/drivers/staging/iio/light/Kconfig index 4bed30e..9c3d146 100644
> > --- a/drivers/staging/iio/light/Kconfig
> > +++ b/drivers/staging/iio/light/Kconfig
> > @@ -50,4 +50,14 @@ config TSL2x7x
> > 
> >  	 tmd2672, tsl2772, tmd2772 devices.
> >  	 Provides iio_events and direct access via sysfs.
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
> 
> Keep the entries in alphabetical order.

Fixed in my tree

> >  endmenu
> > 
> > diff --git a/drivers/staging/iio/light/Makefile
> > b/drivers/staging/iio/light/Makefile index 141af1e..13090e6 100644
> > --- a/drivers/staging/iio/light/Makefile
> > +++ b/drivers/staging/iio/light/Makefile
> > @@ -7,3 +7,4 @@ obj-$(CONFIG_SENSORS_ISL29018)	+= isl29018.o
> > 
> >  obj-$(CONFIG_SENSORS_ISL29028)	+= isl29028.o
> >  obj-$(CONFIG_TSL2583)	+= tsl2583.o
> >  obj-$(CONFIG_TSL2x7x)	+= tsl2x7x_core.o
> > 
> > +obj-$(CONFIG_ACPI_ALS)	+= acpi-als.o
> 
> Same here.

Fixed.

> > diff --git a/drivers/staging/iio/light/acpi-als.c
> > b/drivers/staging/iio/light/acpi-als.c new file mode 100644
> > index 0000000..6140613
> > --- /dev/null
> > +++ b/drivers/staging/iio/light/acpi-als.c
> > @@ -0,0 +1,320 @@
> 
> [...]
> 
> > +
> > +static void acpi_als_notify(struct acpi_device *device, u32 event)
> > +{
> > +	struct iio_dev *iio = acpi_driver_data(device);
> > +	struct acpi_als *als = iio_priv(iio);
> > +	uint16_t *buffer = als->evt_buffer;
> > +	s64 time_ns = iio_get_time_ns();
> > +
> > +	mutex_lock(&als->lock);
> > +
> > +	memset(buffer, 0, als->evt_buffer_len);
> > +
> > +	switch (event) {
> > +	case ACPI_ALS_NOTIFY_ILLUMINANCE:
> > +		*buffer++ = als_read_value(als, ACPI_ALS_ILLUMINANCE);
> > +		break;
> > +	default:
> > +		/* Unhandled event */
> > +		dev_dbg(&device->dev, "Unhandled ACPI ALS event (%08x)!\n",
> > +			event);
> > +		return;
> > +	}
> > +
> > +	if (iio->scan_timestamp)
> > +		*(s64 *)ALIGN((uintptr_t)buffer, sizeof(s64)) = time_ns;
> > +
> > +	if (iio_buffer_enabled(iio))
> > +		iio_push_to_buffer(iio->buffer, (uint8_t *)als->evt_buffer);
> > +
> 
> Normally you'd call iio_trigger_poll here and have the buffer handling in
> acpi_als_trigger_handler. This allows you for example to use other
> triggers, e.g. a timer based trigger.

Good, but this is not called from interrupt context. I recall there was a 
discussion about this and IRQ context issues.

> > +	mutex_unlock(&als->lock);
> > +}
> 
> [...]
> 
> > +
> > +static int acpi_als_trigger_init(struct iio_dev *iio)
> > +{
> > +	struct iio_trigger *trig;
> > +	int ret;
> > +
> > +	trig = iio_trigger_alloc("%s-dev%i", iio->name, iio->id);
> > +	if (!trig)
> > +		return -ENOMEM;
> > +
> > +	trig->dev.parent = iio->dev.parent;
> > +	trig->private_data = iio;
> > +	trig->ops = &acpi_als_trigger_ops;
> > +
> > +	ret = iio_trigger_register(trig);
> > +	if (ret) {
> > +		iio_trigger_free(trig);
> > +		return ret;
> > +	}
> > +
> > +	iio->trig = trig;
> 
> als->trig = trig;

Fixed.

> > +
> > +	return 0;
> > +}
> > +
> > +static void acpi_als_trigger_remove(struct iio_dev *iio)
> > +{
> > +	iio_trigger_unregister(iio->trig);
> > +	iio_trigger_free(iio->trig);
> 
> iio->trig, is the trigger that is currently assigned to the device. You
> should really use als->trig here.

Fixed.

> > +}
> > +
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
> > +	if (!iio) {
> > +		dev_err(dev, "Failed to allocate IIO device\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	als = iio_priv(iio);
> > +
> > +	device->driver_data = iio;
> > +	als->device = device;
> > +	als->evt_buffer = evt_buffer;
> > +	mutex_init(&als->lock);
> > +
> > +	iio->name = ACPI_ALS_DEVICE_NAME;
> > +	iio->dev.parent = dev;
> > +	iio->info = &acpi_als_info;
> > +	iio->modes = INDIO_DIRECT_MODE;
> 
> INDIO_BUFFER_TRIGGERED

Will this not mess up the RAW mode? Or do you mean:

iio->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;

[...]

Thanks for the review. Now it seems we need to iron out the tougher parts -- 
like this stuff above and the iio_push_to_buffer(). I'd be glad if you could 
provide me with some assistance on that. I'll roll out V5 once we're clear on 
those.

Thanks!
