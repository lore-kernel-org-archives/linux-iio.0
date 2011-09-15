Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>, Drivers <Drivers@analog.com>
Date: Thu, 15 Sep 2011 16:33:54 +0100
Subject: RE: [PATCH 1/2] iio: core: add _bias channel information
Message-ID: <544AC56F16B56944AEC3BD4E3D59177146E719B40E@LIMKCMBX1.ad.analog.com>
References: <1316099094-10931-1-git-send-email-michael.hennerich@analog.com>
 <4E721A39.6010207@cam.ac.uk>
In-Reply-To: <4E721A39.6010207@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-09-15:
> On 09/15/11 16:04, michael.hennerich@analog.com wrote:
>> From: Michael Hennerich <michael.hennerich@analog.com>
> Sorry, I must be dozing, why can't this be covered by the _offset
> equivalent?  Admittedly it will then be tied up with the _scale
> parameter changing, but surely with a bit of care this can still be done?
>
> As I read it, with this we would have
>
> X_input =3D (X_raw + X_offset)*X_scale + X_bias ?
>
> Can be transformed with care to
>
> X_input =3D (X_raw + X_offset + X_bias/X_scale)*X_scale
>
> Annoying to do, but still it would keep us in line with current abi.
>
> We could do this, but I'm unclear on whether it is justified.
>
> Please argue your case!

Hi Jonathan,

We talked about this in the 'Re: IIO: Interface for capacitance inputs (and=
 outputs)'
email thread we had some time ago. And I think you agreed on the _bias intr=
oduction.

The idea was to use _bias for the CAPDACs on the CDC devices.
But you are right, we could use _offset here too, if we eliminate _scale fo=
rm the value.

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Mar=
garet Seif
