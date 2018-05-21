Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37704 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751682AbeEUNcC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 May 2018 09:32:02 -0400
Received: by mail-wm0-f67.google.com with SMTP id l1-v6so26697526wmb.2
        for <linux-iio@vger.kernel.org>; Mon, 21 May 2018 06:32:02 -0700 (PDT)
Subject: Re: [PATCH 0/9] ACPI/i2c Enumerate several instances out of one
 fwnode
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Jonathan Cameron <jic23@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
References: <20180520132857.8103-1-hdegoede@redhat.com>
 <f9fc420005d926b2d35854331ec0288d3a98c925.camel@linux.intel.com>
 <336cb6d4-5797-8787-21dd-d816f994cce9@redhat.com>
 <81114e50a1e07763f1645201e42b80a6fc9f33a1.camel@linux.intel.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <92663486-b96c-e87f-ad0e-9f50a03ee36b@redhat.com>
Date: Mon, 21 May 2018 15:31:55 +0200
MIME-Version: 1.0
In-Reply-To: <81114e50a1e07763f1645201e42b80a6fc9f33a1.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On 21-05-18 15:13, Andy Shevchenko wrote:
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

Not a common regmap, but a regmap per i2c-address of course, but we need
to have the MFD driver create these regmaps because the MFD-child devices
are platform_devices which know nothing about i2c. And then we need to add
platform_device / driver support to 3 iio devices and have that code
retrieve the regmap. And if not all drivers are using regmap (I did not
check) convert some of them to regmap first.

There really is no MFD device here, as the need to create separate
regmaps shows, usually the whole purpose of the MFD framework is
to share a single i2c-client / regmap between multiple drivers
because the i2c device has multiple function blocks. So the MFD
framework really is a _very_ poor fit here.

To put this differently, I can rewrite the DSDT so that things
just work without needing any kernel modification at all, the
problem is in the *enumeration* here, not in multiple separate function
blocks sharing a single address space.

And using your proposed quirk support for enumeration multiple
i2c-clients from a single acpi_device fixes the enumeration problem.

Regards,

Hans


