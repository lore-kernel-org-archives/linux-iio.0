Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1383947B420;
	Fri,  4 Sep 2026 15:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537192; cv=none; b=OMJCrlKYJfHiDW8zD2NuKSw8w4S5/HgqSOH3pTeqExBcBOYVRwqkcceGt79z6xLReGPtrCC749iyYZH6VQa5w+i4wytGyVrnliLGfJyaA2a/o/1nJsYdiecNS0MKoTCeGBz5/tlyDZljYACq9GaDkmtC9ScNX0vEITQ8RInFcKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537192; c=relaxed/simple;
	bh=OmQtm8VvchqvHFubYK7BwNHJPTLgALqxfZdL7jjUtDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKUmvRK/JJ9IBmCoV8G6TYc97wtZ3wv/IXIpbtecy+mHZjfiXSIBbKvfRkyQ6X50OOMXDyKdvd48WqSK5Qy14P93eD1TBbjDhcQmpr2e8s0fgwHxLROEnkQZ+lMJpciWNjBKW+becklXmBjZLHVLRyLf9l5z6wq3fAmhSNcT7iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEq38cVV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEq38cVV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496AD1F00A3D;
	Fri,  4 Sep 2026 15:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788537190;
	bh=OmQtm8VvchqvHFubYK7BwNHJPTLgALqxfZdL7jjUtDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hEq38cVV5U3Vbx1p0f8niCvkCkIXo1ts137dU7k/kWTFIe29+a7yhzHe/izWXFl1a
	 XaAntOJq8Z5L0pNGtPB/cShjoCJf/fC8SGnyMRQru51XxK7wKCBT3M3uafxPxpTw5j
	 xNVMc0YPr38PACnDbvKRt3U1QruTIr3X/AvUyZBzc49Y6fhhiS7SZCDV6gk7yrApdc
	 T7/FgFIFkkFljROmOeWycQaChYhiAJq5a8/tFfsF6kYKGis8RFenKpL5AiYtkHjH1b
	 Wy2fYsZao2JBkRzqq4QurKx8QWVLPlXieB9Jc6gV72diPhEZnN4PR119zHqW+RoCOE
	 +ZQPVGxKVQ4Sw==
Date: Fri, 4 Sep 2026 16:53:05 +0100
From: Conor Dooley <conor@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com, jic23@kernel.org,
	nuno.sa@analog.com, dlechner@baylibre.com, andy@kernel.org,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v1 10/13] dt-bindings: iio: adc: adi,ad4134: Document PWM
 usage
Message-ID: <20260904-upcoming-brunette-853932533330@spud>
References: <cover.1788368334.git.marcelo.schmitt@analog.com>
 <de2e0a39782b403194b36ff4461e284378a25b71.1788368334.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hZgDJxWkzhW9Tt50"
Content-Disposition: inline
In-Reply-To: <de2e0a39782b403194b36ff4461e284378a25b71.1788368334.git.marcelo.schmitt@analog.com>

--hZgDJxWkzhW9Tt50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--hZgDJxWkzhW9Tt50
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaprpYQAKCRB4tDGHoIJi
0u39AP4nqnvY3xH7cPSLOlNdoQyvytd58RXCLi06HHL4nXJQ5gEAq6ovU7ptVq5E
/Tu5ByHhe1VUbPX36z/CGbx5rGdxeQU=
=1ZrR
-----END PGP SIGNATURE-----

--hZgDJxWkzhW9Tt50--
