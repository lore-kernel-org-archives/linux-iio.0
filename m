Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48730 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752598AbaBYU5p (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 25 Feb 2014 15:57:45 -0500
Message-ID: <530D03F4.2080400@kernel.org>
Date: Tue, 25 Feb 2014 20:58:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
CC: mporter@linaro.org, lars@metafoo.de, pmeerw@pmeerw.net,
	denis.ciocca@st.com, maxime.ripard@free-electrons.com,
	mranostay@gmail.com
Subject: [RFC] IIO: New interfaces for 'interesting' channel types.
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is a resend from earlier today as it never seems to have reached the list.
Sorry to anyone who gets it twice...

Hi All

We have had a couple of new interface discussions buried in the reviews
of drivers.  Specifically the quaternion rotation interface and the pulse
capture interface.  In some ways as will become apparent below these are
related.

I'm summarising the options here in an attempt to get some more discussion
going.

Firstly, the quaternion interface.  Quaternions require 4 components to
be presented together in order for any meaning to be extracted.  Thus it
makes no sense to ever present their components separately.  To this end
a new interface is proposed in which all 4 components are presented as
a space separated list.  Whilst I welcome comments on this, the actual
question I am raising here concerns not what is presented, but the way we
indicate that this is what is to be expected.

Two obvious options exist as we have two places this type could be
'represented'.  Either we introduce a new channel type - rotquaternion
which is defined to be a rotation expressed as a quaternion, or we take
the existing channel type rot and apply a modifier (similar to an axis
modifier) to indicate that rather than being a rotation about a given
axis, we have a rotation represented as a quaternion.  This would be done
with a new modifier.  To illustrate the point, lets take a few example
sysfs attributes.

Option 1. New channel type

in_rotquaternion1_raw
in_rotquaternion1_scale

Option 2. New modifier.

in_rot1_quaternion_raw
in_rot1_quaternion_scale

Next lets take the ecap driver and it's pulse characteristic measurement
interface.  Here we have a single underlying thing (the waveform) about
which we wish to measure a number of elements.  Again, we can either do
this via new channel types, or via modifiers. Note there is precedence for
using index numbers to indicate that multiple measurements are being taken
via the same physical wire of different things.

Option 1. New Channel types (I'm making the naming up as a go along - the
aim here is generality to other things we might measure and time intervals
are more general than 'pulse' or similar types)

in_interval1_high_raw  (time pulse is high)
in_interval_scale

in_interval1_low_raw (time pulse is low)

in_interval_risingtorising_raw (period measured rising edge to rising edge)
in_interval_fallingtofalling_raw (period measured falling to falling)


in_interval_rising_raw (rise time of waveform).
in_interval_falling_raw (fall time of waveform).

in_voltage_peaktopeak_raw (peak to peak voltage).  We actually have
interfaces in place for this sort of stuff.

Option 2 - modifiers for everything. (this is what I suggested in -
http://www.spinics.net/lists/linux-omap/msg103204.html

in_waveformX_hightime_raw
in_waveformX_lowtime_raw
in_waveformX_period_raw
in_waveformX_markspace_raw
in_waveformX_peaktopeak_raw
in_waveformX_risetime_raw
in_waveformX_falltime_raw

Personally my thinking has changed since my ecap related email.
I think we want to keep the channel types to be strictly what quantity
is being measured and rely on shared index numbers to indicate that
we are dealing with multiple measurements of a given 'channel'.

Hence I slightly favour option 1.  However the reason I'm sending this
RFC is I definitely want more input on this decision from other regular
IIO developers (and anyone else!).  I'm particularly interested in
cases that people don't think are cleanly covered by the proposed options.
I've picked a few people to poke via ccing them, but please do send this
on to anyone else you think might contribute to the discussion.

It's going to tie us to a large body of ABI moving forwards.
My apologies to Matt and Srinivas for the fact your drivers have gotten
caught up in this, but we need to get it right.

Whilst we are talking interface reviews.  Another one I proposed recently
was spherical coordinates for position measurements.  The main reason
for this is that it gives a unified way of indicating distance from sensor
as

in_position_r_raw

There are also magnetic position sensors that report in full spherical
coordinates so we may want the other elements down the line.
I'm kind of regretting letting the generic 'proximity' interface in now.
Those are measuring something related to distance, but material dependent
so I'm not too bothered if we introduced another similar interface.
Anyone comments on this would be great as well as I'd like to get the
lightning sensor merged sooner rather than later!

I hate my webmail, but then its better than doing it on my mobile phone..

Thanks

Jonathan
