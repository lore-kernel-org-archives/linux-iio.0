Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794096129;
	b=VEquOf/UeoUZzhEPKv47DOsr4Q4HO2LGzkgrb3E/aeKd6rjjL9IoDDHVUyDtb80xxR5X
	 c7DL3ppmEFJj9J3NJpM0fOxISNItRGXC+zHdBS2lavct1bgd035BfPHGYEc+iOVwJhvGD
	 SGXmz6Pf+nGIl6ZXx4fDRLQZW1B+eTlKDfV6t2268Ta6htgfRGJSmFFvtrhHj0u84QGWY
	 OZZna1z9xqLkm4AzL0T2pGEStuKVSdHXLZhg8URGU+3r3PclczLGQul7k1aDQsIIkcwUJ
	 HtT57o3A7qG/j/JUTIMS93cL3wfnNNPxaNkyAFjrAfIjxCfIRSuCAETl16Np9q6sbuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794096129;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=RiFgaI7f3ypJNMcIbplVOR7YNw0OlO7nVVQJEyJUwpI=;
	b=wcD9XNNV1nbtA1YdA6LCVTthYk48VHy4KAH4uacvehwqaalXvN+x+LymHMxuKGVi7SVl
	 8SZjIvL0ckY/R9ZqGehpLGPu7QM6EBVMP/gsPGBfnds5mt+c7zvjf2VHikQK0/ZpJrPhD
	 a/R45iZFBeh63zGmjI02WARBLLuYznhcp4nviUC/Y1LfWPHetuGmogNusOsAuorXgiJx+
	 Asgv8aAx+I5mJToUkv6i2XvnrBtPv68UVKSe7kpayzb28iQk9k6qLmif3/wYe1BQBB9Yb
	 iCvz4Gc7GLUDz1IIlF8dkxGpjO0/3V+SNkpecBYHlol10j65tEC8H8ZuAXtK2r2RNVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=abmeSe+p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1D3606A32F;
	Sun,  8 Nov 2026 00:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=abmeSe+p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3102B1F0089F;
	Sun,  8 Nov 2026 00:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794096129;
	bh=RiFgaI7f3ypJNMcIbplVOR7YNw0OlO7nVVQJEyJUwpI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=abmeSe+pbHL+RjTLick9II18+AMmw2B6A2/jPcrweL/CDUYKSAs0+LwCL9ws9fHJ/
	 IKhkp2f5dm5+e9b/ZuB17k+XPxIUVNYslv6cgzdmJm/w1T1HMnD54sKX34w9/sLEBm
	 1pBARM1i2hAR43dx0T7XsLuQ9ddvL9RgLVfDHNjI4x4nCs3wBGm3RtjdVaRBt7sCPm
	 mHhw99bCWUVPIsB7ci2UF5UpW9toJxuWzqq2/xJ5zYphUQjFJDkUbSaBKgsPvlc445
	 HxpVhxbaWmm4Dr/0ETfQWmtch+CqPdmg+J5hHolLp2cz6+L7LMiG8MoGF0cMDEJIew
	 Nv1E1ad8k73+g==
Date: Sun, 8 Nov 2026 00:02:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kyungmin Park
 <kyungmin.park@samsung.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: iio: light: sharp,gp2ap020a00f: Add
 GP2AP030A00F
Message-ID: <20261108000200.38075bfb@jic23-hlaptop>
In-Reply-To: <20261108-gp2ap030-v1-2-55314eb7055b@kernel.org>
References: <20261108-gp2ap030-v1-0-55314eb7055b@kernel.org>
	<20261108-gp2ap030-v1-2-55314eb7055b@kernel.org>
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

On Sun, 08 Nov 2026 00:31:34 +0100
Linus Walleij <linusw@kernel.org> wrote:

> The GP2AP030A00F uses the same register address layout and interrupt
> interface as the GP2AP020A00F, but returns raw clear and infrared counts
> instead of providing automatic illuminance calculation. Describe it in
> the existing binding with its own compatible.
> 
> Keep the core and I/O pull-up supplies optional so boards with hardwired
> power do not have to describe them.

If they are needed for the chip to function we tend to require them
anyway.  That's not to say the driver enforces it, but just that
the binding indicates they should be there.  DT files can just
spin up a fixed regulator if it is always on.

The extra bit of led power description perhaps would be better
in the previous patch given it isn't related to the new part introduction
in a direct way.

> 
> Datasheet: https://global.sharp/products/device/lineup/data/pdf/datasheet/gp2ap030a00f_e.pdf
> Datasheet: https://jp.sharp/products/device/doc/opto/gp2ap030a00f_appl_e.pdf
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  .../devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml  | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml b/Documentation/devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml
> index d4bcca0f2d0a..45f1b53d6d7b 100644
> --- a/Documentation/devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml
> @@ -4,17 +4,22 @@
>  $id: http://devicetree.org/schemas/iio/light/sharp,gp2ap020a00f.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Sharp GP2AP020A00F I2C Proximity/ALS sensor
> +title: Sharp GP2AP020A00F and GP2AP030A00F proximity and ambient light sensors
>  
>  maintainers:
>    - Kyungmin Park <kyungmin.park@samsung.com>
>  
>  description: |
> -  The proximity detector sensor requires power supply for its built-in led.
> +  The sensors provide digital clear, infrared and proximity measurements.
> +  The GP2AP020A00F can also calculate illuminance internally, while the
> +  GP2AP030A00F exposes raw clear and infrared photodiode counts.
> +  The proximity detector requires a power supply for its built-in LED.
>  
>  properties:
>    compatible:
> -    const: sharp,gp2ap020a00f
> +    enum:
> +      - sharp,gp2ap020a00f
> +      - sharp,gp2ap030a00f
>  
>    reg:
>      maxItems: 1
> @@ -28,7 +33,8 @@ properties:
>    vio-supply:
>      description: Supply for the I2C and interrupt pull-up resistors.
>  
> -  vled-supply: true
> +  vled-supply:
> +    description: Infrared LED anode power supply (LEDA).
Not related to rest of the patch.

Does explain the mention of the vled in the previous description though!
Now I understand you were referring to what was already supported
rather than what the patch did.

>  
>  additionalProperties: false
>  
> 

