Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2BA38DC4C;
	Tue, 29 Sep 2026 07:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790667485; cv=none; b=EwicjcDHoxupWWIzd4YDiiwqY2ZvWacAYdc6vlPR8FhgSYsKGFb5ulBziyGJLHTOXMjvD5PgJ3xtHnV89iiKqmZc7nodT1N21WH8B2JoyBsFDPuOHtBKZDiGsGRHiLQrKYV0sB+SiQBI+74MBX43y3BnnoITSPWYz3g5jGsTaYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790667485; c=relaxed/simple;
	bh=XNt2tdvBamn3hwmJfP2ky4nu8Rx+vcRTAT6cuA3Wkiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aka0zcmY/kvl+mk37y9hgI0MU5ZcrxTtMAKbcHcjmzPbb3bnujG8y9X9JZIMIzDMrAPvga8C/FA5rQinjYZaqeQ4kDet2Le6rcVR8+5OP0DQeRKjhL80riHVvq1nGuEGW5uBsxJz42W5MmRmUyc8o3w7symZ7o40gFWaEhZn0TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHfdWgy9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHfdWgy9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9D71F000FF;
	Tue, 29 Sep 2026 07:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790667483;
	bh=5HnRXrs+e0AqpzRjn+shTqMWuU/hbBqeJRuBsbkIwvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RHfdWgy9V70spBOBQLciFeRoTZR9mSynic53Gs97IFN2mcJTdQm5xttXW0no6V2dR
	 V6X2bZlJD8oWgoJ1ClbEyrdx0XI2YxjWzFQsEK2XB55jHkzpqXJxwxGuMVAIZT7adF
	 nsTvc0M/ih2RhSY071/EIKRbtrS9vvXtmNw2fC0ZbiSpUXTFU30TqzcSsf4IZkphsL
	 +AVHmqAzOsvx1tFuZynCe2EzuayQwkAlfaTi35tyrRpZAI77Ga6Blyw6hY/LrzaR/l
	 uKoR7xex+/bI8pb7jl18w2BA5gQsLjF2hwwjvLQ7iFJiZvSMRVPW6MGSWb9V8T6Hvm
	 aH7ScS55FNtaQ==
Date: Tue, 29 Sep 2026 09:37:59 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: add: document the MAX34417
 Four-Channel High Dynamic Range Power Accumulator
Message-ID: <20260929-heavy-intelligent-guillemot-da269b@quoll>
References: <20260924-topic-sm8x50-iio-max34417-adc-v2-0-9a0609e72f5c@linaro.org>
 <20260924-topic-sm8x50-iio-max34417-adc-v2-1-9a0609e72f5c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260924-topic-sm8x50-iio-max34417-adc-v2-1-9a0609e72f5c@linaro.org>

On Thu, Sep 24, 2026 at 03:14:15PM +0200, Neil Armstrong wrote:
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        sensor@10 {
> +              compatible = "maxim,max34417";
> +              reg = <0x10>;
> +
> +              #address-cells = <1>;
> +              #size-cells = <0>;
> +
> +              channel@0 {
> +                  reg = <0>;
> +                  label = "ch0";
> +                  shunt-resistor-micro-ohms = <5000>;
> +              };
> +
> +              channel@1 {
> +                  reg = <1>;
> +                  label = "ch1";
> +             };

Run 'scripts/dtc/dt-check-style --mode strict' on the code

> +
> +              channel@2 {
> +                  reg = <2>;
> +             };
> +        };
> +    };
> 
> -- 
> 2.34.1
> 
