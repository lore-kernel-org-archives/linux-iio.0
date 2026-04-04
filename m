Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D2532470E
	for <linux-iio@vger.kernel.org>; Sat,  4 Apr 2026 16:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775318686; cv=none; b=CtlSIdGFGObXMEgiZgx+f729H5NRaTMCzaCbdD9V81zfFFkWbJj/eRyvqmnxhntRTRxRznmzMOPFO8EEuhTI93p6nDwVrH3i+Ne63M5aAbMHXj8Tg6uZerwA3gJcZz/HAi7cZLsxv1iC2wyU4LLvP4cdzSO0I/YZZK+22aA/WV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775318686; c=relaxed/simple;
	bh=vR1gq2NMqok21ndSyGwYozpFx0zjnkqwevwKB53zh/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TlujhBeE/d3Hp0YOUEH3tkxHKksqDT1Scx4VSjapqLYG2H1wLKv12FNfhVPEafdv1OaCOIgYl0zxmX99N0iDrXDLTFRNZmz8s7ZAAUzn/IzQRH5x5XiKTAhoRiHWT+9Jyu5LVzcM0qdE3SCfwHgmQr0tQMkPTvDnBWfk7lRNYYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=sZq/1Jva; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="sZq/1Jva"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-463f00cda04so1566096b6e.2
        for <linux-iio@vger.kernel.org>; Sat, 04 Apr 2026 09:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775318683; x=1775923483; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+wzVnwcdwZGk4+8lGBJhDoWkSR8wcMoOHjT2H8NPOcE=;
        b=sZq/1JvayMpIvUAJ3GMOIofmPN5JsRVmo43dh4DsfM6gx5kfGJ/Yr4UiXWfir9GZ6O
         XCdJTMryYniz7l9i7hyXaVBfNSWZtgW6iZLv1ayAeniTa19ELQjITGdReKreq53FY4vy
         02hAEsC6pcuQpuIR8uCGhURsrV7qx6rK8R2LmeUQtG9VhlhsDnqFGA2erIIStF5GXEna
         uuMq9+uAOuxEa1qJd97C+wFbDsYFmEHjtTJCZA/NwTQjRvWqsZBYdHOlZJtOif+t8P/u
         DgoeuipavxbiyQKlDnjISszhKtvOax2pw/1B/qhCI6CadewMN+XtybXuWskrMablf/or
         n6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775318683; x=1775923483;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+wzVnwcdwZGk4+8lGBJhDoWkSR8wcMoOHjT2H8NPOcE=;
        b=SLoA6AMYrIQ49HwzrkmRm9PoFiEbMMl6uJh7IdFtWPlm6pE2FChA5FVX7Q/dt8rUF8
         njZYC1uE4TUnFbPWQvUh+vdO6ZJ9JsO0Bj/1+4NC0qxaVqzq9sa6qpJU2ssgt0cGNOgC
         e7/3kqTDWDEr6OhuSxYKUgENuie7gA8hAv3epcDjj9kGv/QUXV/1eu41+GvZ4CTJxQIC
         WldvDQULhzu39M7aEkmYG8/hIx0J+8z57FkIAyF4upAHprxm/3RSJ3E+St7iKDjDdOHe
         ymYRHWHpH0Lk6its9bKwPmE+l52cgN7AqEBytTXIlWnBzJphvxLs/mMum/MaigA740qv
         52YQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBMqIBgRGvQJSohp8b2vKb0DTww84HVvQF5zrWnwsIFNNf+sdGNLtFz65V1oyctuXMvdIrNoOGj9g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0qQeMOjgG/z5mKdkGavXXd8afXg/rnZXaT3Q+yp7Px/QfiM1k
	wbHrshkrc/RJavswtwBtL1u74rwYwB3POMpYAOYaTw02Iyx2BhMG8Vo2d1j1HDXUhLI=
X-Gm-Gg: AeBDieuNgSdocg8Ec6aZ7sXjfckYCif4OTyyh5rpEoSFvrCC64YyDetH0LlcJOxWW+m
	7cBaQnKnUa9rP4Z7DQPJ04SC3MnHneO0CnEnqt+zYqLXy4KqbNhtIgGxEx4TvSJEl8sWDARJESk
	6oaoweJxaYe/F7qCmkH2k08Nwlb2ipSDCTZ+7ivySGG3XU8rqxrX1YwuNNqxO21uN3h8O5XwQNi
	XFKfGA8Vt4RAAqk1aan1cqiQiZLbf2tE7fwbCcvlzQ9jQtNZDO3sbimV0gnh/yugttAEQxq/PwF
	m5+rhTOYivy4Z8muCbayg14Onh0xCaoIFyzXoKJVOoMkSOLX8/QEXIQ7wvZosX+PdZ8rNxSOaqc
	n6wDw1I+bKK8/vyRrK5InboWY760NKt80o/Rutu8I69Vjn10F7Ibn6YfHn3moUnwvGp+ltVwCW5
	fr4Ydi1okF1fCYQq0Tp4yBmp33QHsKbSZ238V0RZbpAP9se1m1ko66JQIMHW0RDuSO1zaMBZAQQ
	A==
X-Received: by 2002:a05:6808:c2c4:b0:467:32c1:ad01 with SMTP id 5614622812f47-46ef8a4c2d4mr3215290b6e.50.1775318683418;
        Sat, 04 Apr 2026 09:04:43 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e14e:bcc6:3f95:26eb? ([2600:8803:e7e4:500:e14e:bcc6:3f95:26eb])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46d92a53169sm5285749b6e.10.2026.04.04.09.04.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2026 09:04:42 -0700 (PDT)
Message-ID: <1fdd057a-3234-442c-b1fc-88bfcbe542b4@baylibre.com>
Date: Sat, 4 Apr 2026 11:04:41 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/5] iio: adc: ad799x: cache regulator voltages during
 probe
To: Archit Anant <architanant5@gmail.com>, jic23@kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260403080614.14213-1-architanant5@gmail.com>
 <20260403080614.14213-5-architanant5@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260403080614.14213-5-architanant5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/3/26 3:06 AM, Archit Anant wrote:
> Since the reference voltage for this ADC is not expected to
> change at runtime, determine the active reference voltage (either VREF
> or VCC) during probe() and cache it in a single variable in the state
> structure.
> 


> This improves the performance of ad799x_read_raw() and removes the
> dependency on the regulator pointers during fast-path reads.

To make this claim, it should be backed up by performance measurements.
I would drop it since I don't think it would actually make a measurable
difference and it is not in a hot path anyway.


