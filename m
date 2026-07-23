Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8514B3DDDDD;
	Thu, 23 Jul 2026 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784793500; cv=none; b=JOQg2ufOaBDTf3YG0ZdFuenxqZxuksTQE+TkCANn2O4YwFutqymXENPkFP9j1Pc/h5+tVqEpxv/1N2d6+b+ySEWLAF86U2ojTvU9MzkrbB01ywnbAAWiee6YBrE3ylNJicbJaGpof0lfsnunVn8NtkQIopEU0UEXVJo6krsiF84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784793500; c=relaxed/simple;
	bh=ZrGvBrfldM5HeKW1DGMLHy59bgjBGrayD0w+nscmK/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uH1jH2X/CR1JdkIloHoOn/GB6TKJtEZOkI7joemGH42VQMP3NnGm7B9/67qTvr1f1fFgplME7v1fZ5v/uW9f6YLYCNgQx2huV2d94YP46HavoD6e4wUqR3UmFDDyB6AbnPKPJirQZMWR5LJL/a27OHIL3iROMbXbLyzatzjbCy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uw+7X5f7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uw+7X5f7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44801F000E9;
	Thu, 23 Jul 2026 07:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784793498;
	bh=BnBB1leXWrpVSe12AUqr3E5yFmk1IsW+d4n7EPWiWoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Uw+7X5f7380AA8r4psKrxIMIIc8HGf5aEUyAizbWITcwBtd9dc/yB34Kv0zFs6isz
	 XtnZ4s9HWpg8YjFSXjCLGq/moFmiPjXLlrq8E9qQg7KumRBZN9tGcncAx4fJKJzIA9
	 cD0eE/Gy7PmzG5T5276RwjmCG8w6QwuHUWAtOfhJdPxS4gQHYsNvdo7Q/XT3qWOdtL
	 pYhHBAFfpmkR2VE5lmzOEehYAzGDdRnplVDEp2rhdHPwUNfM8zmegAuBuwJfZZtHvH
	 Ga6kz72wO/kaK/1tQkATK2eivS20NuQABwzEuh8/LqmguQv1pFrnzMiVNo93UDvEGH
	 lmW0iiQ+cwReg==
Date: Thu, 23 Jul 2026 09:58:13 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Siratul Islam <siratul.islam@linux.dev>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Luca Weiss <luca.weiss@fairphone.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: magnetometer: add QST QMC6308
Message-ID: <20260723-able-mature-corgi-fdc86f@quoll>
References: <20260721134843.7484-1-jorijnvdgraaf@catcrafts.net>
 <20260721134843.7484-2-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260721134843.7484-2-jorijnvdgraaf@catcrafts.net>

On Tue, Jul 21, 2026 at 03:48:42PM +0200, Jorijn van der Graaf wrote:
> Add device tree bindings for the QST QMC6308, a 3-axis anisotropic
> magnetoresistive (AMR) magnetometer. It is an I2C device with a single
> supply and no interrupt pin, at I2C address 0x2c.
> 
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
> ---
> v2:
> - Spell out AMR (anisotropic magnetoresistive) (Jonathan).
> - Drop the package mentions from the description and commit message
>   (Jonathan).
> - compatible: enum -> const (Jonathan).
> - Use the current GPL-2.0-only form in the SPDX identifier.
> - Kept as a separate file rather than folded into
>   qstcorp,qmc5883l.yaml - the two schemas share only
>   compatible/reg/vdd-supply; see the cover letter.
> 
> v1: https://lore.kernel.org/20260714202842.340293-2-jorijnvdgraaf@catcrafts.net
> 
>  .../iio/magnetometer/qstcorp,qmc6308.yaml     | 47 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/qstcorp,qmc6308.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/qstcorp,qmc6308.yaml b/Documentation/devicetree/bindings/iio/magnetometer/qstcorp,qmc6308.yaml
> new file mode 100644
> index 000000000000..6201a44cfe38
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/qstcorp,qmc6308.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/magnetometer/qstcorp,qmc6308.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: QST QMC6308 3-Axis Magnetic Sensor
> +
> +maintainers:
> +  - Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  QST QMC6308 3-axis anisotropic magnetoresistive (AMR) magnetic sensor
> +  on I2C bus, with a single supply and no interrupt pin.
> +  https://qstcorp.com/upload/pdf/202202/13-52-15%20QMC6308%20Datasheet%20Rev.%20F(1).pdf
> +
> +properties:
> +  compatible:
> +    const: qstcorp,qmc6308
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +  mount-matrix: true
> +
> +additionalProperties: false

This goes after "required:" block.

No need to resend just for these.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

