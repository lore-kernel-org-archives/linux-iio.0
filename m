Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-32.csi.cam.ac.uk ([131.111.8.132]:36233 "EHLO
	ppsw-32.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755955Ab0H3Qi4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 30 Aug 2010 12:38:56 -0400
Message-ID: <4C7BDFC1.30108@cam.ac.uk>
Date: Mon, 30 Aug 2010 17:43:45 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] staging:iio sync drivers with current ABI
References: <1283165728-2231-2-git-send-email-manuel.stahl@iis.fraunhofer.de> <1283177032-7014-2-git-send-email-manuel.stahl@iis.fraunhofer.de> <4C7BC3C2.8090104@cam.ac.uk> <4C7BC78D.7030109@iis.fraunhofer.de> <4C7BD157.8020003@cam.ac.uk> <4C7BD2B0.20508@iis.fraunhofer.de> <4C7BD734.7010309@cam.ac.uk> <4C7BDC2B.1020102@iis.fraunhofer.de>
In-Reply-To: <4C7BDC2B.1020102@iis.fraunhofer.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/30/10 17:28, Manuel Stahl wrote:
> Am 30.08.2010 18:07, schrieb Jonathan Cameron:
>> On 08/30/10 16:48, Manuel Stahl wrote:
>>> Am 30.08.2010 17:42, schrieb Jonathan Cameron:
>>>> On 08/30/10 16:00, Manuel Stahl wrote:
>>>>> Am 30.08.2010 16:44, schrieb Jonathan Cameron:
>>>>>> On 08/30/10 15:03, Manuel Stahl wrote:
>>>>>>>     static IIO_DEV_ATTR_INCLI_X(adis16300_read_13bit_signed,
>>>>>>>             ADIS16300_XINCLI_OUT);
>>>>>>>     static IIO_DEV_ATTR_INCLI_Y(adis16300_read_13bit_signed,
>>>>>>>             ADIS16300_YINCLI_OUT);
>>>>>>> -static IIO_CONST_ATTR(incli_scale, "0.044 d");
>>>>>>> +static IIO_CONST_ATTR_INCLI_SCALE("0.044 deg");
>>>>>>>
>>>>>>>     static IIO_DEV_ATTR_TEMP_RAW(adis16300_read_12bit_unsigned)=
;
>>>>>>> -static IIO_CONST_ATTR(temp_offset, "198.16 K");
>>>>>>> -static IIO_CONST_ATTR(temp_scale, "0.14 K");
>>>>>>> +static IIO_CONST_ATTR_TEMP_OFFSET("198.16 K");
>>>>>>> +static IIO_CONST_ATTR_TEMP_SCALE("0.14 K");
>>>>>> These need to be suitable for conversion to milli degrees C to m=
atch
>>>>>> hwmon.
>>>>> I think scientific devices should stick to SI units.
>>>> I'd normally agree, but hwmon beat us in defining the interface an=
d I
>>>> agree with Greg and Andrew Morton that the kernel is gaining too m=
any
>>>> incompatible interfaces.  Hence for temp we follow them.  Same oug=
ht
>>>> to be true for in[m] and current measurements.  Guess I'll do an a=
udit
>>>> of this sometime soon and make sure they are all the same.
>>>
>>> We already have a major difference here, that is we allow floating
>>> point values as output. Also we have no _input postfix, which, I
>>> agree, should be compatible if it was there. Hwmon is tuned to fixe=
d
>>> point values, but that it too limited for the range of devices we
>>> want to address with IIO. They simply don't care if they loose some
>>> bit of precision.
>> We do allow _input.  Only one user at the moment though.  illuminanc=
e0_input
>> in the tsl2563 driver.  The intent was always to extend their interf=
ace
>> but not to break comparability if we can easily avoid it.  I should =
probably
>> document the fact we allow this. It's useful for slow devices with n=
on linear
>> mappings between their raw values and the measurement. (very common =
in light
>> sensors).  Things will get more 'interesting' when we have a fast de=
vice
>> with a non linear mapping.  We'll figure that out what to do about t=
hat
>> if / when some has such a device.
>>
>> I agree that fixed point is overly limiting for our purposes. Howeve=
r, by
>> simply allowing ours to use floating point userspace can accommodate=
 either.
>> Afterall in most cases a floating point read of an integer string wi=
ll give
>> the right (or very close to it) result.
>>
>> Basically my intent (supported by others in the abi discussions) is =
to match and extend
>> hwmon wherever possible.  I'm actively advocating this approach else=
where in the
>> kernel as well.
>=20
> As I said, I have no doubt that *_input files must be compatible (mV,
> m=B0C), but the combination of _raw, _offset and _scale can result in
> SI units as you have to do floating point math anyway.
I still think matching their multiplier (e.g. milli volts etc) is going=
 to
be a better idea on the long run.  Other than being marginally annoying=
 in
that we aren't going to do this for other unit types, I don't think it =
matters
to us...  I've seen a few people agitating on lm-sensors for a higher a=
ccuracy
option there.  If they need it then I'd argue for our raw and multiplie=
r approach.
To be cynical, along with it being a good idea in my view, the reason f=
or
matching units is to avoid conflict with those we need to eventually co=
nvince
in order to move out of staging.  It's just good politics.

> While doing
> the cleanup here, I found that we have rad/s for gyros and deg for
> inclinometeres. Should be unified somehow

Agreed.  Which one shall we go for?
Having googled to confirm. Radians are accepted as closest derived SI u=
nit...
http://physics.nist.gov/cuu/Units/units.html
Got to love a m/m argument...

So I think rad/s.

Jonathan

