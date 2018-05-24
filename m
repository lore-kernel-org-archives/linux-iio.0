Return-Path: <SRS0=B4Op=IL=redhat.com=hdegoede@kernel.org>
Subject: Re: [PATCH 0/9] ACPI/i2c Enumerate several instances out of one
 fwnode
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Wolfram Sang <wsa@the-dreams.de>, Jonathan Cameron <jic23@kernel.org>,
 linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org
References: <20180520132857.8103-1-hdegoede@redhat.com>
 <9434827.JV15Qo8zAb@aspire.rjw.lan>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <d2673604-d5e5-c192-fa62-5afd21fcb086@redhat.com>
Date: Thu, 24 May 2018 10:56:49 +0200
MIME-Version: 1.0
In-Reply-To: <9434827.JV15Qo8zAb@aspire.rjw.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hi,

On 24-05-18 10:55, Rafael J. Wysocki wrote:
> On Sunday, May 20, 2018 3:28:48 PM CEST Hans de Goede wrote:
>> Hi All,
>>
>> This series really consists of 2 series, patches 1-5 add support for
>> interesting ACPI tables which describe multiple i2c chips in a single
>> fwnode, sometimes multiple cases of the same chip on different addresses,
>> sometimes a bunch of related chips.
>>
>> Andy Shevchenko has come up with the solution of adding a quirk based
>> on the ACPI HID of the fwnode for these devices which makes the
>> drivers/i2c/i2c-core-acpi.c code instantiate separate i2c_client devices
>> for each I2cSerialBusV2 in the fwnode. I agree with him that this is
>> the best (least ugly) solution for this.
>>
>> I've been testing this solution on a device if mine which needs a solution
>> for this, the HP Pavilion x2 - 10-n000nd 2-in-1 has an acpi_device / fwnode
>> with a HID of BSG1160 which describes 3 different i2c sensors in an accel /
>> magneto / gyro sensor cluster on the tablet. This has let to some extra
>> prep. patches and some fixes to Andy's patches.
>>
>> Patches 6-9 use the new functionality creating  one i2c-client per
>> I2cSerialBusV2 resource to make the sensor cluster on the HP X2 work and
>> are posted as part of this series to show how this functionality can be
>> used.
>>
>> Assuming everyone is ok with this series (I'm not expecting anyone to be
>> really happy about the need for this), then I suggest that patches 1-6
>> get merged togther through either the ACPI or the i2c tree, I guess the
>> i2c tree would make somewhat more sense, since most patches are there.
>>
>> Then once those are accepted patches 7-9 can be merged into the iio tree,
>> there is no compile time dependency between the 2, so these can be merged
>> separately. Note merging 7-9 before there is agreement that this is the
>> right way to fix this is probably not a good idea.
> 
>  From the discussion I gather that this series will be updated.

More like thrown away and rewritten, but yes this is obsolete.

Regards,

Hans
