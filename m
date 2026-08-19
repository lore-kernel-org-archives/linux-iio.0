Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEB53E0094
	for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 08:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787126568; cv=none; b=spOYCQu5+79zPrAECbZOyeLVUkJ88At8RwaRI5sfXHMM/d69EMeACHXXyjhCixLsI7Eg1biBlk7ChGSgmM5gqf1OrIWSa4A5XFB49VF15y4Xe3q/fXDtEJnuaZJyIbyPruELOwK6DH0fhQwNqsJ88bFzoCP8HcfAGdDTBQ9K7oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787126568; c=relaxed/simple;
	bh=ES/kxhSrcAfYRfK+7CdB1VBngwwtQV8QNC0XOOovA60=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ui5YXXib9qlzXRYNxBLFeORJoqStoDt8DJsnj7pSDIQBVBlEPAUGl98J1LsKLDhGhFgihkupu8MccN4NtAf6T9pOckBNldknNHlLo1RhBhh3b0Ol6Mam29P4nEaH/oD5oudEFT5Poxz5XhqfexzZ8zvOf7y/IAybdoCUKCuOwG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5JuDnJh; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5JuDnJh"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47f93b2fe4cso383053f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 01:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787126560; x=1787731360; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n84akRWrYp771T5DP5M0T4nRXTa96uuJHFpXgEzxzNU=;
        b=O5JuDnJh54+KFZrENN9G+H1nPoE8y9FDsvUUsM8q2HSs4skChaoXW1SR09MFBKY6j0
         Z6aQs/ym7lk9WDzYhWTKM/4vfvz+NY7oQ2slRdJxSa1BCwnyfhaOCs+QNXFIBFt2hLdk
         C4xt7b+pQQrPGaTTDAiIlFOhrIs3s34AVJzGTJXQvS1uq/nYY/hYs2etBzQfb6U8lI4B
         vLv9mUxpXupXrwEvUrgaXWPCT7y70CIzy+Ho5Zx/RkdCSoYutzaGM8NyMGabru8W1mZt
         ifw0CQsi4c576PtL10vJk4AyZ+ggusw4tSTFHk9E4NUPzHMgQGPQpvQrRWQfcPHUjkp0
         hbBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787126560; x=1787731360;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n84akRWrYp771T5DP5M0T4nRXTa96uuJHFpXgEzxzNU=;
        b=f+fp5Bz0DB1SM176mpsEZlA5VeTg9KcWdGqZ/FOF9n7fi5ffQZofqse6Y26bUMpYc3
         Ew5ewAdtL/v4U5bcftOxQf128p4emvzphqpLEgow3qddGs2bApCOTSBJRFdMx3i8P0yJ
         glJGdmXEowpy+zQpP1qPjBqy12AGNwZ06Cy+267059gojD7LpJvFfSEriJB/9ILnsWaJ
         DeP7JiE4wRW8wVGm4C3Dl0CQU2jHne5pKKL6zFpABaT45ZTSbvVwZ/OcA/7FJmwKyNzT
         DXgTtq1rMcWp5ulASKQv1sVmFNkFBnc1/t5M+2DztbRPfEMKOUqs9fId26ONXUyK9IEI
         CNdg==
X-Forwarded-Encrypted: i=1; AHgh+RobB1JKwajhbwIW8D5EUT52BxhTWZ+N+K1+5SPy7PhMfetaxtwe1hHii4ylzg+f0o5uvmy7SB/ttfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/qDa+9KzKFWnlgNVNTn5MAMti5vZ7c8XeyYQAhUWXecrNfkVk
	BxJADRb9z0E3xDjgjv/Su68bTVM1qenbrxiMRaoXrDxQFHknGpbvJxS7
X-Gm-Gg: AR+sD13Modhm8JPuPyMySctipJoTA+fU67ygH0TjI+cZkFgSYWhl6hgbaSg4NCJRtLE
	Qld+d3AsCLkx5TG4MHlQ4wybysLPVjRJOzH/Ib76b2GlDUlhjmT3eRpnyfJyOo0Vqp/kXAD49Vq
	NlCyjQzFQZRQrrJUwvbyOhHwSL0a4oOd3WarK/6m8QEB+NHcG1MYaBEjhGv9+ad4JwcnA8miE0l
	nm1IyII0dHC1DPmBIlfyybUgwRVCL/bYe0g5O0bt0b/S1gaJ//N2w8a6yywTp9LJa7m0chH1vbj
	HBHGzHuAUTqvlDJQCP9x0Vw8t6rTrTM3CO/170jQZilla1Mlkfy3yrhpKyQWQe8gxNokouvfV9v
	yybeSsmmVYL2MwU8v+q/cB4YXVzGyorkSIb8M13qL/wkAAOGycfEMHExPZd8RGXt0bV0vHkl70+
	8mVWKc3p1gXWNkmzOiB2zZxTEYuL/4yH9cbSOTuJndjGwozUDJWX2AwS2WFn68LwRLKm7fzGDj3
	YL7yK0AWIbINfA83ZGvvZp56idddHr5ybpcfFv3eXxgNXQMYbmvCOc8+eLdFR224wsDRFNuMpoR
	zRQhXqYUl1SFJbW4vvQkaXbmTQzPqe/iTPguAsMNCh/1+nzgVOp9d3S+sNV9QjeTkumn49TKQFi
	O1s5M8HV/NPMwPn3b63F6E2bbKUl2vmg5vN0EloKlc0YpDWjnJ1JDra8vWXDN8gF9gVpxSg==
X-Received: by 2002:a05:600c:468d:b0:499:4892:d022 with SMTP id 5b1f17b1804b1-499aa17d5a2mr43992645e9.8.1787126559565;
        Wed, 19 Aug 2026 01:02:39 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499a9aa3204sm31743085e9.0.2026.08.19.01.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 01:02:39 -0700 (PDT)
Date: Wed, 19 Aug 2026 10:02:34 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Vladislav Leonov <vlad@zlab.su>
Cc: andy@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dlechner@baylibre.com, heiko@sntech.de, jic23@kernel.org, jonas@kwiboo.se,
 krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, nuno.sa@analog.com, robh@kernel.org,
 sjg@chromium.org
Subject: Re: [PATCH] dt-bindings: iio: adc: rockchip-saradc: Fix RV1106
 compatible
Message-ID: <20260819100234.0000355f@gmail.com>
In-Reply-To: <20260819075921.14356-1-vlad@zlab.su>
References: <20260819085255.00001e60@gmail.com>
	<20260819075921.14356-1-vlad@zlab.su>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Aug 2026 10:59:21 +0300
Vladislav Leonov <vlad@zlab.su> wrote:

> Hi Joshua,
> 
> Sorry, I forgot the Suggested-by tag. Should I send a v2, or can the tag be added when applying the patch?
> 
> Regards,
> Vladislav

I think that Jonathan can just add it while applying. No need to
send a v2 unless explicitly asked.

-- 
Kind regards,
Joshua Crofts
