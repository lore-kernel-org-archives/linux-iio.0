Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-db5eur01on0106.outbound.protection.outlook.com ([104.47.2.106]:40432
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750845AbdAaHg6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 31 Jan 2017 02:36:58 -0500
Subject: Re: [PATCH v8 07/12] dt-bindings: i2c: i2c-mux-simple: document
 i2c-mux-simple bindings
To: Rob Herring <robh@kernel.org>
References: <1484755035-25927-1-git-send-email-peda@axentia.se>
 <1484755035-25927-8-git-send-email-peda@axentia.se>
 <20170127193917.6xuunrkjkqh4f2v7@rob-hp-laptop>
 <835415bf-77af-6131-d018-d0bc7d8233b0@axentia.se>
 <CAL_JsqLVrzm4BEv3kpOGRoaRq+cqvSm+A6weZfU8H8i9dc=tcA@mail.gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
From: Peter Rosin <peda@axentia.se>
Message-ID: <cdc958c3-2496-be52-6407-bf9aefdfa965@axentia.se>
Date: Tue, 31 Jan 2017 08:36:48 +0100
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLVrzm4BEv3kpOGRoaRq+cqvSm+A6weZfU8H8i9dc=tcA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2017-01-30 18:20, Rob Herring wrote:
> On Sat, Jan 28, 2017 at 4:42 PM, Peter Rosin <peda@axentia.se> wrote:
>> On 2017-01-27 20:39, Rob Herring wrote:
>>> On Wed, Jan 18, 2017 at 04:57:10PM +0100, Peter Rosin wrote:
>>>> Describe how a generic multiplexer controller is used to mux an i2c bus.
>>>>
>>>> Acked-by: Jonathan Cameron <jic23@kernel.org>
>>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>>> ---
>>>>  .../devicetree/bindings/i2c/i2c-mux-simple.txt     | 81 ++++++++++++++++++++++
>>>>  1 file changed, 81 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-simple.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-simple.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-simple.txt
>>>> new file mode 100644
>>>> index 000000000000..253d5027843b
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/i2c/i2c-mux-simple.txt
>>>> @@ -0,0 +1,81 @@
>>>> +Simple I2C Bus Mux
>>>> +
>>>> +This binding describes an I2C bus multiplexer that uses a mux controller
>>>> +from the mux subsystem to route the I2C signals.
>>>> +
>>>> +                                  .-----.  .-----.
>>>> +                                  | dev |  | dev |
>>>> +    .------------.                '-----'  '-----'
>>>> +    | SoC        |                   |        |
>>>> +    |            |          .--------+--------'
>>>> +    |   .------. |  .------+    child bus A, on MUX value set to 0
>>>> +    |   | I2C  |-|--| Mux  |
>>>> +    |   '------' |  '--+---+    child bus B, on MUX value set to 1
>>>> +    |   .------. |     |    '----------+--------+--------.
>>>> +    |   | MUX- | |     |               |        |        |
>>>> +    |   | Ctrl |-|-----+            .-----.  .-----.  .-----.
>>>> +    |   '------' |                  | dev |  | dev |  | dev |
>>>> +    '------------'                  '-----'  '-----'  '-----'
>>>> +
>>>> +Required properties:
>>>> +- compatible: i2c-mux-simple,mux-locked or i2c-mux-simple,parent-locked
>>>
>>> Not a fan of using "simple" nor the ','. Perhaps lock type should be
>>> separate property.
>>
>> How about just i2c-mux for the compatible? Because i2c-mux-mux (which
>> follows the naming of previous i2c muxes) looks really stupid. Or
>> perhaps i2c-mux-generic?
> 
> I like "generic" only slightly more than "simple". :)
> 
> If the mux is gpio controlled, then it should still be called
> i2c-gpio-mux. Let's not invent brand new bindings when current ones
> are easily extended. We already have pretty generic names here, let's
> not make them more generic.

Ahh, but the whole point of this new driver is that it does not know
if the mux is gpio controlled, if it is controlled by an adg792 chip
or whatever might appear down the line. So, I think i2c-mux-gpio (and
i2c-gpio-mux) is actively wrong.

This new driver is in fact an i2c-mux driver that (in this aspect) is more
generic than any of the existing i2c-mux drivers, hence my suggestion.

If you see this new driver as something that is superseding the existing
i2c-mux-gpio driver, I'm sad to inform you that the code is not simply
not there. i2c-mux-gpio has acpi support and users may provide platform
data from code. The existing i2c-mux-gpio driver also has the below
mentioned locking heuristic. Adding all those things to the new driver
would make it big and unwieldy and having even more unwanted tentacles
into other subsystems. And why should it be only i2c-mux-gpio that is
merged into this new i2c-mux driver? Why not implement a mux-pinctrl
driver for the new mux subsustem and then merge i2c-mux-pinctrl as well?
I say no, that way lies madness.

>>
>> I'm also happy to have the lock type as a separate property. One lock
>> type, e.g. parent-locked, could be the default and adding a 'mux-locked'
>> property could change that. Would that be ok?
> 
> I prefer this. Then existing bindings can use it.
> 
>> Or should it be a requirement that one of 'mux-locked'/'parent-locked'
>> is always present?
> 
> I would make it boolean and make not present be the more common case.
> Not present could also mean determined via other means as you have
> today with existing bindings. Maybe then you need both properties.

Ok. Lets define that every type of i2c-mux have a default locking.
If no property is found that overrides this default, a heuristic may
be applied that is only allowed to very defensively use non-default
locking (like the current heuristics in i2c-mux-gpio/i2c-mux-pinctrl
attempt to do, they only adjust the locking for impossible cases that
would invariably lead to a deadlock with the default locking). Then,
there should never exist a need to enforce the default locking with
a property.

And given that no current i2c-mux that is mux-locked by default even
have the ability to be parent-locked, there is (currently) no need
for more than a bool 'mux-locked' property.

>>> I'm not sure I get the mux vs. parent locked fully. How do I determine
>>> what type I have? We already have bindings for several types of i2c
>>> muxes. How does the locking annotation fit into those?
>>
>> We have briefly discussed this before [1] in the context of i2c-mux-gpio
>> and i2c-mux-pinctrl, when I added the mux-locked/parent-locked distinction
>> to the i2c-mux infrastructure (it wasn't named mux-locked/parent-locked
>> way back then though). There is more detail on what the difference is
>> between the two in Documentation/i2c/i2c-topology.
>>
>> Side note regarding your remark "use an I2C controlled mux instead"; it
>> appears that I'm not alone [2] with this kind of requirement...
>>
>> [1] https://lkml.org/lkml/2016/1/6/437
>> [2] http://marc.info/?t=147877959100002&r=1&w=2
>>
>> But, now that I have pondered on this for a year or so, I firmly
>> believe it was a mistake to have the code in i2c-mux-gpio and
>> i2c-mux-pinctrl automatically try to deduce if the mux should be
>> mux-locked or parent-locked. It might be easy to make that call
>> in some trivial cases, but it is not difficult to dream up
>> scenarios where it would be extremely hard for the code to get
>> this decision right. It's just fragile. But now we have code in
>> those two muxes that has unwanted tentacles into the guts of the
>> gpio and pinctrl subsystems. Hopefully those unwanted tentacles
>> can be replaced with something based on device links? However, it
>> is still not hard to come up with scenarios that will require
>> manual intervention in order to select the right kind of i2c mux
>> locking. So, I fear that we have inadequate code trying to make a
>> decision automatically, and that we at some point down the line
>> will have some impossible case needing a binding that trumps the
>> heuristic. Why have a heuristic at all in that case? In short, it
>> should have been a binding from the start, methinks.
>>
>> That was a long rant regarding i2c-mux-gpio and i2c-mux-pinctrl.
>> I obviously think it is bad to have this new i2c mux go in the
>> same direction as those two drivers. I.e. I think a binding that
>> specifies the desired locking is preferable to any attempted
>> heuristic.
> 
> Having a separate, common property(ies) for these would solve this then.

Yep, the plan is now to make this new i2c-mux parent-locked by default
and then look for an optional mux-locked property, thus eliminating the
comma and the suffix in the compatible string, leaving only whatever is
eventually picked from 'i2c-mux-simple', 'i2c-mux', 'i2c-mux-generic' and
'i2c-mux-whatever'.

Do I need to re-document the mux-locked/parent-locked difference? I.e.,
is it enough to refer to Documentation/i2c/i2c-topology, or does the
Documentation/devicetree subdir need to self-contained?

Cheers,
peda

