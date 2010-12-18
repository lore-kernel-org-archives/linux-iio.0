Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:43828 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752779Ab0LRX3x (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 18 Dec 2010 18:29:53 -0500
Message-ID: <4D0D43F9.3060302@cam.ac.uk>
Date: Sat, 18 Dec 2010 23:30:01 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Robin Getz <robin.getz@analog.com>, abbotti@mev.co.uk,
	fmhess@users.sourceforge.net,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	comedi_list@googlegroups.com
Subject: Re: IIO and Comedi
References: <201012171513.03045.robin.getz@analog.com> <20101217203306.GA13671@kroah.com>
In-Reply-To: <20101217203306.GA13671@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/17/10 20:33, Greg KH wrote:
> On Fri, Dec 17, 2010 at 03:13:02PM -0500, Robin Getz wrote:
>> I'm just trying to rationalise something in my head...
>>
>> In staging, there exists both iio, and comedi - which both seem to do similar 
>> things (capture/create external analog signals), just with different 
>> busses -- which is really different platforms (Desktop - PCI, PCIe vs 
>> embedded - I2C, SPI, SoC, etc).
>>
>> ./staging/iio
>> ./staging/comedi
>>
>> the problem (to me) is two different userspace interfaces.
>>
>> For userspace, for those "typical" applications - oscilloscope, generator, 
>> strip chart recorder, etc - it would be nice to have a common userspace lib 
>> between the two - so I can prototype on a desktop via PCI DAQ card, and run 
>> on my embedded system with a SPI converter.
> 
> I totally agree.
>
>> I can't be the only one asking if there any desire to unify these before they 
>> are moved to mainline (out of staging). If there isn't - that's OK too.
> 
> There's a desire to figure out a standardized kernel/user api for these
> types of devices, if they are similar.
> 
> But, we also have to be mindful of the many years of applications that
> rely on the comedi libraries.  comedi has been around since the 2.0
> days, so ideally if we can keep the userspace library from having to
> change its external api, we can do what we want with the kernel side.
> 
> So, any work you might want to do in this area is most appreciated.
> 
I have no problem with this suggestion and would be interested to see
proposals of how to go about this.  Be wary though, IIO also borders on two other
existing subsystems, hwmon and input which could also be argued to do much the
same sorts of jobs. Currently IIO provides sysfs type interfaces very similar
to hwmon (the same except for with alarms where their interfaces as too
restrictive) and we have shown a userspace daemon can handle conversion to
input. Any proposed changes in kernel space would have to tread carefully
around this. 

In theory one could move all the current IIO drivers over to comedi. I'd be
worried about doing this for exactly the same reasons that we didn't just put
these devices in input or hwmon. Some of the requirements are different (comedi
was suggested as an option very soon after IIO was mooted.)  That's not to say I'm
anti sharing of interfaces where ever possible!

Another approach would be to maintain current IIO functionality with
comedi file ops along side. What bothers me about this dual approach is the
additional complexity it would bring. Maybe it is worth it, but I would like
to reserve judgement for now.

Userspace approaches (with appropriate kernel changes) might work. Normally I'd
worry about trying to do a unified library using different kernel interfaces,
but given the stability of comedilib perhaps this would work.
There are many elements in common and things that comedi does much better than IIO.
There are definitely core elements that are similar but also differences in
requirements and approach that may be hard to address.

Basically I'd be interested to see proposals that move in this direction but don't
yet see how it would work.

Thanks,

Jonathan
(IIO 'maintainer')
