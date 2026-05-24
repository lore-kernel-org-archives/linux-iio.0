Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFB73955E9
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 12:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779625807; cv=none; b=fLUEnGeC+k09pdcYNJ9aOltLPy9lA1kA00MTxkUYjczerC6ggoyknBbqF9kkEOqrXisdKTpf4K4GWJ11PUj6WJNFD2PbdGZUt7lP8R4xnnewlUlMzoED4T5OmnPvgI3qYMbax3SFHoLrHB+zmZ9wYfi4D0KLKkcwXVvluzE8F1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779625807; c=relaxed/simple;
	bh=ERoTsAxoECnJLoZkCdSBrxZOe8Upzt4O9Uj+YfgixCw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWVCniRdFr7swBYd3wnrVcjoKhed8GPIbO4jBkzKvGPqcr3rSHhLYGYPRltFstD8YdAN5aNS/9bLP33uSP/Pb0hJoERbB9DQeINTCpjldMXKLE/nD4wTWPVnQKkjJq6CmxpRGfDqdTjIjdAeA/+b0vm3xfDj6Ql6IWSLlLLRcGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNjesyUx; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNjesyUx"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49056b9f04aso11105305e9.0
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 05:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779625803; x=1780230603; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T1o+DvC19PR6GkTpTccEfjTify4jzFt0w17PhEVHA98=;
        b=fNjesyUxCwzSP6/O1jV8L47nm3Lc8Rb3gKfxQztn+6mSVAn7FXb8Rz7msnnsH07K0M
         GIr6IkNtzF+VPW4hCYyLy77k5+C0YiS4Qcj/G4Dtv0dLevVnaUz4laIPGVh2uek3p963
         b2PDIRvK+Z4WLlJH88vrrRFJsmXj7wsImj9wP+eLi16vtmHg0uiy3GCEeSPC5UxtSsnL
         EaqldWS6jq4Q4D8pgj5v/LWSrAnzlsJ0KHU/DOxC0fmxcIgroo49EAFiAAm+7ouKBUnC
         qfBBFdo5mdOdpEG4DJwJVweteUneN9sAlEa25HKkLOZqidGjFGj33EPTBJlWcGjyBF2x
         Fj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779625803; x=1780230603;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T1o+DvC19PR6GkTpTccEfjTify4jzFt0w17PhEVHA98=;
        b=jZx4JTfYIYefdRhxZ3mDdwvT4y6S2c+iqKMM8dNGmLI3NYFvAUNdI059hXoxGYfGx+
         wFSlJYwEBRYKdvNmcH2qj1ylE+ZxR7ILK2QxMDqTNcNzMJZbXojx7hsOKNSrwyw6tRBI
         M0v0xy0w9ekYhFXy1wZ32jiuh7PsJgL/n3q0kl/SCnxKNd0dAU/Twe+KOseaHTLFv0qs
         UBVCPTEmKTnZizBZ0yhyFhKr8j3d42CasBXhVZ2MzoRpzAF/fcscK/CDpVbFv8u+LZF0
         DpN5Dv5G4pdvkLQ73YUB1oQqjZDUL895zXPS6a0IaZnadxKH8sG30ddIR1nS7s+MKAmx
         JdMg==
X-Forwarded-Encrypted: i=1; AFNElJ87qfHCjdIVEq5FCyAacSAEqaH3XUQIe7rnmnA/iRFTtmw4pAkngGh2uQUg1b6uChQi26MBV4i9QQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2QEhg0iIi3Go2OEZkEhhxyHugOxttQq0jD5ANUlEv7TUSat+9
	R3qfuKeoRjjFUvMmLUu1+EZ0TtwCX6StKa73tjcHmnIfCdjHKa0gGNnU
X-Gm-Gg: Acq92OGia1GS40/poMioMnlUM/WfE/Zz9bUV0olt5/t62109DPuumpMAg/QiiId4aS+
	6UrEc7z5PIhNDjKMyfCtR17Ps5s21Wzn+y+yIlT3Z1OtUvKcw5BAAKZ4KBmwbQjk0ZxPvsCSJeN
	ldZsQgePKO67UR6Hwby5f7K95vaLeCJQJBNDjVAGMcXDUN/h/Whff4+1+WuQ0sGhpTSS0viNfvB
	S61Cei0oYBZvnMruaI34CXsrkVYpAj6tsip4PaGdLftpS0Vgwc5y9i9yfeke0vl5ypwq3dVBBii
	VyHcbglDsW7E0wH5SxFj7LXP2QSC0uwbH8dLBLduSBPMPlmdG89DndDb4husq4EFsWfKW5OaqHI
	Y3zHogCOL26cJ1bRsZhsypGgrNUh9YJb1zVW0C/i52aD96OVpfbrv1M4vG6BzyCTweMVsahmkUR
	JSEvFWVelIfCLu8kmUHBoe2C2+65iUiiHhdIEIOMOFpw4V1vtZ5ngndKJElQS7wboqaQdtsZgvN
	J3peGSheyZ6vjKvmLh9DiP+2S4po7YFArYh0n24fB0/DZ7viracQ5lq33uT
X-Received: by 2002:a05:600c:3547:b0:48f:e6b9:c740 with SMTP id 5b1f17b1804b1-490428f30bcmr180656565e9.30.1779625803084;
        Sun, 24 May 2026 05:30:03 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490424aa561sm84023815e9.5.2026.05.24.05.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 05:30:01 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Sun, 24 May 2026 13:29:59 +0100
To: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v14 10/12] iio: frequency: adf41513: features on
 frequency change
Message-ID: <ivren25tav5pgaynyrsujqo5zqfp4l52wu7jtlk5cotc62vbjs@nop6xcq6gjyj>
References: <20260524-adf41513-iio-driver-v14-0-06824d9c15f4@analog.com>
 <20260524-adf41513-iio-driver-v14-10-06824d9c15f4@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260524-adf41513-iio-driver-v14-10-06824d9c15f4@analog.com>

On 26/05/24 11:15AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Bleed current is not computed or updated when switching from Integer-N to Fractional-N mode if the PFD frequency remains unchanged.
> --
> 
> commit 299bd27511dd5b2a2354c749631d53bcff158e2b
> Author: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> iio: frequency: adf41513: features on frequency change
> 
> This commit adds bleed current configuration, lock detector window adjustments,
> and phase resync support to the ADF41513 driver when changing the PFD
> frequency.
> 
> > diff --git a/drivers/iio/frequency/adf41513.c b/drivers/iio/frequency/adf41513.c
> > --- a/drivers/iio/frequency/adf41513.c
> > +++ b/drivers/iio/frequency/adf41513.c
> 
> [ ... ]
> 
> > +static void adf41513_set_bleed_val(struct adf41513_state *st)
> > +{
> > +	u32 bleed_value, cp_index;
> > +
> > +	if (!(st->regs[ADF41513_REG6] & ADF41513_REG6_BLEED_ENABLE_MSK))
> > +		return;
> 
> [ ... ]
> 
> > @@ -630,6 +725,14 @@ static int adf41513_set_frequency(struct adf41513_state *st, u64 freq_uhz, u16 s
> >  		st->regs[ADF41513_REG6] |= ADF41513_REG6_BLEED_ENABLE_MSK;
> >  	}
> >  
> > +	if (pfd_change) {
> > +		adf41513_set_bleed_val(st);
> 
> [Severity: High]
> Will the bleed current be properly configured if the device switches
> from Integer-N to Fractional-N mode without changing the PFD frequency?
> 
> In adf41513_set_bleed_val(), if the device is previously in Integer-N mode,
> ADF41513_REG6_BLEED_ENABLE_MSK is cleared. If the PFD frequency changes
> while in Integer-N mode, adf41513_set_bleed_val() returns early without
> updating the register.
> 
> If a subsequent frequency change switches the PLL to Fractional-N mode but
> maintains the exact same PFD frequency, pfd_change will be false. Since
> adf41513_set_bleed_val() is only called when pfd_change is true, the bleed
> value configuration gets skipped entirely.
> 
> Could this leave the bleed circuit enabled with a stale or uninitialized
> current value, potentially preventing the PLL from locking?

This make sense. After adding the suggested guard for bleed enabled I should
have move adf41513_set_bleed_val() to be called bellow...

> > +		adf41513_set_phase_resync(st);
> > +	}
> > +
> > +	if (pfd_change || mode_change)
here..
> > +		adf41513_set_ld_window(st);
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260524-adf41513-iio-driver-v14-0-06824d9c15f4@analog.com?part=10

At least, that would be a quick one. We can have another round of reviews on
the decimal parse function... worst case, we can have another week.

-- 
Kind regards,

Rodrigo Alencar
