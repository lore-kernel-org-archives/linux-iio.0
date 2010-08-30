Return-Path: <manuel.stahl9ab33xy531iis.fraunhofer.de@bounce.antispameurope.com>
Message-ID: <4C7BDC2B.1020102@iis.fraunhofer.de>
Date: Mon, 30 Aug 2010 18:28:27 +0200
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] staging:iio sync drivers with current ABI
References: <1283165728-2231-2-git-send-email-manuel.stahl@iis.fraunhofer.de> <1283177032-7014-2-git-send-email-manuel.stahl@iis.fraunhofer.de> <4C7BC3C2.8090104@cam.ac.uk> <4C7BC78D.7030109@iis.fraunhofer.de> <4C7BD157.8020003@cam.ac.uk> <4C7BD2B0.20508@iis.fraunhofer.de> <4C7BD734.7010309@cam.ac.uk>
In-Reply-To: <4C7BD734.7010309@cam.ac.uk>
Content-Type: multipart/mixed;
 boundary="------------040109040002090203060109"
List-ID: <linux-iio@vger.kernel.org>

This is a multi-part message in MIME format.
--------------040109040002090203060109
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by iis.fhg.de id SAA14439

Am 30.08.2010 18:07, schrieb Jonathan Cameron:
> On 08/30/10 16:48, Manuel Stahl wrote:
>> Am 30.08.2010 17:42, schrieb Jonathan Cameron:
>>> On 08/30/10 16:00, Manuel Stahl wrote:
>>>> Am 30.08.2010 16:44, schrieb Jonathan Cameron:
>>>>> On 08/30/10 15:03, Manuel Stahl wrote:
>>>>>>     static IIO_DEV_ATTR_INCLI_X(adis16300_read_13bit_signed,
>>>>>>             ADIS16300_XINCLI_OUT);
>>>>>>     static IIO_DEV_ATTR_INCLI_Y(adis16300_read_13bit_signed,
>>>>>>             ADIS16300_YINCLI_OUT);
>>>>>> -static IIO_CONST_ATTR(incli_scale, "0.044 d");
>>>>>> +static IIO_CONST_ATTR_INCLI_SCALE("0.044 deg");
>>>>>>
>>>>>>     static IIO_DEV_ATTR_TEMP_RAW(adis16300_read_12bit_unsigned);
>>>>>> -static IIO_CONST_ATTR(temp_offset, "198.16 K");
>>>>>> -static IIO_CONST_ATTR(temp_scale, "0.14 K");
>>>>>> +static IIO_CONST_ATTR_TEMP_OFFSET("198.16 K");
>>>>>> +static IIO_CONST_ATTR_TEMP_SCALE("0.14 K");
>>>>> These need to be suitable for conversion to milli degrees C to matc=
h
>>>>> hwmon.
>>>> I think scientific devices should stick to SI units.
>>> I'd normally agree, but hwmon beat us in defining the interface and I
>>> agree with Greg and Andrew Morton that the kernel is gaining too many
>>> incompatible interfaces.  Hence for temp we follow them.  Same ought
>>> to be true for in[m] and current measurements.  Guess I'll do an audi=
t
>>> of this sometime soon and make sure they are all the same.
>>
>> We already have a major difference here, that is we allow floating
>> point values as output. Also we have no _input postfix, which, I
>> agree, should be compatible if it was there. Hwmon is tuned to fixed
>> point values, but that it too limited for the range of devices we
>> want to address with IIO. They simply don't care if they loose some
>> bit of precision.
> We do allow _input.  Only one user at the moment though.  illuminance0_=
input
> in the tsl2563 driver.  The intent was always to extend their interface
> but not to break comparability if we can easily avoid it.  I should pro=
bably
> document the fact we allow this. It's useful for slow devices with non =
linear
> mappings between their raw values and the measurement. (very common in =
light
> sensors).  Things will get more 'interesting' when we have a fast devic=
e
> with a non linear mapping.  We'll figure that out what to do about that
> if / when some has such a device.
>
> I agree that fixed point is overly limiting for our purposes. However, =
by
> simply allowing ours to use floating point userspace can accommodate ei=
ther.
> Afterall in most cases a floating point read of an integer string will =
give
> the right (or very close to it) result.
>
> Basically my intent (supported by others in the abi discussions) is to =
match and extend
> hwmon wherever possible.  I'm actively advocating this approach elsewhe=
re in the
> kernel as well.

As I said, I have no doubt that *_input files must be compatible (mV,=20
m=B0C), but the combination of _raw, _offset and _scale can result in SI=20
units as you have to do floating point math anyway.
While doing the cleanup here, I found that we have rad/s for gyros and=20
deg for inclinometeres. Should be unified somehow.

Cheers,
--=20
Dipl.-Inf. Manuel Stahl
Fraunhofer-Institut f=FCr Integrierte Schaltungen IIS
- Leistungsoptimierte Systeme -
Nordostpark 93                Telefon  +49 (0)911/58061-6419
90411 N=FCrnberg                Fax      +49 (0)911/58061-6398
http://www.iis.fraunhofer.de  manuel.stahl@iis.fraunhofer.de

--------------040109040002090203060109
Content-Type: text/x-vcard; charset=utf-8;
 name="manuel_stahl.vcf"
Content-Disposition: attachment;
 filename="manuel_stahl.vcf"
Content-Transfer-Encoding: quoted-printable

begin:vcard
fn:Manuel Stahl
n:Stahl;Manuel
email;internet:manuel.stahl@iis.fraunhofer.de
tel;work:+49 911 58061-6419
x-mozilla-html:FALSE
version:2.1
end:vcard


--------------040109040002090203060109--
