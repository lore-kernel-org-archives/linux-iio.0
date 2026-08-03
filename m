Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C1B39E194;
	Mon,  3 Aug 2026 07:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785741105; cv=none; b=OLA1kw1SxqoBMl/P9DKPWFqTOjbexlrd/K4DK/SL8YHJsMpMdrC+PEl1UObP7zY97WM0yIMVWcj/fBl3RSRyMuWmfPSjsSusGbo7MGCBEqh8ID6sx0zhy5709ncgViJ8d0ltdLR8Sn6KqqFu1pA1O35X+DcixtP96qquWwk7n+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785741105; c=relaxed/simple;
	bh=9KPdVFpBtdGJCq2AUa4i/+erg0hr5NahK3GxbSMMriI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbQOJxLkoTobzaK0Nk6Qc7/YAS46k6Lye5BIjl+A9fvIqxXE7ZWcDw/B0fhAtFZ/WISqOIgUUTT5dzEB+94GtXyouzvNFr1cedtenMkKM/+UW3HfxYeSmIhL4anMjI3XLinUi975r7QACWFsYAYSZo47GRK1AQFzhk7u9BJZvTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+lYewYO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+lYewYO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A13D1F00A3E;
	Mon,  3 Aug 2026 07:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785741104;
	bh=0E8FGeYyjvlJUb6BQlVYyq0Swb3VCsPDTFfPjL4w8bI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j+lYewYOZHPhzaR5Yy3GpSJfJ0FML3s9cA8hZ9/IAR9WoPJKSs7E3uexH54PlhYgn
	 lUe4pdDqwAVGDDid+d6AxoyvSdILNpJwW36et4hIdAlLEHZ+1rCLcEj3ygEK8ZboEr
	 js8m7odWK36pttD37X8aPgbK2Kmx3uitXjscsq4ApQxyYeogruJxW6dOyZzmV98XFs
	 Q1LIvt8GLOXhjngXj8dDYC4OxDndfVt8im+8WgOOpuFBOWpnnyhuETrp/EgjNyLVSm
	 /LIQWfsQEV/Iffp0WVQnLEInXKlIdfHHQWav7FcsePSLK0sFFq7hORM3TX2jb41oZs
	 Frl+RZLeLPPYg==
Date: Mon, 3 Aug 2026 09:11:40 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: proximity: add Sharp GP2AP070S
 proximity sensor
Message-ID: <20260803-unstoppable-capybara-of-respect-1bdd4d@quoll>
References: <20260731-gp2ap070s-v3-0-d1f5cecf9fe7@disroot.org>
 <20260731-gp2ap070s-v3-1-d1f5cecf9fe7@disroot.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260731-gp2ap070s-v3-1-d1f5cecf9fe7@disroot.org>

On Fri, Jul 31, 2026 at 01:37:00AM +0530, Kaustabh Chakraborty wrote:
> The GP2AP070S is a proximity sensor designed and manufactured by Sharp
> Corporation. Unlike the other GP2AP* schemas, this is strictly a
> proximity sensor and NOT an ambient light sensor.
> 
> For power supplies, it expects two voltage supplies, one for core and
> other for driving the infrared LED which is used to measure proximity
> distance.

Here you briefly mention resolution of previous discussion, because it is
non obvious and without it, you will get the same question - why vled is
not required?

...

 +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Voltage supply for the internal circuitry
> +
> +  vled-supply:
> +    description: Voltage supply for the IR LED
> +
> +  proximity-near-level: true

No constraints for the values?

Best regards,
Krzysztof

