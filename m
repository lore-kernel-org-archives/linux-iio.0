Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron
	<jic23@cam.ac.uk>
CC: Drivers <Drivers@analog.com>
Date: Tue, 5 Oct 2010 12:24:46 +0100
Subject: IIO_CONST_ATTR_SCAN_EL_TYPE add result shift?
Message-ID: <544AC56F16B56944AEC3BD4E3D5917712F0DB8ACA8@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

/**
 * IIO_CONST_ATTR_SCAN_EL_TYPE - attr to specify the data format of a scan =
el
 * @name: the scan el name (may be more general and cover a set of scan ele=
ments
 * @_sign: either s or u for signed or unsigned
 * @_bits: number of actual bits occuplied by the value
 * @_storagebits: number of bits _bits is padded to when read out of buffer
 **/
#define IIO_CONST_ATTR_SCAN_EL_TYPE(_name, _sign, _bits, _storagebits) \
        IIO_CONST_ATTR(_name##_type, #_sign#_bits"/"#_storagebits);

There are cases where bits < storagebits and the result is not alligned to =
the LSB.
Lets say we have an 10-bit ADC.
The output is stored in a 16-bit word, with four leading zeros, then the 10=
-bit datum, followed by 2 don't care bits.

So it would be good to provide an additional shift value?
Or how shall we handle these cases?

Greetings,
Michael

Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036
Geschaeftsfuehrer Thomas Wessel, William A. Martin, Margaret Seif
