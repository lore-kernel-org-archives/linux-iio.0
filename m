Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203DE3A48ED
	for <linux-iio@vger.kernel.org>; Thu, 30 Jul 2026 19:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785441270; cv=none; b=aLaQvfjzK362ChME1nJnsnwV+wNBoWIfCt/W+CG/vMUF/WpVhUioN0tbsQWBnqO4uHDplbM9G0Hh15jtxwIcPhkDqyurrbaJV3FQ1tKZR1SFdCrCkvietlL1v47n4J9F+WUylV7cA5+mGJmcdDdSlRWyzUbFWQE28+Bqx4KWm98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785441270; c=relaxed/simple;
	bh=rVGHrnlM8S0Tru24jhbKwCBMGMa41rcxjUCE1vIpC6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrUkjcv0TttViVhAH1kHYGcehTH66zvFYLfhabXOLtaHCl2QtDuF2uGddAARoJZzEeJnV7CRay65+P4CY94q8vKjtpR4EPZpw9gluTyC7ODRW17/KhaFtPMw/y95tX/lJ4bIER7nZywR+edBOPsjvGIe0/Wl3F0SDBMn5aaa+Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=MLElI9dR; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="MLElI9dR"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-495635a85d2so1401275e9.0
        for <linux-iio@vger.kernel.org>; Thu, 30 Jul 2026 12:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785441265; x=1786046065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rVGHrnlM8S0Tru24jhbKwCBMGMa41rcxjUCE1vIpC6A=;
        b=MLElI9dR2bwEIKgDWIKS6lMc7SiePuEeCwdVTrF/oB2kFj+bHfRMhRxoX4BuyBvCL0
         S3ImqI7lPCEo78J6kGVWajgad3fiLGhijYyKTJUHgfmHzZWC5O9u30HLtDJ4KcqtRYbl
         +P7tnNaYasFnPBN16a680uNqwO03B8f4SaYm+B7n8EYuS5YN1w4QvaVFDqqMD3fOI5vS
         PE6dT8im12ik9z+bq55nXuhlmFcEaDXEAtA6i4JuIomC40ZJbg6mAmiFG+C2O7TbNqjD
         +/23iHaP2Q79MVITxCzhrxVLWAnj9OWO1r0JzcLaEYS46iEdwThWoGxMtaA5u9dpK/J5
         nJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785441265; x=1786046065;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rVGHrnlM8S0Tru24jhbKwCBMGMa41rcxjUCE1vIpC6A=;
        b=gO6kSN4Y8C9kwh9q+eeOz6pg5n0Pm82W/Bxebvza+87EqQLJZVW4Y1ml5CEnG54XZv
         4rj1lMIX7G/tIKauKcNgibM9mKBVoZRm0Yj7aRlXC/BkwJ91SMa4J5E5gkQ0JUQakCc9
         ZUZoH+8kHttjDtp/ftbM1ftk0TjRnLG15PThFr359haIFIIF8TyrkIvX6Xtg027AN6vI
         cgQ4NNKmERqDuuGZuM4oCDXTC/AINYKYwSjTf9bj2p/OrYu9I4Dyyz5cJC7+O2vDt/zK
         3y642SfGYtU1616ASkwjWZLeYVdA0oxSA6mJxCbGYdsu8a9XK9b0xjArs72Lv9uJ/qCX
         vIZg==
X-Forwarded-Encrypted: i=1; AHgh+RqYHc9yRQBjRaSkmn6VOxGnM3lz3KuNKDAbbA6UNgRqoDIaQICPYdBhRhdRCrCOxQeuSTGIC7pDJsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnW6k431+8pNXZ5fq+Iyoec7YYbHY4FBRqYjsfsFO6XzX0C30e
	Z2hZXvV1wOcb3uNzToF0SZ1PfbjOdtaP11Sm0PjnKc42/etIsbdywybxjcIbTQzGK6Q=
X-Gm-Gg: AR+sD11a1uwkex4/9PhlOhTWHzUWgYKDMgdcCapnTwM/WbycogRUIQL01M2DEHwmiO0
	QAXr32+4eFJUlkXeN7GDU9FokBgFlb7e/qTgKwjzGBv2Z5wa3VVrjQatEDnUmBLdoPrQxM86Bee
	HW+ce3pKHQaanfVEm/V+XMKjeZNzTxqW4jXzbtXzgiEq2PHaWbdv6NLYbXAd0bjZAhYMRdIybyG
	oW1XMWm0AkvtmNSqg+ZZIpC1AxXfnVEX2OlzQTvZcgzHYtnZwQw97aISzKvW+/x3S+RfAbo+gT1
	XbU5VXtqCkCwhmD0s1d4DRzFCzsdynE1p+yL7dwstWMhWxuo/s/GdleVg5G6/nDBw6VIZq1DQVP
	KPQHDLcLTw7aImESISz9ZFm1jik87RO/aiB+O/mtUVAwzfN8s0FdsMD1lj4p0/ZXdlKUOfCpZ/O
	K/cAha5kpW196Lr8zOe6pxQmvFW/X5URiijS8VLOlLh+NqvAWm9RSVpZImtxxYaLi8lQ==
X-Received: by 2002:a05:600c:a3a2:b0:495:6396:8b67 with SMTP id 5b1f17b1804b1-49800e89181mr42298655e9.4.1785441265073;
        Thu, 30 Jul 2026 12:54:25 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-498011f341fsm71200825e9.5.2026.07.30.12.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 12:54:24 -0700 (PDT)
Date: Thu, 30 Jul 2026 21:54:23 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: proximity: add driver for Sharp GP2AP070S
 proximity sensor
Message-ID: <amurhVbZi_y0N55n@monoceros>
References: <20260731-gp2ap070s-v2-0-1bdfee07d5ea@disroot.org>
 <20260731-gp2ap070s-v2-2-1bdfee07d5ea@disroot.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6iqq33laew6sina5"
Content-Disposition: inline
In-Reply-To: <20260731-gp2ap070s-v2-2-1bdfee07d5ea@disroot.org>


--6iqq33laew6sina5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2 2/3] iio: proximity: add driver for Sharp GP2AP070S
 proximity sensor
MIME-Version: 1.0

Hello,

On Fri, Jul 31, 2026 at 01:01:30AM +0530, Kaustabh Chakraborty wrote:
> +#include <linux/i2c.h>
> [...]
> +#include <linux/mod_devicetable.h>

<linux/i2c.h> is enough to get the definitions for i2c_device_id and
of_device_id. Please rely on that and don't explicitly add an include
for <linux/mod_devicetable.h>. The latter is a dependency hell and is
going away soon.

Best regards
Uwe

--6iqq33laew6sina5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmprq+wACgkQj4D7WH0S
/k6zUAf/Sx1cl/BKPkqGFdNbaghmO2SASm11okWqQNPUBAASK9s2FJe8D7X0d2Pc
rxbD9qNMckkIkAmLcK0z25WgZBGBFp9p7JFMNNaNtODVdDrSzVAWkpVsCP+1KxKx
wpfH4GBPCJ7KZs5VSphtsnQZEUPocJI1S6+FR/2erYowET73idWdL578hdOguif3
gGC3nzPWAAeIr2NuLcA/wszaK7meQrPxhg24VjiqyZiKWV+sCg6btmb31dzv0U+w
iNJKNRoMfAACrLENOmFoF7u5Ca/msHAhYS5POf7oB3t3//qGzwY98+DPRHeZzWfu
loDsTIst5Wzn48eksG4i14baHoA+Rg==
=xgKb
-----END PGP SIGNATURE-----

--6iqq33laew6sina5--
