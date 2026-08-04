Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6F72931E6;
	Tue,  4 Aug 2026 06:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785825831; cv=none; b=M6lnaCsNY9thTOYtCJRyBVfixBcFTS32ElI3GZTJ8l2eu5zOg3RoBaokUQJy/PjOdICo7nL4SxtbqQDupR5TaPn6U5MMQTfXMHRw7ypyhB9TiF6V3PWpJrzCRg3xCFPpJRFAqFZu5tF563db3zd7AetMGxxM6tEtIAjh6fVDtuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785825831; c=relaxed/simple;
	bh=o86kDL/eQOkMYirE0085aVzDejlnByCKVgBoA9NlkDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZlHh54M5u1chI9AhxfQdSigBjQd3hZnq4gfyW3z/v93P7oCWqbpR/odtcSgAvq8UNbPSNAjpalkzs6pS76tlox8wyyZ8/NCIFxj5EfQe6b6pFhfF04TVgnt9JKwVmPQy4B347aC2msANSu42RLp4jED/q2IhaXEMk0bSS2ZRDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYIYGpvS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYIYGpvS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DE91F00A3A;
	Tue,  4 Aug 2026 06:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785825829;
	bh=OQhwquqdctjZ1UHfZD2UDugfhU37PYH8dyJNWWrI5/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bYIYGpvSstYe1hvCRHYHOAjfLF8chI638oZO82gQdzx0vjdEWbGCeysginQRzE/hh
	 qwnDeefM2nQ3LI7+uYzVgYer/WcUEClIBXiv60mcWgzxRo1D6LZtnHwLv6Za/Z1d9Q
	 1LX+nBEksm0pXd/rYMqRy7gB+AS/CgantxY//GQXm/RqGdtPGs1Avt/RNlFAqUWpPG
	 55fhN+DYdIWh9mi919lsGfAt/Hea6yodjZcW6NttZGhgZGD/FWzM5YCGLaWoTL2Az9
	 3eVoALIfFzlqXM43IhgD8+O8VJ5nsfh6s1uKO2QMhvRN8sm8anRu6bVs7mwNmh3GoO
	 XYkisHK7ASf3A==
Date: Tue, 4 Aug 2026 08:43:45 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: jonathan.cameron@oss.qualcomm.com, krzk+dt@kernel.org, robh@kernel.org, 
	conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	maxwell@maxwelld.cc, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, marcelo.schmitt1@gmail.com, 455.rodrigo.alencar@gmail.com
Subject: Re: [PATCH v6 2/4] dt-bindings: iio: flow: add Sensirion SLF3S
 liquid flow sensor
Message-ID: <20260804-dashing-walrus-of-sunshine-ee0a4a@quoll>
References: <20260728214943.29820-1-wafgo01@gmail.com>
 <20260728214943.29820-3-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260728214943.29820-3-wafgo01@gmail.com>

On Tue, Jul 28, 2026 at 11:49:41PM +0200, Wadim Mueller wrote:
> Document the bindings for the Sensirion SLF3S family of digital
> liquid-flow sensors on I2C.  The family currently covers the
> SLF3S-0600F, SLF3S-1300F and SLF3S-4000B variants.
> 
> All variants share the same register map and differ only in the flow
> scale factor and the calibrated measurement range, which the driver
> reads back from the product-information register.  Since that lookup
> is needed in any case, a fallback compatible would buy nothing, so
> each variant gets its own compatible without a fallback.  A future
> drop-in compatible part can then claim one of these compatibles and
> work on kernels that do not know its product ID yet.
> 
> The active calibration medium (water / IPA) is runtime-switchable
> via the in_volumeflow_medium sysfs attribute and therefore not a
> DT property.
> 
> Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
> ---
>  .../bindings/iio/flow/sensirion,slf3s.yaml    | 55 +++++++++++++++++++
>  MAINTAINERS                                   |  7 +++
>  2 files changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

