Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37569 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751178AbeEUNkQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 May 2018 09:40:16 -0400
Received: by mail-wm0-f68.google.com with SMTP id l1-v6so26743331wmb.2
        for <linux-iio@vger.kernel.org>; Mon, 21 May 2018 06:40:16 -0700 (PDT)
Subject: Re: [PATCH 0/9] ACPI/i2c Enumerate several instances out of one
 fwnode
To: Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Jonathan Cameron <jic23@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
References: <20180520132857.8103-1-hdegoede@redhat.com>
 <f9fc420005d926b2d35854331ec0288d3a98c925.camel@linux.intel.com>
 <336cb6d4-5797-8787-21dd-d816f994cce9@redhat.com>
 <81114e50a1e07763f1645201e42b80a6fc9f33a1.camel@linux.intel.com>
 <0459ced0-ab24-c58e-5d4a-b7b545232252@metafoo.de>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <a5fdf323-c0af-dc7f-018b-eeec90c5b05e@redhat.com>
Date: Mon, 21 May 2018 15:40:13 +0200
MIME-Version: 1.0
In-Reply-To: <0459ced0-ab24-c58e-5d4a-b7b545232252@metafoo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On 21-05-18 15:31, Lars-Peter Clausen wrote:
> On 05/21/2018 03:13 PM, Andy Shevchenko wrote:
>> On Mon, 2018-05-21 at 14:34 +0200, Hans de Goede wrote:
>>> On 21-05-18 11:19, Andy Shevchenko wrote:
>>
>>>>> Patches 6-9 use the new functionality creating  one i2c-client per
>>>>> I2cSerialBusV2 resource to make the sensor cluster on the HP X2
>>>>> work
>>>>> and
>>>>> are posted as part of this series to show how this functionality
>>>>> can
>>>>> be
>>>>> used.
>>>>
>>>> I suppose it's better to do an "MFD" type of IIO driver for that
>>>> chip.
>>>> Check, for example, drivers/iio/imu/bmi160/bmi160_core.c
>>>
>>> That seems to be a single chip listening on a single i2c address / spi
>>> chip-select.
>>
>> Ooops, wrong reference.
>>
>>> In the BSG1160 case the 3 sensors are listening on 3 different i2c
>>> addresses.
>>
>> There is a Bosh magnetometer + accelerometer chip (BMC150). We have just
>> two independent drivers for them. Luckily for ACPI they have different
>> IDs (on the platforms where it's used like that).
>>
>> So, my series targeting the series of same IPs under one device...
>>
>>> We could use the drivers/mfd framework, but the we get platform
>>> devices
>>> and we would need to patch all 3 existing drivers to support platform
>>> bindings and get a regmap from there (converting them to regmap where
>>> necessary).
>>
>> ...and in your case MFD sounds better. Though why do you need to have a
>> common regmap?
> 
> I'm not convinced MFD is the right place. You wouldn't really utilize
> anything of the MFD subsystem. And in a sense it is not a multi-function
> device. It's just multiple devices that are described by the same firmware
> description table entry.
> 
> But I think some kind of board driver might be useful here that translates
> the ACPI description into something more reasonable. I.e. bind to the ACPI
> ID and then instantiate the 3 child I2C devices on the same bus. Those do
> not have to be platform drivers and you do not have to use regmap.
> 
> The current approach adds board specific workarounds to each of the device
> drivers. It might be easier to have that managed in a central place.

Right, I considered that, and I'm actually doing pretty much that for
a somewhat similar ACPI case, see:

drivers/platform/x86/intel_cht_int33fe.c

But there things were more complicated and we also needed to attach
device-properties, while at the same time we were also somewhat lucky,
because there are 4 I2cSerialBusV2 resources in the single ACPI fwnode
and we only care about 2-4, so we can have an i2c-driver in
platform/drivers/x86 bind to the 1st resource and then have it
instantiate i2c clients for I2cSerialBusV2 resources 2-4.

The problem with the BSG1160 case is that we want to also have an
iio driver bind to the first i2c-client and that will not work
if an i2c-driver in platform/drivers/x86 binds to the first
i2c-client and the i2c-subsys will rightfully not let us create another
i2c-client at the same address.

About the "board specific workarounds for each of the drivers", I could
check if they are all checking an id register and if so if I could just
let all 3 of them try to bind without issues. This will likely still
require a change to log the id not matching add a less severe log-level.

Regards,

Hans
