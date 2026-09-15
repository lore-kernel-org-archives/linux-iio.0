Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3B73AFAE4;
	Tue, 15 Sep 2026 21:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789509479; cv=none; b=I1jVeJ+OUfdil0dF38r1hgnNQdsEvFgTEG4ZFWTho2zv0+hgi/i3m95UqmvE0C+VcpQx0VGlJ4plSrVd9l/XGzeHIuLvOOfp1VxdTc+Sma85TJhYHRpRXbub7ASveM/q2tt+sZ+GIzFjY1fME4Xpc1Uo59O5DkAichUR4E/H+uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789509479; c=relaxed/simple;
	bh=c9FNjidYRpzmo6Gku2fXGaQEd3TRWNbz3TC1EnRggAk=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=CoqEvwnx3wIbE1L2uBluLHfwxCVpMGAQf57tbnzn/yLNifamrzDW9uAI4IjoRpLUdAEzIy7hTW6u/KRFhWooSuqS1nfprAXB4uUcZXL31BC+3pZsTex1V29uzKzzG1tjgu9IpQICMgFzFdZPm3YuYEbiHfZyd7lCGjm9d6ihEFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VULiWsnl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VULiWsnl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8041D1F00893;
	Tue, 15 Sep 2026 21:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789509477;
	bh=JMXYKPbpMX9jyyhWzfITNykjkmXaQ+clb1/gzDQT4EE=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=VULiWsnlcY9IVEf5kQDkg8XQHiLtLfyLK78DG+0eqYuPb7yjm+j4d5my/8WmbHDeB
	 GVrVY6vSwBf69Vfy87BJvVkiGxqofA8NpU8zedo+Rpp+yqH/dmKvd7bCt+VgLuEkuS
	 dzdzj7ZpPrcUzZHRBqi/IsSyUe6+Zc85lRqdH8FpifbxQ78f2FUR6LfDYFAunihi0P
	 VbBJ8TefTSxVEkp9yRUm6Me0xS2vW0y8pwHW07Y6eTyWexK24xSwUc6HcW6Ysu6UrH
	 CKQNhRZIXmWVN0L/yG2JElJoqaZ9uY27Gq1yLy2yR52MadPhTV9tfHf4JQy+aKyZhK
	 AfAm/kbYq+4IQ==
Date: Tue, 15 Sep 2026 16:57:56 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: jic23@kernel.org, linux-kernel@vger.kernel.org, linux@analog.com, 
 skhan@linuxfoundation.org, dlechner@baylibre.com, linux-iio@vger.kernel.org, 
 krzk+dt@kernel.org, devicetree@vger.kernel.org, nuno.sa@analog.com, 
 corbet@lwn.net, conor+dt@kernel.org, marcelo.schmitt1@gmail.com, 
 Michael.Hennerich@analog.com, andy@kernel.org
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
In-Reply-To: <304d10f12a3418fbd5598160609a6eda09ed4100.1789494473.git.marcelo.schmitt@analog.com>
References: <cover.1789494473.git.marcelo.schmitt@analog.com>
 <304d10f12a3418fbd5598160609a6eda09ed4100.1789494473.git.marcelo.schmitt@analog.com>
Message-Id: <178950938555.3847339.14843070346355086541.robh@kernel.org>
Subject: Re: [PATCH v2 09/15] dt-bindings: iio: adc: adi,ad4134: Document
 SPI connection mode


On Tue, 15 Sep 2026 16:14:44 -0300, Marcelo Schmitt wrote:
> Document how AD4134 chips are connected to the host SPI controller
> according to different wiring configurations.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Change log v1 -> v2:
> - Set default for adi,spi-mode property.
> - Added '#daisy-chained-devices' property.
> - Documented constraints for adi,spi-mode + #daisy-chained-devices combinations.
> 
>  .../bindings/iio/adc/adi,ad4134.yaml          | 51 ++++++++++++++++---
>  1 file changed, 44 insertions(+), 7 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml:174:24: [warning] too few spaces after comma (commas)
./Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml:180:24: [warning] too few spaces after comma (commas)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/304d10f12a3418fbd5598160609a6eda09ed4100.1789494473.git.marcelo.schmitt@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

