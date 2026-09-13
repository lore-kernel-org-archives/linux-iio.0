Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4AB374745
	for <linux-iio@vger.kernel.org>; Sun, 13 Sep 2026 06:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789281323; cv=pass; b=G7pFE66xFuazt/cujx/mmpifUsPJHGazEI5tYLOWd0uT3yQAIwKb69f2CMpHPt4b4uUaX1kIC9al1DP9fAxsXcTcnZkO/2sGPFK4zHiTZdx+wYQpsotn7Ro4gKNxJMjVYhAl+jDmSsLWAHb3/pNMKaW0342bWa96kv2mOtXAvZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789281323; c=relaxed/simple;
	bh=n7FGhT2+o7Xrk+D/cneTINKrUbSlpf57QV6aXXmMNkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pNOROFxGUS4rCCOIZS91A6fqindA2fmy+i58nbgRrzBcr4GjYiojpMEisBZuFtJK6kwfklJYhlLjAjTp2Ik36K1zI8m6bjsuZZiz1nJxiqD3SepS7WngnCDiOvyEU4TVysZF4YdV04huBQ0C8MzwWLDu5q+2OVX7rJoWxZ9+hzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmarqOT3; arc=pass smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmarqOT3"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c0766cbe64so717155b6e.3
        for <linux-iio@vger.kernel.org>; Sat, 12 Sep 2026 23:35:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789281321; cv=none;
        d=google.com; s=arc-20260327;
        b=oIkYleRvmDSfRGiNCJr5m0LcehZlabR9WId5C9GFVhWmKEJNXZzydeoqq+jDP8vS4g
         y6undlEEs1r9+anu3VszYYAhQApmvU9WWNmhbW/CkYpIT+LedAMD5LsOq7OTsQc6DQyL
         eBwx1ApDiAv6Ghu29rqwtcD17VlTV/wb2ATU149qNSmx41vXfGsi+PQhB+rS5qVVjPYK
         NzI/NtcucOWLFT2N7jatMYnMAOLn+G+rJOWzFdadQ8R0mCSfu4TpkgRPO1oJtUQBQAVF
         9Yx6+cilEolWpvEBdlhEjRqSqjayteGREhRoBVAoYs0bkoGEmzl5FzFoyKBFnzslhFt6
         5Gmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=n7FGhT2+o7Xrk+D/cneTINKrUbSlpf57QV6aXXmMNkw=;
        fh=Rm26ZnHgZUF4Tpafwy5oJ/lpsNrRB6p6Am4DF1DYDx0=;
        b=OKfrOy3slk42EEj0PdNy6wqHOdfCoLqJRnFQC4lcdbM57vKQ/Dsq//NtV2FEveKIVJ
         pW7FWeEQ5xatakNhHfoZpfcEDwZPmQiBh4GqqRac7JokY/hKurawFZEhruBp1GcoeHCp
         XDnGDsiki0EnMC4egdFB0XCjQ9LYa1SwDji2ACX89bGMu+K4YuAPVmiHZXkNhqU/J4Mk
         q0zd8YiQiDDXCE816W6yzr1ZxNg/BpM6qW8IXhNLkek7yZXZqwJzN36gYHPUwsXmWfWY
         JYgxikvSENTPwpRbzcueX1n+z+LdsiPnxsgZGynPlzhnPAZGNJJDrrv34JOVHzGNYDNW
         AHKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789281321; x=1789886121; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n7FGhT2+o7Xrk+D/cneTINKrUbSlpf57QV6aXXmMNkw=;
        b=CmarqOT32hcAviUApD45sw3LkbLll7+t443u0S2cnYv9Sn+BDPmhGmI5FKV+FeiPwj
         WzPncDYwLfMhyhnJayX24ZXAtvsTAmPBpppPhooscd7Fenze2/d21XquZ5I6HS5aO273
         hYOta6vOcAYmW+qJBTwF7KsoseQhd4LfCduJTOOYAIpObUwrJ6ABfgo9w+ROlNgjZAZP
         c9aiDZhxeAe2uapFJ+4G2drftKcShnJVfXNwd85hb2k1oPqB9JXEKYHB3S6R+XXp/WZ0
         +Gzc+dlp9RCjS3yjcWE4ffN8AzJTQIKJNYIC4ewCA1x0wEKn1WhuB1Isa6J+6UWcaacu
         CEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789281321; x=1789886121;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n7FGhT2+o7Xrk+D/cneTINKrUbSlpf57QV6aXXmMNkw=;
        b=I63VLZX2dl/WqbVAYPuPBUw4NPpeK6pk4Al7yZ5aF5Rogj8xTMl5tSCn6m1uRDHTOa
         Oy2igrQxsi6rkw0e/gVNRKk4knlKUGHeOs1m2M2ANice3kiObU4EHvZmcLF+WIBnPuBZ
         X3xGjjkVlmDrsjNZkFPbDB9oMqc6UWn/VAR15vAIwpk5MRLOYrpwf4kmwsTuxI0EkN3p
         ING2GWDxX5qKcRyIK+Tic4CpTXoYcj4xf6HzgjMbW8LbZiFrmgKs5K3KJ/AknRu5bFt2
         EDysvZ1sVENdV9px9HKDuhE5rKpdGFrKbdnrv0XFX/9HLudV4U8xFpIWf52SHvVBYB+g
         p5mg==
X-Forwarded-Encrypted: i=1; AKwUvBzct/ePQCgtAn/SgVeqwLnSQDuP6j5ti+D0zE5tG2HHItxT8TtracXQ5lF+uhEjUB74ERY1LMOdFnY=@vger.kernel.org
X-Gm-Message-State: AFuF++knbwlYr7aqsFCCZmjCW+mgsYmU+nfx7RnoUA67Nmsj98maDdp2
	BQh81z4bqMROsnB8yyVh9mxkVEPa8hQqkCrzadNjgf1z8jJM8LWp5HqHdDSjGrw3+qkKKhXwDqX
	bUIb+/4QzYL7HcRyg4rzNdqRv6ql4BLI=
X-Gm-Gg: AYBFou2n0EcFIYEsRSb67pwxB0q+EfxYnDsQeHvpz/SOsffErpNlYNf6IPh7+W9ggag
	/M68B1bMdu6ee+Bu92s6bEOtiPOe8aFXjeoaykgKD3t3pK9w2uWCNuN5oTbECByCPk0RiCfUA6a
	VEw/klCiqSYKLVosiCMSjRvEK9mWag8TX3r3f2iVGd3TDkTzaNEUmSKljlHc64zOwpD/n+nHQBG
	eH42QpK+QDWtvV7JRKL+o8ZEqkL1GFoSBWYK4/AJHWUHoQ7X9utLp/PJdFeZFp/b/dU6GF1Pv7c
	pTuLqvPUQ4e7xpmq50IemoNLRo8KVyxPW2YOGlkvqsEa5nfU2fi2vKpXfT6S48lH
X-Received: by 2002:a05:6808:6905:b0:4a3:fb6c:9adf with SMTP id
 5614622812f47-4c31b6d0361mr15432882b6e.12.1789281321263; Sat, 12 Sep 2026
 23:35:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260912132517.55686-1-abdelnasserhussein11@gmail.com>
 <20260912132517.55686-4-abdelnasserhussein11@gmail.com> <20260913035957.7eb0dd2b@jic23-hlaptop>
In-Reply-To: <20260913035957.7eb0dd2b@jic23-hlaptop>
From: nasser <abdelnasserhussein11@gmail.com>
Date: Sun, 13 Sep 2026 09:35:09 +0300
X-Gm-Features: AcwNN1Xi4im8pLXxHZZUbsbRPvsDuBfyr0AO2io4vttPAiQIYAfumvbhkH4AsOw
Message-ID: <CANpqX3YXXO=-=DZgbc1NG2jsSyQwnpYwHzvDrEV6zHK7Y6iz0g@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] staging: iio: adc: ad7816: Use DMA-safe buffer for
 SPI read
To: Jonathan Cameron <jic23@kernel.org>
Cc: gregkh@linuxfoundation.org, nuno.sa@analog.com, 
	Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org, 
	linux@analog.com, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, joshua.crofts1@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Jonathan,

Thank you so much for taking the time to review my patch and for your
detailed explanation. I truly appreciate it.

Your explanation makes perfect sense. I now understand that the real
issue is cacheline sharing, and why adding a dedicated buffer to the
struct is an overkill for a simple 2-byte read. I also looked into
spi_write_then_read() and saw how it safely handles the transfer by
allocating a bounce buffer under the hood.

I will drop the custom buffer and use spi_write_then_read() as you
guided me in the upcoming v7.

Thank you again for your patience and invaluable mentorship. It really
means a lot to me.

Best regards,
Abdelnasser
