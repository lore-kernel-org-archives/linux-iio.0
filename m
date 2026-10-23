Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792788858;
	b=dqpYSY9cUw75oCvt4GYkPjgRwXQmxk78YUCjuuEZlPRwCeFHWRVP79OU9Q1gfrx502Kj
	 x63TsaM47APaggY4ndOo3KHKMNA1DG+1F7WECsNresQh0kqGIu7aFvsSxS261zHgezGib
	 DdAjaTX4AEo009wgcUBZeSPzhKYzilyQA/KHg79D2rQ9svJJdPTJliYMiHqRFAZYAsbFU
	 H40tWFuIBGfmMcHWHqUaXc3KUFQ7qZA/5Vg1V5f/9GkBUQ/un6d8uAIXBt8cmVKMILGGq
	 +Bk2/dYQJjr6Hm129YEjaVOgS2dgktHYaFtd67/i0lClltiYTWAfA1QD8tWD22uy49Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792788858;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=qLesKnQX07URRCq8muPN0FoXP5WmoOhi+vy1DntuvlE=;
	b=cGGajdSY0vwzWIDKJDjbCf4vz/RUv3zCLHgCqZK13avQ8+5+jWLOuHCu9j0ZPYsLXO/X
	 E8Ejbk/lO2xbXrFQ/L+dyjrfrjaA+idL6KUosC55FlSNRI9jAZyUnl7LCbuVf+Vkvh/1r
	 B7k0wqgXVi2x9FOBgOUuv0RJX0ZMhz4DfbMUcvp5PYXTaEAue9njjWAbg1KK75mdNIZ99
	 NC9Y5VOrTVvBww7FHKHeMHd5poOqYUPujtdeFspvzyBnfoOf4EueUPGGiXFmAnXN1uXUG
	 bv+SecqenByItALEpV+TuuDqPcasUUCk6fonSq5s3CqmVy/kcXfklXj4nVueCzs0M5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ndJ4xRlQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168D1606A31A;
	Fri, 23 Oct 2026 20:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ndJ4xRlQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3B31F01825;
	Fri, 23 Oct 2026 20:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792788857;
	bh=qLesKnQX07URRCq8muPN0FoXP5WmoOhi+vy1DntuvlE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ndJ4xRlQ2kkWn68/NP5O//oJqTjXVAMw30PvzfkJPW8cdhlKc8pp849PvaYFa1oWv
	 6NrRkSBTDruyN75wfDvTt9R6CSh/Tqu1CHm7dPefPJEqaGdmA0ABRWSPjl0HVHoFH0
	 YZeEbSYlgjIeiIYp6s8C3K8cWnl2nE5uphdcp2PiPyivCsqiY8RFAK1hAMh85++JXo
	 ubPEq3sZm1AOEYevHsKvKfZwj+Wghf6pH0q+UJjN0jkf/MBKzCFahEw0STBk37KaYr
	 jlLQLtlZCSAc6XWZKbWRO5+drl7x9+MVB1DGuI1J50fzF5XZXy5ld1a64ieajK3vlM
	 RSWH8ik1C51KA==
Date: Fri, 23 Oct 2026 21:54:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jesper X Nilsson <jesper.x.nilsson@axis.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Stefan Windfeldt-Prytz"
 <stefan.windfeldt-prytz@axis.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel@axis.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: light: opt4001: add opt4041
Message-ID: <20261023215409.4c4ff7d6@jic23-hlaptop>
In-Reply-To: <20261023-opt4041-v2-1-ee320812804c@axis.com>
References: <20261023-opt4041-v2-0-ee320812804c@axis.com>
	<20261023-opt4041-v2-1-ee320812804c@axis.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Oct 2026 14:30:28 +0200
Jesper X Nilsson <jesper.x.nilsson@axis.com> wrote:

> Add a new compatible for opt4041. The opt4041 is only available in the
> SOT-5X3 package. The device is pin compatible with the opt4001-sot-5x3
> and shares the same properties. The opt4041 has one additional channel
> compared to opt4001, the extra channel has a wide spectral bandwidth
> ranging from 380nm to 1000nm.
> 
> Datasheet: https://www.ti.com/lit/gpn/opt4041
> Signed-off-by: Jesper X Nilsson <jesper.x.nilsson@axis.com>
> ---
>  Documentation/devicetree/bindings/iio/light/ti,opt4001.yaml | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/ti,opt4001.yaml b/Documentation/devicetree/bindings/iio/light/ti,opt4001.yaml
> index 12b0c7ed5d72..35e9b0deb944 100644
> --- a/Documentation/devicetree/bindings/iio/light/ti,opt4001.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/ti,opt4001.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/iio/light/ti,opt4001.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Texas Instruments OPT4001 Ambient Light Sensor
> +title: Texas Instruments OPT4001/OPT4041 Ambient Light Sensor
>  
>  maintainers:
>    - Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
> @@ -13,13 +13,16 @@ description:
>    Ambient light sensor with an i2c interface.
>    Last part of compatible is for the packaging used.
>    Picostar is a 4 pinned SMT and sot-5x3 is a 8 pinned SOT.
> +  OPT4041 is only available as sot-5x3 and adds a wide band channel.

I guess we keep the compatible naming because some crazy
person might one day release it in a different package.

J
>    https://www.ti.com/lit/gpn/opt4001
> +  https://www.ti.com/lit/gpn/opt4041
>  
>  properties:
>    compatible:
>      enum:
>        - ti,opt4001-picostar
>        - ti,opt4001-sot-5x3
> +      - ti,opt4041-sot-5x3
>  
>    reg:
>      maxItems: 1
> @@ -39,7 +42,9 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            const: ti,opt4001-sot-5x3
> +            enum:
> +              - ti,opt4001-sot-5x3
> +              - ti,opt4041-sot-5x3
>      then:
>        properties:
>          interrupts:
> 

