Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43435 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbaB0HTe (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 27 Feb 2014 02:19:34 -0500
In-Reply-To: <201402262158.35883.manuel.stahl@iis.fraunhofer.de>
References: <530D03F4.2080400@kernel.org> <201402262158.35883.manuel.stahl@iis.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [RFC] IIO: New interfaces for 'interesting' channel types.
From: Jonathan Cameron <jic23@kernel.org>
Date: Thu, 27 Feb 2014 07:19:23 +0000
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>,
	linux-iio@vger.kernel.org
CC: mporter@linaro.org, lars@metafoo.de, pmeerw@pmeerw.net,
	denis.ciocca@st.com, maxime.ripard@free-electrons.com,
	mranostay@gmail.com
Message-ID: <6b7669f9-4a2a-44c4-8785-70fd07ac0bcd@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On February 26, 2014 8:58:35 PM GMT+00:00, Manuel Stahl <manuel.stahl@iis.fraunhofer.de> wrote:
>Hi Jonathan,
>
>thanks for the very good presentation.
>
>
>> Firstly, the quaternion interface.  Quaternions require 4 components
>to
>> be presented together in order for any meaning to be extracted.  Thus
>it
>> makes no sense to ever present their components separately.  To this
>end
>> a new interface is proposed in which all 4 components are presented
>as
>> a space separated list.  Whilst I welcome comments on this, the
>actual
>> question I am raising here concerns not what is presented, but the
>way we
>> indicate that this is what is to be expected.
>> 
>> Two obvious options exist as we have two places this type could be
>> 'represented'.  Either we introduce a new channel type -
>rotquaternion
>> which is defined to be a rotation expressed as a quaternion, or we
>take
>> the existing channel type rot and apply a modifier (similar to an
>axis
>> modifier) to indicate that rather than being a rotation about a given
>> axis, we have a rotation represented as a quaternion.  This would be
>done
>> with a new modifier.  To illustrate the point, lets take a few
>example
>> sysfs attributes.
>> 
>> Option 1. New channel type
>> 
>> in_rotquaternion1_raw
>> in_rotquaternion1_scale
>> 
>> Option 2. New modifier.
>> 
>> in_rot1_quaternion_raw
>> in_rot1_quaternion_scale
>
>I prefer option 2 since we still measure a rotation, but an axis makes
>no sense.
I suppose this also fits better against proposal of allowing spherical position coords below. There we have on distance and two angles. In conjunction they specify the position.

>I'd even propose to additionally have:
>
>in_rot1_xyz_raw
>
>to present x y and z in one single reading since a lot of sensor supply
>a measurement from the same point in time when reading out all values
>together.
Maybe... But there will be lots of combinations possible. Xz xy yz xyz

These would be sysfs only probably with the individual elements taking precedence for
 buffered output.
>
>
>
>> Next lets take the ecap driver and it's pulse characteristic
>measurement
>> interface.  Here we have a single underlying thing (the waveform)
>about
>> which we wish to measure a number of elements.  Again, we can either
>do
>> this via new channel types, or via modifiers. Note there is
>precedence for
>> using index numbers to indicate that multiple measurements are being
>taken
>> via the same physical wire of different things.
>> 
>> Option 1. New Channel types (I'm making the naming up as a go along -
>the
>> aim here is generality to other things we might measure and time
>intervals
>> are more general than 'pulse' or similar types)
>> 
>> in_interval1_high_raw  (time pulse is high)
>> in_interval_scale
>> 
>> in_interval1_low_raw (time pulse is low)
>> 
>> in_interval_risingtorising_raw (period measured rising edge to rising
>edge)
>> in_interval_fallingtofalling_raw (period measured falling to falling)
>> 
>> 
>> in_interval_rising_raw (rise time of waveform).
>> in_interval_falling_raw (fall time of waveform).
>> 
>> in_voltage_peaktopeak_raw (peak to peak voltage).  We actually have
>> interfaces in place for this sort of stuff.
>> 
>> Option 2 - modifiers for everything. (this is what I suggested in -
>> http://www.spinics.net/lists/linux-omap/msg103204.html
>> 
>> in_waveformX_hightime_raw
>> in_waveformX_lowtime_raw
>> in_waveformX_period_raw
>> in_waveformX_markspace_raw
>> in_waveformX_peaktopeak_raw
>> in_waveformX_risetime_raw
>> in_waveformX_falltime_raw
>> 
>> Personally my thinking has changed since my ecap related email.
>> I think we want to keep the channel types to be strictly what
>quantity
>> is being measured and rely on shared index numbers to indicate that
>> we are dealing with multiple measurements of a given 'channel'.
>> 
>> Hence I slightly favour option 1.  However the reason I'm sending
>this
>> RFC is I definitely want more input on this decision from other
>regular
>> IIO developers (and anyone else!).  I'm particularly interested in
>> cases that people don't think are cleanly covered by the proposed
>options.
>> I've picked a few people to poke via ccing them, but please do send
>this
>> on to anyone else you think might contribute to the discussion.
>
>Here I'm with you. Your arguments make perfectly sense for me.
>
>
>> It's going to tie us to a large body of ABI moving forwards.
>> My apologies to Matt and Srinivas for the fact your drivers have
>gotten
>> caught up in this, but we need to get it right.
>> 
>> Whilst we are talking interface reviews.  Another one I proposed
>recently
>> was spherical coordinates for position measurements.  The main reason
>> for this is that it gives a unified way of indicating distance from
>sensor
>> as
>> 
>> in_position_r_raw
>
>Why would this be a position when you actually measure distance? Can
>you give an example?

In spherical coordinates the r is merely the distance from the reference point. To do full
position you would have two angle coordinates as well.

Thanks

J
>
>> There are also magnetic position sensors that report in full
>spherical
>> coordinates so we may want the other elements down the line.
>> I'm kind of regretting letting the generic 'proximity' interface in
>now.
>> Those are measuring something related to distance, but material
>dependent
>> so I'm not too bothered if we introduced another similar interface.
>> Anyone comments on this would be great as well as I'd like to get the
>> lightning sensor merged sooner rather than later!
>
>Regards,
>Manuel
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
