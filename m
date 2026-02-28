Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650E12E22B5
	for <linux-iio@vger.kernel.org>; Sat, 28 Feb 2026 17:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772299154; cv=none; b=DZGFZ9YkaXdnTu5lp1zReykRw7qWhlDW/4mCimLMpgGEbkPEbl0tlRUfrBqo/hqa4fOpZBtyTACGDsUKRthKnLg6q+ZZ1qGaVI9N6oBqePz5X5jqwlHUc5pVjg1RtFSxlv6G80LyrQgWNi/zF1b3AzF+0shwaZS25vBBqNzd7oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772299154; c=relaxed/simple;
	bh=Vc/iMf9NvcemNAACySDf0qH/0v23LqBKtuikZSU5JzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nKBFCLn2fbS9XLkL5V/czCj2BLhjly0NxBsyD/4L1B4aw+KvPlvd9Zt9MP7x/S2C8BXC4foVjpuFXbmp6ppl6xkbMjU93EdqVWG0SL4vfGyqQxHdYQJRI5AV68yBiARw2GYK5vnwkYmqthsyYu0cv1Tt08JIIw63FCo5V9kD31o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eUr/nymt; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eUr/nymt"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d55b97f358so2659177a34.3
        for <linux-iio@vger.kernel.org>; Sat, 28 Feb 2026 09:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772299151; x=1772903951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ds5nq2+kKQ1UG0rkHwLCeBPViqLzhXHWcMTpXbuuRg=;
        b=eUr/nymt62t5KAmKYvW23oQWpB3ShBv3nQ3P8fpV0msdXJfHiXPIqDNJ1Gv7gRALsM
         gCWpvd/+N7ZL1G4iYWPICAyCRMJUMk8SQAVek6rvjOO4mefbHG98HiTbw/fhD7UMWunj
         /j4wm8yfbGUTffJhesQulQaaSqvYwjLrIA7ccqR8dF4fvPZDHN7usH9S9aps/gfflcSf
         FgvgrLGyVlGmwWsDoRixUkdN2H4n2J+ZbHtltoLSxeuJHwz0r5dvME1R4Z4846yTqWak
         XNZ3VtOslXskQQftWA+7Ksg/SOH2DZPpZwT5L58zRyiwK9Dzsg+KDRO1Y1WJSlKgFVNq
         efUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772299151; x=1772903951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ds5nq2+kKQ1UG0rkHwLCeBPViqLzhXHWcMTpXbuuRg=;
        b=K7ema58UIfrQmHJwJxDhTikquMar3gHmeo7PhXHJjQlEryiuYKsmayxK7hhCeaeO3z
         ubJTUtZYOmaOd8atHIfRf5lQelrW1cszOzojnf4ZWcfT2RSf2V2pFvd2LXrw7zsNePha
         0HHhoiCNrpjVmmg0NSw5RtichjwD5q/IMLAqkIEdNW4A0ruF0oA/TM8SVZg1K2Tikoln
         idNHH0DoBhC6BId/RBmTtUuQHPllzd33L1n02dj8A7dfOOREQYUpO2pDiOCzznb2Q0vD
         gnRU5/lRo9SB62pQ9vRSKXx706wNaVeCCBW023XTGKPub7KXtOsBbUKWzbj1RphSojpL
         HAcw==
X-Forwarded-Encrypted: i=1; AJvYcCVkU3lVIJylKl+CA2qWhbVn488wOGNfLFdkRSEjUfQCPkgn3JaUTVH0sAmLhtMQAjojHcSgueZErZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyY4abOHsdNz0pohtiztZwyk+tcB+7jSxqIlqJIWdcHw7Q42RU
	5y/2R+6GunZBDLh0hGsH4o2k5ih2A7viUh+kXvTRiTHte2xFhf4W3gXFKWZ1e0lAg+M=
X-Gm-Gg: ATEYQzycfAxyMdGibb6T8K4uF77tO3hVH9HFTPLKOI2xgFz9YsSsAHUX6nJ2mK27SgT
	2dF9Iz6dfebnIBVH7EzyiZkOpU9b6QOA9Pe/TSUPbF2RdHcXdmbJY6KARJFfXHYPn2Zb5gae34p
	NqPytPQsoVnoCBO2zZIcwP7cE9Ghho4nN0aEvk5NgPiaRNtFqQ1fFtGDBI9iTAghgk/yzdSxXNK
	o8ICzqKwVZ/aMSg/4Fc21UdjvKnBGYmDT63SoVuBb1P3/aqQ/LtuOfucWt5mP8LwMjqYiZbHAIe
	bn/+6BuSryKfJRu2Znb2jzfP2fx43rElbRIT2JmIfPOdOgIbxLhzbuBcXti0tgJjJKHQ4NPV7TG
	ANThVDrsAZj6j0D1XpsgYGYGU3+30AJioduoQbNOpUIivvwVAaXh26hZLwwYY2AonUQfUpr2Xx0
	BQVf7FTUpHO6gAP/niQ6a21bYsQNSzkZZDg1zfarfUPIx9hCV2Nv31G9Ja8hFU3U2T4iHOyaD3t
	Q==
X-Received: by 2002:a05:6871:3309:b0:3fa:ef4:3e3f with SMTP id 586e51a60fabf-41626f9aa80mr4461828fac.33.1772299151287;
        Sat, 28 Feb 2026 09:19:11 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:1031:c44e:9f1f:17c1? ([2600:8803:e7e4:500:1031:c44e:9f1f:17c1])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160d21196csm7345271fac.12.2026.02.28.09.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 09:19:10 -0800 (PST)
Message-ID: <d7d165fe-400a-4bc2-b08b-d1da8d77d36a@baylibre.com>
Date: Sat, 28 Feb 2026 11:19:09 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] iio: adc: ad7768-1: add SPI offload support and
 fixes
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, jonath4nns@gmail.com
References: <cover.1771362939.git.Jonathan.Santos@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <cover.1771362939.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/23/26 5:59 AM, Jonathan Santos wrote:
> This series adds SPI offload support to the AD7768-1 driver and includes
> fixes for one-shot mode operation and IRQ management discovered during
> development and testing.
> 
Reviewed-by: David Lechner <dlechner@baylibre.com>

