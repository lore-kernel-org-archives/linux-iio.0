Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9194C2C08CA
	for <linux-iio@vger.kernel.org>; Sat,  7 Feb 2026 17:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770484783; cv=none; b=uVkVudAhT+U20bVGbuINOn+rgLQ+5WOuOupjbbovhQSalVrtL84vA33HNCiFYXdmdbrDqSgowabY9T5DqKdzbmNhe1X5uTdEB6XcSgXExFaOFXxf0j6k+dJdoF5BtstAxe+Vftgv1uL2sjpIc0yZaj5Doa4k7OTN1Qs2kHCUzDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770484783; c=relaxed/simple;
	bh=5tSv0K2xPLmp03qZ0ySPg6fhMYjNHkDNBp7DBZrnlwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qxYpAOMsszOxKYAELgZg3o79n0od7UqM1IWPESz25zyr03no6KNsK/Z7TPgDhGBH8PgcqNiwpqEpbj4WcaeL2D3HjtO33y92Ro5+qC4s/KCUkrFBMsgBmQWpIaqyu2luq1+D77qpHjfWy/Zzm3FO/DnEVfYqDzdqS2bx/z7S72U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bFv0bPUA; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bFv0bPUA"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-662f91bba0fso2631073eaf.0
        for <linux-iio@vger.kernel.org>; Sat, 07 Feb 2026 09:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770484781; x=1771089581; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1W00zz5qVNYTH6MgjHmIYO/oSZsXOTum5yin9z3CGMg=;
        b=bFv0bPUA4Ofv6wEr0EqxOkBc+vmD3AnYnxyA0Qk678SHkvpIeT6265hZHeFxKWvqHB
         01AQi+I05chJ8BXxIclTtCpvXTyjdDUDIglhdoIkn2IzXlgc+A4WtlE3sfbQCHcB4P4e
         e9DWPSGSpzONL2PwMxYgjUej94lrrTfGtO+HtaiuVdK8tnUPLBe53VkTm8HPaJjmVnr9
         HKKUhDfweDqql9FQ68HGL5mLyMuOW4IWlwwBNSCcv+Gcchy2/oejnt/W2y7gSnZgKj1Q
         xd3VHBk9S6FMfPANuG66d6cea1hLt7aeWCdBRykH6AGPjbaQWNNgeHmTFiII45/LSvAx
         7DaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770484781; x=1771089581;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1W00zz5qVNYTH6MgjHmIYO/oSZsXOTum5yin9z3CGMg=;
        b=TI2noOQQvoGyxTn4m8ZlX79uEC9c6ZnBrjeVHddqy36odkZZRHGEAPUb9pcIWio4Vf
         Mf5Vb55wZM0GBjEo+0pQaxvcgXC+E+1MZ/Vio9YT3+WawtTcY6+lpXa++jl41iXFKX4F
         2YliCbHropX9uMmX/H+dD7TYCCye4o2rOcTNaZ/Hy2Hl51Ynm3rC6cKZV0a8s2O5iEO7
         9O8YmdGOVBxrdrO2NSgAIe0qSde139hztmKNRKupXSKveSJive1Hau2oqYp5pEEDtJmX
         wEwdi7x1/nN8pJJdu77lGb5IOhy6V/X+5U9iFn5p06LWcksHznmeRwawK9FT1nEd92Su
         7gPw==
X-Forwarded-Encrypted: i=1; AJvYcCVPaldJwsKDTCtowtC1C1m99eQtISALfhjMrmEozBAkEV9Fi/u82uoghgGr58NGAj/MYkj7K6R3z1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvglpDmSeG+0f+X7KCwNXQUdv+c7+Hh1iyMcSrGE9W2uUbXKRn
	seXh71NQoHt5biANdcfLGRo5J2VjrD2Bv3vuavIj7drlmzNH7wTIQ6J7Yg9N2iUw0c8=
X-Gm-Gg: AZuq6aKw8IEVeChDMA30wSO+j6/N6B0ZSA0fP0VT0697HHMERNZnO0QsZkbdUS5ijxR
	hnPTlvrMeCIk2iqfMxO6MqgRF4nRdKYlMSqao7qnUda/SSFOdiD160guF4KuOl4ImQTfN9WbtSU
	0MdRf+TUs3Q+Vm3pPH+LKCZU5ZP88uTAR9EWEE7CYAsepJspP7Re0AZgFE7f6i25KhR1dl1ZudG
	tDGYwOgGJJWAIBPIjeKMUoYL2DjxThQDH07PlWZwNYh/4baeJRQwo4idFxSYPrT9aEIYyoVL7es
	Sm56TiabJoF+RAoSnxKROuDVEZOHhy008Gv+EOO6Fl36QpxPsVg+pKULrZBWFSC20+jPqfur4Gu
	Pw2USxpC/h8BgCkQuVzzsGo7sDgYLS1N6K6FZzYzYyjELb1QKT83vz0AU4tUvCo17DZ9BTrrDjA
	XZQXpsZoAnID8ksEHxoiRiR5cx8AfxTlahQfgKNhMH++t0tswXp+bud/yiDSqeUARWTBZuAQ==
X-Received: by 2002:a05:6820:3101:b0:662:bffb:41fc with SMTP id 006d021491bc7-66d13059c28mr2419479eaf.15.1770484781465;
        Sat, 07 Feb 2026 09:19:41 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:74a6:843b:f33:21ae? ([2600:8803:e7e4:500:74a6:843b:f33:21ae])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-66d38bdeed5sm3004756eaf.4.2026.02.07.09.19.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Feb 2026 09:19:39 -0800 (PST)
Message-ID: <db9115ca-2c8f-4b5e-89ce-f3b934071a59@baylibre.com>
Date: Sat, 7 Feb 2026 11:19:37 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] dt-bindings: regulator: cpcap-regulator: convert
 to DT schema
To: Svyatoslav Ryhel <clamor95@gmail.com>, Rob Herring <robh@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Dixit Parmar <dixitparmar19@gmail.com>, Tony Lindgren <tony@atomide.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 linux-leds@vger.kernel.org
References: <20260206172845.145407-1-clamor95@gmail.com>
 <20260206172845.145407-2-clamor95@gmail.com>
 <20260206230922.GA254792-robh@kernel.org>
 <CAPVz0n3EGCSLUX7jTLve0x0z4uW1yexViCwkSQLY2d_4r4qkjg@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAPVz0n3EGCSLUX7jTLve0x0z4uW1yexViCwkSQLY2d_4r4qkjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/7/26 3:20 AM, Svyatoslav Ryhel wrote:
> сб, 7 лют. 2026 р. о 01:09 Rob Herring <robh@kernel.org> пише:
>>
>> On Fri, Feb 06, 2026 at 07:28:35PM +0200, Svyatoslav Ryhel wrote:
>>> Convert devicetree bindings for the Motorola CPCAP MFD regulator subnode
>>> from TXT to YAML format. Main functionality preserved.
>>>

...

>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - motorola,cpcap-regulator
>>> +      - motorola,mapphone-cpcap-regulator
>>> +      - motorola,xoom-cpcap-regulator
>>> +
>>> +  regulators:
>>> +    type: object
>>> +
>>> +    patternProperties:
>>> +      "$[A-Z0-9]+^":
>>
>> I thought it was said on the last version to list the names. Considering
>> you already have them below, better to put them in schema than prose.
>> And pretty much all regulator bindings define the names.
>>
> 
> What exactly do you propose? All those names will not fit into a
> single unbreakable line (more than 125 columns in length btw). Patch
> checker will complain about this. Duplicate pattern properties for
> every few names? Please be a bit more specific. Thank you!

Making checkpatch happy is not a hard requirement. If you have to
go over 125 characters for technical reasons, no one is going to
complain.

I already gave an example on the last version. It is just a regex
expression. (And note that you didn't fix the $ and ^ either. ^
means beginning of the line and $ means the end of the line. So
the pattern currently won't match anything.)

patternProperties:
  "^(SW1|SW2|SW3|SW4|SW5|...)$":


And I hope it is obvious that you are meant to replace ... with the
rest of the names separated by |.

