Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793736907;
	b=ZHIN3IBNhCCDtRSOJM3SylWu6ZmNNyUITCfhws3LUbQS9h9mFXayW6qqjHKJHiGhhKP1
	 KXEEpq5Shzb8sGZ2XRtm86Ft3LvHWwi8iTu1lVVbIEtGnady5bSzket9zIaTfK1KStwhP
	 dmvCLFKFgP4eQW6hICTZUl8Uo+zWUB1WRHIxXY21ncUsEO9QQoSV88UNO/xFLH2IQAT9M
	 y2sQeHol3h2/3cMgJMEn/YPYHko3czhES+f2GIWNP5FJWcbbCjZTwRpRoymlvxcBNcoZh
	 SLDkGnr3tTTZau/G1cBMNrjEesKTcYFiZcM/GesDp64ODxHPMpQIRwpDSMjIB3N0Tbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793736907;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=ZFHIm/zXQPHe1AaGXSECunepyflW556IG1yCEGyj8P4=;
	b=Sri9eyvooAkHlasERC97CP5kRpq8OkBMVS6UPPTRmXD28vqBsDYpkmHzrdwNZgbgt1N/
	 Mm/Grl1l1JcoU0HGIHAAGCKnSzqaFrx8mmP466Xh9iR7K4xkPnGQDtf3f9NyRhuPR0GJX
	 hiLhA12fFC5OGGLBM+Pwsrb3t/MZ6vcsP0Vq+YtVauqcMVQjxWezilgAeZ+xgwGWFT1x7
	 ky15YipjrluPEVeh0bZqV9qYPp5aPewPYb/dNJIOCW/HX64F8+BKYaiwnIg+tP99fwEzW
	 9/KgqGb2ok97tBsLEhoruUdolkLEr39TMKqSh62uKemBIQAbRkqkCvAxCIw9kfTQMYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fKb8KpPh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA34606A31B;
	Tue,  3 Nov 2026 20:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fKb8KpPh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D511F00919;
	Tue,  3 Nov 2026 20:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793736907;
	bh=ZFHIm/zXQPHe1AaGXSECunepyflW556IG1yCEGyj8P4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fKb8KpPhq3hbU67OaKBB8mtWq3EiqFYN/V4Vmb1aDJJtpNGio7JEQWDCncSPzFGA3
	 oM6IfcRDGgxGw5xkh4U+GblLB8SJxFBoKsfAIKXpjPExCzJkb+K9uGLuIeLlndJPdr
	 ngJ32/W6QS9q23VtfLvMKfGfD0D/7tHMuvtRcracpkNLxfWAX5rlX0cvXSEHERuam3
	 v6bpnAtDuQEoHtKQQbQJJ9J3v/ZU2lqCkkxNfh+NWabAuwUVn1z8sPdxkdMmqJNqWo
	 xOc3DfGHEXfE39FUZXg6yWMot2onR48C5pqvT1xTWG9Qn5V1YEk73sAqo3GSg7QwbK
	 zMxiUMTLgLOwg==
Date: Tue, 3 Nov 2026 14:15:05 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Radu Sabau <radu.sabau@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Alexandru Ardelean <alexandru.ardelean@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
	linux@analog.com, Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH v5 4/8] dt-bindings: iio: imu: Add bindings for ADI
 ADIS16607
Message-ID: <179373690422.3640596.3988798266071308825.robh@kernel.org>
References: <20261102-adis16607-v5-0-4f98b0d271ac@analog.com>
 <20261102-adis16607-v5-4-4f98b0d271ac@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261102-adis16607-v5-4-4f98b0d271ac@analog.com>


On Mon, 02 Nov 2026 11:25:40 +0200, Radu Sabau wrote:
> Add device tree bindings for the Analog Devices ADIS16607 Precision
> MEMS Inertial Measurement Unit. The ADIS16607 integrates a triaxial
> gyroscope, triaxial accelerometer, and temperature sensor, and
> communicates over SPI Half-Duplex.
> 
> Two variants are supported, adis16607-2 and adis16607-3, differing
> only in gyroscope full-scale range (±450°/s and ±2000°/s
> respectively).
> 
> The binding exposes optional properties for:
>   - An external clock for sync mode (falling back to the internal 8 kHz
>     clock when absent)
>   - A hardware reset GPIO (active low)
> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> ---
>  .../devicetree/bindings/iio/imu/adi,adis16607.yaml | 94 ++++++++++++++++++++++
>  MAINTAINERS                                        |  7 ++
>  2 files changed, 101 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

