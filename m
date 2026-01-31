Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3E42D063E
	for <linux-iio@vger.kernel.org>; Sat, 31 Jan 2026 19:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769889330; cv=none; b=dtl7arfChE7ftL7ygIr6xve6sx5KutEV1EBVpGI/AJm4OaSksrZiVLq4qTKV96PC+JYy3toPFCkWjI41J7j9xcwirX+2YQ2pgl/lV00tsldwQ6Rh+XnXLDWzVMey9XsASuYE2gY1qmUaNDiaTXi2AlvjfYmpwbOvxmr6jj0ZYLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769889330; c=relaxed/simple;
	bh=t24mKOVNxxmWMKS1t9FekxYrZBCi//zHUHXDdl8G0I4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ToBKrWDRQe/npEKfoddc4GnGHIlAc/iiNiw9mbYSjhqcrc3fDngkEzFW0kcdrE2TNnlxmeR0Qj4Lr28hJ1YYh2yOhbXETeeg/Ehq9fTzI6NCSVooiFusXj25HyccNQ7/5LJG4zkYdimBN4l/pv3KqFPSNzmdqbd6gh+00e0QesY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rmw5E5Of; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rmw5E5Of"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-662fca4503cso1841786eaf.0
        for <linux-iio@vger.kernel.org>; Sat, 31 Jan 2026 11:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769889327; x=1770494127; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H+VFD3n9uqCeuR5oa2hiu8NEEffv6cHN447B+eVXKTM=;
        b=rmw5E5OfI+f9amD6CdjrhJUpCNx27t7LETFfGMwZRE2lrMnm+9y2OQjwmxPrPW3man
         V+6nlU0IVqBn+5Th+W5/mcOEgfotdTkizpd2otLJePaCosTzUajbyhOjOr03lyvDqS1L
         0vGmSifl5cJkBqZKsOoRj7Ni7bioYTOOF+lhA0tesl//JzQduo+CUjDj4rbSKrgb7CpN
         NG8VoLCp2bpkgTW7tN+JFY0GA8HV7zzcDFzp/LKq/NFzgTcHbwav50ItqfJBXsGFtsXk
         oHeBuJ63edbLWvskebiTUHsHfVdTs+Wz7SVoouNmPdwCAO0HOuudFCchDS1w8pa1xZTF
         lefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769889327; x=1770494127;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H+VFD3n9uqCeuR5oa2hiu8NEEffv6cHN447B+eVXKTM=;
        b=buwFgLCuDdw7wdNMkl1saEzTaRFK82TWAngIRQINFbOU0mn0qnjgOJM7wxXQ9YNl4c
         Q/6heim17fj4kPsOrIoXxm7XVJMJ2PcjncXTD4CJ1jsZgLA9JRUGCE+EKqugrp694Jqx
         55Ts3vwSTR969qwGVuwQf45wRbfJpQWIf/Tr26TLLdNcRYMXTcV3vwQPwYMJP+1Ph/6X
         VTQPVCOO0Bo2Ug8BGHu6SvTLwQmrEOMMfMTJYcET5byG3yINVlLxSwr7DZLlRfLkTV+0
         WDYPSjHeQD2VegOjTsWAv9oBxe7EbnxXs70nZUK3UNuWY/KPcodZD/ZxI04dtO8YsDyG
         ea4Q==
X-Gm-Message-State: AOJu0Yx3h2mHsS7XpUzbf/d5vZr27Ix/i5GSdpr+xE6WEGW6mQR6+4JV
	IVRp0/yxHl2TTIcPG0clDngHBJEI0wnu7JZEumxd8V2i3mR3/0B4MJ+91+gpiuZT+Jc=
X-Gm-Gg: AZuq6aKotBSjAfPdZ419JXQCvjyDlpRyV89lN1RcsXxqoiRd6CETzQMGrbYyreesbEQ
	77D11l9c1Lfzna/fragQJjqRFjrFts67vWFUYhsZbXKxRgNnX3HytEgsLvZRDzE5nGNaq5N3SeT
	iIMSzAzpdYqO6Bgc0KYpE4wbwMshU6b3uC2STY8hSeSc6JcxYJ1PPxSYzzyxtqYdGr8jwpPnqeR
	mRLW60txBja66KzZDoc401YiwsVf2pmtAxMHJ8Wo5bFkTRb6WYmizy1ZV1MQ4ayDc170fUA5Olk
	Ev7tyfoTFJ7jTV+VSQ1iyx8thOQhyNEdAiZ7KcWJluODHjTw5Jvisdt+P8679q3J/+zUrcJ1Yw8
	GrLEwa30YFkJnu5NF6vtIzLm5bFlxcsAEwlcqyZvrNHL1v6lsPiseMPrxgSGv2ZkNruXXWQHIzX
	b+mLfEDz15xkYmstxBwFajE5ERIOoIMwFeQhPILS+zUDtIfhZ0JJTNzD7IeIuc
X-Received: by 2002:a05:6820:2228:b0:663:8c2:feed with SMTP id 006d021491bc7-6630f3d4c04mr3300269eaf.83.1769889326973;
        Sat, 31 Jan 2026 11:55:26 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:c7ef:51f2:4f7a:6cd7? ([2600:8803:e7e4:500:c7ef:51f2:4f7a:6cd7])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-662f9a49769sm6775854eaf.15.2026.01.31.11.55.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jan 2026 11:55:25 -0800 (PST)
Message-ID: <8cedbb9c-9f72-43ae-a23e-705b3feb85fb@baylibre.com>
Date: Sat, 31 Jan 2026 13:55:24 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/10] dt-bindings: regulator: cpcap-regulator: convert
 to schema
From: David Lechner <dlechner@baylibre.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Dixit Parmar <dixitparmar19@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-rtc@vger.kernel.org
References: <20260125134302.45958-1-clamor95@gmail.com>
 <20260125134302.45958-2-clamor95@gmail.com>
 <d7938728-fded-4d5e-b23d-a8346e3fab46@baylibre.com>
Content-Language: en-US
In-Reply-To: <d7938728-fded-4d5e-b23d-a8346e3fab46@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/31/26 1:46 PM, David Lechner wrote:
> On 1/25/26 7:42 AM, Svyatoslav Ryhel wrote:
>> Convert devicetree bindings for the Motorola CPCAP MFD regulator subnode
>> from TXT to YAML format. Main functionality preserved and added compatible
>> for CPCAP regulator set found in the Mot board.
>>

...

>> +properties:
>> +  compatible:
>> +    enum:
>> +      - motorola,cpcap-regulator
>> +      - motorola,mapphone-cpcap-regulator
>> +      - motorola,mot-cpcap-regulator

This is what caused me to get confused on the order of the later patches.

motorola,mot-cpcap-regulator is a new compatible, so would be better as
a separate patch.

