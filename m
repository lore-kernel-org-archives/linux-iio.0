Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33881349CD2
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 10:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778580948; cv=none; b=ZDghoxDqrFVEguqSYKPI1ovWF4Uvik5J+VTszleSm6aUt0gDuhWxutwwOc6sELwdDpY3/EpDjx1pVm45nyzdlbtWCu3SvshXMfVFM8+B55Q1DHBqgChw1Ou1DSgqIF056Zsh/jIRfWusA4bot1HMbyXuE5rIhTT9dHstw96AVo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778580948; c=relaxed/simple;
	bh=b3lzpV/nHEhXzNlJd4ltoB6QZnZKLoWM/4ZHl/G1phM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brC7ktSsLSmA1tu939MaQ9gtLMKqJYAhADMyhv3an5MK6Mhi9t6ivt1/LiQZ5jCSpBVQvUbmcNaT+5cXxpFNlNitQQPL5G+BU11vQefj9M8DOpHHo9a9FbXdy5vAZLqcYk5BOnTR45MM45gYanlYC4Li/ikLzAnCTsIHc8Lpwc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Srbf5XA5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Srbf5XA5"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so90231955e9.2
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 03:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778580945; x=1779185745; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l4DAmhUOkykluCcYSzY+lcfne4sjUcOqBUxV3SjoU4E=;
        b=Srbf5XA5ULN1dvubHlxTRv6cRnhihGLf4eRdV0viIfVQkWUo2LhVspd0YV1i/zZ5CQ
         3XUo/6JcuQDtgZP+nj7cxo7ri0UJMHMrtxXCwUk2cEk9zV4w84CCe0S+2B5ZVrMBGBuR
         jMxjdNCum7lOOtnHuTByuOUXKztg2FJfZz36dvAzKeV7W8IwGbucJrm0aC/dmiq25kUX
         bJKYaXiRW3VfqZVfbSfgVspj+dNNqdnyPBaBaWxZ3rHqC23PGyf1xGUYOSwY6INYfWJ3
         V552pz8YaxMQ4y6unfzA3rhFG+Ou3aR4qYi9vqJ/fZZHsjCfq8VDmWORFjhSp5+dbWmd
         19pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778580945; x=1779185745;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l4DAmhUOkykluCcYSzY+lcfne4sjUcOqBUxV3SjoU4E=;
        b=dvvAQ6El0cOANekFqcgI7nh8+0kOhxIrCtXzx4Rxk8ZwynsUkED/0ZXTDrqqVYhtbS
         d1rz+bCIS5S16pBNM+TOEtBzs7zbE1Kn7b4+EVZgogGBdToLPX7MWyPiD/2ggtw439HS
         ePAiln/Fq06uZqZFXatdCu6tnIGUmvvIKFnd9YQJBP/c0fXwaBtSNIacVSunBuCy/zRc
         OiM3laON4M8Uk5IIPvF7QIW0w3/92Trp8reCwvIl0pT3Vnv7hBqm813kQGcI4+aoeWnv
         Rzzlmoi5ikGJymiCBr+NH8Ew0k9J+M/PqMad1RElqy9VWAv962LLfZRTSSvPRAGq10WD
         xSHg==
X-Forwarded-Encrypted: i=1; AFNElJ93eK4QeNDNr2s11t6KSwHgPn0lpDhx9nG3Y3HNlsMO+rONvkuf4cgMay2r/nPpCzV4MVWVuEZFUoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTzvZGoqaFr0EbmuvVE+FJ0do0tabiLV2JKzj0gPVmCXvivw5M
	1fbdebKmXR0+0wm9YWv7eFKA4YPSyNyAHAYe8qHImIvBYIQDwOCE9U9E
X-Gm-Gg: Acq92OHvSLSHewIJSRP3QCAPIxJxtusDmBEtnPw7vOISgkcPJyBFtT55Q39HjH7kgA0
	K0i30LJZ3wucOg5PPBGpWLlaa1tqAKBMrhWfn7lSM8XCopxtSYxbIdbcbVWHLE97AdefAI2bsNs
	SIgWJ8W5yGPVFp5i2R9z9/R3EdqcpQqaHouW2Q8qn7tN7DCGIEVDhFpJRCmZIDs22XILnmtEZ1K
	9ygErCKdXv0WEiybbBywwAKHwILPG8bNsiWBqljtPZbkxLLyZ/JLwmK2FnaB8TvgPfdJ2aMWBDk
	873qm1rOSJ5KuskkTS7imn0ii7Tm7IaVqLwBmw1+23gM0gM0LPbrYBjKyvft9E8y1TwEVu4mf0o
	qGn87aSWuVZydm25YFZzf/lyL66EE0g6shn0PBlUqg1uAXcFCvoHCRyzEvhG7ZHk4ju9Jg9rlEP
	qiAgQmCVKGxDf2XWsdAfI71PIh5Oa2Obaw5TCbbbcjx0KyFLgv0lIGzDshPkwRuP5yd+S7X98C6
	dQswvZ4yIQ6WrAPO1Dg2CYy1SWNUQ2bti5D/ykoltPGcEjcSQ==
X-Received: by 2002:a05:600c:8115:b0:48a:9540:1a3a with SMTP id 5b1f17b1804b1-48e51e196f9mr451438005e9.8.1778580942345;
        Tue, 12 May 2026 03:15:42 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f43c31dsm14752775e9.25.2026.05.12.03.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 03:15:41 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Tue, 12 May 2026 11:15:39 +0100
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rodrigo Alencar <rodrigo.alencar@analog.com>
Subject: Re: [PATCH v12 07/11] iio: frequency: adf41513: driver implementation
Message-ID: <svusdjojnunrgjuojwk3htqdudzesnc2owfd5wmbvp56ap22oq@7nr6p7fpozin>
References: <20260510-adf41513-iio-driver-v12-7-34af2ed2779f@analog.com>
 <20260511224355.6ED49C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260511224355.6ED49C2BCB0@smtp.kernel.org>

On 26/05/11 10:43PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> - [High] Hardware state is lost if system suspend occurs while device is powered down.
> - [High] `adf41513_calc_fixed_mod` uses uninitialized `regs_hw` cache during probe, causing an incorrect initial output frequency.
> - [High] Arithmetic underflow in `adf41513_calc_fixed_mod` causes valid frequency configurations to fail with `-ERANGE`.
> - [Medium] The phase adjustment bit (`ADF41513_REG2_PHASE_ADJ_MSK`) is set but never cleared, causing unintended phase shifts on subsequent frequency updates.
> - [Medium] Software state is permanently modified before SPI write succeeds, causing a state mismatch on SPI failure.
> --

So those seem to be new issues.

> > +static int adf41513_calc_fixed_mod(struct adf41513_state *st,
> > +				   struct adf41513_pll_settings *result)
> > +{
> > +	u64 resolution_uhz = div_u64(result->pfd_frequency_uhz, ADF41513_FIXED_MODULUS);
> > +	u64 target_frequency_uhz = result->target_frequency_uhz;
> > +	u64 freq_error_uhz;
> > +	u32 int_val, frac1;
> > +	bool lsb_p1_offset = !FIELD_GET(ADF41513_REG5_LSB_P1_MSK, st->regs_hw[ADF41513_REG5]);
> 
> During setup, st->regs_hw is initialized to 0xFFFFFFFF to force a full write
> on the first sync.
> 
> Since regs_hw is all 1s, lsb_p1_offset will evaluate to false here, but the
> true intended configuration in st->regs has this bit as 0.
> 
> Will this cause the algorithm to skip subtracting the offset while the hardware
> actually adds it? Should this check read from st->regs[ADF41513_REG5] instead?

That makes sense and we can use st->regs instead of st->regs_hw. This is unlikely to
happen because during setup() we are often going for integer-n mode. Also the
resolution error of f_pfd/2^26 is very minimal for this initial configuration,
userspace can adjust the value later at runtime if relying on fixed-modulus mode.
However this is something I would want to fix...

> [ ... ]
> 
> > +	/* compute frac1 and fixed modulus error */
> > +	frac1 = mul_u64_u64_div_u64(freq_error_uhz, ADF41513_FIXED_MODULUS,
> > +				    result->pfd_frequency_uhz);
> > +	freq_error_uhz -= mul_u64_u32_div(result->pfd_frequency_uhz, frac1,
> > +					  ADF41513_FIXED_MODULUS);
> > +
> > +	/* check if freq error is within a tolerance of 1/2 resolution */
> > +	if (freq_error_uhz > (resolution_uhz >> 1) && frac1 < (ADF41513_FIXED_MODULUS - 1)) {
> > +		frac1++;
> > +		freq_error_uhz = resolution_uhz - freq_error_uhz;
> 
> The resolution_uhz calculation uses div_u64(), which truncates the true
> frequency step.
> 
> Because of this truncation, is it possible for freq_error_uhz to be strictly
> greater than resolution_uhz here?
> 
> If so, does the unsigned subtraction resolution_uhz - freq_error_uhz underflow
> and produce a large value that falsely triggers the -ERANGE error below?

This is also something we can fix. Nice that this was caught... it is a hard one.

> [ ... ]
> 
> > +static int adf41513_set_frequency(struct adf41513_state *st, u64 freq_uhz, u16 sync_mask)
> > +{
> > +	struct adf41513_pll_settings result;
> > +	int ret;
> > +
> > +	ret = adf41513_calc_pll_settings(st, &result, freq_uhz);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* apply computed results to pll settings */
> > +	st->settings = result;
> 
> [ ... ]
> 
> > +	if (st->settings.mode == ADF41513_MODE_INTEGER_N) {
> > +		st->regs[ADF41513_REG6] |= ADF41513_REG6_INT_MODE_MSK;
> > +		st->regs[ADF41513_REG6] &= ~ADF41513_REG6_BLEED_ENABLE_MSK;
> > +	} else {
> > +		st->regs[ADF41513_REG6] &= ~ADF41513_REG6_INT_MODE_MSK;
> > +		st->regs[ADF41513_REG6] |= ADF41513_REG6_BLEED_ENABLE_MSK;
> > +	}
> > +
> > +	return adf41513_sync_config(st, sync_mask | ADF41513_SYNC_REG0);
> > +}
> 
> If the adf41513_sync_config() SPI write fails, st->settings and st->regs
> have already been updated with the new configuration.
> 
> Will a subsequent read of the frequency channel via adf41513_pll_get_rate()
> return this failed frequency instead of the actual physical hardware frequency?

Not seeing much problem with that. Reversing the state on every spi write failure
would be too much effort for an error that is already reported to the user.
Most likely another spi write attempt might fail as well, so would it be a platform
problem?

> [ ... ]
> 
> > +static int adf41513_write_raw(struct iio_dev *indio_dev,
> > +			      struct iio_chan_spec const *chan,
> > +			      int val, int val2, long info)
> > +{
> 
> [ ... ]
> 
> > +	case IIO_CHAN_INFO_PHASE:
> > +		if (tmp64 >= ADF41513_MAX_PHASE_MICRORAD)
> > +			return -EINVAL;
> > +
> > +		phase_val = DIV_U64_ROUND_CLOSEST(tmp64 << 12,
> > +						  ADF41513_MAX_PHASE_MICRORAD);
> > +		phase_val = min(phase_val, ADF41513_MAX_PHASE_VAL);
> > +		st->regs[ADF41513_REG2] |= ADF41513_REG2_PHASE_ADJ_MSK;
> > +		FIELD_MODIFY(ADF41513_REG2_PHASE_VAL_MSK,
> > +			     &st->regs[ADF41513_REG2], phase_val);
> > +		return adf41513_sync_config(st, ADF41513_SYNC_REG0);
> 
> The ADF41513_REG2_PHASE_ADJ_MSK bit is set in the software shadow register,
> but does not appear to be cleared after the shift completes.
> 
> Because the hardware evaluates the PHASE_ADJ bit in REG2 on every REG0 write,
> could this cause unintended phase shifts during future frequency updates?

We don't need to clear that, if phase adjust is set then the phase shift is going
to be applied. There is no phase accumulation or side effects. I think the
datasheet could improve on that, but later on it says:

	The phase word in Register 2 controls the RF output phase. As this
	word is changed from 0 to 2^12, the RF output phase changes over a
	360° range in steps of phase value × 360°/2^12.

> [ ... ]
> 
> > +static int adf41513_pm_resume(struct device *dev)
> > +{
> > +	struct adf41513_state *st = dev_get_drvdata(dev);
> > +
> > +	guard(mutex)(&st->lock);
> > +	if (st->powerdown)
> > +		return 0; /* nothing to do */
> > +
> > +	return adf41513_resume(st);
> > +}
> 
> If the system cuts power to the regulators during sleep, the chip wakes up
> in its default Power-On Reset (POR) state.
> 
> If st->powerdown is true, this function returns early and st->regs_hw is
> not invalidated.
> 
> Could this leave the software state out of sync with the physical hardware,
> causing future partial writes to leave the chip unconfigured?

That is not an issue because partial writes would not power the device.
Also the resume() function makes sure to write all registers so a power-up
sequence is completed.

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260510-adf41513-iio-driver-v12-0-34af2ed2779f@analog.com?part=7

-- 
Kind regards,

Rodrigo Alencar
