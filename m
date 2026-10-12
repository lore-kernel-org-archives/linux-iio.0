Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8A137269A
	for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 02:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791773787; cv=pass; b=JPwUSVlFEz6oISdDIR1cYz40LJqhahDrgGauuZ6kYxMqKUF8c7/cyAUY5tnok/YfUWlbcYrJKDUxejZT0cj96HvxBY9dhUxEBnIBZK8y4Imsm4ozQ7sIMIObVSy9tnopYVWzloFVjWhXHD0Ch6h5nB8WQRiQUWwnZTn51kp/qks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791773787; c=relaxed/simple;
	bh=bBf7rkKS0FdNhJYMpvvZuNwTaVC4mSM3v4npQa5GPIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PRFmkdIDzTNmj9kL1P+kB7M65ih09Qq1Ft8yXHYod1u/vuwfUN5sP4LdpipGfUYJW5Kcm3JCLf1JvjN22s8R9Jwx7RE34truAL5E/sKwlmIny8k3EeQ06FCwySTht42uRjauygwoJi38oY+HyYmQiZH1KpGOpiFt/AGlZk0fH1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyUQ4eWo; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyUQ4eWo"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc4c7fab7b6so790397a12.0
        for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2026 19:56:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791773785; cv=none;
        d=google.com; s=arc-20260327;
        b=ceVJ4KQQdDtKcIQxd/fN0OXDlLGaiPSMbgpDktbTPNt69MIiGgwO3T0yKfKE45g2Dj
         SvRMCRr/OWIGXxpj5E3KlvNWCtGxgYkUAT2RlRmt2Yr4uUgUD9uXiwRWF9k6n1CvCkOX
         WOMqh7fHOtjP2BHtRuvSwZ37RRqCklD2pNx/QXvb3+wGkD3vPK+V47EQTOQlOud8RyQ3
         2mGM59A7mDXq8buMmUEuEy1+D8QmrjiRMXYFC0J2y1DNIjnPogoAZFFVJVgkqxK3xp1v
         1OrSKS2Q3oIr4kTcYHe+UVhfsJgVX6i9bNvY4gubGsPOclv6u1NsYGtKJDsHuUwnSAtD
         gd/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bBf7rkKS0FdNhJYMpvvZuNwTaVC4mSM3v4npQa5GPIs=;
        fh=zT/ovBEzB+AX8XVwG7RXnTjYLnW8Rm0ZPF/DUf1axbo=;
        b=ZvX373k3OxsBAPpc00c0Y3I1teZwAiMIz8ruKXwSgraNuNMQfTjKDsOCLHlMowF0iS
         vfKyi+pJ7+SL3kyCLBvmkRBpVdGy4DfG5FQQvuQ/Thdb/xRaartUPsLjpiNaX4VUdDR2
         p6WROQJkC1gic71UwhzY1v3oE5kHmyWc7ItOOZeeihH484mWXr3e0V1FUbwknzv8nJV0
         wZiXZxrkZ0fO4cPUfKbPaD5EenEHVb+sbZRdWLekinjeQX4krXDks08cWoKeiKAz9gx1
         gH5BhNmzkj87df+rPnhnMx8SVFnxaPoi3gLsN+rmsYdBwTCkCy7QdFl+5uRAwSxSyB7n
         +7rQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791773785; x=1792378585; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bBf7rkKS0FdNhJYMpvvZuNwTaVC4mSM3v4npQa5GPIs=;
        b=jyUQ4eWoHRPK30DCGpJqnEeqZKHCOCxdmepZWIrD4Lmr5R9BrMq+J94YTXCQnIfBmJ
         kLDYBoRqPTQq7LHvC+H5PfXLYOjZhiVgEzBgwMDyZFtB/zfiJD0pU/3LFRGaUyvYx/Rh
         jfykSRLuEaRcXs/nSRAY5/LWRCh0ZMASmoLa4GqxZHOORy/brOplYHVCS4k1UmMJ7ws/
         1yyC0BGrYvL28e6z2L+xnytX6NoMKFk5qgl+/h3xvdY2r5eEOs3bGo5FiO2EDBOxA2UN
         RpIfum1TWO52//i4qlhiPhfvmfq0EdWf1sPFhD2qxFZCqgi8MIMkOdFN+fizMQ8OXkZ1
         D6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791773785; x=1792378585;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bBf7rkKS0FdNhJYMpvvZuNwTaVC4mSM3v4npQa5GPIs=;
        b=EJXCE66YF5dkGKYS2ixHa0ZNuBmBO9yza5x8PrhVHRNJZlN/HGQJ5Dx+g0KBkYpoKI
         VNJ/MLPw9ug9gEL7BEIe2so2PidefTMJWH/0+8+s8OK7JzOyPtyZaJRHVLDj94AJfiFN
         TNBNZsBbfefgLaS9U/rV7u0yLp6X+Fdz7Dk6fQbP3mYVgZMVC367ECYx1kaVcYPIsdu6
         JuuWkgIEQM7t1zKMazY83gPo+fopaJC89haR3y7+P+saEVnay0Rfa6r0LmcdZCWiFX2k
         5LpDmi+Fmo9ruPMPNBbmwVIa9omKzdxteu5JgnovJVAch/dRPJtCs/DKWv1nzXnMbYac
         aVyA==
X-Forwarded-Encrypted: i=1; AKwUvBzEHrNTgv42PSii+9AEz+vgGxLTMR2BNmUd89C1VIIKKOtY3VbiFWTmaoiAoMo+pFe57+uHNBoUon8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJKEoqgOMUJOIdvSUSxvYU0rgwGRDzIGAYTQ3F/41rnLxdsvnON
	NShTi7XYlpzOHa0Q0CS/8ZbPhH8cVX6Gz90aswXVmtsmAE6QBfB6/0fyWzGzeXQvridkHtcyYxj
	ms3EVwy8dhqFpM95ec8tyxK6ohRHYZxU=
X-Gm-Gg: AYBFou0FbARkjEqyQZvS7XicBOyJbWupgLOSihDBWh2mo9B2Xyg/cq/AVHrwdMbd5/7
	PUwyVUR2ZaM3UhgO/y9Z/ME77OhiAeEtM6EQi1lCyXymAVyvsVgv9HV5MC5zrliDF2Q6He71Qmw
	kY3oPEH4hnjO2KT3FAGCWFCZSLjIGOI2afvT9m8Xqua7h24phgmf3VkpeQFoOw43B+YTasXxmsh
	MqkvsZgFQogEP4VovjNKchx6dZYKMDRtMtemBVdw8oLaNdORV/49K8L03BCvjDTlI2BdbPVBDBU
	lQhSksQJrtfd/SNQAKxctSRd2B75td6F3k8iVFMRHTQLRuYuWwyQOHy+0oi37fAgQLx34fsrR7i
	7Snc15zAiwkJYnvhUKtDafUjXgCGOFtJxVO8u1wLHMFj40R7CaDh1ATQCm4M2M1w2/XA=
X-Received: by 2002:a05:6a21:6494:b0:3dd:85aa:452d with SMTP id
 adf61e73a8af0-3e16be318d5mr6655235637.31.1791773784673; Sun, 11 Oct 2026
 19:56:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011051924.60456-1-jain.sm@gmail.com> <20261011051924.60456-2-jain.sm@gmail.com>
In-Reply-To: <20261011051924.60456-2-jain.sm@gmail.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Mon, 12 Oct 2026 09:56:13 +0700
X-Gm-Features: AclHuK9HjP5BrunROTbTOyyi6-il-VsiuOisXbzNImZPrg21DQwgJ-cb2yVPcfM
Message-ID: <CAABR9nHpreWy28kYXssUCtHr9w97fvK78sEEetriwVFBV6Kchg@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: magnetometer: mmc35240: leave cache-only mode
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
>

Note that the wrong ordering in mmc35240_resume() predates afc8e3ee8307;
the sync in cache-only mode just happened to work before,
and afc8e3ee8307 only exposed it.
So the Fixes tag might better point to the commit that introduced the
resume handler:

553a776b7908 ("iio: magnetometer: mmc35240: Add PM sleep support")

Best regards,
Phuc
