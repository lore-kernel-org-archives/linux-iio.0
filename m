Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37044 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755709AbcEYQpx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 May 2016 12:45:53 -0400
Received: by mail-wm0-f49.google.com with SMTP id z87so69985237wmh.0
        for <linux-iio@vger.kernel.org>; Wed, 25 May 2016 09:45:52 -0700 (PDT)
Date: Wed, 25 May 2016 18:45:49 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Mykola Dvornik <mykola.dvornik@gmail.com>
Cc: Marek Vasut <marex@denx.de>, linux-iio@vger.kernel.org,
	Martin =?utf-8?B?TGnFoWth?= <marxin.liska@gmail.com>,
	Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Re: acpi-als on Dell XPS 13 9343
Message-ID: <20160525164549.GA29844@pali>
References: <1451464368.2262.1@smtp.gmail.com>
 <201512300952.24700.marex@denx.de>
 <1451468582.2348.0@smtp.gmail.com>
 <201512301050.11178.marex@denx.de>
 <CABFtUbTbibudvXYspe8N7cf1UgGVOwtYSPF2JuMZPVmpa680+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CABFtUbTbibudvXYspe8N7cf1UgGVOwtYSPF2JuMZPVmpa680+g@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wednesday 30 December 2015 11:28:32 Gabriele Mazzotta wrote:
> 2015-12-30 10:50 GMT+01:00 Marek Vasut <marex@denx.de>:
> > On Wednesday, December 30, 2015 at 10:43:02 AM, Mykola Dvornik wrote:
> >> Hi Marek,
> >>
> >> Thanks for you prompt reply.
> >>
> >> The DSDT describes _ALI method:
> >>
> >>       ...
> >> Device (ALSD)
> >>     {
> >>         Name (_HID, "ACPI0008" /* Ambient Light Sensor Device */)  //
> >> _HID: Hardware ID
> >>         Method (_STA, 0, NotSerialized)  // _STA: Status
> >>         {
> >>             If ((ALSE == 0x02))
> >>             {
> >>                 Return (0x0B)
> >>             }
> >>
> >>             Return (Zero)
> >>         }
> >>
> >>         Method (_ALI, 0, NotSerialized)  // _ALI: Ambient Light
> >> Illuminance
> >>         {
> >>             Return (((LHIH << 0x08) | LLOW))
> >>         }
> >>       ...
> >>
> >> acpidump also shows _ALI method.
> >>
> >> But '/sys/bus/acpi/devices/ACPI0008:00' only contains:
> >>
> >> hid
> >> modalias
> >> path
> >> power
> >> status
> >> subsystem
> >> uevent
> 
> Hi,
> 
> looking at this portion of the ACPI table I can see that the
> status of the ambient light sensor is controlled by a variable
> (ALSE, which I guess stands for ALS Enabled).
> 
> If the output of /sys/bus/acpi/devices/ACPI0008:00/status is 0,
> then the light sensor is disabled and must be somehow enabled.
> When the sensor is enabled, the output of status should be 11. I
> don't know what controls the value of ALSE, I think it's something
> specific of your laptop.
> 
> Regards,
> Gabriele

Hi Mykola! Please look at dell-wmi driver:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/platform/x86/dell-wmi.c?h=v4.6#n634

There is specific Dell SMBIOS call which tell Dell BIOS/firmware to
start generating WMI events when some buttons are pressed.

In above link is also documentation for that SMBIOS call and there is
also parameter "ALS Driver". So maybe this one can enable your currently
disabled ambient light sensor...

Can you play with it?

> > OK, I don't have a machine with the ALS in it here, so I am CCing the list and
> > a few more interested parties.
> >
> >> Regards,
> >>
> >> Mykola
> >>
> >> On Wed, Dec 30, 2015 at 9:52 AM, Marek Vasut <marex@denx.de> wrote:
> >> > On Wednesday, December 30, 2015 at 09:32:48 AM, Mykola Dvornik wrote:
> >> >>  Hi guys,
> >> >>
> >> >>  I am writing to you because the acpi-als kernel module is not
> >> >>
> >> >> detecting
> >> >>
> >> >>  ALS on Dell XPS 13 9343.
> >> >>
> >> >>  The (decompiled) DSDT of the laptop is attached to this email.
> >> >>
> >> >>  The ACPI0008 is present in the system with 'cat modalias':
> >> >>
> >> >>  acpi:ACPI0008:
> >> >>
> >> >>  but exposes no iio-related stuff.
> >> >>
> >> >>  I am running Fedora 23 with kernel-4.2.8.
> >> >>
> >> >>  Would you be so kind to look into this issue?
> >> >
> >> > Do you have the _ALI value in the ACPI0008 ? That's what's used to
> >> > read out
> >> > the illuminance and without it, the ALS driver won't report anything.
> >> >
> >> > Best regards,
> >> > Marek Vasut
> 

-- 
Pali Rohár
pali.rohar@gmail.com
