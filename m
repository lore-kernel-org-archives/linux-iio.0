Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"uclinux-dist-devel@blackfin.uclinux.org"
	<uclinux-dist-devel@blackfin.uclinux.org>, "Getz, Robin"
	<Robin.Getz@analog.com>
Date: Tue, 4 May 2010 11:53:24 +0100
Subject: RE: IIO:ADC Scan Modes
Message-ID: <544AC56F16B56944AEC3BD4E3D5917712E568A0306@LIMKCMBX1.ad.analog.com>
References: <544AC56F16B56944AEC3BD4E3D5917712E568A02D0@LIMKCMBX1.ad.analog.com>
 <4BDFF8EE.2000201@cam.ac.uk>
In-Reply-To: <4BDFF8EE.2000201@cam.ac.uk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,
Jonathan Cameron wrote on 2010-05-04:
> Hi Michael
>> The way available scan modes are handled in the max1363 driver doesn't
>> nicely equate to the AD7997, AD7997 or AD7991 series of ADCs. These
>> devices feature up to 8 Channels while each channel can be
>> independently included into the scan sequence. (this would require up
>> to 256 'named' modes)
> I agree entirely.  The approach originally used in max1363 has gone in
> the latest patch set posted the other day (indeed the set you reference
> below)
>>
>> A while ago we talked about this - and you said you would abandon
>> the 'named' scan mode selection - and come up with something like a
>> scan_elements directory with channel control files (enable/disable),
>> and some sort of mechanism that rejects invalid combinations.
>>
>> I noticed some additions ...
>> [PATCH 04/19] staging:iio: Support functions for scan mask matching
> Yup.  That's what max1363 now does. In the same series, see [PATCH
> 08/19] staging:iio:max1363 move to new abi.
>

Sorry - I missed that one.

> (as the new abi didn't allow the 'named' scan mode approach!)
>
> Other than some renaming, the lis3l20dq for example has done the
> scan_elements approach from the start (as have some of the others.)
>
> Jonathan
>
>
>>
>> But the sysfs interface is not in place.
>> Is this something you're still planning to put into place?
>>
>> Best regards,
>> Michael
>>
>>
>> ------------------------------------------------------------------
>> ********* Analog Devices GmbH              Open Platform Solutions
>> **  *****
>> **     ** Wilhelm-Wagenfeld-Strasse 6
>> **  ***** D-80807 Munich
>> ********* Germany
>> Registergericht M=FCnchen HRB 40368,  Gesch=E4ftsf=FChrer: Thomas Wessel=
,
>> William A. Martin, Margaret K. Seif
>>
>>

Greetings,
Michael

Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036 Geschaeft=
sfuehrer Thomas Wessel, William A. Martin, Margaret Seif
