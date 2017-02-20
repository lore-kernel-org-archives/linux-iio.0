Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bubo.tul.cz ([147.230.16.1]:56606 "EHLO bubo.tul.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750827AbdBTW0T (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Feb 2017 17:26:19 -0500
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding
 names, pre-calibration, flipping and rotation
To: "H. Nikolaus Schaller" <hns@goldelico.com>,
        Pavel Machek <pavel@ucw.cz>
References: <20170218225435.GA4693@amd>
 <CC600A84-A5C8-4A8C-8CF4-B54C57DF73F3@goldelico.com>
 <20170219141715.GA7159@amd>
 <05F3816F-46E6-4BC2-9E2E-F20E645F7197@goldelico.com>
 <20170219171518.GA12833@amd>
 <B41253A6-95D5-4E0F-ABD6-6909362843C4@goldelico.com>
 <20170219190547.GA17292@amd>
 <EB41EEED-0D94-473F-944F-757B25350A4C@goldelico.com>
 <20170219205708.GA9641@amd>
 <6DF7B03A-8B63-422C-9561-69A34A7FBF35@goldelico.com>
 <20170219221930.GA1568@amd>
 <6610D852-4717-47A7-BFDE-52C8E9E614BB@goldelico.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
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
        linux-input@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>, linux-iio@vger.kernel.org,
        kernel@pyra-handheld.com, Aaro Koskinen <aaro.koskinen@nokia.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        Andrey Gelman <andrey.gelman@compulab.co.il>,
        Haibo Chen <haibo.chen@freescale.com>
From: Petr Cvek <petr.cvek@tul.cz>
Message-ID: <e3dd020e-8590-6e65-9151-b5f1492debcb@tul.cz>
Date: Mon, 20 Feb 2017 23:26:59 +0100
MIME-Version: 1.0
In-Reply-To: <6610D852-4717-47A7-BFDE-52C8E9E614BB@goldelico.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi

Dne 20.2.2017 v 17:50 H. Nikolaus Schaller napsal(a):
> Hi Pavel,
> 
>> Am 19.02.2017 um 23:19 schrieb Pavel Machek <pavel@ucw.cz>:
>>
>> hi!
>>
>>>>> But as said I don't think we need float or fixed point for practical systems
>>>>> at all.
>>>>
>>>> So you are going to loose precision. And if userspace decides to
>>>> calibrate it slightly differently from kernel, lost precision will
>>>> matter.
>>>
>>> Really?
>>
>> Really.
>>
>>> Example:
>>>
>>> ADC values go 100 .. 3995 (i.e. touch margin is 100 steps in pre-calibration)
>>>
>>> This is scaled to let's say 0..640.
>>
>> Ok. Now userspace realizes that kernel alignemnt is off, and it would
>> want to scale it to 1..642.
> 
> Screen coordinates are still 0..639.
> 
>> That will mean that single pixel will be
>> inaccessible, right?
> 
> Yes, that can happen if the additional user-space scale is > 1.0.
> 
> As long as it is small (I expect <1.01 = 1% error in scale) it is
> barely noticeable.
> 
> Therefore, I asked before: how big in pixels is your finger or stylus?
> Does this effect matter?
> 
> A resistive touch is a man-machine-interface where people press buttons of at
> least 12x12 pixels size (or they are no longer visually recognizable).

Smallest kernel font is 4x6 (i think) and I'm regularly using 8x8. I would like
to be able to select a single letter in the console.

cheers,
Petr
