Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43219 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305AbcCLJoy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Mar 2016 04:44:54 -0500
Subject: Re: [PATCH v2 4/5] iio:magnetometer:ak8975: mounting matrix support
To: Rob Herring <robh+dt@kernel.org>
References: <cover.1457001111.git.gregor.boirie@parrot.com>
 <022da3dfc0853c6f9820b24c2d9eaaf0c5ccf294.1457001111.git.gregor.boirie@parrot.com>
 <56DAFCEB.6080905@kernel.org> <56E0014D.1040209@parrot.com>
 <56E08B91.6070603@kernel.org>
 <CAL_JsqJZfr5Cx6vkSGePESjf-gmz54jATjqb=Xgc6HiUtL4_Tw@mail.gmail.com>
Cc: Gregor Boirie <gregor.boirie@parrot.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Cristina Moraru <cristina.moraru09@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56E3E512.4030205@kernel.org>
Date: Sat, 12 Mar 2016 09:44:50 +0000
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJZfr5Cx6vkSGePESjf-gmz54jATjqb=Xgc6HiUtL4_Tw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/03/16 02:15, Rob Herring wrote:
> On Wed, Mar 9, 2016 at 2:46 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 09/03/16 10:56, Gregor Boirie wrote:
>>>
>>> On 03/05/2016 04:36 PM, Jonathan Cameron wrote:
>>>> On 03/03/16 10:44, Gregor Boirie wrote:
>>>>> Expose a rotation matrix to indicate userspace the chip placement with
>>>>> respect to the overall hardware system. This is needed to adjust
>>>>> coordinates sampled from a magnetometer chip when its position deviates
>>>>> from the main hardware system.
>>>>>
>>>>> Final coordinates computation is delegated to userspace since:
>>>>> * computation may involve floating point arithmetics ;
>>>>> * it allows an application to combine adjustments with arbitrary
>>>>>    transformations.
>>>>>
>>>>> This 3 dimentional space rotation matrix is expressed as 3x3 array of
>>>>> strings to support floating point numbers. It may be retrieved from a
>>>>> "in_magn_matrix" sysfs attribute file. It is declared into ak8975 DTS
>>>>> entry as a "matrix" property.
>>>>>
>>>>> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
>>>> This one definitely wants to go to the device tree list. I'd also like a few
>>>> IIO related comments as well. I was sure we'd been through this before and
>>>> ended up with some sort of solution, but now I can't find it... Oh well.
>>> I took inv_mpu_core as an example. However matrices are exposed as integers
>>> and we really need floating point support.
>>> A search on the device-tree mailing list archive does not show up with a
>>> solution to encode floating point numbers into DTS either.
>> Certainly non obvious how to do this.
>>
>> For anyone device tree related who picks this up (I've added a CC)
>> we are basically talking about passing a rotation matrix from the device tree
>> straight through to userspace to describe the relative orientation of
>> some sensor.  An array of strings clearly works, but is this the best
>> way to do it?
> 
> That's probably okay. I'd format the dts and sysfs to be arranged in a
> 3x3 matrix rather than a linear list though, but that is just style.
> 
> However, there's nothing really preventing us from having floats in
> DT. Data is not typed, so it would be a matter of adding the dtc
> parsing support. The other aspect would be the limited use of float
> types in the kernel (though that should not influence binding design).
> Are there cases of the kernel ABI using floats?
Not many cases of true floats, but certainly in IIO we use a lot of
pseudo floats in which an enum is combined with two integers.
Enum effectively specifies the 'fixed point' location and the
pair of integers typically the integer part and the decimal part
(as we often end up with for example scales that are close to 1)
It's a bit hideous in some ways, but seeing as we are doing fixed
point maths with it in the kernel it actually works out reasonably
cleanly internally.

Right now I don't think any of those are passed in from device tree
but it's certainly possible in the future.

Jonathan
> 
> Rob
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

