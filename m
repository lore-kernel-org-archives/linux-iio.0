Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8AF40DFDC
	for <linux-iio@vger.kernel.org>; Sat, 25 Apr 2026 16:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777135782; cv=none; b=VdafwKOJEFKO95kjOr1X5J4ZLl9AINuF+uGBYOXAbDxgbvce5FYh/ga+3tK7D5vtxpwvHP26L/bytuex30MVVxc/wG2yzRP93iaFX/svr6a7+38FJyiCGBvxucL7n+7teZqEmTcNzDY+GefUuPZuPI9Uc3pYWiQovpP+GAX+bSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777135782; c=relaxed/simple;
	bh=Om+4BZK4Glk/us7ysjlelW742w2wiMOoWP8fMs/5fVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W4qo8z1YcbxysZUjUgMxVphCn0A6ulLzE7n751Ox/cKv/2ltO4KKsvArsrfanPaHGc5EJZ1iBpwydgvg+IW0A7IODCcLSlYi4fxlegIGGVI+5LmjR2qYD0EDSnsO1r5IvWIlj0SOLwPBY/tvT4KLdetBrAmfq43UZmxwnoN526Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=DrX2iPDM; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="DrX2iPDM"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4779b2497b4so5173646b6e.3
        for <linux-iio@vger.kernel.org>; Sat, 25 Apr 2026 09:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777135779; x=1777740579; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oea4+dSftVoWoc/G1rVhBLGVFWtjMog+VJo2M25MKW0=;
        b=DrX2iPDMJzxrzrWBAXtdmJqvau96NHwRDaqCfXyzqAp8uMMWt9yPt9xQ9pZAIq5Aq2
         8RTjGBkf4ZsNBQExlayzFt1En0ikj0cD0U/lDjI0p6mQoB69pIt2SwxmmM/6gVRgVslK
         ZH4iNZxfuR5fMVJQe6d8YHe+3GoHhjFolrLPcAhKvQLyRNUFk5a9gakyvf/8GJQ79e4d
         9Qe9hnGBRGkoiBFZBsY75AoJMI+CdtMU3XqieLx7wbfl7hMQcYE+0XVjQiS6ETMzq0Oq
         SYY1/3bKL0kPkwU5tzMLXSzQPWsShPcNUfMPZy3snRoL++a0U3WOsvAoMaByXseCJ1AU
         F2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777135779; x=1777740579;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oea4+dSftVoWoc/G1rVhBLGVFWtjMog+VJo2M25MKW0=;
        b=SXXUHPBjWCXbK1o9Fu73ewXqF1gvSjekjUUM/+LJIv5FjjmIaTs0weeAAYmLUVbPrW
         +IqhvWt9L9HHfWiDBExdbGk2lz74FezNB1nNCOEk0VNCcbYiofk3kC5I1m0JRBkvArLs
         s+Mz5gAX/XhHdCZxIH+Pw45I68VzyQPl8x9BjlMLw8OUUrS7VnjsTMhDepTflD8o8Ogw
         O6yjX3C+497vBcELs7wYMvVfbl89PJ8k+t99udb3KmI4SbgWL77kuHYyYq4wTSvTvUpr
         MdWgs6SahxUBcAnNh0mGoHulbL/kUSgdj4xOx3yWEvZBB5Gg40NVS/6rJmVOrV/AUTF8
         viIg==
X-Forwarded-Encrypted: i=1; AFNElJ/6iBGwZh9+sxzaKB1bi27dj4i8XOfvh8oq3TeaZTCkRk+YQbpa66cN2uzghlYSfXb6rPHwlzZJq64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf2+8tBarXIdT8I2NXv31/sFtnltAEuam4cenfbqIzNh9OP20r
	9P+1eLA1hOIHeHSF4jofF3MPqA//693my+dNSM5t7CA4k19yNKkf3hDRWjIWfsKvTYU=
X-Gm-Gg: AeBDiesYOiYfIzKsPCXreg8X8bx4uqK96WC2/2lFpiMWN0f7PhcCDOfIlAqp7s0Eam3
	7jwwBYUnpAEnYeWJtw5nog/GKODvbgFUfQU4NrYLumsOO/vZKgifjGrrPSUep8l/D0dsHRyyhcG
	16VK5PY6d/n/nhwSwizMABVNTqvzAI6c37+PppIiBZ+pS0hM9JWQuL3ApiIEW6BpS64ohRrAmT6
	jkVw1iPo1TVE/imfQKn88t4584GRKgv4m/POuqYi2KWMVD2SxBZETkJk6YCZybWA6vniy4l52xo
	UNPj79qBS5emi+0iuG4SomRBwaP/68PRsiW/UBMmpvDwvWWZ6OXzSyMEyEqAoY+rHOdGQqNk2u0
	QkDXFMUf66HZ3vloZeaODVBnx7Sb3c1Xug6mqBJlffYiI29fr69UcpePM7IVGzpNn8eAuu/ir4s
	aUCLolbhh9sRwvOY0GHKFDm6xWBTjbgtt9P5qWDbhplJB5uyVF0mgiIVnKg+FSiosr5Sl4t0BL0
	9LxtE4FeT0g
X-Received: by 2002:a05:6808:3447:b0:467:eccb:b788 with SMTP id 5614622812f47-4799c870d71mr18239014b6e.9.1777135779423;
        Sat, 25 Apr 2026 09:49:39 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:4237:7c82:cb4f:1d6a? ([2600:8803:e7e4:500:4237:7c82:cb4f:1d6a])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-479a028cab5sm17487137b6e.16.2026.04.25.09.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2026 09:49:37 -0700 (PDT)
Message-ID: <46fd475f-8d54-4419-a195-d66c947fcc1b@baylibre.com>
Date: Sat, 25 Apr 2026 11:49:35 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] iio: light: tcs3472: implementing wait time TODO
To: Aldo Conte <aldocontelk@gmail.com>, linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-kernel@vger.kernel.org
References: <73d2183e-dffe-4ae4-9312-c544e0079f3a@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <73d2183e-dffe-4ae4-9312-c544e0079f3a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/25/26 11:28 AM, Aldo Conte wrote:
> Hi all,
> 
> I'd like to resolve the wait time TODO in tcs3472.c.

Do you actually have this hardware to test it?

What is the application that needs to make use of this feature?

> 
> The TCS3472 has a WTIME register and WEN bit that insert a low-power

What about WLONG?

> wait state between RGBC cycles. The register is already defined in the driver but never used.
> I noticed that tsl2772.c enables wait with a fixed default and no
> userspace control. However, I think exposing the wait time to
> userspace would be more useful to tune the power/responsiveness tradeoff.

I assume this would affect the effective sample rate?

> 
> My plan would be to expose it via an ext_info attribute in
> microseconds, following the same convention as integration_time.
> Does that sound acceptable, or would you prefer a simpler approach
> with just a fixed default like tsl2772?

So perhaps we could just use the standard sampling_frequency attribute?
> 
> I also plan a following patch converting the driver to devm.

Would be better to do this first before adding new features.

> 
> Thanks,
> Aldo
> 

