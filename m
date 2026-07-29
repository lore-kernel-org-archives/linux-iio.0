Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246453438A2;
	Wed, 29 Jul 2026 23:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785366819; cv=none; b=hIuc37RScUSUZQWumfD6wYNGXFhe4gO6HjtcRGroEkem8VsXXjy3IsSTJ8Bm8VuBLDRGrRH+W8yhrJfNFEMkpnEK717StI1PJ1iVfqD7870fbLw6VF9sTFwCM0/dGwFz4Out3zD9d5xCeAiz0J1c4lEIb14YZh1bOb172Qy++Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785366819; c=relaxed/simple;
	bh=ocuYngM8M2XDcbnhog3pMUW2299D4F4nKD91c+wsTkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dnGvY3FiELrMT0gUE6kDD0HO/IHvmc/w4gE+Whr3lrl4H0sDKINFz4iJ5S9uYPne6eQ5yHQb1xdOsGO68+AqfxFoWn/oRhCW6r+DoTcbHseb7Uo3IvdmR7By9TiXzOVXWNT7UCy82UH5o6puiixeAfMQ+8JCHr36WihVE3REzVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNio5Y03; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNio5Y03"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153D71F000E9;
	Wed, 29 Jul 2026 23:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785366817;
	bh=o9Svtv5xJgiEssnTFNDznw1qw14m87xNi/ervmSa4Ig=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bNio5Y033V0Vie0ZdYUZuAymrfsWpj5fpHgNbirTdCY3zPksNQg0zMqHKVhtCkJ1I
	 Vgtyzr4XM2m0nVkvXB0qopqmtKc4cHrZBhTyiw3WPsC60BG2Xdo+nGwXKHczyizH57
	 bA1Eyox/z7C2eg1e1cO7GY7HNuggj1wRm/sNJvRYmIEegCJ5oGgNM8zkvCu127mHWc
	 X05sPjCwRGzuehsIE2Yz+WctQcg2FqdhxuTTusyz/KDfxV+3dJ2Ferg7+k9yRgUoEJ
	 BIRl/nRR0K9sE/SDkJa1fDw9IcW7YRX4AKtSXhuZ4htVJ+sebKgXDKlprkUs5A8cSE
	 Q5Pr4I9RCn1DQ==
Date: Thu, 30 Jul 2026 00:13:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: <ehristev@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
 <andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
 <alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
 <srini@kernel.org>, <marcelo.schmitt@analog.com>, <radu.sabau@analog.com>,
 <Jonathan.Santos@analog.com>, <jorge.marques@analog.com>,
 <joshua.crofts1@gmail.com>, <jishnu.prakash@oss.qualcomm.com>,
 <antoniu.miclaus@analog.com>, <mazziesaccount@gmail.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 01/16] dt-bindings: iio: adc: at91-sama5d2: document
 sama7d65
Message-ID: <20260730001333.7d094acc@jic23-huawei>
In-Reply-To: <20260727122633.117435-2-varshini.rajendran@microchip.com>
References: <20260727122633.117435-1-varshini.rajendran@microchip.com>
	<20260727122633.117435-2-varshini.rajendran@microchip.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jul 2026 17:56:18 +0530
Varshini Rajendran <varshini.rajendran@microchip.com> wrote:

> Add dt-binding documentation for sama7d65 ADC.
> 
> sama7d65 requires an individual compatible to address the differences
> from its predecessor sama7g5. The main difference is the temperature
> calibration layout and its handling.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Trivial but prefer alphabetical order if you are respinning for other reasons.

> ---
>  Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml b/Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml
> index 4817b840977a..e8a65fdcd018 100644
> --- a/Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml
> @@ -15,6 +15,7 @@ properties:
>        - atmel,sama5d2-adc
>        - microchip,sam9x60-adc
>        - microchip,sama7g5-adc
> +      - microchip,sama7d65-adc
>  
>    reg:
>      maxItems: 1

