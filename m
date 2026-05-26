Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1D22BD02
	for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 20:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779828407; cv=none; b=iYJdpmg28Zwoc+Ub11ftCeIeSAjqqENCpGNcfpodn6VIqEfoCCLXuiAdlFIn0JEFx9HJfFE4t74DtwSKKLY3z16fr0Fv4GkTlSuawV/B1io07MsT8ZqTq7z/kCAYjDvkeKrqyzAFLElL9aSXPL+JCN7jiPw3pKheGtcm3Qg7opo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779828407; c=relaxed/simple;
	bh=2z5bTtd/HxPEU8eYLMrzRgawfNVrHqvpf4qq3+29xt4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=gf7A8VPLr/BuEk3ng7opI9depRZaPyVxoGKe/I2MuahpFbkaeEzQRSQjRXDo11LZFNZryVJaTXeT17T/KJ+LYwdOoTHrvvYQPNmhZS13Nsl2RApzUznXZc+LdfCKxVFPhYDJxhWSLT7SmR0Ksudh2n32kfN6ZB7RXvbMovVfxoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWhLAaYz; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWhLAaYz"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4903974854dso47730725e9.3
        for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 13:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779828403; x=1780433203; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sw9iPfDQzt8bW0KV99nuWsMFk8LtY4w/e81ccwJ3ovc=;
        b=SWhLAaYzSI/gcN1IvuSPrKabWDPi91V5uIzMGxNEXVoCd7ATx3iW3DHasA0aStYG4K
         W9BCc486WSrOd0hdiIQ3vF32+orXOicbi6DdsQQDYA4TwLVlzL92q8rlcSIIRse9gVw7
         2/BwX19aWvUeEaQ7XQ+AREZXkbJ02jEkkDT4OdY8HPLohlWkECP69yfZGzBMeHEXwRym
         kF9k2Rpf+LGth5BFHQBMW3+DczDrOmVigPr1hXO6wWcrhsUNMcEnFR/KGdBL09Z7mbCK
         T+WNzS93yO5OtxdP/sC+YrWri/kDvsNYRD40ZJwaVAP6yXHx95cc8RKUi9GYYrJBffx3
         dCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779828403; x=1780433203;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sw9iPfDQzt8bW0KV99nuWsMFk8LtY4w/e81ccwJ3ovc=;
        b=e0A/+zpD4fgSRsNulmgrrLbQTy/ZSc7cSr5j20BxxfZhqR/99JDk6P2ZGNCof+2ShB
         pqDJvKqjvQcH2pAg5QcGDmkJZ7ajP6somyt1dhqrqkqQH1rBY8OOWMwtqL6IFTrYYYwl
         U9cTa+6KH09RBI68NxzLS2B+c4a3W31+wwlZMNlScMijTNdd31YU6pLuny23EcGO3blo
         k4gC+s4eVeZ8DvdLy/G9fcxYveWztgPFUamPGy9Z/6DRlwpCoJc0FcWCB5Sa43TZPV77
         7r1t2yBw2POu1Uy86FUWsgAvHSaccWM93sf2TETZZaMmB05IqfBW7Ct3fBmu4yhgdbfS
         cAvg==
X-Forwarded-Encrypted: i=1; AFNElJ8hzKLKgybj48xq73zztj67QknvXAZeeaAA9tURRb4kFJUHp83Q0Oc3FaktM4HjgsLPnN4hBZG4o3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNnCxX7MXPWyTmK04CbzpcU8B4RirJpnSbjdKEjgTPPYhD27wT
	LKY4moundUwtrUoZwQ+FlAD3JkpA+1x7TZjPWdKwyG7sryEZ9mKkCrHI
X-Gm-Gg: Acq92OGITVw5LAIRpf4cagIPOcqJCfFlx3j5GEd0TWw+amoCnDRUeh78Nk9LLJOyJTQ
	uJ/kxn2SaSNtOoSzV4t3UVXvZFTxZ3M77lEynJdwm39dxgDPT63mGdd8XVd2D9upOS1GTnYc+jK
	Gthp+g1+4r3eXYWMSu3L/K8xwhqpdlbYhmwqdekkmFP7JLhi23C8K8fsmke+jIktiWWQ/zQZcYo
	SKDIEPcYA4Q9yyt4lcE9MrZkCtx76Cv0+9NLT2OWT7rYcR+73YVO00vZEwNXKK1+XWRBPaMu8zR
	sJeDQTP1aNn535tWvgCtI3AqK1CN9fBCQrQEBlynl+p34WmMpB+2HmXH0yDR4cyIMsly4PRQkzC
	Eu3DZyrDe8aLQo5TAroNxxPhee/HzFo5wwol9xKS4WLHVhOnhFqYj9f4rgrKjEDWv6PlAsN7sLX
	5LvTw8YbTM7cuEA85ObzdDoHb/HXp/85GtYvSsgiyxIvxbPnY=
X-Received: by 2002:a05:600c:4f88:b0:490:50eb:b777 with SMTP id 5b1f17b1804b1-49050ebb9e0mr298822445e9.5.1779828403347;
        Tue, 26 May 2026 13:46:43 -0700 (PDT)
Received: from localhost ([2001:4bb8:19a:6947:136e:fa14:24f7:1e97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49045284855sm356054775e9.0.2026.05.26.13.46.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 13:46:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 May 2026 22:46:40 +0200
Message-Id: <DISWIFAG1KHL.3CUT30EQMVS81@gmail.com>
Subject: Re: [PATCH v3 2/4] iio: light: add support for veml6031x00 ALS
 series
Cc: "Lars-Peter Clausen" <lars@metafoo.de>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Rishi Gupta" <gupt21@gmail.com>, "David Lechner"
 <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Matti Vaittinen"
 <mazziesaccount@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Jonathan Cameron" <jic23@kernel.org>, "Javier Carrasco"
 <javier.carrasco.cruz@gmail.com>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
X-Mailer: aerc 0.21.0-143-g2f3a2e260c09
References: <20260524-veml6031x00-v3-0-29165609b2b5@gmail.com>
 <20260524-veml6031x00-v3-2-29165609b2b5@gmail.com>
 <20260526185933.0084679f@jic23-huawei>
 <20260526190528.0efe80c6@jic23-huawei>
In-Reply-To: <20260526190528.0efe80c6@jic23-huawei>

On Tue May 26, 2026 at 8:05 PM CEST, Jonathan Cameron wrote:
> On Tue, 26 May 2026 18:59:33 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>
>> On Sun, 24 May 2026 23:53:56 +0200
>> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
>>
>> > These sensors provide two light channels (ALS and IR), I2C communicati=
on
>> > and a multiplexed interrupt line to signal data ready and configurable
>> > threshold alarms.
>> >
>> > This first implementation provides basic functionality (measurement
>> > configuration, raw reads and ID validation) and defines the different
>> > register regions in preparation for extended features in the subsequen=
t
>> > patches of the series.
>> >
>> > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>>
>> A few things inline.  Biggest one is that device driver specific state n=
eeds
>> local well documented locking. Here the whole complex gain handling mean=
s there
>> are a bunch of register field where the accesses to each set of them nee=
d
>> to appear atomic.
> The sashiko comment on underflowing pm counters also looks plausible
> so check that as well.

Hi Jonathan, thanks for your review to this and the other patches of the
series. I will go through all your comments within the next days.

I replied to its comment on the PM underflow, but as I only replied to it,
and then I forwarded the message, it might have gone unseen.

I believe Sashiko is misinterpreting how this pattern works (not
introduced by me, it is already available upstream in
drivers/spi/atmel-quadspi.c). Decrementing the usage counter is fine
because the devres action uses pm_runtime_put_noidle(), which in turns uses
atomic_add_unless(usage_count, -1, 0) to avoid decrementing the usage_count
if it is already 0. Otherwise the devm_ variant would be unusable
because it would not be possible to put the device in autosuspend for
the same reason Sashiko is complaining.

Best regards,
Javier
