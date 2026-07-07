Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA2D313272;
	Tue,  7 Jul 2026 16:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783440816; cv=none; b=cTiyYUnYNTDy41Su5I1KZtjYVuHeO3T+svz50E9f0IBU/vtWfxaT0OlZSyNfRQNmFO8oAnwcYkA1l6hcT8ylPBFVHpdEDw3yFXYqgdzq39w0mFpAYXU//gLmrpjrba/ndb418K7mcmqGzWKwQ4QcXEbHhBA2449YG7S5AJTR7Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783440816; c=relaxed/simple;
	bh=OyXuIF6I3/jkDTY6XNE3oW/wU6zr2NJjpANQ4ZiDCkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGWoMZMc8SzQhTdanYBDJ23giydI6sZXPARGV0oxGo8t5of22qsShx7lamSuGaDMNo8bxdvUq6QTGzWOl0lJqMnvwwfV7i1B1M5uC50Ne39SaiSd9E98ozvNfCGiXCTOhN/A6KInmpErPl8wtujSDxLde8h57hN1yMNaVFF9NMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsmMBdlN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsmMBdlN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76FF91F00A3A;
	Tue,  7 Jul 2026 16:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783440814;
	bh=yuBXNxnNPliMXdQZxsx8yJF2LozAOukUOOOwAkzKONY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NsmMBdlNKF47zH1+EJHfgLW3r36aGPmvrl/1C5oDwxOUWITpUjjWiQD6ipqt8sjng
	 uZi9k8AjJYzGtQIudEm+HdC1SBwmdlMIa+ba6iC91x7Me7UzZ8gr/6BJRrWhKMEimC
	 tNaQjOo71601dVBVNThULRLnWPaDUTTLGimA3HvOHXsoTmtUAraqUMU7uCvVlHTGkC
	 rzl4X56JZtTIp76bmGEriqCfyL0d7zaCVY1z2uYpGF57Xqb81SEUllsjQwK05YYStV
	 8FPFz3RdjJUVDlM6Sc17QlQccWBYpQC8QFvZuHY/n+1jlPVHm4Ht0GyhpeTd3GQ5WS
	 fYd5X6WO59EMg==
Date: Tue, 7 Jul 2026 17:13:29 +0100
From: Conor Dooley <conor@kernel.org>
To: rodrigo.alencar@analog.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v7 09/17] dt-bindings: iio: frequency: add ad9910
Message-ID: <20260707-situation-tidal-6552236f0898@spud>
References: <20260707-ad9910-iio-driver-v7-0-a4ec30f63700@analog.com>
 <20260707-ad9910-iio-driver-v7-9-a4ec30f63700@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JsgybDgrBlzr2RMw"
Content-Disposition: inline
In-Reply-To: <20260707-ad9910-iio-driver-v7-9-a4ec30f63700@analog.com>

--JsgybDgrBlzr2RMw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 07, 2026 at 03:04:30PM +0100, Rodrigo Alencar via B4 Relay wrote:

Actually,

> +dependencies:
> +  adi,charge-pump-current-microamp: [ 'adi,pll-enable' ]
> +  adi,refclk-out-drive-strength: [ 'adi,pll-enable' ]
> +  lock-detect-gpios: [ 'adi,pll-enable' ]
> +  interrupts: [ interrupt-names ]
> +  clocks: [ clock-names ]

This is pointless because of the required list.

> +  pwms: [ pwm-names ]

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - '#clock-cells'
> +  - dvdd-io33-supply
> +  - avdd33-supply
> +  - dvdd18-supply
> +  - avdd18-supply

--JsgybDgrBlzr2RMw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCak0lqQAKCRB4tDGHoIJi
0k5aAQDqNVxmoTC5V6A9crrucCZtgmHaT65lzRzOwBrwadp9dAEA5rjQKaau02aZ
Qr6VHt66YtyP+gKsu1gsveJn/8mzGAA=
=OGjh
-----END PGP SIGNATURE-----

--JsgybDgrBlzr2RMw--
