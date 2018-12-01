Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:47508 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbeLBDlu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Dec 2018 22:41:50 -0500
Date: Sat, 1 Dec 2018 16:28:52 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Daniel Drake <drake@endlessm.com>
Cc: linux-iio@vger.kernel.org, denis.ciocca@st.com,
        Bastien Nocera <hadess@hadess.net>, linux@endlessm.com,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: Inconsistent SMO8840 accelerometer data between Windows and
 Linux
Message-ID: <20181201162852.7007d1c9@archlinux>
In-Reply-To: <CAD8Lp45Ds3VU70kQ7fAUAegbzL-asxmF_iBacWpu7DMKp65sGA@mail.gmail.com>
References: <CAD8Lp45Ds3VU70kQ7fAUAegbzL-asxmF_iBacWpu7DMKp65sGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 27 Nov 2018 14:54:15 +0800
Daniel Drake <drake@endlessm.com> wrote:

> Hi,
> 
> We are working with SMO8840 sensors integrated into several Acer
> all-in-one consumer PCs and we would like to make the accelerometer
> work with iio-sensor-proxy so that the display is auto-rotated based
> on the physical orientation of the device.
> 
> One option is to inspect each device and then apply a mount matrix
> override in systemd, but we are looking for a generic solution. On
> Windows 10 the same functionality "just works" with the standard
> drivers from ST.
> 
> Looking at the Windows 10 situation, I can see that the ACPI DSDT
> includes orientation data for the accelerometer device, in a package
> named _ONT. Using an in-memory DSDT override I was able to remove this
> package in order to examine the "raw" uncorrected data from Windows.
> 
> I could then deduce the meanings of the 6 values in _ONT: the first 3
> are axis ordering, so the values "1 0 2" imply that the data arrives
> in order of axis Y, X, Z, or in other words X and Y are swapped. The
> final 3 values are inversion flags, values "0 0 1" mean that the Z
> values must have their sign flipped.

Ouch, they could at least have done something that inherently maintained
the handedness of the axes rather than doing it as a swap axis and
separate correction for the handedness.

Or even, perhaps actually bothered to look at adding their _ONT
mapping to the ACPI spec.  It would be a stretch for me to justify
that one in the day job or I'd be tempted...  When will people learn
that they shouldn't just make up acpi elements.  There are perfectly
good ways  of adding manufacturer data.. *sigh*

Great digging by the way!  If others with ST sensors could dump their
DSDT and use iASL to decompile it to see if they have an _ONT entry
that would be great!

> 
> On this product the values are as above, 1 0 2 0 0 1 (swap X and Y,
> negate Z). acpidump:
> https://gist.github.com/dsd/588762aaa3b5601ff7fc6a8692755877
> 
> However, looking to implement the same _ONT logic on Linux, I was met
> with the surprise that the values read by st-accel-i2c do not match
> the Windows values taken even when _ONT is removed.
> 
> This is a "landscape-first" device like the one illustrated here:
> https://blogs.windows.com/buildingapps/2015/09/03/new-sensor-features-in-windows-10/
> 
> Here is the data. I took Windows measurements using the "Sensors" app
> in the app store, and Linux measurements from sysfs in_accel_[xyz]_raw
> and manually normalized into the range -1 to +1.
> 
> 1. Placed flat on the desk, face up "looking up at the sky"
> Windows (with _ONT): (0, 0, -1)
> Windows (no _ONT): (0, 0, 1)
> Linux: (0, 0, -1)

So their default is flip the z axis.

> 
> 2. Normal landscape orientation (i.e. picture the device positioned
> the right way up and stuck to the wall)
> Windows (with _ONT): (0, -1, 0)
> Windows (no _ONT): (-1, 0, 0)
> Linux: (0, 1, 0)

Then swap x and y (the flip is handedness correction in conjunction with the
zaxis flip above.

> 
> 3. Rotated 90 degrees right from normal landscape orientation
> Windows (with _ONT): (1, 0, 0)
> Windows (no _ONT): (0, 1, 0)
> Linux: (1, 0, 0)

And finally just swap x and y.

> 
> 4. Rotated 90 degrees left from normal landscape orientation
> Windows (with _ONT): (-1, 0, 0)
> Windows (no _ONT): (0, -1, 0)
> Linux: (-1, 0, 0)
> 
> 5. Rotated 180 degrees from normal landscape orientation (i.e. upside down)
> Windows (with _ONT): (0, 1, 0)
> Windows (no _ONT): (1, 0, 0)
> Linux: (0, -1, 0)
> 
> Why is the data read by Linux inconsistent with the data from Windows
> even after I remove the _ONT orientation adjustment?

Given I'm fairly sure we basically just spit out the data directly
from the sensor, the most likely explanation is that ST hard coded
their driver to apply a transform for the first device they even
mounted it in.  When another came along with it mounted differently
they figured they needed to apply some sort of transform.

So their default is to first apply the following:

1) Swap x and y,
2) Flip z and resulting x (which was y).

If we want to support their ONT we'll need to do this first, then
apply ONT on top of that by forming the relevant mount matrix and
outputting that to userspace.

If you fancy having a go it would be good to have this support!

Bastien / Hans if you could check my logic (as the two people who
most often deal with this sort of horribleness!) that would be great.

Thanks,

Jonathan

> 
> Thanks
> Daniel
