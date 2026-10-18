Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4116B43AB0;
	Sun, 18 Oct 2026 22:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792364192; cv=none; b=ivB8+22MFHWQnD8vLYHjhamhVQntXo2g/8V3ORG/59dDpRPIDkliMMYynj5LsS0V83C65jKB5pt4yoal0d/h9Kg887jyA+0Yy46X3Bbtx9ieyPThrxaUiMhi5WVYiQnigzNNOSyaVkz0REzJE6kjfOJb2Lq/ZQbarEmXEuEYthg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792364192; c=relaxed/simple;
	bh=7WJaqAKMx4Vd9amNMrXrj2mghDT3Z3Me6Zw9m375Dlw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BI5INYYQhH6h6dBOQOgvAHAYsRGv9FgiHWyARZAs4BEJ83pialHu+0gv8uPy1SsvOfSIDhrTiApzwPg0z6194pq++6cAPIbiu6L+ZZ3wP3NbIC4sSReUne9Aq5G+4FkyAaoE8vZrUlLGUmCSMryl4bQzfkCGvAGqNOQ3ZSxpuWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtGpYrAF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtGpYrAF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94BB1F000C4;
	Sun, 18 Oct 2026 22:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792364190;
	bh=Y6PKgLLI7TefDQT14Ajrvl8LP/1kQRl3r43SfiCExqQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TtGpYrAFqcbZ0pKFCk8NwjmeWlyWnKfefXtL6nQv+n3n8k7S770Vs/W2w4qGM4RUC
	 yQKfaVeip20bAMTIiDWXo06Z3r/7OoraHUedwcQFOBMnaM+CdI78nmg2eUOZbMNN3B
	 V0OxKd3vEAdQHq5jO+ZlnQajWfTKtFedG+RL6PKimu5FoiK0Q5VHI22aqlKiSTiq3k
	 /3RHVBRQRxCBPEJ5/vnyyKAXMJRJy/224G3AggpckyhGIiGJarQYG09ZASrGVU5FKp
	 +ugfgpbMTlIa5YQY588JyvdjPi5Have9pZ2hGZkVsC4YccZO/E+YuqCSlkJG1S7uYF
	 VtGDMm2d1GfVQ==
Date: Sun, 18 Oct 2026 23:56:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Joel Stanley" <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, "Ryan Chen" <ryan_chen@aspeedtech.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v3 0/3] iio: adc: aspeed: Fix SCU lookup for multi-SCU
 AST2700
Message-ID: <20261018235624.1971e7ff@jic23-hlaptop>
In-Reply-To: <20261005-ast27xx-adc-upstream-v3-0-ef25552d3a59@aspeedtech.com>
References: <20261005-ast27xx-adc-upstream-v3-0-ef25552d3a59@aspeedtech.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Oct 2026 18:22:52 +0800
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> The ADC's reference-voltage trimming data lives in a SCU register. The
> driver has always located that SCU with a global, name-based
> device-tree search, which works as long as a platform only has a
> single node named "syscon". AST2700 splits its SCU into two
> instances, syscon0 and syscon1, that share that same node name and
> differ only by label and unit address, so the lookup always resolves
> to syscon0 even when the ADC's trimming data lives in syscon1.

For now I've applied 1 and 2 to the testing branch of iio.git.
Whilst it is a fix, there is little point in rushing it unless
patch 3 also goes and that one isn't tagged as a fix..

If you want me to move it over to the fixes-togreg branch and
get it in asap, then reply to this to say so.

Thanks,

Jonathan

> 
> This series adds an explicit "aspeed,trim-syscon" phandle property so multi-SCU
> platforms can point the ADC at the right SCU, keeps the existing
> global lookup as a fallback for single-SCU platforms and already
> deployed device trees, and wires the new property up on AST2700.
> 
> Patch summary:
> 1. dt-bindings: iio: adc: Add syscon property for multi-SCU SoCs
> 2. iio: adc: aspeed: Use syscon phandle for trimming data when available
> 3. arm64: dts: aspeed: Add syscon phandle to AST2700 ADC nodes
> 
> Assisted-by: LLM
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
> Changes in v3:
> - Switch the LLM attribution trailer to "Assisted-by: LLM", the format
>   required by Documentation/process/coding-assistants.rst, instead of
>   naming the specific tool/model
> - Move each patch's Signed-off-by to be the last trailer, after
>   Assisted-by
> - In patch 2, use dev_of_node() instead of dereferencing
>   data->dev->of_node, and check the new property with
>   of_property_present() before calling the non-optional
>   syscon_regmap_lookup_by_phandle()
> - Link to v2: https://lore.kernel.org/r/20261001-ast27xx-adc-upstream-v2-0-2f9c15cc0064@aspeedtech.com
> 
> Changes in v2:
> - Rename the new property to "aspeed,trim-syscon": a bare "syscon" is
>   not a generic property per writing-bindings.rst, so follow its
>   vendor,type-syscon convention
> - Reword the property's description to state its purpose instead of
>   restating the schema's required condition in prose
> - Drop the extra AST2700 example added for the one new property
> - Link to v1: https://lore.kernel.org/r/20261001-ast27xx-adc-upstream-v1-0-5ace57533418@aspeedtech.com
> 
> ---
> Billy Tsai (3):
>       dt-bindings: iio: adc: Add syscon property for multi-SCU SoCs
>       iio: adc: aspeed: Use syscon phandle for trimming data when available
>       arm64: dts: aspeed: Add syscon phandle to AST2700 ADC nodes
> 
>  .../bindings/iio/adc/aspeed,ast2600-adc.yaml       | 17 +++++++++++++++
>  arch/arm64/boot/dts/aspeed/aspeed-g7-soc1.dtsi     |  2 ++
>  drivers/iio/adc/aspeed_adc.c                       | 25 ++++++++++++++++------
>  3 files changed, 37 insertions(+), 7 deletions(-)
> ---
> base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
> change-id: 20261001-ast27xx-adc-upstream-34b3d9e8e27b
> 
> Best regards,

