Return-Path: <SRS0=a56X=ER=redhat.com=hdegoede@kernel.org>
Subject: Re: How to deal with accelerometers where the ACPI HID indicates the
 location?
To: Bastien Nocera <bnocera@redhat.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 linux-iio@vger.kernel.org, Enaut Waldmeier <enaut.w@googlemail.com>
References: <d939693c-640a-5dc7-2a5a-11845065cdf4@redhat.com>
 <611091957.5895339.1516022929637.JavaMail.zimbra@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <06a0d2c4-163b-dfc8-daeb-a57cd861006b@redhat.com>
Date: Mon, 22 Jan 2018 18:40:51 +0100
MIME-Version: 1.0
In-Reply-To: <611091957.5895339.1516022929637.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hi,

On 15-01-18 14:28, Bastien Nocera wrote:
> 
> 
> ----- Original Message -----
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
>>                       Name (_DDN, "Kionix KXCJ9 Accelerometer Display")  //
>>                       _DDN:
>>
>> ...
>>
>>                   Device (KXJ1)
>>                   {
>>                       Name (_ADR, Zero)  // _ADR: Address
>>                       Name (_HID, "KIOX020A")  // _HID: Hardware ID
>>                       Name (_CID, "KIOX020A")  // _CID: Compatible ID
>>                       Name (_DDN, "Kionix KXCJ9 Accelerometer Keyboard")  //
>>                       _DDN:
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
>>
>> I do believe there is a need for an ACCEL_LOCATION udev property on
>> accelerometer iio-devs for use by iio-sensor-proxy, so that it can
>> pick the one in the display to provide display rotation info.
> 
> I don't think that Windows would be differentiating them based on a textual
> value, a free-form string like this one. It might be something we use, but
> it's not something they'd do.

Right.

> I would expect the Windows driver to contain the IDs and say "this ID
> is the one in the display, this ID is the one in the keyboard".

Right, I agree that Windows is likely triggering on the IDs and that we
should do the same (were possible). My purpose of starting this thread
was to agree on an API for exporting this information to iio-sensor-proxy
(and possibly other interested accelerometer event consumers).

The reason I'm suggesting a udev property (with agreed up on fixed
contents for accelerometer in keyboard/base and display) is because on
some hardware the information is not encoded in the ID and we need some
other way to get this info. I'm thinking using a (dmi based) hwdb entry
for this, which matches well with using a udev property and writing udev
rules to set the property based on the ID should be easy too since the
ID is part of the device-name for these devices.

> You might want to check whether the ACPI DSDT has _PLD information though,
> as that would be the programmatic way of exporting this data:
> http://marc.info/?l=linux-iio&m=147981183211362&w=2

So these 2 ids are used in the DSTDs of 3 devices in my DSTD collection:

Medion e2228t (same device as https://github.com/hadess/iio-sensor-proxy/issues/166)
T-Bao Tbook air 12.5
Trekstor Primebook C13

Neither of these 3 DSDTs have an _PLD method on either of the
accelerometer ACPI device nodes.

>> But since the HID ends up in the device name we can simply add an
>> udev rule based on this, without the kernel needing to export any
>> data AFAICT.
>>
>> Bastien, do you agree that we don't need the kernel to export this
>> and that we can use a HID match in a udev rule to set an
>> ACCEL_LOCATION udev property for this ?
> 
> See https://github.com/systemd/systemd/issues/6125
> and https://github.com/hadess/iio-sensor-proxy/issues/166

So looking at these, these too suggest an ACCEL_LOCATION udev property,
given that that makes 2 people coming up with this proposal independently
and even with the ACCEL_LOCATION name, my proposal would be to go with
that.

https://github.com/systemd/systemd/issues/6125 suggests using
"display" and "keyboard" as possible values for now, but I would prefer
to use "display" and "base" since not all devices have a keyboard,
see e.g. :

http://www.gpd.hk/products.asp?selectclassid=017001&id=1299

Which also runs Linux AFAIK, but if you prefer "keyboard" over
"base" that is fine too. As long as we agree on values for this, then
we can document all this in /lib/udev/hwdb.d/60-sensor.hwdb.

Shall I write a systemd patch adding documentation for this and
adding a first hwdb entry?

Writing udev rules for the devices where the location is indicated by
the ACPI HID for the accelerometer is a bit tricky for me to do
because -ENOHARDWARE. But I can take a shot and ask Enaut (in the Cc)
to test, he has a Trekstor Primebook C13.

> iio-sensor-proxy would just ignore the keyboard accelerometer for now.

I guess iio-sensor-proxy should ignore any accelerometer with an
ACCEL_LOCATION property which is not "display", rather then ignore
"keyboard" so that if future locations show up we also ignore those?

Otherwise ack.

Regards,

Hans
