Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Drivers
	<Drivers@analog.com>
Date: Tue, 5 Oct 2010 12:52:34 +0100
Subject: RE: IIO_CONST_ATTR_SCAN_EL_TYPE add result shift?
Message-ID: <544AC56F16B56944AEC3BD4E3D5917712F0DB8ACC8@LIMKCMBX1.ad.analog.com>
References: <544AC56F16B56944AEC3BD4E3D5917712F0DB8ACA8@LIMKCMBX1.ad.analog.com>
 <4CAB0EF0.3010606@cam.ac.uk>
In-Reply-To: <4CAB0EF0.3010606@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2010-10-05:
> On 10/05/10 12:24, Hennerich, Michael wrote:
>> /**
>>  * IIO_CONST_ATTR_SCAN_EL_TYPE - attr to specify the data format of a
>>  scan el * @name: the scan el name (may be more general and cover a set
>>  of scan elements * @_sign: either s or u for signed or unsigned *
>>  @_bits: number of actual bits occuplied by the value * @_storagebits:
>>  number of bits _bits is padded to when read out of
>> buffer  **/ #define IIO_CONST_ATTR_SCAN_EL_TYPE(_name, _sign, _bits,
>> _storagebits) \
>>         IIO_CONST_ATTR(_name##_type, #_sign#_bits"/"#_storagebits);
>> There are cases where bits < storagebits and the result is not alligned
>> to the LSB. Lets say we have an 10-bit ADC. The output is stored in a
>> 16-bit word, with four leading zeros, then the 10-bit datum, followed
>> by 2 don't care bits.
>>
>> So it would be good to provide an additional shift value?
>> Or how shall we handle these cases?
> This was discussed in the original debate and we simply proposed
> leaving it until we had a user.  So the question is how to describe
> the shift.
>
> So taking your example, how about:
>
> u10/16>>2
>
> Where the shift is optional.
>
> Other suggestions welcome given I made that up with 2 seconds thought.

I think this is sufficient. I can only think about right shifts being usefu=
l.
This notation would consistently allow both, that's why I like it.

A bit off topic - some common defines for signed/unsigned types might also =
be useful.

#define IIO_SCAN_EL_TYPE_SIGNED         's'
#define IIO_SCAN_EL_TYPE_UNSIGNED       'u'

Greetings,
Michael

Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036 Geschaeft=
sfuehrer Thomas Wessel, William A. Martin, Margaret Seif
