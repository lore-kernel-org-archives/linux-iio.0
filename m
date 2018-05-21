Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33397 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752541AbeEUMeW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 May 2018 08:34:22 -0400
Received: by mail-wm0-f68.google.com with SMTP id x12-v6so11920887wmc.0
        for <linux-iio@vger.kernel.org>; Mon, 21 May 2018 05:34:21 -0700 (PDT)
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
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <336cb6d4-5797-8787-21dd-d816f994cce9@redhat.com>
Date: Mon, 21 May 2018 14:34:19 +0200
MIME-Version: 1.0
In-Reply-To: <f9fc420005d926b2d35854331ec0288d3a98c925.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On 21-05-18 11:19, Andy Shevchenko wrote:
> On Sun, 2018-05-20 at 15:28 +0200, Hans de Goede wrote:
>> Hi All,
>>
>> This series really consists of 2 series, patches 1-5 add support for
>> interesting ACPI tables which describe multiple i2c chips in a single
>> fwnode, sometimes multiple cases of the same chip on different
>> addresses,
>> sometimes a bunch of related chips.
>>
>> Andy Shevchenko has come up with the solution of adding a quirk based
>> on the ACPI HID of the fwnode for these devices which makes the
>> drivers/i2c/i2c-core-acpi.c code instantiate separate i2c_client
>> devices
>> for each I2cSerialBusV2 in the fwnode. I agree with him that this is
>> the best (least ugly) solution for this.
>>
>> I've been testing this solution on a device if mine which needs a
>> solution
>> for this, the HP Pavilion x2 - 10-n000nd 2-in-1 has an acpi_device /
>> fwnode
>> with a HID of BSG1160 which describes 3 different i2c sensors in an
>> accel /
>> magneto / gyro sensor cluster on the tablet. This has let to some
>> extra
>> prep. patches and some fixes to Andy's patches.
> 
> Thanks for taking care!
> 
>> Patches 6-9 use the new functionality creating  one i2c-client per
>> I2cSerialBusV2 resource to make the sensor cluster on the HP X2 work
>> and
>> are posted as part of this series to show how this functionality can
>> be
>> used.
> 
> I suppose it's better to do an "MFD" type of IIO driver for that chip.
> Check, for example, drivers/iio/imu/bmi160/bmi160_core.c

That seems to be a single chip listening on a single i2c address / spi
chip-select.

In the BSG1160 case the 3 sensors are listening on 3 different i2c addresses.

We could use the drivers/mfd framework, but the we get platform devices
and we would need to patch all 3 existing drivers to support platform
bindings and get a regmap from there (converting them to regmap where
necessary).

Regards,

Hans





> 
>>
>> Assuming everyone is ok with this series (I'm not expecting anyone to
>> be
>> really happy about the need for this), then I suggest that patches 1-6
>> get merged togther through either the ACPI or the i2c tree, I guess
>> the
>> i2c tree would make somewhat more sense, since most patches are there.
>>
>> Then once those are accepted patches 7-9 can be merged into the iio
>> tree,
>> there is no compile time dependency between the 2, so these can be
>> merged
>> separately. Note merging 7-9 before there is agreement that this is
>> the
>> right way to fix this is probably not a good idea.
> 
