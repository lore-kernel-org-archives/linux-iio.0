Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE4F522EFB
	for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 13:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792069282; cv=none; b=J5skoh0BVXv7BGOFN3QEEyjqc1RzebIzbKN8RKHp+pO9yoRbY+b6vwWakZhn1tx+wbY8aQiyaT0Px14R4JMCt620EBWZm2XQVyt15HStMQ3yysYYdLeizWAEY2zNwXACnEG3DSU+F75DQVChTot4/+Du19MEQnWteRT8m8gSIUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792069282; c=relaxed/simple;
	bh=M00L0DQuv05+wzHwVamvXqjP2sz1GvUfTGsI+8cDoWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jzLe4JBxGs4hvWMDL8GvLBQDJDSEeQdX2RU38gke3kbIvFvNgB9AJyMMBlj9lYU0SOCE7U4DKBEXt5MX1S4WtZ55DlCs0Y6XGyk1kXyzTvT4zHBEzC2RgF5z+gHBh2ED7S1/tPqeP5dvlPEH6TIzJHWeZg7FBPb3aFFX+w2noLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=MDe+XW3s; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="MDe+XW3s"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-504db7f7870so3643267b6e.1
        for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 06:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1792069279; x=1792674079; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cjFxj3bFbYPisDR6RrznzneRHAUvWft2WkzURGoz+vk=;
        b=MDe+XW3sZGIKUEnYlfRZINRq8F9iFr7onbzNEHeWmvCuwXJaqwkGKfQ9gFok5rB8Id
         IaJAjtROcVBzCDsrrDR69dw49e3I5biC8O2qfPa3WkToEm+M3D3LvUFNbnGyedARiCtk
         cNZtA9RnUSfGGYHtfOcSZRqahDFL6o4H7lgUWZUr2DDzs0IzALO1ecLg7sWiv+lRCKvf
         5XjUjwtQq5pw5W7ZOKOapISX4hwDWYsyK8+tAfyvkAEoBSgrY5CncfdpHFa5L0owkHYQ
         TUTamUfG19ipMTGB++x8MWjdt8HWuPUcUIAQCQobn7hdzkM+MnCt+QPNSuXhetr+IvwI
         oUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792069279; x=1792674079;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cjFxj3bFbYPisDR6RrznzneRHAUvWft2WkzURGoz+vk=;
        b=P2Djcz+IbBIyg/f8fdTfxyG5kCbFjLEv1oy3vfacMl7CjV5Af1XOJVUQy5QU6nfi9G
         hJvWKiLkniyU3CKbNfPspOC6/Gtmr2r7gpI9pVxrzebZ7koYzA+mjrYJmN7hBRMz/hmU
         nHWtIsrX0KgmFoQxvOlHj6usjjzrzLotG+HKsd9zUq3vdS1S5Q6a8wDdjxUfUsFAnRTO
         d8DJs8cYCHbPWBLzQKZC5utSxUl4cqDgttd6kf3bVPG7Y+2UtAmDfAbmoTkODmXhHLcz
         iMg+GaBKRTzVPCEAYpsd7IF4HF1CIMtQHQiThPB0lvcLD9xMa+aYXRTG7+JVCtxCcLpa
         WI1A==
X-Forwarded-Encrypted: i=1; AKwUvBxKwhyl4rvv/NoCbo8GHwejCGnXUE9HS+emAZR5pnstN0Cn0GqfFLyXyCHxNHyMLIX5lAf/A2qFE+Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYL+o8dYkKyfIAVVvAe1z9I3m+LwDPWI9bOhf3rsD07B1FsS1zqP
	E6VsWWTqnyjhyhSI8oaz60UFHiSAlKpgjMIaZOZJ2Sg2CmJS79YBTubSLX/Jsyt3Xog=
X-Gm-Gg: AYBFou2PBLhWn52W6jlR/0P//S22YlXUKVrMvhWor/4Tz6sISMg0bTM/P27jI/3w1AQ
	UMbAk0/whH+7kMWCCXC1468GhmrXZ/VEILJ4TXJxxcueD4jbqoxLVp6Uzf0G8P+wBuLySLOprkv
	T4rkmNsnV4g4JOb2IJjBWzZar4vX/ejQ4Mw6CGl3yyxWeye4LqKMgKtgN8NfUr02Z7KkzshAEnS
	bNvU90DGk8gSq2F97cmpfd93Ts5RvTl7AcQmR0oGxzbgr4VLPgtFkzsIMmerGnIANErOHlxl9fu
	PRRaX4UKnNPaBJ1uZLbg8KiU7Xa+aHRrrvT1AYTnGPP1UeeQ7MkbZgMmCkJLWqt2VM+j/eSASiW
	JrJxT3U8uw5mtak4zRb8/hAEzAOX2aZHYr+1U6VeDbCqo+aqEQ2eq/WLoESMNmjUZunw0q8VFv0
	LLyRfGikytmyiagsCNra3u1KZHKuDvIRJ6C1BUGGarkW3+Nas4gjbXtnVBUKtdwNSzQ8W/Y0XVG
	Vmv1lOoeRNxVpNKuNCIpG1Nz0mru91T4MQ6ClFU47YgY9ZMHI2X5Lf/Yik=
X-Received: by 2002:a05:6808:1387:b0:4f6:6041:f0a2 with SMTP id 5614622812f47-50c5482ee7amr19056488b6e.27.1792069279336;
        Thu, 15 Oct 2026 06:01:19 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:7a64:39ea:e5ac:f974? ([2600:8803:e7e4:500:7a64:39ea:e5ac:f974])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c1674ddf8sm18952180b6e.4.2026.10.15.06.01.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 06:01:16 -0700 (PDT)
Message-ID: <ca27a15c-5b21-4381-a82f-e80bb0ae488a@baylibre.com>
Date: Thu, 15 Oct 2026 08:01:14 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: adc: ti-ads112c14: add gpio support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>,
 Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>
References: <20261009-iio-adc-ti-ads112c14-gpio-v2-0-3231a795fa63@baylibre.com>
 <20261009-iio-adc-ti-ads112c14-gpio-v2-2-3231a795fa63@baylibre.com>
 <CAMRc=Mfn7+uQYvLjGLxU9wMOnRwx5pyPgaLp6oNx+ZcFXyXL=A@mail.gmail.com>
 <cde9d00a-bfe4-4093-b03d-f76a122e4ded@baylibre.com>
 <as46xFp-3fXvWPlm@ashevche-desk.local>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <as46xFp-3fXvWPlm@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/13/26 9:05 AM, Andy Shevchenko wrote:
> On Sat, Oct 10, 2026 at 08:46:30AM -0500, David Lechner wrote:
>> On 10/10/26 4:00 AM, Bartosz Golaszewski wrote:
>>> On Sat, 10 Oct 2026 01:25:52 +0200, "David Lechner (TI)"
>>> <dlechner@baylibre.com> said:
> 
> ...
> 
>>>> +	if (device_property_read_bool(dev, "gpio-controller")) {
>>>
>>> I think the right one to use is device_property_present().
>>
>> I thought this was the one case where device_property_read_bool() is
>> actually correct because gpio-controller property is a
>> /schemas/types.yaml#/definitions/flag.
>>
>> Otherwise, we should just remove device_property_read_bool() from the tree
>> because there would never be a reason to use it.
>>
>> My understanding is we should use device_property_present() for non-boolean
>> properties when we want to know if it is present or not before reading the
>> value of it.
> 
> That's not true. The _property_present() checks any type of property, while
> _property_read_bool() returns an actual value of the flag, while they might
> overlap in the behaviour, they are semantically completely different.
> 

That is exactly what I said.
