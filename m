Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3761D5CFE;
	Fri, 31 Jul 2026 04:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785472343; cv=none; b=sVHloJs/QKuZDlAAdpMzBNk6iJ/7G0ZxGfvtmlryil4EGpUbgcpEgJpj/H/6Hlhj8bYk3lk5+vqTrbtxA+/kwX/n2D6VsQhfCmj253o7S1IC7JXOeGT26tDpgAdXLe+BoWNm9qRM8iG0tLay+KWIbNLIiJ6H/ZIfIMnp4dYykZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785472343; c=relaxed/simple;
	bh=X+roWFSN9q9wAMDayMWUsz/I5RDfVwLQZrg3X5E3EpM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=F1wrS+q7pUkOAMcNlW3lozNFxUytDlqDWFC1GTSTGjdZkeXg8g5TO1Z+4anMUIgCI8DbFYo2rt9R+4EbLC9hdIR30FTr+8KsppDuU+NAY1cy4KSHaNdGfolXLkMgXwbDQsDLsFmjx7KP27iDu7k0u0ioQSPhmG8IoJZBig4R+hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsVvs3JS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsVvs3JS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCA81F000E9;
	Fri, 31 Jul 2026 04:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785472342;
	bh=PghJxRzb05xscJ08yhU/aH3P/ezQ8OakJRmokm95+PY=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=QsVvs3JSvAvWXngKT35/yW6dX22OmEWW4mKYPMoWaPsDZ2gSqjpFvB/T4OsOlDEEe
	 U/HTfqTRecGajxAiFH0S1PhbwdiZ1UgIgkubyRIkzYIYs9mI5pM27bpL6zAlmiu/kZ
	 6dT6tJatQu1HmfOxeUwTl9HaBz/0hZ5N/GHn3ru3VK4ul5yBBe/5wHzkggyzcssAxp
	 fw76hadWnNmAjO/zx3M/ISOKj4nFRxhC+McuesmafzPxhwioYJSsUA570Gefi9JQQy
	 HFoW6tlbNeC24Bs2ibuMnlRRpfS7P6d/uHw+eZk4+F9QyqGN1bawZI2z29jN9jx3MB
	 ttUIgTjStDN8g==
Date: Thu, 30 Jul 2026 23:32:21 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
To: Kyle Hsieh <kylehsieh1995@gmail.com>
In-Reply-To: <20260731-ti-ads112c04-driver-v2-1-aab0168c3c01@gmail.com>
References: <20260731-ti-ads112c04-driver-v2-0-aab0168c3c01@gmail.com>
 <20260731-ti-ads112c04-driver-v2-1-aab0168c3c01@gmail.com>
Message-Id: <178547234112.2038676.6805487929501076296.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: ti,ads112c04: Add
 binding for ADS112C04


On Fri, 31 Jul 2026 10:58:24 +0800, Kyle Hsieh wrote:
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
>  .../devicetree/bindings/iio/adc/ti,ads112c04.yaml  | 122 +++++++++++++++++++++
>  1 file changed, 122 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,ads112c04.yaml: properties:ti,refp-refn-resistor-ohms: '$ref' should not be valid under {'const': '$ref'}
	hint: Standard unit suffix properties don't need a type $ref
	from schema $id: http://devicetree.org/meta-schemas/core.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260731-ti-ads112c04-driver-v2-1-aab0168c3c01@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

