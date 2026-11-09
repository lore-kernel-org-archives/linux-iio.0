Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794228875;
	b=KE2rFwRGLp/AdUfvPs8WfIyOBkOXyGSiuJeOF7nXmw7109JCQszR/zGjrNDTrPMSfRp0
	 40mQtdIr/krTmYn/m7yCC+fR8JkJp+a3Zo+KBO7gRkTWjrDEL2Vis52Y+azfNR3yW2Y9c
	 yecl1IOF+Yn1WtqsM0gvFM8p4hEsH/d7yR8JjH7mAtCopWxNZZV0pSTdXpjjDlxHfEaPU
	 89bbQiqDWfv87Gc9NQ/icmJP+jHTNidSxq9sDbEBeu2AtEKyFj1xnrEDpRhQrAWEoHSsz
	 R7i7kIjqt1sfu0+EXVg/LahJsKxS0c2k7hrXf4IKDcPnFztRTx/8gZKWhiER1ydLjHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794228875;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nxRsHxRqsX2qVrlak5SuSfhR7OlREyuzRzU9B/mk1H0=;
	b=cG0793/j5deW3tHc12z0Z93vObwhp2fHQEt1aJZ6VWtiIdZKFr6Cojzeh1AGrc2kV+Bd
	 GJS+3pfyjRR7KX1bayCf6hdeWso+KQWmaq7V5uLWZ7diuNGfYWHCSIuiZtROkZKAClawJ
	 3qbv57L1l7lagva60Zy1/pxV+8LrJp4R0fN3uYQLDfDlrxv2fs82AXTxhi9pAO7LfaLAa
	 9cPDXMLRULAV0mwRVHWA6j23h8T+/qXQ1ewbDmxul3i5gsc4lUThlAaXtXuHdC20DM6a+
	 LNGKiFfzeumhatmb8ssa4knIZTj2KyO4yjmPa6fgXcbcSqfYyL84ohJ2WUxLFdt/ttg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=awZq0QEd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3341606A322;
	Mon,  9 Nov 2026 12:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=awZq0QEd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DDB91F0089F;
	Mon,  9 Nov 2026 12:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794228874;
	bh=nxRsHxRqsX2qVrlak5SuSfhR7OlREyuzRzU9B/mk1H0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=awZq0QEdz5MiChIZ61bjgX1NPVLwyV6pwhgQWtNH3NR2/1IzLWTQtuwjStdqyfPw8
	 uNORKJEJ/HJrHCy7msLAPPvoqrz4YiocoUM+iicObaxa2M4TLXufIGmxu5zORTU9ha
	 AzAh9BYFhWFrwrO5TCHbRUjIeE38728DSPy8ZEFYt5NtoPYL1RtgnRRawrtrmUHpdC
	 jdeOhdpLvq1IYjpHNfGF4H9+iZtG8XqkhzjOTzVPZnMG/v+8RVtfFQbtpA498tn+nt
	 BURHMuKmV69n9ZiX5sgYdu0pfUwAQb6PJcsaG4nE5FGg1TAB42Rcje9XFSqcoZxgXQ
	 XvEWk/syTJl5Q==
Date: Mon, 9 Nov 2026 13:54:30 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kyungmin Park <kyungmin.park@samsung.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: iio: light: sharp,gp2ap020a00f: Add
 VCC supply
Message-ID: <20261109-cuddly-khaki-perch-b4f3fd@quoll>
References: <20261108-gp2ap030-v2-0-24eaa1b9fe59@kernel.org>
 <20261108-gp2ap030-v2-1-24eaa1b9fe59@kernel.org>
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
In-Reply-To: <20261108-gp2ap030-v2-1-24eaa1b9fe59@kernel.org>

On Sun, Nov 08, 2026 at 10:43:59PM +0100, Linus Walleij wrote:
> Describe the sensor core supply as vcc-supply, following the VCC pin
> name in the GP2AP030A00F datasheet. VI2C denotes the I2C and interrupt
> pull-up voltage, not a separate sensor supply pin.
> 
> Keep the property optional to preserve compatibility with existing
> device trees that only describe vled-supply.
> 
> Document the existing LED supply as the infrared LED anode supply
> (LEDA).
> 
> Datasheet: https://global.sharp/products/device/lineup/data/pdf/datasheet/gp2ap030a00f_e.pdf
> Link: https://global.sharp/corporate/news/110721.html
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  Documentation/devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

