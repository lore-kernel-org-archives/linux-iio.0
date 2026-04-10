Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146833A5E82;
	Fri, 10 Apr 2026 07:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775807727; cv=none; b=BYr17Jt0Zd2RAWLK7VkUogCxVpZ3gUATxpUDky8ouqMnLMz0/FdpEASTLkC66HPLTNFn14Dgsjmncc3Y1D8z/BqhWUDd3QoL3XjMsDtZOYi9daPtlprsyhbUxtIB3d+dxwmD+w+/pbf3sYdZurwg9w6QLVsx6srA35uoXVMCWHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775807727; c=relaxed/simple;
	bh=Dy3jxjZVTM8xz6GR0KyUbEI3OVMGwMs+L96Ws83GCTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnGQMgWtL0ICr4EWbQaOjGMh+cX+H+90+GzeoMLgy43wMF/7FMAa45vRr9xGM/ds3CCEvbmwP4N8Li5u0OOFncDem7wMr2sJ9Z59WPVi3q9lQpxXlWHGbXoBLnCSSCT+bWBZ+QN33J+U0geri63jy8S/td8xCYJPyI+D0Tl2bwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFIiHWif; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFIiHWif"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90644C19421;
	Fri, 10 Apr 2026 07:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775807727;
	bh=Dy3jxjZVTM8xz6GR0KyUbEI3OVMGwMs+L96Ws83GCTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PFIiHWif0XHwXHioK+oOmA2XRo/jNuLxMnfKyh2RTCWBFfCEyo92GKO4z+9Er2FT+
	 EjAgp9UwU1mpMxS4seg3pY4iulgMVDm7jxPnhUcbR+pmDQ7mWnr3u1ZhV+qUrCLOiQ
	 /leDTwVapdXNTqMwPy0ZVh6uUTtMAaCVX5eimHaSPP7+ZuqIAHGxK+3p2P3KHBLeJR
	 /bjuHaYZMNBWmcLUYC9FfFxJ9FObVF4ZhO2oevc5SQFTqi6z1ndswvBOWzArk3LUZ/
	 583QmVSB09kx77J0p40VW92al4HZCzqdQIA2Hg9/QUuqgc/b0Ed/yJ+b0ONFVkW02F
	 jeSP4MhPrCvNA==
Date: Fri, 10 Apr 2026 09:55:24 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Hardik Phalet <hardik.phalet@pm.me>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Brigham Campbell <me@brighamcampbell.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 2/4] dt-bindings: iio: magnetometer: Add binding for
 QST QMC5883P
Message-ID: <20260410-stimulating-happy-terrier-e82dcc@quoll>
References: <20260409210639.3197576-1-hardik.phalet@pm.me>
 <20260409210639.3197576-3-hardik.phalet@pm.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260409210639.3197576-3-hardik.phalet@pm.me>

On Thu, Apr 09, 2026 at 09:07:29PM +0000, Hardik Phalet wrote:
> Add the device tree binding document for the QST QMC5883P, a 3-axis
> anisotropic magneto-resistive (AMR) sensor with a 16-bit ADC that
> communicates over I2C. The binding exposes the required 'compatible'
> and 'reg' properties along with an optional 'vdd-supply' for the
> 2.5 V=E2=80=933.6 V VDD rail.

Drop last sentence. We can read the diff.

=2E..

> +properties:
> +  compatible:
> +    const: qst,qmc5883p
> +
> +  reg:
> +    maxItems: 1
> +    description: I2C address of the device; the default address is 0x2c.
> +
> +  vdd-supply:
> +    description:
> +      VDD power supply (2.5 V to 3.6 V). Powers all internal analog and
> +      digital functional blocks.

Supply should be required. Devices need them to operate.

Best regards,
Krzysztof

