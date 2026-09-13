Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D4B3612E2;
	Sun, 13 Sep 2026 03:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789270064; cv=none; b=f4/MsGAY0MbdZQSc2EumA8WuumEfxKYtt1fITMUmqzRrohXtlsq781p+uENj7XKS53dtn1T8cIz6chGHjXsTk4v/cm7f5KS3TA16XbresEZq5OpwmVULqY9VT2H1Ed/sQF0w7vFewRF6ggWlH7dL5MoObe/zabR7qdH1YkIgD2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789270064; c=relaxed/simple;
	bh=UYTwWMRvhRWLC9pBTt3+cLqeYWCBAX/+YijrquiahWc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PPm+RW8cx5IaPpCnbzw6AMF/yT6nTO9lnIWXD45t5MsxhbrJqiEn/UzdFSr081Bn59WCNMo6XAbSj+juLLVuyMJjXjZR24daU1HUUzng2o/SvjrgauEhvrQsKPwbWSZUcKv0CVdZVuNKCDIncLXSpHGjLmqYl3EPBvQ6TU1vVZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7ZJZ+G5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7ZJZ+G5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD201F000FF;
	Sun, 13 Sep 2026 03:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789270062;
	bh=4cnw/gKsg5nkyDSIUYMYyUH1l2t6pXtcJrkZHm+Yo5A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=l7ZJZ+G59lp3uHSlNB6+9flefqrDllIjEQbQBCiNcnRyETBhGIBEUlFt0DNWVnw/c
	 1U8x4hjbyM5iDon95HcMQ61Kd5HwTlii3HufGN+dUfiBJTF86jg8HpD2DvSmjKcegQ
	 QvSbVsk4b1n/mE1HOrsTpebabO/XZgibD6l+eNsAN3tm2M+BMh06OnpePPtrhTLYIu
	 dfcdXyEgu4/KXNMTsNeRdxj8yIODtTjCzvhrTdWEtWazKMaFQVjMFLOl10vPwEhC3z
	 pyYFsRkYtu1X3Ovb09F48Jc1EBJv7TEVIWkbg5TaAFLM7zZkeEHGSoPNMrucmg7i5T
	 ZJ8vRNeCVaIgg==
Date: Sun, 13 Sep 2026 04:27:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus
 Damm <magnus.damm@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, Chris
 Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>
Subject: Re: [PATCH 0/5] Add ADC support for RZ/G3L TSU
Message-ID: <20260913042735.62806d8d@jic23-hlaptop>
In-Reply-To: <20260911133653.115553-1-biju.das.jz@bp.renesas.com>
References: <20260911133653.115553-1-biju.das.jz@bp.renesas.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 14:36:43 +0100
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> On the RZ/G3L, ADC1 is connected to the TSU, whereas it is connected to
> ADC0 on the RZ/G3S. There are no ADCR0 to ADCR7 registers on the RZ/G3L,
> and the INTEN bits in the ADINT registers are also different. Add ADC
> support for the TSU (a.k.a. ADC1).

Too many TLA.  What is TSU?  In general write this for someone who
is not really that familiar with the particular part!

> 
> The SoC dtsi patch depends on [1]
> [1] https://lore.kernel.org/all/20260911131629.111564-2-biju.das.jz@bp.renesas.com/
> 
> Biju Das (5):
>   dt-bindings: iio: adc: renesas,rzg2l-adc: Make '#io-channel-cells'
>     required for R9A08G045
>   dt-bindings: iio: adc: renesas,rzg2l-adc: Document RZ/G3L ADC for TSU
>   iio: adc: rzg2l_adc: Add RZ/G3L ADC support for TSU
>   clk: renesas: r9a08g046: Add TSU,ADC1 clocks and reset
>   arm64: dts: renesas: r9a08g046: Enable TSU
> 
>  .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 28 +++++++-
>  arch/arm64/boot/dts/renesas/r9a08g046.dtsi    | 66 +++++++++++++++++++
>  drivers/clk/renesas/r9a08g046-cpg.c           | 10 +++
>  drivers/iio/adc/rzg2l_adc.c                   |  9 +++
>  4 files changed, 112 insertions(+), 1 deletion(-)
> 

