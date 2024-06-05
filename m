Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6788316C69C;
	Wed,  5 Jun 2024 23:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717631562; cv=none; b=Ow3YmQi/9250NjL65XkI4rZkRYGYgpficM5mE++zK264sqByo0xaikAkUx/ow7HclbtVvcYOYRqvbhu8AwVu21hu0na9mZusO+OFUttKj73ZQl0+oQ1DSygN9HliInXY1yLkl2wxl/CQFckPCePJ99r2v9IJidEMwAp3Igpmy4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717631562; c=relaxed/simple;
	bh=D40azPYuyjyFS271o7gUSoGXiWfbnmEKNZnN0GolfHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lR5faAUnvi3qpx7xlyI5FHYkPGcyhPJ56T4JtuAhtQt2yGwikz5pHTDV8cSj7ZYcWu4DZaGiVjZOX4dHpIFvu740yZYfYisvQzeDe0KDHy4RMyqW8NhR7HVVfv/xs2mjSMGWMrRNimEzUq7dSWAiP+dURxOoKvOvJ1JatiVKxR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BINy/SMU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BINy/SMU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859B8C2BD11;
	Wed,  5 Jun 2024 23:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717631561;
	bh=D40azPYuyjyFS271o7gUSoGXiWfbnmEKNZnN0GolfHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BINy/SMUuVd1h84CY5U+AbCTUyILx9goti7b30aQo5Q5BvQcS4JYjAU4IHTcR4dCF
	 9lKVnAAOyf6xsHTs0DSBK8hcRxMSq8BENGCOkHcq8RyhRlsvFz1RJvyV7/Dztsc/BW
	 pJEcxTv5J1Nj4MjJqezZX2U52uB10zHESfmFTS8vNbeZ1BvGywkmQsnr6lFz5vdyRn
	 DPgTuXCU9bhQfOihQ+eeT/rhVM5CK3fLP91daf5q2qdUutBaoMt4p5yimflWAWAGvx
	 cYlpHnW8FEk1LbsUOnrOmLFheGUobQISH6CuLY71M0A+RAVIgGC7DCaVe31MWJO+nz
	 7w2RT3bfPB9BA==
Date: Wed, 5 Jun 2024 17:52:39 -0600
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: jic23@kernel.org, lars@metafoo.de, krzk+dt@kernel.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com, lee@kernel.org,
	andy@kernel.org, nuno.sa@analog.com, bigunclemax@gmail.com,
	dlechner@baylibre.com, marius.cristea@microchip.com,
	marcelo.schmitt@analog.com, fr0st61te@gmail.com,
	mitrutzceclan@gmail.com, mike.looijmans@topic.nl,
	marcus.folkesson@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, andy.shevchenko@gmail.com,
	kernel@collabora.com
Subject: Re: [PATCH v2 1/5] dt-bindings: iio: adc: Add MediaTek MT6359 PMIC
 AUXADC
Message-ID: <20240605235239.GA3455504-robh@kernel.org>
References: <20240604123008.327424-1-angelogioacchino.delregno@collabora.com>
 <20240604123008.327424-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604123008.327424-2-angelogioacchino.delregno@collabora.com>

On Tue, Jun 04, 2024 at 02:30:04PM +0200, AngeloGioacchino Del Regno wrote:
> Add a new binding for the MT6350 Series (MT6357/8/9) PMIC AUXADC,
> providing various ADC channels for both internal temperatures and
> voltages, audio accessory detection (hp/mic/hp+mic and buttons,
> usually on a 3.5mm jack) other than some basic battery statistics
> on boards where the battery is managed by this PMIC.
> 
> Also add the necessary dt-binding headers for devicetree consumers.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../iio/adc/mediatek,mt6359-auxadc.yaml       | 33 +++++++++++++++++++
>  .../iio/adc/mediatek,mt6357-auxadc.h          | 21 ++++++++++++
>  .../iio/adc/mediatek,mt6358-auxadc.h          | 22 +++++++++++++
>  .../iio/adc/mediatek,mt6359-auxadc.h          | 22 +++++++++++++
>  4 files changed, 98 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
>  create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6357-auxadc.h
>  create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6358-auxadc.h
>  create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6359-auxadc.h
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
> new file mode 100644
> index 000000000000..6497c416094d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
> @@ -0,0 +1,33 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/mediatek,mt6359-auxadc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT6350 series PMIC AUXADC
> +
> +maintainers:
> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> +
> +description:
> +  The Auxiliary Analog/Digital Converter (AUXADC) is an ADC found
> +  in some MediaTek PMICs, performing various PMIC related measurements
> +  such as battery and PMIC internal voltage regulators temperatures,
> +  accessory detection resistance (usually, for a 3.5mm audio jack)
> +  other than voltages for various PMIC internal components.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt6357-auxadc
> +      - mediatek,mt6358-auxadc
> +      - mediatek,mt6359-auxadc
> +
> +  "#io-channel-cells":
> +    const: 1

Why do you need a node here? Just add #io-channel-cells to the parent 
node.

> +
> +required:
> +  - compatible
> +  - "#io-channel-cells"
> +
> +additionalProperties: false
