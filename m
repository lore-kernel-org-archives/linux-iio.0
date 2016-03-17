Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:61671 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752698AbcCQQPN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 17 Mar 2016 12:15:13 -0400
Message-ID: <56EAD83D.9010404@parrot.com>
Date: Thu, 17 Mar 2016 17:15:57 +0100
From: Gregor Boirie <gregor.boirie@parrot.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] iio:magnetometer:ak8975: mounting matrix support
References: <cover.1457001111.git.gregor.boirie@parrot.com> <022da3dfc0853c6f9820b24c2d9eaaf0c5ccf294.1457001111.git.gregor.boirie@parrot.com> <56DAFCEB.6080905@kernel.org> <56E0014D.1040209@parrot.com> <56E08B91.6070603@kernel.org> <56E6F2BA.5010101@parrot.com> <56E884FE.90005@kernel.org>
In-Reply-To: <56E884FE.90005@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


On 03/15/2016 10:56 PM, Jonathan Cameron wrote:
> On 14/03/16 17:19, Gregor Boirie wrote:
>> On 03/09/2016 09:46 PM, Jonathan Cameron wrote:
>>
>> [snip...]
>>> Definitely needs ABI docs in Documentation/ABI/testing/sysfs-bus-iio
>>> as well. We need the reference directions to be well specified as
>>> well - how do we define the main hardware orientation?  on yours presumably
>>> the usual approach of using the screen is irrelevant so that definition
>>> could be a little 'interesting' to write down?
>>>> The standard orientation for us is defined with respect to the drone's head
>>>> and the propellers plane, which does not suit the nominal use cases indeed...
>>>> Although it really deserves some more detailed documentation, I wonder if the
>>>> question is relevant.
>>>> Given that the DTS is board specific (correct me if I'm wrong), why not
>>>> consider the reference orientation as board specific as well (and make the
>>>> whole thing implicit) ?
>>> I think that is fine for your sort of usecase - though might be nice to keep
>>> a bit of documentation somewhere (perhaps as comments in the DTS), or perhaps
>>> more centrally - would be nice for userspace libraries if at least all aircraft
>>> had a similar 'default orientation'.
>> As you said earlier, things are never that simple. The standard orientation
>> may vary with types of UAVs (quad-rotor, fixed wings, bizarre home made UFOs...)
> Sure, but let's document what we can so at least some cases are covered
Let give it a try... (forgive my approximate english).

  /sys/bus/iio/devices/iio:deviceX/in_magn_matrix:

Mounting matrix for magnetometer sensors. This is a rotation matrix which
informs userspace about sensor chip's orientation relative to the main 
hardware
it is mounted on.
More specifically, main hardware orientation is defined with respect to the
local earth geomagnetic reference frame where :
* Y is in the ground plane and positive towards magnetic North ;
* X is in the ground plane, perpendicular to the North axis and ;
   positive towards the East
* Z is perpendicular to the ground plane and positive upwards.

Sensor orientation is defined with respect to the main hardware 
reference frame.
Given that the rotation matrix is defined in a board specific way 
(platform data
and / or device-tree), the main hardware reference frame definition is 
left to
the implementor's choice.
As an examplary guideline, one can consider that for a hand-held device, a
'natural' orientation would be 'front facing camera at the top'. The main
hardware reference frame could then be described as :
* Y is in the plane of the screen and is positive towards the top of the 
screen ;
* X is in the plane of the screen, perpendicular to Y axis, and positive 
towards
   the right hand side of the screen ;
* Z is perpendicular to the screen plane and positive out of the screen.
Another example for a quadrotor UAV might be :
* Y is in the plane of the propellers is positive towards the front-view 
camera;
* X is in the plane of the propellers, perpendicular to Y axis, and positive
   towards the starboard side of the UAV ;
* Z is perpendicular to propellers plane and positive upwards.

Applications should apply this rotation matrix to samples so that whenmain
hardware reference frame is aligned onto local earth geomagnetic reference
frame, then sensor chip reference frame is also perfectly aligned with it.

Matrix is a 3x3 unitary matrix and typically looks like
[0, 1, 0; 1, 0, 0; 0, 0, -1]. A missing in_magn_matrix sysfs entry means 
sensor
chip and main hardware are perfectly aligned with each other. It would be
identical to an in_magn_matrix file holding the identity matrix
[1, 0, 0; 0, 1, 0; 0, 0, 1].

References:
https://www.w3.org/TR/orientation-event/
http://developer.android.com/reference/android/hardware/SensorEvent.html
https://developers.google.com/project-tango/overview/frames-of-reference#coordinate_frame_pairs
http://www.chrobotics.com/library/understanding-euler-angles

Gregor.
