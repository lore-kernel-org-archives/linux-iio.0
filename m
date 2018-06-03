Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:39400 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751228AbeFCOig (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 Jun 2018 10:38:36 -0400
Date: Sun, 3 Jun 2018 15:38:33 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Mathieu Othacehe <m.othacehe@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: isl29501 and multiple calibration registers
Message-ID: <20180603153833.0710bc03@archlinux>
In-Reply-To: <876037dc4f.fsf@gmail.com>
References: <87a7snd8r7.fsf@gmail.com>
        <876037dc4f.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 28 May 2018 17:38:08 +0200
Mathieu Othacehe <m.othacehe@gmail.com> wrote:

> 
> Hi Jonathan,
> 
> Thanks for you answer, it seems fine to me to use IIO ABI when possible
> and extend it with iio_chan_spec_ext_info for exotic calibration
> registers.
> 
> Here is a proposal for sysfs-bus-iio-isl29501 document. Would it be ok?

Hi Mathieu,

It is always somewhat hard to work out how to fit new requirements into
the overall ABI of IIO.  In general a more detailed explanation is needed
(particularly as the datasheet is less than detailed on some of this).

Also don't repeat generic attribute documentation.

The exponent / (presumably) mantissa split in some of these is a pain,
as we really don't want to have userspace have to figure out how
those are related.  They really need to be 'one' value.  The fun bit
is that sometimes the exponent is shared so we will need to find
the best value for all the controlled parameters.

Jonathan

> 
> Thanks,
> 
> Mathieu

> The ISL29501 is a Time of Flight (ToF) based signal processing
> integrated circuit. The sensor enables long range optical distance
> sensing when combined with an external emitter and detector.
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-isl29501 | 230 +++++++++++++++++++++++
>  1 file changed, 230 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-isl29501
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-isl29501 b/Documentation/ABI/testing/sysfs-bus-iio-isl29501
> new file mode 100644
> index 0000000..6f18f13
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-isl29501
> @@ -0,0 +1,230 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_raw
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +                Get the distance from the obstacle in meters. The
> +                distance is an integer between 0 and 65535.

Please don't define elements that are already covered by standard ABI and are
docuemnted in the sysfs-bus-iio files or similar.

All we end up with is two different documents which can get out of sync
with each other causing confusion.


> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_noise_approximation
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +                Get the measurement noise approximation in meters.
> +		The approximation is an integer between 0 and 65535.

This needs more information.  From that I have no idea what the noise
approximation is?  Standard deviation of the noise perhaps?
Some other statistical measure?

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_magn0_raw
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +                Get the magnitude of the received signal in nA.
> +		The magnitude is an integer between 0 and 65535.

No, that stomps over existing attributes and is very confusing.  If it is
the amplitude of the signal from which we are deriving proximity by time of
flight, then I think we have some precendence though I'm struggling to
find an example right now.

It needs to show that it is an attribute related to the proximity channel.

So, something like.

in_proximity0_amplitude and it needs to be in standard units for current,
even if that requires conversion in the driver from the internal representation.

If this is something we might want to read out via the buffered interfaces, you
probably need to treat it as an entirely different sensor channel from the
proximity one and we'll need to think about that a bit more.  There is some
related work going on to define mathematical functions applied to another signal
as part of the channel type (in the energy meter drivers).  It's stalled a bit,
but would be useful here as well.
 

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/integration_time
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +                Control the length of each sample, which is equal to
> +		the time during which the optical pulse is active.

This is a standard element, don't redefine.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/integration_time_available
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +                Reading returns the list of possible integration times.
> +

Standard element of the ABI don't redefine.

> +What:		/sys/bus/iio/devices/iio:deviceX/sampling_frequency
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +                Control the sampling frequency of the sensor.
> +

standard.

> +What:		/sys/bus/iio/devices/iio:deviceX/sampling_frequency_available
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +                Reading returns the list of possible sampling frequencies.
> +

standard

> +What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calib_cs_i
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +                Set the Crosstalk I calibration value when written
> +		to. The value must be an integer between -32768 and
> +		32767 inclusive.

What is an "I" value? What is it's units?  All this stuff should be documented
here.  I'm guessing we are talking quadrature signals, but that's not
clear here.

> +
> +		Get this value from hardware and show it when read
> +		from.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calib_cs_i_exp
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +                Set the Crosstalk I calibration exponent value when
> +		written to. The value must be an integer between
> +		0 and 255 inclusive.

This sounds like we have two different attributes for the same actual number.
Can we combine them and deal with the exponent internally?

> +
> +		Get this value from hardware and show it when read
> +		from.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calib_cs_q
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +                Set the Crosstalk Q calibration value when written
> +		to. The value must be an integer between -32768 and
> +		32767 inclusive.
> +
> +		Get this value from hardware and show it when read
> +		from.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calib_cs_q_exp
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +                Set the Crosstalk Q calibration exponent value when
> +		written to. The value must be an integer between
> +		0 and 255 inclusive.
> +
> +		Get this value from hardware and show it when read
> +		from.

Again, sounds like we ought to be able to figure out how to split the exponent
and mantissa.  Afterall any userspace calibration code is going to have
to do this anyway so it can't be that hard :)

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calib_cs_gain
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +                Set the Crosstalk gain value when written to. The
> +		value must be an integer between 0 and 65535
> +		inclusive.
> +
> +		Get this value from hardware and show it when read
> +		from.

These all need more explanation in the descriptions.  What would userspace do
with them?  What effect do that have on the read signal?

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calib_mag_ref
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +                Set the magnitude reference when written to. The
> +		value must be an integer between 0 and 65535
> +		inclusive.
> +
> +		Get this value from hardware and show it when read
> +		from.

Hmm. What's this one?  What is it a reference for?

I'm guessing this is the auto gain control, which has only basic documentation
on the datasheet I'm looking at..

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calib_mag_exp
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +                Set the magnitude reference exponent when written
> +		to. The value must be an integer between 0 and 15
> +		inclusive.
> +
> +		Get this value from hardware and show it when read
> +		from.

I think this is another one which can be combined with the 'value' to
get the best possible representation of whatever this should be.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_phase_offset
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +                Set the fixed distance offset calibration value when
> +		written to. The value must be an integer
> +		between 0 and 65535 inclusive.

What do these numbers represent?  Given the name I'd assume something
to do with 1/65536 of a cycle but who knows...

If so we should have better units for this.

> +
> +		Get this value from hardware and show it when read
> +		from.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_temp_ref
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +                Set the temperature reference value when written
> +		to. The value must be an integer between 0 and 255
> +		inclusive.

I'm going to assume this is a real temperature.  Please give it standard temperature
units.

> +
> +		Get this value from hardware and show it when read
> +		from.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_phase_exp
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +                Set the phase correction exponent value when written
> +		to. The value must be an integer between 0 and 15
> +		inclusive.
> +
> +		Get this value from hardware and show it when read
> +		from.

That is annoying.  Shared exponent of various different values.  Ideal is to
have the driver figure out the 'best' option accuracy wise for whatever
set of parameters we currently have.


> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_phase_temp_a
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +                Set the phase temperature A correction coefficient
> +		value when written to. The value must be an integer
> +		between 0 and 255 inclusive.
> +
> +		Get this value from hardware and show it when read
> +		from.
Please explain clearly here what this is.

ax^2 + bx + c etc

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_phase_amb_a
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +                Set the phase ambient A correction coefficient value
> +		when written to. The value must be an integer between
> +		0 and 255 inclusive.

Make it clear we are talking about amibient light here.

> +
> +		Get this value from hardware and show it when read
> +		from.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_phase_temp_b
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +                Set the phase temperature B correction coefficient
> +		value when written to. The value must be an integer
> +		between 0 and 255 inclusive.
> +
> +		Get this value from hardware and show it when read
> +		from.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_phase_amb_b
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +                Set the phase ambient B correction coefficient value
> +		when written to. The value must be an integer between
> +		0 and 255 inclusive.
> +
> +		Get this value from hardware and show it when read
> +		from.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_driver_range
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +                Set the current DAC scale when written to. The value
> +		must be an integer between 0 and 255 inclusive.
> +
> +		Get this value from hardware and show it when read
> +		from.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_emitter_dac
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +                Set the current DAC value when written to. The value
> +		must be an integer between 0 and 255 inclusive.

Hmm. We have done this in two ways in the past, either as a control signal of the
proximity or a separate output signal.  I'm not immediately sure which makes
sense here.  Probably the current output channel option like in the si1145 driver.


> +
> +		Get this value from hardware and show it when read
> +		from.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_emitter_offset
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +                Set the emitter voltage measure offset when written
> +		to. The value must be an integer between 0 and 255
> +		inclusive.
> +
> +		Get this value from hardware and show it when read
> +		from.
> \ No newline at end of file

Add one to clean this up.

> -- 
> 2.7.4
> 
