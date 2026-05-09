Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F9F312803
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 22:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778364811; cv=none; b=c/K/dzfmyx2ZILHzftuS+Dok5QhFimNj3hD7FiCRMe6OO3jE1/nwgJKtG0yLC8kkEILLHop/uWp3enRZcYg1nFXok22DZYS07ZzDUV1j66ODB5QdjGAjM9QeFI8eppG2i04s7Ia9Xx/i2NlPo5dCcqlbShNBKk6GkOn2wIOzz54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778364811; c=relaxed/simple;
	bh=ajMktPN5dE/0zTfAbL6LYio69CScSiBxy/WwtsfhuIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pusF/IyeuU8hXj9x3D6zal0CJmMNvxYb37GPuSKt8f96aAUsfebN8jEA2DOMDw+6HyAMBQ497j4Q6uFb2tLDpe8vtY0hM9QiKjp4QapXOwo2n8JywGtMbqSS3BayA7aidluFzV/WVQxCW+C3LzXpFuAbkl1UD9MvOoOoa8ZOzS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=xJCkimn1; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="xJCkimn1"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7de44ed7a11so2474922a34.1
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 15:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778364808; x=1778969608; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0s0yGqYo3DnR/md8STebIVdegAKBozc0q8d7VfRQCyE=;
        b=xJCkimn1gySx/sG87zjzkwrKqFvdclQCAPtiQc4yDTs4KIlzEkun+zQcChN7noy96J
         J4yl/X80PP3CUw1ZQgQH9OCK+6h4amnZ3ooHeroOf39wa837aDifV3vFDxiTvtaPwGm8
         l6z7yqnH8GapOeCBLC860v1CPM+DRMtAlfEYm29b8PNE8VG89fJeWqLbJPyZVrxjQHWt
         hJmSVbCXzQl64cIb/QtPgjowgqNZiDc3my+umfuqhctU07vQKPHzcce1u6rJE/CszivN
         8N38QcjggWTI3rNeF9/WhS+YaFsxANh/xlSvD5vy9tQ1LKu0rFvgq8F3/1pz7WF7tpK5
         dSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778364808; x=1778969608;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0s0yGqYo3DnR/md8STebIVdegAKBozc0q8d7VfRQCyE=;
        b=aFhwS69GkP3MP1A2XeNwXpygUV+dvzi9YzubFhSef4+wKoaEjXvbZz3m8a6PqQqpkh
         ZpHAU+D3CJcmlGMqPPbbsiLm/aJioYuzgMvcZNaaJd54TdUKjKchPBRr+8x554SlRgKv
         IR73WJWPPeS6BJEOv4E7eL+vZWHFBCUwsDJGjMV2WjHFnVenMyOvF/RgDfDBa387d5Gs
         jX68ksT03rmVDIdFZCckdraLKroiwGst987DHiVpIHFOJI/B4qlug12zf22rcNI9qATd
         95V97jcDUzCDhMLqIdIUiPWMT6biKcmfgUEgEasAwgM/gCtDo8nzZh6zrN+1gKOPaAm2
         35Tg==
X-Forwarded-Encrypted: i=1; AFNElJ+S7vAVuAuXj1j1knE8QgYjirj/cQf75cfkxNJW/KyRGgvX3w3tZlKheL0FQ2MKLXr7RjtUVebs4Jc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpff4OjqZc5LrazVVG/mrsOgdTLakVTniPFAH1R802cq2iRIIN
	e4ayTqNZayXY8k3FUOMoC7TqQMrNGTNYsUQxBDc3tyn4crwRsprmvp8FnWJXk9JM0Os=
X-Gm-Gg: Acq92OEJfSMyJWxqDWBF36SjIo15eRY9gFNDSzqlmfXAr3sBQY4g9bvw/TH+afoUxL9
	mbqicrPjJq2pVyJUsn0n7pNgOC0fKQSnXo8DGZMZ0yoopy94rJWxPK/rzdojzAa5jJYCnoV5diz
	kJAlr8/fhHnN0e275ViJHfBzSiHZ9+DQAZ59GZNaOAHy1C1XRO+dOuy4ZBqxtHzT/JikoL+7cqu
	n4duPAMi8yAhivF+6UcZz4I/EsnGbFx3IyTPV99mHz5Jhn6owP034kL1M+IzUlOuMK1RXMvAQ0j
	aiy7x0JSanIm/wNdOBBnaRujEQVCxsbQet6B+7bOKpoM91bWlmCRX61zko16yk0g+p7l6OdJO5n
	CwqYRDSj7aQ0gLq3F5qAE67XILvpuQ+TIbjm5WjnHptvD3FSWR9Ew/7SFkP08kutzhldCLNYwBr
	PaWtZYqpQXWJKO+YA7ayMI/Sdm3+9AgM8bgM0+KwRoUitz7QHt2NGfu7/ykAniIsQjEWbucH1Tb
	iSzvfRi5Q==
X-Received: by 2002:a05:6830:67f6:b0:7d7:d60e:650a with SMTP id 46e09a7af769-7e36685a061mr5437555a34.23.1778364808623;
        Sat, 09 May 2026 15:13:28 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:12a0:9178:ab4:39cc? ([2600:8803:e7e4:500:12a0:9178:ab4:39cc])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367be2aa5sm3700570a34.4.2026.05.09.15.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2026 15:13:28 -0700 (PDT)
Message-ID: <f6e2a4de-4c1d-46ef-b383-db62091fd0f4@baylibre.com>
Date: Sat, 9 May 2026 17:13:26 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] dt-bindings: iio: adc: add AD7816/AD7817/AD7818
 binding
To: Hungyu Lin <dennylin0707@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260509022718.82957-1-dennylin0707@gmail.com>
 <20260509022718.82957-2-dennylin0707@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260509022718.82957-2-dennylin0707@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/26 9:27 PM, Hungyu Lin wrote:
> Add Device Tree binding documentation for the Analog Devices
> AD7816, AD7817 and AD7818 SPI ADC devices.
> 
Why are we adding bindings without a driver to use them?
