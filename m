Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDB336D50D;
	Thu, 23 Apr 2026 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776965635; cv=none; b=bVmSc/d+W8PH7BYbgKlL//cLyjUyX7tGuRRHDnWJKH+HNofo9mNUC7jff3BYYsEBma7zgeAFTf50FD80w9ZFWYfb9txxPwkqb115HP8H2y9Rkk3FpGEx0qczt3ckJo7W+0GjhQoq66X7mNtsM4kscfOlfOIDAFZxDzYRiH+j0Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776965635; c=relaxed/simple;
	bh=tt5/Ww8988AYNsNKeEDvzGi+qjrkqv2y2R4NebJOvGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JoQlqsGtmsotBs/o3uANMwQE4yMkaDzLPwyGuYZVX9LysJH/QdwG9BkwNiCK5qoJGawG8hmflvkSuAYeEyOmh93b7xNaGeDLiM6kPB5SC0rWRCBCej3A7LW/Yt8JsNxLAJGEK8QpK4q5s1r5429riMcYx6+QjGxr6SfyWzK1V20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzKLrXWJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzKLrXWJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F39C2BCAF;
	Thu, 23 Apr 2026 17:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776965635;
	bh=tt5/Ww8988AYNsNKeEDvzGi+qjrkqv2y2R4NebJOvGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FzKLrXWJxAEzdm2qgj9Uut1t7lFZ1VCnRf8b0jUA+2P2P5Pga9mJyoeHPy7aQCEs1
	 A6y11cFQAEMYXw6J8STV29o4KBDcZkciPj8Ok8YIaPLIw1Z1v/kM+Q1AbrqjTvfvvb
	 Rp8s1ctia7ryqzDx7yQqSpWSTls9t/MfoxxWRREj5cFEv2jxwAyKutWuccwhCoO/dM
	 dt31EtVndZWURNd/WilfwSHeHRh5hKKZsIvr5A4knvHtcZrDAEi3kXTvgCRjRgA3fv
	 9tYvMppLbEzgEuzp7Oeh0tKoK0RnUKEFXt/Eu3ductWXW8XPbXp8kcFcqf7XURQzIz
	 SQnFCIxfoRu8w==
Date: Thu, 23 Apr 2026 18:33:50 +0100
From: Conor Dooley <conor@kernel.org>
To: rodrigo.alencar@analog.com
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael Auchter <michael.auchter@ni.com>,
	linux-hardening@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 04/22] dt-bindings: iio: dac: ad5686: extend device
 support
Message-ID: <20260423-voucher-clarity-b7a9b1f39113@spud>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
 <20260422-ad5313r-iio-support-v1-4-ed7dca001d1b@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eX7l1Snd4pmcBd/p"
Content-Disposition: inline
In-Reply-To: <20260422-ad5313r-iio-support-v1-4-ed7dca001d1b@analog.com>


--eX7l1Snd4pmcBd/p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--eX7l1Snd4pmcBd/p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaepX/QAKCRB4tDGHoIJi
0u/JAQCpJTgINsdJwH8L+zCdAHezgrKL2T+oNXFm9EQd4mS83QEArS+jUh9ktEht
IZSpMUMfH3YunjDN/pYKAJkzA6CRNwc=
=gz1E
-----END PGP SIGNATURE-----

--eX7l1Snd4pmcBd/p--
