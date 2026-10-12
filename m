Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93D831D362
	for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 02:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791773536; cv=pass; b=R8NQ7k8j0I32OAc3u4hKQyWjeA8joeZHNq+HjEAl0krlH5KzX+kGowWXZGbBRzOFwu59Qf83D8k8eXZhYE02B8TWYIc1aTBdGu3hRU5Uf6w+GDFabIjM5VqkxNl0j2p6pnxo7mQBbT+HFdpBqGTeQLfrzvQZHX9VrKEutt4BW+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791773536; c=relaxed/simple;
	bh=LzWchX4KsEIH4caQu/AQaehulhvxSRbR4oh0X/6NURc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mj59uocMRO2Et1b3ZtgehEfe/7enLwqOduBE21Gt4aDZf4DruYdUu7afhocQiL29XzjhiQFFHDIP/mtC85MVBHql9vuKspDt/fDgaKE2LY+mRp4s0a7oACDTldYHSSR1UNjf6i/5nrpf4VvElNVrHdSyYIvDCj+mSFn8qgbQ2+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2RD32nv; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2RD32nv"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-88834d30002so574030b3a.1
        for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2026 19:52:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791773535; cv=none;
        d=google.com; s=arc-20260327;
        b=mk7/iP5VW0vImrqx2rPh0as9MumeHxIjidu31rAZFeA3RdO+dUuERVQRSpCZNXJlpe
         tJ8wFSqUcgO6+OBfDwZ1FNa2UDCiHS2LJ+Q7gXYCoCyz5fQECr5fYTvUfmS+htnF6v8z
         lcZ42KJOBmRicXPY5GRBDkPs0Nn9zq44ae9xZvVZcIq7vhoK5tsZwBUrvPU237sT10Ds
         llhQvMhSJWNmE26ORIBAUpncnwuJH1R8Lu8/i2WLG77C8+CuZ4tBKR/at/OwLOgYXQ+N
         kSGO2r4nZ1Vl8Oyrha1Mb8XmnSg/wAQTe5XRaJCkszWDKrZ2xn5NpDYf9zxbj40vM8GU
         624w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LzWchX4KsEIH4caQu/AQaehulhvxSRbR4oh0X/6NURc=;
        fh=GE00afiqXxpSR3ZjEVADDaYR2w1Z5bDR4CsAS3ix80c=;
        b=j2DIsWAvcschwow8M862DQL5GvcW85LpUuryB05HKf1La73Fifr0WaLoyT49lZ+U/8
         De5SxUOh0c7BXuDhWSNvCTA96jog2ayEJ/6J1HtKvFCc1rvtX7Q18hxHc0kCB1Bvk7eo
         6diFgu6g3iD87n1CwZZREGuTR7sZB9hCOb6zbLFJWL8JcK5z1odi8I3yKiqbFIKTTlSR
         E2NdVx3u9Rws81THSIn08uzfEhbtvcWhu+k+4Jd8Rv+58pzM8LNG2JXwjCVgk6p0eyZz
         58VytDjh66HCllCNAYR4Soh2UTHbqWWVRK2+qLBe4H2Arq1amymLUb7XA00QbuilyZXI
         DluA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791773535; x=1792378335; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LzWchX4KsEIH4caQu/AQaehulhvxSRbR4oh0X/6NURc=;
        b=O2RD32nvFSCACmAB2a2ahKZAuBt3SqkBwGRNjYB5DgSzo3xzGtazuXg3eFVH0HGG7f
         e4qs5kqwTLdIuca8nWoLpZZ5/InNOUsWgracb1Nuj2mO/cvEGj1geNNt0BlcO2SPKOm2
         v3eDRf9mE7mWTYDU5bP0jCTLIrDoOwS6jPlfEdDYQIkIJubAY6ti2dt/ncnbMget7FoM
         11+dXA1vx7LXpFy9SLWL4VgsqpbCSn7FLYfvuNK4YDDvDCy3UuOKF7XRpRGUt2f1/eVx
         bnHDjrP0G8p2gurg3JobpR6UoBT1HpPsaYQlbkiv81D0ZtZP5AyOlvgJtT2WKsXgF515
         CoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791773535; x=1792378335;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LzWchX4KsEIH4caQu/AQaehulhvxSRbR4oh0X/6NURc=;
        b=1Qr84bu66vqMEXhSk+uP38vAAsgpG0SYwEW6+IZhCOq5jdFdZqei33fyXW1hild3Gx
         beQgDmohFQURQOJJadvZEXtG4q9+STtEl5r0UtxQP32gGq8Iv3z6lAO72V/1C/0By9YP
         hFW0keRsbdzLGMTDjnTmY1qqGX+5A4LHtpVUluP7+7kOnY8IMDNKWjk7tXWkaNdX7idM
         oGo5XgLQNc6Pb3VbKH4liVEVtSl1787EjYxn4uS9AwplGKuiTVmZzO6bBMI99v+xBGeH
         xBDulhm2i1Nt8xbc+yyutiLyTyuMIobmGxyNOBfe/QV9AdCtCq/o1xkMc07EukwV4MLV
         1sbg==
X-Forwarded-Encrypted: i=1; AKwUvBz6S6GG9m2vvi8fXC1FLi72bNlEzvX9PheWnNsPqzLa4Bobt4eN1pJf2Hlvm3gMHJN2uV+biDoshEo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJBi6t1+lkgXZyNuaMCuxrLUuO4glCRhtoe6mwJ8LeTtVVw4Av
	dWEm3M5DMbCXTM4umThC6fyRAp9yEevvw7T2KgphwW4elg5lQZwCwp6tzsTaH72jYrkL54qzACS
	YM5ZgunHUWFVf7NZjPw5+MhjGLrcRj58=
X-Gm-Gg: AYBFou2iUE+81HIoIEfC8cKeYMVoIRi//V+6etfzJI2WtXAsnMMMUmESK4HAOQTviap
	vpKxaLI4pMMAkzFhIdrT6QcKBGwuWTweTsmWbP1WzuysVb9MU2jc2/atGKcB8NrjN4oTuXwg40N
	lZP32xNfM3lfXXRfxH0nKIJKjqLsZlrLez0pFs+YeycSh/r8J6vvaOOAi5GmhjfrNDnctoiiOFc
	GtDY6Lw0y43JrLKDGaGIxlq1IYDtB6g6tojGO6YGxOU3S8EsW3g7om9+9XtJSQPTgM3sVPxIbR0
	hPpaOkJY2AjiarpH9Nf7lieqg+Mk0HfSzUa1nGJNkp9kwhnWhQyMX0plIGCGtm7ubyAzDWJJvki
	32YYJzLmtbfs/teeeqrjG2jS2P9e5hd+EoALaDwqKr849lRPJdFRO4ssqAsfA5TAoQk2GeqQfvh
	RRzw==
X-Received: by 2002:a05:6a00:709a:b0:899:f6e7:b6c6 with SMTP id
 d2e1a72fcca58-899f6e7bac4mr1931950b3a.40.1791773535113; Sun, 11 Oct 2026
 19:52:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011051924.60456-1-jain.sm@gmail.com> <20261011051924.60456-3-jain.sm@gmail.com>
In-Reply-To: <20261011051924.60456-3-jain.sm@gmail.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Mon, 12 Oct 2026 09:52:04 +0700
X-Gm-Features: AclHuK-BPvUlZy6fKGO0CDqbainrKzygQvr87oFj_CMEFCIi9XC7UM8Pf7ZICr4
Message-ID: <CAABR9nE2AEee6dtw_J45qmMUxfT+TJah-E7pk2Q2A27xcZVcaA@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: magnetometer: mmc5633: leave cache-only mode
 before the cache sync
To: Shashank Mohan Jain <jain.sm@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Mark Brown <broonie@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Shashank,

Thanks for the fix.

>
> Fixes: afc8e3ee8307 ("regcache: Validate cache_only state in regcache_sync_region()")
> Assisted-by: LLM
> Signed-off-by: Shashank Mohan Jain <jain.sm@gmail.com>
> ---
> Prepared with Claude Code (Anthropic), model Claude Opus 5.5
> (claude-opus-5-5).

Note that the wrong ordering in mmc5633_resume() predates afc8e3ee8307;
the sync in cache-only mode just happened to work before,
and afc8e3ee8307 only exposed it.
So the Fixes tag might better point to the commit that introduced the
resume handler:

6e5f6bf2e3f0 ("iio: magnetometer: Add mmc5633 sensor")

Best regards,
Phuc
