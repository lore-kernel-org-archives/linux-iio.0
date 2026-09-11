Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370D933ADA7;
	Fri, 11 Sep 2026 18:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150146; cv=none; b=boJuqy68/5ocLKJgqWDdJ1nRozvltWzH2il68huZbm/G7guzwmlCJp9gCW1/+6CfYTPBqAO9GBJKAkhsPpfLDGl0PHKIZsdqbhAcrlHEFuoBI4nJXdCsWASmAAQx5XbD+jDziLFcO1a6rbdtWbw2svQCaWkdBLnJZgONUoZwsDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150146; c=relaxed/simple;
	bh=2XsNIwfgB3S1w7wPmJ+uLeAxgnvp5Go0LKbtkyX6pWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JsihWLqvQVUosMY9dmNDHSJ8UQmPTnfRjoXjXfRPqL9xuA/5kng6WsiibKWesuB1hDPAAYjOif8UwVJ+yMkBH6l9JUzXicQ7jbM4rmQPmXL1szqRFKCZoKbD56NJ/Y8+BLw+1Cks3jukg6mKjPEHlVtRBUrgMZ2oJe2gXzkPSr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=TBlPm9NC; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="TBlPm9NC"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 799BE10327B;
	Fri, 11 Sep 2026 20:08:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1789150138;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Owzto5RJpsaGdDWQuvd8vx3DnYx5//26ShytlrfPA+w=;
	b=TBlPm9NCuoQ4uKoJYJuqPB4sCc1c0v60uLv0xCUrF72laLt7/Y0NIUqXimUHGa9CeYwmS4
	eaEzokHM+oJ2En+aTkAtK2qW9UtlVkut7uL1aGWjD18GkBtRKez/izcKMTGkPala4s+lc1
	OYDTYpdLtv8bemIRQP5T3hiIsoumUz12NXH2UdyuVpYDePLpHwMIT9yuIpP6YinKggPa9p
	lGPF1/pscNWrIiZ0r6KwqfKF1JzIdNfz6lluF5siaDTV2DQl7KnA0+pMq9Of902IsT02+A
	uXL7/0evjaaO9qOF+ow0jxNmLGxRgS2LRkeXkRQXY937n1cVciSIS8zLAr+byQ==
Message-ID: <2904b225-e45f-41ee-93ca-794d1b62e1a9@nabladev.com>
Date: Fri, 11 Sep 2026 20:08:52 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] dt-bindings: iio: adc: stm32-adc: add support for
 stm32mp23 and stm32mp25
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Cheick Traore <cheick.traore-ext@st.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>
References: <20260911-adc-stm32mp25-v1-v1-0-cef26eecdef2@foss.st.com>
 <20260911-adc-stm32mp25-v1-v1-1-cef26eecdef2@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260911-adc-stm32mp25-v1-v1-1-cef26eecdef2@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 9/11/26 5:51 PM, Fabrice Gasnier wrote:
> Add stm32mp23 and stm32mp25 compatibles. Three ADCs can be found on
> these SoCs, split into two blocks:
> - ADC12 are tightly coupled (common registers).
> - ADC3 is managed independently.
> Each ADC is a 12-bits successive approximation analog-to-digital converter,
> with up to 20 multiplexed channels that can be configured as single ended
> or differential.
> 
> New property "st,adc-trigger-sel "

No need for space before "

> allow to make the difference between
> the ADCs and to apply the correct trigger configuration.

I think "st,adc-trigger-sel" needs an example in the example bindings below.

> STM32 ADC may be in a power domain: allow a single 'power-domains'.
[...]

> +      st,adc-trigger-sel:
> +        description: Selects the HW trigger configuration available on this ADC
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1]
> +        default: 0

What does 0 and 1 mean ?

[...]
