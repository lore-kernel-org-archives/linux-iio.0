Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1FC1C84DE;
	Fri,  3 Apr 2026 12:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775219104; cv=none; b=qrLMuWm/zS5Cad5kvZKv4Cgdfg72h3ACiBkxZRY74eU5n1IU675LxsppcZKeEzksf72xNrUpFj9XyHM2pG13GcDzf0dWhUeNnQOwGcbhqFVghThM/XWApyXk17VQXx/7pL4/OTxrBznXB/ZkXKwg2ydv7nLF9GDZfz71dOtVu0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775219104; c=relaxed/simple;
	bh=YBB0a5Z0US+tCgH29GBJlYwUGww6QrhiSOHrdpyPaNo=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=mLe18e7R5T6cEhY8kqzXvfHjauXJ/DimYXOX8fgv0d53z6Ni8OtKE+8kCIJQ6dwxmLsXqslc0wwmrb4kuCKJDvEKJB56Q4BRD0bqnKzWERZDi2zFvJelcl4+NaO20XPYIl2UVc7TparQSQ407Z45LcQpd6TDLde4Waeu97okyOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uai9vXXy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uai9vXXy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96408C4CEF7;
	Fri,  3 Apr 2026 12:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775219103;
	bh=YBB0a5Z0US+tCgH29GBJlYwUGww6QrhiSOHrdpyPaNo=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Uai9vXXyLyf6xKfUGk/qXBMZpLUymY+LVPJdKAuKYKFWKNIkRjqg2CKaXZ4OldSnm
	 pJ1Hs2HuxY2CoqnSj+RyJOd+qLQkXszyao4NdUJlFHYPI/qC8Yfl/61SW5eMvk3e+W
	 XrJTiU7zTbwdRNM+H0laEnihdOM3TAGRvRMs7s+Dsw0t8E1hkm/hAUAsSE1vSeE/Lf
	 5xA3n2drPpSEvZsw018vFo596mCGsHFwN8lGqAZxmIw26FZOdB1Lxf7d5zufMWRdul
	 LCPulyK8z9jule6rj+E/CX1TWrUEFudB+3tM2E8MEJcB2YNCUu1LIeaK7SikfZAfEw
	 YdV/USXxDRYhA==
Date: Fri, 03 Apr 2026 07:25:01 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
In-Reply-To: <20260403-mcp47feb02-fix2-v1-1-da60c773550e@microchip.com>
References: <20260403-mcp47feb02-fix2-v1-0-da60c773550e@microchip.com>
 <20260403-mcp47feb02-fix2-v1-1-da60c773550e@microchip.com>
Message-Id: <177521910182.3087622.7420461822795760783.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: dac: add support for Microchip
 MCP48FEB02 to MCP47FEB02


On Fri, 03 Apr 2026 13:50:13 +0300, Ariana Lazar wrote:
> This is the device tree schema for iio driver for Microchip
> MCP48FxBy1/2/4/8 series of buffered voltage output Digital-to-Analog
> Converters with nonvolatile or volatile memory on top of MCP47FEB02.
> The families support up to 8 output channels and have 8-bit, 10-bit or
> 12-bit resolution.
> 
> The I2C (MCP47F(E/V)BXX) and SPI (MCP48F(E/V)BXX) DAC families were merged
> into the same dt-binding file.
> 
> Fixes: 4ba12d304175 ("dt-bindings: iio: dac: adding support for Microchip MCP47FEB02")
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
> Link: https://lore.kernel.org/all/20260216-shiny-itunes-00a31d1f4db7@spud/
> ---
>  .../bindings/iio/dac/microchip,mcp47feb02.yaml     | 291 +++++++++++++++------
>  MAINTAINERS                                        |   1 -
>  2 files changed, 217 insertions(+), 75 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml:245:22: [error] string value is redundantly quoted with any quotes (quoted-strings)

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.example.dts:22.20-39.13: Warning (i2c_bus_reg): /example-0/i2c/dac@60: I2C bus unit address format error, expected "0"

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260403-mcp47feb02-fix2-v1-1-da60c773550e@microchip.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

