Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:38356 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753103Ab2DJKWR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Apr 2012 06:22:17 -0400
Message-ID: <4F8409D5.6050800@cam.ac.uk>
Date: Tue, 10 Apr 2012 11:22:13 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: proximity sensor, input
References: <alpine.DEB.2.01.1204101115470.17667@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1204101115470.17667@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 4/10/2012 10:47 AM, Peter Meerwald wrote:
> Hello,
>
> I am wondering how to support proximity sensors; goal is to trigger some
> application event when an object comes close (in that sense, the proximity
> sensor is used like a button)
>
> there are several places in the kernel doing similar things:
> e.g. input/misc/gp2ap0002a00f.c
> e.g. drivers/misc/bh1770glc.c
> e.g. drivers/staging/iio/isl29018.c
>
> iio seems to be most active and has IIO_PROXIMITY, but I do not see how
> the application is easily notified: iio collects merely collects the
> sensor data
Not true. IIO has a reasonably well developed event interface iff the 
hardware supports
it.  There is no support for simulating a hardware detector in kernel in 
a generic sense.
I'd not be anti an implementation of this though.  It would sit as an 
additional buffer
implementation (similar to that use for the input bridge - see below) 
and do simple
calculations / comparisons - then providing iio events when conditions 
are passed etc.
Could be rather cute actually ;)  Tricky bit would be delinking it as 
far as possible from
the individual drivers.  Could do it completely separately...
(i.e. have another iio device that is a child of the original and has only
events rather than raw access etc).
>
> drivers in misc just create some custom sysfs interface
Agreed. That option is bad!
>
> input/misc has just one driver dealing with proximity
>
> is there some advise where proximity driver support might best fit?
Whilst the application you have (and some devices) are used simply as 
buttons
this isn't always the case and as you are considering writing a driver 
that others
will hopefully use, keep that in mind.  If you don't mind me asking what 
device
are you using?

If all it does is an interrupt (and no raw data access) then input is 
probably the
best choice.  If it will be used for things other than human input, then IIO
is worth considering.  Note we have work in progress to bridge from iio 
devices
across to input, but the gaping hole there at the moment is this doesn't 
include
threshold type events (what we consider events in IIO doesn't include normal
data flow).  Its on the todo list (in my head :)
>
> thanks, regards, p.
>

