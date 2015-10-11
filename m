Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40989 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbbJKM0g (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 11 Oct 2015 08:26:36 -0400
Subject: Re: User-space API again, detecting devices
To: Bastien Nocera <hadess@hadess.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <1444408033.28661.43.camel@hadess.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <561A5579.6030701@kernel.org>
Date: Sun, 11 Oct 2015 13:26:33 +0100
MIME-Version: 1.0
In-Reply-To: <1444408033.28661.43.camel@hadess.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/10/15 17:27, Bastien Nocera wrote:
> Hey,
> 
> I have a couple of bugs filed against iio-sensor-proxy where the
> problem is in my code's wrong way of doing device detection.
> 
> I want to detect compasses, accelerometers, and ambient light sensors,
> both those using triggers, and those that require polling. I'll try to
> answer my own questions, and you can tell me whether I'm wrong.
> 
> To detect accelerometers:
> - Check whether in_accel_x, in_accel_y and in_accel_z files exist
yes
> 
> To detect ambient light sensors:
> - Check whether in_intensity_both, or in_illuminance_input or
> in_illuminance_raw exists (the intensity one looks wrong...)
Yes - intensity is exported mostly because a lot of ambient light sensors
used to do their events stuff against only one of the two channels used
to find the value converted to a human eye matched illuminance.

There is no way of mapping backwards to know what to set the threshold
to without knowing the current value of one of the underlying intensity
measures (behind a particular optical filter - in the case of the _both
form it's an infrared and visible light passing filter).

So the illuminance ones are the 'right' option for detecting a useful
ambient light sensor.

The nasty corner case is colour light sensors in which there often isn't
a way of getting a true 'illuminance' value but rather you get various
colour filtered values loosely associated with it (sometime chip manufacturers
say helpful things like 'use the green' it's close to an illuminance
value - which it might be depending on the type of artificial lighting present).

Having just checked the existing drivers, we have 

6 colour sensors where the best option might be in_intensity_clear_raw
but who knows how to scale it (if it's present isl29125 just has RGB)

We also have the hid-sensors-als which looks to be doing a visible / infrared
only reading which is odd given the channel scan index name is illuminance...

rpr0521 doesn't provides the two signals usually used to figure out the illuminance
but doesn't actually provide any info on how to do it...  Not datasheet seems
to be available and the newer ROHM parts output (or the one I checked anyway) output
illuminance directly... Not much we can do about this one.


> 
> To detect compasses:
> - Check whether in_rot_from_north_magnetic_tilt_comp exists
If you are lucky enough to have a sophisticated one that will work.
A raw magnetometer combined with an accelerometer should allow the
equivalent to be worked out (IIRC - it's been a while since I did
much stuff with magnetometers!)

> 
> To detect whether the device needs polling, or has a trigger, construct
> a trigger name like <name>-dev<device number> for example, magn_3d-
> dev0.
> 
> Is that all correct?
The trigger name isn't that controlled.  Some devices have a number of
different triggers..  We also have a few existing drivers that don't
keep to this form even though they don't have multiple triggers..
Trying to fix that up but sadly they are in the ABI now so we need to
support the existing names (yup, we missed this one when they first
went it. oops).

The more reliable alternative to find available triggers is to navigate
up the tree from the device to it's parent.  That will then have
any triggers it supplies as children.

It won't always be obvious to a generic program which one to use though
I'm afraid.

Pesky hardware guys are always coming up with something new to make
it really hard to have true generic interfaces.  As a kernel subsystem
all we can do is provide as much information as we can about what is
happening to userspace.  Sometimes this doesn't work as well as 
everyone would like!

Jonathan

> 
> Cheers
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

