Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>, Drivers <Drivers@analog.com>
Date: Thu, 18 Aug 2011 09:20:04 +0100
Subject: RE: [PATCH] IIO: ADC: New driver for AD7190/AD7192/AD7195 4 Channel
 SPI ADC
Message-ID: <544AC56F16B56944AEC3BD4E3D59177143006BA8B8@LIMKCMBX1.ad.analog.com>
References: <1313593455-29706-1-git-send-email-michael.hennerich@analog.com>
 <4E4BDEBC.3090606@cam.ac.uk> <4E4BE4F1.30706@cam.ac.uk>
In-Reply-To: <4E4BE4F1.30706@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-08-17:
> On 08/17/11 16:31, Jonathan Cameron wrote:
>> On 08/17/11 16:04, michael.hennerich@analog.com wrote:
>>> From: Michael Hennerich <michael.hennerich@analog.com>
>>>
>>> New driver for AD7190/AD7192/AD7195 4.8 kHz, Ultralow Noise, 24-Bit
>>> Sigma-Delta ADC with PGA
>>>
>>> These devices features a dual use data out ready DOUT/RDY output.
>>> In order to avoid contentions on the SPI bus, it's necessary to use
>>> spi bus locking. The DOUT/RDY output must also be wired to an
>>> interrupt capable GPIO.
>>>
>>> In INDIO_RING_TRIGGERED mode, this driver may block its SPI bus
>>> segment for an extended period of time.
>>>
>>> Changes since V1:
>>>
>>> Add missing documentation.
>>> Remove obsoleted include files.
>>> Fix typos and style issues.
>>> Fix buffer size.
>>> Split ad7192_show() into two functions.
>>> Avoid race condition add mutex.
>>> Abandon IIO_CHAN macro.
>>> Reorder elements in ad7192_platform_data.
>>> Remove driver bus type.
>>>
>>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
>>
>> No merge issues with what I've sent Greg so far so this one should
>> go in cleanly either before them or after. (all sorts of fun later
>> on though  - I'll pull it into iio-blue and fix up shortly.)
>
> done - please check I didn't mess this up 'too' badly.

Tested - no issues.


Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Gesch=
aeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret=
 Seif
