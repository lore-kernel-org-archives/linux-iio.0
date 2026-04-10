Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF42345738
	for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 19:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775848336; cv=none; b=l3CE7ZJXCzJwywIUOsErqDkVZEUApXT6zqIvkGgofsmlQANiZf4CtMizibno20mZPE880Jrml/FUooFyTwIMZv+Rz9UEpkKqMCBBKjPEf5/b+nWQczftymhVUaqqbCamm725nb5KnEGm00xDQHZ9hZbVsm++8GaUJ7TAPXPWvj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775848336; c=relaxed/simple;
	bh=xS5yxi31tQpIlRofqULfInSdfXxuzoD45QSLJ04eDEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M5/HFXrvBv0+7MJY3bVHxFYGOYKb5l/HpzlQIfXFGLQL+0nM5S6VWUOx/F01Jmw2nAg9NWEBR/l9BRsz8BRpE/QmnpcH9GqtLDJ/EYJmHAR8hscjuGOsiiqwZGYaijx7nCPBKf73K92K3SyzK/exKsxmsvhFeW02Z3oYmGaNhGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=xktwtcaZ; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="xktwtcaZ"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-471618e20a5so1278676b6e.1
        for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 12:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775848332; x=1776453132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zLsRMFsMCnWy/dE1MVi6bp8gCipvA2+DQtfeIR8z2qA=;
        b=xktwtcaZ1lM2v+fOqPkOcDHe900D7TX5gJc+6Sa+fKoBwA/TK4T9riBoB+gXPHzthh
         jMtt+jx0IqKuJz/NzUuwRPuEhEXy84UX40UvMQm1+yXGwRLDw7OhNJL4MR8YKZGiZ9wE
         oQW4xNGnKrm767VEDZQejHmAJWCCYlK733hKX5J9tArM1L1JpzPGeEk7Mz4/C4EUr4TZ
         924sgXMABWgbHyKhKGszgtjEaL0odv77uSdg+eT+1UUZSgjbfx+iuLwO1Va340R0joaV
         Wq1Ewh1i9dwPoNiHtc7Tb6EatQuMCYtFmI+nuEDdVSyG2507YfX3hIBeJRnq7cqnN1DB
         i96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775848332; x=1776453132;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zLsRMFsMCnWy/dE1MVi6bp8gCipvA2+DQtfeIR8z2qA=;
        b=lLei/Alg0l8lOorM1KliwFpvy+e0p6lXngUj31R9beVHCM7mBW4mFjw8CjQuyeiuNm
         Gqx/Pe2ruyhVYQcbn5Jf6qBrJC+oZLVa697GhJBE+7uf9ni3Fq18xJS1oCHy63VS8KYe
         kboOmhDhFsMZSRJu9ebAe7HaO+dex2TIM30sN4oCTe8B92a8pIOWrIOLBTgqgRCcn7zp
         7zu4geZmgktCv2qUVGAtnIud2Nu9F32Dais5Pmn2mHPt0wVso0gq0JsjDOsI1ae9imoo
         tyPN3x8+txEgB20NhpHJ+XrHPbTYmLdkOF8i60awLDoqhgE6pwAGuOvhMdKWpZe6CxKf
         8Ejg==
X-Forwarded-Encrypted: i=1; AJvYcCUAPnaUcIbrIHg+lwimPtnbxnxamrynfI0xQcD3x2VuGFmujee74A+v+1GnIIMVhWp4xz5EFdozKF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YytQNLHNo2IrFtcSiBCw+KD7pZmTKzBHSfzsFaJqtQLUd7BJUgV
	zXFc/KnwiQ5VPTgHvbSmGQWJlscF5T5/Hq3xoyHvo8Lbw9FBcz3/Blq5MpvsYcD/rAo=
X-Gm-Gg: AeBDieuFutOGbkZTF68R+9Cf6pdrO9lYIm5Q6CKaikp4I4o2bRtKmsO/y5yAImp2HvG
	SUxaNaYrq2DBX/EpcujnFCzywcGzRujILtYZ/HWzB193H7WqNY4jfgLqMyBM9224CuVnrDdqFw6
	m+P4a7+FDnfq/GLoisfo6WpMk34ukQD2jTh3tHuAlN9SgLhyaDkE1veWNV2269gDesqmnKrSs5/
	WAnxmfjaDw2bcCRfjtnsttU3U07tydTs8Aa1vfjoCFcZaTZu2MF9FFhB0yo/WAjroBG3sPJnjdX
	SDwWf6HUa0RgsFEO/cNrU5CSMfmbuFW8+z39o7/EZ9fzdRd8by4UHqaLuW09wmEfMX60J7/w4qk
	L3ncN8Ua/QtgBa+DA97DjlTRctHGGg08tMlGkCByMALFvML0N1R9u/PUSOeVojJ1D8XJdTTBFIr
	xGtDa9Yw7tRkY8eKFZEfRcAmlQP4P1fCBjlPPNSYs352gSPVuH8Ux7C+09QoxDko15iafXQZ3Iw
	Q==
X-Received: by 2002:a05:6808:67ca:b0:467:27d2:96a7 with SMTP id 5614622812f47-4789d33ff74mr2585325b6e.15.1775848332294;
        Fri, 10 Apr 2026 12:12:12 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b75d:2440:dc10:808b? ([2600:8803:e7e4:500:b75d:2440:dc10:808b])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-478a3666dbfsm1887177b6e.15.2026.04.10.12.12.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 12:12:11 -0700 (PDT)
Message-ID: <2c29f960-1e0b-4d66-858d-576e685f0812@baylibre.com>
Date: Fri, 10 Apr 2026 14:12:11 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: frequency: ad9832: simplify bitwise math
To: Joshua Crofts <joshua.crofts1@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org, gregkh@linuxfoundation.org
Cc: nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260410100832.1388-1-joshua.crofts1@gmail.com>
 <20260410100832.1388-3-joshua.crofts1@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260410100832.1388-3-joshua.crofts1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/10/26 5:08 AM, Joshua Crofts wrote:
> Refactor the ad9832_calc_freqreg by adding a BIT_ULL()
> macro instead of manual bit shifting for better
> readability.
> 
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
>  drivers/staging/iio/frequency/ad9832.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index 1f6ece79b8..260c2e3a9b 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -113,8 +113,7 @@ struct ad9832_state {
>  
>  static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
>  {
> -	unsigned long long freqreg = (u64)fout *
> -				     (u64)((u64)1L << AD9832_FREQ_BITS);
> +	unsigned long long freqreg = (u64)fout * BIT_ULL(AD9832_FREQ_BITS);

If we are touching this line anyway, I would change `unsigned long long`
to `u64` to make the type name consistent with the cast and makes the
line shorter.

>  	do_div(freqreg, mclk);
>  	return freqreg;
>  }

