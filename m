Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49070 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752676AbcDCK03 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Apr 2016 06:26:29 -0400
Subject: Re: [PATCH v3 2/3] iio:magnetometer:ak8975: mounting matrix support
To: Gregor Boirie <gregor.boirie@parrot.com>,
	Rob Herring <robh+dt@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Cristina Moraru <cristina.moraru09@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Julia Lawall <Julia.Lawall@lip6.fr>
References: <cover.1458231723.git.gregor.boirie@parrot.com>
 <a1efa2b83719dc3898c39a5886b7678892e7de3b.1458231723.git.gregor.boirie@parrot.com>
 <CAL_JsqJwE5fmHUzV-xi-hgMPSbzY_7QbXaHCSAMCpp9SggWtPw@mail.gmail.com>
 <20160321222150.GA1787@geburah.sephiroth>
 <CAL_Jsq+unk=UONZD-0e_VrpkC3R3hXHNoRN-gdj6TCSSHXWZXQ@mail.gmail.com>
 <56F947B4.3090503@kernel.org> <56FA4E76.1000406@parrot.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5700EFD2.8050603@kernel.org>
Date: Sun, 3 Apr 2016 11:26:26 +0100
MIME-Version: 1.0
In-Reply-To: <56FA4E76.1000406@parrot.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/03/16 10:44, Gregor Boirie wrote:
> 
> 
> On 03/28/2016 05:03 PM, Jonathan Cameron wrote:
> 
> [snip...]
> 
>>
>> Why is the sysfs interface specific to ak8975?
>>>> AFAIK, this is just the first IIO driver implementation relying on floating
>>>> point numbers. Should a single driver be enough to justify a "generic" API,
>>>> I suppose code could be factored out in a similar way to over sampling rate
>>>> support. People could call this on a per-driver basis.
>>> Given it is an ABI, yes I think so. We don't want to end up with a
>>> bunch of similar yet different interfaces.
>>>
>> Absolutely.  Most interfaces get made up based on one implementation ;)
>> A second is always nice, but here the interface is obvious enough we don't
>> need to wait.
> Right. I'll post a separate patch then.
>>>>> Furthermore, why is it specific to magnetometer? Couldn't
>>>>> accelerometers need the same thing? There's a thread discussing a
>>>>> similar matrix on android-x86[1].
>>>> Same may apply to gyro / accelero / imu and magnetometers at least.
>>>> inv_mpu_core.c already implements such a rotation matrix exposed as 3x3 integers
>>>> array. Should we be smart enough to keep this compatible with existing userspace
>>>> apps ?
>>> You have to maintain the ABI. If both interfaces can co-exist, then
>>> you can have both and mark the old one as deprecated. In time we can
>>> remove the old one.
>> If you want to (or someone else does) it would be good to add the new abi to
>> inv_mpu_core as well and indeed mark the old one as deprecated.
>> The cost of keeping it is negligible, so we may never actually bother to
>> remove it.
> What's the better way to mark this as deprecated ? dev_warn() ? __deprecated ?
> Anything else ?
Probably just documentation at this stage - anything else will be a pita for
anyone using that driver. As long as it is clear in any docs + the code, which
is the preferred option that's fine.  I doubt we'll ever bother removing the
old way.

Jonathan
>>>>>> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
>>>>>> index 34a3206..f936f86 100644
>>>>>> --- a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
>>>>>> +++ b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
>>>>>> @@ -9,6 +9,7 @@ Optional properties:
>>>>>>
>>>>>>     - gpios : should be device tree identifier of the magnetometer DRDY pin
>>>>>>     - vdd-supply: an optional regulator that needs to be on to provide VDD
>>>>>> +  - matrix: an optional 3x3 mounting rotation matrix
>>>>> Perhaps "rotation-matrx" would be a better name in case there's ever
>>>>> any other matrix needed.
>>>> What about "mounting-matrix" ?
>>> Sure.
>> Works for me as well.
>>> Rob
>>> -- 
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

