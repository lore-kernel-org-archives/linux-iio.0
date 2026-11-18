Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795023971;
	b=HBp1EJbJQpiWDb/Y45JHxWTvxEJtToU+RGhtZFzm/2aTUoqGzNZxX+eQll2pHeYbew6H
	 2KxwXsW/A5X+3OMb0UBNvDmaMQ8TsE1pBICRwroOg0l3o8+QHnc1LU3+dRgL1kC/vSG5P
	 G7jAgvEV7L5u6RrFogHeKjDGJ84F0bTWoHn0qMD0IOzUnuWcGiJAlQOeMSbCvAbTPDa2q
	 EIL/Au0UF31XgiQOcrY5slFqLKoaCKfjPoOhIyd374iFjeK/uR8/D6twDbaESRbLyCWLS
	 ZpJ0y39HDTImnWIdbcACkKn//qy2dGOWVXlgS6J45Ekm5oaCTh74vLGeagy968Ewz6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795023971;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=L2XfYf4aRDhCK0D/8nP9CcpLQj+vmYB3RvSR5Daz0kU=;
	b=UHf8+B5Ijv+mdoq5qyL8yXnTy3rAEGrxbYybXFyLFvybkoTO/utRCb8TlSlVOPcnmxbo
	 uoPCelzNf6WTzx2fcvCkE5oCkSx0o2qOpkWpqaDGwpJihRAP3W8wAuiUKFxkrtw0EfYki
	 CoASgBcmu2ZeXoiJdI4LwhI1pJxwf9igPE3+5QMXbdADZVMHJxaZPY1VACZAMeAxschGL
	 UHqxQWDiPu7sjnYJGydYYo+sMkFCTBUG+CnY3o5TIKCxA+TTWDTQMruq14QI6VCWmkFPR
	 PdytNsduiuGeMMEvYMWesGPU+YBOvtgrMRgVxg/RdFc5Y8a0DRhRBqoUZxsEP074n4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RR5r8KXh;
	arc=none smtp.remote-ip=209.85.167.53
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6568D606A339
	for <linux-iio@vger.kernel.org>; Wed, 18 Nov 2026 17:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6568D606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RR5r8KXh
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5be3ed646a5so1493060e87.1
        for <linux-iio@vger.kernel.org>; Wed, 18 Nov 2026 09:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795023968; x=1795628768; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L2XfYf4aRDhCK0D/8nP9CcpLQj+vmYB3RvSR5Daz0kU=;
        b=RR5r8KXhSE2XnaTGcZnPEWVBdHkc57GSBO5iTEsChMbbGlpfjF/WLPYBeVqQvaqqJw
         O1WdmlS3E96rF0JNVegFLsHZGhdGfsOb+Mlbq7rlnLyfpvcHfxOIkwDYKbhW6dvPraMw
         8c/epJ7vKKAZMKs+1BjJLl7VXb2SRFpDov72E1MpGxICeQbwvqMEMZH7JA3BHWgpep5E
         RGbQYO3BG8TtbCT1BuVK0BHweGGiEATVJXzOz+4VsGgKQDV3RvMg+WqNTT6StMtmsDKL
         9hH0mv9yTVKQBD+uxWcsHdsSt8g189vyX97EmgYX8r9EM80faeIkk0ZwpP+YBQJ+djOW
         AZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795023968; x=1795628768;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L2XfYf4aRDhCK0D/8nP9CcpLQj+vmYB3RvSR5Daz0kU=;
        b=awVacpzsmvsyyqlGTcr7jJfDEQkpmMG2f2Wi5ugZSO9nsJi6L1DUj31ubsBJ5KhiwI
         oatcHA3wq8OMHFKmvTg/H19c734pJevz+00CVp8nVrsNGw2v21qFRED9ih8JjUJNMPP9
         wpMCSs9q5Zf8V+Ra2K3IYd7ceZ7H5nnXPhJFw24V3ff+97PHG+UKMM3eAwlw5MHgID7B
         HzSUgNub5dUlhgnqzq0aPhcTGK0zv8VpYpjrU3pfGVio6uVwv8mEd7og6r80U9u0ykjl
         5goH/X2sYN4IVfQC3+0QvQODIaFim2Cz0xFz1kapN5peHBSS8ZIYWn7RP4fnggWtIpPR
         1lZA==
X-Forwarded-Encrypted: i=1; AL+hErEVpi79laQ1ndJAkDhB8G6u3VJCgAJcsg0O1Erc63DZshrtw0gy7U+8qEXhrzhm9oaqTet1JHNitcI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8qFwG4IIPlJel6Elgq1oDJ0hyhefq1CDLKJhO1mmwKLoZhKrCI
	wmcmoXqf4INYXx2egkauma9BSA1s18pZQc4N9MJAVdAaVhn0XsAme+b3
X-Gm-Gg: AYBFou3tXsjJioHbJEy6uxDwOhAalAzZ1U34k9L2ZW4y4vsw3vBdtTQnVzO0Yh23EtO
	z+EwGry4ycSbiVKAgcJSc3zXEYZzdNarHh0qoNd0wurmgArdhXVViXhQ5GbaLtKXZD1l3xW9eBK
	u8/PXCV4cbvChq5f1xGzBiQNLeO+ziMzXeU17Fd6tFrCq2RdFnTzBP143UwXuMSKJk14SsmHtic
	UmzzFc3tQqx5+KnZb8DNjUlZPWmWMv5kY7oZWBr7+pUzleO5Ca1ECbWvpnyFZvUOvxwD33dTE+D
	uXHPQc+5b/Ee17eSh6XVB7hGtqzMSiw/Xyb8b8J81ShM/ec1NNS7/8Ng1v5+RDoFYnszufWgwcn
	LAQqofjTP7KNenilZ2TyR50Lu6XZexFMwLWTILWQai1msSSi1GONMEaFE0Qlc39KB2jTa+Oyqo8
	vyMN16SNJ8EGkKNSEQ9/1P4Xpbu/OKBBt97T6/8i82zy1hCezdyvPma2dKgfPKqYFYSqjTdSj+1
	goe0LbDGUt2T40tOUya25Met5dXv8idEm4FX2+wj1mzaP4T82+AsFuIO1MNdOKqIU/h17YlxOVH
	h820Qb1hBfIX3cal/bqN58IUbnPlCz2dx1EU/i37nhS+GC9TkmuCu8vx6maiLHQ84d9Q6Ge6Zzu
	Wi/CF5BXCKw==
X-Received: by 2002:a05:6512:132a:b0:5c1:57d3:90f6 with SMTP id 2adb3069b0e04-5c1aa080adamr1181252e87.24.1795023968247;
        Wed, 18 Nov 2026 09:46:08 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1aa78257csm707878e87.51.2026.11.18.09.46.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 09:46:07 -0800 (PST)
Message-ID: <c6a7e6a8-42d5-4470-9206-1f8d4f1a3013@gmail.com>
Date: Wed, 18 Nov 2026 19:46:06 +0200
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: Support ROHM BD79111
To: Conor Dooley <conor@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Matti Vaittinen <matti.vaittinen@linux.dev>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Joshua Crofts <joshua.crofts1@gmail.com>, Radu Sabau
 <radu.sabau@analog.com>, Janani Sunil <janani.sunil@analog.com>,
 Salih Erim <salih.erim@amd.com>,
 Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Jakub Szczudlo <jakubszczudlo40@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1795009599.git.mazziesaccount@gmail.com>
 <f69b996cc07fad1712871fb8b0436c71abd435b9.1795009599.git.mazziesaccount@gmail.com>
 <20261118-ancient-ominous-4f2a4a37369b@spud>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20261118-ancient-ominous-4f2a4a37369b@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/11/2026 19:37, Conor Dooley wrote:
> On Wed, Nov 18, 2026 at 04:19:11PM +0200, Matti Vaittinen wrote:
>> From: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> ROHM BD79111 is very similar to the BD79112. Both are ADC/GPIO devices,
>> where pins can be configured to be either used as GPIO or ADC inputs.
>> ADCs are 12-bit SAR ADCs and GPIOs support input/output but not being IRQ
>> sources.
>>
>> The main difference is amount of channels/GPIOs. The BD79112 has 32 pins
>> for this use, the BD79111 has 16. Furthermore, the BD79111 data-sheet
>> promises 0.5 MSPS sample rate with maximum of 10 MHz SPI clock,  whereas
>> the BD79112 data-sheet mentioned 1MSPS rate with maximum of 20 MHz SPI
>> clock.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> ---
>>
>> Note, I had to change the 'root-level' additionalProperties: false to
>> unevaluatedProperties: false in order to allow the properties in the new
>> allOf:
>>    - if:
>>       ...
>>
>> section. It seems to me this is what a few other bindings in IIO do, but
>> I suppose it makes this "less strict". Well, since I am terrible with
>> writing bindings, I'd better point this out and ask if it's ok, or if
>> there are better way(s) to handle this?
> 
> I don't think you should have to do that though, since the children are
> described in the same file.
> If you instead retained the pattern properties section, and lowered the
> restriction to channel@<any number> with reg with the max of 31 and in
> the conditional section constrained reg to a max of 16 does it work

Ah. I think it will, thanks for the help! I'll do that in v2. I'll just 
wait for a while to see what other comments I may collect :)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
