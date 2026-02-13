Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E12221CFE0;
	Fri, 13 Feb 2026 18:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771006364; cv=none; b=tkDE7yhvPX2ZMr31VKk9HjzEZYBZPM2oGeqz8fppwcG/+080AsPnjsORmqRX8RGY0jcgWyl2ox9vzjpUdCEId5+1Q1bGXqNbULdjBIJ5dSyF+s/KK/VPthpbWWcuWmrYkYneuY5ty+8p/uxiqkg4cLNX9Y5TPDlMXhC1eptUJx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771006364; c=relaxed/simple;
	bh=6ycLczQPtf4rUoZh+2XobA+1WQMnBgkjJakh/mDUxas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsItGonXhJuUw27ZfNG0NHpUtfAXun+I2xSTetANj/PhI4d/O6HGKF3popD5JJS8kxw06KG2PxmTQOJSaG45h+JcGuHCsv5uzAn+H2WKm/AzuskmhQEQYm9+jacHdnDjDEz69lDYLU0ZYYUoAwx1GIUQjwbs/eBrnl0stc/bi6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fdb3+mJF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fdb3+mJF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C026C116C6;
	Fri, 13 Feb 2026 18:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771006363;
	bh=6ycLczQPtf4rUoZh+2XobA+1WQMnBgkjJakh/mDUxas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fdb3+mJFD/gw37xuSmN7SSLRJQ57YHpBjgrGYr5MeVDhBfkH/2ZSvhQGHW+XzUall
	 zOggToM/8+88y/J0wctI0SbSWKzOFOJFXhL8DF1cVD1xXJd767Ij7/0Qryi24W92Qw
	 Gy5OD/pottjrD7lZaQdSn0DWxaEGc8BCRdrpuqPJzb+u/upHcO2/ElSbHdatretDNQ
	 JLpc4GCt0c3mYtNtijwzx8XgA9Hw/PcayZ2NU551yogMGHeZTGtmL9/0Hse56yeb1K
	 HxjmJ5+aCf4meWvmPo2pV+tcribPA/6KCIhhWrqIFgzYQP5a8QX84nNdWd7Ts3fNuQ
	 Hvhl+gC7YnuLw==
Date: Fri, 13 Feb 2026 18:12:38 +0000
From: Conor Dooley <conor@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: iio: adc: adi,ad4080: add support
 for AD4082
Message-ID: <20260213-tipoff-risk-2f2256160981@spud>
References: <20260213144629.16001-1-antoniu.miclaus@analog.com>
 <20260213144629.16001-2-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZlxBjhiT+DmWR+W8"
Content-Disposition: inline
In-Reply-To: <20260213144629.16001-2-antoniu.miclaus@analog.com>


--ZlxBjhiT+DmWR+W8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--ZlxBjhiT+DmWR+W8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaY9plgAKCRB4tDGHoIJi
0lvHAP99r+56gn0nnWkNwp3noCKn7mFLNQMi1fNqOZXyxknBhQD+NjQ8gdZBM64W
ze0dja99ok9/tXiStWlUw7gjtLORdgk=
=fHd3
-----END PGP SIGNATURE-----

--ZlxBjhiT+DmWR+W8--
