Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A4039C634
	for <linux-iio@vger.kernel.org>; Thu,  5 Mar 2026 12:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772714804; cv=pass; b=P3Vy/chx3zrTPzF/ZPo4UH8BPMN4yvDuRhiTd1T8wGfOhwigBH3uHXmbKRk6YQbuUQjpZ0CPXcx7dSWVQk+7WE3k9A/eE/9poK8wFvOX7UKQzG0su940EoHnTIdQxyNTgssNyj1AbeoJ3nUt3NX8qNaFnByjNq1ZhvZGxRXifHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772714804; c=relaxed/simple;
	bh=o0POkazCs+lb73dBMhowTUqc3dsqo+pbqDTEL2E/U7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvJzC7PsENEcahEqQJb3M4vbfl8r3I6W8JCYxrk96LrvrETkikRKiJTM7Dxh1dFfOK1bk+B0c0zi8vPVIPR81peZBvTKkTm3pUeY3OXG2xAtsTvehX/hTPRPZTj4U3SS7+QrTSvvbvIU2E3JvX5JZ4RGf57Yvb7qZVrzaJeREdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dY1CNL8V; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dY1CNL8V"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79898953985so39250477b3.1
        for <linux-iio@vger.kernel.org>; Thu, 05 Mar 2026 04:46:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772714802; cv=none;
        d=google.com; s=arc-20240605;
        b=K2vrGL5n/z11ZSE6gK6AsjopGO30sv7rPdBHJ1scx7Fp3sZEcxurS89wWmGlFPS0j9
         B6IB5+MuP6qS0BpKKG8YZqekEuuD0tvgSNpDasL1P49Eet2hO0qZ5M3W1dsbJq8yBmdJ
         X67WqpufwmPKiOrL2VWtTedFSz7b/DBt9yonsTtcRvHS5ARwiM5lslG22Y5KPTW6vENG
         KHOlKL1GFSy8+5ipkXhOWQcXGo1T6Fzcg4CzBjkTEUyN+9LTuqTDojJDCAPeRU27/mni
         fzeFxIJ8pNc213es4tj2oK1HJsj67EGphgw+n51Rk/p5trbQAgjJ2gMwcW5Ku83cJM0u
         Iwug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=o0POkazCs+lb73dBMhowTUqc3dsqo+pbqDTEL2E/U7g=;
        fh=ulodM5k9gAlPLjsZOvhQ1VQBCoHMApvAPnbbv3rBvI0=;
        b=HoC6i3CzcZLgTofcRnlqKMH4rk0AvIBk9FyhMea8hLd2ViN0h/Pj0WSw4ir6/2YPnl
         rJjHrZA9nT20dzMXMHCsuSGWzA0TSVSbIfYbGm7eVhWwctBiDclOoy1YYon42UGZRfxg
         WTt7VsonlsyE891/X1KvBw2VPMKrfraaJDRQNHyPT/kFU1oH3cfCx1B/7caCMzKLyC8S
         XXLqcE5W1A1UJPU8dePxaNiw5bI/yxW2cGIns2hpW4LD8sivJxUn0OqNTTCexGeQgVa5
         wgqEVaSGzIrcyAvz40ysaM3nmxeLhPSNhHGww7Vu/BJUFewSPF0Hf672he0fOy0kfFqQ
         45/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772714802; x=1773319602; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o0POkazCs+lb73dBMhowTUqc3dsqo+pbqDTEL2E/U7g=;
        b=dY1CNL8Vy5pJxr/loHCh7jy3lcHPxPVqreVG2YpdviPlfoOTkyCWHOaWzKavPxZP7N
         mFz6E8s2ZKZAXGwdHNtV+6fyYyKMt9Ed0VTaIpxHyavX/6Of58JPy7DSCWcXehpMVOaF
         kpGkZzAabE2x8EPMMeB837HxS0yNOboG9zaa3HP4k+tYTJhkhdkgpbr4iCdDtbDF+qlt
         sSoZkhPrroD+Qcx+AsjTpF5+/wBpdXWzpNkxEtmyDE38ToC6iLR9cx4u/VeihSHnb57o
         XwbFox5nFrWVLX2so9bJNCYFHYIlOPfAg868XJkQWGjvrHpCMD0bTb2Pdsyu6ln16RcO
         9uGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772714802; x=1773319602;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0POkazCs+lb73dBMhowTUqc3dsqo+pbqDTEL2E/U7g=;
        b=k/uiZPP6rX7fha2lyjrRWB9tUQKAztCX/sGFdOEe7fD7pZbt5hgIFKYR5wudkS6mfk
         jikkkn9VEAuvE4Rb28xr/i/8ru0yMLcjG18sQR/SEG6xWghDC4v6BC9XeKgTu5KAX2PG
         4TpB2yz3KYKFzEIOykYD7BcryBVyGg3Usf48bMlSi1VGOE4btQoFw3gqsLE3y8LNY/X/
         5w/VlSxKfcCDz8BsTIapMJ+WR41Qg3GN62n5xCgQnlM9jhHhvV6ara/DKUIXui3XNAH5
         VJr38Vg0gcXg9UP75LXrYpuAlp2s/aB2msL0TscwjO9zDQEf/kq01ecb5uCbe5BzGn42
         3kgg==
X-Forwarded-Encrypted: i=1; AJvYcCXNwEbnK14bZutryfwt8gtDjQLHqUp8Xu0UodnajWXa+QX8XPLdNICLBY2Nq753jBdpZyypBBEvn6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Yhj/RgzJbJ+Dd0SNg7RAT+YiVQw9KDJzX2xppvwqWJRaa2yd
	RKrQJ4ALQ/TDQNgwiP/CYv2+J7FZ+mVe+j0x96JtvSCkclAorTPx7Sl813Uh5Hoq/tT08ZFeYQK
	nVQT9JgD1L8i7XUOV4a1i3GHmxO81qgE=
X-Gm-Gg: ATEYQzzr0RPx4XwtNPQK0+Pi4QoSAMdAjcfKVICGcs2CfsZqSlYkEQSR13lj2SHwz8L
	ZvbERcb2RJXpAT6bP/jEAkvbVQsAl2ZvT1fOuj1LoS+oarocaVfHlrFI1cSkRuluQ8ovw/i1F8v
	evsxw2CNEDkpgBt9fYFv9JyF1odUanr1orzOZrx68Oqp/e5eJbmMixWYWtyqJ1TD3UzLFw8pA8T
	cXeDReD2KkUe5MT7DZC1ZCgZZ/pGkt6hek4iIuFVrgguJn/1tdt3eQN4O9ceGNeIMK97D7/Vdqs
	YdId8chic9ReIy8a5HPdnY7lxvE=
X-Received: by 2002:a05:690e:b49:b0:64a:d64a:b025 with SMTP id
 956f58d0204a3-64cf9b22d01mr4439489d50.7.1772714802117; Thu, 05 Mar 2026
 04:46:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305021550.120614-1-chenchunyang0908@gmail.com> <aakrn40DOvSdRgQP@ashevche-desk.local>
In-Reply-To: <aakrn40DOvSdRgQP@ashevche-desk.local>
From: Chunyang Chen <chenchunyang0908@gmail.com>
Date: Thu, 5 Mar 2026 20:46:30 +0800
X-Gm-Features: AaiRm53NN7I3r73FTn6Qb93ELqnhbwl-hWO6jNsosj0RP21fPmKjNSN7vQKUAz8
Message-ID: <CA+TCOg8ehyUx4yLs4acCTYfMiYJaJ-g3UyPAfw80Wy+M8FwWiA@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ti-ads1018: fix type overflow for data rate
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: kuurtb@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Kurt, Andy,

Thanks for your review and suggestions!
I have sent out the v2 patch, which addresses the following:

On Thu, Mar 5, 2026, Kurt Borja wrote:
> data_rate_mode_to_hz[] is u32 so I prefer for this to be u32. This also
> kinda matches ads1018_calc_delay() which takes unsigned int.

Changed 'drate' type to u32 to match the array definition and maintain
consistency, as suggested by Kurt.

On Thu, Mar 5, 2026, Andy Shevchenko wrote:
> Needs Fixes tag.

Added the Fixes tag as requested by Andy.

Best regards,
Chunyang Chen
