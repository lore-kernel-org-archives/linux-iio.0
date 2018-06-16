Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:54844 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752814AbeFPRN6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 16 Jun 2018 13:13:58 -0400
Date: Sat, 16 Jun 2018 18:13:55 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Mathieu Othacehe <m.othacehe@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de
Subject: Re: isl29501 and multiple calibration registers
Message-ID: <20180616181355.769b990e@archlinux>
In-Reply-To: <87wov5id5w.fsf@gmail.com>
References: <87a7snd8r7.fsf@gmail.com>
        <876037dc4f.fsf@gmail.com>
        <20180603153833.0710bc03@archlinux>
        <87o9gpbkpc.fsf@gmail.com>
        <20180610142909.278028c5@archlinux>
        <87wov5id5w.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 11 Jun 2018 16:57:31 +0200
Mathieu Othacehe <m.othacehe@gmail.com> wrote:

> Hi Jonathan,
> 
> I'll send a v3 as a separate patch, here are some answers to your
> comments.
> 
> > I'm not totally clear what this is.  From a really quick look at the
> > docs, I think we are looking at in phase and quadrature elements
> > of the amplitude.  As the amplitude is basically a light intensity
> > measurement  
> 
> That's my understanding too, I'll rephrase.
> 
> >
> > in_intensity0_q_raw
> > in_intensity0_i_raw
> > in_intensity0_scale if it is possible to relate this anything real
> > I think in reality it does have a unit, we just have no visibility
> > of what that is.  
> 
> Ok.
> 
> >
> > We also have a phase measurement, but naturally only one of htem
> > in_phase0_raw
> > in_phase0_scale  
> 
> Does that mean adding a new iio_chan_type "IIO_PHASE"?

Yes, it rather looks like we need it.

> 
> > Hmm. Thinking more on this, we could treat this as a separate channel.
> > Given it's light intensity it would be an intensity channel.
> > It's in some sense the combination of the split quadrature elements
> > above
> > in_intensity0_raw
> > in_intensity0_scale.  Note for these that the scale is assumed by
> > most userspace code to be fixed, so you'll need to roll the exponent
> > part into the _raw value not the _scale.#  
> 
> Seems fine!
> 
> > in_proximity0_calib_cs_i -> in_intensity0_i_calibbias
> > in_proximity0_calib_cs_q -> in_intensity0_q_calibbias
> > in_proximity0_calib_cs_gain =-> in_intensity0_calibscale (I think the cs will effect intensity?)  
> 
> Ok.
> 
> > +		The gain read from in_proximity0_hardwaregain shall
> > +		be written into in_proximity0_calib_cs_gain when
> > +		calibrating crosstalk.
> >
> > I'm not following this one, hardwaregain is usually a write
> > parameter.  So should be under control of the userspace.  
> 
> The sensor has an "Automatic Gain Control" (AGC) which sets the analog
> signal levels at an optimum level by controlling programmable gain
> amplifiers according to the datasheet.
> 
> The AGC value in an output of the sensor at it is supposed to be
> saved when calibrating crosstalk in "Crosstalk Gain" registers.
> 
> Would it be ok to use hardwaregain as a read-only register for this
> purpose?

I'm not really keen on doing that (as hardware gain has a well defined
different meaning).  This is a rather opaque device specific value.

> 
> >
> > +
> > +		As the crosstalk is dependant on the emitter current,
> > +		the amplitude read from in_proximity0_amplitude shall
> > +		be written into in_proximity0_calib_ampl_ref when
> > +		calibrating crosstalk.
> >
> > This last one is trickier from the description.  Do we know how it
> > is applied by the hardware?  Is it a simple offset?
> >
> > Looking at the document an1724.pdf this doesn't seem to be something
> > that it necessarily makes any sense to expose to userspace. It is
> > a calibration that has no external inputs - just a sequence of
> > internal actions. Hence I would just do this on power up.  
> 
> No I don't know how it is applied. However, it can't be done on power up
> as it requires the emitter to be blocked from reaching the photodiode.

This is interesting as it's specifically documented as requiring no external
actions.  Oh well, another clear datasheet.

> 
> I guess the principle here is to measure the amplitude of the received
> signal while the emitter is blocked so that it can be substracted to the
> further measures. Would it be ok to use in_intensity0_calibbias for it?

For the control parameter yes if it meets the ABI description, for the value
during calibration no.  Calibbias is a control parameter not an output.

> 
> > +What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calib_distance_ref
> > +What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calib_temp_ref
> >
> > Hmm. So these last two are C in the equation.  
> 
> Seems so (the sensor is computing the C from those two).
> 
> > +		Finally, the c constant is set by the sensor in
> > +		function of in_proximity0_calib_temp_ref and
> > +		in_proximity0_calib_distance_ref values.
> > +
> > +		To fill in_proximity0_calib_distance_ref, a distance
> > +		measurement at a known distance has to be made.  The
> > +		result of the substraction between the known distance
> > +		and the measured value shall be stored in
> > +		in_proximity0_calib_distance_ref. The sensor
> > +		temperature at the time of this measurement read shall
> > +		be stored in in_proximity0_calib_temp_ref.
> > +
> > +		Get those values from hardware and show them when read
> > +		from.
> >
> > I'm slightly less bothered by getting these perfect as they are very
> > chip specific and generic userspace code is unlikely to play with them.
> > We may want to revisit these in the future...
> >
> > If we are using phase and intensity channels as suggested above,
> > these will want adjusting to take that into account.  
> 
> 
> Those calib fields would become:
> 
> in_proximity0_calib_temp_ref -> in_temp0_calibbias
> in_proximity0_calib_distance_ref -> in_proximity0_calibbias

These are kind of fine, as they are the linear offsets.  Doesn't
really match well with the quadratic term though.

> 
> It would also require a new channel "in_intensity1_raw" for the ambient
> light output. Is it ok?

That one is fine.

> 
> > Treat the emitter as an output current channel and all this becomes
> > simpler.  
> 
> Ok.
> 
> Thanks for your patience,

You are welcome, this is a fiddly device!  Sane hardware would store
all these in on chip flash, but I guess it's a cost thing to not do so.

> 
> Mathieu

Jonathan
