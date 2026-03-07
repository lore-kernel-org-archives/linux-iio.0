Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD6423EA93
	for <linux-iio@vger.kernel.org>; Sat,  7 Mar 2026 17:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772904871; cv=none; b=ojmLRSMheKMSlICRX8BbftKBpEovSPzM1lVhXadTL3+POjUogAdY3Tke9OhxvxpvfuMg5oPaKp9v39HswlKC/+UbDv6k3ItkzQuDMLS/eaHoinFUanleiCuIWvDzk8XIxfe9Y/v7yVLCsMiNgXivsrAkCMn2jZh+QpgIjB5jciU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772904871; c=relaxed/simple;
	bh=LD8PWaDzB0jYCg3/QMjeWBbA73jYhxBf0Xu9NQBp9Fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pHHDnQHGXvlWS8A8cltRC2oEPJHQWTxI5TKaAMbmIlT8fjQbtgLCeKLRaIDJwu7P2PovNiW4siT9DpJ2/pFhoDjIWBtlLWPHEV82YBifIbkBPX98TCfv+VXstSlaan305yHMNE1o6dzqNmo7Dif2UUAC6TvUij1M8yYTt0dZO2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=udYSejxQ; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="udYSejxQ"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-415b23dd6e5so1993992fac.3
        for <linux-iio@vger.kernel.org>; Sat, 07 Mar 2026 09:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772904867; x=1773509667; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/yv9hSwjNIBHD4+9yr9CMXRF3iQDU7plMHlSI5wIOX8=;
        b=udYSejxQUNUjdsUZH0kKorLdXLizbNe87Psj7PEkFHnQqNT/Z5c9w33Zt/teZhpRq7
         4q8NHq056wbX0EfVAaYVGXcmZEmig3OZqkd97EwQVKpRYNYEp+Rf1SCmYCUOgr8ANa7g
         N8tvZL4bRla03pyj5trizpUUA/uqqPOD9IjU46l1ersv0W7FWFppiUxRJQyNYfaLX6mE
         IbIXsphTVJqU2O+ze8/6+jWSt7T7ip2b3HQLfGpH7Q2/W1x+FDrW9b/Z+W7mVQXwp+tS
         +kF47nG28wMt0Ga+JAdOhGHy1K69HxYnfjQb6GOBoAr+n3lxNjZL0raYKWGjOXaALu06
         6mog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772904867; x=1773509667;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/yv9hSwjNIBHD4+9yr9CMXRF3iQDU7plMHlSI5wIOX8=;
        b=quTEF1KObyPsSxdPgeJwAIWfYtGcdjpB2ZDGkmVZoHzLvACHA7UF+NIs+dUSHknUbk
         /g3XLerWnQOEGj9vX1MiEWry9VMT2uUNSeMjiACaVsn6tXoTuk4pCglRb0argr/mRdyY
         cmgToDnQLcOHzGfhOKYUnwVzw729SN5Erdlh1bQrXI8Ue4GLqiZgPgFmufh1Hn+tn+Wc
         dgFDsoCVnuWrpZe9a90PSls9pZG2xZPU6IcvtmzIcLHvfquX1KePskFQYyrmPBX7Qli3
         1olPFK4oKMBRRVYrWAyStnN8jX+LEeGo5oVC232XTfHJSzKxkbUzdg7HacXuXC2B6bzi
         CPvg==
X-Forwarded-Encrypted: i=1; AJvYcCWuILqUCmyzdsyIREYdPa9dAz8ZY0PxoVc3G4xVS2nDl2GStckGcTYQgB74OsKYkgMemU/vsg68HQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQZAjeTz/o1gNtH85FGnnSLC3hwjqjOOE4sTPD5xbndrpRmpQU
	PVp2nFdcioV/EYkmbmfqmldjXY3lZnI3jwwtb7ywyfm2yH7/nsMUJhhPsSFHcDNDWqI=
X-Gm-Gg: ATEYQzy1ADrDiRAnrgpw4KTjInLI0aI9dbDZ8lNED2qTgWZ9I/e03ZeE5Jt3w2PWMLm
	U6li5ZodZCTuo9BJYHW9y6ooMV/wF2PbIXft0QVAxITZPcT6W1OBoqbNmStmA3SkCu+BPyNgoe0
	0uY/nzA9jRDaID1Ri8BbEwgwdtTtfmxW90ZbkEOldP3Dna931AprF/Hd3nFDALa2PhjUnpuYReI
	ncHNLAWIKkzu/HKblCin5iVpuXry6vql+Rjh9jnGbb7AsdoX8C9FGqyjWDu9BqkyW3m3mBamEtJ
	6XAuIfJjukMXe4rdywag+EA52IeVYFM0xUULe9GrDjkiyq6QWGlFvA0B+zWbU6Vx5l3hNK/6qAN
	u4y2KPSTwnoP8155lWz26o9EPgiX1EL+Cgbfzy+NlCsV5HWBf6heL+rMCfbyK/8IxMaAmP+SEAB
	tYlTgbZNniN6eIECyxsdo+4mTHWNcP4IEc5mUzdbuzbBnf5i/2Ls8UdWIxT1Eztz9b+oKVYDAIz
	vYXZSARNihh
X-Received: by 2002:a05:6870:9a23:b0:404:3cff:5153 with SMTP id 586e51a60fabf-416e3f87b6fmr3223291fac.6.1772904867159;
        Sat, 07 Mar 2026 09:34:27 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:cccf:5174:fa72:c520? ([2600:8803:e7e4:500:cccf:5174:fa72:c520])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-416e6836886sm4273135fac.16.2026.03.07.09.34.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2026 09:34:25 -0800 (PST)
Message-ID: <b7fdac41-4d22-4d43-996f-cd4733141cd4@baylibre.com>
Date: Sat, 7 Mar 2026 11:34:25 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] iio: adc: ti-ads7950: switch to using guard()
 notation
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20260305-ti-ads7950-facelift-v3-0-a23fdd1a079e@gmail.com>
 <20260305-ti-ads7950-facelift-v3-3-a23fdd1a079e@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260305-ti-ads7950-facelift-v3-3-a23fdd1a079e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/5/26 1:21 PM, Dmitry Torokhov wrote:
> guard() notation allows early returns when encountering errors, making
> control flow more obvious. Use it.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>

