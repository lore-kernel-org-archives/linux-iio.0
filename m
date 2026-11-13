Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794536239;
	b=COzADknVvkcn6ZRIa0RQcubRK01+EjsvWnfyeziEyvNvgV3eTMuHEXW/9PRGweWkdJBj
	 NH96ZlPSgUP08+DdiZkuFqDikQgj+fuDJsx7Z9A3FPyVztJmctqqoolX25BgIhaFOFaZn
	 a/D9aUmlBJ3R5gleR7oUA0UFxnWbFEwcvIEFSbLkoS/omgHvb9do7AXR6RnKhNruR8Z8G
	 C3KCqydzR4PG+sFrFzzyTs2G1OySURLGBOeZjxEjbkY3fRPDpkMDxZq9MqwbfTiWszw17
	 cH7c1Bkg7kXyxcRJIi42NhdqOI/AGjiwiflIgsUeDkjMj/j/ZajtbdEN0u2PRu/flcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794536239;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=6K2ZQ58mfhfrypYFAVRN9Vv3y7y6wCLRsHy328DMCaQ=;
	b=pd4JmbDlX+P4ZcFnzZyo/v3XVh+45JH+/q/7anhF+Vqsy6CGyOCw10GxFZo9wcabSy3l
	 gt+xSvLLycgGd+HzcgPV2k8zamoDTJI0/w80bDxQxxOY8MLDVhs8e+k3UOjoNlk0sqOYz
	 gYCHIUcGywx9YMsQqva1uO4pmZ1GUPB9mgcgGPaUs4jcuCHB722twjB69evFXtnxcJo9U
	 GOoPol0CJ5sSH+pmt2Wa6krNJVIqRlZtXBt4lXPSuIHBKkrqA2LC3eJTmpgCyzyzJHCe+
	 F4hV6rm4X5BWSj05ImLlinSIxcDDesJibKD9U4dysmtzPscMhSVQDtQBvMcWhaNufnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TQxOi3rO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1E4606A31C;
	Fri, 13 Nov 2026 02:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TQxOi3rO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078671F000C4;
	Fri, 13 Nov 2026 02:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794536239;
	bh=6K2ZQ58mfhfrypYFAVRN9Vv3y7y6wCLRsHy328DMCaQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TQxOi3rOwLFY/tgl0aHU5xWmlFZNin0cbTN0hBrfwxUysOVLvuBFl4T0GBU+7zwW5
	 W/WyFebtCw/7E2P+eE005jUvSvx5lr8iWg6cjrDWZ7f8hqw6ajoj0BaP1rHRPiP2/k
	 ty09/QqyfM5tXvas85evPrhhwrSzBaGhe3FolNelyYoz70L2VdjTCKHuVCVIi1Ul+H
	 IwmXKdPGEM2GEV5Me4FOqZmnmXJzKjo4OyrKhxfO6I4F0x5afl7d033HB01Ogn4Uf8
	 CaJIpkLO4kjJXzQgEzzBc7H/qg7ttsM6OpXWQ74TWb9hXAwZlBjmvJ80gevFz3uyJN
	 kh5L2C6dhPinA==
Date: Fri, 13 Nov 2026 02:17:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: pressure: infineon,dps310: Add
 interrupts
Message-ID: <20261113021710.7211ade3@jic23-hlaptop>
In-Reply-To: <20261110154254.39092-2-zoone.rupert@gmail.com>
References: <20261110154254.39092-1-zoone.rupert@gmail.com>
	<20261110154254.39092-2-zoone.rupert@gmail.com>
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

On Tue, 10 Nov 2026 17:42:53 +0200
Rupesh Majhi <zoone.rupert@gmail.com> wrote:

> DPS310 signals new results and a full FIFO on its SDO pin. In I2C mode
> the same pin sets the address LSB, and interrupt polarity must be the
> opposite of how SDO is strapped.

Some hardware engineer is presumably proud they made that work!

I'm not sure why we never had the SPI part of this binding but
given it's not there and it gets more complicated wrt to this
that can be addressed if anyone ever adds SPI.

Anyhow, to me this looks fine.

Jonathan


> 
> Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
> ---
> Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
> 
>  .../bindings/iio/pressure/infineon,dps310.yaml         | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml b/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
> index 416117dfd927..cded6e0af147 100644
> --- a/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
> +++ b/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
> @@ -23,6 +23,12 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  interrupts:
> +    maxItems: 1
> +    description:
> +      New result or full FIFO, on SDO pin. SDO also selects I2C address, so
> +      interrupt is active high at 0x76 (SDO low) and active low at 0x77.
> +
>    "#io-channel-cells":
>      const: 0
>  
> @@ -42,6 +48,8 @@ additionalProperties: false
>  
>  examples:
>    - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
>      i2c {
>          #address-cells = <1>;
>          #size-cells = <0>;
> @@ -49,6 +57,8 @@ examples:
>          dps: pressure-sensor@76 {
>              compatible = "infineon,dps310";
>              reg = <0x76>;
> +            interrupt-parent = <&gpio0>;
> +            interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
>              #io-channel-cells = <0>;
>              vdd-supply = <&vref1>;
>              vddio-supply = <&vref2>;

