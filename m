Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5353ADBAD
	for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 07:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783669174; cv=none; b=TL5v4LugfeVhlnNosbzcr6iB7f9seHtbg8SY17c07BvEkrnQiALl9DUpqW1zwCg0fvkOs423aA2plgWRl96hroqiT8+sqWMRMNT9XznzMviwFk+pcomjSmyllkrE0KGm+IAEFCBvie5hMSpsxexNMAlBhtV1ULvROaJQlpsIUC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783669174; c=relaxed/simple;
	bh=PWU0v4sjJbD2CQ9MCYUXZFpGOf/MY7CyUDjnbwNep8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSyaXib+tXTs+qYZ7NOOgMONZ4fswZ2sca81NgyJCMHo84J/VgBOrSdz319Otx9ZCFY8aibftOaJGk+Qkc8Sx7qr2Q4clW3JLg3lwA8gRS2bl6PbWW2qAcEVOFKEP2mqMxgPQk648AlCEkQs4Muu4tT8M9c7BxUu36KabtjBJn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=cjYYPvKu; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="cjYYPvKu"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493c5220cb7so3734375e9.3
        for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 00:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783669171; x=1784273971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PWU0v4sjJbD2CQ9MCYUXZFpGOf/MY7CyUDjnbwNep8k=;
        b=cjYYPvKu2EJ8wSoR/LYk0Yr/eFQgpf2mT6+0bNuG3N5RC77InOUeSeXVJ8e5mEwDfk
         fOWBrzD1A4+oyDJGrzw/XE1Z1cNsRUngF19V2d1V58sTiicwfUUkMZkO+2agFKC898A/
         mqvYnFjMqCWRPoEXJxB1DoQ8N6Qe4huiwYxRe6KeZNxiLXTKrqsvWwAqqZ2cXCEGpRbu
         s4RgLLvt7gSNukTozPpRK+3MjLVT2L1AxwTBmvUqPwfEoNkMDc5QSulAK6LdSCnQ4Lpe
         Fhc2wfA3yVkL+JBLYYffWCuKYh8kKXdb/tMwPaS80OARbfXOoGs1Dg/43mNa6ity9kG1
         DZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783669171; x=1784273971;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PWU0v4sjJbD2CQ9MCYUXZFpGOf/MY7CyUDjnbwNep8k=;
        b=J2jq5ajuUbp/4Oeu/9LMCCY5DhxVDsDpr771J2S3csplzVP5//S9/TX891q/YM0coe
         8u6dRgJyaBjPyybozIjePxMjN0lcgh/4SQzrDquYcTfS5ei4Phrv9SshVdijo89EUClX
         FBFDLKa5Y5TnLEo7xDt+zX4Is5nCSliP3A2LwLTZAX82bfKyv9pRI3vUKtX8pl6312Qz
         z5HmszHADN8xPOR94QbtHtUHN9Lxlxz4bfQAbaxAxR/2nk99mPjpIVITCoZeTLz1vPeg
         vl+tXsqa75vI4zw+B0ObjtBt+hTtYvaS8WACPmEASH1mGcang5v2A7z0HzL1LenRYHgx
         Sgcg==
X-Forwarded-Encrypted: i=1; AHgh+RrhYk9ACowwt4u+8qGct/J/fO1Oc0QiA2vrCror9QUztW6rUo2SI8kyNOFldB00CRbNq66idJgDjI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRFK1tFviZtoWQoIN46iKz+xz6XXQRZ0If6M1rd2nI7tCDXsOT
	0iTcb7FU0sq2ONAocscaV7DQCRtGV143+/IeozVt7bNA8s5SjwcozcdHGX4EK2BR1o4=
X-Gm-Gg: AfdE7cm6dSER8Pc0ReBW8gnm2iV1XT6lsEKJQC6FCBjMt9r9oeRSkC9ThessEj9DFDT
	nw7aE2GAOttOd9KgGwmOyFqaU3/pwAtZ25vcN5rZH4JhzpQKYJioF9Bl1F1Iv6zhHpFc69y+hta
	mRGTxPRxTBNGlbv6g2Z99u2JkXEDC2oiY1RuVUig+r6epKqo6LHa7t40yEp0J+EI3xKneZ3NqR7
	bX9tSj5BODJsFnC2SCl7ctGINBsSMZz/XgRW+m2ACJV/HCO4zJYm2TRtNAQE91TazZXPEFhC/ph
	+m8jRp/DrwlSBsbqOA3LNKHJ8bxwPAYRRITYv79XLTwlUsGtsGoAGsZODIqahUl3X/BLRvMgWRD
	mDz+r0H1JkBPCSnyvm6y+ftLKPrzEJ/7wHaBzIBDOHy7OOct/sQAEEawSPFgFGCdPOD2kzSjInK
	G8Ml9Dn9lG/Vr3kGkgzG4pyAzkzQVoY8zlD+mo97u7gzy3cZD/VbxQoaBun2M301xCpGlukPt2J
	dWt
X-Received: by 2002:a05:600c:638d:b0:493:df5d:6ca6 with SMTP id 5b1f17b1804b1-493e68c41d7mr93044945e9.25.1783669171165;
        Fri, 10 Jul 2026 00:39:31 -0700 (PDT)
Received: from localhost (p200300f65f47db04fbea22a44ee9ba38.dip0.t-ipconnect.de. [2003:f6:5f47:db04:fbea:22a4:4ee9:ba38])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493f4f09f89sm33853675e9.10.2026.07.10.00.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 00:39:30 -0700 (PDT)
Date: Fri, 10 Jul 2026 09:39:29 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: rva333@protonmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Lee Jones <lee@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Ben Grisdale <bengris32@protonmail.ch>, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v5 2/4] iio: adc: mt6323-auxadc: add mt6323 PMIC AUXADC
 driver
Message-ID: <alChi9oG0-2XUFXK@monoceros>
References: <20260709-mt6323-adc-v5-0-d11b8332a735@protonmail.com>
 <20260709-mt6323-adc-v5-2-d11b8332a735@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w5zvd5vp4pqaarjf"
Content-Disposition: inline
In-Reply-To: <20260709-mt6323-adc-v5-2-d11b8332a735@protonmail.com>


--w5zvd5vp4pqaarjf
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v5 2/4] iio: adc: mt6323-auxadc: add mt6323 PMIC AUXADC
 driver
MIME-Version: 1.0

Hello,

On Thu, Jul 09, 2026 at 01:52:48PM +0300, Roman Vivchar via B4 Relay wrote:
> +#include <linux/mod_devicetable.h>

Please don't add new users for this header file. Only use those
<linux/device-id/*.h> that you actually need (if any).

Thanks
Uwe

--w5zvd5vp4pqaarjf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpQoa4ACgkQj4D7WH0S
/k4pDwf+MvHDR2NtPifHQ1UsidnZd5iG/SkGcVotUqLFeN2Q4NzZWdluwEBDlqYP
3AALM8XUIbkGVP7dg/LDiffqfsK4fE1kUa3Tmzp3lYrTzMlgZwuu4FxN6V4FTDqt
ljrJFdNgUMcs20mDR6iIwDq5KUqFbuBOTeLF/8HHcoScvTb8j+3rfp9D+k8iVIWF
begEnYaOM//SpubNhltzxmf0rcnRnm8+hlR6A3vcLOkP10KQBxk3OAK4oZjiN4dz
AhMCwZu8VjRctocECGQE6ZTH1aKUSzuGcFX1QrXDPRnhyzHjoMoBZZien0jrGL0J
A8nk7InQ4UXOD6YjGdppmL36xpQKsQ==
=N5IU
-----END PGP SIGNATURE-----

--w5zvd5vp4pqaarjf--
