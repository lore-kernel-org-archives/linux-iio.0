Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:12911 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934735AbcIXF3D (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Sep 2016 01:29:03 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20160923224726.GA4639@rob-hp-laptop>
Date: Sat, 24 Sep 2016 07:28:48 +0200
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
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
        "Andrew F. Davis" <afd@ti.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, letux-kernel@openphoenux.org,
        linux-iio@vger.kernel.org
Message-Id: <118D373B-21B0-4246-A3C9-0E0373F66656@goldelico.com>
References: <cover.1474634475.git.hns@goldelico.com> <1409ed9845f17445a8a67bd6fb16c902c3e4f69c.1474634475.git.hns@goldelico.com> <20160923224726.GA4639@rob-hp-laptop>
To: Rob Herring <robh@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

> Am 24.09.2016 um 00:47 schrieb Rob Herring <robh@kernel.org>:
>=20
> On Fri, Sep 23, 2016 at 02:41:09PM +0200, H. Nikolaus Schaller wrote:
>> commit b98abe52fa8e ("Input: add common DT binding for touchscreens")
>> introduced common DT bindings for touchscreens [1] and a helper =
function to
>> parse the DT.
>>=20
>> commit ed7c9870c9bc ("Input: of_touchscreen - add support for =
inverted / swapped axes")
>> added another helper for parsing axis inversion and swapping
>> and applying them to x and y coordinates.
>>=20
>> Both helpers have been integrated to accommodate any orientation of =
the
>> touch panel in relation to the LCD.
>>=20
>> A new feature is to introduce scaling the min/max ADC values to the =
screen
>> size.
>>=20
>> This makes it possible to pre-calibrate the touch so that is (almost)
>> exactly matches the LCD pixel coordinates it is glued onto. This =
allows to
>> well enough operate the touch before a user space calibration step =
can
>> improve the precision.
>>=20
>> Finally, calculate_pressure has been renamed to calculate_resistance
>> because that is what it is doing.
>=20
> Seems like you are breaking compatibility with old DTs. I can't tell =
for=20
> sure though.

There is code to take missing values as 0 or maximum. So this will scale =
1:1
and should not break old DTs.

>=20
>>=20
>> [1]: =
Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> .../bindings/input/touchscreen/tsc2007.txt         |  20 ++--
>> drivers/input/touchscreen/tsc2007.c                | 126 =
+++++++++++++++++----
>> include/linux/i2c/tsc2007.h                        |   8 ++
>> 3 files changed, 123 insertions(+), 31 deletions(-)
>>=20
>> diff --git =
a/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt =
b/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
>> index ec365e1..6e9fd55 100644
>> --- a/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
>> +++ b/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
>> @@ -6,6 +6,7 @@ Required properties:
>> - ti,x-plate-ohms: X-plate resistance in ohms.
>>=20
>> Optional properties:
>> +- generic touch screen properties: see touchscreen binding [2].
>> - gpios: the interrupt gpio the chip is connected to (trough the =
penirq pin).
>>   The penirq pin goes to low when the panel is touched.
>>   (see GPIO binding[1] for more details).
>> @@ -13,17 +14,20 @@ Optional properties:
>>   (see interrupt binding[0]).
>> - interrupts: (gpio) interrupt to which the chip is connected
>>   (see interrupt binding[0]).
>> -- ti,max-rt: maximum pressure.
>> -- ti,fuzzx: specifies the absolute input fuzz x value.
>> -  If set, it will permit noise in the data up to +- the value given =
to the fuzz
>> -  parameter, that is used to filter noise from the event stream.
>> -- ti,fuzzy: specifies the absolute input fuzz y value.
>> -- ti,fuzzz: specifies the absolute input fuzz z value.
>> +- ti,max-rt: maximum pressure resistance above which samples are =
ignored
>> +  (default: 4095).
>> +- ti,report-resistance: report resistance (no pressure =3D max_rt) =
instead
>> +  of pressure (no pressure =3D 0).
>> +- ti,min-x: minimum value reported by X axis ADC (default 0).
>> +- ti,max-x: maximum value reported by X axis ADC (default 4095).
>> +- ti,min-y: minimum value reported by Y axis ADC (default 0).
>> +- ti,max-y: maximum value reported by Y axis ADC (default 4095).
>=20
> Seems like these could be common too. They make more sense than giving =
x=20
> and y sizes in pixel units which really should come from the panel.

No. They have a different purpose!

You need to scale values like this:

ti,min-x   ->   0
x          ->   some value between 0 and touchscreen-size-x
ti,max-x   ->   touchscreen-size-x

So the ti, values describe the ADC raw values while the common bindings
describe the size in input-event coordinates.

So we need both specified: raw values and pixel values.

>=20
>> - ti,poll-period: how much time to wait (in milliseconds) before =
reading again the
>> -  values from the tsc2007.
>> +  values from the tsc2007 (default 1).
>>=20
>> [0]: =
Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>> [1]: Documentation/devicetree/bindings/gpio/gpio.txt
>> +[2]: =
Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
>>=20
>> Example:
>> 	&i2c1 {
>> @@ -35,6 +39,8 @@ Example:
>> 			interrupts =3D <0x0 0x8>;
>> 			gpios =3D <&gpio4 0 0>;
>> 			ti,x-plate-ohms =3D <180>;
>> +			touchscreen-size-x =3D <640>;
>> +			touchscreen-size-y =3D <480>;
>> 		};
>>=20
>> 		/* ... */

BR,
Nikolaus

