Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53788 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbcF0Sy0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jun 2016 14:54:26 -0400
Subject: Re: [RFC PATCH] iio: imu: add driver for Bosch Sensortec BNO055
To: Vlad Dogaru <vlad.dogaru@intel.com>
References: <1466766936-20561-1-git-send-email-vlad.dogaru@intel.com>
 <0fb507e2-e936-9c0c-9148-e4e329ba9dcb@kernel.org>
 <bc97ba4f-128a-b220-9f42-87e5a4ee90f3@kernel.org>
 <20160627091420.GC3142@vdogaru>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, andrey_utkin@fastmail.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <559ab4c5-e82a-55a7-f4f1-5d4cc2f744c0@kernel.org>
Date: Mon, 27 Jun 2016 19:53:49 +0100
MIME-Version: 1.0
In-Reply-To: <20160627091420.GC3142@vdogaru>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/06/16 10:14, Vlad Dogaru wrote:
> On Sun, Jun 26, 2016 at 07:03:14PM +0100, Jonathan Cameron wrote:
>> On 26/06/16 18:56, Jonathan Cameron wrote:
>>> On 24/06/16 12:15, Vlad Dogaru wrote:
>>>> Hi everyone,
>>>>
>>>> This is a minimal implementation of a driver for the Bosch Sensortec
>>>> BNO055, a very interesting accel-gyro-magneto combo.  The datasheet is
>>>> available at https://www.bosch-sensortec.com/bst/products/all_products/bno055
>>> 'interesting' device indeed.
>>>>
>>>> The driver in its present state works, but this is a RFC for a few
>>>> reasons detailed below:
>>>>
>>>> (1) The device has a few possible operating modes.  The most simple
>>>> ones employ a single sensor and power down the other two; the most
>>>> complex use all 3 for sensor fusion.  Changing the mode at runtime would
>>>> require changing the channels and I'm not sure IIO allows that.
>>> It allows a much greater set of channels than can run at one time though..
>>> Would that work here?  Lots of fun with available_scan_masks and
>>> friends, but from your description here sounds fine (will look at
>>> the code in a minute).
> 
> Haven't gotten to buffering yet :)
> 
>>>>  So I've
>>>> opted to choose the mode at probe time, based on a DeviceTree property.
>>>> Hope that's ok.
>>> Would rather it was runtime controllable I think...
>> Hmm. I can see this is complex because obviously the fusion has to start
>> at some point and if we flipped to reading a single axis it would get
>> turned off.
> 
> Not sure I've parsed this sentence correctly, but FWIW even in fusion
> modes, data from the individual sensors is still available.
Really, I thought for the acceleration at least they had aliased the 
normal acceleration with 'linear acceleration' e.g. the version with the
gravity vector removed.  May have misunderstood the datasheet on that
though as non obvious.
> 
>> Hideous though it is, perhaps an 'enable_fusion_engine' attribute would
>> be the way to do it with channels returning EBUSY if they are not available
>> in a given mode.
> 
> Hideous indeed, and not entirely useful in this case :)  The device
> supports multiple fusion modes, not just one.  And multiple non-fusion
> modes, as well.  If we want to switch at runtime, we need a multi value
> parameter, not just a boolean one, similar to the DT parameter we read
> at probe.
Agreed.
> 
> Maybe something like "operating_mode" and "operating_mode_available"?
> These could very well go in the ABI, but simply listing the available
> operating modes without description would not be very useful.  Perhaps
> the _available attribute could list modes one per line, with an
> associated explanation?
It would be unusual enough that I'd like a view on this from the sysfs
guys.  Also, not really terribly easy to pass in software and most
people (other than us driver developers) are never going to directly
interact with the sysfs attribute.
>  In this case:
> 
> 	$ cat operating_mode_available
> 	acconly - only the accelerator is powered on
> 	magonly - only the magnetometer is powered on
> 	[...]
> 	imu - use the accel and gyro for relative orientation data (high rate)
> 	compass - use accel and mag to calculate geographic rotation
> 	[...]
> 
> This would also solve the question "is my orientation data relative to
> initial or magnetic north?"  Users can check the operating_mode.  And to
> reinitialize the initial position for the imu, one could just
> reinitialize operating_mode.
True enough, though it's pretty ugly.  Can we drop a few by powering up
the magnetometer etc for the simple modes on demand?  If they come up
reasonably fast, for sysfs reads this is probably a good power saving
approach anyway.  Easy to pull only the right ones up for buffered modes.

We do technically have the _enable attribute for channels though it rarely
makes sense.  We could just have all the channels available and if you
enable a channel it pulls all the relevant set into working as well?

I'd love to avoid an interface that basically requires some reading of
the datasheet (or provided help to use it).  Tricky though!

> 
> Returning -EBUSY if a channel is unavailable sounds like a good plan to
> me.
> 
>> There are some precedents for this as there are parts that cannot
>> do both events and raw data reading at the same time. e.g. the Max1363
>> (well technically that part can, but it was so nasty to implement I never
>> did it an no one has ever cared since).
>>
>> We could only enable the fusion engine once the buffer is enabled, but
>> that seems a bit clunky given the fused data is in someways the most
>> useful stuff to get via polled reads.  'What orientation am I at now?'
> 
> I think buffer support and fusion mode are unrelated.  For example, the
> driver as it is now supports fusion, but not buffering.  And one could
> definitely enhance it to support buffering in both non-fusion and fusion
> modes.
Sure.  If fusion data had only made sense in buffered mode then it would
have been easy ;)  We could just have done it with the available_scan_masks
stuff.

J
> 
> Thanks,
> Vlad
> 

