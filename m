Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B703AC0C9;
	Fri, 22 May 2026 12:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779453162; cv=none; b=s5+0njsUU53YMe+YsWIDBlO3d4/kZGPJs2/9pGQk9Q1plELZhH7uTcM590NJZjqemTJ0/Z9A6oiVIypH5h6c7GKT+J+BzAeJFpC1tkr2Yzl4Z13zo9CsfrkS2IMkksGBCd+sKSR8gdd01T5+zGXtDKNpIZ8fJfMC3duIDtj0R60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779453162; c=relaxed/simple;
	bh=L6q0+2eMQT/J1fAvSpt/IXZM9oQaVYRG9oRc/PkbK4k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tvc8MMZM4jMBKY4fpYLHjLTyweOLuEugtVN1hQQkTdPrTzc2Z51HP16prqcDDhnY1td0iv8//MK0JfyZVRgdw1I3tJxTCc3y8k9+FzZggg+bQFOxVox9umQYwtdNaeN9BC3mRVBevLxZ4Oiznk2Zea8udNzXWE4CecqXc1hQi7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfNVRePZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfNVRePZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1BB1F000E9;
	Fri, 22 May 2026 12:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779453157;
	bh=Jv9zg2MJVo/D2S5hcq2FejETLMicgAaFVojMA8Hi8v8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FfNVRePZN8D57R7xD1/qPeTks9WcWRCS09tt2QEobG2MCEcF/a891O1YhWOVyqjsC
	 hjk0tI/Gh9V9S2/t/MGsejyGXVqxnsmHzOj7EzV7mk9a4ry21hKGVLcjk/NPKzGQWL
	 aDPtrdKbIXvFuo3Ut81i8nKAUNMLZ386uurZ8Qnp/3lyZAuu9EdUjmz9VNRhjoRjlE
	 tOzP5fwFXQxD1pMT0NJLb7GsuqN9t1RAvl7yCthGSZVoKunyo+okFBrwcE0Jf3u0H+
	 XL2wA8gaYcmqGMQrtoKvUsQbekO3/7kG5sLl+TvXhxkNBl6tQTWPrOpEjlZCbbdVIv
	 Fc4lXwV7HDUgA==
Date: Fri, 22 May 2026 13:32:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, <linux@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: ad4080: add AD4884 support
Message-ID: <20260522133228.06521c5d@jic23-huawei>
In-Reply-To: <20260522115337.18188-2-antoniu.miclaus@analog.com>
References: <20260522115337.18188-1-antoniu.miclaus@analog.com>
	<20260522115337.18188-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 May 2026 14:53:36 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add AD4884 compatible string to the AD4080 devicetree binding.
> 
> The AD4884 is a dual-channel, 16-bit, 40 MSPS SAR ADC, sharing the same
> register map and interface as the AD4080 family. Like the AD4880, it
> requires two SPI chip selects and two io-backends for its independent
> ADC channels.

I don't see anything in here to say how it is different in a fashion
that doesn't allow a fall back compatible to the ad4880. Probably just
needs a statement about the resolution being different. 

> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
> index 9c6a56c7c8ef..4a3f7d3e05c3 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
> @@ -39,6 +39,7 @@ properties:
>        - adi,ad4087
>        - adi,ad4088
>        - adi,ad4880
> +      - adi,ad4884
>  
>    reg:
>      minItems: 1
> @@ -99,7 +100,9 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            const: adi,ad4880
> +            enum:
> +              - adi,ad4880
> +              - adi,ad4884
>      then:
>        properties:
>          reg:

