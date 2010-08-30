Return-Path: <manuel.stahl9ab33xy531iis.fraunhofer.de@bounce.antispameurope.com>
Message-ID: <4C7BC78D.7030109@iis.fraunhofer.de>
Date: Mon, 30 Aug 2010 17:00:29 +0200
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] staging:iio sync drivers with current ABI
References: <1283165728-2231-2-git-send-email-manuel.stahl@iis.fraunhofer.de> <1283177032-7014-2-git-send-email-manuel.stahl@iis.fraunhofer.de> <4C7BC3C2.8090104@cam.ac.uk>
In-Reply-To: <4C7BC3C2.8090104@cam.ac.uk>
Content-Type: multipart/mixed;
 boundary="------------090201060606060600020502"
List-ID: <linux-iio@vger.kernel.org>

This is a multi-part message in MIME format.
--------------090201060606060600020502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by iis.fhg.de id RAA06496

Am 30.08.2010 16:44, schrieb Jonathan Cameron:
> On 08/30/10 15:03, Manuel Stahl wrote:
>
> Youch, I hadn't registered just how far away this lot were from the abi.
> Thanks for doing this.
>
> I sometimes wonder if it would be better to loose all the macros and mo=
ve
> over to abi doc based enforcement (like hwmon does).  What do people th=
ink?
> As can be seen in this patch, it makes very little difference in the le=
ngth of
> code.  Disadvantage is that it does add a review burden.

I think we should keep the macros. Then we can simply search for=20
IIO_DEVICE_ATTR and IIO_CONST_ATTR in the drivers, as these are=20
suspicious for declaring proprietary attributes. When the well known=20
macros change they produce compile errors. Also good for finding broken=20
drivers.

> Let's merge this fix anyway and consider whether to loose some of the m=
acros
> at a later date.
>
> Quite a bit of this fixes naming of parameter that weren't correct unde=
r the
> previous abi.  Clearly we (meaning mainly me :) ) need to review driver=
s
> much more closely for abi breakage.

As I said before, some macros are suspicious and we can search for them.
i.e. IIO_DEV_ATTR_ACCEL_X_OFFSET and IIO_DEV_ATTR_ACCEL_X_SCALE should=20
be rarely used as they're constant for most devices.

> An excellent patch.  Thank you very much for doing this.
>
> One minor white space introduction that I'd like you to clean up before
> sending on.
>
>
>> Signed-off-by: Manuel Stahl<manuel.stahl@iis.fraunhofer.de>
> Signed-off-by: Jonathan Cameron<jic23@cam.ac.uk>
>


>>   static IIO_DEV_ATTR_ACCEL_X(adis16300_read_14bit_signed,
>>   		ADIS16300_XACCL_OUT);
>> @@ -532,17 +537,17 @@ static IIO_DEV_ATTR_ACCEL_Y(adis16300_read_14bit=
_signed,
>>   		ADIS16300_YACCL_OUT);
>>   static IIO_DEV_ATTR_ACCEL_Z(adis16300_read_14bit_signed,
>>   		ADIS16300_ZACCL_OUT);
>> -static IIO_CONST_ATTR(accel_scale, "0.0006 g");
>> +static IIO_CONST_ATTR_ACCEL_SCALE("0.0006 g");
> Abi says that units should be m/s^2.  Also we shouldn't have units
> in the attributes.   I've been meaning to clear them out.  They
> just make userspace code more complex for no gain.

Ups, you're right with m/s^2, nevertheless is worth an extra patch.=20
Sure, the units don't need to be there, but parsing is the same with or=20
without (scanf just ignores the chars).

>>   static IIO_DEV_ATTR_INCLI_X(adis16300_read_13bit_signed,
>>   		ADIS16300_XINCLI_OUT);
>>   static IIO_DEV_ATTR_INCLI_Y(adis16300_read_13bit_signed,
>>   		ADIS16300_YINCLI_OUT);
>> -static IIO_CONST_ATTR(incli_scale, "0.044 d");
>> +static IIO_CONST_ATTR_INCLI_SCALE("0.044 deg");
>>
>>   static IIO_DEV_ATTR_TEMP_RAW(adis16300_read_12bit_unsigned);
>> -static IIO_CONST_ATTR(temp_offset, "198.16 K");
>> -static IIO_CONST_ATTR(temp_scale, "0.14 K");
>> +static IIO_CONST_ATTR_TEMP_OFFSET("198.16 K");
>> +static IIO_CONST_ATTR_TEMP_SCALE("0.14 K");
> These need to be suitable for conversion to milli degrees C to match
> hwmon.
I think scientific devices should stick to SI units.

Regards,
--=20
Dipl.-Inf. Manuel Stahl
Fraunhofer-Institut f=FCr Integrierte Schaltungen IIS
- Leistungsoptimierte Systeme -
Nordostpark 93                Telefon  +49 (0)911/58061-6419
90411 N=FCrnberg                Fax      +49 (0)911/58061-6398
http://www.iis.fraunhofer.de  manuel.stahl@iis.fraunhofer.de

--------------090201060606060600020502
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


--------------090201060606060600020502--
