Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE92F3DCD95;
	Wed,  5 Aug 2026 06:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785911071; cv=none; b=efPu5RMYrpufu7HpBd7QP6GzW2KIhulenaicKQp9L/w+FyiIgqkRtMiGo8c0x+05USbHVsFgL3c3xhN/fi49wzaITUdIcuErs3UIZWowR12HAqK9Og1QcG/rjahN990AT+9sVjXNUlTUWiH29fq2O3FyUAyAWMMXAoPq98xpz5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785911071; c=relaxed/simple;
	bh=uQ2Q+6F0FF7I/z/X1eMTUDqlHoSIwixHn0WyEmMsxSo=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=UbMq5O/ADQ69dDkoTYMGDBrxBxsZoN7D/u1mb63vyK4cttvn0K7/czhfoAdb61rV2GWId/E2QZk1Q0JSmlF8xyPHycGvnc2z5/HaB6QP1ybrJlstyunWDqk8cw/N08mL+Hrw+1TkqbAFXSwaY6c3Z4F/tKkS2VHBbQ1OgMb9UJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gO9PxLt6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gO9PxLt6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3D81F000E9;
	Wed,  5 Aug 2026 06:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785911068;
	bh=vdcfCaE+GdCDt7MPt+7OmoPBCzRQmSdKUSzw4wTxTPc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=gO9PxLt63N+jeH1YCV8DZBamODyO3nN88k94Wp2KMuSqdDNe8ST/Fl0Fov55C1PLZ
	 lOvC65dp29pyy9l0FaiSkXbXARCIPZAjUYUjOF/fp0xW0MV1bVsjD0nZYhCw1om1Ks
	 z8fPeloiNbLcMHzmGZo5yqkwotKVFH+yh8y1gk8K80bJE2GpRTdfvfawBeMR1Czd6Z
	 0WnYZ6W8WCyoBf51Ro1NW+aCkAURX5CQiRor/0gLQRq5aBOe3Zus3LPvmXM15G5WMw
	 L437GG3gLuzySJif5jlsIEcabLXK9Udj0sF51s+HF4pIVuiy2RC3YNhF/RtXLpwJoT
	 lyd50apahsvEg==
Date: Wed, 05 Aug 2026 01:24:27 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, 
 Andy Shevchenko <andy@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org
To: Kyle Hsieh <kylehsieh1995@gmail.com>
In-Reply-To: <20260805-ti-ads112c04-driver-v3-1-49f436829e01@gmail.com>
References: <20260805-ti-ads112c04-driver-v3-0-49f436829e01@gmail.com>
 <20260805-ti-ads112c04-driver-v3-1-49f436829e01@gmail.com>
Message-Id: <178591106730.3177648.16689407752813401069.robh@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: ti,ads112c04: Add
 binding for ADS112C04


On Wed, 05 Aug 2026 13:38:20 +0800, Kyle Hsieh wrote:
> Add device tree binding documentation for Texas Instruments ADS112C04
> I2C Analog-to-Digital Converters.
> 
> These devices provide 4-channel, 16-bit delta-sigma ADCs with an I2C
> interface, programmable gain amplifier (PGA), and data-ready (DRDY)
> interrupt output.
> 
> The binding uses child nodes to dynamically define the connected
> single-ended or differential channels.
> 
> Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
> ---
>  .../devicetree/bindings/iio/adc/ti,ads112c04.yaml  | 146 +++++++++++++++++++++
>  1 file changed, 146 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,ads112c04.yaml: excitation-channels: missing type definition

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260805-ti-ads112c04-driver-v3-1-49f436829e01@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

