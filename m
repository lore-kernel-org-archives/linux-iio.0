Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106525226BF;
	Thu,  1 Oct 2026 19:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790882457; cv=none; b=Y80IC7pxYIoBjR12o58md+yoRsk/o7/YHWgR/Jpfc25Z+uJNSCkOmQ831cTpBtGgKwDaHOvQNYfDV33Y+s2RL9hD/yOL/t7bQUhOZVu7wiGPNX7pi9kFfTi4Vvn+j2cDVXyFE53cwY/TMdk2QPir1ajkBzAKKH95EOQ0A+Qi7JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790882457; c=relaxed/simple;
	bh=x1MmOOCahg4e+YZf4G5N/altgnKA5qXFQq8wazzr6ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJqkYsvGf6CFW2JT/MM8i5l8RfRLpYxiA+mK/bPAg8UY+d+gL8tTKa5xEpMgOY/8Vl+gP9PBDME7XrqTFwZO13rfL7QnF98hvdGaiMS/uhgQ1umTkBhrVZI5NRLqqmU1n4C/mSbrFKJPrzsDXdGdEpLEG1tOksOm074uzESfgpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jU1zxpq6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jU1zxpq6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898EC1F000FF;
	Thu,  1 Oct 2026 19:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790882455;
	bh=x1MmOOCahg4e+YZf4G5N/altgnKA5qXFQq8wazzr6ds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jU1zxpq67EckGkyWPOprssSe5IBihl380Q9+To2nP7Bm5LiheBHEOvjKwjCZ3+2G7
	 +O1SUjgIVFzEkeFddecxCtm0+KeEe+ao88XzdQOg9nurUhZhVh2mmjIZc/M+vnwR4w
	 TmPLxoZmp+sJgdf2o7zNoIk+I0oeHWAH3UbSfPCORHxsrU4n/wa27l1KNrzBoDEgxC
	 Rg7G3QuT9q/eMg4NFkd8z/fqAG7uAxMzJR3Lt7qwlrZEMgHVFlQ3VOtXeTYm0AAiLT
	 tyX5i7Q3E0Y4e/QmfQJLtOshsyzsuLD8732oasRUK8IzarCaiTnEkPIVu3bAM7UNzg
	 attYGZfDQ1o3g==
Date: Thu, 1 Oct 2026 20:20:50 +0100
From: Conor Dooley <conor@kernel.org>
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: Sam Protsenko <semen.protsenko@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: iio: adc: samsung,exynos: Add Exynos850
 compatible
Message-ID: <20261001-ramrod-excess-af03490d5240@spud>
References: <20261001-exynos850_adc-v1-0-791b3516bb9d@linaro.org>
 <20261001-exynos850_adc-v1-1-791b3516bb9d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BadlZsUMoxOv+uPT"
Content-Disposition: inline
In-Reply-To: <20261001-exynos850_adc-v1-1-791b3516bb9d@linaro.org>

--BadlZsUMoxOv+uPT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--BadlZsUMoxOv+uPT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCar6ykgAKCRB4tDGHoIJi
0pcNAPkBIiypEFaEr9cRqf0+A/gpebZXEk4kvlJS5mOUfO3o4gEAsWasR8lY3yxW
sflI+kUdUrN+nCczr4eOpUsogkPVdA8=
=rh9C
-----END PGP SIGNATURE-----

--BadlZsUMoxOv+uPT--
