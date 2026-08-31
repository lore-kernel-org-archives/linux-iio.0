Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC334446EC
	for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 16:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788193737; cv=none; b=Mu4COcw7+gK0m1Jf4KbwyugbzSzPrFaVflcIb+/4duuSdEYczJym7uVjD/Ftd96x6fr7YFsl4xdkF86Z5iEsy/roXSF7z/29iKmTPDBPo81JbUrVPFCJDDAf9MQ9Z5RMdagyHgEjMEq83gBefB+kai8KRUcEvrvSz9HPwdAAQ2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788193737; c=relaxed/simple;
	bh=RBFdUe9Lqu+3E6HjxM/7EycY+o+q4NHjhQ/1rLOnzpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D+1ZyzPGXNWvrOwx9Y3LfQQlB1RuQYb8Xa8NVtoxBiaRb11OnVp3e8MmYJ3Saxg2QAi2RM7zL0dOCMEvy9h9snjDqD65krh0PVaBirujuW3kU9Shxk8QA4pk2OqpxMD8GLUpSe3saER6c1qWZgjo43lNcdCxkvEsr0VJGnQHwH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=cVvUotV8; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="cVvUotV8"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7ec1e9d3359so2999706a34.0
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 09:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788193733; x=1788798533; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EWqZKH5cJQNgKE7le/WSTlw6Pq/lpoqP4enPlKSIv4U=;
        b=cVvUotV8t4gHLwPbNl0AUFJniJl4drCTxW8s4qKnZo1uH3AAeYJUdaXa/UJ7PKWJDW
         BsMSX4oZSvkeYOV1uGuG5uGLAUNkWyXd+YSO2pSdd7ubXsew9Sj3iJz3Gqza6nDTSRAT
         dCe7YRWtgVLXl6sBVuC4+m442YektGGfoVDjXTwRuXSv/4SbZlYeNKtNhRymIWVoyu01
         w7HO8z/FeUaC188xu/bD+3XqmcGYoRLzFNOPL8bA/qPY7518k/EibzWdoSP31TFVMUSV
         sKUyEHk7VBx0Poh8QW/t0oAWdAM0jTEjS5pLmW52UcEcar6kx/ACFPI5b/rKMKbTGBld
         +rYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788193733; x=1788798533;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EWqZKH5cJQNgKE7le/WSTlw6Pq/lpoqP4enPlKSIv4U=;
        b=STP/VAo+039MfkY+dfCpGi9hmMIdh/iM1C4wci2H3SuMR7d8Zzo6dTH0ZTHvZev8o4
         yhqFdwR+vIeSH1IgXdNU7Pn0x6dLc8aV4zwtBneTFxW0R414+5zSzqOmdP/0jLwQwZYx
         nMyHtwnA4VAdNizcpkKhC0o2xzOtQXY+SwKt7oZXPb6IvpaSrQ+bf/02oDKbEuj1sf27
         CPupdv3XW740R1bPtN6ZTgccBOFCvyUTk6wh3kczSRi4bjFl7ZDyb2fevAMxUSLDu+kM
         1LlB5e1N6tgLaCpifUHKPyntXNlrmX5Tsm0wbqFbaUQTN+HziZ4W73lNQZJdrIceGEaN
         IJyg==
X-Gm-Message-State: AFuF++mHP2A0/+m8WNDVfOHCWVX8pqT7j1oDERxaAZeON7vtDI/I6k13
	f7rzPN7BUf/RFk6OZansgadhlfVOEKIXV5RjbREmKH7p+taAxYhnrIKptd5zkDnEh1o=
X-Gm-Gg: AR+sD11ND4DHdygRIji0TEb4oz6zJJvTDERm7P6Ui2BBhOmeSamFnUUu0hR3Hc8DjWT
	UFtIHwWTRNHoKvf9MoUEVWoyKbb3rHBga90tdz86igenVUo+t7EJnTnQWRQWtvg3wy093O8KByd
	JK6bhawGdBDqhO0/YpmA6fmICGl2dWZX73NtrE1OY8rm2+LDpraa2b2CrUpQpaoNrTG0ZJ1MU4g
	iQGSRuHe7MBb4d0X9/TqbF6mlrj6KTxLB/Poer/zNAfHVGDZj+jJG38UGoOHcmxldVgNOo7gKL8
	foBns42JAJLR35crnRc+zIDOujjd32GN8s1yhNmmPsXdR7WRHOEreKm7Wnnn3dTJEZjLhUTOSbb
	k0FsrAhd6Zmrm+W/6+deH7WTDW05JLqm7M/LbmPp5LHIroL+fWV4DHE1uSptD7LgmpDyczQqHNh
	r4BgN/y3PiAn9qkvthSIHpws4xOwAffGGavF8/KkkByPzerfoQLY9zSjPzwtUYHWfhQnEqNK+HH
	NwhR6SnUXA/eSInJm5D4+oHenPkz6o0sm6n
X-Received: by 2002:a05:6830:208a:b0:7f6:705b:ffe7 with SMTP id 46e09a7af769-7f687bcaa4cmr1802418a34.14.1788193733045;
        Mon, 31 Aug 2026 09:28:53 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:778b:da9:a8a1:bc78? ([2600:8803:e7e4:500:778b:da9:a8a1:bc78])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f4fa96cd7csm8181194a34.14.2026.08.31.09.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 09:28:52 -0700 (PDT)
Message-ID: <268eb714-2849-4ebb-9f9d-9607fcce3358@baylibre.com>
Date: Mon, 31 Aug 2026 11:28:51 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] iio: adc: ti-ads112c04: Add support for TI
 ADS112C04
To: Kyle Hsieh <kylehsieh1995@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260824-ti-ads112c04-driver-v7-0-6b3c9c87d0e4@gmail.com>
 <20260824-ti-ads112c04-driver-v7-2-6b3c9c87d0e4@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260824-ti-ads112c04-driver-v7-2-6b3c9c87d0e4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/24/26 3:49 AM, Kyle Hsieh wrote:
> Add IIO driver support for the Texas Instruments ADS112C04 (16-bit)
> delta-sigma ADCs.
> 
> The driver implements:
> - Single-shot conversions using the IIO raw read interface.
> - Dynamic parsing of single-ended and differential channels from
>   device tree child nodes.
> - Hardware interrupt support via the DRDY pin, falling back to
>   software polling if no IRQ is provided.
> - Per-channel reference source selection (internal 2.048V, external
>   REFP/REFN, or AVDD) via the reference-sources device tree property.
>   refn-supply is not yet supported.
> - Hardware reset via the reset controller framework, falling back to
>   the RESET command when no reset controller is present.
> 
> Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>

