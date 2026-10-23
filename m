Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792788564;
	b=QF8VMVBQTWUV637tl2ThRcf76CL9f/Xp61XlOqkh5J0W/e20iUE7BaOO3LMBrEVDTkQF
	 6Q6U670x7dl3GOm2m8D9vwf3AQDAeb0qolg6xPzsH2oZCXqS8GZrlzzlq9fqwNI9yC8mT
	 uT9i2kAOFzDMOZVM6C155OROeOmI2MB+e82uMgscnbUJga314F4bxoIfndRs7pJJayQRr
	 Rg1DW+u4Sn3ZOTp/5W8dg+zPe5xeyqJVIuXj7FPXmG+npRYtncWWqUDeq2I/J2oYq7mIb
	 Wr1WOAomSDoG5Pg/PVscwrEG96Q7LHylzSfipQGuT/rZCYMggSev1OoVDIa2vP9F1cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792788564;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=i/d/j6CvGXRGkq9MM1Xns/LyW3UECTcEwY9WrU9e6vE=;
	b=oCwdunZafiTX3S4p/f4Xf7dpTp4M786DpPwWkukVHaKM50OZlqlJLcDdkmxYLwpxx82v
	 K4MW5qchLxi7jCx4Z+Y81RXyTscOc7F/XubZSvBgbMCFY+HQpsZTNCllig747bTclSWqa
	 pIrgkqX+JBYwqV2wrlc+wHeMfsrJGMDKPHszaMLXmXfZ2Vd4q1Cdm06ViJLYiYffonf6D
	 i7KWMnQdFc+5RxACSrmscavqzUsCPAYiMsKDbC55y/22dh+VkBEmitSqr5NDAJu9DBtqR
	 8fJIIXJMMAkP/Q/Rgkj0i19+z+ZJ1HhggEhUvepjwWSd1IDio3D8DsrCvlJ0JumvUcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cLWXFfk0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5788606A31A;
	Fri, 23 Oct 2026 20:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cLWXFfk0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB8D1F01825;
	Fri, 23 Oct 2026 20:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792788563;
	bh=i/d/j6CvGXRGkq9MM1Xns/LyW3UECTcEwY9WrU9e6vE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cLWXFfk0jjuGxlDFeBpT+0uKBselTAfa63AxsOc+Jc25I2QSiI9pB+Zy4KxCWVZWo
	 6LHYtKXHuZXo3kTSipDK0nQumr+eW2IKSKtVXhWUEyUF86YD3yIDd0ym2kQKKZTXfj
	 asHekn5SjCTvfCmZFmAqGEw282JwEH+75gUD+3W/RDSR8UrhyKJxw+DGHgRrJCGlXI
	 7w2/+WOgk8GSeEIFMs6BYa2HoIhL1l1Y5q0swAF4lTU19wkGWSmDSA5/onLjVfvvWE
	 dee/eVbrzmiTTcNW65ihquJK0Zc4I4AEQsC/LnwxNcLeILMvHYvbGEa10a7OLjj8Bg
	 fcQOU5pNPjHfg==
Date: Fri, 23 Oct 2026 21:49:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, Andy
 Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Magnus Damm
 <magnus.damm@gmail.com>, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Prabhakar
 <prabhakar.csengg+renesas@gmail.com>, Biju Das
 <biju.das.jz@bp.renesas.com>, Fabrizio Castro
 <fabrizio.castro.jz@renesas.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 0/8] Add ADC driver support for RZ/V2H(P) and RZ/V2N
 SoCs
Message-ID: <20261023214917.157d0c89@jic23-hlaptop>
In-Reply-To: <20261023175919.160103-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261023175919.160103-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On Fri, 23 Oct 2026 18:59:11 +0100
Prabhakar <prabhakar.csengg@gmail.com> wrote:

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Hi all,
> 
> This patch series aims to add ADC support for the RZ/V2H(P) and RZ/V2N
> SoCs. The ADC IP on these SoCs is similar to the one found on the RZ/T2H
> SoC but varies slightly in terms of available channels and configuration
> options.
> 
Applied to the testing branch of iio.git.
Note I'll be rebasing that on rc1 once it is available.
In the meantime, additional feedback is still welcome.
(It's welcome after that but preferred as patches on top!)

Jonathan

> v2->v3:
> - Added Ack from Conor for the DT binding patch
> - Avoided splitting up the ndelay calculation into multiple lines
>   in patch#2
> - rzt2h_adc_pm_runtime_suspend() now checks the return value of
>   reset_control_assert() and returns if non-zero. This is to
>   avoid churn in future patch.
> - In rzt2h_adc_write_scale() used multiplication() operation
>   for comparison by dropping the div_u64_rem in patch #8
> 
> v1->v2:
> - Dropped using DIV_ROUND_UP_ULL to DIV_ROUND_UP
> - Included time64.h
> - Returned -ENODATA in case device_get_match_data() returns NULL
> - Renamed RZT2H_ADC_VREF_MV to RZT2H_ADC_VREF_mV
> - Updated Kconfig description
> - Included array_size.h
> - Dropped unnecessary extra line in rzt2h_adc_write_scale
> 
> v2: https://lore.kernel.org/all/20261009184122.1378797-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> v1: https://lore.kernel.org/all/20260929124248.237032-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> 
> Cheers,
> Prabhakar
> 
> Lad Prabhakar (8):
>   dt-bindings: iio: adc: renesas,r9a09g077-adc: Add RZ/V2H(P) and RZ/V2N
>     support
>   iio: adc: rzt2h: Wait for the analog part to stop after a forced stop
>   iio: adc: rzt2h: Add chip-specific configuration
>   iio: adc: rzt2h: Add optional reset support
>   iio: adc: rzt2h: Prepare for SoCs without sample state registers
>   iio: adc: rzt2h: Prepare for SoCs with different ADC info
>   iio: adc: rzt2h: Use scan type for ADC scale
>   iio: adc: rzt2h: Add support for RZ/V2H(P) SoC
> 
>  .../iio/adc/renesas,r9a09g077-adc.yaml        |  38 +-
>  drivers/iio/adc/Kconfig                       |  10 +-
>  drivers/iio/adc/rzt2h_adc.c                   | 327 ++++++++++++++++--
>  3 files changed, 346 insertions(+), 29 deletions(-)
> 

