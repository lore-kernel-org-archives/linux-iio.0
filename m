Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42167 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755579AbcH2Rbu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Aug 2016 13:31:50 -0400
Subject: Re: [PATCH] iio: document bindings for mounting matrixes
To: Linus Walleij <linus.walleij@linaro.org>
References: <1469355434-17043-1-git-send-email-linus.walleij@linaro.org>
 <ab89a386-dfca-bbc3-3dec-613d32d374a5@kernel.org>
 <CACRpkdbA=qZO9M=nc2mUK7Sg5ZdOzcH=x0kUQ004_+uVTQ8tCA@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sebastian Reichel <sre@kernel.org>,
        Samu Onkalo <samu.onkalo@intel.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <8137ebdc-fcf5-8b5b-bed6-1b72eaf5ecca@kernel.org>
Date: Mon, 29 Aug 2016 18:31:44 +0100
MIME-Version: 1.0
In-Reply-To: <CACRpkdbA=qZO9M=nc2mUK7Sg5ZdOzcH=x0kUQ004_+uVTQ8tCA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/08/16 22:56, Linus Walleij wrote:
> On Sun, Aug 21, 2016 at 5:56 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> 
>> Sorry I took so long to get to this...
>> (out of curiosity are you running a fifo queue of patches? Every time
>> I review and merge one, another one turns up in my inbox :)
> 
> Haha no, IIO is just sucking me in, it's such a nice subsystem.
> 
>>> +The axes may also be flipped: for a screen you probably want (x) coordinates to
>>> +go from negative on the left to positive on the right and (z) depth to be
>>> +negative under the screen and positive in front of it, toward the face of the
>>> +user.
>>
>> I'm not sure we don't want to define that it can't be flipped and enforce the
>> correct coordinate system on the underlying drivers (fingers crossed they are
>> currently all left or all right handed? - oops should have been keeping an eye on
>> this).
> 
> I'll reword. What I wante to get across was the concept of flipped axes.
> 
> We need to keep an eye on drivers coming from the middle
> east as their writing systems go from right to left, but I suspect they are
> all aware of this issue.
> 
>> For now we are being a bit simplistic as for accelerometers at least, it can be
>> of interest to know the translation as well as the rotation.  You can use a couple
>> of them to do fairly precise rotation estimate if they are located in different
>> places on a device.
> 
> Hm the mounting matrix doesn't account for that at all. Oh well sigh, that
> would be another property in sysfs the day we need to handle it.
> 
>>> +Examples for some three-dimensional sensor types:
>>> +
>>> +- Accelerometers have their frame of reference
>>
>> Not quite right.  Their frame of reference is in the frame of the device - it has
>> nothing to do with the world frame which you are describing here (except when
>> the device is deliberate oriented to match.
> 
> So the core of the crux, the help I'm trying to provide, is for people
> that develop sensor drivers to be able to verify that they have the right
> mounting matrix.
> 
> They need to see that the figures coming out of the buffers match to
> something they can verify and thus understand that they got it right.
> 
> Maybe this is too ambitious :(
That's fine, but the trick is to explicitly say that under these circumstances
the rotation matrix between the device and the world is the identity matrix
(and highlight that that means it has no effect).  Under these specific
circumstances, the mounting matrix may be easily verified.

> 
>> So we have 3 frames - that of the sensor, that of the device and that of the world.
> 
> OK reworded and tried to reflect this.
> 
>   is toward the center of gravity,
>>> +  usually to the core of the planet, and users would likely expect a value of
>>> +  9.81N upwards along the (z) axis when the device is held with its screen
>>> +  perpendicular to the planets surface and 0 on the other axes.
>>
>> I'd have thought screen parallel  - i.e. z is out of the screen?
>> Might be the same thing I suppose, but I'd define it simply as into the screen
>> then y towards top of screen and x from left to right of the screen.
> 
> Trying to fix up the confusion by rewording.
> 
>>> +- Magnetometers (compasses) have their frame of reference relative to the
>>> +  geomagnetic field. In a mounting matrix for a magnetometer sensor the main
>>> +  hardware orientation is defined with respect to the local earth geomagnetic
>>> +  reference frame where (y) is in the ground plane and positive towards
>>> +  magnetic North, (x) is in the ground plane, perpendicular to the North axis
>>> +  and positive towards the East and (z) is perpendicular to the ground plane
>>> +  and positive upwards.
>>
>> Same issue, world to frame transform is not included...
> 
> OK rewording, this is all about the system-to-world really.
> 
>>> +- Gyroscopes detects the movement relative the device itself, and has no other
>>> +  frame of reference than the mounting chassis itself.
>>
>> This is true for all of them as far as we are concerned here...
>>> The angular momentum is
>> Hang on, where did momentum come into it from?  Mems gyros are detecting rate
>> of change of rotation about an axis (lets ignore the significant cross talk and
>> effects of linear acceleration and pretend it's all easy here ;)
>>
>> Rest of this description is fine.
> 
> Angular velocity. Sorry, just screwed it up.
> 
>>> +Flipped X axis (negative values means positive):
>>> +
>>> +mount-matrix = "-1", "0", "0",
>>> +               "0", "1", "0",
>>> +               "0", "0", "1";
>>
>> Hmm. This is an odd one as it basically means the device had a right hand
>> coordinate system in the first place... If that happens I think we should
>> by default report the negative of the scale for that axis.
>>
>> We've never strictly defined a coordinate system but I think left handed
>> is a good start!
>>> +
>>> +X and Y flipped (X values are for Y and Y values are for X):
>>> +
>>> +mount-matrix = "0", "1", "0",
>>> +               "1", "0", "0",
>>> +               "0", "0", "1";
>> Same with this one, we are flipping coordinate systems.
> 
> Hm you have a point.
> 
> Those are inspired by the touchscreen input properties
> Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
> as those have:
> 
>  - touchscreen-inverted-x       : X axis is inverted (boolean)
>  - touchscreen-inverted-y       : Y axis is inverted (boolean)
>  - touchscreen-swapped-x-y      : X and Y axis are swapped (boolean)
>                                   Swapping is done after inverting the axis
> 
> By supporting the mount matrix we open the door for augmenting
> driver bugs with this. Sigh.
> 
>> I'd expect only
>> rotation matrices to be valid mount matrices.
> 
> OK what about sensor mounted upside-down relative device:
> 
> mount-matrix = "1", "0", "0",
>                "0", "1", "0",
>                "0", "0", "-1";
> 
> Sensor mounted standing on the side so X becomes Z
> and Z becomes X:
> 
> mount-matrix = "0", "0", "1",
>                "0", "1", "0",
>                "1", "0", "0";
> 
> Are these proper rotation matrices?
Determinant = 1? 

Err (been a while) but using trusted wolfram alpa.

Nope to the first one That's a rotoinversion.
No to the second as well..  You can't end up just swapping axis.

Imagine taking your thumb and first two fingers to form a 3D axis
then see if you can spin it using your circus skills to match
the new orientation.

> 
>>> +Complex angular mounting with X and Z in a certain tilted orienation and
>> orientation
>>> +Y flipped:
>>> +
>>> +mount-matrix = "-0.984807753012208",  /* x0 */
>>> +               "0",                   /* y0 */
>>> +               "-0.173648177666930",  /* z0 */
>>> +               "0",                   /* x1 */
>>> +               "-1",                  /* y1 */
>>> +               "0",                   /* z1 */
>>> +               "-0.173648177666930",  /* x2 */
>>> +               "0",                   /* y2 */
>>> +               "0.984807753012208";   /* z2 */
>>>
This one is a rotation ;)
>>
>> Anyhow, now my head hurts.
> 
> That is a real-world example from the AK8975 on some Nokia...
> 
> Yours,
> Linus Walleij
> 

