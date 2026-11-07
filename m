Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794095915;
	b=o4eJw4pvpRaMYQiNTLcIso9/I2KFj/ndV6i1rDVGuQNfyj05XBLHX84WqLMd7w2qUY6A
	 KxkREn/prmwBApnXtZaIT6Iwt/XIw8+t8csepHzY5ufFqbpW0NkXf+8zraAgPaWS2gtFg
	 yp5/XUkF3iDsx5qp2itfJneACNvGcnXVq6nadtAM2cObhpeWlJ6euT9otRu7C1Xrk/c4Q
	 pXXLWx1JM/V4fQ0MjA4wYg6m0Zwytjwrsj+kTe6dyR7IEjfdnTFBEmel4XvULJ+iVQWYs
	 TiCWEdU7ZEYnGcobCHbFzVL0tn6CBpChu/MKDFSbZo3wLjOUk38ZYcEcDCyV6klx0pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794095915;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=hJpfWVWt6OvuJXgVqtROCqrboU3y2TU0VXg6NeVEuBY=;
	b=a+Unt/OOeOCnDv8QHMiQ0hsgXEqG10rNjH2G7CuFeWKRvzDkodWhaA+kfKMeZvedzIyb
	 LDNPbIqBKiyoSY0gv6PVrB8gvnbVq2Q2K1l4lPuwhWN10Pt3KjEg9tRzfnbwHg1q4zDL0
	 BzaJOOX4nod7N6OwTipkcaH5msyDgSGkMb4H0vH7QKXQPVowf0eqNQA75hx4rJe4Eie27
	 DsfWS6kDl5I/LpJKru9rprCfd/uMidagviSCN+Bt8Wil2lkw8QdO2C90xAyHzvpd7Ywo5
	 IdlZ24ljCKEOgNZd1sn5rR5H5gftsQ0Rblt0t7cMzsCRzKCXbtlSvYZtoAlUOdAeW4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eYwvt4n5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2B3606A326;
	Sat,  7 Nov 2026 23:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eYwvt4n5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B297E1F0089F;
	Sat,  7 Nov 2026 23:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794095914;
	bh=hJpfWVWt6OvuJXgVqtROCqrboU3y2TU0VXg6NeVEuBY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eYwvt4n5lvDe+R1WcoBdtTSWJHSQ+xPTl+mc4jADEX+jRpgg8qkx1L6+qZgVoq3Nt
	 HTY4Q4jj7Be8hR9Sd8PwL8O6mVyqTNQhKuhtZvGRkIcAsxYWujqApACRD/L9HrZ2BV
	 dXEhyCyi0EqgZrsD/TJ8fd2fKWeJA/Tp1O8TURv5mugRG9PWZjHx+X/dVmNhDLQkt/
	 h5DaB3vEX4JnjpohkaE3JhIjXSRM1PJJ8bMs2xQjAFV3hzfF/MoPsTaYvvdcRvRxY7
	 TyF22gk7ieFdiKKP1VWnnhFI3MAI95YVpLmooQa3X/jKKVlp4clvWwYeY+fZYqmz6h
	 SqIrz9qxxhxVA==
Date: Sat, 7 Nov 2026 23:58:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kyungmin Park
 <kyungmin.park@samsung.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: iio: light: sharp,gp2ap020a00f: Add
 supplies
Message-ID: <20261107235827.02951362@jic23-hlaptop>
In-Reply-To: <20261108-gp2ap030-v1-1-55314eb7055b@kernel.org>
References: <20261108-gp2ap030-v1-0-55314eb7055b@kernel.org>
	<20261108-gp2ap030-v1-1-55314eb7055b@kernel.org>
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

On Sun, 08 Nov 2026 00:31:33 +0100
Linus Walleij <linusw@kernel.org> wrote:

> The GP2AP020A00F needs a core supply as well as power for its infrared
> LED. Its I2C and interrupt pull-up resistors may also be supplied from
> a separately controlled rail.

Hi Linus,

The infrared led mention made me think there was a separate supply for that.
If not, does it warrant mentioning?

> 
> Describe the core supply as vdd-supply and the pull-up supply as
> vio-supply. Keep both properties optional to preserve compatibility
> with existing device trees that only describe vled-supply.

Is vio supply wired to the device?  It would be unusual to describe
a supply that is a pull up only one given that would often be a characteristic
of the interrupt chip at the other end of the wire.

Definitely after input from one of the DT binding reviewers on that aspect.
If there is precedence for this good to call that out.


> 
> Link: https://global.sharp/corporate/news/110721.html

What is the link for? It is not referenced from rest of patch description
so seems a bit odd.

> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  Documentation/devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml b/Documentation/devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml
> index 3fabf1f576cf..d4bcca0f2d0a 100644
> --- a/Documentation/devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml
> @@ -22,6 +22,12 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  vdd-supply:
> +    description: Sensor core power supply (VCC).
> +
> +  vio-supply:
> +    description: Supply for the I2C and interrupt pull-up resistors.
> +
>    vled-supply: true
>  
>  additionalProperties: false
> 

