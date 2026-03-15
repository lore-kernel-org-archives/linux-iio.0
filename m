Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30D51A6819;
	Sun, 15 Mar 2026 08:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773564584; cv=none; b=SGJ5QWbSoIFK25jXT8684FOPaUrtv971CYuemdxTW4PcV5lAA50yZmrmShmzOnweTcgwrJJ9pngGEeZrwiIYHkCmI+GOoxhPMj09l46Qe6tim4LCNo2W2ivzRRM6UhcKLYXnG2NENhHfOffdXuVqiEcRsbx1Zuh1W27/wGPtfuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773564584; c=relaxed/simple;
	bh=lNfVYfqFUzIenEN23nNkQbpeelNRkJkuLuCmDomX4OY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDSSnDxKp6/+yuiuDKDtkKUXkCX6fkSn4lmXAqJZ1S4w8GhQPo0Dps2qIVEy+6kcaJjsOo88ygSYxNarOKvrk4tzr+BBsACXUEfR5AK3NRyGh7vg1/mUA4LqrSdmw9LMiNc+4VbZpDL6xEOMeyjcEywECkFfBc67ypm9voTFpkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpJ6Ifc6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpJ6Ifc6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC62C4CEF7;
	Sun, 15 Mar 2026 08:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773564584;
	bh=lNfVYfqFUzIenEN23nNkQbpeelNRkJkuLuCmDomX4OY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kpJ6Ifc6RhYtqlXWpAGfDU79mdHBhZB0A4fYAyhOG4lFzaUbx7ofH0oXSBIryb1Eu
	 DZgx4hJNbP+/1mb0XecOSObf4IFB9itcBNxr7FhP78mJyA1CpWyibXprljjBZXdI2I
	 n1okhXg/LKKebHa5EcMqZzVWUnHxLUpTpb0/1DcJZaE+VSTq4SrZedQsAVXrRXnj3p
	 y4BnRpiLAE+v9ZmOTF4JQv6kF4kNs+4xLgK3EWlsfpIBpI0hjSPeWKJg4V1sPjhoeU
	 fPV1WoupzV/d5VSRiIlYTSGrsey7dkbYGZqlW5n4s1HXcWyszHC/upipJdZ9tD/4Vc
	 DkOYyVN4XmRYQ==
Date: Sun, 15 Mar 2026 09:49:41 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
	phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] dt-bindings: iio: light: vcnl4000: add regulators
Message-ID: <20260315-honest-debonair-oarfish-3a33ed@quoll>
References: <20260314-vcnl4000-regulators-v3-0-3c4a48d30676@gmail.com>
 <20260314-vcnl4000-regulators-v3-1-3c4a48d30676@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260314-vcnl4000-regulators-v3-1-3c4a48d30676@gmail.com>

On Sat, Mar 14, 2026 at 06:06:30PM +0200, Erikas Bitovtas wrote:
> This commit adds supply properties for the sensor, I2C bus and IR LED

Please do not use "This commit/patch/change", but imperative mood. See
longer explanation here:
https://elixir.bootlin.com/linux/v6.16/source/Documentation/process/submitting-patches.rst#L94

> anode supplies [1], which can be found in vcnl4000 ambient light and

So other devices do not have these supplies? Or have only some?

You already received that question, so I assume you checked. Then check
again because 4040 has VDD.

thus in
that case 

> proximity sensors, to ensure the sensor is powered on before proceeding
> with setup.
> 
> [1] https://www.vishay.com/docs/84274/vcnl4040.pdf
> 
> Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
> index 2ba4d5de4ec4..a1b4c02db246 100644
> --- a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
> @@ -33,6 +33,10 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  vdd-supply: true
> +  vddio-supply: true

VCNL4000 does not have VDDIO and VLED pins.

Best regards,
Krzysztof

