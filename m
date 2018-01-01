Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:43519 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbeAAJ4a (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Jan 2018 04:56:30 -0500
Received: by mail-wm0-f53.google.com with SMTP id n138so56914056wmg.2
        for <linux-iio@vger.kernel.org>; Mon, 01 Jan 2018 01:56:30 -0800 (PST)
Subject: Re: How to deal with accelerometers where the ACPI HID indicates the
 location?
To: Jonathan Cameron <jic23@kernel.org>
Cc: Bastien Nocera <bnocera@redhat.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Enaut Waldmeier <enaut.w@googlemail.com>,
        Chris Hudson <chudson@kionix.com>
References: <d939693c-640a-5dc7-2a5a-11845065cdf4@redhat.com>
 <20171229121442.62fa98fd@archlinux>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <657e20fc-9449-25a4-3e5f-c142357c7e52@redhat.com>
Date: Mon, 1 Jan 2018 10:56:27 +0100
MIME-Version: 1.0
In-Reply-To: <20171229121442.62fa98fd@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On 29-12-17 13:14, Jonathan Cameron wrote:
> On Wed, 27 Dec 2017 17:42:36 +0100
> Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> Hi All,
>>
>> So I've been debugging some touchpad issues on a Tresktor Primebook C13,
>> unfortunately I've been able to get the touchpad to work.
>>
>> But I did notice the following in the ACPI tables, and there i2cdetect
>> confirms there are i2c devices at the expected addresses:
>>
>>                   Device (KXJ0)
>>                   {
>>                       Name (_ADR, Zero)  // _ADR: Address
>>                       Name (_HID, "KIOX010A")  // _HID: Hardware ID
>>                       Name (_CID, "KIOX010A")  // _CID: Compatible ID
>>                       Name (_DDN, "Kionix KXCJ9 Accelerometer Display")  // _DDN:
>>
>> ...
>>
>>                   Device (KXJ1)
>>                   {
>>                       Name (_ADR, Zero)  // _ADR: Address
>>                       Name (_HID, "KIOX020A")  // _HID: Hardware ID
>>                       Name (_CID, "KIOX020A")  // _CID: Compatible ID
>>                       Name (_DDN, "Kionix KXCJ9 Accelerometer Keyboard")  // _DDN:
>>
>> ...
>>
>> Notice these accelerometers use KIOX010A / KIOX020A as HID rather then
>> the normal KIOX000A and their DDN lists a location (display vs
>> keyboard, this is a yoga style convertible).
>>
>> I'm pretty sure from the kernel side these can be fixed by just adding:
>>
>>           {"KIOX010A", KXCJ91008},
>>           {"KIOX020A", KXCJ91008},
>>
>> Entries to the drivers/iio/accel/kxcjk-1013.c driver. I believe the
>> different HIDs are just there to allow Windows to determine the
>> location based on the HID.
>>
>> But before submitting a patch to add these 2 HIDs to the driver I was
>> wondering do we want to do anything wrt the location on the kernel side.
> 
> Whilst it's not supported currently by this driver we do have
> sysfs attributes to describe this in the ABI but so far it's only
> in the device specific docs as it hasn't spread that widely.
> 
> Documentation/ABI/testing/sysfs-bus-iio-cros-ec
> 
> has location for example - we could move this up to the top level ABI doc
> and use it more generally.

Yes that would also work, although in practice I think we're going to
need some udev / hwdb stuff for this anyways since the driver will not
be able to get the location itself in a lot of cases.

I guess we could have a udev role using the location attribute to set
the same ACCEL_LOCATION udev property as we will have the udev rule
set manually on other devices, then the sensor consumer, e.g.
iio-sensor-proxy still only needs to check one place.

Anyways lets wait a bit for Bastien to get back from his holidays
and get his input before moving forward with this.

Regards,

Hans




> 
>>
>> I do believe there is a need for an ACCEL_LOCATION udev property on
>> accelerometer iio-devs for use by iio-sensor-proxy, so that it can
>> pick the one in the display to provide display rotation info.
>>
>> But since the HID ends up in the device name we can simply add an
>> udev rule based on this, without the kernel needing to export any
>> data AFAICT.
>>
>> Bastien, do you agree that we don't need the kernel to export this
>> and that we can use a HID match in a udev rule to set an
>> ACCEL_LOCATION udev property for this ?
> 
> It is somewhat horrible that they are using different ACPI IDs for
> location on the device.  I wonder if we can find out where that
> came from and whether it is in any way standard?
> 
> +CC Chris on off chance still at Kionix and might be able to find
> this out for us. (it's been a while ;)
> 
> Jonathan
> 
>>
>> Regards,
>>
>> Hans
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
