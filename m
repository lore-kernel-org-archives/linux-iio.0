Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:52672 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760575Ab1D1Odo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 28 Apr 2011 10:33:44 -0400
Message-ID: <4DB97B4C.7030509@cam.ac.uk>
Date: Thu, 28 Apr 2011 15:35:56 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Guenter Roeck <guenter.roeck@ericsson.com>
CC: Jean Delvare <khali@linux-fr.org>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>,
	Drivers <Drivers@analog.com>
Subject: Re: Oddities and how to handle them.
References: <4DB6EF2D.9090704@cam.ac.uk> <4DB7FEE8.3080004@analog.com> <4DB82B5C.5070900@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D5917713AAEE15859@LIMKCMBX1.ad.analog.com> <4DB8322A.6050207@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D5917713AAEE15A62@LIMKCMBX1.ad.analog.com> <4DB933E3.8070803@cam.ac.uk> <20110428155118.041b84f2@endymion.delvare> <4DB977F2.7090002@cam.ac.uk> <20110428142348.GA27775@ericsson.com>
In-Reply-To: <20110428142348.GA27775@ericsson.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/28/11 15:23, Guenter Roeck wrote:
> On Thu, Apr 28, 2011 at 10:21:38AM -0400, Jonathan Cameron wrote:
>> On 04/28/11 14:51, Jean Delvare wrote:
>>> On Thu, 28 Apr 2011 10:31:15 +0100, Jonathan Cameron wrote:
>>>> Guenter / Jean - cc'd you two because we have an sysfs interface naming question for
>>>> AC sensors that touches on the edge of hwmon.
>>>>
>>>>> For the metering parts I think we need to define a few more channel types.
>>>>>
>>>>> How about this ones
>>>>>
>>>>> inSX            S is the apparent power.
>>>>> inPX            P is the active power.
>>>>> inQX            Q is the reactive power.
>>>>> inVX            V is the voltage. (only inX ?)
>>>>> inVRMSX VRMS is the quadratic mean voltage.
>>>> Call it 'root mean square' rather than quadratic in the docs. They have different
>>>> meanings in English.
>>>>> inIX            I is the current.
>>>> currX as per hwmon?  They also define a power attribute, but only 1 (as DC
>>>> I guess). Cc'd Guenter and Jean to see if we can / want to share an interface...
>>>>
>>>> Guenter/ Jean, do you think hwmon will ever handle AC sensors?
>>>
>>> Well, never say never ;) While I've never heard of such sensors, I
>>> guess it would make some sense for a computer PSU to include a sensor
>>> chip monitoring both the AC input and the DC output to measure the
>>> efficiency of the unit.
>>>
>>>> Maybe we want to be
>>>> well clear of your interfaces just to avoid confusion? Or define a new set of shared
>>>> names for the above that we will both use (when it becomes relevant?)
>>>
>>> It's hard to tell in advance what hwmon would implement, as we lack
>>> actual examples. All I can say is that we would never use "in" prefixes
>>> for power or current. The above power examples would most probably be
>>> named powerX_apparent_input, powerX_active_input and
>>> powerX_reactive_input, if we ever have to support these. And
>>> inX_rms_input for the root mean square voltage input.
>>>
>>> But then again, I'm not sure if there is any point in sharing anything,
>>> or forcing any difference, between hwmon and iio interfaces. They are
>>> different by nature, and if we don't strictly enforce their relation,
>>> they are bound to randomly diverge and converge anyway.
>>>
>> Agreed to a certain extent, but saying that there is no point in reinventing
>> the wheel.  I think the naming you've just suggested is clearer anyway.
>>
>> Ultimately I don't insist on keeping to your interfaces when it really doesn't
>> make sense, but when it does, it makes our life easier as we aren't starting from
>> scratch. Also, politically it was suggested we do this by a few people I'd like
>> to keep on side.
>>
>> Michael - howabout doing the rms values as done with peak_raw - as chan info parameters
>> (directly derived from raw values anyway).
>>
>> Then define two new (to us) channel types.
>>
>> IIO_CURRENT = "curr%d"
>> IIO_POWER = "curr%d"
>>
> power%d, presumably.
Ooops. Thanks.
> 
>> Using the rfc I'm going to post after I send this email, we can add additional names to a channel.
>> The only slight annoyance is the 3 power values will need to be different channels, so under that
>> we will have:
>>
>> power0_apparent_raw           is the apparent power.
>> power1_active_raw             is the active power.
>> power2_reactive_raw           is the reactive power.
>> in0                           is the voltage.
>> in0_rms_raw                   is the rms voltage.
>> curr0_raw                     is the current.
>>
> Note that in hwmon, all input sensors have _input at the end, as in Jean's example.
> What does the _raw stand for ?
Means unprocessed.  We use _input for anything that is already in the right units.
If it's a linear transform than it's up to userspace to do it (using other attributes
that tell it what the conversion factors are).  The main drivers to convert to
SI units for output are light sensors where this transform is truly hideous!
They then use illuminanceX_input as the attribute name.

Some devices have no known conversion to any helpful units (tend to be calibrated
to a specific task - proximity sensors are probably the worst for this).

With sysfs access whether we process in kernel or in userspace doesn't matter much
(though it does push some bits into user space where simpler floating point code
can deal with them).

It is more important with the other route for data from devices where we have
buffered access via a more or less overhead free software or hardware (ring/fifo)
buffers.

Also, we do abuse your _input sytax by allowing floating point values (irrc, you
insist on integer?)

Jonathan
