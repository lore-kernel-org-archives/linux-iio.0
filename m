Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:58248 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916Ab0JYLhR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Oct 2010 07:37:17 -0400
Message-ID: <4CC56D50.3000804@cam.ac.uk>
Date: Mon, 25 Oct 2010 12:43:12 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Guenter Roeck <guenter.roeck@ericsson.com>
CC: Mike Frysinger <vapier@gentoo.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>,
	Sonic Zhang <sonic.zhang@analog.com>
Subject: Re: [PATCH 12/14] staging: iio: adc: new driver for ADT7408 temperature
 sensors
References: <1287865757-1031-1-git-send-email-vapier@gentoo.org> <1287865757-1031-12-git-send-email-vapier@gentoo.org> <4CC4B8F8.7010005@cam.ac.uk> <20101025004650.GA15907@ericsson.com> <4CC55CD2.1020501@cam.ac.uk> <20101025111943.GA16863@ericsson.com>
In-Reply-To: <20101025111943.GA16863@ericsson.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/25/10 12:19, Guenter Roeck wrote:
> On Mon, Oct 25, 2010 at 06:32:50AM -0400, Jonathan Cameron wrote:
>>>
>>> I'd love to see some reasoning why hardware monitoring drivers are
>>> moved to or directly written in iio.
>>>
>>> Also, I seem to be missing your point re "high performance devices".
>>> Are you saying that hwmon is not suitable for high performance
>>> hardware monitoring devices ?
>> Yes.  Point me at someone doing 1MSps or higher via pretty printing through
>> a sysfs interface.  Admittedly none of the controversial drivers in this
> 
> Ok.
> 
>> set do that currently either, but that's why I have asked Analog to confirm
>> what they are using them for.  The point is that these devices are only
>> hardware monitoring to you because that is what you think they are for.
>> Some of them (not the one I forwarded initially) are general purpose ADC's
>> that have a temp sensor because the temperature can effect the calibration
>> of the outputs.
>>
> I did not refer to the chips with generic ADC sensors.
> The chips I referred to are AD7414/15, ADT75, ADT7310, ADT7408, and ADT7410,
> though I may have missed some.
You clearly got further through the set than I have so far! (I'd only come across
the first 2 of those)  Agreed, all of these appear to be temperature only and at
a quick look they are typically slow and low resolution so that set definitely
want to be in hwmon.

For those parts with actual hwmon drivers, ad7414/15 and adt7408 (based on a quick
grep unless Guenter has others queued). Lets drop them for now from the merge.

For the others lets put a todo in place to convert them to hwmon.  Nothing wrong
with putting them in staging (under IIO or otherwise) in the meantime as far
as I am concerned.

> 
>> We went through this in a lot of depth back when IIO first came about.
>> There is a boundary. We just need to pin down where it is.
> 
> For the ambient temperature sensors on the other chips - did you consider
> adding hwmon device entries for those ? There may of course be reasons against
> doing that, but it may be an option. There are other drivers outside the hwmon 
> directory which call hwmon_device_register(), so it is not a new concept.
It depends on whether they are generally useful for temperature monitoring.
On the whole they are giving one the value on a particular bit of silicon
in the chip (not the ambient temperature near by). They aren't reading it for
monitoring purposes, but because it is needed to calibrate the other sensors in
the package.  We even have devices with multiple temperature sensors, one on
each MEMs device. Also they often get read into a buffer with all the rest
of the channels.

Lets leave the decision on this up to individual driver writers.  If they are using
the device to do hwmon stuff as well as whatever else it is for then we encourage them
to register it with hwmon as you suggest.

Thanks for you quick response on this.

Jonathan

