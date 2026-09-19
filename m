Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3392D662F
	for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 08:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789806054; cv=pass; b=upHxym+MWe/djwQkgzZdgqvcIZCbtrTiFAIAMGuZvny0HLTO2uyMBTwzlsCodDKT31fKFx7pzCplaua6ci76JVAyK+QVvh5aMxaAd1vb1nZapnWu4kzu0oUlhZOdI/H7qQEWD0xdx2Fbd3b21X16NdWK9FhVHh8xFFafdhgrZ4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789806054; c=relaxed/simple;
	bh=dRbSK/OKK8iimVXv289dck20Og0p7BV3a31l6knNHn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IyIA2NDuHcLRAD8fxjWFkFb6CtAPvyi3ppvysV/0EzMbsmztdHztOg0iC83TB5Sk4edqFgonG40V0Nxxw3MCHDr1DintHSuX1MjX44OGpEz29n/3evWY9VgTyY5ODF5WAFv+msSNLv85YaEwD2S3fesVMsDAqjH9nBuzIQ76QEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIdsEQr2; arc=pass smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIdsEQr2"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466cc88a9d1so716188fac.0
        for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 01:20:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789806052; cv=none;
        d=google.com; s=arc-20260327;
        b=M4kneE4eTcf67xAKH1NFnXTvqVlKIspo/Mz196i7NtqX4FlXF8b14zLOvZD/fO8ZUA
         V/LCoIkYZ7QUFNOZBDsssV7gHCQyg68YEKUm2nfagYEe9AmlYxR/6k7LT2FpVnbmaRVg
         TzuqDO+V8nOKI0AXpxyMTb/yVqXqnXDI5J+vzU4vpzXViowdQmRoiLhKwTxRFdvASean
         KO2a4HxnDzjgF2OJ1bl/4P8sMXVvj/y5K0zoxUMRXJIgUeXGhbmqv/c4/D7g8HtmtXGC
         dRtfVsUJAf34ZB9Y10IiWWvU+7nKX8YomdVdQ3Ko1xG8t+zV/WT/5CWf3BcYFvJK5sQn
         y4tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=dRbSK/OKK8iimVXv289dck20Og0p7BV3a31l6knNHn0=;
        fh=uD066f9QilbxI817t5DoBBVKtR7/uGaxx91Gu9MjtNk=;
        b=Fx5jON4s8W9oEZOd9fG2WwKKEn4s4FXZmjrHF2kHIWFjGelal9kutPLSgwlOOK2iTI
         CQfkFrefUs+Xm/awxulWjW38qAlYk3zR1IZEMOH0W6EDg0MiBlD45x84bAroj4mLAsCe
         +fTqMAwiv7bYLyh26Z7ahJhq17rAoE849XmbLAbf9MDmerriAufpzPPRo8xTXeYwqlv2
         P51B2wFMU1a9QNG0Phsi5cAzHDjvrnsn9yvJYb/YhS0GcqnplIVcJUzWCp/+uvwvScrk
         ADl4myiY24+zJEBzG9mt71nIhflbGcqzU7E6JkpdSCFyo3PUcoBJP2rmjHJOR6jsF9WX
         NJfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789806052; x=1790410852; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dRbSK/OKK8iimVXv289dck20Og0p7BV3a31l6knNHn0=;
        b=JIdsEQr2+HyjoZ0oPGP2aMTpKw+GsmtKueKvDgD80W3YTJFSPZEoRBq97hPZnMKcu8
         6vxD371330rf336cep/H4qm16j3utPzaci0DSjaFIDyyOpzYIstkAJ2E84ZyHJ+0xpJZ
         oKwm7TsyKfcMKRPu33zvomh8o+92AxUfNCxonxgGn6HsAD+1llNpOZpAzbUz8FaFEnpP
         60OF75WN1Pygq9rFB/mdphwW8rXB3z9ElBHFJcZKMd91AqI9ClaoK0tyIvTKDPFEnAjC
         +r6R2Fq/QN17DwOQnKe2qh874paTO0p19kxsG7E5o9J8Dt3XWhZxjmSdkmRJ91WSHjL6
         qjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789806052; x=1790410852;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dRbSK/OKK8iimVXv289dck20Og0p7BV3a31l6knNHn0=;
        b=KyFd/O3LY2K8f0L8sy7lOMjUROj/tKsBQfPjZ/uD/iACgWRHuuhuKOJusMOxlwKEm0
         J7ApPsInxz/0chRrzefJJtS7Wzurlih1S0/GLUeI8ZZzLMtGbM6RgLTnKcYLu070dB+M
         f/gzt3NM2SLQH6Wd9QkL+x+4aL+LPYsPJF6ro4VhHfx0GWRA4BTub8wByvIcx0qxM1P/
         5JtuqiAklF+e1zovYJ4/Uwiy1FVQQ1O1TCxAiY1V29rnuCtqCgamq5RmFVUG2gf/xJ3n
         ay75R1tCcyYKOoDd47KFbaEbFgSVObQg89k6cusfigHsURGM9ZZjPXCaY80gu46CxaTb
         hn1A==
X-Forwarded-Encrypted: i=1; AKwUvBwODOtK5xWFLSgu2feUfAhYxcQFzKCxEQC0J5mgNh0216UBf+GKyOGXDpU7ti4z7W3UVpQlsRKL/FY=@vger.kernel.org
X-Gm-Message-State: AFuF++mrt3t7keK/zqyPdD8D1N1mBllGX46yTrNpXcU4Um6I+G3EvoSJ
	+Uj6HCAr6+ASHzrxObzMZw3qBKZjxYfuUo65hb9ePFxQCAGdRCSWM+GeIbmmKTAZVXKnlcSesTM
	uNKALHTJVVNSQ3ZVTkZUucnFqL2TjGY4=
X-Gm-Gg: AYBFou2G74YKiZCuP7S0rZO/3yLNhEThVMFMll29oC/77tbTSZIqytBt3FleSWjbBGI
	hl6WPxzWYlg+/o6x7irwOK9/QTtokOOojb22dLoAgEEG3LdXe8xXt8V31dRYEOTIT0WChSGGzxN
	RsCLaPSF3oJqn/yNpNSZhKgGT7j75bGeplsaA9PB1znrg2bbGENxyNw6Y+sLJ/mi7CRKbfE55Lb
	7XCgIenAczQdTl6AcOM7szOyv0zb0oTD/74ajI6attAGoRmioS36uIbjNjr+J/QmqPdxq979cil
	4+48RmXxcFUH4sV05DVsOPqfrKX+vRapOhpZF2Drez83tBUeaPxK25kXow==
X-Received: by 2002:a05:6870:af94:b0:475:e235:904 with SMTP id
 586e51a60fabf-486e7d8d784mr5164669fac.34.1789806051717; Sat, 19 Sep 2026
 01:20:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915075939.18180-1-abdelnasserhussein11@gmail.com>
 <20260915075939.18180-4-abdelnasserhussein11@gmail.com> <20260917042241.05bc81a7@jic23-hlaptop>
In-Reply-To: <20260917042241.05bc81a7@jic23-hlaptop>
From: nasser <abdelnasserhussein11@gmail.com>
Date: Sat, 19 Sep 2026 11:20:40 +0300
X-Gm-Features: AcwNN1VPFhT8_U74Se6tKxB-Bhi_wWnDBf7t9r-mJewyfUCjrFEfyYR3Twb_qsA
Message-ID: <CANpqX3ZUL4qhjKEx2DN8YOYrMMxe78w1O0E+aDGSR1NE3oprhg@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] staging: iio: adc: ad7816: Fix DMA safety issues
 in SPI transfers
To: Jonathan Cameron <jic23@kernel.org>
Cc: gregkh@linuxfoundation.org, nuno.sa@analog.com, 
	Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org, 
	linux@analog.com, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, joshua.crofts1@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Jonathan,

Yes, it was indeed a clumsy copy-paste error on my end. my apologies for that

Thank you very much for fixing it up and for applying the series. I
really appreciate your time and guidance throughout this process.

Best regards,
Abdelnasser
