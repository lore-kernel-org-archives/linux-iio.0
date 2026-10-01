Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3483C2796;
	Thu,  1 Oct 2026 16:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790871948; cv=none; b=qgfLQPNXxfNY8CfO/MqqvYTxJElU02tfGuyRd5v8AseltMbIs/DfLXvG+qW6P6223TZSGS9qZOXX3ZUoW8b1ws62Ee9+KtUql4BmrFZ4KmDzTQkDt/Z3P3IQ6RATB7B2K1wG8P3uQq00gFKpQxrWOjF9vO+AONCYZgLw7h4saeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790871948; c=relaxed/simple;
	bh=URkmsViudXfOI5qlu1XnpJjvODhZrUCyrYuyKlIHFCQ=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=BkCrLVmrhM+flnmkMfeuFtGmk/XnkGtvXztvu1mNycPTHp1CBqO1rI5tGAQPeuPaRZI38QW9P8VzaLEbKKUBCP1+l8ovS+8jRh1SpMOVoK3RuD4+caJPnv5Ji2fXlFaZpaxCu8HTXM0RztYooL+hEjDg3BAZI+EuA/8D7RIXcdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iazilZgX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iazilZgX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1A21F00898;
	Thu,  1 Oct 2026 16:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790871946;
	bh=gvOzyJD2QNBAI8MTvajlvVRSSEA1nsS/ookdOR+Q0pY=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=iazilZgXbg93IEbiVHiZQnJ9nRT+Zh9eSMlD2JWXYu2v+ZtyNmo31Xf2YhBvr/byu
	 f5I5p6oWxGxq1Xr88MY5D0nr/UGTMEgb/PYvIQ+JjthucS0/s/n41jG3SuTg5xkfer
	 kK74oAEBrJVFpABjFq43h0d1ax4ka+ERmC4fjzFzeZYT1IvdCWicBNhTHiVxUhDmSP
	 2Ihx+y9otI7lCab2vKchPp8eSVWctms+vg2vPqSbKFggkkwOehuvCcYuR++FU3m2mD
	 S4Hi/YTa6os+43pvsyYkMUUVJTbQ1duT1UjmOhEc/IXtNWGWpd/s1Jzl87YEliK8TJ
	 qWb990rILEdPw==
Date: Thu, 01 Oct 2026 11:25:45 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, devicetree@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
To: Olivier Moysan <olivier.moysan@foss.st.com>
In-Reply-To: <20261001145702.2628429-2-olivier.moysan@foss.st.com>
References: <20261001145702.2628429-1-olivier.moysan@foss.st.com>
 <20261001145702.2628429-2-olivier.moysan@foss.st.com>
Message-Id: <179087149522.849383.5830343342701017040.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: add bindings for stm32 mdf
 filter


On Thu, 01 Oct 2026 16:56:45 +0200, Olivier Moysan wrote:
> Add bindings that describes STM32 MDF settings to support
> digital filtering for Pulse Density Modulation (PDM) microphones
> and analog sigma delta modulators.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>  .../bindings/iio/adc/st,stm32-mdf-adc.yaml    | 383 ++++++++++++++++++
>  1 file changed, 383 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-mdf-adc.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/iio/adc/st,stm32-mdf-adc.yaml:363: example 0 [redundant-whitespace] extra whitespace before {

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20261001145702.2628429-2-olivier.moysan@foss.st.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

