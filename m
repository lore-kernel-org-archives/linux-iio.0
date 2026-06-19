Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11193B7B84
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 16:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781886924; cv=none; b=nDjr7qzB/zGK8tseyDuFxKeVjfsJwgzV+EdrHn1sozUk4ENneBE+U6rNj0d0s5yWklnFimyECau9ayc/7JUezeDJzA3jJTBuWA5o5KSNWfp/7mUAgZ2zGAZZWKreN8cp47Wb9uXHSdHlktwrcolwniLfnVIY7Han1nZLcIYPoSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781886924; c=relaxed/simple;
	bh=JXumolzQL+RrG5Z3QZK1JvP78d0zeS++zXbUCntpEDQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=AjJXyJ3w8zShyDiu8WlurxIHLhoBmGf8P5jsVr9eOD7bcNydltNLkBRoN28inTlcXbKAU/5HREMKarJ7wWz/UKJOj/i4fW2Lu02vUm1PzTtXkGwTrHwOi2BHyyv6eQvaG6Smg/RakhwisRhCIQ8t2eWHqkbnqFKNg7okvXIdm0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IB8XiVyI; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IB8XiVyI"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-6cfd17e9250so933746137.1
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 09:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781886922; x=1782491722; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVB2yFZpNawqKoDYU3GvJktv2Ea96DmwKNad4DsGDPU=;
        b=IB8XiVyIrt5CIA2QSfYoH9ZLycn/5qU97ug+4kPDKZfOZe/LlHUvAU/TAgUgkNGPUr
         /k9qA+SDe2sj6qrQ7ATzYbqBdNrtFqlPnUdOXEq6PT62m8SNVaQFoxz24diDEg8MmBr/
         W+W8Jyc2TNz13UrKDuuSfcm5vzI3hZWnLkh5YjO0iZKmf5pRJypWPHZPMslFVGtg9kJ2
         uxspj72ce6tf+vzbAs1PgDZOHoOorb+ntbA0gitHWRipg0KpT+efrq2j13cGTtV6SZLj
         qnJUyYy4xCm+OIwVQyqewI1zbz7RIT279F2dsXtim+5ID8Ii+E2F5fPL3FvtFdvQ7mFL
         T0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781886922; x=1782491722;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SVB2yFZpNawqKoDYU3GvJktv2Ea96DmwKNad4DsGDPU=;
        b=FtaxedrteFtUdc17I+JrckBh8+cl0HEs+kihM5EHWHmYEFtVheb20rJdLMJk/aLmsF
         vA/cy17TceZCI6f9HoRb7qNNOSFTP8/ljWou2Fkb4b5Co53zhT/1LS9zq5O0AN/LT2X/
         9jei68Th3ZZSfMzESbruHyQpTd3X/bFT/HYwfeAN7k8tj3cXz4qd2xktz1qzxS29tues
         OggKKKz0o5eQ3ZH2FFALquJL/eUycM0wtguItACK3YwcKiyUCS1RPHi99faa14iFa49l
         3L711gfSNt8fuFMgObsgdFU4cZIbdPu3u/jb4rTk48aiWzXuCzEuFMVXo6n5yeyGk24B
         qaQw==
X-Forwarded-Encrypted: i=1; AFNElJ9EfwXNCl5Uz5CKOCzlQJSjbU0UShErEv5zANuee4miAOGbZ6BDwpxJQ0hm4pULK6HuJfeE8kmRil8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzafUVOVI2IEfBN9eAaWTcQvxIhoRbuBf7kJusWP8DBnt4uI9Oz
	JcRD5qWLje7d590lfc+ERMkpGXVCdCdSCwiAbNQsL8mCwHNAVfHbOU98
X-Gm-Gg: AfdE7clfa99lKwT0ctuayUdUHpKQQYdA9gTdWBC7lcoIk95oo8czrM0la02+L+d4XNk
	Ijap+wTkD5e03FmyxRq0kNcCeldETLxw5ibs5NtREuf4QPS1XnPKCHdb90+MbG+SsIruSPhXJoE
	UsUly5dBnBlgB00KoU7nzklylDI+v10Ovr/aOM8xbPNYHxogRVKAYCMtizHq4xS3HcsI58MAZPq
	mk4SNJb19eRJ+1JtJLh8YTy8M3in60Mwgk/YZG3DZCUek05osDVVuXytmbOoRgTOv/k5EaOAIMp
	m8dy0rpCSgVJP1Y/RMx2RkhAGCk1Du7MkNfOG0DIZy+yh/iQ2zUXrCeN3GHG5EWA3OkEqeoJ/UK
	nWoPn0/Kc8cV9cVg/nMPtrb7bRDwmaRs1Tg624AafsMd0aZ+xgqh8GAg2NgTbptrAyfiWGS3ZW2
	ar7oI=
X-Received: by 2002:a05:6102:808b:b0:635:1bc8:3568 with SMTP id ada2fe7eead31-72a1f6f2bb0mr2661209137.23.1781886922372;
        Fri, 19 Jun 2026 09:35:22 -0700 (PDT)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-72a31612e37sm2079023137.0.2026.06.19.09.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 09:35:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Jun 2026 11:35:14 -0500
Message-Id: <DJD66ZZYZOZT.2LPF632YP81AV@gmail.com>
To: "David Lechner" <dlechner@baylibre.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Jonathan Cameron" <jic23@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 0/3] dt-bindings: iio: adc: Add reference,
 excitation and burn-out properties
From: "Kurt Borja" <kuurtb@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260618-new-channel-props-v1-0-963c1b5cf40a@gmail.com>
 <7b93cd3a-8aae-494a-a0fa-540bafcbccaf@baylibre.com>
In-Reply-To: <7b93cd3a-8aae-494a-a0fa-540bafcbccaf@baylibre.com>

On Fri Jun 19, 2026 at 9:23 AM -05, David Lechner wrote:
> On 6/18/26 7:33 PM, Kurt Borja wrote:
>> Hi all,
>>=20
>> After submitting a patch series adding support for TI ADS126X ADCs [1],
>> I was made aware by David [2] that at least two more chip families,
>> ads1220 [3] and ads1x2c14, share very similar features (though these
>> chips are not really compatible between them). After that, I found one
>> more chip with the same features which is already upstream, the
>> AD4170-4.
>>=20
>> As David explained in [2], these chips are intended to be used with
>> RTDs, thermocouples or other resistive sensors so they share the
>> following per-channel features:
>>=20
>>   - Configurable reference selection
>>   - Burn-out Current Sources (BOCS) for diagnostic purpuses
>>   - Excitation current sources (usually called IDACs TI) for sensor
>>     current biasing
>>=20
>> Given that these three features are present in all four devices and
>> three of these drivers are still under review, my proposal is to have
>> these features be described in adc.yaml and have this series merged
>> before the three others [1] [2] [3].
>>=20
>> This series is sent as RFC because I still don't have much experience
>> with dt-bindings and I don't know if this approach or the properties are
>> general enough to be described like this.
>
> Generally, we don't propose bindings without users in the same series.
> I was going to wait to see what feedback Jonathan gave on my series
> before proposing this.

Makes sense. In this case I think it would be useful for the three
series to have this first, but not up to me.

>
>>=20
>> No dependencies between properties were provided because not all devices
>> may be able to configure each one of them.
>>=20
>> [1] https://lore.kernel.org/linux-iio/20260612-ads126x-v1-0-894c788d03ed=
@gmail.com/
>> [2] https://lore.kernel.org/linux-iio/20260615-iio-adc-ti-ads122c14-v1-0=
-e6bdadf7cb2b@baylibre.com/
>> [3] https://lore.kernel.org/linux-iio/20260610151342.44274-1-zizuzacker@=
gmail.com/
>>=20
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> ---
>> Kurt Borja (3):
>>       dt-bindings: iio: adc: Add reference-source property
>>       dt-bindings: iio: adc: Add excitation current sources properties
>>       dt-bindings: iio: adc: Add burn-out current properties
>>=20
>>  Documentation/devicetree/bindings/iio/adc/adc.yaml | 47 +++++++++++++++=
+++++++
>>  1 file changed, 47 insertions(+)
>> ---
>> base-commit: a50909aa46dec46de3c73235fc15a7d6f763d996
>> change-id: 20260618-new-channel-props-4fbd52020da2
>>=20

--=20
Thanks,
 ~ Kurt
