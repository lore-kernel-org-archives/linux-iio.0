Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296D03016E0;
	Mon, 18 May 2026 10:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779099716; cv=none; b=s0BQHAkbyhY/EV2oglayTJYnQnfcXwWmRa+u1uk28PbFHaAr5z5d0OT5AMpacGAX+popPNQOesuNTrDM/cTOKSlGUEHrQqPpOByCbfzDEJnA5YsYWPX6ksrt9kuOoppOjWyNGFCESZekuR2V2uZNvmm6US9Zg+6BC3LG/TrcLAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779099716; c=relaxed/simple;
	bh=+FPo66jE+nctTTtZTU3eJuQuezapEFOt7TMcMbyptjM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=gF8uIHcLaWNOq6WiAviCB27a3ldQaXZshhkljqylHKbBB29F/k28+2NB0KmOoAQ4NDWfWFtbfaFn2w0WrhjHC7sAvggo8IlOhcd7C5oMX2JT3b++6ak1HnLcBTBothuW9rOIOGXoJXi/IGQKX1zEwLysc8ry0e/p4x2DPat11kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1emaE7I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1emaE7I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3066C2BCB7;
	Mon, 18 May 2026 10:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779099715;
	bh=+FPo66jE+nctTTtZTU3eJuQuezapEFOt7TMcMbyptjM=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=d1emaE7IlTHoepeHuTu3DfXFiazwE1+KRQ2ZE9uqvQ8PVePdOzl6dFU724vsisFVF
	 Ui7T8ceJ36nNCVoze4JeCtDN3FW1UwNfvqs4zWkTLoBE9OLc0vKHbGs6fHX7gI3Sra
	 CMowlIUP2W//SmRp2h7wrmFVjUmKcN/lmN/9ys3PoXJAc09DItlDK6uBXbnKXaX5VO
	 uUpNqQOfKlyX5ohGw+91FNgcBvagj4BZ7iNJVFEbgQ+k3lmFQyqkm2M+1IrkwXaMTi
	 ndi73Gyxbcc3yGCK1HO9P7wNsWTWD8I7241lGfW3LPDJRuHf6x+RR0Yzowdb56zHlo
	 QBvc30+kNN+1w==
Date: Mon, 18 May 2026 05:21:55 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-iio@vger.kernel.org, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, devicetree@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Andy Shevchenko <andy@kernel.org>
To: Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <20260518081852.116909-2-xingyu.wu@starfivetech.com>
References: <20260518081852.116909-1-xingyu.wu@starfivetech.com>
 <20260518081852.116909-2-xingyu.wu@starfivetech.com>
Message-Id: <177909971503.1256833.12911438583081090451.robh@kernel.org>
Subject: Re: [PATCH v1 1/2] bindings: iio: adc: Add StarFive JHB100 SARADC


On Mon, 18 May 2026 16:18:51 +0800, Xingyu Wu wrote:
> Add the new documentation of SAR-ADC for the StarFive JHB100 SoC.
> 
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---
>  .../iio/adc/starfive,jhb100-saradc.yaml       | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/starfive,jhb100-saradc.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/starfive,jhb100-saradc.yaml: properties:reg: 'anyOf' conditional failed, one must be fixed:
	'maxItem' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	'type' was expected
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/starfive,jhb100-saradc.yaml: properties:reg: 'anyOf' conditional failed, one must be fixed:
	'maxItems' is a required property
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	'maxItem' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	Additional properties are not allowed ('maxItem' was unexpected)
		hint: Arrays must be described with a combination of minItems/maxItems/items
	'maxItem' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
	from schema $id: http://devicetree.org/meta-schemas/cell.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260518081852.116909-2-xingyu.wu@starfivetech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

