Return-Path: <swarren@wwwdotorg.org>
Message-ID: <5212433E.4090802@wwwdotorg.org>
Date: Mon, 19 Aug 2013 10:09:34 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Mark Rutland <mark.rutland@arm.com>
CC: Jacek Anaszewski <j.anaszewski@samsung.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 Jonathan Cameron <jic23@kernel.org>,
 "maxime.ripard@free-electrons.com" <maxime.ripard@free-electrons.com>,
 "lars@metafoo.de" <lars@metafoo.de>,
 "l.czerwinski@samsung.com" <l.czerwinski@samsung.com>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 Pawel Moll <Pawel.Moll@arm.com>,
 "ian.campbell@citrix.com" <ian.campbell@citrix.com>,
 "s.nawrocki@samsung.com" <s.nawrocki@samsung.com>
Subject: Re: passing two interrupts two an I2C driver
References: <520E3B8F.9010800@samsung.com> <520E7417.3090606@wwwdotorg.org> <20130819084227.GC3719@e106331-lin.cambridge.arm.com>
In-Reply-To: <20130819084227.GC3719@e106331-lin.cambridge.arm.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 08/19/2013 02:42 AM, Mark Rutland wrote:
> On Fri, Aug 16, 2013 at 07:48:55PM +0100, Stephen Warren wrote:
>> On 08/16/2013 08:47 AM, Jacek Anaszewski wrote:
>>> Hi all,
>>>
>>> I'd like to consult the implementation of DT binding for the I2C device
>>> that exposes two interrupt pins (INT1 and INT2). Both pins can be
>>> configured to generate either data ready interrupts or event interrupts.
>>> I want to implement DT binding that will handle also the situation
>>> when only one of the interrupt sources is routed from the device
>>> to the CPU.
>>>
>>> Below is my implementation using interrupt-map:
>>
>>> +  - interrupt-parent : phandle to the interrupt map subnode
>>
>> When using interrupt-parent to point at an interrupt map, I believe you
>> usually just point at the current node; there's no need to a child node.
>>
>>> +  - interrupts : interrupt mapping for LPS331AP interrupt sources:
>>> +                2 sources: 0 - data ready, 1 - threshold event
>>
>>> +  - irq-map : irq sub-node defining interrupt map
>>> +             (all properties listed below are required):
>>
>> So, this node isn't required.
>>
>>> +      - #interrupt-cells : should be 1
>>
>>> +      - #address-cells : should be 0
>>> +      - #size-cells : should be 0
>>
>> There are no addressed entities in this node, so I don't see why those
>> two properties are needed.
>>
>>> +      - interrupt-map : table of entries consisting of three child elements:
>>> +         - unit_interrupt_specifier - 0 : data ready, 1 : threshold event
>>> +         - interrupt parent phandle
>>> +         - parent unit interrupt specifier consisiting of two elements:
>>> +             - index of the interrupt within the controller
>>> +             - flags : should be 0
>>
>> It's up to the binding for the node referenced by the phandle to define
>> how many cells need be present for "flags", and their meaning. This
>> binding shouldn't attempt to describe those. Equally, the concept of
>> interrupt-map should be defined elsewwere (e.g.
>> Documentation/devicetree/bindings/interrupt-controller/interrupts.txt);
>> it's a generic that shouldn't need duplication in each binding that uses
>> interrupts.
>>
>>> +Example:
>>> +
>>> +lps331ap@5d {
>>> +       compatible = "st,lps331ap";
>>> +       reg = <0x5d>;
>>> +       drdy-int-pin = /bits/ 8 <2>;
>>> +       interrupt-parent = <&irq_map>;
>>> +       interrupts = <0>, <1>;
>>> +
>>> +       irq_map: irq-map {
>>> +               #interrupt-cells = <1>;
>>> +               #address-cells = <0>;
>>> +               #size-cells = <0>;
>>> +               interrupt-map = <0 &gpf0 5 0>;
>>> +       };
>>> +};
>>>
>>> And here is how the driver uses this information:
>>>
>>>  - if interrupt-map is empty then the driver configures
>>>    itself to work without interrupt support
>>
>> The presence or lack of interrupt support should be driven by the
>> presence of the interrupts property. interrupt-map should only be used
>> (if present) to assist in the parsing of the interrupts property.
>>
>>>  - if only one interrupt source is available then the driver
>>>    configures the device to generate data ready interrupts on
>>>    the corresponding INTx pin (in this case the driver must know which
>>>    of the device pins is routed to the cpu -
>>>    st,data-ready-interrupt-pin property conveys this information)
>>>  - if both interrupt sources are available then the driver configures
>>>    the device to generate data ready interrupts on the interrupt pin
>>>    corresponding to the interrupt source with index 0 and event
>>>    interrupts to the interrupt source with index 1.
>>>
>>> This solution seems to be a little awkward so I'd like to ask
>>> if there is any neater way to handle presented requirements.
>>> The solution must facilitate passing information about two
>>> interrupt sources two the I2C driver. I have been unable to find
>>> similar solution in the kernel so far.
>>
>> Indeed. I think it would be better to work as follows:
>>
>> interrupts: contains one or two interrupt specifiers. The first entry
>> always defines the data ready interrupt. The second entry, if present,
>> defines the threshold event interrupt. This at least allows the
>> following combinations to be very simple expressed:
>>
>> * no interrrupts
>> * just data
>> * both data and threshold (assuming they're routed to the same parent)
>>
>> (you could swap the order if it's likely to be more common to have just
>> a threshold interrupt without any data interrupt).
>>
>> In order to allow the presence of a threshold interrupt but no data
>> interrupt, then I think you would need interrupt-map:
>>
>> lps331ap: lps331ap@5d {
>> 	compatible = "st,lps331ap";
>> 	reg = <0x5d>;
>> 	interrupt-parent = <&lps331ap>;
>> 	interrupts = <0>, <1>;
>> 	interrupt-map =	<0 0>, /* nowhere */
>> 			<1 &gpf0 6 0>;
>> };
> 
> The interrupt-names property exists for this purpose (describing
> interrupts which may or may not be present). Describing a nonexistent
> interrupt and mapping it nowhere feels like a hack to me when we can
> describe exactly what's present.

But the rules for interrupts basically precludes the useful use of
interrupt-names.

The interrupts property was introduced long before interrupt-names. As
such, the rule was always that entries in interrupts had to appear at a
specific index in the property, in other words, the property had to be
in a specific order, and there's no way of missing entries out.

The interrupt-names property was added much later and more as a
documentation for the order in *.dts than as the primary lookup key.
Even with an interrupt-names property present, the order of entries in
interrupts is still fixed.

So, using interrupt-names doesn't allow you to have optional entries in
interrupts, nor re-order the property. We really should not have added
interrupt-names, since it gives false impressions.

For newer bindings such as clocks/clock-names, clock-names is the
primary lookup key, so things can be optional.

We should document which properties are purely looked up by index, and
which properties have a useful *-names property associated with them as
the primary lookup key.
