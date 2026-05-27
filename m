Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8104266A0
	for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 14:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779892533; cv=none; b=SiZhDz98ztjjMKYSw/4Z1JuwcCTIA1+goKbcbd7Y7i+ixxKQsnX1iMU8JKIAuJ4g9mntwGZ3AnyVbozG10TT0icW6VVqJ7hr/2UxHwJ8p8erNJOebcmHN8zDtYJ1PeJU8QW4OlK50YkZipUJrJA66B/HITVnSxx4GkcrcYR2BJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779892533; c=relaxed/simple;
	bh=UHrDsfIT6HzW7aWOXvesgl+qtaLdshwBJ70KFyyvRFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VTsyBuog89rxbIPjcCqlDRx6dIz4Hl5ko7K/bddxJqYNyUqVIp+Z0/exD4TRNKC4OTSdDJ6OK4XasPjzHXGsR5AOBUuaVaqRgIGJLJ8NrQy33zE0HoPh4OaiZn3GxZK3ELp2lsoyk9P+SkTIgQ8MfySFCK05o8dCuivED7tS3Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSGJ3bHb; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSGJ3bHb"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d75312379so10014796f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 07:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779892527; x=1780497327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5vy/NGwlSl29v1ZVzHPZqFuobCQzqOs8JJ1RlvNBnU=;
        b=KSGJ3bHbfHnyNfGdI+zpAAWr+MnOoFYBu6RZ5m+xYDPLZDyzIdCOxCHVDQFiQbhP9r
         FfYttF+0o0y4M5/R6TKX+4QBUz1na6zfJFans66JYzQoVgX4HBNwJ9WX/pyL1J4507LU
         IzhOjyksgM0LA3fEWiYzSorGmToerFf9Ir5oXUpm1aK+CdBGwucLqWDkAKk1OLEV25y3
         2IQvzuiJHIpoB3vxFqf1Fdu20d4zWwBt+euzqzxDy1aW48+y5menUIsWIhaDSxe7WJwd
         QQCHjoxC0wj7AbMHpKpspMRRzCtJrbwqrcV2UG20fTvzWErpnxqSgRoR6rgz5Q6C88gd
         dXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779892527; x=1780497327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p5vy/NGwlSl29v1ZVzHPZqFuobCQzqOs8JJ1RlvNBnU=;
        b=UTIe3Iae1GyO9bMqOyuppq/T3Rx1/j3S2xQAWHKKlpq5bx6DXe1BijLLwhkRCDq0P9
         NcKYFuHHHURP5/m5uBJ2DzWpsYygNjvDqnpmtsPWbAePfXKC9CL/gPa0cwORlicNtEsx
         dUowA5UXmRRY/xtTer/eJPg8ZXZ+xlRaAr7T1DMj6IB7OxBQA4dwoGtLrlkMCYDJ+Ehn
         LMaBpVM3k2t03xgQawnqs4c//Szszg+tET5A9HNhiXIK8zhk9bmcSqovdwWVgsoN3GPR
         0e+1j9BZeTRC87s2csPG8Kssufe4CC5nUu3TO7mJj1tI+7J6z2QwtkDqdc/KN+LOH/pb
         Ppdg==
X-Forwarded-Encrypted: i=1; AFNElJ/GnSqg33DexOLtPgEDmPGDneMbLR4rooSx1PrWuow7+xjhoP0vFJluKFW0QwRk8U0PnREGeC0Ai1s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0drUhyKJiS+8ncUCJsGGbVO9U/71NwiOEHUxv7CHK8lywgu+b
	4m/Xv5d9d/v2S7VfUT/FMgs3l7Fhy0Q3+o95+AhbWJsHzhOYHhrSlrUt
X-Gm-Gg: Acq92OGraDVZfO93/xzO8iVEcDW5uiMClwpElbtKvPO18nqnYSIrVNtHc6oCq5+pP7/
	P3sA8zISs/iNfJL7TUfoiWs9XWifc4Hn1U+pE3MgP6vB7dSBaTnZTLkFp/wc1AGxFUCToMW1BOE
	UFfjYYBLvAi/eqCCMPWN3Xe8daqfScmIPm3a7ReM8texek+3FsdoivLe9iAZql5DRvHL2aal5ci
	LBlcBuos/RbiYog9o++9swdnz9g4C92OAOLpcbj6K03oNA5weviLZlBLIFKR1FHsAhw8nQf4xF1
	4JiTn90Akt6aaB0J6IjwC4rGtxL6Upp/+c/9NzH2F5zbVBdUpRzuzDIH50nXtpDAoXqribrzec/
	v2YMpIXDmnsYT4t4beZ4Hdm+rOX/du6evBJJxByOHyW1+AV0c1RXHfLjBddsXGTlziJor95NPW6
	WUoh+x
X-Received: by 2002:a05:6000:25c8:b0:45e:b9b4:c68d with SMTP id ffacd0b85a97d-45eb9b4c854mr33983914f8f.4.1779892527240;
        Wed, 27 May 2026 07:35:27 -0700 (PDT)
Received: from sefo-laptop ([2a02:8071:50c5:5c0::361b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5584b8sm6239763f8f.11.2026.05.27.07.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 07:35:26 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: jic23@kernel.org,
	lars@metafoo.de,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jdelvare@suse.com,
	ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/4] iio: types: add IIO_VOLUMEFLOW channel type
Date: Wed, 27 May 2026 16:35:07 +0200
Message-ID: <20260527143515.102794-10-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <95f0914a-cb25-44ea-9cef-d203c624f74d@roeck-us.net>
References: <20260524205112.26638-1-wafgo01@gmail.com> <20260524205112.26638-2-wafgo01@gmail.com> <95f0914a-cb25-44ea-9cef-d203c624f74d@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 24 May 2026 14:39:06 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> Two questions: Why restricting to liquid (there are also gas flow sensors),
> and why litres/second and not per minute which seems to be a more common
> unit ?

Both fair points - Jonathan weighed in on the same thread [1],
so summarising for v2:

  1. Liquid vs gas.  Channel type in v2 just says "volumetric
     flow rate" - no "liquid" qualifier.  A liquid-only sensor
     like SLF3S uses it directly, a gas sensor reporting actual
     volumetric flow uses it too.  Standard-volume / density-
     equivalent gas flow is mass flow at heart and will get its
     own IIO_MASSFLOW when a driver needs it, rather than
     overloading IIO_VOLUMEFLOW.

  2. Per second vs per minute.  Going with seconds (l/s, later
     kg/s) because the rest of IIO is SI-based: integration_time,
     sampling_frequency, accel etc. are all per-second.  Drivers
     whose native unit is per-minute fold the 1/60 into _scale,
     same as SLF3S does.

[1] https://lore.kernel.org/all/20260526165950.6ebbf673@jic23-huawei/

Thanks,
Wadim
