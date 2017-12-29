Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754888AbdL2MOr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 29 Dec 2017 07:14:47 -0500
Date: Fri, 29 Dec 2017 12:14:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Bastien Nocera <bnocera@redhat.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Enaut Waldmeier <enaut.w@googlemail.com>,
        Chris Hudson <chudson@kionix.com>
Subject: Re: How to deal with accelerometers where the ACPI HID indicates
 the location?
Message-ID: <20171229121442.62fa98fd@archlinux>
In-Reply-To: <d939693c-640a-5dc7-2a5a-11845065cdf4@redhat.com>
References: <d939693c-640a-5dc7-2a5a-11845065cdf4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 27 Dec 2017 17:42:36 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi All,
> 
> So I've been debugging some touchpad issues on a Tresktor Primebook C13,
> unfortunately I've been able to get the touchpad to work.
> 
> But I did notice the following in the ACPI tables, and there i2cdetect
> confirms there are i2c devices at the expected addresses:
> 
>                  Device (KXJ0)
>                  {
>                      Name (_ADR, Zero)  // _ADR: Address
>                      Name (_HID, "KIOX010A")  // _HID: Hardware ID
>                      Name (_CID, "KIOX010A")  // _CID: Compatible ID
>                      Name (_DDN, "Kionix KXCJ9 Accelerometer Display")  // _DDN:
> 
> ...
> 
>                  Device (KXJ1)
>                  {
>                      Name (_ADR, Zero)  // _ADR: Address
>                      Name (_HID, "KIOX020A")  // _HID: Hardware ID
>                      Name (_CID, "KIOX020A")  // _CID: Compatible ID
>                      Name (_DDN, "Kionix KXCJ9 Accelerometer Keyboard")  // _DDN:
> 
> ...
> 
> Notice these accelerometers use KIOX010A / KIOX020A as HID rather then
> the normal KIOX000A and their DDN lists a location (display vs
> keyboard, this is a yoga style convertible).
> 
> I'm pretty sure from the kernel side these can be fixed by just adding:
> 
>          {"KIOX010A", KXCJ91008},
>          {"KIOX020A", KXCJ91008},
> 
> Entries to the drivers/iio/accel/kxcjk-1013.c driver. I believe the
> different HIDs are just there to allow Windows to determine the
> location based on the HID.
> 
> But before submitting a patch to add these 2 HIDs to the driver I was
> wondering do we want to do anything wrt the location on the kernel side.

Whilst it's not supported currently by this driver we do have
sysfs attributes to describe this in the ABI but so far it's only
in the device specific docs as it hasn't spread that widely.

Documentation/ABI/testing/sysfs-bus-iio-cros-ec

has location for example - we could move this up to the top level ABI doc
and use it more generally.

> 
> I do believe there is a need for an ACCEL_LOCATION udev property on
> accelerometer iio-devs for use by iio-sensor-proxy, so that it can
> pick the one in the display to provide display rotation info.
> 
> But since the HID ends up in the device name we can simply add an
> udev rule based on this, without the kernel needing to export any
> data AFAICT.
> 
> Bastien, do you agree that we don't need the kernel to export this
> and that we can use a HID match in a udev rule to set an
> ACCEL_LOCATION udev property for this ?

It is somewhat horrible that they are using different ACPI IDs for
location on the device.  I wonder if we can find out where that
came from and whether it is in any way standard?

+CC Chris on off chance still at Kionix and might be able to find
this out for us. (it's been a while ;)

Jonathan

> 
> Regards,
> 
> Hans
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

