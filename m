Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793271146;
	b=ssnZdDCBfRzoeb2GkCQbKmEtmBRz6KDhLPxOifDWM61EHF8tp/yQUr6zNCuUa8m1xiOU
	 7F/87BwGemRVUx5qWdbuXkU8IbrEC+gduWVJsD+tTFvydGZDRI6te0c3wY6e9+Nts0jyK
	 Nx7UKrIdmMBT8j5diqf6UJ4jXIgqHwDvvLun6f1NW85Ek+yh7p2eAsLpIT1GXhAC3mifU
	 L/e2HZTLMBJiq8c67wzV7LD4cfQGy2eaovT5JqXvf95k67LPY5TQ3fjTmcTUQk1C1UZjR
	 AczkYXnqEhSsZGaxIV80zyBkfnPtz7n9GnzfRPzR9LMUqm6EUCaCnrkV+HiOWF02wyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793271146;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Z9CuJJHkbbNNuzLS3GGtdXngJnS4fF2IBPDFiplXDVI=;
	b=jStgtRZaJ12L+BAAgdSvImaws/6V8A8rKEijS8Q06/R3IKrpO569iY+10EDiqvMZoYRo
	 8fJTnmpg/R+DkCc4WIF8zQ+QfaTKG10ixq1tEdJjZihRSdd3spGcCSusGpGxDEdBC86ih
	 HzNiO4Vh1/GFxw5V3TdsSsINUrsl/n75QcWfUX8uR8cUHlqrsgyoccrXz5/fwnEm5YdEB
	 txh0v0jV7locKnbMx1h2g58NZ4EUYo9mefD46RUxRn4vwSCCEGEfuWo4tOpDYAD38ql39
	 9XLKU5ig63Wnd05pUve0GjRVv8er0wKDclkFwlq7e0NU/UMkDkt6gaqQysIfQbrQbQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PsYvEjgx;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A6A606A325
	for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2026 10:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76A6A606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PsYvEjgx
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48e04773687so762997f8f.2
        for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2026 03:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793271145; x=1793875945; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z9CuJJHkbbNNuzLS3GGtdXngJnS4fF2IBPDFiplXDVI=;
        b=PsYvEjgxQzAaHbqnKMmKaATrRLL3eF78bLWpfKuowjhm9iKoiYVq+QgV27M271RkK9
         U0lV17SWE2FvHqBV8dHwPsyXM0iiPfahckMTEUjM4vepU2oEIRv9h4vPrVWCSKYV1e/Q
         z+ZYVBCIu1iWfyuTGFHun73FLD3PUyseydCFA8M/ACRg1UM6cJVeJLDl7qbu4gZLm+mP
         CKCsKhX/rc/bgD7Rrh9Nx3+81uQ53QlJTEjJ8mXQQNAIz8NvC+rBbb6CXewLhr74D48+
         Z7iYe08xhjdECnx0favoECnlXvKP1cL5eaJ/P8Wy9fI9htrlCFYOlNLFFQqZ8T0v9Z7z
         Salw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793271145; x=1793875945;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z9CuJJHkbbNNuzLS3GGtdXngJnS4fF2IBPDFiplXDVI=;
        b=xsmEBVyX5yyr/h/Qi8928EwIjrjNnJWE1WV1L1x6f9VK00cpR46Iv7nrK659NkcLM5
         /lY8V9TIOON1nutu2dVNXjVq2QUUaYKn1X3IA0KB5QZpZrwvjHCHpapX/YSEtIhSsJxa
         H5l1S2wexhvRoQcjMDUZqtWsLPuixlpsnCS83uDuj0fwMV01yffryasYKiPf2owOTHPq
         lIy4alKX6Y3K0wbT+x0nQEWFzgBjlrBezNumNbe1VhTg7EgRwA5irXG7V1RBeZQ4v7es
         MUr25NBwbRurUkHtv2sfb37pfoZbRgCV3y6+XIT43uOCdUhRoTuvLxYpnIB1d/KFNLx4
         n3sg==
X-Forwarded-Encrypted: i=1; AKwUvBz+LJdzd1tG5oJrclq92idSp/UUiZqnHZ8+F36JVB0XvctVjo5Cl31G5PyR+Iq7cY6u77a78IBy7No=@vger.kernel.org
X-Gm-Message-State: AFq9FYIGEdmHkMvp8reXT9+TCSPiWdXIAWmSFQxOm2NY6InZbbwedj/P
	hrowvdtNxHp2r/aTTxteb7WCBuxrFpLWygVH3aQx68mm9hP5m2Uy1ZOG
X-Gm-Gg: AYBFou3n1pKxbwXvYfpAX8kHFu/JKXR2PD9YY0+XN1LM8mrVhTrnmA1IY/Xpkpkkzft
	4pLYF4CP5vcq0Hzj2hMdmY+3T5SEC3Vgy/S1pecExrzqC7s4eG75E2uskUOv4djaPDzGl9DSdH+
	SkujpEp8xlkdEF41L0dexdcpAI3DczceKJ8St/gdx6SGTVLrUBTE34lQibIrxTo3MOAoovPKWOt
	PUGggwBtwwFy+sNQLoLEizyH73HlqozcQB1MwQjIG4j6keotcliLGx5+QlPy7oBPDe5+smoAU47
	IQALY/ifrNqMZ0SmBX8Gbcj2KNGsH51sKdmmdf8nUB+Sf1yvi9ON5/FhQv9tN752gekj5Mu9cmV
	8lvbVb3RE5WfZDRrxHGEVtBWWlM1e9MaYFuyov/U/RN8S3UyLm7z4ah8Un2rvD+kxzhLPyL5thQ
	wGQbL8I5XVhPFLJCWjVtVRY0DWJuCw6AswJ9Z5Q7KFa1uEBsngB7sWbBYY02ieb30O0TmQZ7lo5
	iftzxildN6QiY+MU0pwX7SO3UqDc5UTB7Jee6y9jHp5RU2dOecjgLQ0e/FdCCD/KhfCp4LENNWL
	0QbiYerYELyi5fnnoIphVykA5CmWPrCt7EKGvJEtxfgkpw==
X-Received: by 2002:a05:6000:2284:b0:48b:f08:8159 with SMTP id ffacd0b85a97d-48e5d46820amr12549573f8f.40.1793271144749;
        Thu, 29 Oct 2026 03:52:24 -0700 (PDT)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd8ddasm36664688f8f.48.2026.10.29.03.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 03:52:24 -0700 (PDT)
Message-ID: <7558d438-5d5d-41bf-8853-33bee931dc50@gmail.com>
Date: Thu, 29 Oct 2026 11:52:23 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] dt-bindings: iio: light: add as7343
To: Chang Yu <marcus.yu.56@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joshua Crofts
 <joshua.crofts1@gmail.com>, Shi Hao <i.shihao.999@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20261029074851.216029-1-marcus.yu.56@gmail.com>
 <20261029074851.216029-2-marcus.yu.56@gmail.com>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261029074851.216029-2-marcus.yu.56@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/26 8:48 AM, Chang Yu wrote:
> Add binding for AMS AS7343 which is a 14-channel multi-spectral sensor
> with i2c address of 0x39.
> 
> The GPIO pin is not described because the datasheet does not document
> how to use it for hardware synchronization at all. The GPIO register
> also has no mode-select bit to isolate the pin from the chip's
> internal control logic. Exposing it as a generic GPIO could result
> in kernel writes being overwritten by internal logic.
> 
> Datasheet: https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
LGTM so:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
