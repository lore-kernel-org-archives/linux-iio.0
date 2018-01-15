Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52854 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755315AbeAON2v (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 15 Jan 2018 08:28:51 -0500
Date: Mon, 15 Jan 2018 08:28:49 -0500 (EST)
From: Bastien Nocera <bnocera@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Enaut Waldmeier <enaut.w@googlemail.com>
Message-ID: <611091957.5895339.1516022929637.JavaMail.zimbra@redhat.com>
In-Reply-To: <d939693c-640a-5dc7-2a5a-11845065cdf4@redhat.com>
References: <d939693c-640a-5dc7-2a5a-11845065cdf4@redhat.com>
Subject: Re: How to deal with accelerometers where the ACPI HID indicates
 the location?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



----- Original Message -----
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
>                      Name (_DDN, "Kionix KXCJ9 Accelerometer Display")  //
>                      _DDN:
> 
> ...
> 
>                  Device (KXJ1)
>                  {
>                      Name (_ADR, Zero)  // _ADR: Address
>                      Name (_HID, "KIOX020A")  // _HID: Hardware ID
>                      Name (_CID, "KIOX020A")  // _CID: Compatible ID
>                      Name (_DDN, "Kionix KXCJ9 Accelerometer Keyboard")  //
>                      _DDN:
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
> 
> I do believe there is a need for an ACCEL_LOCATION udev property on
> accelerometer iio-devs for use by iio-sensor-proxy, so that it can
> pick the one in the display to provide display rotation info.

I don't think that Windows would be differentiating them based on a textual
value, a free-form string like this one. It might be something we use, but
it's not something they'd do.

I would expect the Windows driver to contain the IDs and say "this ID
is the one in the display, this ID is the one in the keyboard".

You might want to check whether the ACPI DSDT has _PLD information though,
as that would be the programmatic way of exporting this data:
http://marc.info/?l=linux-iio&m=147981183211362&w=2

> But since the HID ends up in the device name we can simply add an
> udev rule based on this, without the kernel needing to export any
> data AFAICT.
> 
> Bastien, do you agree that we don't need the kernel to export this
> and that we can use a HID match in a udev rule to set an
> ACCEL_LOCATION udev property for this ?

See https://github.com/systemd/systemd/issues/6125
and https://github.com/hadess/iio-sensor-proxy/issues/166

iio-sensor-proxy would just ignore the keyboard accelerometer for now.

Cheers
