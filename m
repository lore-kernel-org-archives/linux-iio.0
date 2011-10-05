Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:50478 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932963Ab1JEJ6u (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Oct 2011 05:58:50 -0400
Message-ID: <4E8C2C54.2060605@cam.ac.uk>
Date: Wed, 05 Oct 2011 11:07:16 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Guenter Roeck <guenter.roeck@ericsson.com>
CC: "Hennerich, Michael" <Michael.Hennerich@analog.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Device-drivers-devel@blackfin.uclinux.org"
	<Device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH] staging:iio:adc:ad7314 removal. Supported via hwmon.
References: <1317378054-9511-1-git-send-email-jic23@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D59177146E7343656@LIMKCMBX1.ad.analog.com> <20111005094009.GA14989@ericsson.com>
In-Reply-To: <20111005094009.GA14989@ericsson.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/05/11 10:40, Guenter Roeck wrote:
> On Wed, Oct 05, 2011 at 04:39:01AM -0400, Hennerich, Michael wrote:
>> Jonathan Cameron wrote on 2011-09-30:
>>> Driver ported over to hwmon where it fits much better.
>>>
>>> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
>>
>> Acked-by: Michael Hennerich <michael.hennerich@analog.com>
>>
>>> ---
>>> Technically there is a slight loss of functionality in the hwmon
>>> driver (no power down mode).
>>>
>>> Otherwise, lets clear this one out.
>>>
>>> 3 more to go on my removal list ;)
>>> adt7310, adt7410 and adt75.
>>>
> 
> Just noticed this part. ADT75 is the Analog version of LM75. 
> Any reason not to use the standard LM75 driver instead ?
Fine by me!  I didn't realise that was the case.  Thanks for pointing it
out.

Michael, are you happy with simply adding the id to the lm75 driver and
dropping the iio one?  I can always do the actual patches if that helps.
> 
> On a side note, the iio adt75 driver won't work properly if oneshot is configured.
> I'll leave it to the readers to figure out why ;).
I dread to think, these few are a mess.

> 
> Regarding the power down mode, shouldn't this be supported using the standard 
> suspend/resume API with CONFIG_PM ? Or does iio have a parallel mechanism ?
It's more a case of run time power management.  Suspend support should indeed
be in there, but typically people want to shut these chips down if no one cares
about them, not just on suspend. Now we can apply heuristics (no one has
buffered access open, and any sysfs read is slow enough to bring the chip up
from powerdown anyway).  Normally that sort of stuff is a little fiddly so we
are leaving it to individual drivers to handle. They many also want to notify
the core that regulators / buses can be shut down as well.  This is particularly
true of stateless devices.

Power down attributes like in here certainly isn't part of IIO. Some of the
uglier drivers do it though.  Basically we always knew these adtxx drivers
were going to leave IIO so no one has ever worked on them except to keep
them compiling.

The only stuff we explicitly have is support of individual channel power down on output
devices (often have to control what state the pin is left in when powered down).
Individual power down may make sense on some input devices (ADCs), but I haven't seen
anything that supports it yet.

Jonathan

