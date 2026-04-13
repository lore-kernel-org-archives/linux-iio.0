Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE51363C4E
	for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2026 14:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776089359; cv=none; b=d7TyCHihwG2q/0yj8vvTwqS0H6W76cQxhW6Il7Epxez5rHv66LZwlCXw0ymXX/xkN8hw0tK2HJvEdWWU+JdttNt6cUH9j/69clTGATHJfaVl+n7wMNoIscgQH4WnC20XmrNX1vVBPNu04RtfgskILJjtolnaO6qaF1GvKJR/7g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776089359; c=relaxed/simple;
	bh=l9aiLJ5QGBBLI+Zctdtkf1pvFopO6KFzXq7yPcIxYUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o6igLZO2Y6nkewhEWJtye+xAjQE8QOHg3L8pWPBjCoPdGH8lm4ha1kOFLdgRcqTEEAPOIdOgXvK7Mj5ILJ7XcMbaSTeoe9qdQil62ozGWdQ0tnILSoLh0D59USD6ZcgN3R8TNInRL/qSp4c2mkI8fBfvx6mCEGRtkVJdP3v9cgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=XLEDAYod; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="XLEDAYod"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-415b23dd6e5so1800726fac.3
        for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2026 07:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776089356; x=1776694156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DsukjqKonCsZQuiZ1n+YCyyj13cDdNS//eoYMO56Ma0=;
        b=XLEDAYodjrUb8JMopTgZ/9Rz7OhMpx5zbyaTJWPq9ONu0hyxB02h37YEDY+iGx5fI9
         UEnAo9DIqKILP4yd1KGjItzFNZxHKCO5kFy9PaJTltATGi0MD3/M5u+6hQ8BLKzYmgN5
         0xYHScXBEXw60DkWfEST/kTtMC8v0yGSMnaJM5syc6KbsygJel0PK3vZTgDwgFSW8AUL
         XQBIFSVs0Bcj8jqP7m51gbJ4orNzfMla7P7RVTbVC0CNDGpQULkZGXcqRLKi0I75m9m3
         tDeJmIzuuVRebHYXhfb6s2irShoqtIaYqGy9lYIztFw53vykslhXuBv19ScCdOI0Wv+7
         gTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776089356; x=1776694156;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DsukjqKonCsZQuiZ1n+YCyyj13cDdNS//eoYMO56Ma0=;
        b=kbolc71e/NE6ShJtSJ3JVCSesNG6hPLNm2C4cOtiNLFS7yQrUuYgJxGptbTWaVM0dK
         EUK7Pk5efYorPDPzkpfsfoWZgZO8CbvQ/K2nbJmIrb8P/bdloMOz0mZqZPi8hFqQb40M
         oToo8LtcnYKdZxu/m95WRTDM096seixksBWIUgDieqK9lnFnnz+0niz2rGWLbls4rXNl
         Ebf4Qf13I9HFxRlsW310/o5zYrjlFUpZO+a+VJeaK6XTBIBrKEYFPkPeUxedR5Mf1OQO
         quksrjawcTEIfa5LGlm2jwUPFCI7i6TM/68ERChvbtgVG2wMt9BB8wAtoLc0PW1dnHCV
         d+eA==
X-Forwarded-Encrypted: i=1; AFNElJ/WFmWbZlZ7Y6+w0Js9nKAJgogBibDYlePzkHGHhne5dcIwLFO2MRCae2Fo8eyE1uA+T47qz3ovtSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YySqBEgjINWyQiK8AVgPAcCAlFx+Pu5xVBAzfUORCYysydxqh8m
	HwIOmjxUC36+o1I95WvJHhPxp0tdqRMA0Unkker6MyPUSicgup85NiNHRxC+/5LGLbE=
X-Gm-Gg: AeBDiet/ZmWER5Ro/XsVHvw0OZ6lOrQ8BT4Cw9S5r9oTJSEwdVJt6TvkaQIzAYj2mV6
	ws6ge+F2bzz8KJJOxtz8XsBcYRKcPXsfQ2RqJYMMuxQX6yuF3hnBDNWYXX0jiSQmedloWUq6gWf
	mvXUsPotyGZBwrZY7+mYQAVWiGoEyuKpG1asJyitIHsc1FTaGk4JthEAMy+ZEi18kmiTOFCS9y2
	vIudwYYc+EfPvwMLd2lnCe01xMtyZYqBDes3O8xGqxUNgZ3thFMMyp5wDfG3C819/YWYmshlYZ1
	AuU2AV2vd4cQx3GFlgZyvuYBXXm8cSYoPKV/kw/ArczXjy7TfZaFEa6rfhQJVyk1RSfd9q8IXSQ
	wbK6LMA7jCu91uk92Wx++5ziEDxG49f2NjVFMV/Z5NFiZPnySLZK0ITfxw6Lc8F4kRdVyCUOjwN
	TFNy94lvi3gVMzaVIg2SMwGd2FEeK3WxxaVXRLJgC1FDIJa5B6LuXgv/QpOVdgqj6E7UYBvTs=
X-Received: by 2002:a05:6870:ab16:b0:417:3307:e1cb with SMTP id 586e51a60fabf-423e100b3dcmr7703050fac.21.1776089356535;
        Mon, 13 Apr 2026 07:09:16 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:1963:d48d:f7b2:862? ([2600:8803:e7e4:500:1963:d48d:f7b2:862])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-423ddb9c461sm9248293fac.16.2026.04.13.07.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 07:09:16 -0700 (PDT)
Message-ID: <43c5cae7-9689-4dad-ace8-e8165e5fe6e2@baylibre.com>
Date: Mon, 13 Apr 2026 09:09:15 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] iio: adc: ad7173: codestyle cleanup
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org
Cc: nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260413134223.2331911-1-sanjayembedded@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260413134223.2331911-1-sanjayembedded@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/13/26 8:42 AM, Sanjay Chitroda wrote:
> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Hi all,
> 
> This patch series clean up error, warning(s) and a check reported
> with checkpatch and no functional behavior changes are intended.

I'm pretty sure someone sent a series just like this already.

Patches 2 and 3 were rejected. Patch 1 is probably OK.
