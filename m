Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:60053 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755207Ab2DJNDl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Apr 2012 09:03:41 -0400
Message-ID: <4F842FAB.9080708@cam.ac.uk>
Date: Tue, 10 Apr 2012 14:03:39 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org,
	Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: proximity sensor, input
References: <alpine.DEB.2.01.1204101115470.17667@pmeerw.net> <4F8409D5.6050800@cam.ac.uk> <alpine.DEB.2.01.1204101301590.17667@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1204101301590.17667@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 4/10/2012 12:24 PM, Peter Meerwald wrote:
> Hello,
>
> thank you for your comments!
>
>> I'd not be anti an implementation of this though.  It would sit as an
>> additional buffer implementation (similar to that use for the input
>> bridge - see below) and do simple calculations / comparisons - then
>> providing iio events when conditions are passed etc. Could be rather
>> cute actually ;)  Tricky bit would be delinking it as far as possible
>> from the individual drivers.  Could do it completely separately... (i.e.
>> have another iio device that is a child of the original and has only
>> events rather than raw access etc).
> agree; there might be three conceptual layers:
> (1) sensor data acquisition
> (2) data aggregation / processing / thresholding
> (3) (input) event generation
>
> I can see iio fulfill (1); (2) might be difficult to do in a
> sensor-independant way;
Does it need to be in kernel?  I can think of cute ways of doing it 
there, but maybe
a stream of data to userspace then use uinput to push back events into 
the kernel
would do the job for you?
>   (3) should be easy
>
>>> is there some advise where proximity driver support might best fit?
>> Whilst the application you have (and some devices) are used simply as buttons
>> this isn't always the case and as you are considering writing a driver that
>> others will hopefully use, keep that in mind.  If you don't mind me
>> asking what device are you using?
> I'm looking at two different sensors (for different purposes); a VCNL4000
> and a Si1143: the former is simplistic (ALS+proximity, no interrupt, has
> to be polled), the latter should allow fancy HCI and ALS (i.e. three IR
> leds that should allow to estimate the positition/direction of a nearby
> object -- so one should be able to distinguish contactless swipe gestures
> etc.)
In both cases you have an ALS there, so you could do a multifunction 
driver but not everything
is going to fit into input.
>
> both are I2C and I'm using a beagleboard as dev platform
>
>> best choice.  If it will be used for things other than human input, then IIO
>> is worth considering.  Note we have work in progress to bridge from iio
>> devices across to input, but the gaping hole there at the moment is this doesn't
>> include threshold type events (what we consider events in IIO doesn't include normal
>> data flow).  Its on the todo list (in my head :)
> can you please point me to that work on bridging iio and input layer?
err. I'm being a bit slow on posting a current version of that work.
Last version I sent out was:
http://marc.info/?l=linux-iio&m=133077653302884&w=2 
<http://marc.info/?l=linux-iio&m=133077653302884&w=2>
>
> thank you for your guideline!
>
> regards, p.
>

