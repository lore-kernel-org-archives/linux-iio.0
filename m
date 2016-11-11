Return-Path: <hns@goldelico.com>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v4 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
From: H. Nikolaus Schaller <hns@goldelico.com>
In-Reply-To: <CAL_JsqLhBwb4eJdrAqLLksovcfP1xm9RGTUQKVvF_WxJaMn4WA@mail.gmail.com>
Date: Fri, 11 Nov 2016 20:01:42 +0100
Cc: Sebastian Reichel <sre@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Mark Rutland <mark.rutland@arm.com>,
 =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
 Tony Lindgren <tony@atomide.com>,
 Russell King <linux@armlinux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>,
 Michael Welling <mwelling@ieee.org>,
 =?utf-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
 Javier Martinez Canillas <javier@osg.samsung.com>,
 Igor Grinberg <grinberg@compulab.co.il>,
 "Andrew F. Davis" <afd@ti.com>,
 Mark Brown <broonie@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>,
 "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-omap <linux-omap@vger.kernel.org>,
 Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 kernel@pyra-handheld.com
Message-Id: <5B9946BF-1688-4BC8-82D5-A2A972B2B3C1@goldelico.com>
References: <cover.1476712675.git.hns@goldelico.com> <76746b85957c9f3ef7101a7ee883898a414cabd8.1476712675.git.hns@goldelico.com> <CAL_JsqJhzZC6Hw3eRLFDiBA8jih=N507WvEh=TRbPhLS9EjhBQ@mail.gmail.com> <3D3CBADC-42F7-4A2B-9D0D-40A0649F79FB@goldelico.com> <CAL_JsqLhBwb4eJdrAqLLksovcfP1xm9RGTUQKVvF_WxJaMn4WA@mail.gmail.com>
To: Rob Herring <robh+dt@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

Hi Rob,
finally I found time to catch up. Sorry for the delay.

> Am 31.10.2016 um 04:39 schrieb Rob Herring <robh+dt@kernel.org>:
>=20
> On Tue, Oct 18, 2016 at 12:27 PM, H. Nikolaus Schaller
> <hns@goldelico.com> wrote:
>> Hi Rob,
>>=20
>>> Am 18.10.2016 um 18:22 schrieb Rob Herring <robh+dt@kernel.org>:
>>>=20
>>> On Mon, Oct 17, 2016 at 8:57 AM, H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>>>> commit b98abe52fa8e ("Input: add common DT binding for =
touchscreens")
>>>> introduced common DT bindings for touchscreens [1] and a helper =
function to
>>>> parse the DT.
>>>>=20
>>>> commit ed7c9870c9bc ("Input: of_touchscreen - add support for =
inverted / swapped axes")
>>>> added another helper for parsing axis inversion and swapping
>>>> and applying them to x and y coordinates.
>>>>=20
>>>> Both helpers have been integrated to accommodate any orientation of =
the
>>>> touch panel in relation to the LCD.
>>>=20
>>> Please add the explanation of why this is a compatible change here.
>>=20
>> Can you please describe in more detail what you are missing here?
>=20
> You stop handling ti,fuzzx for example. So the default driver value
> will be used and this is okay because...

Ok, now I see. Thanks!

>=20
> Seems like you would have a regression in behavior if the fuzz values
> specified in an existing DT are ignored.

Well, is there any existing DT using this ti,fuzz property for a =
tsc2007?

I did not find any use of it in arch/arm/boot/dts.

Since we mainly want to fix arch/arm/boot/dts/omap3-gta04.dts we do not
want to introduce the old ti,fuzzx any more. Rather we want to use the
new "touchscreen-fuzz-x".

Therefore, I thought that it is safe to remove them - and forgot to
mention that anywhere.

If someone shows a device where the ti,fuzz is still used, we can still
add code to override what has been parsed by the common bindings. Or =
he/she
can change the DT of the device.

>=20
>> The patch simply makes use of the generic helper function introduced =
by the
>> two patches cited above and is therefore automatically compatible if =
none of
>> the new properties is defined.
>>=20
>> The tsc2007 didn't have these features before. So what should we say
>> about compatibility?
>=20
> It certainly had the fuzz features before.

>=20
>=20
>>>> -- ti,max-rt: maximum pressure.
>>>> -- ti,fuzzx: specifies the absolute input fuzz x value.
>>>> -  If set, it will permit noise in the data up to +- the value =
given to the fuzz
>>>> -  parameter, that is used to filter noise from the event stream.
>>>> -- ti,fuzzy: specifies the absolute input fuzz y value.
>>>> -- ti,fuzzz: specifies the absolute input fuzz z value.

I have now added a note in the commit message that the ti,fuzz =
properties are
removed as well by this patch.

>>>> +- ti,max-rt: maximum pressure resistance above which samples are =
ignored
>>>> +  (default: 4095).
>>>> +- ti,report-resistance: report resistance (no pressure =3D max_rt) =
instead
>>>> +  of pressure (no pressure =3D 0).
>>>> +- ti,min-x: minimum value reported by X axis ADC (default 0).
>>>> +- ti,max-x: maximum value reported by X axis ADC (default 4095).
>>>> +- ti,min-y: minimum value reported by Y axis ADC (default 0).
>>>> +- ti,max-y: maximum value reported by Y axis ADC (default 4095).
>>>=20
>>> I thought these were going to be common? I think they should be.
>>=20
>> Yes, we had discussed that before.
>>=20
>> In a second thought, I found that they are not even existing for the =
different
>> touch chip drivers that are around. And some chip might not need them =
(because
>> e.g. min/max are constants or defined my means outside the DT or the =
chip itself
>> can store them in NV memory).
>>=20
>> And, since they define ADC raw-values, they are very closely related =
to the
>> individual chip, so that I am not sure if it is really necessary to =
make
>> them common. At least if they are properly documented in the bindings =
for
>> the specific chip they can have different names without disturbing =
each
>> other.
>=20
> They wouldn't disturb each other, but then there is no chance to have
> common parsing either.

What do we need common parsing for these, if they are really specific to =
the
combination of some touch and exactly this chip?

This is different from specifying a touch dimension or fuzz value in =
pixels.
Those are passed to the input layer and must be common. But these here =
are
not and it is the purpose of the driver to hide them from user space =
(unless
they are used as "reasonable" defaults because DT isn't complete or not =
up
to date).

>=20
>> So I think it is perfectly reasonable to define common bindings =
towards
>> the input event layer (e.g. size, fuzz, swapping, inversion) and =
support
>> them by common code which bakes raw coordinates into input events. =
The latest
>> helper functions already do most of that fully automatic.
>=20
> I could argue that size in pixels has no business being in DT.

The touchscreen common bindings define the units as "size in pixels".

> That's a property of the panel the touchscreen is glued to. I guess in =
some
> cases, the controller is internally scaling the ADC values.

Yes and that scaling is what the tsc2007 driver is doing here because =
the
controller doesn't internally like for e.g. USB connected touch screens.

>=20
>> Next, I had simply copied them from the ads7846 driver where they
>> exist for a long time. So this is sort of "common", at least for two =
different
>> chips now. See also patch 6/8 of this series which adds the common =
properties
>> to the ads7846 as well.
>>=20
>> For more reference about the existing bindings:
>>=20
>> Documentation/devicetree/bindings/input/ads7846.txt
>>=20
>> (btw I think someone should move them to bindings/input/touchscreen).
>=20
> Patches welcome.

I have added a patch to [PATCH v7].

>=20
>> It appears as if there is some overlap of the new generic properties =
(for x/y
>> swapping) with the old ads7846 properties, but that is something you =
had
>> already proposed a while ago to make me the driver recognize both =
properties to
>> stay compatible with older DT files.
>>=20
>> So if we now rename the min/max-x/y properties for the tsc2007 we =
have to rename
>> them for the ads7846 (and maybe others) as well, which might break =
out-of-tree
>> ads7846 devices or leads to more complex code for handling of =
property aliases.
>=20
> We don't have to rename them for ads7846. That's already baked.

And the longer I think about it, the more I think it is well baked as it =
is.

> But there's a trend here.

Which trend do you see?

IMHO these adc-min/max properties are very chip specific and there have =
not been
many new resistive touch controllers announced recently. So I do not see =
anything
which could become a trend.

> You're defining the same property. Use a common
> name, so when the 3rd binding comes along needing the same thing, we
> already have a common binding.

Why not take the already existing 1st binding of the ads7846 and let the =
tsc2007
come along as the 2nd one which needs the same thing?

Then we have a common binding between these two now and don't need to =
wait for
a 3rd one to come (in some uncertain future).

Therefore, I have not yet touched code or description in this area =
because I don't
know how to do it really better than proposed in [PATCH v4].

[Patch v7] for the whole series will come right after this mail.

BR and thanks,
Nikolaus
