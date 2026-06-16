Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D2544CF4A;
	Tue, 16 Jun 2026 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624515; cv=none; b=fReyF5mhz06nSh2qPF6s0TcQ8U3Xqh5gNGaIjFLRBXvyH4+Lhv12iuKBT/K9SzMTriHaaTtPiQG2TxBP3QLfbONaxNRKDKDUm0coOtgDytHHFbkLYtOxnUJyiAC8BjDfIFj61r5wVq5b+bUrhU3WdrwLRthNHKXEPs4J2SCNZSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624515; c=relaxed/simple;
	bh=XYHbz1TmYYOg/4AjUMy+PtpiVOh1Q8GtJYBsbEvokQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MImVT1ythL8NIRlDPUJhrf+aOsRa5HFtfyKJGGfbyfRDap+7wQMxhkOaBycS5xwWKPb9zZCWvGWr4Nz43aY9+ouPN9oYigWrebLTG4lPCn+0VUiULbEVvlmlZaz7gEOwGi21pZXEin4jwn9e+ayOKqbJwKGY0Y0GFgHdz8xJAVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKnfwheL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKnfwheL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589711F000E9;
	Tue, 16 Jun 2026 15:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781624515;
	bh=XYHbz1TmYYOg/4AjUMy+PtpiVOh1Q8GtJYBsbEvokQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aKnfwheLTKb+TOspgX+0SerqwDvEtkTr072QVHMwl7clY364JtYBSZ7GD2afL+QYR
	 Z7iQkJkLx+miW6DTprSKHpmVEom0hCHC2CnjlDKNIPKkOP1PljmC0y56PbZfridkFO
	 4w+3+MQsOaagEb9qxqPS86N96/l+ZHV6Qz8Eum0itxkNQlqTwumgCnVxQ1ZJdV91rW
	 xcYxERrY3mz99ofCJmKZ9eNyd5pjE+7UTU7fG611Dy7oBJVlPUw/giQ3aJL1nsrDx/
	 Y+OdaxBhgOfD6Urht4POzPWwt3Xg3/JLqLxKW49ejohuQrC4GNfV33wn2UxNp3JwLk
	 jhae4qjzlzdeA==
Date: Tue, 16 Jun 2026 16:41:49 +0100
From: Conor Dooley <conor@kernel.org>
To: Herman van Hazendonk <github.com@herrie.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Denis Ciocca <denis.ciocca@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Denis Ciocca <denis.ciocca@st.com>,
	Linus Walleij <linusw@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: st,st-sensors: add
 st,fullscale-milligauss
Message-ID: <20260616-squeeze-darkened-82e280beb389@spud>
References: <20260616-submit-iio-lsm303dlh-magn-fixes-v2-0-063edcf74e60@herrie.org>
 <20260616-submit-iio-lsm303dlh-magn-fixes-v2-2-063edcf74e60@herrie.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sZQvM//h8kBE8vC1"
Content-Disposition: inline
In-Reply-To: <20260616-submit-iio-lsm303dlh-magn-fixes-v2-2-063edcf74e60@herrie.org>


--sZQvM//h8kBE8vC1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--sZQvM//h8kBE8vC1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajFuvQAKCRB4tDGHoIJi
0r3jAP9HfcyWDr1jQxsIlN00Sa+52Wx8bbwqt+R3c+ofWNZUAAD/dtgh/qnBR+Ci
OV5Bwl9V3HSWwLdcdsjX5UZIVBa70gY=
=A0GN
-----END PGP SIGNATURE-----

--sZQvM//h8kBE8vC1--
