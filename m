Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795378119;
	b=lIXLfVVGwAK0MVjlwFAbVZ7rIQ14c93QsfSzRO1mV3K/4Ue9tsPbfpCKclLCVPUlQEqZ
	 RCCcxsEwH30g//53bCG6b/n5QiRYEeOugRLxpf45VnKPnSghsFIg7zQUTuq3V0etLp7Q+
	 rUVOA2ftsjo8UVZBaeo6ZntWEFtJUruidXhUB/b8kfexty4EqH7drFenLLzX7NIWNP1q/
	 p39irgZ11/71q+VAT1vwpgc4ZEGCkBHst1/sCygxLyCO+rdw21F+uElvMkq/CFUdWVK2d
	 XLS+FzXUBQHpod6s5XsHxvRjaMs2Ws+ZBskEA6TbgCosuRLCoIXF7ZPHix+Jdt6xneg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795378119;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=o628r7NNNZmfZVtOQgedEE33LYjye1BrJmgudl0h28Y=;
	b=f3YP89pdO0ilkf4/8P/kmqvyUjRVUFr/0/Ep9kSMg7rHDPPBTRaRnbUzSGtoLn5TMou2
	 yBe9pvjdlJxYU3lkM/lCcE6nB+QcqjN+O5nZS628SQjeqUxyEwDiVmVjYB8lNymJ4wueW
	 qPujV6QxPVi4oQHI9DnC2Z6L1iHgxrt90mdj/Ut5RmOrk2TYs2h9CE6Q/rr6AYEB+KA+k
	 vFXKdkuiVV+9FJToyWPu+Ygvo8E85BsLF7k+BFBfyhHQONPaQXaop+FKiza4ULTCBgmyZ
	 vVqeLBy0Wt1xJWkwRA0p/Htyvv+vX3mqy5tS7KxDr5EoJYLJ09PxIt6aB55SlEM4lwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NEcSJnNr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F3D606A31A;
	Sun, 22 Nov 2026 20:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NEcSJnNr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6AA41F000C6;
	Sun, 22 Nov 2026 20:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795378118;
	bh=o628r7NNNZmfZVtOQgedEE33LYjye1BrJmgudl0h28Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NEcSJnNrBzNk0NVobLQaW8brRxhjnpIX5C1lIz7HZEA9ytGBdxXkPpJsk1aaHqRuh
	 GsdJfEOiav51HQXNObRtdFjE8aaYIXtsuVE3PDBBR5l7BYzmdAV/Mp2FSVbKdLf/Vh
	 AFq75XBuUIDCHLKy8gdiwaaMa0b/QNW+DSFhxwFNkr65uPR2g8hrNK2Ob/HJmrj648
	 FQ6qcyKzIAXAzk0dEd66mLdgxbM1Jo3V5fLwOsM4xLuwvaKnqxs7piOKqt4MjBHGq9
	 2pWWMU2kNW1SiQCZnQhQJHTGAx0+ldUi3gwnyVwuKSduBcV6gthL740aFlTpExci75
	 xT3aM9m4bffuw==
Date: Sun, 22 Nov 2026 20:08:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Lee Jones <lee@kernel.org>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, mfd@lists.linux.dev
Subject: Re: [PATCH v2 1/4] regulator: dt-bindings: maxim,max8907: Document
 io-channel-cells property
Message-ID: <20261122200834.4be768cc@jic23-hlaptop>
In-Reply-To: <20261115091120.108684-2-clamor95@gmail.com>
References: <20261115091120.108684-1-clamor95@gmail.com>
	<20261115091120.108684-2-clamor95@gmail.com>
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

On Sun, 15 Nov 2026 11:11:17 +0200
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> The Maxim MAX8907 has a built-in 8-channel ADC. It does not require any
> Device Tree-based configuration and is folded into the main PMIC
> node. Document the io-channel-cells property in PMIC's node to be able to
> request channel data in the Device Tree using the phandle of the PMIC.
> 
> Acked-by: Mark Brown <broonie@kernel.org>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

(as this will all I think go through MFD in the end).
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

