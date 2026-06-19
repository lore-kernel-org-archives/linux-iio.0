Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149DA3939C1
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781879012; cv=none; b=DlpLTJ9Qr+WrcsSFS/jZ3Q6oAB7j+vSkumtQfOT4CzK6UjweLddJKUMa+AQFOlulbi3M+Hkk3v4L0VoPaEFGd7Y4A/SKxuP/CwyI3sqOjuiDI8CGOTlgC5JNQKoMM7qVKmb3yjguCGlZANbBZpfEvY1WzMFx5ltgaJHIJCEL4pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781879012; c=relaxed/simple;
	bh=0KgKbB/LFgHIVH+5Cu5vvnaBcTgSf1gspm8zvn8rEZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OVoZ1vYMw18Xrl1vm+FbOGYErir/DqCiN9PhYQmbIlROl/IBQuPqFVZ4A+v2vtGTft8dsiC0u+ItAK1OgalrBDP+x6Ffaqj40bkSSJ9mVa6yDv78fiEas7JXdOyf563NA16vnhF61xqKM47YtzM78gFjdTSbDhhpTcP7vpLjPa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=JEF7vM+p; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="JEF7vM+p"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-69de16f5f79so1170785eaf.0
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 07:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781879009; x=1782483809; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=afdKuEOlRvpeeu7or0T+Pz7xBujPRD0ovV3SVztW73U=;
        b=JEF7vM+p4k9PbK5L8j19y+f6CwbZnMOmtTaurNEHhHm/wAtk6bFydwJKpAuCZNO+wl
         B4V0drZJbEebODdjeZz+7PDsD+nldq7VA+oazaRf9cT3j9Xptx/4sLLwjiMgiNOCxPvr
         DYk4AvITHGQeI7RAH4zJTqJ83EBtdPMGR19jAxvk9G0YF0usGZTr+/8Rq66wPiIewTMR
         yiJEAKIwpazkPX5Z+bsogu7ZfiWWBod1m7TXZD5IYcz3wWmL69wLXc1DXsKOx/pbSJkM
         WDfN8Lz39GHiJPDBaU88lE61OeEDqt5PTgiuZLL3ZBw7b/OP43pGImuqtx3DS85mYO3B
         AoHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781879009; x=1782483809;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=afdKuEOlRvpeeu7or0T+Pz7xBujPRD0ovV3SVztW73U=;
        b=UJ+GHiw2SG2R/eSdC5XGGRMLorAkFlxU2CxsJP9MHvioq/FNo7wBDHHnEU83uoeaJo
         t6QqkuCqifidEDVwf1OHgkcRyoYdVYHojGTYTzW6pYxiQlTI4UL3nNxXYe9cTrhHJtVV
         M5R3DRUcmpP8MU1kS82bOHcKUVCj2vKQeaw89F9sk6P3rJfdISU9QawQVfq/d1G7pZBE
         FdUovN87Cl0/eF5Qd404W1ym6yR6ZaVoOdUdYs0BAf/3QE/CUFos4u/HJVM6uHDAHGo/
         QzYJJYnhFgul9YYHBCaVkeWl+qHQUskjSNW25VY/csYnhsBjaIlBsTg5wE2qO5VA16m2
         ZhTg==
X-Forwarded-Encrypted: i=1; AFNElJ/ruLSL4YuE3E0XAGtvcctZHNNhHN8sNY+/JmrrmoR4t1ZkIYXBACsViBJr8Y1R8gmsFR+tfZR5EEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHnM7UcxWHx2du3GmRlWTUfwUtRT0wnkn9ZVq5Sd2lHluhiL4F
	uq4EoxSPZ7+gv61ONTqPm51M8jHUt96im2UT5kSO7eTbJF4Ne1OuK0+n2sW0gltQjkA=
X-Gm-Gg: AfdE7cmh0Q7ACXW8Ry2U7LAKfcL76iWp44l2Lv3W28DgkyH0WA9XyxCz56yuo6uh+gL
	HuKXBcilSBAEeyGKiMBmOSVWr1Rn3GFVkDNfvYBoBNCgdQydm/GpdvznG0Q4iRKanXHCbFbwYhT
	oFppqP40PyJiR4qLj1UGVd+O8Pyc+tWuZPM8a6t31DhS1yEm0opEqKxYP9y94VCa0x4P4cAoMGY
	QlinMJFoe1Yu5DdkgmmGgGEfKhEx9NlurgvJQuXQCKfuuSBdDJQxzK5uDourvvmhCSXt2OkZwqg
	t2VAG4ViXt60L1kUmbu5R6WHOx/899LzPDvZXGrgdLGX/GKRco1kLiMpuZNwga/2o75lqPR9u//
	ggM5mfS+Kmlus3VYJWmexTnmyOPuqQguiqFdfhGmLaSVplXWsrsgeyewFl0JGGXXdHsEtFHwfN/
	LMl24X+tivTWfk0E2mgQkmdL3nQXEn6LrxKBYvO4Gmm27Q/Zp37FcMNtTEdw==
X-Received: by 2002:a05:6820:1f06:b0:69e:b788:36da with SMTP id 006d021491bc7-6a0de0dab5amr1962410eaf.37.1781879008926;
        Fri, 19 Jun 2026 07:23:28 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:dd8:d93b:3cde:c07? ([2600:8803:e7e4:500:dd8:d93b:3cde:c07])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472e79af8fsm15862fac.0.2026.06.19.07.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 07:23:28 -0700 (PDT)
Message-ID: <7b93cd3a-8aae-494a-a0fa-540bafcbccaf@baylibre.com>
Date: Fri, 19 Jun 2026 09:23:28 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] dt-bindings: iio: adc: Add reference, excitation
 and burn-out properties
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260618-new-channel-props-v1-0-963c1b5cf40a@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260618-new-channel-props-v1-0-963c1b5cf40a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/18/26 7:33 PM, Kurt Borja wrote:
> Hi all,
> 
> After submitting a patch series adding support for TI ADS126X ADCs [1],
> I was made aware by David [2] that at least two more chip families,
> ads1220 [3] and ads1x2c14, share very similar features (though these
> chips are not really compatible between them). After that, I found one
> more chip with the same features which is already upstream, the
> AD4170-4.
> 
> As David explained in [2], these chips are intended to be used with
> RTDs, thermocouples or other resistive sensors so they share the
> following per-channel features:
> 
>   - Configurable reference selection
>   - Burn-out Current Sources (BOCS) for diagnostic purpuses
>   - Excitation current sources (usually called IDACs TI) for sensor
>     current biasing
> 
> Given that these three features are present in all four devices and
> three of these drivers are still under review, my proposal is to have
> these features be described in adc.yaml and have this series merged
> before the three others [1] [2] [3].
> 
> This series is sent as RFC because I still don't have much experience
> with dt-bindings and I don't know if this approach or the properties are
> general enough to be described like this.

Generally, we don't propose bindings without users in the same series.
I was going to wait to see what feedback Jonathan gave on my series
before proposing this.

> 
> No dependencies between properties were provided because not all devices
> may be able to configure each one of them.
> 
> [1] https://lore.kernel.org/linux-iio/20260612-ads126x-v1-0-894c788d03ed@gmail.com/
> [2] https://lore.kernel.org/linux-iio/20260615-iio-adc-ti-ads122c14-v1-0-e6bdadf7cb2b@baylibre.com/
> [3] https://lore.kernel.org/linux-iio/20260610151342.44274-1-zizuzacker@gmail.com/
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
> Kurt Borja (3):
>       dt-bindings: iio: adc: Add reference-source property
>       dt-bindings: iio: adc: Add excitation current sources properties
>       dt-bindings: iio: adc: Add burn-out current properties
> 
>  Documentation/devicetree/bindings/iio/adc/adc.yaml | 47 ++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> ---
> base-commit: a50909aa46dec46de3c73235fc15a7d6f763d996
> change-id: 20260618-new-channel-props-4fbd52020da2
> 

