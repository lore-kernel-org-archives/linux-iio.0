Return-Path: <Michael.Hennerich@analog.com>
Cc: "Zhang, Sonic" <Sonic.Zhang@analog.com>, Barry Song
	<21cnbao@gmail.com>, "Song, Barry" <Barry.Song@analog.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Manuel Stahl
	<manuel.stahl@iis.fraunhofer.de>, "Frysinger, Michael"
	<Michael.Frysinger@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Date: Mon, 17 May 2010 10:36:33 +0100
Subject: RE: IIO driver merge plans (for next merge window)
Message-ID: <544AC56F16B56944AEC3BD4E3D5917712E568FC1C8@LIMKCMBX1.ad.analog.com>
References: <4BD5F4A8.7020309@cam.ac.uk>
 <0F1B54C89D5F954D8535DB252AF412FA048553F4@chinexm1.ad.analog.com>
 	<4BD6ADFA.4050500@cam.ac.uk>
 <i2g3c17e3571005050037qbcc3ebc8h47aaa087913bf15d@mail.gmail.com>
 <4BE18CAD.5090506@cam.ac.uk>
 <0F1B54C89D5F954D8535DB252AF412FA0620F10A@chinexm1.ad.analog.com>
 <544AC56F16B56944AEC3BD4E3D5917712E568FC168@LIMKCMBX1.ad.analog.com>
 <0F1B54C89D5F954D8535DB252AF412FA0620F2DC@chinexm1.ad.analog.com>
 <544AC56F16B56944AEC3BD4E3D5917712E568FC17D@LIMKCMBX1.ad.analog.com>
 <4BF10D1B.8000808@cam.ac.uk>
In-Reply-To: <4BF10D1B.8000808@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2010-05-17:
> On 05/17/10 09:08, Hennerich, Michael wrote:
>> Zhang, Sonic wrote on 2010-05-17:
>>>
>>>
>>>> -----Original Message----- From: Hennerich, Michael Sent: Monday, May
>>>> 17, 2010 3:48 PM To: Zhang, Sonic; Jonathan Cameron; Barry Song Cc:
>>>> Song, Barry; linux-iio@vger.kernel.org; Manuel Stahl; Frysinger,
>>>> Michael Subject: RE: IIO driver merge plans (for next merge window)
>>>>
>>>> Zhang, Sonic wrote on 2010-05-17:
>>>>> Hi Jonathan,
>>>>>
>>>>> Yes, we can send the driver patches to linux-iio after it passes
>>>>> debugging in local SVN. But, since the kernel version and iio
>>>>> tree base in our SVN are different from yours, we have to port
>>>>> the patches before posting. And we don't ensure the new patches
>>>>> still run without problem in your tree, until your tree is merged
>>>>> into mainline and updated to our local SVN.
>>>>
>>>> Sonic,
>>>>
>>>> How about we merge Greg's staging iio folder into our svn right now?
>>>> This way we can do the API fixes to our drivers and send them also to
>>>> Greg for inclusion without greater delays.
>>>>
>>>
>>> It is OK to merge the IIO patches if they don't care about kernel
>>> version difference between Greg's tree and our SVN tree. Our's is
>>> 2.6.33.4, while Greg's is 2.6.34-rc6
>>
>> staging-iio is pretty much self contained.
>> As far I can tell it doesn't depend on anything that has been
>> changed between 2.6.33 and 2.6.34.
> There might be a few header issues outside IIO. These are just
> additional required headers (due to some general clean up) that
> shouldn't effect the merge from mainline to your tree, but may cause
> issues the other way around by requiring a few more includes in some
> of your drivers. A simple build test should throw up any of these.

I think you are referring to include linux/slab.h?

>
> I don't know what Greg's policy is on taking patches at this stage in
> the merge cycle (merge window just opened).  I'd imagine anything he
> doesn't get in the next couple of days will have to work for the next
> window (in about three months).  They'll sit in linux next until then.
> I don't think operates the normal kernel rule of allowing new self
> contained drivers to merge later in the cycle.  This would become hard
> to manage for staging where the majority of code fits in that category.
>
> Jonathan

Greetings,
Michael

Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036 Geschaeft=
sfuehrer Thomas Wessel, William A. Martin, Margaret Seif
