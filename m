Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA863D47B0;
	Thu, 19 Mar 2026 13:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773926526; cv=none; b=Ai33HWCcLUZgp6QlhWX4q+1mEX4+/RmgFRxbGJzdai4K1/cg5UdBEBWGYbpOIr/ZK12egh3n+EbF7BbaKl63zs9nb2XqsB11/pi9IrI0cianXTY5bWxoz3x5dvw4uDWCTX31wkk7Dqn8Y8XmyZ9Qd9V1C7b7tP/+5lIkXyfyYsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773926526; c=relaxed/simple;
	bh=vQhVWR7cnljcBAQ+FqNmBa875xO5JBP0pYkOmwNY/fA=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=IKVkFLRHFX6K0hJXqmnrYtkKYv1y2GktlhkKd3i+yWJMyHkFYU1Ov1C3YQ/QZD+7LQIU5lX2aUHfh/EZbSBkyOqUbZKjieqvyTiocZjono7nHwFQtqkiHSav0f0iLoO27/JXLqxHoB1yEV0o2gNuvAdK+yUkYafXVA2ovCnLYbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VojmOK/J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VojmOK/J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0610BC19424;
	Thu, 19 Mar 2026 13:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773926526;
	bh=vQhVWR7cnljcBAQ+FqNmBa875xO5JBP0pYkOmwNY/fA=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=VojmOK/JVolCTphrZHzD2ZbAyLQ9GxQsP17ENAmQw/b5E2wW1HTW0/pOs/DYsfu0O
	 dIAzoV4OwPZ+vmLBqcExxY1DcloZPVgthG4jufAujqgdH7BWhxGU0MtY7gqq7K9rC3
	 5xzYXDxPtVRAjUoX0qz6NbAYgLrAtWLmGX2wsRInuQU4FT3SVplbyG8SInOjj1D4Vm
	 0TaGQwuylrRjnslgBc4wDPn2dUT5mwSIGera9sxQA8KF3ccQ3QyzOqY2u/OWHbtjIU
	 uHILOd5QULrE5l7/XvkLEvIk+vSJxjFdkMAt/D/6m0yurS67EkRaf76wcQj6iLIUMc
	 tUePvIF9JIOqA==
Date: Thu, 19 Mar 2026 08:22:05 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 linux-iio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, 
 phone-devel@vger.kernel.org, devicetree@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>
To: Erikas Bitovtas <xerikasxx@gmail.com>
In-Reply-To: <20260319-vcnl4000-regulators-v5-1-a025d3332805@gmail.com>
References: <20260319-vcnl4000-regulators-v5-0-a025d3332805@gmail.com>
 <20260319-vcnl4000-regulators-v5-1-a025d3332805@gmail.com>
Message-Id: <177392652513.2385567.5373645949337322213.robh@kernel.org>
Subject: Re: [PATCH v5 1/8] dt-bindings: iio: light: vcnl4000: add
 regulators


On Thu, 19 Mar 2026 13:58:39 +0200, Erikas Bitovtas wrote:
> These sensors can accept 2 supplies - one for the sensor and one for IR
> LED [1]. Add supply properties for the sensor - 2 for the sensors and
> one external, for their open drain interrupt line, to ensure the sensor
> is powered on before proceeding with setup.
> 
> [1] https://www.vishay.com/docs/84274/vcnl4040.pdf
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.example.dtb: light-sensor@51 (vishay,vcnl4200): 'vddio-supply' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/light/vishay,vcnl4000.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260319-vcnl4000-regulators-v5-1-a025d3332805@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

