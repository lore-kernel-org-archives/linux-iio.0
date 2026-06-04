Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC832594B9
	for <linux-iio@vger.kernel.org>; Thu,  4 Jun 2026 09:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780564568; cv=pass; b=BDtafesIrpOgJepv1+KgdNQT6I/HYVFakuCyXzPnsXNCW6WQSmqCfQdTHWGxuGFsHR9BHH3ZuVVPiXvtWCiLa/O2fXhHXO7hPGwAaMqCeBX82GFUvCTexx+CQgmTil9ztjHtNklXZlcssy07sJIxSpUTnLXwCi1gLMaW4INNQbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780564568; c=relaxed/simple;
	bh=4TABmo9cAip9VzeGMfHP/ewu/I2FMPcfxvfJcd6iVHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MzSPTX3fEhvYP3eJ8UsRz/B+o9/iKfE6a3OEe+N3WLtw7FX6g+Nt2v1aJo4BSIxzvLo6ojJL/ZHY1NT+hNEgskJdfUQDf5OdzdNSKnM1BFO8HDKiOeM+GrPVeq60ecuC4ruXLC1zYMmcStL+Bb8k9UmFU+uvaN9wvA7S+QikABo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GyLto4rj; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyLto4rj"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45ee5cdbd28so1056508f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 04 Jun 2026 02:16:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780564565; cv=none;
        d=google.com; s=arc-20240605;
        b=SJOSz9jwfPkU4GD138bGoVOWRXZxBJTW39HGIZtyJ2yYAYuGnB1a0kdpzbdcPQWMyC
         MDg40igS/C30J1vQ2NVOiPKxGVtY1T9xh6ioBQaeKOxcrFM1D01Ft24v6/2/QFLUUjnM
         V684FcESOSyrohdIGaT8yVo/QEXV8sgrazOp/M66qvaHODa83yPRtipGLTHuSzg3Fa6T
         VMCRUHB3EKqUjhcH7+ekOnJMj9p7KnjfBNHQSom/cOVKu8XG0oTPBtNBdKDkN5jjU43L
         fDJbydN1mqp9UvVyOAs75MusBzMdJfgYtHL6mTOce8Rkp0LMi7Iv0HXz/IIwlXZBrV9j
         nHUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Jc9Nyn4+ErSxF1R08zuU3Mq4bFvcF9uwvoLtWphiAYA=;
        fh=RCQF9ng3FhIr6mzYvmn3GjpnEsLu8Hu3y5DVuDmPZwY=;
        b=TWYzKE9gzUrhriSeA1pLZ7atURa839nHMLZ4g/KVvht2JIKJwkO7JvmjaydAtBwgYm
         nW5kFnIRjL/iFaxsojpEKsaJaMD2qA74maw+3gKzCWZhJuC+cgoPcWJbB2Zimu6BVRHA
         Afx3ppadx62TZyuIzgTZOIGyH/ey6uqB28uV+DBdPA2aHy4RBdYADLz+ArsVSzP1w+wI
         Tl8ChcKDC2aBgdXlARSsqa+0Dxq9dogwztsWhWJlnnwCiReTPf1BHYSPOhWGFWcn0e8T
         h4J/CcVZUgkCKmMvfM8jYCjxW5E84dQ8onFvYBmLrY6cNxhStf4pXdOHXa31UiNhj21W
         P9kQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780564565; x=1781169365; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jc9Nyn4+ErSxF1R08zuU3Mq4bFvcF9uwvoLtWphiAYA=;
        b=GyLto4rj6GFv/dtjJlN4zOqmO3haFhiJkhilcjtZXkl0tPa4EuJSB9bmLEX3LRGq+w
         VgX8mY8RU11AxkqBF1NMs17RIghiGXJMjSwmVQoEk0fOEiD4r0f+0SWKfVUDgFpx4fah
         hum2wp5yAdUzmMWdY2FwegsV5uApHVol4gHluxcazHXJZN+dNU9pVyvzyGKFd+zuXKPb
         F1ntlvUdSLEPgHI9Nfl+cTvrnrteYfToXhbRtwt9UqrJwpLfR7OFRbbipcpSjIbiTMn0
         plw9583Hv3n69qzG9OlHtBVLDwcYJM49xY+jdF5KXn2jKA+9NKY1L/Pt4jmbml/2z4QK
         vzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780564565; x=1781169365;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jc9Nyn4+ErSxF1R08zuU3Mq4bFvcF9uwvoLtWphiAYA=;
        b=dx2PirmHa0DOOwKC/gZkPNt/Tf0HOmtt2dfUxWb3eWASK04k0HRI8QMi1KjrxJv61i
         EbKTZusvqlcaqmQmvyL7+osVQJmEudEfFvGO4+rhxx6PVQbMd/TYpjp/winac02JboAl
         aMPp0yYiHkP8kN9j+LlzkEBAi26tbKy6cQsFHPvjW0OPo70+l6KDFyM5kkJD/2P+PG30
         /wpYO5sPQYt4BHx6Vmgpk0MCJRmTN61qqw24tZUlCs0gIKuGu3Ino+QxKAxbCoLvGacg
         qytmnm5xNL2RP6BZTDUPnMbujgzo88yg0/L+A4YH5oAjbbO59S/GKgQi1Cd9GVcRLbmK
         jG/g==
X-Forwarded-Encrypted: i=1; AFNElJ+5GRiZEm1ftkpM4RZonnZXJzxkEMKl6NiiBX1SDIsy6qSq5y5IzB0Ecn1nbub1OxvsQIB5LErLOFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5vo8bsAA98bd7ekAcC/Z/cQzhR5HYiqOSvOT1mrmzDN8I7JUA
	KYpxeebzPdEQ5d98mFE8IPcivi2CmCt8zcho7CmUbngOdCtIhrDE8tPK8WHvZ3kpLYsvBj0yt/m
	6VPGDT8o73MLT8X8n8702iWLGoJrZsek=
X-Gm-Gg: Acq92OEW4KjyJf1l7bynBRYVR58k5PFRbIuqTSpBx9aUu58YYDlm5WVs6CqBkJonPjT
	GyWoThNMigh1+CZstyn03OuSBHpdsBhzx+ZMEd47SsjmfD4eg2MWjJrITV5mQD/Lzdw+Mj+RIK/
	ZyivUdFzmFsNgmX8aGk037HYQN0ENo9RHRem/1+tdRHvz/kyPf/TicHYs0yXYrmKztqmMtlMKbm
	Fd56741/TBmJLxgWK1lcjHqKE1kF3QggtiTMLubr4XKnMtsd5ntu3k6nbxvp6CK7HiO/IiYVLqG
	XUivMLt6N9I7LXpHLHtu1P34//nDy2iS/4FsXkaauMdF5mzDct68Tg4O/cSgbGnwF2bJx4aVghE
	dfIb+iQPRtA3ErUWJLZ5+Yl7JTXplglmAkTynjcQPV5GJb2IREYUjNT4TbYQ6+OzG1C7dF8jtS0
	zYtDf0J3QG6eROHrkCVIAJ9MM+skQ=
X-Received: by 2002:a05:600c:a6a6:b0:490:b58f:4d65 with SMTP id
 5b1f17b1804b1-490bc51530dmr29824255e9.15.1780564565002; Thu, 04 Jun 2026
 02:16:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604070053.299221-1-limiao870622@163.com>
In-Reply-To: <20260604070053.299221-1-limiao870622@163.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 4 Jun 2026 11:15:53 +0200
X-Gm-Features: AVHnY4JMjR6JKifO44uS9M-mwVQgW43u-5y8-mW4kvUW3NZYwHzsujzGyPxVpnU
Message-ID: <CALoEA-z1LAoZRHHgXij-WDMKHW9HdJZOkTz_QS4_umMuEAnJyA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: accel: stk8312: Update includes to match IWYU
To: Miao Li <limiao870622@163.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, dixitparmar19@gmail.com, waqar.hameed@axis.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, limiao@kylinos.cn
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jun 2026 at 09:11, Miao Li <limiao870622@163.com> wrote:
>
> From: Miao Li <limiao@kylinos.cn>
>
> Update the list of included headers in stk8312.c using
> Include-What-You-Use (IWYU) tool, mainly to remove kernel.h
> and add missing headers such as array_size.h, bits.h,
> dev_printk.h, etc.
>
> Meanwhile, sort these headers in alphabetical order.
>
> Signed-off-by: Miao Li <limiao@kylinos.cn>
> ---

No need to resend IMO, however you're missing a changelog. Additionally,
wrap the body of the commit message to 72 characters next time, per
guidelines.

-- 
Kind regards

CJD
