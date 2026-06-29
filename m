Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E1F3F0A9C
	for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 14:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782744873; cv=none; b=sLrQ1oE1BXW0HZy+5NJTbFtgX9f9zKPz0LdCJs7EC4cFhBjn4VkelcMcSpga3nPjpBQg5lIRblWrfs+37chg4q2dq/z1aekTRqKAON/JpbEBevC2ivq6vkMKsftyp+HnLOSELOY+nhG/tH8EjtDFHOk8FMQGUYQi3FCIs48Y2i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782744873; c=relaxed/simple;
	bh=v8CIyeLb1wkX+wqVPNxYQnc2a8miRec7mlz6SuvIKW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XvVyWJpAHvPPE43lTdFZEbhiGTIUu5IHeGfV6NQjNnkKWlVk3kmDMFQ8qXGH/T4luynRU9miOHpo1QXOD9o8qCoHLbkvDryLrPqlZZHa8vVJ/pXUAXy/bk+jwsgjYTbRQqda6OFNERQcL8hZqgTE2IDsL6jQkUgsQ41mw76AJaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Gb6cUZ+M; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Gb6cUZ+M"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6a0c7c4f55fso2542707eaf.2
        for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 07:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782744869; x=1783349669; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Z8Fz1fRVkTQIb2KN3JUG08EPIq1mQm84WayplzduZo=;
        b=Gb6cUZ+M9gtsVEyfnuz8i+HOjiNJOqHJjhwLfazTdEdCh7Hhdp8aLRxgJHHFHXkj06
         3Cs5wSFyNqGfDDq3/o4Hh1mjIkYN107xhn800h72ZrkQ5JWpfeVVNo3OXGVQYV+TrPqE
         49TIpK7j2TDEKBk7wtwtjOk2OgSLOdbHop8+jX+pGWWsTscQybbeGEP4DuH/wfxlks4i
         FMzEMbBsS3mYSzeHOFp0C9dd+4xmBYqAy3L2LNj0Nc8kdbsQdWGGKMywJMUFjjxQ+1tj
         kq9HEDKdirAUFOOZKjABl2W66HYZBaSJoKiMJdYI4CZEeSv0md+R8G5rQEzcIVjbVpIS
         j5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782744869; x=1783349669;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Z8Fz1fRVkTQIb2KN3JUG08EPIq1mQm84WayplzduZo=;
        b=oUSRIDo0wXVWPRkCn/8NytccLJDquAmt5x/EXw6LvtnzkUOmsw/o1k1wVH15gSm6YA
         IMplPW1yxkKgKMsn6RoDgnFG8auCR5g8yeTHgsNtkSsQSn+2LiebjoIEm6iPyhvD+ZMY
         okhhcus40FpqH7XPf/tz9V0hqAIIs0pPdbfcND2pwAGLC03vNA2YAF7KO8gdBhH0NtoO
         UzrQaOzU0m83FMjJEqTauIufYnP4TyukvOMKvCSHAFLtMY7o3aQ3JsK5YfzR3qvTS9ao
         bvlSWiadyKd5wVa3HeNibl5A6x9Njm0JwQNtUGJ+MC+Wxp0tV/WMzZWqsPAam5o7VrYM
         SxbQ==
X-Gm-Message-State: AOJu0YzTXrqrGNJfMeq5ApADIp1dDRbrYhGX7AeqsBZemRxXpeW7bCw6
	mMNh0iY9z/KhrE7Zpd22GtZ+Eq+O07KwqYUqUlqhtPTfnhRh09fU84gO2nO14/y1s3A=
X-Gm-Gg: AfdE7cn7MXIm1R/Pte1ZdevdIgWYQVrh0tnnJhEsZrxviW0YOL00XHZf29tJ0vMwIsU
	PtuKRmCaEAye6u1G2sfY0uDlHJEDpCmKDpo86F9wRVda9bq/BLGLL+7NkkA+yiu4Od/GMpvpb6s
	za1t7rObHmGGhgZX9KuapJY+vjWr9JmHSQmS8QXbIdk3tLTe0gzWec+5/ItHq8isOBIsyWDzotR
	j8ki16BE+CMbeVZ8hu5FP6VcRnhKJVzT4bXu0czSieg1Ow95NkKYFwrAF1xG6S4a5ldGSLv3nbz
	6i6FROTSBX26XRUZjNv7B7v7xZpMZLGyVfdNmIQ8hCEHKVqA0gDrmnS+/9cjS9JR19FJ5WqpFgC
	l0p6Z5Mri0+q/TriN7hUlcmqsdfpuehd8ybsSNugwCMsCUHHowL63WlESCtJJp0/JaS9hNOGnQA
	4nobd8GdPUOwMBAISiD5VinW//oZSSxmVRhj0bgXlsljB5UuGEWgvO+hB0NsyQBFI=
X-Received: by 2002:a05:6820:708d:20b0:69d:f864:d35b with SMTP id 006d021491bc7-6a1890a067dmr11074eaf.23.1782744869202;
        Mon, 29 Jun 2026 07:54:29 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3533:aa22:9a69:df1c? ([2600:8803:e7e4:500:3533:aa22:9a69:df1c])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-448db51ef14sm36094fac.0.2026.06.29.07.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 07:54:28 -0700 (PDT)
Message-ID: <06ce8972-55f6-4114-a3c5-1d3bd6f45d73@baylibre.com>
Date: Mon, 29 Jun 2026 09:54:28 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] iio: adc: add Axiado SARADC driver
To: Petar Stepanovic <pstepanovic@axiado.com>, Akhila Kavi
 <akavi@axiado.com>, Prasad Bolisetty <pbolisetty@axiado.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260622-axiado-ax3000-ax3005-saradc-v3-0-e57c7c7ae675@axiado.com>
 <20260622-axiado-ax3000-ax3005-saradc-v3-2-e57c7c7ae675@axiado.com>
 <6770a7af-06cc-4240-9b20-c299e7080ab1@baylibre.com>
 <b06005e0-b7bc-4967-ac7b-cb170219f131@axiado.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <b06005e0-b7bc-4967-ac7b-cb170219f131@axiado.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/28/26 9:33 PM, Petar Stepanovic wrote:
> 
> On 6/28/2026 1:07 AM, David Lechner wrote:

...

>>> +};
>>> +
>>> +static void axiado_saradc_disable(void *data)
>>> +{
>>> +     struct axiado_saradc *info = data;
>>> +
>>> +     writel(AX_SARADC_GLOBAL_CTRL_PD, info->regs + AX_SARADC_GLOBAL_CTRL_REG);
>> People usual make read and write wrappers or use regmap to avoid having
>> to write `info->regs + AX_SARADC_GLOBAL_CTRL_REG` so many times.
> 
> My understanding is that simple read/write wrappers are not always
> preferred unless they provide additional value. Would switching the
> driver to regmap be acceptable here to avoid repeating the base address
> calculation?
> 
Yes, regmap is always nice because it brings a lot of extra features
for free.
