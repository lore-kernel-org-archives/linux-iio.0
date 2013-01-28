Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:47148 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754001Ab3A1VcY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 Jan 2013 16:32:24 -0500
Message-ID: <5106EEBF.9020401@metafoo.de>
Date: Mon, 28 Jan 2013 22:33:51 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Marek Vasut <marex@denx.de>
CC: linux-iio@vger.kernel.org, Martin Liska <marxin.liska@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH V4] iio: acpi: Add ACPI0008 ALS driver
References: <1359250167-782-1-git-send-email-marex@denx.de> <510686E7.3050605@metafoo.de> <201301281919.22795.marex@denx.de>
In-Reply-To: <201301281919.22795.marex@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/28/2013 07:19 PM, Marek Vasut wrote:
> Dear Lars-Peter Clausen,
> 
>> On 01/27/2013 02:29 AM, Marek Vasut wrote:
>>> From: Martin Liska <marxin.liska@gmail.com>
>>>
>>> Add basic implementation of the ACPI0008 Ambient Light Sensor driver.
>>> This driver currently supports only the ALI property, yet is ready to
>>> be easily extended to handle ALC, ALT, ALP ones as well.
>>>
>>> Signed-off-by: Martin Liska <marxin.liska@gmail.com>
>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>> Cc: Jonathan Cameron <jic23@kernel.org>
>>> Cc: Zhang Rui <rui.zhang@intel.com>
>>
>> Hi,
>>
>> Looks good, except for the trigger/buffer support.
> 
> I'm not quite firm on that one either.
> 
>> Which for one can't be
>> enabled since you didn't set the INDIO_BUFFER_TRIGGERED mode flag. But also
>> the implementation itself seems to have a few rough edges.
> 
> Good catch.
> 
>>> ---
>>>
>>>  drivers/staging/iio/light/Kconfig    |   10 ++
>>>  drivers/staging/iio/light/Makefile   |    1 +
>>>  drivers/staging/iio/light/acpi-als.c |  320
>>>  ++++++++++++++++++++++++++++++++++ 3 files changed, 331 insertions(+)
>>>  create mode 100644 drivers/staging/iio/light/acpi-als.c
>>>
>>> V2: Fix the channel mask, so it's really reading RAW data.
>>> V3: Put scan timestamp into the buffer only when enabled,
>>>
>>>     Set the light sensor ID to 0 instead of 1
>>>
>>> V4: Select IIO_TRIGGERED_BUFFER as we need it here
>>>
>>> diff --git a/drivers/staging/iio/light/Kconfig
>>> b/drivers/staging/iio/light/Kconfig index 4bed30e..9c3d146 100644
>>> --- a/drivers/staging/iio/light/Kconfig
>>> +++ b/drivers/staging/iio/light/Kconfig
>>> @@ -50,4 +50,14 @@ config TSL2x7x
>>>
>>>  	 tmd2672, tsl2772, tmd2772 devices.
>>>  	 Provides iio_events and direct access via sysfs.
>>>
>>> +config ACPI_ALS
>>> +	tristate "ACPI Ambient Light Sensor"
>>> +	depends on ACPI
>>> +	select IIO_TRIGGERED_BUFFER
>>> +	help
>>> +	 Support for the ACPI0008 Ambient Light Sensor.
>>> +
>>> +	 This driver can also be built as a module.  If so, the module
>>> +	 will be called acpi-als.
>>> +
>>
>> Keep the entries in alphabetical order.
> 
> Fixed in my tree
> 
>>>  endmenu
>>>
>>> diff --git a/drivers/staging/iio/light/Makefile
>>> b/drivers/staging/iio/light/Makefile index 141af1e..13090e6 100644
>>> --- a/drivers/staging/iio/light/Makefile
>>> +++ b/drivers/staging/iio/light/Makefile
>>> @@ -7,3 +7,4 @@ obj-$(CONFIG_SENSORS_ISL29018)	+= isl29018.o
>>>
>>>  obj-$(CONFIG_SENSORS_ISL29028)	+= isl29028.o
>>>  obj-$(CONFIG_TSL2583)	+= tsl2583.o
>>>  obj-$(CONFIG_TSL2x7x)	+= tsl2x7x_core.o
>>>
>>> +obj-$(CONFIG_ACPI_ALS)	+= acpi-als.o
>>
>> Same here.
> 
> Fixed.
> 
>>> diff --git a/drivers/staging/iio/light/acpi-als.c
>>> b/drivers/staging/iio/light/acpi-als.c new file mode 100644
>>> index 0000000..6140613
>>> --- /dev/null
>>> +++ b/drivers/staging/iio/light/acpi-als.c
>>> @@ -0,0 +1,320 @@
>>
>> [...]
>>
>>> +
>>> +static void acpi_als_notify(struct acpi_device *device, u32 event)
>>> +{
>>> +	struct iio_dev *iio = acpi_driver_data(device);
>>> +	struct acpi_als *als = iio_priv(iio);
>>> +	uint16_t *buffer = als->evt_buffer;
>>> +	s64 time_ns = iio_get_time_ns();
>>> +
>>> +	mutex_lock(&als->lock);
>>> +
>>> +	memset(buffer, 0, als->evt_buffer_len);
>>> +
>>> +	switch (event) {
>>> +	case ACPI_ALS_NOTIFY_ILLUMINANCE:
>>> +		*buffer++ = als_read_value(als, ACPI_ALS_ILLUMINANCE);
>>> +		break;
>>> +	default:
>>> +		/* Unhandled event */
>>> +		dev_dbg(&device->dev, "Unhandled ACPI ALS event (%08x)!\n",
>>> +			event);
>>> +		return;
>>> +	}
>>> +
>>> +	if (iio->scan_timestamp)
>>> +		*(s64 *)ALIGN((uintptr_t)buffer, sizeof(s64)) = time_ns;
>>> +
>>> +	if (iio_buffer_enabled(iio))
>>> +		iio_push_to_buffer(iio->buffer, (uint8_t *)als->evt_buffer);
>>> +
>>
>> Normally you'd call iio_trigger_poll here and have the buffer handling in
>> acpi_als_trigger_handler. This allows you for example to use other
>> triggers, e.g. a timer based trigger.
> 
> Good, but this is not called from interrupt context. I recall there was a 
> discussion about this and IRQ context issues.

Hm, yes. This is indeed a problem and I guess we really need to fix this at
somepoint in the IIO core. In the sysfs trigger we use a irq_work to call
iio_trigger_poll from IRQ context. Which is a bit hackish, but it works fine
for the moment, but on the long run we really need to find a better solution.
But I guess you could use it for now.

[...]
>>> +	iio->name = ACPI_ALS_DEVICE_NAME;
>>> +	iio->dev.parent = dev;
>>> +	iio->info = &acpi_als_info;
>>> +	iio->modes = INDIO_DIRECT_MODE;
>>
>> INDIO_BUFFER_TRIGGERED
> 
> Will this not mess up the RAW mode? Or do you mean:
> 
> iio->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;

Yes, that's what I meant.

- Lars

