Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A75D37BE62;
	Fri, 10 Apr 2026 08:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775808377; cv=none; b=nsvvq7norW9iIVG+SYRrmlWEmIEZbAoX0lFwNUEZuCdJcCQheDddtidrEwI3uLBU4yVd4E7tsNxrkaFHtrTWZWS2hW6nyDdVDyCdxoSalA9WHSbKEEPm75tkNzwpZdmpBj2RWuaQp7H3ujT4pA/HQLGgfRV23DNEuX+Xg7shs6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775808377; c=relaxed/simple;
	bh=FzCU/tONQ0NQpWljcKGe06gUTVkQG+/c0gYp62ENhIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=El6+txOAJprC1ZuzG3NlD3RLubSdUfW7qPJhGzUa0jMU/y0pCo39uqaS5FqBbHwU8OOKGD+d911eYKZiZNkmL4BT3SvkvpTxFkAaH7NOwD7uPzyeNlxNR711kN67QDHPev8TsCVnHwk4cV13YWNEyJI4cX1vllUJGd6YcXDNQqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h14TH827; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h14TH827"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE1BC19424;
	Fri, 10 Apr 2026 08:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775808376;
	bh=FzCU/tONQ0NQpWljcKGe06gUTVkQG+/c0gYp62ENhIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h14TH8270tTIVB0tkiuW4tQDREFzRQtXx8tJZq+uiIaYEeRq8RoK/IrLvnnUkwXJR
	 /RQ3hCdX7hhwfq7NUEOKQyS6uSw+WX9yI2HrabzWzSwWszKRPNsj1cXymReMn/J3ov
	 M6t7jZOU4XEyMT1tiMG5nL3W7Ejrb6SkRtY7LItzv/lsRAtecjcPd8Sjlzj6AGmmXf
	 hm2dC4nAU1nq6OWnr9Xjzgkw/qZzh4xWmnDOup5fa9Qo7gxyDrxf10PWXCeB6qCXIn
	 peP5ch0oGBDtN8lEF/C2Mc4bcuzWYnblp2KAWZ0QZ1XQbGM4RUIFsK0/qpHRuzzf5w
	 UHRcx0zd9/TQQ==
Date: Fri, 10 Apr 2026 10:06:14 +0200
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
Message-ID: <20260410-deft-mottled-petrel-fa22bf@quoll>
References: <20260409210639.3197576-1-hardik.phalet@pm.me>
 <20260409210639.3197576-3-hardik.phalet@pm.me>
 <20260410-stimulating-happy-terrier-e82dcc@quoll>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260410-stimulating-happy-terrier-e82dcc@quoll>

On Fri, Apr 10, 2026 at 09:55:24AM +0200, Krzysztof Kozlowski wrote:
> On Thu, Apr 09, 2026 at 09:07:29PM +0000, Hardik Phalet wrote:
> > Add the device tree binding document for the QST QMC5883P, a 3-axis
> > anisotropic magneto-resistive (AMR) sensor with a 16-bit ADC that
> > communicates over I2C. The binding exposes the required 'compatible'
> > and 'reg' properties along with an optional 'vdd-supply' for the
> > 2.5 V=E2=80=933.6 V VDD rail.
>=20
> Drop last sentence. We can read the diff.
>=20
> ...
>=20
> > +properties:
> > +  compatible:
> > +    const: qst,qmc5883p
> > +
> > +  reg:
> > +    maxItems: 1
> > +    description: I2C address of the device; the default address is 0x2=
c.
> > +
> > +  vdd-supply:
> > +    description:
> > +      VDD power supply (2.5 V to 3.6 V). Powers all internal analog and
> > +      digital functional blocks.
>=20
> Supply should be required. Devices need them to operate.

Ah, and since I expect new version, also:

A nit, subject: drop second/last, redundant "binding for". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/=
bindings/submitting-patches.rst#L18

Best regards,
Krzysztof

