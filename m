Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81323AEF20;
	Wed, 20 May 2026 09:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779269841; cv=none; b=OrKPjvUS4Vmd5zEowYsHQVY3pel30Z2T9uoOQA0gIYYrwH+muXXA/I91JZXM0g0DfPvjx/3f3in/SJNqsEQly9es5MBj2rkEjcsHaRtThwvpy3REKWsWWWln/zrUv5dLUMtrvqpBjJpuTOwCgyKlgcwWdEdXGEslP1TCpUtFFaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779269841; c=relaxed/simple;
	bh=FjA0lJigCLTNTws0AFg9xGOERjUY5/4BnVnS3AznamI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jZZ9kdneYkFUNRW4cpDzDWNsKcRtkFK5q9ojHdq3RFLPw+kqqBZdJos+mG3DU/1X83DBt0ztks2yw9Bre4O3MNh3IkkAuQky93jIb1mGc2L2aYJwPCaWqmwI077xcjhz7nQizYN0uvcViLbqBMqJI7Z0rR3ryP1at/egCrgLvoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVMM58rK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVMM58rK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482BD1F00894;
	Wed, 20 May 2026 09:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779269839;
	bh=IWslf9oeLWvEs3JsbwralhudzzXn6+q2Z6VbOV+CaT8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PVMM58rKloa/G8Ow05xXHZDMW8Ox3iqRdSL4ekaV58jjNQ94ULrjBKZByXEq6xj8M
	 F7YZM6GjfwjRh2onvA3bwS9mKhDpNse8n+O5FH3DTXdV1tZW6mpXoD35w6A8n0ofc6
	 0HVxKMExEnQUtBHTouKW8ZrDP9xu4VujRq+g0HZqVm2c3MA2QBml8VwicX3IMC6HZ6
	 Dmo1kCHryxjFl+Jo2yEpglixmxKRt8g3RamDrQpHMNHqFjo96R5P7xeAgIhgKqy+uO
	 +BnnrdAsrDAMBEvDZFLy/qjiMizi5n7dXWs4/Q2tYkBnIs0dyNdTEFz0NAfZG4d0c9
	 40xNbhwzOSxlQ==
Date: Wed, 20 May 2026 10:37:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Erim, Salih" <salih.erim@amd.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, git@amd.com,
 nuno.sa@analog.com, andy@kernel.org, dlechner@baylibre.com,
 michal.simek@amd.com, conall.ogriofa@amd.com, erimsalih@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] iio: adc: versal-sysmon: add threshold event
 support
Message-ID: <20260520103708.24d59b6b@jic23-huawei>
In-Reply-To: <59884fdc-a9d0-49c6-8167-11d56a21dd11@amd.com>
References: <20260502111951.538488-1-salih.erim@amd.com>
	<20260502111951.538488-5-salih.erim@amd.com>
	<20260504184415.7b6688f5@jic23-huawei>
	<59884fdc-a9d0-49c6-8167-11d56a21dd11@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> >> +static int sysmon_write_event_value(struct iio_dev *indio_dev,
> >> +                                 const struct iio_chan_spec *chan,
> >> +                                 enum iio_event_type type,
> >> +                                 enum iio_event_direction dir,
> >> +                                 enum iio_event_info info, int val, int val2)
> >> +{
> >> +     struct sysmon *sysmon = iio_priv(indio_dev);
> >> +     unsigned int reg_val;
> >> +     u32 mask, shift;
> >> +     u32 raw_val;
> >> +     int offset;
> >> +     int ret;
> >> +
> >> +     guard(mutex)(&sysmon->lock);
> >> +
> >> +     if (chan->type == IIO_TEMP) {
> >> +             if (info == IIO_EV_INFO_VALUE) {
> >> +                     offset = sysmon_temp_thresh_offset(chan->address, dir);
> >> +                     if (offset < 0)
> >> +                             return offset;
> >> +                     sysmon_millicelsius_to_q8p7(&raw_val, val);
> >> +                     return regmap_write(sysmon->regmap, offset, raw_val);
> >> +             }
> >> +             if (info == IIO_EV_INFO_HYSTERESIS) {
> >> +                     mask = (chan->address == SYSMON_ADDR_OT_EVENT) ?
> >> +                             SYSMON_OT_HYST_BIT : SYSMON_TEMP_HYST_BIT;
> >> +                     shift = (chan->address == SYSMON_ADDR_OT_EVENT) ? 0 : 1;
> >> +                     if (val & ~1)  
> > 
> > Just to confirm - this only has hysteresis values of 0 or 1?  That's unusually
> > small given hysteresis should be in same units as _raw.  
> 
> You're right, this is wrong. The current code exposes a mode-select
> bit from ALARM_CONFIG (0 = window mode, 1 = hysteresis mode), not an
> actual hysteresis value.
> 
> The hardware has independent upper and lower threshold registers for
> each temperature alarm (DEVICE_TEMP and OT), plus a mode bit in
> ALARM_CONFIG that selects between window mode (alarm on crossing
> either threshold) and hysteresis mode (upper triggers, lower clears).
> Since the hardware has a single alarm bit per temperature channel,
> even in window mode you can't distinguish which threshold was
> crossed. Hysteresis mode maps naturally to the IIO event model.
> 
> I'll rework this as follows:
> - Hard-code ALARM_CONFIG to hysteresis mode during init (both
>    DEVICE_TEMP and OT)
> - Expose hysteresis as a writable value in millicelsius, stored in
>    the driver
> - Keep both rising (upper) and falling (lower) thresholds writable

> - Couple the three attributes:
>      Write rising    -> recompute lower = upper - stored_hysteresis
>      Write falling   -> update stored_hysteresis = upper - lower
>      Write hysteresis -> recompute lower = upper - new_hysteresis
> - Read hysteresis returns the stored value
> 
> This keeps full user control over both thresholds while exposing
> hysteresis as a proper temperature value, matching IIO semantics.
> Window mode support could be added later if needed without ABI
> changes.
> 
Not quite because that falling attribute is not in line with the ABI.

This needs a little hammering to fit in the oddly shaped hole of our ABI.

If you are sticking to hystersis only (not window mode) then you need
to expose it as rising threshold + hysteresis (not falling threshold as
there is no even triggered in that direction - unless you are doing something
nastier like triggering on both edges of the interrupt - in which case this
is very similar to window mode and for both event directions you'd need
to set the hysteresis to the difference between the threshold values).

If you do want to do window mode - that would be fine but you'd need
to then do a falling event where the enable sets the hysteresis reported
to 0.  Whether a write to hysteresis would then fail or we'd disable the
falling direction would need some discussion - the ABI doesn't constrain
that so it's a case of what is less likely to confuse a user.

Jonathan


> > 
> > Also similar to above, I'd split the two cases and use FIELD_PREP()  
> 
> This block will be replaced by the hysteresis rework described above.
> 
> Best regards,
> Salih
> 
> 
> >   
> >> +                             return -EINVAL;
> >> +                     return regmap_update_bits(sysmon->regmap,
> >> +                                               SYSMON_TEMP_EV_CFG,
> >> +                                               mask, val << shift);
> >> +             }
> >> +     } else if (chan->type == IIO_VOLTAGE) {
> >> +             offset = sysmon_supply_thresh_offset(chan->address, dir);
> >> +             if (offset < 0)
> >> +                     return offset;
> >> +             ret = regmap_read(sysmon->regmap, offset, &reg_val);
> >> +             if (ret)
> >> +                     return ret;
> >> +             sysmon_supply_processedtoraw(val, reg_val, &raw_val);
> >> +             return regmap_write(sysmon->regmap, offset, raw_val);
> >> +     }
> >> +
> >> +     return -EINVAL;
> >> +}  
> > 
> >   
> 
> 
> 
> 

