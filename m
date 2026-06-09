Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1815D37268B
	for <linux-iio@vger.kernel.org>; Tue,  9 Jun 2026 16:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781021406; cv=none; b=Zyn+TE8tSx/qlKWvL4g2UnQjBtft5e/SOMgYvFR8OmOQH3Wz4KDVwWxa7zE7b/CIwZiSqTzjM76XxN0pZa+DbdeEgyjF/00qI3BZczVbVEPXx7expqucOe+y7SHl++agrrsZtPP+BQJ1zi+M2K1IL6GGeu2mfr6AwCLIiL/eDhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781021406; c=relaxed/simple;
	bh=RLoEiDvQI23Ox8jg30VQGX4Iwfm7ISwxXbu9I23mu5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uIZvBUV++ogIeBarquLd5tr9fxqV7tt2dRe+nML4g/SjbmX+1f/+lJ27wP6MaN/AW8JYURyZr3kZU2sVkhA71Cj6B20FIAnS6JnRM/kSa40uxPMLo/JVBOaOHljLpNlF/RUN3Sl/UCmqr1t31ydJCEPWZZ6jbwwD/6xjB7g9kEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=kp679Dua; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="kp679Dua"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-440d9bfa309so4294597fac.2
        for <linux-iio@vger.kernel.org>; Tue, 09 Jun 2026 09:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781021404; x=1781626204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/RNb4id2txtpLRqVF8IkFMdlDYN5r4X9vT3DkpgA6KE=;
        b=kp679DuaqNkmFHhbB8cN9yxOjupAJ+LBTHfPGyJzmFq1zeQ5NXcbY/cUivYMwfxmxf
         jWYGuBwGddCUENJ1KsCoq6EXNRA0o5JLb8a3Pn1RrKOnFFEpRnRxcjlNUvmsf+CHOpbi
         IAPje4uoPbtIY0SJirLhSl0cdsBWeS6dBMlpcxn2NsWS38NYyYL12AND0zNZHAqnWcSE
         nAox8u8g83YNLO3yXErnLEipvBki4xCeW297UBRvQHjFto5FEaMXrRW6DZ5a7mCMaSpk
         9YGfsqgPaLC5cnVBcLOC1Un8paOEu7TjYRTE3XuJRZRXddzyeJYVjwdApycnJv6c6pT2
         5RwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781021404; x=1781626204;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/RNb4id2txtpLRqVF8IkFMdlDYN5r4X9vT3DkpgA6KE=;
        b=YxsQwI7t/Te8bERUgc8B2xcdjfF6rigRYkPt0ganz+pREewSx342r/CWx8DCtAICQD
         EcMVyTT6Xvc0orFuMJ9PYT6S6fxwOdU2nNI3LPVa/yXaY7G3mTZLcfiGBvP7MZ+Q+4yc
         j34rieZ2QWkJErFq+1YOgYR6B1neKM376+UPbkVp5CKe1p6M0hEZiOG/HxS3L+8j/C8T
         rPI7DYgfLG7f5Njykjf0iWqyYg7dUZCY6wBFWnFBiMvaG+vQLtVl4MKQgR5T22K2C71Y
         ID4+iD+Dcel5kYiwqWOhtf7pp6wpH5IUzrDw4ZLaGL+FYRSud/MRZZB3CRhI+1xM6f44
         W4nA==
X-Forwarded-Encrypted: i=1; AFNElJ/tRYKmYc0GzHo3y/3Mt7TbTEix06tdXvoFVbAy52QQydfGjfmrHuU0WIPstkkhCI4zGKTM1NVMxHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuiIl6mB/w++9jMYCzK95VHlUrxjUP9kqDRaxQ6+kzZuYHd1gS
	ghHxMguUbDc7tgTjyyhRpUHUUbHkctOC6RLcTtVMgIWpDzbH7hPPfXMx2atSTw9ADn8=
X-Gm-Gg: Acq92OG48HWyHKJ6+hGowI/whOQSwJxkaXY2ifxIP2FfmuoLbyLXwGFHy9p1W7BvOW8
	pp/7zE2DiTXeO2sfHqHxlepuLvEnukLmu7i4+5Y0fApPNQZUH6l5Ct+0jUCya4YC4ek32Bz8EEH
	TSge5sa+OWae6eVBV4GKx58kvalgL56trwOsPP4uu/UWDyk0E4k0rT+i9iZPaj3PrxdhW0OXAnt
	p2aayHoC5VThC7Gx3MaPQRTEumKcQtoTmu96vKMwri/xA5VE45pz7iWxd9Ad4xfDmnZh9tOI62C
	MqwS5xWgx6B/T0h18jzF8VdPkA7DadclwxqzvYio6RrhoeCsbMq5BSZd8tW+Ukhv/JvOknNq6Iz
	pwVIUqLfoC4qPWw5NPDoOGv6KeB0SFB4HChEhKFdBtdg7hMKKhaY8K9SQ0qK2KOwEtIBmYmoEik
	Z3U4CFA4r6DaSPoUKdLx8pY+OVf7mJxhGtYOl7fkOmucOiz6xRSjfSaCMn1+aMWPVQJX0ay2nBA
	D3Qa7GuaOkzWvHIF0vSqXg=
X-Received: by 2002:a05:6871:28a8:b0:439:b99e:441e with SMTP id 586e51a60fabf-4413d68f54emr12001176fac.1.1781021403980;
        Tue, 09 Jun 2026 09:10:03 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:2516:8f73:2dbb:a61e? ([2600:8803:e7e4:500:2516:8f73:2dbb:a61e])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d84def23sm18401345fac.17.2026.06.09.09.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 09:10:03 -0700 (PDT)
Message-ID: <6305149b-d334-491f-85c2-085fe42cae98@baylibre.com>
Date: Tue, 9 Jun 2026 11:10:02 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] iio: adc: Extend ti-ads1100 driver
To: Jakub Szczudlo <jakubszczudlo40@gmail.com>, linux-iio@vger.kernel.org
Cc: jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org,
 marcelo.schmitt@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mike.looijmans@topic.nl, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, jorge.marques@analog.com,
 antoniu.miclaus@analog.com, mazziesaccount@gmail.com,
 jishnu.prakash@oss.qualcomm.com, duje@dujemihanovic.xyz, wens@kernel.org,
 sakari.ailus@linux.intel.com, linusw@kernel.org
References: <20260607183542.368184-1-jakubszczudlo40@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260607183542.368184-1-jakubszczudlo40@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/7/26 1:35 PM, Jakub Szczudlo wrote:
> Extend ADS 1100 driver to support ADS1110, which is a pin-to-pin 
> compatible device with higher resolution. This patch also updates the 
> device tree bindings and Kconfig description to reflect the new 
> supported device.
> 
> Signed-off-by: jszczudlo <jakubszczudlo40@gmail.com>
> ---
> jszczudlo (3):
>   dt-bindings: iio: adc: Update title and enum
>   iio: adc: Update Kconfig description for TI_ADS1100
>   iio: adc: Add ti-ads1110 support to ti-ads1100 driver
> 
>  .../bindings/iio/adc/ti,ads1100.yaml          |   3 +-
>  drivers/iio/adc/Kconfig                       |   6 +-
>  drivers/iio/adc/ti-ads1100.c                  | 165 +++++++++++++-----
>  3 files changed, 131 insertions(+), 43 deletions(-)
> 

I assume this is v2 of [1]? the subject should include [PATCH v2] and the
cover letter should include a changelog. See [2].

[1]: https://lore.kernel.org/linux-iio/20260527164312.355729-1-jakubszczudlo40@gmail.com/
[2]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html
