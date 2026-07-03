Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C303B42FD
	for <linux-iio@vger.kernel.org>; Fri,  3 Jul 2026 10:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783072904; cv=none; b=bTdgWzgJJH3IFM75yp1/r01JRls0/vgprPcXqU7bEdkaa+bdWfZdfeM7pI4f07iygk07D9yrkRxLgfzfJJiEpL4+IZ7ow4IS0+FPN94eypl2OtqND18C0ivUAcXCND69dDbur9NKkLnewhyZn2CYSYbO4sPjQO2pIxdtLNKgBDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783072904; c=relaxed/simple;
	bh=RYeeLX2JG8dp87oYPPrNDLM4wRbMmmAVowH6Gs/X6vw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=srHFtO5sfD9+MhAvEom087gWeXQUPR1RQ12j8kimGGedDRWPRzXgRNXJCA/1TwKjg5tTgwshgMa8byvmidP6TIp5G9scnyZLbkOHtfXtYKhdFVXGlOfeDIuRruimtU7RzGqBUbuKwCRplBTkTbEVXiUkZxR/LeqX43i+w6WlCEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7V9YHX/; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7V9YHX/"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-698aa7ba320so287165a12.1
        for <linux-iio@vger.kernel.org>; Fri, 03 Jul 2026 03:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783072899; x=1783677699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iphKavMyEGyoKkZ7flBVPKctJFRcurdGeTwbxLH/hOs=;
        b=A7V9YHX/6P5OlAht23tj0RMGPFoSinD9l1uXNrDG4TPTQp7WTHxT8tXxV+iZlehnoa
         lPLc48BQEtflxSDW3TSmiC2M3IoGKKqoI8Wr1qollpaU81PrGqSz+Qr7AMC06BMOK+BL
         R1rYxp0yzuGoHOnWQjQrMqJ+0MBwn/aMKS8iGmuVDhdxtDTVLz5JrH+QXfJmvwnudQAo
         yLcriQBv8FQy7WbBR8+K7UH/35OSk3PAqDSdcBZ8qKgg1wumB/gX20RXu6xb9thFeZzM
         d0RIaLgusB8tjNciytWwZmzyX8va4aT4orP2S7LqxVeTpWHBURkm4S5y6WrCopp1c308
         GhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783072899; x=1783677699;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iphKavMyEGyoKkZ7flBVPKctJFRcurdGeTwbxLH/hOs=;
        b=IujbHjeYPZag36tMYP8fxxtbqre6BemgFZK0vErbxoHo6TT7HUIUXGOreaAvdjpvVf
         2ZwzO3Hw7rbzH5RhpuscMF7d+vn9/PX+WwW8GX/klKAlscKw+sJTU4HpulJhv2jXIgLD
         slKdP2elvQ16pI8MQ+ClNT5VPrZhYI5eXKGLKgSDe5C9qtdq9ZGiIu+NetgSFy1g+OK7
         CR/0F0U1I618twMZA4OLSxE+sFQV4dPrZ65WjqMSSIsaL5YC8cnp+gvdJO1E7fxWxHN8
         MwxUqMlwr3zMIpDKx1WB0VPcGyxkCUGNclsZzYC0jNFCBGMaIZuleFB02GuQnHuCCO2q
         bLhg==
X-Forwarded-Encrypted: i=1; AHgh+Rr6V3POkFSoneAfZOlIW2zN92QIVQFik5JxlVkGnPVQi/hioF7ze8Zb+NZS5EK0UqJcFeA0EDS+Oz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEXlKbZCSF1sI2MFm26/FdJD+mkgBKR5k6ZeanUDmuPOCetR3Y
	UTDMKxflkh68apADKrpOZ1zKdPDPEb9DipRswYsAOtaweowGMcIPGoPM
X-Gm-Gg: AfdE7cnHm9Q4rDRcTc0F1E3sV+9exrIh8rmJ/HL2QE3Jsejg853qw8K2RnmVNOJFT6L
	L6pctkl4GHAAy1pR2TYMSalNJka0S/wKhfriAw0F+fhLHyWUE+4UORZLUQvgHDZ10HKifmI86sI
	MzaIZqI/p4A3nVr2PclapiHZ2kxJeG29U4nU1bFm4RiKlWIB1f+yweB8k6jD2sK1IaSbhBA8fsl
	ETWJH5lbYUChVvuN9wBHKULC0o0BnPnijfcO6Jkr26stFG5GXPGQ2+EPUXL0QB498uc9s0rZ69U
	H6Wt5PGx8UZn3ReTmN3EsbdGjJtvi4JlgbqZhtIXqzsxlv3T3VuJSDDy3EcxDnNQgR8IkMb6ctg
	zB4vIH8N/mdm91IkAVPnaE6DJTKLFqf3GdcHGjymV0Q5G3R0q1GAdGFbaA5y+gQzt8gWqygRUsd
	3KloVKY+p1YmadfUCZW6JwRQgV9I+ARrwdpc1/7MfKnGnbA7nWA+xRmw==
X-Received: by 2002:aa7:c68e:0:b0:698:ff3:85ea with SMTP id 4fb4d7f45d1cf-698c104c5f8mr1030271a12.5.1783072898947;
        Fri, 03 Jul 2026 03:01:38 -0700 (PDT)
Received: from ?IPV6:2a00:1e:db84:b301:ed61:1b51:c39f:49c? ([2a00:1e:db84:b301:ed61:1b51:c39f:49c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-698ad118f43sm2162762a12.25.2026.07.03.03.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 03:01:37 -0700 (PDT)
Message-ID: <3e094744-8603-443e-8027-8fc2f2817879@gmail.com>
Date: Fri, 3 Jul 2026 12:01:35 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] dt-bindings: iio: dac: Add AD5529R
To: Jonathan Cameron <jic23@kernel.org>,
 Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-spi@vger.kernel.org
References: <20260701-ad5529r-driver-v5-0-ed087900e642@analog.com>
 <20260701-ad5529r-driver-v5-2-ed087900e642@analog.com>
 <20260701194103.45541cbe@jic23-huawei>
Content-Language: en-US
From: Janani Sunil <jan.sun97@gmail.com>
In-Reply-To: <20260701194103.45541cbe@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/1/26 20:41, Jonathan Cameron wrote:
> On Wed, 1 Jul 2026 08:40:40 +0200
> Janani Sunil <janani.sunil@analog.com> wrote:
>
>
>> +      adi,output-range-microvolt:
>> +        description: |
>> +          Output voltage range for this channel as [min, max] in microvolts.
>> +          If not specified, defaults to 0V to 5V range.
> No way to specify the default as part of the binding rather than a comment?
> I haven't checked but does
>         default: [0 5000000]
> not work?

Tried that approach. But the dt binding check does not accept default for this DT cell-array property.

