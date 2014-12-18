Return-Path: <lars@metafoo.de>
Message-ID: <54930965.3030008@metafoo.de>
Date: Thu, 18 Dec 2014 18:05:41 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: jic23@kernel.org, linux-iio@vger.kernel.org,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 3/3] iio: ak8975: Added autodetect feature for ACPI
References: <1418678363-22437-1-git-send-email-srinivas.pandruvada@linux.intel.com>	 <1418678363-22437-4-git-send-email-srinivas.pandruvada@linux.intel.com>	 <549300A5.5080904@metafoo.de> <1418921521.740.282.camel@spandruv-desktop.jf.intel.com>
In-Reply-To: <1418921521.740.282.camel@spandruv-desktop.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 12/18/2014 05:52 PM, Srinivas Pandruvada wrote:
> On Thu, 2014-12-18 at 17:28 +0100, Lars-Peter Clausen wrote:
>> Added I2C to Cc.
>>
>> On 12/15/2014 10:19 PM, Srinivas Pandruvada wrote:
>>> Using i2c auto detect feature and auto device creation feature,
>>> enumerate ak8975 device, by checking their presence.
>>> This is needed because when this device sits behind an i2c mux, there
>>> is no way to define i2c mux in ACPI. This will enable ak8975 on
>>> windows based tablets/laptops running Linux when connected via a mux.
>>> Since DT model already can define an i2c mux and devices connected to
>>> it, this feature is only enabled for ACPI.
>>>
>>
>> This is quite a bit of a hack.
> Why?
> Auto detect is standard feature of i2c devices. This is using standard
> auto detect feature provided by the framework.

Auto detect is ugly, slow and unreliable, it's kind of like the last straw 
if nothing else works.

Autodetect will be executed for every adapter with every device that 
supports auto detection, so you want to keep the amount of devices that do 
auto detection to a minimum in order to avoid both false positives and 
reduce boot time.


>>   Did they decide to not include the device in
>> the ACPI description at all or is there a special id for INV6050+AK8975?
> This device needs has one combined id. Windows has a singe driver
> processing both as a combo device.

Ok, then use the combined id to instantiate INV6050+AK8975.

- Lars
