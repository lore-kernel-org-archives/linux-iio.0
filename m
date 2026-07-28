Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C066C23392D
	for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 00:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785199138; cv=pass; b=DiR6lWpVapMLTemDPNyUUL18p8Vvc42NQDbZRLh3XhrGhb9DO/y9cNHlQUrVPqwecUEUqFUtUeje2PfMoqthUFcrenr9jfzHmY5AeMk7VAI/yoadAZvuJNgOAgq+thlV6KsTI4RA6WvhLgWZY+JBSHeTTF3MAz/s0Dl7YQePYmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785199138; c=relaxed/simple;
	bh=VEY8riwUSQV88YndLMs6mCpxJ/J7nAYR1Riin/nQO3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oyYUa2CkmqraRcRVwpSkK/VbnWzncyipDibSu+PGZtMOOZZymjlkbgoQ9VKBZhsJAtl8QU/goTPEwwkx2ijFkP62GFJibDZWQ5Dc1bEOKagWNEV89CzJSzeHCWRgk+TvFljENF5eDACk4ScL/SNldS77ipvg+9iK8RF3Ln+3Fc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=frame.work; spf=pass smtp.mailfrom=frame.work; dkim=pass (2048-bit key) header.d=frame.work header.i=@frame.work header.b=anDHoMIj; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=frame.work
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=frame.work
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=frame.work header.i=@frame.work header.b="anDHoMIj"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c1712a04ddaso532469966b.2
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 17:38:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785199135; cv=none;
        d=google.com; s=arc-20260327;
        b=k6/oRsrDBHjvj2yLakdohgVHpgYUbjROx5maTrtRP6W5mIXJ77chxlfDw5/Yo53yL8
         ndvMiM1iwhXTX1f1XQ8VJfbZgVzKibenamt3CgBWqK/oltUjvfxZu1i/iNd6JRsQxnYc
         RDQseDumsQQeu7+Rl45wldU2D8yWlE/OnG1FGCBpalAsD2gKKep7Uo41KxqZf8uGpNIB
         1Q3WHuVDFoPYgVUsylpOMWaHOiUOYJRvNln/cgtOxNHAmNI41kGW8NR8Yr5WGxh70tqV
         73pJ9ssYjnpcgehMek6gbTneQ3FVQbGPppJSL8kVhtl3cwvI3Nkex+vOBMK7MJimsSi0
         ri2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VEY8riwUSQV88YndLMs6mCpxJ/J7nAYR1Riin/nQO3g=;
        fh=ZuTmcUB3QvG/rCGTHL8Se8EA8kaVV8IiqG/A1+B3udk=;
        b=Pw9SSCuzQPFo/SignVzrXki8ggjsNaRPJTu+Wb6iB1BRxEWkTyqPEliRhwjk4H55gI
         QAqT2PEnN2y/IO0xTGNMw43i7+z3G6W7k2Y5XY6NC57dO3+dxLVJqDM5KTtP5QkdJ1el
         qUsJ2qel5FI5OTJ3Vmym8ce/EnxhN1ujk9m+I+FWAkEL0LlZ01lxLPMbO6G/NfnbKLWU
         qJ80I0Gv6GzLjs4cCGPaeesrgqqUjpy+QUCyCMXiYTVRWD5M2QQwJGAl6YcyAxmUq8E9
         aKoUGkY4je2fIdv0+5kw6Sl0wmMXd5Y2VzlggiZAAW9KyBiZmuLPnxqvdJIQgMYV6+PW
         FHgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=frame.work; s=google; t=1785199135; x=1785803935; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VEY8riwUSQV88YndLMs6mCpxJ/J7nAYR1Riin/nQO3g=;
        b=anDHoMIjIZs1uZz1CAKc8C0GvNWgpOsLCJfHyNLnsBQU7u3XwrCawZr19IS4tXiRBc
         5bEHLXpUL2Tc+dZSN8VUflxPm3JVLjAJE2u6oqAv0fxcQkWSEBmawXzAu+v2xN2sVk6p
         gRo1GG/4OPKMtFbfuf/+aweEbS0Jk1mcsPLWdDaX7egUPYTbHndMqY7/EHtCwFjM2edV
         7dnwL3x9cSRSdQf8xLTXj7qCbK/esgh+35pNF+b+FhRmYJYseVuonU84fBABf+lfsdwD
         kmE2a7ltB29ZFmBvhgJp0S7dPyEoDpC2PuOziXged1tKlWcTNmeqLRMxX6HY6NhIVV72
         wfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785199135; x=1785803935;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VEY8riwUSQV88YndLMs6mCpxJ/J7nAYR1Riin/nQO3g=;
        b=qUYWq+iRqEpOhquizIrN8Mkp9cddSCeNUSOLGQPioSdJGqcemsdWm6bD6knHAQoW5L
         jHXVuMNznJo8IV6VcBpEOgmd9u/sRoVKuyVJBIAE7uldrsXIZpSttONApdXS30AtNr+1
         rLIzgZzlU61heRagyfFvgpEcfF3TX/CsYFqFHLaC9F/rZhTR00Ac0N0X8eC3WCqFFvUl
         H2j/4xkxIA3hCkUGLtFh9rgRJYMW+2sMgR1EHtoiGcRCwD8RYJMWiFzyiP+ywUUqN2PE
         o54MWIyK6rntmiW409jhSvZ88J313SyDvbtdaZcTMshLX+2s6LtfFFWfPKGfaq8M4ohJ
         /1Cg==
X-Forwarded-Encrypted: i=1; AHgh+Rqp1jZLt3wkyOcVwOcOiGAW09wYwzf6WlaHfpiZB6HwjZahyEgEIxbFvA15pb69QNzO/INnZh9o3ao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+V1G1b1Up5YekSyOd2uFEYUp0L+GkcsBKiflNTt/pjCnu1Rcu
	e9TXTumcXHUxJJu4OAXNjiwRaiKw2/vkWhwfs9xzidOVfS3bIprWvKdt5sO/lMri/XoFMf+4lCr
	vFEMS/37CXIcAN6r+Wp0XGnXPvzndtTmGw//dJ/h3eA==
X-Gm-Gg: AR+sD12E78QI4/edLFFDXiOpGC5utV/V5A5AoNcge4/u35+QX7iPAZhOIiigYDG6OWR
	tDmW3O+fzEMUO41hPKcuS3r0ibXib8VFLIBcZoN/GWrQ3+B7tomVC17vEQg7N9MplAoRBR4n4Ho
	lDyjfsxntVdPLz8skrYsCMiId239V8QmYxVKVIf0WD7XjtFUWlzGBCgNtdgaeM3WYqfT0regYL4
	SenXbSlCmVGiZ+QNEe2l+qZRiDuD5WUFvb4GQviEMGdaxcOAh65a0BN8IRqMvFKI1y9MrkgFouB
	xR0EjIi1Kv6zzN0pP3RimHLCIkXKFjYVO/aQRC0MyAEq4WE=
X-Received: by 2002:a17:907:c19:b0:c15:a06c:2bc6 with SMTP id
 a640c23a62f3a-c1f72155e35mr6140566b.47.1785199135006; Mon, 27 Jul 2026
 17:38:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723-chromaticity-v1-1-5ef5746ace2a@frame.work>
 <b6e684365758146193421ac3a36b58d55af77691.camel@linux.intel.com> <20260727221338.29f1da9b@jic23-huawei>
In-Reply-To: <20260727221338.29f1da9b@jic23-huawei>
From: Daniel Schaefer <dhs@frame.work>
Date: Tue, 28 Jul 2026 08:38:17 +0800
X-Gm-Features: AUfX_mwLjrpQ6VsNMrlTbcXvOK1JVgbIFD_CE7r5oTklBZYDx2WyZaNizEqtsyU
Message-ID: <CAAjcXz45hB7+4wns0L=2VKeAeq2UaPhwHa11vPgFJux7Q1WLRg@mail.gmail.com>
Subject: Re: [PATCH] iio: hid-sensor: als: scale each channel individually
To: Jonathan Cameron <jic23@kernel.org>
Cc: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>, Jiri Kosina <jikos@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, =?UTF-8?Q?Sven_Vaink=C3=BCla?= <sven@xn--vainkla-r2a.ee>, 
	linux@frame.work
Content-Type: text/plain; charset="UTF-8"

> The channels in this driver report IIO_CHAN_INFO_SCALE as shared by type.
> That doesn't matter unless we get different scales on the two parts
> of chromaticity and I'm assuming that isn't eh issue Sven has run into?

Yes, in practice it's probably not needed and the patch works as is.
