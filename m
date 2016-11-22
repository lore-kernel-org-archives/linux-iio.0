Return-Path: <hns@goldelico.com>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v6 2/8] drivers:input:tsc2007: send pendown and penup only once like ads7846(+tsc2046) driver does
From: H. Nikolaus Schaller <hns@goldelico.com>
In-Reply-To: <20161119181229.GA20446@dtor-ws>
Date: Tue, 22 Nov 2016 15:08:11 +0100
Cc: Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
 Tony Lindgren <tony@atomide.com>,
 Russell King <linux@armlinux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>,
 Michael Welling <mwelling@ieee.org>,
 =?utf-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
 Javier Martinez Canillas <javier@osg.samsung.com>,
 Igor Grinberg <grinberg@compulab.co.il>,
 Sebastian Reichel <sre@kernel.org>,
 "Andrew F. Davis" <afd@ti.com>,
 Mark Brown <broonie@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>,
 Sangwon Jee <jeesw@melfas.com>,
 linux-input@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org,
 letux-kernel@openphoenux.org,
 linux-iio@vger.kernel.org,
 kernel@pyra-handheld.com
Message-Id: <0A0057DD-0EA8-420A-B963-FC37C8942387@goldelico.com>
References: <cover.1477557860.git.hns@goldelico.com> <5e961a92f11b1509bd0effb96ef560f19839aa9d.1477557860.git.hns@goldelico.com> <20161119181229.GA20446@dtor-ws>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Hi Dmitry,

> Am 19.11.2016 um 19:12 schrieb Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> 
> On Thu, Oct 27, 2016 at 10:44:15AM +0200, H. Nikolaus Schaller wrote:
>> this should reduce unnecessary input events.
> 
> The duplicates will be filtered out by the input core anyway. I like to
> keep the drivers simple.

Well, the idea was copied from the ads7846 driver. But there it is used
to provide a /sys status.

I have tried to find the code location that really makes sure that the
BTN_TOUCH is reported only once, but didn't find it.

My thought is that having it here makes me more sure that it is really
filtered because it does not to rely on functions deeply hidden in the
input core.

On the other hand we apparently also rely on ABS_X etc. to be filtered
by core.

In any case I have tested with and without and it does not make a difference.
Maybe it was needed when we started to work on this driver some years ago
before posting the patches here.

So I drop it from v8 which will come in some minutes.

> 
> Thanks.

BR and thanks,
Nikolaus
