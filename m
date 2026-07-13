Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFCD3A960A;
	Mon, 13 Jul 2026 09:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783935338; cv=none; b=g1RMcdvszGU7lTms2XfibAkVTOZRw4SUnCcdu3vePmb68aBfMJ20mc+6/HS3GPkQ3bAteTGw0Vy17IXssdr/2heUt5BtHBCNhYlP06aBQoopqv6BA5FaqbGX9zsJ8jgaLbbdhYBcyKXZQqOC3ZZrBJslNI8k4pqDN0dqpnxIHCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783935338; c=relaxed/simple;
	bh=H2W/KP8SPA0KLTPvj9PjQ56CIeXVFarLU19pUgwYfmg=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=NITAqgtpY0Eb7mhQqaxWjh5XvaprcIBM2a2TDVFYfpkJIaXRiyTle7Ky1bPvNVQFirkmc1Ax//XFa1Yi1KIZJiGFVfMw79ljLrDFd8O29NSwQKOfYffylvNXo/ZaNp1uutLwXIqlmw1rSmKH/nq1IOjjn1cURHgBqoERTluYZAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJjWcwCp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJjWcwCp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CFC1F000E9;
	Mon, 13 Jul 2026 09:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783935336;
	bh=GgTLQ8uwman0lLyw9cc4IPWO6BS2HmXsRVj/qpzG7AM=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=LJjWcwCpOVWguIJ8+S6Ex3xdAJSBzh57FCfNLUBAfs1hYUYICauAG9fLUO2DbWWQL
	 wDStrijG+9ypPEQQvq33DtfiC2dOplak8cVIzix3BEiioPKyyUQo1ogZn9zqQ51NhH
	 spbXn+4DK3s1JNvdi/Q5ITO1+aS7IJ2GpTTH5oYXeKnBx5IWMJi/NtiIOo5SppG7n1
	 ZVMesfuCl8BE3TqUUBvl5idFY2rkKpIuJT2QTLSYNoCIOzzq6NfDHMa+raoHma1Y7P
	 CC7DtX9ATgOedLyUmXDTq5Uv3KYI3QTTcu4hcKi9ykxFXQQm0XpjqzER/qDv9+MTFu
	 jwqmb7e4mOwdg==
Date: Mon, 13 Jul 2026 04:35:35 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: nuno.sa@analog.com, dlechner@baylibre.com, devicetree@vger.kernel.org, 
 cwweng@nuvoton.com, conor+dt@kernel.org, 
 linux-arm-kernel@lists.infradead.org, jic23@kernel.org, 
 linux-iio@vger.kernel.org, andy@kernel.org, linux-kernel@vger.kernel.org, 
 krzk+dt@kernel.org
To: Chi-Wen Weng <cwweng.linux@gmail.com>
In-Reply-To: <20260713081127.115197-2-cwweng.linux@gmail.com>
References: <20260713081127.115197-1-cwweng.linux@gmail.com>
 <20260713081127.115197-2-cwweng.linux@gmail.com>
Message-Id: <178393533549.3982391.11335351167555265751.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Add Nuvoton MA35D1 EADC


On Mon, 13 Jul 2026 16:11:26 +0800, Chi-Wen Weng wrote:
> From: Chi-Wen Weng <cwweng@nuvoton.com>
> 
> Add devicetree binding for the Enhanced ADC controller found on
> Nuvoton MA35D1 SoCs.
> 
> The controller has one register region, up to four end-of-conversion
> interrupts, one functional clock, and an optional reset line. The
> binding also describes the optional external reference supply and the
> optional DMA request supported by the hardware.
> 
> ADC input pins are described using standard channel child nodes. The
> external ADC input channels are 0 to 7. Differential inputs are described
> with diff-channels and are limited to the fixed hardware pairs.
> 
> Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
> ---
>  .../bindings/iio/adc/nuvoton,ma35d1-eadc.yaml | 163 ++++++++++++++++++
>  1 file changed, 163 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml: properties:interrupts: {'minItems': 1, 'maxItems': 4, 'items': [{'description': 'ADINT0 end-of-conversion interrupt'}, {'description': 'ADINT1 end-of-conversion interrupt'}, {'description': 'ADINT2 end-of-conversion interrupt'}, {'description': 'ADINT3 end-of-conversion interrupt'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260713081127.115197-2-cwweng.linux@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

