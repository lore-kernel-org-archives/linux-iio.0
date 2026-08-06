Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959BD3B19B7
	for <linux-iio@vger.kernel.org>; Thu,  6 Aug 2026 06:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785999177; cv=none; b=p3wASikDaOTytkfqPli8e21UVqdgszKfj38Atp8feu0cuYo0dKYjtmgV6FdZuZuLbcLbGvtBFAeVTKdSMv5WKaOhbwdE1FRiDZcmXIikl/0qCosr0NmJZBNtn+mKkENb2MWrBgtqrkaEXZHHQ5UNXcC0uEGb0kXNyUSLpFQlBUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785999177; c=relaxed/simple;
	bh=1Urfd82BzYqi/b40UMVFo5kyKw5wBdvlwB86+SNhMik=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gPnaM6hd7hj1MR0N3ZboVG1Va++VRxHg/ysuIBNKoev79EDffvas/RyPucK8vIECqbD+wAvKfqVtJvn7Jds41o4n0DtEBPqgM5DrgTfKFrTBKF7ojUlDDQo4HVauI3492+WX/bTv6uVjkdnPJpWogSre8TO33eN/zxO9kYISb78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GO9ojMQB; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GO9ojMQB"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f71156e1aso841114f8f.3
        for <linux-iio@vger.kernel.org>; Wed, 05 Aug 2026 23:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785999174; x=1786603974; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EQlr2SygKIgGeJXAqJI2lCJl611bv1E5PUmWcBTg0qQ=;
        b=GO9ojMQB5uKKfr5ZZjrckYT8mvPD+nWPLJzkMLb6JiQhA/ct3Kw619T1O/8XbcpVMe
         2I3XqoAmiJ/adzPoK8BnRwCD3jZvlA9a8TgRB07W6jkIRkAmFpxGiUGtV3+l6l8bRy/g
         bXSzEwQhQCdgbKO2sNk2dzwarcmR48ABr+J9U8dO9wgF/67anWxO8eeIGgYCLsBRv4Hw
         JHxb9tl6l/po89zvj9L3Rlxz7e6+LbRg1i/iarpIdzS6F+9lyDr9XyctJtDw+sgHwOCs
         +Otso55x5FshAmMljkx4hvkas/Bcg+In31bk+gzX/+wv0+piN075Ll3TaMDepbTB/ssX
         RSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785999174; x=1786603974;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EQlr2SygKIgGeJXAqJI2lCJl611bv1E5PUmWcBTg0qQ=;
        b=Z6N4OBo7TsyWt0tVjWHXWEOrWOFsxiYE8tm8zopwDzGdoAK6Gnd1YfxtVbOxvFyR+o
         SYWNVPtfR0gRy/zeG/wpQY261vZ488BCDdq6t8Gp0yXEScvEtXnKFYJbi/2iSUi/Q9TH
         P/q9/nROIiJWvwvjszBEjQ64S26f2G7SQ2oMvxd050HKCw13dXSr4dDzU3t7z2QG4sU4
         VAGJW83/WrdUqzLmC8jBmQmtxIWnVizBMWQ0KBY9ikmGxvj7WTnjLqEyXvkTAAJuCBIG
         2ZWUgKaO9zfLw/ZtV4wxDiD3GYQ68c0A+Cl4RQfNWa/wnsAaajs+5UAN8GNWPPCcVQgI
         bNLg==
X-Forwarded-Encrypted: i=1; AHgh+RrvxMGK1x0j49MCMwYfhVh/kMVBOwep2l8a9xC+mt88wDD/Huv1f8s+xvA11/vxYqWG7Rt4bJGddBc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx27DNKO9VF+dskYFtqrPvoiY2bYfMitl6ZEBhzLTapXr4qdwZ7
	4WlWGy7F93AoQOMbJJPbaP4bGW7rLKJx72ggMkFdTEHdbYjp06XOn3nd
X-Gm-Gg: AR+sD13P1+swbEhntFjQp/Dd25khwE9Y2i9bKZ6QOns89yJPX5CLdv34ANNgUkujLdD
	fhvZGuK1pgQH7CIinyI2AKUt5nNA20J+qYoxY3k1vHc4buD98a8sgDuyrdhJf7DbEGEE8m0WBqj
	PgnUjKI/0JMt0hgg7KPYiaZRmmTKW/YPdXpdhpge3hdCw17cwDRGr11MjShffAUNba+kg7ljBJq
	SyWobHaPGnPzYB7Jg3HCfLy23Aa5RFsS+bbb9zYuRATV4A9U2b5yrLzl/uh3BngrRxON3Br0wvZ
	YwTrvpEPHE5Cprn6xKFp8dVphSonh/FJ6EkBn2Ib8mbVYH+rQCX6ubnyd8UtKlA7K6ea58pCBUy
	KM6KALlo11zVtzq41WHftSBwW3GMvalSHiWDkPQJu1ALWnkVIomso9rxbNBiJMw3VXmgVhSW/70
	T7tpKZ/rYJ8GSh9+qG0RkQdgiC0hxtlovDiI+GcG1JMpLXbpCSkqt3TIOI0zCsBTARWT3pJs1oo
	evhtgeNnteCcSGly6JbKzsWeWlDhPcGXqBSWQo4nRAzEYYsMyxV+krp4GyAW9N+t7sTrcqJ8d3j
	3y/U7K1N0Nw/ttfBfZ9nJzUw63tupogh4mmA/7c3V5SrC9jdnM5peXLk8W3MTHzP64VePrSaEUJ
	3TpLPTCcbv2LpJO885jM9SfLUD3VCo2idsOS0UKibuaZgnfUiytnH/nWmr6wzvLzYHcezV5I=
X-Received: by 2002:adf:f4cf:0:b0:47f:776f:3838 with SMTP id ffacd0b85a97d-47fec5030e5mr16760512f8f.6.1785999173605;
        Wed, 05 Aug 2026 23:52:53 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff79b32b1sm3681466f8f.9.2026.08.05.23.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 23:52:53 -0700 (PDT)
Date: Thu, 6 Aug 2026 08:52:52 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Giorgi Tchankvetadze
 <giorgi@tchankvetadze.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, "Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>, Danilo Krummrich <dakr@kernel.org>, Takashi
 Sakamoto <o-takashi@sakamocchi.jp>, Dixit Parmar <dixitparmar19@gmail.com>,
 Keerthy <j-keerthy@ti.com>, Samuel Ortiz <sameo@linux.intel.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: twl4030-madc: read MADC_CTRL1 from the
 correct module
Message-ID: <20260806085252.00004282@gmail.com>
In-Reply-To: <20260805123201.219547-2-giorgitchankvetadze1997@gmail.com>
References: <20260805123201.219547-2-giorgitchankvetadze1997@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Aug 2026 16:31:59 +0400
Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com> wrote:

> From: Giorgi Tchankvetadze <giorgi@tchankvetadze.com>
> 
> twl4030_madc_set_power() does a read-modify-write on MADC_CTRL1 but
> reads it from TWL_MODULE_MAIN_CHARGE while writing it back to
> TWL4030_MODULE_MADC.
> 
> Fix it by reading MADC_CTRL1 from TWL4030_MODULE_MADC
> so the read-modify-write operates on the register's actual
> contents.
> 
> Fixes: f99c1d4f94f9 ("mfd: Add twl4030 madc driver")
> Signed-off-by: Giorgi Tchankvetadze <giorgi@tchankvetadze.com>
> ---

This makes sense.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
