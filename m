Return-Path: <SRS0=R/eT=II=metafoo.de=lars@kernel.org>
Subject: Re: [PATCH 0/9] ACPI/i2c Enumerate several instances out of one
 fwnode
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki"
 <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Wolfram Sang <wsa@the-dreams.de>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org,
 Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
References: <20180520132857.8103-1-hdegoede@redhat.com>
 <f9fc420005d926b2d35854331ec0288d3a98c925.camel@linux.intel.com>
 <336cb6d4-5797-8787-21dd-d816f994cce9@redhat.com>
 <81114e50a1e07763f1645201e42b80a6fc9f33a1.camel@linux.intel.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <0459ced0-ab24-c58e-5d4a-b7b545232252@metafoo.de>
Date: Mon, 21 May 2018 15:31:47 +0200
MIME-Version: 1.0
In-Reply-To: <81114e50a1e07763f1645201e42b80a6fc9f33a1.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 05/21/2018 03:13 PM, Andy Shevchenko wrote:
> On Mon, 2018-05-21 at 14:34 +0200, Hans de Goede wrote:
>> On 21-05-18 11:19, Andy Shevchenko wrote:
> 
>>>> Patches 6-9 use the new functionality creating  one i2c-client per
>>>> I2cSerialBusV2 resource to make the sensor cluster on the HP X2
>>>> work
>>>> and
>>>> are posted as part of this series to show how this functionality
>>>> can
>>>> be
>>>> used.
>>>
>>> I suppose it's better to do an "MFD" type of IIO driver for that
>>> chip.
>>> Check, for example, drivers/iio/imu/bmi160/bmi160_core.c
>>
>> That seems to be a single chip listening on a single i2c address / spi
>> chip-select.
> 
> Ooops, wrong reference.
> 
>> In the BSG1160 case the 3 sensors are listening on 3 different i2c
>> addresses.
> 
> There is a Bosh magnetometer + accelerometer chip (BMC150). We have just
> two independent drivers for them. Luckily for ACPI they have different
> IDs (on the platforms where it's used like that).
> 
> So, my series targeting the series of same IPs under one device...
> 
>> We could use the drivers/mfd framework, but the we get platform
>> devices
>> and we would need to patch all 3 existing drivers to support platform
>> bindings and get a regmap from there (converting them to regmap where
>> necessary).
> 
> ...and in your case MFD sounds better. Though why do you need to have a
> common regmap?

I'm not convinced MFD is the right place. You wouldn't really utilize
anything of the MFD subsystem. And in a sense it is not a multi-function
device. It's just multiple devices that are described by the same firmware
description table entry.

But I think some kind of board driver might be useful here that translates
the ACPI description into something more reasonable. I.e. bind to the ACPI
ID and then instantiate the 3 child I2C devices on the same bus. Those do
not have to be platform drivers and you do not have to use regmap.

The current approach adds board specific workarounds to each of the device
drivers. It might be easier to have that managed in a central place.

The problem with ACPI is that the description in the tables is often for
vendor device drivers that ship together with the hardware. If you want to
use the same tables with upstream drivers some kind of translation table
might be required.
