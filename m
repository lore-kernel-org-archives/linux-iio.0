Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793088289;
	b=MkSs1e62xTlew5lrNHS4Atzn6zuexgKKqujHczhxXG2j9EGeCzrE6eNUjMklIW6ZGVdV
	 fZoTbYMVq3WX1HUmkuNYirEfJkzpsr/LE+s0taI6RI9t1Qc/C0aBIx49oY4h2iO3l7UKf
	 Rw+joEa9LXwVhmKM9nn/ENOkcPQbIZemlkPWDt8tohS1fEdN0iWThjd4EnyPAXXRMOFL7
	 N59wG2QfyC9w5XVwXaHvkko+UUUFvkw9Emj5Xrb9td6PW7XYj7IuPOdXl4+z+4JOftIz8
	 2XLQD1t7GofywxYFOKSiSfyFRtEznpZ9xFgstzFLqkXqniNZeABIGIGg0JldAh7jvBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793088289;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ZL1gpW7p4ard24lSO9/+2V0/hqF98a+IvwOAZv1vj7A=;
	b=QrjDuEwLXEYlyuSGQGD+Z/C0CDFGeZO7oHF1qofXiPe1ZzbhJbHygjBkVv842XSmbpVu
	 wc6dE4rTXURKhX+6GR1KqcE4oS1pEuBuUM3TzNcdGgcT9P0aj6zbWxLER2Bb6oGNPoPhH
	 FSPFw8XJb+Rda9nXAiDrAX06PjTKkCw9mKUBeoVxmJpsqoMbSnd3HBJwmec+iwiqTBiNU
	 01bgWr38CO2aMdZKj4GxvKOMKHaypwOeqptXvXG54kdsvkiJnYLfSTbpP7jRTMVM27IjO
	 2x3DV3Yyj02QI7R8T2nH5c6fFqJz3za72/CORAA6B2whPMGkC1JuNKn3XQKljmAT87Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kOFIK9R3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944AA606A31D;
	Tue, 27 Oct 2026 08:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kOFIK9R3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E761F031E2;
	Tue, 27 Oct 2026 08:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793088289;
	bh=ZL1gpW7p4ard24lSO9/+2V0/hqF98a+IvwOAZv1vj7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kOFIK9R30fCpE+kzywtFEXksr4BIrnOkyAqNjGnji/boXE+SHiUCokPAb0BYrOfaE
	 3Ij2CbhXsxbCf7Xduo0Kimt9MtZRokiJYe6R1D4ib9sadBZk4Ja2FHFKBqlEEWxrB+
	 SATNGY2WB8GUKMR2SBxC0areS6/Zdha/vir4HXyjZ+TtByRtUbJCLd7BGk+8DA+J+o
	 otee2mf26zka3gFjg0OMVd7itagJs0B0Lc+vgX+NWjc7RRW4S2gKInisCiInE1kbN4
	 iHxROV2v+Qa8Fl8K95pih6+jxxvX6n8tbKuHlUkBmYabIxRzFtJDlbyZeh90w/S70/
	 PNpA6Rgz4cbLg==
Date: Tue, 27 Oct 2026 09:04:45 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Stephan Costa Barros <stephanbrrs8@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mike Looijmans <mike.looijmans@topic.nl>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] dt-bindings: iio: adc: ti,ads1298: add ADS1299
Message-ID: <20261027-slick-rhino-of-vastness-5cfe0c@quoll>
References: <20261024231335.280955-1-stephanbrrs8@gmail.com>
 <20261024231335.280955-6-stephanbrrs8@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261024231335.280955-6-stephanbrrs8@gmail.com>

On Sat, Oct 24, 2026 at 08:13:34PM -0300, Stephan Costa Barros wrote:
> The ADS1299 is an 8-channel, 24-bit biopotential ADC for EEG with the
> register map of the ADS129x. It differs in its gains, data rates and
> ID layout, and has a fixed 4.5 V internal reference. The ADS1299-4 and
> ADS1299-6 are the same part with four and six channels.
> 
> TI sells the 8-channel part as plain ADS1299, so ti,ads1299 names it,
> and it is the fallback for ti,ads1299-4 and ti,ads1299-6: the channel
> count can be read from the ID register. The ADS1299 is not compatible
> with the ADS1298, so ti,ads1298 is not a fallback for it.
> 
> In the same way, give each ADS129x part a compatible, with ti,ads1298 as
> the fallback: the ID register tells the parts apart, by family and
> channel count. ti,ads1298 alone remains valid, so existing device trees
> are not affected.
> 
> Both families have a digital supply, DVDD, and an active-low power-down
> pin, PWDN, which the binding did not describe. Add them, both optional.
> 
> Add myself as a maintainer of the binding, next to Mike.
> 
> Signed-off-by: Stephan Costa Barros <stephanbrrs8@gmail.com>
> ---
>  .../bindings/iio/adc/ti,ads1298.yaml          | 41 +++++++++++++++----
>  1 file changed, 34 insertions(+), 7 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

