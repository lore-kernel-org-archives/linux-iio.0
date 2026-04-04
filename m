Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1458D30E0DC
	for <linux-iio@vger.kernel.org>; Sat,  4 Apr 2026 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775320176; cv=none; b=EfafxGue/sVBKHl5jDsGlOawuinEpvjb1BEmNhdPOazNOTliEysmuak8XpKcZ4/CYI56WXUMKDWFeUgHMWKYfCc4TEhVKbbFtymgqnle4HKsq9Rh0nYO10e6MhfQ2Ci4q7Y4firaY07zEkA3XDvAQA4nklaqDSzNgLaeQ2D6osA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775320176; c=relaxed/simple;
	bh=J+mH3tlc4DzHrOdvjC92wgc8hfC/3o2s8GlMhvE+s00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fhnnd460K4CsGLSBfJUmPEUlDRTBTlfHw3oOYoSoVElBPCZgwx6avX3xHmUbYJC1anLmuzxACr3mIGyU/oOIYIrLOxcj98x1pZ2nzmV8KlrHuak8mFVrvDOwI8SvXUROlEIrO6jx5DSd4A9si8cFScRxTci2vEThaN24yjMeKIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=FjqMWRoZ; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="FjqMWRoZ"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-47018d34159so782414b6e.2
        for <linux-iio@vger.kernel.org>; Sat, 04 Apr 2026 09:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775320172; x=1775924972; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=++8C+TxvxhaCAqikK6VYVaMY+sXmVJh/F3nUP9aaBRo=;
        b=FjqMWRoZY8egRIS+pC8sqmz1d+eervbT0T9RaLaNDHx2V+K64WQKDoR0sqK2Z7qq/2
         L1+04An51bA2B819ZzMZADFhlE6TCn5WTiYf7Y3QzFVjQpt3DKdqGlsz4LvM/wiGJlm2
         QGu/L6nzolw5olKLwHmR7DJIcSGC5L7uLgU8j6yYV4Qx9ZtxIZpwSm68XV+m4f5XVMxs
         j8x4dk7jDrFxenISkI8CVGAJuj3FnwN3aRUPf6OBg2Ol2SS6XvW8/E0ZehnxBxn+8MbN
         3aSdNSBVD58piT1McaeTYoJnOwBV3l7Fsi3dgqY9OmyCKvKBwGFHHizCYt2lDAncHACj
         yINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775320172; x=1775924972;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=++8C+TxvxhaCAqikK6VYVaMY+sXmVJh/F3nUP9aaBRo=;
        b=d0aGDdIB98l3/G/Vt+RLnBZCTJ666HaugcDQxVT+/jZlvanT1Xjh5aAqB9byYKF30b
         ZIYiYGkS1/jfD4jIbMdsibnxzC6CE7Bdv9eY3buKXqbixxwx62SCOo4+EzLK/FdG9sWn
         oCvGyGuzwLy+72MXJjI2ryyAqxyzBtmwOZo5ll8KNpfOUjePZfpEpXaqm9a4nw4S23w7
         NNRtypxrjR86H8PaYqsvgx0nfNnWiNbtHWz3I9GsIVShFZFhq6CPFBCWsseW7W5qUu5u
         QsilfxIiSBz70N4+e1XC1iFFN9R9yL06zInd14V6I3P2dBy0xI13f9V183uVvPXj2gRT
         /+Sw==
X-Forwarded-Encrypted: i=1; AJvYcCVzrmJQjLI3fSNkK5Z4T1RzHTg53OokB8UZDUif8x5Gtaz+clbWcXVm0240iZLynnwhth/+Uj8VDsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYVgypzoXf4y/Q9UUVw9+SipSbe3NZsO30CYDvzOP7fI8QJFcx
	vhcAZn0dJm8rWwgQiXo8qWiJ2XspFstyEfektj9tup0DyJgoAvWcQGf91RfIwFe5dtw=
X-Gm-Gg: AeBDiesdOpY7okQyxsec4pBrU421mOwtfmG9lgrjIbT8UxI2Q3Y30rMdF/c7mbmkeCI
	47F6kUxuQ0u6uelPkV+doxUPGTTbZiVu5xcLRv/hlUUClfOM6RLXXqgY1p7cg27dFzlWLvCkWKE
	1gnSPBC9s7eu/CatDQGjMGc54jOsb8V5fHXbeO7DOzvmZHN/Tss4oVJMoJT3X68FntSSdWaw8zV
	JX/rnSBJsMEPJDRUv0roJcB/KNuAbtTGANARxJIb9RZxQO3IziTcyzcOMu6SdJqkgZZ7J91iAkH
	aaLhZnGKv1lVwsNKPH7YaAXuW4Xd1C+yqrLiSv2kfhmmwtdkEjK1ObtHYZqn5ZcBneIiK8pA3pL
	JQXvL7FisuSvJSJmeaP6N191dr+KF6iKuLa6UtmD/yO7+5Vdc5TN7xErSgNjOqXx9nWhbfs3Zea
	ApQv0u+bQZeYqZC72+TOr0X3L4qOQc5iICX2/LDknyPGrvNnpB1C5blxTH1fvoquUZM7sCXROSG
	A==
X-Received: by 2002:a05:6808:894c:b0:463:927c:1e3d with SMTP id 5614622812f47-46ef66f9cd7mr3956595b6e.23.1775320171996;
        Sat, 04 Apr 2026 09:29:31 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e14e:bcc6:3f95:26eb? ([2600:8803:e7e4:500:e14e:bcc6:3f95:26eb])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46d9387a763sm5220382b6e.18.2026.04.04.09.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2026 09:29:30 -0700 (PDT)
Message-ID: <fc46eb9c-abe0-49af-9f19-fa06f6cf2847@baylibre.com>
Date: Sat, 4 Apr 2026 11:29:28 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Move adis16203 inclinometer driver out of staging
To: Sheng Kun Chang <nothingchang@mirrorstack.ai>, jic23@kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, nuno.sa@analog.com,
 andy@kernel.org, gregkh@linuxfoundation.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260401162458.88110-1-nothingchang@mirrorstack.ai>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260401162458.88110-1-nothingchang@mirrorstack.ai>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/1/26 11:24 AM, Sheng Kun Chang wrote:
> This series moves the ADIS16203 Programmable 360 Degrees Inclinometer
> driver out of staging and into drivers/iio/accel/.
> 
> The driver already uses standard IIO channel interfaces and devm
> managed APIs. The only missing piece was devicetree binding
> documentation, which is added in patch 1.
> 
> Patch 1: Add devicetree binding documentation
> Patch 2: Fix MODULE_LICENSE to match SPDX identifier
> Patch 3: Move the driver from staging to drivers/iio/accel/
> 
> Sheng Kun Chang (3):
>   dt-bindings: iio: accel: add binding for adi,adis16203
>   staging: iio: adis16203: align MODULE_LICENSE with SPDX identifier
>   iio: accel: move adis16203 out of staging
> 
>  .../bindings/iio/accel/adi,adis16203.yaml     | 52 +++++++++++++++++++
>  drivers/iio/accel/Kconfig                     | 12 +++++
>  drivers/iio/accel/Makefile                    |  1 +
>  drivers/{staging => }/iio/accel/adis16203.c   |  2 +-
>  drivers/staging/iio/Kconfig                   |  1 -
>  drivers/staging/iio/Makefile                  |  1 -
>  drivers/staging/iio/accel/Kconfig             | 19 -------
>  drivers/staging/iio/accel/Makefile            |  6 ---
>  8 files changed, 66 insertions(+), 28 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adis16203.yaml
>  rename drivers/{staging => }/iio/accel/adis16203.c (99%)
>  delete mode 100644 drivers/staging/iio/accel/Kconfig
>  delete mode 100644 drivers/staging/iio/accel/Makefile
> 

Quite a few people have attempted this already [1]. It is likely not as simple
as renaming the file. Please review and give a summary of all of the previous
attempts so that all of us reviewers don't have to go read all of those messages.

[1]: https://lore.kernel.org/linux-iio/?q=adis16203

And when reading those messages, you should find that the rename patch needs
to have the full diff (I think this is the --no-renames option to git
format-patch). This way we can review the driver in it's current state one
more time to make sure we didn't miss any cleanups that are needed first.
