Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794170824;
	b=Z+x1Od0tt4z5/v1S/4v5DoO+zRG42DJbb3S35Sd7Nl0KiQ9PdJpLvx7lTkC0em43//Nh
	 oBdSqjnhfzg8IsonrNku2li/8ocqwfzamwjzDRe7Y9WoMJB1XlLgq36a3kBfNLL2kuP8E
	 waA6GjebSPfG+PlDNJda9uGZNEwze1o8Rtm1GZht0IfqhsCYqfnRhIPWnSE/BdI9gbzcV
	 wgSFv4FbaEgzdQgyhF9eZA/vVn7nGd8j+U3DeFzwPT6YK0bHQKmN4FpKUTjlJB6fD8Gk5
	 6TDNcNWGhhTOs2coJdWPe2ZalyokUxJMEyOMc36WkemVv6s4f17nJfD1J7sSdFgbjEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794170824;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ThjO24WuCau9eRYMDFPIL89g6rGl0fqGjMwXQk/3iWs=;
	b=OPkPzfvZSeSbGnDnrXuIs2+jd7YunF9hHBJgpKnMXVXZiPTdb3xb2/OiBJDsoXLO27Vx
	 dmxhKSzIhIOzMk9kbUKy+j2Y5Isykht45x47OtyzNbdimtcWsuwoLh1Yw35aVAKvZQ/GK
	 gDlP6WCfQlpvQyyZN2ekxPXIAIdWvPVeIVYp0JYTqBDPUFEzm2V/Wxh82Shq05KlxeS3Z
	 tzfudJ2RDY7aSJHzzUywI38IVx8Lz3V/hSS/HmY8vJeZQDz9VHv4p8fjV43WhWyB53C6Y
	 UKdw2nEFhCJihvx1ITlc+Iu2t1c4tperglj7XIZSli9OwMawE3W3bLH8I5s2GlMrbvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GN4eWksL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C2B606A31C;
	Sun,  8 Nov 2026 20:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GN4eWksL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720911F0089F;
	Sun,  8 Nov 2026 20:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794170823;
	bh=ThjO24WuCau9eRYMDFPIL89g6rGl0fqGjMwXQk/3iWs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GN4eWksLiMRX5GNrr38NWq6Fqu8qqJYs7W73kYoG6RaEMKrkdaJDKUn93toF0k+ti
	 Q6HooGXYSfkeGB35AoQjIP9rG3G3INDGSRAu2x3OH/8H6hBH/pGSwMUf0UUnAGHd6j
	 Rq/nAqixUl2DIUSjQHbrnNhoo0idFLpTnyj3phqPEYjg+XQQUidVuCBuIm4WhwYfW4
	 Kva7RvGA6ABsr1zZzXK9hkGy85AL+x9y0gBgOtQ7InODv3OwnzMZLrbEYgL1RFZdIJ
	 i3axLKkH7gcVlotTm2raWVWg/TlE6j70nsZaIINUgamtbco151pOM7vyNqJwFFK90X
	 WWuKI7ccsgjLg==
Date: Sun, 8 Nov 2026 20:46:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Lee Jones <lee@kernel.org>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, mfd@lists.linux.dev
Subject: Re: [PATCH v1 1/4] regulator: dt-bindings: maxim,max8907: Document
 io-channel-cells property
Message-ID: <20261108204654.2fe19afb@jic23-hlaptop>
In-Reply-To: <20261108095634.100517-2-clamor95@gmail.com>
References: <20261108095634.100517-1-clamor95@gmail.com>
	<20261108095634.100517-2-clamor95@gmail.com>
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

On Sun,  8 Nov 2026 11:56:31 +0200
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> The Maxim MAX8907 has a built-in 8-channel ADC. It does not require any
> Device Tree (DT) based configuration and is folded into the main PMIC
> node. Document this behavior.

The actual addition here is to allow other devices in DT to consume
the channels.  There is nothing stopping you having an ADC driver
without that which would need nothing at all in DT.

So this patch description is not accurate. The actual change is fine.

> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  Documentation/devicetree/bindings/regulator/maxim,max8907.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/maxim,max8907.yaml b/Documentation/devicetree/bindings/regulator/maxim,max8907.yaml
> index ee1a305d1c210..ccdeb9ba21e26 100644
> --- a/Documentation/devicetree/bindings/regulator/maxim,max8907.yaml
> +++ b/Documentation/devicetree/bindings/regulator/maxim,max8907.yaml
> @@ -27,6 +27,9 @@ properties:
>  
>    system-power-controller: true
>  
> +  "#io-channel-cells":
> +    const: 1
> +
>    mbatt-supply:
>      description:
>        The input supply for MBATT, BBAT, SDBY, VRTC.

