Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB230390CAC
	for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 19:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782244460; cv=none; b=e/3cjtgfdzWLhacGeEJngkIwWLxitH6NIye6F6brZfJurb6nea0aj1LcV7HsoXYjKptMpmDPhesp5cHgFBOnKNJj91k11xfIjng4ap/uFHZHB9UACVD1XeCds937MP3KoNyCCF1NLfUrVapzeJJusZgljpmqJws16Ysgg1nPZlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782244460; c=relaxed/simple;
	bh=kEtYiwGGXfxf9OZgvwT4esSaZCDsxd/HBEXxCtejDdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rs7Rjobz2tmnR7wqoioRzA1CjLgSBXN3mJgBBsBUBXxQwxc12FshoYzHTmtmXypqRugyLFyGTpYSDfN/ExioZhk2bE3rHBCAXokXO+sTFxD4emyZOxTNjdQ5mrq/UwjDFHSSnN88dKgAZz9mf9qmK4flMEEXeuZ4AXeP3EYp9aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=LxzfCC+2; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="LxzfCC+2"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-44104dac6f5so987216fac.0
        for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 12:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782244457; x=1782849257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=psbJjHxePMcruU5APTrGLttW1uAsloPB1ho5xqlQwMM=;
        b=LxzfCC+2hNSYGs88bSYlCl0yonuC40HHtpySn7CoiqT7ZQ+TY4JpX5nsKMKpsKgFxe
         6qDMW9lmoDmjhmfZfP5vW2wDavmzb3dzMHZkDtuVkGmL748m/o6Np26Tj5+Ypk8KGabp
         BHbROhKFYhpf59olIGOXisNWUjSwcHS2PJ9Sa5so6aoxeI+ESYBlCc1iNfkXfsht5TB9
         rJ3gUuu3joXteh/oz0nd+SP2kdb0G+HFr61gWMx2fkMXLZLbr0vumo4utJVYjk5VCi65
         aw+HXokES7pB1MFmToWul7GIf6b/xmInLVKT5WXUMKzPoUvpvmL0k0SzcePlPsP14ruJ
         dNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782244457; x=1782849257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=psbJjHxePMcruU5APTrGLttW1uAsloPB1ho5xqlQwMM=;
        b=AVlsIytKI+B7Ado6cCTr2NooksxIugvmfzJjtl4UOo98AGviTDe95VVuXONTzG73eZ
         +E+l5vyhQI79HIWXs//tKBsHECxAMkJPyTs7UDBHZma4GNtAaaHm5TBjV5MwXMKeC+5m
         gsxTnNwUQDcJ3Cwmw1411e/MVw+ThmeXHDTm4mKAtmfVRTjcypM8oQv6dh/DV79OF6uo
         j3dfZRI2t56NRGpwRJ9KKJvYOXcFLpv8JWd+0CHgvBUezdnei3+n84ZXsTSxM6IcXO7n
         6r0RnNualZzjB24Al7Ss1F0o3peWy6b28gq+paGL1AwvVCbbePlsvCVJkC+YAShYV++D
         JDiw==
X-Forwarded-Encrypted: i=1; AFNElJ/8pfkB8YM047on5Lq6ala3lVJWKRP0mn0Np/DL01GL7ay6CjRD35/YGgwi7qEJcpuKhGVfNOQ1pic=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQdrZEUawxaXonKR/Bc5WCMz2ZbAm+i/fpuvcEf6cPJ8VRjRSm
	ZvHDf5+kDNlUaakstgMQGfvpITbmzuoCIjKTR2kreXjTzRVyVXI3/17Ba1Gv0Hwozd8=
X-Gm-Gg: AfdE7cneMNdMxU1DRRpYNL8/ZA5px9kMwGBnI/WmlLVVoYEg/zTlo3MkXjgz2/qHg2L
	SwZtMtFTxiEaNUjJ/7VnyOcVyq3EDxkOIVqXXUxaM1kWObSzTO86aTTpRGQNJHjbKfyEe+AsLvV
	fM9v7dy+DzBPdWZCMxcP5l4Bq76ma0K1iSAO95V+dz8T9s5+JOy7yqAo638gXhmSgblK/0e4wlC
	hUg/pWG3ftaazHpvHj9ZpkwxT96xCGJc7zZN1BZSge+qEiRACNUEowxi2UQWWPF2Sab8F6ek5xM
	gt8LOID/zrYnOiivkHMnfJjmBYbV7v2l/5xAjG/DyicMmRrx5mIffD80lV+ERuUgvWgJOZS0hxk
	ieWOTnyV3ihMvp20Xb2T1/F0/3FTDXYGLfgQz/fTBo3bDi/Md3mIp+hFvb6EwH+Cgv9E/WrE1+z
	lX2eO9WbI5hQnucNUXmTHitTulnaZwPtZhkGZa3eWJbaBVGWtB3p2bMqMtx6UM5p4=
X-Received: by 2002:a05:6808:6f93:b0:48a:c6b6:b76f with SMTP id 5614622812f47-48ee45925eemr3311675b6e.20.1782244456969;
        Tue, 23 Jun 2026 12:54:16 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:68dc:b788:b3ac:e34e? ([2600:8803:e7e4:500:68dc:b788:b3ac:e34e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48ae8b3b1efsm7202725b6e.0.2026.06.23.12.54.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 12:54:16 -0700 (PDT)
Message-ID: <9f206645-9503-41f6-b33f-9f96b472a1d7@baylibre.com>
Date: Tue, 23 Jun 2026 14:54:15 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: iio: dac: Add DAC8163
To: Lukas Metz <lukas.metz@gmx.net>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20260623-dac8163-work-v1-0-5b508158faa0@gmx.net>
 <20260623-dac8163-work-v1-2-5b508158faa0@gmx.net>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260623-dac8163-work-v1-2-5b508158faa0@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/23/26 11:07 AM, Lukas Metz wrote:
> Add device tree binding for the Texas Instruments DAC8163 family
> including the DAC7562, DAC7563, DAC8162, DAC8163, DAC8562 and DAC8563.

One other thing worth mentioning here as to why none of these are fallback
compatible (in addition to the resolution bits) is that the xxx2 chips
and xxx3 chips have a different output state when CLR is asserted.

> 
> Signed-off-by: Lukas Metz <lukas.metz@gmx.net>
> ---
>  .../devicetree/bindings/iio/dac/ti,dac8163.yaml    | 75 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 76 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac8163.yaml b/Documentation/devicetree/bindings/iio/dac/ti,dac8163.yaml
> new file mode 100644
> index 000000000000..bb4bad389323
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/ti,dac8163.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/ti,dac8163.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments DAC8163 family of DACs
> +
> +description:
> +  The DAC756x, DAC816x, and DAC856x devices are low-power, voltage-output,
> +  dual-channel, 12-, 14-, and 16-bit digital-to-analog converters (DACs),
> +  respectively. These devices include a 2.5-V, 4-ppm/°C internal
> +  reference, giving a full-scale output voltage range of 2.5 V or 5 V.
> +
> +maintainers:
> +  - Lukas Metz <lukas.metz@gmx.net>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,dac7562
> +      - ti,dac7563
> +      - ti,dac8162
> +      - ti,dac8163
> +      - ti,dac8562
> +      - ti,dac8563
> +
