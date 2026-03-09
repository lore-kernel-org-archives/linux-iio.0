Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5626E2D7BF;
	Mon,  9 Mar 2026 07:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773041516; cv=none; b=X6NZEepARtJp5A6+6Ptqe8J9nbx3XTjOKYytgK+JYDR91cpzrptg11POYzCGYw4VMYN3YGS+ke2mPiKa4bbhCsn4rad79C/653HzH/KT4krVK60aHU3UZ5VvfRhap6zmbeDV4F2faqQfeZXUtQTwXcXYqqCzwucxwu8No1UlU2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773041516; c=relaxed/simple;
	bh=hdYMQOX/lKKCHTpRNMHa6JJ/ewQmiWuZngIePnyPKQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LsXT64eZAE5DxAyF9H+Udyf1ZPOG0zf0uqTgUB8jT3PhZZfsKE+N7tFvwIxlBMeEcpeEYWsvzqCTjchpOV1OkAnBNWX5JFiRksw9mH62Gcs4txF7DQ8a9HXzo+T4AEE01pX+85XjLtaKakl0J2XQUV30WbLDywQgQy1j9i6v2lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqTMxn91; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqTMxn91"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F27C4CEF7;
	Mon,  9 Mar 2026 07:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773041515;
	bh=hdYMQOX/lKKCHTpRNMHa6JJ/ewQmiWuZngIePnyPKQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EqTMxn91zwmv9jlOgK0MWh5QuuWdxfoYCByhngGO6FM9UAoMJUC60HWBZZS+mzpYR
	 vmSfdCgbdxjptt0alUSzhzhEU6Q5EJE7zg4fApv7Nw+pt/tv+xIIjVg85jTX2/gqno
	 I9kkahne50YJ6fhIyPJ81/cq9CWyxIP/npQg4ua3F2VCLffOBb/5JSJK3E0jz9XFXi
	 yW4FxKqx7kDzraGLm/C7fPc2EocxZ2hdLQEP8ShSEaUOZEWGV79qZXuIBEO/VceDMO
	 bGsyklQmMQw/n5yOIZC8LEtAkstDljbuQiCcjwfPZp/7t9rEwnWnc864keZ4kFKpYp
	 rqf1zC+HN5APw==
Date: Mon, 9 Mar 2026 08:31:53 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Siratul Islam <email@sirat.me>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: proximity: add ST VL53L1X ToF
 sensor
Message-ID: <20260309-loose-interesting-wren-cfe4b3@quoll>
References: <20260308113728.40860-1-email@sirat.me>
 <20260308113728.40860-2-email@sirat.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260308113728.40860-2-email@sirat.me>

On Sun, Mar 08, 2026 at 05:37:27PM +0600, Siratul Islam wrote:
> Add device tree binding documentation for the STMicroelectronics
> VL53L1X Time-of-Flight ranging sensor connected via I2C.
> 
> Signed-off-by: Siratul Islam <email@sirat.me>
> ---
>  .../bindings/iio/proximity/st,vl53l1x.yaml    | 50 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/st,vl53l1x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/st,vl53l1x.yaml b/Documentation/devicetree/bindings/iio/proximity/st,vl53l1x.yaml
> new file mode 100644
> index 000000000000..c4ae96293f27
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/st,vl53l1x.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/proximity/st,vl53l1x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ST VL53L1X ToF ranging sensor
> +
> +maintainers:
> +  - Siratul Islam <email@sirat.me>
> +
> +properties:
> +  compatible:
> +    const: st,vl53l1x

Looks the same as st,vl53l0x  and pins are 100% the same, so just put it
there without any difference in properties.

reset is the xshut.

Best regards,
Krzysztof

