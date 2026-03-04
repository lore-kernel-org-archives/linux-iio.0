Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29B4378D82
	for <linux-iio@vger.kernel.org>; Wed,  4 Mar 2026 06:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772607406; cv=none; b=CuU/AOq1Du7Ef5xmuPA4g1LU0UuebuoWCxFdqv+figEQdyTmYUw0MGNguYuzqzAdvmoZQFZPWxjgCPF3NrYzH/YS2aWJ2yi0buFez1VkPtoo0I1Fl0BCAJS8mBs6ELdrQcsbsULL2/+GLrrFk7AZK8SMmw6mBxr8GZA7R+0ToIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772607406; c=relaxed/simple;
	bh=4UOYtFSeMguw24/TqqMglohRz5aWSsUdE9+b9mrr2zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U0gaz/WTdkZrOwMrKjKeD1btrPW1qfOTENNYxzLdcOL5QzlVKQWwGJ3Gbg7WfRCYM3iViFr/TS/Bk+nvStmqe4BRCrBPqUTURN5YxosUBGfAGnfELcOdBBmZODh9s1vGSkulG4tvZYck1Xgy5N8h0QAT6YFAmchKVUAVAEmOYtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uJcf9ilX; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uJcf9ilX"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4836f363d0dso57219395e9.3
        for <linux-iio@vger.kernel.org>; Tue, 03 Mar 2026 22:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772607402; x=1773212202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nD2A+kf2ghmCpKz8sOUzF4SnfRCxibAXQaK83nThncc=;
        b=uJcf9ilXIzEAKhWlXgZ1dFXvE5ujoPgSuBzxHw8D6G3TCH8+jUw2JEOtaF7UJzMHk7
         howoOSMC+uhpN8jxFFA6LslGXDoICkrp7k/imiT2a2nPoFP/TdelD1c1Ec3hG6OCsKko
         SD4Fse2fbtKsNBbe9xpY0+qtXBsieZJf5TwpL/GcXpQmYJZx77fYSyOn3zvDjs1TFuQq
         TuLvKIbn5G14+QUIuYq90a6aFDtX0ajjiJymWrqAzmGkN57A/FNhmSUzDNh1GqvDU9ir
         L1fdAl6gGzjLw6MPCI0+YTZDQ7PoiXX4FineFkOBqmmJOvRUcIwMNIrLXNpB3mzxvMIA
         CgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772607402; x=1773212202;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nD2A+kf2ghmCpKz8sOUzF4SnfRCxibAXQaK83nThncc=;
        b=KGZdRrsdL8WbQlQrQ7HyLntz+QODa019+5iSYIiyeEER00jfsZAeCoYi9NEJ9qgWMj
         soGQ3QasY2yUClTGxw0l2fbYhNnl7jE6VQuFsAOu/07Jpqp8yQBu4MJiKFeFIBlya7mf
         Q/J+lntM2FgrRmToeWnfoI94JT+eTYgDRLnfe1HMnBHawcucz8m9vI7C1uA80wzcHMYJ
         d472npAx97g4w7d3DjX1qDu8G7vmcj1YNBGuiBYZ4kROIz6DAFtde5GnAziqUS2nI48Z
         /4MBs++X8WyFmOsilCjDNIAAOo3i/iGuNKKFMSE5BjRnD9gr0UzfxgbdCSUgpxwxjKAA
         /MCg==
X-Forwarded-Encrypted: i=1; AJvYcCVxa50VJ44K5ica5QuiOlFWsQB7fiWSUYg/5Q5DiuVXAN1uPpojpDLmEnV8Z8U+B1G97LVf+jhgpa8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1BNVXRhV4WmnpTELKXQYw/BHneMaZ7m0vjnNevT1aAdYfs+kL
	wqm1zTOnMYKYxw3qS0CW8l9mUmrrf3nmQZVDoMhwjuk3FVMU0S5IjN0C6GIuEQ4bbzs=
X-Gm-Gg: ATEYQzy635IDE3cYBiO1UhbLYjqRyESprXewXZvV/G1PolcVHwO1y/gQKfGqzQ0ejqS
	3OIZCd7jrutaZnioHWt8361uHKULaq245q6oWfQOrhIVvpyfPE4THCGsKKo150Gpn0dw9t7ehnQ
	qmlEh6+mKrUGLsPIP2O51yEnU0p2YakcepCOGswZjhd0zroWPWZ+RuKAe18i7w2+9wyqKj/ObQE
	CPYVsM/CBjNRPvlIQFOiM3RO+ZExDrWCMzC7I646uuyxd9DSghPvy3ZWTCiqtO//AdO+FftSAdn
	FKz4wV0134SqYLx9SCuUceXgN8ZOnv0FcfhMP7C7AtsNcskgQuOmsfmkielxGDDi7i7RfLN9kBn
	4RQzTIhsHI4W6LZ/DyucsyKG/+NQBdldWX6LevbIDqKd6HVWkhT5uKlZJKyU6zAHJuEed1NCXjf
	hlDr6rHwtjQw2iuDkEcuAZkqveFXREFw==
X-Received: by 2002:a05:600c:83cd:b0:477:2f7c:314f with SMTP id 5b1f17b1804b1-48519846ca8mr14622775e9.10.1772607401946;
        Tue, 03 Mar 2026 22:56:41 -0800 (PST)
Received: from [192.168.0.34] ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439c6129017sm4427391f8f.31.2026.03.03.22.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 22:56:41 -0800 (PST)
Message-ID: <b07660aa-56e4-4d71-99a6-3389bb4206aa@linaro.org>
Date: Wed, 4 Mar 2026 08:56:40 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: at91-sama5d2_adc: no devm for nvmem_cell_get
To: Rosen Penev <rosenp@gmail.com>, linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 "moderated list:ARM/Microchip (AT91) SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260304041843.7709-1-rosenp@gmail.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20260304041843.7709-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/4/26 06:18, Rosen Penev wrote:
> There is absolutely no reason to pospone cleanup of this post driver
> removal. Just do it immediately.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---

Reviewed-by: Eugen Hristev <eugen.hristev@linaro.org>
