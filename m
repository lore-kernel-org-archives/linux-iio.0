Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58574 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758549AbcCVMip (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 22 Mar 2016 08:38:45 -0400
MIME-Version: 1.0
In-Reply-To: <20160321222150.GA1787@geburah.sephiroth>
References: <cover.1458231723.git.gregor.boirie@parrot.com>
 <a1efa2b83719dc3898c39a5886b7678892e7de3b.1458231723.git.gregor.boirie@parrot.com>
 <CAL_JsqJwE5fmHUzV-xi-hgMPSbzY_7QbXaHCSAMCpp9SggWtPw@mail.gmail.com> <20160321222150.GA1787@geburah.sephiroth>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 22 Mar 2016 07:38:21 -0500
Message-ID: <CAL_Jsq+unk=UONZD-0e_VrpkC3R3hXHNoRN-gdj6TCSSHXWZXQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] iio:magnetometer:ak8975: mounting matrix support
To: Gregor Boirie <gregor.boirie@parrot.com>,
	Rob Herring <robh+dt@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Cristina Moraru <cristina.moraru09@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Julia Lawall <Julia.Lawall@lip6.fr>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Mar 21, 2016 at 5:21 PM, Gregor Boirie <gregor.boirie@parrot.com> wrote:
> Hi Rob,
>
> On Mon, Mar 21, 2016 at 09:58:46AM -0500, Rob Herring wrote:
>> On Thu, Mar 17, 2016 at 11:43 AM, Gregor Boirie
>> <gregor.boirie@parrot.com> wrote:
>> > Expose a rotation matrix to indicate userspace the chip placement with
>> > respect to the overall hardware system. This is needed to adjust
>> > coordinates sampled from a magnetometer chip when its position deviates
>> > from the main hardware system.
>> >
>> > Final coordinates computation is delegated to userspace since:
>> > * computation may involve floating point arithmetics ;
>> > * it allows an application to combine adjustments with arbitrary
>> >   transformations.
>> >
>> > This 3 dimentional space rotation matrix is expressed as 3x3 array of
>> > strings to support floating point numbers. It may be retrieved from a
>> > "in_magn_matrix" sysfs attribute file. It is declared into ak8975 DTS
>> > entry as a "matrix" property.
>>
>> Why is the sysfs interface specific to ak8975?
> AFAIK, this is just the first IIO driver implementation relying on floating
> point numbers. Should a single driver be enough to justify a "generic" API,
> I suppose code could be factored out in a similar way to over sampling rate
> support. People could call this on a per-driver basis.

Given it is an ABI, yes I think so. We don't want to end up with a
bunch of similar yet different interfaces.

>> Furthermore, why is it specific to magnetometer? Couldn't
>> accelerometers need the same thing? There's a thread discussing a
>> similar matrix on android-x86[1].
> Same may apply to gyro / accelero / imu and magnetometers at least.
> inv_mpu_core.c already implements such a rotation matrix exposed as 3x3 integers
> array. Should we be smart enough to keep this compatible with existing userspace
> apps ?

You have to maintain the ABI. If both interfaces can co-exist, then
you can have both and mark the old one as deprecated. In time we can
remove the old one.

>> > diff --git a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
>> > index 34a3206..f936f86 100644
>> > --- a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
>> > +++ b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
>> > @@ -9,6 +9,7 @@ Optional properties:
>> >
>> >    - gpios : should be device tree identifier of the magnetometer DRDY pin
>> >    - vdd-supply: an optional regulator that needs to be on to provide VDD
>> > +  - matrix: an optional 3x3 mounting rotation matrix
>>
>> Perhaps "rotation-matrx" would be a better name in case there's ever
>> any other matrix needed.
> What about "mounting-matrix" ?

Sure.

Rob
