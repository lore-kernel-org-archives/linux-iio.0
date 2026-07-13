Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB9517A31C;
	Mon, 13 Jul 2026 01:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783906352; cv=none; b=K21ZHxN4ZfCQqhSqOI8eisy7ei2kVKiCzJSZ/ow7EmS+E1+J+NR/33LBxOV0k3pfxWUrpO0pjwD0wjbYaZ+xWsrhTBwYAeLB1bqm6wT8cm81k7XtBLG3pj3cFqdGGrDGeRP8U6c6LSe1HTJ1FvL3BCLKT3CbP7irbF2wr2TtUnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783906352; c=relaxed/simple;
	bh=oJ7g3j5AEGtu1UMk6/eFfulyMRK/FKTaDPRVShrvMXw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T6qaEIpHhc2Qq3kE74b4kuiBVCtGSwlkODIJGDRECbtY7gVoO/m1Z58lfukoEXrQI8POuyU5MR9iJqYpLAWYEZfKsz/74ncoqUyBzaOa6OTUcQUmg12JY+LnUiBzumHcQk+CNOrl8rXrim9slDPb7tZsb6MO5g6jH2VhiajT5Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAl/AYy/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAl/AYy/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476961F000E9;
	Mon, 13 Jul 2026 01:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783906351;
	bh=DVNXn5yaBap5UN4kztvSGLvr+5yt9D8l6rOYosNqBWA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JAl/AYy/XsbccgRz0gRcO7mTEPqPTQvifOzOcbeMFl7AxmBF4Y1lDlmL+cGffMoce
	 wZsR2lh2QqmxLpwe2M+DPqLS1DA6SLgIJmPhIsPRj8jHlXHoYsRaVzxqOZqPnXGesh
	 we+mkNihEXRNiwBVD08Yjux9v22rP2Ju7q0+h4tv44cRHDC125ElfMk93geq6k28go
	 TAizMIkiX3odKFpYyg7zKIIbOyK3NIA/vL3T6EHPRNKJQ2FizXhAPiAvBtnmb+bHLv
	 QwToHMOOEsh4ASCvGMio2qMeKq739jdx5VixOH31k8pAC4PdRkNqAXHbV0DZH7c+rt
	 o82T70sxhyXeg==
Date: Mon, 13 Jul 2026 02:32:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chris Hall
 <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, Kurt Borja
 <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 2/8] dt-bindings: iio: adc: Add excitation current
 sources properties
Message-ID: <20260713023221.4e1e189e@jic23-huawei>
In-Reply-To: <20260710-iio-adc-ti-ads122c14-v3-2-746d52cbf1d0@baylibre.com>
References: <20260710-iio-adc-ti-ads122c14-v3-0-746d52cbf1d0@baylibre.com>
	<20260710-iio-adc-ti-ads122c14-v3-2-746d52cbf1d0@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jul 2026 17:50:35 -0500
David Lechner <dlechner@baylibre.com> wrote:

> From: Kurt Borja <kuurtb@gmail.com>
> 
> Some ADCs incorporate current sources that provide excitation current to
> resistive temperature devices (RTDs), thermistors, diodes and other
> resistive sensors that require constant current biasing.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
> ---
> v2 changes (compared to Kurt's RFC v2):
> * Make units nanoamps instead of microamps to fit known devices.
> * Drop bit about allowing single value for multiple channels.
> * Add bit about semantics of the array index.
> ---
>  Documentation/devicetree/bindings/iio/adc/adc.yaml | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> index 8f608bf0b24d..a21ed9ae4bab 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> @@ -80,6 +80,26 @@ properties:
>        ADCs usually allow choosing between internal reference sources or a pair
>        of external pins.
>  
> +  excitation-channels:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      Excitation current sources provide current to resistive temperature
> +      devices (RTDs), thermistors, diodes and other resistive sensors that
> +      require constant current biasing.
> +
> +      This array describes the mux configuration of the excitation current
> +      sources.

I wonder if we should have something here to reference what 'channels' means
and that it may reference the same numbers as reg / single-channel / diff-channels.

Bit tricky as I guess maybe it won't always do that. There are devices that use
separate sets of pins for this but still have several sets of those.

Maybe vague is our friend!


> +
> +  excitation-current-nanoamp:
> +    description:
> +      Excitation current sources provide current to resistive temperature
> +      devices (RTDs), thermistors, diodes and other resistive sensors that
> +      require constant current biasing.
> +
> +      This array describes the current configuration of the excitation current
> +      sources. The index in the array corresponds to the same index in the
> +      excitation-channels array.
> +
>  anyOf:
>    - oneOf:
>        - required:
> 

