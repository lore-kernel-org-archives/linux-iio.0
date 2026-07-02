Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FE529B200
	for <linux-iio@vger.kernel.org>; Thu,  2 Jul 2026 01:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782956477; cv=none; b=Wo2T7MklwWr7u9MlRP2GFqm+JC9111vTyqk1N6rsKxTA64Vh9N+PfInGKeGMVkDT0qNVGCW/lz/KsiczXTSzp+MTUaMKpkFNI6h2fVf+/ojNONvs7GtsfkAW/toDUtChOOPgxAPnJB/wiE4lWVPBe2HgUVpMgN4iwU18bJCK+C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782956477; c=relaxed/simple;
	bh=UEIngbVpgPQmaeUHLYYQek6IDrSlEeFzwurktpFRBSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SUcXf4cNaAi4wbgIVxZL9kT19pAwO4KRJCeERv5fFLa2gGX/uSB9uy8enEe5hWQ7GUhpmMIT90X60cA4Oo7KY9xbKBWJZ6LEo/PJncZTXKlT9J3DQN7QDRXdPzYbX4L3MzVuziMhY8efCFGM1V57+S0vUWxjoYULvFmWNkTzkOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MkSjaMKU; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkSjaMKU"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-845e363246aso1053069b3a.1
        for <linux-iio@vger.kernel.org>; Wed, 01 Jul 2026 18:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782956476; x=1783561276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ShQQKj8s/Lgk+6VwLi37Fynh9m2UvesLoaAxNarS/n0=;
        b=MkSjaMKU2nA19uExOWaNYa/4Bf0lw0wKYvk0BjZPdkwWDwDoVWLpfpbzUNupVjJ2ys
         pgp7dIU0MAI2ZsR3ekg97AmGtAAieesMS4SW2byp3TTRDIbiWNvf59qCa0qNg3QV2loH
         1FSqZ1eUexPKLx3htRJNLTgW5DGWzFPYxJL7xBYKyI6pvftP0WDmgmXiCZeNPxjDX/AK
         GBYl5VhZhdynZA4subavQoEsI8ASI7zJHWNC0IIi3hfCUtRbYn9TG05cpXSa5F93jgA7
         wCGs75z5LbrDXOW7tBgkS1Ap6/thdz5Xsm+1EOLi90NLmy2xkYs/I0o/PVCLe4xOl2NK
         gwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782956476; x=1783561276;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ShQQKj8s/Lgk+6VwLi37Fynh9m2UvesLoaAxNarS/n0=;
        b=jzLC3McMqzmISpfTbiCpnFYnKsIMo+MZJn3KLtbkJdFfeXFD7goMHWbM+eG5X66iVM
         Da47xtYipPznVuXvL3TtBgTntJyg122hb4TQRwntt2TwaavqoZoliNThzDnQ/50xQkNa
         W/jOhWGzpQ3PW06Hwa6YVg3whE2wS9W7Prxhep+Ml5+Kic6CS+DXErrhCHDFAqogNC3D
         D7wPfVSu4ARYKoVScR8OfYU96YOgIBlsFphGiBFvJxD9ooaKjl4zeRktd9wIvXvSD7KV
         8ERWmTE2rr6JCNGgokm+TmiV95nyq1y6oLUGlRD78zGmMSmc0SqjMsuHEuiK1hs9McHI
         j7RQ==
X-Forwarded-Encrypted: i=1; AFNElJ+exxo1h/VoEREMcBLz6OChYNINswCEpUBxDZJSK5LqUXTtOJyPkN2OOkVNL5pawliaTG8is9Co81w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypjkxpf+v+kWLtmBfzGF6QYb89uyXIniRe5B1TznccUyzyLGIx
	IdY9U+YfUbI8xxQn08tBz+Cv7ZCCXPX0pnfvX/r6VNeEDJZE+XU+dtAU
X-Gm-Gg: AfdE7ckv8Av5+DQmNTJBpryUlxa3GpK9wT/T6noUA9esbsULdyau74WHJwVphJsH/1e
	x8YikaNm941c1u9tlzCChumPOEZ3uD8P1cec0qqnnjCpTEYHiRK4kW8mL8f+7Mg9NQXJsIgQlf8
	0KzrArbl0Ri9h9ZvRTtEgvQKwEcPBQd+fT1jxJ3HQJu80XpUfKEVPvTrLqaFY+SHHORKovyN+BJ
	lbPe3YXrh440kfW2cOlBBdAvE456Vs646WJvJBDptnw8JtCAwpDFjwyE9O6o15fcnwutT7irZ3I
	0xGyId2cFTjmqmqJdW8ufZUdoDS1p1AJnT9qzBnF7RWH7Zv8nXdSoAau/fpvf2FZF5odHTB10Pm
	Cgxz2ARF4GQ+9NTSUqg5Aa2kAEBu6S+L2QmAU0TGsq2t9gaKTlB+8jnRnk8ce+knFquSh5ZA1j5
	c6COBq77vQDq4ipiyxY8jI3mqIeNYTAEKId3P97SOzHEJA/7MOOjn+QSJjhUzz/YV9
X-Received: by 2002:a05:6a00:cc9:b0:847:8449:2ba6 with SMTP id d2e1a72fcca58-847c06739bemr3641015b3a.8.1782956475767;
        Wed, 01 Jul 2026 18:41:15 -0700 (PDT)
Received: from [172.19.1.42] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb99f546sm546592b3a.46.2026.07.01.18.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 18:41:15 -0700 (PDT)
Message-ID: <ead0aab4-4bb1-4979-8451-9b5bf1183bc2@gmail.com>
Date: Thu, 2 Jul 2026 09:41:12 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: Add Nuvoton MA35D1 EADC driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, cwweng@nuvoton.com
References: <20260625110638.38438-1-cwweng.linux@gmail.com>
 <20260625110638.38438-3-cwweng.linux@gmail.com>
 <20260701221115.544e33fd@jic23-huawei>
Content-Language: en-US
From: Chi-Wen Weng <cwweng.linux@gmail.com>
In-Reply-To: <20260701221115.544e33fd@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jonathan,

Thanks for the review.

 > Look at the ACQUIRE() macros for claim direct stuff (in iio.h)
 > and then use guard() for this.  Be careful to add {} to define scope
 > to being this case block.  May not save much code but it will be easeir
 > to read than this currently is.

Understood. I will switch the direct read path to
IIO_DEV_ACQUIRE_DIRECT_MODE() / IIO_DEV_ACQUIRE_FAILED() and use
guard(mutex) for the driver lock. I will also add a scope around the
IIO_CHAN_INFO_RAW case block.

 > Move assignment down to just above the loop.  Makes it easier for
 > reviewers to associate the initial value with what is going on.

Will do.

 > For new code
 >     ret = devm_mutex_init(&adc->lock);
 >     if (ret)
 >         return ret;

Will fix this in v2.

 > Second part of this is set by the triggered_buffer call later. So 
don't set it
 > here.

Understood. I will keep only INDIO_DIRECT_MODE here and let
devm_iio_triggered_buffer_setup() set the triggered-buffer mode.

 > Failing suspend because a buffer is enabled is unlikely to be popular.
 > Can you not save necessary state and restore so buffered capture 
continues
 > on resume?

Yes, I will rework the PM callbacks so suspend does not fail just because
the buffer is enabled.

For v2, I plan to suspend the IIO triggering path, stop the EADC
conversion/interrupt path, save the state needed for buffered capture,
and then disable the ADC and its clock. On resume, I will re-enable the
clock, reinitialize the ADC, restore the scan configuration, and restart
the buffered conversion path if it was active before suspend.

Thanks,
Chi-Wen

