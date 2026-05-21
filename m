Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31473BED1E;
	Thu, 21 May 2026 11:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779362905; cv=none; b=tTMSY3jmBbjvaroudUBwLx08X1lSETnA4xXzye8TsyDoMVMC/r2K1f+2NnbK6L72MYSAWqyIw5L92PjzUfgOP9hICuo7Swlu641kLhjqDbCNhNp1fxz7fgBT/UXAkN3Gy0fLQv2iJewZa/QQ0KKbuWeLiVOjMr8QsoVZ5C+CxKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779362905; c=relaxed/simple;
	bh=wAuohOwvEir9xVG7P7eczB/XtYVOHLUlpLH01diejXM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I7bc4lTkSUWvPZ/4B5fz7jaWgkohDw9sbqNThDwSkX0ExRYxB9gkYn3pA62uom/TCj9qYubdN+UQb/MPV/i0Fm7tqkMwff5SM9h6JUrrv1QH1hw/PshqrFrRRLAV/DJtqPj6jruq1PllwJwZj8F/CyrRstkKWygorN2+nQjrF+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7qUW34H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7qUW34H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0271E1F00A3F;
	Thu, 21 May 2026 11:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779362903;
	bh=q9eDyGKnxJnsoZQ2iQmk1/xPAqo+itJbeMoIZ6q+594=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=E7qUW34HwpEMhYL+n9L5MaiOP2O9x6v2c2anM1XEVU8+pEi39+4s2OzIVmEU5U3/G
	 M8wZ6ZcchEpi6H/jAFiEbPmJ7NSwlivAPlhMU/6oLY5gFxkECRayBItmZ4GI9xORP1
	 hvaEBrqXCvmIL9XD4yJ2ODh6DhTsU737qujDdqKXtZxPyUinmeotTqxCINZrmDYz1H
	 YUbjMGiZX8gPaSu7OJzbay5sqpTMh7X0PyIMFpgOuhO/z08+xExAK8aDXymVKxSTEV
	 zeIw2im0kk0LjzLUMu/Tt0OUtElJrbi8qK8uGdGOI6vR7ZXhIBQHHb+JUeQ5CVSkay
	 T7iP0Y9QxjrcA==
Date: Thu, 21 May 2026 12:28:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Erim, Salih" <salih.erim@amd.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, git@amd.com,
 nuno.sa@analog.com, andy@kernel.org, dlechner@baylibre.com,
 michal.simek@amd.com, conall.ogriofa@amd.com, erimsalih@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] iio: adc: versal-sysmon: add threshold event
 support
Message-ID: <20260521122812.76a3487a@jic23-huawei>
In-Reply-To: <85c06df0-7cdf-4273-b033-9ec9dcd5781c@amd.com>
References: <20260502111951.538488-1-salih.erim@amd.com>
	<20260502111951.538488-5-salih.erim@amd.com>
	<20260504184415.7b6688f5@jic23-huawei>
	<59884fdc-a9d0-49c6-8167-11d56a21dd11@amd.com>
	<20260520103708.24d59b6b@jic23-huawei>
	<85c06df0-7cdf-4273-b033-9ec9dcd5781c@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 00:15:12 +0100
"Erim, Salih" <salih.erim@amd.com> wrote:

> Hi Jonathan,
> 
> Thanks for the detailed guidance on the ABI constraints.
> I have studied a bit more and have a suggestion inline.
> 
> On 20/05/2026 10:37, Jonathan Cameron wrote:
> 
> > 
> >   
> >>>> +static int sysmon_write_event_value(struct iio_dev *indio_dev,
> >>>> +                                 const struct iio_chan_spec *chan,
> >>>> +                                 enum iio_event_type type,
> >>>> +                                 enum iio_event_direction dir,
> >>>> +                                 enum iio_event_info info, int val, int val2)
> >>>> +{
> >>>> +     struct sysmon *sysmon = iio_priv(indio_dev);
> >>>> +     unsigned int reg_val;
> >>>> +     u32 mask, shift;
> >>>> +     u32 raw_val;
> >>>> +     int offset;
> >>>> +     int ret;
> >>>> +
> >>>> +     guard(mutex)(&sysmon->lock);
> >>>> +
> >>>> +     if (chan->type == IIO_TEMP) {
> >>>> +             if (info == IIO_EV_INFO_VALUE) {
> >>>> +                     offset = sysmon_temp_thresh_offset(chan->address, dir);
> >>>> +                     if (offset < 0)
> >>>> +                             return offset;
> >>>> +                     sysmon_millicelsius_to_q8p7(&raw_val, val);
> >>>> +                     return regmap_write(sysmon->regmap, offset, raw_val);
> >>>> +             }
> >>>> +             if (info == IIO_EV_INFO_HYSTERESIS) {
> >>>> +                     mask = (chan->address == SYSMON_ADDR_OT_EVENT) ?
> >>>> +                             SYSMON_OT_HYST_BIT : SYSMON_TEMP_HYST_BIT;
> >>>> +                     shift = (chan->address == SYSMON_ADDR_OT_EVENT) ? 0 : 1;
> >>>> +                     if (val & ~1)  
> >>>
> >>> Just to confirm - this only has hysteresis values of 0 or 1?  That's unusually
> >>> small given hysteresis should be in same units as _raw.  
> >>
> >> You're right, this is wrong. The current code exposes a mode-select
> >> bit from ALARM_CONFIG (0 = window mode, 1 = hysteresis mode), not an
> >> actual hysteresis value.
> >>
> >> The hardware has independent upper and lower threshold registers for
> >> each temperature alarm (DEVICE_TEMP and OT), plus a mode bit in
> >> ALARM_CONFIG that selects between window mode (alarm on crossing
> >> either threshold) and hysteresis mode (upper triggers, lower clears).
> >> Since the hardware has a single alarm bit per temperature channel,
> >> even in window mode you can't distinguish which threshold was
> >> crossed. Hysteresis mode maps naturally to the IIO event model.
> >>
> >> I'll rework this as follows:
> >> - Hard-code ALARM_CONFIG to hysteresis mode during init (both
> >>     DEVICE_TEMP and OT)
> >> - Expose hysteresis as a writable value in millicelsius, stored in
> >>     the driver
> >> - Keep both rising (upper) and falling (lower) thresholds writable  
> >   
> >> - Couple the three attributes:
> >>       Write rising    -> recompute lower = upper - stored_hysteresis
> >>       Write falling   -> update stored_hysteresis = upper - lower
> >>       Write hysteresis -> recompute lower = upper - new_hysteresis
> >> - Read hysteresis returns the stored value
> >>
> >> This keeps full user control over both thresholds while exposing
> >> hysteresis as a proper temperature value, matching IIO semantics.
> >> Window mode support could be added later if needed without ABI
> >> changes.
> >>  
> > Not quite because that falling attribute is not in line with the ABI.
> > 
> > This needs a little hammering to fit in the oddly shaped hole of our ABI.
> > 
> > If you are sticking to hystersis only (not window mode) then you need
> > to expose it as rising threshold + hysteresis (not falling threshold as
> > there is no even triggered in that direction - unless you are doing something
> > nastier like triggering on both edges of the interrupt - in which case this
> > is very similar to window mode and for both event directions you'd need
> > to set the hysteresis to the difference between the threshold values).
> > 
> > If you do want to do window mode - that would be fine but you'd need
> > to then do a falling event where the enable sets the hysteresis reported
> > to 0.  Whether a write to hysteresis would then fail or we'd disable the
> > falling direction would need some discussion - the ABI doesn't constrain
> > that so it's a case of what is less likely to confuse a user.
> > 
> > Jonathan  
> 
> Understood. I'll go with pure hysteresis mode - no falling threshold.
> 
> The hardware has a single ISR bit per temperature channel (REG_ISR
> bits 8 and 9) that only tells us the temperature is "outside the
> threshold(s)," with no indication of direction.

For that we have a vague event with direction IIO_EV_DIR_EITHER.
Not the nicest of interfaces though as requires userspace to be
a little careful, in the case where there is shared event but
separate enables.

Anyhow, I'm happy not supporting it ;)

> In hysteresis mode
> the alarm asserts when temperature exceeds the upper threshold and
> clears when it drops below the lower, so the event is strictly
> rising, and the lower threshold is just the re-arm point.
> 
> So the event spec becomes a single entry with everything on
> IIO_EV_DIR_RISING:
> 
>      { IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING,
>        ENABLE | VALUE | HYSTERESIS }
> 
> giving thresh_rising_value, thresh_rising_en and
> thresh_rising_hysteresis. The pushed event will also use
> IIO_EV_DIR_RISING.
> 
> Hysteresis will be stored in millicelsius and initialized from
> the hardware registers at probe as (upper - lower). Writing the
> rising threshold or hysteresis recomputes the lower register
> internally. ALARM_CONFIG will be hard-coded to hysteresis mode
> during init.
> 
> Window mode can be added later without ABI breakage by introducing
> a IIO_EV_DIR_FALLING entry and enabling it would switch the hardware
> mode.
Perfect.

J
> 
> Salih
> 
> 

