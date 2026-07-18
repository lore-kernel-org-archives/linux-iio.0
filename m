Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162671F5825
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 13:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784382706; cv=none; b=gXKpurzP9BVfxCO9rU31titWWTwrNWWnfbPmBo1nPxFXrg5aW8RViEUfhAsevzSpmR0zJepfOOcn5GHY7DhYVQYSTcqdzf85EhFvUv1lMMckpPjocyJJkn5xx/Uui5wEuCkcU1JHqjMoUQOTCLZBA5iPvxA8AYl2Wh2SPULvtk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784382706; c=relaxed/simple;
	bh=NmhwOnsyr4ClUyrLPc+K6s28iWciaHYVAbVXM4qvulg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msk8lfXa2WCAEwlBtyycTHIAqx3Lyg0rQHggY4z/aBYU2jTyvb+Mq7lJXja2pKtQgFsc6I4gC4dIalLdTH69sJQvkPNlOxNXUlDnleUiu0bEit/qljjPH7cRw0exdlSjnwDZHzJj5nMJmRmjFrI/K97fj/KgK9f08GSyb8gzi24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=GKL91Ii4; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="GKL91Ii4"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4955484387cso1324585e9.1
        for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 06:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784382703; x=1784987503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NmhwOnsyr4ClUyrLPc+K6s28iWciaHYVAbVXM4qvulg=;
        b=GKL91Ii4po+JKkuJMgTkFcw9gMa5hG40MUcjQPiWPRaoDwb6V6KemIp6ikEMVYSOoG
         uasBvzoF1xjzvt96EivY1y0RMY9yfKWFYp2tqSWDFFpUcwe4ywp5pUWLZaBQOCV37Y3H
         JGdqu58UlL16H87AZsnGFg5wxImYU7PRdlIuUmZXbTla1RYuGzAzPzEnmDlyEgfaPa+q
         V4A/6eBHWxSPNSuCXhSmsVf4/tpNGt5Qb4OVexWdTVWrZPNOv3EP/bIj4NUbxulnetoG
         SA6qQvE5Oumwv6v7n7VV7Uld1elxI04orBMyuy9wa7EoYRtshBC69YK/3rm/HQX/Va6s
         D/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784382703; x=1784987503;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NmhwOnsyr4ClUyrLPc+K6s28iWciaHYVAbVXM4qvulg=;
        b=L0AaYkmAVrdlXth24yx/OJdFgaEwq3NK27g9u76m02DP0nZOUC8MfMkRvvLqOOfe6I
         kOHjhDxxKKz5IBZD6num2bPgxQKqr1Bz4zPQsVonmJzcQDcbonK9qAIMZ/ZZzeVJfuJu
         7Lk6ahkud3CJj2Vt233G6Rk4N02LUofnFT6dU20Qf6gy6uHIil8df1geQgXbR9FLra9F
         YCFMVmwbL9F5H1edh9ZzqvcuvagV3mKgbvKDM7J3z7w4+st3mEu8fvjcHGdHelXVVnyB
         lJFDDtK6sJIuJ2zga9OBKfBw/tf/KQAonVwH9OwD5r05Wsor21QBHinn/2F1fXiXasqc
         vR5w==
X-Forwarded-Encrypted: i=1; AHgh+RrxnmsXHPcMgWQZ02WGmSby7Nbwjy5QBfi88VEM0HMqoR4IRy9qV9sesYqCNRVhrqYG17LPCm9eymE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjNPByHadiIuYG/JA0Cm9JYpCpqVm3O8VL4GPOY/TL2I4CwIbo
	VythWFcbB3wk93hs/OmiDN5WOmHHhKE+z6lDEQdn1vm6/t8RXrfYkD0ip+YIhcRyBss=
X-Gm-Gg: AfdE7ckpV82Gjb6bjitp48A5V3UBqbz0Y9wsjVWSX0phmvVHbA7OcFQusri3kpJVAY/
	bq+FXg6VF5B2ZISTrXrwtDWoMBqYdyooaXqMGPrqOsJ7J8dpvFMBuHFmOMm+kMn/Y5hjYHCgkFc
	Ei+cM9svDQhdP8nrL/lZXIlkNe7Xe3xwxig8WHIVsWJfIckxg96jwvSq21zY6ib50AQEbqLd17s
	wgGnwHTBYLxaFIhjCZ2zexchVJYotFQ4TwqnW6vPq+mRZn7rAX+G1nByvmaN//aM/E1S/JYgyCe
	TCYuxLKj38wyHtB3Z9RPB/u8+o32Qv6SWcHfDK+1vAup9A6eGIZk76/RGR7qm99N+tLJWpJXX+l
	azftosmDZhaC4KYxhBfdVkx5kM2Djy9Jq3NIdG8RugJ4BVNFw3Yzl1vVoz40fa9lDcXBoFAnwE8
	noTOhaoJg=
X-Received: by 2002:a05:600c:5882:b0:495:441a:39d2 with SMTP id 5b1f17b1804b1-4954a402f2amr56064715e9.21.1784382702902;
        Sat, 18 Jul 2026 06:51:42 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49549a3e56fsm125239405e9.5.2026.07.18.06.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 06:51:42 -0700 (PDT)
Date: Sat, 18 Jul 2026 15:51:40 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Petar Stepanovic <pstepanovic@axiado.com>
Cc: Akhila Kavi <akavi@axiado.com>, 
	Prasad Bolisetty <pbolisetty@axiado.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Harshit Shah <hshah@axiado.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: adc: add Axiado SARADC driver
Message-ID: <aluEcXhBE-koqBaI@monoceros>
References: <20260716-axiado-ax3000-ax3005-saradc-v4-0-810527a9d27f@axiado.com>
 <20260716-axiado-ax3000-ax3005-saradc-v4-2-810527a9d27f@axiado.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yilug374dphh6m6v"
Content-Disposition: inline
In-Reply-To: <20260716-axiado-ax3000-ax3005-saradc-v4-2-810527a9d27f@axiado.com>


--yilug374dphh6m6v
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v4 2/2] iio: adc: add Axiado SARADC driver
MIME-Version: 1.0

Hello,

On Thu, Jul 16, 2026 at 10:53:02PM -0700, Petar Stepanovic wrote:
> +#include <linux/mod_devicetable.h>
> [...]
> +#include <linux/platform_device.h>

Please don't explicitly include <linux/mod_devicetable.h>. I'm working
on removing that header and <linux/platform_device.h> already provides
of_device_id.

Best regards
Uwe

--yilug374dphh6m6v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpbhOgACgkQj4D7WH0S
/k4LzwgAqUsEtKBg3XgyxAvu4y7B4B4jSS6/on1s515DyGFwKexOluTvela8r2+u
fCLS0KTyCMzgs/r2Ht9WdrF7m24uHy4nYmttIOwOdk5ChYfCDlyYorB8uXVdHW0q
FaJRUGcYXKQ55vSbfNmmAt3RVmQj922qyja4NHpVU5mg0H7ic0rQ1WXmD+g0irJW
wR+cDY78sJRZ8FmNkgjA4XxLu9i252uMG39NB6xQqgazs32SCfNZnVQAyGBBGAoE
+atUSsl8IEV7PQnT4oeAY5Dhh4p4AQ9r9MzUmWL7EPkIyO98GqOdl4vglsRKg2hg
Bea+oa/lxGKZOkoO+wuPkU0H1qdXrg==
=zIaY
-----END PGP SIGNATURE-----

--yilug374dphh6m6v--
