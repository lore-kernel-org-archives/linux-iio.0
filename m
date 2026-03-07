Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F3530AD00
	for <linux-iio@vger.kernel.org>; Sat,  7 Mar 2026 18:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772907600; cv=none; b=fUCMCOpM4WI5+gjdhEN/v1SAILZBnfx++/kaU4xItnCm51ZQke4N0uhA6nxgSrEF9PnoXBeHdBkwmKmWInphv99gnJpbOg/pUmw1LvYp+JmScB0cQZMLDLstqmUexMvI4lUGIMRoBdXEXE6uaBWKWu6yUW/k/c/OgYttRQE8HsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772907600; c=relaxed/simple;
	bh=iUKGqbc9kjkZuVb5F5jw8zI/5zes+EzS9Wi/AN/pf8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lpiHkYTLA6jnr8i1v9NSasYP/Ua9X+93btt6Mesmmxr6JVLsVDbdYx0sUcDqlz2LSlkZ42ImFCrC7Gz0fN7PtlmOiJaz68c6iJmk1NzyO2tHeUHgaFFqFTmyfMKXFmSlG+e+tz64DSzkahVeVfb0mbpWwXUmXDZrHsGINUjU/64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PDQshXIP; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PDQshXIP"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-662efd1bdd4so7057513eaf.0
        for <linux-iio@vger.kernel.org>; Sat, 07 Mar 2026 10:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772907598; x=1773512398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4X5uKvGMI1FbAKrUUToddxkVkm26QOP4QqCDY8kIaU8=;
        b=PDQshXIPSPPwDKa0WYCDbm/fSnTR2OJveXfgqFMZxbkgfEO60MqKqm7jh5uro+nCVp
         8BrYklhowuDemjlR61ZeIiMt5nl103yOcB1k94xEc0aXxiOQJE2seojWww7bQlDqxaYm
         R19InmpmoeL9v1ECQlG8BGPdUAw0CCzInemqvuJin1u6pxH1M82hX6wj0jrW3oigQZwq
         kBY1qfHEyjhxqJ7aa2l0HNVIDPPabIyI3ogQ5WXr+3y7usvzTjlqtRusXr1pWnXgF/sk
         nqFqIsdIOVUmNllvkiouRb/ZXbjJBenCF9dT56Sco0LMAYZSn2B+O3WgWxnQETmThfdu
         i32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772907598; x=1773512398;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4X5uKvGMI1FbAKrUUToddxkVkm26QOP4QqCDY8kIaU8=;
        b=kTH8K76QICadKHAVVUgZrziarKV5hqsSH/GgOgmf4MxoQkVOyBx/RzcVUy6wQESXju
         IxbgX+9G167HmjEodusMzVfLNaXO2Rmu5iP7n62KX1gMqdYXeR8SbYXhHyl4B/6Jr3X5
         LqPEWH7FI6kmYdlF5YAsiNXUxtReWo+d+JjniSac4FO+/RjmXK+yCv2I7yzLwlmKpQNY
         4IybhvuwNXG/Rf3TmI1Cf+4XFrG1rS3H38C4t/vReMs8WOrHuzoeLBN8t9hdwiMl6B4y
         aaxCX2gAeMO8aFxWGlOIFZgZ71NdGKPouNohD3Xx0BG5ccVw1BnK9wsXLScK6QT8ozvI
         B3Iw==
X-Forwarded-Encrypted: i=1; AJvYcCX6ySnxoNy2bv8OFQRtLvSQeO4jgy20uapPfx0KVYfsq5K+W8LiTAYbAOdgXAzlEiqkKbEr1HAmlN8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn9rGDSRlwKxnfRlFnurq8LaOsta1ABYyNscmljQ4HOZc9DI63
	c3TMxM1E40p4qHi3Gx0R47nQrW1cyR6xDalqdwdIaSi4Kpp/v2t+qFLTIH17u7JeSjA=
X-Gm-Gg: ATEYQzzSu9xAGKAkltrTH7NuPhhqYaVChJVYYgGYLmcHzubWlNdXL93LmvdOWU06EJg
	yqWVt0OvPi2TxNJPjnHNe8zODf9RM3yPYUWfGo2jnkCqa6obM5Qb50fdeHG4JG+r0/VQXNLLClF
	Kap0Hj1ZqA4OCORlOn+uGQmcgkMPJEXqFjazJpRaO8wdEj4vHcsuXwVxSGj7FpIjPkNS8XubgFC
	RJeNwIbOj5tS4WT/2giT9rf254cPJKbvKEwzXaP8y2viJcz5P3y0NOUm3gd5u9ailTd1gY6maH9
	sekvKUWH/kBY1VDoi0z8gde3y13VlBKTQCHewGQ9V5w/4jFLNmG2ydLVBlG7kk3kPN+NQ7IapNy
	Sbudt0z0rpyBgkP8Eigx+kXx4IJl44QvkBT0QMXZhoul/gzLFniafoQCXkK+97LU/JAkx4NkeMH
	8Z7hzh98PXwoJsUAZecWtLhBrGiXomhQuemm5hpr7JH2s5Wpj/i1E2V/57kyYrq47dJ93rqaDVi
	g==
X-Received: by 2002:a05:6820:2906:b0:67a:471:d2ea with SMTP id 006d021491bc7-67b9c3f1d15mr3476921eaf.23.1772907598098;
        Sat, 07 Mar 2026 10:19:58 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:cccf:5174:fa72:c520? ([2600:8803:e7e4:500:cccf:5174:fa72:c520])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67b9d50401dsm3016080eaf.12.2026.03.07.10.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2026 10:19:57 -0800 (PST)
Message-ID: <059e7a51-2203-4b03-b4b9-c4cca08adabe@baylibre.com>
Date: Sat, 7 Mar 2026 12:19:55 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] dt-bindings: iio: adc: ad4080: add AD4880 support
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260305113756.47243-1-antoniu.miclaus@analog.com>
 <20260305113756.47243-4-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260305113756.47243-4-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/5/26 5:37 AM, Antoniu Miclaus wrote:
> Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC
> with integrated fully differential amplifiers (FDA).
> 
Reviewed-by: David Lechner <dlechner@baylibre.com>

