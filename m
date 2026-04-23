Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F274363C4B;
	Thu, 23 Apr 2026 08:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776931536; cv=none; b=JeXtTDGNuavcBB+iwbRRo9kHixFoLPdDYtqi7vqB9rFj7HFhPHOUeCqzhNs9N6GsQfnkLCGkV01qpKTdBqKDNKJC80ooR2QIkhr0NOo4EoGrm34Xk2afiqhNAVeYqKsS34vq0bgNPO09cfgjxtL3eD9LUSaTwqFUSDUa31gA1rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776931536; c=relaxed/simple;
	bh=7rkkN+VqoLd6RHME3M+2tu7KACqyhFTH9C25nKv/qv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uh3v+70AKoGPEPiWl5hOThA1SDNPJvtOdS4A5Q+6/h5WA8jFsDjz0wQfLm3oeYybOr5S2sG9YoutMvjtmY1YZfov7IJMQ3tJm2Ih2yk6yrIg43rBvk6W7ZbCkIzZP5cNCChkNAyVqG1Esif+ntBh+2U+TzN8fAuHJDQuOzZw7gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDWEgaAu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDWEgaAu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9270DC2BCAF;
	Thu, 23 Apr 2026 08:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776931535;
	bh=7rkkN+VqoLd6RHME3M+2tu7KACqyhFTH9C25nKv/qv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VDWEgaAugasr928sOcH0MeVZh3XUuwkwej9OTlDlRp1z9qrQ16xeEQPcYN1GPW+ul
	 Q05iGcmitgHrFd5N/UMojvY4AR0rDDzfCMXxV8IkxoBoLJvKyEfvic4Gc/U3+PP4pX
	 F5tYf6KpoQbGo7PZjsxf8MY5P7MBCBYOrjOPcZEL3FxCltMLYBep4SJ3EzCjjHRvgL
	 NfC/dQjxZtWKFHdEQoH3a4Mpc3f1Qmp/LT1M+bIgwcr83gDMlLRdthj5txZj9YeFIN
	 EzBtno/7/TSqqFesrHbIquHZ+f3Wf6Z2XFM9AEyAEFX7hMaHyiiAZ89+XVCSqJ7O1b
	 1tZxiJcEjaGpQ==
Date: Thu, 23 Apr 2026 10:05:32 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Andreas Klinger <ak@it-klinger.de>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: adc: avia-hx711: add
 avia,hx710b compatible
Message-ID: <20260423-famous-tody-of-opposition-73c8af@quoll>
References: <20260422175910.1258579-1-piyushpatle228@gmail.com>
 <20260422175910.1258579-2-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260422175910.1258579-2-piyushpatle228@gmail.com>

On Wed, Apr 22, 2026 at 11:29:08PM +0530, Piyush Patle wrote:
> The HX710B shares the same two-wire interface as the HX711 but differs
> in its channel and gain model: gain is fixed at 128 and the number of
> trailing PD_SCK pulses selects the input channel rather than the gain.
> 
> Add avia,hx710b to the compatible enum. Document the chip differences
> in the description and add chip-specific supply properties (dvdd-supply,
> vsup-supply) for the HX711, a rate-gpios property for the HX711 RATE
> pin, and an allOf constraint that forbids HX711-only properties on
> HX710B nodes. Clarify the clock-frequency description to reflect its
> actual purpose: controlling the SCK bit-bang timing.
> 
> Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
> ---
> Changes in v3:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

