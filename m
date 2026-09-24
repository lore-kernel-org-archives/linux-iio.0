Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F5B3CE495;
	Thu, 24 Sep 2026 14:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790260696; cv=none; b=dwJ2/+W7r+f5UoNfE1CVMLeS4wHf8H2P13OrAFrT4X+OrtoNQiF3ubbjQoFo+3KjjfmjXubkEdo2L0x0Kh03qcFwQxIR0iv6pVoiQUO4s2vIdPk6/wR+xjgzG0emzRFlUzetwSaFPJRbUuY8eLuTEFciiKXQh6mzdwo2KqxUE98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790260696; c=relaxed/simple;
	bh=VQWnshW7x5JKhHt60SoiR0TLDTR0iIuIQR1epXJ8brQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbDaBO8TQM70cEwx7+ShOZFB3h6jbmW3ZCk/hP+UIvthvhDmSgdVTAoOLAY8fTjE0QV56twl+z5069cLNNJ0R2yIB080W8ErF3ApIo5/g0RGzqZjdmh10byN69l7f2z0k4TDVU61Gvyj54/4BQqYnrxEbqYedt0QZzQqfs+TH98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJa0nT7M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJa0nT7M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CAF1F000FF;
	Thu, 24 Sep 2026 14:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790260695;
	bh=ldCUMl64vgCWY7zzR6Hp0M0K4EOVF52HaqQY1yiujP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mJa0nT7My79F5EEMeFkscYdM7Nb/TJxUl1Y0nTE1c6aC+DUjpzQ+T0NJu7FHm/zPh
	 l/uNdJX5Z+k1XJpexQBKxOQ/M+n4qNg4+ZS5DPocJhpZ2M7HR2k6Cw+3LsPKgHqsF5
	 pRHHw79MaJUPiHCa8Jz2ycJXOmVA+umfs3NThyrDcz30ndKLsbeD64gaDDC78NMmJe
	 kkKMXzGoUDP1zysTp9QbVL1bhsO+tVdsa5neQBhUvK/19zIjs0c3GdogKeFHyg1i0d
	 M/RyEl29DqtdjrU1Uq8TyBYw3MmB2z1cgIBfKv0U9i8ueZfYUA5UCVcTwkY68wZWN+
	 fUS8v3NLd/qPg==
Date: Thu, 24 Sep 2026 09:38:13 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-iio@vger.kernel.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-renesas-soc@vger.kernel.org,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: iio: adc: renesas,rzg2l-adc: Make
 '#io-channel-cells' required for R9A08G045
Message-ID: <179026069285.4124788.11493153710746349553.robh@kernel.org>
References: <20260911133653.115553-1-biju.das.jz@bp.renesas.com>
 <20260911133653.115553-2-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911133653.115553-2-biju.das.jz@bp.renesas.com>


On Fri, 11 Sep 2026 14:36:44 +0100, Biju Das wrote:
> Add a conditional schema constraint so that '#io-channel-cells' is
> required when the compatible string is "renesas,r9a08g045-adc".
> 
> This is required because the R9A08G045 ADC serves as an IIO provider,
> allowing external hardware consumer nodes (such as the TSU) to reference
> its individual channels. The '#io-channel-cells' property must be present
> so consumers can correctly specify the channel index in their 'io-channels'
> phandle property.
> 
> Fixes: a3152e5c742c ("dt-bindings: thermal: r9a08g045-tsu: Document the TSU unit")
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  .../devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml   | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

