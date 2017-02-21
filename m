Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33150 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751265AbdBUIr3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Feb 2017 03:47:29 -0500
Date: Tue, 21 Feb 2017 09:47:24 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Welling <mwelling@ieee.org>,
        Mika =?utf-8?B?UGVudHRpbMOk?= <mika.penttila@nextfour.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Igor Grinberg <grinberg@compulab.co.il>,
        "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexander Stein <alexander.stein@systec-electronic.com>,
        Eric Engestrom <eric@engestrom.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Petr Cvek <petr.cvek@tul.cz>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Nick Dyer <nick@shmanahar.org>,
        Siebren Vroegindeweij <siebren.vroegindeweij@hotmail.com>,
        Michel Verlaan <michel.verl@gmail.com>,
        linux-input@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>, linux-iio@vger.kernel.org,
        kernel@pyra-handheld.com, Aaro Koskinen <aaro.koskinen@nokia.com>,
        Pavel Machek <pavel@ucw.cz>,
        Andrey Gelman <andrey.gelman@compulab.co.il>,
        Haibo Chen <haibo.chen@freescale.com>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding
 names, pre-calibration, flipping and rotation
Message-ID: <20170221084724.GB9795@pali>
References: <cover.1482936802.git.hns@goldelico.com>
 <20170220010714.GB8358@dtor-ws>
 <B30D00D0-1967-4BD5-A304-E2ADC815A805@goldelico.com>
 <201702202042.15878@pali>
 <A41872A2-F095-47F8-B122-FFAE430B0D7F@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <A41872A2-F095-47F8-B122-FFAE430B0D7F@goldelico.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi!

On Tuesday 21 February 2017 08:14:09 H. Nikolaus Schaller wrote:
> Hi Pali,
> 
> > Am 20.02.2017 um 20:42 schrieb Pali Rohár <pali.rohar@gmail.com>:
> > 
> > Hi Nikolaus!
> > 
> > On Monday 20 February 2017 17:50:04 H. Nikolaus Schaller wrote:
> >> Hi Dmitry,
> >> 
> >>> Input driver may set resolution for given axis in units per mm (or
> >>> units per radian for rotational axis ABS_RX, ABS_RY, ABS_RZ), and
> >>> if you check the binding, you can use "touchscreen-x-mm" and
> >>> "touchscreen-y-mm" to specify the size of entire touch surface and
> >>> set resolution from it so that userspace can calculate the proper
> >>> scaling factor.
> >> 
> >> How is this information exposed by the kernel to user-space? By
> >> scanning the DT file or tree?
> > 
> > Set input_abs_set_res() from kernel.
> 
> I can't find this function defined anywhere but used in 101 LOC.
> LXR doesn't know it either: http://lxr.free-electrons.com/ident?i=input_abs_set_res
> 
> What is going on here?

It is inline function defined by preprocessor. This should help you:

git grep INPUT_GENERATE_ABS_ACCESSORS
git grep input_abs_set_res

> > And in userspace call EVIOCGABS
> > ioctl() on input device. Look at struct input_absinfo, you should have
> > all needed information here. This is generic input interface, no DT is
> > needed.
> 
> Ok, if this is not set by a driver it is indeed a driver bug.

Zero value is special and means "driver does not know it". In case
driver really does not know it, then it is not a driver bug.

> But we have to define it's value in DT because the tsc2007 does not know
> anything about the panel dimensions.

Yes, driver itself does not know it and DT seems to be correct place.

> IMHO something that should be done by generic of_touchscreen.c

I agree. DT for specific hardware can pass these information into
touchscreen driver (which does not have to know these parameters) and it
exports it to userspace.

> If of_touchscreen would simply pass the touchscreen-size parameters
> to input_abs_set_res() and the bindings would define it to be units/mm
> it might have saved us all a lot of work and discussion.

Seem that nobody until now needed such thing and everybody is (probably)
using Xorg userspace with userspace calibration.

But it really make sense to set input_abs_set_res() from DT.

> > 
> > I hope that XServer is already using it for evdev devices...
> > 
> > For whole implementation look at evtest program. That should be good
> > starting point for your userspace implementation.
> > 
> > While I'm watching this discussion... in my opinion kernel should just
> > invert input axes (when needed) and should not do any other
> > normalization or integer/floating-point re-calibration/re-calculation.
> > If it correctly exports minimum value, maximum value and resolution then
> > userspace can correctly re-scale input events to units which userspace
> > needs (e.g. mapping into LCD screen pixels or whatever is needed).
> 
> BR and thanks,
> Nikolaus
> 

-- 
Pali Rohár
pali.rohar@gmail.com
