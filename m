Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bubo.tul.cz ([147.230.16.1]:56728 "EHLO bubo.tul.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751041AbdBTWao (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Feb 2017 17:30:44 -0500
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding
 names, pre-calibration, flipping and rotation
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
References: <cover.1482936802.git.hns@goldelico.com>
 <B30D00D0-1967-4BD5-A304-E2ADC815A805@goldelico.com>
 <201702202042.15878@pali> <201702202208.50498@pali>
 <C2E7AC24-75AB-442F-94A2-84904723EE41@goldelico.com>
 <CAKdAkRRZa-fpv_TKRdY=hFV3GdKxQ3muQORquvV_bTrDzQAhCw@mail.gmail.com>
Cc: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Welling <mwelling@ieee.org>,
        =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Igor Grinberg <grinberg@compulab.co.il>,
        "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexander Stein <alexander.stein@systec-electronic.com>,
        Eric Engestrom <eric@engestrom.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Nick Dyer <nick@shmanahar.org>,
        Siebren Vroegindeweij <siebren.vroegindeweij@hotmail.com>,
        Michel Verlaan <michel.verl@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>, linux-iio@vger.kernel.org,
        kernel@pyra-handheld.com, Aaro Koskinen <aaro.koskinen@nokia.com>,
        Pavel Machek <pavel@ucw.cz>,
        Andrey Gelman <andrey.gelman@compulab.co.il>,
        Haibo Chen <haibo.chen@freescale.com>
From: Petr Cvek <petr.cvek@tul.cz>
Message-ID: <15339314-8696-f603-d0da-beefe54f0653@tul.cz>
Date: Mon, 20 Feb 2017 23:21:37 +0100
MIME-Version: 1.0
In-Reply-To: <CAKdAkRRZa-fpv_TKRdY=hFV3GdKxQ3muQORquvV_bTrDzQAhCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

Dne 20.2.2017 v 22:50 Dmitry Torokhov napsal(a):
> On Mon, Feb 20, 2017 at 1:27 PM, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>>
>>> Am 20.02.2017 um 22:08 schrieb Pali Rohár <pali.rohar@gmail.com>:
>>>
>>> On Monday 20 February 2017 20:42:15 Pali Rohár wrote:
>>>> Hi Nikolaus!
>>>>
>>>> On Monday 20 February 2017 17:50:04 H. Nikolaus Schaller wrote:
>>>>> Hi Dmitry,
>>>>>
>>>>>> Input driver may set resolution for given axis in units per mm
>>>>>> (or units per radian for rotational axis ABS_RX, ABS_RY,
>>>>>> ABS_RZ), and if you check the binding, you can use
>>>>>> "touchscreen-x-mm" and "touchscreen-y-mm" to specify the size of
>>>>>> entire touch surface and set resolution from it so that
>>>>>> userspace can calculate the proper scaling factor.
>>>>>
>>>>> How is this information exposed by the kernel to user-space? By
>>>>> scanning the DT file or tree?
>>>>
>>>> Set input_abs_set_res() from kernel. And in userspace call EVIOCGABS
>>>> ioctl() on input device. Look at struct input_absinfo, you should
>>>> have all needed information here. This is generic input interface,
>>>> no DT is needed.
>>>
>>> Looking at kernel code... via EVIOCSABS ioctl() you can even set
>>> resolution from userspace for specified input device.
>>>
>>> So this could be potentially used for calibrating input device from
>>> userspace? (In case DT data will not fully match current HW)
>>>
>>>> I hope that XServer is already using it for evdev devices...
>>>>
>>>> For whole implementation look at evtest program. That should be good
>>>> starting point for your userspace implementation.
>>>>
>>>> While I'm watching this discussion... in my opinion kernel should
>>>> just invert input axes (when needed)
>>
>> It is questionable why it should do that at all then.
> 
> Because the task of the kernel is to provide unified view of the
> hardware. Axis swapping and inversion is needed to that "up" is always
> "up" and "right" is always "right".

Actually my Xorg calibration 3x3 matrix is fine with both axis inverted (on TSC2046).

best regards,
Petr
