Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69D8328251
	for <linux-iio@vger.kernel.org>; Sat,  7 Mar 2026 18:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772907451; cv=none; b=VN0yL0Lz95DW+KtJU6Q8rROTiA1pk+QMI7LJzDVcBwb0/po4GTX+8LPvy4BkGXD8N1zY/UTRk9bBWJJjRdPcvGk2YaRk9chSaSrAEV8C1s0eY6U/jmP1oOgSspPrJP5U442N8QwY6Ve8o0Fw0wbGrdlSq1qMyJpU7zBZdr8wokk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772907451; c=relaxed/simple;
	bh=Ibbbri2MB7GhFcfgPa6chiXmHO3dxSvWIz4uDCK1P+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=H7rI/5hMeltw+/LhgxAgGM3d08WHAGIHySCB4aIhZhznDdoIYpJQ7yIEHlExipDgHTECO7gGe0v5vXjpyfqgTvhi6DKdeIaup+HjES+PhSl6b6kyHVz0xXg6N53ufjqzOvkB7D0ZL32rOzMmxGLSg2ltf0ft/lTObq0HXc3ziIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2oaBkZ8+; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2oaBkZ8+"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-662f5c5507cso8184699eaf.3
        for <linux-iio@vger.kernel.org>; Sat, 07 Mar 2026 10:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772907449; x=1773512249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xquXLJiyzhbEgf4b5MNljCoNXck7pIYC/7+CH0404uE=;
        b=2oaBkZ8+sDREnc3IGpntm+BFuer0jtOXHCI+maQx9ts/a285QEckT/MGTRpGUmohSL
         LiLjvscHReBcbqVh62LEMIkV4vGl01hHfYmDc1mUT04D7z1f2cJ1lhgzVTTQjQoLqq2N
         7MfWt7q9l+yLvcERTpga0zszeXFYfIOLlP4K6pGj4zhLhyBWwu4qT3RN+scJ9BhdFUi4
         /6T2Nc8BvhStwY/oHmnezL5zf61WBmY9LBfwEBPA1ktQE8zgIZX0p2NbnqPe10EMRasf
         m9iEFYqAKSFnGUv9MFkIhSBxm7rnI5SubD5CLpegMZjmVYBgcusdETRFeDslfPsuPQA0
         JNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772907449; x=1773512249;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xquXLJiyzhbEgf4b5MNljCoNXck7pIYC/7+CH0404uE=;
        b=sya9DgvewmsQikJT9gSBiMuJJ5X7CnKJn7Op/POfWhARgQC0QUNU3dLE2s+iK90ngK
         6CnATX1bLjRgXwHhJNXBFTlhmjH/sZdbVyO/eFBAvgBeUtVue7LlnMl+3DyJrWt65Fkc
         EntH2Z8a6TkAbTwJzw5rRlIEBLXubhzQLT/OCpqXvrJfZs3aDm1LHT2HnUoGIXgCfYWW
         1I2EUDi+VssDRQbFrQCWaCFUjh4YT0dlU4QbW+Rm8RaP9zPb6XhL7n0TLj9QNifmoQIi
         qvlUMzbRig/YyFm2MuNi2bTg9QS8pj7oGXPtcr34zX/oiBNOeBmJBAs5CMXTqJ+xKyzZ
         u/4g==
X-Forwarded-Encrypted: i=1; AJvYcCWyCWaRVQPvJif6j8U0wklD9WgUITnwYRVUrb61alasV3KI8bLRY6yln3NNq3fpcpx2QA+01rV1z2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEvr36rsTcEhz2Qte7hOHwAv7BWVWzKt0FHrPDCTXJudl1cJaC
	2IEHmcUXAegNk8gvJxH72H1r9+nIBemJE6h22U+i5vdo+yz+hDdC93/c7+jtG3k3lOU=
X-Gm-Gg: ATEYQzzjujmAM2teD4vqMlsI5ozGufo0v/JV5hjDGoCjDk9WY0HNO63a7RH4XAhTmgq
	hKhh9KzWrP4Qtuz0aYnhyEaC2ycSqoeS5IWfl9pcdeqWEOgwrZ9EHgao7xnexJmpKwfEoB/YUbw
	LN70SDBQ0Q9P8LcUbBmbqs2r284JdKDfUpi4zueXzEm++Kk1ECjT1Aqp6zIOiYMDyQNE+l2xNCN
	hZ7CBWSD4V3ltsnZ8HTNpTMvpheYjymdPqQmsZNDhKr5xvV29AU89Q6mtfG6sFZ/DFyvb2tvi5+
	2Z22jnZOWziE0wS86VHp7B5ttrk4+B2MMLr2teTe9xx79DkPzyc6rs/365TbCfo2tGJwO7fxbAP
	45ffiZgCVthsHZQYGWqD/z8S65mpv4K+dHSWxdQdlLoOLvyIrHyy8qwO8ZkH3tLzLvLjes03ns+
	Kzz/csyGCFzTNbtzphpEGVJOVAbgnIoaq+vc5A8DqbjY/AWdr/IxC52VZ44RKsCx6ztFI9UZ0PR
	Q==
X-Received: by 2002:a05:6820:4911:b0:67b:abfa:e154 with SMTP id 006d021491bc7-67babfae1eamr246402eaf.29.1772907448774;
        Sat, 07 Mar 2026 10:17:28 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:cccf:5174:fa72:c520? ([2600:8803:e7e4:500:cccf:5174:fa72:c520])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67b9d4711eesm2843371eaf.8.2026.03.07.10.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2026 10:17:28 -0800 (PST)
Message-ID: <19142d29-89ec-48a8-8445-5e3e441c1b8d@baylibre.com>
Date: Sat, 7 Mar 2026 12:17:26 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] iio: backend: add devm_iio_backend_get_by_index()
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
 <20260305113756.47243-3-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260305113756.47243-3-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/5/26 5:37 AM, Antoniu Miclaus wrote:
> Add a new function to get an IIO backend by its index in the
> io-backends device tree property. This is useful for multi-channel
> devices that have multiple backends, where looking up by index is
> more straightforward than using named backends.
> 

Reviewed-by: David Lechner <dlechner@baylibre.com>

