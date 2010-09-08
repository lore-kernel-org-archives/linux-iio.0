Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-30.csi.cam.ac.uk ([131.111.8.130]:58979 "EHLO
	ppsw-30.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758657Ab0IHMMf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 8 Sep 2010 08:12:35 -0400
Message-ID: <4C877EE1.2050907@jic23.retrosnub.co.uk>
Date: Wed, 08 Sep 2010 13:17:37 +0100
From: Jonathan Cameron <kernel@jic23.retrosnub.co.uk>
MIME-Version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>,
	Dmitry Torokhov <dtor@mail.ru>, Hemanth V <hemanthv@ti.com>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	"Getz, Robin" <Robin.Getz@analog.com>
Subject: RFC event related attribute naming.
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi All,

Given I've just said in a thread on lkml that I would be posting an RFC
for event attribute naming shortly I've move this up a bit in my todo list :)

This is very much an RFC. I'm looking for suggestions on how to make this
clearer, I'm not that attached to any of the naming if someone can come up
with something better.  I would also like to do this change alongside Manuel's
suggestion of a formal way of building the event codes (they will directly
correspond).  I am particularly unsure on how to handle periods.  We have two
types, one is used for averaging values (so the mean value of a particular time
must be above the threshold) the other is used to insist the value must be constantly
over the threshold for that time.  The rate of change (ROC) elements are also
somewhat confusing and I'm not sure I have everything covered there.

We deliberately left these more or less alone in the previous abi round. This
was mainly because we didn't have that many devices actually using them, so it
was tricky to know what was needed.

As before I'm going to define them only for one class of device.  Generalization
to other devices is mostly straight forwards. If anyone could point out special
cases for particular device types that would be great.  All of these can be extended
with a direction and number (e.g. accel_x0_ etc) if needed. I'll just assume one
axis here. Also, suppressing elements to generalize is fine. E.g. accel_thresh_period
will cover both falling and rising cases.

I've more or less restricted myself to element already in our drivers or that have
turned up in others I intend to add support for shortly. IIRC our list of
device with event support is: sca3000, lis3l02dq, max1363, adis16350, tsl2563

Others provide a few events for the buffers, but I'm not proposing to discuss those
here.


What:		/sys/.../device[n]:event[m]/accel_thresh_rising_en
Description:
	Enable/disable an event corresponding to the acceleration value rising past the
	threshold set in accel_thresh_rising_value. If accel_thresh_rising_period is used
	then the value must be above the threshold for that period.  If
	accel_thresh_rising_mean_period is used then the average value (applied to moving
	window of this length) must be above the threshold.

What:		/sys/.../device[n]:event[m]/accel_thresh_rising_value
Description:
	The value of the threshold for the event enabled by accel_thresh_rising_en.
	This is in raw units if the device provide accel_raw and m/s^2 if the device
	provides accel_input

What:		/sys/.../device[n]:event[m]/accel_thresh_rising_period
Description:
	The period for which the threshold in accel_thresh_rising_value must be breached
	for the event to occur. Units of this parameter are seconds (note it will often
	be fixed point).

What:		/sys/.../device[n]:event[m]/accel_thresh_rising_mean_period
Description:
	A moving window average is applied to the raw value.  If this average is greater
	than accel_thresh_rising_value the event occurs.

What:		/sys/.../device[n]:event[m]/accel_thresh_falling_en
Description:
	Enable/disable an event corresponding to the acceleration value falling past the
	threshold set in accel_thresh_falling_value. If accel_thresh_falling_period is
	present then the value must be below the threshold for that period.

What:		/sys/.../device[n]:event[m]/accel_thresh_falling_value
What:		/sys/.../device[n]:event[m]/accel_thresh_falling_period
What:		/sys/.../device[n]:event[m]/accel_thresh_falling_mean_period

What:		/sys/.../device[n]:event[m]/accel_mag_rising_en
Description:
	Enable/disable an event equivalent to accel_thresh_rising_en but applied to
	the magnitude (and not sign) of the raw reading (or in m/s^2 if accel_input
	is used.  If accel_mag_rising_period is present then the threshold must be
	breached for that period of time before an event occurs.

What:		/sys/.../device[n]:event[m]/accel_mag_rising_value
What:		/sys/.../device[n]:event[m]/accel_mag_rising_period
What:		/sys/.../device[n]:event[m]/accel_mag_rising_mean_period

What:		/sys/.../device[n]:event[m]/accel_mag_falling_en
Description:
	Enable/disable an event equivalent to accel_thresh_falling_en but applied to
	the magnitude (and not sign) of the raw reading (or in m/s^2 if accel_input
	is used.  If accel_mag_falling_period is present then the threshold must be
	breached for that period of time before an event occurs.

What:		/sys/.../device[n]:event[m]/accel_mag_falling_value
What:		/sys/.../device[n]:event[m]/accel_mag_falling_period
What:		/sys/.../device[n]:event[m]/accel_mag_faliing_mean_period

What:		/sys/.../device[n]:event[m]/accel_roc_rising_en
Description:
	Enable/disable an event that occurs if the rate of change of the acceleration
	measurement.

What:		/sys/.../device[n]:event[m]/accel_roc_rising_value
Description:
	The threshold on the rate of change that must be breached for the event to occur.
	RFC: How to work out the units of this are a little unclear.  See ADIS16350 for
	an example.  It tends to consist of the difference of pairs of samples neighbouring
	in time.  This could get complex in a device with continuous frequency control.
	The units will have to be something like raw_counts / second  (which after application
	of accel_scale will correspond to m/s^3.

What:		/sys/.../device[n]:events[m]/accel_roc_rising_period
What:		/sys/.../device[n]:events[m]/accel_roc_rising_mean_period (this is currently period on the adis16350)

What:		/sys/.../device[n]:event[m]/accel_roc_falling_en
What:		/sys/.../device[n]:event[m]/accel_roc_falling_value
What:		/sys/.../device[n]:event[m]/accel_roc_falling_period
What:		/sys/.../device[n]:event[m]/accel_roc_falling_mean_period

I haven't yet seen a magnitude equivalent of roc in the wild so we can figure out what to call
that another time.

Accelerometers also often have things like freefall detectors (which may or may not correspond to accel_mag_falling
depending on how it is implemented) and click / double click detectors. Given we don't care if they
came from an accelerometer or something else I guess freefall_en, click_en and doubleclick_en
would work?

I want to run it by this list first (to keep the argument muted) then I'll send a patch to the
documentation to lkml and see if anyone notices. I've cc'd a few people who might be
interested or have recently been trying to tackle similar issues.  Please cc anyone else
who may contribute.

Thanks,

Jonathan
	
