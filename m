Return-Path: <pmeerw@pmeerw.net>
Date: Tue, 10 Apr 2012 13:24:15 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@cam.ac.uk>
cc: linux-iio@vger.kernel.org, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: proximity sensor, input
In-Reply-To: <4F8409D5.6050800@cam.ac.uk>
Message-ID: <alpine.DEB.2.01.1204101301590.17667@pmeerw.net>
References: <alpine.DEB.2.01.1204101115470.17667@pmeerw.net> <4F8409D5.6050800@cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

Hello,

thank you for your comments!

> I'd not be anti an implementation of this though.  It would sit as an 
> additional buffer implementation (similar to that use for the input 
> bridge - see below) and do simple calculations / comparisons - then 
> providing iio events when conditions are passed etc. Could be rather 
> cute actually ;)  Tricky bit would be delinking it as far as possible 
> from the individual drivers.  Could do it completely separately... (i.e. 
> have another iio device that is a child of the original and has only 
> events rather than raw access etc).

agree; there might be three conceptual layers:
(1) sensor data acquisition
(2) data aggregation / processing / thresholding
(3) (input) event generation

I can see iio fulfill (1); (2) might be difficult to do in a 
sensor-independant way; (3) should be easy

> > is there some advise where proximity driver support might best fit?
> Whilst the application you have (and some devices) are used simply as buttons
> this isn't always the case and as you are considering writing a driver that
> others will hopefully use, keep that in mind.  If you don't mind me 
> asking what device are you using?

I'm looking at two different sensors (for different purposes); a VCNL4000 
and a Si1143: the former is simplistic (ALS+proximity, no interrupt, has 
to be polled), the latter should allow fancy HCI and ALS (i.e. three IR 
leds that should allow to estimate the positition/direction of a nearby 
object -- so one should be able to distinguish contactless swipe gestures 
etc.)

both are I2C and I'm using a beagleboard as dev platform

> best choice.  If it will be used for things other than human input, then IIO
> is worth considering.  Note we have work in progress to bridge from iio
> devices across to input, but the gaping hole there at the moment is this doesn't
> include threshold type events (what we consider events in IIO doesn't include normal
> data flow).  Its on the todo list (in my head :)

can you please point me to that work on bridging iio and input layer?

thank you for your guideline!

regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
