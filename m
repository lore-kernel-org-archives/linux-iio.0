Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792923433;
	b=cD6ncEjwzQKOBQQdGOJMNUmSsiDwt5BFPLql91SmmlGx3YalbgINinUIOCnrDi/rXasn
	 O6Jz6Mn+6cd4kdn6ILsh6iM9QO3KmidjkyecMQIkph0v+fz+AMBFpQYOGQ9jF9yTwGEwV
	 vsS9KltlBlmmRqLxqPrHVI3BVpEESCiRrZJYF2ZmQ8f+lgSl6PTxxTAqZ3sGG8K60MRy9
	 ysEb50y6YELRLQntQ+MIIoE4VrqwNE0S1GU7xpuO2PsgSi49HB379/NGRAZm4+kIuf3R9
	 ve/W63yeGSN5jpUrhtXp4SsLEPJ+P3YRYx/ig7tBZjWlzTE2HWwe+/R1qrBxZtIjYWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792923433;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=p55qrhCyb8bxNriwh0vS71dSvlmsqPiAx/g1ELCZR1w=;
	b=zKZKf6AybqmIjxCHz/DSXB8DVhlIhMDmydfiOC15n16wSp4zCNUBk33rJHrEC1fjuq1k
	 83v5O6afYSds1ItHC1W1D/3CtqdxkYRHffIyP1VKUqzk4qKBE+dvrV6iAuIZPJNimCmxC
	 OBG/rm1eqtCvsdG3pRfZKNcPxo7wWJo7wREVZdPhczyGhT5DTmYGHpFc0wol79/fKq9Zc
	 4MVGDHr+7Qw3QLpX+RH/I9keQtxdvk1lLii+7vjirZA1bahSozj/BZ7bR3cu/4+vZqF1W
	 1rAyrZdOJxt5L/T+WytNc0mXDcztP3vJq8jHdyt241zyqLyvixCns0YSCgFByZ5WHsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dicwZ0eT;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25C2606A31B
	for <linux-iio@vger.kernel.org>; Sun, 25 Oct 2026 10:17:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A25C2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dicwZ0eT
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48df0fa43c5so1274204f8f.0
        for <linux-iio@vger.kernel.org>; Sun, 25 Oct 2026 03:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792923431; x=1793528231; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p55qrhCyb8bxNriwh0vS71dSvlmsqPiAx/g1ELCZR1w=;
        b=dicwZ0eT7zq6YUUFB94I/WXO5NSlGex+hWh0GEVXR44ffPnN3MbpD/WEElftVxleU+
         DOuh7AXK1KJcOgKI15DQCk8hylTYjJ4XHQqisS06cXDne10O0kaP5JgNcOsa6u5DLnMw
         IjZnTxtx/fRmOW7Mx+POEbJH6h5nffujIGdqSYpBm9K8MraGb7luDjNM3rggiyynruVl
         LPyFfYk05E3DaN4m4U3AUwPYRUfyiohPyN7tV1Lq4TJ8ZCr4JYPaoaSstlLTh4s1vIKV
         iGQn+IFoGseKl5dEZyWX5pFIFpjda3YXAGpFMSctygoAk23DtAaJ5nPJ8A13vYsuPCc4
         6DMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792923431; x=1793528231;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p55qrhCyb8bxNriwh0vS71dSvlmsqPiAx/g1ELCZR1w=;
        b=DhwUfl5UX3NtrUg9LEZ/mFIclJXceBEdLbhltsrraYbIdVx6ur21gLr1OgRMwPZPiG
         2D57GkXnhHfnFYa/WdOgE5B7/Cq3E5uYr1oASM8D8I8FeociAuoMW/Qf94I5VsZhvClk
         tFRDs9yTSMWGKV6403Ch2iN4IHSukOw6UEnOPvuCgTmym3XofMDEP5LD2KnmeyjAzRBe
         rutw97/dYVUUAPIzYX/yBRlSDgj2OTBYGJYC0ybdDJG0alywiXfX9c1Yr0TA0JMCd4gB
         FPlYR6IeYsXE5NgSv5kX8DdyzFAo8ep/wYAGXZMVvX9P6XjG4CYp0fJKh8mS7OUDvZ5C
         s/Og==
X-Forwarded-Encrypted: i=1; AKwUvBwajmgYPyMJBogjgDfK0TeA38HqJ/pm8xIZUkQBHjq/DLTNlpa96CYmwbgwpNJsR7ATaYctDd3T/z8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIqa6oJp7M15Vn7j13A2cnfm7L5XwG9CorfmRhtfHkTDxPhzD95
	AcaopKEeGQyU9GJEfVVIXoHjNj30Vy3Ny26HvkUeFIdnwzAlToYZg2G3
X-Gm-Gg: AYBFou2dVyKORyYbSqI4FaauKJNjmY+LqdUO3ihBcu9suFEeeAQaIgkzd+UXeTarSjP
	dzvR0hpeDPjIWGNj1dQ8PPJN8DMG0+CjS64Dxo8owqwEAocRhRqK6h3ytatvTD/ljIb8nXtVTV2
	wiel+EGEf4SdXXxEXIi3WGgEg6mMQgZ/N805cPUjYoicq1C8KIk8Qx2ZQ3K7uGtTH6Ubt7E/3Rl
	2dvVW07DSlNAQeWMTKM9DVmWt9LnZEUa2YE6ZBagGSt9JouE00yBaTCugD5y2j+R1zgsEUJHnEJ
	yM4fNa+eKEPrVJphGg9Ha1ZXpSPGsQMbU8iqCWZ2GbITHcN/N9Cr5T1zJZ53skO7/CTaxotQiBd
	V5im7yasntCgp85abI0m+aJBaLtgmTnC+VqlQhleNCog4Ga5hfLls+FgYFN8ljVFrhC3GdAog4t
	k2f+8dqudIUL/F8p/Bh0AqlV1hdT2MzXKfe7ZtuhKO30yYNyOzai7ivbE+nGgTmQXruPRaRVHo+
	7szjWsI0icTSuKeVMl6YYuiRaduuPRhwtz3oMasj23SEWGTEqs+hXZD8/qd/TVMvZjD1sXp6L+Y
	v0jlYmjEXzk4eZ+zglUmkew42GHweA060ovxJyScbei3PsGCCQhKdac6NO+l3QVrZQymvLKAuvu
	aMFgMyZpVOgjrGdPURLql2MbrWR3vb2BknQryos4nmXgoFdcwkWx+PAckPmgsLVZt4clpq/DbaT
	Srn0JoR4VSfUWT
X-Received: by 2002:a5d:588f:0:b0:48e:eb:56c5 with SMTP id ffacd0b85a97d-48e3ed08f76mr7079445f8f.8.1792923430870;
        Sun, 25 Oct 2026 03:17:10 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ece5e4asm9068776f8f.59.2026.10.25.03.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 03:17:10 -0700 (PDT)
Date: Sun, 25 Oct 2026 11:17:08 +0100
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: David Carlier <devnexen@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Ariana Lazar
 <ariana.lazar@microchip.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: dac: mcp47feb02: reject out-of-range raw values
Message-ID: <20261025111708.233f7fb8@systembl0wer>
In-Reply-To: <20261024214423.865635-1-devnexen@gmail.com>
References: <20261024214423.865635-1-devnexen@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 24 Oct 2026 22:44:23 +0100
David Carlier <devnexen@gmail.com> wrote:

> mcp47feb02_write_raw() writes the user supplied raw value to the DAC
> register without checking it against the chip resolution. The parts
> are 8, 10 or 12 bit, and the bits above the resolution are not
> implemented, so writing 300 to out_voltage0_raw on an 8-bit part sets
> the output to code 44 instead of failing, and -1 is written as 0xffff.
> 
> The out-of-range value is also cached in dac_data, so it is written
> back on resume and stored to EEPROM by store_eeprom.
> 
> Return -EINVAL for values outside [0, 2^resolution - 1].
> 
> Found by code inspection. Build tested with W=1 (=m and =y) only;
> no hardware was available for runtime testing.

This should go under the ---.

> Fixes: bf394cc80369 ("iio: dac: adding support for Microchip MCP47FEB02")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM

This tag has been deprecated.

Otherwise LGTM.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
