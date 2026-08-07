Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C3B391E78;
	Fri,  7 Aug 2026 15:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786116808; cv=none; b=MAFRbEv4r3iYQyFHIOkjH/sssTIHD3ARDoN7h7uGWY0vAVGJXIIbNJ9/4rq4ZLVpxYAEPpVkxRIV5SF40bmZYOl7mQbeX+++8uUC492EYuYw7mW0JR0JSjaCs5LgZ80LTto5nHCDMNOh9W9wuqiyKuImWlV7F7q6v0NGlm2K2Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786116808; c=relaxed/simple;
	bh=GIEiK05Nom+qEoO8rJtHY6/3b/aMljXPNpLDKfgWSGc=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=KCu8T8zaznVno9IvWJXO7Q+89ReowoRQSu5ZHcVOMgJSUCYgPhz5KQy0Z6p7272yt6CrMGdpTQwk3XmfV+zmfRNDJ6SJJlD613/ge+H6MpGriFfFG57nBFoHFV6R/STOz1rA9pnrfTbhWUg+CAES/b77guPX3NJDI1zrVoOYw18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9g9wxOm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9g9wxOm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6301F00A3A;
	Fri,  7 Aug 2026 15:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786116806;
	bh=uFaznGFZBtvYN/SwpFFQxtWNFdkN9SzRACt4UXCaOXA=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=B9g9wxOmv4wAy+FIpJz2GgAraoLPrHN+G/LHhzmL0A9Lsmm7N8d7/h66rVI+gd3iv
	 dTssVOVYz0HdKTtUNwwKGTFI78qOMnM84zFUjLN8AiIiZ+o57wEb2EYu5/sPKxNKaS
	 VPGD4WBUWxb2WZDgGy83UCrgSDeP+5UbFHqVLF6nBi4sBrq4q7wPN2cy7AxXnm892r
	 anSIBGGDYL56BdgBKgYcreb7KSfDZSgLhCA5yJ+71R1p500m35YwXITZrPN79ZSk7+
	 HsXG+GLRcvPXQ7HXuk8+nlHDtWVcfXD/n7S4rqjQo2NyJRWJMsZc8xN6vZAKJt479K
	 lzqsIMEdy3uAA==
Date: Fri, 07 Aug 2026 10:33:25 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 David Lechner <dlechner@baylibre.com>, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20260807-veml6031x00-v5-1-e60876fb3640@gmail.com>
References: <20260807-veml6031x00-v5-0-e60876fb3640@gmail.com>
 <20260807-veml6031x00-v5-1-e60876fb3640@gmail.com>
Message-Id: <178611680583.795603.2821287551440090670.robh@kernel.org>
Subject: Re: [PATCH v5 1/4] dt-bindings: iio: light: veml6030: add
 veml6031x00 ALS series


On Fri, 07 Aug 2026 15:51:52 +0200, Javier Carrasco wrote:
> These ambient light sensors share their properties with the ones
> from the same manufacturer that are supported by this bindings.
> 
> Note that only two datasheets are provided as every one of them covers
> two devices (veml6031x00/veml60311x00 and veml6031x01/veml60311x01).
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  .../devicetree/bindings/iio/light/vishay,veml6030.yaml      | 13 ++++++++++++-
>  MAINTAINERS                                                 |  5 +++++
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml:10:1: [error] syntax error: could not find expected ':' (syntax)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml: ignoring, error parsing file
./Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml: error loading YAML: while scanning a simple key
  in "./Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml", line 8, column 1
could not find expected ':'
  in "./Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml", line 10, column 1
./Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml:10:1: could not find expected ':'
make[2]: *** Deleting file 'Documentation/devicetree/bindings/iio/light/vishay,veml6030.example.dts'
Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml:10:1: could not find expected ':'
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/iio/light/vishay,veml6030.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1669: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260807-veml6031x00-v5-1-e60876fb3640@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

