Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019606;
	b=PYy2XxY6boeWcrtybS6tzbZGQ4DZieeH3+U4yyPIJSRzjByl570UREQifWFwUw5gN5xW
	 V0q2tn3fHSRNE0N4H6LBUA36xZfMWSVhF5zDbMjKOxzggENGkHqp9BoAOswMnLOsrZE4O
	 unGuRDdGbww5r0lQz5MYiPaUzWonJlplVnOr5FwAqrmrSZ4An5xnJuxKyU2oOBWz7aLLy
	 5OCaKyH5UxEo2irAHV+heZ72fPHhYWY/+mijdFa3a+4r5sECiJLPM85F89ePLUR2u3hq0
	 R2Vi/w2vfA202aRO6YFep3ehGFQQETmdwQjwFusTz3pYBvPyMThkh/v9sBS3HgQZEbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019606;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=TPQ4r972gb6bSnqkwDpeMVJfD/XRQzGlY4Q97PPUyYo=;
	b=Wud73vb3rqJlEjAgR6k3xxHgFDd7YemAjS0CbMVNg9kwHGQyIERZHzmQSPi1AQ0mOUzs
	 lu/88SbqRtYyFc5JpZi346qQ1y34sS88yWAV2eBGPP/TDQPxM1D0hgGk8bE9hv6bwCRVU
	 DIndbQoudy1aFWUoX2V3aFwBFyyDiXTjS1B84uKeGBxDNlzLOgezjd2y+oG01dG1SxOZm
	 D0o9+ZslQDTtC3i0nl38fOvdlF2itocPsuv+rmlfKUC7IhRo1MDC6Lij0oDFWl+JvR9FF
	 D/m2dD70go1wTqk+aNrUuUhDW+z5w5Fbm1OXuJBasbNakOr09yiMwleYIYAM5T40vtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HQqV9Ijm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440B0606A331;
	Wed, 18 Nov 2026 16:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HQqV9Ijm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0EAC1F000C5;
	Wed, 18 Nov 2026 16:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795019606;
	bh=TPQ4r972gb6bSnqkwDpeMVJfD/XRQzGlY4Q97PPUyYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HQqV9Ijm/7Ci1l5XNmScFxz0OaYN7HbdfdDKUAQAWJuJiUe61iK7RZye9oXw5PD4J
	 Kn1OhIimTn2qo1bkZptDjQn8zB1qo1Lt4bi+j4aSM5iIlkcvs+G7Rh5zlsL5H3epER
	 pHIwry3MNYnu98eEEcGIWJ/Mm3aqGs7mxUHZVL2HiN8Fk8ilZUUckyqghNrPqPOCst
	 MQGrqei1qFNLW2wMsH8iD855p6J0ce2GBQ3iLfnvs22x3MO37IO6SwbYEpmG3EPCBo
	 b1XEcmMGAYYZU9dOCXbFw1ONbaYMW4cl/k69TsL1Kc8zad7/iSEfWkHJMIZGLsfG9e
	 jktwobo1GteOw==
Date: Wed, 18 Nov 2026 10:33:24 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: krzk+dt@kernel.org, devicetree@vger.kernel.org,
	chernyakin.victor.j@outlook.com, cwweng@nuvoton.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	dlechner@baylibre.com, jic23@kernel.org, nuno.sa@analog.com,
	conor+dt@kernel.org, andy@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 2/3] dt-bindings: iio: adc: Add Nuvoton MA35D1 EADC
Message-ID: <179501960376.2868004.4446551155644027981.robh@kernel.org>
References: <20261117082832.1551574-1-cwweng.linux@gmail.com>
 <20261117082832.1551574-3-cwweng.linux@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117082832.1551574-3-cwweng.linux@gmail.com>


On Tue, 17 Nov 2026 16:28:31 +0800, Chi-Wen Weng wrote:
> From: Chi-Wen Weng <cwweng@nuvoton.com>
> 
> Add a binding for the Enhanced Analog-to-Digital Converter found on
> Nuvoton MA35D1 SoCs.
> 
> The controller provides eight external analog inputs that can be used
> as single-ended inputs or as the four fixed differential pairs 0-4,
> 1-5, 2-6 and 3-7. The VBAT input is internally connected and needs no
> devicetree description.
> 
> Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
> ---
>  .../bindings/iio/adc/nuvoton,ma35d1-eadc.yaml | 174 ++++++++++++++++++
>  1 file changed, 174 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

