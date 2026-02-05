Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E319B305E01;
	Thu,  5 Feb 2026 18:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770316938; cv=none; b=jIBWDuKFASgPP8FPUYdPOMVEYOMTEfBrw4AdeO/W9oDoR/GMcMf5ygMk86n7SiJZmebFI92t6aRgE2eZs1YkctCHS/8OvuKS3wE7SdySCyEQcsvlWHWclfySfvcu0OUkqRnEZhyX7mHObZfFjosbc5kjh0R4D8qs/t3mwJaqUc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770316938; c=relaxed/simple;
	bh=Uyt29Sm4Nu3Uzv9llDir3IcWj7UstP5pqref+2nh6Bg=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=A9F8c0VBxR3HdayQSUZ582DXmjNWxsnHKRgoyrAd0eGFxYYNzuGacLhqtHJOc4s7ftNwTN3QREtRI6javdGqUYDkGww9DCc7kghWl+c+hs9tNtP9qV53pjB8pS6kZjeVeQXzlOraBolBTzxVd2+UyBAdcf0GMe/fVGIdeY8rlO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUM7DQVY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUM7DQVY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55EB0C19421;
	Thu,  5 Feb 2026 18:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770316937;
	bh=Uyt29Sm4Nu3Uzv9llDir3IcWj7UstP5pqref+2nh6Bg=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=JUM7DQVYQEQcQr0mhOUyuqBjFzvtAot2+3VM7iSCkKlpmVRxpPU8dztzYnUphTisg
	 r5t3GrDguea7xLFcHA4FvLIoJ1hfbI9AAlfkWmOQfQi/Rxz2NYcV7sf0H58CXzHLCS
	 dFTxuc70I8Yi19/6xyGb3Gb+v8he9bb1uAJyaoNu75Rk/g5mSElOx6dYbZL0NbYdLM
	 Wdt3gqhwBsXiKPz37a46X9dbAyes7LpB4Hl3TAWn1GJAglCgZNC8dKEu0hOFRp1o9K
	 yeSAHnYc8g44/ZaoT8DnUvY5FPPqSySULsw4GZKYbW3E5l6yHf1Y5trNM/XfJENJoo
	 /szEotAPfluEw==
Date: Thu, 05 Feb 2026 12:42:16 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: michael.hennerich@analog.com, conor+dt@kernel.org, 
 dlechner@baylibre.com, marcelo.schmitt1@gmail.com, eblanc@baylibre.com, 
 linux-doc@vger.kernel.org, krzk+dt@kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, jic23@kernel.org, corbet@lwn.net, 
 nuno.sa@analog.com, andy@kernel.org, devicetree@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
In-Reply-To: <4b879f53450e87739afc0dbd832dab5a3f83efb1.1770309522.git.marcelo.schmitt@analog.com>
References: <cover.1770309522.git.marcelo.schmitt@analog.com>
 <4b879f53450e87739afc0dbd832dab5a3f83efb1.1770309522.git.marcelo.schmitt@analog.com>
Message-Id: <177031693646.1530107.11962546739352301287.robh@kernel.org>
Subject: Re: [PATCH v7 6/8] dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216
 and ADAQ4224


On Thu, 05 Feb 2026 13:48:55 -0300, Marcelo Schmitt wrote:
> ADAQ4216 and ADAQ4224 are similar to AD4030 except that ADAQ devices have a
> PGA (programmable gain amplifier) that scales the input signal prior to it
> reaching the ADC inputs. The PGA is controlled through a couple of pins (A0
> and A1) that set one of four possible signal gain configurations.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Change log v6 -> v7
> - No changes.
> 
>  .../bindings/iio/adc/adi,ad4030.yaml          | 70 +++++++++++++++++--
>  1 file changed, 65 insertions(+), 5 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml:139:1: [warning] too many blank lines (2 > 1) (empty-lines)
./Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml:142:1: [error] duplication of key "allOf" in mapping (key-duplicates)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml: ignoring, error parsing file
./Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml:142:1: found duplicate key "allOf" with value "[]" (original value: "[]")
make[2]: *** Deleting file 'Documentation/devicetree/bindings/iio/adc/adi,ad4030.example.dts'
Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml:142:1: found duplicate key "allOf" with value "[]" (original value: "[]")
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/iio/adc/adi,ad4030.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1587: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/4b879f53450e87739afc0dbd832dab5a3f83efb1.1770309522.git.marcelo.schmitt@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

