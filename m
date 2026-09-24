Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A455241D4F1
	for <linux-iio@vger.kernel.org>; Thu, 24 Sep 2026 07:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790233589; cv=none; b=Mv4D3rUm7xdhq8lbxawXnIZGpCiXWKXUy1BzzsXCtaP0b+9j5X6ROCp3tjXNNadsybKmZlnRAuG5OMvVhTVtQvtEL1tq1coJVQAtcGF69/ioLUc5ZV11LLzGjyRJSkVhiSFKd0XxKsPBcPtKx5Ma/ae/niRA/SCIT64jeNcojCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790233589; c=relaxed/simple;
	bh=qF/GmJdDAJbhCt6NxR0IXt/ma6iHiqTNuALlBPxzgdg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k1mTFkwB9elMOFChMZLR5Dq+mueSzpTi2qZQm+vOkTVTZGWw/LYwRqAz8rii2z6YGd6aUy3u/qSU3RBUtAr8/euGToYEaH2rXyUYJji7oEPHdo1460jfQluHo4vIlp3pf9Ip458w5GeXP6wEQefOGbePLoleErWtsLF4ymjcW0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+echMSk; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+echMSk"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-482f63546c5so1370008f8f.2
        for <linux-iio@vger.kernel.org>; Thu, 24 Sep 2026 00:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790233579; x=1790838379; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aNGRH9rZqGsSRMqbv+c8f/d7VbynsVVOoe5uGipRICI=;
        b=K+echMSkFK9Cg8+MpoQFFvLFuIprDqBh3s/DkKFIEoMv+9QAnLNnpHBI5HChGohXTa
         au7GsUflCH5v5gWxFNJ59F5JRjijqCWE1K9o865FJ3ElMJ+ZEDSLWU5S8jSfqM+dL661
         5NCvSMQuByDtKUdiqAX1W9H/LWH8pNH8WTPUfYAmhQQOC4RDM1zBq87fAdz1EPsMGGFQ
         2jxqle42qE/pe0SYoXA9mzURbzanIuaUTptKtL+EUAWCnSElVHidYyeS/Um9CcppRp45
         UgjX6rkchbqshxH+8M2UHCOZoyC9VvYPw/ZF5X4n9pIIzonesUnMAWyhBAv27r7ks1jy
         2kaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790233579; x=1790838379;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aNGRH9rZqGsSRMqbv+c8f/d7VbynsVVOoe5uGipRICI=;
        b=RO7piFI+IHuUWA3P5cn98M8gfAldKS7KrxRWGofJXCsu4RCyfnHcw5xkbTDygFtpS6
         pFpnKcrWUWCEZ/PuUhKFAD3wzhAZ7SRBr1OW3AGXVfQaWHsM8TUUol36cP1PUEdzDlmI
         JnOyzkryAImv1Pb8AzhWwfFQ5YMHgiOldTSzYAUGQOmlc/TMJ2+W/LnwVIJBzd2hGIZm
         swtSexg4ey8hwUEsXmV0nviW0OI8rpMBH9f+rgBu9b8ml9QlE6jFqcy4Uj9lvJ0Es3VL
         +Ps9/6NhXavK7RZ4EzQAQGsMzTgdHxwaPcJNARFYGpLSNxYDsLJJCU33gOqrqN/0t0hB
         bHsQ==
X-Forwarded-Encrypted: i=1; AKwUvBwg9rW1sonCznfAYdRaEwt459jQ8f+xAMvD8d9q62bz3nLhdJl66ZiBr6GM4mHKwdQkvGQJod3Qhho=@vger.kernel.org
X-Gm-Message-State: AFuF++kfeErep3rhKO5TzZlsg+OH8++J9IsBsxo1a1ux2btdlUYL/0hv
	UqSwQQSCMoM5LVw+v7XL++kwyIO0/6VNvWz+Dk+C8+WX9DqhIjhq9hpG
X-Gm-Gg: AYBFou3oscbJ4dKC+5vZWoAqhfaLFgun9RoTsYDUx6tz6l3n1D/s9u10wBp6RGbJsvv
	FwlQivWmpPJT6kUvIzF8BYk3m1COITXME9E151HMZTtKe20g4Wb+LSQfbYkkNV5ejaCcj0ADyV/
	XhNvtIkDKU9vGeL2STgO3BuVEsiGg4iAgn43vh8B8AwgWN3SUKVwibTn50FmsNJGZWOlflXDpbH
	+1/32FDvEaW+vRQ0LLZX8rhbPR3wO+1avF+kbVVDvGvJ2q09/ggQ/ADK5ViySx9Y6ntXFHQA5ov
	2mgdgWv16BqcuFTkv6m8J6zMOQwYgD+wFP+E4EPJUAYsgX+1k/e0YHiqf7Jd5TXeMgpBkTqI0jU
	Hx1BEeK76tTt+SlDakQeUuSuxUCfMm8nLYRTNoRkIEGHbwdVJH0hp8guy6iJGQ7uZ1SdnBTV8cI
	wpY54lPIbwH6Vq9VUpL3FOM0yJuebE5rhPvPmtrReYQSWQ6hSFXMOt4/JO6Oc6HG9//rtNNO4Hy
	gqNovko5VoE5wHziPfrIf/tl6+Nk3W9YO20V62x/LkqRjfEuJM9kH/7h/JUv47z5Lf58Fs1mByX
	SNxloEzxQxo67CD0+EE6AOHhxhvMgxim4Cb7i0+hckBpcOU8Oq6twzS3qK84/IOSR9c1UZ8+VyP
	dE+80Q4B93RPC8BKu7hI3cwbOAIBSWm/jyO46nOFF+5cKV0hG+thFZNUiGsWSQIfZ8FbxbObyep
	jgR39A
X-Received: by 2002:a05:6000:220f:b0:485:8c16:5ee9 with SMTP id ffacd0b85a97d-4887175fceamr2133359f8f.35.1790233578647;
        Thu, 24 Sep 2026 00:06:18 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48868486408sm11108512f8f.9.2026.09.24.00.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:06:18 -0700 (PDT)
Date: Thu, 24 Sep 2026 09:06:17 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kevin Tsai
 <ktsai@capellamicro.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iio: Add dedicated CM32181 schema
Message-ID: <20260924090617.00007d47@gmail.com>
In-Reply-To: <20260923191616.2217203-1-robh@kernel.org>
References: <20260923191616.2217203-1-robh@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Sep 2026 14:16:15 -0500
"Rob Herring (Arm)" <robh@kernel.org> wrote:

> Add a dedicated Capella CM32181 ambient light sensor schema. The device
> has optional vdd-supply and interrupt properties, so it no longer fits
> in trivial-devices. Include both optional properties in the binding
> example.
> 
> Assisted-by: LLM
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> v2:
>  - use additionalProperties instead of unevaluatedProperties
> ---

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
