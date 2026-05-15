Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A875949550E
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 15:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778858922; cv=none; b=gSU+DqJwmDUd4+AFC2rUwtE8kz7bNrV+ZWAI+3IQCNglIrKU8zJKo+E+btJuIPjgI8BYwd1qMiLD0sWfwsCbVexIxw7Uv2EzLdHHRjczozJBcgV6cGhqo2NCQ0/uvG9SVEn2rPFn6gXTI8o2VPcH/KzzRTY+/hZddedL5KY8x/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778858922; c=relaxed/simple;
	bh=9Yh5Rv/5NTveSKLIFpJb2uAp/Hs1/EpekiXV1I3jm5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLwhRgkBLOIcJ3zbq/kcQ3eEgQgIR7VSMiRdnNxDcnEIn9/WQKOpntshctJmFghpLogLn0YEcPDXk4Oujg5dm2rl70MA2uEubViTntdcgeu2aNPgd95WL044DTEsTMGlblMZ7hlGjOrbWXad6gsFjGCplJP4BKNzBudoGgRHTuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkiuvzzT; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkiuvzzT"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bd3d7c29b4dso516601466b.2
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 08:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778858919; x=1779463719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4aHjUz6BqcPUtuPTSYRX/Wrmbz9WV9jZg68a5nWa4X0=;
        b=WkiuvzzTIAgzCrW6Ug14NleN6DTHB30bhgTwWXpTMeiDgNS3+vfMoB/fsR6C0jGac/
         wRxlWuv/Zn7h7wvf3qSIXFFLZhwvHIb1wWM7HZF6ZyDvdUB7oeuxCHIotWhlwaskW1P3
         4R7xq6TDiO1mhPA1vNMwmXMKX17PstzcQ5ruPXzEIxrnuAzu2ErCsRS0lHa5nP2f59Tc
         i1MFO4gom5ZOqHUr1uBIscUnjrUnr6qgJ3JIERKnzJ64Z9u9LvjK0FAw39R7qN/JAtz8
         EBO/4GP23DAc4SeANhvRtljFj6zYSdRVALigRYnhGxeHy5Y1D1RP5ZJmNMmz77MpXXON
         MKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778858919; x=1779463719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4aHjUz6BqcPUtuPTSYRX/Wrmbz9WV9jZg68a5nWa4X0=;
        b=MXYaTlrqSgaa0OPxkjKOhsb0fdIeiYhKFMmWaa3v1hJ1uJ+gtNZ4Tz+g9qxi7uqCTG
         wb6Es26g6cywKEnnPHDpwjzBk1w7snQV3c/Cks54HJxdCIRpCR/BZ559wcVQQD/qhocZ
         9o4Ow2mXRppugNxz/zGp+Aqc6URT1o07VSh1JHiIKDFMqYEPYJyO4lEbu1AgYrpOS6dP
         wOR9qZqUqqXTHJDfJ54ySPnzU1wW6kaOJoN2n+PvCdUnY26FTbpx9vJAd4lNG+UYge1G
         jLqmsMDEwmh5fUmgLEW+6uRW6Bt5LWB7rVAem7G+bkOnkZxGPQqPnj2jO1KdUg9VUelE
         XzcQ==
X-Forwarded-Encrypted: i=1; AFNElJ+13oRe8WkwpMZclQV8XZyQaTLbymgPZZWvJu3NrSoV7IkMDNsSADWgdyUb/pIsxXKhG4wfSBg21sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL8vvTPfSVobWIIqmQ9+zzVp7S5/gqQkhwYWQBuiSMCPOl79A9
	XCzZ2YygUKCbsWdecgKx4ceXoFFRQjgNQNx8H2U79xfUo+YqaVTGnnU/
X-Gm-Gg: Acq92OGsHoCkFQz4v7/gs3pAH0V8INT/9eZlPv7yMJjnywPe0VbJ3Dpa34FRLQjSlCg
	sfoCIjLnndHmDJGYmp25ak05wYIO01ds8RNVs4AAOLqI6wS7vFPuDxQVTFJW66pYFmkc4hLX/VV
	0SozTIHiAk1W1+UrVyXkdFkHdJs8LaPZ3kuqfLcMuWKXN4oiC8BRJh8N5UUYQukTKKlKj6yzVMR
	X8VErtaZ2XtR7VvghdLfAycyZ1NiCkAeXTHPSh4+jgryihEJw4eC6V0Fn4sG8ZCEK8ElAbr9KZc
	Tooqh+48WBfaCViPu+ETOXGHoFv1AYMCf22OIKJIWFtG2vTT1rv5UNmui8bomraVS7pphaNZbyZ
	xxm4hhZH3klx3qprYCWQB3r3132832ILvuWvaBwYU0tmTQT5p+47EKJxx1rsN6c0KRq4xRXBccw
	==
X-Received: by 2002:a17:906:ba84:b0:bc2:70ca:c41e with SMTP id a640c23a62f3a-bd51791d078mr261330066b.25.1778858918659;
        Fri, 15 May 2026 08:28:38 -0700 (PDT)
Received: from fedora ([2a02:8071:50c5:5c0::6182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4bd1bc9sm249989066b.9.2026.05.15.08.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 08:28:38 -0700 (PDT)
Date: Fri, 15 May 2026 17:28:36 +0200
From: Wadim Mueller <wafgo01@gmail.com>
To: William Breathitt Gray <wbg@kernel.org>
Cc: conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, 
	conor.dooley@microchip.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linusw@kernel.org, brgl@kernel.org
Subject: Re: [PATCH v3 2/3] counter: add GPIO-based quadrature encoder driver
Message-ID: <s5xt3l6fy2vp6qvk66qdywccp5w2gv3sfksufxxybytstsuunh@b3th2uqk56jd>
References: <20260501200749.20029-3-wafgo01@gmail.com>
 <20260515054819.302445-1-wbg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260515054819.302445-1-wbg@kernel.org>

Hi William,

thanks a lot for the very thorough review -- this was really
helpful. I went through all your points and addressed them in v4
which i will send shortly as a follow-up to this thread (in-reply-to
the v3 cover).

A short rundown so you can already see what to expect:

  - gpio_qenc_function enum dropped, priv stores enum counter_function
    directly, function_read/write are now trivial accessors.
  - priv->count is now u64 and ceiling defaults to U64_MAX in probe,
    so ceiling == 0 is a real "ceiling of 0" again, not a sentinel.
  - update_count rewritten direction-first, with proper saturation
    at 0 / ceiling, +/-1 per transition.
  - CREATE_QE_STATE(prev_a, prev_b, curr_a, curr_b) macro plus a
    single 16-entry X4 transition table; the delta == 2 path is gone,
    the table just has 0 in those slots.
  - ISR switches use default: instead of listing every ignored case.
  - The "enabled" flag in the ISRs is dropped. Gating happens via
    enable_irq/disable_irq anyway and enable_read derives the state
    from irqd_irq_disabled(irq_get_irq_data(priv->irq_a)) so there
    is only one source of truth.
  - enable_write simplified: no !!, assign directly, two branches
    split by return.
  - events_configure() removed (was no-op).
  - Synapses: A and B keep the full action list including
    FALLING_EDGE; Index gets its own list with only NONE and
    RISING_EDGE.
  - action_read restructured: default to NONE, Index handled as
    early return, per-function switch. X1_A and X1_B now report
    RISING_EDGE when going forward and FALLING_EDGE when going
    backward, as the COUNTER_FUNCTION_QUADRATURE_X1_{A,B} semantics
    say.
  - All generic Count functions supported now: INCREASE, DECREASE,
    PULSE_DIRECTION, QUADRATURE_X1_{A,B}, QUADRATURE_X2_{A,B},
    QUADRATURE_X4.
  - Index migrated to the COUNTER_COMP_PRESET + PRESET_ENABLE pair,
    the custom "index_enabled" COUNTER_COMP_COUNT_BOOL is gone. The
    Index ISR loads preset into count when preset_enable is set,
    like intel-qep does.
  - signal_read: the !gpio guard is gone; the Index synapse is only
    registered in probe when an index GPIO is actually wired, so no
    zombie entries.
  - cnts is now a single-element array (priv->cnts[1]) and
    counter->num_counts uses ARRAY_SIZE(priv->cnts). To not trigger
    checkpatch's "deprecated flexible array" warning the array is
    not the last field of the priv struct anymore.
  - The Count is renamed from "Position" to "Count".

About the COMPARE/FLOOR components and the OVERFLOW/UNDERFLOW/
THRESHOLD/DIRECTION_CHANGE events you suggested: i would prefer to
send those as a separate series on top of this one, once it lands,
so the diff size for the initial driver stays in a reviewable shape.
I will announce that as a follow-up in the v4 cover letter.

While at it i also picked up Krzysztofs note from v2 on the const
scalar parameters -- v3 only had the Acked-by from Conor on the
binding and no code changes, so the const scalars were still in v3.
They are gone in v4.

If anything from above is not what you had in mind please tell me,
i will fix it in v5.

Thanks again for the time,

Wadim
