Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-31.csi.cam.ac.uk ([131.111.8.131]:43449 "EHLO
	ppsw-31.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755638Ab0IWQ3N (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 23 Sep 2010 12:29:13 -0400
Message-ID: <4C9B819A.1030609@cam.ac.uk>
Date: Thu, 23 Sep 2010 17:34:34 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: RFC: Building event codes from the event type.
References: <4C9B5191.9050407@cam.ac.uk> <4C9B7DC9.8000109@cam.ac.uk> <4C9B7D5C.8040400@iis.fraunhofer.de>
In-Reply-To: <4C9B7D5C.8040400@iis.fraunhofer.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/23/10 17:16, Manuel Stahl wrote:
> Am 23.09.2010 18:18, schrieb Jonathan Cameron:
>> On 09/23/10 14:09, Jonathan Cameron wrote:
>>>
>>> This proposal is based on an observation of Manuel's that
>>> we could construct all of our event codes in a much more
>>> logical fashion by breaking them up into a series of bit
>>> fields within the event code.
>>>
>>> So lets define this as a structure for the purposes of this
>>> discussion.  The eventual implementation would probably be
>>> done with macros.
>>>
>>> I'm assuming it makes sense to have a single 32bit number
>>> as the event code. Sorry for the abuse of kernel doc.
>>> I have no idea how one actually documents unions or structures
>>> within structures.
>>>
>>> /**
>>>   * iio_event_code - structure representing an event
>>>   * @sensor_type: 256 codes for different classes of sensors
>>>   *   - accel, gyro, in, light etc.
>>>   * @directedornot: Tells us whether the modifier is for a sensor
>>>   *   with axes or one where this doesn't make sense.
>>>   * @modifier: identify which channel
>>>   *    @directed: modifier for sensor where an axis makes sense
>>>   *        @direction: 16 different directions, x, y, z + compound
>>>   *                    versions x|y|z x|y x|z y|z x&y&z x&y x&z y&z
>>>   *        @number: allow up to 8 sensors in a given direction if
>>>   *                  it is a sensor where direction makes sense.
>>>   *    @number: for sensor where axis doesn't make sense allow 128 channels
>>>   * @type: thresh, mag, roc + specific things like free fall etc.
>>>   * @direction: falling or rising or either.  (so there are some spare bits here).
>>>   **/
>>> struct iio_event_code {
>>>     unsigned sensor_type:8;
>>>     union {
>>>         unsigned directedornot:1;
>>>         struct {          
>>>         unsigned direction:4;
>>>         unsigned number:3;
>>>         } directed;
>>>         unsigned number:7;
>>>     } modifer;
>>>     unsigned type:8;
>>>     unsigned direction:8;
>>> };
>>>
>>> So would people be happy with this rough approach. + please comment on the
>>> exact layout and in particular point out classes of event that do not fit.
>>>
>>> The interpretation of everything after sensor_type for buffer events will
>>> probably have to be separately defined. It would complicate this too much.
>>>
>>> Given the resounding silence that followed my recent post asking for wider
>>> opinions on naming of such events (to lkml), I'll probably just get on with
>>> implementing the scheme we suggested there for naming the attributes etc.
>>>
>> Given I had a little time this afternoon and I'm fairly sure we will end up
>> with something similar to the above I started implementing it.
>>
>> One particular lesson came to mind. If we allow particular channels to have
>> 'names' then we must also oblige them to have an associated number. We don't
>> want to get into the game of having a huge list of label to event code conversions.
>>
>> So taking what we currently have in tree...
>>
>> in_supply ->  in0_supply (and move in0 to in1)
>> intensity_both ->  intensity0_both
>> intensity_ir ->  intensity1_ir
>> etc.
>>
> 
> Guess we could also use the scan_element ordering as unique number.
Some drivers that do events don't have any concept of scans.  They don't implement
any of the buffer code. Also, most buffer implementing drivers can be built without
support for the buffers which would again mean that these aren't available.

However, just from a consistency point of view I'm keen to keep the ordering of a
given type of element the same through out the driver (hence moving in0 to in1
in the adis drivers to allow in0_supply to exist).

So I suggest a small abi 'clarification' to enforce the following:
If the label isn't our conventional _x, _y, _z then it must also be numbered.

We can introduce other such labels if appropriate but they will fall into the orientation
category above.

Another thing I found useful was to define orientation codes for x_or_y_or_z and x_and_y_and_z
Using these, classic motion detection interrupts become thresholds with direction of rising
and orientation of x_or_y_or_z, free fall detection becomes a threshold with direction of falling
and orientation of x_and_y_and_z. Some of our drivers will also want to have _period and _meanperiod
added to more fully describe how these detectors are implemented. Its nice not treating these
as special cases with 'magic' going on inside.

We will need a special case for input type events though such as 'tap' and 'double tap'.
We don't have anything implementing them in the tree so I haven't done it as yet.

Thanks,

Jonathan
