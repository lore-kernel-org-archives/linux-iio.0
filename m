Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:51192 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753747AbeFJN3Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 10 Jun 2018 09:29:24 -0400
Date: Sun, 10 Jun 2018 14:29:22 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Mathieu Othacehe <m.othacehe@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de
Subject: Re: isl29501 and multiple calibration registers
Message-ID: <20180610142909.278028c5@archlinux>
In-Reply-To: <87o9gpbkpc.fsf@gmail.com>
References: <87a7snd8r7.fsf@gmail.com>
        <876037dc4f.fsf@gmail.com>
        <20180603153833.0710bc03@archlinux>
        <87o9gpbkpc.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 05 Jun 2018 12:18:23 +0200
Mathieu Othacehe <m.othacehe@gmail.com> wrote:

> Hi Jonathan,
> 
> Thanks for you review. I was able to found more informations about the
> chip at this address:
> https://www.intersil.com/en/products/optoelectronics/proximity-sensors/light-to-digital-sensors/ISL29501.html#document.
Good, lots there to look at.

> Please find a v2 attached and my answer to your comments below.

Please send new versions as a fresh email thread with the
patch inline, not as an attachment.  For this version I've pasted the
patch inline below.

Sorry for the delay on this, busy week! Anyhow, this is probably still going
to take us a few more rounds to pin down well.

Some of this heads into the territory of frequency generators and wave
measurement so I've cc'd Lars who has had some involvement with those
devices.

> 
> > The exponent / (presumably) mantissa split in some of these is a pain,
> > as we really don't want to have userspace have to figure out how
> > those are related.  They really need to be 'one' value.  The fun bit
> > is that sometimes the exponent is shared so we will need to find
> > the best value for all the controlled parameters.  
> 
> Yes it will certainly be painful to implement.

The upshot is if we don't do this, the parameter is probably never going to
be used by userspace code.

> 
> > Please don't define elements that are already covered by standard ABI and are
> > docuemnted in the sysfs-bus-iio files or similar.  
> 
> Ok.
> 
> > This needs more information.  From that I have no idea what the noise
> > approximation is?  Standard deviation of the noise perhaps?
> > Some other statistical measure?  
> 
> This is a point where I couldn't found any information. I'll ask Renesas
> for help about this one.

Cool - let us know if you aren't getting anything as there may be someone
on the list with some additional contacts to dig out info!

> 
> > in_proximity0_amplitude and it needs to be in standard units for current,
> > even if that requires conversion in the driver from the internal representation.  
> 
> This one is only useful for calibration so in_proximity0_amplitude seems
> fine.
> 
> > What is an "I" value? What is it's units?  All this stuff should be documented
> > here.  I'm guessing we are talking quadrature signals, but that's not
> > clear here.  
> 
> Yes it is the in-phase part of the signal, I detailed this part in v2.
> 
> > This sounds like we have two different attributes for the same actual number.
> > Can we combine them and deal with the exponent internally?  
> 
> Done.
> 
> > Again, sounds like we ought to be able to figure out how to split the exponent
> > and mantissa.  Afterall any userspace calibration code is going to have
> > to do this anyway so it can't be that hard :)  
> 
> Done.
> 
> > These all need more explanation in the descriptions.  What would userspace do
> > with them?  What effect do that have on the read signal?  
> 
> Detailed in v2.
> 
> >> +What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calib_mag_ref  
> > Hmm. What's this one?  What is it a reference for?
> >
> > I'm guessing this is the auto gain control, which has only basic documentation
> > on the datasheet I'm looking at..  
> 
> I renamed it into in_proximity0_calib_ampl_ref it is suppose to store
> the in_proximity0_amplitude value read when calibrating crosstalk.

>From a consistency point of view, I wouldn't use different abbreviations for
different elements.  So put amplitude in unabbreviated in this one.

> 
> > I think this is another one which can be combined with the 'value' to
> > get the best possible representation of whatever this should be.  
> 
> Done.
> 
> >> +What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_phase_offset  
> > What do these numbers represent?  Given the name I'd assume something
> > to do with 1/65536 of a cycle but who knows...
> >
> > If so we should have better units for this.  
> 
> The naming of this field in the datasheet is really misleading. It is in
> fact the distance calibration. It stores the difference between a known
> distance and corresponding measured distance. I renamed it
> in_proximity0_calib_distance_ref in v2.

So does this end up being applied as a simple offset? Can we use standard
ABI for it? _calibbias

> 
> > That is annoying.  Shared exponent of various different values.  Ideal is to
> > have the driver figure out the 'best' option accuracy wise for whatever
> > set of parameters we currently have.  
> 
> Ok, I'll try to implement it in the driver.

Cool.

> 
> > Please explain clearly here what this is.
> >
> > ax^2 + bx + c etc  
> 
> Done.
> 
> > Hmm. We have done this in two ways in the past, either as a control signal of the
> > proximity or a separate output signal.  I'm not immediately sure which makes
> > sense here.  Probably the current output channel option like in the si1145 driver.  
> 
> Ok.
> 
> Thanks,
> 
> Mathieu

>From 576c5976cc4c664231001e858aea4f8758bd3978 Mon Sep 17 00:00:00 2001
From: Mathieu Othacehe <m.othacehe@gmail.com>
Date: Mon, 28 May 2018 17:35:32 +0200
Subject: [PATCH v2] iio: isl29501: Add documentation.

The ISL29501 is a Time of Flight (ToF) based signal processing
integrated circuit. The sensor enables long range optical distance
sensing when combined with an external emitter and detector.
---
 Documentation/ABI/testing/sysfs-bus-iio-isl29501 | 120 +++++++++++++++++++++++
 1 file changed, 120 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-isl29501

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-isl29501 b/Documentation/ABI/testing/sysfs-bus-iio-isl29501
new file mode 100644
index 0000000..7d6ade8
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-isl29501
@@ -0,0 +1,120 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_phase_i
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_phase_q
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		The sensor uses analog quadrature signal processing
+		techniques to estimate the phase of the received
+		signal. The received signal is demodulated into
+		"in-phase" (I) and "quadrature" (Q) components.
+
+		Get I and Q values as unit less integer between -32768
+		and 32767 inclusive when read from.

I'm not totally clear what this is.  From a really quick look at the
docs, I think we are looking at in phase and quadrature elements
of the amplitude.  As the amplitude is basically a light intensity
measurement

in_intensity0_q_raw
in_intensity0_i_raw
in_intensity0_scale if it is possible to relate this anything real
I think in reality it does have a unit, we just have no visibility
of what that is.

We also have a phase measurement, but naturally only one of htem
in_phase0_raw
in_phase0_scale


+
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_amplitude
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Get the amplitude of the received signal in A between
+		0 and 2.148A when read from.

Hmm. Thinking more on this, we could treat this as a separate channel.
Given it's light intensity it would be an intensity channel.
It's in some sense the combination of the split quadrature elements
above
in_intensity0_raw
in_intensity0_scale.  Note for these that the scale is assumed by
most userspace code to be fixed, so you'll need to roll the exponent
part into the _raw value not the _scale.#



+
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calib_cs_i
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calib_cs_q
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calib_cs_gain
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calib_ampl_ref
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Crosstalk calibration compensates for electrical
+		crosstalk observed by the photodiode. To measure
+		crosstalk, the emitter light must be blocked from
+		reaching the photodiode.
+
+		The "in-phase" component signal value read from
+		in_proximity0_phase_i shall be written into
+		in_proximity0_calib_cs_i when calibrating crosstalk.

So reading this I'm thinking these are actually just applied as offsets?
Now I assume the device applies them internally which in terms of IIO
makes them calibbias attributes applied to the relevant channels.

in_proximity0_calib_cs_i -> in_intensity0_i_calibbias
in_proximity0_calib_cs_q -> in_intensity0_q_calibbias
in_proximity0_calib_cs_gain =-> in_intensity0_calibscale (I think the cs will effect intensity?)



+
+		In a similar way, the "quadrature" component signal
+		value read from in_proximity0_phase_q shall be written
+		into in_proximity0_calib_cs_q when calibrating
+		crosstalk.
+
+		The gain read from in_proximity0_hardwaregain shall
+		be written into in_proximity0_calib_cs_gain when
+		calibrating crosstalk.

I'm not following this one, hardwaregain is usually a write
parameter.  So should be under control of the userspace.

+
+		As the crosstalk is dependant on the emitter current,
+		the amplitude read from in_proximity0_amplitude shall
+		be written into in_proximity0_calib_ampl_ref when
+		calibrating crosstalk.

This last one is trickier from the description.  Do we know how it
is applied by the hardware?  Is it a simple offset?

Looking at the document an1724.pdf this doesn't seem to be something
that it necessarily makes any sense to expose to userspace. It is
a calibration that has no external inputs - just a sequence of
internal actions. Hence I would just do this on power up.

+
+		Get those values from hardware and show them when read
+		from.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calib_phase_temp_a
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calib_phase_temp_b
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calib_phase_amb_a
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calib_phase_amb_b
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calib_distance_ref
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calib_temp_ref

Hmm. So these last two are C in the equation.

+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		The sensor is able to perform correction of distance
+		measurements due to changing temperature and ambient
+		light conditions. It can be programmed to correct for
+		a second order error polynomial.
+
+		Phase data from in_proximity0_phase has to be
+		collected when temperature read from in_temp0_raw and
+		ambient light read from in_intensity0_raw are
+		modulated independently.
+
+		Then a least squares curve fit to a second order
+		polynomial has to be generated from the data. The
+		resultant curves have the form ax^2 + bx + c.
+
+		From those two curves, a and b coefficients shall be
+		stored in in_proximity0_calib_phase_temp_a and
+		in_proximity0_calib_phase_temp_b for temperature and
+		in in_proximity0_calib_phase_amb_a and
+		in_proximity0_calib_phase_amb_b for ambient light.
+
+		Those values must be integer between 0 and 8355840
+		inclusive.

I would imagine the are scaled? or the distance is going to be awfully
large!

+
+		Finally, the c constant is set by the sensor in
+		function of in_proximity0_calib_temp_ref and
+		in_proximity0_calib_distance_ref values.
+
+		To fill in_proximity0_calib_distance_ref, a distance
+		measurement at a known distance has to be made.  The
+		result of the substraction between the known distance
+		and the measured value shall be stored in
+		in_proximity0_calib_distance_ref. The sensor
+		temperature at the time of this measurement read shall
+		be stored in in_proximity0_calib_temp_ref.
+
+		Get those values from hardware and show them when read
+		from.

I'm slightly less bothered by getting these perfect as they are very
chip specific and generic userspace code is unlikely to play with them.
We may want to revisit these in the future...

If we are using phase and intensity channels as suggested above,
these will want adjusting to take that into account.

+
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_driver_range
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+                Set the current DAC scale when written to. The value
+		must be an integer between 0 and 255 inclusive.
+
+		Get this value from hardware and show it when read
+		from.

I'm not sure what this one is...  Firstly range is used to mean
something else in IIO, this is simply amplitude of a square wave on
an output channel

out_altcurrent0_raw


+
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_emitter_offset
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+                Set the emitter voltage measure offset when written
+		to. The value must be an integer between 0 and 255
+		inclusive.
I assume this is what goes in Emitter DAC?

If so it's a current offset and has well defined scale.

Treat the emitter as an output current channel and all this becomes
simpler.

+
+		Get this value from hardware and show it when read
+		from.
-- 
2.7.4

