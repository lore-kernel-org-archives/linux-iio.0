Return-Path: <harald@ccbib.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Wed, 04 May 2016 13:38:25 +0200
From: Harald Geyer <harald@ccbib.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, <devicetree@vger.kernel.org>,
 <linux-iio@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <kernel@pengutronix.de>, Marek Vasut <marex@denx.de>,
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/3] iio: mxs-lradc: Add regulators for current sources
In-Reply-To: <1e7d5f3a-22c1-94d4-9620-7aa112602e39@kernel.org>
References: <1461333147-11873-1-git-send-email-harald@ccbib.org>
 <1461333147-11873-2-git-send-email-harald@ccbib.org>
 <57288674.9050601@i2se.com> <6cdd4f858dacf72e192a292f29c12feb@ccbib.org>
 <1e7d5f3a-22c1-94d4-9620-7aa112602e39@kernel.org>
Message-ID: <0e2b0d54b37d5c780b7b81b64b4e9743@ccbib.org>
List-ID: <linux-iio@vger.kernel.org>

On 04.05.2016 09:15, Jonathan Cameron wrote:
> On 03/05/16 12:22, Harald Geyer wrote:
>> On 03.05.2016 13:07, Stefan Wahren wrote:
>>> Am 22.04.2016 um 15:52 schrieb Harald Geyer:
>>>> The hardware has two current sources ISRC0 and ISRC1 to allow 
>>>> measuring
>>>> resistors without additional circuitry. This commit makes them 
>>>> available
>>>> as regulators.
>>>>
>>>> Tested on an imx233-olinuxino board.
>>>>
>>>> Signed-off-by: Harald Geyer <harald@ccbib.org>
>>>> ---
>>>> The current regulator API doesn't fit this type of device very 
>>>> well: Typically
>>>> consumers will want to set a defined current, ie. min_uA == 
>>>> max_uA, but they
>>>> can't without help from configuration data, because the valid 
>>>> values aren't
>>>> reported by the API for current regulators. I have been thinking 
>>>> about
>>>> extending the API, but currently AFAIK no such consumers exist and 
>>>> most
>>>> users, like myself, will force the regulator to a defined value in
>>>> devicetree anyway.
>>>>
>>>>  .../bindings/staging/iio/adc/mxs-lradc.txt         |  29 ++++
>>>>  drivers/iio/adc/Kconfig                            |   1 +
>>>>  drivers/iio/adc/mxs-lradc.c                        | 152 
>>>> +++++++++++++++++++++
>>>>  3 files changed, 182 insertions(+)
>>>>
>>>> diff --git 
>>>> a/Documentation/devicetree/bindings/staging/iio/adc/mxs-lradc.txt 
>>>> b/Documentation/devicetree/bindings/staging/iio/adc/mxs-lradc.txt
>>>> index 555fb11..983952c 100644
>>>> --- 
>>>> a/Documentation/devicetree/bindings/staging/iio/adc/mxs-lradc.txt
>>>> +++ 
>>>> b/Documentation/devicetree/bindings/staging/iio/adc/mxs-lradc.txt
>>>> @@ -19,6 +19,15 @@ Optional properties:
>>>>  - fsl,settling: delay between plate switch to next sample. 
>>>> Allowed value is
>>>>                  1 ... 2047. It counts at 2 kHz and its default is
>>>>                  10 (= 5 ms)
>>>> +- ISRC0: A node describing the regulator of internal current 
>>>> source 0
>>>> +- ISRC1: A node describing the regulator of internal current 
>>>> source 1
>>>> +
>>>> +Required properties for the ISRCx sub-nodes:
>>>> +- regulator-max-microamp: See standard regulator binding 
>>>> documentation.
>>>> +                          Valid values are from 0 to 300 in steps 
>>>> of 20.
>>>> +
>>>> +Optional properties for the ISRCx sub-nodes:
>>>> +Any standard regulator properties that apply to current 
>>>> regulators.
>>>>
>>>>  Example for i.MX23 SoC:
>>>>
>>>> @@ -31,6 +40,16 @@ Example for i.MX23 SoC:
>>>>          fsl,ave-ctrl = <4>;
>>>>          fsl,ave-delay = <2>;
>>>>          fsl,settling = <10>;
>>>> +
>>>> +        isrc_lradc0: ISRC0 {
>>>> +            regulator-max-microamp = <300>;
>>>> +        };
>>>> +
>>>> +        isrc_lradc1: ISRC1 {
>>>> +            regulator-max-microamp = <120>;
>>>> +            regulator-min-microamp = <120>;
>>>> +            regulator-always-on;
>>>> +        };
>>>
>>> IMHO the binding should represent the direct connection between the
>>> current source and the physical channel. I think a node label isn't
>>> enough. Unfortunately i don't have an idea to do it the "right 
>>> way".
>>
>> I strictly followed the names of the data sheet here: imx23 and 
>> imx28
>> reference manuals both call the current sources ISRC0 and ISRC1 even
>> if they are attached to different channels of the ADC. I think
>> inventing some ISRC6 for imx28 would do more harm then good.
> So just to check... These two current sources are effectively
> pushing current out of the ADC input pin?  Assumption being that
> this causes an appropriate voltage across a component between there
> and 0V?

Exactly.

> I wonder if we are better off not treating these as regulators at
> all - whilst you could in theory use them for general purposes, it
> would be a bit nuts and sometimes the 'it is nuts argument' is
> enough to mean we don't support something :)

Yeah, it would be some funny 4-bit DAC ...

> I wouldn't have any problem with an additional attribute for the
> adc channels - maybe something like...
>
> in_voltage6_sourcecurrent?  Then the control could be pushed to
> userspace.

I'm very open to that idea. Not having yet an other subsystem
involved would simplify some things a lot.

> Or if it only makes sense to do it as a fixed value in DT then
> define optional child nodes for the individual channels, with
> the relevant ones have current-source-microamp or
> something like that as an parameter.

My research in thermistors is still ongoing (so I don't have
a kernel driver yet) but I think for thermistors with
exponential temperature dependence dynamic setting of the
current source will be necessary to get high resolution across
the whole temperature range.

Of course many applications wont need this. For checks like
"Is my battery over-heating?" a simple fixed current from DT
will to well, so I guess we should support both.

> What do you think?

As I already stated in an other subthread, I'm not entirely
happy with the regulator approach. Having everything inside
iio would make supporting complex use cases easier in the
future, I guess.

Also IIO devices are much easier to control from user space
then regulators, which might be desired for this type of
device.

OTOH I'm not sure how many other devices out there have a
similar feature. I'd rather not invent a new API for just
very few devices. IMO iio already suffers from the
complexity of the sysfs API. Maybe somebody with a good
overview of ADCs available on the market can provide some
input here.

Also of course there are lots of ADCs out there without
internal current source and those could be used with
thermistors too but would need a regulator anyway.
So maybe eventually we would end up with both solutions
supported, which I'd avoid if at all possible. (I guess
we could work around the last issue by providing some
generic driver to pull an iio channel and a regulator
together - do we like that level of abstraction?)

If we start our own API to control current sources we
might end up pretty much reimplementing the regulator
API for the single consumer case.

I'd like to have input from more people on the above
points before going one way or the other.

Thanks,
Harald

> Jonathan
>
>>
>>>>      };
>>>>
>>>>  Example for i.MX28 SoC:
>>>> @@ -44,4 +63,14 @@ Example for i.MX28 SoC:
>>>>          fsl,ave-ctrl = <4>;
>>>>          fsl,ave-delay = <2>;
>>>>          fsl,settling = <10>;
>>>> +
>>>> +        isrc_lradc0: ISRC0 {
>>>> +            regulator-max-microamp = <300>;
>>>> +        };
>>>> +
>>>> +        isrc_lradc6: ISRC1 {
>>>> +            regulator-max-microamp = <120>;
>>>> +            regulator-min-microamp = <120>;
>>>> +            regulator-always-on;
>>>> +        };
>>>>      };
>>>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>>>> index 5937030..1968d1c 100644
>>>> --- a/drivers/iio/adc/Kconfig
>>>> +++ b/drivers/iio/adc/Kconfig
>>>> @@ -319,6 +319,7 @@ config MXS_LRADC
>>>>          tristate "Freescale i.MX23/i.MX28 LRADC"
>>>>          depends on (ARCH_MXS || COMPILE_TEST) && HAS_IOMEM
>>>>          depends on INPUT
>>>> +        depends on REGULATOR
>>>
>>> Any chance to avoid this dependency for an optional feature?
>>
>> I haven't looked into it yet, but I expect that that the mfd
>> conversion will avoid this neatly.
>>
>> Thanks,
>> Harald
>>
>>> Stefan
>>>
>>>>          select STMP_DEVICE
>>>>          select IIO_BUFFER
>>>>          select IIO_TRIGGERED_BUFFER
>>

-- 
If you want to support my work:
see http://friends.ccbib.org/harald/supporting/
or donate via peercoin to P98LRdhit3gZbHDBe7ta5jtXrMJUms4p7w
or bitcoin 1FUtd8T9jRN1rFz63vZz7s2fDtB6d6A7aS
