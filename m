Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C984756DC;
	Wed,  7 Oct 2026 10:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791368065; cv=none; b=s+MKpvWahdHVZ6KuQM2yFJZtJ/NJwSsiKnL8W4gyEg7VV2/di/dQSOcm9OI3ohjAT9r1964ZHC6+RZkOQyE2ZmN9HyYZVxM2H1+wQYsshbrlFlzVX7O8b8QtVwdcr+4+2CLU3Ykpo6cpi9i2TpXN2ABeODesvvIK7U4zWacDmN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791368065; c=relaxed/simple;
	bh=FFYov5HzBrtldqY8DxDXWuxxUAIKOd7wJjkzvS4Mkis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHTOSUiaGqeTIzxNn6Pf/X1qOe+p+x+e6LX1J9UQ4reDzrgfQW3uo6+UwvcNMj+0OaT8Gx3XTUn2d3nVtP310jb+qxGwCquMwbYJg8U8OcyXINbt7y8KU2x2aRKsCDOTDkLFap0kXXrHHLq7vcSdCLitzulWrL8oE4Kb37hPEF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2KKH0Uz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2KKH0Uz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06FDC1F0089B;
	Wed,  7 Oct 2026 10:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791368055;
	bh=FFYov5HzBrtldqY8DxDXWuxxUAIKOd7wJjkzvS4Mkis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J2KKH0UzEhr/AvmGFNxCVswviIUo8GV31jlkkozvMLTD64RL+BBssD5z3n0Tqvkod
	 CjM9M+cQ95XlPhJzZCLRsnTHcjpmRIlQg9mB78so/Et6ND/pn8hvzCEuL6USE9TF0f
	 ag+x8s8S9BBonRKukKgpqXjVlcrz5T+BlSkB2EGE5TqRVLBi+4M+ezhKCJHl5+BwvL
	 vniQ1CfNcJh+C+hw2w+rh06YLbxkIWGNR+mSQj0s3h1WR/PT8CO00E0Y5rJugBcAqq
	 5pAbYnreZtYsUQMMx4tcor5D0DhgNNnCc4wpFWvFQGuTxG1SYhyNzKjkSIdJCH2bH9
	 JBif68zOs06EA==
Date: Wed, 7 Oct 2026 11:14:09 +0100
From: Conor Dooley <conor@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com, jic23@kernel.org,
	nuno.sa@analog.com, dlechner@baylibre.com, andy@kernel.org,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v4 08/13] dt-bindings: iio: adc: adi,ad4134: Document SPI
 connection mode
Message-ID: <20261007-3dfcd5f2bcbcccfb9ef23f90@squawk>
References: <cover.1791309733.git.marcelo.schmitt@analog.com>
 <6afeb3fcb39f73edde5f39f6f37a1ecea5523319.1791309733.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yXsJ4kX7SCf1Rz6/"
Content-Disposition: inline
In-Reply-To: <6afeb3fcb39f73edde5f39f6f37a1ecea5523319.1791309733.git.marcelo.schmitt@analog.com>

--yXsJ4kX7SCf1Rz6/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--yXsJ4kX7SCf1Rz6/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCasYbcQAKCRB4tDGHoIJi
0ubdAQCES6PF/QOC2Zw14+EGJ3F1jwzuzyyNXYo+7hOOWWqSOQEAzI0Bq6/Xm2rD
hGzvkSVt8oBQv565A+T/+tqMCAASkQA=
=gctK
-----END PGP SIGNATURE-----

--yXsJ4kX7SCf1Rz6/--
