Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51618288C2F
	for <linux-iio@vger.kernel.org>; Wed, 21 Jan 2026 17:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769017389; cv=none; b=W5BcH9Gp2qI5KtIjo9prPMwssB0atHa7N5zNB4x7ftERl+xFIw3lKpZt/r2Y3xFgRoMY/lqQYpZwEkRntYM5gaVYev2x/ZfXguQH5vr5ZuW9F9KpH/Psx/9X8CiE6EKi/HYEEO+nmYuzgaXLsUWsdAoaKvp9AQHTDD6LTIZoEfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769017389; c=relaxed/simple;
	bh=KCp/PHafNusEm2mfmFDT5kqNhBPSp5+sK77Cir7m40E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XMpB1Sd1/ghbZJjr13qNUL7xsg251RsgofMqcrTlJKhnShefrUj/TMwnRYRCtHlSN8S3eQgB9pBrJn+o5MIMLKA5/nmS/XnxSjhLF7egDdeYsstF1XdM1i7Tyc7boOxMdD3OrxK7O05CKaxcK6CvmpoMWOH7XjLIvKJ9oJn2X8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZIFME/Fu; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZIFME/Fu"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-45c78da5936so582325b6e.1
        for <linux-iio@vger.kernel.org>; Wed, 21 Jan 2026 09:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769017386; x=1769622186; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=avyvpoQXDRAmKtq315EuJLUT0g5dGnGHq3S82pBKxXk=;
        b=ZIFME/FupEiel1u9wI3vCxL++b4ucSKbY9zLu39ahCfkV4mmw09WCQc82Oq+zb35IV
         FeE7Rofp7yvw1EGh9Wj8bAR8umcEMz32FrfxL0to82pAhpSkJQW5rEzOlMekCrHIwKX8
         4KEaJ7QQkNapWY4mTrOJEW0WzZMdDDtOBDhQg5lFzTGqvMSjBoub9CxdkMIeDPBBGPh8
         BZa/laCmru+zIHKYK9BHFaeK1sAN1NiSpHqbGQpx+AmwdC0O1vQIcCDIXRd88XB9FVd/
         I+ru2bcGDyBTuBsLZBB7/ubn+nktaqZ8uyG9UIw6djtq8VSwMZWpNK6WXwpGoih9V34Y
         N66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769017386; x=1769622186;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=avyvpoQXDRAmKtq315EuJLUT0g5dGnGHq3S82pBKxXk=;
        b=NV1nGpytDCJZKAHQ4a6qEmY602s5rC9SzjFZot9nBTGS1oHKPLNCE0ahtr5o2/L7U8
         K/aMU3zFNdCRxJCMb0fVIdg6p5dVecUnNoRz0v/Sn7l7OUH00jVeQWgg/McOyd7L5uqK
         3T5/ZK8apJ/NKvKYcc9WopHuS3RWIjq18cmZez/6Onm/hcIHy922sb3Qf6FednbEU1nu
         Q/2q6qzAKDd5xYsihiNAqc2DOBJYMUFprEozi5NL7otFZDswvdGKr9oXjiwGQ6cYcqiQ
         diVbjQpYbhhLwwVJZU/U/jzG6BjnX4yl5ZYJfIQOeg/xEPM7WUxZ1jDzyA7VVO8Jz77Y
         59Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXVdPwy2DcYmtkuhMzeaFOSkn/i1ZoEAGWve8RqfrhoCBpxcN4lJKmKE6Z4UttrOo7JTt/fdjtajQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTKqB3JUu2QTF2Jk43fGJdDLS3OZmKTABMNCpUaRvAzW6hU5xL
	EDNj+6yp0kFcOkocENbChHX0daBqxHhh0lWZi2DWwnCmycmD6+pKSPn7XGePNmbCgNQ=
X-Gm-Gg: AZuq6aIeOGpUOk1+cJnW7VmNysXmb4sulFg5WKl1RgNMYMoqO7kimE63B4UcjBA7BRD
	Gsvs0m5+46fpVCjEkHLtxApb/cTobhzSOZfoa2w8511kv3nkoSIEBbAEY5SSQxhq8QPvpwfbDcu
	eCCQ8ASk8dgFS/2zjN+LB24ifhFihuKcycZKT1iZ0EzBbZNByKTekNejU22i1Q6p0RyL/sRr3kd
	mWFFLz7mdNddROpD84B05FzVOP+zmc2jGfzzee1ERmtxpk2c3xTTH/TJqilNulGxErYiK+aIlr3
	fAFdb9fhREuKUKA5C+OoLBBWjUmtWzBqhthaghTSIN5L9Tlb7ffpiJKCzTWP17g5fLUE9ks9kw9
	O4yBcrWcjH5i+99t+ZDrR0GmmfWu0KooABqkDwa4nsACloY+Iqn4DDncP6GAmbMkJGngFJ7IZSw
	mUHnfKXSF3TT4bOJ55syasVyTwRE+EFV9HyhkrBM9P5ErSc6mn/QcQV8A=
X-Received: by 2002:a05:6808:150f:b0:457:a9bc:dbf7 with SMTP id 5614622812f47-45ea3d89eb7mr105116b6e.20.1769017386123;
        Wed, 21 Jan 2026 09:43:06 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:9a8b:7a9:24fa:a0a? ([2600:8803:e7e4:500:9a8b:7a9:24fa:a0a])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45c9dbcdcd3sm8784078b6e.0.2026.01.21.09.43.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 09:43:04 -0800 (PST)
Message-ID: <95b13260-0564-445d-bff7-b3b54fa15005@baylibre.com>
Date: Wed, 21 Jan 2026 11:43:03 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/9] iio: Expand IIO event interface for real-world
 unit handling
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, Jonathan.Cameron@huawei.com, nuno.sa@analog.com,
 andy@kernel.org
References: <cover.1768759292.git.marcelo.schmitt1@gmail.com>
 <4a04fa3f-c056-4443-a55a-e8622feb1c2a@baylibre.com>
 <2f9e7172885c5dd20be198f013283c6ec0513ef1.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <2f9e7172885c5dd20be198f013283c6ec0513ef1.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/21/26 3:33 AM, Nuno Sá wrote:
> On Sun, 2026-01-18 at 14:33 -0600, David Lechner wrote:
>> On 1/18/26 12:18 PM, Marcelo Schmitt wrote:
>>> This patch set adjusts and complements the IIO event ABI docs making them
>>> coherent with the fact that not all threshold value attributes had a _raw/_input
>>> indicator set in their names. In addition that, the latter patches on this
>>> series update the IIO event infrastructure to actually enable drivers to provide
>>> _input threshold value attributes.
>>
> 
> ... 
> 
>>
>> Just throwing out an idea here without thinking about it too much...
>>
>> Instead of adding a new field/parameter for units, could we extend
>> enum iio_event_info to add IIO_EV_INFO_VALUE_RAW and IIO_EV_INFO_VALUE_INPUT
>> (and same for HYSTERESIS). Really, the units only make sense for these
>> two info types anyway.
>>
> 
> Makes sense to me.  Or we can just document that the old value is _INPUT? Or just make
> it the same value in the enum.
> 
> - Nuno Sá

I don't think that works since IIO_EV_INFO_VALUE could be _RAW or _INPUT
depending on the driver. And another point was that this should also
control the _raw or _input in the attribute name, and we can't change the
existing attribute names.

