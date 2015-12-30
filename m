Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:51228 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752407AbbL3JuP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 30 Dec 2015 04:50:15 -0500
From: Marek Vasut <marex@denx.de>
To: linux-iio@vger.kernel.org
Subject: Re: acpi-als on Dell XPS 13 9343
Date: Wed, 30 Dec 2015 10:50:11 +0100
Cc: Mykola Dvornik <mykola.dvornik@gmail.com>, marxin.liska@gmail.com,
	Gabriele Mazzotta <gabriele.mzt@gmail.com>
References: <1451464368.2262.1@smtp.gmail.com> <201512300952.24700.marex@denx.de> <1451468582.2348.0@smtp.gmail.com>
In-Reply-To: <1451468582.2348.0@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201512301050.11178.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wednesday, December 30, 2015 at 10:43:02 AM, Mykola Dvornik wrote:
> Hi Marek,
> 
> Thanks for you prompt reply.
> 
> The DSDT describes _ALI method:
> 
> 	...
> Device (ALSD)
>     {
>         Name (_HID, "ACPI0008" /* Ambient Light Sensor Device */)  //
> _HID: Hardware ID
>         Method (_STA, 0, NotSerialized)  // _STA: Status
>         {
>             If ((ALSE == 0x02))
>             {
>                 Return (0x0B)
>             }
> 
>             Return (Zero)
>         }
> 
>         Method (_ALI, 0, NotSerialized)  // _ALI: Ambient Light
> Illuminance
>         {
>             Return (((LHIH << 0x08) | LLOW))
>         }
> 	...
> 
> acpidump also shows _ALI method.
> 
> But '/sys/bus/acpi/devices/ACPI0008:00' only contains:
> 
> hid
> modalias
> path
> power
> status
> subsystem
> uevent

OK, I don't have a machine with the ALS in it here, so I am CCing the list and
a few more interested parties.

> Regards,
> 
> Mykola
> 
> On Wed, Dec 30, 2015 at 9:52 AM, Marek Vasut <marex@denx.de> wrote:
> > On Wednesday, December 30, 2015 at 09:32:48 AM, Mykola Dvornik wrote:
> >>  Hi guys,
> >>  
> >>  I am writing to you because the acpi-als kernel module is not
> >> 
> >> detecting
> >> 
> >>  ALS on Dell XPS 13 9343.
> >>  
> >>  The (decompiled) DSDT of the laptop is attached to this email.
> >>  
> >>  The ACPI0008 is present in the system with 'cat modalias':
> >>  
> >>  acpi:ACPI0008:
> >>  
> >>  but exposes no iio-related stuff.
> >>  
> >>  I am running Fedora 23 with kernel-4.2.8.
> >>  
> >>  Would you be so kind to look into this issue?
> > 
> > Do you have the _ALI value in the ACPI0008 ? That's what's used to
> > read out
> > the illuminance and without it, the ALS driver won't report anything.
> > 
> > Best regards,
> > Marek Vasut
