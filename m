Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:46451 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130Ab0JYK04 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Oct 2010 06:26:56 -0400
Message-ID: <4CC55CD2.1020501@cam.ac.uk>
Date: Mon, 25 Oct 2010 11:32:50 +0100
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
References: <1287865757-1031-1-git-send-email-vapier@gentoo.org> <1287865757-1031-12-git-send-email-vapier@gentoo.org> <4CC4B8F8.7010005@cam.ac.uk> <20101025004650.GA15907@ericsson.com>
In-Reply-To: <20101025004650.GA15907@ericsson.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/25/10 01:46, Guenter Roeck wrote:
> On Sun, Oct 24, 2010 at 06:53:44PM -0400, Jonathan Cameron wrote:
>> On 10/23/10 21:29, Mike Frysinger wrote:
>>> From: Sonic Zhang <sonic.zhang@analog.com>
>> Here we enter new territory. This device is already
>> supported in hwmon.  Do we have a usecase that is not
>> covered by that driver?
>>
>> If this is only for hardware monitoring by Guenter (cc'd) can
>> perhaps advise on how to support everything you have here...
>>
>> I'm personally not against having drivers in IIO for devices
>> supported elsewhere, but the requirements for justification
>> are rather higher. Also care is needed to ensure no issues with
>> platform data etc.
>>
>> Guenter, for your information we have a set of temp drivers coming,
>> as a small element of a larger set, from Analog's tree. Those
>> I've reviewed so far have wanted to use IIO's event infrastructure
>> (which is much more general than hwmon's handling of alarms)
>> or have been suitably high performance devices with general
>> adc's to satisfy me that they clearly have uses beyond
>> hardware monitoring.
>>
> Browsing through the adt patch list, there are several other drivers
> which either already exist in hwmon, or should be there.
> 
> I'd love to see some reasoning why hardware monitoring drivers are
> moved to or directly written in iio.
> 
> Also, I seem to be missing your point re "high performance devices".
> Are you saying that hwmon is not suitable for high performance
> hardware monitoring devices ?
Yes.  Point me at someone doing 1MSps or higher via pretty printing through
a sysfs interface.  Admittedly none of the controversial drivers in this
set do that currently either, but that's why I have asked Analog to confirm
what they are using them for.  The point is that these devices are only
hardware monitoring to you because that is what you think they are for.
Some of them (not the one I forwarded initially) are general purpose ADC's
that have a temp sensor because the temperature can effect the calibration
of the outputs.

We went through this in a lot of depth back when IIO first came about.
There is a boundary. We just need to pin down where it is.
> 
> Thanks,
> Guenter
> 
> 

