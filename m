Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794832124;
	b=x7wIEl0hf3OFVRaEfcfYhF9fORQB83/MJCkxPYBW3DyHosX03icvJtuJknrIJ9ZAAxrI
	 8AtO/nbnP4VKqVqcqm3duCF9ZKI/rq8hE5gakBFThMNeqowAdIb0PRMhssW15/LF96bB8
	 vBqBNDTQ+MLyXZrU9h2p+TfJTs/f6Zl3oohdZs/E6I1Httiuf14gKTOrCm/v+4hoTOkJe
	 gZfFxI9T9DQj1hNRAi0w6OBDZ7vMXFeiosgjrhPm55Ls2oddgObnpT4hQiw6BRtuB/83E
	 tTCQFxlPoEXqA5I4zr3/TSD+BWPZRVoBFJTEuVM2U9q4IQVW5GKqSGmnD9iq9+NYIbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794832124;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=fwRQP7cKryYxbdezG2O16iT/PFMqteep/2pksLEIx6k=;
	b=ehQoDEAxEJUUoMmjW4JjXaZWdJMZwd3rLAnlKIHHBN6CwhCGtRBR3w2zpB/7f/lW9FyM
	 Aarov+uUP/MMqHVOhq6pmot5f5BJes6PT6K9F8Ip+Mqfe0qErsk3yT4ofAL/PPRp3qEv2
	 TBW4l2/YysqaXKSOl3xSA/TLbVokPxaqnU5u/WvenTOEgHfkMItXTwCDD9nBtJHrI+C2p
	 vlmFsUj0rsDCuml5hl8LrP/poL+y9jQ4NHc3cIvBVk+8jLWhWXo4TJvug5tRo7Ze+9Sgc
	 ESbfrGtVtPXDwHM1yt7IT2GyHLEvg9ImTa9udRTg3Itt2PvWCQcsnNBzAUIu+M3B8JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eumIoxfG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB28B606A31C;
	Mon, 16 Nov 2026 12:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eumIoxfG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C4C1F000C4;
	Mon, 16 Nov 2026 12:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794832124;
	bh=fwRQP7cKryYxbdezG2O16iT/PFMqteep/2pksLEIx6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eumIoxfG9j9tRNg+4f/KkVH6NgbIRsjvPyTMbBWoo3aIlCKehQ3oka71EQsYUCN8X
	 Gd6iJKrR+lmLNv5+mk1LJUeWqJqeYyn6+SyiA8niqSSB5miWqe9MeScmf/Ac/V7DO6
	 k7rGLxWB8FYUjjTKse/ZK27LzMA/CYKp87lugWoZFc5B60UWy+EYYmlJxGvj3KneVC
	 jqmVg6EVybxMJRVPuP/ievGZf2Ds89oslixPXpxFJ2cf/S6Ip1bSihl0Kb7EOgEcpm
	 QgCuAkNdfDhET6mpepDk34dobf5On8F7tFFwCVIRbmYMkXM6f+ekGcd0kaeDCSuacY
	 B3Gj/vofMJtJw==
Date: Mon, 16 Nov 2026 13:28:38 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Akshat Chandra <notmissinge@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, andy@kernel.org, 
	Lukasz Kulga <lukasz.kulga@gmail.com>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: chemical: Add Sensirion SGP41
 binding
Message-ID: <20261116-eager-loutish-moose-0fdcfb@quoll>
References: <20261115055941.362185-1-notmissinge@gmail.com>
 <20261115055941.362185-2-notmissinge@gmail.com>
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
In-Reply-To: <20261115055941.362185-2-notmissinge@gmail.com>

On Sun, Nov 15, 2026 at 11:29:39AM +0530, Akshat Chandra wrote:
> Add a Device Tree binding for the Sensirion SGP41 VOC and NOx gas
> sensor, including its VDD supply.
> 

Few nits except Sashiko comments:

A nit, subject: drop second/last, redundant "bindings". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree/bindings/submitting-patches.rst#L23

> Signed-off-by: Akshat Chandra <notmissinge@gmail.com>
> ---
>  .../iio/chemical/sensirion,sgp41.yaml         | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,sgp41.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/chemical/sensirion,sgp41.yaml b/Documentation/devicetree/bindings/iio/chemical/sensirion,sgp41.yaml
> new file mode 100644
> index 000000000000..28528a695cf3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/chemical/sensirion,sgp41.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/chemical/sensirion,sgp41.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sensirion SGP41 VOC and NOx gas sensor
> +
> +maintainers:
> +  - Akshat Chandra <notmissinge@gmail.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  Sensirion SGP41 indoor air quality sensor measuring raw VOC and NOx
> +  signals over I2C.
> +
> +properties:
> +  compatible:
> +    const: sensirion,sgp41
> +
> +  reg:
> +    const: 0x59
> +
> +  vdd-supply: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply

Missing blank line.


Best regards,
Krzysztof

