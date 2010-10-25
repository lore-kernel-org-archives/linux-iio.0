Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Guenter Roeck <guenter.roeck@ericsson.com>, Jonathan Cameron
	<jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "Zhang, Sonic"
	<Sonic.Zhang@analog.com>, Mike Frysinger <vapier@gentoo.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Date: Mon, 25 Oct 2010 12:47:44 +0100
Subject: RE: [Device-drivers-devel] [PATCH 12/14] staging: iio: adc: new
 driver for ADT7408 temperature sensors
Message-ID: <544AC56F16B56944AEC3BD4E3D59177130945B1BB3@LIMKCMBX1.ad.analog.com>
References: <1287865757-1031-1-git-send-email-vapier@gentoo.org>
	<1287865757-1031-12-git-send-email-vapier@gentoo.org>
	<4CC4B8F8.7010005@cam.ac.uk> <20101025004650.GA15907@ericsson.com>
	<4CC55CD2.1020501@cam.ac.uk> <20101025111943.GA16863@ericsson.com>
In-Reply-To: <20101025111943.GA16863@ericsson.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Guenter Roeck wrote on 2010-10-25:
> On Mon, Oct 25, 2010 at 06:32:50AM -0400, Jonathan Cameron wrote:
>>>
>>> I'd love to see some reasoning why hardware monitoring drivers are
>>> moved to or directly written in iio.
>>>
>>> Also, I seem to be missing your point re "high performance devices".
>>> Are you saying that hwmon is not suitable for high performance
>>> hardware monitoring devices ?
>> Yes.  Point me at someone doing 1MSps or higher via pretty printing
>> through a sysfs interface.  Admittedly none of the controversial
>> drivers in this
>
> Ok.
>
>> set do that currently either, but that's why I have asked Analog to
>> confirm what they are using them for.

I don't remember why these drivers targeted IIO instead of HWMON, since
I didn't write those in question.

For some (without looking at a particular one) I would say the ringbuffer a=
nd
trigger capabilities in IIO were required.

>> The point is that these devices
>> are only hardware monitoring to you because that is what you think they
>> are for. Some of them (not the one I forwarded initially) are general
>> purpose ADC's that have a temp sensor because the temperature can
>> effect the calibration of the outputs.
>>
> I did not refer to the chips with generic ADC sensors.
> The chips I referred to are AD7414/15, ADT75, ADT7310, ADT7408, and
> ADT7410, though I may have missed some.

For the ones listed above -
>>From top of my head, and a quick glance at the driver source,
I also don't see a reason why these need to exist twice.
I asked the author to comment on, why these went into iio.
I think it's ok to drop the ones that already have suitable driver support =
in hwmon,
while adding support for the ones that are currently missing in hwmon.

>> We went through this in a lot of depth back when IIO first came about.
>> There is a boundary. We just need to pin down where it is.
>
> For the ambient temperature sensors on the other chips - did you
> consider adding hwmon device entries for those ? There may of course
> be reasons against doing that, but it may be an option. There are
> other drivers outside the hwmon directory which call
> hwmon_device_register(), so it is not a new concept.
>
> Thanks,
> Guenter
>
> _______________________________________________ Device-drivers-devel
> mailing list Device-drivers-devel@blackfin.uclinux.org
> https://blackfin.uclinux.org/mailman/listinfo/device-drivers-devel

Greetings,
Michael

Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036 Geschaeft=
sfuehrer Thomas Wessel, William A. Martin, Margaret Seif
