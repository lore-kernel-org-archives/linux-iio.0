Return-Path: <linux@roeck-us.net>
Subject: Re: [PATCH] iio: adc: Add TI ADS1015 ADC driver support
To: Michael Welling <mwelling@ieee.org>,
 Daniel Baluta <daniel.baluta@intel.com>
References: <1452788708-3003-1-git-send-email-daniel.baluta@intel.com>
 <20160114165133.GA20246@deathstar>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 lucas.demarchi@intel.com, eibach@gdsys.de
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5697DC2A.5000801@roeck-us.net>
Date: Thu, 14 Jan 2016 09:34:34 -0800
MIME-Version: 1.0
In-Reply-To: <20160114165133.GA20246@deathstar>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 01/14/2016 08:51 AM, Michael Welling wrote:
> On Thu, Jan 14, 2016 at 06:25:08PM +0200, Daniel Baluta wrote:
>> The driver has sysfs readings with runtime PM support for power saving.
>> It also offers buffer support that can be used together with IIO software
>> triggers.
>>
>
> It should be noted that the hwmon driver subsystem has support for this device.
>
> http://lxr.free-electrons.com/source/drivers/hwmon/ads1015.c
>
> The driver could likely be removed if this is accepted into iio.
> The hwmon subsystem has an iio wrapper driver.
>
> http://lxr.free-electrons.com/source/drivers/hwmon/iio_hwmon.c
>
> The only hurdle is adding support for the ads1115 before removing the other driver.
>
Yes, plus one would hope that there are not going to be a different set of
devicetree properties associated with the new driver, and that the new driver
will support (at least) the same properties.

You'll also have to make sure that only one of the two drivers can be selected.

Guenter
