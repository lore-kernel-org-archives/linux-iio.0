Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yb0-f193.google.com ([209.85.213.193]:33440 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbdBUI6N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Feb 2017 03:58:13 -0500
MIME-Version: 1.0
In-Reply-To: <20170221084724.GB9795@pali>
References: <cover.1482936802.git.hns@goldelico.com> <20170220010714.GB8358@dtor-ws>
 <B30D00D0-1967-4BD5-A304-E2ADC815A805@goldelico.com> <201702202042.15878@pali>
 <A41872A2-F095-47F8-B122-FFAE430B0D7F@goldelico.com> <20170221084724.GB9795@pali>
From: Christ van Willegen <cvwillegen@gmail.com>
Date: Tue, 21 Feb 2017 09:57:51 +0100
Message-ID: <CA+Ot1OwXSyncvVz-S__7buQMJ_2nHaapQ4rroqVgMKyWU7nZiA@mail.gmail.com>
Subject: Re: [Letux-kernel] [PATCH v9 1/8] drivers:input:tsc2007: add new
 common binding names, pre-calibration, flipping and rotation
To: Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrey Gelman <andrey.gelman@compulab.co.il>,
        Michel Verlaan <michel.verl@gmail.com>,
        Nick Dyer <nick@shmanahar.org>,
        Tony Lindgren <tony@atomide.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Pavel Machek <pavel@ucw.cz>,
        linux-omap <linux-omap@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Igor Grinberg <grinberg@compulab.co.il>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-input@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Engestrom <eric@engestrom.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Petr Cvek <petr.cvek@tul.cz>,
        Siebren Vroegindeweij <siebren.vroegindeweij@hotmail.com>,
        Haibo Chen <haibo.chen@freescale.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, linux-iio@vger.kernel.org,
        "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>,
        =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        kernel@pyra-handheld.com, Michael Welling <mwelling@ieee.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Alexander Stein <alexander.stein@systec-electronic.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi all,

On Tue, Feb 21, 2017 at 9:47 AM, Pali Roh=C3=A1r <pali.rohar@gmail.com> wro=
te:
> But it really make sense to set input_abs_set_res() from DT.

And _not_ add the 1 or two lines of code that checks some DT variable,
and then fixes _everybody's_ userland?

That means those lines of code need to go into _every_ userland, which
makes maintenance sooo much harder. And the kernel knows about this
and doesn't care??

Weird...

Christ van Willegen
