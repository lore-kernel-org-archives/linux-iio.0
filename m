Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Guenter Roeck <guenter.roeck@ericsson.com>, Jonathan Cameron
	<jic23@cam.ac.uk>
CC: Mike Frysinger <vapier@gentoo.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>, "Zhang, Sonic"
	<Sonic.Zhang@analog.com>
Date: Mon, 25 Oct 2010 17:18:25 +0100
Subject: RE: [PATCH 12/14] staging: iio: adc: new driver for ADT7408
 temperature sensors
Message-ID: <544AC56F16B56944AEC3BD4E3D59177130945B1C56@LIMKCMBX1.ad.analog.com>
References: <1287865757-1031-1-git-send-email-vapier@gentoo.org>
 <1287865757-1031-12-git-send-email-vapier@gentoo.org>
 <4CC4B8F8.7010005@cam.ac.uk> <20101025004650.GA15907@ericsson.com>
 <4CC55CD2.1020501@cam.ac.uk> <20101025111943.GA16863@ericsson.com>
 <4CC56D50.3000804@cam.ac.uk> <20101025141235.GA18016@ericsson.com>
In-Reply-To: <20101025141235.GA18016@ericsson.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Guenter Roeck wrote on 2010-10-25:
> On Mon, Oct 25, 2010 at 07:43:12AM -0400, Jonathan Cameron wrote:
> [ ... ]
>
>>> I did not refer to the chips with generic ADC sensors.
>>> The chips I referred to are AD7414/15, ADT75, ADT7310, ADT7408,
>>> and ADT7410, though I may have missed some.
>> You clearly got further through the set than I have so far! (I'd
>> only come across the first 2 of those)  Agreed, all of these appear
>> to be temperature only and at a quick look they are typically slow
>> and low resolution so that set definitely want to be in hwmon.
>>
>> For those parts with actual hwmon drivers, ad7414/15 and adt7408 (based
>> on a quick grep unless Guenter has others queued). Lets drop them for
>> now from the merge.
>>
>
> Nothing queued here. Not that I would mind doing the driver
> conversions for ADT7310 and ADT7410 if needed, but I would need HW
> (eval boards) for testing.

I'm sure that I can get you the EVAL-ADT7X10EBZ board.
Please send me your shipping address off list.

Greetings,
Michael

Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036 Geschaeft=
sfuehrer Thomas Wessel, William A. Martin, Margaret Seif
