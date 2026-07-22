Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118A7417D8F
	for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2026 22:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784760767; cv=none; b=RCfJSDPDKqb9m55T79IZ1iPuAXvdzwULJ1vRiQbPgsyJGbvui0Jps+VB9B4TkLygVn9Gd6iVMNToq8bTDZ5viEUJhEHuZOCS/gjUkuPIk2RHITqkj3zWAB7L4MH3OHwnQL/XR84bE3A9SaE/+qIqmm7jSQbbW+PWz0moGXTXwro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784760767; c=relaxed/simple;
	bh=Fy/aGwXLDw9xZkyKNZiQ1nsDvfbCsCKYle8WjcLBdVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jy1sra6q595Jjkhz+5xQkEfheLyNZjRKV/TCnOdB0ZC9ol0vuQd6iAgYVf6DmKYHmeO6ZGp5q+tEE7+CKLhBbycAv/frXNvfi0MxrNqfMq/nTypiVew7gUo9h7qjjoA4FmNkZJ/TkdGNr+gxuy77hMjr5PkEfTya0vrd9H8b80E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=IWhNpelp; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="IWhNpelp"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6a375ba035eso18689eaf.3
        for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2026 15:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784760764; x=1785365564; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SfqXKlSpbGunI+sY0fUkSRcHc1fv3ntgGeQCi/Ybvso=;
        b=IWhNpelpWTLFWLlPvx4yhGj94mKOY73YWVSoVRBGmlGbSot5Qi0oLfQE3UhpCuZ4Js
         TjbylLwCnSVS86ien4AfPK7cY3T/pF/5l8pwgNoA1uoCZ9a5Rr5Imk+KN25Sq5hZozar
         19UZo3Ds9ulCo/xdESsTLqfGig7o8UYvaSd+DECS8T5ONPRqikYHY22u1OAPjI8maics
         cgZvIPXRLad/7cyvnTOkc/BG5QVCyzghEBOeTVk0V1XLOYcoj7n2jAMtNCCmljtPRsHe
         n6uZ4bC+Zt4LIf+hqwqmrDUCDm+aPOSJAmhOf+dlc4i/k1cxxfbWx1SiB3QEEwJ+dkWs
         RNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784760764; x=1785365564;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SfqXKlSpbGunI+sY0fUkSRcHc1fv3ntgGeQCi/Ybvso=;
        b=X3W15WABEdcBxrqH/1DX8kx0b8t9OCMFUBl44mnwG9cfZdvnYfCPbje9WW1Q2C6d+/
         OFtYFcdopMSiM2vwajRUDoDqlCylj2tf1Zax90w0GlMcIyCk/q3u+pgrZS/dKpt2MR7z
         8B6vxnw/Hyy+YGYo1pXkAVwd1DQRfxV/wa3DNjmfyNQFpSgGJzyfEW+UuCgSMA4M7NrD
         6hZWnZlfCdQCo4QIk68RJ/xpoCWIAgnkJ5StRm6ZUdDptKGAsFImzWRNJ6qkKD2x9BQA
         gC7IluML28qm6cOsY89QycuM/8gXka8IRpaAWAFrmT5jQ8ayKTubkQzTrWFfSu9Fo8cm
         +Qyw==
X-Forwarded-Encrypted: i=1; AHgh+RoFMYOr9p8Hw3kX3EudCxA3u2wuesynRDrCE7EnlbIzoPanIu1ffza/ePumpxsxOYAyKdMpC2bxedU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy80nKzAZTdSwAQDytb11Yys8FlreZAB4ldW8fTRH9rPjf3RnIW
	jS+5sxrJRS2diIadAardyi4YgQ+mCTTJpOf03VKaecQQArFI1WLW3q+B1YOyOaoI03I=
X-Gm-Gg: AR+sD12OkbB8pjQI/Rbu4Gl5I7RAhpnvnUAOmW+eR/1vTVj6jvzBNQ9+fQtuiIpuojC
	ZupKN0M9hjn4ahQB4AVg3grd03gOdMENeJfi5v1ITkh/v0/lB/0QOBbzQ6ECvIPFmpaAtYBkZdA
	UyfCz0QCjRM3u9PlFaiCt5PajRHvAqJp92zWbKPttdXD69oqA5HH9Wgfsqjv5efN11ADtng/fS/
	YZBElwCHfr1z6Mw2BmqpkpHnGZiS2koIbI7M5Pg/bkIIiAOs3+f6ueM3cDdb004YDI6T5Pwn4VL
	hbAvOHkw4JbAOXe1o9raqwDjoaEwDyGbRK3ivHc1aWKSHgy5DWqn2tn31cLX9XWeHBLwZrt0KiB
	MZeOmEDQJn7h7bXFSdt0GiJsMkCTqjmFcLIH4cdTyrS+6nf2Lnnb6zcdq8/Hp1eBjtFAbk9NKtc
	IHR/PbeA1k/Z+fPoCD/oJj6F5uzhM890xGQ8UQJMceny9IHeeOGA==
X-Received: by 2002:a05:6820:2008:b0:6a3:97c6:f813 with SMTP id 006d021491bc7-6aad4149d4dmr197548eaf.47.1784760763903;
        Wed, 22 Jul 2026 15:52:43 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:50f7:57d3:643:9739? ([2600:8803:e7e4:500:50f7:57d3:643:9739])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6aa76230b8csm2354061eaf.1.2026.07.22.15.52.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 15:52:42 -0700 (PDT)
Message-ID: <c8bd955b-1d1f-40e1-bede-82e5e9a7bde8@baylibre.com>
Date: Wed, 22 Jul 2026 17:52:41 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] iio: adc: ti-ads112c14: add debugfs register access
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Chris Hall <c-hall@ti.com>,
 Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
 Nguyen Minh Tien <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260714-iio-adc-ti-ads112c14-buffered-read-v1-0-fe6e1c971288@baylibre.com>
 <20260714-iio-adc-ti-ads112c14-buffered-read-v1-1-fe6e1c971288@baylibre.com>
 <20260720012446.27f0411b@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260720012446.27f0411b@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/19/26 7:24 PM, Jonathan Cameron wrote:
> On Tue, 14 Jul 2026 19:19:30 -0500
> "David Lechner (TI)" <dlechner@baylibre.com> wrote:
> 
>> Add debugfs register access to the ads112c14 driver. This is a complex
>> chip and being able to poke registers is useful for debugging and
>> diagnostic/calibration purposes.
>>
>> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
> Given this one is trivial, applied.

Did this get dropped or just not pushed out yet?

> 
> Jonathan
> 
