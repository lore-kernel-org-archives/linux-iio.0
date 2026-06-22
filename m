Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D89A1C701F
	for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 20:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782158520; cv=none; b=AmzquwIrLLm3pYFexON/dC0esJvw522sVSR7Ix+uDyhkGaTrQ/peDoE4pnDdUB8JGtGI3/6mB+czT4lm5y5iNOXEpOoRyc6FB3xVei3wtMwhoo7loYUmG6MZXrUG3CFh1uIWC28HU5SFOnt6CXzQT/0boCw6Ng0plAUE9QEFy7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782158520; c=relaxed/simple;
	bh=UKtfdIrcMYETIGulf7UVXywwHDak7s/n/29XrjgQKFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jf9NzxsbOE2lqFV99dMWyCAp/tk8vvSVW6OzeSyTznrYB9JXeNv51Ed9miEYN59UkzgqHZJahRyaQ8ws4ebE8HNfu+qoTY5vTLlwtmKBjA5hTtPxrcl5Kil8umXow4uL7yGOE3fFfX8P+CCCJWq/9Q9QGIjjnoxeSARrNefE8Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=WoiMpnou; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="WoiMpnou"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-43cce34c881so3476307fac.2
        for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 13:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782158518; x=1782763318; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qvvm5e3nrHM0bXJJtu1afhtiroq3ETCS6aL42YyUaBM=;
        b=WoiMpnouSLKCKdA/sJl0EfLM3F4ZYKXrbDaLzUnp3svYimvRlxlK4SkvatHXoOEf6Y
         ftatG/+FP19fyU0IlFaYHRAi3HO62IvX0MTIZEE3zkuPPWyOxwqo7EzWJ5GbU6OfcXFU
         bj8ySfkRDOsACgGS7wtCrsDoOOoNck273wXRbLqDwpJMTSjvDpq2pc3hjwV3ccJ4cROr
         1CuVRCWylOxVeRb5tpM6FuR54a+Jryb95Y+o1voPI0qgEumukVi24cvGQeVOlXynq8qb
         4kIYay28pIak+tFWen0s3rpgNvmFFSrjHQgIBbvSrDo8Ikdmx0kSYdPv+vJpQuhMR+TS
         fhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782158518; x=1782763318;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qvvm5e3nrHM0bXJJtu1afhtiroq3ETCS6aL42YyUaBM=;
        b=k+bAryvELylRoVxpZ4s3wKS/FG9q23Oi5pRzXtOeMibunhRtAdzmGbjr682qxVixhm
         ehe1xZccKrwTtFSi4ZI/EQsujkGzKhUviijZ+kpP1AShigVpoWzygkmNs06eEbzUkyIs
         XTF2ANBJ/1icp7sqgq8yvXxgOHlGC4k8X6YxODzC7DiIXy+gY3wewv56dahMwiBYnmjp
         D0fd8m3hxxD/N7e3yyzW+aWQ3Uij0joGpwMmWTDOb/aQBcyZxFlKAhrlkrq0V92D11q1
         6qrKgSs9AHn7kcmJAgSeH3uShbn9kEA39/Bo6xQjTZakGIDfAE9fLiH3VZtLFoaU4k7g
         0vzA==
X-Forwarded-Encrypted: i=1; AFNElJ8pOEKeJiI50Eu6WmujNFeYUBw9BPMHC+O8powAfn2+Gb/1UmhzqaxvBVzvxyVN5Nr2u1YJlgIC/Jg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAYmd+A0czNyXsGSwojJhqx1IFSokrjhIjXIQxX/p8Ym0H035e
	CP+WJL8xmd/8xU0KU0ke72D4ggSVe6QE7xqfc6N3OxX+YDGYEcwtS9uB9BCjZ+Wgq+o=
X-Gm-Gg: AfdE7cntohsA6xeD2mb2lHXOV9g9wygnrVpOhgf5Q7UNAFYFnvF4KG1C6UsY+y6J795
	tn9zmznzwNf4MmRhtUB6zum3lpXs7VAYFtFk+vQ0Zfzf9KnwCJI26t4N9wFuNdnxUgnU+yb3XVS
	lhwDaOr5S2lNGo+6HKiOYfQROHx7YJUjXwdRx+YS4L2bC21n/4OInSEc2CW4wD6RbVuAKy7bd1Q
	JX7C4KZdKLoQTF/58RnaH2jAYitKdMnBbxQJcIOcm6hvraqtKYWBTd+8akc99uzFppADWhL15nl
	TejsWLaJ1EeIIlBpx4ZFNxbne5Zd0aSBFTKFYUaLbo9zV7Z5ADmXSQJ+wOYSN/cMhoIRSLMEWB/
	HylstA9UL7T5uZNRaHjC0jNHezf5TE/L9hYO4k71UboXa7SdrE41aDFa7LgsBPRMEewFab/Ilzo
	xa5hZy5OUfd0LmY7Bqi7E/VsJBtMJSogPX5DKzhzhWCzOGj5c9Tx9HW41xUtqEXzphR6bH7z9Fr
	Q==
X-Received: by 2002:a05:6870:1f06:b0:43d:2452:c014 with SMTP id 586e51a60fabf-44707b8032dmr11879983fac.9.1782158518063;
        Mon, 22 Jun 2026 13:01:58 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:6526:8577:6be9:cb7b? ([2600:8803:e7e4:500:6526:8577:6be9:cb7b])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472e79af8fsm6024665fac.0.2026.06.22.13.01.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 13:01:57 -0700 (PDT)
Message-ID: <f7aae511-0e23-41cf-a5b0-27782caac30b@baylibre.com>
Date: Mon, 22 Jun 2026 15:01:57 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 0/3] dt-bindings: iio: adc: Add reference,
 excitation and burn-out properties
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260622-new-channel-props-v2-0-aafd5369f253@gmail.com>
 <42e544b8-f2da-450b-92bb-99c41f1c72fe@baylibre.com>
 <DJFUE81GZEEG.35TP4FFBVE63B@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <DJFUE81GZEEG.35TP4FFBVE63B@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/22/26 2:58 PM, Kurt Borja wrote:
> On Mon Jun 22, 2026 at 2:38 PM -05, David Lechner wrote:
>> On 6/22/26 2:30 PM, Kurt Borja wrote:
>>> Hi all,
>>>
>>> After submitting a patch series adding support for TI ADS126X ADCs [1],
>>> I was made aware by David [2] that at least two more chip families,
>>> ads1220 [3] and ads1x2c14, share very similar features (though these
>>> chips are not really compatible between them). After that, I found one
>>> more chip with the same features which is already upstream, the
>>> AD4170-4.
>>>
>>> As David explained in [2], these chips are intended to be used with
>>> RTDs, thermocouples or other resistive sensors so they share the
>>> following per-channel features:
>>>
>>>   - Configurable reference selection
>>>   - Burn-out Current Sources (BOCS) for diagnostic purpuses
>>>   - Excitation current sources (usually called IDACs TI) for sensor
>>>     current biasing
>>>
>>> Given that these three features are present in all four devices and
>>> three of these drivers are still under review, my proposal is to have
>>> these features be described in adc.yaml and have this series merged
>>> before the three others [1] [2] [3].
>>>
>>> This series is sent as RFC because I still don't have much experience
>>> with dt-bindings and I don't know if this approach or the properties are
>>> general enough to be described like this.
>>
>> It will probably be easier if I just include these patches when I do
>> v2 of my series (if you don't mind me tweaking them a bit).
> 
> Sure, that's fine by me. I'll add a dependency to your series with b4.
> 
> Want me to send one more version addressing your comments before you
> take it in?
> 

No need. I don't mind fixing it up.
