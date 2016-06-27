Return-Path: <vlad.dogaru@intel.com>
Date: Mon, 27 Jun 2016 12:14:21 +0300
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, andrey_utkin@fastmail.com
Subject: Re: [RFC PATCH] iio: imu: add driver for Bosch Sensortec BNO055
Message-ID: <20160627091420.GC3142@vdogaru>
References: <1466766936-20561-1-git-send-email-vlad.dogaru@intel.com>
 <0fb507e2-e936-9c0c-9148-e4e329ba9dcb@kernel.org>
 <bc97ba4f-128a-b220-9f42-87e5a4ee90f3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bc97ba4f-128a-b220-9f42-87e5a4ee90f3@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Jun 26, 2016 at 07:03:14PM +0100, Jonathan Cameron wrote:
> On 26/06/16 18:56, Jonathan Cameron wrote:
> > On 24/06/16 12:15, Vlad Dogaru wrote:
> >> Hi everyone,
> >>
> >> This is a minimal implementation of a driver for the Bosch Sensortec
> >> BNO055, a very interesting accel-gyro-magneto combo.  The datasheet is
> >> available at https://www.bosch-sensortec.com/bst/products/all_products/bno055
> > 'interesting' device indeed.
> >>
> >> The driver in its present state works, but this is a RFC for a few
> >> reasons detailed below:
> >>
> >> (1) The device has a few possible operating modes.  The most simple
> >> ones employ a single sensor and power down the other two; the most
> >> complex use all 3 for sensor fusion.  Changing the mode at runtime would
> >> require changing the channels and I'm not sure IIO allows that.
> > It allows a much greater set of channels than can run at one time though..
> > Would that work here?  Lots of fun with available_scan_masks and
> > friends, but from your description here sounds fine (will look at
> > the code in a minute).

Haven't gotten to buffering yet :)

> >>  So I've
> >> opted to choose the mode at probe time, based on a DeviceTree property.
> >> Hope that's ok.
> > Would rather it was runtime controllable I think...
> Hmm. I can see this is complex because obviously the fusion has to start
> at some point and if we flipped to reading a single axis it would get
> turned off.

Not sure I've parsed this sentence correctly, but FWIW even in fusion
modes, data from the individual sensors is still available.

> Hideous though it is, perhaps an 'enable_fusion_engine' attribute would
> be the way to do it with channels returning EBUSY if they are not available
> in a given mode.

Hideous indeed, and not entirely useful in this case :)  The device
supports multiple fusion modes, not just one.  And multiple non-fusion
modes, as well.  If we want to switch at runtime, we need a multi value
parameter, not just a boolean one, similar to the DT parameter we read
at probe.

Maybe something like "operating_mode" and "operating_mode_available"?
These could very well go in the ABI, but simply listing the available
operating modes without description would not be very useful.  Perhaps
the _available attribute could list modes one per line, with an
associated explanation?  In this case:

	$ cat operating_mode_available
	acconly - only the accelerator is powered on
	magonly - only the magnetometer is powered on
	[...]
	imu - use the accel and gyro for relative orientation data (high rate)
	compass - use accel and mag to calculate geographic rotation
	[...]

This would also solve the question "is my orientation data relative to
initial or magnetic north?"  Users can check the operating_mode.  And to
reinitialize the initial position for the imu, one could just
reinitialize operating_mode.

Returning -EBUSY if a channel is unavailable sounds like a good plan to
me.

> There are some precedents for this as there are parts that cannot
> do both events and raw data reading at the same time. e.g. the Max1363
> (well technically that part can, but it was so nasty to implement I never
> did it an no one has ever cared since).
> 
> We could only enable the fusion engine once the buffer is enabled, but
> that seems a bit clunky given the fused data is in someways the most
> useful stuff to get via polled reads.  'What orientation am I at now?'

I think buffer support and fusion mode are unrelated.  For example, the
driver as it is now supports fusion, but not buffering.  And one could
definitely enhance it to support buffering in both non-fusion and fusion
modes.

Thanks,
Vlad
