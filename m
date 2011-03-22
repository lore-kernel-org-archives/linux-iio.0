Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:41229 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753967Ab1CVKlZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 22 Mar 2011 06:41:25 -0400
Message-ID: <4D887D1E.90503@cam.ac.uk>
Date: Tue, 22 Mar 2011 10:42:38 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "Cai, Cliff" <Cliff.Cai@analog.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Drivers <Drivers@analog.com>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>,
	Cliff Cai <cliff@analog.com>
Subject: Re: [PATCH RESEND v2]IIO driver for Analog Devices Digital Output
 Gyroscope ADXRS450
References: <1300526846-27183-1-git-send-email-cliff.cai@analog.com> <4D878D8B.6070902@cam.ac.uk> <DB904C5425BA6F4E8424B3B51A1414D167E03359CD@NWD2CMBX1.ad.analog.com> <544AC56F16B56944AEC3BD4E3D5917713754315B05@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917713754315B05@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/22/11 08:16, Hennerich, Michael wrote:
> Cai, Cliff wrote on 2011-03-22:
>>
>>
>>> -----Original Message-----
>>> From: Jonathan Cameron [mailto:jic23@cam.ac.uk]
>>> Sent: 2011=E5=B9=B43=E6=9C=8822=E6=97=A5 1:40
>>> To: Cai, Cliff
>>> Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; Driver=
s;
>>> device-drivers-devel@blackfin.uclinux.org; Cliff Cai
>>> Subject: Re: [PATCH RESEND v2]IIO driver for Analog Devices Digital
>>> Output Gyroscope ADXRS450
>>>
>>> On 03/19/11 09:27, cliff.cai@analog.com wrote:
>>>> From: Cliff Cai <cliff.cai@analog.com>
>>>>
>>>> Change v2:v1:
>>>>
>>>> Make modification according to Michael Hennerich's comments,
>>>> correct the spi transfer way,use existing sysfs interfaces.
>>> Hi Cliff,
>>>
>>> As you are proposing a couple of new interfaces we need to have
>>> documentation for them. They are quad and dynamic_null_correction. =
We
>>> need to first establish whether they are of general utility and hen=
ce
>>> should be in the main abi doc. The quadrature one isn't something I=
've
>>> seen before. Is it common in gyros?
>>
>> I'm not sure about this.
>> Michael,do you have any ideas?
>=20
> The ADXRS450 is a quite new part and features a new sensor design -
> So I don't think the quadrature error is to date very common.
> It might become in future...
>=20
> From the datasheet:
>=20
> "The quad sensor design rejects linear and angular
> acceleration, including external g-forces and vibration. This is
> achieved by mechanically coupling the four sensing structures
> such that external g-forces appear as common-mode signals
> that can be removed by the fully differential architecture implemente=
d in the ADXRS450."
>=20
> "The quad memory registers contain a value corresponding to the amoun=
t of
> quadrature error present in the device at a given time.
> Quadrature can be likened to a measurement of the error of the motion=
 of the
> resonator structure, and can be caused by stresses and aging effects.
> The quadrature data is filtered to 80 Hz and can be read frequently t=
o
> detect sudden shifts in the level of quadrature.
> The data is presented as a 16-bit, twos complement number."
>=20
Cool. So what is a good general name for this?  I guess from this descr=
iption
if it were in a multi axis device you would have this measure for each =
axis?

So perhaps gyro_z_quadrature_correction_raw?  This thing also looks
rather similar to a dynamically changing calibbias. Perhaps we need ano=
ther
term for a general dynamic linear (I think this is linear) correction i=
nside
a device?

Perhaps go with a gyro specific term for now and wait to see if we get
many more parts with this feature...
>>
>>> Dynamic null correction looks like it should be gyro_z_calibbias to
>>> me but I could be wrong.  The doc says "
>>> The user can make small adjustments to the rateout of the device by
>>> asserting these bits. This 10-bit register allows the user to adjus=
t
>>> the static rateout of the device by up to =C2=B16.4=C2=B0/sec.
>>> "
>>>
>>> which makes me think it is an internally applied offset on the outp=
ut
>>> signal and hence calibbias in our abi.
>>
>> Thanks
>>
>>> Other than that, various minor nitpicks inline.
>>>
>>> Jonathan
>=20
> Greetings,
> Michael
>=20
> --
> Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
> Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;=
 Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin=
, Margaret Seif
>=20

