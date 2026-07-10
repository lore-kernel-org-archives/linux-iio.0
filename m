Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5FB404BDD
	for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 23:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783725132; cv=none; b=ifmWBoGe67eb8MVZnlj6L4Ht21fh8Zp9bx6KBUH9k3g+0uraLQYMgCTTZe7bNY8MVsd00N1SR4rzK06cJ5un82OwuGPFxR+GLkiyOGY12a4okU8oCRE0xrUExVpCqrawIc/HM9nPyRHYzTk1a1HaDipJusSB2c0aUt7sOVdDmP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783725132; c=relaxed/simple;
	bh=WolUqNqLG8wcbpxo1euYF2zvMyMZNYCNCWIwYPG4YAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r4wnyrVZghDUsQ8Gc3UYNff3M94eW4v53F/9Gm/FXF4NlfGUszWHyl6cro3Gswz0ihJdh4jZQWDOUP5NMzryaOuqWJmxP2A7ukOk8k7YfR6FYYbO6cixC58/OMvkgeqyY8Ii0IxDFKb1Yh/tmCFy4Oux0TGW4oqcvlzyZ6wmjBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=paLba9Ga; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="paLba9Ga"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6a378a2cfdfso979640eaf.0
        for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 16:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783725129; x=1784329929; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=orAXM50ok0dlT4J0LLGqek12i5V341QLmN68gXTBWUg=;
        b=paLba9GaMx2aJNEVWo8/61lzZuD+9h6A3fbJwZEZBoGXmVTSjIVpxWYOTxqmuJQuVz
         B7pR4Zdc63hgPdmEO7dAe/LC1geVOATe05OApro4NvcqCTCeVeEey44UQBS3WDrQ18Dn
         g2vpdrL4cNYM6pSg4jQ1QFjrd9bSX3HAjJwE+IwTtdvAstGXu4F4M8VU+KDQh1U9rVRw
         BG+a36v/CSRkQ9ZmQy0WZhOqiEDWBv3xzeQQAjf9mlv6JjB9/FB44R5H6/QUhSiNvWWQ
         edCLTDDDjDXtrX/G18AtpTiYnNjKC8V4GWiOH3KLItG3flWdnxl4icbAlCzHyrEW7KBh
         hJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783725129; x=1784329929;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=orAXM50ok0dlT4J0LLGqek12i5V341QLmN68gXTBWUg=;
        b=S1aPqRuCmb2eKI8WNUf9/N8RA8gg3Unpi8M8xBpr9rKJLP72dnefKfIsposltLBp/s
         8e/30lSnKlgDm1rVdvgc7A8GHn3HfyfsgekXncJfVDNi7k54LB+MUqnvWxHcqO6qd9w1
         SzWJKxBWqj53zo0dZfEpdj0J5/JNrNA3kBTOjnh5nI5Zvt7b+zTu/SiTAbRBaTbAcexm
         NUr2BOn7mbNVb51VeRov77X9DgFTPDZ73/JGkSSDGtKyFiKwWcotrWl9Nvvj56AC9hJj
         d1Jtg4O7WhN3mXj3Lhr9v6DlCExQeN7lY1J1MwZM0HOOa9TspCJ99t04hDFLumrWd7jp
         +Ycg==
X-Forwarded-Encrypted: i=1; AFNElJ8Z7CkcGyDbnfCWEfGfrK5hsJBi11pTdPKAuIiZUqhlKiuzcWayKd/V2igsZWs3nPs7bgNVO9Oy7ps=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeEmbfzSMhp0G3c/8tmM2/ZZM8h5DrIowscVvckmrHjm8nWZdl
	cFXsfKEAepnCzpcU6Pl5OTPn24Hxa3Phj1GwyprTVyLaylMKpbClkKMqo13/W+g6W6Q=
X-Gm-Gg: AfdE7ck38atqIswUMd94lUg4n0vUbS1xRY2o7MrreBmoCsa+0OLxrufhLTf+NeTqc3w
	y6y66t4930h9gt5oehbwRRdh+GvhHZvzuyT981ZK8zO2owv4kfUNorEziTolwSi/+xeWkSqK7V4
	ouPyuWRyf6cVc9vDk8THgIdR1ng5DR2vKkhZP/QxC64L5PbDwgJ6G270PXxy0DXxnjSKJzDSJgR
	4mWAQv08sy1p7PjPZgCs5+7IWq2etnEIAXbb1KE0uPMouA2BGFc/PwyAHDtTNFnJIS1Yhn7d/r/
	zoId1XZ/LFN5ciuFEmFA0seLBzhcD7MaA1ZzHIfGIKDJmuHzf0lnONallDevOmyZ1pZehin5VXs
	NfDKH1wbyhPshOWxIvY7V2cIiOtP0Ski0fTqQP+oqItl4hijBC/yjCPGIaK/fW2hnjq40Hsmz2p
	yQVl9s/YaUA/gOdwU58lyj+7b5QBVr93xNzUEU8NJf5qqNZ4wLBW0l5bp1JLS9e1DCXoNRgdY=
X-Received: by 2002:a05:6820:178c:b0:6a1:41ae:1bd3 with SMTP id 006d021491bc7-6a39a6b62d2mr734605eaf.42.1783725129440;
        Fri, 10 Jul 2026 16:12:09 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:1b03:95c:fbd4:4d00? ([2600:8803:e7e4:500:1b03:95c:fbd4:4d00])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4519124d07dsm6322280fac.2.2026.07.10.16.12.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 16:12:08 -0700 (PDT)
Message-ID: <f1c5be4b-6bbd-41d9-a152-ee480988f44d@baylibre.com>
Date: Fri, 10 Jul 2026 18:12:07 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] dt-bindings: iio: adc: add ti,ads122c14
To: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, sashiko-reviews@lists.linux.dev
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>,
 Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260710-iio-adc-ti-ads122c14-v3-0-746d52cbf1d0@baylibre.com>
 <20260710-iio-adc-ti-ads122c14-v3-5-746d52cbf1d0@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260710-iio-adc-ti-ads122c14-v3-5-746d52cbf1d0@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Replying to https://sashiko.dev/#/patchset/20260710-iio-adc-ti-ads122c14-v3-0-746d52cbf1d0@baylibre.com?part=5

On 7/10/26 5:50 PM, David Lechner (TI) wrote:
> Add new bindings for ti,ads122c14 and similar devices.
> 
> This is an ADC that is primarily intended for use with temperature
> sensors. There are a few unusual properties because of this. In
> particular, the reference voltage source and current output requirements
> can be different for each measurement, so these are included in the
> channel bindings.
> 
> The REFP/REFN reference voltage is usually just connected to a resistor
> that is being driven by the ADC's current outputs, so there is special
> property for this case rather than requiring a regulator to be defined
> to represent that.
> 

> ti,vref-source is reused from ti,tlv320adcx140.yaml (otherwise might
> have preferred an enum of strings).

This paragraph is leftover from v1 and should be deleted. (If someone
called it out in v2, I missed it.)


> +
> +  interrupts:
> +    minItems: 1
> +    items:
> +      - description: FAULT interrupt (GPIO2 pin)
> +      - description: DRDY interrupt (GPIO3 pin)
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      enum: [fault, drdy]

I know the descriptions are a inconsistent with allowing names to
be in any order. I don't really know a better way to write that
though that allows both

	interrupts = <0>;
	interrupt-names = "fault";

and 

	interrupts = <0>;
	interrupt-names = "drdy";

They are just descriptions, so does it really matter?

> +
> +  gpio-controller: true
> +  '#gpio-cells':
> +    const: 2
> +

No, gpio-conroller should not be required. It is rare to use the GPIOs on
this chip and the pins are shared with other functions.

