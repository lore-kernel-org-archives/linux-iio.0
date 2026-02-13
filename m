Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA528239E80;
	Fri, 13 Feb 2026 16:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771000462; cv=none; b=p+gGx5CyjlVRRVXEHRolGw3mk83EnecM/Uf5ev/MtAEvpIZzMa+gIwIiaWMdG7+TGjIi3/sqUEpCeRc7SyfcNoWMXFvRb6f4q5mQXawUfuY+4qLrHVgkxOcmmdbx92lGFg+ODTZ4A0QrLsuJqM83ib5RWil8CuwEKX3Rl7Qvu4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771000462; c=relaxed/simple;
	bh=Kkdod7hb3K76yUSE/jsadmgTv+XGZsX6Vv91Exo4iA8=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Jow6GlUTC9+epoIf4E9IHsH3M3sbWhHEcqcm2dIm/ELV4RlBSUTof2mut4dBA0Per+p3VezzL9vFcwfcs6loOjDllt99BOG7l9Vk09wwRsYwekQIzy5dnMoVqB3D25rgnQmEn8z2YkBStg5tr0LiZ/bgHRzuNuiwmokY7t3FKi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjC4l5bc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjC4l5bc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02280C116C6;
	Fri, 13 Feb 2026 16:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771000461;
	bh=Kkdod7hb3K76yUSE/jsadmgTv+XGZsX6Vv91Exo4iA8=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=SjC4l5bcc8O0QDk0Yk1Th4TuqtK6E11cY6V/R7j5e+GVXNRYWvojim8j4UWC8YLU5
	 dpjpsnNjJaS02iHl3ZYrf1KIlDOusZsxgJhv4yOqiqK9jW5HIcWQNEGYJW62esVyga
	 /807sI4pIQrEDWX6N9/aodoytKQ/CQ5+EmN+7dDEcKjqopnSFkS/4uVbe1pzTdYnMl
	 05qabsf0UK+0XpI4Iux2tRu5dqFCd5w/Na6JPYt/CVRX1D9AgFDFG/X4kri+g1LdPs
	 k+6wSWx4xRMbqlrQmWUIaRfJ3iv+G53iUUsJfK6Nplll0Kg0L2xaNHbu4WYHKHmqiA
	 keZeDCIRW2j0g==
Date: Fri, 13 Feb 2026 10:34:19 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-spi@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 linux-iio@vger.kernel.org
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
In-Reply-To: <20260213144742.16394-5-antoniu.miclaus@analog.com>
References: <20260213144742.16394-1-antoniu.miclaus@analog.com>
 <20260213144742.16394-5-antoniu.miclaus@analog.com>
Message-Id: <177100045980.2534776.8079356391569945808.robh@kernel.org>
Subject: Re: [PATCH v3 4/5] dt-bindings: iio: adc: ad4080: add AD4880
 support


On Fri, 13 Feb 2026 16:47:36 +0200, Antoniu Miclaus wrote:
> Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC
> with integrated fully differential amplifiers (FDA).
> 
> The AD4880 has two independent ADC channels, each with its own SPI
> configuration interface. This requires:
> - Two entries in reg property for primary and secondary channel
>   chip selects
> - Two io-backends entries for the two data channels
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> Changes in v3:
>   - Add items descriptions for io-backends entries
>   - Fix reg example format: reg = <0 1> -> reg = <0>, <1>
> 
>  .../bindings/iio/adc/adi,ad4080.yaml          | 54 ++++++++++++++++++-
>  1 file changed, 52 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml: properties:io-backends: {'minItems': 1, 'maxItems': 2, 'items': [{'description': 'Backend for channel A (primary)'}, {'description': 'Backend for channel B (secondary)'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260213144742.16394-5-antoniu.miclaus@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

