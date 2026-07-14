Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59077445AC3
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 12:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784031653; cv=none; b=d3b2SY+KQq51gMwTrxxkBS9uDw3kI8bJgcuD+27/ZyAbAgo3/vVJeFWBH60P9Kvnp1D/+6vIKL02HEQuKEGPlUur3SjdC34DfOgQeclHJMWiv50LqKk6vjDN4+wTCK6dPKuckDFez4cxAcokkwlZBkIX+fvOYNotoBwkF7wnjXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784031653; c=relaxed/simple;
	bh=voGadakYqXnIlXwQUHk3gnLHTsrtSs+HoV/Na3s5YyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eePOiojiMpovkkoE01ojoiNDuhksdg6SU+hJTIHnulNyiydalr0fjChi1wYBpa6rAUcud5xoVV4AmXCiVte9XLDcHc/tCFgGekyqfwHGlaFITmtvzkrU6swv/OxiLJnmzpwomaGFiPY9mlP9qC0fMGP4s4ZTXQhhhh5AfvZwAE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=pkOaD8dJ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="pkOaD8dJ"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493b7612475so33125995e9.3
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 05:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784031647; x=1784636447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hgvWUauX7MDwhbm4wkBV3/ar41slFNGjoI84HU3YT18=;
        b=pkOaD8dJFCtOKQNyvKda05s8ajrd7upqCZHwiINGdc41wa8ms9CgKI+XC7/9eUpwZt
         wM+gf5tfr6pAjKAPp/Fd1ujXOzGJaJ+QHYn1EVDNFN3N1PxxDukt8waYNsvBpROv24aC
         +Q7MjCtg9mIB0z9iZyd5mqe/plHv0p31LW7lXMSiRIuCEjX2/kMCFvtdtU4g0B3pmXr5
         I7LEXCPQPdOUo4ZfmTJEgm9R3OQIGH2IHxVyQ8fLj/cibYxT4+LUpgt+uc3AHplITY5x
         zaQ/CwP8Fm57lX2pO/HSLpTZ8oz2MxNdS+JkdOaud1Ft9LQS8E2nsTeR7slfpvN7DjFL
         xCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784031647; x=1784636447;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hgvWUauX7MDwhbm4wkBV3/ar41slFNGjoI84HU3YT18=;
        b=JtBn1USS8/MONPsJPDIBWQLSpdJQOMcp/MrssUp1jlJvvPBhfQT2pf5XYhEf2KIfbE
         dx8kpDwru9nbWI86GPgCNvPVrf8kkiuCYQ+u7rxBeNZiXe1v6C3CTuMXZ5YVRZ+xAifV
         wZwQeg/DTEFeL6xNN6cjgVx2Q5DPQ1YKIvpxeaNd0oz6uC909AUPaTzQE5Oc534Sc5Ic
         +acYYc9fKEj2Bk0+3bb1SxB1Uww8slmgK8QoC9QibnXtBLJJKRZguwE8SrQRxTKLo2Fv
         aZ7JfeixA5RmucL19BqDvM9ZktLmM652QvXX9XWMkKE3yLI90OXyhxM0X1SjSKAdIIuP
         1kTA==
X-Forwarded-Encrypted: i=1; AHgh+RoTHalfYuBgWwVA9fkGtPglseG+Jqn1RqtTXQUyjlr/L3gmiQyG2+FjgdIbfuhVc0OsLtyCTEy87FA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6ziEEoy15nehKRpIXbWQLk41u35+7GHhnp7n7vY8DU+jbpTLX
	BDC3pJ0s+9cTjVJ9WRcAYluFU14YyAtjpzau7ZXweIIVPTTVaX88T7QAQNQQEMq+bZw=
X-Gm-Gg: AfdE7cnGEz93VDjeRjpE2pRZO1efNzAo/N7Xp7suW3N/GVSzwQwBYAgixolLF1Z5K8R
	XzHTpWe/kAF25endpvxDHjMm/6StOkFzyinTIWVyiRmcY2c0XZHhLZoWUZA0k5h/gMA74XuIlRt
	WUxzS7n4KPmbW5SQmEfgTP7laLbLN0hLZxW0wKlN9ZN7UkAWCWGhE7FNLbjdSRLgbo+C3n//EUk
	s3a+oxowlo6GcP16oioAJWBHOtLBCv16qtI1fpxQ+C23TnEbc9GdL9ngu2JYRV/PJdB+82mKbVI
	gOjkwtRgd0zyiyS90I5uQGWEh56uq0FqubgfU/PLsOKGCBiJwsL7mzsLULF5bcajoPeRU5SSF3J
	Wyh1GHNOO8/xttmGsjzvSLnnXOgN9y+gnFCS8Ays6UeDvLv0ZTHsDyApLZ4KcSmb9O/cveqTodD
	YqUeqtWdyjw2+zId4QUKFczoMH87Sk3G/vAO8nle7jFJ7g2UDfcsgO/B/qqjD7lJh9kI0f5gGG5
	hDm
X-Received: by 2002:a05:600c:821a:b0:494:596e:e8c4 with SMTP id 5b1f17b1804b1-495158e08bemr42720645e9.17.1784031646938;
        Tue, 14 Jul 2026 05:20:46 -0700 (PDT)
Received: from localhost (p200300f65f47db04b44a80421173aa03.dip0.t-ipconnect.de. [2003:f6:5f47:db04:b44a:8042:1173:aa03])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493f3a60404sm310037605e9.1.2026.07.14.05.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 05:20:46 -0700 (PDT)
Date: Tue, 14 Jul 2026 14:20:45 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: William Breathitt Gray <wbg@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/3] counter: add GPIO-based counter driver
Message-ID: <alYpPE-cK453m8HT@monoceros>
References: <20260714081709.17846-1-wafgo01@gmail.com>
 <20260714081709.17846-3-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lokkrjvbov7tpqqw"
Content-Disposition: inline
In-Reply-To: <20260714081709.17846-3-wafgo01@gmail.com>


--lokkrjvbov7tpqqw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v7 2/3] counter: add GPIO-based counter driver
MIME-Version: 1.0

Hello,

On Tue, Jul 14, 2026 at 10:17:08AM +0200, Wadim Mueller wrote:
> +#include <linux/mod_devicetable.h>
> [..]
> +#include <linux/platform_device.h>

Please don't use <linux/mod_devicetable.h>. of_device_id is also
provided by <linux/platform_device.h>, so you can just drop the former
include.

> +static const struct of_device_id gpio_counter_of_match[] = {
> +	{ .compatible = "gpio-counter" },
> +	{}

{ } please.

> +};
> +MODULE_DEVICE_TABLE(of, gpio_counter_of_match);

Best regards
Uwe

--lokkrjvbov7tpqqw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpWKZoACgkQj4D7WH0S
/k5D9Af/fGvdc0KFylE/5qWvgs5OvNZHOE4MrxjbKXbLIooOEtGSdVkr88UjnH/0
PLgWBdGuAq/fCedXiCn4DsScCtDfK6v932x6L37LjBvmfDW72A4AHGgQ5IttjVFH
XuvOD1UuNSoZa06uqXLX+7eoRHv60DEpHUTbet49sAk5OwpdEk6F0mjiAoLa/+Qy
nxUwTCYBD3Yrw/z7s4kuXztYhfFHu84akf9514vTHVjX9c7yDmL7t96goP6vVr3P
54wBXQS/Sr671DEuXlKUDDosUA09dUS+pa+PHorrbMvF/a5ZGa10VQ/CYjDYRBpH
08GlRdtcTjjVmaUfu0v0PBMA8kHmbQ==
=R1DZ
-----END PGP SIGNATURE-----

--lokkrjvbov7tpqqw--
