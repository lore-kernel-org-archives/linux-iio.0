Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889C131DDBF;
	Sun,  6 Sep 2026 01:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788658914; cv=none; b=afK6m4y2ndeyyHOCk+Ddn/R8IjnAltuWJhvrTiBYvoo2HeZJMRUNK2TmINYbdL1oFx19LqDQcS5RlKhVtRGzxx34mb3UJcgyYoEKFUoCHnBwFVY7s9fdUyJsPOCWu2ukzlqSIXmK1iEQddHtO4HO7+EL3roFHtZLnrh92dfqq3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788658914; c=relaxed/simple;
	bh=2O+RacXOvFrI3c/esx3kGAgGB9SvD19y8B7CCse23QI=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=o9Up0EXGHNiefyZvUhKtpoBWPH8/ely0FVDuFrBDVSZumcsjuHkwIeTYLdvE6cig2H49LQGldFWqPNP/fj00y2H8NKMTPQgZkzCJxp64gRuKP59cFVoPSKAUG7VvwTN/GlSmeB8+LTJHzEicce6k6Dc6uEv6u4Az673RjUVF0ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+Xp9VNb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+Xp9VNb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22771F00A3F;
	Sun,  6 Sep 2026 01:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788658912;
	bh=7dAFwR1JyNP6aaja0q8e0iRqJWGFSNHQBJi7pTswpkQ=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Z+Xp9VNb5xUGFB8TcapSF/YMEfNYXmaN97VyFgv7MZsOyCMFKTIXZ1wtaYnUJNOvq
	 +ZWlHbZiQumrHDNoj6vEQPLmU3f2uAbd5n9HkXobZl0g4dWSmOcC1ly9/7eURaIo76
	 Cvjec3VexVNp7OjM2mDqWAbqqir86mAP5n330DGomQzAC6Eg6TblRaTYfSVPFLThC3
	 FI72o/ZRcjjOiwrHl2Taj/tDUChFX7li4MuqWsLj0CrNJL1YCIySf3HW8b7WxsvSH/
	 NlTxbKeBO4KyTRzZ4CgaCk/KCC9jinS1Z2xljaZOeVRpl4/pwMAJhybExHJ0PXthW0
	 ZCO5Wwsx3GmFg==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 09/10] iio: adc: ti-ads112c14: add settlingtime
 attribute
From: Jonathan Cameron <jic23@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Chris Hall <c-hall@ti.com>, 
 Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260904-iio-adc-ti-ads112c14-filter-support-v2-9-f86592360658@baylibre.com>
References: <20260904-iio-adc-ti-ads112c14-filter-support-v2-0-f86592360658@baylibre.com>
 <20260904-iio-adc-ti-ads112c14-filter-support-v2-9-f86592360658@baylibre.com>
Date: Sun, 06 Sep 2026 02:41:33 +0100
Message-Id: <178865889327.3402141.8340539908719039639.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5910;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=2O+RacXOvFrI3c/esx3kGAgGB9SvD19y8B7CCse23QI=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqnMTc05nom/5esrBxtqQRgMux5eDaQ5x9H2LxY
 fWvx5en40SJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCapzE3BEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiPPHD/9m/l4C+WuVf/nm3USHeNqJAeTKgelxWleHKuLim7VZbnA
 NTg3jHyFcTkxzpVnMFs0+f4+dHuu0I4D3Mu9/12zepyod2QINYNAhBOCYrp4pWqkoeKo9OX++Ur
 o460GNwnxCru6FL1QEhElZduW615mLol35seLVJXcYFMS78cBwu4AhSqqnk5Vvf2SDWkBKzNU3R
 ZLnJqYjbX9CMNcL5tcVQip0atnJHQm0Yao/ewacILcpDCyOSUvfJSw8jnAQgUgkbIX6MmA4V/4Z
 H3ZolOPnzPMfA6eb+Mz8b2WsSiC/YuDDlWB0lvvl5M3PSLm4072Zbfh6lCApfqydgTGDhBJ+vtb
 x7sB1V4CjRP3BvJcy9T8HQQYkWAovf8bODywpksCKoSLuX37aQUAM4SwcDm/tcLi5YR0++X3tNA
 44yIzzmU4aAhFr6Mnc3G7hlPiXlpRwEnDRt8C+WcJu4ARIoZxtoy96zWjUxZlyYqZRe1pYq7SDJ
 uSF2W9uFo2flQhbv4d1+zW4amEGmyox4C/gZbMaBBib1ZgokGOvSC/m972Pg8bO+NxlWS6X9BoB
 +1mjU6YFlmgnY0X2o0yo4A3vl+GABv4BQtHgMxQOrwXMe1ySSlpHpg16c7VbBDTXvV9cuMEU9IH
 6ypOAckGU+s5fwF4CXa3Ca3LJc76OIE2kKmBz5w==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Add per-channel sysfs attributes for settlingtime and
> settlingtime_available. These allow adjusting the total settling time
> for each channel. The value consists of a fixed t_latency time (based
> on the selected filter_type, oversampling_ratio and sampling_frequency)
> plus a user-configurable t_delay that determines the value to write to
> the DELAY field in the registers.
> 
> The allowable values are non-linear integer multiples, so the step size
> is just the smallest step size. Writing the attribute will match the
> closest matching value for the DELAY field with a time equal to or
> greater than the requested settling time (unless the requested time is
> larger than the maximum allowable settling time).
> 
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>

A few things in here - mostly from sashiko rather than me.

>
> diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
> index 85e926184b6e..cefbb7afe729 100644
> --- a/drivers/iio/adc/ti-ads112c14.c
> +++ b/drivers/iio/adc/ti-ads112c14.c


...

> +static int ads112c14_get_settling_time_us(struct ads112c14_data *data,
> +					  struct ads112c14_channel_state *channel_state,
> +					  u8 delay, u32 *settling_time_us)
> +{
> +	int fmod_Hz, latency_tmod;
> +	u64 total_tmod;
> +
> +	fmod_Hz = ads112c14_get_fmod_Hz(data, channel_state);
> +	if (fmod_Hz <= 0)
> +		return -EINVAL;

[Severity: Medium]
Is it possible for negative inputs to bypass this validation check on 32-bit
architectures? MICRO is typically defined as 1000000UL. If integer is
negative (e.g., -1), the calculation integer * MICRO evaluates as an
unsigned 32-bit operation, producing a huge unsigned 32-bit value.

When this is assigned to the 64-bit signed integer settling_time_us, it is
zero-extended to a large positive value, rendering the < 0 check useless
and resulting in incorrect timing delay configurations.

-
I'm not sure on this one (and too lazy to check properly).
My guess is not a problem due to bounds on values from elsewhere but
please take a look.

> +
> +	latency_tmod = ads112c14_get_latency_tmod(channel_state);
> +	if (latency_tmod < 0)
> +		return latency_tmod;
> +
> +	total_tmod = latency_tmod + ads112c14_delay_to_tmod(delay);
> +	*settling_time_us = div64_u64(total_tmod * USEC_PER_SEC, fmod_Hz);
> +
> +	return 0;
> +}
> +
> +static int ads112c14_find_delay_for_settling_time_us(struct ads112c14_data *data,
> +						     struct ads112c14_channel_state *channel_state,
> +						     s64 settling_time_us, u8 *delay)
> +{
> +	u32 fixed_latency_us, delay_us;
> +	u64 delay_tmod_needed;
> +	int ret, fmod_Hz;
> +	u8 i;
> +
> +	ret = ads112c14_get_settling_time_us(data, channel_state, 0, &fixed_latency_us);
> +	if (ret)
> +		return ret;
> +
> +	if (settling_time_us <= fixed_latency_us) {
> +		*delay = 0;
> +		return 0;
> +	}
> +
> +	fmod_Hz = ads112c14_get_fmod_Hz(data, channel_state);
> +	if (fmod_Hz <= 0)
> +		return -EINVAL;
> +
> +	delay_us = settling_time_us - fixed_latency_us;

Sashiko:

[Severity: Medium]
Can this assignment truncate large settling times? delay_us is declared as
a 32-bit unsigned integer, while settling_time_us is a 64-bit signed
integer. If userspace writes a sufficiently large time, the subtraction will
wrap around the 32-bit boundary, resulting in a short, unintended delay
instead of saturating to the hardware's maximum delay limit.

-

The input comes from val * MICRO + val2 so seems like overflow is
plausible.

> +	delay_tmod_needed = DIV_ROUND_UP_ULL((u64)delay_us * fmod_Hz,
> +					     USEC_PER_SEC);
> +
> +	for (i = 1; i < ADS112C14_DELAY_MAX; i++) {
> +		if (ads112c14_delay_to_tmod(i) >= delay_tmod_needed)
> +			break;
> +	}
> +
> +	*delay = i;
> +
> +	return 0;
> +}
> +




> @@ -814,10 +1050,12 @@ static int ads112c14_wait_for_conversion_poll(struct ads112c14_data *data)
>  	if (ret)
>  		return ret;
>  
> +	/* Give it 1ms more than calculated settling time. */
>  	return regmap_read_poll_timeout(data->regmap,
>  					ADS112C14_REG_STATUS_MSB, reg_val,
>  					FIELD_GET(ADS112C14_STATUS_MSB_DRDY, reg_val),
> -					1 * USEC_PER_MSEC, 100 * USEC_PER_MSEC);
> +					1 * USEC_PER_MSEC, settle_time_us +
> +							   1 * USEC_PER_MSEC);
Rewrap this:
					1 * USEC_PER_MSEC,
					settle_time_us + 1 * USEC_PER_MSEC);
Is nicer.
>  }
>  


> @@ -1961,6 +2239,52 @@ static void ads112c14_populate_odr_tables(struct ads112c14_data *data)
>  	available[0] = div_u64_rem(odr_uHz, MICRO, &available[1]);
>  }
>  
> +static void ads112c14_populate_settling_range_tables(struct ads112c14_data *data)
> +{
> +	s32 (*avail)[2];
> +	u32 i, j;
> +
> +	for (i = 0; i < ARRAY_SIZE(ads112c14_sinc_latency_tmod); i++) {
> +		for (j = 0; j < ARRAY_SIZE(ads112c14_fmod_div); j++) {
> +			u64 fmod_Hz = data->fclk_Hz / ads112c14_fmod_div[j];
> +			u64 start_tmod = ads112c14_sinc_latency_tmod[i][j];
> +			u64 step_tmod = ads112c14_delay_to_tmod(1);
> +			u64 stop_tmod = start_tmod + ads112c14_delay_to_tmod(ADS112C14_DELAY_MAX);
> +			s64 start_us, step_us, stop_us;
> +
> +			start_us = DIV_ROUND_CLOSEST_ULL(start_tmod * USEC_PER_SEC, fmod_Hz);

Your friendly neighbourhood Sashiko:
[Severity: High]
Does this code risk a division by zero crash during probe?

The external clock rate data->fclk_Hz is fetched without asserting that the
rate is nonzero or sufficiently large. If clk_get_rate() returns 0 (e.g. from
a faulty, missing, or zero-initialized clock in the device tree), fmod_Hz
becomes 0.

The DIV_ROUND_CLOSEST_ULL macro will then invoke do_div with a zero divisor,
triggering a hardware exception and crashing the kernel.
-

Probably should defend against this but just checking it isn't zero
when we first get it.

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
