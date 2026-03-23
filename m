Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEAE362133;
	Mon, 23 Mar 2026 07:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774252420; cv=none; b=LLLQ3W+LkJ30MN+yxO0TQ2z/eRF2Qj8+8z3W6/sA/i7onJQswaaGJhOQEyj1nSgfSI4KlOLibPT+yuv5PVR6bh/Kiv+fqZwC1RrVMSdRXqaNubkvPAtF3wyRQRDFgvEcb22+0mdoLl2DboRvTnrV1SDSzhIX2iLyfv89Jeo9mAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774252420; c=relaxed/simple;
	bh=rKXtNU80tlF2bEc5y8Hf3EEwlFTdBjp+OHDgdQ+xW4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQIlj4eAYd6fh5OYwad2ea8HjcVNdS6ZAztpFaGQonNr9DNQ6eit+F9e/vUni0aKbhAgSWjspvnxCwIzCXrFx2jYJTX3MICkoGZD5eLP5YQYeE/PKvgHyOIXKOKvFqM5kKK3z95z4ILR/rXjRlH2LgDuOlha/Zn3h9+ExEhlIM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rpd7r5i3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpd7r5i3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BAAC4CEF7;
	Mon, 23 Mar 2026 07:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774252419;
	bh=rKXtNU80tlF2bEc5y8Hf3EEwlFTdBjp+OHDgdQ+xW4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rpd7r5i3Hay5+CRrN9PuS0ZKpZiSE77pqaQ5052CwJjfxzfAU9TKjSb7cNc11mH6T
	 76NH1urRy28GGx7YoUV7A6j6UqICuhqPEzPADEoJAm1aMpm7YIJYP/mZbVTCD8YSJa
	 ogdsevIJRw23t9i3j1hkXA1Hg3WKF0Abx585kSbk5wQccUsVhocDQaXXupaOAwColI
	 R9FCu37yQCrI8FiMPwUrpUDDOe4l3cCHXNFaViga79LC/xRuDHZp5NMmCpf4Oq1rDq
	 P3hYybNi/PqiXvO+cwnD4YLquk3WTFm9SsoRpAKXGWmilDUwVagNLxIb3eiEuyDIfd
	 5Ho4WRVjZdI8Q==
Date: Mon, 23 Mar 2026 08:53:37 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nick Xie <nick@khadas.com>
Cc: neil.armstrong@linaro.org, khilman@baylibre.com, 
	martin.blumenstingl@googlemail.com, jbrunet@baylibre.com, jic23@kernel.org, dlechner@baylibre.com, 
	andy@kernel.org, krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: adc: amlogic,meson-saradc: add
 S4 compatible
Message-ID: <20260323-saffron-cobra-of-perfection-731c8d@quoll>
References: <20260323013408.429701-1-nick@khadas.com>
 <20260323013408.429701-2-nick@khadas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260323013408.429701-2-nick@khadas.com>

On Mon, Mar 23, 2026 at 09:34:05AM +0800, Nick Xie wrote:
> Add the compatible string for the SARADC (Successive Approximation
> Register ADC) IP block found in the Amlogic Meson S4 SoC.
> 
> There are no known differences between the SARADC on S4 and the one
> on G12A. Therefore, it uses "amlogic,meson-g12a-saradc" as a proper
> specific fallback.

You should explain here why you are adding that comment.

> 
> Signed-off-by: Nick Xie <nick@khadas.com>
> ---
>  .../devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml     | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
> index bb9825e7346dd..70ab4e140e71b 100644
> --- a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
> @@ -27,7 +27,11 @@ properties:
>                - amlogic,meson-gxm-saradc
>                - amlogic,meson-axg-saradc
>                - amlogic,meson-g12a-saradc
> +          # Usage of this generic fallback is not allowed for new devices

Best regards,
Krzysztof

