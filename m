Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E7213A244
	for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783784948; cv=none; b=ivH0eZzqUzyy+SkZdCark/NGaQn1PFIWPaBNgP6cnEHAEAPnjpKLF9/TismQTn1uAGD+MblwVm9LUVCs//V1XZwjHiX/atTsbYMn1NupgmzUJf2Tl7LU8b78/w6YVFN5G+n0v7Qi/69rH4SVJEYvXpBl0CCXT31Sh6I65B3tLvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783784948; c=relaxed/simple;
	bh=cNxVYmciaGx0HxZhzCE6dp9hIUsKTjqHkSJazoMby5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PX8xCBgiax0Z3dqzhA6ehPi2PV4RcI7X5JCoBqwjmax2+cHRlNl3TOydnFcYTAQVLNS8Gljtj/qJiUhoLgNzWT3BUOOpsqlSi0cvQ1FD5AfJyfNMX7f7TfFn3I6GZW+jWUz+Aau1HiLEwaOhJ6aZV/Tnwwk+RP/VPX6tZTrUjfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=PV1kHeUZ; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="PV1kHeUZ"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7e9ed64d490so855696a34.3
        for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 08:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783784945; x=1784389745; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qBNOQnmDXwx/WMHGnaOrdiEo9LQa60JbMecTtADGoTo=;
        b=PV1kHeUZCweRq5mgDup4P++nr8R8A/ao+OgSrW8uJ8qyvrpCa0G2FALhS+ViqjI0qA
         F47YktZ1+Bv0UsczXggpfVY0ZAWxkRQWUbM9VbAeFKSFGhWLZXSebNhB8wnsOy4XD3rY
         9Dzogte8lJ5S6Hu96jin0+ZnLX3K/YEm/d70YOqeR7gy5OGscN0UMjd2lfc1vBwH2v1C
         moLlqQklHCGroUUEwaT/TDg0HwOZF42lLvMqUqc0nNlVa5ai9bUchxa0RPMUf1dbeOGt
         YFebizaCHFkeK6PjlyERxNBc3gFC6tCsuHsrBN7QqaDRtAtxvpxCMclneB2vJp1KvyU5
         jS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783784945; x=1784389745;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qBNOQnmDXwx/WMHGnaOrdiEo9LQa60JbMecTtADGoTo=;
        b=DWPppU/6M3PRv5gR7SWAqH6LcYyGEfmXzV6QSwVcSBaNynHXC+Vlt+UPDtLqPzhHJW
         ERUeTvK4ynaevtMpIvO84OdclS/JTPfCVxV40jmn66NCxW3+WmUBsb7PZvbuKgdM/78Z
         +fGHZsFMogBiFfN8K7Z7hnHj6RlDNcNPKEnuM8K69ikIzMv09akqZNGpSalwZovI7+3R
         lnaubqhmype0ANFu/S25k4sQ8HjeipbrC72qr17aE3ZssCCtdhtd37WxYoG3uo4QrWjl
         boBX3Vb+oDuYCdwQEuIIeCOJhQx1Z7CyLEnzQRl/cK6Gub4/J8+qIZZKUI8bjBDev3un
         dX6Q==
X-Forwarded-Encrypted: i=1; AFNElJ+AVOsOkAGReOqc9wy3O+pGTW9mgFn78Yh6/qWe9u/HK8Nv1hYoeb0QZM2bWIdZdydTC1tZSUMc1Lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcT8h4zmvGlJKz5RlR/574Md6mWwYJJuDRG2A4nIO3sAN3SE5J
	zULWJV3es7bynSmOsqi2Xjf+EH5X77m74t1/0dW+/keROTdRJBXeIxByW+13XGwS7I8=
X-Gm-Gg: AfdE7ckav8X4zzJA8v8scEYIKWJAkHQLxQ2EPdyEAmnK/wlbleJFNTVjUWqPe9h5q7d
	SS9zLfwbmo1l6b1CKkkkDVvb6llEKn3P3Jm/HQKKOjGkcHPgwS2QjRChX7cqROEpg4KCACFcj2W
	Y9nQgOB7Mi8nSMREIjZGeSyn7zz2efHeXNQzDByrppIbk4BK42xC01zN4dGgtIqMKC5MPTrX85x
	Xvm7L65nRBBocCUZoXKTKDv2oCTjFbiR1CDgnMJPGZm4oS65dHd1HIU79tmG9V2A29P5BUmxLjx
	L3aEdj1kMj3YZDNXEbrdZMSpTVRVgWv4WxEAZ7eHC5IEh16J8O/6inak7vOzfo9KOSQnsPmXO2q
	1/LZYr6/jcazfaCj/FbP/Fn5ptF5SIiufUWjoNubp/xIrgzgo9JANgtLfQH7U1HVPbIwaAgCPpM
	VAGmZgGC8WnT/pI0x7l5GNNpGp3jtfwrgtWL03dBsBjWuIifAHRG35W+JlKZGzt38=
X-Received: by 2002:a05:6830:3e03:b0:7e6:c819:22e9 with SMTP id 46e09a7af769-7ec097acbe7mr1938308a34.17.1783784944833;
        Sat, 11 Jul 2026 08:49:04 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:a950:74e5:81f2:8c89? ([2600:8803:e7e4:500:a950:74e5:81f2:8c89])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcab8efc3sm8657965a34.0.2026.07.11.08.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jul 2026 08:49:03 -0700 (PDT)
Message-ID: <d0d6e0f6-2b6b-427b-96be-84acd49bbac7@baylibre.com>
Date: Sat, 11 Jul 2026 10:49:02 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] iio: adc: Add support for LTC2378 and similar ADCs
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 julianbraha@gmail.com, marcelo.schmitt1@gmail.com
References: <cover.1783629101.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <cover.1783629101.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/26 3:49 PM, Marcelo Schmitt wrote:
> This patch series adds support for LTC2378 and similar low noise, low power,
> high speed, successive approximation register (SAR) ADCs. These ADCs are similar
> among each other, varying mainly on the amount of precision bits, maximum sample
> rate, and input configuration (either fully differential or pseudo-differential).
> 
> Patch 1 adds device tree documentation for LTC2378.
> 
> Patch 2 enables single-shot sample read with a GPIO connected to the LTC2378 CNV pin.
> 
> Patch 3 enables high-speed data captures with SPI offloading.
> The setup is similar to AD4030, with a specialized PWM generator being used both
> for SPI offload triggering and conversion start signaling.
> 
> Patch 4 enables running buffered data captures without SPI offloading.
> 
Nice to have this split into reasonable-sized patches. Makes it easier/faster
to review.

Reviewed-by: David Lechner <dlechner@baylibre.com>

