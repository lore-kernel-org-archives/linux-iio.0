Return-Path: <swarren@wwwdotorg.org>
Message-ID: <521673FB.3040904@wwwdotorg.org>
Date: Thu, 22 Aug 2013 14:26:35 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Rob Herring <robherring2@gmail.com>
CC: Mark Rutland <mark.rutland@arm.com>,
 Jacek Anaszewski <j.anaszewski@samsung.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 Jonathan Cameron <jic23@kernel.org>,
 "maxime.ripard@free-electrons.com" <maxime.ripard@free-electrons.com>,
 "lars@metafoo.de" <lars@metafoo.de>,
 "l.czerwinski@samsung.com" <l.czerwinski@samsung.com>,
 Pawel Moll <Pawel.Moll@arm.com>,
 "ian.campbell@citrix.com" <ian.campbell@citrix.com>,
 "s.nawrocki@samsung.com" <s.nawrocki@samsung.com>
Subject: Re: passing two interrupts two an I2C driver
References: <520E3B8F.9010800@samsung.com> <520E7417.3090606@wwwdotorg.org> <20130819084227.GC3719@e106331-lin.cambridge.arm.com> <5212433E.4090802@wwwdotorg.org> <20130820084454.GT3719@e106331-lin.cambridge.arm.com> <52139873.1040703@wwwdotorg.org> <20130821085433.GZ3719@e106331-lin.cambridge.arm.com> <52160802.2070201@gmail.com>
In-Reply-To: <52160802.2070201@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 08/22/2013 06:45 AM, Rob Herring wrote:
> On 08/21/2013 03:54 AM, Mark Rutland wrote:
...
>> We should fix the binding documents to make clear which bindings require
>> their reg properties at fixed indexes, and those which allow for
>> arbitrarily ordered named reg entries. Named reg entries are really
>> useful for blocks with optional components, and given we have drivers
>> using them, they're already mandatory for some bindings.
> 
> No, we should fix the bindings that have arbitrarily ordered reg
> properties. There is no obvious reg examples of this that I see from a
> quick scan of dts files.
> 
> There is this questionable use of "empty" for interrupt-names:
> 
> arch/arm/boot/dts/imx23.dtsi:
> 	interrupts = <0 14 20 0
> 			13 13 13 13>;
> 	interrupt-names = "empty", "ssp0", "ssp1", "empty",
> 			"gpmi0", "gpmi1", "gpmi2", "gpmi3";
> 

Well, there's been an assertion that bindings that define an ordered
interrupts property shouldn't have a interrupt-names property, and
bindings that define interrupt-names entries explicitly don't require a
specific order of entries in the interrupts property.

I assume from your statement, you don't agree, and think that interrupts
must always be in a specific order, even if interrupt-names exists?

If so, that'd make interrupt-names at least a bit useless and at worst
horribly misleading, since people will assume it defines the order and
that the order can be arbitrary.
