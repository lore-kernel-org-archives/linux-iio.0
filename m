Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CF83D76
	for <linux-iio@vger.kernel.org>; Sat, 21 Feb 2026 21:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771709268; cv=none; b=HX47rkr7x8xjlrmvd0ejKrLQxgOf4IZR1aB1tUfvmwlc/VlmoeUotLOEp8782tMUeuijOuszXDxDd1WtGTnRtJqGeWSDmA04FImGuLMHFpfzTtjD1cVGot/8Kv8naAmkczb+HK3g7gE5vENwjNyM2Xx5OA8WJpMrdCqxPcFAYqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771709268; c=relaxed/simple;
	bh=G4M5z9ETgThBka0v0FNp5eZpnyZM6BtTFa7GXKtukvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sr/Y0cDoQ/0C70Sp+nkhCLnRGHWQupo34Uc5eWjN5kBCMfMT68kcdmG0Uoqh13gk98VyMV1+m4apNEmVLgYkT9B/Jd5T6bU3vhBGdtd/mnnAucbPYZRqNmBqnQ6EwWP5I9p5rQbFJEKpLoKJQ5r253wNT+mvvue2aWKeeNLWeDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ohXx+8IA; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ohXx+8IA"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-40423dbe98bso1351533fac.2
        for <linux-iio@vger.kernel.org>; Sat, 21 Feb 2026 13:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771709265; x=1772314065; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b/FLGdRPt6ip2RkNJ6TMOEBWjjsAFgfTikB0pBywg9s=;
        b=ohXx+8IAC4SjhlnIal2TMCa49gQ4VFwoZPfcf35MQRKc+AxBoVhq2PTGwfiuWQt4CL
         aTPy63sGzox3owBXwBpkFjSxwAFf/l/N5FvFNcXuXMmCyrHJZcPenzd2dRJ2vwvPwmrW
         urdFoiYzHcm3B60h2tcdBP6PAL+tfM+TAY5h1TmtiGZ1Erh1VfeGFpeeV0CviooE3dZn
         Bgdboe3AbFzxi0JoPl6jKXI8fckhi1ssrM7R5IxMqz4idYPPMoJi5F/IVXbymzsHU6dK
         dqjFqpoipyx152L9+colcfAl+3HIF+MBfnIYlDHQPHpZy6NMoFnts3J5G3kJz/7mvcdw
         Mxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771709265; x=1772314065;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b/FLGdRPt6ip2RkNJ6TMOEBWjjsAFgfTikB0pBywg9s=;
        b=tycz/L5EG6EX72TmNYy6NIJDYd7+gry1/m9HakPd8k/Z0LeAdRLay5AbB/C3FBUrM0
         ykpiirydoCObbgGwIVeo6Zqw92bCNpBlgku+w+uzrKvI/wHnDQi/LCNN2XXvNrmcN+9l
         1HpUZjLStjMlIRftxl41dIVQnH/RT+aqrqG15fa/ERi/oMHvbLPlY79bfIUZY2VcdW0E
         GsDdSWqb4tIckHBi8k7mZvwzWk17ppdfkjQVs+xP3XMnu1Ps3bVJbG16xno0+q6ARNAG
         PvqJU1Pe0P6mnPUtyYk+0H9VTQgSgyseIPq7pigWyYP2X6deyTO/pl0pW9W10a7zKjuq
         KPyA==
X-Forwarded-Encrypted: i=1; AJvYcCWhVwKatOaZmwVhXT+ObFgHhue8P+akslR9tZvk1ukTKwAzorQ5ck8z0NwYQWq/WcqkiJMYfifjAYo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyelb3XEhPYsBRZDCGdCuZwcemZwokAeNKhHFQNa0LlDQ/Uibkp
	kVh1buvUlBg8vuvyX4v3nEvH6iOctL+eFhlsbCewhup0lXO5796eeW3gn+fek0Co1q4=
X-Gm-Gg: AZuq6aInmHs23feSjUaTmmMGdzADG7yvDeMBnf50RyOF8rxc28GV8MLr+6mTSDPTZdU
	sFxzohVu9toW2mwVVLVnI9038e2zFG+5x+jB+GK7pGKZ17tcJqHK+mWyO+egPsBgNIMxfzb6N0M
	bsZfbM9kN0Da+Ng1aXl1MPwOR/Qi+zu5O0fpbMTcsZv6Ou65BL2gZeaRAqCp5ecVEaG2CqqmUby
	7y9bpNaKl1JUp5r1uHUh1WFLHt0kyFypMiSXr/Ttm/nmsKSGFyxmb4/zEyI0lFvwS8PGqD1ZA5J
	6Aw6OrpXZK3SK9x2/I/J95Wl7OymzcmFOVCSMep7Qn+EoGMzpBXMg8BgNPKhDTNMqRxaB/rso0T
	Z4TC/IaB0pWbLc/NZlgyfNy0V/41j5sx0gSv0nLib3ZB157y9xuVG7/HSjwnaJ5WTXryB4m8FRi
	F5UqNLrO0E0tRxywee6rydgoioUnGepzA/gn6SMh0dG1KTNNxdMMO0IMWS2b9QrxcfNjZFXA==
X-Received: by 2002:a05:6870:860a:b0:40e:e5c4:a4b2 with SMTP id 586e51a60fabf-4157ac27b72mr2412115fac.14.1771709264728;
        Sat, 21 Feb 2026 13:27:44 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:611:96af:f385:64bf? ([2600:8803:e7e4:500:611:96af:f385:64bf])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4157d3a91absm3343204fac.20.2026.02.21.13.27.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Feb 2026 13:27:44 -0800 (PST)
Message-ID: <6f5158e3-84e1-4159-9c61-789c2b198af2@baylibre.com>
Date: Sat, 21 Feb 2026 15:27:42 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: buffer: Fix wait_queue not being removed
To: nuno.sa@analog.com, linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
References: <20260216-iio-buffer-write-fix-v1-1-bc08b239f37a@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260216-iio-buffer-write-fix-v1-1-bc08b239f37a@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/16/26 7:24 AM, Nuno Sá via B4 Relay wrote:
> From: Nuno Sá <nuno.sa@analog.com>
> 
> In the edge case where the IIO device is unregistered while we're
> buffering, we were directly returning an error without removing the wait
> queue. Instead, set 'ret' and break out of the loop.
> 
> Fixes: 9eeee3b0bf19 ("iio: Add output buffer support")
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>

