Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C7B47DFAA
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 12:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784120153; cv=none; b=X9hmYPxLnVL2kyMshtgmFo7cBLyHC26dK5N0ZHZP28XzWg93LTx6ixVuIJMGjTn9T9ZQkJLhzrlsedTUTCFkRAt044tgUedsi8Ju8liUEvkIHtvp2oxGaXIhrLzXsfZbZD01kAQtmI4LrslDTnI21OYJ9IKJtEQr+8Wt3P35S9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784120153; c=relaxed/simple;
	bh=+ef9aDLlQHobsPKwugMtNj/4msi/nZfgAIa1/gNlCko=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QLwu9TkqkuuztuAY9d2S61ogCsWTdeDkmXmTPnGl+QAkQlsqCco8vIkaNHc/aG9GYr3gf36vkGKWrSv+T/4FyReigPOVeIlO7DFm3BGAOqXzA8yvbGMi95EVS9MoQaIAe9hcK3pwPknxumHNuCcikGgmzM8VUavDo93hAPu/Sh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Er6LGKNL; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Er6LGKNL"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493f431e317so15938755e9.0
        for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 05:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784120148; x=1784724948; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+hWIxKyRHkQzvuNSfAhpF4QRz/MvqM4Y3NLoKIJevpA=;
        b=Er6LGKNLp+UIGNqV5ziTH/JxevpcIAEGvmCm7da1DvZQnAKibL+oz6YBD74o2DKDep
         KEUSS1ugn1vOKmfxRarQ/yeo108qMHVnUoI7B0PUiT13dAg+Vf4MAMgcdQ2r9D90TiQJ
         ugEyX/VFywo9GSStgdNwITRRlJdZ5dWhm8pyRXPvTfs3be4KVMq7BF1XaHmeyGJ0FWHB
         J2p8QTq958kctk0uvKQA6ZSWlVQyMs02i1dswuiWLnvGBeYpx4AIg8XRT5ko0zvCwECh
         E1+kCmxD7+B0eV9USrxCVUiijv9b5pN6pRh8zIndVjoX2CNxgHwgycg0yl+D7+g4cy+M
         AhsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784120148; x=1784724948;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+hWIxKyRHkQzvuNSfAhpF4QRz/MvqM4Y3NLoKIJevpA=;
        b=mYwCfI/T4mkDrLuM8Kl3Pe/s+PlI/AS4qF+KaiGJGWOe9yI08lnPpqeuzrJa0/dzsv
         xdlwWiQByYUeCOVdijlC/65FjWakGJUVnEjBuPa61DSSnQ5GktOeR9F5J1+ApgI/WkAk
         bGI2OXjtnx4sSE9Koy9HjpPlsN6fdqwMwH+FEVHiYq6eMgAs5iS05qjk4a3A16wQSQhc
         Tvs4ID71uTf/dplHWgYWhyRQGdu6tRwih0G+zg7kGI/FrmAUZ0nfN4LOA6A5gRi2u+tu
         hNfaM7UoWlsrhylFAU/Sne4dVvsM6RxzJSEdAfeKE8cyrbXQnjq30Pgbp9LFjUHBfK6v
         7gdw==
X-Forwarded-Encrypted: i=1; AHgh+RoCEi99hz14lYG6NpyEkXGrr7j16Km0xe1/trvVJ3AE4eR1F6V83JV057i4P7RlFWPBduRuW+x2nlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWxsHmrTWThk85CV+MgFCm8IjbarQs/yxf28unocQq1PtISLn2
	ltaWj3Ft9a4Cr7Z4nKdKcL7b4c0lofDTdgW+STqzgEpmEWU/BIhCmnFD
X-Gm-Gg: AfdE7cn9NquEQMrRaQjjP8TWfhIQRbYHBu/MgOIy3Ro3hUkA9LgMEqdbOFcYHr5UNOU
	XFxbzhZUjsnH6GazCT44GqJ1jg2Cn1XyYTFVHZWq/54iAbxCHQAHh6xDfbH/1xlver9JrdaVegX
	3sAy7S0kfPVdjri2MKcr/TsbW7jwjxqeqNwd7Dt69uidGtKsEwgqTPXqJfUIEk/bSWMdXxCDq6g
	p5Y36lVSuBUYeeu+rd2pS5X84z6GA4v7MUshUQGE9DTiuiy3Kc34zIA6ZsITY0EN5/z33hc2des
	NQlx5PL5l4Mu/m1d0Q02ShRheV4WDO70WauoHx1Ojta18h1V4bZ5EkEFdKS+brlvRq9GJ7s28Wg
	ZnR/CDz0HsBgOtUmMknbm4ah3Wt5N53JMELaHJvGelTifWpNtvCfv3r76mdbLBKQX+aTzrNZ+6I
	pr/b5kpLSY2tjKa9fWM9MYvrf+H4wcjP5WfY2G0omsunLkJocdJgkF16tVncsrNYaKyA9ZR8UWP
	RU+UhKwLBvHcRUELOqyWkHVjpNFeNc9merwjpEN7xP7VTHPpLNnjC+dVYdxJx8vMM9ZjsW0TeN1
	jizskXeASFqIAESV3hUYwR3pZe132kx/DZ5+jkulELjLla3KQb8yzed+s4azHaRidZekCMM5Bk3
	P/Eg2WEGxT938ANfQG8oa/sU=
X-Received: by 2002:a05:600c:1f8f:b0:493:e79e:da6b with SMTP id 5b1f17b1804b1-493f8815d42mr231250705e9.21.1784120148039;
        Wed, 15 Jul 2026 05:55:48 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49508732395sm149662985e9.5.2026.07.15.05.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 05:55:47 -0700 (PDT)
Date: Wed, 15 Jul 2026 14:55:46 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nikita
 Travkin <nikita@trvn.ru>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] iio: light: ltr501: Add ltr329 support
Message-ID: <20260715145546.00005bc8@gmail.com>
In-Reply-To: <20260715-liteon-ltr329-v2-0-d18af55edab5@geanix.com>
References: <20260715-liteon-ltr329-v2-0-d18af55edab5@geanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jul 2026 14:27:22 +0200
Esben Haabendal <esben@geanix.com> wrote:

> The LiteON LTR-329ALS-01 chip is similar to the LTR-303ALS-01, except for
> interrupt support and related registers, which LTR-329ALS-01 does not have.
> 
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
> Changes in v2:
> - Fixed error handling when irq is defined for a chip that does not support
>   irq, powering the chip down again.
> - Added simlar fix to error handling of devm_request_threaded_irq() error
>   handling, powering the chip down again on failure.
> - Added explicit #include <linux/array_size.h>.
> - Link to v1: https://patch.msgid.link/20260715-liteon-ltr329-v1-0-31f027051594@geanix.com
> 

Quick process thing, please wait at least 24 hours before sending
a new version - let it sit on the mailing list so other reviewers
can send feedback! Larger series should wait a couple of days.

-- 
Kind regards

CJD
