Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C432367DF
	for <linux-iio@vger.kernel.org>; Mon,  2 Feb 2026 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770046309; cv=none; b=sut5pm//HDpR+BK5yDVvc1+jx5wOUTy+lglw6/DdvkqwbO3/Xlv/lppGo9eWbFJjxMON3Th27HH/gX05Wm27DGMcy6lxJCQ7LVX4bE92gJlJwDjyMb67g2Rqmbm6XeaVtrtULTtLxtj3GPbyviAYB7p+qkh4218Sn4soS+A1vMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770046309; c=relaxed/simple;
	bh=HaSLdUfjo+ndtARltuxzMFZ7pO7xIlqmAt9VSiMwTRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rOe1SIgt61xg7XP0n9YmsASWKdz4cryLV/xznKP5Op2Ce9NIcxXWts/sjrb9N3xa6TLGBIup2Nn4H9pkgiEAdt99Mq+X7ytG5biho6ndvAd/FUNgApiosYsrLlM1eOr2JHjhe6EspcGCiCZ/DprAXyvf6CG8zKh/dqQo3EOfx4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=C08Ey6VJ; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="C08Ey6VJ"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-45ee8823e2aso2805604b6e.0
        for <linux-iio@vger.kernel.org>; Mon, 02 Feb 2026 07:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770046306; x=1770651106; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kgPLskVZbsnwpPXjI0Uy3xPQbW7GUfPIAOi3y1K2veg=;
        b=C08Ey6VJLhV/xq7zMUwqu2azzvc9O3JrazCwCqVbNxkkSX+hLHSDRnlEmlUeLQZA+0
         mbMA56P9TG1iG+tzRuInFnxU4AUmjsCHvEd5AXyIcEYztETIsOIpqWaumLW1OCn1iFLa
         DvH4fLVc8E+1RwUVQzPCucACg7Mu4DE1+yd1XRYYke9PBHZE4Up5xexj51r9TeiFm7f0
         4OJX/gXV9tyPD34EY4Q+0oKtVP/ZsOFNuJiFob+inThg5Wbg+dLCYWBfV0je+65RP7/y
         Sg7EaDe9XwHxxRKfthe6NcbyctS2OfSUrDPWv9fckpYOKKBOmBuZfNRsP9D0sbhz63GQ
         LBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770046306; x=1770651106;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kgPLskVZbsnwpPXjI0Uy3xPQbW7GUfPIAOi3y1K2veg=;
        b=nYw+m0GKBjIAH88LIHcNhbtjfsRzIcFgdzPWGL0dnn9H0LsRES/JCOjALyDmFB1gpF
         A+liRT/z2UwN73d8XWJ/vXO5i1ENhj3cc4DWdOKIoueClkzvKWYlp88nO0DJr2UTxBS0
         18VulExvYpNtb+r3Rq/V3N961lZODihGkRY4tF2FfeaLEGxKDeATbG7U4U4hNiXNQEqo
         C+UNEtq2CM7ue53NpufepXNhjwt5N8SIR5O2dguVkYBQNey7lt6hwJHB6Q0hsDzReQie
         hLhNL/bMQa0Gj3XJq/atJjFneukjQzSh3dFW8S/QTEteWeATL2qmtv7Be34Tr6fa8UMQ
         uYjw==
X-Forwarded-Encrypted: i=1; AJvYcCWl3rEEb+3OqSguSum4n2n/QibL9D/2IzAojB1NJWu3cdFcbsH/d09zE8h+TftGp8EU4ppWmVnoDAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhNxABfwMn+vbUph05AqZUqYCP1GBT2f0v34shipj+UXXdgtWr
	KHyNJS3fF4wf2nfpfinjyl1pSf0ONQPKEXgwZd8S+e6FxVekC0DhV1im0JhDnea/8JA=
X-Gm-Gg: AZuq6aL8+fZhPzYWpQ+9jGXGqn8sMg5gqoQEhQmicP3mgTe4F9p902ykaVezcHVrQM2
	7XQZ+mdLCbK4X7RZCPuY97spMulSVBP6gDR9Q40SDxaJRgKNntAKsdnLOCEQcemyQ83RP+lxWtt
	Z99GzhRdo/4OkC2R27A0D58GcBJ36eY8GQf93E9UoLl2tFNRhpY8KcpwJ0bfMmHBaLvL5Gh+Ld/
	vWgUdvUC8OaIp5UkKjnCAxVjCEvd/z+E3Y8HNyj/jp/nLi1iSBHlOSWlZ6tW/KMQ7aUpdkumJQY
	SH/uUWmYXv/vHVTZgLRAB+xkTfApJuuSF1jzZSHltGr6FUxuSMm6T8cnOryhoQDDm2EgKDVFgYG
	68N2Q3XNkK/pc+hOujr6SoDf3XiEWOWVMPPRpcH8BcrTPwEVFanEOXmy3SxFKTTyySBPGZFoXAe
	AzZvPTQlrcQt4mqjsUiyku0bD9FNbgOiG5W4Tb+eOB+FYWMap0qPd0srX5PM3l
X-Received: by 2002:a05:6808:309c:b0:45e:ab3d:2378 with SMTP id 5614622812f47-45f34b3c8f7mr5806724b6e.6.1770046306640;
        Mon, 02 Feb 2026 07:31:46 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:3695:6954:27c2:42ef? ([2600:8803:e7e4:500:3695:6954:27c2:42ef])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d1a6dd4423sm6567145a34.28.2026.02.02.07.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 07:31:46 -0800 (PST)
Message-ID: <745218f5-fe09-4a20-9cff-ee2ca28143e3@baylibre.com>
Date: Mon, 2 Feb 2026 09:31:45 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] iio: core: Add IIO_EV_INFO_SCALE to event info
To: Taha Ed-Dafili <0rayn.dev@gmail.com>
Cc: Michael.Hennerich@analog.com, andy@kernel.org, corbet@lwn.net,
 jic23@kernel.org, lars@metafoo.de, linux-doc@vger.kernel.org,
 linux-iio@vger.kernel.org,
 linux-kernel-mentees-archive@lists.linuxfoundation.org,
 linux-kernel@vger.kernel.org, me@brighamcampbell.com, nuno.sa@analog.com,
 rdunlap@infradead.org, skhan@linuxfoundation.org
References: <afa85a59-07c7-46c9-990a-b0b34599cdc3@baylibre.com>
 <20260202151939.15893-1-0rayn.dev@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260202151939.15893-1-0rayn.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/2/26 9:19 AM, Taha Ed-Dafili wrote:
> Hi David,
> 
> Thanks for the feedback. You're right—"missing" was poor wording; I’ll
> rephrase to "implement support in the core" for v3 to reflect that this
> is an infrastructure addition.
> 
> Regarding existing users, the current lack of IIO_EV_INFO_SCALE in the core
> forces developers into manual workarounds to stay ABI-compliant. For
> instance, in drivers/iio/accel/mma8452.c, the developer used
> IIO_CONST_ATTR_NAMED to create a manual in_accel_scale and linked it via
> .event_attrs. This approach is static and bypasses the standard event_spec
> infrastructure.

OK, so it looks like there is just one existing user of any events/*_scale
attribute then. That would explain why there isn't a IIO_EV_INFO_SCALE.
It just isn't very common.

> 
> My goal with adding IIO_EV_INFO_SCALE is to provide a standard path to
> report these scales dynamically through read_event_value(), ensuring ABI
> compliance without manual sysfs boilerplate.
> 
> Does this core infrastructure approach seem like the right architectural
> path, or would you prefer I stick to a driver-level attribute for the
> ADXL345? Regardless of the path chosen, I will address your other comments
> in the next version: I'll fix the "in scale" typo and add the new scale
> entries to the adxl345 documentation table.

If we think there will be more users of this and we want to make it more
discoverable, then adding IIO_EV_INFO_SCALE seems useful.

I would wait until Jonathan weighs in with his opinion before taking action
though.

> 
> Thanks,
> Taha

