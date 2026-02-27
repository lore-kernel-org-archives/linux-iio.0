Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EA944B678
	for <linux-iio@vger.kernel.org>; Fri, 27 Feb 2026 16:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772208526; cv=none; b=agDe7o9RKz7gSDuPm+Fi9PMsz3phttlpLI5p/aFNPmgJrTU7ydhUHGy+QfcdELEykvVvBTxH24wrfB7KiiDkP/VcrkfgPC4b6NudtoLh0L828n9T20/dLFM7TsMgkhbOzFPaVmA0A5UdmOhARMrRvgInFspFxzrY3AIJaCbHmJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772208526; c=relaxed/simple;
	bh=STkeXZBzuh+YN7vlYJuUPRBvITseQafQdv1omnUABmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tkt7bJa6YArFbX5bVZl2qnMr/uMvh8P/o92YTtJWc+8kcCfDNCvx44LbgBnc2SUAQHuoVlgBLQhSe9/h0P64pGARNF12qnIayVQcXI754PI8X7l2q5EpuOo0twmito4g3QsXIqKZvYgXVsKIRfdhwDnCbnPrX9aQEKfmqFOZT4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pxne8VK+; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pxne8VK+"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d4ba9abbecso2542094a34.1
        for <linux-iio@vger.kernel.org>; Fri, 27 Feb 2026 08:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772208524; x=1772813324; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KtWJbD82CzzIAa0NPT1U1WDK0yBcottZE/DqnKgdU80=;
        b=pxne8VK+ozSmF4CUPYRcPrt1PVWITHaYch+mrdMVK1qRZtUJnOWQNef3thOh7Qdros
         8Ssa8wB88SdbuW0n77Bnjwgft7ECf0KsDZEZ9+9G4omks967tMEuFB1gp1Ia57JB/q8i
         jl1q1dsXsk5E+YBR+G90YV8cf0i4yQ+xtp9KLan1igUxIcd3PwStzzQSSPJO1Pai7vlw
         AQALr5nIzply3dg5gKCfwLskBlKATEkZnzPpCHkaEJkpPLJGE5tK6kNH80gtgQGVlyRT
         CKf6qCMDgvL6PaXsLSt/WnZ3fw1LyUwraIg9Outo3WuDnWXijFoklFXuV7u5Riww5ZtH
         H4EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772208524; x=1772813324;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KtWJbD82CzzIAa0NPT1U1WDK0yBcottZE/DqnKgdU80=;
        b=g37o290Md+4j5N0vG4NZieBTQW8CPpUHHW7QKm1MfuzBlloa2Rcus6colEPLjmJrAx
         njPBV9EJymGq1pekdLehUhbZ8taLKS8+IrmFLW2cqp4A3ulh2BftgCI9MGusgqTF9nDg
         Joe7DFxpo0anu8lk1TR5Ul1Mc8O08y+NYj+j76MIw4nKVMOQvuoVf6m3EkgPG1QAG3cV
         Kvxw2wC3OOTSVTEGkoOqgmCM+YlfinkXbn7duX31CaqzxS2xjMDxrHDlSjKXxcgzMjTl
         GA6H1J45FdMK1vECzvstdzPlpufeb7TfQ1/DKhxKOh4L76DDNDcua56dePo+e8hsfSiA
         VFrQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4bN+6Um+sgYas0O+b1nGq/jiIb+ayMtJ9sXZufbTFAtDgsNj77c+pFvt3DUmi8RxDXMUhAdst7qA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+p72U8hiX4iKyY2YE/Vf/mIZ3An3TnvT6zvHWe9hT2Nev7b3u
	dB7Ns+wQLxaiA49tUFxEMCxor2pahPcSEBV5t7L6qKMVFvrTnc3p5/NWoJN4pjhnFG8=
X-Gm-Gg: ATEYQzzZ68UXnUihfXXTRIrrbTUTH5xkhpN2AbafI+GUa/ftacEv13p5CHpSKbdc5Zi
	iCGSwznKCF4eK6Yg+/x2f++ztOc+rmbBbqF+WfS6jd2Fu7Pt5h9aLmI+XNoKJszgERejn3sZ5Zg
	g9lBtjg8S4DRlD4bUP63EA78kW4fI5Sn+4gg0gLvfFSHmwuETEZeT1yrwupa2jJaHROX7tVIKRz
	6PMDfzGCYT3Rt29Ob7uUUXqe3GKgLx8PEj86gG4OpS89UD/oO5v1hkYrUz0MCXW/ab4qeWUnqbL
	9tgkGuZ7X5MKH7+viiMiVtIWs+eHPji9ThTpMEUEMA4JWfGXguKD7f5j53Y8gITfeT2ECI/zbBo
	1qwDEAnF7gMW1ZXvoLLBXfAd5zLaJAW5mZGTf343Lcv6befup+nivAAUGsoMyWeDgtrmbSMJyXD
	+PUxXsAyUq5t3M4tqAA7WN1eTUIb/RK6dUHU4j5tkH/Q5RkXYTHdvO/bZM3GCLGpNA9YZnF1nxE
	A==
X-Received: by 2002:a05:6871:69a6:b0:409:62c9:5cb8 with SMTP id 586e51a60fabf-41626d87140mr2153992fac.10.1772208523782;
        Fri, 27 Feb 2026 08:08:43 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:876a:e36c:76c7:e6d4? ([2600:8803:e7e4:500:876a:e36c:76c7:e6d4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160d21196csm4799103fac.12.2026.02.27.08.08.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 08:08:43 -0800 (PST)
Message-ID: <f7203222-eaac-4757-9328-c34660a27eb2@baylibre.com>
Date: Fri, 27 Feb 2026 10:08:42 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iio: filter: admv8818: Simplify locking with guard()
To: Ethan Tidmore <ethantidmore06@gmail.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260227061424.1135505-1-ethantidmore06@gmail.com>
 <20260227061424.1135505-3-ethantidmore06@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260227061424.1135505-3-ethantidmore06@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/26 12:14 AM, Ethan Tidmore wrote:
> Use guard() instead of manual locking to simplify code.
> 
> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
> ---


> @@ -352,13 +344,8 @@ static int __admv8818_read_hpf_freq(struct admv8818_state *st, u64 *hpf_freq)
>  
>  static int admv8818_read_hpf_freq(struct admv8818_state *st, u64 *hpf_freq)
>  {
> -	int ret;
> -
> -	mutex_lock(&st->lock);
> -	ret = __admv8818_read_hpf_freq(st, hpf_freq);
> -	mutex_unlock(&st->lock);
> -
> -	return ret;
> +	guard(mutex)(&st->lock);
> +	return __admv8818_read_hpf_freq(st, hpf_freq);
>  }

admv8818_read_hpf_freq() is the only caller of __admv8818_read_hpf_freq()
so we can drop the wrapper, move the guard to __admv8818_read_hpf_freq()
and rename it to admv8818_read_hpf_freq().

I didn't check all functions, but might be others places where we can do
this as well.

